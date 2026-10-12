Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7D7CA9ED1
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 14:04:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C0B880BB2;
	Mon, 12 Oct 2026 14:04:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nZREKZOeCrsi; Mon, 12 Oct 2026 14:04:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BDE7980D2B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813861;
	b=PpYWQiTyKy2XAvqGfmIaTI+Ir+RS80rI+7ivtuhIsUAr8CZZr5osEjgyivx9Mn9cjZZq
	 y6hinnlispxu7bdFD6hn0FzMlUxe+geA34jChAFj4dgKXpTEbQKDnNpfT9cEFpxt6bZYn
	 eSzkEPFBtHgNcslWls9c5T/2ccLXnKIA1I9oe0+e2RwrqfbfisR6OCXLpynSpUwW7ClY1
	 W+7q1IrtszauMf4ODbuNXoco9aFFhG0dXI82iczIPPgkFeUPoiagbLaw9XXk8WTjFuFXH
	 t7YnKRWNWCgxBw1ACiT6ayh4cP8m2BtP7YWuLPEGjMmHAsb9KyWFJSU1LCxuYAdsDKQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791813861;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LOy78G++Tcvl+CfFt/swmmqKOVXaq1B7FIjppwwEFl4=;
	b=aj6mLooeTaPENe1JzQbze60p/2j57ufvmz/CeL/xAscWyUzAGd7Ht+6aSnRGDXUd/Zqq
	 a4irmeBnCfmQm96iYJyoO66Mh7bZt+3pFRdHUky/xrxX0DQcPc4yX8YcFwOe6FHKn22K7
	 a0H9NY74TaNNwNYsc+CO/pRoYf1uZHHYn5vABx0ODMOjguKq6n1WFNcs0MaRcBJPwEXst
	 3RkZckWwxftzvzEduX8LvLFqs+BAY8vsASScHXDvnDEfXYGgBgTk3Ip+UmyBle9Ufvyos
	 UvSYxYinVovr3uQcd1/QFFxSzPVHElNyR/MpBjNvTCI++17AZCjDRRc43qDf+ZuT+tw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=GjwvaSwc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791813861;
	bh=LOy78G++Tcvl+CfFt/swmmqKOVXaq1B7FIjppwwEFl4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JX3EDS4VclDeq7Ud31JqhdvRWymc5fUyLJZ6oeBvvETbANHaRQGPZEBR1beLCa8RQ
	 M1t3XYFA4TRWQB6Cpwk5JSxlV38rxgA4cBsjfwX75Avak8KJE7FKg16/+9s6aiAxr6
	 j3464Qgm+wPDq+7WP9a/uCBtMSERuVZ+8zM4PB2va1SK9I5ylcw1ntW88hpkKx1NVs
	 ZXTAANf+P3dHoGyxtemHDVcX7MD+iAr5PdllisY0emSzZIG8phxr1enYHcllZc9uMX
	 sfIFKV3g+goZitlWG+j6pcKMQyzl/yAr26wbHLoSZhngCN0Bg5Eg9k+QV590kNDQYw
	 Elo5IGDGa6lGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDE7980D2B;
	Mon, 12 Oct 2026 14:04:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 67445179
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:04:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4D86A80D2B
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:04:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aHw3LhCzs2Mn for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 14:04:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4AD6980BB2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791813859;
 b=OJyIJFUrkfdQS6WB6n7Qx1ChHN0wS7WtakJosdT+JnBdnqzwGSqeU3iv5QrohM1xTkl9
 paT9tjl9O4uHNP3pMIrTDaBY2+jWZ579NX+Ge48fMNh+u8XFM3CNBWje9u5KK4b8VHa33
 CNTRPdPLOs/fmBlM9Css4jtoBhYnqkjwX3kJi5Wc8bofhUX2yEIO2ExQ/YZ8dYCV7cvrj
 tdmDYfPD7YvFi44IA/qgKmxDr7HfcbahCO7Gi8saaXIZ1xCEz2OB3bg5sK8JQ/3Cd6wrm
 OtATJKtEkmmz1TuJj5wL7cwnUld2buwVhOPLOgZSCAUU2NNDPvd0sI9NqL3I876L15g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791813859;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=LOy78G++Tcvl+CfFt/swmmqKOVXaq1B7FIjppwwEFl4=;
 b=ZbB4Q4EaV0WtXNFkQ1Oz/YDEF/IljNd/69XNukzyi9mxueK80hHre0fTFAPan01mBJoh
 djMAGcwyQ08V9/o07zod8bax1P0lZ1ALZtPqYj3OPtBm9OpFwA1aougC2sBLpVKqKkwgR
 4ng5L7LNzGXpBTcrkzJt3sfCPgnSlQtlAYYTzOmE4MBZuu9hXiHBhejr8odKRI25M2XlB
 Y3zVhPFhHNkJMNCYcsMnj0M10+XKmnS3moiGg0QOjjREks+Yozcyb6HTZ0MocRE/s9CN/
 XDAQjKYGbUgfa1rTa/6WxVNXjJE/GLzoiSVmRlf85wjBITvKlAXVZwpXYXT4vpLkavA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=GjwvaSwc; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52c; helo=mail-ed1-x52c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=GjwvaSwc
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4AD6980BB2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 14:04:15 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6b1ab02ba4dso1858636a12.3
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 07:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791813854; cv=none;
 d=google.com; s=arc-20260327;
 b=K2id/5/os+lpV/Bb0EBKh5jm1Jna0eNtdwHQK+wjd2tD3xYvduec7HfLZgPywwByum
 WzLvlZlfNcIXHBDkhfHybzwBG1iVXAXjnGCr2lUoOWeYOZ1Y9DIEF0WUro0/ZelhsMlg
 JMkoZHwkaCQqBGD3e/rKtelMPcoJSyyUyqu8Jei5666dV02ONBqVuchzxLwmi/4/nwRh
 dncjm9e6W5Zx3l6lwPybBbHTHvEga4wKNved/ndj7zKSrVGrjy0OJtt+ltZydUnTSzvg
 BNQcR2BkZMqd5i61nCJXDI759RcCyfB1V+6ghL7qAhkzAzoi32RSIrF5OQgtraulSQpD
 BDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LOy78G++Tcvl+CfFt/swmmqKOVXaq1B7FIjppwwEFl4=;
 fh=QEXFfNFaey3k30F16NYSbHExo6tjdBBykHPh5RTuD28=;
 b=qqgthnYWt8fETeSoHnR0iYbDEZ2GmQH1GoVcsJFpROfPGmg5FmjV6EcDPwg23jVIcx
 OKIi7y3AApjdcJrS9FECSoolIu+hSUh/hz5dxVJcgPQQuZoxI0Du+TgXTu8Z6h5kCo0e
 Nu/eiUpDvf8m1S04kzsWLa4M+3IlPLr+1LgwT+vZNrZxkfKHWOnMPvsi5C/mhMyPC8bK
 wcTmZqngxR+CUHijHy87l87ORPYtBVB6exKB+psuK/lk09SUeeD+fQT6BAuOIlQ8V5d+
 cAGRsOanTP7oK0ZFpjZFBoSBaiqIEEkAtA28Op1PxhNQR6D7snZ4rHZl9zPmEpK/ucTw
 NbYg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791813854; x=1792418654;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LOy78G++Tcvl+CfFt/swmmqKOVXaq1B7FIjppwwEFl4=;
 b=GjwvaSwcAJJcEVpTkyTxybXVo8Y2V8AwxXFp22Yd5f8KFLYZ7Qv3hK3ymcrbDVt/i1
 rDnennTG3JPHbubxw6jPHW+uuzaaNjkf0JjY5Tco72k7Cz2428za6l1rJYY5lkPzhyvz
 hm/J56K0I4aEf0VffRKG0Gdtc8r5jVVhOZyxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813854; x=1792418654;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LOy78G++Tcvl+CfFt/swmmqKOVXaq1B7FIjppwwEFl4=;
 b=wEUsv8O92vhfFJ/NlvZ1PJJKAliQkEKOGro6XjTmBAW0S4ATNDjpr28F+fLKqEemBP
 8FN3ruewLiiYz2AwXceks9RdObz8qq4LqfS9Oi9j5zI78IzZ1YPy8meeG8W6jCK34y3x
 QXqvlfZ6iYezrnSBeGemA84di93pXF2mHO9MM+cO/w1YSiWHIGQAeugKOADVr7oU3DoF
 dXKCa1aT2gXTythrpbS5ODtErutOARgTtdhPVo0/oSEFouaS6M4dBmu7P8PSfnjRmDLI
 Z13qjsXCtzHe1hr4O7j4GIVbwJCP5Dle9j8ceZG9H1yhPlaJejqS+v/wqgMpekcDvA5o
 dxyg==
