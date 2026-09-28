Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6BFCA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 17:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEE1D80D73;
	Mon, 28 Sep 2026 17:12:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tpADpSSG0kDM; Mon, 28 Sep 2026 17:12:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 12D0F80D63
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790615571;
	b=NCffSjtuvxucDc0CTEVmJfLvK9Zcj+3FBpE1cTZeJl0K4p6xu/LmSwB/Z9TUo2dFyeNM
	 Hadu08gwscXYrbnAgUieGT73lqYvThcckWNCPwv3dovFPSRNBsJhrfLyqHFAbj+B7SOjA
	 gW0nhQQ1x3Obl1tAmq9DRWNV8dneP3gqOJSgzUazs+rKNgjfhq0ak4N2GfTi+vFjpJgnt
	 AQR23n+blqDY5Rn0tTdspOt7JxxhXUln1qA2xai8EegW239okITTiLxmV73q0G1F/nXmz
	 50E2X2dWUGi/uJ//l7MVn+qPYFNVUv1uGNCDfDH/LMM0TvehGQYPJObdzzETq2XpflA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790615571;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=g4eP2lJ8+3kRzyYzN079Y9Ynp5tm8K3oc6Q0BkKaUm4=;
	b=FoYA57cTdlZYVTdItA2R9dOrvX1LVtKpyp1t6YGxcp9QCQZbchsI1Iu7dHR9HSNVkh4u
	 11v/rmlmeyU7eApVfBkSXtUyoDDBGI1lI6lyjD8e/yIQ9CBnQ5OFz6f2AXDyM3wFHBG3k
	 rTApVhxyPzABRN4Y5JN1iVoeNfPh1RK7kKsJ/PO0kb7GyDlXXywk6o7flmRs7lM3T8eVV
	 23XGhnfAS8rZRv7jP/hHOhlXDDnz0MnM7hh46rYA4NkHAhj5hYkCBXgA93rscUcY+b+aH
	 iL7iT5FNDgEjQ1desJz25nm0xOO3WGsWSTN77I/EA3IVYYzrlST48RwfnxGXKk+kVAw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790615571;
	bh=g4eP2lJ8+3kRzyYzN079Y9Ynp5tm8K3oc6Q0BkKaUm4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FXl+NqdUCMELgzY3vtcGqGtawRj+6e9EaTOF9VadzbdD27AAjK0JrLemZPJKohvTy
	 41M4NEgKOQ/beqHUBUskX0MHdybu8lufftaM5pW/J9WiuA3Av3x1YenpO6Hgf2MXWh
	 YjidhUWu9euNOITE0pGKldnaJjU5e3PDCePbQmoj+8UAMy6hHOW2iwMQpv7+V/LRUI
	 7EZEhxSFnYL4VwFB7JDIwzUoRdf0JnZeo8hepdISz5MCXpp4eOuqh35la8GJFfTZaE
	 rVU6Pa4+hmInzZ7LUm6qNiauYd92gvPphz24tskGf7NKNjYBRuay/u8PuQlCzhZ6dZ
	 hy+eD/HuDXKNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 12D0F80D63;
	Mon, 28 Sep 2026 17:12:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A7DB972
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:12:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 995C740553
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:12:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9QCl-lhEs6aK for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 17:12:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6BB2A40552
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790615568;
 b=GbY3yCO1RsdUjGTHuPaiw90z77T8yVnACcA4nQRidRg8lUqT9b7HA4ZgpN5m+gspeS7r
 d1+bpYqVirv5Wuz0FSokMLz/cRFAka2/MwLtpwqbXhg19zv5GtR1+EBjZWd7CUlYyQZ5A
 Ug4khnL/VN8qzyHEkfDPN9R57NjjYVFifYumgZTG+YgIbnUMLj5Wgr2f75TyA8/gpcPpt
 T2eqRPxeiB2kPcFotJyXk/a+YHaPd+dBW3fESQ3fO8fOEsMO5vDUmHpaq4FadU1KL8lIg
 mRGfkjyscZpKsBcGZsyc8F91mSATnIzq8Ik2yb0yNAAfOqffzBPOJXEW8Xrm7TVq9sw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790615568;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=g4eP2lJ8+3kRzyYzN079Y9Ynp5tm8K3oc6Q0BkKaUm4=;
 b=n9IvyDL5OIXahLfjRU6r/3vR6n5izCSVQrn4QOxgPtj+THUc2tTRWH7RlAF3KOyKexv1
 g7qkdZlRPWEAb+W+NZd4LTexh3dJttbvjP/UwO359Ut6TLdP7DQSUghtTuqjJPjnJ+2ux
 +LHW1ljJuw2Pi9cc7pMTYCq/94vXEZTLA4C/7XbvBauTouurMR5c5Jr7e9iuVFhid0pIp
 8bGcEAsq0JinS+dDIWAsV8VFHIB5DGgXUb0Ct8m+3+Kt4WgUPDI48OSr4z3mWqywZIf2t
 S20KjRJNkepYB2bUTURe8k9BmGSv2IsfXbUDTeDBvQmWUFmsePfrwv3XfN00Y4NylPA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hn7T84rI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=hn7T84rI
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6BB2A40552
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:12:48 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a996c8adf3so5306493a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:12:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790615566; cv=none;
 d=google.com; s=arc-20260327;
 b=I4iJ1rkiMdaBM4G4AhsQ/vASpv4GV9X56isrCpZYCMGgO8c6qeEoWdXc02x6/686VQ
 F7ax9/VRIr2zqznvM+nZqlsmibxicLKVqHI1sH14p7DKhvR3iO2ZWqOddohzZATPEQyc
 yrnoLaycZZikex7OUNTDAbQynHev9D7kAI/ozchWK+RIZbyGMndk5oGSceH1WCSjipdE
 kcazNOZ64/jDpf784O8XjR2eaN4o/gMDwVmSfJ2dfHxNmGfKqbKlxzaEdor1hmw38/Jr
 8gLSNx2ROk+ROqBTIKdWIaTXDQjgJxEhXcRkIwROEq3pXsWMOm6fWMkc/WRF4qD37MWJ
 iUdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=g4eP2lJ8+3kRzyYzN079Y9Ynp5tm8K3oc6Q0BkKaUm4=;
 fh=durgfX1b4/1SnC3pJJVYM3Gc1F35eR4yNe+Lv0h5pxA=;
 b=U02ph6wCN7Q1AEXmK+n1TpYzsq2mdEywiyLOXorIMoiIZoEr75ZrpsUzxwiqP7UlUT
 4M/q7u+Rx4Rvm25sbj/MEMqrM1sw1t5aNryI11nHNvxKdLTX/ntV7CvqV3j4peARItA2
 QWZeKSbf/0KIoxAnpMtbOhAyDDN01e3ln+jDRbZwzOoocfRXw6TjWr9T7eT8KzqHDk73
 3V6DwfCf6FJAHiCyBrrHF7TNAo+Rk9slHl09OAz1+EOWYiuLeg4ZoQNtW/W3+tfiFo4d
 0vgtpEriFhV1yMyj0L9uGcmRmTIoLHCWCkwF0PNDgKIWioa1mjrq9IIBMavo+aKGUSJ+
 8ZnA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790615566; x=1791220366;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=g4eP2lJ8+3kRzyYzN079Y9Ynp5tm8K3oc6Q0BkKaUm4=;
 b=hn7T84rIt615+oUvpA5KtlWQ7vLd/OOGGL7ON7n2+Uli0FvhUevhIXwpc+oQA2ZpH9
 iKG18Ez3ttV7CJtkI7Lh/81e7RCZ6UJdBArVWkE63vG3CEpS3I4BzARZ0woKhQZ174lh
 K66bvG7LXeF8DiqLA5VnInGDDCSEywLNXlRmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790615566; x=1791220366;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=g4eP2lJ8+3kRzyYzN079Y9Ynp5tm8K3oc6Q0BkKaUm4=;
 b=h3nsbMKXrQh54hAweGAO02hGpe33YtO6SQ6CXi86/7ejXJSV95AOki4Dfp7+LxUzML
 avrQS9ONoL+pQQBI+W4GoQFp6VkxtNXBkKM0MMxJhlLrwPHcWBXSZw58xxHPL8HUEiiJ
 eG2tj3t+9K8gKQnXQb/xNd+mIuouq7xtiVsW7GTZXLyz4eIbNLDWw86Y4nMZtHtywd3F
 G90qW0bdg8C3fb8b9Gvf00+Fq9kwaRN7/V6rnsz5UZsAAr49SA82yLgS4Q2yg+RgUW/a
 kW2dXTFABYstO8QdrbE1Ky87CNZo27LIAsSAoBtliGFRHZuvIeSQ1OoV11nki0PPzMPh
 NlYA==
