Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF41CC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 10:25:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 174E760784;
	Tue, 13 Oct 2026 10:25:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DfD3xzNsSzMt; Tue, 13 Oct 2026 10:25:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 241EA606AF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791887109;
	b=Df5gZGzjFgmU26NCsK+5LSlc4IQoDt8b8n6usOLiBpQ4YuLlTRp7fJr1mG4lMn29yU1A
	 I9c4bBmP/7+ckM8cI6pDo0r0QYhOt5BH/Vq8bdR9uYvMneYi9F3jaUHCcGPbWaiGIxHfA
	 CSyy1tr2jiCq8LoX4kWo58sIKGg+01vuZ+hDRsWC/OiCxzbj7OjCjqsx3Lz1rKxD5r2or
	 +JOIt4JJskSyu63U5HWs/s0kE0pVEFp3xQ8NFyzqBsL0WU2W6VB3gLwfvFqw8RIlyQ82z
	 RLQC3Zhi8C0nOuxbxf+lUYmu0O+A5PVZz/GLAksZHoLRXyb++dl9yMoBoT6LKY9J9/Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791887109;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DiIsyAlxk5+VzzeXBi+a8FZEUpj3PQTb8EI2sLgfuY4=;
	b=ovJgeajtUciwJ+APy7XqahUt+zFmFZ1ickV4gu+4AHAX198fYRk+qi3DyoShKRuEiO/o
	 eRY9pOQOvagJ1cPI6TH3r7bsi1ny7Q+jpkyTfiNqmzLpQK/TEFUT9x36NBNAYAu7iRqf7
	 Mlxd0TFb25sumAtEpXWaiip0gUR0wsOxVIOkiP8sAwKgO9gVCUu/nnDhNOUstVvhhWguT
	 lMh4EiIHodPfuWz20PBfNRs6pfb7l4fofoF+vyrLUnx1K+F7Zuz9CM5bYiBTScFLSucLv
	 LgxHGTzngVk3616hlssNrdT2x20RGK4AilTyOBI+Blx4j1yF0i316QWBhOALhtigNNQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791887109;
	bh=DiIsyAlxk5+VzzeXBi+a8FZEUpj3PQTb8EI2sLgfuY4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SKV/acQy5puUx5CTO98tCLrfefs4O7Hy0MM0dCvctwDOTLSb432eJPzHqnHgChTCx
	 J0M6D0SP+3XwAwTMZFT1pv4ZcRtWjx460AKc7igynK2EBt+cbpjvOKtKhIO3wyjG5t
	 v18d/i51DDGn+YaBw7MjKDBErxJWlY3sCdCl8WiWpQLCvE59rbhIi+AMWwjuKs8hPw
	 eSP130798Sew+z5SyB05uIdwA6hl7xc7mrMoHJBNdBdzWD+LFzmbJZmO10rl5WjbO1
	 AsnKklNIp5VpaeODLvdGwEFWUhp2Ah2gcCozdfhrz+pkdomyeR4RJaITA4pNLbs1/N
	 p/Zqf3h9Z3zew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 241EA606AF;
	Tue, 13 Oct 2026 10:25:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D647475
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:25:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C546080DCD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:25:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AiWTm0Piklqw for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 10:25:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BD42B80DA4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791887106;
 b=eayNs17LZmfpMzMZPNC4sw5CSLDrEgWhzUCeAfqFBMV9vTl0l3teQ8jq6AtbwvHPxpCO
 g8jkHPdQi58cAMEPgkXw4s9nY09Qk3nlkq7b0zApZc6It1zhhWvn5F1/03M3N3K4afo6K
 0tKmOIXdm8KwSKzmtQygyymZ/rUidXGFZ1Exw1z+l4uLgRUbYnGJyzWE/2ECqRl73xssh
 x1Zskg1wLcie7k4Jlf6VyTeuEhNIXGbLYtI4PnC8zPkqOD3io3H/jkbM/J9YeId+Mbr0p
 ccgAWVIjj2+GnsUE9nB6vCA7fqsLLhdBoSeDTkxyin+FD9tvSsJI1jukfGMnSme3eWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791887106;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=DiIsyAlxk5+VzzeXBi+a8FZEUpj3PQTb8EI2sLgfuY4=;
 b=XnFWgBpsVSBIC/rLFzKWF47r+/ZMbMCiH1sG9yQ1Oan3RyqVnR1KYnDSEpoyYCkhwHSX
 HmKmMBSlWtHoIVgIimFUJNY8DFexn6yB6bwDKECCXyL2TKHxpZ1ZDwIF11D9MIddge+Ih
 XyKPio4icFlffeUlNMq7C3yGgPPlHQJidkfNz/Y0/FpEIpMhJQdntJlgYntlEuc6q3CcS
 uQM45WL0iSZMbT5ryfvZDmY8Pcy7/3cE+Wl0JN7/TyKjE9XbQaa/VarQ+ZiuO+C7pIbpa
 hp4nF2gVarLUAGWnuI5Yka52uvLqJbdCvno3EMlG4fyOnecFGOEO4VOdwAk8xYgv+tg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="LEAYS/5g"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LEAYS/5g
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BD42B80DA4
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 10:25:05 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6ae27f06c2fso4373416a12.3
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:25:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791887103; cv=none;
 d=google.com; s=arc-20260327;
 b=rW6z6xvB87oP7OTGhrLmwzKkWjtN0aLSHQjbp7vQcGqczJGSWtbgioTWGujmMZn0Wf
 DIv+Bx3J6389ZEDLl5di1nLxSxmfCRigqlIy6ggdJbPu4RF7b53x+rIlNDnqBqu0yyHv
 pAwBqsNASLnuLZD8kHF1O9yvagcLLGVHicvLDNMXL7kE5qgIr1OPf0n7HAKGaQsuZ6fA
 gUdpUI8cwDabALQMRkTiUi6/dNv8kP77Hv79UykX/50r/BuEooQuEHMUsP+YsHVDIvsq
 t6OzY73nPpFLJz/qGuvDNVrdrgk4kefSbkfKBLatiURnRZFxDYtaA6qNONPGqGjG3gHc
 jEHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DiIsyAlxk5+VzzeXBi+a8FZEUpj3PQTb8EI2sLgfuY4=;
 fh=HNvyiKdY0EVXoOVdehOWSAhbBVIvKB9921VBkS5FvAg=;
 b=FmNGltJTxbxwSq/H7+X6kybDL5G+IHJSfnMfHCie/hr6xkls2QQB3U2FrrJRFY/4oZ
 zkgAPPSzzrxCdKbvGilNsmDdgtHeZ8M+TuKtXcVhni1bSXcZwewpLWFI/dp9CHagcBLX
 Zddzm6w6e0E4O4ShmTA2/g2rICmCLh8rvSSodNfLgtnWolnrN/1pF4WKVX7o/Xrsv9uz
 r2e2er5EMKFeX9N57D7b/S7VtMYWI1HdeItOyt2kzEqybhO7Oxy1/N3KsTqr8CBFCMHQ
 rXSp6APm5YnVoGSh+Omz4g7yLyZEoHC4J2lF9sMqA14hRsxms3G9onQnemIIeFAKkM4G
 LmwA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791887103; x=1792491903;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DiIsyAlxk5+VzzeXBi+a8FZEUpj3PQTb8EI2sLgfuY4=;
 b=LEAYS/5gKuFUZyCZ392L+u/6D1Hj1JctbhYa26SMqUzhWxO+Ltr0R/KjeugteLwUka
 opgPt7ExMuZdSI5t41bFHVXiCYcOgMASM+f/AorVm73a1h8g1PXLg54Navu0NJ2GWuzr
 N9rOoTymiRo1zRu76LcbD1rPGseS9ga9f+yFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791887103; x=1792491903;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DiIsyAlxk5+VzzeXBi+a8FZEUpj3PQTb8EI2sLgfuY4=;
 b=DOtc3rGoGFDlS4z4+LC19jd0dOoY02zsSyosxg+jWZSKw9QlOh4fhwzy+8nB4tWosB
 rRecgHYrEgWF16786rQ4a/VW/wkkaXLXbY6wHN5SQKV9B+RF3LcblYhqn+XrbQP+hOu7
 lBmnEVRtXWrqGCz7eYlqFVPrc2UCJbEDvDzZse/mQmMP7JXOkgW3kWytvGrgKo7Z35xZ
 GJOJ1ga9c2CRLg2azk+f9l7HtuQqquCLeBpijb74uTIjzrRnodUbG08tpWlwHSbTWKcI
 uT/yxv6LVglG7lT1XnEjQnqzdhH/JKHyPfSU0vY8c4gPP2xO5db/FH6mINX0CLuTI8P6
 b2wg==
