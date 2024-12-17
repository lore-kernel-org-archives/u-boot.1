Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A55E77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD38B80291;
	Tue, 17 Dec 2024 20:47:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="d7kAbncT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD65880291; Tue, 17 Dec 2024 20:47:44 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9675280250
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:47:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-725ed193c9eso4907880b3a.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464861; x=1735069661; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uXMCL6S38b4BRESdKGOi0LdQrpcp9BmXwzlM2OxYk6k=;
 b=d7kAbncTdTYPmtnA/xrermCKkatJjFrxmFjCsnUDhmIuBxaC8a2p4tor30wZxt31h6
 RV9Ztx//g+R6E74eT0RnSsYdQePamw4P0uJScxVIyOLmPCJjaZEueVUEdv4OOg+ykie2
 rx1qZylTj+qS+TGmwiWHQWXmE2s4LrbDWSJI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464861; x=1735069661;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uXMCL6S38b4BRESdKGOi0LdQrpcp9BmXwzlM2OxYk6k=;
 b=g9V1j3RajhytcHJKvny5DnQl6KgCktk6zy2tfZ6SVM+a36XpYIl9XLkkFZZboDH4Xu
 kbB64z3Jc8igX+c0IKvsQS0zYUqRNnrGO8AFGx9yv/eWSwGttv7Tafe+eJxXOhWv4PQv
 gvWsk4Vv1VqeOHTLcW0wlDkzQUwnT45mTwInPtTKbwFb5GBtXD3gt2rsYZiyij44Bm6b
 8TebcSYRyBCcrDk96w1Fqa5O/is8USba8wQarfk+3IqZ/ukxQP5HfadCU7RBhP8IvZK8
 nIM9u+Dfs6+fH+B/lFbDJzUTMqnOTj54LMmr2I3UNzkAr1yYftgRwzsBFqUAzagxe2hm
 sIKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqc7JoxesKJPWstVfR1tPG7RBWmsniTNNqO27qW4tcW+/DewEsapdAkvFEHJ2BS8XtW8iz/uY=@lists.denx.de
X-Gm-Message-State: AOJu0YzK+oAqSKBl8S/6au5d9U7bbxUKLrPcdh9e6Zkegul5+PrU3dpI
 l2Y/izZYlZc/Q89ql0k4ETQZqx3qq2fNJwSKmJrhzbbAMGKroQBG787cq7fYBBU0OnNgE//3oGa
 yDpHIrfEUUMi6gcJ1jvG6H8CyiMMnSmiEudxBUke9rBXsbFk=
X-Gm-Gg: ASbGncs7viX50q3HsYgwrM+YJER/g/lUMSIdrct90wmRFEU9dauLOoHG0GNCDAo0G5D
 TDIWiqMktFK+4Bb4finjfSA1+mpKOFxtLkcF1kwM=
X-Google-Smtp-Source: AGHT+IE9rBDVdXAUMXvEDKN3I9lYvWbXLTTVcr47uCgU8NBlLq3vQDgj3g/oQkt1f95Ah+xsa1sU+xBOu31xvDBIwrY=
X-Received: by 2002:a17:90b:5203:b0:2ea:356f:51b4 with SMTP id
 98e67ed59e1d1-2f2e91ddd13mr201708a91.13.1734464861012; Tue, 17 Dec 2024
 11:47:41 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 11:47:34 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241211135418.563803-12-sjg@chromium.org>
References: <20241211135418.563803-12-sjg@chromium.org>
 <20241211135418.563803-1-sjg@chromium.org>
Date: Tue, 17 Dec 2024 11:47:34 -0800
X-Google-Sender-Auth: zgITwjCKIVXu1JG3nBdW9HHTtpc
Message-ID: <CAFLszThqSvZNRWU4S7JVgC=ykCB+1oa9mQ=CEdP8-1aF0Zg+3w@mail.gmail.com>
Subject: Re: [PATCH v5 11/23] efi_loader: Use the enum for the memory type in
 priv_mem_desc
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
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

We can make use of the enum now, since this struct is not exported to
the EFI app.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Applied to sjg/master, thanks!
