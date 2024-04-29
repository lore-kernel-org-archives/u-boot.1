Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7504CC4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 23:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6510889F1;
	Tue, 30 Apr 2024 01:04:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i0vhrN+1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A97D889C4; Tue, 30 Apr 2024 01:04:24 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C4D7889CC
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 01:04:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-790f4650f93so156279185a.2
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 16:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714431861; x=1715036661; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wjNLXBVkX53xRo0xrrJZrUu/SFdfATAJjntK0nAQcWY=;
 b=i0vhrN+1fnu2u3c4N3Vr4cGx7F7S9ZhNv5uG1x/fIW3hwzD1CRECYHQ4BdQOMYVbTN
 lE3FxaoNIeDkO/6v/zQZkjEx5DZqOL//yAw651F8DcqGPjWxmq6WXV2anglf4Z01g4ML
 fO0/zgtT2mATsLLdyc383DHhCw3MJaVo6PRjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714431861; x=1715036661;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wjNLXBVkX53xRo0xrrJZrUu/SFdfATAJjntK0nAQcWY=;
 b=qlSJxRl+gTUDp9Yh/RCkeEVX1u7gtCzHcmvhFjzBD5NR7kmnHfl4L6zJp+604mQcD1
 Ca+QCXQ93Y/KQAzcrT2ZyoCxAWfvNZI5Ae5TCZ1gGJz78zCKylKotqhvx1Fn89t6jcfk
 Iar9Z3Wz5zRe5jn2kaWnHkfYDi/lAbVkgekbWBVIrqVfeWKJxPQzMw4RekDqlE+GxpcF
 UVTuJp/HLjdSOeorwGl4I6Q85gi1qcRqKIcI08xDxRhhYI0TgU0eHWbL9V2Cak80yC/L
 bkjDyHjWSg2EccnRD053qp0HIEmm6HeepKjid6JZ51ew58cXPnWaFpQvh/tm3PCCU9AU
 RxXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqXV1AzqdmJ7KcmdDB/WAynh3UoJvNpMdAxZISmyTTd4qUAfNd2tV7J1UfZ/MSJmpPCF47oIUu23fjSB5Opy7sNEFRQg==
X-Gm-Message-State: AOJu0Yx6MvlhqKIrDimcfK/TF9My7hbXh/jJfRJzYysTM0TeTINT/yhq
 iHKp3Ymb0b73ZaOdW7o/hGwGKBRi1VokKYNvhev5qScYfYxO7b0+9mML+yMQWVZu7qs9RV4IJV2
 kaCRQnA==
X-Google-Smtp-Source: AGHT+IHmIgBHYL5CNLrvNnFdggmD2/mmI5ohDtzjpQ7+qO8H0uUfQHeallZK6n12KU7nVdF8O0SB+Q==
X-Received: by 2002:a05:620a:ed7:b0:78d:6a13:cd1d with SMTP id
 x23-20020a05620a0ed700b0078d6a13cd1dmr11225788qkm.19.1714431860817; 
 Mon, 29 Apr 2024 16:04:20 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.98.216]) by smtp.gmail.com with ESMTPSA id
 h6-20020a05620a13e600b0078f044ff474sm10967156qkl.35.2024.04.29.16.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 16:04:20 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Judith Mendez <jm@ti.com>
Cc: Nitin Yadav <n-yadav@ti.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de
In-Reply-To: <20240418190100.1289150-1-jm@ti.com>
References: <20240418190100.1289150-1-jm@ti.com>
Subject: Re: [PATCH v2 0/5] Fix MMC tuning algorithm
Message-Id: <171443185950.1749944.11308286584685523074.b4-ty@konsulko.com>
Date: Mon, 29 Apr 2024 17:04:19 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Thu, 18 Apr 2024 14:00:55 -0500, Judith Mendez wrote:

> The following patch series includes a MMC tuning algorithm
> fix according to the following published paper [0].
> 
> This seris also includes fixes for OTAP/ITAP delay values
> in j721e_4bit_sdhci_set_ios_post and for HS400 mode.
> 
> For DDR52 mode, also set ENDLL=1 and call am654_sdhci_setup_dll()
> instead of am654_sdhci_setup_delay_chain() according to
> device datasheet[1].
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


