Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7ACD3EE67
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 13:42:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 548CA83B87;
	Thu, 22 Jan 2026 14:41:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ipIAGV1t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E04EF839DF; Thu, 22 Jan 2026 14:12:54 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD59980077
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 14:12:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mateuslima.ti@gmail.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-38316445a67so8168031fa.3
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 05:12:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769087571; cv=none;
 d=google.com; s=arc-20240605;
 b=ElmrM/5zxaIMz5JRSnY+9Miu1Xh2oN/oApTR0FRp4IK/DqGQe1Py2AW0GvynZPilJh
 n6QbzD7seMzg0vLYhVcb2KoumN09tUMrs4ZcQcOZk/wD7/zZvHInJGFsywcIwZTtBV7y
 zw4ID27TO3zyUWD1egDlh9pdd0fzAhFb2u+Igw6HZQI8idrjvju8zm4duAl5jd7TRwvS
 4OpyVk8dGj/bPsOdnxSUVvolWlNV8ZasFducO7ptZLuFAlDSQNkwMOSg3sS5AzzcadQf
 E5YiU4gCytQNwmDJy/zERITMR1ywmG3pDwMYhLfrtpyrxWtrkX5EEf6jZIkK4F9RoU0T
 zASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+jnq7ygXtkMgKPFVg5hWmBmzWnRHiZcjMVGn/OkW7+c=;
 fh=duMmhiJQkwXc6bjeypO5m2UMHNQCnfs+hGYbGltw4dQ=;
 b=ZgDLCEWS7mc9TukLSIN6dWngh1mZqqI9kCw+bPmqmQDQwYbrfeSaJfooVhYeuSrI8O
 vQtOpjPekfzE2IobrxGKKVcGxG17iALCVHDmdzjluVmFgPsXQPCkyFrnYNN9d19D7bgn
 b4OjsAkQxrK1OTWOfR6HIdIrtKD/DbqlhetRTr63Q6vJh4LkKVcZE6TiG6LRdOcVKHma
 +ZhufbrrAGdGDgWOq74/nnVa8ESr6+xrzYqo4fkZ3jd12eXWh0IyeVr0nNUr0awMeKa5
 qRbKjjB9G92VvVd4sb0eFKPw2OQdhvb6X2J4zqcEL0qwzdTd+A1pN8MTRm25u8vtaJLh
 1TbQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769087571; x=1769692371; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+jnq7ygXtkMgKPFVg5hWmBmzWnRHiZcjMVGn/OkW7+c=;
 b=ipIAGV1tYPMPKC3bHryH0AXxo58xtDy+QYXpLHYpN/PGGgO7jUPAl/T9FpGCUL7lqa
 TMiIYZ7U+LJkKf9G8b8cOAUr6rC6dFo4GdTjiSOeSEnvPZOVfrAO8NPnEh4c6ujbk8nI
 1I3WNOdPG/cGWFEl6txrdyxRQ3PcHn9oCea3xV612DS7Hny5i6K+xrcLOZoiwhG2uWDE
 CLRXdOLEiTjg7T+6E+lkF4Gfq0wCxaOBebbZdS68lZdkPmgbgccZU+gHIhgRdY0YuiW+
 Kmw5nc/VNvM9tDkai6WkMHQ9ltSgkyotyNKybeT1GLyjRfa7t3HUeiSdKtrV5EACuGfN
 6T6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769087571; x=1769692371;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+jnq7ygXtkMgKPFVg5hWmBmzWnRHiZcjMVGn/OkW7+c=;
 b=ebAfJAiYNCfoXVgVdZEOyKCli7xlpjrMYd+wUU0CnLq5Ti5NX1CmG8IvrhJgkpfeNK
 o278U4dfSNqgIf2vCO+EMqYBQkjjr86K51hSutpE1/JvAQUMqMhS6zIIAMhLdiH7U+ie
 eD6uZ+iKLDB5qng3mT13WJeTKtPq7BKd+roxFVkV2i10yLnMVXvoIqdSGkldbuyg+GW9
 JSUepy9AWosniTVserppDFtnhEQZl2E2GT9WuUJSGjtZHwQjlMyy2iS4kxjVmAuCLnW4
 IPoSvb8zHtWzNjojgWe/ApLydkA9jECwokXv7xmYJITQ1J6Fpq80u+5b+K3TrvclqNBk
 vTMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV/YM41CWaodwkvLwq1lpEBayKO5Ds5iaX7yjJdB4ID/4PeDbUyeVqX/Nrfr4EQ51NIe0DQi0=@lists.denx.de
