Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB2ACDE03D
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E53E188F3E;
	Fri, 27 Sep 2024 00:07:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ASQHnLVC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DF9B88F3E; Fri, 27 Sep 2024 00:07:36 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C33588F64
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e0894f1b14so1172009a91.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388448; x=1727993248; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9COQ0OFtpm+G8tOfqEa4U2ZjgD/J7rY4jyfFR4DQaKE=;
 b=ASQHnLVCFiSeodleuc5CDkNVQWjdzoSQff43OkTD2jq8XubWzVN8I/X/co6lFugE8N
 ZoLo3cPYcBUMXnkctFgrBeOQVvehGX/8rqyJnwQz4AwiiNeEwq1FfJIkZuR3DvzvmG7v
 zaOqQ/yd6CN1a874Cy7g27nT1Cq+DDRmOn5gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388448; x=1727993248;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9COQ0OFtpm+G8tOfqEa4U2ZjgD/J7rY4jyfFR4DQaKE=;
 b=xQRRi8F6dWr6GrNe21DFsm6R4ZoQedFRd4Zc5OYCmTRFFu2Hnte9Tx3xN2M/CkMOXC
 VSwS6joEEazrB7c8g42GFj8jAQGbBaUdzuivujZi/Nh+OFml/mAfF1KLNApFfH+iNUu1
 /1tZlCFjv2j8NdxaQsSGKqQNUdNkiRbPOFeatpt/qJbmgfNA5P8DH1iPsXBiSTKq2S3e
 KJWGq7sh6L1d7vP3PutdD/pPzuuxNfen5P3BhQJtL284jSNaRjNqBnzJtkSQB0DY6/kq
 dPtG+fgeh6U5cwlSbxXR7KRbAujW7GV5P5P8x5J23zNNsv31xhOVlc2jbEDQPp7IS2k5
 kCOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuAIWG3pEwACSnOnPxyGuOArLSikrsQ1KuGrXZ4kyjwf0yWrtU8JDAuDL1lk2br7djO4CBJzs=@lists.denx.de
X-Gm-Message-State: AOJu0YxYdr/T10dniuzChGF3CL5iwU0Q/Ef/11oy9IpnQ2D2QwQkRNsu
 9o1WdsjOwZ7EmY4Wg0U3cXswCduyHQbXY4iqCcmgVQ9RLu4nB1XTeVEoZutohEZ9xm449P8xTDC
 Xln+LFJ/ZBrS/2/ZPNG93HxA+azU6nwZRctqIpPCmkMXQdhHzNad8Lhg=
X-Google-Smtp-Source: AGHT+IFaK+NJkfKz5rdfey47TFNMzaHqQ9dtFhd6u8H2ZeDnET9kIyC1nMp2IKQdKyvaEpWwQVc4Cw7ml41RxhXzrlk=
X-Received: by 2002:a17:90b:2344:b0:2d8:9253:dffc with SMTP id
 98e67ed59e1d1-2e0b8b16d36mr1325170a91.19.1727388448635; Thu, 26 Sep 2024
 15:07:28 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 26 Sep 2024 15:07:27 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240826191143.426387-8-sjg@chromium.org>
References: <20240826191143.426387-8-sjg@chromium.org>
 <20240826191143.426387-1-sjg@chromium.org>
Date: Thu, 26 Sep 2024 15:07:27 -0700
X-Google-Sender-Auth: B73fn2erRHftuzzyESZyqoUfDCk
Message-ID: <CAFLszTjo0NrcmtHtM4d2bvKYge=ApO-K-qZBq1y6LfafnYkypA@mail.gmail.com>
Subject: Re: [PATCH 07/15] binman: fit: Avoid assuming that a FIT member is a
 section
To: Simon Glass <sjg@chromium.org>
Cc: Lukasz Majewski <lukma@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Use the more generic variable name 'entry' to avoid confusion.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 tools/binman/etype/fit.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Applied to u-boot-dm/next, thanks!
