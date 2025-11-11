Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8469CCCFA1A
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 20:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0D9683C01;
	Tue, 11 Nov 2025 21:15:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A6N6RLHt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5223783BBE; Tue, 11 Nov 2025 21:15:08 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE31883C04
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 21:15:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4503ee5c160so40135b6e.1
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 12:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762892099; x=1763496899; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q2i2tdd7mzi4dL1tx67TSd4TrNtK1WEnWQD9VZ5dqJ0=;
 b=A6N6RLHtS1F5Dghl2ifJyLfvvR4jRmrnQYOY0GdEk5nOhwe294if6DdJNbTmCWgo3r
 6bFi7s0bZjjKf+geOSIRP8mrEyOQEa9Gdu1ArrUWiwsXF2eEsm0C5iAjav0Gq8brDdxj
 0P/NXX1T2DDi4P6G1dQIQPyLWpLPxWl2ZqBfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762892099; x=1763496899;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q2i2tdd7mzi4dL1tx67TSd4TrNtK1WEnWQD9VZ5dqJ0=;
 b=QlDqyd0ro2TsI6ZVjiUIZ4/Aa3QGIP+bMBW8bulh0E3e6qc6c0KcFn6TZlRLP7wHlx
 MfNyas2HKxznXwbhvAApfvt/6voEoZtc7ZL6AFttxUdwlCmMHJ2rUdezI/mNrwuSCOmw
 b4ZuS0C7huktwFrrGxGIpoZLGogvuty2CFTlxzlPxOADAF0Up5p6s1dGW4+xe9PN+ji8
 72DIamM+H73ee66Dze0tZQmQ5wtitWxseC4TgM0IyftTdPQ+YfPXj3we8XJGhsZ823bA
 fecw0qLZ2CHLiK/2Kq9z2pB2jkL1nxvuXz5Jeizw+lXMmlH8LQ+9DJIN6dVKN2r/ckn4
 znQA==
X-Gm-Message-State: AOJu0Yz+G/tCLnipGf4Hcox4AqAm0xWRQM09YD2j1c8uy7m8g6QNnbZ0
 4D8USL76A8wl47sPqcqbdAWeMeM1Nx0n28aGR8BOWcsPb4e1Z1YJwpIXSu+1GexFzrGGPUF4Y2J
 bECyi9X6qaQ==
X-Gm-Gg: ASbGncvPAoAvu+mkuG+5fjU6cgeyBX+1O8AlC477x+SpEL0y0A9dkQRVln4oIkRPOL/
 rl22gFoYn/vfITGD73S/w23hhNG+Jjo/SB5StYU5O/jbifK/9hhpu3XVksSQWOBTgZt9RTP8rYZ
 bBmKGrT1ARBhwfjTmQ+G6hWSwKs0eJTr2XKVgcdMGYeTa11C2pfQgoJ6VRGvwXS+EOiEF+oJZFd
 vqZD+684urTa1FMOA4Ot6YPArzqdIj3lx+kjtP48I599ULpJx60HqR9tYsRTKKp074HgAMtBPx5
 3LIAXO6n1893UnO3nNzQPkLA68WnR7dPvOScFBKlQ9UcWk8A5lAEuC4HJKwLUwpUWK4PHg0A186
 M9y72BmK25JVX/XDUjNxXaU9+ii8vA3KwLZWiVL5rxs55TKsz5XBcEPVX9Ey0KaqRJ+HKy2bgel
 caMUFGcOzxxKfRUh4147r68WNQC0zUUVKcUhDPNi3Jc8ACMRe7
X-Google-Smtp-Source: AGHT+IEp51eAaM+6KWGCNlxPtHkSft+iKCMzqnMMScgHBGNBRLHlWsA1xgluP/y7r7a8WvCQv9sglQ==
X-Received: by 2002:a05:6808:3191:b0:437:dd6e:6844 with SMTP id
 5614622812f47-45074611854mr224666b6e.38.1762892099437; 
 Tue, 11 Nov 2025 12:14:59 -0800 (PST)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45031835261sm4197443b6e.16.2025.11.11.12.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 12:14:59 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251109184551.41457-1-marek.vasut+renesas@mailbox.org>
References: <20251109184551.41457-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] ARM: Fix HAS_ARMV7_SECURE_BASE help text
Message-Id: <176289209884.737015.7757022721526740561.b4-ty@konsulko.com>
Date: Tue, 11 Nov 2025 14:14:58 -0600
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

On Sun, 09 Nov 2025 19:45:41 +0100, Marek Vasut wrote:

> Drop the 'a' from 'ahardware', no functional change.
> 
> 

Applied to u-boot/master, thanks!

[1/1] ARM: Fix HAS_ARMV7_SECURE_BASE help text
      commit: aa99fc54ed6177f25a6d987dfc8def813784de50
-- 
Tom


