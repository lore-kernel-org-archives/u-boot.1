Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF94E74AC8
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 18:28:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85407895F3;
	Tue,  3 Dec 2024 19:28:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j/eD6oHu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B03288FAF; Tue,  3 Dec 2024 19:28:13 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30DE289649
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 19:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-53de84e4005so6879616e87.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 10:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733250490; x=1733855290; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8aDcYL0bSvUyKV/CRCfgeSoO4s0+UirsRfIXZ1AYxLc=;
 b=j/eD6oHuN9y5m6uwKkuNN1vFf4saUw5tny3wB2FXKEHp+qUGD9ISjrcCgcMdS8hVbF
 j7A0F/Tioco9HMy0L6cpyscVR3H0VNzXgpWBaKD16NE1Xg1IN6tQXHUWJiR/ABHunf7S
 nVNlfIjEC8F/LmTXALzaftzsPDgKIG2kkpMH24RzFuf/D0//dJ8CbLfCJSfNw3n8ChL1
 955jQVuhz1BDJPJ10dMOe+k6sr2EPSz5fjX4Nljd1614cjqgN+y7unxKaKDDkZclpvwg
 /zR64WLEoh+meFPbRVFi5tahpc/sbRFaCnzCzariLrW0X92sZJJtlmQzt60hE+dkxCn3
 FuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733250490; x=1733855290;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8aDcYL0bSvUyKV/CRCfgeSoO4s0+UirsRfIXZ1AYxLc=;
 b=Q/ywXLXssaiWe8S7xcBVpv66wb6Y6pki+2x9Cku6TShsabLycNlvs5KX1eE2Zo1/0Y
 p3fE8k6/Os4CXojxDGpwzzy3hbwLu97xkXHFLoPX+eMDz5xhtD2rKUJJbqwXVhAP2J0x
 6oUViCI/mEKa+/hv5+Ifuypk7whOVJn2N4dkRub0P3IiShHJ076IsN0YD/ZKtcPEKd12
 7aciM4HDXcfoeHGP7jeIasYB05ImPJckolzWy6Ay+lKN03qPj+jh2bwFYwtO/+eg9kDs
 It7wiIQeLUkjbAYeXhiUdtWawiI19Zh1fVdzDGGTFa7DSzA30T48S6mE3omu0suI7NWJ
 a7DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW6fS57QYtVn0r7tXQ6qiS1NFcJVN9mnYSa2u0LFlhoy5nYnuzQBvnbWFCqaN30saxMhB+mhc=@lists.denx.de
X-Gm-Message-State: AOJu0YxGrSjAcaI+h2b9cLRGLGEP/8nLi7HqOGlVCr7o3v0WuPy3/Sqq
 kMmb5m8RTWu1Ys4uoRPR28zanKLyBrtrnTvsVEBkMvAfRmq/FyoNYjAWSO7I3lKHKVz3QGW2pHa
 KNdFuOWGKmXuzgmh3YWzwURFfBoM=
X-Gm-Gg: ASbGncsWfxKysNxnT925sobbtvuOjEktk/j4iFfs5SIhAn0SlXuFgKT43CKqeGuPOun
 EoUbuFhebmq2rg/KeLXR6NLTMF/EScN5IZbrHIQkz9UJZaMRhw2wGDZwaJyK+D58=
X-Google-Smtp-Source: AGHT+IFu12TjwOU2aWK+p5YQ2nsooD/dLy+v9rw4+7A38V3YDvoE2d3YeG8P7ERDlydxeqS3tzZXGSaZlwfuRg0Zjdg=
X-Received: by 2002:a05:6512:3082:b0:53d:e8ed:2172 with SMTP id
 2adb3069b0e04-53e129f4d0cmr2025709e87.14.1733250490157; Tue, 03 Dec 2024
 10:28:10 -0800 (PST)
MIME-Version: 1.0
References: <20241203-imx91-v1-0-48d2eaa4519e@nxp.com>
 <20241203-imx91-v1-1-48d2eaa4519e@nxp.com>
In-Reply-To: <20241203-imx91-v1-1-48d2eaa4519e@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 3 Dec 2024 15:27:59 -0300
Message-ID: <CAOMZO5BEEM_oWtoQE05VVTwKFiUe2yXwBvJyfeo089VSR1VkKQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] gpio: imx_rgpio2p: Move 8ulp_data to data section
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
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

On Tue, Dec 3, 2024 at 11:37=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> have_dual_base is set to false, so the 8ulp_data will be put in BSS
> section which conflicts with the area of u-boot.dtb which padded just
> after u-boot-nodtb.bin. So move 8ulp_data to data section to avoid
> its content being corrupted by dtb.
...
> -static struct imx_rgpio2p_soc_data imx8ulp_data =3D {
> +static struct imx_rgpio2p_soc_data imx8ulp_data __section(".data") =3D {
>         .have_dual_base =3D false,

Isn't it the same kind of problem that was discussed before?

https://lore.kernel.org/all/20241017034507.GJ4959@bill-the-cat/
