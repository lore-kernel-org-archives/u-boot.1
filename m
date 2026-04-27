Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF5EFF8860
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 15:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8659484236;
	Mon, 27 Apr 2026 17:42:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eUos36vq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CE8884106; Mon, 27 Apr 2026 17:42:16 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C40B83AA9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 17:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-479ef2b7979so4622314b6e.3
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 08:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777304533; x=1777909333; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eXZaj/bYtMxxwVf0XzXjAmuHXORAGcUHRthiWD10BEA=;
 b=eUos36vqPfSdyJYknc0bZ/Yc0M3AWK76pligdd5htVFowpAq5MdlbS3qNQhdvOrahS
 md0sWZR2jt8LVrlfpqX68erLZQa2Ymn564sgkY1tiOYZFY8pp1dXVHkYmEdBLlTrLMpi
 kqQ6CWlkbfCKD0wTbHew0jybA/2IMdN39wDLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777304533; x=1777909333;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eXZaj/bYtMxxwVf0XzXjAmuHXORAGcUHRthiWD10BEA=;
 b=Kf8OZfnddzIPdwk27YsPokTB5dpjjq3wJ3nQXPdxy6Db2GNYfaUDqdAlmG6+EjxtlO
 ASogmILOUeBELtDaRt/UyimKPHABMzbZHuplnkrhe26h/BF5xKwqK5k5mRSYrUbXfytk
 GIUzgT2RsjF5InSGcUygt6Rg+rKiIMbxTKTNlmMgZA5aGd2WQtkFudBpBqpLFiRstW5d
 VJyCw7Cb5Av/AyXwJyNhi4BaMqagqcYRJFhMsXApDiQ5AQJzvIqCMFiOHrTAPuCt9ZGr
 96lG8u1gklG3IB/mm9gntzKxuaB6V/NjPW/OSEzoOJyplvsSRQ36VV8CwaQJMqGyQ6uM
 RbBA==
X-Gm-Message-State: AOJu0YxpcUCTKmutA+QWbelYVNp0Ua0VQIZ8FfjeZoocMalV2IqOlkJX
 MlrarWFMInO29dcx+7R7pdgbVODfpO7mM192J9uKcOJt0hxMaLXB65Je52Vc2W7CpTzFe0qB4Iv
 NFsIH0NJptOAv
X-Gm-Gg: AeBDiet4hwKExohH6vw+T3ULIuK87dyMar5Fpdp8xJXzA5nYggIVa3YHnvNE6UcpLZ6
 QO4Yi6uV/s8fTosoa+yHbjg1UNKrBCQObdpzzKF6sLsNJHb8taCnWpSR4+HgXzE5rhjf9mvshOJ
 1REo5w3DtwAbH65JQQcbsxuPOWWWmspX46+xK0ugmBbINOjCXFlGWBmLaR1S12FVO3ED5GVEACm
 TEdc6g9hPrMnXDShdbb2vKU4C4gZRyFzwyqgUwWwOJWwUbpDHm+joFk1d1Y4xCChxQGC76U4N4c
 /1yroStTpIldDGGOMRZFJ2gAmPFjK/8JSl2w6Fyga89fVYVG+v07ujG1lJHpgDbZ5mWePReHCuw
 CEsYNk96ezZthKEbNcFDZHo9VBUGmTfWFHe2d1KCc6pAjO7UzQ8dnr7vYdZaNZjUJKyzt3Lmswa
 hpLzy/C84E+kCW+CvDAam5mEc9EezYSlbLxbl1bJ0n66zJSHVMYRq616LuQbckjex+kaBpbEHnB
 TNqrHnmzulmX3sWS5sijjYWO55qsdO2VkJgOxX9RPP+8e9f4IeTTJZXfHzP
X-Received: by 2002:a05:6808:1301:b0:467:2375:58c9 with SMTP id
 5614622812f47-4799ca307d1mr28875433b6e.45.1777304532738; 
 Mon, 27 Apr 2026 08:42:12 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c1c8cd7c2sm824896b6e.2.2026.04.27.08.42.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 08:42:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, neil.armstrong@linaro.org, 
 Ajit Singh <blfizzyy@gmail.com>, 
 Antony Kurniawan Soemardi <linux@smankusors.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
In-Reply-To: <20260427114730.558468-1-casey.connolly@linaro.org>
References: <20260427114730.558468-1-casey.connolly@linaro.org>
Subject: Re: [PULL] Please pull casey/qcom-main-13Apr2026
Message-Id: <177730453148.3468459.2488151742294859624.b4-ty@konsulko.com>
Date: Mon, 27 Apr 2026 09:42:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Mon, 27 Apr 2026 13:46:26 +0200, Casey Connolly wrote:

> Resend of 20260419030602.2470577-1-casey.connolly@linaro.org with the CI issue fixed.
> 
> Various Qualcomm additions this cycle:
> * USB superspeed support for 1 platform
> * Initial support for the Milos platform and the Fairphone Gen 6 (chainloaded from ABL)
> * Improved support for booting with OP-TEE on supported platforms
> * Initial basic power domain support
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


