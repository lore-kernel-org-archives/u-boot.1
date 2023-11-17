Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A8BC197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 10:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A90A386FFE;
	Fri, 17 Nov 2023 11:34:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v+oXLcF+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F15786F3D; Fri, 17 Nov 2023 11:34:20 +0100 (CET)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEE0587477
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 11:34:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7c1a46c943cso340625241.2
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 02:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700217245; x=1700822045; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1jVa76XkI+9oeVucUd3Ab0uWxej57MQl8hc01w9ZZHA=;
 b=v+oXLcF+DsSJMgxm+Mr2tNd/1YnPyopMMyVK/CfOjj7Ys9KAoHG7D3qqNVvzJ/GRkj
 GM1KpmsAjvKpEK9+kIFyOpc/zLY9Wlrz7qLPgJ3unuybaf0pNplAwHF559X4zZ4yMRQR
 V5zDhxxNAfkfKg5aKcM3mos+XhmC+5J5qNElt1mCwzrfftmTBdSkFJ1kTGH8bCvpvYnH
 1Ne63/ziOZf7JIDjGoGYxAUqjjXCrdCWsA6UYBMLutS+gWSViB+LYico04vZ78KNNzEq
 1gAtEq2/bKEkSF3KF+xX8Ojh1ZguLjKyqJMd0RqHw3Z8andO+EdpEXzYtnQ9xppaQk0e
 /qxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700217245; x=1700822045;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1jVa76XkI+9oeVucUd3Ab0uWxej57MQl8hc01w9ZZHA=;
 b=UJ3Ioh/1ctSR10FZ+Ij8Xl2jaqsTSGoEW1pX6IZBFuKhLF639XO5jCGO/g7OLteuJN
 qIa0luH3lAfNnnPp5XPenoAXfmuNbfFGCu6lFdmbHts02Lw9ZlilZHYV6jPzb9SanCPJ
 l5nPS8rhm1EM0lkt9iqLCI/PYrtp4J1z2sDLNU2kQN7oeS9p9GO/n8cKWpgHIQRKdDQi
 Uj3MmRuTH+IDRl6n2BI10U/2SQG1y6efolFcAEO2GiY9Ayal3rYJP5ro8h5vimzK0pML
 MvNlC4yZtgVSP04MnKuSGnQ++KA5sUiYVhWrkavb8OVOHbNXIsjHl5FxbhrhJG3aTHdg
 3njw==
X-Gm-Message-State: AOJu0YyvRLEfVJUx0QnsZPdM15h37nS83LGMA4mr4R7O7tBNGnU6xdIS
 Ma5M631PlFXQuNxICo422pNLjhYatx9Ov/6bATDWkQ==
X-Google-Smtp-Source: AGHT+IHD18p1HnwvVKiN6oE1E1tXG6gODZ6lZ/PzeuBkGvAYM7I74bAkaNn9pwmux/fv0kkr92EqmpF55swsTLSbqNE=
X-Received: by 2002:a1f:734b:0:b0:49a:1a56:945c with SMTP id
 o72-20020a1f734b000000b0049a1a56945cmr17038899vkc.13.1700217245592; Fri, 17
 Nov 2023 02:34:05 -0800 (PST)
MIME-Version: 1.0
References: <20231114-b4-qcom-dt-compat-v3-0-88a92f8f00ba@linaro.org>
 <20231114-b4-qcom-dt-compat-v3-5-88a92f8f00ba@linaro.org>
In-Reply-To: <20231114-b4-qcom-dt-compat-v3-5-88a92f8f00ba@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 17 Nov 2023 16:03:54 +0530
Message-ID: <CAFA6WYPCDAzYSQiR7Fw4-R=SMOqkyPNwFJqkaqGYB_g8zDgmNA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] pmic: qcom: dont use dev_read_addr to get USID
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Stephan Gerhold <stephan@gerhold.net>,
 u-boot@lists.denx.de
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

On Tue, 14 Nov 2023 at 19:18, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Linux DTs stuff a value indicating if the USID is a USID or a GSID in the
> reg property, the Linux SPMI driver then reads the two address cells
> separately. U-boot's dev_read_addr() doesn't know how to handle this, so
> use ofnode_read_u32_index() to get just the USID.
>
> The Qcom pmic driver doesn't have support for GSID handling, so just
> ignore the second value for now.
>

Since you are trying to add Linux DT bindings compatibility here, I
suggest you drop custom u-boot binding here:
doc/device-tree-bindings/pmic/qcom,spmi-pmic.txt.

-Sumit

> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/power/pmic/pmic_qcom.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/power/pmic/pmic_qcom.c b/drivers/power/pmic/pmic_qcom.c
> index ad8daf43f06f..f2ac6494811d 100644
> --- a/drivers/power/pmic/pmic_qcom.c
> +++ b/drivers/power/pmic/pmic_qcom.c
> @@ -66,12 +66,19 @@ static const struct udevice_id pmic_qcom_ids[] = {
>  static int pmic_qcom_probe(struct udevice *dev)
>  {
>         struct pmic_qcom_priv *priv = dev_get_priv(dev);
> +       int ret;
>
> -       priv->usid = dev_read_addr(dev);
> -
> -       if (priv->usid == FDT_ADDR_T_NONE)
> +       /*
> +        * dev_read_addr() can't be used here because the reg property actually
> +        * contains two discrete values, not a single 64-bit address.
> +        * The address is the first value.
> +        */
> +       ret = ofnode_read_u32_index(dev_ofnode(dev), "reg", 0, &priv->usid);
> +       if (ret < 0)
>                 return -EINVAL;
>
> +       debug("usid: %d\n", priv->usid);
> +
>         return 0;
>  }
>
>
> --
> 2.42.1
>
