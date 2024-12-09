Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6318E7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 12:24:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05F1F895DC;
	Mon,  9 Dec 2024 13:24:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MKQMlVji";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B2389618; Mon,  9 Dec 2024 13:24:22 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA7A489207
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 13:24:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-54021daa6cbso472705e87.0
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 04:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733747060; x=1734351860; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9sU7GpuJzDDNoS5JTdq5ZaosWK8PQGp42sdEsSvSFtc=;
 b=MKQMlVjiEA4lB6lPwRrCnJYOIxSpLYer8rRyIjXsNVZ0Yzn6MRMM3EWjXUfnfqfL86
 BKTFz5MId7Hw8jHhlhk47FiiMMotsGa6JupnXFVDYEbQVEjC1kHrzdxGsTuGrEv7Huwr
 Vp5FtJLgn04keSQFzxiyqLON/1vB63eXU2ICe5fvnfmnfMVM24vIVVpFRIZmlnqdyeh+
 wmoh4pE/zxoqSQwZ8H2BwxA/7sJYJAZxs59kBNWMcD2Rd+j1lUJcRVzyuzjiL6fW2Pe3
 Zm0X59LWucds4YxgXiVkOTcB1XgcqjthsbFWeh4ouvgrhKIUejXpfwmPgOp2OhBYOEVp
 wAfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733747060; x=1734351860;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9sU7GpuJzDDNoS5JTdq5ZaosWK8PQGp42sdEsSvSFtc=;
 b=NMwt1W2/tGKPOoKMLkh1Ypg4k5uu4cWKAaw3P4zOThl1UaI5bZ+g5ANHMCF4W5YWTE
 EYhjz1QGPsmBigreERaPlwkQCEQGpIV6Lt7lcRJqxn9RxKJoMzhuJU9ylry3HxgcFjJr
 29xrMmQS0f+0HJ84/6+E/abGxlV/1hLbFxBZJTF0f4ekm/pd+IRj1QVXAH0YR4Hro3hD
 bwjO9tCjA7EuJeIbiwe2fendp8pZq+08InSiq4JhxgWBZuZd1qJ6Is0pQBNxspvHcTA7
 YSV54hnnMN30m58tNx3U4k2zpn2hPZgqTHgY0hn8AGx3ofgeV6LycUq5qCEEkUPS8XCB
 1qAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7m6RkdJRaX0skxykc9e2D2lJBDZGgXLzm2pcFX7hnxhwVMdroGHLTF7pjXa1rrLoJHBTHV8o=@lists.denx.de
X-Gm-Message-State: AOJu0YwkfUgBYXofuIdM0eA4l7jM8zGfcg/bXXmVmR+qVusdE2MfvNSL
 YgQFEF752vuJLPhrZox/NlMPWqXRPjhQGAOeB9M8Wf5FmAzMwtBh2khjvIFrfZKkb2AONuOJ5mR
 WUkbEVmpZDZe4WxDCwmY1fSHQU24=
X-Gm-Gg: ASbGncvyGjum6B14V79fcz0mL+/fAATP23Fp7bZwOLIc5WlIpeH6IdrRwyCTc+yw9Ob
 /yZxEbQObIqy+WO1Oup4f8w9DzrAMtdIFwrpuXa/NdACU2keZ2JSJMPD2+VFe38U=
X-Google-Smtp-Source: AGHT+IG4Znc5ATS5vhvmikMLIJv/gId/QBLxeq/UGTFujkvCnC7VZZxSC/iJ+dcfXMvFujVwJwhbaW93KjR+rldyjeE=
X-Received: by 2002:a05:6512:4024:b0:53e:39e6:a1c1 with SMTP id
 2adb3069b0e04-5402410766bmr103499e87.43.1733747059905; Mon, 09 Dec 2024
 04:24:19 -0800 (PST)
MIME-Version: 1.0
References: <20241203-imx91-v1-0-48d2eaa4519e@nxp.com>
 <20241203-imx91-v1-1-48d2eaa4519e@nxp.com>
In-Reply-To: <20241203-imx91-v1-1-48d2eaa4519e@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 9 Dec 2024 09:24:08 -0300
Message-ID: <CAOMZO5DAyyToAQXBM+4wVzr1ZHvegyyRXBL1Xq+Qmk12hg5ywg@mail.gmail.com>
Subject: Re: [PATCH 01/11] gpio: imx_rgpio2p: Move 8ulp_data to data section
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
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
>
> Fixes: 51cfa66f2c4 ("gpio: imx_rgpio2p: support one address")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied all to u-boot-imx/next, thanks.
