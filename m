Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A162CDE03D
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:08:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61FC588F4E;
	Fri, 27 Sep 2024 00:07:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V47Rrc2c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA9B488F41; Fri, 27 Sep 2024 00:07:30 +0200 (CEST)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4903588F4F
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:07:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71b8d10e990so9162b3a.3
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388447; x=1727993247; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=peOgXxqvVY+7yvhXXIkT2+dS2ZH5+4bBwzYuevLJoUQ=;
 b=V47Rrc2cD5ieQi8CLXYqLSx+9yZG21Dgkm9fhS40KMjoPvn7boTca2GpBqQlM3blla
 1zgU+tQLyXW87w1ftp1MVzMMuuuTmitJpWatFIBkiQhlnxhqpvcThEOwEyIY6QLCKGwR
 zKHHYtJOwtpwApokss33N70MY8k4FPQ40J7Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388447; x=1727993247;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=peOgXxqvVY+7yvhXXIkT2+dS2ZH5+4bBwzYuevLJoUQ=;
 b=Kcj4xOC0vHfkjmbbBu1U/ohafyZBCrahVEL/0lr0i+JDXnaiBuvCGSmAFcyngXtrdO
 q5Yb/hfQdhfo542MybLbX0VHGnccBbEBxY8t1H1k6sJpvDxetd/uh5zUPg/7jWcH3mRJ
 bXmDO6maAPOrThgF6YVyVbf4XW5bqGnnqqwywfwf/knvvOusI2bwDs6x9So+kA6gTxEI
 Fee9hvd1eDvm8MOr0U52tCEG7n5n2kPhnGMmvzKWNK3LJB8JEIFDPjiBADwk3WjsPi/u
 8cH/sDFaPL32Q6xp/pnTuisBWRPTx30r5xNp/Xj8va0tCao5yKTwwzBz4Dr+hJTJG/fQ
 gIRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtNS0TVprKBVAkfv5Qbb4CvotiCmeRTamn+vm2uWL/Fvr9hKvQqsDj1KsjD/dArA8b7bzM2LY=@lists.denx.de
X-Gm-Message-State: AOJu0Yyg/M6KG/KgYvzjBL4o40qIR+P3kqb2Om8rwT0ouf01E8mIuryY
 ifCJjUGOy3OhZDAbKv2pnzLLibnptuTNlxQrjJVFlWD7gYZkckirrtaao280ftaTcwEieAJ/qnO
 Zd+A/neXtbNxAW9B1XWoKJow0Ab8LaZVf/I/X
X-Google-Smtp-Source: AGHT+IEUOLLLVjtBTXXWdfULvyk1wv13pm61wPnztQ+IJVO4xk+a/PbLY1VHYlBDJ+0kqXmClcSb4VmiGFWQebDSdio=
X-Received: by 2002:a17:90b:155:b0:2d8:bd33:9c07 with SMTP id
 98e67ed59e1d1-2e0b8ea88d7mr1210140a91.26.1727388446842; Thu, 26 Sep 2024
 15:07:26 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Sep 2024 15:07:25 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240826191143.426387-9-sjg@chromium.org>
References: <20240826191143.426387-9-sjg@chromium.org>
 <20240826191143.426387-1-sjg@chromium.org>
Date: Thu, 26 Sep 2024 15:07:25 -0700
X-Google-Sender-Auth: gecHhssR7V110ZlY6FOQTSToD_k
Message-ID: <CAFLszTg7tKLqSeCe=Z_PaKvYNdUnQky2bk9uSmA3Bk72T-B-uA@mail.gmail.com>
Subject: Re: [PATCH 08/15] binman: fit: Set the image_pos attributes only once
To: Simon Glass <sjg@chromium.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

The section etype has its own implementation of SetImagePos(), most of
which is not useful since the code is included here. So call
Entry.SetImagePos() which has the only piece of this which we actually
want.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/etype/fit.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Applied to u-boot-dm/next, thanks!
