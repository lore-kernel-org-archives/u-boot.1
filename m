Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC39D2CDE6
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 23:10:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71B3D84178;
	Fri,  5 Dec 2025 00:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IFvDAG8n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E12E84178; Fri,  5 Dec 2025 00:10:35 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 439D584144
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 00:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c765f41346so835310a34.3
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 15:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764889831; x=1765494631; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eWj9ps7wfz5yccxkBiknVeB/N/LLKHHKXABfD5xGGi8=;
 b=IFvDAG8nRUQ+tEVmmVGcUjF4Mjyidj7mELEmwymXX5v4W6xR64VaV1Lv6dRYXYanwt
 Y4s7R1QKFwy/yup2tYze0MwC5mKoExx2g3ueRqDFdIxYzKx/eZ008es7LRciksFWv4Dm
 QVyIijZMcJy/Le4edNmtXTtVVir0cst1ZVpMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764889831; x=1765494631;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eWj9ps7wfz5yccxkBiknVeB/N/LLKHHKXABfD5xGGi8=;
 b=e3mg7cXfstbck4h1VfXu4nHxM3Lte0BVbPMU7AzYpUFLljKKMKx/cLBf9O2WxEMWxZ
 kLVrTHxxQyCv9b3UIWF/mtsxBig+9WnTKnRfJH3iI0ASHWKv5B2CHz0mzwaJ+17kXHWQ
 z9vzuR3VictwJ0GQkVnSYjofrfFMaFjvyDaL2n+DBujpxhsTIA2RlT9j07DSBbgkHa+m
 5WermTBGhm37D+JEHd05FvuR4jmbaMJem0lh9Rgy6p87vLJDds5ueY9gL11hWxqN1Pw3
 EET2zR0JbwhUpYReYQGZ4EGhaXGLKl2YUZ7uYB3er8yrfpTljorB7kLaCZyMnKfWmyBN
 B1UQ==
X-Gm-Message-State: AOJu0Yzf1g1YIjhVX4k+L32Or9bC5nEEM2MqACJUKfOHI/z4CbTnHcGO
 PHy/4EFnXUREE96SQEBXpzgmby+EO0gP6W8tZC7UW/rIjZ9AWeh6QqlQWD1E/bRlL+Q=
X-Gm-Gg: ASbGncu9Ko6ccC4gDtpHnWUBAySZjM1ch0hSo/qq1w+cqxLc4LEoig718TmT3rByMe7
 iJ9VfQBOoHCsY4fuTUJcwGWU/SI4inCqf1orMZLViUoognHf6CJAZd/0xdpT11oDFcU4rG3yQkv
 ACWN0VDyTTNLosvFpOAD4BjpKfEuYEPtEiJEXXsNpCjdZTMukDGc9u69nbK7b/L76q3BjfXh5PI
 uPW6H++29Jbc5XcHnmqVO3BVZVMYLYYZQuKUeZnneacWrtxCfPjmgcDorvO/xROlLUBhN0M9UBz
 1CznsCV751cd6YfoVTBaYTACMyuOkr75T77pQxLR/qymw9qAeFoPpvLRwiD9svJtFvoD6g+OSld
 lBiazo24MQv4GMYq61Xe1M1LgRIyb4I4aOhVYW3uGG+0dtGiVHys9YdNftBViIKcG2FGau8ijqU
 rA34ePJc0EXPtoZWX1ogkeb2C/dO3fRELD64anODabAQb7d3GW
X-Google-Smtp-Source: AGHT+IGO/lMLR+Owg5xwrw9W5OyfQeppp3vOoch/obUtWTuGeU9KJ4SNh+kkcLH+uBxLxqOMOuv40Q==
X-Received: by 2002:a05:6830:828e:b0:7c9:599d:c538 with SMTP id
 46e09a7af769-7c9599dc8f8mr3455921a34.16.1764889831054; 
 Thu, 04 Dec 2025 15:10:31 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acfafeasm2360264a34.29.2025.12.04.15.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 15:10:30 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251119145514.843117-1-trini@konsulko.com>
References: <20251119145514.843117-1-trini@konsulko.com>
Subject: Re: [PATCH] arm: Remove remainder of zc5xxx board code
Message-Id: <176488983042.2091996.5007534049450191237.b4-ty@konsulko.com>
Date: Thu, 04 Dec 2025 17:10:30 -0600
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

On Wed, 19 Nov 2025 08:55:14 -0600, Tom Rini wrote:

> When these platforms were removed the common config header file was
> missed. Remove that now.
> 
> 

Applied to u-boot/next, thanks!

[1/1] arm: Remove remainder of zc5xxx board code
      commit: c200ebbb98a57d8715b95d6947e223bd6ff05563
-- 
Tom


