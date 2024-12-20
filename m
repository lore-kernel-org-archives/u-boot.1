Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B4EE7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6500880517;
	Fri, 20 Dec 2024 05:05:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="akxQDQvS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73E3D8037B; Fri, 20 Dec 2024 05:05:54 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8411380087
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa67ac42819so215652566b.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667552; x=1735272352; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HXhNMbBTj7seCNeqmQ0NhnJt/LG5iT9hzp2nmC7zjNY=;
 b=akxQDQvSPQtKa2yBuuFkJeE5znBl4y69EDA1SGdqb7FC0uoTkzi1124y+/JJ+AVCdg
 eOQefIm7neysXwsfOiA69BcKWYF9+T5u6z8R7goV4U4ietUygqxcgpCVgWl+Ra/FdcLA
 qmMSbDlxITRm76VYn2PaynyslMP+fAlzhxxuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667552; x=1735272352;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HXhNMbBTj7seCNeqmQ0NhnJt/LG5iT9hzp2nmC7zjNY=;
 b=mLZWcvqcRHfjyMbQcof2X1sFgqATeIEXUKhW2nJZE99HFVW1XhK5/WjdkpEerubZjv
 1q9NTu6ACwcSLH9PcyShSET7dqPx5sumDg16m55c0RzfBMtMZZ0FCUE3GTAtzX7pKrdR
 mfzk4LQ1w2ax1zZ/a7seIEyX1/I7YEJ5Qa3mHJ0iELdJ7YEzeuYyzKrvng3qi8Bv6S+9
 nwt77+rAdvVcfLEWJZr3qYKdt4HCIWzGjkD/OJdEXGa1rPTf2zx3JnzkAxnX2USWZDpn
 6T7OgWRSTu7TyV3dUBhTonqg6xkQ8/XV863+xijhopRUkhrQopl/FuP0uRlaw8ccncBN
 r8Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCtVjTwf9wOlIK4eCPb9qYCBwnEVZyRNM0P2olN96W8VX6EQo9RJfRH6sIbCumRC/z2q1i+eA=@lists.denx.de
X-Gm-Message-State: AOJu0YwM9J4uYs7uNbijGu0IhiwRsVnS31TX1GoAwfz6go9SlJGZ0tqW
 7LTLqKyBQemFBxOzDNlRJlfgbmu59vT3v+kXIc/kSlB9Wp9OgmtGPOpXd258RqxcGO2uhgYWPQp
 PUcWmEM5PZzt58at7jm4KN/5F1b4BPLm6RrlY
X-Gm-Gg: ASbGnctGxJ145Wv9wXlQ8Fcuwn3Ert/DRX452QfChsTo2CQyp1n53YjbRhQfKjZJ/+f
 ojzsoEWH1UakdDnYWWIvtR+o7iz9L6qPnmQvGXK4=
X-Google-Smtp-Source: AGHT+IH++rkCIra0PNNgz6CyFMKKy/TVE7M1mv0QwTbB84EZ5AL7Wmz5t+QG+X+GLfhYhoqqKE1XB/ytbV9XrtJrqQE=
X-Received: by 2002:a17:906:c14b:b0:aa6:6c6b:15fd with SMTP id
 a640c23a62f3a-aac2ad9ae60mr101211866b.20.1734667551971; Thu, 19 Dec 2024
 20:05:51 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Dec 2024 20:05:50 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241206023626.2456858-27-sjg@chromium.org>
References: <20241206023626.2456858-27-sjg@chromium.org>
 <20241206023626.2456858-1-sjg@chromium.org>
Date: Thu, 19 Dec 2024 20:05:50 -0800
X-Google-Sender-Auth: Pa6a6PBp6ZqX_-N_4b8LmDDfpjQ
Message-ID: <CAFLszTjwzsaUtXYp5mS9jzkgSDL659wbk+rN9wJXeSnqX5M-oA@mail.gmail.com>
Subject: Re: [PATCH v3 26/46] net: Return the size from parse_args()
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Adriano Cordova <adrianox@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
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

Rather than setting global variables, return the size, if provided. For
tftput, use the addr argument to store the save address, to avoid adding
yet another parameter.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/net.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

Applied to sjg/master, thanks!
