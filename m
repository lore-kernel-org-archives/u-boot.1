Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AD4E77179
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 01:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9455B89124;
	Sat,  7 Dec 2024 02:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Gn86kQ+G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D35A8946A; Sat,  7 Dec 2024 02:03:19 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF9F689434
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 02:03:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-466879f84ccso19595371cf.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 17:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733533394; x=1734138194; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QJ0bnKgga4z+0L+T4HePdCvcsRcvjZrc/v3JeB3CxdY=;
 b=Gn86kQ+GmKkewCmjlFBrsj+kgTd5XThhSYYz+1qzz9/+9sTM03Pr0oEHrDTlesVEZ1
 2Q5A7bvsxghoI6b3+37Vc3GGVGTCEd63qfyDIFc+hizU1Dwo86C6ddPlr+HRxeTcIrCx
 pOukTQ+vik5Wv/Q3kbXYA6hkcbAMMYr32wz/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733533394; x=1734138194;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QJ0bnKgga4z+0L+T4HePdCvcsRcvjZrc/v3JeB3CxdY=;
 b=CMVyEkUK34IgZ5338Wsl+QSf7U1k/n5gK4cgvE9O9V5YkASBTZxeLBnkn6ZJ+b2xS+
 S5iyLMz0IKkSJCFNDvXY3lbtSntvJ/S7Qq7OuHcwE8ZMisoEJwBn1KSoF7yKh0A2d/VL
 IbCVp6r7YLWvMskjeuwoo4dRL6pNhlmRpa+UXrN/iHzmGNpNSJpyG5ROnnPZwZkbVAGX
 vJ/baqtieeLq4wYvpcoRrzCuddp0qw1UtUzAFbf8LHlQaRT2FhS/TGoHbDWbqOHUZKva
 VYHXlu6Qu92xjB1EOAcerQJkTrnNOKD2mBGSBFWyfFbM1gUrkDW/yNhBxY4UIqATc7Er
 u8+A==
X-Gm-Message-State: AOJu0YzYGs0FpZ7h9rLT0bmfryWMjwmacHcsN+2RZFL0HqG4SybVm8iM
 vV7R7aTbR1l4Lb2pR29/TXhke8Agz25UPpahnOWppDEp5wN0m6F1CxrRWBQG+AXA+91fYQwmEWf
 aRds=
X-Gm-Gg: ASbGncu/14RKdDIG0C1KMio7o92zIQzsl8d4jJvLo8+LgQKVR58K/jFHOZmL67oDaDe
 vJHrQLIcbwgbbjmid3HiuYmNxbELh+SfYT4KDnXiCona5xVNawqufQJ0OqqdI+WA/dl9bvj0ykj
 ULqWPwVbrYN/dDrnQ9/DkP/5oQbbUxuE/gKtY0mzwUBuobiqITgyAsPVwjZYZZvpjjy0frgFKqV
 TFNk0WVf/Gtlk9pRO2KscRssJKnZvnEUduWCgFEfVfh11PJNg==
X-Google-Smtp-Source: AGHT+IFe+MwNqCwoOwzvWxmrUIPVtzDhTelCVUUHBdu1SfgNrJM1O/81wx+tiG6UW0LEOsNYsNbaBQ==
X-Received: by 2002:ac8:7fc3:0:b0:458:27f4:5e1f with SMTP id
 d75a77b69052e-46734cab897mr73817431cf.18.1733533394656; 
 Fri, 06 Dec 2024 17:03:14 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467297cd6a2sm26834331cf.84.2024.12.06.17.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 17:03:13 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>, 
 Udit Kumar <u-kumar1@ti.com>, Chandru Dhavamani <chandru@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20241121-b4-upstream-pll-fix-v1-0-904f618897a7@ti.com>
References: <20241121-b4-upstream-pll-fix-v1-0-904f618897a7@ti.com>
Subject: Re: [PATCH 0/3] PLL Sequencing update
Message-Id: <173353339233.3658905.121894370722595097.b4-ty@konsulko.com>
Date: Fri, 06 Dec 2024 19:03:12 -0600
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

On Thu, 21 Nov 2024 17:32:50 +0530, Manorit Chawdhry wrote:

> It has done a re-write of the full driver and the commits aren't split
> to keep the bisectability intact.
> 
> Boot Logs: https://gist.github.com/manorit2001/1eaba109d722715a233244da693133d3
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