X-Gm-Message-State: AFq9FYIjgAt+M6b1DcKbAc5pgJqVBWsG2bC4JtI9INuBtYQKB8d34biq
 bq5amZ/GBtAsM5P119X1B2znsAue+5q2h6zKZefbwU2cctbrT3hR4x/pDWbQd71vL9bb9vPWmhs
 WCx1gKMGFlrKHxmJiG0586Ui87NcMOMk2t3+PRoYi
X-Gm-Gg: AYBFou0ufIE6+T3lMVwwyb/3Wgz+6JzU3lO6j9ZHfNTPKYq5WueFOc9HK3OngwC8vyx
 WNkQOLBX3MAzKUHRqmCEKQVNL9a1tO3XLUkRvgEK8SBarj1TebEXooEAdqA2bnpb4ruTwgOs7C9
 Km1kH4ZZSVD6lqSJ7rcXJyg1K8fZ/opfK2s1Aef1PEPbMixrRUVGdBqXJNAS5trMe8TbSyQtste
 9/s95b/QI5lcNv9Bgv+jf8h1fAZbb6tyvJFgRbgxxhk9BX9GURAZmZAGz7G9n1qlPYPHLg++ozk
 OW+09iMixlPQaX1bPxJATrBjoMm3ZxLoxm33Jg27tfeF0id/XBZ5Iow=
