Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2C7E77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 15:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAB04801FD;
	Tue,  7 Jan 2025 16:31:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S3dKnxsN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB3BD801C3; Tue,  7 Jan 2025 16:31:37 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EE7680634
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 16:31:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2eed82ca5b4so22686717a91.2
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 07:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736263892; x=1736868692; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=poqUIJRB3UnIwzIVTIQvHEqyjeRoFXKtOCgRG/9LlM4=;
 b=S3dKnxsNODqlxx7kBOlVQoee5UGBD5hnOlgEbwn5X16zqc5Eya6veQyvC7+2FszJwB
 b/hcW9m2QS8dn8qw8fOGDWW+4Yt/RJPKzHyA03oUjCr4tSu38mWWb4WQELqbG+nDqsYC
 9gcQT+xjmDm9qM+4XvHdjezLvH5HG6JOktHs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736263892; x=1736868692;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=poqUIJRB3UnIwzIVTIQvHEqyjeRoFXKtOCgRG/9LlM4=;
 b=PIMVloLGo5v2PzSheFsm4vVr4eLBxSSNKq2d7l37fQ4CzXG6DIWzSzpEQAfzlUsQ9+
 E2leHsOyDg4OZ7PUl+RJp1O642WpO3CIe/GjKnTnjTRFDV56i4SR8n2xORzjEWw8rJ4o
 2PGB7GEKvE+wvaRQa8+b9FkUqzrPtRw+gP+IIJi+49RaIpa6ZiEvKfTSgOvjKIS330qJ
 7+RyHuQ8ZErImcwkJHwio68R7MjYX/mPzDRIgjoEOSuTkUbaw0n4ghBBlHlOfAANbJtz
 IVHSpZHmYKNiSrp0Efdfh3kN+7shxS5+k05jY9kU3Zb0BYcv+rITZlQZLUrJ6JN23boY
 +M9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVksTPZnUeN5sbkiINVosKKSzSuAoQYzgt0gfS2jCeyz1RKhzOPg5aNA8eFbKJtMkYIbcTON6M=@lists.denx.de
X-Gm-Message-State: AOJu0Yxvg0Q+0gvAoXtns0wy7xQIlgJZ5cOcfcyWnJG6qVJXyeR8JXuo
 e4DIvo1KDAI4GdLbCS5La6fYtmVfOlx6icZLIQKgQMLF/ToZqSIbnmD035V7K7An5h3hNX6pF28
 A5TAfoMwfWZKwwZ49jN0vVWAN3pNBbJ1hjMAD
X-Gm-Gg: ASbGncu1d4AvOkA52MIZSAQCpLUrJoKo0lVhYPQmvRnxwx4fMYhtw3rKoaEWJn7nZyv
 5NKwKrAz+R/wSoeVDMG6169VGoaMZMLjLVqNmy40=
X-Google-Smtp-Source: AGHT+IH2xNTtYVXC7AjNLkeVZAoey1o21tHQ4ZV2snXEQ6Ha90Ss89xmnp7beXrVQvYOB6WH2oZc6rPZEq+nvfVG4lk=
X-Received: by 2002:a17:90b:534f:b0:2ee:ab29:1482 with SMTP id
 98e67ed59e1d1-2f452e2ecc8mr97577261a91.16.1736263892335; Tue, 07 Jan 2025
 07:31:32 -0800 (PST)
MIME-Version: 1.0
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
 <20241124-b4-modernise-smem-v1-8-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-8-b7852c11b67c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Jan 2025 08:30:39 -0700
X-Gm-Features: AbW1kvYy764-_dIzouNoTdrN04XtVTDhxhosC2qko3a5pxFnM-ubUZODMaMbook
Message-ID: <CAFLszTgeYKSfHyqKXEGYzcOQCcoDFH_gCZqvXa9ECLKF+W63fA@mail.gmail.com>
Subject: Re: [PATCH 08/15] soc: qcom: smem: get serial number from socinfo
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de, u-boot-qcom@groups.io
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

Hi Caleb,

On Sun, 24 Nov 2024 at 12:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Implement socinfo support to fetch the serial number if available.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/soc/qcom/smem.c | 25 +++++++++++++++++++++++++
>  include/soc/qcom/smem.h |  1 +
>  2 files changed, 26 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

nit below

> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 5166f289dfb6..5570c5c907ad 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -13,8 +13,10 @@
>  #include <linux/io.h>
>  #include <linux/ioport.h>
>  #include <linux/sizes.h>
>  #include <soc/qcom/smem.h>
> +#include <soc/qcom/socinfo.h>
> +#include <env.h>
>
>  /*
>   * The Qualcomm shared memory system is a allocate only heap structure that
>   * consists of one of more memory areas that can be accessed by the processors
> @@ -982,8 +984,31 @@ static int qcom_smem_map_global(struct qcom_smem *smem, u32 size)
>
>         return 0;
>  }
>
> +int qcom_socinfo_init(void)
> +{
> +       struct socinfo *info;
> +       size_t item_size;
> +       char buf[32] = { 0 };
> +
> +       info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID,
> +                            &item_size);
> +       if (IS_ERR(info)) {
> +               log_err("Couldn't find socinfo: %ld\n", PTR_ERR(info));
> +               return PTR_ERR(info);
> +       }
> +
> +       if (offsetof(struct socinfo, serial_num) <= item_size) {
> +               snprintf(buf, sizeof(buf), "%u", le32_to_cpu(info->serial_num));
> +               env_set("serial#", buf);
> +       } else {
> +               return -ENOENT;
> +       }
> +
> +       return 0;
> +}
> +
>  int qcom_smem_init(void)
>  {
>         struct smem_header *header;
>         struct qcom_smem *smem;
> diff --git a/include/soc/qcom/smem.h b/include/soc/qcom/smem.h
> index a955db08c0f0..755003807dba 100644
> --- a/include/soc/qcom/smem.h
> +++ b/include/soc/qcom/smem.h
> @@ -4,8 +4,9 @@
>
>  #define QCOM_SMEM_HOST_ANY -1
>
>  int qcom_smem_init(void);
> +int qcom_socinfo_init(void);

Comment please!


>
>  bool qcom_smem_is_available(void);
>  int qcom_smem_alloc(unsigned host, unsigned item, size_t size);
>  void *qcom_smem_get(unsigned host, unsigned item, size_t *size);
>
> --
> 2.47.0
>
