Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCDCCCFA16
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 18:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D6D88907B;
	Mon, 30 Sep 2024 20:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VI0lxHLc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84EF48907C; Mon, 30 Sep 2024 20:52:38 +0200 (CEST)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 584FD87D1A
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 20:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6de14e0f050so38641847b3.0
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 11:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727722355; x=1728327155; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NMXSqukqM95SormfjSd6rworylVgZ6bRDGZ/UJmSzCU=;
 b=VI0lxHLcW4QA0UYyRGWGe/7Xh+tUJk520G7ZhEdNb0p+a+aB99Jy9j9tWSc4LES9oL
 zqkNDfbhIsl6ghijzvBv4DTIVf4w2IXCxqR7lTZ/JhPk29t13QokoGPrbdmD6EWogYq3
 7riMBh392DcJ8bKWNT4n2Qhkxz8ZyxpDsVftI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727722355; x=1728327155;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NMXSqukqM95SormfjSd6rworylVgZ6bRDGZ/UJmSzCU=;
 b=dOZCpqy5sWAxYp0yCkxB/QRacBB7EeJ9q6qIwf7cK0kEtDCzcJ8J06C+cYbYib3jdC
 c3jUT41ox502AdvSgLpjA0XsdCHcMSFqoXytkow11FVhmdVkm/Tepq9gkiLrxzVd/vhQ
 FjFd6FMVlHY9O64WpD3AbhyGxVPoVRW2VvgxXhtKxJ58tT7Y+++XzkfFpcBiXeOPpdw4
 CA3NhZvTAK3P2KvU8zJM5Fz866yr7hnUyyzq5l75H/DUsucGkraIkT4HK6+RFJZ2/k6D
 ATb1KAksm5KuyuLQMUmbFGqMp37yulIKBX4qEBeMYB+DZgdp6o8AidR5Fi1X9N8EZaI2
 jSPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVPyPWW3VzM/p2NAfAlZehXRpll9n3DoS1R+jlH2PyMR1UbN6nSx2asTRZ3P3tcdlTOs61fEw=@lists.denx.de
X-Gm-Message-State: AOJu0YxjM2augGfqTcuQGi5FUnXiUOJAGsM3sGg2DNSETVBHukZwhjEv
 LdmlgLeN8V9LHe+x7fi12ZV25ofB+Ps6olpQT7SdXucN3OrwxjjwJVWobyM2prg1/1wSe7FKnx5
 QjLwGngEqX2v1JXN63eBp0FsECFlFtWKvsNepN2B0O39QW04=
X-Google-Smtp-Source: AGHT+IFlcjrE2+1rpsL2aFhn1Xnqa1Qvu4s4kZPUmR6FIoRiLduzOP4Vzuing6oB2ylqo6ussNfLUiU2fyrPlNvxHPI=
X-Received: by 2002:a05:6902:2009:b0:e11:6eb3:833f with SMTP id
 3f1490d57ef6-e2604b14c30mr9253523276.5.1727722355254; Mon, 30 Sep 2024
 11:52:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240930102148.854-1-brian.ruley@gehealthcare.com>
 <20240930161006.41052-1-brian.ruley@gehealthcare.com>
In-Reply-To: <20240930161006.41052-1-brian.ruley@gehealthcare.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 30 Sep 2024 12:52:24 -0600
Message-ID: <CAFLszTj_qCcSMqQ0KawZus1YoHR4iRDSwKYO2Ur=nLcG8c1HqA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] binman: cosmetic: code formatting fixes
To: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>,
 ian.ray@gehealthcare.com, u-boot@lists.denx.de
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
> Conform to the style guide used in the project by making the following
> changes:
> * Use single quotes for multiline strings (except docstrings)
> * Fix line width to 79 cols
> * Use f-string instead of formatting a regular string
>
> Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
> ---
>  tools/binman/etype/nxp_imx8mcst.py | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks for doing this.

