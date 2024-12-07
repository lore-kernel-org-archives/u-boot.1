Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7963AE7717B
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 17:28:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DA5F89529;
	Sat,  7 Dec 2024 18:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nFUjuhgX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D4C4895BE; Sat,  7 Dec 2024 18:26:52 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7772388DC6
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 18:26:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-841acc8151aso208052039f.1
 for <u-boot@lists.denx.de>; Sat, 07 Dec 2024 09:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733592409; x=1734197209; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=la9uV9JGlCvmJGwV0r1ALmFWw5dhDLNTawJTdRGVpgU=;
 b=nFUjuhgXkJzAb0uyE/mLJIZ6jyugGvDmU3Odt9JMtuBEBb1WGLEZRAtcdhGIliHtWt
 L5WhHSlPaULPKCBA3parluuxqb0KRdc+/Mh5sYSMoWHz5w5ACyQLeC5vq7iNhTIy5ce6
 aVrgMNqqmN/unbLbrtBC8iEPzNVYvqG5Qj7Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733592409; x=1734197209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=la9uV9JGlCvmJGwV0r1ALmFWw5dhDLNTawJTdRGVpgU=;
 b=Wgdabyz8MpVxvid8Y1hYZn7a/cJTX7ZMTBwdUp1VYIBdsimph24n1o8Tl+ceTB6WnL
 yC/GEkBEU0qTCaL19WQSqbm+aGngC1NAGoSdimGE94b8HU6hTi86iFtPB/GR0r/6myRq
 g34wOaSnj6JLwa9QAORuAjAqW+48Xgk7tY+At7p7iEG0QmwsxvwfzKb/lijl4ZVHNSMU
 mNOKNAuFAaTuudm86bWc5hrVRAVG1GprdOntTxcWscsr5NCebi0r6M8g1+p52Fqaya/A
 GPZXf5Qz1N5MsAk4QzJPR7Db69RRDsLeqeZ3LkpKr2qLrdY5+FTszes4INOV/JcgMsRj
 /LOg==
X-Gm-Message-State: AOJu0YzrdaHomcCsVivHcMFbh/SaKvqxilaQjZmVTl4olpk0o1E0j8cl
 NQ3EFQSbscHAY7xmst4HhWKBBy2FDVGczxqZq5f/vaVO8JFtkC6g3vPqGI9IaxhiKno2+UBGeUs
 =
X-Gm-Gg: ASbGnct1W+uwL+OFZPjZXa3cs0jB5B0Rd4zkvoMt9QWSv6CWLuMWMlGoUy9w6tpQHZA
 UH4hipyv57TSy7AoajLgBLeoyrGM9ESjKpIpXXtJUtTXmPizxxJ7MDsR63SRDGJKXNSlzee80g6
 +QZ2v/E8JTVpugzIDMnLoR+9ko2tBoNoVs2zzf8zovRkaACOBO9aLtQMNo625mDOReK+u2g6z41
 zgTdmbJvvMOEHvt11wjZzNGP5bV3KsRzb0ND4hImhb413/rbDVK/oRdsAnpJ7ednDseG6RWPoct
 6XZyJkA6Zc8=
X-Google-Smtp-Source: AGHT+IEdHliOlKFtEZlH31U7rsbKrYaczdujlJRQtWYLfHn9lIQWtX5DpKw/y4q/5gVzMx6Vq5QIBw==
X-Received: by 2002:a05:6602:48b:b0:83a:a82b:f856 with SMTP id
 ca18e2360f4ac-8447e1fbc29mr932512839f.3.1733592408728; 
 Sat, 07 Dec 2024 09:26:48 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84473a7080csm171745739f.45.2024.12.07.09.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Dec 2024 09:26:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 18/19] boot: Imply CRC8 with VBE
Date: Sat,  7 Dec 2024 10:24:11 -0700
Message-Id: <20241207172412.1124558-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241207172412.1124558-1-sjg@chromium.org>
References: <20241207172412.1124558-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

VBE uses a crc8 checksum to verify that the nvdata is valid, so make
sure it is available if VBE is enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Depend on TPL/VPL as well

 boot/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index e8f87e48ee6..73106f7a617 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -733,6 +733,8 @@ config SPL_BOOTMETH_VBE_REQUEST
 config BOOTMETH_VBE_SIMPLE
 	bool "Bootdev support for VBE 'simple' method"
 	default y
+	imply SPL_CRC8 if SPL
+	imply VPL_CRC8 if VPL
 	help
 	  Enables support for VBE 'simple' boot. This allows updating a single
 	  firmware image in boot media such as MMC. It does not support any sort
-- 
2.34.1

