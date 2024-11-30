Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 729D9D73619
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 23:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70E6C896E6;
	Sun,  1 Dec 2024 00:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CbHou0uR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44B50898BA; Sun,  1 Dec 2024 00:37:39 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFC6F896E6
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 00:37:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6d842280932so30192536d6.2
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 15:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733009856; x=1733614656; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g7pWMxcAtZYeo48jmlsI1vO9zdBB1D6rYq8Y0zsgWlk=;
 b=CbHou0uRATwu3eE5kKmiLv4uQ3IZ0kwa2Bnrj4LClUgWu5jk1KZN1cVB1VywFJnTxw
 j/M+6xL2AEi8NJqu/ESyjtHL/ODEG6mvX04F7QvQmoFIdAoal5bBw2fOC6F+Imf9nREJ
 cglXu10YWcTyaQ7ClviNumYk5cv3ub4Uoo+ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733009856; x=1733614656;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g7pWMxcAtZYeo48jmlsI1vO9zdBB1D6rYq8Y0zsgWlk=;
 b=GzLHWtL6cfO38zW5jhC3un4fmUf3jgJ4rWxQ0D4ZPQG5G9SRxqi9hjpe5+AfPHYAuc
 YEXGdVYEcTYyvdIDdfu0o7J2TQxAC0oprPM53d2zBy8jR5iHTupRoi7YcObRKzR36XY7
 iidTeiWhTRqYnCfBsI9whUvB8xQyjd0fgfkbaTTsyi77VNLGc2POY+SLVtD9Bhij1ijP
 91UwL1gwrMM6YxW1QB86jUAFFW1MiPpbef8OOkNvymrFKZi858RwMGKxT9BALSCyyG49
 CNoxnu93zXQR1KeZ87771W6eNwiMzEhC4Sem2mjqNnT6nmpMMmRZtpBbAU8O1UJh3WqY
 ovtw==
X-Gm-Message-State: AOJu0YxSw9eXlXvQ56tEUfVFbGau5uMu0M/LzvpVYQBWNWdRxPj0HKEs
 Cy3GkI66YXHg1oZZgSg7FC17UOLLnYbIKERGSESvxBrZPSYiTyHClZabPVDjWwpzSgCltf3Hhy4
 dSxI=
X-Gm-Gg: ASbGncu2UU5zY/yoRH/kKuGlkFtNWT0D2gxd7+opQApoqxFKzwgqGECYW9LIaOmOGZO
 8SjgtuNwz7+Yr6W+k4tgI71ZSMObH8/kskjq1QBxGUTCr0ZrWLvJgZR61Uk0HcH9RTpBJMrgOI2
 wP44Hmg0QVtyDt2GOvWR5yPYjHPUhvZHTG5qB7/BgJH0pRU/VRGw8lvfWbvj5iQjY3S9sm7QpHb
 Ft5Uqcjfidl2E9IyGNqaznP/hvkcANlvmqBkPT6Y2m4HfEZ
X-Google-Smtp-Source: AGHT+IE6efi1MseCejXQLu1GCeoox5NS1JQiPSHe0QxCyeGvAb6/cxSHKXTjA4ApKAAlb6OyKggqIQ==
X-Received: by 2002:ad4:5d4d:0:b0:6d8:8d87:e5b4 with SMTP id
 6a1803df08f44-6d88d8807b5mr97148836d6.19.1733009855993; 
 Sat, 30 Nov 2024 15:37:35 -0800 (PST)
Received: from [127.0.1.1] ([187.144.30.219]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d89b158778sm5725926d6.96.2024.11.30.15.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2024 15:37:35 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Mark Kettenis <kettenis@openbsd.org>
Cc: sjg@chromium.org, marex@denx.de, quentin.schulz@cherry.de
In-Reply-To: <20241126191214.21709-1-kettenis@openbsd.org>
References: <20241126191214.21709-1-kettenis@openbsd.org>
Subject: Re: [PATCH] Makefile: avoid non-standard sed expressions
Message-Id: <173300985403.2282108.1484502050066186199.b4-ty@konsulko.com>
Date: Sat, 30 Nov 2024 17:37:34 -0600
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

On Tue, 26 Nov 2024 20:12:14 +0100, Mark Kettenis wrote:

> The '?' that is used in the sed expression that determines MK_ARCH
> is part of the extended regular expression syntax, but the default
> behaviour of sed as specified by POSIX is to use only basic regular
> expression syntax.  Use the equivalent '\{0,1\}' instead as
> suggested by the OpenBSD re_format(7) man page.
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


