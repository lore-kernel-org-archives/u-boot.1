Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6173ED3C538
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 23:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C8728916B;
	Fri, 18 Oct 2024 01:12:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LUDSw3l7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 323F1890FE; Fri, 18 Oct 2024 01:12:12 +0200 (CEST)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2992588DD1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 01:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6cb97afcec9so9943726d6.2
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 16:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729206729; x=1729811529; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ardNeTEgIvzXJBnNREOQjfHl8tNZay8bWJfowOCIIyw=;
 b=LUDSw3l7hXsWbhYbrJP31Aaz+Xz/07JMqnxQFeYIZJso2NhlcFmVpzKPpuJJPhIkeO
 KsV4Ev4XeaKuW41ybdfSaba/MBarv2coGW62NyZvQSn5bwueKsPyrJufEOyNN9zFdflC
 5KYnusFeZexA6O4ViT9E+CA9CK3XElo9bUsbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729206729; x=1729811529;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ardNeTEgIvzXJBnNREOQjfHl8tNZay8bWJfowOCIIyw=;
 b=h1COUq/hpPLubh1p+3+BVpCXnH7mP4JOOmXeDnfDG+k2qD9HOnoZ/cE5HBSZo78tLh
 CPIKLg+nApvTCLME8x8oERZTTz8y8CHB0AY9itZW6DJqN1J8ZxpTAoVxPOZL2lGlirV6
 rf9uXEOCN73IOy1NGTfhaiyokO/zOID+l+EDwP+oYxqPMvkkWZyBU0y+jf+fFTwyRbQ4
 ppBfyCSmNE3zDN8xsEx8J9mPY1DblKuNWp+B0Tk4cBijYF0DoCSVcxa2Bzhq/EO30A5y
 CQgN5j49Un70UTECj6eQ3Bc2duigAVU71M+bYkIcCNaIRfugr35c7eRA9Pmg5JhRQyjr
 9oOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT3M5FxXQYCsx9WVQ5sxkmWENjF88/Ig4xyQKVJRcJLLrLjciRYlVW9f+QJk19qMOcbzxgd8E=@lists.denx.de
X-Gm-Message-State: AOJu0YziFnQynG8uqy8hdNbLcEU9JWPMWkjEA48MPpk1qklxjYv0bO+0
 zimAikD4IneXcqsPsapJoEIbtvJRa9tFGJWLHhOtkpQxdL0c3hXmyvUqqkh+TmwJYLbYXFN3Wj/
 RLG2+weH4q+aFgFU1VFCA3yeyRuoNOC5H8nqYxPesuDcEDlc=
X-Google-Smtp-Source: AGHT+IEFRcTMhzDGEvzEe3+RXMCrE7ntaa+FTKDiOeU5U7fez7lCyNy78LYbl8HUgzN7GnQ3OxAki6kdEecpWAArM2g=
X-Received: by 2002:a05:6214:4607:b0:6c3:6c66:af6e with SMTP id
 6a1803df08f44-6cde162cf73mr7630366d6.47.1729206729013; Thu, 17 Oct 2024
 16:12:09 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Oct 2024 16:12:08 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20240828201355.1111764-2-sjg@chromium.org>
References: <20240828201355.1111764-2-sjg@chromium.org>
 <20240828201355.1111764-1-sjg@chromium.org>
Date: Thu, 17 Oct 2024 16:12:08 -0700
X-Google-Sender-Auth: gkRwzZURdWU7crczLubEy7xZYMg
Message-ID: <CAFLszTjk+LtGFUBb-Xgn_QX-W-QP+yCJ+E1C=V04VGcpi0mVng@mail.gmail.com>
Subject: Re: [PATCH 2/3] x86: coreboot: Add timestamps from coreboot to
 bootstage
To: Simon Glass <sjg@chromium.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Bin Meng <bmeng.cn@gmail.com>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Receiving timestamps from coreboot was unceremoniously dropped some time
ago. Add it back.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 8ad01ce36f7 ("x86: Remove x86 specific GD flags as they are...")
---

 arch/x86/cpu/coreboot/coreboot.c | 2 ++
 1 file changed, 2 insertions(+)

Applied to u-boot-dm, thanks!
