Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25785C35FFF
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 12:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87BC088D93;
	Tue, 17 Sep 2024 14:15:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MF6X/ayh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9849688DB4; Tue, 17 Sep 2024 14:15:51 +0200 (CEST)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3D7D88D93
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 14:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f75c6ed397so57952891fa.2
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 05:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726575349; x=1727180149; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gvWZiJnzlOQEvlmeZyajavPKmNVPOo8hrVMjrfUVzho=;
 b=MF6X/ayhYTu4NNu6+p7tifOuSCdT5E4EZ0JkgHYgLd5RbUMDeF2UPwhdraN3y+i8eQ
 wmzIIU8nObiDpHlbb7LlDSt8z9i2WYpg/TDft3rDyjtvmG46GM8jNeiflCJ5SfkL9NWP
 4gPJ74WJbyyimB1senYr8U0iQdeWmqR5hfIDiD/nF1BdZTydpJxYK3Zm5nueUHAub1Mp
 FgQUgQShvJdWdgy0eXFueQxIFSCehZciMyf7R2iOzz5zGzfCZ5MGQ5ZPyJgxdUxNdICI
 wMie2D3ClTbDiYkdye/hqSbink+XXnW2fdH34nXg5oqzsgVGy7m+SmsQ3bYmXs+ZnI5L
 /IRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726575349; x=1727180149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gvWZiJnzlOQEvlmeZyajavPKmNVPOo8hrVMjrfUVzho=;
 b=HANbHk8D2fdt5cU8NFp6HDdscF/fRoxCUXm5gX0p8UdWhu4gRN6Re34LbBwabkqaKS
 B3mIztMSNOpnbUz2QQSDzwD7LXU3nyfhAcdwAmqMBMgMfevfHNPgPIk5fAu1OYAaFN0b
 4VIvoARQ2RllOkeSuVj9Sn08PxtUH6WUi33C7TkP5bMP4w2JOMq0vpRDXkIwCON9FScK
 YB5OsP93hjgHin2939wnkJ2U6bAlWkbPZxRLmlV9s3o2+2hMBmpraNDLRZmNnbmP8ymd
 dlQWxlmP8Cb37RFHtCKnKJzeE244FvhCEkQwGmTCmo+SY8z6Q6NcnYKDdjsNzJOwIJQz
 6HeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA5jsv5hidWIRld0JH4PvaYD42UKrzTQmO05qHrOAWJNchQCJRe+OpN9tRRMgiMTJzAOft9rg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyeian80kD47OG5YcBicsv2GObALhXEad+/8irFMUBWrVHcIRLG
 mrTAqUtTBM6vRoogl1ppxTV3aBv+ygMdGymcov02Zu06j9tWaEtFrZsqBwtEHNrbLm8xWlqvkML
 S+Q92Z1lrp4TSlz9S9GSBj6QeIEg=
X-Google-Smtp-Source: AGHT+IEDsjeH9B+/byTgt4F9pH3H3/6TjqXfslmIvqWJyd1ipUnZKcLmjhhmL/7T0+Bg+/I/z65a2baShdZ8nbKWK8k=
X-Received: by 2002:a05:651c:504:b0:2ef:2555:e52f with SMTP id
 38308e7fff4ca-2f787f2e66fmr103588921fa.35.1726575348399; Tue, 17 Sep 2024
 05:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
 <20240917-imx9-update-v1-21-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-21-4fe8effc937e@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 17 Sep 2024 09:15:36 -0300
Message-ID: <CAOMZO5CQSixQgB173VjNDhxa6W9i9HdjO3122B+5iQZO_8D6GA@mail.gmail.com>
Subject: Re: [PATCH 21/21] imx93_evk: Enable M.2 VPCIe_3V3 and deassert
 SD3_nRST
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
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

Hi Peng,

On Mon, Sep 16, 2024 at 11:31=E2=80=AFPM Peng Fan (OSS) <peng.fan@oss.nxp.c=
om> wrote:
>
> From: Ye Li <ye.li@nxp.com>
>
> VPCIe_3V3 is used to supply the power to M.2 card, we must enable it
> before using the flash.

Flash? Which flash are you referring to?
