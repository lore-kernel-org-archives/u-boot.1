Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C207C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 15:54:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 866D2807EE;
	Wed, 26 Feb 2025 16:54:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fMgFtL3q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47A3480F12; Wed, 26 Feb 2025 16:54:44 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C2C18004F
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 16:54:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e0b70fb1daso9474197a12.1
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 07:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740585281; x=1741190081; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xL+xw2Aw3r+AqvgFsvVUq6XxhSK3pP8lfoSWv8yszpg=;
 b=fMgFtL3q+XVUezRlF9iSN6E7nqxtC2h9yFHXEX+2puIMHEB35rdnBfhCyCOYwKoRQu
 3OKInTWelSNP/VRzVpBOBoBmerCuVWogJCXY9nxNW4HP6q3PLLfRD1chylrKf5BMn88M
 61EeBVb3YPVrCoIqiG6bvWagraV4guuK/6eOKIYMWUNwmi5Hw/0ew/8uCJcnVICS23fZ
 /Qw/letoCDKh/c2SS8Q3+OqM9QfG2V0Udt8KtQnOy9d7x8/5YUQk0tyT652eh9JTO4qL
 EhAbmpcOFTpZff5vvPODfxgfuzvz/zgq8LTnsuTheytbVP3/0LNC2FVAjsn2PDcbfa6w
 h22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740585281; x=1741190081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xL+xw2Aw3r+AqvgFsvVUq6XxhSK3pP8lfoSWv8yszpg=;
 b=CP5TFfZ+Ghor02Ypw0ReW1NRDtOhN0B1CC36cibG/+LtwiiuXfcjiVur/EpkMxomNi
 B4r8g6fIRxoIuWB7k4VOa6/jePVqqz//nO8yjpGnScVOd4OUBWP24z9TqpNYR2swZ7vb
 wa3JV8M7Ua3aoxJ0YSaSvovgA4dwJ4ijZj6pJuQyZ15RTfNPwdxhZdlHdXng0XKMtZep
 rtSk8OTv+/A+h1SQFKJZP5TSE6zkb5G9hYC91oj8dj4IeLfORRGlk50+VQDTtvvfrQTI
 XYI8JroFzf6bVNTXgbGLeZiyNFTglURH2sYDLbEbzHaOcRJM26Z9mTwbSiackDS6HC2V
 1q7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBwL6I0kmC6rAF0MiY3k966N1n73JZDlW1EtJuavldtY6yl5DZYKI1HPBtZ8HuqSV1EjjcV+A=@lists.denx.de
X-Gm-Message-State: AOJu0YzntGS5tanuQ/IVgPKEo9hZJVVBUo3OTvZeuKXAyWlDltZuEa58
 ILp+1EJo1nivoYFA5ykwqVI9IssAMUIRW46aNcKDQ2GjvFkGrhRl
X-Gm-Gg: ASbGnctlQsDjn+CbZIrjPxQsqNCd/WIpJaxuyXgARIQIK8K1OHsx3ehguJ6BuRzwRqb
 /ayz9g7LJKLYGDtnFgQwu41SBy1BRfTdrxXbbv2ZoYNzSGeVprJ9Q/tGai1gTnDe66UUfsH6dYu
 gkl2HXrcOm0QIK9RQO6Kp148XErA5umDuFPo8lmCD1/fiw5gJW+suNDZlhY1FI4EJMfLeB0ZTra
 zabAhnZUs12EUk4yVgmbF7xpjLPz00mFbyz2R9CVKp5joiUwVLTl+nxLDDJUBgVAYgQ263Fjnhj
 7Q2PtqwoMwgwrnFdqq6UWPNeXu8VMHEpiSSDRmC69wnBhgKPshqPY29WUa3LoMEGt3enhEJmmJl
 3SQ==
X-Google-Smtp-Source: AGHT+IHzcTLAAZYtrgS/xRMRmyIBTzvv6btGp6HKMLWs6niiUU/Cs8bJ2GYlkNJzz/HT1K+pdG5+dA==
X-Received: by 2002:a05:6402:2b95:b0:5dc:7725:a0e0 with SMTP id
 4fb4d7f45d1cf-5e4a0d830eemr4764150a12.15.1740585281184; 
 Wed, 26 Feb 2025 07:54:41 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e45b7174cesm2938378a12.34.2025.02.26.07.54.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 07:54:40 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>,
 Kuba =?UTF-8?B?U3pjem9kcnp5xYRza2k=?= <kuba@szczodrzynski.pl>,
 Icenowy Zheng <icenowy@aosc.io>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/2] sunxi: mmc: Fix T113-s3 MMC clock divider
Date: Wed, 26 Feb 2025 16:54:39 +0100
Message-ID: <2359168.ElGaqSPkdT@jernej-laptop>
In-Reply-To: <20250226113712.1257061-2-andre.przywara@arm.com>
References: <20250226113712.1257061-1-andre.przywara@arm.com>
 <20250226113712.1257061-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne sreda, 26. februar 2025 ob 12:37:11 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> On the Allwinner D1/R528/T113-s3 SoCs the MMC clock source selected by
> mux value 1 is PLL_PERIPH0(1x), not (2x), as in the other SoCs.
> But we have still the hidden divisor of 2 in the MMC mod clock, so
> need to explicitly compensate for that on those SoCs.
>=20
> This leads to the actually programmed clock rate to be double compared
> to before, which increases the MMC performance on those SoCs.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reported-by: Kuba Szczodrzy=C5=84ski <kuba@szczodrzynski.pl>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


