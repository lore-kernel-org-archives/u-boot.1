Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090DCE7716A
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 03:56:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E99B801FB;
	Tue, 17 Dec 2024 04:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LH/L1LqQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7B4C800D2; Tue, 17 Dec 2024 04:56:45 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BFA2801CE
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 04:56:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-46741855f9bso42024401cf.2
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 19:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734407802; x=1735012602; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1fcQzUUVisONrlGH+T8IOTaGAN8Gt6CL4JQMRlnoWnU=;
 b=LH/L1LqQLD0fZjzT9vXBgkW5KRsW8Q2GAFvEI5x4ldaHeicrF4psB8gLCi2IhX64Kn
 54jgEV67yYy5Upu7GDSJyPe+vA6j8H0hIEF/Sqq8lCAeqVQRzzZ/24Xh87bWEhZU4v1R
 iuPq4TrIVgQ+fRQVPt4iEYCbp5Y9alpHsere8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734407802; x=1735012602;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1fcQzUUVisONrlGH+T8IOTaGAN8Gt6CL4JQMRlnoWnU=;
 b=A35LLQoWl5rRv/s4WnCtwlrYJNvvGlxiowovtMHGBtmnnWzJ4s2REOOJKbj7Alzx9H
 mjwUYHvQ41XlqOI6ln2etJXLBGECA1vDOKnvVh42++bDNxDgHHQLXT6uaYMya1CLd1J1
 SVpZgtAU3ZVggTwnKqZGAqWlapo0DJkGnfpN9Z6yrMht2p+h9bIZAx8CACmEb+rlBZ2L
 /Ug7FzYZ/729Izq4m5kmnJR5xyLGMmmts2YXc27SsnQ1NvpYb2jku5jV8l1llBjARiTy
 TcjloS15iaXdAjvgLuCGHjzHpYHP2QyWwNMYAi0vd1iIuWhDldZq85JyBao0niaOtZBt
 uOdQ==
X-Gm-Message-State: AOJu0YyiNhXcPF9nLXgFIKZhUGPoth2Pu633QMZGIQ+k4WJdHq4iPQWf
 yQI3j2ZnOwhMlsbbXq1wu5S4xDc5cRz1uGJ6oF3GCrwTWbKnK5oOJk0UC48b/VU=
X-Gm-Gg: ASbGnctbEodHmPSKBjBP7sopWvQ9V2GapdGO1MGnBrG8autzAzijJF228gb1NMCczRX
 Y1IpXhdLi5i3GeFq7s+zPT6ZkMQHfU8pjTEm8EpzkmHTK9IH6Q7fV35Vyv9NGlicZQU3So33w9v
 070ceu3P5ogG8HSX8E9Aj7tbRrKUOuYUTzjIgj/weHML/3D2hbq5pd0kayCZl+rSAvQBw1EXyxX
 vxbaJ78k0GOpKzVxqqIhS6X+MPwXzwmuFJEyX4os9nH+BTEgf3Crn8=
X-Google-Smtp-Source: AGHT+IHvUM/s5nVSdkqGEXAVKWfomC859BlTpwLFErMISA59raILhf+Kav6b7UpdHFFG1NP9XQ2KCg==
X-Received: by 2002:a05:622a:4cd:b0:467:8836:e003 with SMTP id
 d75a77b69052e-467a583c26bmr287336611cf.41.1734407802252; 
 Mon, 16 Dec 2024 19:56:42 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467b2eccbdbsm34330301cf.84.2024.12.16.19.56.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 19:56:40 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Thierry Reding <treding@nvidia.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20241213145319.10956-1-clamor95@gmail.com>
References: <20241213145319.10956-1-clamor95@gmail.com>
Subject: Re: [PATCH v3 0/2] Tegra: fix clock init
Message-Id: <173440779981.3114554.13264372727574991804.b4-ty@konsulko.com>
Date: Mon, 16 Dec 2024 21:56:39 -0600
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

On Fri, 13 Dec 2024 16:53:17 +0200, Svyatoslav Ryhel wrote:

> This should fix https://lore.kernel.org/all/20241201164810.GT3600562@bill-the-cat/T/#m2b62b471fd37e4c9725c98547e2a919cf11db5e5
> 

Applied to u-boot/master, thanks!

-- 
Tom


