Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B93C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 12:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3EB3605D5;
	Thu, 20 Aug 2026 12:31:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QgPqMRyQlBzg; Thu, 20 Aug 2026 12:31:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787229110;
	bh=HPeFywF6LRvsao0mr1MPPLSXFhnV/IcB2v05kGhLCIw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FPy80Xd84nffVEcgC7hxfedg1mAOwrUwIa8t5o8D2i4LTv9PKuhOzi+pMQHAi88c3
	 IVnrSuOutH1AD4pU9I0gMZj0z14LKXyJsOt9Js0shxQvDVMr0qXy60RenOjiipjJPk
	 ABaJisZX7CTS/Ypx/j9Hpc8r/zPVO8170cPZ3grPJ252njTOztTJUizNnwFIVvBlD0
	 +5pqdYzsd00998E0anyFt+v7V7raS1Z5JiRlMDTE6IAaJYdj5mb3A7ZbFomE6oPw7X
	 ibq5TbOvYdDOXikADXvJvTwLND7g1ZxSmpCaoUV8EEj+QP/DVO0dBEx+7gpzWiD0FB
	 9L1gCOGgcpb6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD892605D7;
	Thu, 20 Aug 2026 12:31:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C4BC03AC
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:31:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AA3B340603
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:31:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n7D4CFzweZTm for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 12:31:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LuRbjwDd
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 01DBC40558
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 12:31:47 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2d5cad1a6baso16985505ad.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 05:31:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787229107; cv=none;
 d=google.com; s=arc-20260327;
 b=skQPg6mDGt+dvOgZzoLhbRpU7BCiGim2c4jqO1w7iwCP4WXMYmmAaOlRCJlfDSHAuR
 xk56/irixMSES77+JMvfx8DMNRXFv41Wxb0tNp0/SPK9dXOzqeW4cDMTsdR2J5OscqdM
 hIWlcTB4E/qHyJfkPo30BIls7ZAEtrBSwCA/BA5FMb6tMc/2tytiQWgx6cR97/l9O10I
 PDRl2JVASFbUfHgztYdLoOVmJWgi4KjCODtQuQ7T4Gj6YHGPLywBkdYK/zzEorcvJdfE
 2y62NdwDkCFQtVeE/G0X2GSs/UH2kzbcnEIkP4tuk0g2IwLNkxHB3XlI8Hmo22S6evYv
 iFDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HPeFywF6LRvsao0mr1MPPLSXFhnV/IcB2v05kGhLCIw=;
 fh=dt7UrUXnn871sXXPbwCgP8Qcn2KjxTAP32yeWYOSxNo=;
 b=bwZahqCnU4ikh+qZ3UHiyW+qqJGi9auAt3kWDtCpEPz//b+UCmqDC/zUJn5LcfVY05
 YBOKfPqRN1hUMCY2M/ezbhc8iU9YTm6XP3uNoQpo7W68OYJZWoVvBBv3ddCzVy3e6hyB
 e4Tg7QhNzDptujrCDQ/+jd9K5NvBAEnAg1qJ9cy3eysdBdVA5KhXc2FJqmG+y4jo6Ez+
 Vl5gStxSsOkMS8gp8SwSEih4XhM05u396YKorZFwClULZOycmPw2D38U0sAE4szgB+J3
 AF66+y8cPMRZAvYp2SaElgWxQR16et/iNdGylUb+ZdbzNbHxflyw4VpVqAYpw6Mg343U
 S1pA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787229107; x=1787833907;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HPeFywF6LRvsao0mr1MPPLSXFhnV/IcB2v05kGhLCIw=;
 b=LuRbjwDdV2pwwP3e46btpdBlNnjTGtG0iPlMhgJ73HOkY++yqeOSIilsqE4gLV4uRd
 TWutbmOKWUASUXr7fYkrHsEQszk+DEN91fbU30ojQ2pApgHYEMXIyoVFMBWS1aDF6xVh
 fHNdh0bb4xUfIIodMs6XNxib/uDIVSrUbd7C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787229107; x=1787833907;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HPeFywF6LRvsao0mr1MPPLSXFhnV/IcB2v05kGhLCIw=;
 b=VyDDl+/24CcB410LJaE3ZtjOYif2ztlBKeAHUaQxIWDp3DBBtmILVRi/db+aibemmc
 4FYIPJVcsRBIZyaKGW+XCZPo2VAgXdL5m0XuyyEjicZ/Ov8VeANC6L//LS+b0uxJ8me5
 ffqNPPlnIIQB0CGeb5Utw+NHLYkiLZoBRLOu2HCMDnBtG51DBiuRB4Mr5Pgs1qqN1ulv
 pREPh93lZTVd7bnoouxTujriJDmarMqiH2Ex007U0oJ3jjEfp2n6jJQ7p1g6qLZLvaXp
 Kv+VuLeexhOFhLt8nhuRzoNx5SXhLB/iKRBOtTdRzEwJkc6eVbilAPjDon3K3cT/jBRk
 0Gcg==
