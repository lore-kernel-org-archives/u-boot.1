Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB6DFD875C
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 12:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EED238426C;
	Tue, 17 Mar 2026 13:29:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W02FTqRr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED6B084286; Tue, 17 Mar 2026 13:29:02 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22FF28425F
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 13:29:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-667952fd262so46003a12.2
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 05:29:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773750539; cv=none;
 d=google.com; s=arc-20240605;
 b=it5FRcV3ac6+JA5Ga+ZDJurhRR5Y9qom3vT28FmOPOKUHzxL3cS6AFBaF/SxMCZ9Qs
 Px/sZRYc6Zra2XUjO9VvLjD/JJBbT0oQQ51jou7WZpNmSNygBiT9xYLZ8Lb9XoV7L47h
 wh8JhAhsOoGel3+x0mRUs6UKJEUoryfQqV+065wNLWuKvhI5oJvekC7QzTDRwpc7E9fg
 jWXdgXhMJ+gAs1YYrtoivL0tXoF7FjfAok+gEO2TRTU+qhFGd0+qQ5HG4X7dZe7alArX
 2nko7u6k8XlWK6M5YmLI9IY/ZRSwetjpHSgBT/FBw9PzWPKc9rugoBhrZ0KpEk+OXPm9
 me0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=b4sfjXJcKGe+/+P4XfN7RaHEPhjf9oS/MxVoEIvcEnk=;
 fh=fhia8wkl5xGUmglYw1Css8upJsuw2Nw8UF3lTjP1QAY=;
 b=Rl0ojlX91zR9ebcAXeYlk4MtE3uBKw/lKwuPDyiT3tTdAHkk+cV3mO6PLOWmC5fhef
 peh612/lUdJMhP3zSLiMc8323mMCMtx68GoOsZCAIGjuav/c4jFl6pL3hmSINVSTIgiR
 WprGbRj17Rd41xymTrWmulyK7apm/XWxyS8vNfb/IR11LYCsrD96mPn/u/M4BMYtc4zY
 q1c/E6gyH1lyibUcL0YuQZe35OgmpM4wqerVrTooRAVxTOr0gEQ03IglGjWXUF6/Gxwp
 5xBw9oKgflefvOc8jH9vcNVKm62outchptiNQw3XRz13x3Lz74S8uZIAcjBs5ZL0HOPr
 ZL8A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773750539; x=1774355339; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b4sfjXJcKGe+/+P4XfN7RaHEPhjf9oS/MxVoEIvcEnk=;
 b=W02FTqRrklFewj8AykAcCEt0RpSjhEV9IFxbo+pCuhh0zPbr61+aFwYJBG3odhHbje
 qgA4I2bvJ5COI1us7M88ZSO/zdbjBG0CEBJOyHTD085RIgyqSzyYaKsNB7zRewxwbVd1
 qoqpfxDNJtaJXgG8XXWGcm/0vkHNTJkPZP4HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773750539; x=1774355339;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b4sfjXJcKGe+/+P4XfN7RaHEPhjf9oS/MxVoEIvcEnk=;
 b=RjrUN7xeWPf7GQMX0KOeqL2FNLUX0kbVijQL2IVROp+YZuyNUDucesWG6pOYbMU1e3
 8aY5KcETatcKy0Bwl/8jLc13X/67UMrq5fg7vlctJUfuscVngtbg1gZvG5qMDd97yATA
 IGCT5RYFPUVJ+HUWXox2NH0JHLCNCFliOB6Hl8Dzl5GLlzc6nty0cU3NNo7yfN4FXovM
 vWrzIz0v0HpFTn1SL6lARIA69Od+59qZsB8yPXvYEHX2h2nP88tLszFVHPYZNUYFhZM7
 LqgCZ8KzHwgI2RVmMa/rVFlrajSK/pqFvW+YGCBRneTMKdEqM0pOoQ66YXVg2DEyXXlf
 SYmA==
X-Gm-Message-State: AOJu0YyvIkAIwA+FzSEq+Q/hJxlPk5bmeMp4dxRDSmLMoEXcBT/eE8J8
 4WH4mUNSebSpm8vkLOkT99Es1Q2FuqkX+pjgCn/7VSQ4SyOCN9l6aIBvN2RmZ17dC+i/y/m+j8n
 x6WGGxDfed+pkHQJa+x+/+jW9BstDO7VFzbHfMIZX
X-Gm-Gg: ATEYQzywaQOa/vSNIlQ3BA1Wl7C+OsQULqSKUV5LHGSxHQnNOqOhVwFGgFymtisoQPJ
 G+87Pj+orQcwr+1ZMQUx7doyn7qf87bkPmPryVNR4O8ty/pOU+FFJSXAO/J1qTftSqf9vRQPIv0
 E18jtgmMJcBWqrXamTEozy3sXHJ3R0HYRjIcd4ZIt1nifkdp3Fh5rmtW+d7PdxFJc+8WPyxgxyh
 nNobrID0MOzuSrblPIo+/ck24hbP5cncdBZkGS/hVlDeXm6OH6txIGTE5TYuqp2wwRlIdSmMlyl
 w3/CSw==
X-Received: by 2002:a17:907:1b21:b0:b8f:a5c8:f75 with SMTP id
 a640c23a62f3a-b97653bbab0mr1013012166b.52.1773750539376; Tue, 17 Mar 2026
 05:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260213192838.157084-1-marex@nabladev.com>
 <CAFLszTjHZ+a17+bZh17DMOJGny6VaWCe4EftpYRE1Bq+RAty4Q@mail.gmail.com>
 <c3d59858-9855-47fd-aa5a-0b861c4e44e8@nabladev.com>
