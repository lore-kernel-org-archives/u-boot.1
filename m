Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1E9CAC582
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 22:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE9C983214;
	Wed, 10 Sep 2025 00:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CAEb1VGi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FEA3831BE; Wed, 10 Sep 2025 00:57:43 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22B8B831A4
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 00:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-88776dcac7aso89476539f.1
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 15:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757458659; x=1758063459; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5XCXgK4Be9SePxaV/RrOy+ZtjEG6cJiCFRsiWTkQp28=;
 b=CAEb1VGiS511lHjsZmhSNMtQo9GlsOc7lEAuS1jnHNUPE3pHwBN5nsNwDfEN+k4RMK
 oy6RYXrTmIOnec4stATinRtyYiIX1d4Bhu69dm/ZNeq6UjBGii6Hpg0X7xVsTAxlAs3E
 QLJqvmKwFPeeu4U2ge1SBwE6zseo87qt+4soU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757458659; x=1758063459;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5XCXgK4Be9SePxaV/RrOy+ZtjEG6cJiCFRsiWTkQp28=;
 b=P2tJPq0JJpQtNNosBDtmxJbas22eU6geirdmPubdWRaLiXt1JcA7dAUgteh0NSaMNn
 ljlk7zIGenhEPt+z98c7LdHSZQF37s6+dBfDBAOcX+pYaXwtSftA4k7PYYpUO1SXecPR
 OIzTI9PbHd1/fuxO2jGGdiRett0Mlpo9tPNZiSUqOk8ffJsL+VNOJhLg8zN9X+mjZ+t3
 V8cPvlGgbCNd7/pSA/CfYmd/raEg/fgKU1jCTXvQfzJl0jrAsJsBmAvVeB6Bwc5pDPpl
 HlTFSF0s3G4VkyrycqJkWgJ/IWZBxFe/5jzQk2wJeltXxbkHAohmgvngBWvpkyG5iCZR
 rWsA==
X-Gm-Message-State: AOJu0YzImux8u7HCqxgafHb+agOBViXafWcoVRluQF021Iuu8RpOXTll
 DWRfnQcW88TCHA31Bcjj7ZUQSZTLhzxcTu/oILrtM8bZZUSvkHeZvP/jc/4CA4CZVG8=
X-Gm-Gg: ASbGncuoijVyQ3e+D9LjVIpJ/Wy1V3Tw1kHbNgB4rKlJSMyaWO8hlLn2Eq26T9ZNWxN
 blMk2qBZsnTpXN6NT9DT9ykHZHH0O9wAn+JdKK9XdlxcH5b73BCwveGq32felgB7qy4t2vqRkFm
 CWL6Du9DIaJ1zotNknuYV+50WCMHR5I6PfoHxAuLyyoASFjTQm8uWaYpd1D4+zxgqkTbC8Yygou
 sNdQqHbxnidDHpelR3ZDwmZoocKAdN5KqUQIQQuQX4cG1Rdng4Z64h2c87oC6N3xiK6pt4JgBhK
 jW9ygJd0Ym4Cdl+bjboEOuliu5TcBVwp5RzxjQqS1Zv89KxaNzLroWF/2W/MccNOUN83rUCnU7e
 w/PrJgLNI1eVFGzE9baflDTv/b3ZrYSaZDD5aZAPtHzBu3UEgWS9aq6Ih1DZx79SeVw==
X-Google-Smtp-Source: AGHT+IE1zBgBZZAAU6bsS81qyOcmzQz+hepKmI5GYyXGFNVm8oPBR9oBfuA1c3Tio5Hx+GctXYRC8A==
X-Received: by 2002:a05:6602:6b8b:b0:884:477c:b4ca with SMTP id
 ca18e2360f4ac-887774d9c70mr2059795739f.3.1757458658810; 
 Tue, 09 Sep 2025 15:57:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-88c31dee466sm195844039f.7.2025.09.09.15.57.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 15:57:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20250903142245.90689-1-marek.vasut+renesas@mailbox.org>
References: <20250903142245.90689-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] env: Fix up indent
Message-Id: <175745865734.1836956.12416722573331603889.b4-ty@konsulko.com>
Date: Tue, 09 Sep 2025 16:57:37 -0600
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

On Wed, 03 Sep 2025 16:22:26 +0200, Marek Vasut wrote:

> Replace #define<TAB> with #define<space> to be consistent in
> the entire file. No functional change.
> 
> 

Applied to u-boot/next, thanks!

[1/1] env: Fix up indent
      commit: c9d4e82670ec4e4bab5681710de4240a3fb42fe8
-- 
Tom


