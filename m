Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B286FC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 19:06:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82F22875D6;
	Tue,  7 Nov 2023 20:06:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UXC8THMF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AD1D875C3; Tue,  7 Nov 2023 20:06:06 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DE9C870BC
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 20:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1f03db0a410so3671902fac.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 11:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699383962; x=1699988762; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I5/zjzGLYFryIfJys5Dg50RCnuBt/CVZtgGdTyIj5w0=;
 b=UXC8THMFamXWJrDEPbQYF3mmfF+M3PyQswi39WSpDLXHdSbnmw9sDmgKFRVQBpBLsz
 6Nz45FAiRSnXfgdK30m0jMWOghnXpgcul8yQJ9NRsjPNLPQGZyPXmudBOhmUJrqhr5Ao
 wFVVV9oiTYPTQGBqwUwvVMWXnyxV3Wq5+nHq2JDVzqsuZ0ZUohhQNIv4/NjzUI2v7Jb9
 2Mb/I90XSP6LGyNlk62QXmEdlv7k305LLlsosXFEVF1Mt/I6ydaiMzYqaExtuCFhn8CA
 vKAJU1rbXyA2PxKqski7YRFtX11N4oy4vxiDX/j9NGKV4EAXl+kRGoHOWG58JX67BtRK
 oGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699383962; x=1699988762;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I5/zjzGLYFryIfJys5Dg50RCnuBt/CVZtgGdTyIj5w0=;
 b=aKy1LRzxhdQEZ6f4juNKLLnmfeG62Ddjw6g6qcXopJbcZ8QOFmhfVwuJmTS7lu5u0s
 WMlJhNnfIC09vyVuM9yi4h/G3lpGA6WKcarAe8jnwoXMWBZAeX6sT3ckcfgqSRu1DXeh
 NUCtE6TN6jXSWJwzRnNGjt9opET3uVt1FmkHQZ6bxFba9phCw5Y+dbn3ocJi5+RPY9xg
 hARIAN4+uGJUzmB810lSceExyQxe32V1TqHN86CMv3fgtDxCNFsaQbHc/BIbvmey5y/Y
 eIY/s2uj1+/Oxc9bCjSSjB84cHAaBg8P1pBV86ppNB3b2J3hIJb9udsRvh9L3iFedidU
 tD7w==
X-Gm-Message-State: AOJu0YztBdbgl7VCV+axXNw9HYdbSyeB3mzO+WD9ngZslOomHO5B0BWu
 CJ/n29fvPLURCdKj/Qv5VHQ3sg==
X-Google-Smtp-Source: AGHT+IFjrbffZuVGfUTFkCXsTkJCI0x18qy5FDg4NHVlGPxq1OFLaQitFGsxP7yU2y82djQcaBL+EA==
X-Received: by 2002:a05:6871:4d6:b0:1ef:b7be:e147 with SMTP id
 n22-20020a05687104d600b001efb7bee147mr3835665oai.11.1699383961989; 
 Tue, 07 Nov 2023 11:06:01 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 c4-20020a056870b28400b001efcb7b4717sm1838663oao.53.2023.11.07.11.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 11:06:01 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: Mark Kettenis <kettenis@openbsd.org>,
	u-boot@lists.denx.de
Subject: [PATCH 0/4] serial: s5p: Cleanups
Date: Tue,  7 Nov 2023 13:05:57 -0600
Message-Id: <20231107190601.17151-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
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

A small collection of cleanup patches for serial_s5p.c driver. Should
induce no functional changes.

Sam Protsenko (4):
  serial: s5p: Remove common.h inclusion
  serial: s5p: Use livetree API to get "id" property
  serial: s5p: Use named constants for register values
  serial: s5p: Improve coding style

 drivers/serial/serial_s5p.c | 71 +++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 31 deletions(-)

-- 
2.39.2

