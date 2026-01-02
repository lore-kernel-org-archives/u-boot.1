Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC887FA3755
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 19:20:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 525DB84262;
	Fri,  2 Jan 2026 20:20:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="dJsLQHx9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4603F8428C; Fri,  2 Jan 2026 20:20:27 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39CD08421C
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 20:20:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D4F953F871
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 19:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767381624;
 bh=Qz5FwatMg39ZUkUKj9bT+OhK7AKiGoTIy2A5irFXJxQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=dJsLQHx9ESUhbuwJTSjQFBDsH0Uxa9glNHeBwgHsiCPyq7/Z073SmALU/WAL2iHZ7
 XfFOda1XbcJTUNxI3G19Xk6i9nNXuJC2ifcIJjvvPy4vkUVw2S612EjaURHpuYhtPm
 Mef9qYnk1P/7NbA7t2mdezKBTmYu+took8uNeMlaNBv1k4eUt8cbZRva6XMllmL/3g
 VDbfplIsDcpH/hYKr3qlP2C/GrSEBCtuJWxRlpwdXzN3Kn8yKHMfQ0zB71sCEw7YCs
 tNnteG6W5GTn3p0tP/fpJ9UkGqEqlXlRcJsMBO4y/9bGuZILFCLgXx3ZpJ32DqvpC+
 8MUCwH6FiB08MA2EP/KaVGI84o1sKm1uxqiOJf7byoSvrpkHl1U/Sg0+gHApwnu4CA
 PUvlSgKSMBJvBk1qqc2lV1cSfaKf9z0HgbcqwWyX0PKD1s/AXSNAbhsEZeD2449cJj
 hnIQGE3pMFmeHosT4nJ+8R3DsY5ET4IftPgtekVIuA8pX+HOcsHpKzYN+BjprnIMx0
 /ujHZvDWq0MO0J8jPcROY5aT+eOThJuYaaklXVseMeq4NEL1Z0DBM6CX8FNHng6+dm
 XHHt1AF8b/pWUn1VPXiCbAABh5kKGepYetHZMagyHb++me8KHrB7tJ9HA+4dOnhPSi
 NPZzn940Ziaanq5yqcMECNwc=
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42fb1c2c403so7780717f8f.3
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 11:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767381624; x=1767986424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qz5FwatMg39ZUkUKj9bT+OhK7AKiGoTIy2A5irFXJxQ=;
 b=PJjSCmr/tUZ165yvDAEd1PzlwgHKp7KE2l4K3ERXN1ihbnMgAv9DAau4/dDcqrgJZp
 frP00o8LClbYiDgWCIbcrJDGWGNfcU3Psl9PeGyZnQ7NNwe64C+d8u2B+P4Gm4beYSok
 qK9+usa1xbaq3zvyzasNvjvImWKD6zEQt8338sXFg8YexZW0Aqpe/nW/2q/5prdEQ6Bd
 jMqoxDfejMwuvl+H73/guj8AyGnvQTX9YF33oHKposAJh43Ew5mmvULWDGs3VPZKWM5W
 qqRvln+QtVgUJZMMSAIRgjDB5G3cK66tvTlWRTtIfhm9fxryCx6Y3Zfa3FQC7ZCYW8Da
 HY+g==
X-Gm-Message-State: AOJu0YwA5cT/bcVFi8XqCcvUxyuL71fekrBa72UCeKLw3jL3Pjtz5ovD
 qEZBzqE2yb5xqoQtJO4Ia8O8xrhj6gjhRE+P6f3b80KJHx8mVmaJhSXqE2leQ2y/qRhuhhEJ1l/
 ARuVuw/xsBBzTFh3D9T/MRSrF/YXe++s8UhaSL8go1p7rgj69abxK3KoWoEzgRx0uzQCyYY89mj
 bJHBo=
X-Gm-Gg: AY/fxX5Dnnlk0kV4cMwM9EYus6pK9OyBnsLAe+/o8taQeLgA25cvFUdiKMi98C4JOLJ
 ZW56qVmy1a3BJXKzgW1oFsDk0XFBG24oZsXuyusHXiFTOkQhLPDZHg1/0qACCPl/522K3FsP9Bn
 9CCZ4lY+t6aUlORk+t74CTPoYEAfqrRMyLxuQ/HZIX6lrLVT9+y+OrUIL7kZtpydJqsYLITxN1J
 YsPxLDFf8LmVsheiPHNNaKH84iKXtzIm5Bqrfk882RSpm8dZS+VT7OJS1jxERXV53sjr7xMOZ6i
 5Q3hePQBzrAKEZfLMVxbz6yUIjR6/7aaV52XPtcjQuRtXYMdfr2mJsqaW1ijjnLbJ+a3QV/Pdbu
 SzMgEEO6/e93a3ORyYIK6NS112cPMEXXh27VRM4jhPM/Ko8/FsE5wx4bJ2fNAXDehIKlNJo2if2
 Jk
X-Received: by 2002:a05:6000:2504:b0:430:f437:5a6d with SMTP id
 ffacd0b85a97d-4324e4c9e74mr58489718f8f.22.1767381624376; 
 Fri, 02 Jan 2026 11:20:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIfcgcfUyfyzLQ2cPGkO1JOeHe70P5vfqdFJs3rw/6ripmNI3X8kBtZpVNbwV+Nkc1nQIL3w==
X-Received: by 2002:a05:6000:2504:b0:430:f437:5a6d with SMTP id
 ffacd0b85a97d-4324e4c9e74mr58489692f8f.22.1767381623982; 
 Fri, 02 Jan 2026 11:20:23 -0800 (PST)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea82fa1sm82692274f8f.23.2026.01.02.11.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 11:20:23 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] usb: fix typos in include/usbdescriptors.h
Date: Fri,  2 Jan 2026 20:19:56 +0100
Message-ID: <20260102191956.266773-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

%s/heirarchy/hierarchy/
%s/usb/USB/
%s/configuratin/configuration/

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/usbdescriptors.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/usbdescriptors.h b/include/usbdescriptors.h
index db1d6ef791b..6ad831ffefd 100644
--- a/include/usbdescriptors.h
+++ b/include/usbdescriptors.h
@@ -18,8 +18,8 @@
 /* USB Descriptors - Create a complete description of all of the
  * function driver capabilities. These map directly to the USB descriptors.
  *
- * This heirarchy is created by the functions drivers and is passed to the
- * usb-device driver when the function driver is registered.
+ * This hierarchy is created by the functions drivers and is passed to the
+ * USB-device driver when the function driver is registered.
  *
  *  device
  *	configuration
@@ -45,13 +45,13 @@
  * made available to a USB HOST during the enumeration process.
  *
  * The USB HOST will select a configuration and optionally an interface with
- * the usb set configuration and set interface commands.
+ * the USB set configuration and set interface commands.
  *
  * The selected interface (or the default interface if not specifically
  * selected) will define the list of endpoints that will be used.
  *
  * The configuration and interfaces are stored in an array that is indexed
- * by the specified configuratin or interface number minus one.
+ * by the specified configuration or interface number minus one.
  *
  * A configuration number of zero is used to specify a return to the unconfigured
  * state.
-- 
2.51.0

