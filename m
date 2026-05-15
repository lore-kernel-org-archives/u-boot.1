Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C04ECD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 13:37:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9575846C1;
	Fri, 15 May 2026 15:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HTLveOA6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D463846C3; Fri, 15 May 2026 15:37:46 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BA008467A
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c80227b1f6cso4043074a12.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 06:37:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778852262; cv=none;
 d=google.com; s=arc-20240605;
 b=AlBJmyO1AuwG6XCZvAbn6AamTZzFpxn/lAYMWQGKgPaUGfhpKPs0Ix+ck5sK+OVaQz
 NKoH5KqRmfAFYl2yDQwTMxWPiCI7z9Jg5qNc8zoqvQpeEDxZ5C4kuQw5PMoyL9ULctZ8
 rseW6it32E9jvILcLYAEcUtVRrqQjncs6lxxHE1MOESghYKn3XQ7qBb+xy+RFhRjgnjW
 LMgvTeERDJE9wat8xKU/EJ2R2iRC3mnV0cMYMYMfjy1o9+VF4fK5XmPKTPZywea+MjSj
 qWiy3fJHtfQWHlmIAPzCU3/xZBqPs6qo0/esny349LaEE9AhavC3OiRCA2tJ32U0BWez
 n4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=i7gm1iC2R6s9gVzmQOZf0DCDbAaS5kttMcMJGuaXj1E=;
 fh=tQ6i/s4tFHAEvXuF+I3tvlNBIFMLDaoH3jqYWx+M1lc=;
 b=cDthcvw9gSsnlk+4tNHqFsydvPL6Xnr0sUfw0n+AbFrAmOIqY8/pi2tGHXE0u3q06l
 A3FyLuq4LV6gl/ML0U+zQ9nEejowLSC8jHny22gFOuemspIGaNOG0TITwwO2AocL6A22
 peSrVqow+4YOyqqiVxkiyXaXz+sk9+iT/UaF68GqvWrz9qpIaSycvEIalJax0chin52n
 /pIuPtruAPTWvT9IBzDQJJ7fbZcgIdF/YqJl+WgPCvQkgcpZFsklw7JIle4uvC0xtRvE
 mkTOJDLWaCC+p8IIfoC1bEfugJCo2abjA+81UPrkENR39fF5BKWvnQtK/yEhA7skXi4p
 6g7Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778852262; x=1779457062; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i7gm1iC2R6s9gVzmQOZf0DCDbAaS5kttMcMJGuaXj1E=;
 b=HTLveOA65EzX+CDg7n5x/WUTdFF979bpFUNHMWqgqqbKbGTW6Yjshkc56mEw5hsHNS
 tGFyobzeUpr0CB6E0Of0XTWwlDfd055J0dK2zomqPT0g5pj0FdTMJ06xxdByYjLkeTRt
 3CLzljybXXQ6ZqX6h7FlbBKrIRjlEhw9vBERA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778852262; x=1779457062;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i7gm1iC2R6s9gVzmQOZf0DCDbAaS5kttMcMJGuaXj1E=;
 b=PgE106Tf9rx/u4UWbzjlW5kPkl+xpHYsxePiaTZB3wjt5YOd2rzUmMTur0/dZOKa9F
 0Bj1buS4QtV2pENDbRWV3yv/0bXLn+Zz9d22vlelA346+av6mD1Ttw0tVqiicl45JS+W
 uGndvnsf0bF12JYI/lZhnkJhkTmrRl84mduF11H3QR0Cx6Ev90xlEffyBoQnXSGLkH+H
 EY+cBvnMMtuTgHe+7SYEVdOjTkxlch+sWKttTWFhye5E9DUUkqiaz03IBs+esmu9z57c
 WiSYEx5zG9CaQOSX/CNquMVNGYs0Eo8Fa+Clac4Pfj5VS+Kh2xSvyi8FMJJQGWsZy51w
 CKMw==
X-Gm-Message-State: AOJu0YxqZj7oxejLruhENovP5/6yqoHzoIAwenzZTGRv92vwIQxLmVHR
 pisL0o0gLw9ZJXWH23IOw3E2nCm1cKcbtI0T2qF/bqiqMBIfoOSWRlY5YgRePIDRqSHYtVd8Cqt
 WGwx5NpOUePZrFoWBwgFAvcKB8aqXanyq1Cz9BEmm
X-Gm-Gg: Acq92OFBxSsczsei/Nj/bSryacL30nBO5POqfWSm2DApZf9U0dhod6pvVszB74FeLuN
 FoyC7a/nrbzBxdkuaxgl3e1Qo9kD/3AvfvK2/VOBhglJyZiNv5pD70NvP9QmPMkQnMTkg3UjRSE
 ouRJ08aQp513LqaX6wGiLVeTSdjSgU+GrYE3rEDWSapxMGKJe7e64o1hLRd6o6n6hKlKeC/prdL
 qiLwmsi+IaBgHGQ9d+7kS2vE7vPO0cDufFRlzwPJvOWr2WWJqjpR3ywpsi3vQ4/dDWlb12xFE06
 hkPAoA==
