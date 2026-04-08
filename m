Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EE210F996A
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 18:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A277838BB;
	Wed,  8 Apr 2026 20:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ql52FRRl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0F1B8407E; Wed,  8 Apr 2026 20:25:17 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EBBA83693
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 20:25:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4767e6ff822so22152b6e.1
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 11:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775672714; x=1776277514; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ft7CSv6n+zeYdH+23MGenLCk032empXop0wwJsRaeI=;
 b=ql52FRRl/Gn+VckE/AuRXU+uCNWyHALrkpO8SlmBxiqX4qWWbuCTNi2qn7QlQSWACq
 6rInkUtXRHnln6cRU9L4Ypt8hNoPXisSOn/BtRYP3b0frStb8SFJkIOXZq1mEZr0FBtG
 oNJXoC3efufy0JfIPg7c6hUmIlF2c9ELtGWHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775672714; x=1776277514;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+ft7CSv6n+zeYdH+23MGenLCk032empXop0wwJsRaeI=;
 b=YdTOt8HklwYtoF628cyABfzwWb+YzmbedpbUK3JWznxYBZwyk3XeyKJgjlbPeTUPVK
 Ale8Bc2FuP8zJ5dJYbPdMbY9VkTXOkpcGe9OfyMIS3b2rw+L2QmPulAN6UJ8JeingccC
 4zOyiFXR+ytSBa//mbktDznC7r8joBmg+hOvJoXgOywjkk+VY+EdwHOnD6t6yg3u964C
 Eva/p+9lnXqoCSq6DtCLoCB+A5Evf+h+cPNo8cOsqpw6Nmkgy0yfSEV52nu31D26H4hI
 84vbEkwHBgN+xETrDJYJ6DmmkAKYdzCgXut3P5ZCcvsQq1c1Bnf7vLRufYmdu/QNgyB9
 oeIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ16cWnrG2w+zj7zagFDGOQGTZM4Iqg9vt7t/9iF5i33N0aN6Jj8R/Q7+67ooOqL1l+bzX6to=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4pbVgf6ZoHU1zSiN5bgnn7nOBPvvxyek9qjXuf/BbbSkjGJVj
 XJUnnc8tbLnZhnlf3KqHi5q3PlqqrNZX4XHzGxpBqwIHZYrrYyiC5SAFaV/ngHX/sDQIFjlRT9/
 zzMCmfBQ=
X-Gm-Gg: AeBDieumvKTak/fJT9SmTLUY9ItrTmb7U9In/5/HMfRk8cwfk7ia9xwU5vkJqTAC8O7
 aGRrkNdAiEBe1SZ/cJa85I/25p1XjVv697XRJ39t5d+OgWFcM/vTey3I9SZSWvX7ZbsywR6V7HI
 WeETSd++I1bSBLaGDFhbjulQTTKabK4ZVHxaQbbPv1S8Pnh79Doi9BXm6EAKKVkbtV0BkvffbOH
 6xxydR7neGLeW6d7+Q1xbmZwh/Immuj6jHWEYVVeZtZZsv6BL5Iswc53Ai7EMARgHp0CLIY2o1I
 psTYscJZkJM6bwZH7bQMzejhT+93lukfNhxeN8PCbbSjoCcI1HiLwR8aE2qh/Hb2zkC7nJesCV1
 s1Z0hEemkmc+7lUaykPgtUckegZsEuUxjlfes7LDoslzPA577NefMyb9K02lBw/xYb20vYMWqZV
 6QV+rEI441T4GQTTT44u3F3tW8d+EQchGvhSoK/h2RB5i2xTTzN1+eAgzIHkKdPhmScGFU9BPs5
 thRgk3nDzFOJ2d69qu3+QPiKWWKSk7oTM8wAzrmL2x6MobSLA==
X-Received: by 2002:a05:6808:e85:b0:467:a59:a678 with SMTP id
 5614622812f47-47721b81fefmr420619b6e.13.1775672714272; 
 Wed, 08 Apr 2026 11:25:14 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-472813cdbe7sm5953554b6e.7.2026.04.08.11.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 11:25:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260326-cmd-scsi-drop-reset-v1-1-01956d061acc@baylibre.com>
References: <20260326-cmd-scsi-drop-reset-v1-1-01956d061acc@baylibre.com>
Subject: Re: [PATCH] cmd/scsi: drop scsi reset command
Message-Id: <177567271346.827346.16563155809332663443.b4-ty@konsulko.com>
Date: Wed, 08 Apr 2026 12:25:13 -0600
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

On Thu, 26 Mar 2026 15:39:52 -0500, David Lechner wrote:

> Since commit b630f8b3aefc ("scsi: Forceably finish migration to DM_SCSI")
> the "scsi reset" command has no possibility of actually resetting any
> SCSI controller. Drop the command to avoid confusion that the command is
> actually resetting the SCSI controller.
> 
> 

Applied to u-boot/master, thanks!

[1/1] cmd/scsi: drop scsi reset command
      commit: 8191d234571e39a49490ab3301cea0106a4ebeb3
-- 
Tom


