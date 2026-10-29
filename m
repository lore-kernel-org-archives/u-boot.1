Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2FE606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 19:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YnyupfTC;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=FKpcvM6F
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CF3160667;
	Thu, 29 Oct 2026 19:39:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nB57PcgQPDkl; Thu, 29 Oct 2026 19:39:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BCF96606B0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793302759;
	b=MbmGa8WJPVe9oNMTiGegrPxDuQEti8BL2CXMOSd78goRwZ3i6uMtRykUda1+xoGg0um6
	 olTbRbGtk7hTNynGLoj1OZ0RQNoEbVrpkpRp4KLtIRRWaiCIFh30DVPTZNpmbkzeX4RF0
	 Pb97V3cKtXV7tNpf1Ox4Y0pgdu+UQ4KQJTMeTBvOAVioaUM0/RtzJpUllAQhvX/WCSwR8
	 ul6MGuHT/62p+7wlQYG/yEMsFWZy5oRu0W9F9BBmNaGx0hf5PntTznDjocfIYz7g7X2OX
	 4GBPdTQnp1W4F2UGMUzjR8reVzG8B99J7pHlL0z7D4BhD64BfFrM3l+CndRa/G8+MaA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793302759;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=p9XLlcvxhi/YBGu1MX4kDSUzsBc5MwU/UadE8Wr9vj4=;
	b=sqF2SRQ6Z8Sy4WtVA6AY3jWkzMt053GF298bldku6zG3NVwigmrwJ1lhQwjAn4sccd4W
	 2QDDvq3JPdv21qVOoD0j5xzlX1tnC2WAqm53DlSvMuW0NWRHbwGknuXP2OLYTXlc6lFqh
	 Cf4uAAAR6fLd+wF8Xf/IYEjfUsFqKa5dGiaE83urK4FRIRbA8tk9LlLogyBEntstKQLaH
	 VF+pNIjEVkk1gWBurKy27dlMfvhbEbeQkOxKdYMa5Hp7F9rVySrhTwA/X+VyhzsQcgthE
	 WuwAT6/w78oSlsP+BTKfo8CrfOxA0JpQ15qFp+WPNjQYhqRh9WbLj5VBN2t5wB69W2w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793302759;
	bh=p9XLlcvxhi/YBGu1MX4kDSUzsBc5MwU/UadE8Wr9vj4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YnyupfTCPMpz3oK4nANr1AreApw4NBC1wt5Z1kImOKajItoun+7ZBrkK5vfnR/0qY
	 RXfhdT9kKnzQAaN41rTUCbWAvurCv3x+UovxweCwsJhmnLQHgaFNken7RYmu6/0OKP
	 FJ1TLTX76k9zjlZiW7p/t+qJk3Ah/LxdN+pQMX1dZ15jLeCx+8m3QdnMBVeMEmMtgf
	 mMenriRMKpTJ7L/rE/hpQTHXpFXbl9ce9gPv5JMC5EPw+O7MZmu2WP+EjbR1KfUNxw
	 cJ49shvCWygaPM73OqTe3Eu6cSGVqwOIvLhbA15g8jF8CRrCBe8BRQRpqu4Vh9OznZ
	 APItL0lR3KZ2g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BCF96606B0;
	Thu, 29 Oct 2026 19:39:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CB8F8120
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 19:39:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B5B6481004
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 19:39:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2i_Ry3Mno0pE for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 19:39:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1216380E7F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793302757;
 b=W+gzgDD8+FnlFXLZ7WRBNLHsoZqMeaIz9x0dz2b3sEJEZWkccWYlN+H06Za95lrewow9
 dBN1Z83rlM4C1F79dM51584NM37kgXM7m32n+vpO0h1OQr9eKcVImarSkXqeJzdldzc+4
 tUE1JWgbzDWQJELZ19sUN/Bjw/OBCdwoqtz9v1B/FPtkMsMvKn0i4iaver1PlIoWf9lr7
 40DNLTjQMKS9MGatNY2dZkNDzvU8b4yE1QVZqOFU9MEikDGRSCm7a2XdUcE8bRiBgYnlf
 fGkrAdCkn0K+rr2uuoWNtrCbm9a8OaKidUqEulbFot0j1PwjmaRdLUCcuPRy4IlAhGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793302757;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
 bh=p9XLlcvxhi/YBGu1MX4kDSUzsBc5MwU/UadE8Wr9vj4=;
 b=awG6RYO/E8LVwreMB71iAHrcCCnEZZfnNUQf4hcuxJyInRlgI+oPX+jp2ylYeNISZcI4
 1YKpF4khuL2zc+2pNF/N40XGovt8cKzpM3PCsc12koQQznF+an+ochANMaDbZxaCRl0/W
 m9s2IkKfD5DfU1lEDMk7hPUx18+3hwmv4DgBJs83Ce3edMtHV7MVWfYaGlDY2y4CAE0bW
 6fv6u1NGgXRLStl+DBuc0VoC306ue2HJujfMVsE0aXpYn2hfcBhAwpGcZr41RwkIFEYHr
 Gu9GHmJ8np4VrewI5dYCghWprvyO/vs7z/QG+rct7sLjtUZ9ODyz+NdgBBoOOHmuxqg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FKpcvM6F; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=FKpcvM6F
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1216380E7F
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 19:39:15 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so27609955e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 12:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793302753; x=1793907553;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=p9XLlcvxhi/YBGu1MX4kDSUzsBc5MwU/UadE8Wr9vj4=;
 b=FKpcvM6FyK18wDsi+juZl2U7IVzxhEtmjjPglywMGYrHANcka0CAmhM5XdkT4gMlxk
 DAwo8GkfUZOkvw+lhMLjatS0yKAXgJqWhfgZISE52SD8FPVmpuhAYyjL6HegtO+1ocpY
 GkDO8gYWuyU10LFOAAyaJ4sNbpeX1FYAOM5fgWVEoXCp2GfOG/piZoTJ3n909qfuAJmX
 Z3pU5RybKL+MTUmQGXdCqNTTsq8rixqUD7jFc7caBgO7JTXF+f+zv4PDWtpdQ/u8UTl9
 j+ZOkxKbe0iX/y65ynUhpySBsjgw0EjdlAhRiH+0aUTmNTg2lGmYWvNI1IupMqUuvltR
 sB3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793302753; x=1793907553;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=p9XLlcvxhi/YBGu1MX4kDSUzsBc5MwU/UadE8Wr9vj4=;
 b=hafO53yF6HNieLhtdohmUxxStNsNA/QoHxZw6BYC3+3ES6hLlasW0zw8MFoa5ddQ/X
 Ld8QWjQ/riaBOr41UI9KSF2yrxD66SiPDZ0mw7a4xgi3nTmHrnNijNN2Bjy+WgX9T8H5
 FY+eRP2+fgO3Lqqt7C5DOkQIHEWgo8CmfL7DNEEMtNt7nLBt0WVaJtuk+E7DxcgG6aVm
 AfnTtfLkVDINN2nQ1BxNp6DabGeU9A+Usp6/DWUvli9GhPAs9z5r9GHRLRyYP8rohnh3
 8UZcb9be+79xQUuaHL9VTRbGs54fH+QaP3jqaW4G2lbZxtV1RiDKOaqkAVxto1nPkSF4
 3a3w==
