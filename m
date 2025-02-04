Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D708AC02194
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 19:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83960807A7;
	Tue,  4 Feb 2025 20:43:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t5R6pyJJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CF84805DA; Tue,  4 Feb 2025 20:43:30 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88873801FD
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 20:43:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3f314ff6ffdso3375150b6e.0
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 11:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738698206; x=1739303006; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G+Xe5Q3izOFU3cLLBs9yiZfUXeH17jqd0+AZ0MaBmk4=;
 b=t5R6pyJJd4GN5GdATlVyKVuwwK0Tw3zBAlYq55ng3nbTR7J9swgRwTEmXZdQyAikT4
 ImHY+P/sgwwrLokLW2OqDXBFZjAp2s83mUL8xAuk+U/1qDln6Y2KU6lbJNU5Qg3mfbGz
 4MF0Hh4eG19HELZzovHHrHO/4RQckQFQXZY9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738698206; x=1739303006;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G+Xe5Q3izOFU3cLLBs9yiZfUXeH17jqd0+AZ0MaBmk4=;
 b=o1JsCuOMiOAD+zZyHHujXoDrwFVxiOCG3tNzfZUAHdGdsb5yg8tn+s+SFauKIYn676
 GU0nakKOxpCz9GjxKPFqV0hPEYOiVlUi9xEyrj230foGJkb4BAp8Ch32PLds4x3N07lk
 3bAMWZPAarxLawqamCq0LTKlxz114/Suio9QklTA9BVk8kaB7WcBCtLIdmGNeZJD2Stx
 ovkmR5EfkR2ZBRCcnrfmaQhjdeNLqP1lGwKn0dovE7bMJMINKNPNv1VwYpUVF6TNZ/Mf
 mVdnfPKnjA0yg63Zmx9+fV2Xv7HN4sYdsu/j+HH3xy9YKY7wX2X4JDcao/A7b0rpROOI
 dWpw==
X-Gm-Message-State: AOJu0YyLCViVm0pdcyr+L0XiUB0oD89wIwHOvifrAa81cS4Znkqoc9fg
 QKFQVfaiKK6bCebpYnamd32YBMbY2qGHcEpJWTxtcvaWs24/hr3aki3aZIQuZ4Spdmv7tZmffXy
 rA6k=
X-Gm-Gg: ASbGncuN7jp7vFJQm7wFo0i0VnHcVEJbiG1/svfnuuBLfkHVpzKHScw8Z4e2byBYyur
 c82gkA9r24moJrMxJmx1CclpTJmnw46dHA+CRQ67J43s8Z+5hPHGNi1aNJjZL/+BO7/ZgIXndM9
 J0Qp4qP5NE2V4pOVOnGcJSikP3QCLw1e0gFZOaYVn4xDODS9XfeZW0EDM2f+UHi6lfBzjMyzMdd
 tFIekieu46QC941VTfyWcA3vMh31FVrmMg7g0YFKpNXcqoa0bgRHpVJaf+NtgqlDGnU7jLHwPqw
 hF44aeI565mVLA==
X-Google-Smtp-Source: AGHT+IEKfRLNDnthfr7kDC4X/nGf0Q8Oa1VAmeovONeDFFxnqKkjhUt7fpGSqMkMsPwmNS4GDFTV2Q==
X-Received: by 2002:a05:6808:1b26:b0:3ea:519e:cc92 with SMTP id
 5614622812f47-3f323b26914mr16433950b6e.37.1738698206379; 
 Tue, 04 Feb 2025 11:43:26 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333690ba9sm3160867b6e.49.2025.02.04.11.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 11:43:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250128232948.2064724-1-trini@konsulko.com>
References: <20250128232948.2064724-1-trini@konsulko.com>
Subject: Re: [PATCH] GitLab: Run sandbox on fast amd64 and fast arm64 hosts
Message-Id: <173869820509.637016.14825510555564826194.b4-ty@konsulko.com>
Date: Tue, 04 Feb 2025 13:43:25 -0600
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

On Tue, 28 Jan 2025 17:29:48 -0600, Tom Rini wrote:

> Now that we can run sandbox on arm64 hosts, have these jobs run on both
> the fast arm64 and amd64 hosts to catch any issues.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


