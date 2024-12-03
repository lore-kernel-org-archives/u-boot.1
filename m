Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120D8E74AC8
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:40:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCFB689682;
	Tue,  3 Dec 2024 20:39:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O0HHFgRY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AF2989681; Tue,  3 Dec 2024 20:39:47 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9483287F3B
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa55da18f89so894856966b.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733254785; x=1733859585; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SNUj0cOkXnZnYBJoA2j811Y4b9UNQ3hsUcOvQd1FMHI=;
 b=O0HHFgRYWoBGdujbCHojDke5IXFoP+vMyr/rPmLO3eb3G1PABsVwfmxob/dx9EbuZa
 UrnlNwMSy/sU5NzhfybKCn7plkq8jCeUTYGM7qnnkUYKtTHU7Soh/sjJDwYH7sBCmFd4
 07DuaR008mx/lfu2tkRLLtX35tUKrbWJk4430=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733254785; x=1733859585;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SNUj0cOkXnZnYBJoA2j811Y4b9UNQ3hsUcOvQd1FMHI=;
 b=WS/CB1yDUxjXOUL/HbUY2TSqhtBoq28mttIsSAiAnMmbGdFgFrAMKo3hO6nvGUz918
 4DjpX17yG6BhO61XLGp1OI234CMHtLN8A3lxmnz3Rx8PqUVPxaQtKEN5IePVEzHIgieW
 ch9c5d97cEmGDHO9JYDaym51isTiO6G1R4LZzExwnO4CUx4eU318fz/Rcr/H26Ao+Nol
 m5MH21NxT51wP3wSvM2T7GID1BiSohYPXsuoxQGOp2jAjx+dwMr5f5Y9CzjA1hw/eYE3
 fsfFVu51SYnBC71EGXi9Xy36lYLbBfiKrNSN9pchhBb3iyUzCVzX/GWFdI3L6yNx8CWw
 gi6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCWZ4GPiuvBXuKr8EFLQeN08XcZpYBpmJXIpnR3tH8VCSpdfBZr7Du3Ff5gn7UEHZ+1nwLtrM=@lists.denx.de
X-Gm-Message-State: AOJu0YyGImhwUVpfYoZmN2zJP+noYcLYtiRltC8aJ3AsBpSndWMgTmn4
 XPyBIguFD0KehJgEXZn3PtKKbRMQJ01glwNDiMvJ3SlT29rfUAmrqwwqVbot17TTHP1LHr8k34E
 y8X4NG8tDVspAR1Oa29YnGNfgsMsO3Fk0uNo4
X-Gm-Gg: ASbGncvb1AmPQzciDkMNvAq2S+yZvP7CevrydrRkvNDu1zVIjzDBZ+JNOeXXNhn7JpY
 1CY7hECLWDC1zsD5Vtum8mDs8Ftj0d0Ab
X-Google-Smtp-Source: AGHT+IH6549y2VFaCQz8kRrlIh/8dqq8ddX6LGiiGLnrLbJ6bhsFmcech6N6VAZbkpRXzDewTwXxgDLTIZJa59O+bLI=
X-Received: by 2002:a17:906:3d31:b0:aa5:451c:ce1e with SMTP id
 a640c23a62f3a-aa5f7dc3e63mr251920066b.32.1733254785102; Tue, 03 Dec 2024
 11:39:45 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Dec 2024 19:39:44 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241103003322.626036-15-sjg@chromium.org>
References: <20241103003322.626036-15-sjg@chromium.org>
 <20241103003322.626036-1-sjg@chromium.org>
Date: Tue, 3 Dec 2024 19:39:44 +0000
X-Google-Sender-Auth: N4uquNtKyNOuEdX7ztkX6HjX1ZY
Message-ID: <CAFLszTjVZXh+-iv5B4nsUBcZQGMe=KguUrbzaNQPEUSHsHahFQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/25] misc: status_led: Delete driver
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, Stefan Roese <sr@denx.de>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

This driver is not used anymore. Drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/misc/Makefile     |   1 -
 drivers/misc/status_led.c | 124 --------------------------------------
 2 files changed, 125 deletions(-)
 delete mode 100644 drivers/misc/status_led.c

Applied to ci/master, thanks!
