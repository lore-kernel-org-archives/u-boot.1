Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEA9C4332F
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 22:02:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E02D786EFD;
	Sun, 29 Oct 2023 00:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=hotsplots.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B63A878CB; Sat, 28 Oct 2023 16:20:16 +0200 (CEST)
Received: from mxb.hotsplots.de (mxb.hotsplots.de [185.46.137.13])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 430C787881
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 16:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=hotsplots.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=faecknitz@hotsplots.de
Subject: Re: [PATCH] mpc85xx: relocate code in non-SPL build
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20231019230655.24974-1-faecknitz@hotsplots.de>
 <20231028132653.GH496310@bill-the-cat>
From: =?UTF-8?Q?Martin_F=c3=a4cknitz?= <faecknitz@hotsplots.de>
Message-ID: <200e9d8c-5658-0fc0-36dd-cf36c3065ad0@hotsplots.de>
Date: Sat, 28 Oct 2023 16:21:18 +0200
MIME-Version: 1.0
In-Reply-To: <20231028132653.GH496310@bill-the-cat>
Content-Type: text/plain; charset=windows-1252
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: mxb
X-Rspamd-Queue-Id: BFCBA8C05A8
X-Spamd-Result: default: False [-4.15 / 500.00]; RCPT_COUNT_TWO(0.00)[2];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_ZERO(0.00)[0];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:~];
 ASN(0.00)[asn:3320, ipnet:84.128.0.0/10, country:DE];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-4.15)[97.70%]
Authentication-Results: ORIGINATING; auth=pass smtp.auth=faecknitz@hotsplots.de
 smtp.mailfrom=faecknitz@hotsplots.de
X-Spamd-Bar: ----
X-Mailman-Approved-At: Sun, 29 Oct 2023 00:02:41 +0200
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

Works now. I used T1042D4RDB_SDCARD_defconfig.

relocate_code in arch/powerpc/cpu/mpc85xx/start.o before patch (non-SPL build):

00000dc0 <relocate_code>:
 dc0:   7c 61 1b 78     mr      r1,r3
 dc4:   7c 89 23 78     mr      r9,r4
 dc8:   7c aa 2b 78     mr      r10,r5
 dcc:   48 00 00 05     bl      dd0 <relocate_code+0x10>
 dd0:   7d 88 02 a6     mflr    r12
 dd4:   80 0c 01 fc     lwz     r0,508(r12)
 dd8:   7d 80 62 14     add     r12,r0,r12

00000ddc <in_ram>:
 ...

After Patch:
00000dc0 <relocate_code>:
  dc0:       7c 61 1b 78     mr      r1,r3
  dc4:       7c 89 23 78     mr      r9,r4
  dc8:       7c aa 2b 78     mr      r10,r5
  dcc:       48 00 00 05     bl      dd0 <relocate_code+0x10>
  dd0:       7d 88 02 a6     mflr    r12
  dd4:       80 0c 02 c8     lwz     r0,712(r12)
  dd8:       7d 80 62 14     add     r12,r0,r12
  ...
  ea0:       7c 08 03 a6     mtlr    r0
  ea4:       4e 80 00 20     blr

00000ea8 <in_ram>:
 ...

In SPL build, relocate_code is same in both builds (because of
CONFIG_SPL_SKIP_RELOCATE).


On 28.10.2023 15:26, Tom Rini wrote:
> On Fri, Oct 20, 2023 at 01:06:55AM +0200, Martin Fäcknitz wrote:
> 
>> When building a non-SPL image, relocation is needed. This patch restores
>> the old behaviour before commit b35316fb67: CONFIG_SPL_SKIP_RELOCATE was
>> only defined if CONFIG_SPL_BUILD was defined.
>>
>> Fixes: b35316fb67cb ("Convert CONFIG_SPL_INIT_MINIMAL et al to Kconfig")
>> Signed-off-by: Martin Fäcknitz <faecknitz@hotsplots.de>
> 
> This is now applied to u-boot/master, thanks!  But also, can you please
> confirm that top of tree now works for you, and which defconfig that is?
> As part of my testing I check for size changes before/after and this
> doesn't change any platform, which would lead to how I had missed the
> problem during the conversion.
> 