X-Gm-Message-State: AFuF++mFe8qjX83R9+GWWkYzyMweS0Jz1bXT3uXAq9k1g1rIcEmR/ddi
 XfYgWQu4alG04KsyQRnoV+N1O6RrcORTNIffNK9FM49/0ZDVVWaULD110Pyl9is2FM0DBpqeyEp
 P6BKPp05x2DMcXnB6dm6JbNrqYp0s7SI9BDb3Khy9
X-Gm-Gg: AR+sD11P1RkFzqOw2/PDPYegA9yBQx2iuDQV72TaY+eY7OZ5ZRsvTrHDSoC3Xfs45VG
 7FC9aw0vju1au1Nqol3VEAnjQdnhPt0T7LX/A6sRcC4SF0U+772c+AqF8+whE0xEfhLk8jLw6Ff
 Gp+myTt+XjZumsLfURuKwsx/HW0LJltoEZscTWdrfqMAHxaVZwDaYrZEwMCKLl7G4RPNW2AzF6U
 2hB5ZzivMR8dH1D47UQMEWbEkFOm8mhhiQIMqmoOgPSiyjjmE3MDUfZu4fXlu2w0e9TQcNIJKeR
 e+ZZwPsxSUFz3TNKRZStOVvmL8S+qB03LyyJI6sALIY=
X-Received: by 2002:a17:903:11c7:b0:2cc:864b:539 with SMTP id
 d9443c01a7336-2d60175df80mr204194495ad.6.1787229107252; Thu, 20 Aug 2026
 05:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260818175301.818739-1-valentinliu@icloud.com>
 <20260818175301.818739-2-valentinliu@icloud.com>
In-Reply-To: <20260818175301.818739-2-valentinliu@icloud.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Aug 2026 06:31:29 -0600
X-Gm-Features: AcwNN1XzwlLFUcvH4ygobU90UB-YO7v1Tx3SIpLN4ePSy0UPphB0tw4moA9G12s
Message-ID: <CAFLszTiPKoju6E60qq5G8m-Lb4h7r+B2SS8V-DjFOetYjyWi9w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] boot: android: Add AVB verification support for
 different bootflow.
To: valentinliu@icloud.com
Cc: u-boot@lists.u-boot-project.org, mkorpershoek@kernel.org, sjg@chromium.org,
 trini@konsulko.com, igor.opaniuk@gmail.com, alchark@flipper.net, 
 quentin.schulz@cherry.de, marek.vasut+renesas@mailbox.org, 
 daniel@makrotopia.org, rs@ti.com
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

Hi Valentin,

On 2026-08-18T17:53:00, Valentin Liu <valentinliu@icloud.com> wrote:
> boot: android: Add AVB verification support for different bootflow.

Drop the trailing period from the subject.

>
> The different Android versions have their own partition layout,
> so the AVB verification process should be dynamic.
>
> In the new verification process, we need to use the header version
> fetched from boot partition, so we need to check the boot partition
> firstly to avoid the downgrade attacking.
>
> If we didn't check boot firstly, just use it, the attacker can
> bypass the AVB verification by flashing a boot image with header
> version 3 or earlier.

