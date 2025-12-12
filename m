Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7387AD49201
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 11:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDAB583849;
	Fri, 12 Dec 2025 12:32:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MXDbax/c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C66B683849; Fri, 12 Dec 2025 12:32:28 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ACBF83045
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 12:32:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47789cd2083so6498185e9.2
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 03:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765539146; x=1766143946; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nicb789zaUV3jJ21/3qeJg2lljGMKekj5joU92AQ2wc=;
 b=MXDbax/cmacAE3h0m/kuS6R2XNNj1s6rXzXXoZUWDUaxNhtBgaLfZfglB2qaGhHYhv
 hvHQyae2/PZQCKeA9+bTjJZkXaeF6/ZdRTxWPHIRTY0jaMbX6jsvpByA+FNVoFqhg6rV
 XB39AK0VsgiNwIV4Fyrqh7VEGmEQOKRY8lqUwDQ7jkuX2vemI0LwDelwy1geYrN0JKR6
 ZPtIXVkyiBCtH5Ax0lxgrWio9RkWcDMRNQbUZzXNa4aUYQTn9tzPcjx4tN24ExdaWBj/
 VHwbQhBk1DHj1u2Eiv+sA8bhVIN7yN+u3WeY34u8q9ZlXneEaQSts15nEWEGWBIf84I/
 H7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765539146; x=1766143946;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nicb789zaUV3jJ21/3qeJg2lljGMKekj5joU92AQ2wc=;
 b=g9sgTYnU827MILZWaZUBR473oF3z9obX2jW76JaQbSkNcaczuRABCcWH6qB4ejwZPG
 52NYJe+5o3g+P+hF17/GpItTHZBT+bho+uHWQp9C9+x+/j6Lcj5ueSrgUxGPKGIMtOuD
 OPMIembHsdA8lcH97POEk383On4zO6WOMO60BlqFGVMWPH4S0dGOUNtW4CWY7Aw1z7JH
 +fHj5l1YMomynxvQc3IM4ciV2cgEjU43KGTZQP8Kov8ljoj5i4uTWjOryt4dPkWCJ5iC
 3qtU4ntoRnV+F3o9Sko8x9oi/BuChtflIYwQVrMtdKd3kAunP9RoEll/KgUXzwgaVh7b
 i5SA==
X-Gm-Message-State: AOJu0YwASpRRvMCfJYkr4X0rZ182UjilDJJpjtDmNg2Gd6GsxgRPnjBf
 +5CAIkBAgsBTWwx2lPCfz+abLDDl6l1K2zZeA2rdHz7QnjupK0IuCSOtvs6SMgp83fs=
X-Gm-Gg: AY/fxX5lI4Bfu/W6UMscMq87k788torVTKHRUDM3A7FeB6tfFMr7oYs1/y3InDCbAH4
 BKxiUbKbQhVBD1FQVvn9dGh7Zex0jdQlr/UPtnGsjMyGpZbLHanTwrNdpvwjRCPxugOrT442fc/
 jiITqo9f5Q2+cBxYjsGgp9DovmfForaXgAf9WeDchj/5kPefCQpPn1RlBD53nYnDrUm+QZS1v2q
 DSP6E50voVUFcFfQtX/98Di1NV3uX6CSobx3rym1+zZ0kMFnB9dbi4iIixCsHpsgex5ImQkNpoY
 pYGqi6MPDMiYHS+jtRNjBBUGLmuHA4I4DiZ7e2kyMp3Z3r9W28v8Scl94NJS97z+dGd4i3PjF7F
 /17UnijrPLG1gEs1jNINR5qR67Dpw1nawL8Wmr5BFBd/T9nxsOnhcV6v5XLREquOpVDN9KOzf7D
 ZB1FewJIZPwShXHSsvZ2K2KC5VF8y9m8wf5ZjdxUQ=
X-Google-Smtp-Source: AGHT+IHmzigxc27gLxkAmgTjNeKbRdqeRyTW3Bx7kYuNqLmrbDZW0QqczgRqesrt0DmPPFed2OtWWg==
X-Received: by 2002:a05:600c:310a:b0:477:aed0:f403 with SMTP id
 5b1f17b1804b1-47a8f8a7661mr16503275e9.8.1765539145596; 
 Fri, 12 Dec 2025 03:32:25 -0800 (PST)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:fed:3801:9287:1e8a:f239:8d00])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f8f39c6sm26277235e9.14.2025.12.12.03.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 03:32:24 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH v2 0/6] net: Port NFS to lwIP
Date: Fri, 12 Dec 2025 11:32:23 +0000
Message-Id: <20251212-lwip_nfs-v2-0-9cb5a60520d8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEf9O2kC/0XMQQrCMBCF4auUWRvJpASrK+9RitRk0g6UpCQSl
 ZK7G+vC5f94fBskikwJLs0GkTInDr6GOjRg5tFPJNjWBiWVRqnOYnnyevMuCd12mpwZT3g3UO9
 rJMevneqH2jOnR4jvXc74XX+Ikt0fySikQKdti4TaSnld2I8xHEOcYCilfABSCLamoQAAAA==
X-Change-ID: 20251029-lwip_nfs-5385efca71bc
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Benjamin Hahn <B.Hahn@phytec.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Adriano Cordova <adrianox@gmail.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Andre Przywara <andre.przywara@arm.com>, Tim Harvey <tharvey@gateworks.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
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

This series ports the existing NFS code so that it can be used with both
the legacy network code and also with lwIP.
Firstly some legacy network code, mostly variables, is moved into common
files so that it is accessible to lwIP.
Secondly the NFS code is refactored so that the parts that are not
specific to the network code can be shared with both network
implementations.
Finally the lwIP specific parts needed to interface the NFS shared code
to that network stack are added and enabled.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
Changes in v2:
- Corrected capitalisation of lwIP
- Stopped moving some variables into common code that are not used by
  lwIP
- NULL check a pbuf after allocation and before use
- Add patch to enable CMD_NFS on qemu_arm64_lwip_defconfig
- Link to v1: https://lore.kernel.org/r/20251208-lwip_nfs-v1-0-1f5d31e15d00@linaro.org

---
Andrew Goodbody (6):
      net: move net_state to net-common
      net: Move some variables to net-common files
      net: nfs: Add licence header
      net: nfs: Move most NFS code to common files
      net: lwip: nfs: Port the NFS code to work with lwIP
      configs: qemu_arm64_lwip_defconfig: enable CMD_NFS

 cmd/Kconfig                       |  28 +-
 cmd/lwip/Makefile                 |   1 +
 cmd/lwip/nfs.c                    |  11 +
 configs/qemu_arm64_lwip_defconfig |   1 +
 include/net-common.h              |  29 +-
 include/net-legacy.h              |  22 -
 include/net-lwip.h                |   1 +
 net/Makefile                      |   1 +
 net/lwip/Makefile                 |   1 +
 net/lwip/net-lwip.c               |   5 -
 net/lwip/nfs.c                    | 286 +++++++++++++
 net/net-common.c                  |  12 +
 net/net.c                         |  12 -
 net/nfs-common.c                  | 863 ++++++++++++++++++++++++++++++++++++++
 net/nfs-common.h                  | 123 ++++++
 net/nfs.c                         | 849 +------------------------------------
 net/nfs.h                         |  59 ---
 17 files changed, 1355 insertions(+), 949 deletions(-)
---
base-commit: 59f9fcc1f514762674ac07c13c2a85f7aace7250
change-id: 20251029-lwip_nfs-5385efca71bc

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

