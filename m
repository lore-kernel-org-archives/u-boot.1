Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6422CAC592
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 22:06:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C29383236;
	Wed, 17 Sep 2025 00:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iEma0K/p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 056928318E; Wed, 17 Sep 2025 00:06:41 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAE50800D7
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 00:06:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-74526ca79c2so2356623a34.3
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 15:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758060396; x=1758665196; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypTJs+PER64bQrHSaPjE2Br/EAkAhRAvXPNfe+hovOo=;
 b=iEma0K/pSgbpLtoj3NCLhdibjQ/dwILwOoaNzcjduqMpdNqyguu9soaBzfxVAaZhZU
 HyBK2JL+6i4gNpZqbHwF+41YomzpafSb6badiHCDcvFglea5v4iWu0Q9tWppZdQ2agHY
 h1YWOZgQvj5Mjh536cX4kavRFCUfGfRoNDWI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758060396; x=1758665196;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ypTJs+PER64bQrHSaPjE2Br/EAkAhRAvXPNfe+hovOo=;
 b=hj2Y30MW3D7TC/4KpPDwOThypfp/30FY6Yey3WDFVdmb8qFOBko+wpfXv6MfeNgQsY
 H7US5IbKh3QkYIusDiZL4WSdTqxafDFwD/zsojKJjD9xz7UhRpfXtaGALn+2XMuo71O6
 vj6jx61D/CtvY4BfSDh+aKdb394KBU6H22ccKJLSHXaCY5EZOl05EKuXxueObDiN8mjo
 6AI/BSoHNVc43p08Fs0VT9EjgskLo39tqmKX+T5QJGmsIkHa5uNvkuvVpUbuyTDVL18/
 DqUVLb92tZYogLGNmwYkVMNo9xg/Gxv6WlgK+ceauC76Cusbhdy6AB+I6ncbMeB/5pvD
 scbw==
X-Gm-Message-State: AOJu0YzziUmVC2TNOZtt9cv1vAJjUT3C+yduLrakxFNt36KL6jy+T5nO
 0oOSWRd4VIzqMBhxUCn9XHW4fHNzmCT7lQ3MtkyuPzowRG64Rd4o1TUTggLZ32+6s+Alc9hJuO6
 kyGqcjy8=
X-Gm-Gg: ASbGncuRxsSEe2Zv1K+3XAwclgR1Lg9qwz+wjLqyv4BY8a3+WjfBMU0QGV4UMjEorzp
 nT2Fir07AiyeasReQE8Is1fXzcGl7Xi0b1koFoOg1WhUzzTW6NKiz5iYel99rFbbmMf47k18EKK
 47kJ+LppSIG7uVkdXaNB/uVffUsiO9YDwdvo8vhKNcEzcQD6erjQVRlOaOQY9KNo8Zgs9oKMZLI
 0VvTb11PAFf0FcC1fXQFRy3ZfJagj6aoHK29xl8nEC5LomTMBNBSyRGq4AxGJW0ukCzCVz8d35n
 +25FKZJxW+l3t0eAndYiw7l4qUdcYCMCjVw30adpQCU7bsdhea8Hd2hB8DaWTfcYczz5QuFfij/
 4yIM6XUox786+pP5abXmdnDFfCvlqqQnOT6HoM/a1/NlFyddRxNNynhMUjnODbFqrpoJYOvx+VE
 NN
X-Google-Smtp-Source: AGHT+IHkNzAkMCOrngs85+gQSTtKrTbAPXVHLBJKdrUknBO2zfWibLcQWraY93x1ia5mq9uiKGxUKw==
X-Received: by 2002:a05:6808:ec4:b0:43b:bcb:70e0 with SMTP id
 5614622812f47-43b8da50299mr8777302b6e.40.1758060396560; 
 Tue, 16 Sep 2025 15:06:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-43b82a72a48sm3500050b6e.20.2025.09.16.15.06.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 15:06:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aditya Dutt <duttaditya18@gmail.com>
Cc: Harald Welte <laforge@openmoko.org>, Asherah Connor <ashe@kivikakk.ee>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20250905140611.238951-1-duttaditya18@gmail.com>
References: <20250905140611.238951-1-duttaditya18@gmail.com>
Subject: Re: [PATCH] cmd: terminal: avoid serial_reinit_all() with
 DM_SERIAL enabled
Message-Id: <175806039529.649628.6873889159151246687.b4-ty@konsulko.com>
Date: Tue, 16 Sep 2025 16:06:35 -0600
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

On Fri, 05 Sep 2025 19:36:11 +0530, Aditya Dutt wrote:

> serial_reinit_all() is only available when CONFIG DM_SERIAL is disabled
> and CONFIG_SERIAL is enabled.
> 
> 

Applied to u-boot/next, thanks!

[1/1] cmd: terminal: avoid serial_reinit_all() with DM_SERIAL enabled
      commit: bbc9347a98c3fb32610d4324c9e0f6239f013143
-- 
Tom


