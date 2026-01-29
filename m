Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFFCD6B07A
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 15:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB30C83FED;
	Thu, 29 Jan 2026 16:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YEJ4pvs+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F0F384006; Thu, 29 Jan 2026 16:53:27 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 541A283E9F
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 16:53:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d1890f5cafso351427a34.1
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 07:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1769702004; x=1770306804; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IGhGy1hZxzNh9T/0llZfQVOzdUkvLTnAuz7MITTuD/s=;
 b=YEJ4pvs+fiZqcSdMAEJb3cMyjtgYeRA7tTd5I/T2betu7nhDCrapM6HO2Q5MTGN4/N
 SMvzXVoegjsCsyZ02gWnHNBKSZ06GmS8uY696oOYhAVUrOItZgU9LTFpfrlRmUgvV7FP
 MYYqDh+kZR09hey3gyALGdZkg7f6Tb6QkzZ40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702004; x=1770306804;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IGhGy1hZxzNh9T/0llZfQVOzdUkvLTnAuz7MITTuD/s=;
 b=TZUvHZjzkMm1+bJSxZyB/9y10IcEfQIeeawUw1Eeaj9Wo6JbiaSSvmuHC8P0vv+N13
 65Mj9xNBpFxbHoLrxQBYuD8pZGgy1ctnK+MMnKqOZbjWZsZ8TO6iHZ9/xLMn+M6QM/fo
 Fu2pNng+wQm/WXqEPZPmMw0trWLTk+qk901xWy/zTPdh3UgyeDwbrw8y+Qy1Y6g2vxz/
 ie7gEqSU7G7Fy6Ihw476nyfD8phbUVINxfk8mNbiiiWLCZ2J3kRxyDg8fK+5DyHaBhtm
 CoC3Zwdg8/ItKr4PNB57EwKDUAx3RFSByv/orxBhx7xN2zoX3YJUzuqDsq6eKRjq6wjQ
 4azA==
X-Gm-Message-State: AOJu0YwfpS+Z2dnhfS6IV0lnLmMCu9rJ3F3TTAq4a+6X6Cr4cJdF/9mg
 jFAgLS8nT0w6j93pdVBk8V5Dv0QZ8psP3INQcOBfU6g4zWRpFaFkWtFDrjtSn1xbB4vX5Xrtcrd
 t9F8SKCU=
X-Gm-Gg: AZuq6aL9m7MkalO3xjXPkBRg4OswhWR+UxNpfpF5nMPE6dihlJv5MoxxAKAZhHVgKij
 QsimDEO4GiQipP7sTUJByuC7VFKvLc8IiOp8dTxt5zuP3BsFJ/gr965I6k5YuiwtsyNXZoBjIKv
 shGaip027fMIiQJEOgrWqarGVAxeOYjHKzwiSmulqe/i44D6RyGwKi9CZWMSnglR3891pzbKN9q
 SI4amzDPYmeJp5ho19MgXl6KihD3/QxGzZIB0RdvMDxFsn+rqmPF/S0WXQz9irEAZ5/K3A79SXF
 DL4X4j9h/B0s2s0426FkvCIt7l0PoEivp0vdoHeNcVTZA9Yfdu8lzAX6y+lS/BkUTs3YLTZ4z7x
 kEn9jgi89PpFkHf2EHV/1N8tZz5d9XTWP+fVtLJFS1rkuFXofqHx7YfZJdEK/bRXvNMh44esHTf
 thYQCoHXmQ5HyTdHNkzKQGXTt2TaLIY+zR9fmLMpkxcwgax9GhqPwmR6pb0MQDuHuEV2+wo+og7
 2oAH6/77g4b5uoIxAO2cp4PCkqZfKtTKLWgEg==
X-Received: by 2002:a05:6830:440b:b0:7cf:da7d:5041 with SMTP id
 46e09a7af769-7d1a5310281mr22931a34.21.1769702004026; 
 Thu, 29 Jan 2026 07:53:24 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d18c7cf4f0sm3778040a34.15.2026.01.29.07.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 07:53:23 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Mateus Lima Alves <mateuslima.ti@gmail.com>, Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20260128192617.1724570-1-trini@konsulko.com>
References: <20260128192617.1724570-1-trini@konsulko.com>
Subject: Re: [PATCH] misc: Keep FSL_IFC available on PowerPC as well
Message-Id: <176970200325.2016924.4417512214614825845.b4-ty@konsulko.com>
Date: Thu, 29 Jan 2026 09:53:23 -0600
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

On Wed, 28 Jan 2026 13:26:17 -0600, Tom Rini wrote:

> This symbol is used on a number of PowerPC platforms as well, so make it
> available there again.
> 
> 

Applied to u-boot/master, thanks!

[1/1] misc: Keep FSL_IFC available on PowerPC as well
      commit: 3f6b113291c714b19c3acc1b3f07b5a249b0ee05
-- 
Tom


