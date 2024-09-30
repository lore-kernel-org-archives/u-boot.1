Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3209CCFA16
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 18:53:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3F9088FDA;
	Mon, 30 Sep 2024 20:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TtnLX4YZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 651D287D1A; Mon, 30 Sep 2024 20:52:32 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 807C98907F
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 20:52:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7a99eee4a5bso421931385a.0
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 11:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727722347; x=1728327147; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GXwgebbNqRzJTqvp3Juovqw25/56wQ9E2prrLAZjW6Q=;
 b=TtnLX4YZ7s0f2Z2OZnO1AH9hTZHMYTloFl9MfopSo8rURdb09Aa+o1WNFnniM9ODjU
 qoWYoLfiX3L+xZBxjqGfubZkq7CB3kONLVCVRnqvhPclnP4Anj8mZPKJDbKmPGkn5auK
 lGXg11zVGKBxbwlhv0Gf+/EerUTUNHA4JuEF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727722347; x=1728327147;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GXwgebbNqRzJTqvp3Juovqw25/56wQ9E2prrLAZjW6Q=;
 b=EG6WU+CQI/ACqlmY2LmS3zmvqE+Prgn12y+ySKIvQlPYpodkUpTS6bjxy7vDk7rN2w
 p5/l7zCXJaR3wlATqlzerhAAPqBbf7O5QyExPORW3OuzFMyEK7mAZ32bJlpAu/hDVJn1
 6QrLGfKKazWG2CAaHRVxReScq9t+OqkZTTu+DreZ18Hv+8FTxaYHw1qKAi8RY9WclCAZ
 OsukI7JSuIouK6zhnm5b9THjfZPEITp10Z1TaHSm5dLgxgh7/Mk48J4CeGzdsrQz+Kpg
 8Y0c+0NL/roTmiAuxLaeIf9v8Sxr/fslmleQGmUQ7uy1DAcHjhJaiItKr1QDRw8LSf2H
 xTrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrnbsCo1sdmw5BX74OJBTimw/DPEkTaVWzOY1L6BIrHynNj/CJETO5JKH/I3qKuNXIQhYslmc=@lists.denx.de
X-Gm-Message-State: AOJu0YxLEyl5MCroVzUpEg3XY6IMMY6DZ+UaeVTiGn76lum/HCEOarWJ
 Gqx/0nJL6XIWj2BkvSLBAwLnzrWUBaT+JbPgNgTS/rtUw2apsYtluBPzltjfltUJuWN1/11inVg
 VWjMPok1wSRw9nCx9Qpxiwf4rPRFEM/iG+SN5
X-Google-Smtp-Source: AGHT+IEsTD4vTxi75j5I09rH8WJIC8w23PNFAfK03uoTV5i7OvSqwnUSy4LyojF9yBpClZeijcjdbOPoj2Mjwwtcruc=
X-Received: by 2002:a05:6214:5d8f:b0:6cb:1006:e9cb with SMTP id
 6a1803df08f44-6cb3b5f90eemr156097266d6.28.1727722347338; Mon, 30 Sep 2024
 11:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240930102148.854-1-brian.ruley@gehealthcare.com>
 <20240930161006.41052-1-brian.ruley@gehealthcare.com>
 <20240930161006.41052-2-brian.ruley@gehealthcare.com>
In-Reply-To: <20240930161006.41052-2-brian.ruley@gehealthcare.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 30 Sep 2024 12:52:16 -0600
Message-ID: <CAFLszTiKK8CJ0ocN8G4LMqPCSDj0726Py5VfEPEDTDz6XCBjiA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] binman: add fast authentication method for i.MX8M
 signing
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

Hi Brian,

On Mon, 30 Sept 2024 at 10:10, Brian Ruley <brian.ruley@gehealthcare.com> wrote:
>
> Using the PKI tree with SRKs as intermediate CA isn't necessary or even
> desirable in some situations (boot time, for example). Add the possibility

spelling

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

That should be below the --- (you can use patman to get this right
automatically)
> ---
>  tools/binman/etype/nxp_imx8mcst.py | 44 ++++++++++++++++++++++--------
>  1 file changed, 32 insertions(+), 12 deletions(-)
>
> diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
> index 0c744a00d7..a80cb94499 100644
> --- a/tools/binman/etype/nxp_imx8mcst.py
> +++ b/tools/binman/etype/nxp_imx8mcst.py
> @@ -36,6 +36,9 @@ csf_config_template = '''
>    File = "SRK_1_2_3_4_table.bin"
>    Source index = 0
>
> +[Install NOCAK]
> +  File = "SRK1_sha256_4096_65537_v3_usr_crt.pem"
> +
>  [Install CSFK]
>    File = "CSF1_1_sha256_4096_65537_v3_usr_crt.pem"

Since 'sha256_4096_65537_v3_usr_crt.' is common to everything, could
you have a variable, say keyname, and use that everywhere?

>
> @@ -74,16 +77,25 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
>                              self._node, 'nxp,srk-table',
>                              'SRK_1_2_3_4_table.bin'
>                           ))
> -        self.csf_crt = os.getenv(
> -            'CSF_KEY', fdt_util.GetString(
> -                           self._node, 'nxp,csf-crt',
> -                           'CSF1_1_sha256_4096_65537_v3_usr_crt.pem'
> -                       ))
> -        self.img_crt = os.getenv(
> -            'IMG_KEY', fdt_util.GetString(
> -                           self._node, 'nxp,img-crt',
> -                           'IMG1_1_sha256_4096_65537_v3_usr_crt.pem'
> -                       ))
> +        self.fast_auth = fdt_util.GetBool(self._node, 'nxp,fast-auth')
> +        if not self.fast_auth:
> +            self.csf_crt = os.getenv(
> +                'CSF_KEY', fdt_util.GetString(
> +                               self._node, 'nxp,csf-crt',
> +                               'CSF1_1_sha256_4096_65537_v3_usr_crt.pem'

e.g. f'CSF1_1_{keyname}'

> +                           ))
> +            self.img_crt = os.getenv(
> +                'IMG_KEY', fdt_util.GetString(
> +                               self._node, 'nxp,img-crt',
> +                               'IMG1_1_sha256_4096_65537_v3_usr_crt.pem'
> +                           ))
> +        else:
> +            self.srk_crt = os.getenv(
> +                'SRK_KEY', fdt_util.GetString(
> +                               self._node, 'nxp,srk-crt',
> +                               'SRK1_sha256_4096_65537_v3_usr_crt.pem'
> +                           ))

All three options seem to read the 'nxp,srk-crt' property, so you can
do that once the if() to reduce the amount of duplicated code.

> +
>          self.unlock = fdt_util.GetBool(self._node, 'nxp,unlock')
>          self.ReadEntries()
>
> @@ -137,8 +149,16 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
>          # Load configuration template and modify keys of interest
>          config.read_string(csf_config_template)
>          config['Install SRK']['File'] = '"' + self.srk_table + '"'

This is what I mean by the f-string:

f'"{self.srk_table}"'

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
>          config['Authenticate Data']['Blocks'] = (hex(signbase) + ' 0 '
>                                                   + hex(len(data)) + ' "'
>                                                   + str(output_dname) + '"')

Can use f-strings here too, e.g.

f'{signbase:#x} 0 {len(data):#x} ...

> --
> 2.39.5
>

Regards,
Simon
