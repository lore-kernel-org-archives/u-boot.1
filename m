Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F844D49221
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 14:19:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAB8789124;
	Mon, 18 Nov 2024 15:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WTg5u+t8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CD0489456; Mon, 18 Nov 2024 15:19:38 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8DDD8931E
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 15:19:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-460c2418e37so26530291cf.0
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 06:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731939574; x=1732544374; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KhSBI4rZkKUeydhkLCuDVfsgZZaX2G4GhYbwOtNlm2M=;
 b=WTg5u+t8BWY26nXBNgq32tWEoA/9xWqPk8caAbIidPxeOon2RLEkinkszBaL0x+hgN
 UfWIT4LosOMG1p7TgRplkmPKCr1febVyMKvf7/HuIVnqZge6Vdl9J2l/at/muzB1m3fl
 ZO6QAtJWfmhANJkCKiaPhVzwJxdaGzVT7JerE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731939574; x=1732544374;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KhSBI4rZkKUeydhkLCuDVfsgZZaX2G4GhYbwOtNlm2M=;
 b=d+3J95IlEaDpBzsV3Bnm0pE/BeIfa5boJD6szIKMVILvQDtvAqd4E5bzf/8KvRyPtQ
 jBYehxc5XW8jHyiBLM0FZRqZLXdFiRk+Ya2u+eeg6jlDiNNaDQQcHFaPnGi7LWxargVC
 Fz5UiRyWp4OHLINblr5ueveGdhzj0KEzgBMLQKXMPNo20V+S8ky46+S6NzyqavUagSRj
 MYOFGppH7ig1/aflOASxKnr29l4UyjmMWKC5nI8nwg0IVm7L7tdwSgUxrU5wTW9W92MW
 CR0Bb0l9zeFt3FvrEnRl++fTR0nV6nDrvNNKyC/MHeLY9magoQHV1dY1MWDIP5PWk/TO
 B6qg==
X-Gm-Message-State: AOJu0Yxfeecf5v2Kg90O7YKw7anSkpjNEASYr/RQFJ9EESNKo/HveTCQ
 T1Sg8E5rrNkdWv3ihiXe1NLla2z7IwR+JNs/h9oCwjMHNfyniSju3XTLHQ7Ag94=
X-Google-Smtp-Source: AGHT+IGeIJWqJXshQv9i9uWB7VWqxmgSMmxziFHWszBzE99RzKuYArnTvDUTU3xia4KbwpesYMZ8pg==
X-Received: by 2002:a05:622a:5b9b:b0:462:af30:47d with SMTP id
 d75a77b69052e-46363b6b7b2mr140232101cf.0.1731939574571; 
 Mon, 18 Nov 2024 06:19:34 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4635ab24e44sm59075981cf.59.2024.11.18.06.19.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 06:19:34 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241106135017.696551-1-andrew.goodbody@linaro.org>
References: <20241106135017.696551-1-andrew.goodbody@linaro.org>
Subject: Re: [PATCH] test: bootm: Ensure tests can be run twice
Message-Id: <173193957369.3366111.13228192071794160441.b4-ty@konsulko.com>
Date: Mon, 18 Nov 2024 08:19:33 -0600
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

On Wed, 06 Nov 2024 13:50:17 +0000, Andrew Goodbody wrote:

> Some of the bootm tests rely on state that is assumed to be
> correct but is changed by the tests. This means that running
> 'ut bootm' twice will result in failures on the second run
> as the state left by the first run is not what the tests
> expect.
> Fix this by ensuring the state is as expected by explicitly
> setting that state.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


