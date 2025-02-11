Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3DEC0219E
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 15:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 184AD809D0;
	Tue, 11 Feb 2025 16:03:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kbtb/NyD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DC3F80BA9; Tue, 11 Feb 2025 16:03:37 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D835F80842
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 16:03:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so892565166b.2
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 07:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739286213; x=1739891013; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yl5kZ6DCk4vYk2Uyj8WCIVW0sIqameJUICx0Kr1QJl8=;
 b=kbtb/NyDnMCeYFCe43aYG9dpgNUNkSCnDHkx9Ouck9gkO6bx6bLPczwr1Itq/D3jdO
 e5USutMc9wt5QDg/IYOuSI8N9W4m1emQPMU0nFkYcmBaX4ztfXYuvtxkM737jlfrzQYH
 Y9H+OSuzSSiD5Cu9cU8ePvoAVjj/klBz54LC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739286213; x=1739891013;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yl5kZ6DCk4vYk2Uyj8WCIVW0sIqameJUICx0Kr1QJl8=;
 b=VXgj/YstnnTdPiEM7oxFQjbOdacPJw+7rL5JVFbobRZtfUr5yzCdRe3/ewNCq3Nevw
 AxI8l2wbzHnIozSEhjyYtCLiYEgl3M1auNtRQO2YizOg2mqw0+pKJiPczkNNYzdQXwq0
 p6jBfiU0XaW0yIoS4Ai2u37cfuQVucE+J/LuMw2okYBIJQu9+eFYqSnD5sD4ybTqhZbT
 htHhF9tIJaA4B/BoAsITguDZ+giNp+K6SRFWeru4+cRT1oER5Aier2nKa6/h7TMWDAa6
 zKsUIFUx96sHBlgJDvf+0u4o43vAQIRE3ANw8Q+5JQkWEvhgJFZ2JqJH2BrPdxlOyDc9
 3uxA==
X-Gm-Message-State: AOJu0YwErLijxQteCTAWI4fNlLYr4D7jcYyauOiFA4n2J/mE2NzBMVRS
 hbGfcuw8rLKxZHUazy/vdtVtiKKEO13nQ3B5+k0+bXUh5GRiTalOxMVTCiyMGM8ybfQrGU+02mY
 UpGvc+7z3H/wJ70K2wnHzdW5TPC1pd+qbbXfezSevK/ilcSnDvw==
X-Gm-Gg: ASbGncvPxxMwggXh9nu/N2um78HhCIp5KNqAu/FxzVSc/uHvVWmEwWFu9dPAKip44gZ
 4Pry8poCzYqXe8WUKWJtV9ZjrfyO5rvMAqDJ4wYAJUnoHF46aNIoD8eiMQ8BpSbSPWEgAlXYf8P
 S048jcJpuCRa7EQV+rzOXWFWhvVlDZ
X-Google-Smtp-Source: AGHT+IFIlMxCpReZDgTMLI/aSy0iHACYMrUKAS/vtkmSgDLqdWR8rWTqBMtzXIaCZPP9yi+zNN67msceEty6CEGA5UQ=
X-Received: by 2002:a17:906:f590:b0:ab2:b5f1:567d with SMTP id
 a640c23a62f3a-ab789aed55amr1649422566b.32.1739286213157; Tue, 11 Feb 2025
 07:03:33 -0800 (PST)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Tue, 11 Feb 2025 08:03:20 -0700
X-Gm-Features: AWEUYZns3MOwGOIJkBtNliQcbkKdSbQuFrZRPOF9E_hDsEI55kNZp6OV9OBpUfw
Message-ID: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
Subject: xPL Proposal
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
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

Hi,

I just wanted to send a note to (re-)introduce my ideas[1] for the
next iteration of xPL.

A recent series introduced 'xPL' as the name for the various
pre-U-Boot phases, so now CONFIG_XPL_BUILD means that this is any xPL
phase and CONFIG_SPL means this really is the SPL phase, not TPL. We
still use filenames and function naming which uses 'spl', but could
potentially adjust that.

The major remaining problem IMO is that it is quite tricky and
expensive (in terms of time) to add a new phase. We also have some
medium-sized problems:

a. The $(PHASE_), $(SPL_) rules in the Makefile are visually ugly and
can be confusing, particularly when combined with ifdef and ifneq

b. We have both CONFIG_IS_ENABLED() and IS_ENABLED() and they mean
different things. For any given option, some code uses one and some
the other, depending on what problems people have met along the way.

c. An option like CONFIG_FOO is ambiguous, in that it could mean that
the option is enabled in one or more xPL phases, or just in U-Boot
proper. The only way to know is to look for $(PHASE_) etc. in the
Makefiles and CONFIG_IS_ENABLED() in the code. This is very confusing
and has not scaled well.

d. We need to retain an important feature: options from different
phases can depend on each other. As an example, we might want to
enable MMC in SPL by default, if MMC is enabled in U-Boot proper. We
may also want to share values between phases, such as TEXT_BASE. We
can do this easily today, just by adding Kconfig rules.

Proposal

1. Adjust kconf to generate separate autoconf.h files for each phase.
These contain the values for each Kconfig option for that phase. For
example CONFIG_TEXT_BASE in autoconf_spl.h is SPL's text base.

2. Add a file to resolve the ambiguity in (c) above, listing the
Kconfig options which should not be enabled/valid in any xPL build.
There are around 200 of these.

3. Introduce CONFIG_PPL as a new prefix, meaning U-Boot proper (only),
useful in rare cases. This indicates that the option applies only to
U-Boot proper and is not defined in any xPL build. It is analogous to
CONFIG_TPL_xxx meaning 'enabled in TPL'. Only a dozen of these are
needed at present, basically to allow access to the value for another
phase, e.g. SPL wanting to find CONFIG_PPL_TEXT_BASE so that it knows
the address to which U-Boot should be loaded.

4. There is no change to the existing defconfig files, or 'make
menuconfig', which works just as today, including dependencies between
options across all phases.

5. (next) Expand the Kconfig language[2] to support declaring phases
(SPL, TPL, etc.) and remove the need for duplicating options (DM_MMC,
SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allowing an option to be
declared once for any/all phases. We can then drop the file in 2
above.

With this, maintaining Kconfig options, Makefiles and adding a new
phase should be considerably easier.

Regards,
Simon

[1] https://lore.kernel.org/u-boot/20230131152702.249197-1-sjg@chromium.org/
[2] https://lore.kernel.org/u-boot/CAK7LNARQ-PgxiCh+gm2efpfXmNBkdTp18OTk3sHtqNsk6by5-Q@mail.gmail.com/