X-Forwarded-Encrypted: i=1;
 AKwUvByZuqVx2xRSDcbF7G+wlP0kw+3YxOsmO9wdx7jkVJ2YQHkFPkosZ62GwMKvTO4MdLK/VBKKhwo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKuNCYJRWJB3m242O+Hj2Ti/LojVyIBv5PI/Xq9otUmeUY7T2W5
 6BZ+ffRGFa41Xe6mk0FxNtukorgJiAGqOX/wIPlnZ21v7rFgE59NW4cK4mTzWneMtFylbcsoaZz
 GOZo3
X-Gm-Gg: AYBFou11G89L5cgbIJHKkxtZ2ZLqBe8+RxQpUBc8eohCY/4Yw1SfX2JtMImj6+enekF
 LgPr08D76VRYu3CF/4GO8iKfg0C46WBB1K0uD4zZxgpoUirp2Q6BLfj3Up20zzcBD54e20DiYDJ
 rt5hvv98Yba8GHPL+DGEiRzbRCJMhZdM7E4MqNnGN/9DlkJqykpJTc4+GLpjebXeKT8Qp5hmi5+
 bvgvIuaJu51Ehc/xvOUnrCGDSk7vzBcyPAKEiiJhzPmGCnpNpyamiZpz0YGHHn5q/Zx8p0aI8Gy
 KCd98cc80n+qAA2gS2H+8dPJsU+mjkiTQZSJx6aCpeAIJzFmZhji1bt0LDFEl7PyPgoENSYJYMZ
 4MYtSOgeHh4ul2kG1uTyFM0QqNpinx9X//V2n7KaNiNk0kPOLE+ZxwMonnimXLaIbbMZ+mq4wzQ
 Z54R6GhGQZy4jJi+ifcKxZdlFy3xR4IDemPFb3HOO5JOFznMaRhG9zNNrTBgT7k5DhAdO6RXRK2
 PzqExkc+fLLOJ2AUXKM8N0dwZUSpauuna7EeblUbfrJBfgLOP6BKOhTmt0zUm03oJshc+AemBCK
 gZgD1ef1hM0xXcljLUPX3bI5GJlFYYe9mfkQjrCKDCC4Z5u8Wc8l6ljKJoK2Yaapt93gbdps9XI
 Uj/W8Jjkvn7uKqCTW7g==
