Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F8E9C83038
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 18:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4012D82EC6;
	Tue,  1 Jul 2025 20:40:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S4wqmJtl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89EC38003E; Tue,  1 Jul 2025 20:40:38 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D50082ADA
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 20:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-73afbe149afso2061829a34.1
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 11:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751395235; x=1752000035; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LrUPbYAJqOiAvkzuX+eSo43/LvVBQmEmBZZ3X+Aao4o=;
 b=S4wqmJtlrBFE9jzSH+ODRoaeL60FHUaegbA8ArAc1PyWDOHyIz79FCBm5onQTnjI21
 bmctYKs0KVDfm/jSX4s15/jxPyl4ZOAAcX/JGvZnWEXZrFXHX/+c4MvRPSltiH3k293k
 yZ36pQK3HRE0zacZSApbCV0Z2k7nQ5KHNw198=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751395235; x=1752000035;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LrUPbYAJqOiAvkzuX+eSo43/LvVBQmEmBZZ3X+Aao4o=;
 b=Xg5KSVNk6PtqDB7Pv5J1XVbjO5KJ8mEXjw2ae/Vu5tSOzk5pN1C95jJRNCvVCLhsMj
 hDnkPICWT5y5lpOScj/GY0CZPgFCJ6YJPIZXvQ/6Z5lplmiJHJoighZY1NFw05Ow7xRK
 /++QykHSXj84yHm68cEXM0R1IyFom1yCvusO9px0fsIOm7KMqj6TPIC4a7Ira4lJwsPp
 vyiY9u7wi44PlajuMWIwlZXPAdI+TStqHmhjpmHIRmWT369FvGQTq6CRyph2uPEtn4OM
 0NJ+e7VVi4o/BXsIe8btP4hNg3TFFuSsd2vM3ouaUzuM1lyIsaRN/MKoAnQs8uEKx42S
 Sf/g==
X-Gm-Message-State: AOJu0YzuX6y5dEK898E/fP46UIEKIb+QUEBIYVK2BMd/S+dJRWFUvCI8
 CaT8T8TEiivG2xcF9W6Oi0l/SJL0LEk32+D2bcBeJnqYS9G0MnMoDwyaB348x6cOBWY=
X-Gm-Gg: ASbGncuCJ0PqDixic4gWUUNfJZ0yI5r6J8zpbWs7nHTh7X4tZsdXr0g2zVrIv2JQNWk
 HyZRp9L6CRtu3vQ4HrmgYqbHSyESEIEKe+sWllzDk6sUeKOB8+RsK7IIwD0OX73TNCbzl/VblIj
 QdoO1ZJAe3YuE1XCUrQ4TQa+UYt+aQ/7NRd0MTQmm/gdxkh0/DFGeCsaXcoklN7QkiWT29Eg2OL
 VTANB4n2VW99GGuliTouWYK1pidIq4O2igpk220y6x2IH7g8+LXtlRZCKekG92b/meHtiZRHbg1
 GRgwNscYAhRXyP01V2tws9R0rcHiVn+ceN0gqMvD316WfT5ldaNYs5xfg2iu60cE8o9iWiUFixr
 JgHG0p4KJ8YRJezW+5oxOxw==
X-Google-Smtp-Source: AGHT+IFlHdxb08m6jz3QQTyAofNzZhGy0kKB+87ZmiJry14d5GdqAsBJWf0/oNAxQEBg0BjC1Ty6Ww==
X-Received: by 2002:a05:6830:63cc:b0:73b:2df2:a84 with SMTP id
 46e09a7af769-73b4c958bc6mr82076a34.4.1751395235153; 
 Tue, 01 Jul 2025 11:40:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afaff249bsm2210913a34.6.2025.07.01.11.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 11:40:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
In-Reply-To: <20250527111932.3058650-1-sjg@chromium.org>
References: <20250527111932.3058650-1-sjg@chromium.org>
Subject: Re: [PATCH 1/2] buildman: Correct behaviour of --in-tree
Message-Id: <175139523446.3190871.10892369720872952705.b4-ty@konsulko.com>
Date: Tue, 01 Jul 2025 12:40:34 -0600
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

On Tue, 27 May 2025 05:19:20 -0600, Simon Glass wrote:

> This option doesn't work as expected since it sets the cwd to the work
> directory, which does not necessarily hold the source code.
> 
> It should be left unset, so that the current directory is the source
> directory.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] buildman: Correct behaviour of --in-tree
      commit: 9002ab0986fa51ed2dffcfb655b062ce026b194d
[2/2] buildman: Support an in-tree build in the current dir
      commit: 919ba46d7283c33026178dad8a0c6cc28ee58001
-- 
Tom


