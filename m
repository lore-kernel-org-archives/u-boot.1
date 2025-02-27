Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DD8C197BF
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 19:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7AAD812BC;
	Thu, 27 Feb 2025 20:49:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="OOTriewh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB0D3812BC; Thu, 27 Feb 2025 20:49:17 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D9768118A
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 20:49:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=waldekranz.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tobias@waldekranz.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-546267ed92fso1354001e87.2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 11:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1740685754; x=1741290554;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1Jq+L5/hbXhLhvgzUlumUQYiRqihGXibaKdmcQOWx4I=;
 b=OOTriewhEFK2NeZkXW2YnGWRrLEBtLY6yozdTu/1r6jgN2KBFLh2H/PJg55ua0Y1Yw
 /h/xhlPlTVZT4a1+AhjO0/O4BEl4IDWkqH2Lla+J8/v/dzDkPuWHGJULMwrCx2cXeMc7
 zu3mA7TtXpXepVq1RlN+59mwuRhWxpxaHpnikR0C+a05ox8ISI4QbEus+NLkvX2I9oGw
 rElMyDqd8IOH48qfq9xk9QfyemvarLg/jDsKgl2VJMNetIVAbRn+iKZnO8WfILDR9Ulq
 7Kfc4rMqm1Nvr1TEncQPtTrNF43PSW7c+DQgWW1D6BzcEHsK1oOd+kfQnRlQqJDlWDy5
 hLFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740685754; x=1741290554;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Jq+L5/hbXhLhvgzUlumUQYiRqihGXibaKdmcQOWx4I=;
 b=oOd3wNqDCyf85DUaQWZ6KWvu3qtJJeJZhIT5ZmFBG2ffdWRt9ONzhf3ejuiLgnKeA4
 17ip60WTngKt82Vu0/QLdS1IKb9+lVnZvBZ9Y5FQq8Z8e004b3mwD1Gab7pbix37SOWq
 IaN77kmNUXY94rtQkp5CwTlf26rWLeKEatFI5lTqmBrr9WwZ54SSjK0bSpTPOSj9nxHh
 +2E/rNev9PexP2vgn/w1PHUSWJ4RfRqU1SGFXlYGKn0xLStREqiPexybSbYh2vGFLgev
 yZLNS7WTKAxvaE654SNh7gkWne3XQeGV+5ZB245TaCm8ojbCcDYc/WJrddeLNG6/hcFG
 azZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe0KLJznn/XX2gRmo+PLu3kekLDP8sjR+eHv2I2eU6G+Ag8V2yj+t/R4hrN9cak+2C5uPmHcs=@lists.denx.de
X-Gm-Message-State: AOJu0YwlFc4DTfCA05KJoARXok1EiQd+tIRy6hiC+jkfoJxUcZOYnOTM
 Bi5ILEQwnxhKfYOl9ELWpGvnUymxmJDLNCQVvOuWZLuy4CuyxHdJI9xP1rfAQR4=
X-Gm-Gg: ASbGnctx2gXIHYgEnkR6bh+Y8NL6qo5Fru+APs98gKTZTt6vA/Q06QqDgajT6AV6Tmf
 /8c1+6/3RufcIvlEJSUNwOYVJfZf2RZQr1qJQDb9jL8wjouDjj1r/kodId61y1T8Jn+htrJ+G+h
 ah4+9jZjSJU3fsQ2SK3YZlsmWQFIqelT35/X0pv+XScFiDA2EploYjm2AXNQXTV1ZQdunNZTUKN
 gBqFJwHiMF+jOFCToK+EBtMyTn4oIB48gTem9WlTGIKY8GDNz52rCesA30ikB4Zkmi5Zb8qb3y8
 uirkLHzpKmQ/s8JmB8YJ4KksoICC2ZYWeCIklHliWHbskK35oJretLgDW1I=
X-Google-Smtp-Source: AGHT+IFThqMuM4DELBCDdso7oYHH66vFDWGn9SKWH5zsPDfZXLvX82g6xQEu/u8hXfqA2C6E5j0mjg==
X-Received: by 2002:a05:6512:281d:b0:545:2950:5361 with SMTP id
 2adb3069b0e04-5494c129f93mr341935e87.5.1740685754417; 
 Thu, 27 Feb 2025 11:49:14 -0800 (PST)
Received: from wkz-x13 (h-176-10-159-15.NA.cust.bahnhof.se. [176.10.159.15])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-549441742a0sm245693e87.5.2025.02.27.11.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 11:49:13 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>, Anton Antonov
 <Anton.Antonov@arm.com>, Bin Meng <bmeng@tinylab.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v5 4/6] blkmap: store type of blkmap slice in
 corresponding structure
In-Reply-To: <20250227111519.45787-5-sughosh.ganu@linaro.org>
References: <20250227111519.45787-1-sughosh.ganu@linaro.org>
 <20250227111519.45787-5-sughosh.ganu@linaro.org>
Date: Thu, 27 Feb 2025 20:49:12 +0100
Message-ID: <87h64fb22v.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On tor, feb 27, 2025 at 16:45, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> Add information about the type of blkmap slice as an attribute in the
> corresponding slice structure. Put information in the blkmap slice
> structure to identify if it is associated with a memory or linear
> mapped device. Which can then be used to take specific action based on
> the type of the blkmap slice.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---

Reviewed-by: Tobias Waldekranz <tobias@waldekranz.com>
