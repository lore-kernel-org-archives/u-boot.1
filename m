Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF561C282EC
	for <u-boot@archiver.kernel.org>; Tue, 18 Mar 2025 19:12:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A3B48197D;
	Tue, 18 Mar 2025 20:12:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LKi4DmON";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7F2D81026; Tue, 18 Mar 2025 20:12:02 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D30678129F
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 20:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2235189adaeso105496415ad.0
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 12:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742325118; x=1742929918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NctfM/PrzGBe8gsbUNMXG2stK1zsFw64jTDbAtuHb5w=;
 b=LKi4DmONec4VFMtbZepAfprTUv81BJqevOK94/vPAJ4JlAVU0j6ZyZ43K35jmyj3TY
 1JMn2Im7SY6F9oanNWTdn3EnUikVLUJJ/39/9acJF7u/Qb1pZatLy0Cc/Fh8HvtEJSax
 p3nbfqH1/oydrcuxjHGdvYKmh0cPBvC31zJQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742325118; x=1742929918;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NctfM/PrzGBe8gsbUNMXG2stK1zsFw64jTDbAtuHb5w=;
 b=IeznhbDRoNEcvomxensorwNs0NVufuw6a06vfH9BKxYxyJPAF6ugd2nNQv/b6LM0zh
 MUxmWooFQUCNKBGqys+9syBQA+pPJl0iPgOH2+q1wN+0M8gEnylr1hSLtZL2Lhg7axXP
 o7dFeRy657gPPFYTOp4uC7rE3J2oxF5eC4EQX1BD1yatjtNZ0xIaswaf8TrzKGZXw5sG
 DIDuXdT52h/5hb9m0xC/YIGMJL2ci0hgCNzOioV55tY+xKsNIQ9EYIXypB1nBcalbE3P
 WST/9BntzVChmEgT1X+Xxm/oBhK5/ORtEO3OVGEjb4p89xmOGA5RDdjcnmPJdwxrdKgN
 Vs9g==
X-Gm-Message-State: AOJu0YwriC6jwEr4omdquOptXtp8qF7Z0GNF77XTF41bhAFJXOc26O0w
 MEJSpua139obyqWVsKE/+A04NaPy++uEab9cXpeJyeuvJzMjt5I6VgmHswCPTc0=
X-Gm-Gg: ASbGncsoWRvK74eAj1RoyqAx76Jbyt0Q291I4yQprTrdtQ1V6soxzzRCala6xXmOnsf
 TbGHJhffkeofYDzsxk4abVk6YgWbrgza5HaeyyugkmFStF9oW7BggDfFoCSR5Mns9LlCSLjOMDi
 4+WLhUKzQC1DK/xVW6mxwX0wV4eNz+XrJM0Y6B+lmjPp/bbTynwI/QOppgNQEQjNR4yTprLkksY
 2aAdPLJsiENyzr8QWQlDYnJtVKDNQftf78bHOCvpFN629ODhowcE9u34sN+80mJVxm2Pa7YAL+8
 3XBmtpyUlFgFM/y+DoU3MBKqrXc9bPUQqWzf8o9aQldYLgwnjfIKaWQ=
X-Google-Smtp-Source: AGHT+IF2VFbKkX+IsEEX/h6GcQca/DChPhEYiBwpWC5W524XWX/51C61nx/0s/HH6yEVQtAQWA47uA==
X-Received: by 2002:a17:902:f546:b0:220:ff82:1c60 with SMTP id
 d9443c01a7336-2262caec34bmr60008315ad.14.1742325118379; 
 Tue, 18 Mar 2025 12:11:58 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c688866asm98989985ad.50.2025.03.18.12.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 12:11:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <5ac73ad3-d718-45d5-8578-a37f6fd25d4b@linaro.org>
References: <5ac73ad3-d718-45d5-8578-a37f6fd25d4b@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-ufs-next-20250318
Message-Id: <174232511743.1770758.5913035360794351613.b4-ty@konsulko.com>
Date: Tue, 18 Mar 2025 13:11:57 -0600
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

On Tue, 18 Mar 2025 17:20:45 +0100, Neil Armstrong wrote:

> This is a welcome cleanup and sync with the v6.12 UFS headers to ease
> code sync from Linux.
> 
> Thanks,
> Neil
> 
> The following changes since commit 0e1fc465fea62ebae91f2f56cb823e8b37ee1077:
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


