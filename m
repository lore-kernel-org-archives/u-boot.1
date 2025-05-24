Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3BAC54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 04:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3824983440;
	Sat, 24 May 2025 06:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CAOs6SKt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 221DC83443; Sat, 24 May 2025 06:25:28 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31C2683466
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-acae7e7587dso51061766b.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748060726; x=1748665526; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pxjLo8oIu1qhkow972GhQMfPg5i6q5JDXs1nrP3LVOk=;
 b=CAOs6SKt2Qu1FIztbOnKjsL/+SIqKw1KOtFzVfy21/pCHahEF/oGi8ig/i0Cwy5Ctt
 1MgdGwTwmDmx8IkHERgdB1OIYPmzCmlWvqevgNg8I5nL8+4L3pHT807csoKZnjCehzLY
 ELR63zXkYAzvF4KqAIqqBNqcRlYHAh5iRw2Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748060726; x=1748665526;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pxjLo8oIu1qhkow972GhQMfPg5i6q5JDXs1nrP3LVOk=;
 b=GBWTmRvSOzXKaswrbWgzBtPxKOI6io6vTEE2Gsex7l7/1EsZ7SxqTcYfmp7GlViK0K
 1ZLlGqpaDJ2KuoXAUP+tz7zl7zId/pCbo/vfIIFxZ641wO644Vd0LzwTToZlyyjL3/yM
 wLhwZ/Yhp3jE0i2hRNERZLZdVfcYOaVRPZIMloKyRwBcBo/CNbGzqobHkrzAWxcDPF8d
 nFqaH+ImzQpfA40osnDJ+odr40IlvWGpy3fblX5jhTLvUHteZ1n1m3+5UIqzZx2KQLTB
 ZgLHFRAF2NAcMWGO2XC8njXpwRTahNE+sgHF/QAfbXkaPV5MFJd2jQvF0wtqkii10XEF
 PZLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy5cxRb9MhbkG9bPQWgJT4KfcR+weXV2IvLy2hnZtHblznXdUZEvtBKNIFgGNWBDy9V3fF1Zg=@lists.denx.de
X-Gm-Message-State: AOJu0YyKYUWXeK/TAe2rGQIIseEYGyU2QepUMe6N2+4rMyDoZG55f5//
 BTucQJbT9iTDLZ66PGhWEjrht2AYVmOD3aU1RnyKXSAj7yGL0rGDiV7poU/54leFdJmO1rq2JeE
 JmVEA1zGlLJNxX4sJohvRL7+6Zm8CWad+qNNksq22Ptluw0KNBexpCZK8
X-Gm-Gg: ASbGnct7Z3sCcc4ZFU5KUlkSpSRf+1/GlfU7M62PUOH+GAo3O8FmjxFvy77ARIIqoxg
 qOUDWXZraS6N13X7bchbNc+qh6h+tdj1KubMFPF/relHxrhw5vIDQjXRFIqCi41E1oUHlE8ZwtG
 PbjPuH3uSFsO8+G9Oi82b8sFj8MJqed/I=
X-Google-Smtp-Source: AGHT+IGZzJPd+neL2qCLvdorIyzyD0V0kXKkJ+o/uXjx7ZHpf5POdOVxV4OwuuGF4fUM4k+L4RWVsWmWrKEr2Liktqo=
X-Received: by 2002:a17:907:6d0c:b0:ad2:1b64:2dee with SMTP id
 a640c23a62f3a-ad85b112684mr130688866b.33.1748060725703; Fri, 23 May 2025
 21:25:25 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:23 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:23 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250508072907.207175-13-sjg@chromium.org>
References: <20250508072907.207175-13-sjg@chromium.org>
 <20250508072907.207175-1-sjg@chromium.org>
Date: Fri, 23 May 2025 23:25:23 -0500
X-Google-Sender-Auth: Jl-W_bMYvq2QFPAsO7Fhv7JCxko
X-Gm-Features: AX0GCFuqTZ9Ert6PV3NOOaEhc4p9LT5n2eJyOWUzOVvmmTVjBmBF_OEefuZswgk
Message-ID: <CAFLszThqNX6Xx25b19HWEYGYnL_kyWT+5tTrB2kspYg6AYCuGA@mail.gmail.com>
Subject: Re: [PATCH 12/20] patman: Use git to set up the test config
To: Simon Glass <sjg@chromium.org>
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

At present the branch information is dropped when writing the
configuration. It is easier to get git to set up the config anyway, so
update the test to do this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/func_test.py | 5 +++++
 1 file changed, 5 insertions(+)

Applied to sjg/master, thanks!
