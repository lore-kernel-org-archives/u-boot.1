Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06921CDD1CD
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 16:50:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 396F989142;
	Fri, 27 Sep 2024 18:50:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cb1eu9uc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F0EF8914E; Fri, 27 Sep 2024 18:50:43 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3DDA89133
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 18:50:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6cb2f271043so20105346d6.0
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 09:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727455840; x=1728060640; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y+9vEvxVh76iMGZQDTpt2MmNzc50qTkUufmLUAbSuus=;
 b=Cb1eu9ucSj+jKKtpt+sz+im4KFxAdlh2aL28ytmhVYMHmqW7gzCNSFK7Fh1hoL64bG
 nkkeQKixgimUamcitqcqs9utftl7/FBL/ytDmyNXZzuG6yY/9awfgziC3OJeDlAvVU3O
 gFEKtXE+uik0x99nN0gWxfSvy8BLW9aczbAYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727455840; x=1728060640;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y+9vEvxVh76iMGZQDTpt2MmNzc50qTkUufmLUAbSuus=;
 b=Ok2odVKwSnc/96M25CdUoOjPsdJkSkRdTKWK7fiF8guCDc4lyiZYBGCLdgZimiIT9U
 vGggMcdZP87rNQZGTJdPoy9IbVAQXzmz8puYeELCgHt4qAfnq3nSK/eyfhG7jDmvIqpJ
 zFrnp/FaCaymUI03xIUZTDJiyTOlzXZc3cWjJIKsqq+WZlepbDfnkRrmioFLJgobDzUE
 H74Yce1dPRjqCzlOhBJp7jydA1Rd7jVbw3Tna5Ttnn/DCYOFqDaMrY0atkgbsppCE3Qy
 9Pi7yDiqQUpGVhn2Mm65aap8Lzjcqvg8O3NBSon3H3eugOTCU/QuoNLPyX9xfouRHGaa
 rC6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3TdpRTDOdHshOTNampN0MbpPF0BakOCtVAJn602q3d3v1YIBOTmwAbho3o1wlsrdteBDFwHc=@lists.denx.de
X-Gm-Message-State: AOJu0YwrooD2pW5PnEDmR7gQB+AJaSedhQsnUbO9nT59uS5TCw/9QpOv
 tTo0ayrYSmAIs9Qxen1IcMzsxavBQQdykj5V5jtdAI0sXAX7y95YMnLETXA+TAVWMvha1p8U6BX
 xKpPtzdWbDe4HQ32r250t5Vq3IcvyWUyi736O
X-Google-Smtp-Source: AGHT+IGCzxtTmoZpzbv93py3V+nkdDkCOYoyTwHDkwjoLu9HYjRWaJdo1tqo7IoBtbSA3Co+qvJqxHfXxpHgq7eFe1k=
X-Received: by 2002:a05:6214:448b:b0:6c5:a40c:52ee with SMTP id
 6a1803df08f44-6cb3b66ea41mr62781266d6.45.1727455839669; Fri, 27 Sep 2024
 09:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240927124237.47-1-brian.ruley@gehealthcare.com>
In-Reply-To: <20240927124237.47-1-brian.ruley@gehealthcare.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 27 Sep 2024 10:50:29 -0600
Message-ID: <CAFLszTjHkmT0JcgcZ6Yn69q27Pe7YhvwuXc0bC0N+agmpPtCfg@mail.gmail.com>
Subject: Re: [PATCH] binman: add fast authentication method for i.MX8M signing
To: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 ian.ray@gehealthcare.com, Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
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

Hi,

On Fri, 27 Sept 2024 at 06:42, Brian Ruley <brian.ruley@gehealthcare.com> wrote:
>
> Using the PKI tree with SRKs as intermediate CA isn't necessary or even
> desirable in some situations (boot time, for example). Add the possbility
> to use the "fast authentication" method where the image and CSF are both
> signed using the SRK [1, p.63].
>
> [1] https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/imx-processors/202591/1/CST_UG.pdf
>
> Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
> Cc: Marek Vasut <marex@denx.de>
>
>  tools/binman/etype/nxp_imx8mcst.py | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>

Please can you coordinate with Marek as we need to sort out the test
coverage for this etype, before adding more functionality. I did a
starting point, now in -next, which should help.

> diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
> index 8221517b0c..d39b6a79de 100644
> --- a/tools/binman/etype/nxp_imx8mcst.py
> +++ b/tools/binman/etype/nxp_imx8mcst.py
> @@ -36,6 +36,9 @@ csf_config_template = """
>    File = "SRK_1_2_3_4_table.bin"
>    Source index = 0
>
> +[Install NOCAK]
> +  File = "SRK1_sha256_4096_65537_v3_usr_crt.pem"
> +
>  [Install CSFK]
>    File = "CSF1_1_sha256_4096_65537_v3_usr_crt.pem"
>
> @@ -70,8 +73,13 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
>          super().ReadNode()
>          self.loader_address = fdt_util.GetInt(self._node, 'nxp,loader-address')
>          self.srk_table = os.getenv('SRK_TABLE', fdt_util.GetString(self._node, 'nxp,srk-table', 'SRK_1_2_3_4_table.bin'))
> -        self.csf_crt = os.getenv('CSF_KEY', fdt_util.GetString(self._node, 'nxp,csf-crt', 'CSF1_1_sha256_4096_65537_v3_usr_crt.pem'))
> -        self.img_crt = os.getenv('IMG_KEY', fdt_util.GetString(self._node, 'nxp,img-crt', 'IMG1_1_sha256_4096_65537_v3_usr_crt.pem'))
> +        self.fast_auth = fdt_util.GetBool(self._node, 'nxp,fast-auth')
> +        if not self.fast_auth:
> +            self.csf_crt = os.getenv('CSF_KEY', fdt_util.GetString(self._node, 'nxp,csf-crt', 'CSF1_1_sha256_4096_65537_v3_usr_crt.pem'))
> +            self.img_crt = os.getenv('IMG_KEY', fdt_util.GetString(self._node, 'nxp,img-crt', 'IMG1_1_sha256_4096_65537_v3_usr_crt.pem'))
> +        else:
> +            self.srk_crt = os.getenv('SRK_KEY', fdt_util.GetString(self._node, 'nxp,srk-crt', 'SRK1_sha256_2048_65537_v3_usr_crt.pem'))
> +
>          self.unlock = fdt_util.GetBool(self._node, 'nxp,unlock')
>          self.ReadEntries()
>
> @@ -125,8 +133,16 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
>          # Load configuration template and modify keys of interest
>          config.read_string(csf_config_template)
>          config['Install SRK']['File'] = '"' + self.srk_table + '"'
> -        config['Install CSFK']['File'] = '"' + self.csf_crt + '"'
> -        config['Install Key']['File'] = '"' + self.img_crt + '"'
> +        if not self.fast_auth:
> +            config.remove_section('Install NOCAK')
> +            config['Install CSFK']['File'] = '"' + self.csf_crt + '"'
> +            config['Install Key']['File'] = '"' + self.img_crt + '"'
> +        else:
> +            config.remove_section('Install CSFK')
> +            config.remove_section('Install Key')
> +            config['Install NOCAK']['File'] = '"' + self.srk_crt + '"'
> +            config['Authenticate Data']['Verification index'] = '0'
> +
>          config['Authenticate Data']['Blocks'] = hex(signbase) + ' 0 ' + hex(len(data)) + ' "' + str(output_dname) + '"'
>          if not self.unlock:
>              config.remove_section('Unlock')
> --
> 2.39.2
>

Regards,
Simon
