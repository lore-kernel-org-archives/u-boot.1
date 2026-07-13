Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB07C44501
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:36:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC02E84C1A;
	Mon, 13 Jul 2026 15:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="c3FEac6y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FAD484C2B; Mon, 13 Jul 2026 15:36:09 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D13B584C20
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6a39a267d34so695058eaf.2
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 06:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783949765; x=1784554565; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/BMcmq1pJJENJ+4/ODfnx5cV0ZYQROjI/GIBw//Ol1k=;
 b=c3FEac6ySm2BuagGZ9QPSPbOOhFpj3DeLgGhHwLIYyCRxgH8LdO8s+lUP0g/06VBkB
 rDV1ikMMK5YY9e9GjNmkwz/SFx/tmHdpJ50mes5XYnBRjoomNypD+D8/Ou5bAEnGGBS1
 oFk7l+L2xPFFHJdDidT6AJPeSgoz6EFQcMQ7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783949765; x=1784554565;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/BMcmq1pJJENJ+4/ODfnx5cV0ZYQROjI/GIBw//Ol1k=;
 b=OeP8t6BCjphSKCObTDwGUTBaa/h6avpMVfGiwnS0QDm0ljXOR0x81zmMLjtn5pS4iU
 hAHHTKktQR01PiUaxqpyrOkw2q+0SWViJBaJgf8LCPQ+5vPVHzyPbcBBawVuuAv17K9o
 JdMHbfPubCYHJMQ2eez2DWqTXLHgTUvEIoPHSzose4p43WSUqDDVpJomYIJzrXYnmNTx
 crwdf9v/HZpjdv7NloD9ucQpaMiwbEvFFr+EIwmI/373eYPCjnOhW9/k8taWsqRkP/R9
 oSZlEdfdZRIt9ICJFIUTAiMumMublD2R+NXm/gXDyI3NdIjfVdmrWXYLXSCnhqeOZ3Fr
 1CuQ==
X-Gm-Message-State: AOJu0Yz+BBV0dDdU4U/BgZ7bqOg5u7CzCEe58lrCVzTgcQ/QIZdQ1LWS
 p8lfNM3NFpjNuVwfkq7cu9SYDCRQWCM+ksW3JLiX1ApXFg1vKhmh7AolNvaiOOgItkx1EzhEHcb
 MlEw47BE=
X-Gm-Gg: AfdE7cnvDHKTrxWEDSL29JcZO4EeIrvbyy1/LJknKOgMHlcL+E6w7t60RNMcnX/v+d8
 akfUehdBdBZzVmtKyRRnF5c69T7fuDStV7oqJkXdp25kOBfjaIl1uAco5bxGxi8AI6Z4IpW/+QU
 8B8cJduvhc2R/pa3jz6LJaVXjJQ6oK0BZuN7xwM6VEXWTdTZz+IbhApMrAwfieckYn8atyb4Xek
 v4dtD6OIju1KsjjhUSs5VHRqIo4JnwuzPgtCwhSycJ8sY3TRHdTAdLjysdS82pv7sPueHrMB8NW
 9OGrgPpA3H6Yl96tsdnxOQnq/5lun2q2MeI/JhyXqpvs0L5jVwghD7hUoyzfeibSbuebMXTrPSH
 LZXDEzRpVjlbal3qzjPnS97cNvHqz9PVeZuuUpmWgYzM+ua8PyI5sA0jXfDykvgudHj276JNuCH
 CGDBTU10SESUFF3x4so7Fy+TPPM7gNOADf2TFnrUedR+BxDD8JXrHpzAM/lW8bnf4Ell9W0dikp
 6Bf5FaJhffUHXJy1IND8aj90kc+V0o91mi03WQqFiySGJo=
X-Received: by 2002:a05:6820:4b8c:b0:6a1:4347:8ff1 with SMTP id
 006d021491bc7-6a39a6cee0bmr5388813eaf.38.1783949765539; 
 Mon, 13 Jul 2026 06:36:05 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcb262db2sm12944794a34.16.2026.07.13.06.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 06:36:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260710163706.2827580-1-trini@konsulko.com>
References: <20260710163706.2827580-1-trini@konsulko.com>
Subject: Re: [PATCH] Gitlab CI: Switch to git.u-boot-project.org
Message-Id: <178394976487.3618110.16636917668762632382.b4-ty@konsulko.com>
Date: Mon, 13 Jul 2026 07:36:04 -0600
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

On Fri, 10 Jul 2026 10:37:06 -0600, Tom Rini wrote:

> Now that we have everything available on git.u-boot-project.org, switch
> URLs to that location.
> 
> 

Applied to u-boot/master, thanks!

[1/1] Gitlab CI: Switch to git.u-boot-project.org
      commit: 02f8b8ab6d6095dccf867d899099322f7430d20d
-- 
Tom


