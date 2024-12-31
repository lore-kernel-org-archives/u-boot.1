Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 415ACE7718B
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 23:56:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD0C380379;
	Wed,  1 Jan 2025 00:55:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UT6B8v0g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 401308037B; Wed,  1 Jan 2025 00:55:58 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1486A8021A
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 00:55:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6dcc42b5e30so26502876d6.1
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 15:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735689355; x=1736294155; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NLVkM3C2dce0TXsMK59rwBcrDcdpvAJWbd9Z/1TSiYA=;
 b=UT6B8v0gjHMzRdPAevrXGBbZu0/5l1w9DaduIo4cX7JuJffbkNO7/iH5iiGzi7tOqj
 KZW57mRWiH8HWjncEV5P1zUFwLAQmLP3wGcgqHuCrDnm1m1IKqS9k+R4JgMp95xZPllf
 TrpX7DD0QeheeeJGpQ9Cb6zxAzcKfKRHEqma0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735689355; x=1736294155;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NLVkM3C2dce0TXsMK59rwBcrDcdpvAJWbd9Z/1TSiYA=;
 b=wnLkY5AgRJGRtulXjJlL8wCx2vly+CWW1CMfE1fQuxonX+PLgdrN2851FcFEn/dsLH
 l5KwR8z8k9xq8FoYfkz1tfEMyQQV9N7PVBchdNOqbkw19JaZchS88v4yCt9TU1gLHUY7
 5g3avKwmr8UOdE44AHCRuwiXk8F1UupFddp8XLVDboNCYJz1u5avHyRpJrOTWcF9lsM6
 UkHIb17pkunMzBXARCSLT1O4Lw4f6eKI6XEMlnJ4v0bw1O34LRY8MwXKU4K93NbOe0tm
 FxzM93ObUh+qXToYEVbLPnIImVsjXvdjJtiofOrdW3mCOEzuhu7ljWVvhFVpfu/X350W
 KFNQ==
X-Gm-Message-State: AOJu0YyfOV7hvHUtNVv7e/E1IyDc+zOunsjBbUUT/JGkonTmauk1ixNc
 dV8+4Mptyodr/zKw8TaYOwwFz5CDLx6ld07NgGspdDLsb3VpUY35rsp+G7YrUAk=
X-Gm-Gg: ASbGnctGaMhj4lrfV9venmTZ/xecsNQyD0JLAZ/ImFeTQPYQSaN9sPPhxITF5nOK+Di
 9AM55goiZBgcr3+UhLvMB7+7pX83t+RZ2fKdqiVmw/FelbceQntw9eQurXIPNQTH/YdZAG/beTN
 MBI80UD2HeF5FDwGH+izQ4fyCeKzoZc5sefkxK0Qef8Yyng/VGBD1INYXPBuD/5GHvtbb6fV7hm
 5//OIAK+DcNPgCKPZVgCjKc0yF1TkH2/euYYVMvjKKliHGqzPZxGcp/
X-Google-Smtp-Source: AGHT+IEujRLOjVEbvhk+usOSvL3TrTHOJN9gZsa1amnywQDq5f7xiGrOMAP/5Qse7a3TQeq5+VBM6g==
X-Received: by 2002:a05:620a:31a4:b0:7b6:ee6d:fc09 with SMTP id
 af79cd13be357-7b9ba8363ebmr7606257285a.43.1735689355075; 
 Tue, 31 Dec 2024 15:55:55 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac30e8a0sm1049095285a.63.2024.12.31.15.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Dec 2024 15:55:54 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, alpernebiyasak@gmail.com, 
 Prasanth Babu Mantena <p-mantena@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, u-kumar1@ti.com, 
 n-francis@ti.com, vaishnav.a@ti.com, s-k6@ti.com
In-Reply-To: <20241218130045.2070314-1-p-mantena@ti.com>
References: <20241218130045.2070314-1-p-mantena@ti.com>
Subject: Re: [PATCH v2] dma: ti: k3-udma: Fix BCDMA probe by adding check
 for MMR_RFLOW
Message-Id: <173568935258.1606193.15786533554153656254.b4-ty@konsulko.com>
Date: Tue, 31 Dec 2024 17:55:52 -0600
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

On Wed, 18 Dec 2024 18:30:45 +0530, Prasanth Babu Mantena wrote:

> RFLOW config related MMR does not exist incase of BCDMA.
> Add check to bypass the RFLOW MMR extraction.
> Without this, the probe sequence fails checking for
> the MMR_RFLOW region, which is valid only for packet based
> DMA and obselete for BCDMA.
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


