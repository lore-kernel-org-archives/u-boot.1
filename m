Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C96C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 22:13:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8E6A60BCE;
	Thu,  3 Sep 2026 22:13:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c3l5HOeBDIcb; Thu,  3 Sep 2026 22:13:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 07EF160BA2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788473618;
	b=dDh+lWhd+QG9yH9S23v9tOWdNIHhjJp+I0iXSCoBO+Gtn+cRGZfTstFvE3za3DTRPH0I
	 567E5ZEe/CXCs/T4ccrH24ioIJr0d5EtPieWTGjYKLlpSWU+sUahNPOoTnzbOzTxOhjrs
	 /avT4+NDddscaptZLU9GJFQiVQacTMaec6FD9ME4c2V8PU9zdruuL4EGWwjmynl4DS2Nf
	 sr5JWrsznoDQPk9gOCJhfEE7COT0QBp0XFJhZNJC5Zez2zzvpqpukPWQS8oufz60tJ+rZ
	 bZH1xa1XrWzDvd6SVDE8LS6jw3+MCmUHg3d41pe4Ngf2uJe9+SRIieGMybH+7Mw3A/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788473618;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mslE4N5ZXfCGpp1hr+gh+6WtyWuoZoSsRpthCRi+v4w=;
	b=YsWggTXRKTCUsLtzozTACtSfP8GFZQ5hjHtwXQEnKV60JLfyFvfFt0k6L8rxTQoL4uc+
	 N4J3dOUDoDHmR3O/cPB6qixujtlrpF7R0PZsbDxmvxOwzVIpPP/VrhT5jwnLrz9ZjVxw3
	 lFuLT1/iQYsB+GT7vynphpY90/dQFxvIe4APVvFz8GjtEqLPSanBBSKIimYqlKxTUoMBH
	 cnYCKQTbwnWRgmDNb+Kf2nRs9MhWRSUru9WvQ77i8w91FeDy+Bo6qM9IoCuuUca/MoeRz
	 wTBj45GDWRA7VIFnTAqrZibfmmke9Vf6oW/4XJiaCypn/dg7jK2wnHOlJar/QNsYQ4w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788473618;
	bh=mslE4N5ZXfCGpp1hr+gh+6WtyWuoZoSsRpthCRi+v4w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wxQrUdTEHZHxiV6LxDWWGZKkIoAw+M8lX9MZqvu4WPr2Kbc1KRnGci9eIk+CCnRMS
	 T3QTqCO2xNETmtWlunCa2uFWLxI6i2X2bmCqqqJNmnyFhxn6TUbf51A/7Wt2X+wSkE
	 F9MFSVdBSNBIVS18X8YrLGRMXMl/v6MOTbEEHu3HAnN2rvwO2Ch6HwEpQFL3XOMMTF
	 GqvLNbEdFOEftO3On5XPBXqz35TiswWFXkIQAFmaHF4h2CbuPZTjfIKqZ/fPQCmeLB
	 JG1bY/MDc2oj+6ngYkScHKERNNGJuVTTLegjpsq06qvc4oYxJQe19VSliZ2K+iKky4
	 9sy8WSNQtcLVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 07EF160BA2;
	Thu,  3 Sep 2026 22:13:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 12D34498
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0519D400D3
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fDCei-1dhqHF for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 21:38:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 46DE640029
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788471484;
 b=o7Or7pFlYzC/Log2dDChjhLgMyl71ZcIhmVvjwkFroyAgFknth7b89RI4XNPBthZnOtI
 UyrZX4aPKWUOKX1EaZXncg7FwlIvJ5GgcQB6qjAfqnchboJLBsocWWm7rMag1t6Ekv0tu
 I9BXVe50z6dbgQYQ26pzTmehZr+QwLsA1QJ9HadTwWHY/IqvHjREYiZ1Ncm+RBrSc9OcG
 Ts944icrRFsk12M5ILUFm0NVDsoWDcxFKLT1nFIgppXzzHOzKOHKmOZ4qHMuZDpK8r8Er
 +rMf3FbgkzwN2YJBE1PK0ibhhmcTfHx1afGB9zBo0V2xUc6GA8jxdZolMeBGL8F+OFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788471484;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=mslE4N5ZXfCGpp1hr+gh+6WtyWuoZoSsRpthCRi+v4w=;
 b=CykIRgpEksFEqziyGjU4v2TADj8uoF/Pdoud3Yiqg177BIlA7zko9aM4sGKo9QuRhNUQ
 ihprbiLjGEecCULEpSCWaNGtw6/gVTiYD8oS9NOAWELCPa7QBYF3fNh58TCkgTJxAkM59
 8vldLhG5P2dSImdSNSWLFeCOkaBx4c4/ES2ER+dv0SyOTwE0iWkAqmCTNEanTfhbOa0W3
 9wDg18jKT9vrAxu86n2levXw0DlszmEVrJmxFsLlCGMM3gPrd/8hwYw3LVYbrHMVnCe02
 rP7c52sWeN1n0klIp9UMO8fUSmGpyJRDEx3x1jRAGZlzAp0g77yY54Nd2ef8tzzWsFQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=k5aQhXTn; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c35; helo=mail-oo1-xc35.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=k5aQhXTn
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 46DE640029
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 21:38:02 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6b12ada8befso215480eaf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 03 Sep 2026 14:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788471482; x=1789076282;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mslE4N5ZXfCGpp1hr+gh+6WtyWuoZoSsRpthCRi+v4w=;
 b=k5aQhXTnSHGE4XXGKaxh9x/v32Ty6TLiMHO2ck8Yre5+CiN7YYHIwGoFwEO2wwUbkA
 2f0vw336IoYh17tSHgOPplqsGN5PLjJfLfvxYPg8ypnpz8hMBaEO2bBE4Aaor5luycPz
 Qsz2L7Af0Vb6sv4GU5369XEfsks7aMlRhkp7vpsM74OpYcbE7iA/E7tliJZmihhVt+cR
 0os/Zw5tg12GA34vgdYHA34SKjoImCaaNS/78iFCpgwrmvjC2qtjsEzERFsZuKg4ddoi
 ZDTKKEcIsdEh9SAXwOiDI1ebmBOH+DEDp5mELOzPbnYETM6pr8W73ZWZ4OpNTmrDpkcb
 rP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788471482; x=1789076282;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mslE4N5ZXfCGpp1hr+gh+6WtyWuoZoSsRpthCRi+v4w=;
 b=ef4PxdZnB3SPX5n770AdLQQ0WjL0CF0dZuRZ1/45wgacwMf8wGvmN9OGC2jXPKho9v
 ZRtr7pu3TMHSJcV6OUAXvHrjWDOGwcPKCbqggJnuLjcArbuAPJiEL7m7QbDN07SO2JQI
 h6KFRy7LTU96oV4qIcgLRATPk2FBhqUmwzcD/aI6Up0M1eyNUHWpQKCI7RekAPSA900N
 44/46kj5B8YQ6suQFWdKUE7VQgdQGJaRefOrZ8C51l+ky/ZCPkwDlNuSPubCAG6XNh6h
 IjpsdCWe5HhDuW1HOU77Cwh0Z+XJSernt1OYSDmJhjkrrruHTrgRQ66piHnjZE+qZmyX
 Jzrg==
