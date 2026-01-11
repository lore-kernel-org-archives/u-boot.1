Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F3CD2502E
	for <u-boot@archiver.kernel.org>; Sun, 11 Jan 2026 16:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1E5583B85;
	Sun, 11 Jan 2026 17:33:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gH/Lf8FZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F387283D07; Sun, 11 Jan 2026 17:33:31 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C795183CAA
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 17:33:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b8718e54398so5577166b.0
 for <u-boot@lists.denx.de>; Sun, 11 Jan 2026 08:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768149209; x=1768754009; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LaRvfPD2Dsc8g8OPspV6udqL1/D0a3W3iQw2c7lVpvQ=;
 b=gH/Lf8FZ2WIwN82Rs5N7tTcrV0mS7HhB7Rc2HKYHmORrsA8gOUzHSCZ6D+2zKknsNb
 ht4DmliGrcfsOD7SBKbsq8gQO2S0RyZPC4Yx0vTgVcxoVdB2vCUrRJsPRovQayy25Y66
 1B5lPK7PtBYRBmgA3BTAE/fexzJxMXnkkre1OM/B8/hFOl2r5KATRTkLnKkMVsO+6Sow
 h86f7cKrOo+Klce12xQWW4HfaLhNh40mqSI8y9VD+twaFhRGgadRhI5/1bd4bjrD/1dP
 CGqhkMuUBALD1IkHU1AyhX/gGrI2Mxjw3chO40QB0Eebfpwhqzyh0Tqr/AwNcKIcQMiD
 1dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768149209; x=1768754009;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LaRvfPD2Dsc8g8OPspV6udqL1/D0a3W3iQw2c7lVpvQ=;
 b=qfSRePOAhSmrdXom1U1bmb1KAA6yKqljpNIy0KVpfUKoNY+p5QEz+0/qYRE7vEU6JM
 c34lsTMV8P1b4Whi5tSft8BoPR6b38ah9eRnkNRolFsWpOYNNcWU1HyZXAcC+J+CRM8y
 skRaK3atSnxWzNK/4+8ZJLjr+bVoxlPTcvDgLBhC0O1wEAk29tW6bIlQXAS+49z3TSsN
 AJuJfU9rgGEv8p9Yw3k8JwnHW9DMe4j6ZibVvaZB7anwyxEQVrdkFH5gj6znHQR0Ev6S
 uSiTBn5sOl8u3ImmmVrhv3untFySy2vP9tzoPDEvNIqaff1xbvNu5AEn/3G+49mjT/l7
 mXPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAxnyoBAYvZ3RjP5bNf+3cC9EmbqN+RLmOSy0g1/iivd0wVDxZM1Pct/5skykFaaJpSwoUq9I=@lists.denx.de
X-Gm-Message-State: AOJu0YzLfALsP1l/MNWwBdMQIDO4NkJhHU0nzxS7JVLXnLliZEfKolEr
 qicCi9nYIdif8TCJy95Q4K35IkxcLv+cpMPdmRDLfV2hbjN9ZOXV1Ckr
X-Gm-Gg: AY/fxX6GpmNWnZS60lHkTPvoc5+tV/f2JSt/oRC5sr42T5AzTfG+PfB1ouHxNby9vbc
 b1NigDDSdCVIjkp0gCkJbEyln9CAV1v9GS3h5SZg98g57JYMUIpUZdlfw+NXq4s92uf6UtvF2x1
 KRe76LvWSyfCTyGMJG2aX5eAmZO69VpRSi71sFMXXatRlh7piT8CjVKnE+otIjJoObslZpo8KiV
 bz9+4CNjVc0c11shFiwb32xN9QXqZfN4dZtxYwAslNJ2xRoddvl2mJQ6P4Hy88bfAcf1ysqFdim
 7+0MCiFAoWbPY/WW1fQNgW6XS+4s5eT2IlkpIUJnSsHwy3Uwcatp2bIY4uhcndSLh/eziueZSwt
 DVD0XDDPyycuLAVdrrRvzKBAcqZWCEtv1PJOFSp+W5508ugZO0MATzsfVkipFersgzukj8pCUE0
 FI1G241HTZyPurC+SpW0M1B/4qeTgMS+5eqmmNR6viHTc+wtsGfQ==
X-Google-Smtp-Source: AGHT+IEPyNzEH2I4Bpzli7L7BMsa3C4SAwh7eqA/hZTFFqx/hQubFk+ScXVnXfBAPw0IFo3RfYzbiw==
X-Received: by 2002:a17:906:ef0d:b0:b71:a627:3d9a with SMTP id
 a640c23a62f3a-b8444c99d74mr824217266b.0.1768149209136; 
 Sun, 11 Jan 2026 08:33:29 -0800 (PST)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b870889ac26sm263174866b.28.2026.01.11.08.33.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Jan 2026 08:33:28 -0800 (PST)
Message-ID: <65df8c26-9cf8-4b6a-8a9e-600750a30b63@gmail.com>
Date: Sun, 11 Jan 2026 17:33:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 1/6] ARM: dts: rockchip: Remove mshc aliases from RK3288
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, sumit.garg@kernel.org,
 trini@konsulko.com, u-boot@lists.denx.de, hl@rock-chips.com,
 jagan@amarulasolutions.com, jernej.skrabec@gmail.com, w.egorov@phytec.de,
 jonas@kwiboo.se, michael@amarulasolutions.com
References: <deeedc19-e992-44d4-ad77-2b9b2d891675@gmail.com>
Content-Language: en-US
In-Reply-To: <deeedc19-e992-44d4-ad77-2b9b2d891675@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

The use of mshc aliases is deprecated for some while,
so remove them from the rk3288.dtsi file.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Link: https://patch.msgid.link/3e461bce-e8e6-48f1-a296-34040447ff25@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>

[ upstream commit: cafaf99e4a790f8492a034a3470f878779c8c535 ]

(cherry picked from commit faefae4ca217961a0d96a54c9618e56aa8fd37b3)
---
 dts/upstream/src/arm/rockchip/rk3288.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/dts/upstream/src/arm/rockchip/rk3288.dtsi b/dts/upstream/src/arm/rockchip/rk3288.dtsi
index 42d705b544ec..7e284b4fecdc 100644
--- a/dts/upstream/src/arm/rockchip/rk3288.dtsi
+++ b/dts/upstream/src/arm/rockchip/rk3288.dtsi
@@ -34,10 +34,6 @@
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
-		mshc0 = &emmc;
-		mshc1 = &sdmmc;
-		mshc2 = &sdio0;
-		mshc3 = &sdio1;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
--
2.39.5