X-Gm-Message-State: AFq9FYKW4jbJw4lpNZ7phG7Fy3C45UgYTseBAO5H4vyfpHTnrlEYnOlv
 yeSUH+NCZp/4ZxgkepIuTjfcCez14/5ZlQ3Y8Py4lzcQZmjghzDf7+wwuXgTpTQj6W+m64R389f
 pDNdeaSOFCbyPrwBnjlCI8wXcd39WcxzimmKXW944QdKqiQe7Mwft77kn
X-Gm-Gg: AYBFou1nsVnNdujZYeH2pT5WzuFrqae/uz0jXRFZq3tppX/pZELF3K+Szd36chQxjqX
 kyDaEEaGWSXKs6q3/nK/xMC6GIeYFhcJNVi8/j5cN8GXCBabKwxNW1XF1cY5za+Z4Rgqw1BlLac
 whart+nmstSX6OXQO2j4Fky4mmBBu0JjRBKY7chmBcPN7IYhmUznT3/hA8ho1eToXQXA8tG0waE
 7qaXjFrWBfssSTNeXlw0jHq7R+X/boJbJhZ+nodrh/0Le0zCKe8pZ6MvbXqceSfaiAJEI8szn3T
 yjkLneW2azk6aQE+nde7j7wjWW7FDRCyPHIvTk3Q8wDvgtbf6ct6Q/vt
