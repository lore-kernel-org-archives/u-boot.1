Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7669606A323
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 00:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dtcpZ70P;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=nFsC+HK3
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A85BF60828;
	Tue, 17 Nov 2026 00:06:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gkRiTRzRhG7t; Tue, 17 Nov 2026 00:06:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C238460811
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794873989;
	b=LuYKXo68xyXNVmFrVw2OYxZzI0jsgtZCNy53CW3c/vWoAQ1q3VQafUCIiA5/pW6nxMgG
	 BJhT0cOmRc/kY3kgNZ41ZRT2H5iQetRjkguG6XAAydNXVJ1JCAUbC091kx75AqjvHDm66
	 FloJjvZFcMaxf/BJv9tTM8fvQqosiW+YBlMbz/zBT9QJmBu3yP6tFQx3UP+Vua+n5sfzO
	 2Hia4Nisyh9pHVlY9qaVRz+4Wkww400kLmERxFEVuCh7j1As1UlSgH3pXMGRZCPkZPwmI
	 O5ESV+GLpCHAPp041gCEiH1LRduu7Sj1QwVOEWkXwS2dmHs9ic4707oWCCqHR64VHbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794873989;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BA9OZS2fjE2TObMt+ifGH/ozaf84uqMGGw96Pxdo+qo=;
	b=dUShd+vTizQ8ghPr2vanUmPEjmRRgWph7Sq7WlQ4hOIiB2cmCRzVN4jyMp3yfk1qXjAy
	 NpQ2J1s/CCdNbqeLo92Nsxyek/hTg9ULpRhatp2HP7MR0bnFJGLVZhzZ8hUIp1WtTyAl/
	 syh/tu+RziIxd6DICkNXiKqKRwZ2/DgOIH+5tLJikkkoDqJ5M6kcDqo1nQiW8UCX6si8J
	 bFwgxR1CPf6tMnb06okLwArARKbYMPxtdvBgrt7h+txf3MZ5CsFO2GWIqNBMHOE/vJa26
	 SMksiQETIUBD5FUOZekHH7CelTIM3v5ivZwHtUVtAtrFQKvl1ZhIE+z0fJ9xngaMyWQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794873989;
	bh=BA9OZS2fjE2TObMt+ifGH/ozaf84uqMGGw96Pxdo+qo=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dtcpZ70PYVFOXqqiI+hhGYDG0AAvIrPofyD5dpVFDFBEyWy7+KbeGlX4fIMMvJgLb
	 WFEwtTb9BESeVp8qQQtSz2tjjwJQ6FvGVkHqlkn/cTLn/q+BuT9+9lqOL61igjj5OQ
	 CyjzddxCW36Vg134xveqrQTBLv2/a8JLkOqqu2PrY+3Yeuee46IRsDI3K7kTAm6ZkW
	 /182N38UBHQmKi+QzEm0Ah2suqB3o16gwJyyS9Jb+VkRsa+P4YsCVXl6+EKBqc0SdS
	 WkbkDwxx1VBlioDgbHywo6ZibrVvBSeDrmbLw1kffv4MHsNXDQd4p5h5YlMnyiKdbk
	 oFVrQAVH58BkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C238460811;
	Tue, 17 Nov 2026 00:06:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A4F249B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 00:06:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 76AA280D83
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 00:06:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DJSTE-hkZXAP for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 00:06:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8AA7080D80
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=nFsC+HK3
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8AA7080D80
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 00:06:26 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7f84a55e31aso3159445a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794873985; x=1795478785;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BA9OZS2fjE2TObMt+ifGH/ozaf84uqMGGw96Pxdo+qo=;
 b=nFsC+HK3BSX+nTF4vKOhZi6BYLJ0jnj2T8HyeIOvG/i6kgC2rjTTTVtfMQNux4hQxt
 qSdI61sXEc0ZOgdi9z1MvBzR78q0kcxMIEn/aFu3IRnMD25ZihXnEifLuw0Zc8iX4IXM
 XM3VO01yh26M8wU0jBMwbgL+uYT8Bhj8chzWwTfnuRKu4QyifIUp8Lxf+53wd8FsFOKR
 HFPoTEdOI9xeF31uPSwnF1ZLSrLGMBz49KNJw3kTdFbs1dSL/xSSUCFV1iOPChjtzW62
 LN/7jVGxdSEfHNRIoXLwHkL5nMxUU7QvtlVMIYG2JXKQVZBD7cPUcxOvJzRrPUBxYwZk
 yfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794873985; x=1795478785;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BA9OZS2fjE2TObMt+ifGH/ozaf84uqMGGw96Pxdo+qo=;
 b=XoVNzSx5NWM+kVPTUfBgBr/ZbLwV7Y4qhYxgJXp+6vQdY85hgqqeotG2H5ZrygO7rS
 W8ytPylfXq48Gd/jAcc+HLXT3UGs2WdyRrqc0JodqaF1rTBojpA9O56IQmvc5jL7SVv0
 oOrCwXpDo1fnQrxnf2SlrX6C1e9syacJNj8q3LJ4rdT6NF4v7yJAtkybXmw2PrL9B8EC
 NpJ1E60rLGRQQihsMT9MQ7/LcjEsMD9me24CfJETrMu4aMQRgdW2w4ANkk7tVg8CrPtF
 ZnayOxA+bfV3ZvQhouLSnXZlEtez0Jgzv4TkPKTncbnN01Few9xBMffi9Bi3mdX59Moy
 yhGw==
