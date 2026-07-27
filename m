Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E49EBC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:43:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AF5F80C38;
	Mon, 27 Jul 2026 08:43:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rIhJdhoE_-ur; Mon, 27 Jul 2026 08:43:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 482E280AA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785141837;
	bh=yfok9hpW7tDiKTIbHM4a3mjoRUSGSSV4xHXE2yYf/5k=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VKlLGxKTqepr/Fc3R1NxtpsE5l0YrJWEDiz/RQRK++DCck4DgzngBjenKm8+WAXky
	 PqmzGknh78uVJmpfELGg5rDIbPMBZp983txLuMnHPp55mNlEGR99LhTUJ/4Bcb/8iS
	 F67dxHaqNHGX7M0K3Xqz7SW55+TZeyZk1Meld3NBw1IHRNA+/Suqmr1eU6ISlQczgq
	 CzU4nzqx2OmFu9d8vYctqo9Th2t4QuhZ24mROMZXRBFzpwxhrjvwwfiCa55VA3jlYR
	 1IgOSmjgaSx61VlNOe/r/4ly22oDV1dAlAcmVdlB+8yMZReuOACkAOYpGGBfiXlI2u
	 BAaDkzSUnkbYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 482E280AA9;
	Mon, 27 Jul 2026 08:43:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id F29A1490
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFE7560627
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:43:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SICNAMclAjQQ for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:43:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 08483605B7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 08483605B7
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 08483605B7
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:43:52 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so1875551f8f.3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 01:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785141830; x=1785746630;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yfok9hpW7tDiKTIbHM4a3mjoRUSGSSV4xHXE2yYf/5k=;
 b=IRu+WFA68keGHknBLkWBjMyfg60rBVJ/Zm4wk21IXJDplwr6kAGCbTfiTm3uyu3Ul7
 ra3vkEJWTrxZdKPxN1e9HmRdKHagXIkNq7IhKiXpL8KKxJVZ3e7UeX9XKM2VfG/12bL/
 RDjrgEE2cjhm+GBbymR7UZxcwmnQFpMOYrXsDHfCRg7MvwP8hU31xUq8ZvtWekPm80Jj
 nf8YTeettEY9OieoDewMqdhXMX2UU+4VYhRDOHcRjfWn147de3wqDvfN23K+NcDDFUoI
 nkPgs997NdwP/98gBDPfM/7p1quKEAnLmCcTz+/GZn0406b6+C9a6N4hj12TmMFWVb43
 ul8A==
X-Gm-Message-State: AOJu0YxnMPTwNYDgJocaUa5ovWPB9ejCs19CI/m/U0tpEPXuQrDgqUyP
 /FRH77cTpPrPbWOfiAr44fPbeN5CRlXonZjgVFl2yxOPK3IeeGhbb7ev21bubq+rZI0=
X-Gm-Gg: AR+sD134knchnZc51npuablyKMofxOommmBcH4bF7SMu0xoO9y4iyJUX+Zc6Aakce5v
 jvdpvhqffTF9bvXgfj/88Mi0rdNuA0Fws7tfDxviawn6aBU87iHH8sR880lw0FkyRGH22Qxturd
 2x4Pq0nk6FreD/Ld+ZVyXOQRGFoips9gujlMx28Op8ApkSOxssINC5B/O30kOWTJPkxTewzL6in
 vGprtrGntFGjKMVRbvfhsXDy/6MJbfm5Dv0PepBaDmpLgN5lKbrLMCtBxwZF6KOkYBZmzyR9fBI
 k72uc900zoRcjQ2OeENdtMrWRQ9GTiouE5CbfFvHFx8RvGF0is8jEdwHbv1tMqnB3+Qn03r6ALn
 0JYPwnSgSujmFo317ezB1pa0rX1XYLWOBqz1CSsEJ9ruUCdyqvpQHd0aC8YHEdX8vK58PBMTPvW
 x+dVRdd8WzYT2qKBUVPD0TX4FI6YtkW2TT4E4M8SXegN8BdOmj0Bcvj300K8Les7hzoaIfiEQwd
 xMcFtWaPnyzsEsXMMABcbGq3Pk9dd0lw1HJNXmkmpMZvBbnu7chRl8DOlMEVxs=
