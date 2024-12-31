Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5966E77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 15:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDB908037B;
	Tue, 31 Dec 2024 16:20:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t4HspsiY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4809080383; Tue, 31 Dec 2024 16:20:20 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BFE8801CE
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 16:20:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b6e4d38185so822578085a.0
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 07:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735658417; x=1736263217; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NLVkM3C2dce0TXsMK59rwBcrDcdpvAJWbd9Z/1TSiYA=;
 b=t4HspsiYmOrP5K+UWMbVA2O3LUj2sjabD+OMTdutFH2Bfp0oMc/qy9MgbiICFEgv3E
 xBG9YpTpl8jrbDnFkQJU7tN64GeQ2rkpF5VO92TB6Ehm9BD0t3jk5vdhqvjqxVkHnLLO
 UWjGKmgEgPTtwBn1LhD9tLI6fWkClaxnRJ4N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735658417; x=1736263217;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NLVkM3C2dce0TXsMK59rwBcrDcdpvAJWbd9Z/1TSiYA=;
 b=F1jnTXlc83iXq/WQIdjx2jwMAhpYVnMiBW/YMJogMg5zFK9BmrACkRFwAq5NFsSTPz
 PMISN9KIuljVINQxsKb66gSY5JkTk7F7CZ85c2AeIVKKUGAvpCEAZtSb2z7IRjYL0YEO
 y7RSINGRM+5vu5w6f+sV9PJFEdsAMG9I6YnI3xUJeqBzihgEY2iEJ7rSc50OgKo8zMmj
 /Lg24j9VZJibhNXaUIiejv0YJgtYRV098x2OSDf5Flpx4l/U1ih1jUFsCN9lTcN/vEXC
 xo1f1s483YbgwwlKODKRPdz+9BY+NS8o4PLccz6NxDDVLP11PziF5LB2YSgT3xlZ0eEN
 XmOQ==
X-Gm-Message-State: AOJu0YxuAIxXKJfuCU+MvYi41jZwmTHJx2HRDLn2+NBeD7nBO4QNynO8
 jq2Y2dgXwQWsVQvY0ogO/QohqzFc55jTBIe/4QXXl0rUjRZfPVrNWWMl2SHem+o=
X-Gm-Gg: ASbGncvGB9uypFUK+1xc2jV6gkjqnEOWBQdwMKrKVGgT3XsGSuL2N6DJth99VtPfofJ
 oqTUvQqGr2MuO/m/OjS1O/ndMzGDK0nseGXrnOSem8GtASf/p1QOze84Ca+6I7GfqbFnNGUHjm4
 u7uqMIR4Ioijq+tybUsbsBO8EbG9LHYAk+5Xb0fbWEPelyITF43jfKc415sY0/c3SatAWaC2Slf
 xBk+EVhkij4M9w9FKjb2YnbNSStiBv88+htXZUwgjX0oR/X2IIxOm7M
X-Google-Smtp-Source: AGHT+IFvdiEkXSoxJFXiypD2ir/NVHIDqy8XJ3L4EwgbHtzEnsqrHkfsYQnaXPsPXBjcNgH+v/dLAA==
X-Received: by 2002:a05:6214:ccf:b0:6d8:99cf:d2db with SMTP id
 6a1803df08f44-6dd2339e044mr757357486d6.38.1735658416987; 
 Tue, 31 Dec 2024 07:20:16 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d528csm112175506d6.112.2024.12.31.07.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Dec 2024 07:20:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, alpernebiyasak@gmail.com, 
 Prasanth Babu Mantena <p-mantena@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, u-kumar1@ti.com, 
 n-francis@ti.com, vaishnav.a@ti.com, s-k6@ti.com
In-Reply-To: <20241218130045.2070314-1-p-mantena@ti.com>
References: <20241218130045.2070314-1-p-mantena@ti.com>
Subject: Re: [PATCH v2] dma: ti: k3-udma: Fix BCDMA probe by adding check
 for MMR_RFLOW
Message-Id: <173565841529.348552.15135055091605518631.b4-ty@konsulko.com>
Date: Tue, 31 Dec 2024 09:20:15 -0600
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


