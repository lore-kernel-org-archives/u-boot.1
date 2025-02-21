Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11D2C021B5
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 17:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D18CB80FB9;
	Fri, 21 Feb 2025 18:38:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oJb15xIA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E651C80F67; Fri, 21 Feb 2025 18:38:23 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6273380FC6
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 18:38:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2212a930001so67412595ad.0
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 09:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740159497; x=1740764297; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gT99m1uD+CU+kv07L5wMx3OfTzv28lUm0bOcJDkX4Ug=;
 b=oJb15xIA/C2RICbQp1C03xXegBV11ZXT8zHSh6MvPBqqGfALROG2WAZ+yIsEhWlyqR
 99OMXNuhv21Yj6H6+6G5SQk24DewrY7H2s82ljWotDbGPvy+mluvoewpoafdf7beSuFY
 2CMUjQ56aETCLkrMVlgFN5J58DOIGkMihhFlk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740159497; x=1740764297;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gT99m1uD+CU+kv07L5wMx3OfTzv28lUm0bOcJDkX4Ug=;
 b=aYk5r6Aup4Mdw4OMQmW5C5gGvrimzaehQYF9c0j40Eq/Ygjb55pptMbpb56Dm94dFD
 /JbAlbjXNtg1uxZOYM1pqbyB4FKnfrF47CaMW2RY5+L+FT+gzN0YYBE+/HQtHaQlih+V
 4tZktWda41JsOe3yHKCTIV9gZIREE5RAZTqXDlajekejhWaBMhWREDWHf38nj6mUe/fT
 Kll3Wb+IBBOy0VVwmhO0DpMXpXsv0M1fk38psrS0EhqPEclmQJwIXPp4cmH5P+BNB0EM
 UfnMe6CwJpcQrrH0cflGjm5MT9h4kCJ5g9PnJ845/JseBn8lYB7hkvgDBBxCLshLUlsK
 h8Rg==
X-Gm-Message-State: AOJu0Yxh2eSAaNGwaqoM3iQi4GVRG9v4OrsjvsvwjIrfrWzksN0LIu9o
 gDPqSgxyA0oPWQBKvtX+wvRHcqFtySIx1KUifQKwboMY9wSCn+rwrvm7VM+At0M=
X-Gm-Gg: ASbGncuHUtX+y7yMtbfrnOpTLgURRH41n0kO0ZtmSdwYkXzBtdy7nq5cmzCrULE5NeM
 L2jPl4H0G/wAc6/eGNwR77tIJC6aAjKnEG7AvAow/3KL0P/KdZHZH2xsosOBhG3kB93xznTjj7S
 87sjqhbu6CF9mESE1TyaMnhQ3bTE3+sr9nIC+p06B/JBTp3NEk2nYdNzRLS9x0eJrFOmX918WM+
 j46fAnPzdbt1SGKvxtQicRQ+zNrR6IHMhacASzzeQcaWfX7FOd7m/jMjaSFSh7NDwCaEI9PpOFj
 BwU5H93FFizQvSQj6mmLxSQ=
X-Google-Smtp-Source: AGHT+IGAB7Ng6YHu/qpM9WFTY+fvjTqFW/+hpSImAFxAOIvPIuMT4Pl969UesUP/Tvz2Tz0KGAAnEA==
X-Received: by 2002:a05:6a21:6f8b:b0:1ee:e4f0:62a with SMTP id
 adf61e73a8af0-1eef52fa8e2mr7553105637.20.1740159496982; 
 Fri, 21 Feb 2025 09:38:16 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-adec4756d0csm8792554a12.55.2025.02.21.09.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 09:38:16 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Alexander Kochetkov <al.kochet@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>, 
 Michael Walle <mwalle@kernel.org>, Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20250219151118.2345297-1-sjg@chromium.org>
References: <20250219151118.2345297-1-sjg@chromium.org>
Subject: Re: [PATCH] tools: Fix pylint 3.3.4 errors
Message-Id: <174015949568.3526942.17281325588707531702.b4-ty@konsulko.com>
Date: Fri, 21 Feb 2025 11:38:15 -0600
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

On Wed, 19 Feb 2025 08:11:16 -0700, Simon Glass wrote:

> This newer pylint produces errors about variables possibly being used
> before being set. Adjust the code to pass these checks.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


