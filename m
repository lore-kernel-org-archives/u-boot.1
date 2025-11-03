Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E19CCFA03
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 21:03:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5434D836D1;
	Mon,  3 Nov 2025 22:03:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="owgHQsFV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 565F7838E5; Mon,  3 Nov 2025 22:03:23 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1141B82A9E
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 22:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-44fba97bf37so865934b6e.2
 for <u-boot@lists.denx.de>; Mon, 03 Nov 2025 13:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762203800; x=1762808600; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ymyug/ob56zc2RUMxwfGMAwDuJnCW5+U3yqaxQqOAIo=;
 b=owgHQsFVz2beEk+B+gHF1NLP2PKBV/gjgxVsoylqKYDiQV6312jWxXuJoEPmLgwZNR
 FnOLy6xdP5BbUKstGF0zfFuvEhFYNLXZ6XzRPx7EgP8oTdHXYZHz3C9cIMznFaldWkNG
 77GC/36UKFMGvGNBuf42MQCosLyC1Ej/l62Kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762203800; x=1762808600;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ymyug/ob56zc2RUMxwfGMAwDuJnCW5+U3yqaxQqOAIo=;
 b=k0CFqPmBSiwgPEZiP+LlFgf7WF5DnHyIH2uPZnduyC74s6v35hO2Ip7H2QysXeVPO1
 PdQDgcjF1bxmwxrL8sg40l2JXdO2j9I5g5aLRknaNFV1z5YUxfcP6Zuj4bPiQnm3UQrx
 AsJD/neTJYRXobElHFfqrFfmD1QmTrlQ2MUR0k0oRawzZYuH5GnmUnKoqKyv7F3rFU3X
 XnhoxDuF0yoeGNndJmhTWPzCjV3hvqZFtuwQilSMeqnvsBP6sPmeW/GnUGzhDKY4zlhq
 AckxYccsDXnbniA1JIohdtR3BIxHRvIz7pPMRB0PUHYzY/lG22SR5XeuzxxoNsBk+nPQ
 cEzw==
X-Gm-Message-State: AOJu0YxroeGPRUaPhEGjrjDq96gEqrlr1JNPdoI099pjayyD5DtT0yXd
 BzazFHNTnIcpITWb9cH8ACgsy4oMUSYMq6hmL47bHVpH0/85fT8B8pmOYX41wnKJqAg=
X-Gm-Gg: ASbGncvEXdwGuaKqSOMHKpVL60JHvvcsuHTXz6syi7fOec/Ftx90GffZoAGMDbUwpYm
 w3+PMNePikdNzbLtMxWJHCe43JeKPwRE1GywRHgGeDLqP9pf3wi9AdM/d90nAifL0ZhPZoFiyaF
 azRMS22JrJR7xtMK7aQURB2D5rDOJvp85ltdbfIbpgKT2IF3iEqF2f0UxA0Y8pUT5kRofKBWeLl
 GziM3hA3ntur5NgWjDHG/ta3u8jh/GJqnXm0tAxAZuFZ780xPFYrX1cSh5GZwbh2LDQJnhBa6Ra
 ZfffFc3NowgoswjBXFTXrGS16oLmnRNSAPYAgmM8MzeGnfHDcVQfShSJ0Dv14HlIy9+Fid3mA31
 GZ1wM07xdu6LHydntht/0d536ZCZguaiw9LM7Ajq6KqfIxDCKbAy5p/jfsyVlGAGVxzT3jRCepu
 ganMiQk+FfnFQY9E856gI/7qBauBl4wP3s0Aa3TJAXwHSsSztf
X-Google-Smtp-Source: AGHT+IFaLiiKWE8aWkNsqMWebLtis69HobgpkqofZbnJp6WOlfBwyoZf98p1pkN0pZ0uBde98LV02g==
X-Received: by 2002:a05:6808:c2d3:b0:441:8f74:f1e with SMTP id
 5614622812f47-44f95ff9fecmr6526140b6e.56.1762203798964; 
 Mon, 03 Nov 2025 13:03:18 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6c246f342sm455378a34.9.2025.11.03.13.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:03:18 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com, n-francis@ti.com, 
 b-liu@ti.com, nm@ti.com, bb@ti.com
In-Reply-To: <20251024081408.1610102-1-anshuld@ti.com>
References: <20251024081408.1610102-1-anshuld@ti.com>
Subject: Re: [PATCH v3 0/4] Allow falcon boot from A-core SPL on K3 devices
Message-Id: <176220379786.3382007.205569475864956068.b4-ty@konsulko.com>
Date: Mon, 03 Nov 2025 15:03:17 -0600
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

On Fri, 24 Oct 2025 13:44:03 +0530, Anshul Dalal wrote:

> With the addition of secure falcon mode since commit 7674ac9c820f ("Merge patch
> series "Add support for secure falcon mode: disable args file""), this series now
> adds support for the same to TI's K3 devices and documents the feature taking
> AM62x EVM as an example.
> 
> With secure falcon mode from A-Core SPL, the boot flow changes as follows:
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] spl: Kconfig: allow falcon mode for TI secure devices
      commit: 16f412679005e539401308bb075d4cdf87f01cb2
[2/4] board: ti: common: Kconfig: add CMD_SPL
      commit: d99688d26e697a52ceccea8231e085a79ee63771
[3/4] arm: mach-k3: enable support for falcon mode
      commit: f5119b38ff0d13f58a9af4d9f7f48dbc3f6f6a93
[4/4] doc: develop: add docs for secure falcon mode
      commit: 20fe0f5dadb70c24163c2c5f1ecd27c569ddd13c
-- 
Tom