X-Forwarded-Encrypted: i=1;
 AKwUvBynPPrPz2Y8/yJ7hhsCp/i5NCzlmw1OzUN8qkra/BnboRc7fKMvm9tCoQPR7JloUdawOLgZcTs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nafcRcDMPFJJsjc4CuMs6vPYDgKA0c3rFa5hWvt6pI/SOSEyPo
 eZXNbRkMk89LQhWeZqm/tMcepjp6qndJj1bLO1w9a7/PzQecanq5GP9IwfwejwLLXsw=
X-Gm-Gg: AYBFou05hPWrXmghEwA1pMkeC47nMeHxJwBMDEDDJg7tBYIjb4osClaWiyhHKiZcsac
 ShFcK6uRRRTvdW/03jGIiTyIwR7ST1zJq58LQbcrYJCY/AMazIhrA6zrPn9GM7ZuLEqkPoArnYN
 59ald7pGT+KrlI7hsmdHaXvok6t0xt2G44aVGqU5gTb8SHRhkEAsVbCz02zW5FkYv1feqFzEwz8
 F0JecSEL7KPzr5rY3NWb0NLeu1Ws95yGyP72ucPPcYWaYo8EC868llDF5DURL2//se1Th+IMNu0
 BgnrnzP8t0LveV1l4T6Dgrr2UzAhXhgIdK5O0+aH4EKBPI6+Xowq6YctAyCQzrf6rqZNfvCbIKR
 DfynUEfJ+BxCN6NYcrHBnqf5tVjcoBbWkqpx4DSLr4l31xGzWrL26CG819BJZQzt7L/n8wybLdw
 5vozL283uHmuRdAU+zoP+2NlcnT0x9PsiPJ6i6F2PHf8kqHeNFoG6Les/ccfapzuU2CfJR0Znae
 H0cELo=
