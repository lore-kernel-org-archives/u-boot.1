Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBD5F8A143
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 08:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B5898407E;
	Thu, 16 Apr 2026 10:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N/6wVfem";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8453F840AB; Thu, 16 Apr 2026 10:31:13 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E438283FC0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 10:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-651c366f7efso4528632d50.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 01:31:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776328269; cv=none;
 d=google.com; s=arc-20240605;
 b=Es9RT0dqQYznnTCKDb+ri8o0WhvSdF+Qoz+e2+IyYRlRDnNMS358q5U+7PAS8vFyud
 d/Yc6UYcF5oH35GceRrDN2bu5ehTzwh4n++mjHaNFmc+gJFb6l7K/p0uZ3uOnFROuLD2
 03z0PjNAnHN1jdG3sCh3vPGhBeJQc+6nK22Q1J3YOrLSplbA5MQjg3fF9TDlmJusohhn
 0Xr6qcJEDvoHdWIKfNDrMNb95UK2vvaKdiOhyEo5jfDYwvmx74pl+HG7C4blAz1F/d76
 abZOHRBV63CYOifxEuLSF7PXVX5IuOz3bgGCAQMTioUTF6XeKVW4IY+uuR/loIJ+Rnut
 gPPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=v51CcDI29Gbe71EJPom3xWLYdkc4g7ImAgU4n09q6AQ=;
 fh=Iw0LkeB05DeRNILfAIxaIBOq6OOrPX1YtyP/cG9y6OM=;
 b=Uc36vmokvnwMuPwRNSCmlmWMFGw/CH2CmATr0243Jhfiz7r4WpZzztxQO802aONZ1q
 9hfwEmVxDjafDeCO9IGULQRTETT92QSlsQVeTJy4vTQ/96pIOxTpj3cax74SMaqdbzIk
 Ul8zEk30L+M4lCKrSMzcpZUAwHvTGOmv4modluNNaz8vuDZW7foayXm6KFMbaBfLZYe2
 c7u/QI6oXk5gt/fU0KyRtMXi5nsyxkNRck0R4DePKrlgoZfLrLc0bgRCCGV5Z2Gf4RZ6
 CKFmLnkg/bS5ThVfJkjvQdi63FBRJOtDeFbtTI0v5xyYhVpWTwgD4kzsUBad2hovDUBA
 qv1A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776328269; x=1776933069; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v51CcDI29Gbe71EJPom3xWLYdkc4g7ImAgU4n09q6AQ=;
 b=N/6wVfemnJYIR+UIOL14HOYYGLiJYydu0+yn+wNKzxscOncLcyi0KKfC+BJPLukS6/
 PvyvBvDQ6xnJhzhCxFO03mxdBasrBZcMkwfMc63GI2uV145xzPsoYGunlHm5qVLse+Ae
 3WQLEGzWBgs0uJYO/MHDpkajrVioWuuquG0ATyiT+RqjTxIswcPnUeFudqyz5skRYsMq
 gm0mF9xqaXl6kxTINmRyYxzbVKEkyrQs6ZGXKzsYzXFezZAUfz3Ws+PUceshMmfnBlcA
 nvsgif8+PpbDEZah6reEgIv7EuBin4bLdxlFLOIpskIRDo2OVofVKF4ByRic6iFvNKxQ
 j6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776328269; x=1776933069;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v51CcDI29Gbe71EJPom3xWLYdkc4g7ImAgU4n09q6AQ=;
 b=TzuoSYmaFnbvDhJ6h9ruKzMdyNeGvv/36NriaEEed6HfdcTCQAVb0EipLOeNGkAqOa
 DuyYDhvVzfe6FIxDqXhDWEp+iHClslBmnYV+s4eL+h3SFhvgDC6WQkXEA1wAZntLM02f
 7JrfkcOpJ4sMU1pO+3fMmET0XbPDgakc84P04b0CL32vdBxB6qaxrs5LykMyq/JHdvJc
 1J+0iLBMCXZP4FsvICsp9Xi9PcEKsVR1OZaTn64v9vaFtufJES+/SEivtOq03cy9hDRa
 ixHIqbI72R0DVXIxqUSbAghDkh9PBMEsXZfQ20ueiBQmx0sAisD4i+jPNG4PK8EaFXT7
 tLGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mG2H92Q44ytYBrcQDcuZq+KIllu5k/eEtcDYgoARXlR0x36c6VQ9ETwzrqDEBfLV48XziHEk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+zYDGUQhUEn+qFT49TTw8ttjt3AQ2IlbQl2fWOjx3DZ/re/Gh
 gkKmPMcjuLmHecUEENkBuqbhEdO4L/0lKZYrtbkAqzVsPCQ/dCwBaJjM/3caVRV7B2s41S+UOyA
 OLAUbMTzTUAXHs0u2a6ngmSmWuqbLJETxL+x8+DhE2w==
