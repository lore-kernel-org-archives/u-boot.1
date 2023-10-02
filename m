Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F49E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:38:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 539A9871F2;
	Mon,  2 Oct 2023 03:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="wfJ8LIeA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C109871F2; Mon,  2 Oct 2023 03:22:13 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57F458711F
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9ae2cc4d17eso2228981866b.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696209724; x=1696814524; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wPbORSQotwu5LQpMgpsAI/phNBG7iBFAw5QZ8Cku068=;
 b=wfJ8LIeAZNmTn1xd7e2y4lHwAowr9EAVoBRSPpiKxnXtk/u5oMXUin8ioyBcfAfMOw
 krypePgrKu0dgtAfiVBUJkzeNciPMuXMTAnrnkY62ffP/ZoIpr7tqOf+xoZL+rLwXLJC
 Bj90gsJ19E6PoDKLIOJZelO3SpXl2eUQNbP0YBDOFrSFDUGaokaiNZtffEw8BVsehP2p
 cs0GdxRdG96Ejrgm5vUCluviLr9oUbCbmwqaLRzjxtZfEeBECUHooj+E+l5ZJ6p5hbAa
 6Mx1LF5Uzlk36ZpjLZOqyjQYD8yWZ5Do82pqb8nY6C1aSSfYJoGpch4JWHYCIO6q5eln
 169A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209724; x=1696814524;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wPbORSQotwu5LQpMgpsAI/phNBG7iBFAw5QZ8Cku068=;
 b=fUavfemESh33lgHeaZq/ThVlr2h84d6RWLqYXBasq5v+QNg2FqfUN6WWJy5jddBbhT
 xiOoLSryA1UFVDxkMECUnIQINPw4oC8Gc2F9jf9Cc0Vd3SeR2maWMEknYfUqkJpg7EX3
 sdm76LyAxhE8qlDI/FNNYNVuwp/GVdCFNqb2L19/FfFO5zWy33L7n+yxUB85Pb59LRUz
 kfIBeWPaJjtqPGai7G2diy3+U9SuHZxebDESYtFQmr0S2XHOZe09dRzjqEup4s0rP1ZD
 cjvOfPcUWeX1zPMaRdKS4COz4HgeDvj6tctNcX3dYjPCVx2kafGYl03Xk9ngDlSV0z3o
 bxcg==
X-Gm-Message-State: AOJu0Yw2+0wxb57TLCqk8gPaBvvYtn3Hl/aTrshtdyF7q8H3tqLzw74B
 DqoUBKUVMaqW+HdiwaHZnkpSnHYlh6/ZCMOgzet2cw==
X-Google-Smtp-Source: AGHT+IFbPXU3zDa6Nv7lbbOLmfRiAoKCq5JdGSXtvDEmWqm2sBns3u756G8jyN6scjzj+X8CDPqM/WuFcdh1WtN1koM=
X-Received: by 2002:a17:906:2932:b0:9b5:f25d:9261 with SMTP id
 v18-20020a170906293200b009b5f25d9261mr599343ejd.22.1696209723720; Sun, 01 Oct
 2023 18:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
 <20230926094124.7024-14-maxim.uvarov@linaro.org>
In-Reply-To: <20230926094124.7024-14-maxim.uvarov@linaro.org>
From: Simon Glass <sjg@google.com>
Date: Sun, 1 Oct 2023 19:17:47 -0600
Message-ID: <CAPnjgZ12frN7PnGNndTSi3Pm5gm7MEeOBPnd2ijsoNbDTC10aA@mail.gmail.com>
Subject: Re: [PATCHv10 13/15] net/lwip: connection between cmd and lwip apps
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org, 
 joe.hershberger@ni.com, rfried.dev@gmail.com, trini@konsulko.com, 
 goldsimon@gmx.de
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

On Tue, 26 Sept 2023 at 03:45, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> ---
>  cmd/Makefile   |   1 +
>  cmd/net-lwip.c | 286 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 287 insertions(+)
>  create mode 100644 cmd/net-lwip.c
>

Reviewed-by: Simon Glass <sjg@chromium.org>