X-Received: by 2002:a05:6820:2d09:b0:6b3:b9d1:f629 with SMTP id
 006d021491bc7-6b6fef6f7d6mr1539189eaf.31.1788471481700; 
 Thu, 03 Sep 2026 14:38:01 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4a5f:f4c7:21f3:4b8a])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-475541a8becsm682930fac.6.2026.09.03.14.37.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 14:37:59 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 03 Sep 2026 16:35:51 -0500
Subject: [PATCH 07/14] usb: dwc3-am62: check dev_remap_addr_index() for
 NULL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-b4-dm-addr-null-checks-v1-7-db945bd5e712@baylibre.com>
References: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
In-Reply-To: <20260903-b4-dm-addr-null-checks-v1-0-db945bd5e712@baylibre.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Julien Masson <jmasson@baylibre.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Yang Xiwen <forbidden405@outlook.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sjoerd Simons <sjoerd@collabora.com>, Eugen Hristev <ehristev@kernel.org>, 
 Claudiu Beznea <claudiu.beznea@microchip.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Dylan Hung <dylan_hung@aspeedtech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>, u-boot@lists.u-boot-project.org, 
 Stefan Roese <sr@denx.de>, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 u-boot-qcom@groups.io, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=822; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=D3/uMKTigghOGdM7qp535B35NaOisPirC+WS573+JSo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqmehluWYMMUtNu2E9vpmOq7iIIRs4Ox/qjRRrA
 c+DfyWeRPSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCapnoZRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AuaUH/1cd9YqJHu0x4jwSYubGl/l18BesljXyphOI6qf
 Cv66FIPvz9nwzwtXgLIdUiKXMX8JAGVkeA2iK53v+BqZ96y2+kCmBVJyHaqVbbDXpYrpipV6aO8
 HFujS3yYPD6yX2d+VPNQZGUP/Np4gbXgDlYk9J9iajSKIIW1FDaEJGZyoSWHU+QY1UUo7KdG0aM
 D94fUuYYQdseC5d/Lqfz+CFrnHZQhVYEjGMPHPRrPCXehsOO46YNK21iXaSXLwulMNE2AOaevTo
 4umw9nVMah+CxBQe22+N3pNsOJe5DSvjoSv996yieEWubTWMqvfmwmIsWIfUx9b0tyoI3DyZK8v
 +qRU=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Thu, 03 Sep 2026 22:13:11 +0000
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

Check the return value of dev_remap_addr_index() for NULL instead of
IS_ERR(). This function only ever returns NULL on failure.

Fixes: 92114d7c0a19 ("usb: dwc3: Add dwc3 glue driver for am62")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/usb/dwc3/dwc3-am62.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 8cb5796b6ad..57a34d69fbe 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -46,7 +46,7 @@ static void dwc3_ti_am62_glue_configure(struct udevice *dev, int index,
 	struct ofnode_phandle_args args;
 
 	usbss = dev_remap_addr_index(dev, 0);
-	if (IS_ERR(usbss)) {
+	if (!usbss) {
 		dev_err(dev, "can't map IOMEM resource\n");
 		return;
 	}

-- 
2.43.0

