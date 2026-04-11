Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D403F3ED50
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 17:39:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0202384118;
	Sat, 11 Apr 2026 19:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iScYyK6w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE83C84154; Sat, 11 Apr 2026 19:39:46 +0200 (CEST)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com
 [IPv6:2607:f8b0:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DB5783DC9
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 19:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c766a95a72dso2027594a12.1
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 10:39:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775929183; cv=none;
 d=google.com; s=arc-20240605;
 b=WtCILOxvG/uttySyPdF2A2OSfAzGlUTQJQ29JGjOYYU99wf19cBeuBiBYpqhq41NSj
 PvUhGK4bDjwWG2yFCDmjJWvwKl+ZsUkh8Z9gAdVdcY/MH+PoYTn4AP5Ex2Ict++ZKcL6
 zhhxcS5se0wBbiaKMrZBcI6oMScQ+6MSaWRDXFsbbl7mPvqhv4nuEiNS4cI06RH+EwxO
 AWiIUqS16/j6+K1eomp0AVEfWjhMXNI/x1zVoCUl7Rahu6THyVTt/J4Wllhcd2VSZWEy
 PAqaBuU0tReZb7rB6BRNAmzYmQfAzwIZl+G2b5TthMo07VoDaSkIG29KLH6EVg/DF4iq
 y+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6lEbo0zYPwTdJL7kyJ2Xzt2F01WOM7CTr2fXCAeyeew=;
 fh=RMotW0d5XlV4ufFtnrZdzQ0yk4gZppNtVCUWCpNgShU=;
 b=LOzK5wOrQm+N1+5+sZF/6IoBRze+d9RZJwng+irXRdv74ee6Q32G6ltCYLRZXufdzJ
 SCzMX/OCgwkcY3m3o/rfROFBYby+MGKDcZcliuUk/mnIb0QACSmdXJTNORgl3CKEChg0
 YvGUzQHbH3vY6tV3GEHdJAOXriS5KNzSMgF8EqcAQRAQV8Ttv0XBc7uGrMpNCxMnWW/z
 8Gr7mlwYJP91XYk1qjwmSWRmOo0kbZYb239OPkofcThQqZvh3yAyoP1/G2W0QiO+cCp9
 k4HnrgJzWxtdMvwyBxhke53tnde/yDMK4fdWvRBuv6+XL03awxhFKqh8X0llir177nuv
 8TMg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775929183; x=1776533983; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6lEbo0zYPwTdJL7kyJ2Xzt2F01WOM7CTr2fXCAeyeew=;
 b=iScYyK6wH9kw3l9qm8Hf8IlOK0KIZ3XJdEorZUfdDNP6eNAyjYskIYxtnt9ndfXZiY
 DLJswE7h7rr54Wwlw55AkCE9/vw7iXnb+1K60/+LqprHC6PRpMP8pMU/s9YyDAf3vzwH
 CB942DT6fV+BOM5725Vz41Od7phjcLl0MPs1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775929183; x=1776533983;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6lEbo0zYPwTdJL7kyJ2Xzt2F01WOM7CTr2fXCAeyeew=;
 b=FNMMliU6oLDmU6cNtJJdluZZhxtGv6j52nEDn4R+yhMY9yE9YmDwHipU0q6HMQjEpm
 ZHKjTMnUiXrc/JgSqGGnLAGkCKomcGLKhEIyZAMeK5o5uULvf5khp3Uof8kNtAAC3PEs
 1Rd08/Bs9qnn6Gi+itFiOlUltXiiP8wc4emCRp+KTBj9mNE/xXGn9v8lW9uGMqwW4v8g
 +8el/OK2+HNSsKluv6U19SH9gnNpNrVnvC+mI2GZy6L1jB9sYBjKIKO2YO3Rfo2+BjLa
 8lKYoBUHjs4aMvu3GxLc6bIf7qRhPlP61XjkhgnoMeP7GmoElAjTthLivv0sCLKR2v96
 HaWQ==
X-Gm-Message-State: AOJu0YxoyfevWazdu0mEl/PLpP1aVApcS4xivDbs/Sqckt90tFurxiNP
 KudSa56AyB6LM6P8nkaWgzCIyPJJVo97plZ8YIgJ+W0xDdcj1oJ9syAzP0dg5cJCExZ3Xm7zaXp
 0aNzpuU5Mnq2dj+FrwwJnZ9O6aJKST6vCKqL+vxP/He1QQf90eerEcCLq
X-Gm-Gg: AeBDievGBbtq5foY0xuiR471qu2fjf8i1QjeNI7xB1vM51HO0ui0fanoEjBPJ61dEXP
 z6jNvs0em3ORmwBoViczlQkWRlfsLvXeuSim77oHZOLosqSVu6wil6FrSRNfGdOJH4TEubjVXDy
 uC3+7J3F8fFrRS/z+RhvI1WQqpYJ0x6cEKaTfpY2bZ0zE2ov50TsVkxh0LkS05VNxyz4CMKUP9y
 Y3jrmBBdLpEv/EJxYysD1ojK8lFXar+d3VUCjvSfoRTH7+sORMMqPc9DAWY05m/XFwLd0Fu/clC
 y2jezA==
X-Received: by 2002:a05:6a00:2d85:b0:82c:9126:31e3 with SMTP id
 d2e1a72fcca58-82f0c31050amr8568818b3a.26.1775929183029; Sat, 11 Apr 2026
 10:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260408140339.798015-1-aristo.chen@canonical.com>
 <20260408140339.798015-2-aristo.chen@canonical.com>
In-Reply-To: <20260408140339.798015-2-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 11:39:24 -0600
X-Gm-Features: AQROBzA5OsO_lWqmSomBn6E6Q7Of7o4XWcnMf5a3VYoKLs4lmtH4peoH1AM70l4
Message-ID: <CAFLszTik_GipbFjp5w_kFiDjBJwX9GMEwH3ChUgoMT21ecJjzA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] test: env: add test for himport_r SIZE_MAX
 overflow guard
To: aristo.chen@canonical.com
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Aristo,

On 2026-04-08T14:03:35, Aristo Chen <aristo.chen@canonical.com> wrote:
> test: env: add test for himport_r SIZE_MAX overflow guard
>
> Add a unit test that verifies himport_r rejects SIZE_MAX as the size
> argument, ensuring the integer overflow guard added to lib/hashtable.c
> is exercised and not accidentally regressed.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> test/env/hashtable.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

> diff --git a/test/env/hashtable.c b/test/env/hashtable.c
> @@ -122,3 +122,20 @@ static int env_test_htab_deletes(struct unit_test_state *uts)
> +     /* SIZE_MAX would cause malloc(size + 1) to wrap to malloc(0) */
> +     ut_asserteq(0, himport_r(&htab, "", SIZE_MAX, '\0', 0, 0, 0, NULL));

Please can you add a check that errno is set to EINVAL after the
himport_r() call?

It's a pretty old API that!

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
