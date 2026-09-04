Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 982D9C61DD6
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 14:47:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5AD4E40BEA;
	Fri,  4 Sep 2026 14:47:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K4YDwYCAX1qM; Fri,  4 Sep 2026 14:47:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 436E940BBE
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788533250;
	b=jv0mrnlkDoCdQN0Q6L1YyuHNexLPBIrYYoX61KYkOmK4CN60znPfNXbBvLsds8CTqLP9
	 9pUkevd0Pm64CoNeagzYkXPMXoslZ93hlI0ZOPE+FnEnzWc7nTRe9CMJlKYMNdvRY/UGu
	 ZCv9suANt+ecZ5IINXrBzapoR8FAL6b+w0PKbrSZoKiW5/RFYxpsZ97N9+0+CYTri8Bb1
	 VqXqNeNp/WUkbxpLeE3tdkZcUnf7BwLVunxjWP4XuuRmrr7xdlsjC6YZg02tK9rLjPZ27
	 VFUV6HXnYZ0DeZwXfe311HFTK4UGtY4nKtvP6RlOaS64USEWYRJqb849YVZMTGqJiiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788533250;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=80mQicTS22MfirFH+kQ5ONgfoIHMRNybOrAL1sMDTO4=;
	b=tc2nujwZNDsKFx/JHgTNU9Po63Q6HGtAUSMHZYjFq4re9ghih9c1RaFJT7DD9qyq0Len
	 Nbd9x9kJumOqe4sgo/hjNywLj7QJuCbA08bNUJEZT/Dc+Oe3f6ecLtcnyb+z50Bm+oF0i
	 PfW2CZiqqItblzCWDOsH6ElxbQKsn7dAAKlMYWoBc30zQIhWztjrCfjWms0/UCLpTcsF2
	 FlMJBJRI6ylBkx6FuMJicxjdgQ/IEM5nzCe6hjDXss6SffPJQe5LIIQHtIlJ84KBVphEH
	 i7OdQpuVjZ7Pyi4pMMLvqaTULdKFvKqPDmlwUu7XnKnbKLrxbXHSeJWX4Vg8t+tSQqQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788533250;
	bh=80mQicTS22MfirFH+kQ5ONgfoIHMRNybOrAL1sMDTO4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Bour7Y5UpYrt+3WqD2xpC76sXw5k24GsFcsf82+NTIVUhOdRC1bYLgCtVgxLUg6AE
	 ThQT3bK0KYVvn1LOlIH0jl8O3Hp7Yk/K1Ds7W04RZkerJle+uCGaW4yebUj6qudYMb
	 rB1D9Z4pFWjHPHxsDs88S8rHz4JtBowHvunRfQ6tt19xDQyVOt0mN1tfbYOKDGBRe3
	 Y8sy8RDAHW44PMri4y/NCD9PeZbNUHK9MCjX/1NZs9kJ02pHXHd4XfxGUS04/L0PXl
	 RfHubSVrB4KgJb8uZEnNhTDDjhgfcSwC1mnwiWVYpxnvcQ4L2VbwCAJr58QCBYGlii
	 ScicaTzK9/riQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 436E940BBE;
	Fri,  4 Sep 2026 14:47:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 337982FC
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:47:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3146F404B3
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:47:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u5jg7shEmiqU for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 14:47:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3CB3D40376
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::30"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788533247;
 b=oY6xoSBlyiu6s/SvVKbV6JFw3sHgrpyEvIetdygP7662Itycqn8f+OQrQkpiwzcRV0aL
 /ugeU+6B94bScCUg2b8QNGp2QS8wU7bO9sNGPe8iSa1Dm5sl47NYu7m36Yy8t+ycNPfcV
 VaZdNdZf9P5ySvliLWO/HACTy4PKzsgaR5hFKimV83d8B2OYWiiGfY6NO2ir/gkBSVimY
 1YcnS0APZT4bj7tpH3WFNmLhiZL6zRaoOLN5Et7Skudx4/hD/n4e5Zb5+eLipjYw8feDw
 69ugr+P8mwNX5qx31R5okk80A9vZThIwV5F7GAw+oPQp6jivYFGEU6UcSFWq+kFCjXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788533247;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=80mQicTS22MfirFH+kQ5ONgfoIHMRNybOrAL1sMDTO4=;
 b=IX9Jvw8a1GNxaZ3nWs58NZOFEqopOxRipBdsKJwntPAn8dePge9GRe/94MYO+a9hD5QI
 6q2puHTEuHDxsfhOwkBTh7Tw6qtFGN8uZW/GRzyT16XbTjP7UvQP3ykAvZsylIL7E80xI
 LyYVqjL+bTdQi+R6rY7t/zbd3KFRo3fAx9Rep7+M/KM/F5NuHu+GY+pXCm2UeuscmL0J4
 ParMBriEimp0oKYEDusZlvxdO/Qw6Rk0U8MCyflzDKGao0AdzMD7CMJUYoM85JTPY/gPb
 tU8Z0IoyUIdIzjv1xU9GHy5N4UVKxQhSh8CZN7XHsRiDRm9+Wzm32/BLItL87pb9Ijw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=eUaAmffD; 
 arc=none smtp.remote-ip="2001:4860:4864:20::30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::30; helo=mail-oa1-x30.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=eUaAmffD
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3CB3D40376
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 14:47:25 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-46aef6e48fbso687259fac.3
 for <u-boot@lists.u-boot-project.org>; Fri, 04 Sep 2026 07:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788533244; x=1789138044;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=80mQicTS22MfirFH+kQ5ONgfoIHMRNybOrAL1sMDTO4=;
 b=eUaAmffDKeHsqzn5w+KXgipX/xs2TU2e8phSjlFPqHg7CtRBvkjVRHNKdAo4nGEObS
 tQcXCQpZRBFjwX5xPnB9QLHphH5vEUk6uwkpQAA4QtzVL/AZ7An2j3hsEnVFotzPsuUr
 UjjBIMdrdkqfK01FMXw1j7d7CWZ84jeSo3h2h3qk2Z0jJEol5h0MSjVMuHH+bJ41f/E8
 6HgfMort0OIllQxViz1f0d7LmaXyocYSipQXNhsfTZzaIACwcBlCM+l7LHzgCjCbzSTY
 wenyZ3IAkgA6sVPbY8mGfVkb7wO40cNojKcDRwvK454jukQeIa9qQVrZ1uEICF0HuaW5
 J58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788533244; x=1789138044;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=80mQicTS22MfirFH+kQ5ONgfoIHMRNybOrAL1sMDTO4=;
 b=MDzIC6ATZr232ttLe9kPPyM33OSwiHxZ0XnQ5KkxsY6bb/yBtuir/pdIetp5eQRdNM
 Mf6FoZx1dzDCoAPcmRKES8zC2k5j6GPc960QwozLy6JdSl5H/duXCWsJ/a0srKiCb9+/
 j+CeBkW6t8nCbZEFmXIgTIyd1DNDMTuQhornRi5kFmW0haao+bEFOUP3C4+A/tjAf6ke
 Pa6Pp0CyEkHlNQNkvIJytlavFtMNXJJoXxRQqY1nibxJ8Wnz9OOZ0eXQeyfa4rQ3FtZI
 SFSZLHrqEK99BCQEFfA9XQk1vLQAmFziMwkYGXFINQt76GDZaIw0Cqiooiyp7hiaxTW4
 Z+1Q==
