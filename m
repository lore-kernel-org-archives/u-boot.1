Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDFDCCD193
	for <u-boot@archiver.kernel.org>; Sun, 26 Oct 2025 05:59:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC567832AD;
	Sun, 26 Oct 2025 06:59:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lwUFfwhB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE32B83623; Sun, 26 Oct 2025 06:59:45 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDF5682E34
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 06:59:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-63e0abe71a1so7079780a12.1
 for <u-boot@lists.denx.de>; Sat, 25 Oct 2025 22:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761458383; x=1762063183; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6NZo4xjZn6VpoDmgTXQPGhDEhgFnksDmFJRaagzP1w=;
 b=lwUFfwhBI/cF5QGkremeJIfQwtujC03T9NaR3SE+IEXGcwtxHVU+1owO3hN5qfUkb+
 bNmXftPAwyj9bhhzjNiRWCP4PCmnxKDqrrLPzmttzK45JnBNphCXjbXalIJwjr4jtJbj
 PxB3ZXwwb/PC9QtN8zNb550JDl03GjcOrFG+gilmvA5hxXsb7g0eRaRCtMV39G3DcmmG
 jfNh+pFPstOTu9B6f5TNA3A/Ce1jVQ6wwzP1+x/NierrwYmz0XgqpWyZrkhGO+2mDVB3
 wCjquNrQxd2ArSEUuzcGTF6qRnippe3EEvYH0bOj5pfPQOZkR4bANmZQtsvXZKWSvgbV
 c9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761458383; x=1762063183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A6NZo4xjZn6VpoDmgTXQPGhDEhgFnksDmFJRaagzP1w=;
 b=RH8Sod61yVB3figMlA5/wO3ee1SMHYYgCov9UD/Jkn7YqE2yNUFGA9HEJiooABk9Jf
 gIOcu66kAgSB+A89+H76uvROz502hDKdbttG2bjCZ0r0waW1g4WPBoxBIHGJEwpY8lv/
 LOEb1EnFgq8nMySvuHwopZlSFx2s95hi1smFhgxvKOFQQ7PxdmhnhotBepnIxMMJaD8W
 /khuVOoA4DF/7SZQhrU2pnE28VOdn3zHHNXsKmNsnZky7l62ivJC3l84OpuEy4t2dttL
 vwROTQtUapiQSsx7RvbxVaWGL2Woek0XEYirAR2ZNoDA7Y1Xz9r/F8+p6ltiAlynWV5c
 y7Zg==
X-Gm-Message-State: AOJu0YwDcbvi3SLY7cgB7uAtHnQrk9jIiX7Xvu3UVF0ybX+EPxXS/0tF
 sHEe1FxGTREq8/k3JkqUj3M9o5Q1D1GYaKZfwhvXrkjBfD3m9DTK9SbCtujS4g==
X-Gm-Gg: ASbGncsYn4aKUGQeBsc78EjZzwnhBfvbxpO3bCKXGfLnL804/YllvXVht5FQdPK3biP
 6LLbMfY8Bz4cOdJhT/1dzqIY1qK4pZO1so060fVAJeSthM44cT59e2RBsLzy4xq/gixSZY8RWOw
 nOnmHVRh2hilaEk7JvlIjAPDEpAc0DaNUCpgwI3t0b0R70G5NHV+7Ml0SiRiQEtEkpNp4E76oh5
 Mfnug4edoNlCf5Fs+1FBTn3mPRQ5yoa2MAD1JpYMeZkt9dRtb1yi1qlFCzd4C3b3n/0zJz/29m3
 Z0GZoU/FFIbsdtrfhzf/kmy8wVUQVjUz7HAO6sUrRBNh1FZPkMGZpoH2lq8t9CLQ5ERBNF9Gefz
 4x67uQwbm5/AaNebRFG0yFDiuTjSjfncVMwgVqY5dLdxYqz3XKWBCFMoz45cv5uT7vkLZTv3yII
 mWwiuNnubqzkWUDajV112Syg==
X-Google-Smtp-Source: AGHT+IHskUzJ+v07K8gkLP0h32BSIFq0ZCZoEpPqqhZkGYDv/82+sS9TmsErXWD82UWmubewSnK+BA==
X-Received: by 2002:a17:907:9415:b0:b46:31be:e8f0 with SMTP id
 a640c23a62f3a-b6d51aeff5bmr1340800466b.3.1761458383172; 
 Sat, 25 Oct 2025 22:59:43 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85308c82sm381232466b.5.2025.10.25.22.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Oct 2025 22:59:42 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: linux-sunxi@lists.linux.dev, Chen-Yu Tsai <wens@kernel.org>
Subject: Re: [PATCH 1/4] sunxi: switch the Allwinner T113 SoC to OF_UPSTREAM
Date: Sun, 26 Oct 2025 06:59:41 +0100
Message-ID: <2801929.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20251026012357.16773-2-andre.przywara@arm.com>
References: <20251026012357.16773-1-andre.przywara@arm.com>
 <20251026012357.16773-2-andre.przywara@arm.com>
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

Dne nedelja, 26. oktober 2025 ob 02:23:53 Srednjeevropski standardni =C4=8D=
as je Andre Przywara napisal(a):
> In contrast to some other Allwinner SoCs, there is no difference between
> the DTs for the Allwinner T113-s3 SoC (sun20i) between the U-Boot and the
> Linux kernel repository.
>=20
> Remove the old copies of the T113-s3 related .dts and .dtsi files, and
> switch the whole SoC (represented by just one board) over to use
> OF_UPSTREAM.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

While I haven't actually compared files, those weren't changed for some
time now. It makes sense to switch them over:

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


