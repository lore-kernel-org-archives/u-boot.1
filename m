Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5E1C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 17:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1556D82C8B;
	Wed, 30 Apr 2025 19:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qcc0gwa4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46E4282C03; Wed, 30 Apr 2025 19:03:50 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 294FC82C67
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 19:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3fbc00143d6so114840b6e.3
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 10:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746032627; x=1746637427; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1HWwOKUTRQiO7yAe1zQKbOwTYbeFPM80AP9O78Ck38c=;
 b=qcc0gwa4e/fuz7mevskx+BK2NzviRbyC/BnnZIZedUz+8434m53v34YkMvyqJDTQ3k
 D82dfX3Pwx9xZ/Dj1Mv9lpPFYiJVGyQs6MTobuvA4y0ecvFsbforZYOHbc1FvpqIfzfn
 lmBl05Tw+eZLZlwhsl3NN7okG18kAW0AErLNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746032627; x=1746637427;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1HWwOKUTRQiO7yAe1zQKbOwTYbeFPM80AP9O78Ck38c=;
 b=IISzJMQlXddu+ggH6keMTLURbY7STa6OeuP/jocmvdPKiQZ3yXKiH8BoA67W1ANZZG
 o/3tHR+5XO3bQhpqgueeLnKJWzJBHzu+AJR/YSNMG8kGbBMn32IJ3p1Vf3SRnyZy5rHd
 kgoLXqG3Exf3dj7bfvC+mrmIB40/Xsn6Xss4aaR8P/pvpF16bTFl5TgL9dndUnc3zFA5
 XFTuWyjtmIrCrhff3SdJUEU51LCg4m2BABn5KDKwdOf8324jYVoEQQiProqXGCA573oz
 W53s3n6WFnl2FUSqZcqn3/HvxW/wP1Wf3yuxlX5vMLKq3CYt9R3oxAu9jV3ZJca/DUnl
 60Wg==
X-Gm-Message-State: AOJu0YwPzS9UzM5D4ft31qdbgSxdOUNUCPjXNz1EWbQew280d23/9U27
 u8YLFp8J5HMT9PtzYSWBrApmBso4IVINnEj8cOUvMecB82y0x+KqIdoPkqiN7Vc=
X-Gm-Gg: ASbGncsmyqc3CpWQFAgxxkQp2E1M8HGqM4mgzNqAy2sz3LDUw+Z5XoF7qcU1cZ17NzT
 /9h9qftj8PbgirPekiL9tN9A3OIgFQW50/57DHnhCozBiosad5qJkJOxVHmkOzJMuctqVqu5T6q
 +zKZINsTyxhfdJOcuiT7ZWTCSKfaUI/Ax8DRWy85TtPcPD9VMOzUTad8Yl8sa9ksQ3y59gqshZT
 +YErMIRzzCLt6afBLjsh7Cd1YK+tbwi4GldIPScai/xxdpIJ8NL9MgIy1SCW3YIK9se3q50zgx0
 mOZv8AU6xRLsyo0G6u1buVKE3RcTLxhSMC+R3z2bo2CqCt41fV3pjMSNFWLh83sv1VPwu/Xy1gf
 /
X-Google-Smtp-Source: AGHT+IE+ncleysdqnzzAogfZn3pq63fDgPb22ITelFGJYUYT9gVW2JdGdySm82kgbtXexlqiFac+Yg==
X-Received: by 2002:a05:6808:80ae:b0:401:e95b:3b20 with SMTP id
 5614622812f47-4024394c839mr2696794b6e.26.1746032627015; 
 Wed, 30 Apr 2025 10:03:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-402e1c102c8sm456111b6e.16.2025.04.30.10.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 10:03:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250429020424.48795-1-weijie.gao@mediatek.com>
References: <20250429020424.48795-1-weijie.gao@mediatek.com>
Subject: Re: [PATCH] common: board: fix build condition of noncached memory
 initcall
Message-Id: <174603262618.1760506.2923411380935003761.b4-ty@konsulko.com>
Date: Wed, 30 Apr 2025 11:03:46 -0600
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

On Tue, 29 Apr 2025 10:04:24 +0800, Weijie Gao wrote:

> CONFIG_SYS_NONCACHED_MEMORY is defined as hex, not bool. It should be
> replaced with CONFIG_SYS_HAS_NONCACHED_MEMORY when switched from #ifdef to
> CONFIG_IS_ENABLED().
> 
> 

Applied to u-boot/master, thanks!

[1/1] common: board: fix build condition of noncached memory initcall
      commit: a6da395b5d68ad0e644e0a70665274dc60ec2056
-- 
Tom


