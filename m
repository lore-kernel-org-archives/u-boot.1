Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FA1C4167B
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:41:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EF1187897;
	Wed, 13 Dec 2023 21:39:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WXo2MqPs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D080A87877; Wed, 13 Dec 2023 21:39:19 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54A2A8784A
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-54cdef4c913so16630420a12.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499953; x=1703104753; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4lDofocDRHZuGVuKHgEA72Y/z2/sNk2tkvU+IEf1sZo=;
 b=WXo2MqPsbpPvZCDSpMT4XkvCl0jf3y8+b4MNlJQz07H75+Z/7hqi8ay0i+1PWPp4uN
 gYZOQMZN4RctUxCG7abjxP/d15HQ11KczLyjOmiEHjW0ypyVCE3xsbVsPnFLkkQbXaq0
 IMLANzvNpPqr/f/DfWC193+MX6WkvSdCuUVbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499953; x=1703104753;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4lDofocDRHZuGVuKHgEA72Y/z2/sNk2tkvU+IEf1sZo=;
 b=AyWJaBV6isch+47LDDdQv9uZVK5ybacEVIOrk3y6pOVzpwqeWy8zWjNMDhY9nYpLJu
 kU+ek0heCaXfTiYC7Ah4Voc0mluHa2pP3Q97INzzf7s4YwXzYEAzKm6jFqzwB0804vj1
 0/u0wB/Ge9bNlSMEftH8RIgJBd7Xa6gjeB+pL8/BzSmup4AdGYaTzeWX7A5XLEqNuQas
 u9c/Bdab1RacySkhZ6HQ15PgLyW7aqb6DlxaNvzil3TUqkyDltJ+8CDmUnPGTmIJuywT
 AhaDDncwnzSKXQ3nzaKEnv6wYf9GBJ/o8xuy2hGYa5n+FUyd43UJHgHZsupcuJ9jNIQL
 kbXA==
X-Gm-Message-State: AOJu0YyeJFEUutBjjDEkE21cFXoqZdRwab6utCLhwQLwKeQxG1LeecSY
 bEwf61Hd2sSxV/iKNSy3+tcECmfLF9qrPMkgb97HAA==
X-Google-Smtp-Source: AGHT+IGyGdtDfB67D+5rlJPMbEUIKvnvbdYP+Mg51BjZfBCmTn3ytJhAhB3kpJkNq4iFYib1raPrS2vbTYpwb9zM7+M=
X-Received: by 2002:a17:907:a087:b0:a1f:6ec8:2f6f with SMTP id
 hu7-20020a170907a08700b00a1f6ec82f6fmr8509172ejc.28.1702499952766; Wed, 13
 Dec 2023 12:39:12 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:12 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231119153611.639252-2-sjg@chromium.org>
References: <20231119153611.639252-2-sjg@chromium.org>
 <20231119153611.639252-1-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:12 -0800
X-Google-Sender-Auth: 9hrbuXZo6Lycwq6ftsQC1QFnIjk
Message-ID: <CAPnjgZ26LAiG47chsk0swBhYZj9JZ9dSiOBbYy+zudVbZz3ydw@mail.gmail.com>
Subject: Re: [PATCH 1/7] doc: Update documentation URL
To: Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Maxim Cournoyer <maxim.cournoyer@gmail.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
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

Update to use the new docs.u-boot.org URL for documentation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 MAINTAINERS                       | 2 +-
 README                            | 2 +-
 doc/build/documentation.rst       | 2 +-
 tools/binman/pyproject.toml       | 2 +-
 tools/buildman/pyproject.toml     | 2 +-
 tools/dtoc/pyproject.toml         | 2 +-
 tools/patman/pyproject.toml       | 2 +-
 tools/u_boot_pylib/pyproject.toml | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

Applied to u-boot-dm/next, thanks!
