Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165B5C282CD
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 18:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F97D81269;
	Mon,  3 Mar 2025 19:45:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aKGExli7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A3818129B; Mon,  3 Mar 2025 19:45:37 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0414E811C1
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 19:45:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e589c258663so5258848276.1
 for <u-boot@lists.denx.de>; Mon, 03 Mar 2025 10:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741027534; x=1741632334; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fX4un/qhDVxVwWBg2TMCUa0j/qk7I+kc5KEfDAxPmNw=;
 b=aKGExli7mMzW/5c02We/q4+lCataIOUtCpq5fMVmpAeTQiXfMbXv1b0xVCiFpsyFx2
 tFGnTfyYTYYgaX3e+mszFpHLwieOdeIYPNE1uqTNjQHeJWXiYfdgPeTveEq7nsoxors7
 1i/uM/k9qAOQqc6KVkcI66CH0dGOtvvcH4BiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741027534; x=1741632334;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fX4un/qhDVxVwWBg2TMCUa0j/qk7I+kc5KEfDAxPmNw=;
 b=w2tBYmrdfgvI3kSH9j8xoPCfVqhHsji4XoYHDC7SxdD4V7wDWe1dY8Jnxn+Qqwr8cu
 oz6DrD8Up7gXwqbry2GHozIasxfL4gnyIOd00smmpGgX2aLQ2u+k5q8kETZ5hCYLVbFp
 7mJIF9OmltQuqI6hGccam0WHuqpC4u7Iw7zZWzyY+axIM9AaqG9xglwr43CJXesSGlMc
 ZTMHAezpDgaQVJDmZxa7wS3m5JNujAWBxhN7+Vz3NkZkmDl8avU2z5XFrJcsTRxm6/hH
 G/R1LX9T3j43UY4Qn/rat0Zwd0fxMJ0ITT2YfiZs4IayqzUa4IQQ/iQxk+RUYON0vrLd
 aLzw==
X-Gm-Message-State: AOJu0Yw2CL3QlS87KfYvADvIgk5vVIQ3lnYI+zEyXTL/k0lfGcL+No7z
 TuNuFDe6Yqx6FGCTQvPynt8fL+LfTPL/rN4BW+zirk5x4fGNCvsbuWCaasWIB17JSL4pWXWA/n6
 5
X-Gm-Gg: ASbGncurx0x9P6wwM3EhXpDUigT0LjKRILE/YK6pYpo3q4360bcEwYJ8dHcKeKr/SN/
 YJaT8XehyeKYGs4bft9QEQAmBF+iWLz+U7vGx1oz4todqIhuSwuNmNFfus5AFJ3eMzvmplUz73H
 bIwvG3/DuYF2aZmlw/mgPIbOcHeKUy10Y3aWvbyeU94O1vCj8nOsjICUGyg7OkOMG5Uoimrbvtp
 GrinrHIcdQPfYJjCWf7aqD5hmKTZuZidMuqwDZFup4NgB1NL0voc/oS8vAsXQp9YlXAeeS8wxZ4
 bhxfVY54iJVl4iLYvZF/0yIxx6R8N8v1Hc9xZeXrGQ==
X-Google-Smtp-Source: AGHT+IFIDw/c3ULEGTen35QI5y4rrLG+3AmFwOkCIfRgxs1qiA0gymyXkLyEinn0fMwZ28l3/ALO0g==
X-Received: by 2002:a05:6902:2203:b0:e5e:85:a9f0 with SMTP id
 3f1490d57ef6-e60b2e94151mr15119327276.6.1741027533897; 
 Mon, 03 Mar 2025 10:45:33 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e60a3a41ab9sm3192727276.27.2025.03.03.10.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 10:45:33 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Adriano Cordova <adriano.cordova@canonical.com>
In-Reply-To: <9e777fab-8183-4938-b578-cf0f26936f18@gmx.de>
References: <9e777fab-8183-4938-b578-cf0f26936f18@gmx.de>
Subject: Re: Pull request efi-2025-04-rc4
Message-Id: <174102753222.1504497.4400968625549902559.b4-ty@konsulko.com>
Date: Mon, 03 Mar 2025 12:45:32 -0600
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

On Sun, 02 Mar 2025 09:11:34 +0100, Heinrich Schuchardt wrote:

> The following changes since commit b78f8677cde8b1dde31b66f5b780f2e9b62fba7f:
> 
>    arch: arm: dts: k3-am642-phycore-som-binman: Add custMpk to overlays
> (2025-02-27 08:07:38 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2025-04-rc4
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


