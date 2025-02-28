Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964ECC19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 14:24:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 071FE809D4;
	Fri, 28 Feb 2025 15:24:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VmB11QeS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57B7C80FE1; Fri, 28 Feb 2025 15:24:35 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C7BF807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 15:24:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-219f8263ae0so40369505ad.0
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 06:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740752671; x=1741357471; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3myOyvdaZ+8ocWDkI5Q5AM4YrtzmZY+uVtJC+Hxk/R0=;
 b=VmB11QeSYDhF+VNP1bHH3LDjpG3L1lRrMexcSBZla711YbmBU7+FEFjPui79rvNU1h
 mkKOQlOrUVkDMwbtr1iGoZoiKOilvYERih7vBo6EKY5RqJFo3fQke8gMcUMY60IQlLT+
 pVtkP8TfrFGjiDYkkECpD4a7ofiV6oTrkEpWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740752671; x=1741357471;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3myOyvdaZ+8ocWDkI5Q5AM4YrtzmZY+uVtJC+Hxk/R0=;
 b=GhzmRk2occhoJUtlGgn11z+YvXwtZ3zZ9bJmraRGYVZiVQy2UZUywBcRw9wGn4ywYu
 /I6ngAsKaxosyEB/9r8yGwvmcpXIBL4aASVJLT5QasjV0r9i5QTs6uJYttVgeLs+Pfva
 PsWC24X69d3Y+88EQLhnWCHYrHejwG90NnuJC49woYtH2kqX68sDIA2/0bTLW4R8HUFO
 f5h9ruxei3fK/mY1vWsb+zQV6u2xglVX6xOPVNthendJWE2J/0h34n6xu4vAm3i4YuRT
 mZSwWaw+OpFuEtgSxh8YU/BKMb7LS8v2QvJI8JI3JIqdfkF/Stb0f62fjf0QFJ0TpUit
 M/ow==
X-Gm-Message-State: AOJu0YymeglXUQF+qIH8EqpoqvV6I+yK3yjY2mu75tsNrz9NIvMRwmJo
 g/iDs5Bh+tXjNTuV8lkqvHU/IjKEjfrcjaA8pYFq0TknA006UXvNn7YZNEPzZbo=
X-Gm-Gg: ASbGncthpts1bvPj1yUZl7cSqtImL1vNPax7BRI29HpAoH4K1A4X710ulQSv8WF+Vi2
 kSSJwwtO4/CAHP3l7JYXDwi6G6L5y78Cxa6XLJPB6srFkkdec7YH3emwmcU8iYrvP6XAClzfOf2
 6aj68tzX5hsfWB4xq3IPKrbi4p/ozo6Ysy/8fbF7kdUOon1g1Za9fZ83hSqZXFepOWsa2/wANDV
 gvoe7mzoFOUEifxdyOxE4hjYzqVakQ08kiW9j8wU3CHUKBTNLQO1UFVjMimeimcR60l1FlSykel
 gqo2ptpF2T+6v5fsIls8h0Y=
X-Google-Smtp-Source: AGHT+IEkXi7wcJvBTFmBZIRDZ/CozAr66/RRjs6SimjQ3sW9XN/k0nphrxmovZiz5BZUJyy1KmJ7Bw==
X-Received: by 2002:a17:902:cec1:b0:21f:592b:b4b6 with SMTP id
 d9443c01a7336-22369244244mr52093285ad.47.1740752671640; 
 Fri, 28 Feb 2025 06:24:31 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501fa5bcsm33559005ad.92.2025.02.28.06.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 06:24:30 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Raymond Mao <raymond.mao@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maxim Moskalets <maximmosk4@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>
In-Reply-To: <20250203220825.707590-1-raymond.mao@linaro.org>
References: <20250203220825.707590-1-raymond.mao@linaro.org>
Subject: Re: [PATCH v2 1/3] mbedtls: fix incorrect kconfig dependencies on
 mbedtls
Message-Id: <174075266952.46986.8005195555537785999.b4-ty@konsulko.com>
Date: Fri, 28 Feb 2025 08:24:29 -0600
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

On Mon, 03 Feb 2025 14:08:12 -0800, Raymond Mao wrote:

> Fixed the building failures when WGET_HTTPS,NET_LWIP and MBEDTLS_LIB
> are selected due to a few incorrect kconfig dependencies.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