X-Received: by 2002:a05:600c:154e:b0:4a1:7bd4:d07d with SMTP id
 5b1f17b1804b1-4a967e8d5a3mr148205455e9.34.1793302752783; 
 Thu, 29 Oct 2026 12:39:12 -0700 (PDT)
Received: from [127.0.0.1] (host-95-246-144-141.retail.telecomitalia.it.
 [95.246.144.141]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09bcc967sm1987645e9.3.2026.10.29.12.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 12:39:11 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH 0/4] Enable USB host support on the Genio 510 and 700 EVKs
Date: Thu, 29 Oct 2026 20:38:58 +0100
Message-Id: <20261029-ccaione-upstream-mtk-g700-usb-v1-0-6b0dda25be38@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QqDMAxA0V+RPC8Qu2FxvzL2ULPo4tBJ046B+
 O+r7vHA5a5gElUMrtUKUT5q+p4L6lMF/AzzIKiPYnDkmppci8yhJIJ5sRQlTDilFw6eCLN16M+
 u8dQTcbhAeSxRev0e/9v9b8vdKJz2KWzbD3BZcLeBAAAA
X-Change-ID: 20261029-ccaione-upstream-mtk-g700-usb-732670f00ca4
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Alexey Charkov <alchark@flipper.net>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Julien Masson <jmasson@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable the USB-C PD host port on the MediaTek Genio 510 and 700 EVKs
using the existing MTU3, xHCI and T-PHY drivers. Both boards share the
same USB controller, PHY, onboard hub and connector wiring.

Two supporting changes are needed before enabling the boards: the PMIC
wrapper must recognize fallback compatible strings, and the onboard-hub
driver must initialize the TI TUSB8020B hub's power and reset controls.
The remaining patches provide fixed-host settings in the shared U-Boot
device tree and enable the required drivers in the MT8188 configuration
fragment used by both boards.

This enables the USB-C PD port only. The USB0 download connector and the
USB2 M.2/header controller remain disabled in this host-only setup.
Dynamic Type-C role switching and PD negotiation are not implemented.

---
Carlo Caione (4):
      power: pmic: mtk-pwrap: honor fallback compatible strings
      usb: onboard-hub: add TI TUSB8020B power and reset support
      arm: dts: mediatek: configure Genio 510 and 700 USB-C hosts
      configs: mt8188: enable USB host support

 arch/arm/dts/mt8390-genio-common-u-boot.dtsi | 17 +++++++++++++++++
 common/usb_onboard_hub.c                     | 12 ++++++++++++
 configs/mt8188.config                        | 15 +++++++++++++++
 drivers/power/pmic/mtk-pwrap.c               |  2 +-
 4 files changed, 45 insertions(+), 1 deletion(-)
---
base-commit: 03e45557e1f38a39a0c80fe30483130ff376cf92
change-id: 20261029-ccaione-upstream-mtk-g700-usb-732670f00ca4

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

