Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0978DC5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 18:44:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8BCFB60876;
	Fri,  7 Aug 2026 18:44:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9wKBT8g1oUQC; Fri,  7 Aug 2026 18:44:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7432260877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786128261;
	bh=53pIk8OYfPmEVgYjM66vZx0c+rt3jemDzhiqWrn30TE=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CA7f5hxfOVcyptzf+wdfhU9FH4kh1yuZz0qFTac4ORjWUH5wkHUE/EvWK6qeiVaW7
	 uGX1BtGJtFfzt0GnlJYKycFK6qZZXL2+RDvgVMNrWhcXxMQUzHvCq6rk9BB4OkGdnY
	 TsSJwgTGjHul/j8lE2OW816jE3desUMbq4Hfl1We+YGm8D8n8pP3+DqtMmvp9nMCSG
	 CZmJtVrQnmZ0p4HJFBuyevXzK0Hd5j/IxdzIkZejiEmWNLlFrW0UDWUwD9O648232Y
	 CpNVfWkn95BSqATcS6neA/ZS54cr3CNkdvsclvzPdU9q/LQHMsPLQyvft7oTH2ABPJ
	 RRtFqKTaHjHrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7432260877;
	Fri,  7 Aug 2026 18:44:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BB4622F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 18:44:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC662409C8
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 18:44:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YVvE8usT1kr4 for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 18:44:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::234; helo=mail-oi1-x234.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 6987D409BA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6987D409BA
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6987D409BA
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 18:44:17 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-48a0ca07c38so2276458b6e.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 11:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786128257; x=1786733057;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=53pIk8OYfPmEVgYjM66vZx0c+rt3jemDzhiqWrn30TE=;
 b=XDKhR2czMY6qAwlEoV4zinr51rnaPR1RQVp/dxruC+fW0IcEcL17Rrt1uGvuWgmdHK
 UDj+YutOmRrG8v+0bZ8oOSIOY2Asdza282dvHNUg+Yv4xSJ6BL6ZfG//QdI/88P9yMl4
 ZG3pM9+GXUK5hHfz0MhZ0k+Db7zAnPrS3Yw05fDioYDBjWUx2ZxVpjCsXzrUe3Bvcdis
 LrQH6YG282urK7/tUylx/LtQPjg4ZQL/Go+aNan4EwblPUSP2oVhCgwLvo91AC70h6zX
 P9WzKn9xRjA0+mlbjtyRRTT8XTcn+obxvYWxgyu44GSSnXSDrIZ/NLKU9pPtf1qE+wsJ
 DvTA==
X-Gm-Message-State: AOJu0YwW4CONmeeCbqaNhQ1c16e1jLwaclLS3UyuuFP7bOldbnT7qSuM
 sD47S7uAMrgkV2+2f10aGxG5e0krd4EX4NiSyOyFUH/UXUCYEy6XVZ5Et0jtEB+csenzLjzgzs1
 FhBjf9s4=
X-Gm-Gg: AR+sD10aLo+XdSlPHino8Cb8fpRivGlDq5K+uOuj6J+crffSUR49//b6PJsHSW2VnIt
 zAnZnUohAGVMByf701OurAdhAwCCzeIpB0MNCbWDjrFaQ113o76foa5en9jALbR+ieOx6vpYzHy
 L7fneyNQBQ3w1hJ+B5iYtvRUzgufsvXuIFi+DbUIlweJWjhOzPMu9DT7UI/1l6JvSymtDQ88mXW
 rm05B+8Ke2d7n7FMk48Z2mQV6GLQ+0ZxICTpQDzTJWlNFH4PqcdoeIRdfiV8pUvBwokUVCx6v0f
 szIss7jl6xUOhbGuiWhEbS7h1dbNJBBtxvYo1S2kIGqBpdTlsijUDytOCQgiu+StNVdsFvcJVy6
 DjOZYQ/N0+ny6NMCdNTiE2ee13SNTBJF5tQxCDRAtI93JBaHI/38JEq4gmXNbahAJpmQ2c8pCH3
 eUYD2KUmhC/dHMyvfMisr58tlI4RBz90YhJ26WgLbSuKv2QzjN7pxkUgWpUCL039O1
