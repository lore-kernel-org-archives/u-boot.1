Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374FE606A32D
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 10:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dUAstlEc;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VjzK1+q7
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 121FB607E0;
	Tue, 24 Nov 2026 10:01:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MEqmMl7jgpqG; Tue, 24 Nov 2026 10:01:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 294306070D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795514473;
	b=kC+3xVVJ381c7DeATtS4ujDuETd/emwYHoczZtUiq4fKVki7wofFBAoVIfD9J+Ja64X7
	 nzZ94p4DnRDqVQcC+cWif8Ztefdkt24mZ116EIQ0y6yJgVz/VCCm+zYLy40fhPyE47Gxo
	 JXo4H2wv1mToGC4uj36lyduno6YHvmuWkorVLg6hKoYPvszK8R2JgCq2rB8G+yXemxNjM
	 XvKLfiwZFCFIV6DDUsXu+FMsR6KiiQuzqsnaTXV1pbVRjx/8WsMpbQ2vxUXcuLjPfkAxR
	 0TDxu5tCBtgDdU4bPn1ZYlx5JGKh3mDNpzm7C/ixbaO+iBk96TZBsHC03j+FSy8vCPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795514473;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WL4kz0559a31+ZFE28jslvZ1uQLDZ4fQNwUJyTDTYMk=;
	b=ZwPEnuyktpY2/HjAxMPMb/XQskNkRnHDgzM3YrW2BHWZV6HTM7V5RItFdYkIEouWrLEF
	 Qp1mbTl++s0HAaFKNX6URyiqUq/VWJLDEq76kgRfXGJsBWGgd1AJwQsIiKpKyD8+wbrK7
	 BJAReiyongwVsiUOypfCuBgqR5R7eVIgMVU8igdtGdygJxlmY3Bhvu2gbjTdu5mYF7i8R
	 0PpfqRs3j++8vS956D+iaoWRkt2vR3WKW5DIgAbVmUoukG9MhKpqkk9VrkpSSjp3qWUu8
	 SpLUeL0GNBedErCQMNc8d1IfY/TkjPGgZ680ZmhkN5mcON80KJbIJCaOvpYWxTWS1Gw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795514473;
	bh=WL4kz0559a31+ZFE28jslvZ1uQLDZ4fQNwUJyTDTYMk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dUAstlEccvMnjdRBDy1dkBkjXp7wc/209mookRYMome7NJGDNFibI4bMSqkvfgklm
	 1Ewrh3on+Z/sXaSbziYeRQKC8M9d4D0oXL70qmMlis4rImGsJSNorTI04TtpdOyxww
	 iLu/2F4Tbu9cD7Z/qYzyhfqqFti6KXPT3PWqcMF6Fj+JjV2rtp9ySp9mpcmZLmYb/S
	 /TD9yq1W00+Ub0XGX0HpjbUlHPvoiJv5q84pZ67pYw4C3SNFqyK1oRsPJlbgUepSqt
	 07llp151oh/uBgpOTCyqh+buVieWAm0+Uy0gixaaHEgAxd3CGdcFWYiUe3zsIKGBe3
	 759csvLxoqtEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 294306070D;
	Tue, 24 Nov 2026 10:01:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AC221C9
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:01:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 00DAB80F52
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:01:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GGBTiq43sHLd for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 10:01:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E58C880E6B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b129; helo=mail-yx1-xb129.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=VjzK1+q7
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E58C880E6B
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:01:10 +0000 (UTC)
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-677bc4704cbso5014808d50.0
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 02:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795514469; x=1796119269;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WL4kz0559a31+ZFE28jslvZ1uQLDZ4fQNwUJyTDTYMk=;
 b=VjzK1+q7mAyY1K4mRRddXl2SHyj8UgUzNqYmVVATr8PKoKh8cibSQ+6zZu89dG+8ef
 z28q1O4vfHB7HaGB9zko0bE6+b7lM5I6ma0nZJxDe5HvGf8EbsLWkdP8FO6YqnD7YQJg
 IQ1x9ztCXLCi7g9OtJTmpO7wqe32PD76rR40EJS/3Ae942ntsyP8Ps5P3pwK3EhYBcaj
 jnHjksuS8UQfb3agoYzrphNKQm0utDSKAQNZcd1UVroM15wnPCy9T67yJY7dNT6mkfDZ
 iDtdRzhIJbnsjGkYvwohXFc7y7xaW+l6X8rCX7Ws8vYxQs/7UD5ywlN/wDwPooxknNpy
 TpCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795514469; x=1796119269;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WL4kz0559a31+ZFE28jslvZ1uQLDZ4fQNwUJyTDTYMk=;
 b=XCA5GTqqBh/ozSLwYCPA3ufyHWCbM7iARFMn9QWsLT4AyOGgUamsVnV9pnT9WQxF9E
 jcJhMyiukbDppzijLV8C8F76VelrZ7U2vZTayhFp4Mjx9H8ZAgq6FjEbTUTJGzdYn+t7
 21uv52fVDP34sg6hv+p8Qcy6fltJvcL6oYKhMjXD8aWdaNpVsXutBpHRTb/d7Pr5a6Ee
 LmA2nUwLkut+Z5PCTl79fDsbfiz/OtbEM6vxLZqtm79bGvd/4T0r9OwMSSGqg1iVHSIa
 oYpNQ9Q6Mngj2u1/AHlFdCJSolQcQehEvIC67gzfPfTOQMOkK/7buMxmCJRLnQpI1eAX
 Pk4g==
