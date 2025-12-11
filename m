Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BA2D41C1B
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 10:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 916D383CD2;
	Thu, 11 Dec 2025 11:46:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EtPcdnwl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AF9583B48; Thu, 11 Dec 2025 11:46:23 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33F9E83A26
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 11:46:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so8313205e9.1
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 02:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765449979; x=1766054779; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d/87YDKiYcZLzVS3pkKiOBEkpdlzdNDZH+w+dUxdDFo=;
 b=EtPcdnwlE89arMwWxkqIUR8g3dAap+IvEk6v17792jRdK/pG87b/1q62dYYPt3WmH2
 rECWmleB4NFK1r8bF3kMt+elugFkBwaECtu20FLkr6eNb7f2Af+BcvL/NglyQIDLYmkQ
 C+hIir3DjaHKKjwLMeF0dBUTiTux0EWdR3T1agPfpjk0Mzn99DhNXCjxe+6aRIfvYVuI
 1CJo3HQdi2TkDs6cl8b/S4PI10RhEnIRLiLrQVjffEPYS7dJ+inFxWtblJrWqDcT5c7s
 bn03jm5FUoNBFRWnncatbMorBYbk+uyenWjRTpr+EMYEO0ZEzk7meIEoWph8Nk6H3h4w
 Vrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765449979; x=1766054779;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d/87YDKiYcZLzVS3pkKiOBEkpdlzdNDZH+w+dUxdDFo=;
 b=pYFQem4Nyw4gOmyAWqd832b2W2Rtu+WBzti4lKWwPmhXF0oM5UxggWqsDo6/owcozY
 1CxtkLALcG4ZvpIpexl6jnqSBDavp8sTbrlNqoadSvm5raOzacnyU9cbIxZOk5vLGSQi
 F9kDZtiupR94Pkc7mLlKp7BrWiHX3AmfUXaULC3YYO7zTJgu6Brfv5cTOHH9cCTiXoB3
 xx2tzYjWfHx8oqzZPK6FzY3GnUHxTOaxrvVXUHlgtb5AxE9MnSCVd9criHosdrszZium
 oPjrKJmkpw5rO9F3IkYJQaR4E0LcNOtOipfqECwV2jhr9lG2p0fXZpefA5P2TLnnDjcU
 IzPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhfQJoUq4eiQNhWqvSBxOoXsKo3BFrRs4XPYf/ruzzNXdXemt+ewqkxcKmzgjDTbKYynMI8Xc=@lists.denx.de
X-Gm-Message-State: AOJu0Yzf1ehDEZxvT5ey3VVQzr/A8sfMYxzFuNUI8c8jkIGLD7DdQEyF
 D98i4qHJMOKQ4By23RlfhOrOCmOGIcDptj9z+GEQX3CgFsTmhCLlyK1yXCWS5nP27h8=
X-Gm-Gg: AY/fxX6jF3WBRU8gT3mHfMEEmnhDqgKgVMbRRdIJh5jPviqSxd1OnRTMX5srKJEZQsS
 JYDcAKHanQ030phVtv9mbW8X8Y8ISDZ3a+0u+xev5oMHlWOJU2yDNLGGV4mbDlcIgdk0cAqcXLQ
 9n0NkfoItUbwhqhpLHNxHrsbXlMVpn260dFWv9lFLAU5EE/P671EKPgvUKh3B8cBOc85rE5bQ4J
 8cvmNk+FpeSuMpSTJzeojciKumVkaSlpV+04lGjGhcy9ksQSdx5dw5CoAw2hDfGpoFyNmKjKrBO
 7RbmWiXm0KDTViyUYaG28xNKzFfTrvXIvPKkga1s7POL4KKr8bdLCJCW4U2LBzEo8Ut9Yg+J7RH
 CwFmWOcn59B4XXO1C7jeYzmiKJm2NXjRQCjT7Cf+oamW9TDLdQ4cNyx2l7k0y+Y1GE+33HqWd2E
 zpFFrr+40ig4RUPKQrzhxmwajAudbp6Cc=
X-Google-Smtp-Source: AGHT+IF2R0OcWaBdtvvIkWRs/nyPiCdnUkGAyED17wHYfWERLWeKkDaSwO3vyu+LHaEDK0r+QfbQHA==
X-Received: by 2002:a05:600c:3b13:b0:475:dae5:d972 with SMTP id
 5b1f17b1804b1-47a837925e3mr48878695e9.23.1765449979352; 
 Thu, 11 Dec 2025 02:46:19 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a89dac074sm27548245e9.8.2025.12.11.02.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 02:46:19 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 Ferass El Hafidi <funderscore@postmarketos.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
References: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
Subject: Re: [PATCH v5 00/10] initial U-Boot SPL support on Amlogic GX SoCs
Message-Id: <176544997866.2550755.6380353806583614603.b4-ty@linaro.org>
Date: Thu, 11 Dec 2025 11:46:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

Hi,

On Wed, 26 Nov 2025 12:17:02 +0000, Ferass El Hafidi wrote:
> This patch series adds support for U-Boot SPL booting on Amlogic GX SoCs,
> replacing the "bl2.bin" binary blob running as TF-A BL2 on these boards.
> 
> Boards tested:
>  - Libre Computer LePotato (S905X, 1 GB)
>  - Videostrong KII Pro (S905)
>  - Xiaomi Mi TV Stick (S805Y) - downstream defconfig [1]
>  - ODROID-C2 (S905)
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[01/10] tools: mkimage: Add Amlogic Boot Image type
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/18c1654567dca70d848a4da1af93ea86632a45ba
[02/10] mmc: meson_gx_mmc: add minimal non-DM driver
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/3eee9c1f61fc4ec0b7823477fbdac31d136fc729
[03/10] serial: serial_meson: add minimal non-DM driver
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/ec958be7cc76b4f305fd78d55a20502d7c8b35b3
[04/10] arm: meson: initial u-boot SPL support for GX SoCs
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/f39f6eeaa8c19053405788479b61a1e3b17ec150
[05/10] arm: meson: spl: add support for SPL DRAM init
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/17d80a3b326ea94cab687236cfeac5fc7c2bca2e
[06/10] arm: dts: meson: add meson-gxbb-u-boot.dtsi
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/3d0a06aaecc7b380e2588072bf6cfc3bf1ae8832
[07/10] arm: dts: meson-gx-u-boot: add binman configuration for U-Boot SPL
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/236e4b1cc4eb491dea31e112cf4e880ebcce05f5
[08/10] board: amlogic: add kconfig fragments for SPL
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/773aaf8f8cc94a882a89373920f7986a9669f0e7
[09/10] spl: meson: set SPL max size for GX SoCs
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/dcf8a2738b0e00a7caaf193a6cc69d3cf0ec3999
[10/10] doc: board: amlogic: add u-boot-spl documentation
        https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/8f2169faf6e4ae1d0506779c6630104dfff7feea

-- 
Neil

