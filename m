Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7969C197BF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 03:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68A33805C3;
	Thu, 27 Feb 2025 04:16:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LHX6HtpA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21D8F807FB; Thu, 27 Feb 2025 04:16:09 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CA328006D
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 04:16:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3092643f4aaso4840461fa.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 19:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740626166; x=1741230966; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pnHlvibFWQK0wD3NpRpmNrCM+nBUN1ssd0Jo8B4GbAs=;
 b=LHX6HtpAQ+/JP3J/9X9PckpLUczPklUH/Utb5Yaol5cTt9+71nIjoVECco4mYnX2/o
 1cQEactb2lDnAqzaEeyIAOCH62In8h+zqHd6sSlYZkSDuQU7x6qHCDDA6ZCtuf6a1beq
 NxvpEJDZFKflQ7To1qhjApPKQphhttqqtAZdbkqPoEaUqRIl3NZkobid6jR/srN+w9Tl
 jdPZ9P8ENVmzN+t7LincSAxoSuWzzyzQ7yeaKg/V2R1XYs1ahiJeEzz/99pVvb5q27zs
 dM23ZB1PQmMVlKm4lmXJ7ReH9Xs2ErmpH5JG/xN48jTr4IOpSF+sjhT6KSRuWxBsn14N
 JvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740626166; x=1741230966;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pnHlvibFWQK0wD3NpRpmNrCM+nBUN1ssd0Jo8B4GbAs=;
 b=uxw3/Jd6vlnBvRcXBCD0g6YOa53Ijro1BiHNh8jdU8Q8CT/pmgJKikIYCB1HRQWO+5
 TjhPiEE81w6S2vlLd1syzSqvtfeQslu3AjLdt/VbboRhswEIkGyb5sHvbMVcV1WAtymo
 yilD41mifVLRFj9czFrdgymeVj9F2wszraQ5cTQiIKF+6GfP7yFbtxpUgwEj0DdDHdJf
 3rx1dXvbRBK8PXlyP4pQmBe8NAAJXm/d6GI/meiT8xmh2cg2NA4N7Wx/bA9k86YgJb3T
 ptftM136mAuYT5NSIi3q8es1eCQM+JLqanEnBu+ilg4K9dgoPEXi4xX36wCnopC5uK3V
 1oPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB/njncXow3CeWvVDM2mFqA2AaRSglRM17uSi9ZtxiPzD56kVIyTZA/5c9AeBzyGRIWz69zz0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx774x+TUVYhMdKzf5k3k2icEyYfnWM2ayP0d1/TarYgVeKzpzN
 GVpshqWnS/pj7qgV/JDwArAcrGDlmQ5Smibn/XeJoiOk1cslnTvh9XxbZqFN013ApBqUSGoUF7H
 fwjYGRZKyy8POAyCkGiJp1pnU0jU=
X-Gm-Gg: ASbGnctAKWvTNb8hBjxRAYZF0ZInwqSPXnGuqk1BCO/vIrrQcbwdrOON3K3mVlnXSK8
 IKWtcCj3KsB7snl+AgmKQs5t7hdEgKl7tAWx87vFbmDYXsqQ19JtVq7ZdYxZC21Xwj1IrB110tx
 90WWWDYHyzjSiThXB91BOLw+AszsroFY3mbVPG7Sk=
X-Google-Smtp-Source: AGHT+IFFWRGp3lGnclyLApeBxRva/+vMFurRxOu4v14gE3Fio8eada22wpCfJq8tzRAmiZyiiJGuuV/sFOifaqI5hc8=
X-Received: by 2002:a05:651c:61e:b0:30a:33d5:daef with SMTP id
 38308e7fff4ca-30b846c46c3mr5725011fa.13.1740626166131; Wed, 26 Feb 2025
 19:16:06 -0800 (PST)
MIME-Version: 1.0
References: <20250222121711.6697-1-peng.fan@oss.nxp.com>
 <20250222121711.6697-2-peng.fan@oss.nxp.com>
 <CAOMZO5Drcqztvz1jE634sumDZk6Rmw5RJ1GzvvkU0mPJoDg1RQ@mail.gmail.com>
 <20250227022748.GS2640854@bill-the-cat>
 <CAOMZO5CeOjL0iNSQeC-S0u10vx-T-Kkj82-E9Aes5jKTB227tw@mail.gmail.com>
 <PAXPR04MB84594EF4E0FFE527C9760D8588CD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB84594EF4E0FFE527C9760D8588CD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 27 Feb 2025 00:15:53 -0300
X-Gm-Features: AQ5f1JroOuqWY4nSiQV9F9wmarXJ3BMbVGPcGLk_t5clPyltvc0dnLG6ttsgzEE
Message-ID: <CAOMZO5AsDdS8qiscaFaYf+c6+GSH-rMPb6y-EFc_UgBV1NM+Sw@mail.gmail.com>
Subject: Re: [PATCH 2/2] imx8mm: imx8mm_evk: fix BOOTSTD boot
To: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
 dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>
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

On Thu, Feb 27, 2025 at 12:11=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:

> I am just trying your setup.
> Appreciate your effort on helping this.

From what I can see, it is only imx93-evk and imx8mp-evk that lacks
setting kernel_addr_r.

I will test and submit patches for these boards tomorrow.

Cheers
