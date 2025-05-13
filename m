Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA3AC3ABC9
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 20:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB42C80AE0;
	Tue, 13 May 2025 22:03:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JYTET6CW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E23C81DD6; Tue, 13 May 2025 22:03:51 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77EED800C1
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 22:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3f7f7b70aebso4538907b6e.2
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 13:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747166628; x=1747771428; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=onROoGOw1WW9WYmO5QuQV3bcYO39/e4fN0uH/1pZvMA=;
 b=JYTET6CWZ5tsLqvPbzaev9m+plyn1r1+GbyyMqtzk+T8dfzxhssRAKVtBP1j0xJgF6
 6czQh1HN4F+2Dlpeni0YQwRkIdOHZ7mKn3LCBnyymPP6eZeaYMP/xxEqW9Pywra9O+ZP
 AYlmyJ/fNJfflgZAFpY1UykS2/hZjTp9aEio0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747166628; x=1747771428;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=onROoGOw1WW9WYmO5QuQV3bcYO39/e4fN0uH/1pZvMA=;
 b=Z7vYndAvEyJRcLoOY6mCbWWTqO412pqsE9lZ+vqUef8TQCDc/JaMW5I2KPmtc8PPvt
 KDdbR3O41FZqC+Btc9biszfrhDbCo1oMJubNysHmsfxABlIuDJkcHfgmtyGNXFR5n9nN
 XzAyKosJK6BnQ0VvPo+r0liWUQV1jVDOeKwG2oSuSt7NLbR3vzHQ8S8xENRj0Sz3Fxny
 nbz07e6Aa6OqpWz6lsvYWzNvl5erwBBYgjvm/4Mt+iKWJ0+w5lPoYef3NiDeMPITvw8Q
 zrsfJmySCNekk8BFkGrfLVoTJJogIlP8FwOF/8yFNr2+Aj7KpiEHtzo5fPId1KsY9JrU
 jCsw==
X-Gm-Message-State: AOJu0YymN55/pMkt81vsFvSh0jioiM4dwkTa/NkGeMgpJQKQWl6qxTDi
 eOw6gVIT/S0Sk8BCcQB5/lg6MnZFk6JwSY3BwcbAWylZq9XWNPTMwjtBoYmvEAc=
X-Gm-Gg: ASbGncuqt4+xsZM4m1p8M9OKwf4xaZslceV5lO4a2HZpaPOI7KRz4gFAjDmN/6Km29O
 1Akme9BE8dB5QlXwudEcNGmaXwxRm0CUWlCYF4cvBWOlEk7gvLv0YzweOzDTFjqfkGl8+Jlxvh5
 Dsb7JgLrz43IMxIwCAlsUBdkvJ3stwkQ4gr5z27/J1+X0lBqo6ykkmE/Rodqulk3luMAx9oxDi6
 Mf5BVPwaD18IHqfR1GxOznUSYe9WrFuxwoxeXSOogRlbTdKLcP7IXDyKExkUJXFW0yiliR6Vrob
 hHEu4BjXaCHKwMMgyPnoOcRAfZoasmwmMeYk0KpuVX0pWjd2vx6k/WPbLqAHPdrijpLtIJ6+TYY
 rx6qJPHIKJ0Q=
X-Google-Smtp-Source: AGHT+IGM2jQaPsD+Pxy7X7L9v+mcNpmWXBFBNUyTwizmxyHvweTjXChkBED86V6Mbgpr/zUZYurJbA==
X-Received: by 2002:a05:6808:3193:b0:401:e949:6374 with SMTP id
 5614622812f47-404c2003d2bmr629687b6e.16.1747166628066; 
 Tue, 13 May 2025 13:03:48 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-137-42.totalplay.net.
 [189.203.137.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-403802bd09fsm2095978b6e.2.2025.05.13.13.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 13:03:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250501164721.1494370-1-trini@konsulko.com>
References: <20250501164721.1494370-1-trini@konsulko.com>
Subject: Re: [PATCH 1/4] cmd/cat.c: Add missing include
Message-Id: <174716662684.2554302.18259800566694633940.b4-ty@konsulko.com>
Date: Tue, 13 May 2025 14:03:46 -0600
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

On Thu, 01 May 2025 10:47:18 -0600, Tom Rini wrote:

> This file references errno values and so needs to include
> <linux/errno.h>.
> 
> 

Applied to u-boot/next, thanks!

[1/4] cmd/cat.c: Add missing include
      commit: cfa00751b0516a3c8f4f432962a754fae4d551de
[2/4] ext4fs.c: Add missing include
      commit: 720e0c0f1a14f034df3cc960e0924b74b3ba4fe2
[3/4] fat.c: Add missing include
      commit: a367817c9a7f50b41a9f84e5a0818599e857739d
[4/4] fs.h: Switch to using rtc_def.h
      commit: 4c26de2eea6bcf5f27b13da0372d27d767cd38e3
-- 
Tom


