Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F6710F2840
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 15:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C106E83DA7;
	Fri, 27 Mar 2026 16:35:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="D/8llU3N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F372783DA7; Fri, 27 Mar 2026 16:35:13 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8127683C14
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 16:35:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d77b179b52so2057682a34.2
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 08:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774625710; x=1775230510; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xam0/74vrEvydH8mavn7v1rUAIBQsPf7bPT8UreZRV0=;
 b=D/8llU3NWVk1Df1d3wK9TcVqZOhL4Fi+zGt3mvAxoXPqfKzT2s/zCoiCC0JaStL0Og
 BYWi8nyfFwGGFJOrzGSB4jHKiwsSktCCYBkdBbZLpyOuPjBdoJqrnxAGa2tKMZ4GOd7h
 alk9smYRmuQg/vDQ0YKseKTTRmVgJoaeEvv44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774625710; x=1775230510;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xam0/74vrEvydH8mavn7v1rUAIBQsPf7bPT8UreZRV0=;
 b=F+ZEG41E+GfCEiqJAZbsralh63+3S8IVIF9BO/yi7VP/eTBuXV+jiaX59YVqsY/Rz+
 opTJrhaGWY7AXuhtVD3+mpouv+IuwWONf/dOAYgzLviYrJnS1FHjWj17RxpMgOTMpcO9
 UBl0CH7ybmx+kzTzAJTOypeEwhwU+RSz2W7WYg/Mw8NgxzgsS/i2Uv0gLHjJo7AHQeKl
 M2eWYJUSZnU8Yox8W0ysuRlWADhc6Gl3CiUwx4wQc+WTOsm4VEFSQ6Lyvn5eQLzQbPUw
 3/aVm2bxW/Rxcz4UB/djTXT58aW5IBFZonPFLo6gK6E7cHvjssIwJj9UHlgJxycM79Hb
 mjcg==
X-Gm-Message-State: AOJu0Yx1TkzWr77pBTKgQWzjVVHSYGMqJJRTT7yvE+skA534t+yDxL3R
 1FDFffvYPFMSmBHravbZ1qouPKP3X8Qucj8s2MsfFLwvX5m6b3u+S2wXLsscDzDZtXQ=
X-Gm-Gg: ATEYQzwacYs41jgbrxT72fxNcFEwCzeeG8JaWwbUQBqDGjpwVtH4K6UEll/39/eyXt7
 1iblhiS66LvmGDti8PMQN7hHg9Ma0fI6B6/leevMF9ng4RadPAyCyF0yPFIVkW5IpRuc4mzoVdi
 wuL7tSfFqxkplUeTqRlAYHUBaaXN0yMUObeyGfL4//jYby8v2ZKFp7r7xH7jQJeLAB/v6tmhEbB
 2+bhWt4HCJk88kU4RfovWjsM+4dzBeD2qGK1TNcCMjaCa2zFQjVcWHMC+HBkPAyS7bCMk8zT3MQ
 7VXoy/9WZ8anW3YNbwZn7/eHfS1Ct4Wdfjhk6Ud6b1ZRNwEPBLm+qGqfq71wPzkfh8YetWvV22l
 ZiZKArBxRSfU6sGAqzQgBgoYxDRFA8H89MuAuyvv+jzXBwrtD9+Oz/ue0QEi2NaqsCqFpA/9Q2i
 OcjEpwV8HP2pB/kdNveVbH8zGc+HpUBDqwhKUdZNa2xcvW8QaS2pj3G8WMKHD7RVoSoDOAP2PY4
 bZM3NiyNlem/JSobvE2fNY6XvZWlBbj6he3A8boGZsO7ms=
X-Received: by 2002:a05:6830:3693:b0:7d7:3adf:a722 with SMTP id
 46e09a7af769-7d9faf3b95cmr1532254a34.29.1774625710066; 
 Fri, 27 Mar 2026 08:35:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d9e6fb2af0sm4954917a34.6.2026.03.27.08.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 08:35:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Anshul Dalal <anshuld@ti.com>, Aristo Chen <aristo.chen@canonical.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <5eee3f35-a8f6-4e7c-9ea3-c7be045ff6e2@gmx.de>
References: <5eee3f35-a8f6-4e7c-9ea3-c7be045ff6e2@gmx.de>
Subject: Re: Pull request doc-2026-04-rc6
Message-Id: <177462570907.4082332.6272534706095453839.b4-ty@konsulko.com>
Date: Fri, 27 Mar 2026 09:35:09 -0600
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

On Fri, 27 Mar 2026 12:19:15 +0100, Heinrich Schuchardt wrote:

> The following changes since commit c24a72c35abe9cbbeb72e2effc6b6c73cd828a32:
> 
>    Merge tag 'rpi-2026.04-rc5' of
> https://source.denx.de/u-boot/custodians/u-boot-raspberrypi (2026-03-26
> 09:02:05 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


