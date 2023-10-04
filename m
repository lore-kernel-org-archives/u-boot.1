Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04BCE7C4E8
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 18:02:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C627587646;
	Wed,  4 Oct 2023 19:58:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WV6W3PDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FF68875F8; Wed,  4 Oct 2023 19:58:41 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B55A875FB
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 19:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5344d996bedso54195a12.3
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 10:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696442319; x=1697047119; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rnIbbUTebbnykyaDCx0Msqfg2Ci7JyiIY9ESRGZ9NHA=;
 b=WV6W3PDMj5D7JmIxDzvREMEg+2xS8wlneazLqiymTYIXvTK8L7yEaFncfJf59O0Lli
 8t764N7qCv8Wah7avdcPITl3ORGGHxb8DDzeDFVIYvloxxqlPVCvTj40Tg0vt+VDJTqe
 uts1bHkVusv23XT5YIKOoPaPKXDtoeOucO0us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696442319; x=1697047119;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rnIbbUTebbnykyaDCx0Msqfg2Ci7JyiIY9ESRGZ9NHA=;
 b=nL/yH0sj1e+WbZWjOMtXAlR1+nNCyskeaTa7561cJe2mLoHWXvG7cyIU5xTVqhsHWX
 VB8P/oT8pFk6tJlrELg/qQRc7s1kzCP60ZhSBU6zAUpqnVqHPwBJB+U2AsOIlnw8TSVY
 GkCWyVOnU1e44DNtWftD7Z22QJwnXwWMj+L7d6klJM8df3NQYCWAe1UG5qnYghILB9qt
 9rQU/zo22KRGEzjmaqlItyh2z7p/tkaBi8rs1kMvBQQuemnxLEGA8l0SViQUeB7Clx2F
 FZkq952vqReMot0SuNr81dA66hQTqW5cx5lAwpKs9UYBOGhtNLlVVJOLWKuaS1H/Bt6d
 I+Ag==
X-Gm-Message-State: AOJu0YwPYZ0k5RBhBZGzfhzyBt7qUx0DOGttOCeg2eB2GTKFhOV3imgC
 BkBpEGvEV53tk5HDp3vve8Ry27WwPVyOBWKT8pxSVw==
X-Google-Smtp-Source: AGHT+IGdFnfLiBkLjsrNxq3TDR+UtYYvi7UfMC885VMN88V4ybJSLq5byfKh/d5EMbQA5NnJ4+L547NP773pkVBvDbU=
X-Received: by 2002:a17:906:2258:b0:9aa:25f5:8d95 with SMTP id
 24-20020a170906225800b009aa25f58d95mr3130161ejr.59.1696442318768; Wed, 04 Oct
 2023 10:58:38 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Oct 2023 10:58:38 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20230923194424.1739224-12-sjg@chromium.org>
References: <20230923194424.1739224-12-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Wed, 4 Oct 2023 10:58:38 -0700
X-Google-Sender-Auth: oJC1NHy8UYGz6nzp795uxjKdsTc
Message-ID: <CAPnjgZ2JgwnqEWVagATPPnjE2fJ-e9NdhN=5pBeu_3D_ZzqLZQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/27] moveconfig: Correct unused variables
To: Simon Glass <sjg@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
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

Fix pylint warnings about unused variables.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

Applied to u-boot-dm, thanks!