X-Gm-Message-State: AFuF++k4rnVuCpTCig2dOX8ZltvNDNp+sFZid/SlM+LPSmYpAxE6lIDd
 X4LHENmLL3CAmNMlgM3wm2Zfas0eCGGY3rjHSZybxhYB2bbiULQuuyjGtP6zcTGjTgc=
X-Gm-Gg: AYBFou1lA4CnVPxn1atSXuKGhFIMg3kaNBz+yLAobL372ZFwpdAeRFgFuPWYXGQmHgc
 UOUoDTD3bA/exKkoeWyFQdkn71+bVW3oadW/MncZFRZYXwIAJbA3gGDtM26e1zLiY93t8mhb2Ju
 KcsunPxJk3w4SjIRZauxyWcDNLL+/z+ERvl9Bq1PjaV0nRkI52vTNAuKovjnJfFv+g0fi9yTbQZ
 uC7n5YePn/2nnrmKTa9ewbeWEuU58TkOQ5VTO+cqKabeO1EkhbVZoKtalQ6P/zhE//LeG6/JnrS
 j6yTzY6dw2NgjqZYXlUF1NUdEFzrSS6cfAIZ1nuyLdLeGOZ0Lz8I/dLt2r74/Y9lfRNT4Ay5GKn
 MvqUH5kOzhOxEdAwVLQhvVF8aPjrM7gWq3owxKiXdO+/6TfGynz0H4FVLiOvWwocGJ1z6vdKQ6J
 65HjoVMKmVe54/BttGW3dAHFaDFjhAk/vpqpnGonIi8SmkTUbEk9Ee93dEhQEqNyeKOA==
