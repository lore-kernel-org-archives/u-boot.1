Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51A5C02181
	for <u-boot@archiver.kernel.org>; Mon, 20 Jan 2025 20:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B334801CF;
	Mon, 20 Jan 2025 21:52:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hCXFzD6U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C6678032B; Mon, 20 Jan 2025 21:52:30 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E98DF800C2
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 21:52:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6e1a41935c3so69851636d6.3
 for <u-boot@lists.denx.de>; Mon, 20 Jan 2025 12:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737406347; x=1738011147; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RULBgC+dwyzYNrtkjEAD3zfq8wnPDDEb1mcqgxisqiQ=;
 b=hCXFzD6UhUtpyTDz4JuwNOIA1J38bc4OnhvvfWw2qR5lyKp3WbVNldN4EXS06yW2ce
 FXc7koJ0NN7thYH86pD5k4czjKXTWk+K+yDAthn8DgTvkcAq0MgCk2Mm87bgHD7cy5wG
 kF2WqTA8L299o7LEwluW99pnytJ6+zsRHuXo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737406347; x=1738011147;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RULBgC+dwyzYNrtkjEAD3zfq8wnPDDEb1mcqgxisqiQ=;
 b=LAY4wqYxJzaBBOth1zXk2XF5uRFnDX1yaZlSl1fXsA3Zs8F2wWvQeo/Rjbmu7FnToO
 DEec7zHsJ3vtBT5GfLGUht2XMLq3lMH6vMFIrUo5yaLZWBY0OEMN86NMTOUhkJfMG0+t
 dz4zf9IhZsSWeUp53W8gl+JOZXWq/mmJ3GlDW34A1TB1FyRuhYDKJv0g9Z+/AWJWIePu
 IiCyYDZOzQPxnqW4pUywxtsDh71D1B+2FTMxrkCmjKAIeVyoL/+LwdpL/6xbRkNHp2pa
 Uj7Ycz7SjpGxyj3vRFO4WN7bOhCYiuww1nAdBqExz1u60/Mjs+lOnhN7xpXM/TEonq0m
 392A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH0er/IOMVacqD6sX+b08bj22PM699s6sw83MtdrtM5KP+1OxefA0pIZVbEcmL80p115APHIo=@lists.denx.de
X-Gm-Message-State: AOJu0Yyzi6b7Fz6JOkPdGsVvHC89jY4Nnj/v5QjmHNFZUECp8bzXwcEN
 Zcul9dxFlX6Gc/G1XoCsk0iXqoU6peywI9Qumu8wd3FLHBCK6h2+6/S6IEpARH4=
X-Gm-Gg: ASbGncukJjkcfifIxa/IZgs8Eq7QsFEknlLWRPUHJCnTu2a4G0k5hHtFUf792BC7Vmj
 w+R3wSYpa69DT8CkLmyR3WwhyoB1aYNPlAy615gNICH3iKBR1SoeT1+nIkee+FMmEKVhvLJ1Y4p
 0/+s3zX3gwlH2AdhuglaQfcGaSfSLcg/9C9cKTHfBZVSpDq/ORwhvOIwFNnurNVaST3qWsvyAK9
 AuwwZH9ssPl8uVm+S6PorewDtXcoJ3sPv5iOW6W/shDS5hwIr74cSrdB2sSg1GsWA==
X-Google-Smtp-Source: AGHT+IEJXi/+lRwSHsdK0pigE/Pyq5/36iKM4A6RWUdOC0g3l3JniLYPp+GLSXiSsp9V2vwy0Tzk3Q==
X-Received: by 2002:a05:6214:2aa8:b0:6d4:1ea3:981d with SMTP id
 6a1803df08f44-6e1b223031emr231673076d6.43.1737406346543; 
 Mon, 20 Jan 2025 12:52:26 -0800 (PST)
Received: from [127.0.1.1] ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e104693c0sm46604801cf.81.2025.01.20.12.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2025 12:52:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20250103232118.711135-1-heinrich.schuchardt@canonical.com>
References: <20250103232118.711135-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 0/3] net: use strnstr() for lwip_strnstr()
Message-Id: <173740634466.2858231.5892096095947475294.b4-ty@konsulko.com>
Date: Mon, 20 Jan 2025 14:52:24 -0600
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

On Sat, 04 Jan 2025 00:21:15 +0100, Heinrich Schuchardt wrote:

> Using strstr() instead of strnstr() creates a security concern.
> 
> * Implement missing library function strnstr() and add unit tests.
> * Use it for lwIP.
> 
> Heinrich Schuchardt (3):
>   lib: implement strnstr()
>   test: unit tests for strstr() and strnstr()
>   net: use strnstr() for lwip_strnstr()
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


