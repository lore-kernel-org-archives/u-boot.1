Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76230C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 16:30:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D09E180805;
	Tue, 25 Feb 2025 17:30:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MNTHuJzu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92DF9807B1; Tue, 25 Feb 2025 17:30:51 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C88B80805
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 17:30:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso38740985e9.2
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 08:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740501049; x=1741105849;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4X6RmVY8aBFWEgtI90nKyiJgsZUzek0k6Hb2WxJO/VY=;
 b=MNTHuJzuL4M3c0iFUDwCN/al7ujdGge+o90FAeT2iApDK3yyBXoCVD1xDqk9VEC5kc
 HXA/s4opmF7kSmMG4TGsaLtkGnowWjTB4rzCvh11Y/8R2EDH/wJH/CIfhcIzYRVp2Xsw
 Lq7aOXJU2/2MT1AYJQN/TW8QXw+Cm16/oUB51nG/HSKDqwH+UohHRmPv2KIcqfNS/R9+
 kn/n8RhRmaR01RYpomerQkgBupcb/oU0AER7f1cqRDvmaC5wT85//RIiHuyMQ3ff1RNi
 CLcgHGcdIZZEa99AU+qVvPyEkBrJ4rLIft7KvJd+TYwGtZX5gdckhU/gzezVnWQ1G8JL
 PQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740501049; x=1741105849;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4X6RmVY8aBFWEgtI90nKyiJgsZUzek0k6Hb2WxJO/VY=;
 b=ZiC7e/LhYF8RG7Sio4Ez13xJkMLoiw2BthHzFRWlZ4TD/icnruP0ZyHU9IJAaKvO37
 cBDfxGTsWROVp9UX7m9csH9e8VYzQiyNz9Vnx12dHuPAbhLSHnj+3sxvXHSqLPLLO7ho
 4yjiMD+w99HJR8s+ckf7ouMclkz2VTQnDbNMs9ggV5cs7UuWOHiYoWuzIHWXWcYcIjvR
 R2BraVfoJ7gl34psSeuuLd/edBCzVEhT4TBMNissBjjGJ5G1sU5gLHLQ1uDQROPmNA+S
 Lzl7Ej7PwKJsLyQvElGOekBg8EOHUq/E9ra3CzQsRGV9aOje5E4uERbv04DUNoWa7Y4L
 R+9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxAUTFDyLqxVQEAnyqsLQ3qG23Fqd115cYcGNnbI0scW+AiwarQACzj5TJa1AiXxPQk0osq+U=@lists.denx.de
X-Gm-Message-State: AOJu0YwiymhN++MMX1nmVwPWRu1WsAcDUopfEppcUpm530w1PUW85je0
 hEDow2Goqg188RGoRqQZ2fWbi9hJpKUgB5RwIPr/Ud756iuwiVZHJoxLSQMK2Qb94WeM6AK0qwa
 M
X-Gm-Gg: ASbGncvEOq+o5NW4DIdsvoWodeLpAUgJo1O2ILyrkFzIof1ZOnySxqO9Tu0SaZ5mawH
 FV6hnVKa/FHjPNCo8qYv+4STp+4+CoQFy5jf/LQVIA0ipzsZfX23lXnchz1tHeJNdSvkmbOXk5H
 wIaNaeeAgrqy+z2nuZTU2Dei0Fkn3+T3OEbpwvXbAfbX8UbT4U0SkNsD0wdW57T8XNspKH+i0p5
 8MJ58EyiOlBzFc0MCa+ubjKlw8Al5LbBKruAyLMWoynw+GC2YfQmV3mpgzh9OJxDr6yuGXlcir/
 Li2tsCOq5R9P1qVmnkgF6KdQ+nsqLwzqmYE=
X-Google-Smtp-Source: AGHT+IFuTzHAhScnuedqJEO9Id/SZbM69qQCLRxH7d8hxiZI3ZxhPA20RRj+N3PXa0qaYNnGXy/b6A==
X-Received: by 2002:a05:600c:474b:b0:439:9a40:aa19 with SMTP id
 5b1f17b1804b1-43ab1823448mr31259245e9.12.1740501048875; 
 Tue, 25 Feb 2025 08:30:48 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02d854csm145521425e9.15.2025.02.25.08.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 08:30:48 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Dragan Simic <dsimic@manjaro.org>, Joe
 Hershberger <joe.hershberger@ni.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 1/2] env: mmc: Make redundant env in both eMMC boot
 partitions consider DT properties
In-Reply-To: <20250221184732.202336-1-marex@denx.de>
References: <20250221184732.202336-1-marex@denx.de>
Date: Tue, 25 Feb 2025 17:30:47 +0100
Message-ID: <87eczmf0lk.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Marek,

Thank you for the patch.

On ven., f=C3=A9vr. 21, 2025 at 19:47, Marek Vasut <marex@denx.de> wrote:

> Introduce a new function mmc_env_is_redundant_in_both_boot_hwparts()
> which replaces IS_ENABLED(ENV_MMC_HWPART_REDUND) and internally does
> almost the same check as the macro which assigned ENV_MMC_HWPART_REDUND
> did, and call it in place of IS_ENABLED(ENV_MMC_HWPART_REDUND).
>
> The difference compared to IS_ENABLED(ENV_MMC_HWPART_REDUND) is
> in the last conditional, which does not do plain macro compare
> (CONFIG_ENV_OFFSET =3D=3D CONFIG_ENV_OFFSET_REDUND), but instead does
> mmc_offset(mmc, 0) =3D=3D mmc_offset(mmc, 1). If OF_CONTROL is not
> in use, this gets optimized back to original macro compare, but
> if OF_CONTROL is in use, this also takes into account the DT
> properties u-boot,mmc-env-offset and u-boot,mmc-env-offset-redundant.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