X-Received: by 2002:a05:6808:c188:b0:4a4:a930:1f76 with SMTP id
 5614622812f47-4afadf3495bmr12749083b6e.11.1786128257063; 
 Fri, 07 Aug 2026 11:44:17 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b1af5e4fc0sm231858b6e.11.2026.08.07.11.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 11:44:15 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/2] pinctrl: mediatek: add mt8366 support
Date: Fri, 07 Aug 2026 13:43:51 -0500
Message-Id: <20260807-mtk-pinctrl-mt8366-v2-0-b7358bb31521@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NzQ6CMBCEX4Xs2Zq2kAKefA/DgS6rrPKXthIJ4
 d0tePc2XzIz3wqeHJOHS7KCo5k9j0MEfUoA23p4kOAmMmipjSxkKvrwEhMPGFwXc5EaI4gkmhI
 xK1UGcTg5uvPnOL1VP/Zv+yQM+9PeaNmH0S2HdVZ7769gVkIJneVNqnPSypqrrZeOraMzjj1U2
 7Z9AXontkzJAAAA
X-Change-ID: 20260803-mtk-pinctrl-mt8366-ee0c69cc4914
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Deep Pani <deep.pani@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1094; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=/Zq4+RPo/x0X2QIq5IRmpuZBg9RDdADiE3eTGASCSGk=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdidqQ6qLSQi+DEdqTq8aEPzr3yvWz5AmBIpxE
 Qw2358oV7KJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanYnahYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AvtoIAJLu9Kbz/PSu2KMfOhsUehy+UZtUrqzzh9mZiUg
 Mh5PyV4/Ixy93dsuo6DxLBco9bYAwJ67Ckiblh2zWkMoQLeAb8zmLnLjrmuFpf8Db78sFaH62DB
 ft3NvNGnBhcZN1TkCuWmsfilOi9x9mSoPul91mJuWP7DKtQbhnXKS0GgOmvVU30HHZNrkcEDOWs
 cJ2c2uFWD8G1IEv5eIVC0rJ6zA7+SmxxbAseCum5pV8qv0R33vTIAHi5mLvo72SqVaQZo2GSPQu
 62qBjEuMkvISsxhjWyCCpj/0JDmM+mOgRDlbSccU34hWfmHeUl7W1shJUlETx90OxOPCiSdpueV
 UDSM=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786128257; x=1786733057;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=53pIk8OYfPmEVgYjM66vZx0c+rt3jemDzhiqWrn30TE=;
 b=EBs2xTkuDYH/giLTLWEdFRXvoyfrojrHr/s7pwnmpy1+3x4hQUX+x3iOTCK2BtY6Mp
 rM1fw4ZMOqX5mlz2ZFwibtHsujHrYttg9zDqsuqNd8vzjH5OIoZogo8nGYUqVnlYZ9gv
 FiGi8vA6bm/FS0HgIMYHGmLO5eq6ZJQwIHvhGftfmVJAvFjAYd/ZXaXlBjOA5BJnQqIk
 eIaiae4izAy1OKx40enbgPM9NKsMQOaPAkuuBlWTQFenRj5l1ZY208VpeWtYxfdGUcLd
 DBKGkpdG6vE+aeLVjJ7jO0T7Lv/nEr19pb4dIDLQgXPu123iE2Se4XTQzlBEPStgJ1uu
 OobQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=EBs2xTku
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

This will be used by Genio 360, which will be added in a separate series.
Tested on Genio 360 EVK.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Add macros to reduce repetition in mt8366_pins[].
- Add missing const qualifier.
- Include dt-bindings include patch (previously sent in [1]).
- Link to v1: https://patch.msgid.link/20260803-mtk-pinctrl-mt8366-v1-1-247d327e21b6@baylibre.com

[1]: https://lore.kernel.org/u-boot/20260803-mtk-genio-360-bringup-v1-0-606ee60755b5@baylibre.com/

---
Deep Pani (2):
      pinctrl: mediatek: add new mt8366 driver
      dt-bindings: pinctrl: add MT8366 pin function header

 drivers/pinctrl/mediatek/Makefile                  |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt8366.c          | 1242 ++++++++++++++++++++
 .../dt-bindings/pinctrl/mediatek,mt8366-pinfunc.h  | 1069 +++++++++++++++++
 3 files changed, 2312 insertions(+)
---
base-commit: 05b9e779d2be304609f7e9570edac049092c7736
change-id: 20260803-mtk-pinctrl-mt8366-ee0c69cc4914

Best regards,
--  
David Lechner <dlechner@baylibre.com>

