Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D2FC55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 20:57:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 645F140650;
	Mon,  3 Aug 2026 20:57:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pVJSsKzheUKA; Mon,  3 Aug 2026 20:57:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2985F40649
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785790667;
	bh=tiXaA5atQkc2DxonWoxtvcDlZa2UsZwaiek/HTy5Taw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=F0dFfj6FEGTNwbdqPCBjm47D+UuKip2anDqHYUck7sOJNpr8MvbfDAPsMNFYB/iTp
	 0OZQKfITwToEHoJKvq/FA9Q4+oNyogVb9/nePU1p3P5ZuoqtBv48OlXNDu90/4VSMP
	 xmNDFFVjaKLd9gTMOpDlgEd30EyDGRoKq8+rGbqZJKV2mKkinsy+WA+IC6pMFdU/MM
	 Oa+3xJTCP7lNWIlKvgy4gJJNSj+wTCgFgr4Ecsk2VAzekO6uja7zoyrkRkWHh3xWbl
	 FwIsDJKR6UdlraEA1sba4YnF5J7/iur19Sa/h1/6Za+EWiW3s0kvrd5vCE0FwlKR9M
	 Zhez8EP6ONWVw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2985F40649;
	Mon,  3 Aug 2026 20:57:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EB74B23F
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:57:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D1A3280C04
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:57:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p2ezl7lvGo6R for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 20:57:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8FFCC80BFB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8FFCC80BFB
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8FFCC80BFB
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:57:43 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7e9f69ee6f4so3443800a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 13:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785790663; x=1786395463;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tiXaA5atQkc2DxonWoxtvcDlZa2UsZwaiek/HTy5Taw=;
 b=h6lEgGX+gnvS4HxEG2PWoROfQdN+GtPp3CIrp0foDyVFFlObwEa/9SIX3G1rPkcxox
 BXd06SrRfu3W4+zpxlpKn6bsPUPefNRAGCXR413XLw50M+ar5FRTmWEu7NjZxosyQLyM
 zPaEfzHWj4RSmgxh3J0KcQ9xVQPJvxyV1fZWhH5585B81H0Y4JVo/+b902Y+JQlcDopR
 Yh7bzqTRjPhQEAvL7MROkYYop0+cfZ349ZIoiIUCRoParSHkMYRUrostMg4MCBTIRBut
 7PMOw64qaCjeYgJ7IaMNTsB4nrBgVqK5+2fFL+iE7m1kipleC9jZ7DDUllGFK9EiDcx3
 lbsw==
X-Gm-Message-State: AOJu0YwVEH0KnddrnJwSwZBjhHkIWCMfRAN+Xcf0dT3alF5O6lUNo+iI
 ce7kB005aWbK9iItPz/edvzK3TlOSxC+j0dTQ7bBd08ipfa5cnEYe0MrUlj2VyKpSLh+WuWFjGo
 yaGQsGY8=
X-Gm-Gg: AR+sD109wv6O2wbPoSVXKdNRIJkO909h0lE23ZlT1d9sllB6V0+i/cIW2oIK7/DphJy
 IWsV17s+3DuwVJgJvU1bxlN2AT4snJliQZ9Hnki23ef/XW4wzxaOOD9G2DBySiuvEabRlipI8hX
 G/ppwkEKnSdXZtqNjBpEMf33U3ETi/4k6IfqCel4rkyIVyG7+5do/Kj/OZcpqfdDRSkXteoyzPh
 7ksxPHSmPD0kr7LJ5zWWYxQ/7emWtmrvrdmEDTnc16TXh+NBNx5PZDkPAZVpHYt8xahp/b9cmjL
 n7k9aJehE5ocNy2vJyiD6ye3MA9juhLmt3J3q9Qm1nh6ZWD9OC2p0lqmUNR24cbJBOtVpVyE9Fr
 oxKniDSsMB2Kqczd+DLA8oPFOghv9jkrHibv3OJMCR/n1a5geean/hpj88sWb3aB+oDNkMFzC38
 XsN8tgzj9PcrACJVI2bCVDa92o5Mq4G2nVv0oExqhY1SW22YS1AJMJChh4TkcY1iZRF8g/hozRE
 Q==
X-Received: by 2002:a05:6830:4992:b0:7eb:c8ed:71d5 with SMTP id
 46e09a7af769-7f196ef1d76mr20529427a34.14.1785790662883; 
 Mon, 03 Aug 2026 13:57:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b8f7:1f5e:7c:a7d1])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f18f0d6a68sm8421452a34.19.2026.08.03.13.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 13:57:42 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/4] pinctrl: mediatek: Kconfig cleanup
