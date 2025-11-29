Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BB5D116EA
	for <u-boot@archiver.kernel.org>; Sat, 29 Nov 2025 21:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D617A82A9E;
	Sat, 29 Nov 2025 22:20:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eafELShV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41862832AD; Sat, 29 Nov 2025 22:20:30 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E62480107
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 22:20:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5943b62c47dso2557377e87.1
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 13:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764451227; x=1765056027; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPoC6POFInQLZsKe93xGgoDEg+iqmcT/x+mbuatvBAs=;
 b=eafELShVAVxe3wmM2WxXz9w5VPvQP8u2VdUoWDHDRDvTHKbm1+OKPO3ajQowII+vvp
 2ZQExvBdVJq9rwqkW70o65cC3xrm1BjMWn93y5DTUbWcSAo7YzrujJKIAyo8Z3fOl3tp
 uRRrtA/2qrQUojWLvtUZAR7NyAhyGYEb58QXPeaL7MEfB4+uvBrMrS7/TvHFMY1Stuol
 r6yr9GDVlWMWxJzdj9K74s+afdLRnaBglWRg30nS+qCjV17mh/8cz0kmhVHkZDCwYo4h
 Cu1eQZ8NPeuomoJ61pE6NSaOBABFHYFce/NOA4wjmhb6ciXuCuWXljuEG2CMWG0pUoDd
 0n9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764451227; x=1765056027;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RPoC6POFInQLZsKe93xGgoDEg+iqmcT/x+mbuatvBAs=;
 b=Uoqyk74HP5iDjJorUiUSbsMLoxvbHC4+7oTwyl58AKxB9AuyE5sYNEhmkp58257o+U
 f/1xT3SFmwp1hY1x6LnZnZ/ZtpvNRihSltWt19iX7BQEEUclFugR3ewukApy3WZBZDZb
 M8lDYUi3zeD4j+Hp3pjM2EpKkEztDOBcnPb6XOz2+Hyox0qOaIvzQrm33ONshVSQLiuW
 xJ6VH+HBfCuCBCJxoDxC5BIKKqW7iZGUQLmqNNuQ4btz6EuW+XAlRnI3w59QJGdrsrwT
 XsJqBF0u1bbIsMa+ab1sjkLn+PfeohmxGlGeQQ8UC5XjnKj6gP5TcuLjVp9A5brog1YT
 AvMQ==
X-Gm-Message-State: AOJu0Yz5cnVnr3m5I8GlnGYfzB3fDG/D9ybVMY9PL7gfdzyhEOenZbTR
 KHmo/NQ/LupJ6Le0vRYNcTR5G2GshqEylZHcICkn1/34LqqeGhdcbMjG5z4gWQnu7g585hvuxGR
 KPfTnTbH+y+eBkDIWOmdXWIRH021AOzk=
X-Gm-Gg: ASbGnct/x3o0+7Ry94NOW01DVroJlJJui8WYEPuuy6dIAU9SZQbPdhoA/Z3QvkmEYEk
 56uW+2hRs0DRws4SGxcIgL9thKLMllYUS54mcQXsKOX1zlNz2yvN5e9gO5XSUgqKEZEu3g6dcdY
 AimXsP/X3yL0bp7nZF8L/tsIZt0LbHZiT8phICsrSjGFGo177DkqdZ23ndYizfZWlLXKFKry2Ej
 kTMDCU/tuPpazcu9LOo3AYT8Z58VwM6QqxuiLaGGKvLf/L/4i8I9/IBRVDIRq/Jo/Ew0byG65Pv
 93QrZReaDOhtBZcA7w/Jx20mzBHF+utmB3mMFQ==
X-Google-Smtp-Source: AGHT+IEUeVeJB/L6ybLKuS49pFhfmI0RBdhwXTxMfQGqv5DKWRNzZgT57AnvixgB3O9BFR62QOPjtN0r/4UsnwYzw0U=
X-Received: by 2002:a05:6512:3e1f:b0:595:91c5:3df6 with SMTP id
 2adb3069b0e04-596a3ea7e1amr10868356e87.14.1764451227243; Sat, 29 Nov 2025
 13:20:27 -0800 (PST)
MIME-Version: 1.0
References: <20251105140609.117866-1-andrea.calabrese@amarulasolutions.com>
 <CAOMZO5Ach-Dd3R98zD31o1THp_M+yRu8=Pa4Ph6w3aeVJ3MboA@mail.gmail.com>
 <edd4ec7b-de13-4db8-89f3-d56f8d8242fd@amarulasolutions.com>
In-Reply-To: <edd4ec7b-de13-4db8-89f3-d56f8d8242fd@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 29 Nov 2025 18:20:16 -0300
X-Gm-Features: AWmQ_bm78_at5LX5d8xK3e3k0UQBPyEcOj0HO8d8YV3t1SxppfkmSuCb7lTGSSk
Message-ID: <CAOMZO5BjgOO4dpvyss580dOmScWG1iD9gkucTTo1N4YMz8a9EA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] bsh: imx6ulz_smm_m2: Add imx6ulz BSH SMM M2D board
To: Andrea Calabrese <andrea.calabrese@amarulasolutions.com>
Cc: u-boot@lists.denx.de, michael@amarulasolutions.com, 
 dario.binacchi@amarulasolutions.com, trini@konsulko.com
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

On Thu, Nov 6, 2025 at 4:47=E2=80=AFAM Andrea Calabrese
<andrea.calabrese@amarulasolutions.com> wrote:
>
> Hello, sorry for being late, but I wanted to make sure everything builds
> properly now after the previous mistake.

Series applied to u-boot-imx/next, thanks.
