Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD5B7CCF9EA
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 23:58:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C14A8382E;
	Wed, 29 Oct 2025 00:57:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J26MR/KR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8937083826; Wed, 29 Oct 2025 00:57:37 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4AB883826
 for <u-boot@lists.denx.de>; Wed, 29 Oct 2025 00:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c5338b1d10so2503985a34.0
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 16:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761695853; x=1762300653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BZvfHHVYLb51R00MJuiP0COdqViGJHeN+DcTj3Vpc4I=;
 b=J26MR/KRj7ONmFBWKvCLR9myFV99ghbztiCu2m5vEQfbW21FmfV+mpV8qK99EluAy4
 a2kz8xPm3vgMx2Y8civ/8I8HBlzmqJ9XttO8d4OqbOxRbVqdrE4zKrhN7eUKLPmLj80D
 3q1bIPwVKbAW3zeSZrwlLEaWNlAt9RAP/Mw6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761695853; x=1762300653;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BZvfHHVYLb51R00MJuiP0COdqViGJHeN+DcTj3Vpc4I=;
 b=BXwff6JzVX5CzmNetdH3zBj2efy6bSm0auL9LsYPrCKtMdyJF/N/Xpp2cq5CrzrnFQ
 AtaKl2LG7AQmeFlBIhh6eHfkubLGLXFLt7FRbbcVpF12z48q8rbmDHD3gU3TJv9QKm1O
 YQyPcBpBUO6pzapCUJ59mGK/+jfAcl7SwiHDP30BATl+DYWO+W/Ph4J+4KxiVqfH1894
 2kuYe86z00CV7hUwfRB5LIGADwmvd0vV9QuOOhpo/MAok+QvUWjsZVY8A2slKqL8uvV3
 LI8qWLfzJpvnq+zLMmgUWDPOVeqCgduyjg2QZjD7pXTcb4YxblutR3PocjdkWoCFOOKN
 /I1A==
X-Gm-Message-State: AOJu0YwnHl6c1FpjMT/7EnnK6r3uMDeUfbFIQ01bc4ffFTeecWOFOXF/
 sRW+99EAtViPxGKQoOMAz8bu/we0WfoHe5xMDSqbrFbfNldsqqzgUPzSJibAyaVPtyk=
X-Gm-Gg: ASbGncv6QFlvtWnNqni9t5PnZMdP+8xjET125gxg9uLK56cocvV9mnk2AaIAIFJwijP
 kiFY63efTTWyZz9ELA6bzbtSiwaKHx8KYLeBFt5lMBKheoPwzSgmfnw1oe69iYWy24BNqW3/JJD
 obNjduAlSVh9tOXBbnF9lXZSid5HfGCB7JW8HErd6VLc3S5VXgKChPh4UCinsRpevcGCMg4Fe1o
 lvU7+bTc/JxCz5EKczJF9oRyg4ArIjNo6HUnM4oOigspcSwZiRSf4EyFzzGP8tU6Lz8oGhxVSop
 xAF3R4WIFBH+2W+qhHqqrbnNg27YrXmwRfL183VNhy72XvWV+yc717rAZXLlzwMMtOJD4UWGIB0
 pjObe+RW/ZwjSx9GsbO8DgOL9+Natz7VHpogwp+U+d93yP6AWbVlnqf7NRRyX6d1Jq6kxyTwPR6
 kuqh63ABP9se0/BhiYNi1Nz6GbcJkx5LpvvP2HLg==
X-Google-Smtp-Source: AGHT+IG6LVYWpMZwD4qOGEpUjE8tzkOgz07NCMKqSF/dOT53/Z5eSJLwcGwiCINr4K2/MhtcqfpK5w==
X-Received: by 2002:a05:6830:3592:b0:78a:8b0d:cd54 with SMTP id
 46e09a7af769-7c68318743amr595143a34.34.1761695853601; 
 Tue, 28 Oct 2025 16:57:33 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c5302068a6sm3646234a34.25.2025.10.28.16.57.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 16:57:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250704214556.3418849-1-trini@konsulko.com>
References: <20250704214556.3418849-1-trini@konsulko.com>
Subject: Re: [PATCH] mtd: Correct dependency on SYS_FLASH_CHECKSUM
Message-Id: <176169585256.2287207.17737828698652800312.b4-ty@konsulko.com>
Date: Tue, 28 Oct 2025 17:57:32 -0600
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

On Fri, 04 Jul 2025 15:45:56 -0600, Tom Rini wrote:

> This feature requires that CFG_SYS_FLASH_BASE is defined and this in
> turn is only done in the case of FLASH_CFI_DRIVER && !CFI_FLASH or in
> other words, when DM_MTD is not enabled.
> 
> 

Applied to u-boot/master, thanks!

[1/1] mtd: Correct dependency on SYS_FLASH_CHECKSUM
      commit: bd7bf693de4f6f1c04159a312ad2b69b30dff8c5
-- 
Tom


