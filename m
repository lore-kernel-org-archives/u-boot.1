Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99D3C47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 20:17:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 039F787527;
	Thu, 25 Jan 2024 21:17:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nCVSYFeO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA1B387B71; Thu, 25 Jan 2024 21:17:19 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D378287447
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 21:17:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a298accc440so793612166b.1
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 12:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706213837; x=1706818637; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tNM6M50uwS2Ti9/gdhzSRkhC5IDV3Rbg4DELCX15dcY=;
 b=nCVSYFeOxaeoFBm9268RD0YN6U7oHOzsKmOwyot8RdjIo5B4puCfDokYC5f+He7T7V
 8ie10VBAtVo7WSTyWZQhMdJGDQTWpPOA+p5xr45nxISGRTw4/HnE+gKlY9oMFDM3tqGk
 sTC/hdTUnCUuSR1PkBUQ5nw+aEYK64RJENA6Iz7SSvNRBVnU1JW57HadyOfWxGOkqp2e
 Yq/9cFW5k1g7cOrVgbZvy5OvbG8h86foAjO05DK8tIdA53ViSOieSEsZnw3Wkotn3r9U
 gI6sYTQIkPNZH0hPY1xHvF3Xn8tqM1KyvQXVoL5N+RjlgfOVt2Mx/5TAiV3b2GbLXYJQ
 ctuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706213837; x=1706818637;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tNM6M50uwS2Ti9/gdhzSRkhC5IDV3Rbg4DELCX15dcY=;
 b=bvwa0Q9BZt2Q8npXadNer0h5/NuWHfM/7BQnNMqDzCOsZhvkollA2978vxobWOdwNf
 iHJRlzH6L78JQctpjqLq3btYXlkU6VXlSKUt38Plhjl+zh/+/qjzyeY4o39/cZpua7JH
 InRK8xVz5hyLg9ae1P9K8OKXCTrcMnIjPZLoJffDJ5/RC98+t74QRLEPAQkQV4PB+g08
 c21sGLx8Wv+oJP6DaRpLBsYf0+RwW7OnDytW0Qx0ZluN6OBx0P7IqEnXoTX05dFewLih
 y53QMCr8WjBXoWJdfcXMJsqsNS6FF4Gb4+GEUpbhx5HoZAHG7aRoCYLER5I1WiLnmFR3
 gCew==
X-Gm-Message-State: AOJu0YygHLTGxr+z60z9EqoA0ZvFXjpF/vKw338ejJQxiKhbscFVHsfO
 FWjFdovluXAeASkX1Al+T0Bez2J+oX0ohfs/GwUgbS4uJCjIGH7S
X-Google-Smtp-Source: AGHT+IHnY0ikXdAfDJ79pRTSw4VsHISlOtsmCG7CfKMOb7OteYKk18k8QX00fiQ2lcxdxiv0Ekjx6g==
X-Received: by 2002:a17:906:97c5:b0:a30:9c4d:c1e3 with SMTP id
 ef5-20020a17090697c500b00a309c4dc1e3mr170446ejb.45.1706213837056; 
 Thu, 25 Jan 2024 12:17:17 -0800 (PST)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 tz3-20020a170907c78300b00a3472ae7782sm318738ejc.100.2024.01.25.12.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 12:17:16 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/1] Fix booting kernels with ATAGS and extlinux
Date: Thu, 25 Jan 2024 22:16:53 +0200
Message-Id: <20240125201654.17685-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Currently, if boot with extlinux.conf and do not set the fdt
U-Boot will provide its own device tree. This behavior is
beneficial if the U-Boot device tree is in sync with Linux,
but it totally halts the booting of pre-dtb kernels (3.4 for
example) since it uses ATAGs. To fix this, pass `-` in the
fdt extlinux field as a signal that no tree should be used.

Tested with 3.4 legacy kernel and mainline 6.7 kernel on
P895 (lg_x3 board).

---
Changes form v1
 - Added CONFIG guards
 - Clarified documentation
---

Svyatoslav Ryhel (1):
  boot: pxe_utils: skip fdt setup in case legacy kernel is booted

 boot/pxe_utils.c       | 27 ++++++++++++++++++++++-----
 doc/develop/distro.rst |  6 ++++++
 2 files changed, 28 insertions(+), 5 deletions(-)

-- 
2.40.1

