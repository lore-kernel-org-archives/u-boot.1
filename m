Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF054CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 14:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B9D487269;
	Thu, 19 Oct 2023 16:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=hotsplots.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5B6786FEA; Thu, 19 Oct 2023 15:29:25 +0200 (CEST)
Received: from mxb.hotsplots.de (mxb.hotsplots.de [185.46.137.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7EED8708F
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 15:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=hotsplots.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=faecknitz@hotsplots.de
From: =?UTF-8?Q?Martin_F=c3=a4cknitz?= <faecknitz@hotsplots.de>
Subject: CONFIG_SPL_SKIP_RELOCATE in non-SPL build
To: u-boot@lists.denx.de
Cc: trini@konsulko.com
Message-ID: <cf04d59d-f598-5dfa-64b8-3ba0135a66a9@hotsplots.de>
Date: Thu, 19 Oct 2023 15:30:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: mxb
X-Rspamd-Queue-Id: 597028C02F4
X-Spamd-Result: default: False [-4.67 / 500.00]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; BAYES_HAM(-5.00)[99.98%];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_ZERO(0.00)[0]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_NONE(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 ASN(0.00)[asn:3320, ipnet:84.128.0.0/10, country:DE];
 MID_RHS_MATCH_FROM(0.00)[]; R_MIXED_CHARSET(0.43)[subject]
Authentication-Results: ORIGINATING; auth=pass smtp.auth=faecknitz@hotsplots.de
 smtp.mailfrom=faecknitz@hotsplots.de
X-Spamd-Bar: ----
X-Mailman-Approved-At: Thu, 19 Oct 2023 16:58:19 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello,

The patch
  Convert CONFIG_SPL_INIT_MINIMAL et al to Kconfig
  (b35316fb67cb7aeaf022032ce078135251372f39)

changes the behaviour for non-SPL builds when relocating code. The patch
sets the CONFIG_SPL_SKIP_RELOCATE option in a few freescale boards, e.g.
T1024RDB_SDCARD_defconfig.

Before, CONFIG_SPL_SKIP_RELOCATE was only defined when building the SPL image:

 #ifdef CONFIG_SPL_BUILD
-#define CONFIG_SPL_SKIP_RELOCATE
 #define CONFIG_SPL_COMMON_INIT_DDR
 #define CONFIG_SYS_CCSR_DO_NOT_RELOCATE
 #endif

Now, the relocate_code function in arch/powerpc/cpu/mpc85xx/start.S does no
relocation because CONFIG_SPL_SKIP_RELOCATE is always defined:

relocate_code:
  ...
#ifndef CONFIG_SPL_SKIP_RELOCATE
  ... relocate code from SYS_MONITOR_BASE to gd->relocaddr ..
#endif

When jump_to_copy is called (common/board_f.c), the

  relocate_code(gd->start_addr_sp, gd->new_gd, gd->relocaddr)

would not relocate u-boot (located at SYS_MONITOR_BASE) to gd->relocaddr.

For example, SYS_MONITOR_BASE is 0x3000.0000 and gd->relocaddr is 0x7bf7.0000:

Relocation Offset is: 4bf70000


Relocating to 7bf70000, new gd at 7bb6de50, sp at 7bb6b540

Any access to memory 7bf70000+ is invalid, because no relocation was done.

When patching

  -#ifndef CONFIG_SPL_SKIP_RELOCATE
  +#if !defined(CONFIG_SPL_SKIP_RELOCATE) || !defined(CONFIG_SPL_BUILD)

relocation is done in non-SPL builds and booting works.

Testet on T1042E board using U-Boot 2023.10.02-01420.

Best regards
Martin

-- 
Martin Fäcknitz

hotsplots GmbH
Rotherstr. 22
10245 Berlin
Fon: +49 (0)30 29 77 348-0
Fax: +49 (0)30 29 77 348-99
E-Mail: faecknitz@hotsplots.de

Amtsgericht Charlottenburg HRB 93460B
Geschäftsführung: Sascha Schaub, Dr. Ulrich Meier, Dr. Jörg Ontrup
