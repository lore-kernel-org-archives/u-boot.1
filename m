Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F3BEEC2A8
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 22:48:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02E2383C6E;
	Mon, 23 Feb 2026 23:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KfBUFS/u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CFA683D3D; Mon, 23 Feb 2026 23:48:27 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 462CF83C39
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 23:48:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-46413b2c3d8so1457617b6e.2
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 14:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771886904; x=1772491704; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=umqc/hGmbDtX3AgkVuMBoHmVtCIMciJcM6uWnrHjTrA=;
 b=KfBUFS/uSL+tV9MffwAs6pPjieGJ9SD10c5l3LpuFH9Co1w++L07U9ap2L9HdACW/a
 MgQOpVFh+/H5AdVH6VmXaBEQ5uFUFZZn9PCOwg5QB3rOCbcnZ46G3OdH743v8ujcEdKU
 5u3mtFX5rL0MHlGNOn/BNAEY3JOIgb5QI5WQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771886904; x=1772491704;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=umqc/hGmbDtX3AgkVuMBoHmVtCIMciJcM6uWnrHjTrA=;
 b=MIRmhj181/DRF4w8eoQ5YqpLTSL9WEyxTzS69y/Sj7xkPSK6Maa9O6I9GgMN9gn95D
 EPpopnVcA27V1rPmn/wVfvWiStGP+M7ABvqbx0u1bAyP4gW5h8/Uzql14qZQeMkiXrhp
 sGhTyqG1c6aYzxiavyd1kmx87BzlmP+whvGhEKX5rHo9CjdggoRbOT4/NhAHLuRO2V11
 P6eMUW/X5eOGX6lrXjIUkIwcNuYUDqAZaC+hXi3lhx1QDOBI6dIXMm/OjN2eEu/vg1YS
 3aGPUqg6Ii7G4wSPXIy9dpr/6UF9ZGEKBjGItSbI0wER6RMFIE65efThUgp6cvK7kyqk
 HsZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwU+PGXlJ+H/Os5AzSWVOpIVLz+LXTe/BpXw5ut/4z3oz/F/9V7Mr956VlSsIdS4fdn/3dPc8=@lists.denx.de
X-Gm-Message-State: AOJu0YzqsX8/s1bOVFkc17nIO8aCsf1Zk1/L2M0g4lR5/Moaa9wXqA6c
 xSC2tnsVZX+wz6pLoDuqwR1pQFR+z3tOwCeTIDOF9aICRD/mVWt2cDF6SZyaB+Vr7Tk=
X-Gm-Gg: AZuq6aLi2u5dsUv3X+5CV4lWATeR2dPjNlqvh3mQLjjACPzBuIMT1VhN8NflOnLBU6N
 pTiAwpNlHkQx0r/Za8CHiG+gzr4m3gzmgwHw0WgeXG4seAjBaNqV2A2Nt9CTRliK1+8pN3P+Hp8
 k4XZHV5SsgyEibMohqo4866LWou34fjrouLrRAtqsmD6Nf2krwCsClaDRW6d5XGw/06L7MoEX/2
 OhYYUQiwsgpRjjV+GJHHHmmMxXzEWAmJLg9iu3PMl+lEpe3PsFhodXMZtYGGI0heH/EPERe6jQn
 3xrazCuE4BWHR71zpEm/DEpTL6p0lJRD6AO0z5sNtMIVE5HKsfQ0tr0Je1GUsWnFTCxoMOsGJCL
 dSdXblFq4C9rAQ5SDRDgRH51NVs8UJnVvSNlodDL47602VTTqpGBcrkKQHjhmfIaQ3Hc/Jb8a91
 SMS8SGx7/8EouNIKVoyozYvxdYBHMN/lsVI61ZzsP5Ji0/9y3vkCGmzcfGADXmQeb1X2MhKhzMw
 xqJik24FC1OAB2D/sA1kiiuqFxn35f5foEXnxfokEiayjG+Qw==
X-Received: by 2002:a05:6808:4fc9:b0:45c:9384:3626 with SMTP id
 5614622812f47-4644638d03bmr4855750b6e.47.1771886904004; 
 Mon, 23 Feb 2026 14:48:24 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a17aea2sm5929413b6e.12.2026.02.23.14.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 14:48:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <20260209114515.1916-1-ansuelsmth@gmail.com>
References: <20260209114515.1916-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH 0/2] net: mdio-mt7531-mmio: consolidate and improve probe
Message-Id: <177188690292.4021327.15386355321486911645.b4-ty@konsulko.com>
Date: Mon, 23 Feb 2026 16:48:22 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 09 Feb 2026 12:45:04 +0100, Christian Marangi wrote:

> This small series consolidate header usage of mdio-mt7531-mmio driver
> and improve usage in preparation for support of OF PHY autoprobe.
> 
> This driver is still not used (as it will be used by AN7581/AN7583)
> in the OF mode (it's used by MT7988 for the MDIO functions)
> 
> For OF PHY to be correctly autoprobed, the MDIO driver needs to attached
> to the MDIO node (the parent of the PHY nodes)
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] net: mdio-mt7531-mmio: use common header priv struct
      commit: 145487611f6875efc106be7f41e8544ff5bdadc9
[2/2] net: mdio-mt7531-mmio: improve parsing of switch register on probe
      commit: 358f97fcca9a888e7f2c074d70460b92b5222c55
-- 
Tom


