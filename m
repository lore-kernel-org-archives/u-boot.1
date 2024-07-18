Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A452AC3DA63
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 17:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8C2B88113;
	Thu, 18 Jul 2024 19:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oPG63mje";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E3448657F; Thu, 18 Jul 2024 19:13:28 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC5B088AD9
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-25dfb580d1fso490826fac.2
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721322804; x=1721927604; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xyz4oBZLIPbkYz582n4fTn+Rbd24cV3n3QH9P14Rvus=;
 b=oPG63mje+AaoSmCPE5h9SNZ9I47AHDOVVTYSSHNdPpCJKBLDE9saPG1qOlUmaGIu6s
 ML163U8blY2dsRx/pvJyUO9soE1Njk2owcGD65avQMGxWDzQkgi4lYNbmqegSUM/dDp4
 xfG/do9L3ZoxOnMOarf6n/O1qUQUMtflCfrOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721322804; x=1721927604;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xyz4oBZLIPbkYz582n4fTn+Rbd24cV3n3QH9P14Rvus=;
 b=DHvIRoX4s4EXVZrZDdf2CcvuG8PgLO8s9x7CdjkhSMxJXFPFDxPqXKQFguLQBsJOCz
 vpGt3zjL4kKBoQuyd2iWmhirLb1siL9hqm1n0Pkrka/TSTdC8RgKbi3ng4VPqNajDyb2
 RyPnpDO3gvrD5UWHLmmk15tV6q4u3YrgZSkYe5cPE31V+f1zY2fTRue01Gp4uT+4JeBx
 y/7qNAGYpSgxowRdmfPRAIUN9Xp12sxxKmDv3LngEOU0HbMivy2sVT2DHqA3nMhYf1cL
 ERcjOyH2JwWN8sdxqADsxUQ4WOLgB/S2K8DohmTW4wCbuLn+j9F9Dv+5lE5x21b++OsP
 R9rg==
X-Gm-Message-State: AOJu0YwK4MgXy4niPmZ4zCi4L1OjdwmMKZr7DBuNtBjhkB9X+rXT5BWf
 LoC7Ea3MJ5A32RftLcbOuPa8+ga8qK5HQqUomXhROBidhRpMcW4PLHiWEQVBugo=
X-Google-Smtp-Source: AGHT+IHzsPwaDLnC+JSwdgLbouKUjYxiUlXxFUwyqsQwmnsLjIKqGERB3hnxCI9Esxkq6TNm8UWKaQ==
X-Received: by 2002:a05:6871:153:b0:25e:1817:e4b7 with SMTP id
 586e51a60fabf-260d9504caemr4659896fac.38.1721322804472; 
 Thu, 18 Jul 2024 10:13:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-260ee584a56sm422664fac.7.2024.07.18.10.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 10:13:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io
In-Reply-To: <20240718-u-boot-fix-v6-10-upstream-build-v1-1-ebeb67ef773e@linaro.org>
References: <20240718-u-boot-fix-v6-10-upstream-build-v1-1-ebeb67ef773e@linaro.org>
Subject: Re: [PATCH] ARM: dts: remove leftover Amlogic GX/G12 bindings headers
Message-Id: <172132280380.1848517.3639926942922389573.b4-ty@konsulko.com>
Date: Thu, 18 Jul 2024 11:13:23 -0600
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

On Thu, 18 Jul 2024 10:28:37 +0200, Neil Armstrong wrote:

> Remove the leftover Amlogic GX/G12 bindings headers that
> maked the v6.10 upstream DT fail to build.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


