Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA678C19F4F
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 14:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 236A58873A;
	Wed,  8 May 2024 16:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XQ/uxNy7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B912C88380; Wed,  8 May 2024 16:14:20 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 760118873A
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 16:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a59b097b202so881623466b.0
 for <u-boot@lists.denx.de>; Wed, 08 May 2024 07:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715177658; x=1715782458; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6WWOmAlNmJnIxjI0PXWpWur2YSFkW4iW9RQ1lJSe2fU=;
 b=XQ/uxNy7gsTioSYIuYoe98CzsSxLCvLgIe9YsPLrcHU1gYm6u+HElOR5u4e+W85XZL
 dw0qZcbw4nJmqchnDwff6aBbxp1OPJRcchX+VC1mm8wuP8FIWsykfI4yfHYxGvHeAJVR
 2g7hh7mZ58rFExUFk6PG3YAx9H8mfiAUe78ZK+Zm41F8AlOtkKLgA2Vghso+2vv0KVBA
 Nsj8ab4+VyPx0Rynt9zgWcvLd+VkDwFjQzemNkITw0dZkY2uCDFwmm8IFdfYYG/BHOG9
 X9KM1FC1KWvEbcVs91sekiD22C/UTyZ/4Tikj8QDDtwFWR54fKxgKb4swDAwoHwG1q3C
 m2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715177658; x=1715782458;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6WWOmAlNmJnIxjI0PXWpWur2YSFkW4iW9RQ1lJSe2fU=;
 b=q2Uti8r2mb0/xJvQp392/rO65dVYHOTmZhC1f52Kno38bvWYdAAUu5GbSittm15bSg
 f4jF4KOd6QVHtbJiZkeYBDsVcSVWri9tzlv6yUl7d35ntWa+edH17D0blNFnzOU3Ib9u
 g+DTTGGVRi+e44ndnbMzWZkM7OYrEfT4biitEfiqmx13uPUDUvwQ7OZZv2VD5VAlB+3i
 5pM8gi84T/weioQ2o9D+kcYcAVdG8z5Z+b2BG2mJXnkukhzUwBeRViGnrxob6had27rf
 kad4gtdvYGUg4AJ3X8B1JyZ7zCr4ispWd3RJpOGDUd8L86eIMJ9LtPyl+JdrODHkXNFo
 yRFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi3DdOBX2RoiT+C4xVqdENloYw+dEU7eC4D929FqLRL4ApRc0/+fEcDCkzVox2UE8azSE+GtVt6bsAvjXJLXX9purt8Q==
X-Gm-Message-State: AOJu0Yzdo5BuEsgG15XCd04vtznrgDSYaMMQi3l/pvUJVV5bBF5H46zB
 8wukrnIfUqSbxGeUyA/XMOTimNkzmamgpLGD9vuhjqzI19vZ9SussAyEN1uTthQ=
X-Google-Smtp-Source: AGHT+IFsIVHLkXYUInEttkE5TQrJ+pI0zw+9Yb1YdxbLEhIZP7X1SnCWT7dy1yjISxrMqTVPzNHeqQ==
X-Received: by 2002:a17:906:2dd3:b0:a59:afba:d0af with SMTP id
 a640c23a62f3a-a59fb9211e9mr169047266b.4.1715177657978; 
 Wed, 08 May 2024 07:14:17 -0700 (PDT)
Received: from cymric.local ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 cx10-20020a170906c80a00b00a59fac165dfsm1223887ejb.204.2024.05.08.07.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 07:14:17 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Sam Day <me@samcday.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
In-Reply-To: <20240507-qcom-defconfig-msm8916-v1-1-6d6914bfc00f@samcday.com>
References: <20240507-qcom-defconfig-msm8916-v1-1-6d6914bfc00f@samcday.com>
Subject: Re: [PATCH] qcom_defconfig: enable msm8916 and msm8996
Message-Id: <171517765714.60629.11527452242041207771.b4-ty@linaro.org>
Date: Wed, 08 May 2024 16:14:17 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev
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


On Tue, 07 May 2024 18:46:54 +0000, Sam Day wrote:
> Enable the clock/pinctrl drivers for these two SoCs. Previously left out
> due to only being used on the db410c and db820c respectively which both
> have their own board code. We can still boot these with most features
> working without that board code.
> 
> 

Applied, thanks!

[1/1] qcom_defconfig: enable msm8916 and msm8996
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/9291868db7d9

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>

