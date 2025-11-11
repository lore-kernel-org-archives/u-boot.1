Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF5C3CCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 20:16:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4115683FA3;
	Tue, 11 Nov 2025 21:15:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rpxHpiYJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7295E83FA7; Tue, 11 Nov 2025 21:15:13 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8213B83B91
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 21:15:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4506534149eso16592b6e.0
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 12:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762892102; x=1763496902; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2rBbZZAs9F+nqH37zBq5rixjBmgGQWRV44lnPpDt/Aw=;
 b=rpxHpiYJu0zDxlSeFlHpVPKqdSYfr2SpNgpMQCPmjkZHIfuPGuS/HQT2ExtDBUQs9Z
 VhpazgL94v3edr15KzuIN7QpXM8Erg+fqAyw5W3ygCGtZEyAaIyZvv7rpObqCZp4ucLW
 +/+/wJyGCvSGXu/j9C4Ub3YlwQJzgN7CFd18Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762892102; x=1763496902;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2rBbZZAs9F+nqH37zBq5rixjBmgGQWRV44lnPpDt/Aw=;
 b=rglzvykvTz5Jr59XJSw9XSG9VYHL6+NvksjeiA3KLukZUfVlo3gLrN8fxwIztWrE2A
 WNoDeJ6t/dRzbnjz0wBI0Q+iimB6f+qvttzsGn6Tr3keoA4PUAVPbsxfkBi604zummeD
 AENcTbKOm0o3YycH63CVC3XpCJdYPKFuGDYlr7tn2PLo16TgckHksjk1TjM2wH8AgIt7
 4PNk7tL/bGQyjiWj57wyIjtGANkXAHC4B1OJvP28Zu0ibrM1EAyEtH/ey73o+d/k7wor
 EjkGjoy5tOPSQKnEAFDnjJ2bZTaISpgSJY2h7Ws32qO9/3C63O9LJaV/1FBHebbOmpdA
 hypw==
X-Gm-Message-State: AOJu0YxMaisplvuAyYc6EFjZHxsexL4MLzGXYj8acfOYpHK5iVW3T3zt
 ZK4mDZLEZ9WPNx4S5vEUVBKaSFE9j7EvEAOT1+Ue8lMatJVSPptzVD9ljfvVEBjgGLRLwA1GYTA
 mFNvjjTs1kA==
X-Gm-Gg: ASbGncvLoeX5Z6YEHkUqT1MHmKsbhdL9tbafsbJOwOOF9Ckcbm5QHSxyKzx8w+oVwc7
 iTdn1OQR6iIH0C5XJX6Yf3YrYCNahfT2dB/E9HRxu5nYM2aRIbB6KViF/uZb56udPqJDjLuLiBn
 Mnpeiq2ecyVeiWmRiETnoeMzsFTqDlVRi+oN+3CflOupOQyHZXB4yc4DUiLB49tNZ5U16lD1SLa
 aa1B6vRrMiehw8yIB/NOfoJI7s2mrkyd00SmyPnI/cOd4V1Nh37Nk54RnJ+q9GB7GUXUjYkcwzk
 fa2E2rknC36rerk1vaLlBLMKWFhbZ8Z+/RXrZ95udrLdVfnMzA0ww/8jVtyWIt05dUx6dcmhm1d
 +Jpe9w3FUTnLNrw3ZjqP4WMHYitRpFLKUMVLkNI500LVMM2MocVbvbJyu8Xh2phoMCZU/DYfrVc
 AorJtJEicYAMtyGdIrPU2dbW3SM8ohpyuC7Msdog==
X-Google-Smtp-Source: AGHT+IF0NdT2QEwr+df74Tp+YM7AscWfepOuUenpJmCLJmhfIvO5vRabNW8ijpTNATv+ALZ3U6b0vw==
X-Received: by 2002:a05:6808:1901:b0:44e:4d0e:f02f with SMTP id
 5614622812f47-450738e2ffcmr313313b6e.32.1762892102286; 
 Tue, 11 Nov 2025 12:15:02 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45031835261sm4197443b6e.16.2025.11.11.12.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 12:15:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20251106232835.3243576-1-trini@konsulko.com>
References: <20251106232835.3243576-1-trini@konsulko.com>
Subject: Re: [PATCH] Gitlab: Optimize the job dependency list more
Message-Id: <176289210169.737015.7583177860288833575.b4-ty@konsulko.com>
Date: Tue, 11 Nov 2025 14:15:01 -0600
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

On Thu, 06 Nov 2025 17:28:35 -0600, Tom Rini wrote:

> In general, we want to fail the whole pipeline as soon as we can if we
> spot an error while also letting bigger jobs get started as soon as
> possible. Currently we use the "Run binman, buildman, dtoc, Kconfig and
> patman testsuites" job from the testsuite stage to unblock the next
> stage as this test is complex enough that if it passes, likely the whole
> stager will pass. Using this same logic, unblock the world build (and
> sjg-lab) stages if "sandbox test.py" has completed as if there's no
> failures here, there's likely not failures in the rest of the test.py
> stages.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Gitlab: Optimize the job dependency list more
      commit: caa740df9cae5ddc74b18b88a4fea43e27b2fdf6
-- 
Tom


