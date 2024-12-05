Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB3AE77170
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 19:57:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6059689579;
	Thu,  5 Dec 2024 20:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U6O27ige";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92BC189578; Thu,  5 Dec 2024 20:55:53 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA3078956C
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 20:55:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa543c4db92so265145366b.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 11:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733428551; x=1734033351; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wYXkD1rQqdF2oo59omc2DXcxeO0PWysudXoTEgElMdM=;
 b=U6O27igey8NQhfDwlWuCYizUMDVpefuQc6Ea6KU4M90nzWcVW5aJgY0FUWRg1xCNwq
 b/obYsBCiIojzBPVfZWsOMPTdcwUJqaQ2725/fnCeLe8/TwqnhRSyzTX7LVH4XDq0Tn2
 +0lS9vkSP5Vgk/xj0kV6iKM+zQzjuaVWWVbNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428551; x=1734033351;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wYXkD1rQqdF2oo59omc2DXcxeO0PWysudXoTEgElMdM=;
 b=rwmLihNylwq1Q7IMxiVn3zDH1AZ46Nwx3obHStJ0/AfwBj63/jzwUsNiAEn8ZdWo9E
 lHqe2WJl8wIE9p2McakyVS68lCGBEaMsFMKXbKKWJChpg6qXzdTOjINL26c+JJ+f6HHQ
 wd9ex25CD761drbm3uW8AD4brJJl0Q0vWmKJlehiGHAT1dZmLKGA1GEmu/aV0suI8rrd
 kF7jq/vFd/xGIPMt/Z1ic/8pocUZFwFlWwQks6Y9R34IBWLdbR4gG9SOenFkgKG/GbXe
 jXjhslOYyxOwuYHMZ7ZVgBjfxqx78SaFTn36fAsmRtqtzW2km/1TN0+Fo0mw5v6qbJp3
 CWrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTnnaJxfAh1FElZfYe87q9hPC+m46ZJRTnTQg8Y9hkSti9GmfbAuIzodBfEP95yf4ogqinrv8=@lists.denx.de
X-Gm-Message-State: AOJu0YzHZFrUnHi1HQQmWruYLq/oIowKr71Z/jOX7vUKCQExXBYzFKne
 19jPwcIifOcaXQkYrqIKrLaSEySl973QlHRp5WRHCg23oOeEVUQJA6ssXXoYN07BPKLv7pqLo7a
 /XN7lfEwAVrHOLo5E1FD8qJQCqWdMCNBrFqszr4jH3fjYvEk=
X-Gm-Gg: ASbGncvTvNNmfY9RnG40+TXUaX7eyFiQ7KllMWoiOKYm7ZdCJWfgtyUWCRG2b8+MmYS
 CXg9YCAaUAVFE7AuOh0Z2uGGG6l2bPHB5
X-Google-Smtp-Source: AGHT+IGjEytKPkCxLwDuCbcyuATYWAmor+f750K75Y8VXIwPR73O6s3Aspl8E5+qmCLCba+E236ieQjKlF+kemb69hU=
X-Received: by 2002:a17:906:4c1:b0:aa5:1585:ebbf with SMTP id
 a640c23a62f3a-aa639ff68c7mr11912166b.21.1733428551209; Thu, 05 Dec 2024
 11:55:51 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Dec 2024 11:55:48 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241115231926.211999-12-sjg@chromium.org>
References: <20241115231926.211999-12-sjg@chromium.org>
 <20241115231926.211999-1-sjg@chromium.org>
Date: Thu, 5 Dec 2024 11:55:48 -0800
X-Google-Sender-Auth: kmUfD2qRPVhiTpDWZZJeW4aLYqU
Message-ID: <CAFLszTgjmehUXYk2GgMScip2X791zzZK3DqKyPXZKbuKrfFqjg@mail.gmail.com>
Subject: Re: [PATCH v4 11/19] bootmeth_efi: Check the filename-allocation in
 the network path
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>, 
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

If the filename cannot be set we should give up. Add the missing error
check.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Change the tag to bootmeth_efi

 boot/bootmeth_efi.c | 2 ++
 1 file changed, 2 insertions(+)

Applied to ci/master, thanks!
