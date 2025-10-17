Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE0BCCD183
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 01:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0732983710;
	Fri, 17 Oct 2025 03:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LEUhS7UF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22EB0837E4; Fri, 17 Oct 2025 03:24:00 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0CF383700
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 03:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-443a2689160so431912b6e.0
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 18:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760664236; x=1761269036; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uP5DosyP4+v3mWNWHAk+AQ2gY8PIq5XiDMHn6fVB0DI=;
 b=LEUhS7UFsC3UUg0fCvfUM1FbYen8h3k8IdbHWX3j4PMbwvl2MQrpaOaW7+d0gRf1Nh
 R3Wg0qa7y3QKGIlErF4AuMjPneKOYHF4Qh/Hb7G32uH0QUBvHq+UzGlybaT5sHL8PMXn
 JWD5/beYhGZJl/XLzHgulDgh5kSh9o3biWIqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760664236; x=1761269036;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uP5DosyP4+v3mWNWHAk+AQ2gY8PIq5XiDMHn6fVB0DI=;
 b=GxF9nToHTKsCr78UG5Uk7AThG1idzGc6HgSCzcDve2AoDxet1z4SrwvvsoWN+9ZNba
 nJVTjt9kAzcuOmM5DcaIEAmQCHUywzBYxmuNfpfTG7X5ll8V7X+s/PwznapVyOMLdBkN
 lTOQtxi+uQkRz1ij05ce88sGr+QAd02pVdgXwC44UTZnqCutBTkmPJVO+GiNEsKqRU1Y
 syMIxkGvY88GaUywBgtdmYuz/2ucL0CINJZW5yMSLakux8x1wk/aYx5rIwBAdWITBUfz
 DNbAKpbndBUlZXTnJOOvpRSTCARi3CYMwDw9u82OyHXAIx13Aw1BI4YJdyamqhZW+8/E
 TIyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3GqG0gMqqS+RVVl5nNCiK+H9jXJVJ8EXRtmhQWg2F1Exg79pnlfLhm9WB3SxDaq+uKjC9m/U=@lists.denx.de
X-Gm-Message-State: AOJu0Yztm4xxTHTY+d/sa1BZZtpNuy0EscHX8x20BP24R+v1HMN068L+
 QDBo5dQ4fYePsEykMC7KG98DgNqXqcMNNTEUpm3iY6GKdugDnOysiRLMJVLQuj3j25Q=
X-Gm-Gg: ASbGncs5LgSPouJfcfZGmnAIVw8r4Lw5jzLtNkSF2DGfep/3ulARwl9dA+My129rGG9
 ulUMUQAbKvc0rAoVu4NRH9ZXEQ0nN+IxV31xpHa/hs6PchhuuMsEEAfrFsH7LS6WXGovQXmo362
 7vfSJXh5uycxpyK2vyUGpK3fIBTNHoO+CsnFY2vvfBOC0VM5N0eVrKmKGSZ8t5FSGLSjG5PwQ38
 aY5F4sIdED0lsL09AuoaEa9h6UrwYk5aDa4IHLzV9p5C9pLKJJL2tsiJn0qzHDeiWvNiGw/oZYX
 w6Lubi2P65SkuIkdGqMkaHPNt9gOcQACQmJYX/pKcDrC1W+U9aM/Dcy2qej+0kYscEAXQzYVH/g
 7P9iJZzr66e6r0+W917Ddka21ttMf3kY5n7pHx9H6DrPnGx8P/jUPZ01tkLT9CKNulxLix+fiU0
 B0xM09eyv+l159rCyHReoBrm9hqwfpFg9JaJIZRUWRW+GTBkIE
X-Google-Smtp-Source: AGHT+IHUeYebObAjfM3AcN1d5w8RZJppteq2kqhZIhrpOee9N28eF3Ex2R8Llt7UEEAHGVWLb2yHrw==
X-Received: by 2002:a05:6808:181c:b0:442:5c0:b50e with SMTP id
 5614622812f47-443a305dac8mr1010898b6e.45.1760664236655; 
 Thu, 16 Oct 2025 18:23:56 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65018130f87sm5157512eaf.3.2025.10.16.18.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 18:23:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
In-Reply-To: <20251010202926.2603488-1-heinrich.schuchardt@canonical.com>
References: <20251010202926.2603488-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] test: uninstall PK after secboot tests
Message-Id: <176066423538.298873.4074966290884280703.b4-ty@konsulko.com>
Date: Thu, 16 Oct 2025 19:23:55 -0600
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

On Fri, 10 Oct 2025 22:29:26 +0200, Heinrich Schuchardt wrote:

> The EFI secure boot tests install a security data base.
> Other EFI tests assume that secure boot is not enabled.
> Add the missing tear-down at the end of each secboot test sequence.
> 
> 

Applied to u-boot/master, thanks!

[1/1] test: uninstall PK after secboot tests
      commit: ede1186f2094f5709f4c4cd081a388873680139d
-- 
Tom


