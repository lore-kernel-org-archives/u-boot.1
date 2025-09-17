Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0220CAC599
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 15:08:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B07E58365E;
	Wed, 17 Sep 2025 17:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ioE19qlB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3338E83653; Wed, 17 Sep 2025 17:08:18 +0200 (CEST)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C250C83622
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 17:08:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-33158d9dfc6so3479475fac.3
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 08:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758121694; x=1758726494; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ugVVgNZJ3uT06yklZpWeEoqCYLSrdprSIl58LLyzLZM=;
 b=ioE19qlBeJB3vRbZN/0mgNdu2vKnYkiCRqlRtYtdQYDJ8BHoHlIQBbReZgi78MDM3f
 CwDvjFcNOJNnvb2sFuN02p3LShF7YkSzuRCeoqTFrydodqiqqHEhpE5wl9rNzmbburZJ
 9B33RPfcxnkHioQH2QO12Inu8+2nQJ5Xqvu7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758121694; x=1758726494;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ugVVgNZJ3uT06yklZpWeEoqCYLSrdprSIl58LLyzLZM=;
 b=YksjLWR/ywbBUK1+C9jGo6NOipBS2I9p+S8aSDssfHuMOfsSzy+rk6KIp+EkEMOGab
 nVWcvRSxB+2bZuNMqwiQkUIwsZo5jsshGzi/yOZrGsmKfLME+q1DbAKEYq14LMlow14z
 /3SLMiaqOMovywvp7EihqOA26ZWb7DMI+0lXzDc6oL4V9jLtjhZNsjoi4YDxZYbaTmaE
 5AQQXM0+ARjwg5u3lrt7hoXxL4Zh2wonKQvouzg2ezZKCEYcn2SfaA2VYXo4T2DLRVkr
 h5JI/Ggz56ExLThHhpAxUqGWy4ANnNa1Fn/0SmGWEjfoYa3HL+QYvoLWZHawo6pyyzdu
 7lmQ==
X-Gm-Message-State: AOJu0YzeLDjLqBkVkd7OYSte0HMdDL7iL7unfEW3JhNeCeBhDmoR1uq1
 q90yns7osWAY4CIaSTmek0umHSbgF2HE2vJPLBdbE9n1dexS7FYjS6/eEf6x8+kL6SwTermEfnn
 9DyszMw8=
X-Gm-Gg: ASbGnctiGrpNX2iyghT9QW1c0tdGUYnZC+oMm4QT+5xqCZUG1SBSqEovKhnOoU3/Y+1
 8qKbVKY7qxwTHhdWTA7UVkZTnQNRlHGGIpVVV7JfGdeAj3W1gQOmNY6zQW0iM4wwXUmzf2/dx6s
 cyBdGPXsgi3mYYHGnHSL5jjjuDVzywP0Wj/mR5VVBqvarXdxaw5KDLOOm66O5EIKnXIrPQsyYME
 aT5aTDJk6lOcoAbiWSkV+c5DTvf08M4i4EIOD46a9hGoT2p5IU2qR5SUnGNPhJlZsz63yOsznBx
 I74fkGLurh+7IkG2YecvrpIGYScQXkQfoFPd6NoXdP2jkYJi19JIOzmBDW7uzZ2zyT9vL5XH7wZ
 2S4K3fvzklm3dxwQnodxe2ACz27IIF8OY9Xb4+1iAIptvVD8l/2KtPyFhXNzxkOcm8A==
X-Google-Smtp-Source: AGHT+IE3qNmW9AD8LeC4xegIMJY0L+pRDWboXbhQvGC3tcGjU9CILFjxRabpqGgeLUr6MbhpGdFgnQ==
X-Received: by 2002:a05:6870:82a7:b0:32e:f4de:2db3 with SMTP id
 586e51a60fabf-335ba0868e6mr1266551fac.0.1758121693930; 
 Wed, 17 Sep 2025 08:08:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-758b2883055sm2981354a34.45.2025.09.17.08.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 08:08:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Marek Vasut <marex@denx.de>
In-Reply-To: <27f1612b-25e7-4727-baa1-0001f8526acc@foss.st.com>
References: <27f1612b-25e7-4727-baa1-0001f8526acc@foss.st.com>
Subject: Re: [PULL] Pull request for u-boot master / v2025.10 =
 u-boot-stm32-20250917
Message-Id: <175812169310.761188.9634462116335727693.b4-ty@konsulko.com>
Date: Wed, 17 Sep 2025 09:08:13 -0600
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

On Wed, 17 Sep 2025 09:07:14 +0200, Patrice CHOTARD wrote:

> Some last fixes for v2025.10 release.
> Please pull the STM32 related patches for u-boot/master, v2025.10 = u-boot-stm32-20250917
> 
> CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/27648
> 
> Thanks
> Patrice
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


