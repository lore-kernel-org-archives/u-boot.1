Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6BECD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 14:36:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B892884875;
	Tue, 19 May 2026 16:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="a14gMqK7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 613A584876; Tue, 19 May 2026 16:36:22 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B245284874
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:36:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-48270f099d5so3020218b6e.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 07:36:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779201378; cv=none;
 d=google.com; s=arc-20240605;
 b=ejki3BM2u6Jo7kxNwnRhcPrtPEfh35wbdBMd6+muvUhIkb4+zgwvBVTAtWxUJZRutg
 VKh5Ok4e5jCQ2v4i5r9icESAf3XvK/02QtAJHQolrl+ATfvP+K+AWb5cur8mp5LLzcbt
 JKRgcM8VgfN3mn9h1b/FornvgIXQflqApnq78ThkkSIrgT/ldHjdAe3vcG+6a9oYbp3C
 nYMdzrkz4774N+/k4C2zzLd2v8IczKRI0Y7le7BzvPs9jOMei4txbJxJy0YTYyGezTgm
 jCZYCvktVskhxOxMkjIrwonMYD9+BPTNkSROM7aPK6k+ohKgYDteT+DTxjFHCSV77Hpi
 veyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LujjIojfb1rd7r/zr9EQu6418ldLFKl/nqC+LxBQr30=;
 fh=2jvIhbbpXRpGY1DzXwVMJS5Fz3+81UgGv1YpcQNj3mM=;
 b=QkdshqiToY6cp5cHM30q2v5zHBoHV/jQaGpkmmOWZF9tOW/uGMHZhhVXNrrNyPEZj7
 +05ATFaKJ2czozGdg9PIFbHEXmz1lA15Lwg2DXMN1ylTz6XYm7DQN8DIh3c+O4G66tUE
 95zIeWgC+GzcD61bKHFtOR7zzgTJ0dLfaqONWRGbtLvoQRqGIIvkURDnAZhoHhpupQyA
 IqOaMc0+aBgf0GO3Ep+8m837VdEXocgzd7BMyl+AR2ukXqKo4Wd1cmI/OVSB+QcnwPuA
 23q7YQYtc5+/b6pLyAxdvFOvN3XvIgYiJZqHu/Idv4XD7VwN7A/SXr6AvWbVi2l9S2d9
 kuBA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779201378; x=1779806178; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LujjIojfb1rd7r/zr9EQu6418ldLFKl/nqC+LxBQr30=;
 b=a14gMqK7PIC47su6qB5vY4Q55Z4TRDq4JTK/uzYPVWYIcb+EdqYvHsT4GbsRKQM9Ef
 ll3EFAyEQvNhwrB9Ta//yDFJKdSYH5c0uLBHzMGE5oTjPmcWZI3Yes8+RKcLl/8RbzoP
 qIUVOkRdGiKQ40kIrkaXlrbI+Z0aNcNUgSX/hJI4i38SOfxH+7Y9f2QE0YH7dXuBjVSj
 XpXSgLsdaWbE4aQ4xXFeL3IPC4xwolGw2ui42kAsAoVSZcHl95CKeXGd4Wis1gNbeNvl
 cAPScnDfOPtBU0RcniqPRcoCU89Xvbd0pyTruYDKdJR5SG8qww2/bdKtNCzFSdfeFoOk
 oXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779201378; x=1779806178;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LujjIojfb1rd7r/zr9EQu6418ldLFKl/nqC+LxBQr30=;
 b=dhD1EhnxiseUEc8Lj6dgLIR/omvVB7lgtNljUdOpm7+opeiLclc1ZVpOJRs6ChspHK
 bkrjxtryoIgjp+Hmq/5rGVi6vHy8ETjqQ9B61iMGHCjD4MQK5t0dysLkpyxbdK6ttfUt
 7PYbklumKVMxafRLTLLd7QaGY1wVOW+lNUuqm7NM2HuuBJMGBDOeyb9HknWNvJOh05Ru
 hFziCsHXe8gUt+i4v3KH92bijmodo+6V54AuHepWk5Myc4WBF/Sj2RZw96aQP4XgJNwM
 9XLlttnJOGOhHriZkmElMgaddt4ndGQHMgPOwhfhlFOFKFkYar+UBbL0SyUByKDFr4O3
 kIUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8LU1ZIYtqfO0tA0j5TokyZj6MhUneSeLJo9ncu9v7RsQM1H0yMy7XSnzFBUK/SZpsW0V2Q7XE=@lists.denx.de
