Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0571FC5B542
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 20:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BD328317B;
	Tue, 27 May 2025 22:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="atFMQU6p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3FA98313B; Tue, 27 May 2025 22:19:21 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8414C8318F
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 22:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2d4e91512b4so1856927fac.1
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 13:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748377158; x=1748981958; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bFNwpWB9vyX3142e4HmlavvEdgJef9M7T55YDmPy24w=;
 b=atFMQU6pmuXI+k5z2o5R8cqW6NdqoJ2h57VTlfS38TKRknOzx6IHPrSHRNhxsYs60u
 iUWlvNPl6Z+iUduY6NaqKNOEz9AXF+6lsIj78Jxr0b2dvd3jwnqQGesFHiQ3oLtoS5p/
 fi923EpSk8cl5pSyjRWlC2DXttwRuJjUIK2zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748377158; x=1748981958;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bFNwpWB9vyX3142e4HmlavvEdgJef9M7T55YDmPy24w=;
 b=SqkLxzVouFp4APsQjuQ0lmyVV8dJ572Rjky0jaU7IG2RcqOvv5jED7TJzfzsDaNGLw
 RuhcVqkiHgs7SlkQW3ClzYXROfKU6iD80ntkDJlPgtNlmFRr6MaBbAcbWIyg6tJjU5/+
 saOxU1/4M2GLFx0My5qEcnQTVVHRmw07g6RActZtgSqGhIQUd4r0XhdqQ7wKe0tmp1Ie
 FukJTymk2WTPOdkJfufwQH8pfNPje9n2AwdBwZII/oJD5wEX5P3G3s/IO6g//c6pVgKY
 ruL4/EWz8S/FToYtm/C0T2hd2UwlGX0cD/VIzw6yl1VirBuySoEoulA2aYlXyym0Oisi
 8B0Q==
X-Gm-Message-State: AOJu0Yx2UdzKug4u3Ay1l9Wi9uAEZ5HIXFGWni9ggm5O1h3lSSQgjRte
 cz9r44BDAVTJvRy4BsthKuulYUaizayZJuHyzIZkcRhUOtQqXjKewKdXrV2tydF6sYf/W1LF7Q6
 0Wh/y4iM=
X-Gm-Gg: ASbGncs8lgFLq5H+RrqkUWmwy3REfdGnK/pkatlt4VQ+fGNT4+uF0/Pm8xs1Fs5aiBJ
 lEFQF4xfXFZz/IYGPYysIU0GUl/YkUtOZ9XwidaTkuIa5Jz71IMzBKMK3wnt8nAOHJrPXEpOJsV
 GbQXWIndlM+WWl8MIFESSDsRuN7ZY6Z3EdbF10zroDQZoDGK7nWdVzSjhLVbBFvYAylrCjDYq88
 dFs8oE2gZQ5ZfosyB6t5WpxrZZaWNaspjEBXAs36RwXwkfeBdDEb72OCcX6G30DsBQtHHiX4Sz6
 8G98jC74AbTxAs9FzEQCgzliezAEAfRWS0XZhNr42ndDkZrByCwV8fbQukNb8oCzm/TFLt9xTjy
 8S1Km7fkXOo0=
X-Google-Smtp-Source: AGHT+IFUqVIB8p6PQ416dPePfttdfCfnrL9ncPRHjB1LgVZtp4EaEp5Ku1JQP8Ky3iLaBkSrxPTaXg==
X-Received: by 2002:a05:6870:4581:b0:296:b0d8:9025 with SMTP id
 586e51a60fabf-2e861eb07b6mr7145472fac.20.1748377155324; 
 Tue, 27 May 2025 13:19:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c06084ccsm5559631fac.7.2025.05.27.13.19.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 13:19:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Tony Dinh <mibodhi@gmail.com>
In-Reply-To: <20250526222931.2775004-1-trini@konsulko.com>
References: <20250526222931.2775004-1-trini@konsulko.com>
Subject: Re: [PATCH] Revert "ext4fs: Fix: Read outside partition error"
Message-Id: <174837715432.2894052.3605745777922613423.b4-ty@konsulko.com>
Date: Tue, 27 May 2025 14:19:14 -0600
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

On Mon, 26 May 2025 16:29:31 -0600, Tom Rini wrote:

> The issue here is that the function read_allocated_block() will report
> problems via a negative return value. If we say the return value is
> stored in an lbaint_t that can no longer happen (and Coverity discovered
> this by reporting a no effect comparison and then dead code). The
> problem being fixed by allowing for storing a larger block number will
> have to be solved in some other manner.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Revert "ext4fs: Fix: Read outside partition error"
      commit: e04d137231f2e9e14708a32448c879125b8e308f
-- 
Tom


