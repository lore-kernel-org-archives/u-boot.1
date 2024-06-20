Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D5EC27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 19:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB29F8840F;
	Thu, 20 Jun 2024 21:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PuanXuU3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CEFF884FF; Thu, 20 Jun 2024 21:57:31 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8D7788385
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 21:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6f855b2499cso715160a34.1
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 12:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718913447; x=1719518247; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ywlbKBGykDyFtPar+yJjQ6YQCEc9RXK1C6tL//0SerQ=;
 b=PuanXuU3lWyPlxNLmw1SF7VqQguYCWG86dkSnZ3xYqWRmtGTb6owhkFGUToRAtzrXN
 R4WXBeOYDtZpLR1dYJTJbRvsAelDMJgEB97IUd9R/BrK52zqv42hlEOLa1k4+9dM12do
 /YtZHqvSluqODm7n52Ua9bMGZkx+1/7SsbVHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718913447; x=1719518247;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ywlbKBGykDyFtPar+yJjQ6YQCEc9RXK1C6tL//0SerQ=;
 b=h8MwdpQAIwhPRmekU3LsLMu9ptsxwdvvXWcO0wH2MG4f/J5zk7P/iTXz+OXt69Gf8L
 UFLldM46CgSyeznyzEleNhwvm65yL0jt28/s0Bf4U8SXjj4hR4+pk+Ccg+YjRImcYrFd
 EfNDEJWDUBwfc4AV2Z1g6lMk0a7Cs3EEHnxcC+SxaxTREk/xwnIuI9lr62sFBg5cWHK9
 Qwt68+eUhcRHaAKBQMM01ulNsAss5vm2Fqc9SvF68KViG/dkkXZaeU25q/1xrObaFV6Z
 YArPNHHyr5z8X/wsKIxRqR4rRnUKtqm+su+eySoeqKHpw0YkXvNjHzWGS1hTwbesAIEY
 mk0Q==
X-Gm-Message-State: AOJu0YxEfdQDKcna7TLFUD0zSZ1rD/5ILCbGlblog59hFBgHQb6Awd0n
 q3Z3d/4hmGprkMMfMJ6zfDpaY96u9A1UfkFBlA7Y6ju5qnyAF2IThSP425lWD7k=
X-Google-Smtp-Source: AGHT+IGhYB+LGIdRc0etcfZW3/aeDvtsQXqe0phRG7QClGK3BV1H81flqStFGLoSMT3rG7zb6jWVZw==
X-Received: by 2002:a05:6870:d205:b0:24f:f282:241b with SMTP id
 586e51a60fabf-25c94a225bemr7295904fac.33.1718913447596; 
 Thu, 20 Jun 2024 12:57:27 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25cd49d1900sm32958fac.26.2024.06.20.12.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 12:57:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, git@xilinx.com, Michal Simek <michal.simek@amd.com>
Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
In-Reply-To: <cover.1714138688.git.michal.simek@amd.com>
References: <cover.1714138688.git.michal.simek@amd.com>
Subject: Re: [PATCH 0/3] lib: smbios: Extend driver with using sysinfo driver
Message-Id: <171891344627.3565130.10106585648190631714.b4-ty@konsulko.com>
Date: Thu, 20 Jun 2024 13:57:26 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 26 Apr 2024 15:38:10 +0200, Michal Simek wrote:

> currently only DT way is supported and it is added directly to lib/smbios.c
> but I think DT and env is only one way how information can be found that's
> why this series is improving handling with using sysinfo driver which can
> be platform specific.
> At the end of day DT should be taken from smbios.c and put to sysinfo DT
> driver instead of implementing it directly in this generic file.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