X-Received: by 2002:a05:6a20:3d93:b0:3a0:b781:4c80 with SMTP id
 adf61e73a8af0-3b22e648408mr4761389637.4.1778852261670; Fri, 15 May 2026
 06:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260513141027.351280-1-ludwig.nussel@siemens.com>
 <20260513160816.v4.5.eb9898db9115ab0e26701a962ff8b41b199e78b2@changeid>
In-Reply-To: <20260513160816.v4.5.eb9898db9115ab0e26701a962ff8b41b199e78b2@changeid>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 07:37:25 -0600
X-Gm-Features: AVHnY4JVQ04p1WhjA68PK3UYwM1d9MDohOjEPHaWf_CDEpRCGJ2eF1WXsyBCQ2s
Message-ID: <CAFLszTj=FhNwbHzKRRiwLijQGYxL_tv0Qcm25ouUSGZ_HCNAQA@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] iminfo: also verify signatures
To: ludwig.nussel@siemens.com
Cc: u-boot@lists.denx.de, Ferass El Hafidi <funderscore@postmarketos.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Shiji Yang <yangshiji66@outlook.com>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Yao Zi <me@ziyao.cc>
Content-Type: text/plain; charset="UTF-8"
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

Hi Ludwig,

On 2026-05-13T14:08:10, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
> iminfo: also verify signatures
>
> The iminfo command already verifies hashes of images. This change
> also verifies signatures of configurations if enabled.
> If FIT_REQUIRE_CONFIG_SIGS is enabled, iminfo also fails if
> signatures are missing.
>
> Adjusts error output slightly to be on stderr
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> boot/image-fit.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  cmd/bootm.c      | 10 ++++++++++
>  include/image.h  |  8 ++++++++
>  3 files changed, 71 insertions(+)

> diff --git a/cmd/bootm.c b/cmd/bootm.c
> @@ -335,6 +335,16 @@ static int image_info(ulong addr)
> +             if (CONFIG_IS_ENABLED(FIT_SIGNATURE)) {
> +                     int ret = fit_all_configurations_verify(hdr);
> +
> +                     if (ret != 0 && (ret != -ENOENT ||
> +                                      CONFIG_IS_ENABLED(FIT_REQUIRE_CONFIG_SIGS))) {
> +                             unmap_sysmem(hdr);
> +                             return 1;
> +                     }
> +             }

The point of the inline stub you added in image.h is to let the caller
drop this guard. Please remove the outer
CONFIG_IS_ENABLED(FIT_SIGNATURE) wrapper - when FIT_SIGNATURE is off
the stub returns 0 and the body falls through.

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -1512,6 +1512,59 @@ int fit_all_image_verify(const void *fit)
> +#if FIT_IMAGE_ENABLE_VERIFY
> +int fit_all_configurations_verify(const void *fit)

The header guards the prototype with CONFIG_IS_ENABLED(FIT_SIGNATURE)
but the implementation uses FIT_IMAGE_ENABLE_VERIFY. They coincide for
target builds, but please use the same gate on both sides -
CONFIG_IS_ENABLED(FIT_SIGNATURE) seems right since this is
target-only.

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -1512,6 +1512,59 @@ int fit_all_image_verify(const void *fit)
> + * Return:
> + * * 0, all configurations have valid signatures
> + * * -ENOENT, no signatures found
> + * * < 0, -errno
> + */

'no signatures found' is misleading... -ENOENT is only returned when
the /configurations node is missing or empty. When configurations
exist but none carry a signature, fit_config_verify() returns 0 and so
does this function. Please reword to 'no configurations found',
otherwise the iminfo caller's special-casing of -ENOENT doesn't mean
what a reader would expect.

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -1512,6 +1512,59 @@ int fit_all_image_verify(const void *fit)
> +     /* Find configurations parent node offset */
> +     confs_noffset = fdt_path_offset(fit, FIT_CONFS_PATH);
> +     if (confs_noffset < 0) {
> +             log_debug("Missing '%s' node: %s\n",
> +                       FIT_CONFS_PATH, fdt_strerror(confs_noffset));
> +             return r;
> +     }

fit_all_image_verify() above uses printf() for the matching "Can't
find images parent node" error and it is visible by default. Hiding
the equivalent here behind log_debug() means iminfo silently succeeds
(or silently fails with FIT_REQUIRE_CONFIG_SIGS) without telling the
user why. Please use log_info() or at least log_warning().

Regards,
Simon
