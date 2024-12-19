Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA0DE7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 21:43:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8CF480394;
	Thu, 19 Dec 2024 22:43:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h1mXbVTt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3B328036E; Thu, 19 Dec 2024 22:43:26 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D966F8032B
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 22:43:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6d8fa32d3d6so16357146d6.2
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 13:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734644604; x=1735249404; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xA+oUIkQ8U9IbkzbFSrMzwHHGPgI60tBc+I6a0HEHEs=;
 b=h1mXbVTtbjAuzw4bRUZ/FD6Wn7CqMkrEsmSxDRldYr/tuBMOLWb26Yt/yY/Nl4MVKp
 fhSz6KviM6cPUmcRTxdin6NY+5eaUgauuMw90ouV8uLdCc/7stlTczl47ctkbH8dJX2M
 fW9LAVlgoVP/yCR/F/YlD9nMQP35iIqMFiC+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734644604; x=1735249404;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xA+oUIkQ8U9IbkzbFSrMzwHHGPgI60tBc+I6a0HEHEs=;
 b=m2nt9gDVfVXyeGExdLsRGlKrQlKaoGwP/PEtOCLEa4Tn/fo88HARisvd+r6UakUPpQ
 oQaBn2hsfgZLnfrK0VH9Arw2VKmeiHzruMVs4uuke21elUquL2ETHkmjDeK1ii572nMW
 FxS6mLu4Jq6CdxASk6O5I624jKwrSatHbhVkTxKM6cMhG8uz7UtqrAGfjng28gdp07uJ
 IRX3wvi8VogIo5478yCV5IQXCJs8yYE83uvVYY9qlg3sKvHcXk/rpwvUsHlZKSqYNqwv
 8L1xe3pGeOMZxzOs+Ol5zPSnhx1Z0jhSZ/QWCOxYWwvOqLvtQYYGNPam08k0E9u0wH6X
 LRqA==
X-Gm-Message-State: AOJu0Yy/MWjr3pNM7wUB3LmoDjfCnLt7bCzsVGHsBi6H3G9Iedz2AYlq
 mAJPsbK5q6QskYAYctaJBYtguxpKrtUh2FfIoodZsJii8hh2iwkVk4Hdxkzk/nbfmGE8saGA5Hh
 0gPM=
X-Gm-Gg: ASbGncvbZgibXBBZ7cxUgLdlPD6Fqp37HN4cNUWHeSRIQ1pWS5tmc8K2Uth+Cd8EDJt
 DYCjxS3KyhpD1oeZj8vESLD8zsAztrB45Pwm+SDMd7unDsMyupdg/aDsxlWQPGSV9lbM5NsuioY
 8/F4xjRb4cjmIK78878WtUM62q4FF3h739AExzYFth8l7ZTMJj4Gs17/IqaGbuNriAf/9lk7eZT
 +nVq2UEBQ5wcvI+cllfMJFSJNiR/ONk4Arg5dVBEHzcWfVS6VxZSaM=
X-Google-Smtp-Source: AGHT+IGpNiMeUs/BnW51c03D7ahFu00XdsNuHuMVoEx+Depw6weV/c68+C32l+OeGyk/NLKTAM3WVQ==
X-Received: by 2002:a05:6214:5189:b0:6cb:e4d3:10a0 with SMTP id
 6a1803df08f44-6dd233ab438mr7779486d6.48.1734644603794; 
 Thu, 19 Dec 2024 13:43:23 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180ea824sm10410196d6.4.2024.12.19.13.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 13:43:22 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Minda Chen <minda.chen@starfivetech.com>, E Shattow <e@freeshell.de>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241216063220.627348-1-e@freeshell.de>
References: <20241216063220.627348-1-e@freeshell.de>
Subject: Re: [PATCH] Revert "configs: JH7110: enable EFI_LOADER_BOUNCE_BUFFER"
Message-Id: <173464460239.3661439.16683756459500422895.b4-ty@konsulko.com>
Date: Thu, 19 Dec 2024 15:43:22 -0600
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

On Sun, 15 Dec 2024 22:32:12 -0800, E Shattow wrote:

> ("Enable EFI_LOADER_BOUNCE_BUFFER") is not the correct fix for the
> problem it describes.
> 
> The change of memory addressing leading to side-effects in commit
> 22f2c9ed9f53 ("efi: memory: use the lmb API's for allocating and
> freeing memory") is remedied by commit 1a48b0be93d4 ("lmb: prohibit
> allocations above ram_top even from same bank").
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


