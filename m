Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C65CD5BBF
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 06:35:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A9A18405A;
	Mon, 25 May 2026 08:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dK8nZmv/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71BA5844CF; Mon, 25 May 2026 08:35:29 +0200 (CEST)
Received: from mail-dy1-x1334.google.com (mail-dy1-x1334.google.com
 [IPv6:2607:f8b0:4864:20::1334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC2408404D
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-dy1-x1334.google.com with SMTP id
 5a478bee46e88-3025d725a05so21783516eec.1
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 23:35:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779690925; cv=none;
 d=google.com; s=arc-20240605;
 b=PSQDNzRYuFDI1YyOZXpDHj36+M1gc0fmbW4uExIcpMjyVcBvSq33TI09S+Jua1Fc4u
 OMUAc87uc3xw/HsYlhr69ouC+pz2S+o8wP3DHZ6li34rhx5dfbVqMIaMGu+bUCfSYdQ+
 3e3wIC2uLqdrrB/k7umeKfw2wvRATLdBnnf08ksiOOYPJflVnLgLAQ/Bhl/x4FdAaII0
 PXy6nHAxDTr4BlDmE9Xi70vhc1hslG06XJPx2WC6NyaEZT3xIXr8+xcDVFTW6QkBqIKA
 DUpFpn3wwlHn7791Z2wP8VZm0LiAUwyDLpWnejoM9BF6IbLT3f9Bl5HD1sV0jhkG14rj
 0Uvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MG808KzbtxqZEuFQLQP9DNJD3nqwzMeV4M+Kf1Sb4wo=;
 fh=j4nwYqWfj/v3bKy81DRV5p5QDE40u9NGpBIIGj1WoSE=;
 b=iKtFRW/wFEGmgY53R9f8CNVaLLEtoDqnCDRGids6Bxrm9Xe/V+S6E+FoH1Y+g6SN21
 gNKlrpvgcIZQm8xdXlWaU3wANSyyXFTP+/NtgAhQA9AbVXnZ+tn9ytwXKijJ5Bo8rP4q
 gjLgo2epwNd3/pTCRO7WgjII+bjY+WLjobn6qOji9gu6CvUpNUF951UwaDTypgZtJD/G
 aQBHR6LVmVJ3dH5FHyTAq/h5X35yB5K7ULwVzGElHP4JMaRL0LmPbC3oGuiihl3VUZzw
 ydEpFH0Xi4COaIpLL61rUdORvLD+ONG+afXJJWMhOEMQP8q3EauPtutvJUvRyNT6xrlY
 hQDw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779690925; x=1780295725; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MG808KzbtxqZEuFQLQP9DNJD3nqwzMeV4M+Kf1Sb4wo=;
 b=dK8nZmv/SkDsDNNKnYagpdI98bK0BnftAhnIX5HgQrFS2JEkDX1qJCLUruZvtjeeL6
 oHD+3bTtLLWsRcYz+76i4fmqLXQtF+WPgDEXo4F3MHwos+yeMBGTXvIIpgxjRSQLbH+D
 EW7gx7aw4KEC/hqc86IYHcsYCz5Cl7NFgE0m7ChNv7M7ilGU8Q1kZkGq0hnuha2WsE8u
 dMKkPsk8HsmGOn/jXY13jkuRsZDtojzaP0dibaSuFxMc331JSQDaEB9mWq4ICw5//MUS
 OLuDQw6rK8Fw4B5TbVX2/gvzpwgHqWfbRqrqFxRV5jJa9rlPm1WG0M/whS0dVswr6B/1
 c4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779690925; x=1780295725;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MG808KzbtxqZEuFQLQP9DNJD3nqwzMeV4M+Kf1Sb4wo=;
 b=VeCbNukOP44IPSyuWH4jY7VCm393TQCC38tANooHMlqIL90X9Gh19z7+/04HG/4BvD
 /wiigE598O+bZbtB5VA8YNi+xLUv5+GjZMXtbgV9gmnFJAHPrHY9DNFpkDE17fNkAaQx
 QixW7Qz3hV1YLalnsAUc3U5iOrbS1Es31Pf17NUz/HbsYZNllJQv6OybPF228lVG16G7
 4VjyWNFTbg7sll3k46gHFulBRfN7G05FmkeODETZaSsuEY3vovNKHPa7olOrG4x2eaNo
 wELb1JFpp+GDYj/LUPjoQn09DRcrjjxv3OT+B/a7yyxrpNZ4VwMH61MR32a0NWa7/nmh
 /MeQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DBexy6WHah7EYpU90vWnZF4oP/RknsrNRPAN/QABq8l3dJHcnBED+ppGD94L7vcIW+tc66HU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9ajTVMvq9bTUO9mgdLMm0lAzI2aIjJDHDXSXqKeEg/XiV5M06
 5Bhv1MAtjwiVI083MCuW2/E1V8n7zeZc82W0ovjc1xpdCDLgncdGXysDT4PtECdEAHj5YfxZ2Dl
 kMBJassee1w0WwazuGbg1N5HSFUUYLUtEylXk
X-Gm-Gg: Acq92OHBL1tPqYRRV33atcdRuLW+QLNX8R3eI74PSH3zOQ2fqS5/qk1zbURSLhQc0w+
 26WUDD9X2kZKRGQXcRUfj6456Wn0zPAmU4if074QmvVKnmbj7I4D8/fLXJzXJqAthFEdztZYjAw
 wQ/p0aZOFypQtR2Zw5fo64TmosW+TJOOsdOguwaF6CrlegsRU62+RKRNGkFXyIxN/193aZcB7yV
 5ZEiaOKjuAbg7Ob+LiL0WWezLcmyTFSuiroNA+VbpfUavD42QEQ85LT4HIef0B4bnlM4zp6mj/0
 CLXD2PBB
X-Received: by 2002:a05:7300:730f:b0:2f5:3641:f126 with SMTP id
 5a478bee46e88-3044919da81mr6302308eec.24.1779690924908; Sun, 24 May 2026
 23:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260525043714.2374516-1-peng.fan@nxp.com>
 <20260525043714.2374516-2-peng.fan@nxp.com>
In-Reply-To: <20260525043714.2374516-2-peng.fan@nxp.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 25 May 2026 09:35:13 +0300
X-Gm-Features: AVHnY4IDUGZ9jIKcGGDrsFshiWUiuaWVwB0vqnZVgy-1yd8APUjhe9HwH8hBQp8
Message-ID: <CAPVz0n02gLbv0pyXEw5Pxp-2G6SFSHq=YhOCw3U3-2bb5E15cQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] crypto: tegra: Use dev_read_addr_x()
To: peng.fan@nxp.com
Cc: ryan_chen@aspeedtech.com, chiawei_wang@aspeedtech.com, treding@nvidia.com, 
 BMC-SW@aspeedtech.com, joel@jms.id.au, u-boot@lists.denx.de
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

=D0=BF=D0=BD, 25 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 06:2=
0 <peng.fan@nxp.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Use dev_read_addr_size_name_ptr() which supports both live device tree an=
d
> flat DT backends, avoiding direct dependency on devfdt_* helpers.
>
> No functional changes.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/crypto/tegra/tegra_aes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>

>
> diff --git a/drivers/crypto/tegra/tegra_aes.c b/drivers/crypto/tegra/tegr=
a_aes.c
> index 7b374c757ba..55a4cec525b 100644
> --- a/drivers/crypto/tegra/tegra_aes.c
> +++ b/drivers/crypto/tegra/tegra_aes.c
> @@ -518,7 +518,7 @@ static int tegra_aes_probe(struct udevice *dev)
>                 return -EINVAL;
>         }
>
> -       priv->iram_addr =3D devfdt_get_addr_size_name_ptr(dev, "iram-buff=
er", &iram_size);
> +       priv->iram_addr =3D dev_read_addr_size_name_ptr(dev, "iram-buffer=
", &iram_size);
>         if (!priv->iram_addr) {
>                 log_debug("%s: Cannot find iram buffer address, binding f=
ailed\n", __func__);
>                 return -EINVAL;
> --
> 2.51.0
>
