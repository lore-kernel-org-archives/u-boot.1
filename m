Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EBCC44501
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 12:17:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D72B84D00;
	Tue, 14 Jul 2026 14:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M6U+GIv+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13D3384D02; Tue, 14 Jul 2026 14:17:16 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF8F984CEB
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 14:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-69531108f25so6922004a12.2
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 05:17:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784031433; cv=none;
 d=google.com; s=arc-20260327;
 b=lO1Djpz1iAxhShNbP7qvAMembuuIvHy8hqpqe7v7KAP61P3f87cbyODFVt5g3oHGSo
 RhasrMRnCdbqILzQ2x9aQcgPNPVh0aS8TQjaC/nAyoggTXjLyJGBIsC2HtT6+rva5Xav
 9y7Ky+NxbRHqT/j2OrN9POTQvjKBTPPP5Gg4e+vBAfyvimWc8eZOWhfkGVce4V79L26/
 VbWGg5ckpcseOwuyOrreh9xN5oE93X20PrqepbzfMkljWt5t9ZclZirP/+R6oR1nCZaI
 uAPkcmjKSpOFafUHdYxcV0n6Uphae5Pi3YWrriAwcMoWMV0ChnBZu3CeSABer0Vx8MNS
 1CHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5nWLEjwESLDw6qhVG+Sn7kr73d0th++kRpXtfvCXUOU=;
 fh=j7zCQFIVY/wqwMBEyy9uxzmSL3MOH7Be1CJiFaVemiY=;
 b=qrASNd/Gvu2/1k6URpuJdbHXcYwN+0+cMjYPrZNx2OOdjDCziK9mxx5ZDZUfUjtgaG
 Cm7Cw8N3gm7pNVsPDI2R6p0S7Pnnn/Vyumt/57LKSaao3VfTaldXylsdwTskiZGiQTmo
 jVMFst1XGBJum1b0cwy1hWYwFF2n1R/6PoTpqh8ms4B52+eTottRZaxGO9iTl5jzT4ik
 OKyrGpvH99TEB3shUar7wPwXwnlVzM9vcRz4Nf30GAPqItZ562JHNcQBBoM/W9KBb+De
 tH8A+djiJLTTg90x1soF4Un6znpBeTII2taa+Fbc3NqNvXhIuwjfFIDzAkETmZqYp6xe
 RRGw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784031433; x=1784636233; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5nWLEjwESLDw6qhVG+Sn7kr73d0th++kRpXtfvCXUOU=;
 b=M6U+GIv+rqP/dPMBohUyil/MuKpwIm9f6pF+ESPDSoWf8QS7yCQGT6qtMCBNJOqv18
 +6mPdHSbZb66FZGMxvgB8jsPn0dVJjAxot1ljEDNQTc0YAxKiyvliL9er5crcx1W1c3S
 bMQh2AtoQgaZEjQxN5UC8/jCU8sVKULbBIvnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784031433; x=1784636233;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5nWLEjwESLDw6qhVG+Sn7kr73d0th++kRpXtfvCXUOU=;
 b=ib0hL4LPGrgAmiTyCI3h1Kjwm9dY8V8MPrr4b4k6XCDbNB3G22bjdXePAe1QxDrzHT
 bt+k53i/1KJZ6CQFc/BL+pO4noGVMmVhcNIoz2l++YRDNOPz2y7A7Y9xbCilayd2rl0R
 wCrdmpZcfK8RMqfcoR+OSCA4Ih8TzNO7CtCRh6hRZfIFvyxLN/W3SRBD0BUW6e7uCy8D
 a66PTU0h4ZvcI5kr7sMUFV4i1JQwiFxt9vqdDC5AmVeIpjNUnBQP9InvF2Ik2FKjpt9J
 CPhio6Ijzyc8n/fhkXajofblzdlVyD2WsV5gvdS/W0thdoFl+s54IQYNLLDyoVBPU1jN
 PaWg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoQlNzrCnAbxue0IQYmG/PVXGyqSHb3SGQ7buTjZ7iLT4JiIiMps7ijdIoNd6d3HBRmofeU/bg=@lists.denx.de
X-Gm-Message-State: AOJu0YxXDEq262XRzoWIZIIK7G4ZQMsM1YZRbfp3PwotnucnWiNd6f//
 VraeLi/6dvP9kVVid4RJZFiye91hr7Q6sy2aHAOITYmNmifjm7aOejB5lYRpfuLjgwo3/tZv0HJ
 QhktG4WqfxLVRu40PRK9CPeRQafPEg4ZFSPxzck6f
X-Gm-Gg: AfdE7cmwsb3P2nxGFMai9SG+MQ3AmwjEO/P/U6ZPU/J33fq5x6tidoqqzmSqjAgqGRk
 /NhhFBrZWuzh18vwqz3Om3pVa4ksfs+z1sMeEa3+63jvHSP/Q3d/HRt7y+XSv5h+nYFKYHhtz1/
 CT6cx+ZMBRf0IoU5WWT4Q1bJlLL88dzlshUtmZepNYgmp27s2J7NslCb971P41ZPHyn/F2bd0Gp
 IwUKXg1RrVYyMJ/Ak5X8k6J7EzJvYNPuxHw1hlLKAEJ3l/sJbc9/e49XDa0djKHwwNEjkc=
X-Received: by 2002:a05:6402:2691:b0:698:76b8:e552 with SMTP id
 4fb4d7f45d1cf-69c5f0c77c7mr6183771a12.2.1784031433076; Tue, 14 Jul 2026
 05:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1783816074.git.daniel@makrotopia.org>
 <d460c0571dee7cd852267d881938d6c3d2caf300.1783816074.git.daniel@makrotopia.org>
In-Reply-To: <d460c0571dee7cd852267d881938d6c3d2caf300.1783816074.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 14 Jul 2026 06:17:00 -0600
X-Gm-Features: AUfX_mwfZhyD2o9S0WsjtDKDypSobRfoq2GYNSOKkOxOtH8N17MFYlH1mv2r0Gg
Message-ID: <CAFLszThiDJ8-uO_nBHc41XKDY65msUxscL8VdCEkvBpCKn01Yw@mail.gmail.com>
Subject: Re: [PATCH 1/3] boot: fit: factor out node-path collection in
 fit_config_add_hash()
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>, Anton Ivanov <anton@binarly.io>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Randolph Sapp <rs@ti.com>, Francois Berder <fberder@outlook.fr>,
 u-boot@lists.denx.de
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

On 2026-07-12T00:33:05, Daniel Golle <daniel@makrotopia.org> wrote:
> boot: fit: factor out node-path collection in fit_config_add_hash()
>
> fit_config_add_hash() repeats the same sequence to append a node's path
> to the hashed-node list three times: for the image node, for each hash
> subnode and for the cipher subnode. Extract it into a helper,
> fit_config_add_node(), with no functional change.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> boot/image-fit-sig.c | 73 +++++++++++++++++++++++++++++++---------------------
>  1 file changed, 44 insertions(+), 29 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
