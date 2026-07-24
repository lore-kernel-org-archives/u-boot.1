Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B216C531F9
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 08:36:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7F1081191;
	Fri, 24 Jul 2026 08:36:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k_fe1YedRXMX; Fri, 24 Jul 2026 08:36:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E44781114
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784882184;
	bh=5OwbCvvxkPRUG5VT7m8R0gngTRtCKefEZ91IYgbtUjA=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Hc8nAXBw2bEZQfAr/haAy0u9Sk5dIt8D9XFEiUQtdMV3ic0d3lVwZpeSiVsf1AIu6
	 RM/mDux/d3sUqzUVXFg7PcPZ7m9YvtcCqSHr+ek+fSFOHohxyuNwNmoj2wrMza66zu
	 o6OwT5CEO4hCcvsW42ErvMEyHSBNQ8X7RFcYeJuJlZaozv4SJvc/q0QOOI+C2GwdMx
	 wbsNfhTbIFIUerTKdrdBwnHN8FdiUEqw5ZQNDuPYVantjhlcb2uLRIxoF3zY6pRf86
	 rqGUBVVvOz2Sf4gQtU6fdvqvHsozuUA5zAc51yb/KWxqmVaVVXIKp42PckJnaX5yiI
	 Ms/qOdOzaZAbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9E44781114;
	Fri, 24 Jul 2026 08:36:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id D095E347
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:36:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C047960AB6
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:36:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rad1_CmhqlOY for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 08:36:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:30::2;
 helo=mail-wr2-x02.google.com; envelope-from=ccaione@baylibre.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 1413F60B38
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1413F60B38
Received: from mail-wr2-x02.google.com (mail-wr2-x02.google.com
 [IPv6:2a00:1450:4864:30::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1413F60B38
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 08:36:20 +0000 (UTC)
Received: by mail-wr2-x02.google.com with SMTP id
 ffacd0b85a97d-4744516a312so45495f8f.1
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 01:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784882178; x=1785486978;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5OwbCvvxkPRUG5VT7m8R0gngTRtCKefEZ91IYgbtUjA=;
 b=JorJodFpqd0NqFbZ5X8yHSMK6kpiIyTvB9rWu77nYL4wrPIUfMv7abzu11dyitRG9c
 bP/UvzFpzPDroPdoFGDCYeATixjramkTdpk0dOKQj7v7PfqnwAajTDx3u4evkUoh4m5b
 u7B9BYeAu5Oew6ObQ9rz/3Tf+8xxNHaCNHxBF3V2lJjZTTqmAhh9SDpCfRNvT54CZ4Kv
 5I8fFg5IN7dRudvam5Z80JZs6pO4JGZ4t8xbZADzbXYmqQZ10yO54QNBDpYVc8xQuxkC
 xVv4d40mnZWQ3iwITGrnaHtGERxGEvxUO9lE1VYjpp79q4VrjTLlhe9mumqg36YRcc5l
 ruzg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqqUwKn+Y81tT7uxJRAhPSm4ubbL/5HHFornofXdseVqsirr45fL2JQTflfkotsA20osmyghtQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyZE4iLYAsuFDmbXC5Q1x9q3qGUsY4DffYIhjPwFre7kgfKja8X
 1XuxF9PRs4oGfoboqZEZTmh/fHKoh+osipxQcqFXw7Tdm6IWHfarmtva3EiI5R+7TMc=
X-Gm-Gg: AR+sD11CbkVUQluGvy0lEni+vYB4EMhzJ0kZh4cVf1TNrZBRGTj7If41qHozYT7Qfnx
 oMXBs8StEkaaQFFsSRk5QegdRfgvdQg0H/NKk08AUQDlrW9Rd0tNHw07jwNCurWFP5XLiywuTki
 hHuRhuQuzufhks/495kZyP34m8GLXu5jK14Fkzr41dGBXkwS1llCyrpgoJVSDJaLANXYraI9UN9
 vXJWQioT0S/h4Yax8IOCQr5nfrIvJ306663uWFsKtnuJG4H/PWfIHcbf2+4VvAmDfazhF6JcWv1
 aQwqjGX/dncSwCw7yr7mYihTf55JcDDIqVrbrCBN0ohqC8p/S5WZMNTwD4NxIYjnu949HpGArqg
 2UkR9ZU4GNbyVzkp7ufgVU4iXsW9rvj6vt9svxpNz80oT7+9mibZ/MrYX+79QgIg4X1Bui5HjYa
 WeZhIyhsXpjTnsWcE3xOHZOogJtompRbpRn69THkN1/Wh1CbrxLXnT966co7Qe/Hz4ub23YRvp9
 qA7s7M/RXG/jAw=
X-Received: by 2002:a05:600c:1c1c:b0:493:ecf5:89fd with SMTP id
 5b1f17b1804b1-495745ac487mr68227815e9.17.1784882178574; 
 Fri, 24 Jul 2026 01:36:18 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-87-0-90-136.retail.telecomitalia.it. [87.0.90.136])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f5665f0sm15324465e9.0.2026.07.24.01.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 01:36:18 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH v2 0/2] Probe MTK clock parent providers on demand
