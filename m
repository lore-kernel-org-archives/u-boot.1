Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4388BC44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 14:34:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A43DC84C46;
	Wed, 15 Jul 2026 16:34:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="gOYdKxIl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77AA984AAE; Wed, 15 Jul 2026 15:37:14 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64CA484ADD
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 15:37:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c15d111ca99so538642866b.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 06:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1784122632; x=1784727432; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dIeuriyr6uq5MJgU9JNWdXpfI/x6QEcmS/4WM6oslt4=;
 b=gOYdKxIlNYuUGBOqMs9xeEWKFu4hH9dBjiYl/nMA683hljsH/HVgJiwW0zfTxZMf8c
 21s/Uq7fGC/9NyO/fWC/tV7moVVgqKnY8lQUcnGkB61WeSAXx6LfiUkKDC7KNt04dLwh
 ITSN5ajOCoDxcTubvXtOsEOCN6W4oD6SIq5QRvxaAmOo5eNnlas1jmgn2qmPU8ARW8w1
 d73X+91m0mDXflBeI9YnT1auT4SGp+ipnhNpYIziGMZ2Qx7Nz0WUaYYScEQW0mycygRO
 A5c+yFhs5/6VExMsRxWsBYPNnXs6af4FdWMa5eqJ/eLZ3F84gkROP/Bwo9B7N4ZQv+QL
 jQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784122632; x=1784727432;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dIeuriyr6uq5MJgU9JNWdXpfI/x6QEcmS/4WM6oslt4=;
 b=g5Uu4C4mUqiMMyINbsXrNBr1Xs+QTsf0xpfa/qPzh/q7JQ0Rucb6P8K2XXWwBnw+4P
 qzMzNxHEWdjbrGGZ98Y1i11HB4W9WkxM6JG7RDTfLoBUmdEh9WMtuTsKUAgFFSEs8U7y
 Sd+y1mU5DwTPOa6v/KkikdUAo32rIgxwCuuPgx7sPeTgnM9OONZXTqLtKTtNkXlbspTM
 OMAVtDljwYNJ4xq6cBx/3qRiNV7dFrM1d/xQ1fISP4hHyID7+eonc+lD9i79/7sw3FsZ
 gLpSJd5sHTvwD0/GviS67jSPVsR1DXdO9BGRNgHheykqg3VRnN0Fmjc9iW5XUufASX/h
 /iEQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq6kdPPJzf6vm69+oQ7QGnWi9ECLGPa/hs5gFCcvljKE9fj9dBHKJR9e3XlnNwUQDBG0WRzeMQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0eRC3tI8z/fa3J6iXgnggzZxf6uT7IL9m4FbVDp4/pjedPrbq
 kXv2zYen+7fVVnf+HpCfH7EN3h2A64zjIzxfeR5HT+0qfwHqUGOIu6XdbyA1faQLAq/GYVgUXN+
 E7Qvs
X-Gm-Gg: AfdE7clALdYUblf3g40vQ+hDo0VM33bzw/nVsMfg0DrJlxjRNH8LPyK4Fb3uOBjpwB2
 A+xVNmvueG/tzgf2RikWw8dmBSlgxc1X3+9CdSJ1FIuC7qTQsSl/+UQmmeXKsehGdc7R5Gnzjnh
 bWFdRxcKFNjRtTk7+Y/9ZBGi0bcpgW46C+dYnPcei08TzeCRrN5AQs87CbnwDUrcUdVhMiRC8fC
 26gm+e+6yJVW/eA1z3STwTqDPY0o0y0144VXoh1wfC9fJNrh+DXfgOZ8thwBZe3t6kuVXcNZRec
 bk76a2/9+2uvtKayv5zrIfd+Y60qJYhQ4CdSGyGUaLpaN97IZXv8i68WeIe1owClwpfcWUkaesS
 ZsplDtiUjYNLsvGU5qJQWOvONLf7T8nW3w88NSv8j1V/KEPAH51j/h3QTPVqcZ+e6F94+9kZN4j
 /H7qWNaooXhOAfNDehE0t++a79vDg23BZHRIQrkZhQrBz79NuQWyFhH4A+Ok8nJhT2sgo=
X-Received: by 2002:a17:906:478f:b0:c12:979c:5a5e with SMTP id
 a640c23a62f3a-c1678ff1a33mr172581666b.0.1784122631797; 
 Wed, 15 Jul 2026 06:37:11 -0700 (PDT)
Received: from [172.16.240.102] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c16871962cesm29896166b.25.2026.07.15.06.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 06:37:11 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 15 Jul 2026 15:37:09 +0200
Subject: [PATCH 3/4] configs: Enable SYSCON dependency for PHY_QCOM_QUSB2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-qusb2-msm8953-v1-3-b6e638599e02@fairphone.com>
References: <20260715-qusb2-msm8953-v1-0-b6e638599e02@fairphone.com>
In-Reply-To: <20260715-qusb2-msm8953-v1-0-b6e638599e02@fairphone.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784122629; l=1555;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=V5hJHaSlfWEzOoYFts70WxRzM9NB7z3VPZOdXsuIKRY=;
 b=jgcMX1m+Fejw1ts53RT3uMiH1JEwKN1LaMd2GmSIByhTSKVKKimmK8dxkez03U7CaD/9scD9z
 fI8sVRIReCfDtCaP24R6Yh9truZ6zEeVpf4i/Ohrkmrwk3rurgjXnJb
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 15 Jul 2026 16:34:36 +0200
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

In order to keep PHY_QCOM_QUSB2 enabled after the recent patches, also
enable SYSCON which is a new dependency.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 configs/qcom_defconfig             | 1 +
 configs/qcom_ipq5424_mmc_defconfig | 1 +
 configs/qcom_ipq9574_mmc_defconfig | 1 +
 3 files changed, 3 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index c52f619850d..5ca3f5d01cb 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -53,6 +53,7 @@ CONFIG_OF_LIVE=y
 CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
 CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE=y
 CONFIG_ENV_DEFAULT_ENV_TEXT_FILE="board/qualcomm/default.env"
+CONFIG_SYSCON=y
 CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
 CONFIG_CLK_STUB=y
diff --git a/configs/qcom_ipq5424_mmc_defconfig b/configs/qcom_ipq5424_mmc_defconfig
index 299cd2c8a6f..4a450ef2fd7 100644
--- a/configs/qcom_ipq5424_mmc_defconfig
+++ b/configs/qcom_ipq5424_mmc_defconfig
@@ -27,6 +27,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYSCON=y
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_IPQ5424=y
 CONFIG_MSM_GPIO=y
diff --git a/configs/qcom_ipq9574_mmc_defconfig b/configs/qcom_ipq9574_mmc_defconfig
index d1da6bc82c8..08a065572f0 100644
--- a/configs/qcom_ipq9574_mmc_defconfig
+++ b/configs/qcom_ipq9574_mmc_defconfig
@@ -27,6 +27,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
 CONFIG_OF_LIVE=y
 CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYSCON=y
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_IPQ9574=y
 CONFIG_MSM_GPIO=y

-- 
2.55.0