X-Gm-Message-State: AOJu0YxcWoBTNt2lUzScv816uXQ6cSLX4iszHHnIWLQR37bQE+T1NLn2
 fsqC/TsyhHzu1CqI7twKRriF9TiC0mZbyO5yteRq8qi6LLhUKKYthXdiVGYg30H0XlXsLXf9v3r
 vOPXnwDRGJQeMYLnzBsAZdLjpUh4mhj4=
X-Gm-Gg: Acq92OF01eDggnvy0eo5Ul8hkqElQVR19gaBv1Z5C16zYJmh8P8OAUQAq2OcJBG/V8o
 fvyr+833aldck3HqZVKBQVZGLQqwm9E6r+KNKitD14TQ91UzVArhQOKh7x5QoTOyoqLPzccclzg
 5Rd4sXAVF58Caxajy9EjCyC31Z5Vrj0Z++5nSjJgp9os1sWntYR9s59HHj4uFqlWlAylafnEOzf
 B7/3wTc1ajtPTbfoS9tmON6/rmv3Pxhbl4Kv7iwkp/KxCJ9Kw777HQoUyoPSV4W45xXXNJzBMOx
 6KbBFvM=
X-Received: by 2002:a05:6808:3992:b0:47c:be93:9212 with SMTP id
 5614622812f47-482e5630e18mr13066519b6e.18.1779201377659; Tue, 19 May 2026
 07:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAN7C2SCYCwE=BRoeCedqQYjv-Gf6x6ETOdKeeDBE=CG=-rSk9w@mail.gmail.com>
 <c8cb1fbe-b15b-46b6-a39e-e6c2bd652ec6@cherry.de>
 <CAN7C2SCguh2M3JFC2UE3UFYf6_Z9a9038UEKpFLTTGFTH_r60w@mail.gmail.com>
 <3c49cee2-bd74-40c8-acb7-7a587ad895cb@cherry.de>
In-Reply-To: <3c49cee2-bd74-40c8-acb7-7a587ad895cb@cherry.de>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 19 May 2026 22:36:06 +0800
X-Gm-Features: AVHnY4LTRiXLsgDXB-Rvy8wEfhRGElpHZTwE3Ie8lJRCunGBIX7Qzq6M8h5NHeI
Message-ID: <CAN7C2SDtbdmqw0HYCgYp_RKkFgqhRhFFOmeYwmKwkkb4kSYuNg@mail.gmail.com>
Subject: Re: U-Boot patch submit standard and requirement
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Quentin,

Just one follow up!

> where you also have an example. However, I see the requests for
> "'Changes in vN:' rather than 'Changelog vN -> vN+1:'" as nitpicks. I'm
> almost certain neither Simon nor Tien Fong would have requested you to
> change that if it was the only thing to complain about. It's just that
> the changelog being part of the commit log is an issue, and since you'll
> likely need to send another version to fix that, "oh by the way, also
> try to do this while at it" happened. It's not unusual. If it was the
> only feedback, I would have understood the frustration.

https://patchwork.ozlabs.org/project/uboot/patch/20260423042824.3480-1-briansune@gmail.com/#3684415

"I have reviewed this patch.

While the functional change appears reasonable, the patch cannot be
applied in its current form because the commit message and version
history do not follow U-Boot patch submission conventions. Specifically:

- Per-version change history must be placed below the '---' separator.
- The required format is 'Changes in vN:'. Custom formats such as
   'Changelog vN -> vN+1:' are not acceptable.

Maintainers rely on these conventions so patches can be applied directly
using git am without manual rework. I will not correct the commit history
on behalf of the contributor.

Please resend the patch with the commit message formatted correctly.
Further review or application will only proceed once this requirement is
met.

Best regards,

Tien Fong"

Well I have no idea how you can intercept:
"you'll likely need to send another version to fix that"

BTW I think this is my final reply.

Agree or disagree doesn't matter, at least I know the true story here.

Thank you,
Brian

> Cheers,
> Quentin
