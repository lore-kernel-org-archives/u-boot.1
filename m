Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EBCC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 23:18:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09CA688618;
	Thu,  8 Aug 2024 01:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NK55jDeW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4488A88618; Thu,  8 Aug 2024 01:18:13 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D534F8882F
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 01:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6b7a4668f1fso2745966d6.3
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 16:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723072689; x=1723677489; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UGnaKimQKd/oYl/s5/n6V+buXIwfoBxzPpa/gwC8E34=;
 b=NK55jDeWVEfjUFHvSgL2fhOJNSFWyxogTN3wKVabp1pkicsRh70OOBW8RLmGrrv6Q0
 Ns0lpg5ej+q6zVV1V49vhlfe+gonU4Ghw7uxianGsw24YhlpmaHPtd1I8gZiB6/QXr/a
 V+RrkvJLCRsujIAoaK6a0GOX0iNe/aZBFv9bQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723072689; x=1723677489;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UGnaKimQKd/oYl/s5/n6V+buXIwfoBxzPpa/gwC8E34=;
 b=X9LfYApTwJncj8eODeYi/PfbZ6/vxE13IGYhhrdYgq+ktr6pbh9uh4OCUAWwoxRwIJ
 fFYip7uKC3gy/wSCU+lVg+2GRdoNVpA+VAns9jfA4xTfsc2MOlhA34WIcZsYvowmR6Ln
 HJLXP9sv2cWFDpm5E5A0PMOlsCtABUKEVpthwIXsqx7CwTgtCYWQtUqe4N5UZKqZm/Tl
 hQf+zFEEuGcW3bVqTgNtZMIYcx72tcjCd+zwdrlSsKoWqF3qFJYGLhrq3kLZMlkKFait
 hLzJGrJwOlrq7ubKyKvO6CZZ6uHfRZO1lwGcWGTtPhenvS3c9TjlJZ41K6Sh30W6d5tQ
 /fuw==
X-Gm-Message-State: AOJu0YwxTHo8DDpx3wg5aWKqFqmlze2IZVn1fIRQ/b/WsuKDE+HjTHOp
 ikteq1my0c+kndeFWaSnN8jMKcsrNWio97VFQB7uERg52gZgHrmcX69zkkLhgQW/4QEpnaJZfuk
 PNUQXTIKc2oNkDSpIM7uuy+4toSOS+Uh2RlCAgrnNFQVmQto1mw==
X-Google-Smtp-Source: AGHT+IHZxhZ6iNGeTRuHKy/mWL3DWe72duk+I7nMLH/vqba6bxJk74NFCJj5RQqCgu2KjMFkjwIQV+jih8AaIrDA2Wk=
X-Received: by 2002:a05:6214:2f0f:b0:6b5:ab8:3c67 with SMTP id
 6a1803df08f44-6bd6bcae52amr1961226d6.12.1723072689589; Wed, 07 Aug 2024
 16:18:09 -0700 (PDT)
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
Date: Wed, 7 Aug 2024 17:17:58 -0600
Message-ID: <CAFLszTj5oQwuMDbd_AXbYFsuQ=Yt+MzWeEOvcbqTuws2D2CPOQ@mail.gmail.com>
Subject: pinctrl warning on sandbox
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>
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

Hi Sean,

I was looking at [1] and bisected the message to this commit:

7f0f1806e3a (refs/bisect/bad) test: pinmux: Add test for pin muxing

I'm not quite sure what is going on, but could you please take a look?

Regards,
Simon

[1] https://source.denx.de/u-boot/u-boot/-/issues/2
