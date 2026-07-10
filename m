Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D57C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 10:52:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C5C884A0A;
	Fri, 10 Jul 2026 12:52:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="SAupUjtk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 330DD84A0F; Fri, 10 Jul 2026 12:52:02 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFDD98484A
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 12:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7e9ecb1e13bso374916a34.2
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 03:51:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783680718; cv=none;
 d=google.com; s=arc-20260327;
 b=XUelzvMxMFN+IfF3X6kSnQcpi646AunA8+VEb4viH8Zbvx7rPIjRe/bgIaOYFWSbAU
 N/AIre5nBRqfc2VSN5rEhdWW7MyjuVkX+eBgx3CGH/hyx6JDG2+dC10lv+YwbGIqVkQA
 ccjiLTGVVZdDyrwl+ZRtR0Wo0DGeBJm/flLC1mLOxKxgJulNGKcMhnegbV2XJ2e46W+w
 kcduUjV5WxUyYb+ZUN9aZzO6V41iroIs3kmPzDvcv1Ux81RsfBF8cWPMMEACkY7UCv7E
 oNXhkwbyw3z1cqrDu5wX1brx3G4RWE0xK/qMXTH2WPwnmHblRzUs0EpyFgwBZX8nii6y
 lLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=H3ebwUdDMxie4cB4oKfxN9IOpHBdGOmsSadh9MI/f64=;
 fh=C6xnfQ1THzxBkbO1mwuSmr6MsDo3j05m6QG7Am6Dchw=;
 b=QwtHjm9kMEWsxIoDNGhWX26jWMwYsySvVe5pLOdIXl/l0jqa4R7dxe4NeX1s1qf5Lo
 ii2RCMiMbi8Qj/835zDVIWqjfcgKgOlO/b+bZhhi7kQv7QPBd8lH9/V2uK+3uycBMGG1
 38GyN4aV/1ABxLjuYxw6Gv1Ub4oWEIYON54S3gb8OYnLa6LEEwd1jBQ7CYHdetZ5vXNl
 45yHXFryTEwTpQ9LGZt031HIlWaLeZMv7KGOIZPEk4QwJF4hyUB7NM7FruK1BROC/dlP
 Dt5v1WSzIC86wXoZm+vygqwPpGfs6kpy0bXtrGDMoEQgQ30QBFSnfxgK6irjUpj0d9AE
 cnWA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783680718; x=1784285518; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H3ebwUdDMxie4cB4oKfxN9IOpHBdGOmsSadh9MI/f64=;
 b=SAupUjtkkpqGoXZ4RZnc31ySNQP5Spz4OcIz0chIvSLSmbZadlieYKmsiAvBEZDyYc
 4zBmbya0rmqXoQcIKgC0QqjytXByWURPHsaJY1KOakgft0CuVUdfa3O/24iEo0naCf+J
 4y0ntD2BivAUnRUV2p5oZ+7vyDw/soMa1MRUBdb1TcueajSlwfrri/NVUWdUBGz15+Nl
 DR8E/quK2srl1GESbCZcACYKEtKHx062nP+GFiK5aEuu2LMpVKM4H5d+Q+jEtV28+Lnl
 GMpm2M+Ot+slbk5O6sWO380mpS1CzuII7OUlYGcJqos2rgrPeYDgOY2+WP1qd6jZJWWO
 n5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783680718; x=1784285518;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H3ebwUdDMxie4cB4oKfxN9IOpHBdGOmsSadh9MI/f64=;
 b=s1BO+BLkde3TuouNLw7o8njaj/+jjV+ypRdqTPEgbTlKj7gj1ypoJJsWQEZYL1jrXd
 sYly8oB2rD3W9pW1VycMbjqbeHqn8AnSd8mY7uCheC1vXZeOCD05QE6FVcMWaka3VZ6D
 UkC7OXAXhsbrJi9UIGT54yTR6NMOzboLPfi13wS9dzLA2zOHJnmctiI87/+oMgVnrnox
 34Aou9BRw6KMt5q41p2SKTyOEN6vtymre4haCtM6vyI2GwCj+84rYiNY78I7XdiqcZNj
 UsgV6Obla2X3VUF8V+bmsB3i6lqJKktY63VEhKmPj5UrdToAk0TizuA7rjo0atNbJcUW
 SBZQ==
