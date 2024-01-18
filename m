Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BB3C47422
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 14:05:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E6BE87BA9;
	Thu, 18 Jan 2024 15:05:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="plslfhK6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B627E87BA2; Thu, 18 Jan 2024 15:05:19 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 182FF87B12
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 15:05:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-42a0454899dso20333531cf.0
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 06:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705586714; x=1706191514; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cNsF5uDYWniLEjc5rt4Ng52bAwtfXfOQVAqCssg03Pk=;
 b=plslfhK65N//TSPt5eq2Yh0Wqq8EzuqXRJ9iA8Bl57WE2sPrfym3OThccjsZq3evar
 tA6cDtms/qCvelMLSTVCjtofnw8Z6k1wEd33qRtPep0s9X1RGgX0DtXcFHUJ5nZvk7YE
 nSGUPjEG89WmPYcJ1OXOPKwpI3Tx8LxafGIp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705586714; x=1706191514;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cNsF5uDYWniLEjc5rt4Ng52bAwtfXfOQVAqCssg03Pk=;
 b=t+OFk408GgcXgmFc0pXXtVwHAllC9eBa63bZlv2Me/O13XG4UL9f/XYweFT0jTdlsZ
 o7jnBPth/WzZ/ykr/KKn5hC+pEJTMB+9cGrvQePPlBtFk6vm3zY585nYR0DteMjMd3EP
 i7DnmXu382KJeExgNV/rmudSPSFn4WS3bvvUPYimYvpBOoJl5EoejV4qffIMQg/L4sUk
 olggtoPOFFCbjazr1Ob8DO6kmstfaN78Sty94CFX4wWonBerminswk1xh2VuqtE7jcTN
 CBw72BQKzKI3GZlDVi9DJK1GGlhjjREYuZZm46aeruqmLtJ180vi5ilyhFG5GIisee+4
 QEmQ==
X-Gm-Message-State: AOJu0YwDHTWFWfFzxkYJkTLtm26WGio2S9MxL6A8eaYgjWU8xIbcldcI
 E5ANq0q6dCVuEqBwshLSlrY1BkltfbWAzzswXC8JF65nkNAe2Av+3wdv92PDAPB4eQaIX+p5JyQ
 Z
X-Google-Smtp-Source: AGHT+IFBnN6ywpt7LZxddVDxHndqnAaxUyjVE+uJ2i0qcQ9lpIKWys7GLN8EB5B4ycIoivNo4v1eoA==
X-Received: by 2002:a05:6214:2aa9:b0:681:8706:2e86 with SMTP id
 js9-20020a0562142aa900b0068187062e86mr870186qvb.70.1705586714535; 
 Thu, 18 Jan 2024 06:05:14 -0800 (PST)
Received: from [127.0.1.1]
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 mm21-20020a0562145e9500b006817fd532absm1246316qvb.82.2024.01.18.06.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:05:13 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20240117200654.1880463-1-trini@konsulko.com>
References: <20240117200654.1880463-1-trini@konsulko.com>
Subject: Re: [PATCH] test/py/requirements.txt: Update packaging requirement
Message-Id: <170558671366.2400148.10530326883332753306.b4-ty@konsulko.com>
Date: Thu, 18 Jan 2024 09:05:13 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
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

On Wed, 17 Jan 2024 15:06:54 -0500, Tom Rini wrote:

> Update packaging to be version 23.2 to match our Sphinx requirements.
> This will let us build a pip cache out of both of our requirements.txt
> files.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


