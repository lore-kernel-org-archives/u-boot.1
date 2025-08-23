Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64678CA0EFA
	for <u-boot@archiver.kernel.org>; Sat, 23 Aug 2025 19:35:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6BE8800D7;
	Sat, 23 Aug 2025 21:35:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W/tGKXID";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 882B382B20; Sat, 23 Aug 2025 21:35:46 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CA5B80077
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 21:35:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-55f3fc15e09so152262e87.3
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 12:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755977744; x=1756582544; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=58VH0Aeq4UjzLwTo4rnaOgmnQonBTfOCm3r/GE4CQn0=;
 b=W/tGKXIDLvzD2r1n+bSXnnrgfGLEVP9nR2qTsthULjIVwLG3KzQQiWa6Lawq+yG2oZ
 7txaif0uT+NS9NvSqpPh1iHN5FgP4A+vK5NXSxTYXnEObsPlCHguLctdPMuRetoYOtoW
 6vHQitpEU38fqatRvv3YDTd+YUE0ZjQSO/Bjp1g90x+j1j02F3ozCrJ6QETDiux/Xyg7
 2YW1WHmV3rWBY9DzK/vzSceaDdWEL8U0cYLW0k0tR3KrYP2RUXPB9RfPMkrlGel9reHf
 wXPH1/4k59n7JiFqu1sse6NRmiGEYRqOLa9Z2RPIb9kolJnARXxNrauuansMbIUEQF9y
 3lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755977744; x=1756582544;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=58VH0Aeq4UjzLwTo4rnaOgmnQonBTfOCm3r/GE4CQn0=;
 b=Lwf/R9gWeynVR4f1LaJTchh6qIHZG0CWk2QPx/+W1ei09b5yM/A0hTd45BmsJDLM38
 wVM8SnoTV4+WpkA1MxF7609hhCSnZ2ZftnwJblPnNMAKaO0tjqaBBLLKmVm2aIX4mpEa
 l1pWFRWS0HvkICTfgjOMh/1HmeQvojUJnvuewA+KpbAXjzheJgR9aq3BEvw4fz5PXH0P
 Y+n/fWUVqaP+tYA8ed1DzK5zB/zWb8zY/mEAbNRtcBm/CGhk4ktCvCzpzD7DmftuQJnK
 H3ODeRjDohdUzEESHyXhG/VrmPSq25shnXLrySk6DrqliwfCNEsi+ed4DdKgH7GcP5k2
 7B6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCURdXsQr+ByDsK5MX0shTJaAFmc4NnpzrFG2tNhjw7Wj/QqCadgbsZ2m3xwp+zug+GQDgIWA6Q=@lists.denx.de
X-Gm-Message-State: AOJu0Ywx5ih9gbkPPEoiMlaFOsMXnRVxAE11f3iHwjaOcIl2mMwsCtZq
 OqNvoOBNoLeV7h79LuVVYcyP8Nz0vkQymwW9bTTDzekig155VNbBsHey4kjWZ+fYGubDdfTasPi
 uuIHqpo3eBmXVXGdS7El3IO0llWJIYtc=
X-Gm-Gg: ASbGnctof6GgX8RJqxGkBJ+yNDL1cGQ0122xT+2SG2Pt6UMwuoFYWQHq19M+EXaTdF+
 wxq6z1OlURUAYB67lYkLPAkUQExPAqSnwlf25nvaNPev6US8x6fJVz8MOitICvEaUb+lH/Q/rb6
 YsHs/BHVi45R69VHWxDc0ZCx70rgqn5nWFSibotTao1//LVfDyrLrjzzvcH3SO/jsi0MwdXAMgp
 AejCsl80hzYFjTmiaZGOG6GyT9VnvbeH5hnmgw=
X-Google-Smtp-Source: AGHT+IESyGePgGQyLykHHnV4Pvse2mmu9Cd2cFT4kWmjR3PxQ2ZJhksgSWNNNqwy/wup0/RyQm6rqaPTkiCcCqn31Nw=
X-Received: by 2002:a05:6512:3b13:b0:55b:8086:c496 with SMTP id
 2adb3069b0e04-55f0d3ae560mr2372789e87.52.1755977743588; Sat, 23 Aug 2025
 12:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250819053941.908834-1-primoz.fiser@norik.com>
 <b63a3acd-5d8d-4e54-9f53-873cfd26872c@phytec.de>
 <252daf0f-1c3f-4bf3-9151-e1e4e7302e10@norik.com>
In-Reply-To: <252daf0f-1c3f-4bf3-9151-e1e4e7302e10@norik.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 23 Aug 2025 16:35:32 -0300
X-Gm-Features: Ac12FXwIyD3BtcVk4O-0vTRPA3KXmK-CqJr2tgJuvDoy-R9FVlq0Bd2BUD8mPac
Message-ID: <CAOMZO5C6CeA3rn459i=fwiL6aUG9s8b0fgo=O=ebixzSE1kmpw@mail.gmail.com>
Subject: Re: [PATCH] board: phytec: phycore-imx93: Fix EEPROM bus mismatch in
 SPL
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Wadim Egorov <w.egorov@phytec.de>, Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, upstream@lists.phytec.de
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

On Tue, Aug 19, 2025 at 4:22=E2=80=AFAM Primoz Fiser <primoz.fiser@norik.co=
m> wrote:

> Yes, I would like us to migrate to CONFIG_PHYTEC_EEPROM_BUS later.
>
> But we need this patch first on i.MX93 to sync SPL and U-Boot proper on
> I2C bus ordering.

Applied, thanks.
