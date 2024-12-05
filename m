Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DC1E77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:58:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DA9789598;
	Thu,  5 Dec 2024 20:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TiOu1jeE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C011F89592; Thu,  5 Dec 2024 20:56:11 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDBC089532
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:56:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d0d3dd3097so2117133a12.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428569; x=1734033369; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GZVNv7jkBDRSUiEX0II5PK+P+h4uI0rNH/upZfYoAuk=;
 b=TiOu1jeEK9UosQzmbrCKi7MGk+CenvRke15NErXbBlAyqHN5eLkVfoNd1/7E0Zuw+K
 XgUw2zZpjXGkHgcu2UX41PhiCrC6jx29/b/SHfMnEFAEEyYmkbX9HrvGL6oAuAOAby24
 2jLL5umCOwrN8ipm3sd9L42TdVNq3TxDP7ukE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428569; x=1734033369;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GZVNv7jkBDRSUiEX0II5PK+P+h4uI0rNH/upZfYoAuk=;
 b=q28DXGitM1SoECQalWDwz+JssUZTmqPbTK77sovG+18pDpkAxdAZMkWfBWNWL6eJTH
 H4YLrCmeUbRAzCaiynpO7hgx6dCOdrmzIc4mcMM3KPBTa+P8erEVPg4YPeCUDFbdBFLn
 6EclaCZ2Y/aCCJhK2XcwOqLX7jp4g/Mh4sOigW+VnNQFFIA46tDTGbWIb9KxpCSo/c44
 fjXELweIh3P1on5N7jWHEm0mJmwQCJst7uRZwbGou34LBH9s5ZzpjRNJ4MJli5EG6NhV
 WpYwt5OvJs2aT7f2oHvdOYh5um3v7S0dkF6SjQscmoxrC8N+XUaWwVSQqHitPY9FDLow
 QMWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYqqYEzX8T9R/aXYa+BwZOlWa+acCbJ3NryHPJQiI7cBMdRoZfDGZm8UzuC3FgxoRjLVkVVck=@lists.denx.de
X-Gm-Message-State: AOJu0YxFBquIXaBsAaILDrH/qIwLrPbOAgMQ+hJK3Dt0fTkBukvZ4eSZ
 eRMOpoRfByRrELxJ+R5mHfINw/FiYFLbSM/TQlVhCF6Y4OCQdd2gdxyPq5sUfu6DkRmdIlwU8A5
 0NJ0gcRMhfp5covfbqymRXrkeU4c9bLRk1xbV
X-Gm-Gg: ASbGnctggIeEarSlttqIKq9WMm1h3BVcwuPSr/SSF+Cd96x7vAOVwVd1ZYe72jNZ7ob
 Nf1Tb+fR08GaeAn8pd0U12bEDc+tpAZDq
X-Google-Smtp-Source: AGHT+IFN5WjC0bjTNd2PzsmAZ4UBdiFTW4taNSEvdUYirhot05KFwKNGP57/1cpDk3Uhq2SZrKoX5Ctau/+xSQ/idGo=
X-Received: by 2002:a17:906:4ca:b0:aa6:1e9a:e46a with SMTP id
 a640c23a62f3a-aa63a2c6679mr10122066b.57.1733428569278; Thu, 05 Dec 2024
 11:56:09 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 13:56:05 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241115231926.211999-5-sjg@chromium.org>
References: <20241115231926.211999-5-sjg@chromium.org>
 <20241115231926.211999-1-sjg@chromium.org>
Date: Thu, 5 Dec 2024 13:56:05 -0600
X-Google-Sender-Auth: wAP9eedlxX_EC_WjfGtxSg7hvE4
Message-ID: <CAFLszTg=c_4Mo5u2Pb=XiJ+8EfR2D9pE=Em07bBRXtZy8-ihzA@mail.gmail.com>
Subject: Re: [PATCH v4 04/19] bootstd: Drop the bootdev-specific list of
 bootflows
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 Nam Cao <namcao@linutronix.de>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Shantur Rathore <i@shantur.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
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

This list is only used by two functions, which can be updated to iterate
through the global list. Take this approach, which allows the bootdev
list to be dropped.

Overall this makes the code slightly more complicated, but will allow
moving the bootflow list into an alist

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootdev-uclass.c | 61 +++++++++++++++++++++++++++----------------
 boot/bootflow.c       |  2 --
 boot/bootstd-uclass.c | 17 +++++-------
 include/bootdev.h     |  2 --
 include/bootflow.h    |  5 +---
 include/bootstd.h     |  2 +-
 6 files changed, 48 insertions(+), 41 deletions(-)

Applied to ci/master, thanks!
