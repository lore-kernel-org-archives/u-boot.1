Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32F8CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 19:30:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EA2083642;
	Thu,  2 Oct 2025 21:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TcUcSctS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 127F28366F; Thu,  2 Oct 2025 21:30:53 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFA7381D6A
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 21:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-92b92e4b078so58518639f.0
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 12:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759433450; x=1760038250; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pkbrw1uUF7vV+Ki+A2gHKgAULMTeRasQu9NN6YFROmo=;
 b=TcUcSctS4EBvIMW0rJW8uI1+ejntrRH7690OK+bTJlbKZzJA6ja/NIKGqGe33Q25qP
 rGEgdQy/1Sxa/vdXuUbC6EZrCANe9dMyRVT5AjFf51Xnqz4H3HKgAxcm2c5lJKVEVxTD
 sEds+6BkjjnJHRnjvsu7+HCDNNfYbI+ErFibU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759433450; x=1760038250;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pkbrw1uUF7vV+Ki+A2gHKgAULMTeRasQu9NN6YFROmo=;
 b=pcIhlByd2ROVbXjH7uy7ffwPyd+1KRA1lfX2LEpB65JZ1A2ZA/MtXLX2FTifCCt4+D
 cuj/2/4cdT9xg69gfvURSJHp91HK5LJYW7AJk5YTGYGrlmaktZAzZwdn2eG/+Rc3PQyY
 sok0P7AC22e1pwTeV04K6s62WJEm1IzfSvagRY6xaVVW7RbMMdQFaHl++55R2QRCl7k8
 zJYQXoHyZaBKppCPXcIEpj4Wek43KE9YqyEYnXYLEdGF35m5p+0VnVRD8y0rwY1coFL3
 NtZp4pgzcIZVwLIgHH73Cx+iynWT5uDV4//4GPqA8PKkLUQgqOn7ZzjuTY4QCGTF6StT
 7CGw==
X-Gm-Message-State: AOJu0Yx5HZE2UfKgIbXZYdGFa1R0fvOS9aM6RMUuyUcbnFzmKW4+wSiT
 D0cG3XkWfOT7VuP536t4Qw+afgBfnzA6pkIcETQKhLngoh/FW/0VcAG7YcSafbdCPec=
X-Gm-Gg: ASbGncuqKkgYzwUlC2iSHaMBsWhKZ8aFMCllS/Jdcj9AoInLk9J+GUktBY4WKY3thl0
 E6cyiQEfXIwmIqdwPiMwE4nI65/er/uOEcebz0fa/k+bUqlXv0fCBnc2x+CQzRlVTa4QUc7QGdj
 do2I8OZJkwk9N2hMbjbj4khSMxe6WyURVDM20SEeFagEqA4N3nWTTxIjgHtCZasZuIlp0O9xe4q
 T9xEOjGGOqxqkgw0tVWVojpDwZXh1Cax3ZrUDu81sJg4a7qYDIFeB3zGx/bFt9abxh7EiK8ioXU
 BeUWjvS8AzraqWyCMTy0feVoZYdQRKRU+JVy4wJKx1UuYHDMoplzlMn714NR/ZN42Dt6Jwu8TxN
 MHs2Wf4bJEm0EIipUE/yUxKEwnW6/MZaIDquxPBb4/xOOJL2V3+s+aGthsuxbmg4AVhtikSNI6p
 zrhz5pS0mh
X-Google-Smtp-Source: AGHT+IEhVHMUaViIeJ5aZFam5kpY96eZ39MVx4ob1V+soMO8/A8Hrgz5IeSCn/3MUnK6zOVlxps5Yw==
X-Received: by 2002:a05:6e02:12e4:b0:425:8d77:547f with SMTP id
 e9e14a558f8ab-42e7ad01ea7mr8387675ab.5.1759433449522; 
 Thu, 02 Oct 2025 12:30:49 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42d8b2815dfsm12760755ab.26.2025.10.02.12.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 12:30:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@amd.com, Marek Vasut <marex@denx.de>, 
 Michal Simek <michal.simek@amd.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <493603eba5d4eabf2b281e1f438fd19fc0587712.1758557017.git.michal.simek@amd.com>
References: <493603eba5d4eabf2b281e1f438fd19fc0587712.1758557017.git.michal.simek@amd.com>
Subject: Re: [PATCH v3] env: spi: Fix gd->env_valid for the first write
Message-Id: <175943344786.3005247.6569559018771779376.b4-ty@konsulko.com>
Date: Thu, 02 Oct 2025 13:30:47 -0600
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

On Mon, 22 Sep 2025 18:03:39 +0200, Michal Simek wrote:

> When both SPI environment locations are invalid (gd->env_valid ==
> ENV_INVALID), the first call to saveenv writes to the primary location and
> sets the active flag. However, the logic for updating gd->env_valid
> incorrectly sets it to ENV_REDUND, which does not match the actual location
> written. This causes the first two writes to target the same location, and
> alternation only begins after the second write.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] env: spi: Fix gd->env_valid for the first write
      commit: e589d5822cac10915ec04e8d9044d2460aec8924
-- 
Tom


