Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D3C2CFD362
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 22:33:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2331683F01;
	Mon, 24 Nov 2025 23:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lkYELg1d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A749083F0A; Mon, 24 Nov 2025 23:33:39 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 487EB83EF5
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 23:33:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c6e815310aso2792154a34.0
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 14:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764023616; x=1764628416; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/mlaqmxSFVKsLC+XjhSbdO7eNt4m0LOBJct9oXdE6cs=;
 b=lkYELg1d6fK0j5QkXtBaS0QrDBDd5XjwqMz3BQulhk3LsFvK7tlIpQ/TeTCuFYPbJN
 8oeOm5torlWYqJqZuQHeuzm+Hj3eIWWzQKbMvNm9pIBdePdq+uHuYqE0DP2fFn/SkQSb
 sJjY5rsjaUDYqEOeJrUzj9aMpTBq0D8DsOu7eFGK3gZ8ieXhIE/AiOgO4c7P0+lluB1D
 q679Z3POb36ljZMQhK1uysckvHSmuZRI+qnXgni5085HY1YcNFM0swkn3IAeS10Ec9ih
 6vpU1pZIFgpn9CwvcVHQ2vE5o8cO0UtgI97hOjwBDAIJmJgeQlM3hViRlcu0aIAemPu8
 IWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764023616; x=1764628416;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/mlaqmxSFVKsLC+XjhSbdO7eNt4m0LOBJct9oXdE6cs=;
 b=FrVj0Gj3tQWwlDjOOXKiA4esFH2pGKSnB42Yf5lSHhe0aNSnjvliItkUquP7jIdGFz
 l1zyeqRiOHxP8xHH85UBf5kajcsJoA1zlhvmzwJCwPoh9RQ9a5IMNEdUyCmKfsDcZr4w
 VuBmy+Qd/08FXnJLyFdSlA3hEeK5225UsoKUaBmAKSVU6xYyb7hub/HRvjsuV/yq3bm3
 Dakq5qSSra+yhRnw5rBxOKAU/SJRfNo6QjhEnrJ6j56TSU6LYgRELCFiTZLdHqWizbQH
 Jgk21/xRwgEnMLbv5enwsz3/4SQfn6sFHINRmbYQpYeYiT6I3BgU0nx/S5wUr0QequYN
 Mx0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrNq6FZghlvW6qrSZmp8e7QawCZp6h6+cnmbTFry4MTk5MYHa6FSFXbHmV4fsb24bAism/ETY=@lists.denx.de
X-Gm-Message-State: AOJu0YwUoLOpkkHg+fJbrD+TOQNgTGwsbLMwTIjolgJgHLmfJ5B1owjY
 Xbu1FaS4v9FtdNOe6JSXJ2eyRARufzVVik2WbjbA/J7Y/uhN8oOTisMk7sp0iBisVeb0+bM4A5t
 Lkm6xx5O9yj+yOxfIOse/FTUtJ6AOBjPCh1+DM1xgOA==
X-Gm-Gg: ASbGncs6F6AjmcuOjqQBgl9bExMz98rdeFjdQYpO32A2a8kNmkqkDuHuwyBKdXI6tL0
 XfF9Ya1Vw3ZTMSTUJVnV2NixsvUFTBnCQkBj2FbOFma5qZ3pCjVkIOHK/VJUbqK+ogGzwNBK4E8
 7pd/2QDxJT0oB5Mi3mnq2S0PTyMxDnz+ltJ5eCVYHBqFQl4mKFmlcjFkXrmOsumlBi+NH60P9R2
 SeBMBrVwLnquUMbgF+/PnKWYeIsRaUCjuQ9MTsZDhuJujrbkFUpojHrdQOzA24bLDL9vyNm
X-Google-Smtp-Source: AGHT+IFR0xSlw3GPjvZuOqXFKhzvojtjtXk28ftesB01nEB80TsxekfibAGfpQKUL1FgnJYeEa2E+jRurUWY9pMlQn0=
X-Received: by 2002:a05:6830:2685:b0:7c7:5974:3563 with SMTP id
 46e09a7af769-7c798de46f2mr5684379a34.29.1764023616046; Mon, 24 Nov 2025
 14:33:36 -0800 (PST)
MIME-Version: 1.0
References: <20251115113118.783-1-briansune@gmail.com>
 <CAN7C2SCQQ62=e6FEVW=jrLSj8hoWjDxUWMjQGohrpaeYjY-W9w@mail.gmail.com>
 <27fc092f-36e5-4f20-b8b6-c25e529fbe2b@cherry.de>
 <CAN7C2SCCA9CV1rSEy1fosaE=EDE70LMOLcfTsVz4nvNMsH0mFg@mail.gmail.com>
 <62d063ff-7420-462a-ad51-a47a2e53c52a@cherry.de>
In-Reply-To: <62d063ff-7420-462a-ad51-a47a2e53c52a@cherry.de>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 25 Nov 2025 06:33:25 +0800
X-Gm-Features: AWmQ_bnMCl04uihCxui8ZudCxf2p77ynXn6O6ZC01gLNpEkSvh37LoJvXA4qEuQ
Message-ID: <CAN7C2SCs0jzd3go5Y326JtOHThe3QY3dWT62M2tjQ1nJ5q=VEQ@mail.gmail.com>
Subject: Re: [PATCH v1] SDRAM Calibration Failed fix for GEN5 SoCFPGA
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

> My hunch is that SPL_WDT is enabled (or whatever other mechanism can be
> used to start the watchdog on this architecture/vendor) and somehow the
> watchdog is started in SPL but not in proper, in which case the watchdog
> isn't pinged. It could also be a remnant from the previous boot if this
> is a warm reboot (e.g. the IC isn't entirely/correctly reset before
> booting U-Boot).

For this I also tried manually master resetting the system (push button).
Hard to succeed but if "Barry Allen" suddenly helps you then it passes.
And triggered a boot and manually entered reset on command. The
system will fail as well.

Any compiled flag change i.e. optimized with size etc will even worsen
the boot success rate. Also make me feel the more you do before cal.
the worst it gets.

For register map [1].

But I am really sorry I don't have enough knowledge to debug the root
cause of it.

[1] https://www.intel.com/content/www/us/en/programmable/hps/cyclone-v/hps.html

Brian