X-Forwarded-Encrypted: i=1;
 AL+hErEmHWRYORo7eebd2Oc9y6jiDhdcsqk7JrfGkVzmPA+zDV1UWr1YB8PP9NY3DO86B5HhE8ViBZ4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z93xB4To46pZWBQre2mzevS0M1Di/aEq7qZwCv3OhdvNJ6qtuus
 ZdygDyCAgccW+6U1s1Xy6uMEPprbLo2tsC0M4YDVUen9twHa8ll4uXI07nkulRYX2vU=
X-Gm-Gg: AYBFou2g51a2dQTVm9ytEmcswIZm+5BLxHrT1VKH8R8UPmSq2B/KZIAGQy8qGOqEZpM
 f5QUDXax1zMvkXdeqJCz0ebLDOIsK08/Id9XJwWOUncq2pkNDpu+R1jHjt++Mnw8FLTDjFbhpEw
 FcH0Idh9D9Mo3Ps/Xe5vDoqs56GZq/ZBZ6wdR+3BCUvBNyIWVXF1YE+iJTIZZWKaI7gwv5emkF2
 qZFiunGkOvISvngnjyCeKZd3wZn2qnTOxJObna1W8IB+UO2ZBe1TGfugQEA+bKYs6Vjy92LaVA2
 N11X2FekQgflzBH4ghaSnOOZgDrls3fLXnEm6Og7Aj42VF717I/nuj0sK+3qGmFSEZvYowcPxOq
 co26+xehOB7tzJBXjleZzpmUVXVn770/x47qqijVfkB7JvDlDwtNjvr3ZR5hdOQ+CMpo2KYcauv
 vNtyVxH4Rjvh7lVhFbHuX7tXWwPRK5Vcef+7LCMDqEe1Mc8hXX/rA9ZZxhnfamNgVCyewl3Sywk
 iowoQN7oylZeAzkFCEIf8fvpS2M69hvJosITvbz9dvZmOta6gQ+1tcOU+emVeXHH6oXKjNtiu/e
 VelKHTk5wNKP6YlPr0GAR0mpbM+aRxzsTA==
X-Received: by 2002:a05:6830:411e:b0:862:c3b7:c2b0 with SMTP id
 46e09a7af769-862c3b7c655mr5000484a34.9.1794873985582; 
 Mon, 16 Nov 2026 16:06:25 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7056:3b5b:7d85:4921])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862beb11508sm5097254a34.3.2026.11.16.16.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 16:06:25 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/3] mediatek: mt8189: add SPI NOR boot for Genio 520 and
 720 SPL
Date: Mon, 16 Nov 2026 18:05:52 -0600
Message-Id: <20261116-mtk-genio-720-spl-nor-v1-0-7a926f80dc78@baylibre.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CMBBA4auQWTtJf5I2chXjQsqAo9iSTiEkh
 LtTdfkt3ttBKDMJtM0OmVYWTrFCXxoIz0ccCbmvBqOM00pb/JQ3jhQ5oTcKZZ4wpozX4HzvDFn
 rPNR2zjTw9vve7n/L0r0olO8MjuMEFYCdjHkAAAA=
X-Change-ID: 20261013-mtk-genio-720-spl-nor-9c67d62e3367
To: Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1111; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=mExWE+tk1Pph7DRS0Uq2tlgsJdJjAVKlDa4uUmKWNsQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq+5pk6xLCyAk2cnv18so8k/Zqx1z+YdWBQnlTA
 o2x04DAH6+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCavuaZBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ADjUH/3A44u0sECJvYHeW2dknnqgOO6V3TiRJ6eg2Wbq
 Ljqv6x9aHFZ99Wn/fNH/BMw7FfWfbHmJd1F0hC4ZS2OIgjNf4Hvj9dQ3h83o0MbpkO2BhdRCBPy
 Vk7mZ19cnTVMTnYYwZL0DQhfQVjBrFhD+CvaqzueFgWiOyEoeGNK3HYbY9zT0Q1YNSKzVG7W6yT
 EcjN6XsQWJALxegoEtkjdRYFZvIzwzrZI4HyVDPkUE0azZIHS9OL94CpQQX1+ul4+2XAMrw9c4K
 Qwph7DvuaBMH/8hl9+HEWU05+9QyvPGRv0OYg2BC4IuOWXgUNrAt2Rk3GX0Y4WQ9jDbu/EKbF9E
 rois=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is the last boot option for the Genio 520/720 EVK boards, after eMMC
and UFS. This one worked with no runtime changes needed, so it is just
devicetree, config and documentation.

Tested on Genio 720 EVK.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (3):
      arm: dts: mediatek: prepare Genio 520 and 720 SPI NOR for SPL
      board: mediatek: add a Genio 520/720 SPI NOR boot config fragment
      doc: board: mediatek: describe booting Genio 520 and 720 from SPI NOR

 arch/arm/dts/mt8371-genio-common-u-boot.dtsi | 20 ++++++++++++++++
 board/mediatek/MAINTAINERS                   |  1 +
 board/mediatek/mt8189-genio-spl-nor.config   | 12 ++++++++++
 doc/board/mediatek/mt8189-genio-evk.rst      | 34 ++++++++++++++++++++++++----
 4 files changed, 63 insertions(+), 4 deletions(-)
---
base-commit: 542bacb838fc199e77a35127e3c801b9fb334663
base-tree: https://git.u-boot-project.org/u-boot/custodians/u-boot-mediatek.git mediatek-staging
change-id: 20261013-mtk-genio-720-spl-nor-9c67d62e3367

Best regards,
--  
David Lechner <dlechner@baylibre.com>

