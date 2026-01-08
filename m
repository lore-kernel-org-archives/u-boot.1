Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44B7ED1D462
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 14:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4DE5841F2;
	Thu,  8 Jan 2026 15:47:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zG85IhDl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 072008422F; Thu,  8 Jan 2026 15:47:17 +0100 (CET)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AAD0841B8
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 15:47:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-430f3ef2d37so2806799f8f.3
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 06:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767883634; x=1768488434;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V85rSUxTUkxk8IpaGAFpuDM7cR/TDb9JHiDy6gV9vnQ=;
 b=zG85IhDldw8gWvgeYLSr2NfFA7bh33yKud9hM0YpNMxdMuJ8z1nr4/BDUVbSrj6fGH
 wy7S7TymhRR9jCfoLSyGGaGnvGPxGc7fnHfEKYWM3qHDBfIafvx/OeJF1OPYT+peCgnL
 fwqnUL9Ld2pXI1FgnIs+2fw3D6ePnPj+R2dT0W5LNBUfHMpaV2QmLibu7uvWqaZuVpb3
 RaeTwHtD6Z1EQIv52SrxA445RXUgFIFmroZf3hx6CZceBy1ridqU9sNgkFLpByzbBLbw
 Q2urAzdHQ0TfgI3KivdXCncoy3zlVcGA/wDnZkd91Wu/5g7XZ8xWuezobH8ACdL/Qq/R
 3ryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767883634; x=1768488434;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V85rSUxTUkxk8IpaGAFpuDM7cR/TDb9JHiDy6gV9vnQ=;
 b=BhGzrmHm+VtguOoCcanE1j6CdLlMejt/hwKNPe3Z+aofuZPb03qyu9TwGtNwvaOYmV
 IA0okrmIiT+wefXHgBHD9I8vILvZ9FsknbpTT/mKj7RAJV2U2wWemuUGv7lCZUHUq7tY
 wHrcQKkFFinhHNTYC3Nwo0F7iweSBzIfcOVx/HXYd6Cli8AxM4JpE529RCYEf+MMUzRt
 gAzub/sR1HcKENdQaV18fhKXq7LJ09wekw7g5UQvj85uS+VabkWNwn+8aRgArQWUDmDl
 QAQqt4Cb19OA/D3xLNGdLwD/n7NA9RFRPVvBELRlMa8pRJ4ebKp7lUOZph4h8nS26AFG
 Ycew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP+Jmvx09zIbsdOtwZytm6akaEWmouiNkhkXSpOifZx6rgDbN3UvKbUDJlcCktVLvVScXnw/g=@lists.denx.de
X-Gm-Message-State: AOJu0YyzYvScRaOrrmOUZpZ73/GaF6B+4VL8k7YMMYxi/Ij36aFsZVc7
 L5SlH/iLHuHh7zWzGWmka1UQxQgW+ssy05CcUzMn20B8KEK0paxnM/NUAwxqezRf9qE=
X-Gm-Gg: AY/fxX6kqlzuIIF9vO1US/QsI8vki/VOkK1wn5HyzI097ZJwEswfXvrOUlStugt+9lY
 yckJ6GpvsnntS5j5Z7yYlSYYZSohMVl2/CvT7powDRi3gtjywQfeiF221CemPpWoaxomDZfTJZu
 TG2qTgdUqBX6Plk6FbW50BB21VVCWHb5MnZ6KhHyOjF70ytu2Fhv+AO6R2jcc/aoH+PeCLOj7ml
 hTgQq1HgHWHsxMkZag7vpE4zodv5dokBAVQMHna5JY0lDxVrhYKV40dzzn4dOp9n3/VC2Q63CmM
 g8BWxa1D0dhxFMi2d88WRpYJYDfRfi5Y4UtwdHVIcKaZZ2na/9evfT56U5P4X3nbPpCoFyTuyDy
 g2U12m9DqQWF2usaKVGp0nnIf3ZM4qM/ay6IxacJkQSSqoypMhlP5Ukr2RqREWanh6fUsM5cK8t
 AxU8U34Erua3bnf7C/pTEcCQ2eGrPupQkXME58r2N0rFF69aP4Gtms3gqJtgjOTLSqCOmw061aJ
 Hxkg1qY
X-Google-Smtp-Source: AGHT+IHlhaVnN+YaF4Jy4hLEwVjh/PZ2hOuHxyNNT2z43sk1PnNrht9h/i57te6e9rsbpdQa0yElLw==
X-Received: by 2002:a05:6000:26ce:b0:430:f5dc:d34a with SMTP id
 ffacd0b85a97d-432c37c8719mr7749351f8f.29.1767883633871; 
 Thu, 08 Jan 2026 06:47:13 -0800 (PST)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-b535-6f9c-731f-0b89.rev.sfr.net.
 [2a02:842a:d52e:6101:b535:6f9c:731f:b89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee5eesm16872463f8f.34.2026.01.08.06.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 06:47:13 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 0/2] pinctrl: mediatek: fix compilation issue
Date: Thu, 08 Jan 2026 15:47:14 +0100
Message-Id: <20260108-pinctrl-mediatek-fix-compilation-issue-v2-0-3d0499d3b6db@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHLDX2kC/42NzQ6CMBCEX4X07JpuATWefA/DoZRFNvKXthIJ6
 bu7knj3+E1m5ttUIM8U1DXblKeFA0+jgDlkynV2fBBwI6yMNiUa1DDz6KLvYaCGbaQntPwGNw0
 z9zbKGDiEF4EpCt3qk6Y8t0rOZk9S3EX3SrjjECe/7t4Fv+lPgf8qFgQEd7alscWFygZvtV17r
 j0dpayqlNIH4ABL598AAAA=
X-Change-ID: 20251210-pinctrl-mediatek-fix-compilation-issue-2440f060e33a
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>, 
 Sam Shih <sam.shih@mediatek.com>, dlechner@baylibre.com, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2
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

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- Rebased on master
- Added a new commit to fix logic in kconfig, as requested by Tom
- Link to v1: https://lore.kernel.org/r/20251211-pinctrl-mediatek-fix-compilation-issue-v1-1-c7a52a48e5d1@baylibre.com

---
Julien Stephan (2):
      pinctrl: mediatek: kconfig: fix logic
      pinctrl: mediatek: fix compilation issue

 drivers/pinctrl/mediatek/Kconfig | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)
---
base-commit: 41687cc74b0922c8f169de1de7f679906f2ca52d
change-id: 20251210-pinctrl-mediatek-fix-compilation-issue-2440f060e33a

Best regards,
-- 
Julien Stephan <jstephan@baylibre.com>

