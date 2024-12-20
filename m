Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624A4E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 03:59:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7DC88021A;
	Fri, 20 Dec 2024 04:59:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F/FVMBSy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D36D8021D; Fri, 20 Dec 2024 04:59:39 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 230E580087
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 04:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-844e6d1283aso90159739f.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667175; x=1735271975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kVGQ9dC3xqU02RrpfYsGBNTwBdSzJJ95FF1TESSFKcs=;
 b=F/FVMBSyujWd7+Q8fgakJ+VcZSkaoNJJaLnKXvvEUjliAinyYMxRsI5wGI/VXGBphG
 v/Q3Rc9Df5TxT7SK+IajPkjjJtJDn0f4RPU8DGO9v2WKCFBxN1e1eVhMjBagImvcdpjC
 92V+41ZXkLAEwOeHaCMfz7mh3a5kV2CYyn0m4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667175; x=1735271975;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kVGQ9dC3xqU02RrpfYsGBNTwBdSzJJ95FF1TESSFKcs=;
 b=NkTQIJzUj35e+ysQb7eRM8LcUpg7TKZl00f4xi9HYJnDhvsBWfckq8xjKbkleOsW47
 Yc1hpQG+hDuLo5MwIkUt5uZ1oFuY0vCrYGSmsmpzXUk7n5AwbUxIPTqgJV2klrP23GAU
 8FtGXT+ahtfB4QevpuCK8LbkBX4TawFLBCAE6+RqWBAzY0QZiPpg+Ek33KoZDUDD1g4m
 mgXH5A+o3dG7Pgg8eogfPbd825U8aubUyNfjA7QgL3/hd5M8f0tO4zShvvm3c58ONbrD
 mnwGX2EI9r1SPyPjSpZZvwyH8o0YxIGtwGnilhmNLYBxJAOzVZeyEhSQXkNMcjyHc9mZ
 qTOA==
X-Gm-Message-State: AOJu0Yyjg1lYthzSdDodejWmhD0wcsQ5rGYh8/bhKEBCqAuF62M+AclV
 iLQBYsosanQYpDTb8Mzf4y/5FKib8IJwT+UDaC4OvuV324qpKlwOT5WCuXX4FMMie4zyHQZTXeg
 =
X-Gm-Gg: ASbGncsEYoDRIg4fmAwCrWY7ybEcWu6TZKwiv3d1nbAdQEBXrNw88uxuGdL5bZQZUeX
 PKWMA6Xvs/3CMxkL2UVaZtPSUBCzgoeK/WVfvaxWZ48EHCB2OssJcWcpnCKMByMJfr+AHFE3TJ/
 SgWGsosm92jyoolyAn7kMtBlViISUi2FbR/SHaWLHOQn+8NUSiwJWn3oJnDo5760IExDaG2u4+a
 PQjOce49wLiVrn7CgGc+H4buvFS6CuSR8V6I9AsVStx56sO/TK77f8DfqeTprxfuja/kplnHJ+S
 JNN39SloDhIdAOfDjw==
X-Google-Smtp-Source: AGHT+IHIzWwxpCNunNcxcxLHAi5ikJaMFfGE0cmIdS233snrD8PJwMyISCCAOup/4ccDRH+OSBmVkg==
X-Received: by 2002:a05:6e02:198c:b0:3a7:a58b:557e with SMTP id
 e9e14a558f8ab-3c302627786mr11276585ab.12.1734667174865; 
 Thu, 19 Dec 2024 19:59:34 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0deae6a06sm6706935ab.18.2024.12.19.19.59.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 19:59:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] sandbox: Adjust configuration to hang on panic()
Date: Thu, 19 Dec 2024 20:59:27 -0700
Message-Id: <20241220035927.3243648-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

It is annoying to have sandbox enter a boot loop when an assertion
fails. Hang instead, since then the error message is only printed once
and Ctrl-C can be used to quit, as per normal.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/sandbox_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 3de4aa79c6d..636130a360d 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -354,6 +354,7 @@ CONFIG_WDT_FTWDT010=y
 CONFIG_FS_CBFS=y
 CONFIG_FS_CRAMFS=y
 CONFIG_ADDR_MAP=y
+CONFIG_PANIC_HANG=y
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_MBEDTLS_LIB=y
 CONFIG_ECDSA=y
-- 
2.34.1

