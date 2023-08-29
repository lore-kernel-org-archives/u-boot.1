Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3394BC83F12
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 14:14:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 789F8864FF;
	Tue, 29 Aug 2023 16:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PRTY3R/t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F9108647D; Tue, 29 Aug 2023 16:14:17 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6AA78651A
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 16:14:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d749f57cb22so4177133276.3
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 07:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693318453; x=1693923253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C8qXoU2NXpm1q8YSU301UzP9sTT7J1IxaS8b2QCJyLI=;
 b=PRTY3R/t9bibHsUiZ8Ef7O2X8xrVXrKkxslV0OSsD65kJV/nyZa1Az9e7klnqQHz6r
 H7baWRcM1sHXWAbTvd4UUu2UkTT/IuG30OGvxJAoJBb1BW12x/u0bSKQm7sCiMyATUnS
 xn2xYFs2lOcNZPSWY1h9SwWpTRFCGS3REtEig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693318453; x=1693923253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C8qXoU2NXpm1q8YSU301UzP9sTT7J1IxaS8b2QCJyLI=;
 b=gguNZp+KNHUx9K6Y0Hs9ibvQm3CsGCAYtZ9NioV+se5HBE6HrxOYz6qyogxVnKCm5N
 jfDrsjWr2RXJ3M1fXQzW+7YAisB7TIniP+KVx8kQNb/RMV9qPaLHmE6O/yrx42AOfnUj
 RKj31n2AA2FCw0PRlTz9K3CjIi14y6Aa1oSHYkWG9O7pIZfonkSPidwVJYzEzLhRXjBe
 8UkS9gou/UjckMPTJgupRLt87kfnxMI97VpVsRwVXM7uS8SEVBe9Awxd5yPKG5tetPoS
 meSzT5a7DD4ANpihVoFgdEH0eeGLsmZCc6s9iWJ56YpoIoS4jJRMrnCmOe9GmxvKPUXP
 daeA==
X-Gm-Message-State: AOJu0YwOPFjAUt4J529f1NPsv0VzLfRCU7Mg1684rqXtZT8kPfZ3PhxL
 O5cXShJbyNLLExL2Ik5uVQCS8VylXo0LgPd6pI/VJQ==
X-Google-Smtp-Source: AGHT+IFy4uhyF1TiZSEoQVHgBoCjdPsJ/qWA2LDNt8mUIyh0/sbMVCO79gqn22HEt0bPAUUG94I+ww==
X-Received: by 2002:a25:5504:0:b0:d77:e0d4:5ef8 with SMTP id
 j4-20020a255504000000b00d77e0d45ef8mr14697895ybb.54.1693318453341; 
 Tue, 29 Aug 2023 07:14:13 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-4165-1a0d-2d73-76fa.res6.spectrum.com.
 [2603:6081:7b00:6400:4165:1a0d:2d73:76fa])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a25b112000000b00d77bd2fe760sm2204990ybj.27.2023.08.29.07.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 07:14:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@xilinx.com, Michal Simek <michal.simek@amd.com>
Subject: Re: [U-BOOT TEST HOOKS PATCH] travis-ci: Do not run TPM tests on
 Versal QEMU target
Date: Tue, 29 Aug 2023 10:14:12 -0400
Message-Id: <169331842918.3627164.9948982994480056113.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <add78a532efd5b822fe272f6440d923042b600f5.1693232991.git.michal.simek@amd.com>
References: <add78a532efd5b822fe272f6440d923042b600f5.1693232991.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Mon, 28 Aug 2023 16:29:53 +0200, Michal Simek wrote:
> TPM is going to be enabled by default but QEMU doesn't model it over SPI
> that's why disable it for xilinx_versal_virt_qemu target.
> 
> 

Applied, thanks!

[1/1] travis-ci: Do not run TPM tests on Versal QEMU target
      commit: 3c736fb3a2c81d3ffc2ae22d3ee264651ad6a7f9

Best regards,
-- 
Tom

