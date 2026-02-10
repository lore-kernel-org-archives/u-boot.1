Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CB3EA812B
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 15:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A40883CBD;
	Tue, 10 Feb 2026 16:09:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VKZ5tunA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D50F83CE3; Tue, 10 Feb 2026 16:09:32 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 027BF83CB5
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 16:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-59b834e3d64so4825951e87.2
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 07:09:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770736169; cv=none;
 d=google.com; s=arc-20240605;
 b=WX8BpFbN9h83thsYAjpbDLwZRZCFH4WItyXNRqKSETnBYEZqwf3FUkwhtoqgrJTRq6
 uQiNSfOTY0fRZSeqbxD5Ne4IkF0pj9oeIE2cID4mJ/0/4sYmisURgVSna6wMXn7eRqdQ
 LUeKgYAKY6m+eEndX6pIEj9mPxlBxhw2JBolW8VFJkLW0v90FNPjCWosw9Co+COfS6jX
 +WTC98fJyTFTlV27Zry3IKDVJhadQFBXJhOE1BWZQXGLTJ4/bFK0MstS+XpDZgIR8yDy
 +8VqPgWDYo9NArzpm3BetkwQMgKWeksaGTq3e+Pb8dZ6Kg9HZOJVapF9Hnc7QtozbXkp
 zz8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RdARmp6ZJDCZUrxSaPxPEfEibbrQlgA6gcdXOGOWLxg=;
 fh=nE9eekRp8ySHaPxDnRnDpltNUhJDlsc9BYrsyJx/vD0=;
 b=RAlAIjapuIi9LyYv13+0kX+4XO/VsIfrx9rmMfgju8j6aJy358vZcgZVpMoSvXZBks
 gTP74uswDFZHX/qQeaok46QD9Zv/BrwlXFrLl5EUBsOSU1ccnQB5m9krHQVa+iOlUOpN
 /Y/5iVf/XV5tQUuDUR6lrxMlTHl+68Fua7rk5TwIqQCOL4OhmTARPv7F+GBxl0LtGht8
 gAzddjMtBxhV4Ccu71XiQLNopciQx9GhYleB0tGKyy3HfRMlRBIfM4pjZkoYwswbHBKQ
 ARsysLjj/6LNBtlukPqwws7QMC+Jw8cFx2nyP3co4XELtsTs/w0v4T511KzY1Ogwy2de
 dffg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770736169; x=1771340969; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RdARmp6ZJDCZUrxSaPxPEfEibbrQlgA6gcdXOGOWLxg=;
 b=VKZ5tunADULHIIIMFu6++THLUddz2cLjfP8YQFTfUbx+8Xfe+n12ae9imVllKQzF6T
 mkGrtMKU68MLn/YieSFD6TSMQk1uKHUPGeo8dIJCcMIxcmKKsX/tbEqU7RFWEYuRuH5r
 IMMmywPg8sc8pa3SdnrbCloC84vlV5yIgOcjUt7ushWm77JdZruzc3JJLuQ7xgi38HZF
 E7AJ+2AeIUS5i6f9RS0GYbd3r9q8XGIctK3eea16NpLYCHMyyd8ym3+SqCfIHlsCuhLr
 RQgHI0fqjR+oaohW3M+Z6Ded81eKzHf549YL3F6fZeHYqLUpdFwtRE5DXm0qJE7FKm2q
 DAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770736169; x=1771340969;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RdARmp6ZJDCZUrxSaPxPEfEibbrQlgA6gcdXOGOWLxg=;
 b=MdivC29o4UZTO9+nY8xB0D9djGoQZ5bCZZzwuVaEyv1dqN6qRl+BhVaAuzv3E40/pz
 wCX3QE7SUD+ykGXfNzTGaaTHYj0UxmEFvOixprWpzC7FqTISRLPH/Jmw3kEyz9zqTzgs
 Ug7D18mi7NiMAl19LXH8B7yvtpdyDdfx0vEqmvRs8Zl7rs+7mJg3HdEMk/S/+pPVbnrv
 eKUIqYb1fBHq9bHG5SMbuDMO0eJI42/AKovTPyzsvbqptIMt/CgM/XTzQU9ZZBZT+MeH
 iTSYvK4gjlvQRvrjH/nKIg0fKnfoP7Xq7pZYcYDf3MxQeSJIIZPYjXBIKgKJ5dU88ZjA
 dJBQ==
X-Gm-Message-State: AOJu0Yyr7tIktPBxMpjDCmxTyw/K2ry/REE+seUQ6GxXOjzaZ6fONWwy
 DCLFJbkTkGh0nLWvz4En/j/hh7Ff3L0JJFEL4mx/rCM0xTpneDSpDaBJizEQzLFzmnH0bNwiMyE
 dBrmYibCCX+Q02neNnoQioP18c/rSjGA=
X-Gm-Gg: AZuq6aIcZJCRCPtvNSQGkWQG1P0DyVOji7TMbU+10nuH0fnK/4dBKefZ8FwYxgDc4tz
 /dnLF44BCUHXYUqYkaze6U9fPaIa2frGFFffIL0dmEbjDAL2Dr0qUktoayVonsTtwaH+e+vCmkg
 JiEOiuYqS+qqdcD45+9HQCght1da18Rt+QSKjUCgMZJdDFFVTA6g0oqqtlR6mYPie0Fyfi2WVjN
 oxmULOaKtTe2TFelnhsrV8Yo2ch3ManAemOC+QFztHdQl8SjHqkbP2KB78RPI2Np5PawzLL+g7J
 DZGygkpMcZZRt32Slbil047UR3Ns1IGdCdXosxbSaFA3xY5hyA==
X-Received: by 2002:ac2:4bd3:0:b0:59e:49c3:9f8e with SMTP id
 2adb3069b0e04-59e49c3a027mr3346487e87.0.1770736168724; Tue, 10 Feb 2026
 07:09:28 -0800 (PST)
MIME-Version: 1.0
References: <20260210090029.728636-1-brian.ruley@gehealthcare.com>
 <20260210090029.728636-3-brian.ruley@gehealthcare.com>
In-Reply-To: <20260210090029.728636-3-brian.ruley@gehealthcare.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 10 Feb 2026 12:09:17 -0300
X-Gm-Features: AZwV_QhbapHIt7Hdny349KxIsYcFqOiFxSNEbvFdaBBIWpqNKmRCyJRY5Xjm9Wg
Message-ID: <CAOMZO5BF-jfjunxhW2_9ZF+r-c1GE2UvEBqeg9ruKutAW3H4ig@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] clk: imx6q: apply clang-format
To: Brian Ruley <brian.ruley@gehealthcare.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>,
 Mark Jonas <mark.jonas@de.bosch.com>, 
 Peng Fan <peng.fan@nxp.com>, Ricardo Simoes <ricardo.simoes@pt.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Feb 10, 2026 at 9:49=E2=80=AFAM Brian Ruley
<brian.ruley@gehealthcare.com> wrote:
>
> Conform with U-boot guidelines.

Which guidelines? Please explain.

I don't see any improvements made by this patch, sorry.