X-Gm-Message-State: AOJu0YykdwZEuyG5CX48h6gspXvmln2GopPhkylCd0Pc+CyQnetb+e7h
 UKF/Vam8t1py1N8nwTwNda2yfEqW7Ua1dwzJBKC3CEFRmXCi39wSZ8uCOn5Y1OqeSR/nyHzvKRb
 YeKQHb0eTe5dKF+uBuDJa2Ai8VZLQokZd8kW4Xf++Jw==
X-Gm-Gg: AfdE7ckcqO4fhDpeXO9z3hfGsm8kbGrNU2hx2V/nPn8rbua0iGGGFsI09HmuqFlLWCV
 /JtPdPMPATBuGaKgKEbdhK0N5rCNxxL0AJBXocJDGpopwGlmRBh+LtqMnDXcxhGp4sHtvyHJ1B5
 wrc7ts5oRg0CQ2gvYHNXr7D2vG9500i8FeLyfMop2tABog6WFv7vI1bQudVUu3/FWoLZ7fBzCSW
 aZtlMAtFCjYkMcAdCKkM+d6EJ/57zDTt5yYEHEash99jxhKNAMPr+eXyCn7C44cMkDHUnsT
X-Received: by 2002:a05:6830:6119:b0:7d7:ea9f:c0f9 with SMTP id
 46e09a7af769-7ebcfb996aamr8017835a34.0.1783680718595; Fri, 10 Jul 2026
 03:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <205BD474-178D-4E91-8C41-33C46E1CCFBB@baylibre.com>
 <CAFLszTgP05iS-4dyaLbzmPGppdMmFxUQvh=JJJGnSjKJ0MnL7Q@mail.gmail.com>
 <CADh8LscDis-pfMK26usYEfS-cfRRSwvcm5hg_akXr287oDXQ=A@mail.gmail.com>
 <CAFLszTgqQtt-FMx7Rh3vVE_NLL8cKp5vveqmi4iNOKE2GwJt=Q@mail.gmail.com>
In-Reply-To: <CAFLszTgqQtt-FMx7Rh3vVE_NLL8cKp5vveqmi4iNOKE2GwJt=Q@mail.gmail.com>
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 10 Jul 2026 12:51:46 +0200
X-Gm-Features: AUfX_mwEagCN-1JiYWl1ckWxq7kd-ItYHWRrxDTgsZbBCy85v5xO-iE0A8Tw7Dg
Message-ID: <CADh8LscEUi5kvGQ28GErjEM=WvQ=6t0p5Kh30jQ-S8ZapG8yrw@mail.gmail.com>
Subject: Re: [RFC] bootstd: firmware-owned OS devicetree for EBBR /
 SystemReady IR
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, dlechner@baylibre.com, jstephan@baylibre.com, 
 baylibre-upstreaming@groups.io
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Jul 9, 2026 at 9:16=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:

> Just on this point, the question is really whether GRUB does not touch
> it. My understand is that it actually loads the FDT from a file (Ilias
> is the expert here) and that is why we have an EFI fix-up protocol to
> send that loaded FDT back to U-Boot to be fixed up before booting.

Oh, ok, good point. Now, there are two cases:

1. If grub.cfg does not execute the `devicetree` command, GRUB uses
the firmware-provided FDT from the EFI configuration table. This is
the path I tested (most common in stock distro images?)
2. If grub.cfg executes `devicetree <file>`, GRUB loads that FDT and
can replace the configuration-table entry before starting Linux.
Debian/Ubuntu GRUB also carries the EFI_DT_FIXUP_PROTOCOL support, so
the loaded FDT is passed back to U-Boot before GRUB installs it.

The mechanism proposed in this RFC (V2) guarantees that the selected
and verified firmware FDT is the one presented to the initial EFI
application. It does not make that configuration-table entry immutable
after the EFI application starts. After all an EFI application can use
InstallConfigurationTable() directly, so trying to enforce
immutability in the firmware-FDT loader would not be sufficient in any
case.

BTW this also means that authentication of the firmware FIT covers the
DT provided by firmware, but not a later DT deliberately loaded by the
EFI boot manager (we cannot do much about that). The good news on this
front is that (AFAICT) in a Secure Boot configuration GRUB's
`devicetree` command is normally lockdown-restricted (but again that
is a policy enforced by GRUB rather than by this mechanism).

In general I think that is correct rather than a hole: same precedence
as passing a DT to bootefi, an explicit devicetree beats the firmware
default, and firmware cannot stop a loaded image from installing a
configuration table anyway.

Hope this works, cheers.

--
Carlo Caione
