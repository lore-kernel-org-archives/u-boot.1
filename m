Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39788E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 18:31:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DAA7802B4;
	Thu, 19 Dec 2024 19:29:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gG/PVD5Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 435F380429; Thu, 19 Dec 2024 19:29:55 +0100 (CET)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFDCE803CA
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:29:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3a9cdcec53fso8171785ab.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734632991; x=1735237791; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VRSuj6pKteLtuMwXDJLfAGJ6LkQSrJAWGY27gBbBnko=;
 b=gG/PVD5Q3rh87i88XSVoVR2yYezWObPxn2rfqXvMr7rXohEvUskddsB5JF8p31rVPa
 KNCJ844lbOkR4HBwhkXZimJi54zC9kl/gWTbRp5tGc+hZzdaq5r4w4ueRfMp6aTdGjY4
 NVABJKqXcMk0dDc8q7x/ilazAtMcEiIOiAwTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632991; x=1735237791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VRSuj6pKteLtuMwXDJLfAGJ6LkQSrJAWGY27gBbBnko=;
 b=s7nTKtJMKnpqWpJANLA9lC+jhfdVArpi+PNHbWUbyQuKHLABk0ADZsVValtAAXTUmD
 n8WiHANSHBGgABT/vsy58OALlFVpa1sRmrSgtcv4vuZnxKFJlSg98NVcd3NO+G/h+htU
 EQRr0AUvrDkVMbSwRmNUsJ17AYRN/DQnfn2gdAJ6xVIHYTSNJMmyyQcYXGxgREWL6XUv
 ErIFGEneiqiNpOR/GlrTD+obep5Bj5so/RZQSK5veuOAphHINxx0FWONY8rdFx4RTDZV
 SKeZbT/qP6tJpIIFQrg6y21Ibxd4UdB8EjH1U6dmkFXlXfzudbdqwTb/x8XIGJOReIde
 051A==
X-Gm-Message-State: AOJu0Yz1ld7mnqHxIPEE8oLTLNGie+pgjK+5pIkUBPVVQZF1vVv81kCA
 JHXJWeLhiQi/+pwtBImMgJ0CeZEzF1T/OqtRoViGQSsMT0NdKjTlqNCiy+rjhDaNt8lG/I9ZxA8
 =
X-Gm-Gg: ASbGncv76Q2e4aTmICEIE/o5CDDRUCUcK7Ik4E7iRh8DvudVbOrfSKd+Gk+/DZSxKJ3
 R54Pb7QPZE1bGOa+QQGZi0W1Rv41y7m/QThovOL35wBm1L5FUOfYRYq8WQUf6oGwv2lFOdPPuH7
 PndYdJuRpXd5PPD1XP4CbiwgsvSVTCiqjLIBqlh6sUVcj8fWHP47Darncp1KAoOn45WckeinDEd
 wU3Jj9xq+GVNstwDqiyReys5RrHuS1Q97zeZNx5faZZb0AR7l0sy+5r4Q4ikJ2ZEV9sG1JK8B38
 eJwPzOc05S48EqPX5Q==
X-Google-Smtp-Source: AGHT+IHGJf8uY8ryU1pWxkNU4nk5TpWOnnWpd+IkGIUXe37elisXLiR9lPwUwuprKA/uLqDOaJ5cyw==
X-Received: by 2002:a92:cda6:0:b0:3a7:8720:9e9f with SMTP id
 e9e14a558f8ab-3c2d14d1c30mr1240945ab.2.1734632990816; 
 Thu, 19 Dec 2024 10:29:50 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68bf676c6sm393655173.50.2024.12.19.10.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:29:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 17/19] lib: Allow crc8 in TPL and VPL
Date: Thu, 19 Dec 2024 11:29:05 -0700
Message-Id: <20241219182907.2609704-18-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219182907.2609704-1-sjg@chromium.org>
References: <20241219182907.2609704-1-sjg@chromium.org>
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

Provide options to enable the CRC8 feature in TPL and VPL builds.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Fix 'depends on SPL' to depend on TPL

 lib/Kconfig | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 203f40e2662..8f1a96d98c4 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -728,6 +728,24 @@ config SPL_CRC8
 	  checksum with feedback to produce an 8-bit result. The code is small
 	  and it does not require a lookup table (unlike CRC32).
 
+config TPL_CRC8
+	bool "Support CRC8 in TPL"
+	depends on TPL
+	help
+	  Enables CRC8 support in TPL. This is not normally required. CRC8 is
+	  a simple and fast checksumming algorithm which does a bytewise
+	  checksum with feedback to produce an 8-bit result. The code is small
+	  and it does not require a lookup table (unlike CRC32).
+
+config VPL_CRC8
+	bool "Support CRC8 in VPL"
+	depends on VPL
+	help
+	  Enables CRC8 support in VPL. This is not normally required. CRC8 is
+	  a simple and fast checksumming algorithm which does a bytewise
+	  checksum with feedback to produce an 8-bit result. The code is small
+	  and it does not require a lookup table (unlike CRC32).
+
 config SPL_CRC16
 	bool "Support CRC16 in SPL"
 	depends on SPL
-- 
2.34.1