In-Reply-To: <c3d59858-9855-47fd-aa5a-0b861c4e44e8@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Mar 2026 06:28:47 -0600
X-Gm-Features: AaiRm53b_CYSWkCqHFqk-jkfofgHf3HS4kZ5dG-v0xdqrzv3nNbtyeBeoyGHCfM
Message-ID: <CAFLszTgNA1xmMNH=qtaKurDZdFW3dscMwwKyQ7iU-7EMMDOAuQ@mail.gmail.com>
Subject: Re: [PATCH v2] binman: add CST backend selection for i.MX8M signing
To: Marek Vasut <marex@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
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

+Heinrich Schuchardt

Hi Marek,

On Fri, 13 Feb 2026 at 19:51, Marek Vasut <marex@nabladev.com> wrote:
>
> On 2/13/26 9:20 PM, Simon Glass wrote:
>
> Hello Simon,
>
> >> diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> >> index 1bea091344d..a3ebd397d82 100644
> >> --- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> >> +++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> >> @@ -167,17 +167,25 @@ The nxp-imx8mcst etype is configurable using either DT properties or environment
> >>   variables. The following DT properties and environment variables are supported.
> >>   Note that environment variables override DT properties.
> >>
> >> -+--------------------+-----------+------------------------------------------------------------------+
> >> -| DT property        | Variable  | Description                                                      |
> >> -+====================+===========+==================================================================+
> >> -| nxp,loader-address |           | SPL base address                                                 |
> >> -+--------------------+-----------+------------------------------------------------------------------+
> >> -| nxp,srk-table      | SRK_TABLE | full path to SRK_1_2_3_4_table.bin                               |
> >> -+--------------------+-----------+------------------------------------------------------------------+
> >> -| nxp,csf-crt        | CSF_KEY   | full path to the CSF Key CSF1_1_sha256_4096_65537_v3_usr_crt.pem |
> >> -+--------------------+-----------+------------------------------------------------------------------+
> >> -| nxp,img-crt        | IMG_KEY   | full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem |
> >> -+--------------------+-----------+------------------------------------------------------------------+
> >> ++--------------------+-------------+------------------------------------------------------------------+
> >> +| DT property        | Variable    | Description                                                      |
> >> ++====================+=============+==================================================================+
> >> +| nxp,loader-address |             | SPL base address                                                 |
> >> ++--------------------+-------------+------------------------------------------------------------------+
> >> +| nxp,srk-table      | SRK_TABLE   | full path to SRK_1_2_3_4_table.bin                               |
> >> ++--------------------+-------------+------------------------------------------------------------------+
> >> +| nxp,csf-crt        | CSF_KEY     | full path to the CSF Key CSF1_1_sha256_4096_65537_v3_usr_crt.pem |
> >> ++--------------------+-------------+------------------------------------------------------------------+
> >> +| nxp,img-crt        | IMG_KEY     | full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem |
> >> ++--------------------+-------------+------------------------------------------------------------------+
> >> +| nxp,fast-auth      |             | enable fast authentication method                                |
> >> ++--------------------+-------------+------------------------------------------------------------------+
> >> +| nxp,srk-crt        | SRK_KEY     | full path to the SRK Key SRK1_sha256_4096_65537_v3_ca_crt.pem    |
> >> ++--------------------+-------------+------------------------------------------------------------------+
> >> +| nxp,unlock         |             | unlock CAAM in SPL                                               |
> >> ++--------------------+-------------+------------------------------------------------------------------+
> >> +| nxp,cst-backend    | CST_BACKEND | CST tool backend, default is 'ssl', or selectable 'pkcs11'       |
> >> ++--------------------+-------------+------------------------------------------------------------------+
> >
> > Perhaps point to an example?

Sorry I missed this earlier.

>
> Example of what ? Two lines below, there is an example of using those
> env vars, see the entire file.

Yes I see it, but it doesn't have CST_BACKEND right?

>
> >>   Environment variables can be set as follows to point the build process
> >>   to external key material:
> >> diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
> >> index 8922d6cd070..29bc778d0e5 100644
> >> --- a/tools/binman/entries.rst
> >> +++ b/tools/binman/entries.rst
> >> @@ -1664,6 +1664,13 @@ Entry: nxp-imx8mcst: NXP i.MX8M CST .cfg file generator and cst invoker
> >>
> >>   Properties / Entry arguments:
> >>       - nxp,loader-address - loader address (SPL text base)
> >> +    - nxp,srk-table - full path to SRK_1_2_3_4_table.bin
> >> +    - nxp,csf-crt - full path to the CSF Key CSF1_1_sha256_4096_65537_v3_usr_crt.pem
> >> +    - nxp,img-crt - full path to the IMG Key IMG1_1_sha256_4096_65537_v3_usr_crt.pem
> >> +    - nxp,fast-auth - enable fast authentication method
> >> +    - nxp,srk-crt - full path to the SRK Key SRK1_sha256_4096_65537_v3_ca_crt.pem
> >> +    - nxp,unlock - unlock CAAM in SPL
> >> +    - nxp,cst-backend - CST tool backend, default is 'ssl', or selectable 'pkcs11'
> >>
> >
> > The way it works is you add this as a comment in nxp_imx8mcst.py and
> > then run 'binman entry-docs' to generate entries.rst - see here:
> >
> > https://docs.u-boot.org/en/latest/develop/package/binman.html#entry-documentation
> Why is there this entries.rst then ? Should the entries be removed from
> here and moved into the py file or what is this inconsistency ?

The entries.rst file is there so that the documentation can be build,
containing it. It might be possible to update 'make htmldocs' to run
binman to update the generated docs.

Heinrich, what do you think about that?

Anyway, if you update the comments in the code, then you can run
binman as above to regenerate the documentation.

Regards,
Simon
