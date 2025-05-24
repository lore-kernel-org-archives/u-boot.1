Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C1AC54E71
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 04:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7335183327;
	Sat, 24 May 2025 06:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iywQMtBh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5685983444; Sat, 24 May 2025 06:25:12 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D70683303
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 06:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ad5297704aaso85694466b.2
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 21:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748060708; x=1748665508; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yuOvIV1J159FW3ipOhf37wu4MR3JaIcfhFSh/UVkhfA=;
 b=iywQMtBhO6gGTK5WTmBSjW/T77my+57i/Ph9w4J9A/tA0kULjs2qpWRUox25boNEkR
 FXGX4HHyPWuU7xfgDRG5/HUTQ1K9lujmsSoE/3uhycsh5tGqXrKQv7BbWTfIdQcPFk/z
 raIQGiKJLFFEApV+Qt8VANO1x7VMxMuSt5APo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748060708; x=1748665508;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yuOvIV1J159FW3ipOhf37wu4MR3JaIcfhFSh/UVkhfA=;
 b=WbOY9IUf5XD8Np1hylY1irhzZBIdy7x6O+C+L5iQPSS9tST/rZsYbCKUqqaCzlo9sx
 SH7DJlDidMRmlPj4xoR+oQYdOzxi5+yExtrtpyffvJdtSRluldxSHDIcKjrPYlSvct8g
 +6yrzMXKEasQIyu3KENLUisCC/+L5SNSoWorslJQz93eIKZrxdiVEAYk3qeVrd+b9A5v
 9XrI4pT+Z3TyBYqHYHjIgJHidpwo02q168OCOrTTpTCOqpMsPlOoyBxr3rJsxCvnWmiR
 8eu5pC2kvNQfXlnBuJ22OMRF+JcpRXXiHPnQzyn8/CJ9SaCt67+CFdmhAaiP2CEPhkQL
 x82w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLFINl5DsRUzi3w7Nw3HdtTUgRLRQoeR6ryBcOB8PLWNrXxSdNTLopQVx780/aeWsEsFrHJyc=@lists.denx.de
X-Gm-Message-State: AOJu0YxNtcP8fNetAzlGYCPbANRmCL/oBMI19Vg2W5Lt1FV64YcK3BQ5
 6NkaHYyC2rXghGKMh0NZzZoC8y56QWq262pFnybVfU6SabqsT0jOh+7RyrGn5G+Nht6NBAco89L
 XP2lUIRyZ9TWCV71TPXaW32UflfuG1PXwIdIedH3M
X-Gm-Gg: ASbGnctjh5SO5w4zFJTzL8sYOgJbSOhFWCPRXz8jzK/UFEnkk5xg6C7/s0nkUEkt7WD
 3ube7pDeEOu4JzBR0JbkPWqVqXYqYrBemuQ0MiYfzOy80ZE/0EqudWw+zl3j8+6j/gw/vjcOKMj
 8L+Jvn/sK/f9eapb11c4vwXogcnkNLNWI=
X-Google-Smtp-Source: AGHT+IEPV1VGJlVbftmFd0RAjr6gpWi1LkWr3Luf57S6VnJ1ba9L3BwmpAUGYkQQXhIvaWJ5m0Yi/s1Fc4zUThAYVTg=
X-Received: by 2002:a17:907:3e1f:b0:ad5:b2aa:847c with SMTP id
 a640c23a62f3a-ad85b2f61c0mr129270666b.54.1748060708067; Fri, 23 May 2025
 21:25:08 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:07 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 23:25:07 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250508072907.207175-19-sjg@chromium.org>
References: <20250508072907.207175-19-sjg@chromium.org>
 <20250508072907.207175-1-sjg@chromium.org>
Date: Fri, 23 May 2025 23:25:07 -0500
X-Google-Sender-Auth: hbg4-uRhuf80ALy-5UWl_R94Z2s
X-Gm-Features: AX0GCFu57hWGEWZCkUDXZntYE5fHsHjjAdBVbR37otVNOX3obZC6Kl4Qf7v5DtE
Message-ID: <CAFLszTjkV5cwH5UG-W-QPAHKgbpK5iHfbNM9B=r727gk+Pr_qA@mail.gmail.com>
Subject: Re: [PATCH 18/20] patman: Move -H out of the send command
To: Simon Glass <sjg@chromium.org>
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

This is the help for the whole of patman, so move it to the start of the
control function, rather than being inside 'patman send'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/patman/cmdline.py |  2 +-
 tools/patman/control.py | 14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

Applied to sjg/master, thanks!
