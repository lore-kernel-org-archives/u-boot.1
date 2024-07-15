Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3C2C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:33:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 121F3888E4;
	Mon, 15 Jul 2024 15:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cjXcvwS0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 122E48890D; Mon, 15 Jul 2024 15:31:40 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0078C888CF
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7044c085338so2625798a34.2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050297; x=1721655097; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WKOL/nEV67Wt0PSoQgaxfgEZIjaxBIKMolOs6kjMn5A=;
 b=cjXcvwS04Stlb5qjvY/su8RC+fEtqvUwCLzSV9wLuS4tbG51ibTJPtmWRBgHLRRSQ5
 +4fX3Hq8N2iSZktGmRNbs9pBVSHQ+cnOD3K1AIDgGxtGmFJneERWsde0X3YlPbf85sq8
 9cKw98cDovoyoXySn6hd3RbeeMdeys7G+zJYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050297; x=1721655097;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WKOL/nEV67Wt0PSoQgaxfgEZIjaxBIKMolOs6kjMn5A=;
 b=dzKrAC6XBFzgL7R3NZCupgmo8CxfEKNi50fvUNeq4O+62qZONZWGYLR9mi1QTMtlJk
 kPr13BbhQSfQZenR2Mcd1geWMZfFJw0AaRejNsM6lxEOLgxwJG3x9R+8dcZGMYJa4aOf
 RkK7HXKzuF0AaGgwdmE34zxfgrai42cwTE99Y5pFjwiO0DiethhMGktLe+ul7AtyVxEc
 VIPIw2g2zWjQ7AQTr3mQA/EKsep54640EcNNP9p+LB1qEyx9KOjYUWRQuTBm9NU0knh0
 M4k/qACfCt19ADsXxeNFy9URF7igN6IvWzJkq1KT+YwPX/I/vdxYwAe87ojbcFuAPt/U
 GsUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWc9nnVLjwETXd9I7puk9h8VvY5HgfrWB3HYvtYA8QFMchYKx52XQtxtYwRAIrnOp0yYPLatMEQAXOfG8QLIJpecmXNtg==
X-Gm-Message-State: AOJu0YzXvzpl4lsgvr/SdH7eIvddVX9U0k8gGr9rlEi6UxFsevgig2v3
 sHJblSojjtqWhMtfKygqC2of9fXUB8JRDHN8lXDH3W4uiZ+I+b9KWYH8F4f3tHzo9IgKDRX0WM/
 Yet11tRiX6/Y09USfZ75BbBFKswGKMbhLxLhY
X-Google-Smtp-Source: AGHT+IF0hxLIWUPQcLyvDTH5Mt43hSAAWQtoFZPcfT/+Rla3mkru6FkwQoDWig2gme3VLszLYG+mZnuSoJRHnXGWDUE=
X-Received: by 2002:a05:6830:19cf:b0:703:6cdf:461b with SMTP id
 46e09a7af769-703759faca1mr21907538a34.6.1721050296783; Mon, 15 Jul 2024
 06:31:36 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 06:31:36 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240623175515.1466908-7-sjg@chromium.org>
References: <20240623175515.1466908-7-sjg@chromium.org>
 <20240623175515.1466908-1-sjg@chromium.org>
Date: Mon, 15 Jul 2024 06:31:36 -0700
X-Google-Sender-Auth: y_dvVQE225eogSmnRlC9F-rvhiI
Message-ID: <CAFLszTj5n7d-2h=hoGgcRRj41o+ZzjUsDM0VSJkRzgg5DsLCeA@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] binman: Make Intel ME default to position 0x1000
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
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

This cannot ever go at offset 0 since the descriptor is there. Use a
better offset for the ME, as used by link and coral, for example.

This matters when we start using assumed sizes for missing blobs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/binman/etype/intel_descriptor.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Applied to u-boot-dm, thanks!
