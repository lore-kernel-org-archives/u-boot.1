Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7927FC71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 19:17:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B65CC82B97;
	Thu, 12 Jun 2025 21:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lgVqliAJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C76DF82C8D; Thu, 12 Jun 2025 21:17:45 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A328E82B70
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 21:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7382ffcb373so682197a34.0
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749755862; x=1750360662; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JH51pHQGfMrEx/rkMqVgN9qfJbodnkkM84xK9AYDyFI=;
 b=lgVqliAJhvW/m8r9uNRtIHwEhAq7OaNwc9NK5S2l3ZZ8jQ+0c9nAq/K1RHM5vwHgeM
 Ulmef7OG6AT9kZg47Lahc03P4pNlpjMy4YB+bZIn7hn0cTnnKbi8HmuCuAp2qkjz6Aql
 IOapiRIXgM0T8Uzo+wJ3lrpqFpNZXaSQyeJJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749755862; x=1750360662;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JH51pHQGfMrEx/rkMqVgN9qfJbodnkkM84xK9AYDyFI=;
 b=krvmS5AzyYIzCLH52C6DPuvCi0UEaw5Zy2u4N3Y4wqg3+UjO6f5sqV4uKGPZaW2tB4
 e9hU1e5Wiq1BOWJkvm+wOiymg/i+zb1dzvs7sEMY0ZfL8Cpmg8g+L+wItuWSfO0jGbiZ
 Nml8bdhSPe95WkHT6MpUwczl8frQc8kpk2+5nj4UQW7E5hZLklPG5TveKRh/7H7NTEHm
 2/fKufQi6nG/VmpUE14mBh5aGCfES52EP5Gcxg1tdFjxY/x9d/6HcyVE6J2FWJAbU30E
 ZGc13KdeMXvUGIKv5Y6GHFfbjwecSv4uJutlTNevA/JxHyVNsZ4sT/wFedA8zKa8xwje
 lDnw==
X-Gm-Message-State: AOJu0YwYdLndBLVFUg/LRX2ycg063Njmchy4b98D51wOhF2Ex2CHvQ6O
 I0plwKg5r5HQoeSdBDRHhiEt1Wi4pcpkNwiU0zLxmOmTwLeSXCWSVWBJKrPXBU1Q0a4=
X-Gm-Gg: ASbGncujJJietWkfi2nL5DaWwFoOXd3DTCsxAnHtM39Dm3KQ0RQkziRewPXc7lxi9kr
 94jjvQLcTAZh/HZjXKWG2BJc0FlWG2jjV1cXElKJGi70VPokKZKC13znYKKJ8dDVX2avn/jwr/M
 oSNdA5LrTT7Bq35iVOOsa8FNu2VLLjxfzAyax1+x6+WD6iFLEcULOacpJoRaW/h+zjPqmy6PHKd
 4ccCeJ037kVqEPSGjJS/A3OAWCrXqHF2nM7MUT/d5vP/OoUzZjDCRR8p4862xPjRHYoeWh+Mfuj
 p4TTDapXasZqqCyk7RBVuTzzaBT5TPc90V+doQ9ZdnF5eUWvATztIkQMb/7YR+f1FUVZTECvxUX
 Wgo7xNZktehJMKeK5tifszAC9G/70u2d9
X-Google-Smtp-Source: AGHT+IGYvgTDlDE2TQE4DpPwvQ+nJtYcKVTqeR2+cSYe/uI+xEys1wozBcdoXPR0vb5BY+ZDJdHYqQ==
X-Received: by 2002:a9d:4044:0:b0:72a:1b3b:2384 with SMTP id
 46e09a7af769-73a271189fdmr12641a34.11.1749755862346; 
 Thu, 12 Jun 2025 12:17:42 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a16a57db6sm370695a34.17.2025.06.12.12.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 12:17:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 No generic patch CC mail please <noreply@example.com>, 
 No generic patch CC mail please <noreply@example.com>
In-Reply-To: <20250529141500.2123363-1-sjg@chromium.org>
References: <20250529141500.2123363-1-sjg@chromium.org>
Subject: Re: [PATCH 1/2] test/py: Use the correct fixture name in exception
 handler
Message-Id: <174975586130.346916.13939894462425565332.b4-ty@konsulko.com>
Date: Thu, 12 Jun 2025 13:17:41 -0600
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

On Thu, 29 May 2025 08:14:51 -0600, Simon Glass wrote:

> If a BootFail exception is thrown in a test, it is not handled
> correctly. Use the correct fixture variable 'ubman_fix' to resolve this.
> 
> 

Applied to u-boot/master, thanks!

[1/2] test/py: Use the correct fixture name in exception handler
      commit: ef82e45c2ef5278493576708d6aafd686ba77af9
[2/2] test/py: Correct handling of exceptions
      commit: 2ab10ed2399b0c1c790733884935c94ad65aa2a8
-- 
Tom


