Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEE2E94623
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 23:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E9D88341A;
	Tue, 10 Feb 2026 00:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OlrmuZeA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC14683C61; Tue, 10 Feb 2026 00:35:11 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CE93805D7
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 00:35:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-45efd53148eso1222472b6e.0
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 15:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770680108; x=1771284908;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=amvXWi7XE7GQCk1GMPh0IYUHo4RJIT0U3ojOgrnY5kk=;
 b=OlrmuZeAsOOSePVEhtZMVNnRgNXqkjeZFkVdyppDSKzH5/+g2FUMFEuuyF6ACsWBNa
 W8nM7AoJN5XPMdzSYm/4ELRlu2rgBIGsX9XpFTAZZUlCDU3+ERBz2ZkO/bFUjzug8v20
 E0tsGkwdF+H3vaZ1xee+77C8Jo1d/AWFLNbHlFTvWDYJbgXUe0ofybU/fPij/fl7Mzwj
 bRiBnrFliF8jSNinunMTLrDuWbF4Qi/hUvyP1XGhv5FiXWy/E+VCPf+IeAmVrxvcUS2+
 kMlxgKNYnDEveVaqv0mRtVQD3H1koZYMkTp8MvhFQRjkDP++jBMCTYh8aclHsW2a8KqA
 8BZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770680108; x=1771284908;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=amvXWi7XE7GQCk1GMPh0IYUHo4RJIT0U3ojOgrnY5kk=;
 b=dFvWQaGCFfpXVXybS4a1HLx3seqTF2K/+BRhM5WbBtUrbopei7V2Crd5KgbuvG+dPI
 DmW6ULn9mbBRPP92+prFMEhm5opXWYZknifyW042Zmh81EOYIGdVCAidHWgf9Qf9/GnF
 lDtPoOeQFegiMBULwRmc86YvsrZzWTgez8qxhX69oDYLXpXuIPlQcoGbUaIhJFbdJ2DY
 8ipMGSg6+Oz+6sxvwDCqG2ahoIFF8p+TRrCLtkrsfM72xZaTwPV35luh2fdQerZ2sODF
 eOgpbfIQa66NqN1fSl/Xje+LE+sSLe8VIo93ZcH5t6fI3tBa+Mni1PtM2yeXRX508Iqc
 KROA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgcRaqSohyShxMn+UWyMTDJ2qJoZh9lGAUHkaZ4V6PLyN2J5egz8DpYBxCIuqOTZN0T819ijg=@lists.denx.de
X-Gm-Message-State: AOJu0YxnteiYD67CsSCH4YXUfJ6csozw5BuGt196Lyi7uq5+2GxcEjuh
 b4KouZgLJqcy3epwrc73+X+it5XpXGW7jzdqqKkEDFxI6N3vlWtBF1+Yl4ZVLo2iMD8=
X-Gm-Gg: AZuq6aIo0l5bSl2Gypyd50lzfCIKqs7FOIiAJ0oNBzszWpZBqwJNT0PbwiWMzgj08cR
 DQb2/vlIcyVbgWeIwDntBpXAsAZ5wMINooYWPf2oRFK99Ya+8KXvBmVXdLjNdkDjoYaZJyp8/4F
 ruv//dtsFxf/xairUAqR8aC36MXrSotbxFOjFsneqUOEqbXz7jIAw7Gw7AnlQr31RvfeCL/OZ7o
 OYB/rRT5qaZCh2jwbL7Ciz1zCFX1SmpnBz1StK8HFGlLZD8n31+/kO2CjAzs2bhHtSMLaXVxhi+
 E9OilXJoumX94uMybREogl03ySbT0zuslXlo56b37k4bMsqM3RIgMXdKfnrB/Z7ylxdTkwzVjc9
 rHMT0JMD99HwWm0D1sEbEr6QSCNrLTFSOknBgslp3TxNRp1T1J9pb4x7dXmyGF9bUZJw+hGnqks
 ptgxuZim9aYdX9K7e+Yl6U75RxYdI=
X-Received: by 2002:a05:6808:338a:b0:450:b8da:b800 with SMTP id
 5614622812f47-462fcb1e0f3mr6877944b6e.47.1770680107890; 
 Mon, 09 Feb 2026 15:35:07 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4631407de2dsm5304309b6e.16.2026.02.09.15.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 15:35:07 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/3] pinctrl: mediatek: support for mt8189
Date: Mon, 09 Feb 2026 17:34:16 -0600
Message-Id: <20260209-mtk-pinctl-mt8189-v1-0-a7a3069eda6c@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrDIBBFryKzrtRIKTFXKVlYHdOhVdPRlELI3
 SPJ7r8P761QkAkLDGIFxh8VyqlBdxHgXjZNKMk3Bq30XWllZKxvOVNy9dNm3/VGBm2VV8Eb727
 QvJkx0P9oPsaTGb9LS9fzhKctKF2OkeogMtNE6RptqcgwbtsOT+03JZQAAAA=
X-Change-ID: 20260209-mtk-pinctl-mt8189-f2a0d0fd9dc4
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Iq3VJ87Sra7q36vFO08KQM+4ptDPugZFM01rpDYZN2w=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpim79rmQwKjnMooZzGdOmrFUSj3UQBpW82hCnm
 BBbrAHFHJGJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYpu/RYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AMtcH/RlpFQeDZPw3ErZfNq+SL1uhwVr5oC7B+bKZd4L
 gViIcf3ti647P2pxfXz2u7K4aQVleL64e0zb9FGB5doQb47OO3jUATL3xVzBp3LbDpdbJcrAY7X
 vVs/uaqqtM0xxj4mAuYafJQKAqEU3DVB/fDECK6NmHYy32eC/XuXj5XZfxQhGYmba2WLjlsWlKS
 Cf3VDDPqasFESW561ye5/kPBGR+riLCE56J7gdFFiBeqCAhac9iL+wkznhr9LJl9rh97W/E1L5D
 BIRvq6iELmV7JN8LsQ6m6LWp5qypDMNW9DR2zZ6eYff631+uzobsJkGkvUCIQ7T1kgANj6tWrkK
 ABIs=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Tue, 10 Feb 2026 00:43:55 +0100
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

This series adds initial pinctrl support for the MediaTek mt8189 SoC.
This one has more register maps that any existing one, so there are a
couple of preparatory patches to handle that. Then adding support is
just a matter of adding all of the pin definition tables.

Normally, I would also add the .dts changes to make use of this in the
same series. But there are a lot of dependencies in-flight for that.
So to keep the dependency chain from growing, I'll add/squash those
changes into a v2 of [1].

[1] https://lore.kernel.org/u-boot/20260209-mtk-mt8391-initial-support-v1-0-b23ab9d0b9bc@baylibre.com/

---
Bo-Chen Chen (1):
      pinctrl: mediatek: add support for mt8189

David Lechner (2):
      pinctl: mediatek: add bounds check on number of base addresses
      pinctl: mediatek: increase max number of base addresses

 drivers/pinctrl/mediatek/Kconfig              |    4 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt8189.c     | 1276 +++++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    3 +
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |    2 +-
 5 files changed, 1285 insertions(+), 1 deletion(-)
---
base-commit: b99da05e1538b8fa153322da82917af2aa27e1d6
change-id: 20260209-mtk-pinctl-mt8189-f2a0d0fd9dc4

Best regards,
-- 
David Lechner <dlechner@baylibre.com>

