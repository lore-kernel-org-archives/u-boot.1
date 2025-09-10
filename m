Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB51CA101F
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 18:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7A7B83257;
	Wed, 10 Sep 2025 20:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="eRUu53Q8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69E4683280; Wed, 10 Sep 2025 20:16:42 +0200 (CEST)
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com
 [IPv6:2001:41d0:203:375::ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21E53830A0
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 20:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1757528199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ktDaQ0zEOqqj0mfKFlDKjRwTrApHE4GRhwsRilOv1A=;
 b=eRUu53Q8GJlP01iTB1bZmcTNbtuMVP02IkAqqAxGy34CxQNp8ZYiZsqYkf99Pq5/6ali7z
 vOCgMSE0F/SY80bcRCrYLVIy2hWrahd1haAuPhWrG+qxgSUPTaBHDFHGS5S9doZq2XWlOP
 YZynJy0IDlJfSvEXcwMkVyGYrcvhLPNf0esa/HDClJTnT/zS8fyDzI051ofxm2So1V/m1O
 l2HIJymZj/x+G3Cc0OVVxl7Mq1am7BJ8sXw7ApJFfMP2gThJW2aOJnMJ4pSIYmMCPxrtMF
 KxBJ2onpOp7KalLytay+/TIJ06TLTr7d8nC9gy+m0DaOuvlINoe2w8XD53+Uww==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 18:16:36 +0000
Message-Id: <DCPBQZ6RDQXO.3QXVYRR2IMJGT@postmarketos.org>
Cc: "Jonas Karlman" <jonas@kwiboo.se>, "Simon Glass" <sjg@chromium.org>,
 <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <~postmarketos/upstreaming@lists.sr.ht>
Subject: Re: [PATCH RFC 0/9] initial U-Boot SPL support on Amlogic GX SoCs
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
To: "Ferass El Hafidi" <funderscore@postmarketos.org>, "Tom Rini"
 <trini@konsulko.com>, "Neil Armstrong" <neil.armstrong@linaro.org>, "Peng
 Fan" <peng.fan@nxp.com>, "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Beniamino Galvani" <b.galvani@gmail.com>
References: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
In-Reply-To: <20250907-spl-gx-v1-0-37395d9ff5af@postmarketos.org>
X-Migadu-Flow: FLOW_OUT
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

Hi,

On Sun Sep 7, 2025 at 2:36 PM UTC, Ferass El Hafidi wrote:
> This RFC/RFT patch series adds support for U-Boot SPL booting on Amlogic
> GX SoCs, replacing the historical "bl2.bin" binary that runs as BL2 on
> these boards.

Superseded by v2: https://lore.kernel.org/all/20250910-spl-gx-v2-0-8f52aac4=
7e04@postmarketos.org/T/#t

Thanks.
