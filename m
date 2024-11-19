Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFECD4415C
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:22:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB877895AB;
	Tue, 19 Nov 2024 14:19:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZkCVji3W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDF708954F; Tue, 19 Nov 2024 14:19:53 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8DCE895A5
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:19:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3a77562332aso5141665ab.3
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022390; x=1732627190; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTgkV2hY2tB+6lbjr0E1IhnI4Ssk5CoJOFj4OYM4WRM=;
 b=ZkCVji3W72EWkHxOKBjVsUHZmcYdH50o5hNRgfHNuq07F6EiN6qqbfrVRlmuHPhDUX
 MzC3d800d73qBe9c2l1yEcCYerR+qaoo8YeuQrxZFuQGeIY/IdZN8FWeiUZlDFTYmnAl
 5mz14Kpk34JQfdjDfj+I4PBEiOje/svrQBl6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022390; x=1732627190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eTgkV2hY2tB+6lbjr0E1IhnI4Ssk5CoJOFj4OYM4WRM=;
 b=wUHVo1ey9OuK18vmfQHFxsVN1XbpSrntaVTxs322UaclrjVO6VMSNxTNrTvGnJr2KI
 1cmBbOiCaBRCIkTJTyIXZmhIXZVcNtSShdR7y13stpGbSm37zWnIiufvMQGaW09GbuOw
 QhjW/Lv8O4J/dLwf+iDKD3U37fWpyF23cVOXUctc6ZGQBS2XsrNrq0eCHRioLSGbIqKj
 AKrD+ng/wGiTxT4pnps+aIGFHFaWFWvdnR443imO6k/OE1XTVP3JNpj7Ff73wNfew1Wn
 FwvkXtICHwHrxvIxXemXJUJ2cY6eL3UtXFKXRBKqJoWaJCP7kAI6lpm9m2xoxo/ByXDD
 60Tw==
X-Gm-Message-State: AOJu0YzPxPUQTL7nehHIKKCVVCcQL9tFKGqTmJmlBlmJgG/kYDGU19Ue
 ndwalwnEmFxVpqogYeYdhqIu2CLfwJqH+QK5iaZFguhY+TYqUWmCw3LV+1c2ArVnjx3W82idNyM
 =
X-Google-Smtp-Source: AGHT+IGV9mYQoFjtBQhSd9GHS63afCVoCr1vTOUoS4RSTVq+HVMXoNJXJOvGLGWBX80ilxCBp2d9HQ==
X-Received: by 2002:a05:6e02:19ce:b0:3a7:1a65:2fbc with SMTP id
 e9e14a558f8ab-3a74808cc28mr191192005ab.23.1732022389916; 
 Tue, 19 Nov 2024 05:19:49 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:19:48 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 22/39] net: Drop #ifdef in parse_args()
Date: Tue, 19 Nov 2024 06:18:27 -0700
Message-Id: <20241119131844.4078144-23-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
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

Use IS_ENABLED() to avoid an extra build path.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/net.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/cmd/net.c b/cmd/net.c
index f1b520143df..03b33aa1f20 100644
--- a/cmd/net.c
+++ b/cmd/net.c
@@ -366,13 +366,13 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[],
 		}
 		break;
 
-#ifdef CONFIG_CMD_TFTPPUT
 	case 4:
-		if (parse_addr_size(argv, addrp, sizep))
-			return 1;
-		*fnamep = argv[3];
-		break;
-#endif
+		if (IS_ENABLED(CONFIG_CMD_TFTPPUT)) {
+			if (parse_addr_size(argv, addrp, sizep))
+				return 1;
+			*fnamep = argv[3];
+			break;
+		}
 	default:
 		return 1;
 	}
-- 
2.34.1

