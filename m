Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97066C36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 18:21:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C950182A0C;
	Fri,  4 Apr 2025 20:21:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iBe5EaLo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C7BF82A16; Fri,  4 Apr 2025 20:21:00 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28A1D829C3
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 20:20:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-727388e8f6cso1481887a34.0
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 11:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743790857; x=1744395657; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vLU6c4YPgUzLnlPgjsDGc1RAWFxiSZuQGPNa2XdQReM=;
 b=iBe5EaLoea4aml8gGJOB3P2SFtHexStrL4kTl6fbzsBNPCuXsfscQB0NkwuRZWiDul
 YUxXc971H0H+ZB35x++avq1+LAf4fpjV5Fc4uGgy+e0+uwVncU5vFgGT9lQk0Urx9j1O
 //5K+TVSejuTGJWfWOotMGFcfpJ9DDSpjTcKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743790857; x=1744395657;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vLU6c4YPgUzLnlPgjsDGc1RAWFxiSZuQGPNa2XdQReM=;
 b=m9yuCVEYtFt3OX+u63263TkBSNVVxuIJc/NWUt/h6vdpMI9hfUIQXtP7RThSYgg76+
 5810Yoc898tYJoUNqHEf+w7RVaDiK7M6Rcmct1bzl4nizT9NPExqqhik2kWGKlMqHVnq
 E67reH7nt6t+tR76pOCjTWB3fkRYGa3gXeO/WAN50fcAYEcvrvDLAZu8DDSVX8yGF97J
 4s1NB5rfPXTiWFVfo4PJUeMobLwWcIpHfJFbdF7OuYiuOrj5GgpJkaS3U+wIrDOPPwF+
 F5W1CAwgIllq1e1jj1Hk3z1pvgnV+ozIUD2TnicrS43xhTcTHtvnskZKiBcORxr9VdOn
 X+hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGJkQRSqnim05a0Z/zQ6pK/7k6BssUorueINIvrAnP0FdR3BwAwX1v4uVHxjtloxpK/18diuY=@lists.denx.de
X-Gm-Message-State: AOJu0YwUnIMhtw1N0sbxWHO5h5lQ/vAGefsMKscbXjbYKFH430S9x6NW
 IH/a3N35edeAFw9eEP22QfAbnQL5o19TwixgDe/ZFKNj+AYUUV4FzDu8UtDYDmPkDz4h4EQyO2i
 V
X-Gm-Gg: ASbGncvz8JO7ZBxwaws/+yFS4GonAFCfxnrbTAUjMfaXIBCWaNP6pgOZdRsU+91u27M
 Q153yJ6aXhCMMrpKGcb7tG5jrpV/9szOtrOi32v77kTLbC8YZh7uvMZjzozgsm7WOLD+bY5xdnI
 axzbQBm5bPLsDbqQFjPsMW5EuRuLJd71zcoaGb8QrHxIJkY/aTzUOwnRJw2C1Urawe6y4YlkYSB
 +VQ88RLH3NhA33jx6FAhe7bZxHWuy0eqk6Ht2hN6qRIQZvw06II6tjywlkS3LikhdVrUuUUAAaq
 Lr1FBOrBXSzHWEoOtfKMSrAfVuIsKxdY1CmK3tNvw1L7CY9QMM2gjuhwVdp/s0c6Le+0Hld18cI
 S+GvY
X-Google-Smtp-Source: AGHT+IHY56MiBVPk3CnFaj3e3weQmoHEMPxcSEaluUKgsSVnhd66A1SnaFqJLjhDxRylkBynSMCZAA==
X-Received: by 2002:a05:6830:dc1:b0:72b:a175:2f0d with SMTP id
 46e09a7af769-72e365c000bmr3055045a34.0.1743790856902; 
 Fri, 04 Apr 2025 11:20:56 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e3051171dsm752144a34.20.2025.04.04.11.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 11:20:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de
In-Reply-To: <d1de0302-ad3a-44ba-ad1a-73cc1b6f34f1@linaro.org>
References: <d1de0302-ad3a-44ba-ad1a-73cc1b6f34f1@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-amlogic-20250404 into master
Message-Id: <174379085596.2587039.1164818831056569907.b4-ty@konsulko.com>
Date: Fri, 04 Apr 2025 12:20:55 -0600
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

On Fri, 04 Apr 2025 10:40:31 +0200, Neil Armstrong wrote:

> Here's a last minute fix for the libre-computer boards fixing the capsule update feature.
> 
> Thanks,
> Neil
> 
> The following changes since commit 82b69fc4224432d5aefa7ca750d950374cbc7fb2:
> 
>    Merge tag 'efi-2025-04-rc6' of https://source.denx.de/u-boot/custodians/u-boot-efi (2025-04-03 07:31:28 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


