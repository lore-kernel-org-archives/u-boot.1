Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4952CC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 01:38:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C919835EA;
	Thu, 24 Jul 2025 03:37:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mfdIuOv4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92F3C82B0F; Thu, 24 Jul 2025 03:37:35 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C630835B3
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 03:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-615ee07353bso306675eaf.0
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 18:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753321052; x=1753925852; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=42mAPWp2imGy+7HSss1YisVAlsqh98DRhlBZFVxPi6I=;
 b=mfdIuOv4lwUZWfT4lBnRrGRYmypspC4D5k1zNawKOedSNSd6kFB5JrCiHB6lFFJAzs
 v/w51zD6eabaM3Ad8I61InKP0FKV7OheP/1uaiFmbAWTKcGOd+qf7odRMNGAfA9eLBnT
 AgBT0ceDCspSQ16thFbmOd3oqRWjAXktv47y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753321052; x=1753925852;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=42mAPWp2imGy+7HSss1YisVAlsqh98DRhlBZFVxPi6I=;
 b=rLRa5D78UCfjneuBo2G7Yw62l/jXI2Q39nQAt7mzYBnH/LxsAamJNrtsT/bPs3dWlP
 /GTeQxNWsPNJ8+bMl2s5LLi7kfnIYAW8PosWfTJ4VGdFsTMFT3wzcYQ1I86JlbxApHnk
 CKPDZfK+IMFQpnlU0H7rjT2WhGONXDzLsqqQpX4m7auCL1xXgzbAh0Qf+LjjzkUOZyd2
 zBk970P5FyNzwr4uWf/x3qC71vhbKsZzRTXmEHqChwYMzoZC2OVbKpjDiab7wORcl7dV
 n0DWsM6beEjh+T5btQ3oupdA/fHIiaYncy1Ha3ihgC2ASfylLUQ07HduJcPNifdVKIMp
 p2ug==
X-Gm-Message-State: AOJu0YzwwXCP4uZku2YrkW+CmH6Yk1OzI8VkVrxS2x7/fAIkUqT6RW7Y
 oyK13ZT3mLqgLlGlKqdNVhtfgFclEYNBeoi2dVM/wjMedEblkytxVBeCCkzVlN+a/tSkeL3rO1f
 21+MB7Pg=
X-Gm-Gg: ASbGncvtmjjErEKJrNfbkLGkOkUrtjszw8930CBwue11rkO7n5wczIWbXJ9S+fZ7mel
 MVhA9DumTg0VEJdBp2kJwhB69snkixVUVCz/9FpS1QukYEXMcZggYwaYPozv48SzNMmSWEMbI5z
 nrp2FDIPZQeIJdHO/u+dtirUMpJUa+TeHlh/2bRyKtC1yZ3NtzWnZZuwIFkS7ESlqIBEKTSZwYp
 1sHRq28hJcpKh6BvNKQFRPzn4L1GM8F7KZQPmXjGx3wEc82NUbWjUqSGoxOFXfFWjJiC0zB+J8h
 xmUBSf758AAQ29nPimja5/GZTOjmZr1bMeDG//Nl1aE+8Xz8k9AJcUc3wHyE3z1AxHG+ceJCekY
 Im5yddLkLZpXAIu2Mej7t66lnTil8CNchNy/gmkkxGV125lkAy1So/CQ=
X-Google-Smtp-Source: AGHT+IErc7pRNSTYqNTC4S+qAdKmnUXMGA9STs9LDRDrdPklIKvuUzZY+IkQCedn2EPF3rdRSrwbiA==
X-Received: by 2002:a05:6820:4dcd:b0:615:ecc5:c07b with SMTP id
 006d021491bc7-61862dd3e6emr2987793eaf.0.1753321052274; 
 Wed, 23 Jul 2025 18:37:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-618fb4431a3sm102604eaf.13.2025.07.23.18.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 18:37:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Greg Malysa <malysagreg@gmail.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Alexey Romanov <avromanov@salutedevices.com>, Heiko Schocher <hs@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
In-Reply-To: <20250717102012.10018-1-malysagreg@gmail.com>
References: <20250717102012.10018-1-malysagreg@gmail.com>
Subject: Re: [PATCH] block: Remove blk_find_first/next
Message-Id: <175332105109.263924.15857659734899462292.b4-ty@konsulko.com>
Date: Wed, 23 Jul 2025 19:37:31 -0600
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

On Thu, 17 Jul 2025 06:19:01 -0400, Greg Malysa wrote:

> In [0], Andrew noted a code quality issue in the implementation of
> blk_find_first and blk_find_next. This led to the observation that the
> logic of these functions was also likely incorrect, and based on a quick
> check it seemed the functions were unused outside of test code, which
> did not exercise the potential failure case, so we felt they should be
> removed. In [1], a test patch which illustrates the failure in sandbox
> is provided for reference.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] block: Remove blk_find_first/next
      commit: 3532f1f5edfc97c9dcea723cdeb732eda44bc669
-- 
Tom


