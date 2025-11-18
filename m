Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864B9CEE351
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 20:32:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3E59837F2;
	Tue, 18 Nov 2025 21:32:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hprK0TBp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4E9283966; Tue, 18 Nov 2025 21:32:23 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2BEC83700
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 21:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c75dd36b1bso1719186a34.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 12:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763497940; x=1764102740; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2I4o4g/qiR309HncsrV61vUC3JVwBsYNpoCMoD3i5jE=;
 b=hprK0TBpwfNOnaNuAi9HGDHcwIs8exYE3qbxCEcLzcxi2HRQaTq4WxacGu6nHaNn65
 CoTNu3guUrF0FLC355XvfbUAfhIlcGyGupkggxzipZIJmi9m8UsCBwBUw9DQqfw26xGp
 W9B38HfC0mJ0+JeJgSVTrLVamxQKSvMpCUdi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763497940; x=1764102740;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2I4o4g/qiR309HncsrV61vUC3JVwBsYNpoCMoD3i5jE=;
 b=ulfllfdzORrfhOT1vcctQNEDf73RKmgD0AcCUWbBNOo/AMTdrnPvpfVo0lwv0uAqBC
 cPIj1ohawdwnG2gB8p+rs0YShUq6yHydNUU3/zYVoTokZeKtXtVRwobHQeqNTRrGE+mz
 BVYc7pwx8rxX/BrzRYp7LNPriyDKWGfYwyK8KvWny7/EnOdrmSD7zjIomdubTHGvVNlG
 jyYqyy+nQaJVPJvcKM7P0Yf4cVUKHvHusWrA1Su/QQXzb0/54+wxLpAOTkDHDEq1oRng
 9lCub06tK3UhEWVLz8wGvwkHo6oETjMn4ZPgKBr6WHVkba/8g7a1mnswxRWOP7a9WdfX
 BX+w==
X-Gm-Message-State: AOJu0YwVmD1gIOJiGdYymeWsGfOxICioX9fEPbgWu988Po+iIY0FS69j
 hw+v1qztlgSFNWurpzae4jrKH392vEEn1U5Hu00eYfrHYxdN/e27w5M9SDWOqZ6uSR8=
X-Gm-Gg: ASbGncu9qC8is9NzRQT3J7jb4ue9ZQz+XUHHzOqxGosSpx7nTfdqhEsXSh0YUmdb7kK
 2on7LDjCH9wFv9l97WJil27JWAlDsJ2jYcJfSW//WM0jUBIHF3kWJ+Ntv74Lv9OwSBEGLxVzWY/
 rRZxzw11APqHeYnb0cXwTo7Szg0deg7LDXq0cX5zp+CgI48ZrIMBBLDFhZ+/P9b5A28Wk3z1Ll0
 EdaZgCZS4hUaDq4bWhY2jJI7Rc86LgEb8kUXmBui+HUP4LuSyNQKw45tiQ3jTtM7Yy2KnnVpTLL
 G36Mo5EhdEVJknpRTGehrNYzjyKWrvIkGfGY5mr2ghEBVBhbjKoUwDDbCO5CV01aw7B/lG9LBlK
 yp4MI4pQ/tdL0FNGVcBR0aFzBDqBiN+4sH8mkaHOk3tlDJjshfanVdLx9wFGrngziMzP17uXWk/
 zPG+6ReNc/ntH6zakCACYTX4wQwHwWu9lJus1Rg+MzzGxc2ep2
X-Google-Smtp-Source: AGHT+IGgKu/cRuZ0nhwTxpovXECxh3kieoa2qRiAFLHKxxgUsWbVXUNJGJ04xVTdqZFqgSjQJoNPhQ==
X-Received: by 2002:a05:6830:920:b0:7c7:6626:b586 with SMTP id
 46e09a7af769-7c76626b9f1mr4736223a34.25.1763497940302; 
 Tue, 18 Nov 2025 12:32:20 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c73a283c36sm7036097a34.3.2025.11.18.12.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 12:32:19 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Philippe Schenker <dev@pschenker.ch>
Cc: stefan@embear.ch, Philippe Schenker <philippe.schenker@impulsing.ch>, 
 Andrew Davis <afd@ti.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anshul Dalal <anshuld@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
 Hari Nagalla <hnagalla@ti.com>, Judith Mendez <jm@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>
In-Reply-To: <20251111071756.1257488-1-dev@pschenker.ch>
References: <20251111071756.1257488-1-dev@pschenker.ch>
Subject: Re: [PATCH v3 0/6] remoteproc: k3-r5: Build fixes and security
 improvements
Message-Id: <176349793883.618903.4545102952733372052.b4-ty@konsulko.com>
Date: Tue, 18 Nov 2025 14:32:18 -0600
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

On Tue, 11 Nov 2025 08:16:24 +0100, Philippe Schenker wrote:

> From: Philippe Schenker <philippe.schenker@impulsing.ch>
> 
> 
> This series fixes compilation errors when building for R5 cores and
> addresses a security issue where authenticated images were not being
> used correctly.
> 
> [...]

Applied to u-boot/next, thanks!

[1/6] arm: dts: k3-am642-evm: Remove duplicate node
      commit: 46e372feb784f533cd92e73f51f90b4fe4d336e5
[2/6] remoteproc: k3-r5: cast size to size_t6dd
      commit: 5d3697b7cf0006fee3fa12966643d605ae0777cc
[3/6] soc: ti: pruss: Fix size ptr type in probe
      commit: 40768f5ed3ef82ac11236cdd2e50cde79b5debe5
[4/6] mach-k3: security: Propagate verified image addr
      commit: fe114f3662c655cae44b45370d6dc4de2055a611
[5/6] remoteproc: k3-r5: Use verified image address
      commit: 3a43fc9016c3c37eefca10ed404c95ac7cecd3dc
[6/6] remoteproc: k3-r5: Implement is_running operation
      commit: 0c192f52cfb8a4b1c29d61750f48e016ba6b978b
-- 
Tom


