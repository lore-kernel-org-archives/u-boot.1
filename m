Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51C0E77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 00:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B927980374;
	Fri, 20 Dec 2024 01:35:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hlmDzxno";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3593A80371; Fri, 20 Dec 2024 01:34:59 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FC7B8033E
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 01:34:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-844cd85f5ebso108293939f.3
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 16:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734654895; x=1735259695; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yEB/BDZKBFXHurodSNGD/VLHrnu/Y0ZI2I1a+OJRrc4=;
 b=hlmDzxno5Ps56qDZVFN4Jk48zdqb9ov+cAomW9iCGzAM8Nm2fxInOFGWOWk06CWGQw
 T2/Morbil6GLGLOsZOdlNwqrMETxPCuqS8qHwbzloYKY1wcw1BaRipb7NJm84dkzYobB
 pxr0r3qorkbC9h/SedXQenFCkR4SNAd6RzLp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734654895; x=1735259695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yEB/BDZKBFXHurodSNGD/VLHrnu/Y0ZI2I1a+OJRrc4=;
 b=IBnhTQAm/quAZHHe4RNDw+QiEOj+m76WAjnbq+3L+1Po++TnXNTeHdxPezbgTUNbs4
 2HpDZFl7zt48lXXgK2DI3TEoYVSeLcq0Hrf3WTVScAqSKNgcRlPDdIUfj+Wo74c87aDH
 zanL6v9vjiW529uUnUJFEyqnD9m5lMa/2GxnAkQMRrccv4R3irAhsAtnVYbo1mGFVzwI
 gAq1ZESe6OCIk/G5k8jXvStbwtf5AU/Dc7vcx4UFn6P+qP3Qr37yRzM5TP0tkg0SXRa3
 uoTEtILhif4XPddQStwLrV1RgiiPQOhM7Nk4xa33jDPtCYYPsJLQZx8XHXBzDdqdv01F
 uD/g==
X-Gm-Message-State: AOJu0YzHDuuYy1zn4yyhha3DYiLvToeziudSN1KbwpGBpY9zR3dnuqtk
 Jxko330MjQ43BMzVrYraXMTlXcf1a5tcm1deDYiTIbGW+UtXUQ1Gcqf4972mWMtUVXVa+AZdzS0
 =
X-Gm-Gg: ASbGncuSZI4cv2zK1TyRrJuvvmIncO4LfxgoMIiqeWU7sazx3coQS+WDc5mF1WEKkNi
 KbaVVkf4FHVfirCci3rN3cgjpuT6ZBVgGVaXcW/dmmQ7GzueLGNgsWEXPniACXLG3kpBGzEIfEG
 YEdKqVCEl90YZ146inpjI56XwQibHE+9tDUtF0jqqD7PH7g6jmnSMJXOydHRjqDqWbJl27Rk629
 2ChOWmhG0o+dIEo/VUcCaUT0UE59o89CaUkU+it+LqFXQIC+Ot2hPInOI9QP9X2uZ0bHcVDpryj
 tmT6LBAOa63gIVf3Pg==
X-Google-Smtp-Source: AGHT+IE2QRC4r2+Xrl1i5Qj/hxVpDTkkRqTfYUAHCu8fDckcdMm3WKWjH8xnTjxzXB+sah3XrzKtUQ==
X-Received: by 2002:a05:6602:1606:b0:844:debf:2b42 with SMTP id
 ca18e2360f4ac-8499e49b46cmr92976839f.2.1734654895251; 
 Thu, 19 Dec 2024 16:34:55 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68c20bc69sm548273173.141.2024.12.19.16.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 16:34:53 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>,
 Stephen Warren <swarren@nvidia.com>, Matthias Brugger <mbrugger@suse.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 1/5] rpi: Add myself to the list of maintainers
Date: Thu, 19 Dec 2024 17:34:43 -0700
Message-Id: <20241220003447.2913443-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220003447.2913443-1-sjg@chromium.org>
References: <20241220003447.2913443-1-sjg@chromium.org>
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

Add my own name to the list, since existing maintainers are fairly busy.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add new patch to make myself an rpi maintainer

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ba31f86feb6..8db1e605fc7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -210,6 +210,7 @@ N:	aspeed
 ARM BROADCOM BCM283X / BCM27XX
 M:	Matthias Brugger <mbrugger@suse.com>
 M:	Peter Robinson <pbrobinson@gmail.com>
+M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
 F:	arch/arm/dts/bcm283*
 F:	arch/arm/mach-bcm283x/
-- 
2.34.1

