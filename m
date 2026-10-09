Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4A8CA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 16:15:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C72D9608BD;
	Fri,  9 Oct 2026 16:15:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FY9X5u_BYa3K; Fri,  9 Oct 2026 16:15:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B3E73607B2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791562552;
	b=AWGEagS7ggsYnXsd9izKnYft1hxPXBvYlnzRnWr4CDgdcaA4qsdnfF489K0z22yBs8l0
	 uJMfMUPfV2drH2dn9tqWkaSjZCC3tTPfmWIBrR0gimjxI4aMFi7ayMB16xgMPMMfNemoS
	 s3cb9t+si+mNz5QWixfi/DzO29X7v1gdN703bYhTutxPkA7xvLP+oIz2R2/T6QsBwcE0V
	 qlLz7ljEZQrnOKFGKWXIm87/Fq5cUhvT7v3bdEMqhYFp4zODhCE8czhE5rsecFWMYDNnK
	 F+R4l8SO42459lV/Kt07oIj2b3u0tbFA/J9hWrPg9RRl2hJRQG7UlHsxVVzJnlITEsw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791562552;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xhj1PZmMdBBO62m12GwZl3VhoCaUUMtFAjskgNWfUmA=;
	b=lgzWWrM+WgntX6ZU6LAizM++ER4s4kXCS/oPpqStw36DEqWxUdqEnYQEVxUONbWyQ56R
	 LzskDIomAQLxzdmaFQGHx0fFMlNj9I9EMy03iyuKutorZD/agHHwshCzBbfxflimHd/Zb
	 iItMRzuM4O0S5zsNVTiGOdek9O7HQ+cAN75pjtOXBYjsKHvAPsinEyj8Gqp5YAHLalxFF
	 KgbYiCxZDOgm1OCBtmSUwUrs9VJjTzKfxxTep4+ZJjCF+zymB3AFqtmRfRUkXnvm6nMs3
	 P3yp04FqJtzPlXhYZWrNXbhI6R9M6uskWH7c8NR1eJNXxG7ol4CT73rXn3Tx9qLO1fQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=XhNo1pYN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791562552;
	bh=xhj1PZmMdBBO62m12GwZl3VhoCaUUMtFAjskgNWfUmA=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ji8Ms6KlzD9bDe4ptCqLBMbLZTzeu0M1HkvF1mYo5PYx9luNcq4nzrYRSVmtKKfqH
	 K6lslKILPp+se5VhIE7KByndtkFHi/0eV2wZomMgPTx9TPBWJxyh/7+LQ4Gyw0W6d6
	 b9UYygeygzGULWC6SWuJW95l8C1E4SeTFLZZikmyCfGNNs0w68e462HJMIoaHBrOlk
	 M2UpFp0LCKDJdiRThRg4WRVJZzvbzYjNeC0ISSd6b4Sgvu7IlAQBacMQrjJU/YwUax
	 fNjmgA9NhYgD2PxHICQ3jqYsMeMgz8X2Fg/o7Y7LO2MbEuWqOjZm5xcxAQ9pDmhIrt
	 WkNnQBHufr41g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3E73607B2;
	Fri,  9 Oct 2026 16:15:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C3A62356
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A98FE60644
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:15:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JjeD8nB1xZ8Q for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 16:15:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 00C35607B2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::231"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791562550;
 b=RgGL4GpbQJVlKkqzXKfM2r1mN7CQb6nkDbG6EdB/+u87GlWX+B6kqCyL+Si9q//eNWFO
 6HBQhcCLeHD9xzkzMLD9kPhdoNzBGYQLWs8lZN0oL5iRe05RziGGc/xeBOU+YvrYhtmHM
 /2nZH1+bEJ8CMLfLF6MKLaDRASYaTDOu20fZn1Wqq9UwO7QNL/Y/H8Tlfbi9uS+oObNoV
 JfhjlaLR4uw3BwnW9yWRBM8KEriJC4FDfyGoZDuTQTCLBROXi/x5QGC6YPrD8NjztJsm/
 FXjIdJWupVNsUzmDQoxbcSZxjQUBHHzIJY9nJj6QdQ/rfM+7LUC5pTdQaKGXxGqAyhQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791562550;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=xhj1PZmMdBBO62m12GwZl3VhoCaUUMtFAjskgNWfUmA=;
 b=rn8xXV9wSpHjbTRTICZbLGwwC4kDQMgphNCX2SeNlI7kpbjClB6oLkCLVgsKRg5pLZFD
 AJXe9hL3CD6a7xYcdvIJY7gUZ6mSjObGEf01uZI6bYQkGGAB22a5N4X6bPyvM/ZuB/U7z
 929pvzO8yKwzUHQIlm/y8hVTlK7RsYkYrNOMiY1KNjodL8/u3N/YmhXWjlkoX5zGAw0b9
 Ms8fU+Ob/Dw6wMRASq5Rmjk1O0atE6296lIKF+JJFWr5/Sea93ALc+6Nz2nUiVFPAe2c4
 wPaAWjJ04Sxy1nrzsqOyaKW49lhEfKB3rmRGGLTqQGhJpGqEsxiqlL/mppToZ6sVc4A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=XhNo1pYN; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::231"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=XhNo1pYN
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 00C35607B2
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:15:49 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-4d198f1a591so2204261b6e.2
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 09:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791562548; x=1792167348;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xhj1PZmMdBBO62m12GwZl3VhoCaUUMtFAjskgNWfUmA=;
 b=XhNo1pYN5uAIw4uG8uq3VoiMC4Ha0O0XqVhEMFSIu0LJBqvlTqtDYdcgqE4JFrzAPi
 I6hb4a+xv41oA8JAzLtSiW1+d8QYIU9aXa6V9HcChUcTb9tu1UPxkNFz9O1aAd15xhTw
 oM2stKCkOigK34lEeBaStgbqNudzUFLQFShM0+sg3NrRGl8DJtturnyxhqAj939bWBlI
 7me2b2lf813jzVaS2oAq2ljAHgxBq/uODbFUiTv/vH+H/SiygF9MUb1WC4kA02yebhR1
 PkRgKZvpgh3Lc3fi1zToR9vtRzsI4/Hqz164E6nyV5dc9+ZXZ/5ZOSKkFpE8RxZgp9OR
 8/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791562548; x=1792167348;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xhj1PZmMdBBO62m12GwZl3VhoCaUUMtFAjskgNWfUmA=;
 b=W9wqJIpRjNPMaAtXvczlsNfbDN7oOPFduunED7pSLQgE6oLFbLsYapKDjYXqCmxM7s
 ls4zvDQ4txHObm8LRONgEn0gvKWhiDsUsK+MYh2ngQDHpsi5OTnEacAm6Pi+P8DptnwD
 yFzmVYObdUXYyhF2/gwP7q3drRbmZLDvWz+SU1fuWC2DiOwDtyR8ncQij+G5L1T78bT5
 7qwEx1PRrA6ngf47t4P7h68qcr9iu/Q7+iKo6lsroGbnmmACKsms/h8BJaTm7HjWQVF0
 dyOEXoh5NvYoWIvpV2gCI2aYBlBr3bGyvuakEheT3v7i6bzpW+JiqikjYnBKzuBILMMg
 rdXQ==
