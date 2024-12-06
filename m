Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D4DE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 18:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB49489746;
	Fri,  6 Dec 2024 19:59:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oBxniOFh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BF1C89740; Fri,  6 Dec 2024 19:59:00 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC9588974F
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 19:58:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6d8f544d227so2211256d6.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 10:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733511536; x=1734116336; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eq2eH91EzJzSzpx6NgzLTSgOwFDcoAFlIEFKLmJdzec=;
 b=oBxniOFhK643VzDB5vYNKATH9BEjMgPS6r8Rf6gM5LqeZqDPwHPTsW6ndtVeuJPFkK
 SCmND2sfMXdimW0+nidD0n7x/MKvYIPLpt0+7PNU/TNPN/MI8B3JG8F7teIH28RJ2GKQ
 lE6iv1/zpaYxNm3wEf1LdNCVurO6ACWJPJ9bY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733511536; x=1734116336;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eq2eH91EzJzSzpx6NgzLTSgOwFDcoAFlIEFKLmJdzec=;
 b=tOHS994k7datKqmeEbrApeo7DhprOnQ5J4N7MdNjHuFo6h8KOrcTzPjm+ItNq93PDC
 KhHRlylp7kHxjKs2pq9nsf7+vXtBUuVhgHwrh8N+W9WS1ixAEdHhm3oFuvH2A2rSHy4G
 4b0/maKLrX+OIrkvyNScCD53dy4b3uGUCU8cZGNBMJjl7YjQlZvbaM7Q7kS3hfxnXi4S
 QzjcNl9cpjQV4hrrKN6B4FRgVZXSmbrmgnN3HS269I9IjQ5RgEcqRayW0Hw+33epwgOW
 GL6PKYiwoM6TfYOTGDeMusXULVFzmV44aOyBuQrwbPzJAXKGhDwINe/YjNJSskbPusc8
 5Psg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6k+xf/rW/EciJq/wIxi83oHBgr+l5WfDQ8T+p0wiP8yX+a2ijTKcEBpaGsZK+hHnumjxh/GI=@lists.denx.de
X-Gm-Message-State: AOJu0YxDszzaxIirJGYZwNzUwGk+uebQJR7m5l6Yc+QXqh2XR7Y7Px6J
 vAPLBBF9Kux9m2igziVw8yaWePPvYqiJLj3vlbiZQFLiaMV+RRgyNkLmPS+enSg=
X-Gm-Gg: ASbGncvoL+xs2uhK7KSKI+wA+GxrW1jkXeZDxXO/uigMlQBR0ras6Glo5ZDDK9qXYh9
 Oo3RQ33W2upvZI7LQ6TtQo16tiHkZhZrtclW9q9QM+pJQSznLugpxwJfwa0ckax/ieyTXntY8/d
 2GdrY7KTFcr+mRrWPYcJuRnrVzVmq+K1J/trZ11pKe65um8/1Qp0vLvjOoI7R9dU72+yVV55Z1q
 Sip7aaz9pHJOPsWMBwj1Y6d4uBKJu7FNyJQMpTmWi6udUuO
X-Google-Smtp-Source: AGHT+IGKg1wpQKTo8HIuWW4KYpUhbpoyMqoMknHb3Zw77YcHhWyeBJvmj45G5e3I+G1Q/8DzVio8Mw==
X-Received: by 2002:a05:6214:2247:b0:6d8:9a85:5b44 with SMTP id
 6a1803df08f44-6d8e71641a9mr66180446d6.29.1733511536580; 
 Fri, 06 Dec 2024 10:58:56 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da673441sm21909066d6.1.2024.12.06.10.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 10:58:56 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: m-chawdhry@ti.com, b-padhi@ti.com, Neha Malcom Francis <n-francis@ti.com>
Cc: sabiya.d@ti.com, u-kumar1@ti.com, u-boot@lists.denx.de
In-Reply-To: <20241118105714.1973573-1-n-francis@ti.com>
References: <20241118105714.1973573-1-n-francis@ti.com>
Subject: Re: [PATCH 0/5] Enable AVS support for AM68, AM69 and J784S4
Message-Id: <173351153543.2516797.8954483829232327963.b4-ty@konsulko.com>
Date: Fri, 06 Dec 2024 12:58:55 -0600
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

On Mon, 18 Nov 2024 16:27:09 +0530, Neha Malcom Francis wrote:

> This series adds AVS support for AM68 SK, AM69 SK and J784S4 EVM.
> 
> Boot logs:
> https://gist.github.com/nehamalcom/db5dbf98357ebac46f648c24ad1a17e2
> 
> Neha Malcom Francis (4):
>   arm: dts: k3-j784s4-r5: Add VTM node to R5 stage
>   arm: dts: k3-am68-sk-r5-base-board: Add VTM node to R5 stage
>   arch: arm: mach-k3: j784s4_init: Probe AVS driver
>   configs: j784s4_evm_r5_defconfig: Enable AVS
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


