Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98934CDB483
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 10:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5871F86BCD;
	Sun, 15 Oct 2023 12:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ve9Mjai9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFFE586BCF; Sun, 15 Oct 2023 12:31:41 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5E7586D56
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 12:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32d9effe314so1651794f8f.3
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 03:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697365888; x=1697970688; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ksqc97RrvA//9JSdIWQdCwkwNxbdnSEeDi9p0bEPXJE=;
 b=Ve9Mjai9AzgjwrIs+OERtddw8XyfKOEjYjqy7vUayjrs9Y1LPdNvUV5CfC9nXOjwZF
 5W0c5Pf0OsGd07E2/3TBmUGLkzNz/2FoUSrDVzuqdvfRiUDPDmsFKrzXuESB7GAhXVik
 Y8vU5PReSsLVikiNW+B+tbez9ZhXqO4LWxYLIDfKIO8iBpHUx5SJ4RwVvDvOrCw3pjgU
 PP8jR5K8Igd1QLpSkWHaezN7vftHL97P2mg1TFEDwgJ1AdfryhVuY8PH4VLd4hvrl2dC
 71ypiNGr7rrCtr8Rs6r8wtKrVeO8Af4LM6Bpx+LWukFNu8WFu3qLPE08fNTbmrYGucd0
 vHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697365888; x=1697970688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ksqc97RrvA//9JSdIWQdCwkwNxbdnSEeDi9p0bEPXJE=;
 b=BM5MldYqv0W+yVijQAEFCIT43rjIx/+FdzQdrw2kHhkt8lENKArYRXj2TBNEkS9NhO
 qS9xW6XeolH9EVQyeuqoiWvUPCRiq8l1UUh6MqqH6SONedvk+iFXrGiuhUmiuSFt9pN8
 SfCsopCLKgG+qbE3D345JNmQk0ee1zW+vBV6IpxsgqIn9oYSI9BBsMJO6LiUDUpCFs/w
 vPaF9VM2ch8CPnXVJRz+fk33lXp+bbw2PA9unGDit0g2v/XRKvASDoKLeoHR2S3Ymx2P
 E/znTL51HxMzW2XzQJOOAYYwK0eE0YgFRcxeLl6X7fMxSff2PY5dvZ9+YIhpNgZJk7QK
 1XRg==
X-Gm-Message-State: AOJu0Ywrmm091wPKA/BEt0bfwgoxXwoAEpbdVU2hahKkmz7MqzZ3K70K
 PecNGI0CwlgWdOxvB0PkH7iX/Q==
X-Google-Smtp-Source: AGHT+IFtUCymwK6lX4GLZ+oqA/8/baJmwSEr1Rbtb+18gD3piSQWpU6XJsrBKGzQLXzIRNzaxFQlFA==
X-Received: by 2002:a5d:5b0d:0:b0:32d:8401:404a with SMTP id
 bx13-20020a5d5b0d000000b0032d8401404amr11571241wrb.10.1697365887687; 
 Sun, 15 Oct 2023 03:31:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a5d6109000000b0031f3ad17b2csm5820598wrt.52.2023.10.15.03.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 03:31:27 -0700 (PDT)
From: neil.armstrong@linaro.org
To: sughosh.ganu@linaro.org, xypron.glpk@gmx.de,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alexey Romanov <avromanov@salutedevices.com>
Cc: u-boot-amlogic@groups.io,
	u-boot@lists.denx.de,
	kernel@sberdevices.ru
Subject: Re: [PATCH v3 0/1] hwrng: meson - add support for S4
Date: Sun, 15 Oct 2023 12:31:21 +0200
Message-Id: <169736585436.4181364.7854441987940465829.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012075828.22685-1-avromanov@salutedevices.com>
References: <20231012075828.22685-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

From: Neil Armstrong <neil.armstrong@linaro.org>

Hi,

On Thu, 12 Oct 2023 10:58:24 +0300, Alexey Romanov wrote:
> This patch adds support for Meson S4 series
> hardware number generator using new algo.
> 
> V2:
> 
> - Sync with Linux version.
> 
> [...]

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-amlogic (u-boot-amlogic)

[1/1] drivers: rng: add support for Meson S4
      https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/commit/a92345610ed3596bc25de08b17cb29c86b508e6c

-- 
Neil
