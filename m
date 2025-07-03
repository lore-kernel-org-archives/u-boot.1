Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DB5C83F03
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 16:29:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E71B082F49;
	Thu,  3 Jul 2025 18:29:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NU4zIFyp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED4AE81D5D; Thu,  3 Jul 2025 18:29:37 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D843182063
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 18:29:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-73b1b1b3cb8so35514a34.2
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 09:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751560174; x=1752164974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ut9sCETdCyI+o6EBE6MD7APkTO/1/P8XbHj2iS2j0aY=;
 b=NU4zIFypK/jWUzq22FBlBmcQ6TFAAylmVmmFQ7aMbtV4juS76anTBs+DecOxqCYqpe
 TTts3P4tzp7O37Ox0rT4W6Eh2iyey9t9oUzrcMvg0rIsV7CJTv7PnIIjj7OQlAD77NPX
 M1F8XuiSAcqUWKVHE+b+bz0tIFE7xKw7v/f7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751560174; x=1752164974;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ut9sCETdCyI+o6EBE6MD7APkTO/1/P8XbHj2iS2j0aY=;
 b=DiHG/ak2DIDZIkUThAJ+XUAvZAglC3F+U8BOa8eefFJJbK8GdB46uEUNO5x2ylAGdR
 Q2Z/FWa5z9Qlpwezqd4w6VGQywyHKpn8B1/jXWcgFGA3QimY3uSB5Uymc3SWMEwLbrF6
 7jj5kfKz3VDqZRAoYfooTinTlI3j3qCYiPciQsBZHzL1DM6tL5wVYt/MjxhajpcolgDS
 8BdDzfAOdA/GLJZYyphigfm5hIg8WBR3vGsay94u/oFLWXzx7XxlICUD3MMo2say6cJA
 2dpkf32mhShWXl4lILppmZ7pBBb2cbXh6luxpNP8VWKdZENW76uXBZA4TIW9a7cbD8/4
 6ZjA==
X-Gm-Message-State: AOJu0YzPJBeU94btSXEA/ZzudUeCwnCo8Ue8LG1eqQRwQZwnROyhox9L
 5CPXj9Qwp0ULB7XarIlDfSYPTQCJlHSgwpMw+eYG5Rx3S/jukw5F1ecN1QWT+vYsIjqv9B5xxhz
 gDttO2+w=
X-Gm-Gg: ASbGnctg0F9gLIlhiIbnl+/8cYw2pfd9k7rQzErwFlvkS9anyeAGE5hNmmonPVtMMU6
 f/Huc1xxRWZLxyUSpeZrnSLpuNoNqrO17ZQ5n1Y92rb/q8nkhCOX+bH62ijsi9V33cqFEADx24M
 QABvkmZ8qgoyfH77vll162qd+ToJGtYjNC0Ml+bxHE5lWHhJuDxjb+p56hCjtejHdLH2cUy3LcQ
 hImfQ9GYyCDXM5+19ZLXnbvMVz8mSSJLtIFekhH9bCHuf/MtpaXK2oeQgadkyDj22ZfhKyxCc7r
 uOOxy/6abocyT1GfKvEo0RQdto+Shvbcj8WJiKN92jKRirfqKr7XkSaKh/WkC2WaEBLtk0s1b43
 jh5/dehW/F1C6hIeXgLU=
X-Google-Smtp-Source: AGHT+IEiuUrZrXjzIuZtg77LBqLRsWTZ7GFsQNmXZcTDIp1eHzfoQRl6eFDBPWsyiJ5gVRuJU8U1SQ==
X-Received: by 2002:a05:6830:8104:b0:73a:6eb4:e8d3 with SMTP id
 46e09a7af769-73c89625b1emr2668939a34.10.1751560174422; 
 Thu, 03 Jul 2025 09:29:34 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f7714c4sm19400a34.28.2025.07.03.09.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jul 2025 09:29:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Lukasz Majewski <lukma@denx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
In-Reply-To: <87pleh4b55.fsf@kernel.org>
References: <87pleh4b55.fsf@kernel.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-next-20250703 into next
Message-Id: <175156017376.3012248.13402196931900559534.b4-ty@konsulko.com>
Date: Thu, 03 Jul 2025 10:29:33 -0600
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

On Thu, 03 Jul 2025 16:11:34 +0200, Mattijs Korpershoek wrote:

> Please find the following fixes/developments for next:
> 
> Android:
> - Fix uninitialized vhdr pointer in image-android.c
> - Fix uninitialized vhdr pointer in abootimg cmd
> 
> DFU:
> - Update maintainers file to include spl/spl_dfu
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


