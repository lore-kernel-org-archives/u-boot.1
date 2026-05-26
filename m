Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9343DCD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 11:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCDD483EF9;
	Tue, 26 May 2026 13:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EQpKbBZu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 830D583FF5; Tue, 26 May 2026 13:11:22 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF56D80433
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 13:11:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-65c1ba7eeb6so10250383d50.1
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 04:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779793877; cv=none;
 d=google.com; s=arc-20240605;
 b=aHwjOl31+vkgF7D/5vf41/rOJcIMTtklY7esKCAbZ8fJDVXbIyjKJy++rywFgFGlYE
 Qina2uGJ8UAoatAAQxt++voBa9k/P88Ueznlu1nYXDM8pwD2kDVvpnCcy5m7JMnbBgzO
 j8xirticl1O7AmPgpdWFRtURcDysoqYs3H7+e7rBlWI4RPwvaqSPnZ8dgLATHr7Iz6V+
 j9UmfTU/4BETY9y4IbuNaHx4mazgVTsjrH3bzWy3ThVrW0Jy+J77XT21HYFS8+hOd9hu
 pkQFm2QrHA135Z1smsNYhzoWp+QVZFC+e0uOuf+paAVd/CUZ9IHthYIxbj1S8O1HtMzu
 +/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=KTwWXB2/2IzJoI1EobU//7Bz0JWpctSgiwyK0VHtHaI=;
 fh=iCFVvx0BeDO7gGPCwI2KY7ug6QiUx1Gi1sXRnflipl8=;
 b=igpy+nOoCo7VT5rr7Go1C3c0ThMZOaoslMEqBq5ell68StjtFBeCAJgv7XtKJP9yQz
 BrR2FE9LmNoDtMXcutvLutQkbWzwWUAVMD/Fy4V4gzbN93sjLtxJO2R4QtiulaZN9U5D
 EbJsNEthvHWSvn8RKg+ldbdQnsnFITytOGahjFsDfmGl2pmca0pfzN6aiVOQNjWoQQj+
 4emuevSRRzVTJGjzRyS5xGTCVlc2ezO5T/6VUtua5sooQJ7rPBP4ZuUXODOb5eJS71KE
 cbxtapubE83aYl4NVvy3QyzZACO0ovmyzggth/+Pm8QFqhKHy+xa3Q5C47JfO6+rFfy7
 zPaQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779793877; x=1780398677; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KTwWXB2/2IzJoI1EobU//7Bz0JWpctSgiwyK0VHtHaI=;
 b=EQpKbBZugwMPCFwXj9E8hjTeqYp1C5VU5bT9auogRpVOl/NDkGLAE6tUVP85aEodnQ
 f/KFsqXDQjpNK0Lgj1nrlY5uA6x+gMHQkGZp8YxYCPtfNUxQ8+sS5b5qdoJpgQnTezg2
 g/c17jw59vlowtQ5J5S3J7EmTaclj/jDdRoTTH9HcVzN37hhTIbKwIBKqrAkP7DHNTqM
 fuVEj3h9LKp3VuNVPYKdOsCDWFeP9X37a/DcKfQ7JJH623nLSz6MKq5Fig89FwBcN3Ir
 kC30nEY9zjHr3y1pDhP0nnGDCI5dE1FY1/2da/P03TptCd2nyzCdChTEaSDdBQQ/66SB
 p3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793877; x=1780398677;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KTwWXB2/2IzJoI1EobU//7Bz0JWpctSgiwyK0VHtHaI=;
 b=Kl7/pVWpB+mBgPS6YwvLKpzeaSl6DI5tNlA0hQnKug5n1eUHUrGVhqe8uZqji0rXMf
 Ykz18D8r8y6nuDK0GhwG8kvY9+LFlOzZj+uNZ8DR1OpYOC20yae8vh/2OyaBJ4Tfc9b4
 Ulrc+7/Ax6EWtB8Ahhnw+3jDhR19woYV7/ofwqBe/lybJyFTheZQ8wbHt6v34vKS7QOy
 s7ZtDTtsMMiiiw8DulHAQIRr5aQns0ibQpurobuRolyfGsx2X7S6+qaDbhjEc+eGnj2o
 XFXFo9o7i0fsrHQ2rfPBVhbAGVsOb8myUkdH4/mevkVTY559ym7287khDnv9cYH9MoLD
 ZIwA==
