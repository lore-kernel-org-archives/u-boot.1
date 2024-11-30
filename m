Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B222D73618
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 23:38:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C88E898B2;
	Sun,  1 Dec 2024 00:37:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MMH3A3HX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06ADE896BC; Sun,  1 Dec 2024 00:37:43 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0CFE898D8
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 00:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6d87a55bc50so19427816d6.3
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 15:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733009860; x=1733614660; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6UnLP5A7FpOMVs97zd8Sb5kTw1PVE3+NZ7y3M32P9E=;
 b=MMH3A3HXDEs/tXjZoUA3eXik44x9+XOMru9pyvNiJQsscM7Pj9/klUJ0MxN7VPzzyc
 JP/AFSefVypGLhRp5U+iJTFoqD0m1u88iebsoYoIWI/jtIYTVHDsxbJOPX40ScCqtCgJ
 EaGb5yK+PS0Q6WVTMwPcOApHouvalKg1iORJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733009860; x=1733614660;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E6UnLP5A7FpOMVs97zd8Sb5kTw1PVE3+NZ7y3M32P9E=;
 b=JSxfWq0htWlKB2RtwYqPFO3fc0bn3+4/vUswhADqi/9YGG57hNgdN2853vhnRE/S0B
 TSF9sQjugMJgjxMO0ApFMKagEuqO+qn3BpelzPjeEqBIFY24Rc1II9/EEPL8jGvGOMov
 IyrAzOsy5ooJEHIUjSaw6Il9W0UikVyUNk/G53rxySHZx8aEacuY65jdg8mNkcmolwaf
 +BtJLYhhE2I/rRdqe6jnLKw6l71qPu1rwcK9W/MLse5/XHvaygi5rrCdWhE2ywXDEjTk
 De2gqEjdmgh0Lt2rlVn8yklUlfQ8ASR1kY/7nP63+h+xLOhu9o/TRgLWIarRvSWZYizS
 lAWA==
X-Gm-Message-State: AOJu0YxhN785T6YWf1fkM03BnIf/zu2TzmOCQju36yBdAi5qFkpERz4j
 7PDGSiaceuhc2hKghjQYKr84sEqvoyvzc8nrKk03Gjg74we+0tSZj7/NRPdpmHN/HSzrpthj+H1
 HPGc=
X-Gm-Gg: ASbGncsaqCpwTNFR1cszWDXad3JDD+foTHLYbDoURQU1MYvdJfZ6GH+CafcCGuMVJrR
 LIXzeBKYlQmuatGbEgCn4M7EmrCkzxuqLgJoER1DmlhXnBjVjOHyX/+0ePY4FbpGYSFywruSiFX
 pFe9KZwhSfKhPqwozOJXlYHJ96jxrR2HolyTFB+C+7fK3BWpKPIZFlBj1dkm1aEaXMPPApvFRuA
 3dN7wGs3t9Cxzii1GxQaNNKV3T/+3LJSwonIch/+VDG0D2C
X-Google-Smtp-Source: AGHT+IH89FLVqWbBajONMqPsLYttrzDMrLUG3aOqSqfCPWuPdaLvsBBNcUguzJAvRj+EsSkQXKjAtg==
X-Received: by 2002:a05:6214:20c6:b0:6d4:1dc0:2623 with SMTP id
 6a1803df08f44-6d864dd30a1mr280457386d6.32.1733009859803; 
 Sat, 30 Nov 2024 15:37:39 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d89b158778sm5725926d6.96.2024.11.30.15.37.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2024 15:37:39 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
Cc: Shengzhou Liu <Shengzhou.Liu@nxp.com>
In-Reply-To: <20241125093700.1135929-1-ravi@prevas.dk>
References: <20241125093700.1135929-1-ravi@prevas.dk>
Subject: Re: [PATCH] powerpc/t2080qds: remove spurious x permission from
 README file
Message-Id: <173300985811.2282108.921632527262120314.b4-ty@konsulko.com>
Date: Sat, 30 Nov 2024 17:37:38 -0600
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

On Mon, 25 Nov 2024 10:37:00 +0100, Rasmus Villemoes wrote:

> It doesn't make sense for a README file to be executable. Remove that
> bit.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


