Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2455DC021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 02:04:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55D8280F18;
	Wed, 19 Feb 2025 03:04:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="O43epeZ1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C9280F18; Wed, 19 Feb 2025 03:04:50 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73B4E80646
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 03:04:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21f61b01630so5901095ad.1
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 18:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739930687; x=1740535487; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yyPGs3BlQOq8KbhcEcuJ+BreaaNTs/+pIZnQkzu1RQ4=;
 b=O43epeZ1eD1aqbgzlzLdTMgFt7Dy88cE+rns1OWhLj4haQui5O8yLRPLRSkvAYDixB
 698K6LdIDWytp8GwjFaPJyKg1f8IEeCCpsbkX2Onw0/HHMOsizeZ82HK16fVaopa8j/P
 BsWJ/AZbkJKAYeQKXN+amzmOThJeTXmOM6aeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739930687; x=1740535487;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yyPGs3BlQOq8KbhcEcuJ+BreaaNTs/+pIZnQkzu1RQ4=;
 b=NxVZ3RzNhvWyNyg6+wsLrGXAjpZGaFVq9LBbDt4SGA1UkPIk0tgm1rf+mGnycHr53l
 5UhVP2ahyQ06N0HJhy/VmF/mHlv1gWkpeX1gw5FZZXcCGW/dJ+1UD9k/c6PkpKzGz9AZ
 FTAvSvPanHsnl7e4SrN1yedYwvgsnpWDuBw8HvIWJPmig6BRTFKouiKV6DpEnaXuok/g
 qzUPdlIYexeK+/Kme7n4+b4jX0SWIfmfkLSooNMy2vBXNP59yJqOwugP11s+3T3t5HmI
 JOXHz89Bq8LiwZOzkuwChHsVvgqq6rrSkn/C/wT7NlPlo3iyJt9Bp1Ptp0CrqVRmbksc
 W+Ow==
X-Gm-Message-State: AOJu0Yx86iqaZAMgVoao5LsTzYjDesPgeTbPR9XlQZ0BeJRyjjkS3kWZ
 USu/gKl//EUNf7blsVMjnjMB4UdvbXXJvzwjj7f6lUlNyWwWXEd1aeeDcvaymGh9ZVlJbZPLHVi
 Y
X-Gm-Gg: ASbGncvYtgJkoxtnjDuiG7FtHWdTjsJwkqmMyi7Jo9X7i++aiVvyG4rVdNTmjfvreZv
 bTV4+3+eJANHjZQzESfNYzCYu17JkHBBUWSqc+f2CFpx7bId04Lr6DViHjAXUwvXCyC7kOliveS
 VY7p6+gU984QiPBBMcB9iFhaVnBnxpiVUqJkNSNAEumwvln42u6YQ5QcRc++ATKl7GW0ML1mXu0
 ZzO7ek7B0NgUQ2CNgqUNDHhiQr5PtKao/RgbIBRXZdXEYaIdlMWMQJkxqMLGKXilUZyrXw7jrpA
 QZVCXY62l42w
X-Google-Smtp-Source: AGHT+IG4lQKpYDTjzmhzn5YnqamCOnHQFYFOnLWiIhtxZZYJ3mvDAo1hGXF9Wby2M199JRmukVPOcg==
X-Received: by 2002:a05:6a21:4d17:b0:1ee:ab52:b8cc with SMTP id
 adf61e73a8af0-1eed3b595d1mr3285247637.21.1739930686920; 
 Tue, 18 Feb 2025 18:04:46 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ade1c7a675asm6365064a12.48.2025.02.18.18.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 18:04:46 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250209143409.2765303-1-trini@konsulko.com>
References: <20250209143409.2765303-1-trini@konsulko.com>
Subject: Re: [PATCH] u-boot-initial-env: Add missing dependencies
Message-Id: <173993068591.1662848.6032591073257964.b4-ty@konsulko.com>
Date: Tue, 18 Feb 2025 20:04:45 -0600
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

On Sun, 09 Feb 2025 08:34:09 -0600, Tom Rini wrote:

> When performing a build consisting of only a defconfig target and then
> this tool, we were missing two dependencies. Add them.
> 
> 

Applied to u-boot/next, thanks!

-- 
Tom


