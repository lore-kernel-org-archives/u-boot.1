Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7962CCD183
	for <u-boot@archiver.kernel.org>; Thu, 16 Oct 2025 22:07:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 657AB83631;
	Fri, 17 Oct 2025 00:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kImEV4QZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BA2683826; Fri, 17 Oct 2025 00:07:40 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C43D83734
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 00:07:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c0e357ab51so1000913a34.2
 for <u-boot@lists.denx.de>; Thu, 16 Oct 2025 15:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760652457; x=1761257257; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+tzIc8wOI0GottD5t6zdk1AGuNEF266Pbci9iZ4CH8=;
 b=kImEV4QZRwr4swGB+uNmFltOAFWshejCTp8/4EZGSqWQPDmjgUMRHkUC0lAqBryoT1
 tECx4N805av2z1UjcWr9izwe0w4tnOUYQd7ame5sJmqHvP7VXHkpZzQFuqOmbOcL/yxQ
 wrUhe54AXFnXt69CCFKzd0a16jhMThAQrEqbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760652457; x=1761257257;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+tzIc8wOI0GottD5t6zdk1AGuNEF266Pbci9iZ4CH8=;
 b=ZvbuX493CC7RuqYG21TUDA/2F+xh/kIpzFbr8KN+2GLFJEbjX88n/dF4t5sLu9Yn3B
 QDDmFqJi5fn4t9coUqB61V8Il2KwVHluQmzemNso83yzdZumdGxSqfaljU/UwgzS3KCN
 Gdp5NHlVu7AJpZwXuFGrPkdqhYW20YFceSwVV6EHMAib5E/Wn/ICWGhsOwusyd8K4cRm
 Pk9RgkzsCGujPPW3R43x1eeimV0r1+tY90G8vpXtvX8VvRJwdBrco17HUHOqIEtAKkBs
 uxB6FjEVtYKmZuOhYUSdMjUX31LqaSkM/vVAjuqtYO6/W+NWbt2gOyZaq4QaraA7duA2
 nDRA==
X-Gm-Message-State: AOJu0YxIqfegeVzNyOAh/MO178fNN9GGvws2gAwNgy/pdvcCJg9IhSyx
 JQWrS7ScrCvwtMFFBaGckrJ1OoiH2wgFcBhKaSZYMb2/OlNk1UAGVpWJusEBbipaXlo=
X-Gm-Gg: ASbGncs2N0H97XwSUErzbChK3CT0qupYqxPlhc4zuntCk+taGAIRyGNyM2QqO+XuoYw
 Sm9gz9sbajDcNGQe6VcbeAjthhvG0cepBZiwQN4aRtx/Eng/yiZEerLnFYMsWaqQFxl9wT+npjX
 td/BMF7aoYtUWyAw6mUCRB7H7TDCA0PXzUez+C/7L1ksPuDX4AtCjs0BnsGfyUYY8XlZndzQlvL
 ib6O7jQ4SdKRzLZcO6BHPb9YOATMY9xgVUwL/O1dzUVH3OjOIjPth96RCYbCUqaIzL0ymNkwIWc
 YGXm2KuZJuZ3deObNqgLHq3aYEb/eSHkLguU4iUnAWiaIWJW3xDRYNjoPVjYooljjmmpJSPPUw6
 pefIdQY3pKN2PpCib5yA7eHKQUMVZhKFiKHxhHdwQZ4YGg0699iUH9YRLezstz3tMN0lfL0OOLh
 nBEDqLExAbx+rzon+72vW0FK20hBMXc/xxPfAdNQ==
X-Google-Smtp-Source: AGHT+IFDq/lZiO4gtMmXhWexXgFUOMWmDbrHjTf7jtcW+z66dBZLTFud6nvxkOhRTzebIvHYlKAfuQ==
X-Received: by 2002:a05:6830:4987:b0:745:2585:9c57 with SMTP id
 46e09a7af769-7c27c9c4260mr685825a34.7.1760652456956; 
 Thu, 16 Oct 2025 15:07:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f9051d75sm6742427a34.7.2025.10.16.15.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Oct 2025 15:07:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Neha Malcom Francis <n-francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>, Moteen Shah <m-shah@ti.com>, 
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>
In-Reply-To: <20251008-ti_sci-v3-0-5866bf84adc6@linaro.org>
References: <20251008-ti_sci-v3-0-5866bf84adc6@linaro.org>
Subject: Re: [PATCH v3 0/3] ti_sci: Address some issues found by Smatch
Message-Id: <176065245573.262817.7084447760749917984.b4-ty@konsulko.com>
Date: Thu, 16 Oct 2025 16:07:35 -0600
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

On Wed, 08 Oct 2025 10:23:34 +0100, Andrew Goodbody wrote:

> Prevent a memory leak from a non-freed malloc.
> Return an error code on an error path.
> Assign a value to a pointer before it is dereferenced.
> 
> 

Applied to u-boot/master, thanks!

[1/3] ti_sci: Prevent memory leak
      commit: 4b8bc5af80f1637cd71a1b6a0dffa7588a03f27c
[2/3] ti_sci: Provide error code on error exit
      commit: 4602fa92202388665ddfbb622f001d62b1473a08
[3/3] ti_sci: Pointer is never assigned to valid value
      commit: 5b9125746dfde0a29911ccd542801da6b8f94239
-- 
Tom


