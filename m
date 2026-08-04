Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB97C55182
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 02:15:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7E329406A8;
	Tue,  4 Aug 2026 02:15:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NVuwQVPAWeQh; Tue,  4 Aug 2026 02:15:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 242BC406AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785809707;
	bh=ASNZJRasADRfO19AK5n0nDxpxbercFf2Sq/66qi308Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nvmZiS5DDTzSpnKzMuszpZz2riW9x2nGuMYvqBdJAfhk5TmZk8JHP7l145dtRvBk3
	 SQGxw9BZueVnkrxa0/+F1M6PtnSROgTTNuoQAA6PhHcWAp1KBR+UdYepg2OzdLicv3
	 dxqiYjjRmGK/nqtXzHoC6skxJcEbI53pOQzrPxfaGhni02OAkV2n9cJAMlGMUpfjZT
	 Ab3MneDWQWQY4bnX4fDbu8zTDfAkSHyuiOPO9lt/6LhE6/8eA0h6k0LTGdG0SdtmvA
	 pGiXF1HADtfal54dLHikDiYVj11VvXPi3OWJqPRuj2ZqLpkCBTHNHNyRSLUpakc/3b
	 ap11Hgh4eO91A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 242BC406AF;
	Tue,  4 Aug 2026 02:15:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 54B36282
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:27:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 51FC380C1C
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:27:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WRm2Ea3KGZWO for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 00:27:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=elliotjb+anduril@elliotjb.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 345B980BE9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 345B980BE9
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 345B980BE9
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 00:27:10 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB8C5842FC; Tue,  4 Aug 2026 02:27:08 +0200 (CEST)
Received: from MTA-10-3.privateemail.com (mta-10-3.privateemail.com
 [198.54.127.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AB1080087
 for <u-boot@lists.denx.de>; Tue,  4 Aug 2026 02:27:06 +0200 (CEST)
Received: from mail.privateemail.com (K8S-PROD-WORKER-06 [104.30.160.130])
 by mta-10.privateemail.com (Postfix) with ESMTPA id 4hDZ9c6CVTz3hhTG;
 Mon,  3 Aug 2026 20:27:00 -0400 (EDT)
Date: Mon, 3 Aug 2026 17:27:00 -0700
From: Elliot Berman <elliotjb+anduril@elliotjb.com>
To: Tom Rini <trini@konsulko.com>
Cc: Elliot Berman <elliotjb@elliotjb.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 2/3] qemu-x86: Wire support for applying capsule updates
 to pflash
Message-ID: <anExGWj6kgZlXvIT@eberman-5690-nixos.corp.anduril.com>
References: <20260730-qemu-x86-pflash-v1-0-fb403348e29b@elliotjb.com>
 <20260730-qemu-x86-pflash-v1-2-fb403348e29b@elliotjb.com>
 <20260730221208.GJ1773261@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730221208.GJ1773261@bill-the-cat>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 04 Aug 2026 02:14:59 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=elliotjb.com; s=default; t=1785803225;
 bh=JLnccRCmzlDmOxud5k356LreRTT9T1rqfLiVj1I/A4U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TaWOxJSy9ol+iYPZQW0DMH84yDlKrFtYNZO8f9ZAjuKJuvqZxj7dTQOHJniFXD5c2
 VXyRm/ejo5n1fBZwDp+cxwQ3Kn3K3UNQCxGNskJ1AWwgCDg+1kwx6TT47nkPVcAje2
 try559NMKjdoBzHSo12M1F6eVE5tGn4M9u8lGdZSW1kZlkaecRxNYJwcd1DM2nxzkM
 6U6x3xR64VFtiZ8Cx0YteuoknDb2z9oRw27cMZmKFP8wpwN1X8uVM4FzYJZW2tzsY9
 mhwbVIhOrMKOwDvPdOwXAVA7/fYAEHMS0/duw+7kFr4oJFlG7RXesMhA+8tNAenlFk
 Tbn4n+G5R8RDg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=elliotjb.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=elliotjb.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=elliotjb.com header.i=@elliotjb.com
 header.a=rsa-sha256 header.s=default header.b=TaWOxJSy
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=elliotjb.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=elliotjb+anduril@elliotjb.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=elliotjb.com header.i=@elliotjb.com header.b="TaWOxJSy";
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom,

On Thu, Jul 30, 2026 at 04:12:08PM -0600, Tom Rini wrote:
> On Thu, Jul 30, 2026 at 12:37:46PM -0700, Elliot Berman wrote:
> 
> > Following the flow used for qemu-arm64, probe the pflash MTD device
> > and set dfu_alt_info/mtdparts for qemu-x86 and qemu-x86_64 so EFI
> > capsule updates can target the u-boot pflash partition.
> > 
> > Signed-off-by: Elliot Berman <elliotjb@elliotjb.com>
> [snip]
> > diff --git a/board/emulation/common/qemu_dfu.c b/board/emulation/common/qemu_dfu.c
> > index 8a59f5ade13..db7d8cbbb4e 100644
> > --- a/board/emulation/common/qemu_dfu.c
> > +++ b/board/emulation/common/qemu_dfu.c
> > @@ -51,11 +51,13 @@ void set_dfu_alt_info(char *interface, char *devstr)
> >  	memset(buf, 0, DFU_ALT_BUF_LEN);
> >  
> >  	/*
> > -	 * Currently dfu_alt_info is needed on Qemu ARM64 for
> > +	 * Currently dfu_alt_info is needed on Qemu ARM64/X86/X86_64 for
> >  	 * capsule updates
> 
> Here and later, we should stop enumerating the platforms because it'll
> just get expanded when say RISC-V is added by someone else down the
> line and just "on QEMU for capsule updates" is clear enough I think.
> 
> >  	*/
> >  	if (IS_ENABLED(CONFIG_EFI_CAPSULE_FIRMWARE_MANAGEMENT) &&
> > -	    IS_ENABLED(CONFIG_TARGET_QEMU_ARM_64BIT)) {
> > +	    (IS_ENABLED(CONFIG_TARGET_QEMU_ARM_64BIT) ||
> > +	     IS_ENABLED(CONFIG_TARGET_QEMU_X86) ||
> > +	     IS_ENABLED(CONFIG_TARGET_QEMU_X86_64))) {
> 
> Can we reasonably be CONFIG_EFI_CAPSULE_FIRMWARE_MANAGEMENT=y on a
> platform that *can't* support it? Again thinking to when someone
> supports this for say RISC-V it would I think make sense for it to then
> show up as "Oh, I forgot to map the MTD device in" as a run-time thing,
> rather than "Oh, I need to update a big conditional". And this too is a
> "here and later" question. Thanks!
> 

Yes, I can drop the target conditionals. I could also drop the
EFI_* config checks in this function as well. On QEMU, DFU can only
happen when those EFI_* configs options are enabled, so I believe it's a
little redundant. Does this make sense, too?

Thanks,
Elliot

