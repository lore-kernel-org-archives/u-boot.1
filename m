Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80925C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 21:03:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC0DD876D2;
	Wed,  1 Nov 2023 22:03:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fZH3TGAV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD07787683; Wed,  1 Nov 2023 22:03:24 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 544F28769A
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 22:03:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-77897c4ac1fso9129685a.3
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 14:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698872599; x=1699477399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Pj5z54HJSCM0qEtmdA2fpiafo6KJlZhNqSGfb5/zZE=;
 b=fZH3TGAVtpTZiaon010gY5VGUjdVy3VwMlBmr8jg155aAWdo+vGSeXuwWKpESeSKvJ
 IzHWnO2/3lPKUN2f5jOjc20lexvcQO0PXAi1ANulBvfumq5q50I1CnfuKcO5Za8F8gZT
 Aqvakgxo+KANr03vo+NCkCxK7kj5T3tXeHMhcExQ7jm88yZE/FbQdzEymOFsBr+zLtkP
 1wVGagYszgi5GXfMwTsKoODrk+AC/OaaRpPLQr8XWZLZdWFon4QojgGzaxuGJ21lB5oF
 YlUIC6RmbL7axjW6t/8nN1z56P7jHeSscAxZlhoANsnaINcWr63vr92rcLLzaEif9Abr
 BOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698872599; x=1699477399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Pj5z54HJSCM0qEtmdA2fpiafo6KJlZhNqSGfb5/zZE=;
 b=Crq7Oj+i8KGiRa1atTrFWPRv8LvGepglcRnyO4blBzKLGHoCjUN304xaVkoV0zI5A+
 VYW3+Vtpoc4Oc33UKALlVmBdLZa8K4orezBiHP3MqWDQgQzOSqovzctM3SrmBSJyA3sq
 TxqIoirz/rcjOcyVGebwS7n/KXqi4t9XYqZKuMQ1neN7IPLJ+7P1oDeRm2rMhclNUO4x
 uj6D4z3oSWsP6QPnpc554JMtkzaynowgn3kGzh7ezE04oRdGlJDmqyR+8RMFKtdjkdkr
 vgpb6LoqUhAwHtMY9HCCgBFm8IsGaPzp7eVCE/16BoKIM00cFabIp8SHIEWoTTpy1q9H
 cv+Q==
X-Gm-Message-State: AOJu0Yxnd1OcMdofv8eEAICOLAwfyIXopoYM+MzbvkufXdkfuh8u/P+r
 GoQ6iWzZZbVxcbDOrxuhbgw=
X-Google-Smtp-Source: AGHT+IEm6fBiYE2Ki49IZOAIxAJzRNigaPdaEZNHD8IIklih3Im7vdUiyJstFkWh8qzi1SdQeN3nRQ==
X-Received: by 2002:a05:620a:558b:b0:777:6631:85b6 with SMTP id
 vq11-20020a05620a558b00b00777663185b6mr15701033qkn.39.1698872599103; 
 Wed, 01 Nov 2023 14:03:19 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 de43-20020a05620a372b00b007788d2f3d4asm1764992qkb.39.2023.11.01.14.03.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 14:03:18 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: eugen.hristev@collabora.com,
	lukma@denx.de
Cc: Sean Anderson <seanga2@gmail.com>,
	u-boot@lists.denx.de
Subject: Re: [PATCH] clk: fix count parameter type for clk_release_all
Date: Wed,  1 Nov 2023 17:03:08 -0400
Message-Id: <169887250360.1352526.16888002933473627645.b4-ty@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230619104752.278500-1-eugen.hristev@collabora.com>
References: <20230619104752.278500-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Mon, 19 Jun 2023 13:47:52 +0300, Eugen Hristev wrote:
> The second parameter for clk_release_all is used as an unsigned
> (which makes sense) but the function prototype declares it as an int.
> This causes warnings/error like such below:
> 
> include/clk.h:422:48: error: conversion to ‘int’ from ‘unsigned int’ may change the sign of the result [-Werror=sign-conversion]
>   422 |         return clk_release_all(bulk->clks, bulk->count);
> 
> [...]

Applied, thanks!

[1/1] clk: fix count parameter type for clk_release_all
      commit: b6a56f553318b4c0c8fb8b1ea05f2e15b2662ccb

Best regards,
-- 
Sean Anderson <seanga2@gmail.com>
