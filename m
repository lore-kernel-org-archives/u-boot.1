Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BAC6CFA768
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 17:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9F8983A5A;
	Fri, 21 Nov 2025 17:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jOboBp0i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8F6483984; Fri, 21 Nov 2025 17:19:40 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB3E98394E
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 17:19:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fanra3.tk@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-594270ec7f9so2049474e87.3
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 08:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763741978; x=1764346778; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S/8PrWFEkaDrboOEq4tHF5082cTbNOlzn9OpZTsZobo=;
 b=jOboBp0i4gIN+uE3iRr7Sxm1x/P3ksVj0kbSd6tAIa5c+Dgg68WkdjXvTOR/4g3D72
 QPo/75hUF8tUWwG149n2a9QVFEs3k6Zv2XsmnIRX0wAfXZQ2suX4RMWc4HNrCZ0821Rh
 MnbYXjHg79Hs1pPYJX1W6INjRrvtAE9FWf6cNqg065jKhtI1f0O5uDXGW4Qb8zb5Z4Yi
 NKibgYMkWJBQjpU08No0XvAHjAlG510SRYGIc9ti5ep/vuL75C87RIlIPF2YsttBBQ3g
 xPlDDDR1nISbXYLEwSf/90/eNNVWh+Z5JEiBt0SS0o1bdwjYDfEthS7NMmqpjZKo/o1m
 uu8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763741978; x=1764346778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S/8PrWFEkaDrboOEq4tHF5082cTbNOlzn9OpZTsZobo=;
 b=MdxVYbuPeIKPUdJMkWTrKcXOCcTxmcXmZQfZuv4J/sxZ8LiUEu7qSoFT2W7e2p3nEy
 DBa0UG8Gr++n7sSU1ks1TO4NxwEZmkj0rOoG7lWgvCim1VrBDKm9xtYv1SzhhBM1y1dZ
 eYUys7WENw2DNTRh72S8Ca1yfEyLmao9ghlAab7QqG4a5ex1LGMULljNjQH+Gb9/Qo8n
 cqwtHROlYU2sDvTzBJWiMayU+gj9BbIOPk+ZC4KhOvdq1qMiztqA/5d5MquZR6IOwmRD
 bPiDc3zUev9A0rylpdpyo2MantJyHnLorHTEId2ecqP1LvSBowSkVtjUd55R/BUw+O89
 PmlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKGnN7YkzoZjzpZI6D09ZROB3vxCGZ0dbKih8GCKnoLG/pHCdMk0L3rawlgGjPXSTn8lCRoi8=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6nid7FzXwbdWUKHnFeGi1XADQIVpeTWz6LTqkyaIpkPZesw25
 utq763btyL4vaz3cg67T+XlzXyD7SdcXEenVZQJzhaPsp85aCycCqYe5
X-Gm-Gg: ASbGncvtdcsGf0k/mKo0Z0gLtyvDGGzvEtaFawK0x/TzlN55oAnHgu2Z8SvdYzfXltK
 DVtpNj7eE69a3k+BphTHr735OkVIi4EFXW46OszBK5mlceEpffQAdZCjxLyW9OkMe9w5VH95v+E
 GbRiJE8UI6c+GVY757UrKBYl9aTDBEw9TGhdAYDL6arhhHydeDMio0XZ5UUkIBMQiwnxuuIIsht
 7lTf58KBGJscpd/dkSWALuSolZx+IwVhsoTUtldHzRYVCBGq+w53aXoa9N9VAmWLJ7T9Hb6dpKS
 uCrICPhmnOdaf8TUALYqruPYPYwWZjBVJQO8evouNv7sQmzdwgjp0hes//ggdllxuE2nbl4+lrV
 R08GBWz7Ytppde/37bqK6jq9cc+lblfuoG1q0HglFOsLfjxX+sbkdub3q/oQNUQmsFFKDUCn8xo
 DMh7dCsaGemGPSvcldth5GJVGTSr+rc5vkB98/1GI14ZyncwWJpGNmBUs=
X-Google-Smtp-Source: AGHT+IH5AGir/PTNJEyibruZOF7rNC+Z2gHnRc/kuwZpos+IA2qIwRdqLozV9si5Zl5sY7taIly2xA==
X-Received: by 2002:a05:6512:308f:b0:595:7ed0:9c77 with SMTP id
 2adb3069b0e04-596a3e9f91fmr938477e87.12.1763741977861; 
 Fri, 21 Nov 2025 08:19:37 -0800 (PST)
Received: from medoed-VirtualBox.. (88-112-69-49.elisa-laajakaista.fi.
 [88.112.69.49]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5969db7478esm1696247e87.6.2025.11.21.08.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 08:19:36 -0800 (PST)
From: Surkov Kirill <fanra3.tk@gmail.com>
To: kory.maincent@bootlin.com
Cc: andrew.goodbody@linaro.org, praneeth@ti.com, quentin.schulz@cherry.de,
 sjg@chromium.org, thomas.petazzoni@bootlin.com, trini@konsulko.com,
 u-boot@lists.denx.de, xypron.glpk@gmx.de,
 Surkov Kirill <fanra3.tk@gmail.com>
Subject: Re: [PATCH v3] boot: pxe_utils: Fix memory allocation issues in
 overlay_dir handling
Date: Fri, 21 Nov 2025 18:18:39 +0200
Message-ID: <20251121161838.48603-2-fanra3.tk@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117152308.900316-1-kory.maincent@bootlin.com>
References: <20251117152308.900316-1-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Nov 2025 17:59:23 +0100
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

Tested-by: Surkov Kirill <fanra3.tk@gmail.com>

I tested this patch on PocketBeagle Rev A2 with am335x_evm_defconfig.
Everything works correctly.