X-Gm-Message-State: APuU4Z8cNiVtKD2uYbv+wurEbndBt6ighXGMz5V9ao27fDZHkupoTo+f
 CMGCXEGeEOCCv5Mulur8To9M725Kq/FXzF6GrTedYzOUq9wUbOBrUeMQHYwJ/dru1KSOuA76isJ
 b/oEz9tPIkUn13NiKThjL9b47WeG8atFdLrhclNXbPA==
X-Gm-Gg: AZFdTZdA+KYiQ4B/JpuAOJH7Lh8QoSGU8nJPT7NAkbLrr+tKD0VPLPd08LMolJXN9Jr
 ONmrbo/ny9RoKc1ivgf7Tdf8/srue6nGUoRljPpmr40RRL2QECNsTSrakpXFWjJcgNLhY64HjxA
 rCd0wU7/kzbyIfUgy43nmwTFPluoJiZkYqtpDoxxPO16L5rFJVhsLSF4zTNdMsAaMLskLQ6Bse4
 uqio1kNLODp2oF9c28kRA3FkBQhgCSDsttTZFF5pLjcPqJqew4n2b9SLqCCu/PV7TP86jMDRngH
 PZYIzKFXB4haueiq4g3zEoplEU9Qet7ySyP7XMBLH2wWuD1kr/eNnRdU0E1CLu5H2smacWtrJ7f
 Mz2tcihfwIFs8rGkDwfXorwdXVVsPpJOmZ8O3dPya2VcKOSHyOfxH+dShKDfNUUXech226EHY2F
 gfeWj4+3DviEsYHbbN1t/ePmTejfgpE/lJuw9K39dNrALO4tU/VAdD4j/hyv3KdIHJLZchxQyN1
 E6rOJ7wXAvej8aLeJN8A//us/CSAeCEjyAeVNK1csEYG4u8InfUKXNA/yKpt9Zjlxv0b43MzcPg
 lAqRjyWVmyWP0RyHAvNUlL7ACb8nGXu46b0Q+qOoK94eNok53An3mZrj2Q7sxYqyD65rzpDOzk7
 C8dnCe7oCTzf6XPBsMq9Jx96hnN59nWyLDTZ1lqR8iGoyi9zL/X3V2P08qLKaQhw2aTbiHtjoMf
 XacRvff6h9eMy/4jSppiPOsz/dGLFwOGHnDQ2/AxsgWpPpGHDK9AVDg+Q6T8HOa3RR1I6blMUs3
 fjMiAdauNdhOLP/5iVorg==
X-Received: by 2002:a05:690e:d5b:b0:67c:cd5:f5a3 with SMTP id
 956f58d0204a3-67df447a918mr3611633d50.109.1795514468869; Tue, 24 Nov 2026
 02:01:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261123-qcom-capsule-dynamic-fw-images-v3-0-b665b48e0de2@oss.qualcomm.com>
 <20261123-qcom-capsule-dynamic-fw-images-v3-1-b665b48e0de2@oss.qualcomm.com>
