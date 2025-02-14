Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E28EC02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 18:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07D3880805;
	Fri, 14 Feb 2025 19:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s0UnS+wE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CB8980B98; Fri, 14 Feb 2025 19:55:51 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 496B180756
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6efe4324f96so20867087b3.1
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 10:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739559348; x=1740164148; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Zp5ZcMKJxDbY32DI2A9ipej6FYoTJlFPlKux0W+fnU=;
 b=s0UnS+wEL223O873rkkR4YYup5/v/DCXzLrib6sgHZwA6tyJN+yHl/Yg4ylR/sJZvv
 pDbObxWUhWrtN/DaMWVcSr/k29pZfP95A77+WouXenayvYABi+ShXWKH6XkNxXFkaIFO
 JnOw+AlTfZUOlwucjUKey11AbWKR8xTjmTGNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739559348; x=1740164148;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Zp5ZcMKJxDbY32DI2A9ipej6FYoTJlFPlKux0W+fnU=;
 b=k5Sno1+RT+l7IYyrwaDtDYI33w1QGm7v7Ay3kV9z5xjnpRGhevS6hv2kEKMvOSU0+Y
 JFo8KnSBC3ZMDUZxNH5mHClP3AX3OlWUgJo00/pfoNmMj1W5f+jPXPG0+nUo4yfR3qYu
 yS7JZ31DKuaTqwqdBDwHmqAXcyGG6JjKAlZ/HPQ8oqlVIDlnEvbrZK4r2KSo8lRnwFMQ
 z4TrUO6TqlQ/k+99Hb7hre82MgsXuXVs0/ugitJ7QJI/MELdBbY9cx6yTg+QJJhhrtdb
 gv1noLs6w3Mewf8Niaz6B1N4yGMNzEE6LixpvuuuKy05HMlbsF+djtkPg5VBX0A8uP3q
 YDwQ==
X-Gm-Message-State: AOJu0YzxVBmBShVaMJMULGtYGJGEq/qzJ0NWeKgEqAVsown+2poXsvx8
 TW61uwRFzlx4827J4tjFmMIqL9AK8hhQ+S6afzK6Ppr+LFbjrs6gNcjSQ3setEwoMywXr/nVJDa
 85x4=
X-Gm-Gg: ASbGncv1W3VYddeI4pRdDuxwEB3KZZB8QTB90WpcEpeYbMmLFU9mvbyxSeP04aMVXzg
 E/5dGCt7O2cUpFAEU3e6K24Gx0x/w+dQTzYXQeHW4fL4zXFak2V8zqW2hvL6nx+8/eYUCyS3Pui
 YaoHQXpT0x3LPP8eGNYxDrhQA+sAJNq4SHdf1wlp3/GHoGoeO0Eo1FvqR24nDjt5s5SCUKLebac
 NHmfupgF/f7co9bZsbhm4pBdXIx6tM5gdxquLKghid3qM25Lk6FBp71M2haUqZPk2qwTCilswFW
 0JC3jr++oP9iqg==
X-Google-Smtp-Source: AGHT+IH+bvnWly4I3liyy7HHHq5lAQAmqRxzQl5KkSh5ndwOo9AbwR06/9qjsxDqiTvdiaiSWxngvQ==
X-Received: by 2002:a05:690c:c96:b0:6ef:7312:d05e with SMTP id
 00721157ae682-6fb582a3b5dmr6153047b3.19.1739559348098; 
 Fri, 14 Feb 2025 10:55:48 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fb3619ec5bsm8692897b3.91.2025.02.14.10.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 10:55:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tomas Peterka <atheiste@seznam.cz>
Cc: tomas@dronetag.cz
In-Reply-To: <20250131100845.31380-1-atheiste@seznam.cz>
References: <20250130164758.GC1233568@bill-the-cat>
 <20250131100845.31380-1-atheiste@seznam.cz>
Subject: Re: [PATCH] feat: Add CONFIG_BOOTCOUNT_ALTBOOTCMD to Kconfig
Message-Id: <173955934703.3052361.10140738654072110732.b4-ty@konsulko.com>
Date: Fri, 14 Feb 2025 12:55:47 -0600
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

On Fri, 31 Jan 2025 11:08:44 +0100, Tomas Peterka wrote:

> Add CONFIG_BOOTCOUNT_ALTBOOTCMD so the developer is able to add
> custom altbootcmd via Kconfig when they enable BOOTCOUNT.
> 

Applied to u-boot/next, thanks!

-- 
Tom