X-Gm-Message-State: AFuF++lz+zw/DNrr4PivNCyq+kKZwKelNAzYJBzaKKrwLTGtfEDF6PMk
 K/ihUSM2OpJ79ASKW3sXc/1SjjsFUMc3CBoSCPeNe+yxongZcjA88iQ3facKVN5KBhA=
X-Gm-Gg: AYBFou1WIvquyKE53L6wFw0aW8UWtssJNOff9MPZK9t0oLfzbmDrtjO+c1c8gTTEEVL
 kav/ytD1vtnFwZtBSrOeOIIBCXWNUhKoKGPLYAgpWuOCJgekuEhta3HDqRMxuMBEMlV4JuATRLC
 JKTx5Uw65mKSwZMYL5wj32Xg7V0wS0e7Qav7chKhm1e1cZjptfJYM93OR5IWCscZL3nWHV6BSVc
 AGO4zZuuAg4U77L0zUO3ZIK6dgnmfheLCCOYV0fWkP0a8BhTdzJejXrgQm08td37kRBAnFjvYmE
 7LYHLtzIkHxLiupD9W9oD0HL6Di7DLn4+OYaW1sxw9ga1wlzzjl44CEDcWkPK7L2etNnaZDL9Em
 i9WUtK+Ap693UmGQXtQG+miF61jJYcw7j196Ax3jZstRtmF71AU7k/tSGObV8Uy8TDoE42ym3K+
 xIVd3voS4ddjJ5tH7ly1cDGBtV6zaprogO5+MQs0MecFMRmK5QFZ9kpKGeentfDiVZOtP/1XUIH
 KHy6qyIw8RIGC4=
