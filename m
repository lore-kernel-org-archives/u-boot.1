Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40045C0218B
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 22:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C331B80ADB;
	Fri, 24 Jan 2025 23:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L4l3WdCk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D659280DF7; Fri, 24 Jan 2025 23:28:46 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF3CC80A52
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 23:28:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-467b955e288so27788481cf.1
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 14:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737757723; x=1738362523; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7en7+ZzFgVQ5KVq2Yv1LWPTdlZQJIOlJZlCcvD/wuUQ=;
 b=L4l3WdCk3C4rbpM/UI1ryNhqxnoK9S23G34+vfEqggYxT5J1v2u/JWiv5gawhEfW5d
 NszNj16CwPGOvDhbr22wJ4f1rDO56ANDLM2ZIqbwMUPEJ/2F4hdmpPinPfOFGBM4gOCd
 ot1KhG7HdKqp5She6pm0T+L1TI+b8dTxxABqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737757723; x=1738362523;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7en7+ZzFgVQ5KVq2Yv1LWPTdlZQJIOlJZlCcvD/wuUQ=;
 b=ix+iXetwC0hrxKzOXsaByaPanjs31ETZ7zECwJIltJtyYhhC1wIDV7v/ZBE4xALOdh
 EJHaSELCCIe3snE9FBMymeYB32ddJSCuUPH5o1k2OVXQwjUA0h9jNusPLyp/u0C4L7f9
 zRGAA6QbqsswNS3TpBl1/mpMonHFh/Nm/DCy814V8VVUXW5mc3AsAZjOb5cC19TLRyVB
 K2BcFB/hGiXBKgoVvWKBdJ269kmxrtcOiWeZpdXJhrEdAzIuLCQyZ1T9+iXbigyu7xay
 xG2T7RdrDSTsQnX3jPtmI+7F15TSynT6RvWOBS+tY0WFhAuXqrMsNiO2+wSDZgSb/MLy
 eC7w==
X-Gm-Message-State: AOJu0Yywf4c9FtKTEihH+e5tM8AO49PM2EmgvjLHM+bWNeNXJQO13/rh
 qKuTqHPUa3dq0rvs9fV/LNtldZDcoCrVNevthe8FlXTS7GFdyyqHdEnE3KUNIFg=
X-Gm-Gg: ASbGnctpDVT65ic/BbasEjBWryO1pYWjGWhY/jWx0dLfrRZIUMiO3wVHBUkWLGwCOzM
 QpCMXQowhSATBAv5wL9QVoBnD8IO/oniFBRp0/Gxex1w2O1yOZrZ3hBiuIOV5z7wGA+m1fNei5u
 BBPhJ0Q/6WpkbiQ2eaMdNiIfTkQHe9oNQ9t/gqxt6VU+/gV4ifD35rJd8jaSxw5dGZdF1g7xj8s
 f061AQOZQh18KnlwZVXtnXCDnAn3dMv+5Gj+AEUda4X7F5Dvqb3lGxpkUq4jDQyIp9/2bK3D6WM
 eAI=
X-Google-Smtp-Source: AGHT+IE9Q/xwaqbBTMNp+K7hmj+917Lr2uuDUwK8dBM2+4h7S9kuaAhnLbee8Fi46ItLHHuq/aZuVQ==
X-Received: by 2002:ac8:7f4b:0:b0:466:b382:a789 with SMTP id
 d75a77b69052e-46e12a2d0a2mr499958521cf.4.1737757723609; 
 Fri, 24 Jan 2025 14:28:43 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2052498d6sm12787946d6.47.2025.01.24.14.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 14:28:42 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, praneeth@ti.com, vigneshr@ti.com, u-kumar1@ti.com, 
 d-gole@ti.com, Aashvij Shenai <a-shenai@ti.com>
Cc: m-chawdhry@ti.com, kamlesh@ti.com
In-Reply-To: <20250120085042.2767733-1-a-shenai@ti.com>
References: <20250120085042.2767733-1-a-shenai@ti.com>
Subject: Re: [PATCH] arm64: configs: Remove obsolete TI config
Message-Id: <173775772140.3136238.10316540743046955867.b4-ty@konsulko.com>
Date: Fri, 24 Jan 2025 16:28:41 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Mon, 20 Jan 2025 14:20:42 +0530, Aashvij Shenai wrote:

> This config is causing conflicts with how fdtfile variable is
> initialized.
> For K3 devices, CONFIG_DEFAULT_DEVICE_TREE= "ti/k3-<board>.dtb".
> With CONFIG_TI_FDT_FOLDER_PATH also prefixing "ti", fdtfile is then
> "ti/ti/k3-<board>.dtb". This variable is updated when fitImage is
> booted and fails to boot due to the parsing error "ti/ti/".
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


