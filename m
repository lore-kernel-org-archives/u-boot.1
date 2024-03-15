Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A26AC54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 12:19:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5883987FBC;
	Fri, 15 Mar 2024 13:19:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NzzF5oKK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2F8C87FDB; Fri, 15 Mar 2024 13:19:16 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F53E87FC2
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 13:19:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6e50e8dcc72so1042859a34.3
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 05:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710505153; x=1711109953; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cHTyvKoMjnpLk0hZPjOkP6xOMIz+2bn6OGF9bqIFQTM=;
 b=NzzF5oKK7qp94o/sESRqzngkQC+ONlgweH6Q3h7C4eAAl7PPyrfFiylSPVdDEH0izn
 itM7pNI4NLfIV+kwW4FHNPTVjZviapaI1IiXPqxJz+glVfAMRDXGHHIgxrRP7tWNpwfI
 K2RWi39ON5lI3cextK9iTpQmSGn0jJHTFKVpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710505153; x=1711109953;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cHTyvKoMjnpLk0hZPjOkP6xOMIz+2bn6OGF9bqIFQTM=;
 b=SGVSytguosaRk05sKKvPvy9Sj0/2m3xTNFQ5j9pfYM7GyLAUhCT8aybQ36mNZKs6rX
 LAn2BROeR/rfjg7dDWsFq/PL86zODklJEymv1Wk9atlmorK/YHB30PqWrrVU59GRcFZ9
 e78BnCD2+xYHRaNci7nnJTS+lYNXEH/oCASdoEeASuS3lG+po71vKtQ9pfzq3gsLPDEV
 aJTjZAoPCy2+QvLgYf/itVbU3ghTlSdC+cR8dlKSrCfszSppc2McinyYmziCKg+2VY9x
 hx/PGBES5EuX8HjJys1YmkCUQu/wD0aiUdd3Xnxy1wynjnWVzEB45iwZaggMLukIg8E/
 xk8A==
X-Gm-Message-State: AOJu0YwGpj6OlQju2C/IQRLz6XGU8q30rXDh+S1j6HmctQj0FX9LhZdL
 W/5FAuDFPvQtZkOejgJTVB53kAUp0OfJUx/XlmeLWsSn6mmyhjz0l1GGTF+IzKormbcDMNBtTlJ
 7
X-Google-Smtp-Source: AGHT+IEOw6tNUwK3lt3TUhhubyt1NLsuHY0X4lQyNmSJUL/IHKU789mLLU+LJqSHoSG9demqzOIrBw==
X-Received: by 2002:a05:6871:146:b0:221:9635:da6d with SMTP id
 z6-20020a056871014600b002219635da6dmr5252173oab.47.1710505152824; 
 Fri, 15 Mar 2024 05:19:12 -0700 (PDT)
Received: from [127.0.1.1]
 (2603-6081-7b00-007f-0000-0000-0000-1004.res6.spectrum.com.
 [2603:6081:7b00:7f::1004]) by smtp.gmail.com with ESMTPSA id
 vu24-20020a05620a561800b0078874565b40sm2009011qkn.30.2024.03.15.05.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 05:19:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240310195928.730127-1-trini@konsulko.com>
References: <20240310195928.730127-1-trini@konsulko.com>
Subject: Re: [PATCH] CI: Update to using clang-17
Message-Id: <171050515215.774434.6230475594421565835.b4-ty@konsulko.com>
Date: Fri, 15 Mar 2024 08:19:12 -0400
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

On Sun, 10 Mar 2024 15:59:28 -0400, Tom Rini wrote:

> Currently, llvm-17 is the stable release. Update our container and CI to
> fetch and use that.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