X-Gm-Gg: AeBDiesjq2RnfHfBI3ChdJB+Add2M8h3+M9HA0Wq7O+dKHJXjibpuors4luKmSgLwoI
 XdTuriI2q3GMFQPqo/MaL8cmdpswVFa71sYItL2SWwhHoMVKw/RvrWWekNIvqpb1k5T9P01sr8T
 25FsHBamCwCzRTqpVTIryi+8dD+B8r8mVRX6nnwo1JMQAtFmjrEK9AsWJpv/ckV4qutTCpEVgJT
 H97nWlnbkxC+tDO10wVfWnZknwJr0CvYCc8o7B1RoP4acMt70KWi4VJ/ctfwxQzIxGZt1IRVvCK
 0ZAsOvHqemjqsaoI2v0/kTZNEiP6BLS1gu8dgEABXAgDhLe+6Osa5A0cBuaMc0XYAwvllfwfgc3
 LzjQDZTUZIxF4qDxfJq+u1hrh1AciDEM870Ekg0/Rx2CtgEgVMoSD5jTfS3O6JUkIH4WEmws9Im
 6yJUfzHIPXlKCwVWnJY6FXKjWZqwYOwZL7sC711U39WNG97oqZWlIVDscxpHOyaqcFeppv0Qs08
 lWz3TFVFLfU5XK9MuAL4n1eUGkY217H0qavxYKDY7zHTsfrkhjc+oV71eM41458puvjz39lIwrE
 mPvax8sMmcqD002B4qJT3ttU2+2pfSNcbn1fiKMpipsp
X-Received: by 2002:a53:ac81:0:b0:652:f423:47e9 with SMTP id
 956f58d0204a3-652f4236a24mr2969817d50.54.1776328268615; Thu, 16 Apr 2026
 01:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-2-rs@ti.com>
In-Reply-To: <20260413203555.1990337-2-rs@ti.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 16 Apr 2026 11:30:32 +0300
X-Gm-Features: AQROBzBTvhbUYknNkLamWHb2KIDb3q9BuAZ2L5S8G_rGHZQ5ATQEQeY2gummOfA
Message-ID: <CAC_iWjLR+wZB6G5p7uMDcv516YkNMhvUaFNdyd68Kc44Nai7uA@mail.gmail.com>
Subject: Re: [PATCHv3 1/6] lmb: allocation flags macro documentation
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, u-boot@lists.denx.de
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

On Mon, 13 Apr 2026 at 23:36, <rs@ti.com> wrote:
>
> From: Randolph Sapp <rs@ti.com>
>
> Update the allocation flags inline documentation to follow the kernel
> object like macro documentation.
>
> Signed-off-by: Randolph Sapp <rs@ti.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  include/lmb.h | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/include/lmb.h b/include/lmb.h
> index 5d5f037ccb9..427d701bc30 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -19,16 +19,36 @@
>  #define LMB_ALIST_INITIAL_SIZE 4
>
>  /**
> - * DOC: Memory region attribute flags.
> + * define LMB_NONE - no special request
>   *
> - * %LMB_NONE: No special request
> - * %LMB_NOMAP: Don't add to MMU configuration
> - * %LMB_NOOVERWRITE: The memory region cannot be overwritten/re-reserved
> - * %LMB_NONOTIFY: Do not notify other modules of changes to this memory region
> + * LMB Memory region attribute flag to indicate that there is no special
> + * requests for this region. Normally used as a placeholder value.
>   */
>  #define LMB_NONE 0
> +
> +/**
> + * define LMB_NOMAP - do not add to MMU configuration
> + *
> + * LMB Memory region attribute flag to indicate that the region will not be
> + * mapped by LMB. Normally used for reserved regions.
> + */
>  #define LMB_NOMAP BIT(1)
> +
> +/**
> + * define LMB_NOOVERWRITE - do not overwrite/re-reserved
> + *
> + * LMB Memory region attribute flag to indicate that the region will not be
> + * overwritten or re-reserved. Normally used for reserved regions.
> + */
>  #define LMB_NOOVERWRITE BIT(2)
> +
> +/**
> + * define LMB_NONOTIFY - do not notify other modules of changes
> + *
> + * LMB Memory region attribute flag to indicate that the region will not notify
> + * downstream allocators (currently just the EFI allocator) of changes to this
> + * region through lmb_map_update_notify().
> + */
>  #define LMB_NONOTIFY BIT(3)
>
>  /**
> --
> 2.53.0
>
