Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4328DCE7A88
	for <u-boot@archiver.kernel.org>; Sat, 23 Sep 2023 18:14:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2948A86A43;
	Sat, 23 Sep 2023 20:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PxJ/1GlN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8108E8691E; Sat, 23 Sep 2023 20:13:57 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67D4D86B09
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 20:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-530fa34ab80so12046656a12.0
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 11:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695492835; x=1696097635; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cCtSv8OeI8mqijqCOIIQvGKndFR95AVOJbd+KXF0teo=;
 b=PxJ/1GlNAsZy4zkR2dwktyKl53hDvbLt/TYQHpDak8J0oS1/LiCQ/lGS0oPySiUquK
 0aYPwukiZLWbo8adXRUhSpGkhsLGuaL3RthHAT/+H65y+cQL4PcSvZjpBEGyZX2zKwSh
 eximvABh5UggmTiQwjsS0T9Q9RMaKddXwtzJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695492835; x=1696097635;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cCtSv8OeI8mqijqCOIIQvGKndFR95AVOJbd+KXF0teo=;
 b=b05qOMT3pzWK0ueFBbsPeN0kAhI+RAMDOHRGxC+YAGuuqtLc1PStaDWCFe0/Te5ABS
 ON9sbaMxtMQYL5aGLcwegzSnAL9N3uXnW32S+Iutuf4YvvVWtJFsUjlVayXQIz076iQd
 25hmu9/hSm4m2x9QdXlnYJPwx80pCk6us+sF9rY/ktTBeaBqJmJterTodTqpenqc8qzQ
 p9YRRhY+5Cp/XBRzO0T7BNc5wPAPKNRdbvG/nptjpePWYJrIyDsqx02fqiqpDb/Ji2tU
 pERmtCOLyabWWcPb/shQBt0zMVEyqmHSDi6xuGfO8BlZSSMsDou2R2fKkHL6FbguED8z
 W3Ow==
X-Gm-Message-State: AOJu0YyUPw32a5INY3MC0XVktwO0nqFp5NCtWeJXeKjFVNHASa3au0ma
 7iBPsWDZRxwd9TAptZtDENcSNRaieMGH4g1jGT6gwA==
X-Google-Smtp-Source: AGHT+IEWfJHxlBgCtQocjWsQF6QWA3u6PRF0vJI0hTde/g3worvS/ogzBiTxjNshNcoANA/AbF6bhJSVU0ftIhHa0Mk=
X-Received: by 2002:a05:6402:2803:b0:533:4a89:5b2e with SMTP id
 h3-20020a056402280300b005334a895b2emr8818363ede.1.1695492834656; Sat, 23 Sep
 2023 11:13:54 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 23 Sep 2023 11:13:53 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230904155501.2715470-1-sjg@chromium.org>
References: <20230904155501.2715470-1-sjg@chromium.org>
Date: Sat, 23 Sep 2023 11:13:53 -0700
X-Google-Sender-Auth: j6ZT1234NiZVxa3QJJ373xQUixg
Message-ID: <CAPnjgZ09Kc2OsqfJhrxgeuHMrT1rJUfnzKK-QQNBvkxkm5o6GA@mail.gmail.com>
Subject: Re: [PATCH] buildman: Fix full help for Python 3.8
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

With Python versions older than 3.9 Buildman produces an error on
start-up. Fix this with a workaround for importlib.

There is already a workaround for v3.6 but I am not sure if that is still
functioning.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/buildman/main.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

Applied to u-boot-dm, thanks!