Date: Fri, 24 Jul 2026 10:36:04 +0200
Message-Id: <20260724-ccaione-upstream-fix-clk-probe-v2-0-ebcef2e94e9d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OQQ6CMBBFr0Jm7Rg6IA2uvIdh0ZZBqkhJC0RCu
 LsFL+DyJS///RUCe8sBrskKnmcbrOsj0CkB06r+wWjryEApFamkDI1RUWGchjB6Vm9s7AdN98L
 BO81IuSIpi7wkqSCODJ6jcATu1Y/DpJ9sxn11N1obRueX48Esdu/v2CxQYJGWoqRLLanJblotn
 dWez8a9odq27Qs7zWdi4QAAAA==
X-Change-ID: 20260723-ccaione-upstream-fix-clk-probe-24a27764927a
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Sam Shih <sam.shih@mediatek.com>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784882178; x=1785486978;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5OwbCvvxkPRUG5VT7m8R0gngTRtCKefEZ91IYgbtUjA=;
 b=L2ByfcttqV/ed7dxLbDG8577LsLRt603f0mlJsoVb61bSBVS5tZizEr2xRclgsOq2P
 ELOyCb8jxvnxCxs4ue6hpp2GUOIRL+HFViDZofOTDhnECLC+j2wRHnbDoRFWKEkqSsNZ
 Mz/cS8lyK86DBPxpzPB4vQLfLGkDJ/1pDmQB6+1Imsz4nKw3psjlWpf0dmAUsTlOGKPt
 F0NtNGyejtcdsbnpnvdbTH0O1I5byQjk8Fj0JQDjjFxOQeCcSsHeKHRVkCgRVam8Cwsc
 U28e2awCjryAJPpnU2/nY/Ujm3kAPGpOkyVX4ve8Sh3P4zIEqnB+lOP8k+osY07Eb9HQ
 l3bw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=L2Byfctt
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

MediaTek clock controllers may consume parent clocks from another
controller. The provider registry is populated from each controller's
probe callback, so an early consumer can fail when its parent provider
has not been probed yet.

Rework the parent providers on demand probing mechanism.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
Changes in v2:
- Rebase on Julien Stephan's driver-data clock refactoring.
- Match and probe only the exact missing parent provider.
- Remove the common probe-after-bind setup in a separate patch.
- Link to v1: https://patch.msgid.link/20260723-ccaione-upstream-fix-clk-probe-v1-1-6091925d72f3@baylibre.com

---
Carlo Caione (1):
      clk: mediatek: probe parent providers on demand

David Lechner (1):
      clk: mediatek: drop probe-after-bind provider setup

 drivers/clk/mediatek/clk-mt7622.c |  2 --
 drivers/clk/mediatek/clk-mt7623.c |  2 --
 drivers/clk/mediatek/clk-mt7629.c |  2 --
 drivers/clk/mediatek/clk-mt7981.c |  3 ---
 drivers/clk/mediatek/clk-mt7986.c |  3 ---
 drivers/clk/mediatek/clk-mt7987.c |  3 ---
 drivers/clk/mediatek/clk-mt7988.c |  3 ---
 drivers/clk/mediatek/clk-mt8183.c |  2 --
 drivers/clk/mediatek/clk-mt8188.c |  2 --
 drivers/clk/mediatek/clk-mt8189.c |  3 ---
 drivers/clk/mediatek/clk-mt8195.c |  2 --
 drivers/clk/mediatek/clk-mt8365.c |  2 --
 drivers/clk/mediatek/clk-mt8512.c |  2 --
 drivers/clk/mediatek/clk-mt8516.c |  2 --
 drivers/clk/mediatek/clk-mt8518.c |  2 --
 drivers/clk/mediatek/clk-mtk.c    | 46 +++++++++++++++++++++++++++++----------
 drivers/clk/mediatek/clk-mtk.h    |  8 +------
 17 files changed, 36 insertions(+), 53 deletions(-)
---
base-commit: d10c5c793fe7b45f6d1751265588188b10f65e53
change-id: 20260723-ccaione-upstream-fix-clk-probe-24a27764927a

Best regards,
--  
Carlo Caione <ccaione@baylibre.com>

