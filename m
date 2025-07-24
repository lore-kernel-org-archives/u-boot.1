Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7581C83F26
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 21:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F38683903;
	Thu, 24 Jul 2025 23:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GGi8d+SG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 022FC8390C; Thu, 24 Jul 2025 23:30:31 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D712E838F0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 23:30:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2e95f0b6cb7so722298fac.3
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 14:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753392627; x=1753997427; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lr9bdU5nQW6EsVsfUJEvWlq7XuRzgJ525q4P/E3hN9M=;
 b=GGi8d+SGsTtkmhWSqZETtKQLpsakgd9JBgB5rCjkosaqh/vwXl9eMEL5P1Ueg7piD2
 b4AlXRivsXanJEFbXBJ8m8361FjgP/k/5+RuMkiDcsjrpePeJCEQoKBgJSXAAA5RNj1k
 eCUuWQPrrs2rQwu2rT2s/FgLTGJBSZm6g5m6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753392627; x=1753997427;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lr9bdU5nQW6EsVsfUJEvWlq7XuRzgJ525q4P/E3hN9M=;
 b=s6Rd9zMeRD0eD91VjuMUOgjkHxobpFftHP5RnT5uo9YpOtzIAlIjWhzgc95atqgZZt
 VH6WvFVjrm0aYFM6nyGGqGKunt8HPr3rN/2FeQsU4n1AV9YdHX/ArnCCCl3+DrtnNUAS
 2yE6YcAm4VqrAAgK4OoaAI13hvujLHPO7EWaZRpCaV3OYxyrkBek8wxcxHBRtm5F/JQ0
 IhTqlGNPNWukieZT/cBn5+RrieDmWJbI/fJELSPYOZM3B6OzqvljAqwqrTDRSJXlq7pa
 Hrpm1WMXdmpexjVyoM2ydqV5mrxA69ggnAT/DAvhs88lkYnx4UN9+oezMJLYp+RlhU/I
 OQ3w==
X-Gm-Message-State: AOJu0YxAR2Y458IlGITU9dyXvo+Dey0QgCfRiiZX1FNcmy94pgqIcpZr
 gMs9HWoaxPYaaZJmx1ZHv+Wm827k4EDW0VT+kfOBt5E1Thn2J7waDRb7hCnzqpyfcVk=
X-Gm-Gg: ASbGncuZ4E6vrZU4QT1MnLoxqTMRIP80fslytNYfznVYyui+qEKCzCiAZ27ujhquB9k
 iUxpS9jy2Lqh7Izxl75M18zYGukh+YE0hb+gnXrH9kS88Kp+V8wHVQb9/2gjSM5hQ/EgMpvJ/X3
 at5c8j4p7ttApbwV0jJ+7+TuqQ1QRgT8KwAKrVWIPJ5dqBjMM0A0T6i1z214EBrL3/AtFrgH1Lt
 1GtzX5lad/OMVkP8xDUG05uart7bvFC8D+JN73GTJ1SY42L1Kdas4aI7Kdz+Ey3oNMVXWbNXoHU
 YsL9VmNNmEuS9gIAp1bwEsNQm/uINMpLAD1lbfVVGNHuNMTHPI7VpLKvB2xINOyednUELI0EKfN
 mEpU4n8AS8m/VPYYH0ADbt1eHlp/7006VBi1pHpgG3Y3J54ENoa8KHsm3QB2XZ451uQ==
X-Google-Smtp-Source: AGHT+IEZaZrIDKuj+jxu4cKvxoJ7JqUMiRCceeRxxDTJT+SeKz82ChReMyUcx8VZyAbq6zwSTATyXA==
X-Received: by 2002:a05:6871:ea84:b0:2ff:8f57:917f with SMTP id
 586e51a60fabf-306c73033dfmr5412672fac.39.1753392627519; 
 Thu, 24 Jul 2025 14:30:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-306e1f8a7adsm660520fac.42.2025.07.24.14.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 14:30:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250714-blk-uclass-v3-0-1fc761606df6@linaro.org>
References: <20250714-blk-uclass-v3-0-1fc761606df6@linaro.org>
Subject: Re: (subset) [PATCH v3 0/2] Remove unreachable code and cleanup
 code with fixed return
Message-Id: <175339262651.1899261.8794267583201203136.b4-ty@konsulko.com>
Date: Thu, 24 Jul 2025 15:30:26 -0600
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

On Wed, 16 Jul 2025 10:58:37 +0100, Andrew Goodbody wrote:

> Smatch reported unreachable code in blk-uclass.c which led to noticing
> that uclass_find_next_device always returned 0 which meant it had no
> need of any return value.
> 
> 

Applied to u-boot/master, thanks!

[2/2] uclass: Cleanup uclass_find_next_device
      commit: 70bf6e33e15e2ce56f6e3e9a3f725136c9c6f486
-- 
Tom


