Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8FCC54F2E
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 13:23:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BB79833F5;
	Fri, 23 May 2025 15:19:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hBpDmSqq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B985D83236; Fri, 23 May 2025 15:19:32 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCA4B830B4
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 15:19:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-6000f2f217dso12407290a12.1
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 06:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748006370; x=1748611170; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vg5+9Hfsyx15eFT2szi/YGJ2fQbYgNMVnf1gqVEK9KY=;
 b=hBpDmSqqcJlzZ+lINAKtERUyvIGCFuj46jg6kzsFlPWpeOZ8YuOYGPOGqYUlptTY6i
 dJpAdbWzo16xyk7HgXuLblGKET9Q1Lh8mRuNl8qXrwZd44wmyiXqmbOn+gz7ONZylkwo
 sSG8v5Y+dx+pRW6oOoE6UFb9JiyvR0zYuobhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748006370; x=1748611170;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vg5+9Hfsyx15eFT2szi/YGJ2fQbYgNMVnf1gqVEK9KY=;
 b=X8iN1NGQkx54HVDzywH/W73JFdqoR/cWZkfaafrVP70kqRE7MirVO6lhHHV5LtOS2S
 /FIrwaGzv2HeCGN+BoweECGQnCfwC7/0PmznsGRnvcZmxtt07ckMSJVsgpS+xVBa77Df
 BpSVxqTqURf8ylleV9kQFGp488QJMykrdfMZn8iC3V8xXFmBkaP6IEiLYxU9LdfXW6eB
 aXkUEtOHg2aXZTxTWdujREUEkpsx6gaETDtOJB06TAIM4m30tLpqEK3USA/3hsmfvpQW
 +du/iPZzkrbUoTRSZm1U6qWp2cPiW/goXlsEqBvXPUvbF/j0Ly2Qie+JMmyeYtGbnpm6
 0WQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmTTpAox8c82jbCjjhYCfs1OW+eJiIBIqjARbUCef5Is0zChvbwQ5GS5ZY1XhF6HNXDzS8Hp8=@lists.denx.de
X-Gm-Message-State: AOJu0YzN7FDG/Wi2PVIlruhZzhB58K6FPribKWcYF/q44VubTowDfipF
 TfGZl5sWQLmJ9ptqHe91bylkkIgzUb5j57bmLbUSNoVchSiQbJEp/x5yegRLLCvdC0F12Uwqncn
 BqPmvnXjvkQMHYl/Rnk21pbcFetV5ivrFKUmudm2M
X-Gm-Gg: ASbGncuS6XchpbZKq/ojqj0+Ts2XMqgyYNhsRRjfbbG2fkw0dy0O9ZCK27WiFB+zBED
 hVOjHRkRJrV+Kna46sj3QRzDtguLOT61aTgzuBJdUNrIHTWYMgwdWxLtjrkKIhKpLUPhoYUDarO
 0Vsvew0WgCcZY3WL+fqtUDMC54olnfs3okxw==
X-Google-Smtp-Source: AGHT+IH/1iLoO9a8acRTr8xKD5RskLahpZxyM4Aw6dM1/gWDriD6TV9qZiKe9WuXckbzErpOw/te+qJJBme8jm/aFLs=
X-Received: by 2002:a17:907:7f89:b0:ad5:32d8:1360 with SMTP id
 a640c23a62f3a-ad70840ad65mr259225466b.34.1748006370170; Fri, 23 May 2025
 06:19:30 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 06:19:26 -0700
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 May 2025 06:19:26 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20250504132356.2317305-3-sjg@chromium.org>
References: <20250504132356.2317305-3-sjg@chromium.org>
 <20250504132356.2317305-1-sjg@chromium.org>
Date: Fri, 23 May 2025 06:19:26 -0700
X-Google-Sender-Auth: ajxOC4nGQS0vjm7mvomgipIQxhI
X-Gm-Features: AX0GCFtCW990z0G2a9ZXwaN_qsVw8VzIsUjXQPXSWFosp6XFI6yEk7-zAvZDou8
Message-ID: <CAFLszThgTZtxUzJ3nRxN7GFUvpa=Cw9wT1V+6j2SUNde5hG9jw@mail.gmail.com>
Subject: Re: [PATCH v2 02/30] patman: Move capture_sys_output() into terminal
 and rename
To: Simon Glass <sjg@chromium.org>
Cc: Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>, 
 Douglas Anderson <dianders@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Leonard Anderweit <l.anderweit@phytec.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
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

This function is sometimes useful outside tests. Also it can affect how
terminal output is done, e.g. whether ANSI characters should be emitted
or not.

Move it out of the test_util package and into terminal.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 doc/develop/binman_tests.rst    |   6 +-
 tools/binman/bintool_test.py    |  20 +++----
 tools/binman/cbfs_util_test.py  |  15 ++---
 tools/binman/elf_test.py        |   3 +-
 tools/binman/fip_util_test.py   |  11 ++--
 tools/binman/ftest.py           | 101 ++++++++++++++++----------------
 tools/binman/image_test.py      |   4 +-
 tools/buildman/func_test.py     |  10 ++--
 tools/buildman/test.py          |   6 +-
 tools/dtoc/test_dtoc.py         |  11 ++--
 tools/dtoc/test_src_scan.py     |  25 ++++----
 tools/patman/func_test.py       |  15 +++--
 tools/u_boot_pylib/terminal.py  |  16 +++++
 tools/u_boot_pylib/test_util.py |  17 ------
 14 files changed, 132 insertions(+), 128 deletions(-)

Applied to sjg/master, thanks!
