Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DCA10F2873
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 23:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2759383FA3;
	Sat, 28 Mar 2026 00:06:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MUSSpGc9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5126183FAF; Sat, 28 Mar 2026 00:06:30 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 371DA8394E
 for <u-boot@lists.denx.de>; Sat, 28 Mar 2026 00:06:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-408778a8ec4so1619460fac.0
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 16:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774652787; x=1775257587; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HgCsheST3lRJSe5rmufTtp0p//pMq/TSgo9z1NjpF4s=;
 b=MUSSpGc9Fdc4gEYFw6nea1UHQU/bw+/N7pUUrix7ZPsHQXgCrYp+d3VsjApq26sXvl
 4JxELMh/PzNjHvjHgdCGaDMAZlaw0OQxdl2fhZQIHf12uC9Tf8FqsQ7X6/53xYIV3SMn
 /0/5iFkQxfvUXucUWl1dTlG38pwLsr534xpXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774652787; x=1775257587;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HgCsheST3lRJSe5rmufTtp0p//pMq/TSgo9z1NjpF4s=;
 b=qz8K2pKlyDX57Z16/1kPgpRLbh+UXigT+UpLkLfYKQWEw4ENHBUKXrBifS0YhcgS5K
 uhBdIeXaZrYgWb0+VgIdp9WUFdCe4uEPrpA22SAmDuTNzAOD1MaHMSDxjN8NFWkMYSPq
 sRDMklajy0qHx9ldtXGjOXJDh5EBIsJ+CwZXCcJ2jHZY4MN2QogzfNLWfFqyRVPw9uJ2
 remMNvUsEvFXTRSqPf0sVhzi8bsRS8gIjXsoAGzh9wZu9OsexkBAEbrzeKI9lU64zhok
 Rj86C0QpmALhtJMIhgL2vms4Z6pSdXGc/OqaXxdofHjMl1nC/H/iwBRFtZdR7SW2om0T
 7GTw==
X-Gm-Message-State: AOJu0YyiFfAo6vdGdQqs3S7ax8b7BvSAt77CFE0KLNd5ewKij8g+0Dee
 +5Uq/6x0SNPZFJA1SSuE/wDOKzPkWLWn2yujAUgSTCMUJNuZCZF+VPjo3vHLBrM4IjYrJFLQx5R
 3s5KQ
X-Gm-Gg: ATEYQzwM3zlosTwfst/Fuk/YdSlMAgZoCHobMEMtgJET7M76BWOamUeX9muLyWJfrwR
 gh9WnfjP2XRVRelaC/lRbV91tUOldpIZkwSFAV4kPPxW9E8zTVUAbi/C+7HE0DzluAAEfbaACm5
 jeZrRq9bnIt//5ycj3YvN6+C9zuraEPg0O2NoxOOvdEVzrxvn0X9W8/Ptq2qShnAMElyZmzMpF6
 8R1/6PPMNFV8Sz+NSwETkY/M7Gtkpfy55wsMT5gPqLzsVG2POo6Y7ltzlJLwe4uLMg8SI1Etf6r
 ieHAXLPgzRv1fWcUH94sduPP3IzqfNefA7xaxtgQSw3sbQyIyCcGbGq419L8nmujFjWcWT0zc7v
 CNgaQ34prjc36yzVRc98jGHIA3ajEY1xul54mxEBnTPuyhJ08HjU/b8aV1WHhXIhyObJWWM+Az7
 hTiCuGIMy6vPRHFJ/9wb9UkZn/e2sEhs6gA7NYnnQqZ++fxZKmXVd+ugB8mJlpWP/odGo9Z1Mr9
 +dKWtYzp1DCzcUioHIUnV/gMy98RXgl78dSjl+DVr0NtU8=
X-Received: by 2002:a05:6870:b0e9:b0:36e:8381:db00 with SMTP id
 586e51a60fabf-41cec0f3151mr2040801fac.9.1774652786735; 
 Fri, 27 Mar 2026 16:06:26 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41d04cf9e03sm421650fac.14.2026.03.27.16.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 16:06:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, michal.simek@amd.com, 
 Padmarao Begari <padmarao.begari@amd.com>
Cc: git@amd.com, John Toomey <john.toomey@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Rasmus Villemoes <ravi@prevas.dk>
In-Reply-To: <20260315131655.2352627-1-padmarao.begari@amd.com>
References: <20260315131655.2352627-1-padmarao.begari@amd.com>
Subject: Re: [RFC PATCH v3] cmd: part: add part dupcheck subcommand
Message-Id: <177465278483.41705.7881068652823106651.b4-ty@konsulko.com>
Date: Fri, 27 Mar 2026 17:06:24 -0600
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

On Sun, 15 Mar 2026 18:45:29 +0530, Padmarao Begari wrote:

> Add a 'part dupcheck' subcommand that scans all block devices probed
> in U-Boot and reports any partitions sharing the same PARTUUID or
> PARTLABEL. This helps detect situations where the same disk image has
> been flashed onto multiple boot devices (e.g., USB stick and UFS),
> which can lead to unpredictable boot behavior. Duplicate
> PARTUUIDs break UUID-based partition lookup in Linux, and duplicate
> PARTLABELs cause the wrong partition to be silently selected in
> bootscripts that reference partitions by name.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] cmd: part: add part dupcheck subcommand
      commit: b5517950e6ef9b631299f33a4ce84ba380928258
-- 
Tom


