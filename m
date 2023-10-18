Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40219CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 07:46:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5A9D86F38;
	Wed, 18 Oct 2023 09:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zlJPYTnn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E1DE85DE0; Wed, 18 Oct 2023 09:46:33 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B97E863F3
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 09:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40572aeb6d0so61212475e9.1
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 00:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697615191; x=1698219991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E2iaCkNz5PyTYLLeWze69XDFEBNEFZ6jMXPxx/Wiyh8=;
 b=zlJPYTnnkhhTUPXC9cbfcYNy6xhGUXdN16gHLi69SWLRKL08c9XSpJCro2Kz26zuYd
 NYOLdTxSzPHzhiU3Rn0zyOpj5HlelY6NGbEP3vxBlL2d7aFy05kjMdZF6tRMyXQ7Msad
 xixW94sRKSGyGxZfezwDTYs2e3+uPeAlHyxkfaEUXQWFcka6RYNQkMaKh5ZexPcZbBwW
 7QkwKk2O7iWGzlE4zHE8/+3kECtzYpJI8YSnJw5kHq6ldX+WbQLmkbxlkS4Lqu9nm5TG
 u7Ik1S3AduA5RPg8yyyR+GFENbzmej8qIxCcIKvD/KSgx5R6cZr3Q4Ba8nw1aIrs278B
 Pn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697615191; x=1698219991;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E2iaCkNz5PyTYLLeWze69XDFEBNEFZ6jMXPxx/Wiyh8=;
 b=Pj19pYTMfnFyKPmBRYXL1IrTt9K2CLF/XccCNMMkEWnhzQaT3svvHOQZzlaerLptb3
 eZ4f/CL3D12fiPz85xIDnpKWi2DdI5Qkl2fndhoOPpuIfvF5/BK14GBCS+LvQpISOCbR
 qFsbuwuUtxvszrnY/XVc671XZd1ZZ+O3Sjbawooiczm30F8dYoEE9aGi8zw9DrqIgVND
 ScjvdoxAxmSa1jDnwuX8KazF6yH5FZ2G0sWWhQxElK8/vhtqt34MFdlwUSFR6W3gAROx
 +g+JyX4ElLKRqzUS7srwn+LS9rfOk5VxTLNgTpu9i+muKKEn0QGHxiJNj17k3QbQbKsL
 YoPQ==
X-Gm-Message-State: AOJu0YxgAxG7h3EiKo0kQvGGfE6p0Us8l2fkKfSyhb5Xc/cFbmag8gzZ
 Q4ZslyA82h4CN9T5SiG05zO96A==
X-Google-Smtp-Source: AGHT+IFu/3ySnVnBP8TWrRm1sgT9tTbJk7Lga39yOQfAQGkW2Y5NsfKHxYWSXt94bW36iTbxv6PfxA==
X-Received: by 2002:a05:600c:1383:b0:407:859c:a1b2 with SMTP id
 u3-20020a05600c138300b00407859ca1b2mr3328613wmf.14.1697615190796; 
 Wed, 18 Oct 2023 00:46:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a05600c218700b00407efbc4361sm941509wme.9.2023.10.18.00.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 00:46:30 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, u-boot-amlogic@groups.io, 
 u-boot@lists.denx.de
In-Reply-To: <20231017213211.121550-1-ivprusov@salutedevices.com>
References: <20231017213211.121550-1-ivprusov@salutedevices.com>
Subject: Re: [PATCH v1 0/2] arm: dts: meson-a1 Sync DT with Linux
Message-Id: <169761519014.2954297.493814791807948421.b4-ty@linaro.org>
Date: Wed, 18 Oct 2023 09:46:30 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
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

Hi,

On Wed, 18 Oct 2023 00:32:09 +0300, Igor Prusov wrote:
> This series syncs Device Tree for Amlogic A1 with Linux. Currently
> DTS in Linix has different compatible string for serial devices, which
> is not recognized by serial_meson driver, so new compatible is added to
> driver as well. Additional driver changes are not required because new
> compatible only differentiates between ttyAML and ttyS names for serial
> console devices.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/2] serial: amlogic: Add UART compatible for A1 board
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/43a0b2cb9be2320615aa1cfc5318857ebce3b488
[2/2] arm: meson-a1: dts: Sync DT with Linux
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/14a21f1a80afc58d52dc72e35f27d3a47d36c082

-- 
Neil

