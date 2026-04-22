Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3BCFF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:47:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E747E842FC;
	Sat, 25 Apr 2026 20:46:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="djxy42Dy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7F8984376; Sat, 25 Apr 2026 20:46:57 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93B0880087
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 20:46:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7dccb8644c4so3023286a34.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 11:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777142814; x=1777747614; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lurez2D4CAfZTYTd/q8xTfL83pAJNzUyNmQL7Ukf2ug=;
 b=djxy42Dy9pihzojT1SE2vV9cJ/2UwfbPdrhaAMKhLQBR38/NhPzrU8NBJ1rxsyqsUg
 suZd6NEb6/PS/QhKCiwLcGfJgFN0wQvaXObHT6KwW/IpGV97u7srXoqvCOCnecE6FByZ
 zVYIollWx21YtRMqiONKe7+kR7tYAsTZhRgHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777142814; x=1777747614;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lurez2D4CAfZTYTd/q8xTfL83pAJNzUyNmQL7Ukf2ug=;
 b=MX2clqEvMtL7sPFUwcjffYbFuMvLziuU7AO7ZUmign0WM3ad6K4OxemPfYzKPTMZXr
 f5XgTfOWDta5PSNL53sNbbyXi374UqYwKfJZObMoZ5YRflikUDnLvhVr7YySwevi1taW
 eRhP+MfT7xotFqJtLrIcvarDnFzbpfb3gVijbBMjJQOwNj+6mNyisjZRD7JqJCzmxzwL
 80zS03XCw7gGNcIr2pT29cU+A9bqwWvXxbYWOQ5hpEGB5pUZnW0W1Rc/RRhZUodIQFrR
 WnxL2qoSK6kS0A+JulbjBEDdfPYSTA5JH7B4N2ByPxbK0QIAHnZ6aZ3P7cDPVrsmY1HS
 gJCg==
X-Gm-Message-State: AOJu0Yz3Cx9Yq4hAApFCbzCYskzOp7wUeQZ38TY376lcDvVDz1VKiI6j
 /xHXuTJiANxLBWW6SnCedN2APehGekfDJoE/wfh63QOejgK49Z/LrOou4ONC7m8jpPyRH+bSBIR
 B8qNO7behFQ==
X-Gm-Gg: AeBDiet0iZzyBE4kxukPcQammPbu7H1CUn0dGE3lIga48jqfdgTrE4V407U+9FGNhVZ
 Al75Q3bbkMPxb3rdXw+uNKdHiWiX4Z9DXKV3gdNR2o32hyHUOGdsa2aojfroQaWP0frEaoyNDHw
 uWu9hhgEKNU35wd3w5uyDOsHaxPf6mL2077o+EB86Ig2K2QK8P6XgwN3P4S9NE/cM6fZSdMXsi0
 ycBnWxcxz0QU5fbhT/x8tRoxpT7343wKu2MlCJIfbJFv+5CQJ+j28zwHBcknJNa5t6LDA0ggSNN
 LM7X8EUPsonhbjZ3cT4gU2kUOj3S5leeHHkGsnOSS7fdNRkwoB3V+VHhF6SMqvveeJiVeJeV6Fz
 JWk9dcT7g++DcqGaEx9VkfaZ6tGlhxNGMZQR1KSnYxxeJlBRX2zlvLjytfIqx4/ID1ypXvsrrY7
 VilqXH1aAC9h7/YT1qq9TxCiwA7rPnfqyWxI5MsxJbAgvt3EUb1sdX8/bM8ZvGwXKNwhzYuHgx1
 EtxRy3VJ8phLGXpSblvYM0x8ZORL5lIISc+3A7eVP+nSoFwLXHKxQivzSLeCww77Fomb1s=
X-Received: by 2002:a05:6808:2515:b0:467:46e7:e6dd with SMTP id
 5614622812f47-4799c9776b7mr13522798b6e.16.1776898141652; 
 Wed, 22 Apr 2026 15:49:01 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-479f3cf40d1sm3874175b6e.12.2026.04.22.15.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 15:49:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Gregor Herburger <gregor.herburger@linutronix.de>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 David Zang <davidzangcs@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>
In-Reply-To: <20260413152526.153605-1-gregor.herburger@linutronix.de>
References: <20260413152526.153605-1-gregor.herburger@linutronix.de>
Subject: Re: [PATCH v4 1/2] console: add console_flush_stdin()
Message-Id: <177689814032.1956774.1380688153599790570.b4-ty@konsulko.com>
Date: Wed, 22 Apr 2026 16:49:00 -0600
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

On Mon, 13 Apr 2026 17:24:53 +0200, Gregor Herburger wrote:

> Add a common helper console_flush_stdin() to drain all pending
> characters from stdin. This consolidates the open-coded
> while (tstc()) getchar() pattern that appeared in multiple places
> across the tree.
> 
> 

Applied to u-boot/master, thanks!

[1/2] console: add console_flush_stdin()
      commit: 2c8fdd7aea1d3c6c380ea5b5080147dc7fe9c38f
[2/2] cli: flush stdin before enabling cli
      commit: e973fa5115e40f93bb1425db5b1cc1f3d9b8047d
-- 
Tom