X-Gm-Message-State: AFq9FYLRZgcQJvZo7oAYi7g9SSU4o8njD58oaAjQgfvGAMPptyEITacw
 +kboqZjJSOK5QSzOk4KTVHbM3We4MbPHTjaGtrUaCG5nW3k0O6KnofnBxndhq9VPO1RwKXlpSpw
 3nt98qGTssIeiGXMS/h5FfoSHnr/tfXiVQvqUl2RxE0iUyMICA5l4z2X+
X-Gm-Gg: AYBFou1eNuOGOjyuEDdFDUeMfpQg9NZx0r6bZPnXalV20Q32r5GmJje5X3F39MIb4Fy
 XhTNS34qrLFTK1vYrqea3M3sgrL4FG+Rvr1nJgmdpiklzenDd9chb9ZmeGJ7ce6NpUawSiwNPwY
 3OkQwfGoGd6DtcgmFJmjZi5Pn6ddLwge9H2mj8llxMpZXqVsYE2RkK8eBB2i6uVcUF979Fnrafh
 X3mjIMqYFdg+2aHZAF2myE3iZ0PhAkWL5EnVn/NGhCgMY83ZrY8KtpfIEz7i8qQru70Z3xvAf86
 lPdOaMWwW438j1N6tYTF+va5QjVpodsSMucwfFFz+H8O5KryuuH7rgfd
