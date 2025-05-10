Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509C2C3ABCB
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 11:27:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E49158295C;
	Sat, 10 May 2025 13:27:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TPYhQ9+c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 778E1829CD; Sat, 10 May 2025 13:27:38 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9569F826AA
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 13:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5fcab0243b5so2185979a12.1
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 04:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746876455; x=1747481255; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=puRS2ACHJeo00/YCJ/d5/8UJX2X+8lV+xOwEGwHg4+Q=;
 b=TPYhQ9+cK74QnL7IAcnehI3prWUpZHOQGMvjemEBaVnXc4+aF3i+c0Lin7YqloeMHo
 DDEdMD1zwddfFgS4iR9H7JE/vFiNRoIKw5ukDya5U7Y+arx++4fr/LLitxWtdRJUOpu0
 1uDvvaq+Vn4PxyMfqmlbB1bojLkiUFc4Rhceo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746876455; x=1747481255;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=puRS2ACHJeo00/YCJ/d5/8UJX2X+8lV+xOwEGwHg4+Q=;
 b=hhoxhXqib7lhKOMyZLtKuDGFk1ETXCtyAK3sl8DesDeK+eYAAxH9dhMpg+pThrPr73
 uUIqBDYc3sahVQDifiEmqWD9Bh2TcMGUuDoJwKeFvJe9OCbz20hNE47Yqm2WtcW1AvzM
 C60R5rc16NBObksDFcikEMaCJv69WHS/i6TPKiuSBfB3ADN8n6rSqHTi3ZsSeQnihF+p
 g9SKu4BF/igoAX1tXBfbEYAb/YKsOY6hvNHx448mfYilseP07ShCY6EMYz2I7sJJuzot
 hMCujHwHot9pIEYc3FvKo01AZeeQNqHdQzi2lIRnKqCQuWdaq2qxlkIcIWetrk0Y1zhj
 He/A==
X-Gm-Message-State: AOJu0Yz3y2iA3BpeoU+hY+3f3aZQvf+r0fJYuGuo/32OsVeoGZJL/Jsl
 MC79AoRkpfOGKuKojxj0OVGDH6QljAmpGfjV7JzhEBdCej+xtJ7iyBZd6YgwFI4NVOdO1jLDkGY
 DHGGhpjTI7VDd4UneP64gqlphX64X7wFwU1uk
X-Gm-Gg: ASbGnct5+L9RdLIHmJD5X7m8So9OmAB20yY2uxxqU1CZvG/letIXyWqbcFPb0tyz6If
 +lWI2BeB6wnPzBDFKt87F2IzH9JvHtwKOIq/N8ypHzzYN2FzPqXiG1ZmxaFhaqU6zAz27UThktD
 aLnuc4IkUgvJleBqZN2NG9/QlB08xapLZHPEAuo/tRaTv6
X-Google-Smtp-Source: AGHT+IHB13M1EnrKfO3b9Pj0LWCt7MCtFHYeg1OS0p/RG7r1bCcjUoMlwIQo530xXNfRFPMD/Vw+Af1asIlz6JeWRyw=
X-Received: by 2002:a05:6402:42c9:b0:5fc:994c:b6ee with SMTP id
 4fb4d7f45d1cf-5fca075e532mr4942456a12.8.1746876454911; Sat, 10 May 2025
 04:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250507232500.527782-1-trini@konsulko.com>
 <20250508214222.643020-1-trini@konsulko.com>
In-Reply-To: <20250508214222.643020-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 10 May 2025 13:27:23 +0200
X-Gm-Features: AX0GCFumBOAo1ENi6YHKeOd-3AvtW1PTlA_zuegWxk0Mk4pCpD0B10rQZxwEqbU
Message-ID: <CAFLszTjwfGV6P7GzFDYFVp8G5oTvoXUKvOXZy6KLNW_=BMO+xQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] doc: Document remaining test_b* tests
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
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

Hi Tom,

On Thu, 8 May 2025 at 23:42, Tom Rini <trini@konsulko.com> wrote:
>
> Hey all,
>
> This short series is a follow-up to my last series. It could have been
> longer, but I think this is a good point to get some feedback on a few
> points.
>
> As background, something I wondered about and the answer seems to be No
> is, can we automatically take things like:
> @pytest.mark.buildconfigspec('cmd_button')
> and get some nice output? Since we can't that limits the value,
> possibly, of generating some documentation.
>
> First, as this series shows, is there value in documenting tests which
> do not require additional configuration? We have some tests with no
> comments and some that are fully commented, but at the end of the day
> when trying to run these tests, pytest will already say helpful things
> like not being supported on a given platform, or not run because
> something isn't enabled in the build. Spelling that out in generated
> documentation would require duplication of work.

Yes, I agree. I think the code is the best place for most of the docs.

>
> Second, is there value in documenting arguments? Especially ones like
> "ubman" that are just required and always present?

I like documenting arguments, since when people see the docs they
continue the trend. Python suffers terribly from a 'def
my_function(*args, **kwargs)' disease where you have to spend hours
spelunking around to figure out what is actually valid as an argument.
Highly Pythonic, but dreadful.

>
> Third, should we document internal functions too, or just the tests? I
> would be inclined to say no unless they're expected to be re-used. The
> test_net functions to bring up the networking are an example that of
> reuse that should be documented for example.

Sounds right. But I am likely to continue to document all Python
functions, since I never know when I'm going to want to export
something for use elsewhere.

Regards,
Simon
