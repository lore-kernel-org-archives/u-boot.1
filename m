Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77100C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:32:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93522888CB;
	Mon, 15 Jul 2024 15:31:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GuNBXiNO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E969688886; Mon, 15 Jul 2024 15:31:29 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB62588890
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7035b2947a4so2497238a34.3
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050286; x=1721655086; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Rriv0SDqiVnGw6CcB8rZBrW5a/JR95noCUyUOB9QJIE=;
 b=GuNBXiNO5/5c/j2nCd8crrQ15X4QJKdqbv2jVutzKQynyvSQnqO8tqd9aStXhePIfk
 Sf7VlC844yiTNFWfvNDwFYUm/mqlV2fyDnJW5/Ig0NzLgqRqBZJXr9ZWJvPj9McCWlEL
 OXYDblukC9xa5GOSror1WOOrWQubQLtwElfxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050286; x=1721655086;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rriv0SDqiVnGw6CcB8rZBrW5a/JR95noCUyUOB9QJIE=;
 b=OAMECG/CgaXDYQZVtsmjoxfMP573xyNqWF7vraaCM8OSflOqsFqYQRLb0S0pMevYGJ
 Fd2Ju9SbfMiCfsrv5+x3fHnZpEnDCb28Fu7dTsN6Gq35vhfuTq/0f8Vjy0cVq35SXrP+
 Tr5XJC8AYEEGtylJeQNfAqkUD2fnEtFsmvR4O6UgQPasbp1sTbVQm/C18uuvHxZVDHXW
 Wa///yXK0fJljauTNnz3/vhNK3Rs3roKLdmnsf0TlXMgJO6tcfAS9hV8ph53hmqiIGA0
 XNZAmEhsnBn3dt86CR0T65xPTJ2LSWg9AKLkezO1i/XOelS013bAmcHJ1/cEJtf/iFZa
 oP6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiBt+GQYZ9JAZXyEomrlyNRvzEywhZx7wcGptmFccgUmyrnjqQOD3fQAaVaYEfLE1L+gRZfGYxm/Xe2QLthUdciiUHGA==
X-Gm-Message-State: AOJu0YxVkrKaCwpzDz981l4Gs0Jp+KEx+xCl2smGGVkGf4BniZ7Wh9ta
 5IbubCHubHLVLafiGzNVBVyCLqt1ILuJ1ODHrei5v2iPTB9BfaWjxXV6nsR/XMwOc1gUDItD9sR
 WHCqbznl7NjODREvbEJg/99nxnk3RvF6kyLAc
X-Google-Smtp-Source: AGHT+IHmHIRZGHvUckLaxl0A4V76ihUuaFRmBr15uwdRQ53tw9GNMURDurnfuLXobUYvkA8fDKHu7g3GWrEFKST0d2I=
X-Received: by 2002:a9d:6d05:0:b0:707:d3c6:a893 with SMTP id
 46e09a7af769-707d3c6a8demr13709169a34.15.1721050286517; Mon, 15 Jul 2024
 06:31:26 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 06:31:26 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240623175515.1466908-13-sjg@chromium.org>
References: <20240623175515.1466908-13-sjg@chromium.org>
 <20240623175515.1466908-1-sjg@chromium.org>
Date: Mon, 15 Jul 2024 06:31:26 -0700
X-Google-Sender-Auth: wwM7pbhrGD3pRXYcTvjXqUCtkMw
Message-ID: <CAFLszTg3Q1HZH9bHPiBkUcp9q=GwAfjicG+cDUeytsFbqg5RVw@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] buildman: Add a flag to force mrproper on failure
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
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

When a file is removed by a commit (e.g. include/common.h yay!) it can
cause incremental build failures since one of the dependency files from
a previous build may mention the file.

Add an option to run 'make mrproper' automatically when a build fails.
This can be used to automatically resolve the problem, without always
adding the large overhead of 'make mrproper' to every build.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/buildman/builder.py       | 18 ++++++++++--------
 tools/buildman/builderthread.py |  6 ++++--
 tools/buildman/buildman.rst     |  3 ++-
 tools/buildman/cmdline.py       |  4 +++-
 tools/buildman/control.py       |  1 +
 5 files changed, 20 insertions(+), 12 deletions(-)

Applied to u-boot-dm, thanks!
