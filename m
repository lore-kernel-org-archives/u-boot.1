Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3881C369D3
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 17:42:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BB068129F;
	Mon, 21 Apr 2025 19:42:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cE1CGLru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B403817C4; Mon, 21 Apr 2025 19:42:10 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 422D681026
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 19:42:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3fa0eb29cebso3177158b6e.0
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 10:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745257327; x=1745862127; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DBx8ZQMBhJYpwtCd1HX+sDO8CCoH/pwmGCiCv37bLDY=;
 b=cE1CGLruNia7rC2wbiz9YGpr2cE+8ACWLuuVnK6hjGzDx3o3m1XiGJGehHj8ktZFpZ
 tEuDn0Ts5r6ca4foEHMmfMOYEcGaqs+RtRU0px7AVYjcVL19cqDwlxtL5a38NacHZJy/
 JXhapGmEuHjTEy6It1dR2MXI4bzaRTRgvZhmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745257327; x=1745862127;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DBx8ZQMBhJYpwtCd1HX+sDO8CCoH/pwmGCiCv37bLDY=;
 b=ovgAm9zGzcgNb9YtAiQ017YYpmSMtXtgSRA4GzTwJsFJRQJ0mz/CI8HD1pfMi8npQP
 URy79u0CuJAj6itssC7u53Ml4gXRoYM87yPvnJRn31SIaMc5dl8tXV6wCG1tOoatzhyy
 ZlflIgO5Z8+CkdSd4dckV3te2iuBmTpZJb+p8T7lqTFrnE4SvWOcF8s0Scy7ps+0zOPA
 Q3TwrvMVFb6yOWKLGAEBb8cCJjUizktCu57hd89g8y6va87GqpTOxexOpIfkNVZ+dvJU
 AIgh9QrVXeUZmp6G1JTaO58NaACKy5b+yz6I7Ey/5eokVin6BALFcvo7gHzW43PRkKsc
 eSdQ==
X-Gm-Message-State: AOJu0Yzzt5ixJX6dHl/s+qKv+aM/X1M0MAyv0mwj1TZM4dgmQczKPHfm
 R/aF/VG6ssA1CszI2cKM4tYXBP8XGT0eCcNvJr/scv7kPJscbwG7DgrdyDXPc2Y=
X-Gm-Gg: ASbGncukqwzB9XhPs3t7+OSknKpukTyxvrcelRdcIznW9x7RIC2ajErfBwYMY1DsOSQ
 WBotQjazkFDNBQiGn7y246AJ+ezglYdvvjMZmVOcfZ6YT0d1PZ/bDnQ6/JvVT4N8imta6fMpIIT
 VemxZMS4RkzSwMZyuh4BNyKc0M5ZIZ4YJ2rGuGXsecoFcRnWiZoRtNMujzaA0zeGFtzwCM23lN0
 ppKvyjhzeF+9nnY02YsTINrW/OwZ5UQZ8jQnUZYkzkvoes0c2z9O1Yf9/wRgfMA71TIbBfc+cic
 z6iy0PB+DSquLqCszdRQSAU+bbZwIpFQn0kXJP9ytEtc5iBoxMj0zmscP0ydyo6H9CVEehQvJFF
 C
X-Google-Smtp-Source: AGHT+IEmM6s4T8do1Wl93uZCIM8MzK0Z9zk8DI/8GSeIe5RMNvthdeLDttxrfhTbHA4Btm63TOiGOA==
X-Received: by 2002:a05:6808:ec4:b0:400:7dd3:2dbe with SMTP id
 5614622812f47-401bcf4bd3fmr7991020b6e.14.1745257327045; 
 Mon, 21 Apr 2025 10:42:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-401bf09d018sm1611324b6e.43.2025.04.21.10.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 10:42:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Harrison Mutai <harrison.mutai@arm.com>, 
 Manish Pandey <Manish.Pandey2@arm.com>, nd <nd@arm.com>
In-Reply-To: <20250415215034.1679664-1-trini@konsulko.com>
References: <20250415215034.1679664-1-trini@konsulko.com>
Subject: Re: [u-boot-test-hooks][PATCH] Add support for FVP emulator and
 fiptool
Message-Id: <174525732609.3657668.11704133961918317550.b4-ty@konsulko.com>
Date: Mon, 21 Apr 2025 11:42:06 -0600
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

On Tue, 15 Apr 2025 15:50:34 -0600, Tom Rini wrote:

> This adds support for the vexpress_fvp platforms. In order to do that we
> need to add support for calling fiptool to update an existing "fip" file
> with our U-Boot build. We also need to support launching the FVP
> emulator itself. This is a little tricky in that we need to use "telnet"
> to reach the created serial ports and cannot just use an existing
> file descriptor for our needs. Finally, we add in conf files for
> vexpress_fvp to make use of this, and a symlink for the
> vexpress_fvp_bloblist platform.
> 
> [...]

Applied to u-boot/u-boot-test-hooks.git/master, thanks!

[1/1] Add support for FVP emulator and fiptool
      commit: 0d8c51967901ae52c79ebe5180ad36fcac23b705
-- 
Tom