In-Reply-To: <20261123-qcom-capsule-dynamic-fw-images-v3-1-b665b48e0de2@oss.qualcomm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 24 Nov 2026 12:00:32 +0200
X-Gm-Features: Aa3M54peXoRLjXDgPlMbBlHCYHAeU5z5XJyNSLXWtrHG9I91t7rKWQUZJceXqdw
Message-ID: <CAC_iWjKwOwpOJvcTt_cOfq+e-TaAEJxSencv+wKf4XP6zbZxBw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] efi_loader: capsule: allow platforms to map a
 capsule to an image index
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, 
 Mario Six <mario.six@gdsys.cc>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Hem Parekh <hemparekh1596@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 at 06:54, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
>
> efi_capsule_update_firmware() passes the UpdateImageIndex from the
> capsule to efi_fmp_find() and set_image(). This only works if the
> platform's image_index values are fixed when the capsule is built.
>
> Add a weak efi_capsule_resolve_image_index() that returns the index to
> use, defaulting to the one in the capsule. A platform that discovers
> its images at run time can override it to find the image by type GUID.
> The lookup happens before efi_fmp_find().
>
> Add a sandbox override and a signed capsule test whose image index
> doesn't match any fw_images entry.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v3:
> - Use an unused filename for the new test capsule, Test13 was already
>   the signed FIT capsule
>
> Changes in v2:
> - Added newly in v2
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>  arch/sandbox/dts/sandbox_capsule.dtsi              | 15 ++++++++++++
>  board/sandbox/sandbox.c                            | 13 +++++++++++
>  doc/develop/uefi/uefi.rst                          |  5 ++++
>  include/efi_loader.h                               | 14 +++++++++++
>  lib/efi_loader/efi_capsule.c                       | 14 +++++++++--
>  .../test_capsule_firmware_signed_raw.py            | 27 ++++++++++++++++++++++
>  6 files changed, 86 insertions(+), 2 deletions(-)
>
> diff --git a/arch/sandbox/dts/sandbox_capsule.dtsi b/arch/sandbox/dts/sandbox_capsule.dtsi
> index 34d29916b30..af994373c27 100644
> --- a/arch/sandbox/dts/sandbox_capsule.dtsi
> +++ b/arch/sandbox/dts/sandbox_capsule.dtsi
> @@ -104,6 +104,21 @@
>                 };
>         };
>
> +       capsule7a {
> +               filename = "Test116";
> +               efi-capsule {
> +                       image-index = <0x7>;
> +                       image-guid = SANDBOX_UBOOT_IMAGE_GUID;
> +                       private-key = CAPSULE_PRIV_KEY;
> +                       public-key-cert = CAPSULE_PUB_KEY;
> +                       monotonic-count = <0x1>;
> +
> +                       text {
> +                               text = "u-boot:New";
> +                       };
> +               };
> +       };
> +
>         capsule8 {
>                 filename = "Test12";
>                 efi-capsule {
> diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
> index 13006a0ffc2..8844f59e4c5 100644
> --- a/board/sandbox/sandbox.c
> +++ b/board/sandbox/sandbox.c
> @@ -57,6 +57,19 @@ struct efi_capsule_update_info update_info = {
>         .images = fw_images,
>  };
>
> +u8 efi_capsule_resolve_image_index(const efi_guid_t *image_type,
> +                                  u8 capsule_index)
> +{
> +       int i;
> +
> +       for (i = 0; i < update_info.num_images; i++) {
> +               if (!guidcmp(&update_info.images[i].image_type_id, image_type))
> +                       return update_info.images[i].image_index;
> +       }
> +
> +       return capsule_index;
> +}
> +
>  #endif /* EFI_HAVE_CAPSULE_SUPPORT */
>
>  #if !CONFIG_IS_ENABLED(OF_PLATDATA)
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index 94ddf690440..0e1641122dd 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -503,6 +503,11 @@ on the FWU Multi Bank Update feature, please refer to
>  When using the FMP for FIT images, the image index value needs to be
>  set to 1.
>
> +A platform that builds fw_images at run time can override
> +efi_capsule_resolve_image_index() to map the capsule's image type GUID to
> +the image_index of the matching fw_images entry. By default the
> +UpdateImageIndex from the capsule is used as is.
> +
>  Finally, the capsule update can be initiated by rebooting the board.
>
>  An example of setting the values in the struct efi_fw_image and
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 7b865fe900a..1d3e2cf1348 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -1238,6 +1238,20 @@ efi_status_t efi_ecpt_register(void);
>  efi_status_t efi_esrt_populate(void);
>  efi_status_t efi_load_capsule_drivers(void);
>
> +/**
> + * efi_capsule_resolve_image_index() - get the FMP image index for a capsule
> + * @image_type:                image type GUID from the capsule
> + * @capsule_index:     image index from the capsule
> + *
> + * The default returns @capsule_index. A platform whose image indices are
> + * not fixed at build time can override this to look the image up by
> + * @image_type.
> + *
> + * Return:             image index to pass to efi_fmp_find() and set_image()
> + */
> +u8 efi_capsule_resolve_image_index(const efi_guid_t *image_type,
> +                                  u8 capsule_index);
> +
>  efi_status_t platform_get_eventlog(struct udevice *dev, u64 *addr, u32 *sz);
>
>  efi_status_t efi_locate_handle_buffer_int(enum efi_locate_search_type search_type,
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index a77810fa15c..f5f4cab3613 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -517,6 +517,12 @@ static __maybe_unused efi_status_t fwu_post_update_process(bool fw_accept_os)
>         return ret;
>  }
>
> +u8 __weak efi_capsule_resolve_image_index(const efi_guid_t *image_type,
> +                                         u8 capsule_index)
> +{
> +       return capsule_index;
> +}
> +
>  /**
>   * efi_capsule_update_firmware - update firmware from capsule
>   * @capsule_data:      Capsule
> @@ -543,6 +549,7 @@ static efi_status_t efi_capsule_update_firmware(
>         int status;
>         uint update_index;
>         bool fw_accept_os;
> +       u8 image_index;
>
>         if (IS_ENABLED(CONFIG_FWU_MULTI_BANK_UPDATE)) {
>                 if (fwu_empty_capsule(capsule_data)) {
> @@ -615,9 +622,12 @@ static efi_status_t efi_capsule_update_firmware(
>                         goto out;
>                 }
>
> +               image_index = efi_capsule_resolve_image_index(&image->update_image_type_id,
> +                                                             image->update_image_index);
> +
>                 /* find a device for update firmware */
>                 fmp = efi_fmp_find(&image->update_image_type_id,
> -                                  image->update_image_index,
> +                                  image_index,
>                                    image->update_hardware_instance,
>                                    handles, no_handles);
>                 if (!fmp) {
> @@ -650,7 +660,7 @@ static efi_status_t efi_capsule_update_firmware(
>                 }
>
>                 abort_reason = NULL;
> -               ret = EFI_CALL(fmp->set_image(fmp, image->update_image_index,
> +               ret = EFI_CALL(fmp->set_image(fmp, image_index,
>                                               image_binary,
>                                               image_binary_size,
>                                               vendor_code, NULL,
> diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
> index a500c499bb9..07a14105d01 100644
> --- a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
> +++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
> @@ -190,3 +190,30 @@ class TestEfiCapsuleFirmwareSignedRaw():
>              check_file_removed(ubman, disk_img, capsule_files)
>
>              verify_content(ubman, '100000', 'u-boot:Old')
> +
> +    def test_efi_capsule_auth6(
> +            self, u_boot_config, ubman, efi_capsule_data):
> +        """Test Case 6 - Update U-Boot on SPI Flash, raw image format
> +        0x100000-0x150000: U-Boot binary (but dummy)
> +
> +        The capsule image index does not match any fw_images entry.
> +        The image is found by its GUID and the firmware is updated.
> +        """
> +        disk_img = efi_capsule_data
> +        capsule_files = ['Test116']
> +        with ubman.log.section('Test Case 6-a, before reboot'):
> +            capsule_setup(ubman, disk_img, '0x0000000000000004')
> +            init_content(ubman, '100000', 'u-boot.bin.old', 'Old')
> +            place_capsule_file(ubman, capsule_files)
> +
> +        do_reboot_dtb_specified(u_boot_config, ubman, 'test_sig.dtb')
> +
> +        capsule_early = u_boot_config.buildconfig.get(
> +            'config_efi_capsule_on_disk_early')
> +        with ubman.log.section('Test Case 6-b, after reboot'):
> +            if not capsule_early:
> +                exec_manual_update(ubman, disk_img, capsule_files)
> +
> +            check_file_removed(ubman, disk_img, capsule_files)
> +
> +            verify_content(ubman, '100000', 'u-boot:New')
>
> --
> 2.34.1
>