X-Received: by 2002:a05:6402:322a:b0:6ab:6f77:c4eb with SMTP id
 4fb4d7f45d1cf-6ab6f77cc0cmr4931839a12.37.1790615566098; Mon, 28 Sep 2026
 10:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
 <20260903-ccaione-upstream-ebbr-v3-2-016658d0b6ba@baylibre.com>
In-Reply-To: <20260903-ccaione-upstream-ebbr-v3-2-016658d0b6ba@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 11:12:32 -0600
X-Gm-Features: AclHuK9EETHy8HtzbkeXQgKpCKuNotTfrSoPaQfXCYjvDJKJrt_SB6hlXhD3cdE
Message-ID: <CAFLszTgRt8_+po48Muhhosm1BdGET-GgfoNkyW5HPucudyS+JQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] boot: add a firmware-owned devicetree source
To: ccaione@baylibre.com
Cc: u-boot@lists.u-boot-project.org, Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Johan Jonker <jbx6244@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Randolph Sapp <rs@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Aristo Chen <aristo.chen@canonical.com>, 
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>, 
 Peter Robinson <pbrobinson@gmail.com>
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

Hi Carlo,

On 2026-09-03T13:09:47, Carlo Caione <ccaione@baylibre.com> wrote:
> boot: add a firmware-owned devicetree source
>
> Platforms following EBBR / Arm SystemReady DeviceTree keep the
> devicetree in firmware-owned storage, updated independently of the
> operating system, rather than shipping it in the OS image. U-Boot has no
> generic way to source and assemble such a devicetree.
>
> Add a firmware-FDT uclass which loads a FIT through a storage backend,
> selects and verifies one configuration, and assembles its base DTB and
> overlays. Each backend supplies the FIT while selection, verification,
> assembly, caching and consumers remain storage-independent. Require
> exactly one enabled source device.
>
> Implement the first backend, 'u-boot,firmware-fdt-block', which reads the
> FIT from a filesystem on a GPT partition of a block device:
>
>     firmware-fdt {
>         compatible = "u-boot,firmware-fdt-block";
>         firmware-fdt-store = <&mmc0>;
>         partition-type-uuid =
> [...]
>
> MAINTAINERS                               |   3 +
>  boot/Kconfig                              |  49 +++++
>  boot/Makefile                             |   2 +
>  boot/firmware_fdt.c                       | 303 ++++++++++++++++++++++++++++++
>  boot/firmware_fdt_block.c                 | 143 ++++++++++++++
>  boot/image-fdt.c                          |   3 +-
>  boot/image-fit.c                          |   9 +-
>  doc/develop/uefi/firmware_fdt.rst         | 118 ++++++++++++
>  doc/develop/uefi/index.rst                |   1 +
>  doc/device-tree-bindings/firmware-fdt.txt | 160 ++++++++++++++++
>  doc/usage/environment.rst                 |  13 ++
>  include/dm/uclass-id.h                    |   1 +
>  include/firmware_fdt.h                    | 106 +++++++++++
>  include/image.h                           |   5 +-
>  14 files changed, 912 insertions(+), 4 deletions(-)

> diff --git a/boot/firmware_fdt.c b/boot/firmware_fdt.c
> @@ -0,0 +1,303 @@
> +     /* Verify overlays too, since boot_get_fdt_fit() can skip a bad one. */
> +     if (!fit_all_image_verify(out->fit))
> +             return log_msg_ret("verify", -EACCES);
> +
> +     if (conf && strchr(conf, '#'))
> +             return log_msg_ret("chain", -EINVAL);

This only looks at the environment string, so it could go at the top
of the function, before the FIT is read and every image is hashed.
Then a bad selector is rejected without any I/O.

> diff --git a/boot/firmware_fdt.c b/boot/firmware_fdt.c
> @@ -0,0 +1,303 @@
> +     out->fdt = fdt;
> +     out->size = len;
> +     out->name = filename;
> +     out->fdt_owned = fdt_owned;

When fdt_owned is true the assembled devicetree is a separate buffer
and the FIT (up to FIRMWARE_FDT_FIT_MAX_SIZE) is no longer needed, yet
it stays in the cache for the rest of the boot. Could you free
out->fit in that case and only keep it when the devicetree still
points into it?

> diff --git a/boot/firmware_fdt.c b/boot/firmware_fdt.c
> @@ -0,0 +1,303 @@
> +     memcpy(map_sysmem(fdt_addr, fw.size), fw.fdt, fw.size);
> +     *fdt_sizep = fw.size;

Just to check, the existing bootmeth path reads the ESP devicetree
through fs_read(), which goes through the LMB check when CONFIG_LMB is
enabled, so a reserved region is not overwritten. This memcpy()
bypasses that. Perhaps use lmb_alloc_addr() (or at least document that
the caller is responsible) so the two paths behave the same? What do
you think?

> diff --git a/boot/firmware_fdt_block.c b/boot/firmware_fdt_block.c
> @@ -0,0 +1,143 @@
> +#include <vsprintf.h>
> +#include <dm/device-internal.h>
> +#include <linux/string.h>

Nothing here calls device_probe() or the other internal functions, so
device-internal.h can be dropped.

> diff --git a/boot/firmware_fdt_block.c b/boot/firmware_fdt_block.c
> @@ -0,0 +1,143 @@
> +     ret = fs_set_blk_dev_with_part(priv->desc, part);
> +     if (ret)
> +             return log_msg_ret("fs", -EIO);
> +
> +     ret = fs_size(filename, &size);
> +     if (ret)
> +             return log_msg_ret("size", -EIO);

This is essentially fs_load_alloc() with a blk_desc instead of an
interface/part string. Could you build the '%d:%d' string from
blk_get_uclass_name(desc->uclass_id) and desc->devnum and call
fs_load_alloc(), rather than duplicating the size-then-read sequence?
It does the max-size check for you too.

> diff --git a/doc/device-tree-bindings/firmware-fdt.txt b/doc/device-tree-bindings/firmware-fdt.txt
> @@ -0,0 +1,160 @@
> +For the block backend, a standalone node points at the media device that owns
> +the partition by phandle. The node may live anywhere in the control devicetree;
> +a node with status "disabled" is ignored. Exactly one firmware-FDT source may

Not quite. Driver model only binds children of the root node and of
nodes whose driver scans its children (e.g. simple-bus), so a node
under an arbitrary parent will never be bound. Please can you say it
should be a child of the root node (or of a bus which binds its
children)?

Regards,
Simon
