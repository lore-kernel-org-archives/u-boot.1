Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC06C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 02:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 252FA88225;
	Fri, 12 Apr 2024 04:12:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lEOQ9qrt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 617D288225; Fri, 12 Apr 2024 04:12:50 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B2B088229
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 04:12:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-78d743f3654so32063385a.0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 19:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712887966; x=1713492766; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x9XaF2bkr7HmlSgZ8AYTTyWH+dPT0bFi5w6GCJD7VHU=;
 b=lEOQ9qrtmvAY/DKC9+6+UXHSTJxCLx8ny0kZ9jXTh8AiEdyqhpFjoO/1awA46Ng++P
 aY7H/o1sK2pDg44Vr4j9l9mKreSZKGtURRRmeG3584oclMjRBNSiVz47qIQeJGWiUY7s
 u5q5WtCJKtt6i0LrQUbBR9sNRpvLWQAJACauM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712887966; x=1713492766;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x9XaF2bkr7HmlSgZ8AYTTyWH+dPT0bFi5w6GCJD7VHU=;
 b=eax+9JLYcdDglS/ZwZSMwO/HHesBk8A4jED0FVgsjQ7XdzLDPOTFLL5HPcjAiuwqCO
 Sfn8uL0mxoCSWT/n/Aa5SARsMrv+a4uaTn29EZVf777bkW8gBBRYjWq/1P6+SPLb12eq
 oknKZuNH7EP+9XAqyS1Zi+1MtnfA1vBpL/YWpxePleYu0ZGU1tSqo8ObZbo2UcOCqsIB
 G+AHbKyzpkUJm5N7XnnCvEx5CjmHogfSHibawVhJn7qWd9SSufCVST43kOjl8eO2Smet
 KyuVQPsisR/jLO/Xe67KRSKQfkNzRD015zvMOxnba0iNL2LqYXHtQw+HxO5vBvdzihtt
 1cJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ2KW9e3Stcwb/ffXj/Bzfhvl6fWMOpsij0fBm2l+yyTIWhy/EZCTDKYuFDrkqWVWqRgqWWNCxwIAATDtQAp4dostVLg==
X-Gm-Message-State: AOJu0YxDpskuO7d3BXgavSthmO+4pYyuWfa0K0Pt+0Tqcrr9Rx6OM9D2
 eS+mcB83It0jiP7gokPeNFNzSh+i7tN6H1+A+CtkvOVBI3F4P+c39uclRX9OVpo=
X-Google-Smtp-Source: AGHT+IEGc7oNOpsVCZ4Hy0cqvQRGRLMzXkiiXu0BOgB2bmWYqaKyfxBMXTbM+or8ZvX4Wle/6KX6Rw==
X-Received: by 2002:a37:e205:0:b0:78d:632e:be98 with SMTP id
 g5-20020a37e205000000b0078d632ebe98mr1391289qki.58.1712887966549; 
 Thu, 11 Apr 2024 19:12:46 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 g13-20020a05620a108d00b0078ec439a9a7sm1348922qkk.62.2024.04.11.19.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 19:12:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Michael Walle <mwalle@kernel.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, u-boot@lists.denx.de
In-Reply-To: <20240403143155.3995102-1-mwalle@kernel.org>
References: <20240403143155.3995102-1-mwalle@kernel.org>
Subject: Re: [PATCH] net: ti: am65-cpsw: Fix buffer overflow
Message-Id: <171288796555.897536.12800268327722881164.b4-ty@konsulko.com>
Date: Thu, 11 Apr 2024 20:12:45 -0600
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

On Wed, 03 Apr 2024 16:31:55 +0200, Michael Walle wrote:

> The device name is a concatenation of the device node name of the cpsw
> device and of the device node name of the port. In my case that is
> 
>   ethernet@8000000
>   port@1
> 
> First the buffer is really too small, but more importantly, there is no
> boundary check. Use snprintf() and increase the buffer size.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


