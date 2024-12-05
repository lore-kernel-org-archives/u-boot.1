Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB75E7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:57:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06A788937F;
	Thu,  5 Dec 2024 20:55:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VcmQEF1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6339D8956C; Thu,  5 Dec 2024 20:55:51 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C7E289590
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa560a65fd6so232368666b.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428548; x=1734033348; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aylshaUMmAPegCIVAlsOC92kvuvse1CcLUo5y0HRxkg=;
 b=VcmQEF1md3HNVxMQSNNrAV4mviD31m15ru2WMU/y/jhCANotXeTu+hccj/Sg1XZRSV
 nUIUJvTmPqvvqnADWPPsHABNrR7+zBPuQV38bw7gHgxuxpMWT9tOLo6uqlXxwk1ThyIi
 pUREnRD8GzYeCOBeXNUntBxBBur+e0kXan2Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428548; x=1734033348;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aylshaUMmAPegCIVAlsOC92kvuvse1CcLUo5y0HRxkg=;
 b=kfht6tZiwFQpvrOfKXNbqmx8DLiZ0vTs6drH8dAqh1Em6/ZDFKMgwMXGKIUPCBzV0t
 q37GId70HGEhInIG4vPD1TQcmuSiHhBHSNf2ccfy4TpbTiEvRpXT2WFGQSQ4WZQe2GyP
 9+7kPgqjsZPX1izaBRuo1XttfpCIEsiA+M8iSmqscJV2qDAnHRsGkRmY7ZxwVlVZh5fA
 3t7K78stV32ZCzUwMULniYH7hdJeQg4eypld2lc5yHcrBnZh2mN+hhpXqYouo7KkGhzc
 lgmve+bURfRRJM+Twr6A4fbwoahdQGZNJ9Fh3JITZf9KDgUPuvEMvnyRGKQe96Dag4/P
 rO8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr/igAIzWFwI8EYYAu+IiW6J6ikdaeTTzKbvAHCJ1P1WKF1RLSCQLpi8sbdI9pkgJPD5tjnPg=@lists.denx.de
X-Gm-Message-State: AOJu0YyIxULa8XBMfMRaA8T/TUh6FfBHm9jNQ/LSq9cH4mrrtbqgb3+E
 gO26IgOvjNH1ZUaTD5/T4cE6m/bYPyOkgHEsEFZVhKlSZJ4Iesc0CHuGtVfdzbtekVwgXr0roDK
 W5+zRr+5a6pNdkioJur62G23ArBtX/viYKHxN
X-Gm-Gg: ASbGncueHWASbqi6sX3tc6IMNHnwQYMEpva7UpJkmHuey4QRLOz7Pt8kYPwZx302PV+
 h2oVWclmCl1qKWvriBAp61TpTakJWw31P
X-Google-Smtp-Source: AGHT+IEPc5uzkVPbR0ZKNkgtblXSZf/Ufu4rh/1drgyyYZITmH8hYdOM9FhVBM0shaYyyKdD9hOj1+hoxJr3FGxS/Pk=
X-Received: by 2002:a17:906:18b1:b0:aa5:438b:513e with SMTP id
 a640c23a62f3a-aa637626aaamr49700766b.30.1733428548601; Thu, 05 Dec 2024
 11:55:48 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 13:55:47 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241115231926.211999-13-sjg@chromium.org>
References: <20241115231926.211999-13-sjg@chromium.org>
 <20241115231926.211999-1-sjg@chromium.org>
Date: Thu, 5 Dec 2024 13:55:47 -0600
X-Google-Sender-Auth: 3rwcs4m0DMGkOjxkVchKi9pF4IA
Message-ID: <CAFLszTjKLefLZ3T4RwEk_sxC6Y4s3Pzn-U+Lth2GCXOss1qarA@mail.gmail.com>
Subject: Re: [PATCH v4 12/19] boot: Update extlinux pxe_getfile_func() to
 include type
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ion Agorria <ion@agorria.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Tim Harvey <tharvey@gateworks.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Add a file-type parameter to this function and update all users. Add a
proper comment to the function which we are here.

This will allow tracking of the file types loaded by the extlinux
bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Update to use a new image-type enum in bootflow.h

 boot/bootmeth_extlinux.c |  5 +++--
 boot/bootmeth_pxe.c      |  5 +++--
 boot/pxe_utils.c         | 26 ++++++++++++++++++--------
 cmd/pxe.c                |  2 +-
 cmd/sysboot.c            |  6 ++++--
 include/pxe_utils.h      | 14 +++++++++++++-
 6 files changed, 42 insertions(+), 16 deletions(-)

Applied to ci/master, thanks!
