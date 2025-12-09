Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A72D3B994
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 21:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76D43836CE;
	Tue,  9 Dec 2025 22:18:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="M6AOT+V4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E69883C08; Tue,  9 Dec 2025 22:18:17 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AE2083642
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 22:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42b32ff5d10so129505f8f.1
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 13:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765315090; x=1765919890; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZMC5tjWXmmj8i5odtZVdcJ6wuXP70MtC1rpAaszPWhM=;
 b=M6AOT+V4X7DLLTFz3taRx1/7bAdivBhPf4LjrpdH+coeWcN3EX/yZnpFAByAq6lrRB
 ylu1voUQLeYdHYapOPv2IrKZf5Hf2xWpjQ2jtK1HWvbZsF+IwASG5xo2fdWMSDOlu5i+
 ot48LbGknze3Mr9+jU8A50qH78t7oWojhONgJHQPF6j++pF/eFmd6OrdKPeQdAlYLKah
 5y9Tf/3uIi+zUAblnvJOfY9ZYBhU4q+YLD4blLvV1chKQ/Q0sXTnYudw+rQaMzm1DxX/
 J7Fm2jpgKozXoxJ05+Caz5LZl4+VyPO0OH/kWIvPz9tLGSdW7wnr2FRDrL3FnuSq4ClV
 oIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765315090; x=1765919890;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMC5tjWXmmj8i5odtZVdcJ6wuXP70MtC1rpAaszPWhM=;
 b=gc2PtohS6zV2acPmzg3FAFxVx2Vy7Uu16L7wtecBx4nZx0Ay+FcoxHmUmFyjMIwvQS
 60mGdsKkLoYBIvq1Fm+rjC8ciaGX/0ulgcdaR7O2C4G8qyIRAWtlmYKNSFvO2ZIh6fyc
 pDh/dx8+Dm5sRjFAyAfUdIBNW8+Bs32ope91yLmBzqtorRJhjsH467hPdowHGuokBpdm
 2/++0mO8F5LvOtli9doeImDuOFL81JnjmhGjvcRBo0HIgAKXU56egHNVpp32RQWDA31G
 QouduK388eammgLR04m4dKB7bxWG8mxEysahyqgAeoiOxpkfSL7jNrjV8VbGh8JPWb0l
 2WIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVeipm2pndZ8bv4t6hJAbwWEtFl7mETzxhDskHICFBEqtYF77jJZ70cnML90nm0fErrpExNUY=@lists.denx.de
X-Gm-Message-State: AOJu0YwElm8E5v6Aurhy0DLrI6z5J5YaThrxLULrp30gUXilfrqqkxkh
 Q/j1lfY3G5ngV+0/VsiLCajDCk85FbbyZinPbsyDY2f2uJOF1TyWAhkp
X-Gm-Gg: AY/fxX72/cahrdqarLfmwkKOqrfkJhEEKjX6JCDeT7yboqXKqUoigHCsqEsWvv1ocdC
 HlVUdmbNnOtct1UR0RAZrduBpECtxc9VUztGXeH2sYz93fafrUxsepxDgYjuuaSsNwBeohpBQzG
 /4rj+CPwN3+XTD5IWTNLo9kU6QO9YmZC30Jt9NPZ8TlIw+eERwrpDw88eFWE4QpJW79Z16RUKWP
 sqse3HSS2tNRgZ9mRr7OSA11yJ4sAOrwLKxdapLCYvtyC6W8cqr+jXfv5lHqMgIK9WFWSQJY6Qz
 OX4Ye7U8v0z+zqMbGs8APqwX+IU+IoP/9B9Brx0v+3Tdxq8HubT//hGHUxBcg109lNylCwIPcGV
 5VUKO/H2Tr6qim7S0vmDKy5E5L+RnlDAX5jqrMVIHfEDzl190IHOsVNDaUOnzZD7xJplOsRUle8
 95f7Bou1Qnap2Yc7PD6At8UEAeO0yAkEaSRM38XLEfTgK3vWmES3yU6nCC51w8s4TRRGLmwN26r
 Y8nJhzc/Dl1vQ7Kr29Gcb7IOXJPrLGcdvtbEhpp8E48inn+SoRzbNoUG9eG0jaJvsJ4SUuaqS2T
 ucKW41oJOksRgUeEiJPhk00HA3uZYB3+C4TrgB2rDl6+AwcmXtqY9sim9bgCODolGXwIVuRhHen
 2zQqeL9l0iQ==
X-Google-Smtp-Source: AGHT+IEjwE7rOUULHjiYPAOXTn79yQonUTEos9ttk7ywSoLAfTaOwCwEggsIIDIn+jrP3jOrIhYJdA==
X-Received: by 2002:a05:6000:615:b0:42b:2db2:159f with SMTP id
 ffacd0b85a97d-42fa08306edmr3963092f8f.12.1765315089597; 
 Tue, 09 Dec 2025 13:18:09 -0800 (PST)
Received: from cypher.home.roving-it.com
 (7.9.7.f.b.1.3.0.b.8.f.0.9.e.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:e9:f8b:31b:f797])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbfee50sm33548006f8f.14.2025.12.09.13.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 13:18:08 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] rockchip: rk356x: Stop overriding sdhci/mmc aliases
Date: Tue,  9 Dec 2025 21:18:02 +0000
Message-ID: <20251209211807.497095-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Upstream device tree has rules where the aliases are board
specific settings, no SoC settings. Looking at upstream
rk356x boards there's a lot of variation in the setting of
mmc0/mmc1 based on the device so we should not be overriding
this here and now we sync to upstream we should just consume
those settings, to do otherwise confuses users.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 arch/arm/dts/rk356x-u-boot.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
index 738b9673d35..f25c7970208 100644
--- a/arch/arm/dts/rk356x-u-boot.dtsi
+++ b/arch/arm/dts/rk356x-u-boot.dtsi
@@ -7,8 +7,6 @@
 
 / {
 	aliases {
-		mmc0 = &sdhci;
-		mmc1 = &sdmmc0;
 		spi4 = &sfc;
 	};
 
-- 
2.52.0

