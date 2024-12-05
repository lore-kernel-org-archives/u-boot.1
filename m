Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D69E7716E
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:58:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5ADF8957A;
	Thu,  5 Dec 2024 20:56:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L+WfT+BB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79D5E89578; Thu,  5 Dec 2024 20:56:10 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 982718952C
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:56:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5d0d32cd31aso1533010a12.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428567; x=1734033367; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+d3OKKLhaEtgv5hdAh9WmcCI7kJdBU+Z8dwhK1tVD2Q=;
 b=L+WfT+BBFrt/rj/se2Y30P0XM4kWBxp/QgYS+ntRdnfFctbob0Wa1W7yQEaZnBus7U
 gwhmNqCVSHwnYmZxDDlReHbyvICQ9IsBuCBQHeLPC3HcgagM0THM5FuLYp8RASZ8eG9x
 k2Pv3N/f8p24efvxsDmwq4snMcu3s+KebRYXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428567; x=1734033367;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+d3OKKLhaEtgv5hdAh9WmcCI7kJdBU+Z8dwhK1tVD2Q=;
 b=DTcDAMmoSJ2LsZbKL6VfZ9YP9Vnb/NlNQ3fFTIqXJIJ1Ry1YyCsKAYKPjP3R7tgV/m
 YyV27Duofjv9CenGmfHR4Lb7sp6UiZlJaGl9JzRtPwM4+kdI1rrIh/ixZgxe5xtT4R7n
 4ODhxT949VwKNOljKvFnDMCr3LRA/vvbHDus+Y4zUptFp4YSnzlWbFjU4yxMtNDCGU9Q
 +5NaKN1lppHyo3xwD5E1i6ugm2jiUQsBgcjyt+foVo3f5RAbaMQPJ1cJnRXd92qLnYtp
 RPsNwhBIAzt9FKaN5JHInPbTwEmCxcPgTG1aHfuQuR2fzyMOJTHRvNahxDNz4pzZLkVI
 htVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+XotC0EDUodT1Q+tWBYEXtRvYmHVn+JXjNhshK1vGP6U0Qd0YfWMao89bnKj/8vFf/fwyjBw=@lists.denx.de
X-Gm-Message-State: AOJu0YzWEwuwnTaiH4x07Th8SCgEfhp/jlDw+2pKsfNRlTOqNnRaij5R
 brj+uUvVzb63jBO10ksYUoD2MKYrbFvyktED5Ax3sPgoEg/W7y0+W1+NU6rip3jHOCFjH78W2gg
 dZv1d76pgUJnLhtTYimvPhGnsaCW/JmoPAawg
X-Gm-Gg: ASbGncs+RPM6sItR1lnnR7hgPCOSoOCGOe4BKWls2DEM1AE4E0FN2S7uAy962R3lQr2
 9odZz26YfWYTRnOaKlnvPH6reYoCFf0pX
X-Google-Smtp-Source: AGHT+IHHLhGFO+6Brcj+7lspW3Mk6Hq/4M2wrIsK04FUy+XF5IVPKMFfmg1l+Ef6vqNoD4UwrOHhpAuDRY44pqpQjeg=
X-Received: by 2002:a05:6402:26cf:b0:5d0:d786:b894 with SMTP id
 4fb4d7f45d1cf-5d3be6ff9eamr894007a12.26.1733428567144; Thu, 05 Dec 2024
 11:56:07 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 19:56:04 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241115231926.211999-6-sjg@chromium.org>
References: <20241115231926.211999-6-sjg@chromium.org>
 <20241115231926.211999-1-sjg@chromium.org>
Date: Thu, 5 Dec 2024 19:56:04 +0000
X-Google-Sender-Auth: xkhGkqkBcCdhG9-x8EThqX9iq10
Message-ID: <CAFLszThfHEt9p9KkucZj7SXmxXHGp_9knVw1SBOQegRWn3jbMw@mail.gmail.com>
Subject: Re: [PATCH v4 05/19] bootstd: Move the bootflow list into an alist
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
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

Use an alist for this data structure as it is somewhat simpler to
manage. This means that bootstd holds a simple list of bootflow structs
and can drop it at will, without chasing down lists.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Update bootstd_add_bootflow() to return the element number

 boot/bootdev-uclass.c | 47 +++++++++++++------------------------------
 boot/bootflow.c       | 16 ++++-----------
 boot/bootstd-uclass.c | 42 +++++++++++++++++++-------------------
 cmd/bootdev.c         |  2 +-
 cmd/bootflow.c        |  2 +-
 include/bootflow.h    | 11 +++++-----
 include/bootstd.h     |  8 +++++---
 7 files changed, 51 insertions(+), 77 deletions(-)

Applied to ci/master, thanks!