X-Received: by 2002:a05:6402:4341:b0:6ac:b8f4:20d3 with SMTP id
 4fb4d7f45d1cf-6b17c27abe5mr9532281a12.27.1791887103416; Tue, 13 Oct 2026
 03:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20261003-aspeed_vbios_fixes-v2-0-f8e593f024ab@oss.tenstorrent.com>
 <20261003-aspeed_vbios_fixes-v2-2-f8e593f024ab@oss.tenstorrent.com>
In-Reply-To: <20261003-aspeed_vbios_fixes-v2-2-f8e593f024ab@oss.tenstorrent.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Oct 2026 11:24:30 +0100
X-Gm-Features: AclHuK9PtnCkwTSprc8IyKgY-cV72ys-SAPhHD6pPiF51WiMHa1QLSlXm1kiF9c
Message-ID: <CAFLszTj3vnH=6Y8zQu57x2UzSvZSbe6DwS4iavVwDLUiCFYv=Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] bios_emulator: don't free a caller-supplied BIOS
 image in biosemu_run
To: asrinivasan@oss.tenstorrent.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Anirudh,

On 2026-10-03T20:07:54, Anirudh Srinivasan
<asrinivasan@oss.tenstorrent.com> wrote:
> bios_emulator: don't free a caller-supplied BIOS image in biosemu_run

Please say where this is actually hit. pci_run_vga_bios() passes the
image from pci_rom_load(). On x86 that image is at
PCI_VGA_RAM_IMAGE_START (0xc0000), so the existing 0xc0000 check
avoids the problem. On other architectures the image is malloc()ed and
pci_run_vga_bios() frees it again on exit, which is the double free. A
Fixes: tag would also help, if you can find the commit that started
passing the image in.

Whilte you are here: the subject is 69 characters. Please can you
shorten it, e.g. 'bios_emulator: Don't free a caller's BIOS image'. In
the body, please write biosemu_run() and PCI_postController() with
brackets. Also 'i.e' should be 'i.e.'

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
> bios_rom is NULL)
>
> Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
>
> drivers/bios_emulator/atibios.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/bios_emulator/atibios.c b/drivers/bios_emulator/atibios.c
> @@ -509,7 +509,7 @@ int biosemu_run(struct udevice *pcidev, uchar *bios_rom, int bios_len,
> -             if (vga_info->BIOSImage &&
> +             if (!bios_rom && vga_info->BIOSImage &&
>                   (ulong)(vga_info->BIOSImage) != 0xc0000)

The fix looks right, but with it the other two conditions do nothing.
When bios_rom is NULL, BIOSImage is always the buffer
PCI_postController() allocated, so it can never be 0xc0000; that check
was only a workaround for the caller-supplied case on x86. free(NULL)
is also fine, although PCI_postController() returns false before it
sets BIOSImage to NULL anyway. Please can you simplify this to:

    if (!bios_rom)
        free(vga_info->BIOSImage);

That also makes the ownership rule clear.

BTW, PCI_postController() leaks copy_of_bios and vga_info when it
fails after the malloc() (e.g. on an invalid ROM signature), but that
predates this patch and can be fixed separately.

Regards,
Simon
