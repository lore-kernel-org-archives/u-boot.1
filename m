Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3C9E74AC8
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:39:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4920E89688;
	Tue,  3 Dec 2024 20:39:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mpCJB0K5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B5B089684; Tue,  3 Dec 2024 20:39:27 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7636288E7B
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:39:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385e2880606so3913904f8f.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733254764; x=1733859564; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=92tbVGZA5y1PG/IejTrN0jK1zxmrgXcQGirFfO0V6iM=;
 b=mpCJB0K5BUu0apiVn9GWEWghFTJOE/g284jE7PER3rrTgYo91AzVvk9TzFMiHc9Ols
 bFSIKr2tusFqgv+XQb1NArSdmNWc8OmPxt8sCIPm3JNY6MLqqlmPf0RRrOuOCEB4RQ/r
 7tsvPL2W6h2YHoukvsncI510pQVa84sd2ojzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733254764; x=1733859564;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=92tbVGZA5y1PG/IejTrN0jK1zxmrgXcQGirFfO0V6iM=;
 b=JEYqZR1NKnt9hZNdCAXg49MIXe+aH+ihVUKAyNXiQY3++0huoHAG7HrzOUa7iewb78
 8gN34CTg0AkQQmKJZpjUaK4icrC8eDA7XZS6HvyPHpKa2csr06GibcFQUkjgEUCcmxmn
 fI2sMN7oE5NRMAtzNB+yLTM1wKxPiEluzOzz8RiHadF49V/DKWW0L+qCJmgto1qw7Ke1
 VUSeQZthEWB6uUBiM4Gphrj3fp/o1/hjvMdMLYic9wWkGu4fMObBGSiwMmoAJDXfpocx
 9Hr7ppct/6eqmGu+zNw3lgkBYzjUlXyCWCsEYzeR5teOXTThhghWm6E/7vKUxa9RCC7Y
 5sMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4RqlW3POHGmu3ufj8tJILLBYzeb8lW0/9WSL8MfjdNmhjukibVKGMahJURdiOyzW6rpIO1g8=@lists.denx.de
X-Gm-Message-State: AOJu0Ywwf1QO+Ktbp1uvZlQw0FfYQkQ3plZMDjiupOy+tZ5TppDFnytU
 V6kEaoQZ/hQthd0kPaH0Y6VVfPbBqlSRUMABM4kPIYLMWRI/3G9M9vrA1riQ5S+KUBLOT5xpWfI
 piwrGb5QWbp4TcmVIJkenN9X1UwKnhOml0Pqg
X-Gm-Gg: ASbGncvMuhzfaR6FFFrGFl6CSQLcqf/zO3AUiTiv7vAbtKad07sklh52KyAkXeWhnh0
 cpIyridEqkbL6co/j29WNhJrYWujretr3
X-Google-Smtp-Source: AGHT+IEsR+m14kZ6xbva7Ov0qouoYu+4+mlLcCMUOML595SkvIV3oUfkprhihuxWUQn0vp6SkIoFQeyYGEQVw0F4jNw=
X-Received: by 2002:a05:6000:1886:b0:385:ed1e:20fe with SMTP id
 ffacd0b85a97d-385fd533d2fmr2930711f8f.59.1733254763886; Tue, 03 Dec 2024
 11:39:23 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Dec 2024 19:39:22 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241103003322.626036-24-sjg@chromium.org>
References: <20241103003322.626036-24-sjg@chromium.org>
 <20241103003322.626036-1-sjg@chromium.org>
Date: Tue, 3 Dec 2024 19:39:22 +0000
X-Google-Sender-Auth: aaVzT-cFs7JYAyDT_SXlGrQrglA
Message-ID: <CAFLszTh2mMEkDZJW8xm_KU-_pRAtXg-2Zet_2X2j+E4C3R5+5g@mail.gmail.com>
Subject: Re: [PATCH v3 23/25] net: Drop status-LED code
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Charles Hardin <ckhardin@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Sean Anderson <seanga2@gmail.com>, Sean Edmond <seanedmond@microsoft.com>, 
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

 net/bootp.c |  7 -------
 net/net.c   | 33 ---------------------------------
 2 files changed, 40 deletions(-)

Applied to ci/master, thanks!