Some of my comments on the other patch could be applied here, if you prefer.

>
> diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
> index 8221517b0c..0c744a00d7 100644
> --- a/tools/binman/etype/nxp_imx8mcst.py
> +++ b/tools/binman/etype/nxp_imx8mcst.py
> @@ -23,7 +23,7 @@ from u_boot_pylib import tools
>  MAGIC_NXP_IMX_IVT = 0x412000d1
>  MAGIC_FITIMAGE    = 0xedfe0dd0
>
> -csf_config_template = """
> +csf_config_template = '''
>  [Header]
>    Version = 4.3
>    Hash Algorithm = sha256
> @@ -53,7 +53,7 @@ csf_config_template = """
>  [Authenticate Data]
>    Verification index = 2
>    Blocks = 0x1234 0x78 0xabcd "data.bin"
> -"""
> +'''
>
>  class Entry_nxp_imx8mcst(Entry_mkimage):
>      """NXP i.MX8M CST .cfg file generator and cst invoker
> @@ -69,9 +69,21 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
>      def ReadNode(self):
>          super().ReadNode()
>          self.loader_address = fdt_util.GetInt(self._node, 'nxp,loader-address')
> -        self.srk_table = os.getenv('SRK_TABLE', fdt_util.GetString(self._node, 'nxp,srk-table', 'SRK_1_2_3_4_table.bin'))
> -        self.csf_crt = os.getenv('CSF_KEY', fdt_util.GetString(self._node, 'nxp,csf-crt', 'CSF1_1_sha256_4096_65537_v3_usr_crt.pem'))
> -        self.img_crt = os.getenv('IMG_KEY', fdt_util.GetString(self._node, 'nxp,img-crt', 'IMG1_1_sha256_4096_65537_v3_usr_crt.pem'))
> +        self.srk_table = os.getenv(
> +            'SRK_TABLE', fdt_util.GetString(
> +                            self._node, 'nxp,srk-table',
> +                            'SRK_1_2_3_4_table.bin'
> +                         ))
> +        self.csf_crt = os.getenv(
> +            'CSF_KEY', fdt_util.GetString(
> +                           self._node, 'nxp,csf-crt',
> +                           'CSF1_1_sha256_4096_65537_v3_usr_crt.pem'
> +                       ))
> +        self.img_crt = os.getenv(
> +            'IMG_KEY', fdt_util.GetString(
> +                           self._node, 'nxp,img-crt',
> +                           'IMG1_1_sha256_4096_65537_v3_usr_crt.pem'
> +                       ))
>          self.unlock = fdt_util.GetBool(self._node, 'nxp,unlock')
>          self.ReadEntries()
>
> @@ -118,7 +130,7 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
>          tools.write_file(output_dname, data)
>
>          # Generate CST configuration file used to sign payload
> -        cfg_fname = tools.get_output_filename('nxp.csf-config-txt.%s' % uniq)
> +        cfg_fname = tools.get_output_filename(f'nxp.csf-config-txt.{uniq}')
>          config = configparser.ConfigParser()
>          # Do not make key names lowercase
>          config.optionxform = str
> @@ -127,7 +139,9 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
>          config['Install SRK']['File'] = '"' + self.srk_table + '"'
>          config['Install CSFK']['File'] = '"' + self.csf_crt + '"'
>          config['Install Key']['File'] = '"' + self.img_crt + '"'
> -        config['Authenticate Data']['Blocks'] = hex(signbase) + ' 0 ' + hex(len(data)) + ' "' + str(output_dname) + '"'
> +        config['Authenticate Data']['Blocks'] = (hex(signbase) + ' 0 '
> +                                                 + hex(len(data)) + ' "'
> +                                                 + str(output_dname) + '"')
>          if not self.unlock:
>              config.remove_section('Unlock')
>          with open(cfg_fname, 'w') as cfgf:
> --
> 2.39.5
>

Regards,
Simon
