Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7F4C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2C8D840F6;
	Fri, 11 Apr 2025 16:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rj8L+nGs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96FFD84006; Fri, 11 Apr 2025 16:48:59 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A57F840C9
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:48:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-72bccda48cbso1333079a34.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744382936; x=1744987736; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNfEyG8aNOGWosAjJiKJRcOQO6roK5qmuUAFNXqOup8=;
 b=rj8L+nGsNZlg+++p1W/Q1emZ2NlOUFTC7+fK4J1NwdfPdWxjRmY3Y5UAP4eJw4Y0Gz
 jwXct1wpULR9ia0ScCzG0qsW9HmcyOVdEUnnUrQ13+Apn68YA3/+BT1RZDdI7FW7fXPW
 scqS0ohnxQTj+TmRfuo3s+84TutnJWBipH1jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744382936; x=1744987736;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mNfEyG8aNOGWosAjJiKJRcOQO6roK5qmuUAFNXqOup8=;
 b=FQ0LNQAqdbQU67Tm8Pp47m/QELy1mPTAwRizk1JLMSda9QmEvuM7NT/OpzqdN1RMbC
 2w2bQZxfC1QOtt9xMC7GdfnUs2GQ1gDUITc4j8OHvCIVsJutx9Nw4xzVAGNx7OEpdMtK
 yfXCJmA8lD7FO7L8QXt7p8A+BiecJvImtV1TzPiE1pLNOPVnxtsuYGgL04wMJQHyrtMo
 vwgsF9ngl6Fbh9MZECfN/kzgZMX6dd6HuWH1NN2lril323dWGqOlxMXVElvau1OOwcP3
 mrRcnBNmRgt6UiAusZhjpYVQMj06LaUb5e3mGoxJuUvFmMAKbbOtqV4e9yvc7zSI0RQr
 YWgQ==
X-Gm-Message-State: AOJu0YwMMF+IGUqv6xML4TSM14hEEl2XKdE/f5Kk1jHIYkHvm2yCCJ2f
 dBuVLDxiNys2EkKZRhgHdQUtwTs0Iwo3I+P/NvHUrbeN8KI/KfXDR3l5VtoSNLQ=
X-Gm-Gg: ASbGncu0fnWp4JkVIHpRoykGxiLxXjoyLa+tS1J4y8kzbXlFSAj2zA1q/fULkpteDMF
 RbXUPQE8Z3aUhjVW50iIOJI8Qdu2QcVAkM/2PfLRY8K258cTX6R6MHLkM4xoqFI44HZLHxTl/p3
 IAZ1sjRJD0PWBVpUyoO5vsKOVrlB9v5bsuWDpPEpuBTi9tmhh8w/ntq5h2Ov4k1CvGeAdTrRJ3v
 ICzJdb8Xewd7GosAAeS8g68BQy5Thks67NpPf9GqSNPqxnOgL178NAf5hr/tMlNwjLy6V5RKnlD
 wlOni3J27IE57vxhno8WeijsvNj3izUt1ZE1Z3NGdJGGA/c1qqMaLvEivaUb21FdzN1dxFW7cmw
 E
X-Google-Smtp-Source: AGHT+IF9WUZLQO+fAZ+65dWLrsA8qMJMtHfuwqiLB80piu3GczIpsIHzztE0Ark30IumFh4GOWbPaQ==
X-Received: by 2002:a05:6808:1a0d:b0:3fa:4418:679b with SMTP id
 5614622812f47-40085042d8bmr1720906b6e.13.1744382935965; 
 Fri, 11 Apr 2025 07:48:55 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4007639db05sm954732b6e.33.2025.04.11.07.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 07:48:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Xu Zhang <423756212@qq.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <tencent_1860C63CA04A383E29D25FC5C59DC5C2EB0A@qq.com>
References: <tencent_1860C63CA04A383E29D25FC5C59DC5C2EB0A@qq.com>
Subject: Re: [PATCH] armv8: start.S: Subordinate CPUs psci setup vector
Message-Id: <174438293525.3201192.13294329410924119220.b4-ty@konsulko.com>
Date: Fri, 11 Apr 2025 08:48:55 -0600
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

On Wed, 26 Mar 2025 09:44:12 +0800, Xu Zhang wrote:

> As current design, only Manager CPU called armv8_setup_psci() before
> jump to next stage(such as Linux Kernel), Subordinate CPUs also need
> setup psci vector to handle trap request which comes from higher EL
> level.
> 
> 

Applied to u-boot/master, thanks!

[1/1] armv8: start.S: Subordinate CPUs psci setup vector
      commit: 7c9f8680c16e7a0e1d2afc6c2542e2555eb6bb3c
-- 
Tom


