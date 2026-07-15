Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4067FC44501
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 18:39:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B56784CDA;
	Wed, 15 Jul 2026 20:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IveFtY7B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0159384CDA; Wed, 15 Jul 2026 20:39:38 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 212EF84CE8
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 20:39:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6984169c126so10699761a12.1
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 11:39:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784140775; cv=none;
 d=google.com; s=arc-20260327;
 b=OpA9dIxLm8jztMo6LuCdnhhcPgBSNwgdYHQ5NIjEepsCRi3VhNo4HhOnQ3Lq90qn4v
 7UIkVxWHy2ZmrnIiWIOl9vZIUfvaljYDtdRObky9RbGEKR/irRm4BYSY4NCPeUem/Dpq
 XPsEqlxaYdYgss0OSv5y0FnS1jJM66ZrJVPjcTabKJ7gksBGQO/JYz8EYhEpMD56B3ol
 pYfvnk8VPywsDd8UhfjEyAvPNu/itBgc41fyzHkcwWedetowk4swogR1CUy+MZTkHWZ8
 UkXqXKMkwa5l3FNywUsbqivr2q+AT9XiIOME9P4H0lRp7kgdAdeH7pcVpiOwnbb7YcVl
 imvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QfKocPhPI8Of+WvVXQ4jnbkhyJIfixOp9RICzdgoRiw=;
 fh=T6Kzv4oXehom+zRo3YTqcMr7OqKQl8V35hdJYSfjQGM=;
 b=UKzlAY+c08wqpQ6yu/IGCW4f93WWI2Dfwn8vdOPzqNX/UtJbSCEAih0YNp2YG5uJty
 X0jdHIny/GEBAjI81Z5mTBa2p0cN7KL/q7LcAC3SLHXh5FAKrTvmW4Ux9t39rYCAK7ys
 TS67E3nqoZQnX/JsE84uGUTIuG+xL+OLq0w/zakp5LwV0M5I0NXszjGnEZkiXawPo+G0
 VvWtI6/NbLbBEhvwKyh2F2CcFpbITpVLv55M6kcQsjEZyD0qV5rlAu0pxmAd5nMaeNMR
 gf/3DycEIioILagb3vJpWOMWR3mwj4t3z4ENqUayC/7hlWjARE3clZgrhZiFYffyqYg8
 31hA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784140775; x=1784745575; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QfKocPhPI8Of+WvVXQ4jnbkhyJIfixOp9RICzdgoRiw=;
 b=IveFtY7B8LHaPVRDWHN1ZCbYzHVcnoVZOfnS8dAOmjCEVF/zh8FdDwhFVbnnz+ChDA
 cWFBj1EIUq+mq/A0+7AlmdVGg/xgvxW3azCVZlvjr5IljIB9Z5Y3rRCUulItlj9RvHMd
 VoFIVcOf1KdbjG14bXcqJ9SC+lx6wxxPk0XT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784140775; x=1784745575;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QfKocPhPI8Of+WvVXQ4jnbkhyJIfixOp9RICzdgoRiw=;
 b=dC92oukM0dkmgFP5BC+fP/CCfOe0dE88FBr1XRI4h/74WoQUG/GM3thrRGM0PQxkBm
 liNgvxHrYD9ZMywG+r2d8hKcHaTwdsSbHdlR2DL/5b48wG2k0kmNWeyZLiPIstaXJQrL
 CFzd2AIvrMRiy0Je4BjFJs0JS3oB+mf/596SrpdhfAmva5q87uZ2ZnExuLM20XE4XGPk
 je6zJ6uOD7CcIN6wWJTd8Flpc/iZb6IQkNt0GBlxKmOHwubI508KeKuhlqQM8ACpMOZW
 liCB9FO2Lc9F1RcFaj6KHHv2IK3EvgQ8vq/DaZ/wGUi9SZH+FqYaDQgiajfGTFYQTzFJ
 pZiw==
X-Gm-Message-State: AOJu0Yz2Znsnm6MqX1OQY6T1r2IlVrror98X3TWw5+OL+vwosJZkLeoT
 zI50OctCUsFsquwu1QXYRQO+QK7mDHHqSfOyG1MYI2lR2vf3NEJQuC9wzDEX6NcHIa8BoOZLENk
 9jhgwxlEL9XGHCUPFPKllouA3X4N7aA3JJ9S474pl
X-Gm-Gg: AfdE7ckpLh2wcRckOIKiuy5LfyFBljE9xnEEfuETIUJQnB7VD9s5lLCMJ7cb5u+C8Rz
 a+pr0sd+DIGIxSkHHzgctuOgI9WwmiA8do6EFLo7ragv1MWN84z/51zl5pGAyBhAb/zn/SrsmOK
 G7wdp/y0VJ4b38M0V+EhAEw87sfU0v5Vmzv4zYjV9tOtZY68uF1+37NydY2zImA2qyvxfSl6ozI
 /NgcZgR6p7pcyfKBedWRDmRpRmhPdfJjcuMiu2kVADcMDptzwPf0eBnx5qAyO9Yqp4BgDg=
X-Received: by 2002:a05:6402:5108:b0:695:822c:1083 with SMTP id
 4fb4d7f45d1cf-69e199df9d7mr2443765a12.28.1784140775569; Wed, 15 Jul 2026
 11:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com>
In-Reply-To: <20260710-rinta-watchdog-gettime-v1-0-9a982fb93f49@nokia.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jul 2026 12:38:45 -0600
X-Gm-Features: AUfX_mwJQBZn1anvVXivyXnTicdZkmCd0Er49fSkpsRDvBuT1vCEgDQesh-bz64
Message-ID: <CAFLszTijPuGRY2vAN8L2wX41OM6119Fzpa9PF1aVb0uO5Ku2iw@mail.gmail.com>
Subject: Re: [0/6] watchdog: report effective timeout and add gettimeout
 command
To: juuso.rinta@nokia.com
Cc: u-boot@lists.denx.de
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

Hi Juuso,

On 2026-07-10T04:51:17, Juuso Rinta <juuso.rinta@nokia.com> wrote:

> The series introduces a get_timeout operation in the watchdog uclass,
> which is used in the start-path console print, exposes the operation
> with wdt gettimeout shell command, and implements the operation in
> sbsa_gwdt, octeontx_wdt and sandbox_wdt drivers.

Thanks for the series - the motivation makes sense, since printing a
timeout that the hardware silently clamped is misleading. Comments on
the individual patches, the main one being use of per-device uclass data.

Regards,
Simon
