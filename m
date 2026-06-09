Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7463ECD8CB2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 22:29:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B1BF849CB;
	Wed, 10 Jun 2026 00:28:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dg3g10jj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C7F3849D9; Wed, 10 Jun 2026 00:28:29 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5ABCC84987
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 00:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-486b93fc7c8so1554518b6e.3
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 15:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781044106; x=1781648906; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkX+WYN4XR4fBSFkLHR3OODCY3eGMTO0XYaBuydjYzU=;
 b=dg3g10jj7HYnWxwSw2K7FDynY2oIBA+Z53kLkmCsHyb1Fs8R6OrmAg0vh2iWsJNh9D
 I++tz+sGk46zB4dGc5VvNqwAaZ5LBRJBp3owFcvIISBJAHYsiJu17RHnxeHk1/kzU2oq
 Q7LMoHFmSfy47uPtXmyFzthsOtw5ci5xgf6Bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781044106; x=1781648906;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HkX+WYN4XR4fBSFkLHR3OODCY3eGMTO0XYaBuydjYzU=;
 b=qHi0bhnU45gTr/v6N+nUF8Xyw8usxO+9yCMHiV9ot2iN1fzf/IVCAjRLmOoIuzztx7
 5GC2fwaC9k+51BnGR8ehUB7RfogZB6+E6C4N2R7vDAi1Jcfbiluq7XXI926dj8WiGBi9
 PC/s/Rb9Su88mgBN9jdOkwFjkhASWtRqvijj3dK5NCnp89HF4i9hg4oyVHTvYR0zjVk5
 lv7178shAS4Ez//MVx0gvre8Nc/FSU9EYNu4I6cJhfFW5lznQBNI7XmWhjCqSVTi+05U
 qzsvnMIIsMiVlpy6dTo85Ht5A1wq+0JpC1BKLxAN+el8HHeozwpqy+LevjhHDq/27p1F
 VSEA==
X-Gm-Message-State: AOJu0Ywq2u7gUCwFSPnEtrdkjThBHFvXJyxuQ+zEDxtbfNuseZ0A6voR
 gGU3hDbF/75g+lUiL5cUYmEA2UyLUx3FFp+9fUUCRnQpg40ace5Av17arVgER6JplIY=
X-Gm-Gg: Acq92OE0YUzamcP10qDVwzyDG6FHVJw4sa84xd+g2dipqf4j+6zRVr3UXkpMsxcG6uV
 vRJty0PdWhItd03HF9VPdEepW51ZgQoKZId7S81yDCWfaEU2orQQ+x/lLGs2gHKt231O1iCjk6g
 GXOTdaHuBMfLp3gW0rcF+47yWZsXC+CfUDmjMhnLavuwbQbVdN9jjI6xsGA60fg435vvbGQeqzH
 sb5g7+5b9ba1bSmrM9HUKFr/vGpZSY2NhEYZrFy6Kpvtv1hFDUpfhadKsSkNW6wyJy2sSZFH8qv
 v1zM1YoQUzZMiuO34II+eX0sJvE4Q1Nb7sJPGYnN3si/d3/9JZLpaSKm35JAaR6FPMcSS+awqWA
 C7cgTN3o8Nq6VT0Fu71MaUhKTS63wHg/ANkvqYYDDLblQyLVxO+N1hLQ44D3Qj5Xp9s4xsbEIpE
 ktQ3oWxfWgz314+spjktP/Q3ARw3YVwmBRYSZw532xVeafSY7xSsNDphO/+q4kZKmF0v6pY5T2N
 RWpT44TRowqA9iMKS8qs32nrol83HnFeRXW7DVtDkejaYkIWgWga/UXlRTG
X-Received: by 2002:a05:6808:1794:b0:486:3537:2193 with SMTP id
 5614622812f47-4868dc58812mr14015804b6e.11.1781044106045; 
 Tue, 09 Jun 2026 15:28:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b7ad946sm16790962b6e.8.2026.06.09.15.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 15:28:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: peng.fan@nxp.com
Cc: u-boot@lists.denx.de
In-Reply-To: <20260526065003.2742336-1-peng.fan@nxp.com>
References: <20260526065003.2742336-1-peng.fan@nxp.com>
Subject: Re: [PATCH] misc: k3_avs: Use dev_read_addr_index()
Message-Id: <178104410520.79918.17744575855116183639.b4-ty@konsulko.com>
Date: Tue, 09 Jun 2026 16:28:25 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 26 May 2026 14:50:03 +0800, peng.fan@nxp.com wrote:

> Use dev_read_addr_index() which supports both live device tree and flat DT
> backends, avoiding direct dependency on devfdt_* helpers.
> 
> No functional changes.
> 
> 

Applied to u-boot/next, thanks!

[1/1] misc: k3_avs: Use dev_read_addr_index()
      commit: 8e4414d1a9832f640ffedbf90c42c99e2e7b0fa2
-- 
Tom


