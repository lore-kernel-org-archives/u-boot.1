Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A56C7EE31
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 08:09:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32B6382F03;
	Fri, 27 Jun 2025 10:09:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kBvCeiz9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0D9182B34; Fri, 27 Jun 2025 09:26:32 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F87682E35
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 09:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=liujianfeng1994@gmail.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b34b770868dso240395a12.2
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 00:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751009189; x=1751613989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AEjslB02Lq1jKLNExD8eobXcpyPRED0fiHM6wK35LqA=;
 b=kBvCeiz91112uGFQSyOkXTKzHXowApHp9BR3OWp4+OcvB3nxu7FlMq93vvNwRXZH3u
 AxrHVkJYl9QqpCIpN4r7JolGwTOFXTboIdYRXfPed6x/Tx7y4b4edDQirK3qNTkbpjjb
 zKxgn4Gx13UNazxP+v0twvcvrj/ywYt7mDuWYQk1N168aG4IEZS7YZJpLtAacif8KTi9
 x5Za18kAKDOLQCrWZkgrz/eOKhdWlYE4SSOK2vMgfCxSsaYcud7oLUFu6Rk7YMRrCCfd
 b5auF6XZMu4+r4pp8pnn+T8vFP3cx5vAHPvi17Vg/4I5bt3K6svMnSo75XVmmRAoOvz6
 nKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751009189; x=1751613989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AEjslB02Lq1jKLNExD8eobXcpyPRED0fiHM6wK35LqA=;
 b=q1CgF2J7Y7flG2Lu3mdLHciVym9Iz//rmijhODOg6Db0BEpHtvBHu54UjL4OmkzIFO
 AcdrnpV7oJmrxKv5Q5r+2z7DhYwJpwdMCoSFLqAGW56yFNGxS5JZHxMcSf9CI1yi2JO6
 F1Twqizix/RJ1z38LvTgIxHFArEvRgcqARbjzfDdV8shdevGYDF7nX7IUPChzb3Vg9Sx
 4OoPEFDin81WjOc3HOHB9SgxAfgX5glJvxYG4UKEGSC0OQdY5j9W/1b+Ar+dwHYgWfNu
 c+bUl4QHfZ2jVMgIwbg4AxZ+59rJMjdg/6fnQFFCxOyy+iZjMhyvlNPpZ+aEHPE9Ekhl
 psXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBTVEiY2ZNAg+VIjQ8zZ3U+/CFmQj0fTXuQYo+YSzGjACuhv39OJpoFjweSb6DIBp+8TV72mA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2FuJ/+n1Q26NVJUak83fSaPl6tXy6BLyNzqkokGE0fu0xV0ED
 0chy6dpnRrjqK/fQobIIgzVhe/i5Hbp+kdmE4PenDxYSlF30eA7nJ1yA
X-Gm-Gg: ASbGncuyMTfVHgiYXZ9ZX6C+2m3xPzjt/IWR+Zg+qNFauf+frCYs4Q0COt/ePRnD1pM
 3sm4gEQINV6CORuHzAT0tH453x7lMZpzhJNDmRx0taWkcAz6zcdN7gRWIskHnngXPjBGPatEXXy
 gb1klNizw9n+EsrDB2WGvsPWDFzdThUS2uB3dZ5dZiZ7wxXpfma+MRH++JHsmmrAWbiqHCPwbYC
 rnxyuY635NrxmDvXRzSgXGtcbmqCZj2xoXZqQ9968dZh+D6xF/OttqjuocAZGpRqV/8UDyUM+RX
 kIrKIRaiKH5Yr8y2EP1k8ZavZH8PB3q9MRzITZ2+XevTDx4T1Hy+tvE24/a1wQc=
X-Google-Smtp-Source: AGHT+IG+RnHNPyyxRI2ta1k00cUlKJ8zqUCLTIRfzLkiY2/k7U8EPaRAwrbcz8d2LvyGBNXzkImCeQ==
X-Received: by 2002:a05:6a21:3296:b0:1ee:ced0:f0a6 with SMTP id
 adf61e73a8af0-220a169b988mr1195646637.8.1751009188726; 
 Fri, 27 Jun 2025 00:26:28 -0700 (PDT)
Received: from rock-5b.. ([45.32.55.39]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af55c6e62sm1489575b3a.120.2025.06.27.00.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 00:26:28 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: jonas@kwiboo.se
Cc: Oliver.Gaskell@analog.com, heiko@sntech.de, igor.opaniuk@gmail.com,
 ilias.apalodimas@linaro.org, jerome.forissier@linaro.org,
 kever.yang@rock-chips.com, liujianfeng1994@gmail.com, malysagreg@gmail.com,
 mkorpershoek@kernel.org, nathan.morrison@timesys.com, pbrobinson@gmail.com,
 philipp.tomsich@theobroma-systems.com, philipp.tomsich@vrull.eu,
 quentin.schulz@cherry.de, robert.marko@sartura.hr, seb-dev@mail.de,
 sebastian.reichel@collabora.com, sjg@chromium.org, sumit.garg@kernel.org,
 trini@konsulko.com, u-boot@lists.denx.de, xuhui.lin@rock-chips.com
Subject: Re: [PATCH] board: rockchip: add ArmSoM Sige5 RK3576 board
Date: Fri, 27 Jun 2025 15:26:07 +0800
Message-ID: <20250627072607.964020-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <07e80d9e-c91b-4b33-ab12-bcc5aa0bf3c7@kwiboo.se>
References: <07e80d9e-c91b-4b33-ab12-bcc5aa0bf3c7@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Jun 2025 10:09:01 +0200
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

Hi Jonas,

On Fri, 27 Jun 2025 08:09:13 +0200, Jonas Karlman wrote:
>Please review my series that already adds the Sige5 board, see [1].
>
>[1] https://lore.kernel.org/all/20250422211216.3727559-1-jonas@kwiboo.se/

I did not notice this series. I will test it. FYI now mainline u-boot can
not boot with sd card if you have a blank emmc. RK3576 need a new
boot_merger to generate idbloader.img.

Best regards,
Jianfeng
