Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C088ECE7A89
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 18:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 475CC86A0A;
	Sat, 23 Sep 2023 20:13:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f4/m5Wk3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDB2F86996; Sat, 23 Sep 2023 20:13:50 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2E048691E
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 20:13:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5041335fb9cso6250681e87.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 11:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695492828; x=1696097628; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IHYL2xuxQtViCbS084ITKTylM6eAkUzdVzSlQlDpSJA=;
 b=f4/m5Wk3Gw/huPK6TngweqoQ9gljgqFtkwHvSziXt3c82ziRgvsHG68HWSWneV6msj
 7/NPGXLz18/VdwJWzZdhv/vDU880iGOHv1Tpb4FMNlMiwB9dqj/Y5ZkTu8DiyGGLjShF
 foLsyVStUToQRgrEu/FKpFqf6uci1xypFgWw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695492828; x=1696097628;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IHYL2xuxQtViCbS084ITKTylM6eAkUzdVzSlQlDpSJA=;
 b=Jv61K77/nyCtH3tRoxMen773+QoSuBHFMBVILwgFOUReLaa+PZT1Q4LAPoXBFIrjfV
 GzDpAsz1k7vdnVknqKHS4JDju/S9syS3bm07xBtjDAlJc5ZYef/hdBbJtA7bt1/gQs7Q
 F4BDH+hjqo9xIVGUu1nDSWotOKT9PjEDU7Jpmyc8d+uuMt+3v2boRFGA7AHMgbvmm0UO
 safV605VOeZY006IUUlktAJePcs2yRbdNSpSWJGEHCT3MdJWOOB1HnjteQElLVdhBEDy
 fOrIX8nba65oiyPtUHZAoXVNW8A3GnShxx+krxI8oCejJ/L5YvO4+n4x24xJJLOrGEZr
 zfxA==
X-Gm-Message-State: AOJu0Yxap+il33TZ0Wzsy0v2O1GjbO9lSciuA17Ff2nzYKEV36DJC4TX
 HYlu6/D2VSo2WK7UdEzk7zMYjZtRd4DViB4/dbje/A==
X-Google-Smtp-Source: AGHT+IEhbrsunU9CHpFJJJyIwrl/Sze/l+CyCjKbjRZtd4+VqRd+1EIN8EAwEg6QSuPwxueHQlVuGn0SLoh2Nnot0wk=
X-Received: by 2002:a05:6512:2103:b0:503:26bc:b08f with SMTP id
 q3-20020a056512210300b0050326bcb08fmr1926703lfr.24.1695492827939; Sat, 23 Sep
 2023 11:13:47 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 23 Sep 2023 11:13:47 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <d3853d91b6fa7e3a1e5c24dd3c17335cf0041b5b.1694779918.git.michal.simek@amd.com>
References: <d3853d91b6fa7e3a1e5c24dd3c17335cf0041b5b.1694779918.git.michal.simek@amd.com>
 <cover.1694779918.git.michal.simek@amd.com>
Date: Sat, 23 Sep 2023 11:13:47 -0700
X-Google-Sender-Auth: c_LAlVl9yrNjyyKd4ddeL__mz6s
Message-ID: <CAPnjgZ17cjfKAfRZJwCjAKC3ZRA+s23JJJ+AjNB+NCDvNDHKAA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] trace: Move trace_clocks description above record
 offset calculation
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
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

Flyrecord tracing data are page aligned that's why it is necessary to
calculate alignment properly. Because trace_clocks description is the part
of record length it is necessary to have information about length earlier.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/proftool.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Applied to u-boot-dm, thanks!