X-Received: by 2002:a05:600c:4704:b0:493:e79e:da6b with SMTP id
 5b1f17b1804b1-496b56f12f2mr97269035e9.21.1785141830322; 
 Mon, 27 Jul 2026 01:43:50 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4ed6b76sm216330695e9.2.2026.07.27.01.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 01:43:49 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 0/2] i2c: add HDMI DDC driver for MT8188 and MT8195
Date: Mon, 27 Jul 2026 10:43:44 +0200
Message-Id: <20260727-mt8188-add-ddc-i2c-driver-v2-0-bf1c45fcd588@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32OQQ6CMBBFr0K6dgwtsYAr72FY0M4gYwS0BSIh3
 N2CGncu3+T//2YWnhyTF8doFo5G9ty1AdQuErYu2wsBY2ChYqXjVGpo+kxmGZSIgGiBlQV0PJI
 DWSaoqpw0SiNC/+6o4ue2fS7e7AdzJduvg5+Eo8cQpP0vVrPvOzdtH41yvX7l6R/5KCEGynJrU
 abJQacnU043No72tmtEsSzLC3r8AnbsAAAA
X-Change-ID: 20260716-mt8188-add-ddc-i2c-driver-1a3d2f9e6d1b
To: u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Heiko Schocher <hs@nabladev.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Johan Jonker <jbx6244@gmail.com>, Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785141830; x=1785746630;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yfok9hpW7tDiKTIbHM4a3mjoRUSGSSV4xHXE2yYf/5k=;
 b=Y2Rk9Zn59/6PipU2MTdXBonDw1sroEaZ6h9prnBNsPRt8y9WiTUK8pKK+LG/CuAdil
 +tP7+hy7SD706ns3lSa+//WlCcVvu/06cyV1Fa8T4Rz49vozlkb9Ehnwxv0a8+Yo7WHv
 Pdmpn+uvjY3qAtGGzCMa1zidmEfhmdsBnSu9539uEgL7PNEyWPzwajOprajcXXmClUBO
 s/RZ7L7HbI0f70CGz8+XTWZ/NvjfDGonIET5A4ELHO29w3JOyjIfVNpkaHVyNQ5rStz3
 wQQ09zXG14CseTK/sFkTBM2Kw484VBcZusG5N8KESpgvANjSGTwv105CyqzEQaI+Yg/F
 OATg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Y2Rk9Zn5
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

This series adds an I2C driver for the HDMI DDC (Display Data Channel)
found on MT8188 and MT8195 based SoCs, such as the Genio 510 and Genio
700 EVK. The DDC channel is used to read the sink EDID over the HDMI
connector.

While at it, a generic EDID_ADDR macro is added to edid.h for the
standard 0x50 EDID slave address.

The full HDMI support will be added later, as a separate series to ease
review.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- use clrsetbits_32 as suggested by Heiko
- apply trailers
- Link to v1: https://patch.msgid.link/20260717-mt8188-add-ddc-i2c-driver-v1-0-e89ccd173567@baylibre.com

---
Julien Stephan (2):
      edid: add default EDID_ADDR macro
      i2c: mtk_mt8195_i2c_ddc: add new driver

 arch/arm/include/asm/arch-rockchip/edp_rk3288.h |   1 -
 drivers/i2c/Kconfig                             |  11 +
 drivers/i2c/Makefile                            |   1 +
 drivers/i2c/mtk_mt8195_i2c_ddc.c                | 394 ++++++++++++++++++++++++
 include/edid.h                                  |   3 +
 5 files changed, 409 insertions(+), 1 deletion(-)
---
base-commit: 78bfaf6281605509fd49262b0138cf1fb338ef62
change-id: 20260716-mt8188-add-ddc-i2c-driver-1a3d2f9e6d1b

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

