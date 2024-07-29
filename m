Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19721C3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 16:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEBD5888FA;
	Mon, 29 Jul 2024 18:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JL+2Espt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92A0F88867; Mon, 29 Jul 2024 18:19:45 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A09A58888F
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 18:19:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6b79c27dd01so20086406d6.3
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 09:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722269981; x=1722874781; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k9elRMD6oGm9SBBF0fyWuMMeKnoxkDneIvrnyQxrStw=;
 b=JL+2EsptC21P1Ny3Or6WKZOMnWP/Rg7rbiHRjOWMaKd7gkEa36ULVCqkmyseOaD2eP
 ZazEXn0P2rX04ijVyd9I/wCbYqNOBCb5foE9IGwW5Yo03h5KU0j3OjWN8F3f2zHvbZPF
 EXPgh3eIOTdHb18p//pzYrwcg1FDPF2ccNHuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722269981; x=1722874781;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k9elRMD6oGm9SBBF0fyWuMMeKnoxkDneIvrnyQxrStw=;
 b=TYnVEu+YExoA1PCGCLVDsqKmtojew1WVhCH1KrHmDPsyAYPtwr4Dy2QSvt1BEA/WBw
 Os1QWO2R3srU0vBNjwj1/S9rG18bjm3mMMjXr6oYazKV/oSj7yapTC6Xh2ZStyA7PNk6
 7g/gKogmgS4h5tOoILQ2R9JZnLLJ6A49ermZ+ZhO2L4rr/LZBfqpjYtSsvVv/GqriEb5
 OWwIZjxPNQNaXJJJEfEx0ZrXh28lXDTtcO0gGROItln4uQBqDDf6VzjfcX89HUCmL/Vo
 mcD6/Y+HopucJgjoMasasm2xWFxDPnJ/H7t/Em7DInLocHyBT8RQXEUz5fEBzfPYRmQR
 cKOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaE5UEuTL0SY85GC9bq/hg2Utv8Qn145ABHV6+ShuV2oRS8/XV9l+634hOFMt0iMj5VXYgr1lIp3v+sm1Sn1ZfxuR4zQ==
X-Gm-Message-State: AOJu0YyGY6OoL2FxoM4tcSGuBsfYqJGUh1lx7/gE9BZIzKQWMH/dSEXE
 DDhrARCdr0Dpv0sTlVlH5Gd5YoGb15bk6kLPGhIHPc8YBgb4lQEJVYrgi3s3ONhM7dx6KwU/19C
 0tZgb2nMaIL1Kvq5xx7jC3JFBBIb/87kiN6rV
X-Google-Smtp-Source: AGHT+IFM642+0C9g96nST80sjJCfHFdYrx/5hCuRQV+aGLARjuRsVGYpLJN36K5ZFYeEyukRxSOC4T3qbpDmo1qU/T0=
X-Received: by 2002:a05:6214:5189:b0:6b5:8f73:acf6 with SMTP id
 6a1803df08f44-6bb55ab9e18mr96698886d6.39.1722269981597; Mon, 29 Jul 2024
 09:19:41 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 29 Jul 2024 09:19:40 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240720104950.2730773-2-sjg@chromium.org>
References: <20240720104950.2730773-2-sjg@chromium.org>
 <20240720104950.2730773-1-sjg@chromium.org>
Date: Mon, 29 Jul 2024 09:19:40 -0700
X-Google-Sender-Auth: UpLPAekenV1Beibr7FK8X1qKu4Y
Message-ID: <CAFLszTimBdAuHxOF963Lo2qnExBAnE5ryyhOPrW=ybDKup9NJQ@mail.gmail.com>
Subject: Re: [PATCH 01/20] fixdep: Support VPL
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

Add VPL support in this tool.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: f86ca5ad8f7 ("Introduce Verifying Program Loader (VPL)")
---

 scripts/basic/fixdep.c | 2 ++
 1 file changed, 2 insertions(+)

Applied to u-boot-dm, thanks!
