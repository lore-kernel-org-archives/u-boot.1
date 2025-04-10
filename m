Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EAE4C369A2
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 20:15:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F148483D0B;
	Thu, 10 Apr 2025 22:14:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y0dj8085";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68C1C83C3A; Thu, 10 Apr 2025 22:14:25 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C77983C3A
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 22:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72c27166ab3so706836a34.1
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744316062; x=1744920862; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rBY1azV2YdquxPYVwvOOWBNOr04XM67EXeo7/dVs7z0=;
 b=Y0dj8085tVpe62PECCMBi0fd9cTK5x2H8MZnWJtUaHxZ32L3XQHR3h18ixTLC/Vw5m
 Nv3ToMagjkXGx1fVEXyFcc1pzJW3FcMXHEbdcx7P9wYhwN/9VNYm3TpxNRAIwTE5CIqY
 XjLXFT6+7+3UYfYHGlgGWam2y01XV5s4ewmBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744316062; x=1744920862;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rBY1azV2YdquxPYVwvOOWBNOr04XM67EXeo7/dVs7z0=;
 b=GwLz9xbrIoeZW2YVbwKSYhagfvm+GZOv2qQ2ibGlPdkXLsVWrhHItv4hfoQAe5wJeM
 k2SQcJxzVHjLU8kjLyKHY+OOYzhkjgJWOcuSzBxuf8JTeeyFmFTquCjn0mCQo9qVQkhR
 sq92V50m9vw7q3m4xkeinu8ORZHZSsuuTMaC3pKPlACsbK8npRlFjZl68imzaa/4asrt
 ciXMamQy9wcRZrVbHLksuphRvceqvptefWNal00pQGQ0vMsgXKRTLeFCO9fo0JgEVWEW
 bmqDsKgOr2M+gsE4I2BI6CGl44rkDv9x0gdGRfHp7vbBt/fjuRpklCYtMt+4L9yN7JJ8
 f6mg==
X-Gm-Message-State: AOJu0YyZdZWa/aIN0nD7Scw3ltV3bbJGmPJcWcjsZCp+eFqFOIMNrWNm
 jnCqskalmp83I8CQvX2nUz8nZ6A8H0tfODx6mkAVksF9SdhDkXhjg9K4NLZzQZJaijcnhSfZRDN
 I9aA=
X-Gm-Gg: ASbGncuZZbXf1SzFOiVvjF8jh1Ie+gwHH80A2uvaii+pUfwls+NblJIecbdO/JZnLm8
 O0XAXjOOiL6I2ZXvByMAPKOEXDKKPRPAUpkmlyr8N7nOArV/Ei/1kcrQqn1H4O0E5Dx+jUpYpTU
 E+3Dv4lFa8MUcP91Y61Iq2ka4Q5V9q8t/v7S7NylnGy3xIdie0oaGXQmfMJFNvbnx73VQTv5Cu1
 4yuyiYsHu/ROzfnGQmja92+AyiQ+ci3oRhNveLWj+PN+YqsTpaxVNrRtSjOLv8Nd517xiPeIVbn
 6vTIG8/SpOWvIvs9a/O50y6R06TAa+Wj4fRrFw4A7Ltm319emRJEZZJOElzVMHSm5Me7YUADBsv
 N
X-Google-Smtp-Source: AGHT+IGRw0ZHZugKkJhuzDZM5tYvLZfxn8kWoi1f0j2pZ5kT/rgMgsAKoGQkwBQCW77pqZYs3pG9Pw==
X-Received: by 2002:a05:6830:6817:b0:72b:a175:2f0d with SMTP id
 46e09a7af769-72e86161bbemr234731a34.0.1744316062184; 
 Thu, 10 Apr 2025 13:14:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73d8fcaasm685741a34.38.2025.04.10.13.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 13:14:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250401162125.125055-1-trini@konsulko.com>
References: <20250401162125.125055-1-trini@konsulko.com>
Subject: Re: [PATCH] env: mmc: Fix test for ENV_IS_EMBEDDED
Message-Id: <174431606137.2981499.17317596389364781760.b4-ty@konsulko.com>
Date: Thu, 10 Apr 2025 14:14:21 -0600
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

On Tue, 01 Apr 2025 10:21:25 -0600, Tom Rini wrote:

> The symbol "ENV_IS_EMBEDDED" is an environment internal define and not a
> real CONFIG symbol. The IS_ENABLED() macro is still valid to use here,
> so update the check.
> 
> 

Applied to u-boot/master, thanks!

[1/1] env: mmc: Fix test for ENV_IS_EMBEDDED
      commit: 684aea3132031b124d8e54c9aa99a244b81d3a49
-- 
Tom


