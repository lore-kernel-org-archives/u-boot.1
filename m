Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF579E95A62
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 20:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB60C86E22;
	Sat,  7 Oct 2023 22:37:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bYK0SkyH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F119986DCE; Sat,  7 Oct 2023 22:37:48 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C7E286A02
 for <u-boot@lists.denx.de>; Sat,  7 Oct 2023 22:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-533e7d127d4so5661474a12.3
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 13:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696711063; x=1697315863; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kr190rY0w5eIW9RTBZ93v980OBd+K6ohan0+3qX/6E8=;
 b=bYK0SkyH84ftdduEEz6ngkFZY9jczlfu3x6/AzBbwJEfevPgk1+Mh4xBeL+5GZDaEP
 Rit2WEzUk0SL/i/gkffcYI16XiWbyb82VWSehcWxkLImDxXv60rNYjZga1whWyjdNrwG
 2sprtXwj2fOl+5uysNrl0CUa8KCCRzOxRzcSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696711063; x=1697315863;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kr190rY0w5eIW9RTBZ93v980OBd+K6ohan0+3qX/6E8=;
 b=MgH6cxZemxAN/WzH2LeeFxom7T2SM8l3c7xFHzDDMVz0wSGuPvoZC2v4xjrQJP5Phb
 0RLhMrreCgc4vut6ogu0UTY/vV2RCP9ArGMnS7O+9ejdjWaUttyeu0fKc6eR3aYktKBQ
 JY2dB+gutqSfmXblOQrBAR9HfvOKXretKtL2Ec8OnrgVb7qrlLz8cQ14LO0Jgb44Nx0J
 dVQJ8v2uicSwBypJE+SllVHzrSXzbyb2ASoPZo5ql+oBWTZSYM2nnW/yOnmz2px3tGOt
 0anfrRic/nKEjnX/WO+zkBoL+CO6ZSsSh83r5qEVqzDsLaUrbjYXIfPXDnzNbWb0UgYY
 T8PA==
X-Gm-Message-State: AOJu0YwKNqs7e1O7q7UGdTqzzlSLaXNSIrny4MEFnNoO8GudkyVApT62
 ypCq7ka2vfCuxKOgbiK8ETTB3GBb+rI4/stT210jCw==
X-Google-Smtp-Source: AGHT+IFYNIrNPuIyqwbj/VJ9HbjrS5LxFnxHSiQemZPt5WbO81dSnW0EzMc9IP/1X5XVigDiWyI3kdSavK7bwMYxCZ8=
X-Received: by 2002:aa7:db43:0:b0:530:f880:ca74 with SMTP id
 n3-20020aa7db43000000b00530f880ca74mr9922778edt.28.1696711062872; Sat, 07 Oct
 2023 13:37:42 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 7 Oct 2023 13:37:42 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ2Q7jDyqkR63=1ws+g4LR6LGOAuYUkbuFWULad05diEXA@mail.gmail.com>
References: <CAPnjgZ2Q7jDyqkR63=1ws+g4LR6LGOAuYUkbuFWULad05diEXA@mail.gmail.com>
 <20230923194424.1739224-23-sjg@chromium.org>
 <20230923194424.1739224-1-sjg@chromium.org>
Date: Sat, 7 Oct 2023 13:37:42 -0700
X-Google-Sender-Auth: nDTkh6UROxO8Md2oJg7mPlbz88g
Message-ID: <CAPnjgZ3FEzS87uSq-+OewGW7LWvJsObdrQU4L9uE6WCz96BYLA@mail.gmail.com>
Subject: Re: [PATCH v3 22/27] moveconfig: Show a summary at the end
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

Rather than printing all the failed boards, which are now easily visible
on the terminal, just show a summary. Sort it by defconfig and drop the
'_defconfig' suffix.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/moveconfig.py | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

Applied to u-boot-dm, thanks!
Applied to u-boot-dm, thanks!