X-Received: by 2002:a05:6808:23c2:b0:4f5:1273:14b0 with SMTP id
 5614622812f47-50c59399bb4mr2127722b6e.44.1791562548453; 
 Fri, 09 Oct 2026 09:15:48 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c0c5fe7d0sm2451506b6e.2.2026.10.09.09.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 09:15:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 00/13] arm: mediatek: add eDP display support for Genio 520
 and 720 EVKs
Date: Fri, 09 Oct 2026 11:14:03 -0500
Message-Id: <20261009-mtk-genio-720-edp-v1-0-4fbcf5b2904d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43Q226cMBAG4FdZcd1pfOBgUFT1PapcjO3x1lnAx
 AaUKMq7x7AoVbeVkhujscbf/MNrkSh6SkV3ei0irT75MOaCfzsV5jeOZwJvc10IJmrOWAPDfIE
 zjT5AIxiQnUDWqtLCoJVcF/ndFMn559389XCt06IfycwbdHREelrysPna9tcNfAzuTsfY+masT
 R64caqxomqlKLuV37q3Cmu5yoqSdXX91IDW7lJapinEGUrHqDbONkyKbhWfioqXe67VWwow4Ug
 9pBnjTBdgjQKOLWqpSLWu6dby84RC7p7pL1tErloYhvSSoHHUajSGo6u/tKooD+QCUwwTnjF3x
 e2QnOkMVQ256n87DpQSHtb9gbVXjKzHbTXTE47LlGAVwECLttZOYomt/Knxpfc60ncThh9fsv8
 ETX489wRhg3mGuZG6sqopS43/whpT3jsMg5+70/7TljSHnHC8+wjqQoSRnufi4e3tHRh1X2HpA
 gAA
X-Change-ID: 20261007-mtk-genio-720-edp-3685b2cad31b
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4116; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=6FVQd/fnUVjqu44vrJ1Ea5Pe/pjDlYgHO1bTH23TIP4=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqyRLPcEpjmwd25/+8E7wNzN0uV34OqkzHBEQE9
 NVjktEW0LSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaskSzxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A4hcH/R/eheYF+Br6F4DY/I04R1gq3jBOTE2V+YFTLXs
 1Ag8RLcx2HaniM9m88T1RRX7su2DA97s6Tmqpd6JeGmMBOkyv8mzokPBlV7dZ8gp9LPZIFPFNEg
 WGhHyHhBb7cree5hre1jtQvvQ6Hrn03Mw6o4p9k8fN56etXDsStUPPlYVTm7MdQkLqJcZcwt2t1
 N3w/GE6Vc6NDN5KNHx4u/2oS4rxXYwcq99dZ0bc+Di+qruSkwnkoVD/P69m9205BBZTJz2J56Eo
 MQ1Yq09V4SSBpNoj0ejMdm+jpG4ozDP+hHVNLfZ/qOksl6lh3oCKwW4+8XZ/rw+UoWR/hwLTRwW
 KgTY=
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

Add an eDP display path for the MT8189 and use it for the panel on the
eDP connector of the Genio 520 and 720 EVKs. The pipeline is the same
OVL -> RDMA one the DSI path uses, with the output crossbar switched to
a DVO stage that feeds the eDP transmitter. The panel mode comes from
its EDID over the AUX channel.

The EVKs drive the DSI panel by default. A new device tree overlay
switches them to eDP, and is built into eDP variants of the Genio 520
and 720 device trees, with and without the UFS overlay.