X-Gm-Message-State: AOJu0YxhSTcYtq/eXr15OT4MApmQ7MwHI9d+IR1Fyurie/noOQ3gGJSR
 bAUlkXM2RO6vesnNtjXaVmiO6pgQdDuZa/fpXbBqqo6Rrdpme8rgblW1uNZzsJgGXKaugTdwyqj
 Sv2CNnFXIi0O+M6+hWpYKnj7Lv3dDy6eyW3CCD6Jeng==
X-Gm-Gg: Acq92OHZjWyxk35gXcvA9H9knMkUzvlT24sd351LiY5zBeVfu/VacgoeklZvByY9E7l
 dnLhoba+MAiUp8u++eQWY/6YA6Umx1dkz9ANJnQ3DHAaVo8aOpqp8lwNGj2s9d1a32lGkM+1JoI
 l+/cKrpgPSa3TNgEa+JALxeXUEtIOA55/NldIYV1UAKoLJ8nLEO2IqSDgRzwJHhKm9kGCWE14e1
 /Tl6cfgdd6uIF1jOpGEe3V1oTCjt5IdA8KjxelQaNPOm1d/JIVwvpWNx2WPOnnZR5rodPHQjp9/
 pXUxLGq6Es9vvbLX8h4rO1URp5P9bfjKJk9Wu+bDyCVsbVvxsM3isMAIOwSYBjta9VJXz8JLcUM
 lhTMy4X4kEAVC0WtnaiqWdI3ZZAMOmTq0sotP75EIB+s/pvhTvWtVwbsj7UCy1WxFRMnjqrnuLg
 DhdTAYAY+HmMlMB6KEXrMavN9BnKwRD69h+q6reNDslnv4MEQ1t+Gd5XSu7PCsizwcmUXbmleX7
 mz8iOff61HwlGPQEV+zSL2yblo8nMDxk+jU5WFIs9F24yrTl32zV/NJyvORJad0NPWJc6ulLvxU
 +dbRr58ZNCSPApDiG4GMeQuZAD/WOw1wKDnkpZCCZ6OeTIdlUP0oY5usSW9Eze8xf+XjlChVPod
 7T9se
X-Received: by 2002:a05:690e:4298:10b0:65e:5aa3:9645 with SMTP id
 956f58d0204a3-65ec98aa450mr13752879d50.40.1779793877553; Tue, 26 May 2026
 04:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260524123822.7244-1-josh2@disroot.org>
 <c67720e2-bb73-43ab-9d75-851ef1f4afaf@kernel.org>
In-Reply-To: <c67720e2-bb73-43ab-9d75-851ef1f4afaf@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 26 May 2026 13:11:06 +0200
X-Gm-Features: AVHnY4JIOiI2-F4UD6DP0W3ZeZ9uYTd6ERJNj9JDz_d0e34w2ur1lcsFVE9IwHg
Message-ID: <CAC_iWjJh-6TNd+nYRAbp5Dx4SPs7zivoUJsYtCvugUuz8V+mLw@mail.gmail.com>
Subject: Re: [PATCH 0/1] armv8: reduce core errata dispatch work
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Thanks for the heads up Krzysztof

On Tue, May 26, 2026, 08:01 Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 24/05/2026 14:38, Josh Law wrote:
> > Hey folks,
> >
> > apply_core_errata() runs during early ARMv8 CPU entry, before
> > lowlevel_init(). Today it still checks the Cortex-A53 and Cortex-A57
> > paths even when the build has no matching core erratum enabled.
> >
> > This patch leaves that dispatch code out unless one of the supported
> > errata is enabled. For the A57 errata case, it reads MIDR_EL1 once and
> > reuses the extracted CPU part number.
> >
> > The erratum register writes stay behind the same CPU checks as before.
> > For qemu_arm64_defconfig, where none of these errata are enabled,
> > apply_core_errata() goes from 15 dispatch instructions to a single ret.
> > For ls2080aqds_qspi_defconfig, which keeps the A57 path, the dispatch
> > side goes from 33 instructions to 26. A KVM microbench of the same
> > dispatch sequences showed 1.30x for the no errata case and 1.09x for
> > the A57 miss case.
> >
> > Josh Law (1):
> >   armv8: reduce core errata dispatch work
>
> That's another identity from Josh Law, since all previous got NAKed, and
> 100% AI generated code without review and without tests (I don't believe
> what was claimed above).
>
> I recommend ignoring and here is some background:
>
>
> https://lore.kernel.org/all/cbd0aafa-bd45-4f4d-a2dd-440473657dba@lucifer.local/
>
> Best regards,
> Krzysztof
>
