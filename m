Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44ADC28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 19:43:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBDCC81782;
	Wed, 12 Mar 2025 20:43:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gCr6W4f0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC2B3817D3; Wed, 12 Mar 2025 20:43:32 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9237980756
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 20:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7c07cd527e4so12359385a.3
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 12:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741808609; x=1742413409; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DkHFZ3pq4TP6DfdFh0OufWeLz9SfnyZrhh6hwailPgc=;
 b=gCr6W4f0JvBS5oVW50nAH/Trd9v7wfVH65jT/oDD2QxOM8qsk1lq7EByLq6S2DF883
 WEW8JSGS8uQq1q1P6y2fp6U844Tn9hw25ZoBNKQTuChYrwRZtL3ivGRjfWJvzS8NoicS
 o/21nQpTHo2Hl3HrpyJb05GWf3jJrpNUGD8pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741808609; x=1742413409;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DkHFZ3pq4TP6DfdFh0OufWeLz9SfnyZrhh6hwailPgc=;
 b=VfaxAyuWLLHbvKN2nmIuo5K6yuWeviJi+jMQgIwUY4EXLH/tXuC2DFY7r3FwnNE6ty
 5w8g/+v/yisP3jjG6jUECxV3uK0PvguOISihj2xg4wh48hkMczntbByGPrm5/z5rfGY1
 72N8tBU1n+btCPJ7QMERSd/hTd0/sWD0XsfGaMEdzNry+RwjF+bsgPQ2Jif+RkbQVMR9
 lvmM0PD55Kx/QGXyZznFmgGGp/NmHqCxwlkGGBGiVIuV7jIhBAmKo3DrGrtRrZECzSRk
 YCjzq09IRk98Ow3fXCl1tR+Rp/XwYoICwkcQxPJw/rNUMNY6x6Dt9fLS3cYAAH9yPcRL
 Xaxw==
X-Gm-Message-State: AOJu0YyNGFIwvorKFQj6kVccm+aXRAQlpQ1wukWjeSae2hdvsMBR99i5
 NhfukNwSwP4/JBW1jutZ51+i3k/OniQWgzBHXZYI+7JIhWqY9SlOihnmi8D/nnAA6wRCO4rQYV+
 B
X-Gm-Gg: ASbGnctrcw1OZLjD3X8dpMesKElKsCRK1Zc2Gp7Cr4IgEelDNYSNZDTfw8gN4Tnsm6k
 CShhSKNPQbJ/eh45Ym4I0afzxBrWvIsTJCyUjDYIp6cD+t60e/nBCwPbIUbNfJDZW3mRDGcKu1g
 hqTogT0vLONXM40kVcw7mhBCobRE0wjTyz110Jvd9/JGhYYTK+RbxzO0J0+w/dbBDqFZ8zgJKjw
 0/9/urETgeyco6DQpzUMeD2CSCi5CcxJAKk7yfOuC59VOtkLGPj1OckWQVZr3ixUDsAdsJS6yOy
 6t9+cCSJrxD1pquoc6qKQSGC9m/e38YNKK8j6xnBI5YvYBAW87mXc9o=
X-Google-Smtp-Source: AGHT+IGpbOLCJkkC345gO65wMqnfDfhftuzI18CbHV1nNJcQoylQGsfH48LhiV/Bf87b0gfr28PaVw==
X-Received: by 2002:a05:620a:800c:b0:7c5:59a6:bae9 with SMTP id
 af79cd13be357-7c55e83c908mr1678452985a.7.1741808609466; 
 Wed, 12 Mar 2025 12:43:29 -0700 (PDT)
Received: from [127.0.1.1] ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c5491fd795sm630841285a.110.2025.03.12.12.43.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 12:43:28 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Leonard Anderweit <l.anderweit@phytec.de>
Cc: Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Marek Vasut <marex@denx.de>, 
 Tim Harvey <tharvey@gateworks.com>, upstream@lists.phytec.de
In-Reply-To: <20250226210501.72794-1-l.anderweit@phytec.de>
References: <20250226210501.72794-1-l.anderweit@phytec.de>
Subject: Re: [PATCH v2 1/3] binman: build_from_git: Add argument specifying
 branch
Message-Id: <174180860769.1757127.15880186718492002267.b4-ty@konsulko.com>
Date: Wed, 12 Mar 2025 13:43:27 -0600
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

On Wed, 26 Feb 2025 22:04:59 +0100, Leonard Anderweit wrote:

> Add optional argument git_branch to build_from_git. The new argument
> allows specifying which branch of the repo to use.
> 
> 

Applied to u-boot/next, thanks!

[1/3] binman: build_from_git: Add argument specifying branch
      commit: 5f2096d2bc58ac265110777d08673a0e4b27cd84
[2/3] binman: build_from_git: Add optional make path inside git repo
      commit: b48bc416206788da990c34ddcf92d5c3816247ea
[3/3] binman: cst: Build from source
      commit: 326b7ea9823a74a83b3a7ef6ee3f4927eb36987e
-- 
Tom


