Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA66C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 03:41:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD5C188595;
	Thu, 18 Apr 2024 05:40:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZXE91++3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83BDA8857B; Thu, 18 Apr 2024 05:40:22 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3A1B884F1
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 05:40:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-78f03917484so24372685a.3
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 20:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713411618; x=1714016418; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dyk9RL81AdrXPDHeE+UctPqIAK36F3vmw9O3UeCipNU=;
 b=ZXE91++3j87CFzanYuroJjzDzUfyYmx6WFlj8utoEI733WLGl5xY27emWlv6hLVsK4
 OC6If0DBaqwYblyk9oHg5ZU/Y2Fl9H1SyjhKVe2NxiDBid/jbrH7yRhfJOW8u9wVXpYM
 8cY2V0JhI0lY11KQdTzAJmaVA+P7gf363iS5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713411618; x=1714016418;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dyk9RL81AdrXPDHeE+UctPqIAK36F3vmw9O3UeCipNU=;
 b=iaWKiF4zDOFS5OaT/9gMTqKy0/LxoDDgwyluxMLmhy6ajll1p7hyHW1uYIq3LZ5nTt
 4MVbwisf7dORdrdH2W/KltmdNlrb2QiWpV+DjMPbAAOLYOndSz6cxRBiyEAIE0OVrojV
 EgsQ4qbscgtm8bpij9PSu5by08QbHyDzq80ARtYjUuTfOu/Nm57GkaC9aeQdARn5NarG
 OMiRS28pxULzTTOTQQRQ1nL1FCPNIYwpfiUOAlTAr4rMyEOeHpu5AmenbWQtsRiQ6vxr
 YACtZ2vRFd2riBkgTXZtbabpXMvQLMTtXBCOJAjoYSDqKn3A8MDYYDPKmVdY5SKck46t
 8e9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2ybV6rEFDhxx9FGa1CuqOqSNSlEp052SeJQS9Hr85nSAwB0NJjE6+3MuiaPIIQJ+cLHV/d3nsFDEUEXgB6//eccPDuQ==
X-Gm-Message-State: AOJu0YzSLVYFL7jO5n7FhmsLHS8C7rkN2jcWb3rA99SV6f8zN+WKf5tV
 CWygRm1uJxgKOhsoI0iHeLkOEHgz1oEgWyUjn3LpqZh5vS6nN3G+vWEXPA31d34=
X-Google-Smtp-Source: AGHT+IHXeFo7odMNIq1aAYv3YsjA5dZTSayMil1Bdl4erdBQQmKFjuJwz+xF/zjjmLvbfznehj2B9A==
X-Received: by 2002:a05:620a:a4f:b0:78d:7368:3c7a with SMTP id
 j15-20020a05620a0a4f00b0078d73683c7amr1525682qka.35.1713411618421; 
 Wed, 17 Apr 2024 20:40:18 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 du33-20020a05620a47e100b0078d68b23254sm259041qkb.107.2024.04.17.20.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 20:40:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>
Cc: Jon Humphreys <j-humphreys@ti.com>, u-boot@lists.denx.de
In-Reply-To: <20240410183834.153876-1-afd@ti.com>
References: <20240410183834.153876-1-afd@ti.com>
Subject: Re: [PATCH] arm: mach-k3: security: Lower verbosity of cert
 message for GP
Message-Id: <171341161727.1250683.8632416614018403206.b4-ty@konsulko.com>
Date: Wed, 17 Apr 2024 21:40:17 -0600
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

On Wed, 10 Apr 2024 13:38:34 -0500, Andrew Davis wrote:

> When we find a certificate on an image to be booted on a GP device we
> print out a message explaining that the certificate is being skipped.
> This message is rather long and is printed for every image. Shorten
> the message and make the long version into a debug message.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


