Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79B9C369DC
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 20:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1ADE81E25;
	Thu,  1 May 2025 22:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X1eWMlV4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 196E98070C; Thu,  1 May 2025 22:59:14 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E1E1809D4
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 22:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72bd5f25ea6so370543a34.1
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 13:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746133150; x=1746737950; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YUs3SsWAOrglNIbaO0j5+x39j/qPuCUgII5RAhugdu0=;
 b=X1eWMlV49C/ih19bmANSHTptX3D4oaYwc+scGr9EnDP7dqxGKWMGU1mk2GEQgpy8+N
 A1C4FYu7hhvU8RqoW7oeZhQXCpZTL22sZ2VJ5/pJ7kkSxITO+doklrxZXZgizgYJlY98
 D4CzT7qylumPZzEpJoUuZlMTvFrAmpOdwobBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746133150; x=1746737950;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YUs3SsWAOrglNIbaO0j5+x39j/qPuCUgII5RAhugdu0=;
 b=dYqUsTBllrOAEqwqxwFP1lT8aJmq7eh4e2NiwdHjTQ0XuosLhQUizzL5+3x7ng8fr1
 LiAapSbGFFNRMVqq6Syam4VmNNAOEW6lEniHYLs773h8n3cYWLi+IkPokLD+haOdz2nu
 gqAUb0C1QjCswfJKoS9IqVlN2sM1zPbKUZcKkSQNdUNtycVBhX2VgWPbwQyfj/IPC5/5
 0f9pbki2+RtscpZLIYLMDXfIa23k6VSNsYG+IWSKQNnBQGg1ISEZ7fjXmFKcba854S39
 qZBaWHNt5JsjZLU/FheLRNRx9HHXQ3T/kDv5M8VnSYgclGPdAao/1dZImr3o1XBZZ2vk
 hOEQ==
X-Gm-Message-State: AOJu0YwWDolETEBzkEVrHATvakcMLjtnAbIoqRtqXojqQQfpiDslwHQw
 kmd5GxyR2AiQB8eO6YVRCtlJkzisiPbW/7HKuUnUAlcWZD3Z+Vn+J/2pC5YnJgtp0VIH9iNiYz5
 3
X-Gm-Gg: ASbGncsbGKNSJfP0kgw5e2B5jK2kzdK5Dc2r8jsi/3pcHEOnlMDn+FF+htUbHsWndZ2
 mvde4ljGXee2OEN9h5YndCRc0vwbSV9MFQHIH4q3ZaU/P3ETaSWc1pjKn3KmdE2zsV7h3+dwfJR
 2DL4vk5mC8n5PAwHem3L4H6TTiUupvNkcHyCpefJyEu9h78/PIdtz+QgiHppB/B5t+ahmpLWoec
 zdPT8mLkLAz7ZtvErGA1sLqN4CTvixPJRbQpvRz81qddZAo3QnRIQg/1q50KUY1fU86vAyjFl8q
 wDs7knJMHK8t93cOgUrBltapsOXlkje7m5YxWhw0yHWeZ2fyozsZTKgNsQaoeETn/08lNlN7sYC
 R
X-Google-Smtp-Source: AGHT+IFuAV8XT/qtzpuR1102oVXRQJo7FlNRX0N+pXb2XE8R1Jdcd65lKRIZqL1d9BDt1DM3YmyAbg==
X-Received: by 2002:a05:6830:730a:b0:731:d1e5:7c5d with SMTP id
 46e09a7af769-731da17a808mr268748a34.9.1746133150312; 
 Thu, 01 May 2025 13:59:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-731d34da29csm256306a34.42.2025.05.01.13.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 13:59:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszThj=AEg3AMEQCLaAEnB7jU2OUSx8DWk-rqj2D5L_Aa49Q@mail.gmail.com>
References: <CAFLszThj=AEg3AMEQCLaAEnB7jU2OUSx8DWk-rqj2D5L_Aa49Q@mail.gmail.com>
Subject: Re: Please pull u-boot-dm
Message-Id: <174613314971.2090677.14356696582764281290.b4-ty@konsulko.com>
Date: Thu, 01 May 2025 14:59:09 -0600
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

On Thu, 01 May 2025 06:06:59 -0600, Simon Glass wrote:

> https://source.denx.de/u-boot/custodians/u-boot-dm/-/commit/2a61f40d4a9f7eacce67a80ce79f916996c4196d
> 
> https://dev.azure.com/simon0972/u-boot/_build/results?buildId=75&view=results
> 
> 
> The following changes since commit aa96cda0a58f4d181b81a897b0b9fea3d9729478:
> 
>   clk: fix crash on clk_set_rate clean rate cache (2025-04-30 07:50:18 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