X-Received: by 2002:a05:6870:330b:b0:45e:4deb:92e7 with SMTP id
 586e51a60fabf-47552a575a7mr6614486fac.10.1788533244337; 
 Fri, 04 Sep 2026 07:47:24 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4a5f:f4c7:21f3:4b8a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47554935962sm2118988fac.12.2026.09.04.07.47.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 07:47:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/6] power: domain: mtk: add support for MT8189
Date: Fri, 04 Sep 2026 09:46:27 -0500
Message-Id: <20260904-mtk-power-domain-mt8189-v1-0-ab9d8cd0f01a@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBCF4auQWTtJYYS0XsW4KGWA0dCSFsGEc
 HerLL+XvH+HxFE4wa3YIfIqSYLPKC8FuNH6gVG6bKhU1SijCKflhXPYOGIXJis+D7rUBq+mbp0
 2ZIkI8nuO3MvnX74/Tqd3+2S3/HJwHF9KvopqewAAAA==
X-Change-ID: 20260903-mtk-power-domain-mt8189-495bc893a333
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, David Woodhouse <dwmw2@infradead.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2068; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=dm0vJclQ84CKTxXdUosGYULN4bRd3qpI1Zce1j4Z8SE=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmtnH1HKazgfg51N7PmuFhQccrfX5x6EbfxkjN
 0479CZ126CJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaprZxxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/An9sH/02Sk4goVhZZ9mHG+sNlR1HLqC3J5fA/nuoMJLh
 DlO/zhSzmBmSd7+/Z6KqBch+GWYbPtQuUwh5vZqnJcui1nlFwCGrJvbGn8o7aM0paMYkcDVrKy1
 xcGtKrZjbXgw0vGFw+ZU+xdpCSDZQlA6zcmcyYgG6KphW6oUd++mxRfFmaPm366a9Mzih5u0DQZ
 NpFt2cjijJaw0Ac9GAHHpxY9P12Q5QNryg4Ob628ZXO8NTC93LOzGfXqPmZhGNv38797mvRvWb4
 3RvRjruRge6sPV4gUjHTIIfqTYMUt+sPKTPVWcZOp5VLdA/3zr+ZLwpn/D0ByTixOT/Kk3dg8ZW
 +Jmw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Adding support for power domain on Genio 520/720. This will be needed
for adding video support soon.

First, we make a cleanup to the Kconfig (similar to what we did for
clocks and pinctrl) so that we don't have to keep adding new Kconfig
entries for each new power domain.

Then we need to modify the shared power domain driver to support a
feature only seen on the MT8189 platform.

Then we can add the lookup tables and the devicetree entries for the
MT8189 power domains to make it actually work. Just the minimum of what
is currently used (and will be needed for video support) is added to the
devicetree for now since this is still under review in upstream Linux.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (6):
      power: domain: mtk: simplify Kconfig
      configs: mediatek: drop no longer needed POWER_DOMAIN options
      power: domain: mtk: support two-phase bus protection
      power: domain: mtk: add MT8189 power domain
      arm: dts: mediatek: mt8189: add the power controller
      configs: mt8189: enable the power domain driver

 arch/arm/dts/mt8189.dtsi                   |  52 +++-
 configs/mt7622_rfb_defconfig               |   1 -
 configs/mt7623a_unielec_u7623_02_defconfig |   1 -
 configs/mt7623n_bpir2_defconfig            |   1 -
 configs/mt7629_rfb_defconfig               |   1 -
 configs/mt8188.config                      |   1 -
 configs/mt8189.config                      |   1 +
 configs/mt8366_genio_360_evk_defconfig     |   1 -
 drivers/power/domain/Kconfig               |  47 +---
 drivers/power/domain/Makefile              |  12 +-
 drivers/power/domain/mt8189-power-domain.c | 419 +++++++++++++++++++++++++++++
 drivers/power/domain/mtk-power-domain.c    |  30 ++-
 drivers/power/domain/mtk-power-domain.h    |  19 +-
 13 files changed, 525 insertions(+), 61 deletions(-)
---
base-commit: e91d0b53e2678e0e6439370ead9bf2c71404b715
change-id: 20260903-mtk-power-domain-mt8189-495bc893a333

Best regards,
--  
David Lechner <dlechner@baylibre.com>

