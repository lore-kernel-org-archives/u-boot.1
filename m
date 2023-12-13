Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2948AC4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A985086A81;
	Wed, 13 Dec 2023 17:29:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cW0YX8sW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 364418784D; Wed, 13 Dec 2023 17:29:15 +0100 (CET)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6077486564
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:29:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-28aec358bf4so151845a91.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 08:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702484951; x=1703089751; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqM/Awf6kqQcaMTOYm4fGriNfmcHnTXtMrZ/Mmkqt3s=;
 b=cW0YX8sWRCdAibhNmAJvOJE19CfRyJcBC6T1HKso92wkxuMFhm9sPD3rtdAEBaxAym
 /wYIlDmTuVSHNUCw+Zf6hhaaxAjKIeTkKGanOhNWhLPnK0d77B6d/P/R5uiwiBh+wLIi
 spVt5rHQHF8DTlhvlyCYmKfekg0+TgBEu6hB4bRs+umHMAdm9O39PUKycR1a6BQ0Ji01
 D8PLLXYP1SWIlDCldSPJ7TGCQkbBjeNMMYur7HTa4+M2Ntu7wYXvG1/xKVuxPK6tzgnV
 HyEYN2yMBmjIaZpzzkFSiy/l6b250al4Uqwkj1WYqXlX3jJbzLeTt7UETEAYeqh7DAkn
 9Ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702484951; x=1703089751;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pqM/Awf6kqQcaMTOYm4fGriNfmcHnTXtMrZ/Mmkqt3s=;
 b=Rbo2MqNd6wCC9Dwu0AAtEcPgUnfAzatnPcC7M0fw7YyzADyGXk5Xs2i3r8uglSFW1/
 2Bd2Oqvfl03atXm6qWi5VSJylQimpXmQJF7mjnm2x9ts5qrnUyvuj4aOxm1z3bRr/CdO
 10lldfDjOOVQ7XCsTRf5zGKsr1GAJdr4921b9SETYz3Uw8CSMNiILE8G7Emoxa/k3EJC
 Z4jV3z/0YGjJTNiYNepn9RKfA1msVFhuIHuz0nfCkS4ByTu87qA7g4GkBG4WSvcaI4Xk
 rPJZmBq0cTyiHbtGLEq5znCMLeE14R15mBFurF9H/8q9keQj9B5Q9QCtVUU52KBfv6U9
 mTAw==
X-Gm-Message-State: AOJu0YxEKfooSfkOP/yilP6Kztv+zPixZtdakuQ+h4hJubsXK3G69kqK
 QlApqEaN01wAurnR5ZIGVO3/9iVBCB1vfCS2d1Y=
X-Google-Smtp-Source: AGHT+IGhF++WEt0Q0jJz7uMMV1ovVpoxv+ZZSJnFDHbg4WkYivu2z07QlcprNmRZbFrw/dFoAY4meUojkBE6BTnZcmI=
X-Received: by 2002:a17:90b:681:b0:286:5987:f74c with SMTP id
 m1-20020a17090b068100b002865987f74cmr14028530pjz.4.1702484950832; Wed, 13 Dec
 2023 08:29:10 -0800 (PST)
MIME-Version: 1.0
References: <20231019215113.1833803-1-festevam@gmail.com>
In-Reply-To: <20231019215113.1833803-1-festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 13 Dec 2023 13:28:58 -0300
Message-ID: <CAOMZO5CLp_wHQhfrio5vwUSQ99xVOOASOwmF4_fx+zcBAZuCkw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] imx8mp_evk: Simplify Ethernet initialization
To: sbabic@denx.de
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, hugo@hugovil.com, 
 Fabio Estevam <festevam@denx.de>, Hugo Villeneuve <hvilleneuve@dimonoff.com>
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

On Thu, Oct 19, 2023 at 6:51=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> With DM enabled, there is no need for board code to initialize
> the Ethernet interfaces.
>
> The RTL8211FDI Ethernet PHYs have 25MHz oscillator, so there is no
> need to enable the RGMII TX clk output.
>
> Also, there is no need for describing the deprecated phy-reset FEC
> properties, nor passing reset properties to the EQOS interface in
> u-boot.dtsi.
>
> Remove all these unneeded pieces.
>
> Tested both Ethernet interfaces after these changes.
>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Applied all to u-boot-imx next, thanks.
