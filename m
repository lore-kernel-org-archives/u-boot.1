Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A650E74ACA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:39:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A714189667;
	Tue,  3 Dec 2024 20:39:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="J3URnq46";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 277B089655; Tue,  3 Dec 2024 20:39:29 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 037A289680
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9ec267b879so975464566b.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733254766; x=1733859566; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ezTDcBajEBks+2Gb3djHDTX5VTWTCmUOiHW7n0iIslw=;
 b=J3URnq46usvQIS7Yapdk34fEDmze6k4Koyi/iAO6sCscs8N1bjj7P7Dv9Q1p8eJ96l
 NU9whJ7wNUHcwqEcWGFH5tCjDuVCa01JTJFAxBZbACLDjCZhEjQxisl2gUxub1bJPxo3
 BgN8Y0dJKHKZPJ/WB8+TS1iRAOjtqUDlgoGE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733254766; x=1733859566;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ezTDcBajEBks+2Gb3djHDTX5VTWTCmUOiHW7n0iIslw=;
 b=udSbYRNdYycYafx5Wpwy40uYMJkFBx9jM6KQj12ushIe13Kt0LiPfTny0MWLDNcSPj
 90tKIB1Ewnyk25Q+PX3wu4Wvd3L7o/PiNU2+uWrtRJpizBrYFvbW3jom3P5ffFVx75Fd
 Va3T/CH/BEe1P6xgmjYrIl+GSD4Ldz+iy1y7uCNyEbi5EUwFH+RduvlnS6hmay7skYA6
 U41D3QnhIgebXRrvkWEq/J8pOEKgAzCBlch+gr6LmBQWGs1yqGe/pMMX/91Qx2MI4clB
 qxvV08kTUwkF0zfxvoHSNZUBzG1W60U9Sv01kHSiv87PzxLZdaMag0yH1kIsu8cTI2qx
 +e6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9k/sHTw++UiuQYuaVhjIcHybU/lO2UFlh81tu/yO/AyeQ7mnpoL6Hz2sJJXSX8mJskUFi61U=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6DDhIGJ715plnVlMdd0K82QqboBbxkXTTNVgKBxXhsRlNtLv4
 c7QW3HQHannoMihxbLQAlSv8q9wB352G0eTjQ2iExD/8RPEQdgFHtNgzN6ORrWsEN/jsdO8+3Mj
 T/SCbzijZI17uamPfcuc64mJBrdn3kIGQmNsfZf9EbatqrX0=
X-Gm-Gg: ASbGncsGTabcfCpsDCM/DNXmXmvdpTyOiGv+hiGCxJo0cC4euNEeE7XemQJ4JvQNV7Z
 y2R2nyxW9ka0XOo+bdghBuwXe3cdVBcw9
X-Google-Smtp-Source: AGHT+IHKizV5gqv4po/SPo1hhbytW7Aw3jYmSDtMJtKOBUt5dXU0fwBQpl41rCdW/UNng/Ct6J9VZi28UH0WT0VKrx8=
X-Received: by 2002:a17:906:30cb:b0:aa5:297a:ac65 with SMTP id
 a640c23a62f3a-aa5f7d4ec91mr361505566b.19.1733254766367; Tue, 03 Dec 2024
 11:39:26 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Dec 2024 19:39:25 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241103003322.626036-23-sjg@chromium.org>
References: <20241103003322.626036-23-sjg@chromium.org>
 <20241103003322.626036-1-sjg@chromium.org>
Date: Tue, 3 Dec 2024 19:39:25 +0000
X-Google-Sender-Auth: ZbDhLlAY9ibV3UgatNy7Hs3fA38
Message-ID: <CAFLszTgcqYen4xFD4UU2U8BnWJ37HYxdwwEHfi_oPwBVLcu7DQ@mail.gmail.com>
Subject: Re: [PATCH v3 22/25] mpc83xx: Drop status-LED code
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Mario Six <mario.six@gdsys.cc>, 
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

This is not used anymore, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/timer/mpc83xx_timer.c | 5 -----
 1 file changed, 5 deletions(-)

Applied to ci/master, thanks!
