Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214B8E77179
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 19:16:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 916298973E;
	Fri,  6 Dec 2024 20:16:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NlouOcuB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D56B8973E; Fri,  6 Dec 2024 20:16:30 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C922A88F0C
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 20:16:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ee74291415so1777584a91.3
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 11:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733512586; x=1734117386; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uq6MnTcwxxwYNxfdraUSYgvDaC+4Xbsswg2/D/P8fGk=;
 b=NlouOcuB6yn4ATTc62vQ9pzqvnuevdCsUhSMLvY1MV3yTVMqoOczIcLxz31Z6v6VF7
 hKep+MLVRo4RXNO9aeEbxyagnK8AB5k8UW23yO0Djp+ifk5ifTIYP2bPv3Z6e1e1NeQY
 1GNM60RZVjyb47pAk4YTUMRTeMg18Q9qxqjqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733512586; x=1734117386;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uq6MnTcwxxwYNxfdraUSYgvDaC+4Xbsswg2/D/P8fGk=;
 b=p1pf1Bmwwr2zIBRmb8tP6G6z4gp78fGrG7TIeI6MeMmh/5oPnXPJto8OXngu6VpHer
 GMvWOfr97ZSQTnblXifY6Q7wTpGTb+4KF1TE2UjgClggFzxTnMAdsnAAwhhuvI8GxI9g
 xqgpwv3nPERuYvP1pF8xLfe/L1abqq+kJfAkiiDTxvqYOVy8B3PjJewpWBC9ggoyfrcD
 +SaxNpqRxSY6pYi4tZNhWrM3f1i9PCYW3P2y0HC1ZzS1x8QPrPJPcIqPT5cPtSaKHqBI
 NZG5BcpAg1RgimgdYGpR00GeHFWASJr7t0HGQQIH+3FUg3IS44iEA0w6d5Ougg5Msh3Y
 nIgw==
X-Gm-Message-State: AOJu0Yz/sxMPAf44e/zp/7+615icqD5XAT9hictuAZf6wV4z/H/yUht6
 Wph8eK2fqchJ7J9tfV6SSYM7zY0PZHTaJqfmG5dgCIKcpWtd4WW5moSCoPVCsvdMnaVfKtaUlGi
 t7LxeQKqPiLyfPn5Fjv32A9gSo/3trwaSMCHk
X-Gm-Gg: ASbGncvxQrK12F8HVWwqjCo7wJwrdHkey7Au1igG06J0SepBrJCBQaAtAM3+7PlHVIc
 nGse5BdfCI2akHi6roaRLFqoQLmdKxywl
X-Google-Smtp-Source: AGHT+IHc3ZzP/yGs94XNsp0eNMxpdHJ94GSffOLwzQW+VE+hDorxlxQl/p5cCv9eiMOZFNy/3g4mcIs34tSRARLIP0E=
X-Received: by 2002:a17:90b:2d43:b0:2ee:ba84:5cac with SMTP id
 98e67ed59e1d1-2ef6955f863mr6520398a91.7.1733512586352; Fri, 06 Dec 2024
 11:16:26 -0800 (PST)
MIME-Version: 1.0
References: <20241125174717.1181452-1-paul.henrys_ext@softathome.com>
 <20241125174717.1181452-2-paul.henrys_ext@softathome.com>
In-Reply-To: <20241125174717.1181452-2-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 6 Dec 2024 12:16:08 -0700
Message-ID: <CAFLszTjp7Y6xwNQXcakuS2V3hN-ELhdQ+CqF4BOCvHB_uw3j3A@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] tools: binman: add 'fit, encrypt' property to pass
 keys directory to mkimage
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot@lists.denx.de, paul.henrysd+nodisclaimer@gmail.com, 
 al.kochet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, 25 Nov 2024 at 10:47, Paul HENRYS
<paul.henrys_ext@softathome.com> wrote:
>
> mkimage can be used for both signing the FIT or encrypt its content and t=
he
> option '-k' can be used to pass a directory where both signing and encryp=
tion
> keys can be retrieved. Adding 'fit,encrypt' property to the 'fit' node, l=
eads to
> try to find keys directory among binman include directories.
> _get_priv_keys_dir() is renamed as _get_keys_dir() and adapted to support=
 both
> signing and encryption nodes in the FIT.
>
> Signed-off-by: Paul HENRYS <paul.henrys_ext@softathome.com>
> ---
> Changes for v4:
> - Add 'fit,encrypt' property to enable encryption in FIT
> - Remove the previous implementation to have a common property to pass th=
e keys
>   directory to mkimage for both signing and encrypting the FIT
> - Update the entries.rst file
>
> Reacting to Alexander's message pointing at Simon's previous message in A=
ugust, speaking about entryargs. At my level, it doesn't really matter whet=
her a specific directory is specified or if it comes from one of the binman=
 input directories and Alexander's implementation, that retrieves the signi=
ng keys from one of the binman input directory is handy for that.
> On my side, it would sufficient to retrieve the ciphering keys from one o=
f binman input directories, like for the signing keys but with the current =
implementation, I would need to add the property 'fit,sign' which is a bit =
counterintuitive. 'fit-keys-directory' might also not be right, it could be=
 something like 'fit,keys'. What I meant is that afaiu, 'fit,sign' is not a=
 property that will enable the signature but provides the keys directories =
to mkimage. Signing the FIT data is based on the presence of 'signature' no=
des in the ITS. The same is true for the encryption with mkimage but with '=
cipher' nodes.
>
> Regarding the other entryargs for signing with binman, this is another wa=
y of signing any piece of data (file, binary blob...) which globally signs =
the data and prepends a header. When using the FIT embedded signature, that=
 does not sign all FIT metadata, I guess it's better to keep it in mkimage,=
 which is the tool generating the FIT.
>
> I am pushing here a v4, where I add a property 'fit,encrypt' that does th=
e same than 'fit,sign', passing the option '-k' to mkimage. That might help=
 our discussions because I am a bit confuse at the moment on the approach t=
o be taken. Thx for your help.
>
>
>  tools/binman/btool/mkimage.py |  8 ++++----
>  tools/binman/entries.rst      |  7 +++++++
>  tools/binman/etype/fit.py     | 25 ++++++++++++++++++-------
>  3 files changed, 29 insertions(+), 11 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
