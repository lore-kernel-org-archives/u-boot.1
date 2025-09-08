Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DC6CAC581
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 11:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55DB8830B3;
	Mon,  8 Sep 2025 13:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Pv/Vt1uq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBF35830A0; Mon,  8 Sep 2025 13:31:46 +0200 (CEST)
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com
 [IPv6:2a00:1450:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C639B809A5
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 13:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ed1-x542.google.com with SMTP id
 4fb4d7f45d1cf-62205eb63f9so4214957a12.3
 for <u-boot@lists.denx.de>; Mon, 08 Sep 2025 04:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757331103; x=1757935903; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K1UhJEGy5ofyaJAVIIeo11LM8yUjXMG7NSsk7U0XHyo=;
 b=Pv/Vt1uqWGGhbacctZa4V8ZVdSfFWpyUEF+uHjDoxWQ05O6uIsMgiPNvzZNVixAIGn
 nQWT6WWTWiH6RAKz8JW9Z+zLfxZkgmH4bvJu8IKJFYKUiwxnFUzyy1JatOXceLJ4OAzd
 ieHi2UopEh7JPi8+tihgNqgsLDhJaedrPVUr8Vue+ZN64wWXGKdGeG/wBxDrOtYIFd8G
 6eSUA8SP/FoBaePgFYYSLRzgTCbX/9wLfDPnst8m8OzgbrvyRLdF71nDmtIQeDBFCilN
 iiEM0XzB5HHAwrYKRGC0KOKI/ahGorO8t79lh4mZopZp2j5UyYNScvatog7mFPmMp4HM
 xuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757331103; x=1757935903;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K1UhJEGy5ofyaJAVIIeo11LM8yUjXMG7NSsk7U0XHyo=;
 b=T6yh7Q1PtPtGiVC3ciJoXNVaUnPwS1pz7ehBQMjvCv5hsMkdfnMjzl4C88jGP+Na+G
 aIuWr59Yjl5/ANlQQd9IOAZu2CnKEdAyFj7HttCa3vLmUurGwcSpFVOeuAu2Z8TbNCZh
 xi2iPfQ+yPIDmZW+1ADK6lWHyN/795+TzkRiHKa0bWcHgylbbu3pX20AOc7L8SfDl5Uk
 /oibA6fWXWOjEiuEGn2v7r+LkI5KzDMRImc5odr5GE3xJ4mIihyNfxLYtJTR4EyRNw83
 u4raLF9MfzGW8V0CozUk1U8HyNMEvSVhn9+7nYC5xCZGney/N73UeYENZzXzSIwQecVc
 G2QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYbg5OZsuVpvMtC808AWxBActOP5s/Se+6jjUyaYR3nx//hhYvTr54/Did42XzlsxW8AfH2xc=@lists.denx.de
X-Gm-Message-State: AOJu0YzFYDZZWlVNBEB06TKebqOtryCFRF2Ij1CdUe3/LRziN2SC+QnC
 bHTbIMgjpBf0SgdgB+pQRyZ5mWKD0LWksyjyY7C2rfoaYIQ36RTEgYOVSq/uH657X+w=
X-Gm-Gg: ASbGncspfxrRfhDc/9XkJDlD3XXDmOyN2OyiVBa2zLM/f9eZj3aYOSQkRIrQlTwP67q
 OtyGUirWUZ9PAx/MEKhUQRIovQHTzAFd+3yT+dgEoH4QbRqtdZN8P+rwJd/eujKCDAw2Hefl3wl
 oZSAitwm4bzAliQ6wZXSAYI2AbnoaJTfasOUjcIbgOrDnSmQ+mFbT1UURpdizLms6SN5kpX2XYs
 j9FS8Ua+BRd8RySA6lXwqEhSs5K1r5xvoLSIrN5ZCRLuaINktDnNCxZC52Kz4MCYdTpI5uSZj7L
 X81CWSflNRCFc/V89XUMDzcG1xEkZf2nZEnOTPfbSio1a1ZbI6H4z+EB/j9LchxJpv5azGjvOdx
 IveDDInuw1QhG1Wltd3pCju6pDI1My/sv9w==
X-Google-Smtp-Source: AGHT+IEg++r34+9TKGDwDlkG8AGM1nt8wa0Hbrt/awntJqZ3Dj617Cr4kD2/jEbgz5CyMXmNPSAn2Q==
X-Received: by 2002:a05:6402:847:b0:615:78c6:7aed with SMTP id
 4fb4d7f45d1cf-62378c0cc57mr7181167a12.32.1757331103106; 
 Mon, 08 Sep 2025 04:31:43 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:30:60d4:28a5:7729:b0b6])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61cfc214bb7sm21251501a12.13.2025.09.08.04.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 04:31:42 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH v2 0/6] Fix UART autoboot issues on DragonBoard 410c
Date: Mon, 08 Sep 2025 13:31:20 +0200
Message-Id: <20250908-db410c-autoboot-fixes-v2-0-316ed98e0143@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIi+vmgC/3WNwQ6CMBBEf4Xs2TVtLWA9+R+GQ6ELbGJY0yLRE
 P7dimePbyZvZoVEkSnBpVgh0sKJZcpgDgV0o58GQg6ZwShTKqsdhtZq1aF/ztKKzNjzixL6UPe
 2L1198mfI7iPSXmT11mQeOc0S3/vNor/pb7Ey9s/iolFhcFXnak9WB3298+SjHCUO0Gzb9gFW3
 6c6uwAAAA==
X-Change-ID: 20250419-db410c-autoboot-fixes-ad7f4f5973a8
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
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

There have been issues with autoboot on DB410c for years, where autoboot
gets interrupted by spurious input on the UART console. I've tried fixing
this back in 2021, but it turned out this fix was not enough. Looking into
it further, there are two separate issues to fix:

 - Spurious input with UART disconnected: The RX pin is floating in this
   case, resulting in garbage or a UART break event (0x00 byte). This is
   interpreted as input in the autoboot prompt. Fix this by adding
   bias-pull-up for the RX pin. I've made this change upstream in Linux
   6.16 for all MSM8916/MSM8939 devices and it has already landed in U-Boot
   through the recent subtree update of dts/upstream.

 - Spurious input when querying console size with UART connected: It's
   unclear why this happens, but it seems to be some issue in the overly
   complex implementation of 4-character packing mode in the serial_msm
   driver. Fix this by switching the driver to use the more simple
   single-character mode, which doesn't have this issue.

With these patches, autoboot is finally working reliably on DragonBoard
410c (and hopefully will remain so for the future :-)).

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Changes in v2:
- Rebase on top of U-Boot master and fix conflicts
- Drop backported upstream DT changes (already landed through recent
  subtree merge of DT changes in Linux 6.16)
- Link to v1: https://lore.kernel.org/r/20250624-db410c-autoboot-fixes-v1-0-d96c97ae41d1@linaro.org

---
Stephan Gerhold (6):
      board: dragonboard410c: Drop now unneeded bootph-all for console
      Revert "serial: serial_msm: Delay initialization to let pins stabilize"
      serial: msm: Cleanup register naming
      serial: msm: Reset after writing to DMEN
      serial: msm: Re-enable after resetting
      serial: msm: Use single character mode

 arch/arm/dts/apq8016-sbc-u-boot.dtsi |   9 ---
 drivers/serial/serial_msm.c          | 127 ++++++++---------------------------
 2 files changed, 29 insertions(+), 107 deletions(-)
---
base-commit: 328747974a0620d0996113fe2b3906b06e96de00
change-id: 20250419-db410c-autoboot-fixes-ad7f4f5973a8

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>