Date: Mon, 03 Aug 2026 15:57:03 -0500
Message-Id: <20260803-mtk-pinctrl-kconfig-cleanup-v1-0-fef1ff69d1cc@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMAwA0F8hPdtkDhTirxgPs3RYwbJsw5gQ/
 t2hx3d5KySOwgku1QqR35Jk1oLjoQJ6OB0YpS8Ga+zZdKbGVx4xiFKOE440q5cBaWKnS8CTNW3
 T1c43LUEZQmQvn99+vf2dlvuTKe8lbNsXO2x/EH8AAAA=
X-Change-ID: 20260803-mtk-pinctrl-kconfig-cleanup-5207483af47c
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>, 
 David Woodhouse <dwmw2@infradead.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mingming lee <mingming.lee@mediatek.com>, 
 Fabien Parent <fparent@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2074; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=asReep4oNVQVq33b0Ym5oMuyfJMlitXjLw0TyazCp6s=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqcQCksmu6z6NYaGUaoNRq2aXTB/SStvMlHXnvX
 hU2RsSGUTqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanEApBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A03EH/j4o/Bi3FZtE6TQWb20/dJ/sBWg6AgrkVY8t9DL
 VK8DZlyNSSgYTseSA+4sE4AkuAe3f2N1Vp8jecJJ3uk9yVLAS/usBaXgeVS0LV3d7eQA+NG2umv
 xCtIY5TfNWnnHzCtYkMfa/+HDbSpNr3QcI8x5g/mEyAlRI4ReNxM4/QpLjHeD/P+UYo6Cak/XjD
 QaCztaIQz0YXY/OdkSxO2MGijKi/YKpjYsXMKmgswTufCKkdLsv9xFMVRI+mVJcoMhAmwU8219r
 agUIZvFAzm5yaVg2iWqP0GYY+asAkNWBewZ9ekynr/Vb8UvgMsPaD4ccgTeyA2QlXVjrIoMZn4G
 VxiI=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785790663; x=1786395463;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tiXaA5atQkc2DxonWoxtvcDlZa2UsZwaiek/HTy5Taw=;
 b=Es57h/ZCwF5+52KIbh764lhXCiikyvNpyt1EuOXWzo8F7II1z/0VJP0xKCITCjKy3N
 FeTAlwEeYGjl2ihXH6+jsuDytMwfYGOkecN5jAEB8GhnX/6W8qHPr6XFsYNXx14pFNDw
 n/eFg7nuBKjdzhZrAkBMF/X/HC840MN6/2m50UbxPCmf9zE8MV8JQ5Mq76xEQODe80bi
 hz6UN1Rly/5aXJehq1uyMkjDcY16dqy57jv9QJXx66Z70Cw32726m9O3OcfySa6CQBcZ
 MU2KB0abaNw9x/wIg/qGYxAPfPNT7EA9Ofoj/G9h0XXreM66nB7wUtbN7RLT7uiB4hB4
 LJJQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Es57h/ZC
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This is following up on some suggestions to cleanup the MediaTek pinctrl
Kconfig before we add another new SoC driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (4):
      pinctrl: mediatek: select PINCONF
      pinctrl: mediatek: remove PINCONF conditional compilation
      pinctrl: mediatek: simplify Kconfig
      configs: mediatek: drop no longer needed PINCTRL options

 configs/mt7622_rfb_defconfig                  |  2 -
 configs/mt7623a_unielec_u7623_02_defconfig    |  2 -
 configs/mt7623n_bpir2_defconfig               |  2 -
 configs/mt7629_rfb_defconfig                  |  2 -
 configs/mt7981_emmc_rfb_defconfig             |  2 -
 configs/mt7981_rfb_defconfig                  |  2 -
 configs/mt7981_sd_rfb_defconfig               |  2 -
 configs/mt7986_rfb_defconfig                  |  2 -
 configs/mt7986a_bpir3_emmc_defconfig          |  2 -
 configs/mt7986a_bpir3_sd_defconfig            |  2 -
 configs/mt7987_emmc_rfb_defconfig             |  2 -
 configs/mt7987_rfb_defconfig                  |  2 -
 configs/mt7987_sd_rfb_defconfig               |  2 -
 configs/mt7988_rfb_defconfig                  |  2 -
 configs/mt7988_sd_rfb_defconfig               |  2 -
 configs/mt8188.config                         |  2 -
 configs/mt8189.config                         |  2 -
 configs/mt8195.config                         |  2 -
 configs/mt8365_evk_defconfig                  |  2 -
 configs/mt8512_bm1_emmc_defconfig             |  2 -
 configs/mt8516_pumpkin_defconfig              |  2 -
 configs/mt8518_ap1_emmc_defconfig             |  1 -
 drivers/pinctrl/mediatek/Kconfig              | 62 +++------------------------
 drivers/pinctrl/mediatek/Makefile             | 30 ++++++-------
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 13 ------
 25 files changed, 20 insertions(+), 128 deletions(-)
---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20260803-mtk-pinctrl-kconfig-cleanup-5207483af47c

Best regards,
--  
David Lechner <dlechner@baylibre.com>

