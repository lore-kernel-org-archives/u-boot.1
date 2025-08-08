Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52757C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 23:54:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE9588476A;
	Sat,  9 Aug 2025 01:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C+oYopWA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A3F984795; Sat,  9 Aug 2025 01:54:36 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F420C846D5
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 01:54:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-8817fd0fab0so75693139f.2
 for <u-boot@lists.denx.de>; Fri, 08 Aug 2025 16:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754697273; x=1755302073; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JNSfBqj1bGf8gtQLHXtb+xfuVEjQjAmodBiCuY0aZdY=;
 b=C+oYopWAXVGUGPND7lbHvgUueo9CPUQGA2ouK+e/2ijRCl04RE5l8NLL3ZOIUJjY6Z
 D96ezj7lqyUKVfPN1CtKDXa0CqTIgCdRQS575OXtjLVWHsdRcnKZkefNlhcJmy8XSs9P
 maJ5ERPgRM25GF/Jd0Gw6WwTVTz1zu4h7RnYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754697273; x=1755302073;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JNSfBqj1bGf8gtQLHXtb+xfuVEjQjAmodBiCuY0aZdY=;
 b=jTi8qsNxoio45DuDJoGsnZtBb1zX7kbGfbSyf6wDnE2CPbrAvK2afopmk441vWM2Cv
 EHOYTe4Z68d34zbtDUQhzlGnZzRGPxhlNmYCehvtMGOSi3Wf0p4eRoZG6d5nHxGZJRhU
 oodex2SzJH5M8YrQDjESwxXtiUVGeTrrw950lEMtjTLTgrFpfMKbNoHQsfMhhCEjHQe4
 b1MmuZtkKwRLfClgsgJgJlQ/s/W0DwSbAg/H1O2mry9qoHoZEX7P8etj3ljCiwB9w5ww
 EgbRMXolMzqqQL3Vw8sRtXeJJ7f4tiy5BQc+33cvUU+HG1WTmKX6wJKykczWXWH39h24
 7u+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEioqSJbXKRTc195rZIIl3rAyIDuiONkz7YD0m6Y+5rTInBRIRUHlFnOgMqenqRhRxMkR0hEI=@lists.denx.de
X-Gm-Message-State: AOJu0YwIlOjLLDcrCg9UOQu6rSe7mJJ0XVpFo1N75awZlXqnOaaw+ikf
 bwZvvD7FBUIKGFn+3aT/7OUai5iIUxuRhPSdUOi3gF9NhwXKUU42kq6rFGvNRSuZyAuU9XhzZw7
 jrDyOOYw=
X-Gm-Gg: ASbGncuaoiKXeSuv3r+17lsawE+UJ5SOuLGH1JS0lFymyG8NxZMY00VAn3PnbYV+UL1
 CWTq/6ut2osMhsY7L56m8bCpT5hVZ01QQ69Hsh1Uz+DR84wrUnxy+t9L4VX/S0dy4TLfAbGWphR
 RHYOdEa1XBq1tRLIhbnKG6mbL3QUWmf/+N8g0HCkm6cywV0lX2VR+M7ychiAt9hD45VmuW/p36M
 PfTXXu9Ft/Wbm4UBhw/V0E0jqEK7pm+L4pjDnHxnJ/Y7tL+DBaEvnshxuQzpW8nbR8XyadJMGjd
 9590CpoCN0NPRQNAoeA9T+c9v6wSgXvG8wL4HJaxSjUZThaMi5CVttzZX32Qe800j35Ohk5chEv
 35+WljCrBi5arxnNKlPvf+TkSn5q2op2Gw+28iskjKzB+teyDMvyLPRKHwTriM2IPZg==
X-Google-Smtp-Source: AGHT+IEr3m9Y7BPxJGhHL1g28R4RCpjGQv0HqRWGxqcHfE4eKJ3Tv/j6jJmtUiONli6JIqVlnZM4Dg==
X-Received: by 2002:a05:6602:6d14:b0:883:fcf4:d9c1 with SMTP id
 ca18e2360f4ac-883fcf4dc74mr109415639f.2.1754697272772; 
 Fri, 08 Aug 2025 16:54:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-883f18d5d77sm93284739f.14.2025.08.08.16.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 16:54:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>
In-Reply-To: <c3a1fb84-9a70-4b04-8db7-e01200e80dcd@gmx.de>
References: <c3a1fb84-9a70-4b04-8db7-e01200e80dcd@gmx.de>
Subject: Re: Pull request efi-2025-10-rc2
Message-Id: <175469727090.1534808.16584937208074345369.b4-ty@konsulko.com>
Date: Fri, 08 Aug 2025 17:54:30 -0600
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

On Fri, 08 Aug 2025 17:18:27 +0200, Heinrich Schuchardt wrote:

> The following changes since commit 123cd77122a13288e1552b5d9b7c22a6f19e2e02:
> 
>    pylibfdt: setup.py: Drop license_files (2025-08-07 11:16:12 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2025-10-rc2
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


