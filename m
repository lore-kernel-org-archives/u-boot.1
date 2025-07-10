Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77ECAC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 22:44:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE6CE8384C;
	Fri, 11 Jul 2025 00:42:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RyDGjD3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26A7E8362C; Fri, 11 Jul 2025 00:42:14 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8848E83744
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 00:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-73a4c557d47so699562a34.3
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 15:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752187330; x=1752792130; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yo5S9oZXPs2QRtf1RE4dXDZXicVIWDXl3sCjuIzhwtQ=;
 b=RyDGjD3MtvO0QT3hRBRggTHyKaJFtqQ5X7O8iRYP75Muc9uCAjrdHEqq/6LpruP56l
 gTITVwKyGPzuLt0a75IRwDMkTTAsGNE80LdGiL1gxGv9wg+1N+v9awAYwiffUh647J8C
 F13DT6wWBISgC6BSXdMLkuZV8xJmYR7BAWM0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752187330; x=1752792130;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yo5S9oZXPs2QRtf1RE4dXDZXicVIWDXl3sCjuIzhwtQ=;
 b=bJazhEtlIyQJ/jRc5rLl8hmrvsdtyoDxz+kC4HTLBnVL2jebVe4keumQ1InimloLZK
 fVgNiv8cNVLHiYmyAGLbGki2FO0oOsj0a6KkiqXTFj5axDo8wh66aLULOOK8BDaQw4ZM
 ZC8sPfhFEN7TjXYmu/wnBt+WZUUry8jGB76klXuoz4W+gMbLhGKhwkRKzvFw3fYNroxE
 eOLXBT56U6ri+EcDY1ZPMN27hPLbdniPQ6bHVftV/kdWataE/LilRnl3JouBir0y7kGx
 mko6e0wQaqCAhuF0rLYFCNbPlMGF+cov6sJkV4uUCYI/wu/2Z6vee0CPnWs1eD+5fRik
 k/UA==
X-Gm-Message-State: AOJu0Yzv4xYM7IWoaHLrx/rMSGL7t97ROB5dDRb0XUf1HA/TThM9//i/
 KgiGuIXfGykQHYKy6j0x+bbeUOKvcnc+3rvgRaT4BrpFIINhWpxv9G/OzsQAtSyTKgVAnjTzsZy
 VYAWPcAU=
X-Gm-Gg: ASbGncvZaModTtuxLDxQbwsWztueE+oyIcsSR3vvZnE7YEcMO0vAfl6WEireBFbLf0U
 bgW9ENtPmSpX9cAeTdF5Tu+UfbZPwPp1CwEikJ86n8/gHa73xauYm03FRDijR0BBuilwt7tp5ND
 DWSJOizsveQNvFdXr+uGRhH06MHsqBSnpQ8OTj7g2g2rPfs+eQavbZbxB1khlqwyWr3M9p+GvPv
 vW+SYAyI9kmdEJdjTXlmd0E3WA66tmZ1H5HKlac0j/SksoTs8CS69DHIpDjWCyAERLnr7rOjVbw
 JGPy2bYR9bUD82aFNyrLY78rQl+0VkPH7b8fZPiRuJxQfZj8swo4YzJVbYPxg5ltbw/HOBJehr/
 2yKxRtxOKC2wqtL0Wdd//YOBMueaUor9Bk05FlHjcs2dZTZPRFTGVXyM=
X-Google-Smtp-Source: AGHT+IElJn1bp2hwyZKZTmW5oVpewV1QPMgJ0tcqgz529Kv17FPNbgBMti4bYcvDbcYwIJj/PfCuhg==
X-Received: by 2002:a05:6830:6995:b0:73c:fb75:d571 with SMTP id
 46e09a7af769-73cfb75d7abmr282500a34.22.1752187330272; 
 Thu, 10 Jul 2025 15:42:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12b745fsm357354a34.64.2025.07.10.15.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 15:42:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng.cn@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250702-nvme_fix-v1-1-a0d023f4305b@linaro.org>
References: <20250702-nvme_fix-v1-1-a0d023f4305b@linaro.org>
Subject: Re: [PATCH] nvme: Fix memory leak on error path of nvme_init
Message-Id: <175218732941.2073260.9495590052004142340.b4-ty@konsulko.com>
Date: Thu, 10 Jul 2025 16:42:09 -0600
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

On Wed, 02 Jul 2025 17:02:10 +0100, Andrew Goodbody wrote:

> The use of log_msg_ret to log a message and return an error meant that
> memory allocated earlier in the function was not freed on this error
> path. Instead log the message in the same way that log_msg_ret would do
> and then goto the cleanup code to free the memory.
> 
> This issue found by Smatch.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] nvme: Fix memory leak on error path of nvme_init
      commit: f074616014179eefbca6f4b86b1fa6336711ba80
-- 
Tom


