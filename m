Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1184AC4706F
	for <u-boot@archiver.kernel.org>; Mon,  1 Jan 2024 16:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71E04878F5;
	Mon,  1 Jan 2024 17:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PXRe1j5c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8900A878F5; Mon,  1 Jan 2024 17:53:25 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66AC287906
 for <u-boot@lists.denx.de>; Mon,  1 Jan 2024 17:53:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-67f8d9fe99fso69479676d6.2
 for <u-boot@lists.denx.de>; Mon, 01 Jan 2024 08:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704128001; x=1704732801; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M9UD3Sf52W+hlj46/TlUKmvFoYJmEUfMj6tXezCpSYE=;
 b=PXRe1j5c0jbXLB9UEpTPXfcO2J6MIlLW1qEuf88BtQguUWuhrUbE7JeqK6etNbxLHE
 UmtnZWYzqWqKXTtqRmNN9KyxwPqiA0cm2HZT5txvUv5vSSdutMMQ6HoYfLUPDvHlHIi0
 pRtdThmHCdCMwwlmtrTKVT4LYZqIdXQIltkqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704128001; x=1704732801;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M9UD3Sf52W+hlj46/TlUKmvFoYJmEUfMj6tXezCpSYE=;
 b=NO3kZXoAVv9tbnNhcy+4S00T24gi3kNwXcolyVs9z4jIjG4xuZ7wLePcY28Py+Or2h
 AcF/i64++RiHsFNy5Oj9m3zlzKAfD+g2780z6Z85IfWPLX2UrTJYIH2RHzfKBDNfHP9q
 Y0NSSxHnq5coidlage/Wq7ADsBZTu8CLj0XAzQA2Pv+5TH2AZVBOue0C1P6XulHK3wVQ
 TB0C8mEdtoOXgNxlNR50WHkTxvvntxap3KNKZ/ul9GLBvySIV1Hx7hueRddY4/JZntXu
 7U2JLd4/WYA5wV4GpV05jZcIDBsMAksgTmHD4aa5YtJmDNd94Sv0rAnPN8DUX+m7Aape
 DIow==
X-Gm-Message-State: AOJu0YzpxtKuyXubCUTVT5/q5trbLz004VSp5fa4mIH7thqeCOaPLW1f
 SW0szOqasgc2TiVVKr3sfgp8dUbJe2GT8l6JwHwSq8rkURnY
X-Google-Smtp-Source: AGHT+IGfVD6cXbofHKv6Vuaoz85fma2p2JitzX0TJiyzhmOIu4BZkN2hu18GlvRTPH5b2v/F6rwYjuuKAePzqdjrMwg=
X-Received: by 2002:ad4:42b0:0:b0:67f:940a:ed1c with SMTP id
 e16-20020ad442b0000000b0067f940aed1cmr18580431qvr.66.1704128001318; Mon, 01
 Jan 2024 08:53:21 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jan 2024 11:53:20 -0500
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231229174244.892818-6-raymond.mao@linaro.org>
References: <20231229174244.892818-6-raymond.mao@linaro.org>
 <20231229174244.892818-1-raymond.mao@linaro.org>
Date: Mon, 1 Jan 2024 11:53:20 -0500
X-Google-Sender-Auth: sH2EAqxZNNU5UZcOecrAuevqBu0
Message-ID: <CAFLszTidvuRRBtSXjpKhhq7MCNbo+1bduAqLdw9sRqoSKeeN=Q@mail.gmail.com>
Subject: Re: [PATCH v5 05/11] bloblist: Access record hdr_size and tag via a
 function
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 u-boot@lists.denx.de, 
 ilias.apalodimas@linaro.org, sjg@chromium.org, jwerner@chromium.org
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

From: Simon Glass <sjg@chromium.org>

Convert accesses to tag and hdr_size via function for grouping tag and
hdr_size together later.

Signed-off-by: Simon Glass <sjg@chromium.org>
Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes in v3
- Update commit message.

 common/bloblist.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

Applied to u-boot-dm/next, thanks!
