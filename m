Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5318AC02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 20:39:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8A98805D7;
	Mon, 10 Feb 2025 21:38:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nlsksvfc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2124805D7; Mon, 10 Feb 2025 21:38:48 +0100 (CET)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D44F080821
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 21:38:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e461015fbd4so3784240276.2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739219925; x=1739824725; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WWoVuzC/lp/Jax1Rp1DGtzon2P8f27zUp3FbNlsWMSY=;
 b=NlsksvfcksDgzAJKBzNKruXC6PZD+u5pINLNmBg69PVhDkQBV8u6KEM8azRFp3wwSH
 qJQPvRyFOEg4eh3QpO9IIpQQf1hNOi98IIyGSfB3LZha2ODYl4+iAeqreY4YJu738CWw
 UzmlmcDCqabkY/e65PPXnl6Kh8Of9rvVtuUTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739219925; x=1739824725;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WWoVuzC/lp/Jax1Rp1DGtzon2P8f27zUp3FbNlsWMSY=;
 b=CBNqBIBdGxUxHTxTfJS2lQkGCeYX4jpfWb8wBk2nv3BKyRkBGXM7DVsvEYrPHj6Ot+
 76HU7bmh9ZXzEvuvDhMsPR0RhEJOtFoRCvLNM9LLfWkmmfe0yI1XUShwE1/lvsbYFYf/
 cvx+ULDS0oKVb4/RbnN5lXXv47kDFumpzwRW9yxuzZ+8QYjboAP8mwu2X2J74n2B1zJN
 YbB3IW4f1RiuL3WqLsDV1ku+Quxi6rWrtmSJxPWIsd9WCfI4X5f+rZicWOO7CTPmYr9r
 mhp4FJLdh0pX3lsCo0/sKNhxLL2wE0SajgSVqMCncRbzWqdqM7DPiZexFwPM5H2ad+ih
 rrRw==
X-Gm-Message-State: AOJu0YzO5i9S7JVDHU1Dp3Fxo6hT9V3qvU1+hVTBklc7EdUYzLJhRMgZ
 qAXnwhKNYZEGUEgQsaswDPhHvfpZWs/OjR25DA9DImn3IuZ6xEKQc6aRYas7vCuBy5daVCLUIH5
 8
X-Gm-Gg: ASbGncvRozH93q+D+S0ZlVCqQ6Rb993haWn65iXGIJxUIAVBd3i3v8QuRzSK4yoLdtO
 ACCo4rRoAsxcPVA0DX1lZXFsQxr2zOrFXip3AIPqe6Z0gBxUo09fwLP6gCPkoEfYwtISIauwjX3
 aLVoE9J6i6hcTpG47bqnbfxhd5zIghmQ7zv/3htSmsfX5uTGflwT+H2dErw2BTUwLD984hr1nSL
 fThhQ7jhZFdbVXPrO2MP7NDdzUjWJyJjYS5DVU00nPJbxz0OLYvXrVN6Myppa0BdXs2bvcFlFqW
 XV8O9j9Ia7HVvA==
X-Google-Smtp-Source: AGHT+IHC1YKmufa5VnKZwX0Orfbn4zZWrHYcj7CptYgB2Fg/SfvRroSmZ0lclKlljVSlWLLSI3l6lg==
X-Received: by 2002:a05:690c:7090:b0:6f9:a75f:f24c with SMTP id
 00721157ae682-6f9b292290bmr144963287b3.29.1739219925506; 
 Mon, 10 Feb 2025 12:38:45 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ff6a8d8sm18233207b3.79.2025.02.10.12.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 12:38:45 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Love Kumar <love.kumar@amd.com>, Marek Vasut <marex@denx.de>
In-Reply-To: <20250205130427.2385292-1-andrew.goodbody@linaro.org>
References: <20250205130427.2385292-1-andrew.goodbody@linaro.org>
Subject: Re: [PATCH] test/py: usb: Fix format string for fstype command
Message-Id: <173921992463.2921783.7871396598224311478.b4-ty@konsulko.com>
Date: Mon, 10 Feb 2025 14:38:44 -0600
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

On Wed, 05 Feb 2025 13:04:26 +0000, Andrew Goodbody wrote:

> USB tests on ext partitions can fail with the following output
> 
> test/py/tests/test_usb.py:245: in test_usb_part
>     'fstype usb %d:%d' % i, part_id
> E   TypeError: not enough arguments for format string
> 
> So add brackets around the format string arguments to prevent the
> error.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