Tested on a Genio 720 EVK with the eDP variant.

The device tree does not fully match the upstream bindings yet. The
Linux bindings it follows are still under review and could change, and
some of what it uses is not in any posted binding yet:

- "mediatek,mt8189-edp-dvo" is added to the DVO binding in an in-flight
  Linux series [1]. That binding also wants an input port@0, which is
  left out until the MT8189 display path is described as a graph.
- The eDP transmitter and its PHY are separate nodes linked by "phys",
  following the in-flight MT8196 eDP [2] and DisplayPort PHY [3] series.
  "mediatek,mt8189-edp-tx" and "mediatek,mt8189-edp-phy" are new
  compatibles, and mediatek,dp.yaml has no "phys" property yet.

This series depends on the Genio 520/720 DSI series [4] (and its
prerequisites) and on the MediaTek clock rate propagation series [5].

[1]: https://lore.kernel.org/all/20260714114414.184512-1-angelogioacchino.delregno@collabora.com/
[2]: https://lore.kernel.org/all/20260709113148.49090-1-angelogioacchino.delregno@collabora.com/
[3]: https://lore.kernel.org/all/20260910092038.48291-1-angelogioacchino.delregno@collabora.com/
[4]: https://lore.kernel.org/u-boot/20261006-mtk-genio-720-dsi-v1-0-7fa10e9c4506@baylibre.com/
[5]: https://lore.kernel.org/u-boot/20261005-clk-mtk-propagate-rate-v2-0-b823df57e4c8@baylibre.com/

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (13):
      board: mediatek: MAINTAINERS: match the Genio 520/720 files with globs
      linux: drm_dp_helper: add the definitions needed for eDP link training
      phy: add the DisplayPort PHY configuration options
      phy: mediatek: add an MT8189 eDP PHY driver
      video: mediatek: mtk_ddp: allow routing the OVL output to DVO
      video: mediatek: mtk_disp_mutex: add DVO support
      video: mediatek: add a DVO driver
      video: mediatek: build the overlay with the shared pipeline
      video: mediatek: add an eDP driver
      arm: dts: mediatek: mt8189: add the eDP display path
      arm: dts: mediatek: describe the eDP panel on the Genio 520 and 720 EVKs
      arm: dts: mediatek: add an eDP overlay for the Genio 520 and 720 EVKs
      configs: mt8189: enable the eDP display path

 arch/arm/dts/Makefile                     |   12 +
 arch/arm/dts/mt8189.dtsi                  |   48 +-
 arch/arm/dts/mt8371-genio-common-edp.dtso |   54 +
 arch/arm/dts/mt8371-genio-common.dtsi     |  134 ++
 board/mediatek/MAINTAINERS                |   11 +-
 configs/mt8189.config                     |    1 +
 drivers/phy/mediatek/Kconfig              |   10 +
 drivers/phy/mediatek/Makefile             |    1 +
 drivers/phy/mediatek/phy-mtk-dp.c         |  276 ++++
 drivers/video/mediatek/Kconfig            |   30 +-
 drivers/video/mediatek/Makefile           |    6 +-
 drivers/video/mediatek/mtk_ddp.c          |   24 +-
 drivers/video/mediatek/mtk_ddp.h          |    9 +
 drivers/video/mediatek/mtk_disp_mutex.c   |   47 +-
 drivers/video/mediatek/mtk_disp_mutex.h   |   11 +
 drivers/video/mediatek/mtk_dvo.c          |  417 +++++
 drivers/video/mediatek/mtk_dvo.h          |   33 +
 drivers/video/mediatek/mtk_edp.c          | 2385 +++++++++++++++++++++++++++++
 include/linux/drm_dp_helper.h             |   12 +
 include/phy-dp.h                          |   98 ++
 20 files changed, 3599 insertions(+), 20 deletions(-)
---
base-commit: ca1c29c01bbd03f89cd86159b2959b4e72d41aa9
change-id: 20261007-mtk-genio-720-edp-3685b2cad31b

Best regards,
--  
David Lechner <dlechner@baylibre.com>

