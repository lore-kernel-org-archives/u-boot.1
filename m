Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D7BCA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 22:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68EEC831A4;
	Wed, 10 Sep 2025 00:57:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iU3L99fB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CAE882B20; Wed, 10 Sep 2025 00:57:41 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82FE282B20
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 00:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-88735894d29so221875139f.1
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 15:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757458657; x=1758063457; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZCbQiZMLhu4q1cCLhoHMRFArITtY4D1bIApHnYaXz/c=;
 b=iU3L99fBq74vfiNV2BuPRG0gG8UqoBue0Oa+XWvpqT8IbfLz+PpmW1pAxOFRTKNgwx
 MA88RA9fqrqVt6carj4mXGnfWISM9pUwrb9HDJHLeNK7hz8t1HjZbBfQU9lG3pvLnGWe
 0AVbgj446X0wVEyHvRH/JsznK4tqiS6yEMm/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757458657; x=1758063457;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZCbQiZMLhu4q1cCLhoHMRFArITtY4D1bIApHnYaXz/c=;
 b=cpHvkp3s59rq51RUqHOzHvkD22VqJZ62rIhL9Qk4boEKEAbhrbUA0SY6lYAirBBUcs
 mGpQGkOpEMZEQndBfMMgOuGYSfcS7wP93VaHQrfTZ6DKsNkNRZiBN6kPTuCeKTy3DaHS
 vO0zWKxT3tpJsq96XlM0BqPjQD4xEUMZ4LVhkWw4Wv7wAIhCjMlhJY+OIJNuhmQKqnI3
 wlG6w85hVjLIfP7WnYbjAcaGy/z7QSwgKjxnKg4q0aK3IzlSc9IzBJwglG8vlAQjV/w8
 vzp2JDtz6lWw3CQl2KSNU2xH+z4gtdSRllFU5I9HlYxRYRLRscgy4Oqs2VhZa0ZqQWnY
 A6uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8cdasD6KtQIjBGJGt1Yok7coOuAUonyMxiTdDrToIfmbeengIqnxvcYslVlSHFgVvhOUYDJA=@lists.denx.de
X-Gm-Message-State: AOJu0YwRib0so0oimomhlUwZWLk8fAsx51bScy+sWlJrJS1xwq8h/UBq
 3jgKZxGBTZHjJ6Fu61c6Jm2DmtPHfkDx3A76XRcyz8JJgd8Qn+SWPU69SnyjrMfzT09ssr4POrk
 XS7UocpU=
X-Gm-Gg: ASbGnctCrhACpwYgbjIYIf1oLs+yFoa/hCy0YOh0tZmEEC3JaSRRxFQM0ZWC52ZoYdu
 vii3FfsDGrIbtxrB1BnysoGWnPaB2qYxKfWOPt4ph7oJoMxT31QR7PvXBZYZ2/FLC7Hwmd7yZcX
 CgtYuL2+Sb7ETUe7XTKuVURyYcQZiJj3D2qrubIfmIocyWMuSjQroGapZ7Kv4F+Xi1RsEeg5e0p
 zdQxTz1URE98HsoRC5bj3quQqH1MuvSF9xYtNNUVMLTsbXED6wi3McADTwbw5SoOQsCVSBNGvU1
 ZN2E/3pq+082PsV5XArEHsfHKfDeo497kq2RmGEf0pb5RrpJ1LGaubrDGaLGPxV8hF7Ss+Az/x4
 OB5vWSBdmIIzk+UfGyeVyNMO6N2VAuQ3PhmStAf5q49pRcsTZbbgxHSxuRrY3LspqHQ==
X-Google-Smtp-Source: AGHT+IGpLxi37gOhrvb4OX8Rsqee/NMCDDzFVLLFCCsmJThJ15wbVQXVExfU1ry7HgEQv2yN2cZ6aw==
X-Received: by 2002:a05:6602:4a0d:b0:889:b536:779b with SMTP id
 ca18e2360f4ac-889b53679ecmr1913939239f.7.1757458657210; 
 Tue, 09 Sep 2025 15:57:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-88c31dee466sm195844039f.7.2025.09.09.15.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 15:57:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: brock_zheng <yzheng@techyauld.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250902060813.2481257-1-ilias.apalodimas@linaro.org>
References: <20250902060813.2481257-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] arm64: Properly clear BSS
Message-Id: <175745865543.1836956.16485088449985739797.b4-ty@konsulko.com>
Date: Tue, 09 Sep 2025 16:57:35 -0600
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

On Tue, 02 Sep 2025 09:08:12 +0300, Ilias Apalodimas wrote:

> Brock reports a breakage on an RK3568 SoC. His patch is
> correct but he never followed up on the requested changes.
> 
> We currently use ldr to calculate the address of __bss_start and
> __bss_end. However the absolute addresses of the literal pool are never
> relocated and we end up clearing the wrong memory section. Use
> PC-relative addressing instead.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] arm64: Properly clear BSS
      commit: 5d01a971804e3f7f7d320870acf5418bd8497535
-- 
Tom