Please use present tense throughout, 'first' rather than 'firstly',
and 'downgrade attack' rather than 'downgrade attacking'. I also don't
follow the security argument: priv->header_version is populated by
scan_boot_part() from the unverified on-disk image and is not re-read
after the first AVB pass, so verifying boot on its own does not change
which partitions the second pass includes - an attacker who can flash
a signed v3 boot image would still get init_boot skipped. Can you
explain what the first pass actually protects against, or is the
intent to re-parse the header from the AVB-verified copy before the
second call?

>
> Signed-off-by: Valentin Liu <valentinliu@icloud.com>
>
> boot/bootmeth_android.c | 43 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 5 deletions(-)

> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> @@ -479,11 +479,12 @@ static int avb_append_commandline(struct bootflow *bflow, char *cmdline)
>       return 0;
>  }
>
> -static int run_avb_verification(struct bootflow *bflow)
> +static int run_avb_verification(struct bootflow *bflow, const bool boot_only)

The const on a by-value parameter has no effect on callers and isn't
the style used elsewhere in this file - please drop it.

> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> @@ -493,6 +494,28 @@ static int run_avb_verification(struct bootflow *bflow)
>       bool unlocked = false;
>       int ret;
>
> +     /*
> +      * Always verify boot first.
> +      *
> +      * When boot_only is true, only verify the boot partition.
> +      * Otherwise, select additional partitions according to the
> +      * Android boot image header version.
> +      */
> +     requested_partitions[requested_partitions_num++] = "boot";
> +
> +     if (!boot_only) {
> +             if (priv->header_version >= 3)
> +                     requested_partitions[requested_partitions_num++] =
> +                             "vendor_boot";
> +
> +             if (priv->header_version >= 4 &&
> +                 priv->init_boot_img_size > 0)
> +                     requested_partitions[requested_partitions_num++] =
> +                             "init_boot";
> +     }
> +
> +     requested_partitions[requested_partitions_num] = NULL;

Please use BOOT_PART_NAME / VENDOR_BOOT_PART_NAME /
INIT_BOOT_PART_NAME instead of open-coded strings. Also 'n' or 'count'
would read better than requested_partitions_num, and the array bound 4
would benefit from a named constant or a comment for the boot +
vendor_boot + init_boot + NULL layout.

> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> @@ -562,9 +585,10 @@ static int run_avb_verification(struct bootflow *bflow)
>       return ret;
>  }
>  #else
> -static int run_avb_verification(struct bootflow *bflow)
> +static int run_avb_verification(struct bootflow *bflow, const bool boot_only)
>  {
>       int ret;
> +     (void)boot_only;

Can you use __maybe_unused on the parameter rather than a (void) cast?
That's the U-Boot convention for stubs.

> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> @@ -617,9 +641,13 @@ static int boot_android_normal(struct bootflow *bflow)
>       ulong iloadaddr = env_get_hex("init_boot_comp_addr_r", 0);
>       ulong vloadaddr = env_get_hex("vendor_boot_comp_addr_r", 0);
>
> -     ret = run_avb_verification(bflow);
> +     /*
> +      * Checking the boot partition firstly because the standard AVB
> +      * verification is rely on the header version from boot partition.
> +      */
> +     ret = run_avb_verification(bflow, true);

Grammar: 'Check the boot partition first, because the standard AVB
verification relies on the header version read from the boot
partition.' See my earlier comment - please clarify in the comment and
commit message what the first pass buys us, given that
priv->header_version is not re-read between the two calls.

> diff --git a/boot/bootmeth_android.c b/boot/bootmeth_android.c
> @@ -631,6 +659,11 @@ static int boot_android_normal(struct bootflow *bflow)
>       if (ret < 0)
>               return log_msg_ret("read boot", ret);
>
> +     /* Standard AVB verification */
> +     ret = run_avb_verification(bflow, false);
> +     if (ret < 0)
> +             return log_msg_ret("avb", ret);
> +

This re-verifies boot as well as vendor_boot/init_boot, so the boot
partition (which can be tens of MB) is hashed twice on every boot. Can
you split run_avb_verification() so the second call verifies only the
additional partitions? That would also avoid appending the same
androidboot.vbmeta/verifiedbootstate args twice and relying on
bootflow_cmdline_set_arg() to dedupe by key.

Regards,
Simon
