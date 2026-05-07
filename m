Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A426DCD343F
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 15:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B68884A79;
	Thu,  7 May 2026 17:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mq6hFUEy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D101A84AFA; Thu,  7 May 2026 17:31:13 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31FFB84A7B
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 17:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bc23bebd345so189560766b.1
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 08:31:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778167870; cv=none;
 d=google.com; s=arc-20240605;
 b=hSjLN5g9u7K6Ai8uS9MoEIf0U7FJZ8gSskw0vwesdPCb/qWjp/XrZyUzuU8IRV3zZj
 NhVrV1ip3/Li/BZghIcsq0mBMUWm6RTaEP7sP5Q1rgmW0adgPzxfUhxe1reCepqXOax5
 JnZlbTppzvrpRVaDOvKm+fgDeVF/6ZMHvp0WYVxx6jyxgFVmCEjvsncVTnHAlqUfKEQx
 ylZaXxZrnBOwTuhjyIk/+Qjm9vIPjg2LLsVj5jCV4g2dYE5l9u6BTjyYYmckxjHIRDaP
 TCWOCrW0Rf6+J8M6T98CSZhCDMQP0kBHq8/E+d2Z/PDxarw66a8b7KYCYHjUadat3YDx
 4R7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iu852Ff196ydzXaHxvC8GWPNpFpEq1sm/XEICjKFslY=;
 fh=mMjfHynJFJmcWd2ujY9HOYbDsUWJsRgAYR53jQaIBb4=;
 b=AZzoFIxGCTuxTjedK1WCiiadajagcA/iL5wRIT7Pmo9vjUvnwJmoJSavOjxQrDqVNK
 mdatPEYKgm2klPOFihEZLGha8W+RZfytsKyNszuQK9Go2aG6uusk0ZPZt/QXcwCAadGJ
 fshUclI51RV6pUgvxcNcCpjvEduCyiix1PmDKFGqBqh4f94xhW8GlXRlbqSJZbm2CVO4
 TOw5aGmmc2rmwowiVRxMMK5dvdoYDMA1reMucrM2MUp+4rAJKbITByoqaDvDjAekBCiU
 HH13a9ONXui9fMQFeEiPyvNCTyCjmitdHzmP1keEJQlj7jwLfmlaK9ci2it+wlkHfeNU
 Dvjg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778167870; x=1778772670; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iu852Ff196ydzXaHxvC8GWPNpFpEq1sm/XEICjKFslY=;
 b=Mq6hFUEy3H/b5+u+hmSGyG/8h88K7kyJ4lKxDp1X5VcnLS+NC/VX5g0ZutWuSFp6qm
 chkNgCG+EiDPXe70Ee/YkLlaoKTduvpghdcCTvEyqSsX4DppqG4/VvwcKg22k02N7gVc
 epuHUAVj5nK1IiHhk6tWwstX5/5JjH8erCLzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778167870; x=1778772670;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iu852Ff196ydzXaHxvC8GWPNpFpEq1sm/XEICjKFslY=;
 b=muGBrzfzi+HlZ2j7O5lx09fusDgakhg3hCccouHWbCNnfoqFbgAVapkk86+G4wdtl1
 GHWosbykQfeitWhxIxdIf3tfqwrZ+FUEG0n/rr4Rszk8xbeh1MIfqyOKkSWvVxV0q4hX
 aENGNdE6xAwxS68wWB1HsJ9SWCanzo4kz5xpMykShol1QMcvOonX4i36qG+xAe5xZqDf
 RXopT4W7UmB5mUfjTEh63ng4lpbbCqZuXjpW6ZksTgwZ+NzUcYF+46Uj4wZ2ks7vf9mh
 e8zv4zYVGdojauCx1XRcy0iZf5d2w+48dme20mNCwFu6gr7sEDEOfaRzpLFBrR6CEAS+
 3Llw==
X-Gm-Message-State: AOJu0YzK5zsVeudk2HnnHY/68wVnBoe6eh0OE7pJcRt4X16mPbb3J0EH
 GMSEoIagLdPrkWbHFFKlZUGeLvwAX3Y2SGbnFCL7oIfBlXkB/sFMl6HmCw4k0tG49M/mUVAG5PW
 Jv6uBoWcYGHyAWsMm5rVo8xZYApsbPBXr8MwxBylj
X-Gm-Gg: AeBDieu2W8faJLbBcCRi9GtLtiaOmlPWuV/W/oLbRc/uBgR9zDNvtgctrvHiZckTu72
 RRNW72mKCg9HHm0fUqEB8ja1A+vYTdGSBrcOuVgiwRSG9dQ+wqhPJL9NeZtHvdkYFBz2wEO6kZM
 NFJV/BPP2ww9cZRCvxG0mGLBkhAq2XnwgiSkeCjK7sVuDtb0PM9zLQvu+kEBtrIjM2HcUfw/1Jy
 AfczKlxX5tOp9+V8bpHkJr20zi1QCCAt/T/Tk1Rm1/xWgITF88NfpOJZhXuSfoQSRQEdPhKt19e
 yQyna6IvkdupQRSsfjZ9e73XSNM=
X-Received: by 2002:a17:907:e157:20b0:b9d:14e9:d06d with SMTP id
 a640c23a62f3a-bc84ce749a5mr155195766b.8.1778167870319; Thu, 07 May 2026
 08:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260504144455.3674272-1-ravi@prevas.dk>
In-Reply-To: <20260504144455.3674272-1-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 09:30:58 -0600
X-Gm-Features: AVHnY4LMVZMuq1-Q28kGll9QoXXwdPGAakj4S4t1dLx3a8XNiNvrUWXyHsi5yrw
Message-ID: <CAFLszTjtqDHB5NpXq_dTu-WBx1D9uhgNMcEtgvsSg8MoRUHDOw@mail.gmail.com>
Subject: Re: [PATCH] boot: image-fit.c: check target, not source, for 8-byte
 alignment when loading FDT
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tom Rini <trini@konsulko.com>
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

Hi Rasmus,

On 2026-05-04T14:44:55, Rasmus Villemoes <ravi@prevas.dk> wrote:
> boot: image-fit.c: check target, not source, for 8-byte alignment when loading FDT
>
> A number of our boards no longer boot with v2026.04, ironically as a
> result of the effort to ensure 8-byte alignment of the dtb passed to
> the kernel and getting rid of the fdt_high=0xffffffff.
>
> The problem exists when the FIT image does specify a (properly
> aligned) load address to use for the fdt. For example, we have
>
>         fdt-am335x-boneblack.dtb {
>                 description = "Flattened Device Tree blob";
>                 data = /incbin/(...);
>                 ...
>                 load = <0x88000000>;
>         }
>
> Now, with v2026.04 and depending on just exactly where that data ends
> up, in a good case we see
>
>      Loading fdt from 0x8a8c6e10 to 0x88000000
> [...]
>
> boot/image-fit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/boot/image-fit.c b/boot/image-fit.c
> @@ -2311,7 +2311,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>               }
>               len = load_end - load;
>       } else if (load_op != FIT_LOAD_IGNORED && image_type == IH_TYPE_FLATDT &&
> -                ((uintptr_t)buf & 7)) {
> +                (load & 7)) {
>               loadbuf = aligned_alloc(8, len);
>               load = map_to_sysmem(loadbuf);
>               memcpy(loadbuf, buf, len);

Fixes: 8fbcc0e0e839 ("boot: Assure FDT is always at 8-byte aligned address")

BTW the file already uses IS_ALIGNED(x, 8) a few lines up in
boot_get_fdt_fit_into_buffer() so you could use !IS_ALIGNED(load, 8)

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
