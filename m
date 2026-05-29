Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D027CD6E49
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 22:47:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F212784693;
	Sat, 30 May 2026 00:47:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BGHmYVFk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D9E28484F; Sat, 30 May 2026 00:46:57 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39973846E2
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 00:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7de7dc85b74so13123389a34.2
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 15:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780094813; x=1780699613; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CgJKj0MmeNjIXs+V3r9bqrRouRjZna8+oYGyKOBM/KM=;
 b=BGHmYVFk486UAAQlP6HJFGDQ164G0rW8b8wwin9gHr/3jfbYQO/8DhkBJF7vBWh/h+
 xRUnXa+zhdqfZ84oulBCneLjKkcPyef6qynmR0qSckHuFurmxqayclPG1bby1lKZxxUP
 TBueinHcMrkr0kx5e+lqoWLMQ4Zswq4eJVnI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780094813; x=1780699613;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CgJKj0MmeNjIXs+V3r9bqrRouRjZna8+oYGyKOBM/KM=;
 b=rPD+5SIX3mE+U59eRyPzl0++HC4l0esDvc/2IOMtFanKfwvXCtnfCel4BdPxx5LDeX
 LozEfDEuV1aO+kDg4JreY7KjdnxAvq9MdG2sZBNCTzuYoiP/0BbARf6V53J5j4nvIp4l
 EltGLJG9Z90nPOZTapdKTA2KFiiG7Z2nKsNWgvI5TsM17zpByvU4zcsM+iK0YHFyjgQr
 yBetubs2XNXskaeuXqzD4dIXJ2K7G9P4aFSWWD3EZSdELi2ctY/uQvvTUfBA+AyCpAon
 7xtpzY7W4TUv6m6mPsOJS/1Xyr4Wz7Eak1R++822bfBKsHrHnhV66dBK+u1fKenbSOXR
 gCDw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wEWjx4IkGxwhGk8SDtrIUhDIyp09aUe+L4F1kTWobFrJNmKx2acOjJEXTKfCG/P48gq/996I=@lists.denx.de
X-Gm-Message-State: AOJu0YyykzR/wPR/s9H36OxNlMqbAlytnd8PoJ84kuoZY7HeQKvSrwLN
 Gw5pIh2+xcb67IbnZt8Z8I1fTe3V0lVxwx+NTbexga05iVi2g5RIYsn6Ejc4220CKEA=
X-Gm-Gg: Acq92OF0vsQmtMWM7b7OYQPLtpekneQSXnwdWSGLsV/jjGBymfLW0f3Zp4sO4bAGIRx
 27ny0FKDwMdR3uIPemUv/aRUN4zjxktjWglcBorGODnlO0mWFxoABk9nVHz0C2aS7HzeZV2h7gb
 i+/R0H++/IcZmvmrtQtR3dSR3rz65puaLwd2TaTm2MMU3fKtNeqcBhnhEMNvwDd6Fqmh+eYNmJm
 DtLvauZLI50gh0FrcFou1FQp6fzBqB+hbNAKbmG/hfprhh7rB+ny4Z1ZCbSxJT44F9/QqKjIHQq
 f7GKbiE7Rr+PNcZwSjW0eCHf+wdOd+VuJxEyfOICxsLFyNRfnJ81anYetc0E1BEBhO41nyuMjfW
 Dhq1uUT0+1ELPnPB7Kkh1Xonj6JIXCy2Aszu8RUlAgRPvQ+wFHLnZ1cYnpATFeyZz7D908s1VM0
 VQPypNfd3gj45D1WtHJ8JCIRoWZ1MsK19wmAXq8l9jKp0apkbBqAbt30laUjmfPpHfpCxum4T/F
 3RRU0+6C4Bu2QHrmsdsxrWd6AdxhVYydITFbMv4nNteYfpl2WBowQ0=
X-Received: by 2002:a05:6820:1514:b0:696:6440:9e1d with SMTP id
 006d021491bc7-69e10361c18mr683117eaf.39.1780094812885; 
 Fri, 29 May 2026 15:46:52 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e0696923bsm2112441eaf.11.2026.05.29.15.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 15:46:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Mugunthan V N <mugunthanvnm@ti.com>, u-boot@lists.denx.de, 
 Jeremy Kerr <jk@codeconstruct.com.au>
In-Reply-To: <20260508-dev-am33xx-v1-1-7ec76860021c@codeconstruct.com.au>
References: <20260508-dev-am33xx-v1-1-7ec76860021c@codeconstruct.com.au>
Subject: Re: [PATCH] am33xx: don't assume we have a UCLASS_MISC device present
Message-Id: <178009481197.728062.8531508945039368439.b4-ty@konsulko.com>
Date: Fri, 29 May 2026 16:46:51 -0600
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

On Fri, 08 May 2026 15:11:32 +0800, Jeremy Kerr wrote:

> Boot on am33xx without CONFIG_USB will currently fail, as we error-out
> of arch_misc_init() if no UCLASS_MISC device is found. This requirement
> was introduced in commit 3aec2648698d ("am33xx: board: probe misc
> drivers to register musb devices").
> 
> Instead, only attempt the UCLASS_MISC init if we would expect the MUSB
> TI device to be present. Add a comment to explain why we're doing the
> device lookup (which we immediately discard).
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] am33xx: don't assume we have a UCLASS_MISC device present
      commit: 5151c208b56c6a954c121363ad33557046154b27
-- 
Tom


