Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D01C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 22:50:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D053C87771;
	Thu,  2 Nov 2023 23:49:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Va+83WNO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9713487745; Thu,  2 Nov 2023 23:49:34 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2CA687725
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 23:49:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-da0344eb3fdso1507005276.3
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 15:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698965369; x=1699570169; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BE57JCJfZSC+4ol5QKcXv2BU8t/x99Zj+fPUAIhjE/M=;
 b=Va+83WNOacARUFlHjIOBwQvgHs6rVX10zHR2+jkuAMm5hbtArhz4wTeBFPsc+2XNlw
 yyigurH1aom8nyNdSrbIWpkhtR78BJXhpTNII0IjLLaH0L8UkVVhrNhKiWnm+uKKCYwe
 PBzlY2qqydP8+QPcbGaV8XVV1QBEEeZM6n4DI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698965369; x=1699570169;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BE57JCJfZSC+4ol5QKcXv2BU8t/x99Zj+fPUAIhjE/M=;
 b=tvO59/I/2m9jjExeKAbixqxxIGfgGjMCkodQAonDBCeGd+4FNC+WEmFzT+kvoAoSd2
 0m3MmHJFgexdJmMSE8vnJwsIZT4gsKnZlVugfbIMH4wq+y1UnLYMXhaIeBu2P5gXqTQu
 uDj4Q2GTyJ9DJCS4ZC5/16yNPk66jfBLLhTuGhDQQdvmA/zclLQ88gi38CFkpqwcE9CS
 DVO6oPDJ1rGUHN3QVYKezLuo7Nrcvr+Puf9fexHdBUB9BBcz3tXrjO4j5PQBXqyENISu
 H4bIaC2btqHf785l/DBf+3B6+A01bhZOhOkjTjHzT8y51zEuKQ1nuRf57ZNEoNfU28ka
 6PSA==
X-Gm-Message-State: AOJu0YwuPN2GmLawwq8u1ZMtq2FH1jlUQ9hKMQ8v8SxK3VKKDz+Jc7Is
 Ye1CT25gn52tA1h5mzXdossTDS8vXSQ1c13UyGCTEg/FjfC7j8P7t1A=
X-Google-Smtp-Source: AGHT+IGzVOWhc64wWRxUq0JwxS+38JWMCbet3Xwb/Htc910JG4ipkO4+ybHQp0yJQJbjrrt4Ie6LiHJDw5U6H48HtBw=
X-Received: by 2002:a5b:b44:0:b0:da0:76eb:3d31 with SMTP id
 b4-20020a5b0b44000000b00da076eb3d31mr18063550ybr.15.1698965369284; Thu, 02
 Nov 2023 15:49:29 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 2 Nov 2023 17:49:23 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <ee189e3a-7ba2-4367-9ba4-4a959bf8bdf9@ti.com>
References: <ee189e3a-7ba2-4367-9ba4-4a959bf8bdf9@ti.com>
 <20231014204033.3077052-1-sjg@chromium.org>
 <20231014204033.3077052-3-sjg@chromium.org>
Date: Thu, 2 Nov 2023 17:49:23 -0500
X-Google-Sender-Auth: VMn1nNFTCpMQDRB-3oCp8zUh8a8
Message-ID: <CAPnjgZ0He5yChVtwYu1srJFvr0TQATjZV1rK+neCQYWgjKzAyw@mail.gmail.com>
Subject: Re: [PATCH 2/6] binman: Don't add compression attribute for
 uncompressed files
To: Neha Malcom Francis <n-francis@ti.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Simon

On 15/10/23 02:10, Simon Glass wrote:
> cbfsutil changed to skip adding a compression attribute if there is no
> compression. Adjust the binman implementation to do the same.
>
> This mirrors commit 105cdf5625 in coreboot.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>   tools/binman/cbfs_util.py      | 13 ++++++++-----
>   tools/binman/cbfs_util_test.py |  8 ++++----
>   tools/binman/ftest.py          |  6 +++---
>   3 files changed, 15 insertions(+), 12 deletions(-)
>
Applied to u-boot-dm, thanks!
