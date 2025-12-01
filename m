Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F26D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 16:03:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9EE183B85;
	Mon,  1 Dec 2025 17:03:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q1AuX/A8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60FE283BAD; Mon,  1 Dec 2025 17:03:37 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEB8483B63
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:03:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c6d1ebb0c4so2745412a34.1
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 08:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764605013; x=1765209813; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nJH+TczUljXDLPCK87Io3I0tED1NbYod27VCFUIuwWE=;
 b=q1AuX/A8M1wK6zOtn6tIbWLnL/XDuRnISP67+aPXegsUoiQdN7+9Jb2TtD/g0UiQbz
 Bu2E1OVFwFhNnLIa8GoE96XH0WLzXYacx7kyIFX2w3YKslGJ8R0C8GUGuQxcHTR9cRKA
 SQGlwJGeukkVp/GFBzks52j1REjpluUE92oRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764605013; x=1765209813;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nJH+TczUljXDLPCK87Io3I0tED1NbYod27VCFUIuwWE=;
 b=Es1wyz9HgvEsYXUHjt0AXSRms7gXGFfjxv3eV/8kGIWEZQ75juA/RgF0iOI7Y3M6+v
 4Ky5iv19LlzouezMb3OL2Oo1BWo6n3a9QLqdCbxKSQAYHJu8rR3TfiLKADDhCXMZ3SBH
 hLlA5x8S1BkjGDY71/yqsQ2BXSQKgs1Oa3K5AySp8Gr9C5qN4B4Syk9cfCAJZ1NeaE0H
 vsJH8P9iT47QMbS0W53mKFHWHUvo4GpZv+QAz/DWECZmMEJ0+y+n4zFePRygrn/WA5yu
 8vr+BI/TTfqDKzfWaEBs/YWfuzBDSUWiFtLwbRZRaGS5uEaXOSvQ560tq93PXKfnuEUa
 +daA==
X-Gm-Message-State: AOJu0YxlIWFjOLPLHXe3rIXkegtU3ktRfAd0hMuTWvOXqqyBhp5RDjt0
 2M+0TjlmXXcXO/QeV4F/iITm31QLGh269E5MM5YAsxn+ww4Tw4JwGeDreZZJqVrg6idMvPr28Et
 IBDpK5BE=
X-Gm-Gg: ASbGncsZkLLlddiA0QD2dlEstWR4UOIWgRuPhtNSbysu/1TL5qv3OX1D4005arYhzry
 FWRc18IirAu0TJoRFjg9bTygbOFlWzvLBrkCqioe7trEtvUf78Z1XyVU4260RV18sRol9V/hoPK
 sK1GHULRdsqffIvL1YirfvT+QWakQKxPa4ntyX8/HFWTjS19yp7xph//NWYUWKD0HNdfOZYHTwD
 DiiCMZKJWq0ECDjGwapYKAbRHVKYBPIgYHIOElTCguAY/JFhHJOFlXsLzbVWeefEDQKFWkOzcds
 Iwdo1/atoKTCDk9G/ITxgainahXkYvm93erCkbeuYRUgIaBRC40XM6LhIpeW3NrrahY8tBv0SOf
 KrIU+HJAQ+06N4vUVD9jdMHqtFLu2PmIzPYWwxm9XjtBCdmrFEK4SqubJjkfWdbxJ9ksW6Rwj0E
 bxygbz70RgkFVDBmg1n3PBDY1yaoIItjqx1kcfhPndeNPtKbJm
X-Google-Smtp-Source: AGHT+IGf4GsJfnSYv46d9vv+HA5GYmRi8xe1DMpc7YQTcb/vLIhrqa2kvU2v9cJe1lwy04JfFmn0gw==
X-Received: by 2002:a05:6830:268b:b0:7af:353b:95ea with SMTP id
 46e09a7af769-7c798be781amr22217169a34.14.1764605013501; 
 Mon, 01 Dec 2025 08:03:33 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90f5d811asm4708061a34.1.2025.12.01.08.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 08:03:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251119143453.838989-1-trini@konsulko.com>
References: <20251119143453.838989-1-trini@konsulko.com>
Subject: Re: [PATCH for next] Docker: Update QEMU to 10.1.x
Message-Id: <176460501291.1117748.17041413844584952204.b4-ty@konsulko.com>
Date: Mon, 01 Dec 2025 10:03:32 -0600
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

On Wed, 19 Nov 2025 08:34:53 -0600, Tom Rini wrote:

> The current release of QEMU is 10.1.2 and we should be tracking at least
> that new currently, to help find and fix emulation problems. This will
> make it smaller of a change when we move to 10.1.3 which will re-enable
> sifive_unleashed_sdcard testing again.
> 
> 

Applied to u-boot/next, thanks!

[1/1] Docker: Update QEMU to 10.1.x
      commit: eee3ff60450a7f4720937c152b53bf2c51c1b3d2
-- 
Tom


