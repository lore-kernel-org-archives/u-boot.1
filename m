Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59E4C44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:16:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E6D160743;
	Mon, 20 Jul 2026 18:16:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 645mB-uwEpZe; Mon, 20 Jul 2026 18:16:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0FEA6606E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571399;
	bh=/z14BQ6La6H9+iMTDJd46fHujzBdUHrw1W0E7eqlrh8=;
	h=References:In-Reply-To:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=cRJDLEP9Uni04HGK4a2iZY+xxVdK6+LfgOYC6dz3CzrLgSVofKPkcZFKUkhvvKjKm
	 CCE163OD0vLF7Eu1KcELXaPjDl1X5+XdhAwDZxQCeExFfUBz+v3hgHhEjH7vD0JD23
	 Ni/msLtWzeF8+taTnuNi+Cmi0uVGfdfUc9HgOAbciBlWgrIEXpEJbsZvl1BzqdBYcN
	 1n0gRwG6wshhFAhg262053fUgZGWePqu9qsKysRsEe6N64sGrs3xjMJ2PPzl0jqhvo
	 mZ+i5fX8y2wxc1NSRRhIlRyqO2g6/bzatUjI7LelgQhYEXKmmtXMNFOu4m5XVh/wN0
	 mDhn/1oDa8MtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0FEA6606E5;
	Mon, 20 Jul 2026 18:16:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9DCCC42A
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 84A63406F1
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:16:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tP3HHgjFXA5v for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:16:36 +0000 (UTC)
Received-SPF: Neutral (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3506B406E2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3506B406E2
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3506B406E2
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:16:36 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DC79844F6; Mon, 20 Jul 2026 20:16:34 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18C3E80433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:16:32 +0200 (CEST)
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-8484a0b998fso10307891b3a.2
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 11:16:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784571390; cv=none;
 d=google.com; s=arc-20260327;
 b=lCv1QR9DzHbmBUv0pFIf3Mx84iSTIbUC2PwaAqPGdvpt0KF9Vw7mu8Uh0W4cDJ5vlv
 S2DjbTt4BJce60px9MUsrTKjzCPBmwqHsUoPXDd/daeIW9FXIikQAvTpgEZxBoBmvwpj
 cQCToYisoL9gmDPNEnyOByn56t9tI1IPkIvMPhGIFyXlC1VPa+bZjZywqvViFKTvXjJ8
 4B1SwlUIszIQey2+fobdvLJf9pwsHKYRxhPv36GlkjIyy4Dyg3KVSOVl8VTIY0upbzMe
 pYjVDT7PD/TQKMKoMbT71PKk/gYfUSLMz0fqxkkHmr6PJL0VhYkndJ9SQ1UjbPNblEiZ
 7nSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/z14BQ6La6H9+iMTDJd46fHujzBdUHrw1W0E7eqlrh8=;
 fh=HGFxqjW7EmEVgkuAAKalGIiLGTacmvL3ctiAmCo/d5o=;
 b=nXXQZX3u6EbfvlMR+oe/mvVgNAiWEdTjanz4CgxvZSNV56BXMCha9M2rbI199tIGA+
 ELEDHHDO7+52SgiB91d0O2dk2z2s53UI2xppm0xnnA7njU1wi9rahj4gAaOUXTW/K2fu
 8s5zDQ016S3Zk+PEpzPPXNSyV10qLY5fsC5UGuo7jUF22EmIEk+AzEdaQDih9iVxEIUc
 d4vx988jiAk5lp27DAum5+lD141gFn61no/X7UEtgr5RWWZmvVvdsJxjM0+pZEyLT+vH
 oyzF1sDHRA78eVNi409IXPFXsT4wJgBcESgqJK2izTegVOTG8E3e/nEcs3lkJ3lOY+tz
 onLA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784571390; x=1785176190;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/z14BQ6La6H9+iMTDJd46fHujzBdUHrw1W0E7eqlrh8=;
 b=qKodxMIpssqzv/xt0rgdcFslB/ZW20eGIgnbjbG5C5sMixkr3t/sFfl7srTlbU55L6
 zFnNHXW3dxKDPu8ersuGRv5oM0dnXiBVXHig+9dvmHQSkKRSCoeS6Dli7MIbjkBuXs9q
 lqZwVQF0YcAMeuZemQcj8e6WWmjfEyelkKz0ppgoQqBwQhSw+BbXus/Skfa1hWUSw9pm
 rUL0hVaNWVMxr5G6gwSL//vbUf+sWlz3qQS4qLCUiryIP+zDj1l7pkKUvor3YGDOMCfi
 Qw486iQODRCpiySYoQ1hlp6ZkbpH/jKXqScIWCMd2LizrNrER2LUBHddBH0SJ8C99gYY
 ql0A==
X-Gm-Message-State: AOJu0YyE3C5I4Y0ul0QA+BeHHQmMtqmnCL7pbwJPSgHch1unVFg61n4j
 TTbjtQU7qu/uPj7R3bcFMAkj4+wnfwHlHyIg6xa8zcm9EN9peGFfBbFKOYFWyFPHjao2jAnml61
 WeGciI7mAJFTsQVKQWFO8E8dkIwpFrfk2CQHX1w+n
X-Gm-Gg: AfdE7cnEwzsQBxzmMZGeLoKK0M7fhSkb919HzICxjVeZYQevYawxUG/eRHw9eZpNnvk
 c9KeRz8vW8gNbXCb3zGY+h3W2s3SWAHi9uSIBXDJjLTvsSQeW7Pq3mPd0OT3YpZxj0JJbIdlE/W
 QayPjtjlHV9uLifY0Ftb3s7UPCbOAV+e2+BOSL/hZ5D6c31S6KNRKJtJU7oANfhUjpJsXjdpS5o
 Ov9dbZnj61vz0BdaCiggQZ2TcUTnMsq+X0qtYR//Hh0I9h6Y34LgpM78vV5
X-Received: by 2002:a05:6a00:330f:b0:848:50a5:a70b with SMTP id
 d2e1a72fcca58-84c292c16abmr16786621b3a.21.1784571390525; Mon, 20 Jul 2026
 11:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260719-aspeed_vbios_fixes-v1-0-c94026f28250@oss.tenstorrent.com>
 <20260719-aspeed_vbios_fixes-v1-2-c94026f28250@oss.tenstorrent.com>
In-Reply-To: <20260719-aspeed_vbios_fixes-v1-2-c94026f28250@oss.tenstorrent.com>
Date: Mon, 20 Jul 2026 12:16:04 -0600
X-Gm-Features: AUfX_mx79_G16hOhcckPqYLVpuU4jAfTqm0KIjBvlxf8r0_fylybMIYLvMtv2nM
Message-ID: <CAFLszTh7f66CO-1=yJeO68L5gPMyTrT0U1XH30twHt5Dcv=Bew@mail.gmail.com>
Subject: Re: [PATCH 2/8] bios_emulator: don't free a caller-supplied BIOS
 image in biosemu_run
To: asrinivasan@oss.tenstorrent.com
Cc: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Rasmus Villemoes <ravi@prevas.dk>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Conor Dooley <conor.dooley@microchip.com>,
 Martin Herren <sputnik@on-the-web.ch>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784571390; x=1785176190; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/z14BQ6La6H9+iMTDJd46fHujzBdUHrw1W0E7eqlrh8=;
 b=hLzxYwrW1wWN3oM2t3xu2VMKH5kVYYejrLGgvHl4wYXNi7GRaGBXSEwq6p+T40eyfd
 vopuE6ETwTQ/8vkDaL+fL0q+znI9l0AMddABMMfUhYs0s5BLiCjKcG+MvlO4/G8NS11x
 n1l4FQV5g3FsuQjoE2SP0v8LMIAo3GNOXgwn8=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hLzxYwrW
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sjg@chromium.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="hLzxYwrW";
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
From: Simon Glass via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Simon Glass <sjg@chromium.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Anirudh,

On 2026-07-19T18:03:31, Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
> bios_emulator: don't free a caller-supplied BIOS image in biosemu_run
>
> biosemu_run can be called with a BIOS image supplied by the caller
> (argument bios_rom is not NULL), or with no image so that it makes its
> own copy from the card's ROM (argument bios_rom is NULL).
>
> It subsequently calls PCI_postController, where the BIOS image it runs
> is stored in vga_info->BIOSImage. In the first case that pointer is the
> caller's buffer; in the second it is a buffer biosemu_run itself
> allocated.
>
> The clean_up path in biosemu_run always frees vga_info->BIOSImage. That
> is right for the second case, but in the first case it frees memory the
> caller still owns. This can cause a double free when the caller tries
> freeing this memory again.
>
> Only free vga_info->BIOSImage when biosemu_run made the copy itself (i.e
> bios_rom is not NULL)

The parenthetical is backwards - biosemu_run allocates its own copy
when bios_rom is NULL. The code correctly tests !bios_rom, so please
fix the commit message to say 'i.e. bios_rom is NULL'.

>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
>
> drivers/bios_emulator/atibios.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/bios_emulator/atibios.c b/drivers/bios_emulator/atibios.c
> @@ -509,7 +509,7 @@ int biosemu_run(struct udevice *pcidev, uchar *bios_rom, int bios_len,
>       */
>       if (clean_up) {
>               BE_exit();
> -             if (vga_info->BIOSImage &&
> +             if (!bios_rom && vga_info->BIOSImage &&
>                   (ulong)(vga_info->BIOSImage) != 0xc0000)
>                       free(vga_info->BIOSImage);
>               free(vga_info);

The fix is correct - dm_pci_run_vga_bios() in drivers/pci/pci_rom.c
frees 'ram' itself when 'alloced' is true, so freeing it here as well
is a double free.

BTW with bios_rom non-NULL, vga_info->BIOSImage now always aliases the
caller's buffer, so the (ulong)(...) != 0xc0000 check is only
meaningful in the !bios_rom case. Not for this patch, but worth
noting.

Regards,
Simon
