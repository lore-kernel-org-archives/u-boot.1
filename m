Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91865C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 16:47:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D50B881EC8;
	Wed,  3 Jan 2024 17:47:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QpHt9fQA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15571877D9; Wed,  3 Jan 2024 17:47:35 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F21448082A
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 17:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-427a3887483so80472431cf.3
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 08:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704300452; x=1704905252; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rS0+MDTE/FJ2+Bh0xT++s3IdSyp59BzsXdhjFs81jlk=;
 b=QpHt9fQAQrJiEIe7MpO3m8jesUQp0+ViyUHRzMm5eIysMCu/LdPC5uIHKtRyKPmaLC
 CDZGIEVn7VUqgLtBc28EtXxIkO+V1YbNfwyjhs21ntM3lQQZ+1FbOjvmzh5I/P/9lP9V
 Bzt/toajCK5ERULZ0fDr2n6ImKggfnrR34g9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704300452; x=1704905252;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rS0+MDTE/FJ2+Bh0xT++s3IdSyp59BzsXdhjFs81jlk=;
 b=G73/sTU3pd8H5o2WcKOWKxLRSUxI1pn0enmW/ND+0mSGy6mQkKsZF+KeniawjnTm/b
 Vzx9V3u/0ZjrWSLr2ZyeQkSRCQg5UFCbuoVdILXb8iDS4mG0U84EzBXruQVzrbGMcNCe
 fhZ9BvmLo+SU0roVHKfEa+SyoZlD6QuOUDwJs/b9jtpBks7hcuYqJYmW3bPHQcz7KR5u
 aDF6KSpj6cA+DEZrCpHHTJ334Npc5RXG7UyNddl7oFBns14H3PyUhW7ceALMkUKK+0Z9
 oMbK4Azb0WcfFKPpW6qWbi4XI9CzOXWP795OwEE0y5IRZvQVbGJ+lCHt1fSItRlckOhm
 WOFw==
X-Gm-Message-State: AOJu0YyU4ElQ7VbMJVIx/x8rkHX4mv/W0hJrT2jLWaX/mJrx+M7mWglo
 FKboCjnRm1aYudggFapyazRjid0jeMEcWw==
X-Google-Smtp-Source: AGHT+IGAXZpiGKx7g5mKTb1t0GQH4aSQGtzBJigpmJry9hUHeKoAyATzGIwqTBSmf7X68o8NZ9qPSA==
X-Received: by 2002:ac8:7f54:0:b0:41e:a62b:3d18 with SMTP id
 g20-20020ac87f54000000b0041ea62b3d18mr22185501qtk.59.1704300451808; 
 Wed, 03 Jan 2024 08:47:31 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 z1-20020ac84541000000b00427e0e9c22dsm8937435qtn.54.2024.01.03.08.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 08:47:31 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
In-Reply-To: <20231221-maintainers-fix-ab-v2-1-9182a7829646@baylibre.com>
References: <20231221-maintainers-fix-ab-v2-1-9182a7829646@baylibre.com>
Subject: Re: [PATCH v2] MAINTAINERS: Fix ANDROID AB unknown file entry
Message-Id: <170430045117.1087984.3302296756065536770.b4-ty@konsulko.com>
Date: Wed, 03 Jan 2024 11:47:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Thu, 21 Dec 2023 17:09:49 +0100, Mattijs Korpershoek wrote:

> Commit 19a91f2464a8 ("Create a new boot/ directory") moved the
> android_ab.c code under boot/android_ab but did not update
> the MAINTAINERS entry.
> 
> Update it so that the maintainer will get cc'ed again.
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