X-Received: by 2002:a05:6402:2346:b0:6aa:f1d2:ddaf with SMTP id
 4fb4d7f45d1cf-6b17c23d5f9mr8276299a12.10.1791813853876; Mon, 12 Oct 2026
 07:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20261011-upstream-bootm_android_b4-v1-1-3e82462ac206@oss.qualcomm.com>
In-Reply-To: <20261011-upstream-bootm_android_b4-v1-1-3e82462ac206@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 12 Oct 2026 15:04:00 +0100
X-Gm-Features: AclHuK9jI5EzSi5T-95mKQbJhBDtpRHTGeYhD83Y1JwKYQ-JaUg6MYXAvdjY_bw
Message-ID: <CAFLszTgcEmk_pTufiP06dLzRfG938FoPa_60WRyaQ72QOQRYYg@mail.gmail.com>
Subject: Re: [PATCH] bootm: set os.arch for Android boot images
To: igor.opaniuk@oss.qualcomm.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Simon Glass <sjg@chromium.org>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>,
 Daniel Golle <daniel@makrotopia.org>
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

Hi Igor,

On 2026-10-11T13:10:26, Igor Opaniuk <igor.opaniuk@oss.qualcomm.com> wrote:
> bootm: set os.arch for Android boot images
>
> bootm_find_os() leaves images.os.arch at IH_ARCH_INVALID for Android boot
> images, so the arm64 Image relocation in bootm_load_os() (booti_setup()) is
> skipped. An uncompressed kernel from a v3/v4 boot image is then executed in
> place at boot.img + page size, which is not 2 MiB aligned. The kernel
> reports "Kernel image misaligned at boot, please fix your bootloader!" and
> dies early (observed as a stack overflow in start_kernel() with a GKI 6.12
> kernel on QEMU virt).
>
> Mark the kernel with the default architecture, like the legacy and FIT
> paths effectively do, so booti_setup() moves it to a properly aligned
> address.

The legacy and FIT paths read the arch from the image header rather
than using a default. Please can you say that the Android header has
no arch field, so IH_ARCH_DEFAULT is the best we can do? Also, the
in-place case is not specific to v3/v4:
android_image_get_kernel_addr() returns kernel_ptr for any
uncompressed kernel with the default kernel address, or with
ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR set.

>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
>
> boot/bootm.c | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/boot/bootm.c b/boot/bootm.c
> @@ -432,6 +432,7 @@ static int bootm_find_os(const char *cmd_name, const char *addr_fit)
> +             images.os.arch = IH_ARCH_DEFAULT;

Just to check, have you looked beyond arm64? Perhaps it would be safer
to limit this to arm64 with IS_ENABLED(CONFIG_ARM64), or explain in
the commit message why it is safe. What do you think?

BTW, for a v0-v2 image whose ramdisk is used in place, booti_setup()
can now move the kernel forward by up to 2 MiB. The memmove() copies
image_size bytes, which includes BSS, so it overwrites the start of
the ramdisk that follows the kernel in boot.img. Executing in place
already has a similar problem, since the kernel clears its BSS early,
so this is not a regression, but it may be worth a note. The following
LMB reservation also still covers the old load range rather than the
relocated one, but that already happens with FIT.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
