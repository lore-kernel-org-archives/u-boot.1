Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC80C54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:20:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F8548334D;
	Fri, 23 May 2025 15:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ef1uObBB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E31383264; Fri, 23 May 2025 15:18:53 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9782D832EB
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-601968db16bso7691151a12.3
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006331; x=1748611131; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=C5CYfSUvgQ/zdWUqZtfEKx+YS5ZTwJt1OFd1ISf2V4s=;
 b=ef1uObBBXSdjyUxwVnclqD99efCJ036EuucQKuz3H4cmnUj/gaFVmnh/609f8kck3J
 AS6//p6MkGCHcYPw5pnQouDBLnw5zkT37gUjEaqd+MUsvqy8iFbMkaNvKrqmA2vnVuas
 CaukDwVdchqmH1f1H14NZXZApg53gsXJpdaH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006331; x=1748611131;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C5CYfSUvgQ/zdWUqZtfEKx+YS5ZTwJt1OFd1ISf2V4s=;
 b=ZVPkdCNgkWCBO8n0Cw5L7bE9LOpc4uzqyqt/xP4rGY9KSALK5XS/GC28CODwCyDC2D
 p/574qPdL3M/T936mS+diX4ZJGbi9MbDqNTx/VzWumSy7pidp6I8yBF4eiS7kyyaE4HV
 q+4679iIy57wi+LTAMD2UxXoOtUoBpdNv/RhZlIMNjiS41lJGN6BZYlB1Ey7JVWJfsBr
 ub078BnokabKxEuDAyGgYmbhkt4uxw8g4e+hhJO/O48vxRJd9XbDpv+ukALVUPw/ciGv
 OepxsYAxLsAOJbNncDGCNpxKlDrMSwvzANxwFPk5tPelAj8AIj7o7t8QpGZvzRhJbOCk
 A/ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/uNezLAb8qKR31hmfnWSHFjlExJuRurDiEeR/adzDD+vDYd3zCnJ23lpR7sFMIXj2AfSIKa0=@lists.denx.de
X-Gm-Message-State: AOJu0YxFTh7Vj/lUd3WMjgfaMF7paoEa7hRoBMCcTrQEORxgrLkprUn2
 xg15g9vS9j+6zIcIe4idlnGDqpepZU20mQqwm8WJl9hnTNcNerPWbRkcV1B6UpBpoJgD2OOR04I
 una3qysdc23pP3z9Zyverw4kkyfsqtMN/ERGunTrW
X-Gm-Gg: ASbGncvirGp13Quooa//eYlma7LfE8lbqXe65zSsTVTWn8l+VDMLUp582Pnk1tQIA96
 0lV12oP5bp1eP81Cj0xO30u2xTmhEPk2HyxXhYcTednPiDOivz9i/blgsW8oovlhy+P6awsrOu+
 bE8gFLGeq6w4u4+RgZ1trkQrQjjlV/vwqX9A==
X-Google-Smtp-Source: AGHT+IF8XdmeZBEqUys3Y2lZr09pZzHsQN2ynqD5bHsz4iGfMguwm58NM6XQCPkOd+5W2RnYNXN1fnWHFtCU+DiNu/A=
X-Received: by 2002:a17:906:6a14:b0:ad2:2e5c:89c5 with SMTP id
 a640c23a62f3a-ad52d4c511cmr2673260966b.20.1748006322818; Fri, 23 May 2025
 06:18:42 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:41 -0500
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 08:18:41 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-20-sjg@chromium.org>
References: <20250504132356.2317305-20-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 08:18:41 -0500
X-Google-Sender-Auth: 6_dmY2IGBO1IdScvnR2c68ltWeE
X-Gm-Features: AX0GCFuyeqmxGgxKiWGpJAOJGzM9KV4xhnzHOqqckJ1re-RnK3YY3P27XCpDzIU
Message-ID: <CAFLszTgrewKdKfUN+YnSiJZoT_CHhhk0tm+b_z+ROLUpbduBiA@mail.gmail.com>
Subject: Re: [PATCH v2 19/30] patman: Rename check_patchwork_status()
To: Simon Glass <sjg@chromium.org>
Cc: Douglas Anderson <dianders@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

This function actually shows the status and does some other things.

Rename it to better reflect its purpose.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/patman/control.py   |  4 ++--
 tools/patman/func_test.py | 14 +++++++-------
 tools/patman/status.py    |  6 +++---
 3 files changed, 12 insertions(+), 12 deletions(-)

Applied to sjg/master, thanks!
