Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E54DC3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 15:01:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCF4482CF1;
	Fri,  2 May 2025 17:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MWXXh+YO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 559A8812BC; Fri,  2 May 2025 13:36:42 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 575FD80F03
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 13:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=brunosampaioleite@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-30f30200b51so18808421fa.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 04:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746185799; x=1746790599; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WBIZ7CCqxp3VsB9coHioHkD4j5/40284cAXrVIquSPs=;
 b=MWXXh+YOsYvpHh5unGh0OQTGxG6QjAchHr4bh6Ai5fdWPLnlaq9tz9I6rSfuFeDnAN
 Y8/SRtqQx5ZY6qXHjhSxuPPVK3EkT7lW0W2Kr+B0X1B2fx7NzgIPH1TkgA/Ae1gtJ//i
 7UG9TSfxiqYLqFVD50RI8JQMogNrkIAcu85F/qA9jfHrcWe88puFxme5t72t79KrbqKl
 uytcX9dtPzs5vvRiCcb9z+qvzFFVqYGt8t55yvsR128iJq6VMGldaNrD08PAxY41kZXg
 ZI6VmM4OCLMuk6Fx7BCQGO/pD6lloYt4b7Es2uDwo5fs3q0no26PIdlcnnaupi/cIJNP
 YoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746185799; x=1746790599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WBIZ7CCqxp3VsB9coHioHkD4j5/40284cAXrVIquSPs=;
 b=Pv7+hcu7bPysF3wIicggCiyIdZgmiqg/XgLNcYIJEGCiO3QUJOPdR+EK7x6KngnxPG
 vdzVo77MHOvM9atc9uokOUt56ZI4p6Txn6TRMryYUhnNlVqqdhOoULNsa7YpD26l31at
 4AEU3LXH8dz3VoqgBKadJ2+WYC4U4Y/30MUit1FF0eF0fRCEeAr271cRPuFypysHsFJ5
 4moaWu+m0J4VZ/NhNWHJVwB2mdDACLS8sz1fUlhtMtkSTZDAwx3U4f1WzTHtTtjZLdK/
 2RDUShrQmVAfft6OdmKdaQYSIzRQth/YHqcshh+4mFwNOTMKMt4ApE+MQyjvSh1/mImH
 cKLw==
X-Gm-Message-State: AOJu0Yy4n38UX8tNdX7568kQwsOgtjnMpj7jEKRQpnGY6XxFFd2oWJS2
 B1dugIEpj0UWVe4dHLZt0fTOfLc98Ii35l2GopQFM/jvgfSAGc1Bqn/FK7vnwms=
X-Gm-Gg: ASbGncsFqCKx84xh5YQM9mHPhDrD1sbG4i6WH2jBcUKI/pVhTDtyFJ0uvnfqkYHw4JU
 EAyzwEDsguwqRBBx2ZbwhYxx2K3w8xlKke2dx/Dm8jsAhL0KFXbiGCPwJrIsAFS1FIeProFl88v
 NrqQliROXTsqhxouQIpGbZErzPYNIz2Ngw/yb20LPZnwCP6d9PIlfXZWCOXwYkp2QTxYwlf6Wym
 jJ2/kM5HDjno6tpgjmJIasNlhi1S61xg14RTim4kNH+kURI7OqIglMIwCqSYgyJB6ZJ37jNPE6Y
 DmJhchT81PhKRvV8KvofFZ0zHKNsKbUdXnPuwv6J4l7MRQxYdf4gT3k4bnykrTuM//jbEPA6lg=
 =
X-Google-Smtp-Source: AGHT+IHCKnBOStthxX99K3F7VMd46pdMOKlZkhOW7X1bbIBGiwKoLcQpfRWIsjnH5O05qPgG9H0m4Q==
X-Received: by 2002:a2e:b894:0:b0:30b:cc6a:ffd9 with SMTP id
 38308e7fff4ca-320c165d0aamr7218631fa.0.1746185799279; 
 Fri, 02 May 2025 04:36:39 -0700 (PDT)
Received: from brule-Precision-3590.prevas.se ([81.216.59.226])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3202a89ef3fsm3172141fa.69.2025.05.02.04.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 04:36:38 -0700 (PDT)
From: Bruno Leite <brunosampaioleite@gmail.com>
To: u-boot@lists.denx.de
Cc: ravi@prevas.dk, probinson@gmail.com, Matthias Brugger <mbrugger@suse.com>,
 clast@prevas.dk, Bruno Leite <brule@prevas.dk>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/2] configs: rpi5: add rpi5 specific defconfig
Date: Fri,  2 May 2025 13:34:35 +0200
Message-ID: <20250502113556.134731-3-brunosampaioleite@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250502113556.134731-1-brunosampaioleite@gmail.com>
References: <20250502113556.134731-1-brunosampaioleite@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 May 2025 17:01:15 +0200
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

From: Bruno Leite <brule@prevas.dk>

rpi5 is currently built with rpi_arm64_defconfig,
but that is a generic defconfig that does not build
machine-specific things like the devicetree. Add the
rpi5 specific defconfig with it's own dts from upstream.

Signed-off-by: Bruno Leite <brule@prevas.dk>

---

 configs/rpi_5_defconfig | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 configs/rpi_5_defconfig

diff --git a/configs/rpi_5_defconfig b/configs/rpi_5_defconfig
new file mode 100644
index 00000000000..852eff1c455
--- /dev/null
+++ b/configs/rpi_5_defconfig
@@ -0,0 +1,4 @@
+#include <configs/rpi_arm64_defconfig>
+
+CONFIG_DEFAULT_DEVICE_TREE="broadcom/bcm2712-rpi-5-b"
+CONFIG_OF_UPSTREAM=y
-- 
2.45.2

