Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EC5D10375
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 06:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C88FD842F3;
	Thu, 27 Nov 2025 07:48:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DMkFk8yp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6D48842F4; Thu, 27 Nov 2025 07:48:23 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 909DC842E6
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 07:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c71cca8fc2so369845a34.1
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 22:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764226100; x=1764830900; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Dg1lJx45+yRiATL96BgREE3CSirxNlr9cwhXG7aM6Sc=;
 b=DMkFk8ypuuhcjYTvPSqbwaXKreuyli1I7MhmBYTK/WoYYTHMwmibuNUwmszr+rmEN6
 /dIuiXdcbqqB6gWloJrbeODZmmpyZ4/Gdx77ne8sATLwQiFqiIMWg2xF4U095p64hnOm
 LgOZWlsA0XVSO3wrwby2GFR74sE0gSth+EGMkrxx1hVWRHcaDsqG4qWvhXMfHayIb0qr
 NRW39Z+6TQctX71vjTa4TBk28RvIfXOaYvDpF1bFv2FwYR0vUHMBHVnIMeYv+h+9R8po
 ZqI6kOL9dZLbIh7cGLWJTb9YTHp1g/PkE0xnGad43Ot4TnnVWLW28QNS+AcYfJ2Up4zp
 ayYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764226100; x=1764830900;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dg1lJx45+yRiATL96BgREE3CSirxNlr9cwhXG7aM6Sc=;
 b=XU27f/7ier2zjWW3dPFlUcMklFhoTqaOkuaHW/rJnws/zm7n5SHRwWF9PFjYet/oyk
 oglWZQt+NZYtkg4GUMKWkPCc9AlX7zfa7IuH0p6C/c7wjqSxDm7dAXapiWTDd6jnDnb/
 Vb8kuS3yxlIaUaB1aXzVn2IlGNZJwz3lDuKITIbT+oNpWmyq5pOl26Ch2f+BMS6wxsqT
 AkwM459Isi4kolFvCUza+GVEOLsqCJRyOj1asgIoh9mb4HHVylP36Lmv85dqK/2lqULP
 3XrATDw9rAiOhuxZgXo18/vVZTMC+XhyLNs9tZu48qK0AZiIHj6yyJraMEEm0lKDQFl7
 eCEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW25JJVPv11/4OfiawgrOExsE3ZP5528UwQdzW2GGOVaKDBIaZYudGpxhL4IoEK888hx+9DzBk=@lists.denx.de
X-Gm-Message-State: AOJu0YydCkDKi7/2NBxAGMBs/cxpIENKtJtf20BRJ5XmAj4kuVcFFNwJ
 /C3YkfeFbYodEvFN0Qx3wTHND0ZTWZyV8dJLBXjaw0WxGCOkcTplpxKwcxMfP/dyJXU6W49ctQN
 SLmW5GZrMop1zqGxIlddqnM7Kfy+/R9I=
X-Gm-Gg: ASbGnctl9umqOLvGh7cZP2EQ0+8yDE+HwFfdahoGIjysde5tCuFVWJGdbk/YRJ3pgWI
 8A2HN3kddkq3IqXASpZsBEnLtB3lpQ2TjzPYO8Dq8HUuoBM0KXZGfJDWoEpOEsJ2NZwSg1WldQU
 aN4ZXM7uM1kPU3Fk/y4i++EQ1Ko/P1jlmwhiDSnCLF+f6GMfmpWTFaNjN5XX8metzh0k4tRspY/
 WyVs8SBqLT0ESmRxEDyCRP7EMiw/9g2GZBEfE3+Em8Uhie8TXb+gqmlEGvJgBhXH+tEK4M=
X-Google-Smtp-Source: AGHT+IE/ZX3vLGOZl0ekQ9q+fN+JDb2D1pvzecpS6UNEvU+EbCQ6vhRI5JmFKhM/Ha9VbnWrzVpoAJNP16hH+n0MHv8=
X-Received: by 2002:a9d:6157:0:b0:7c7:1c91:1258 with SMTP id
 46e09a7af769-7c798de445fmr8963710a34.26.1764226100170; Wed, 26 Nov 2025
 22:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-7-alif.zakuan.yuslaimi@altera.com>
 <896ecbf4-d85b-4c09-b8d0-9730be370673@siemens.com>
 <e2f1c154-573e-4326-ae8c-ee9ded46c71d@altera.com>
 <dbe16e20-ae32-441e-b987-6cb5feaeeb93@siemens.com>
In-Reply-To: <dbe16e20-ae32-441e-b987-6cb5feaeeb93@siemens.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 27 Nov 2025 14:48:08 +0800
X-Gm-Features: AWmQ_bloXE3N_J7-hvwnPq0BCJB0NpzkYbYdvTGydU_KQPA8dnIjzOyqRRViO8Q
Message-ID: <CAN7C2SCmt1z_rtQBpoBwpDJBCcXWAX7eZTz=mxQ1SqPR=rqWfw@mail.gmail.com>
Subject: Re: [PATCH v1 6/8] configs: cyclone5: Enable SPL FAT support
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Chee, Tien Fong" <tienfong.chee@altera.com>,
 alif.zakuan.yuslaimi@altera.com, 
 u-boot@lists.denx.de, Marek Vasut <marex@nabladev.com>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>
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

> But - as you introduced yourself - raw mode loading is broken for most
> boards, specifically the DE0 Nano SoC. It uses sector-based raw mode by
> default with an offset which only works by chance (if at all). If you
> switch to partition ID mode (like the romloader), everything falls
> apart. That's why I sent the other series. It may not yet be correct in
> all details, though.

Hi Jan,

No additional trouble on here but just want to
confirm how you run your DE0 board.

1) Do you use a pure MMC boot? (no NOR Flash)
2) You follow old boot flash method write
aka placing "u-boot-with-spl.sfp" to A2.
The "boot+rootfs" partition can be empty or
not exist.
So simply the entire sdmmc just contains A2 and
u-boot can't pass SPL phase enter U-Boot phase?
Are you having this trouble in the first place?

Thanks,
Brian