X-Gm-Message-State: AOJu0YzcX+DKB3uOTC2UQIv1AJH7qK6qMs+i0Ez4axtbiiFN1GBGvtPG
 59Ojy4o+K4/WZ0agxvtHFrCQekDi5I+6oOl7IqO8n1hWBR9Q7MNXH6xnCj7aT3+Rf7tDizDj5IE
 AQhviBLRb4Z5soXOZ5Nh3v5wfre53DSY=
X-Gm-Gg: AZuq6aJxomybB10lqbfzQYWOZPxa6Lg3PC3awi6YxAByCE956AHeoXRb0ieuK7dDske
 z27MlWgQGWCFpDfwl2lgQvIx4xfYcoLmOTHYxgWzt0vV3tcXd/QoREBUJLBNqXHSFypxoY1fgUF
 EyxIgjde6NKUTgrSdHn1CF64lNkEjNlH95fhJ8kIyJUQS0rq9uGi4sUsEcFav+cxh00ELoQB6JI
 4ayklCfzSqdHQewRhD7mxHN5tZWFfN1zb0iejUHq81ffQYn8ml5J2IOknZBdM9Izv490CY=
X-Received: by 2002:a05:6512:230d:b0:59d:deb3:8bd5 with SMTP id
 2adb3069b0e04-59ddeb38d41mr773141e87.48.1769087570516; Thu, 22 Jan 2026
 05:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20260113142303.441190-1-mateuslima.ti@gmail.com>
 <aXGZVQhGzIrtXY86@nxa18884-linux.ap.freescale.net>
In-Reply-To: <aXGZVQhGzIrtXY86@nxa18884-linux.ap.freescale.net>
From: Mateus Lima <mateuslima.ti@gmail.com>
Date: Thu, 22 Jan 2026 10:12:36 -0300
X-Gm-Features: AZwV_Qjof-Z4YWyKMaj9jp_z03uy_wxnlfME4aFVbalCiWOODVLeuR7SFcjA-sk
Message-ID: <CAP8WwTH5=Aqy+QLLRv9QGJ3RTbwyMXA88BsO4eJOB-WawHfHMg@mail.gmail.com>
Subject: Re: [PATCH v2] armv7: Add CPLD support via IFC to the ls1021a-iot
 board.
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: alison.wang@nxp.com, u-boot@lists.denx.de
X-Mailman-Approved-At: Thu, 22 Jan 2026 14:41:52 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Wed, Jan 21, 2026 at 11:13=E2=80=AFPM Peng Fan <peng.fan@oss.nxp.com> wr=
ote:

> On Tue, Jan 13, 2026 at 11:23:01AM -0300, Mateus Lima Alves wrote:
> >This patch adds CPLD support via IFC to the ls1021a-iot board.
> >
> >Signed-off-by: Mateus Lima Alves <mateuslima.ti@gmail.com>
>
> CI report build failure.
>
>   CC      drivers/video/hitachi-tx10d07vm0baa.o
> In file included from drivers/misc/fsl_ifc.c:8:
> include/fsl_ifc.h:16:10: fatal error: asm/ppc.h: No such file or director=
y
>    16 | #include <asm/ppc.h>
>       |          ^~~~~~~~~~~
> compilation terminated.
> make[3]: *** [scripts/Makefile.build:271: drivers/misc/fsl_ifc.o] Error 1
> make[2]: *** [scripts/Makefile.build:492: drivers/misc] Error 2
> make[2]: *** Waiting for unfinished jobs....
>   CC      drivers/rtc/ht1380.o
>   CC      drivers/video/hitachi_tx18d42vm_lcd.o
>   CC      drivers/rtc/i2c_rtc_emul.o
>
> make[1]: *** [Makefile:2191: drivers] Error 2
> make: *** [Makefile:362: __build_one_by_one] Error 2
> Cleaning up project directory and file based variables
>
> Regards
> Peng
>
Hi Peng,

Thank you for the test, and apologies for not having validated the patch on
other targets.
In fact, this driver was not being used by any target (neither ARM nor PPC)
and after this patch it became enabled again. However, PPC targets fail
when trying to include the asm/ppc.h header, which is not available for
some reason.

For now, I am thinking of submitting a v3 of the patch adding an explicit
dependency on ARM, something like:

+ depends on ARM

This way we would avoid building the driver for PPC targets.
What do you think about this approach?

Thanks again for the report and the feedback.

BR,
Mateus
