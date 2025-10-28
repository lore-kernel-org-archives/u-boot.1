Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EFDCCF9EB
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 17:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B2AC838C7;
	Tue, 28 Oct 2025 18:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YTB7VWpl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80EB5838BB; Tue, 28 Oct 2025 18:59:10 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D35D80422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 18:59:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-44da4528832so1922207b6e.3
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761674347; x=1762279147; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BTUZ2EbObhxzbjXZeEsG3pWPCBwmSJjN07kABjI5Apw=;
 b=YTB7VWpl+ZqI+/iXtd26+EJR165BbJ8cVmJOYhPF+sByrnZeAb8uNtQ/pTj5I9437m
 6LOoSJhDPHvRVxT1Wbg6Vu4JhWqwtRhwrZyM3EW2vBRtNRfcjnZl+5brgAIBBFsU9YXl
 9HISukP1HWsUwHUVQy5BpoGKuUpvjUMWkBztg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761674347; x=1762279147;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BTUZ2EbObhxzbjXZeEsG3pWPCBwmSJjN07kABjI5Apw=;
 b=SvT/FFE44tDDntt0bhknOsGDg2YhVTtis03OS00YETUbX9QH9gXxot6c4xJdviEjIq
 COzQYJJHjs8XLunztnetBNm3nlfKQXZ5KzaRwxMTN1jEJSlIPE+a0Zfs7JH9WdW4Co7L
 DjOne5mhyki52uRBf/yRNzI+RLQ5UbsWZ4LgCOydgJ35C9FDs3bZgzC4tvNIzP2hI2SG
 6rn0WALSn0LyJm/XHI7HTDnM2Vr1TpH7JVhE+w7Bp/hrcv5zJcWVA0nl25ZZMS1nohOR
 tqaWS9jGM656Q8J/uDqzc+YF4iUT5jI2rRrp5F2wDO8t+riae3BHFry4TukAQeocpFCV
 +F/g==
X-Gm-Message-State: AOJu0YxO/cDPGQ8vV/AnOL4bUm+OVKJxfegN1KRQ/0KSivXynQsQRWgS
 axK9pEMAewwQbWtzWQ6GUX9GU53Maj9Umt7yDro6TwwUeiVQ4Q7GuvTZzZ4YTJ+qhuc=
X-Gm-Gg: ASbGncv095l3B/srOCARm0+QlAwXc0a9auzwFKuD5cfe9QT9HUfAe+x5X7ZcIYMEON0
 D9ARO/qcE47t7G35YA7RLIH0BsF7cPrLHln+U7w1PPlAuKPCMxiuiLbzUsBaaKgXSq/FnyB5cVi
 u3jvQijmY8gVshifQSAIok+ORWeBLECn0/LTSENs9jCvSBBeDEJxeXgFCE/T2KQnIBflZ4+xk0A
 OHoWuhuvXG6eJ+MQUuxBsfK7zuX0y7swiKwbwOoP5GDsiZ+AS4KX2/M4crn4XG5SN3tvajVilJW
 ZVFVTdqD//zdcLiUYtGRtBd4/ythG+8KEbIsiiPnTvrB7GhboRDY1kH71y39rz5trB0zuNlHfX6
 FrjlgZPlXh8zQmsq7JeUY+FI+jb8gy1UBTsK7/1auo/Jr6MrRl6ScFq1Xkh+zNAHhoCcvI335xN
 15ViZMg6PXplAP0vtRrWhJzfuQr++MhQcnK8LxjA==
X-Google-Smtp-Source: AGHT+IEApssAO+Hp/IJMSh+5gHIpkaeQcSru5eX4obia0twd9kuL1jD8XFt+oAWZwfL1mRbuE7G4ng==
X-Received: by 2002:a05:6808:2109:b0:443:a19a:8a1c with SMTP id
 5614622812f47-44f7a406eb2mr177544b6e.25.1761674347008; 
 Tue, 28 Oct 2025 10:59:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef2e0d33sm2843926eaf.16.2025.10.28.10.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:59:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250723-clk_versaclock-v1-0-9d70f2530871@linaro.org>
References: <20250723-clk_versaclock-v1-0-9d70f2530871@linaro.org>
Subject: Re: [PATCH 0/2] clk: versaclock: Fix two issues found by Smatch
Message-Id: <176167434592.2025892.5045964795763972788.b4-ty@konsulko.com>
Date: Tue, 28 Oct 2025 11:59:05 -0600
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

On Wed, 23 Jul 2025 16:54:06 +0100, Andrew Goodbody wrote:

> Should return value calculated by ERR_PTR as calling code attempts to
> check for it.
> Also do not dereference a pointer that could be an error pointer before
> checking it with IS_ERR.
> 
> 

Applied to u-boot/master, thanks!

[1/2] clk: versaclock: return value calculated by ERR_PTR
      commit: 6f48f6f2a2df05bd7663917b694a4d881998f6c5
[2/2] clk: versaclock: Use IS_ERR check before dereference
      commit: 2a13b59ed4317ec4483d1502d9db161f46985a32
-- 
Tom


