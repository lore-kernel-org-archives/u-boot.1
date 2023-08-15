Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05FDC001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 12:42:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D634586785;
	Tue, 15 Aug 2023 14:42:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pnJgfdC3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A590B8678A; Tue, 15 Aug 2023 14:42:28 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14EEA8676C
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 14:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99c353a395cso722474066b.2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 05:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692103345; x=1692708145;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OKULS+jGMth1WCVpwn5jn1aAW4X79nezJ3/dbHsWEhk=;
 b=pnJgfdC3Y/a9/oEqo0kQYs8WGsYVfXO6REw+Z+Qj+tn0D45C5ol9FGJndeaTL9Db6U
 mXN27aU8MCpzoxEHpuksN/jzpq1vD8xNOUykvJ4fpKz7kiN+XqATjYBG4RUlMw9OYEAM
 FiP1iLjMXIC55gfEsnNQ1oZJZI7hiD+KtO8VFsiC9zNCd7cXI+mmB/hStxgiMUuoieJ9
 +zbjnaek905+DXyqgnD18RscI0yVvSMHNO3QvMhIwOaPfFZO3C+sB/Vg2j0b6wGszcPb
 z2SgUl6mwdszZhDjgOW3u9wx46EUdrny3bfnTX+w7VOpIQJIJ7slKI1AT9bD5nYjLBgx
 1Bjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692103345; x=1692708145;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OKULS+jGMth1WCVpwn5jn1aAW4X79nezJ3/dbHsWEhk=;
 b=gXsTKrAM29gaoK8vEhVSvn1VcevrhTAeoao5rMha/ZmObqq7VXFokbrI07Yr64ShP1
 63BtklCuf9Jg4qcpB4CSlFrX6j0fuvOwIAmrXpYD7pkI9OnoITcnqL218WVloY6CWkl0
 kWseS9oOIo6KteQitpUPyOu4lN+VjRpxSie+DwmLLMYVTXZN7YpSNylPpXCcYihO/2dU
 skYlim1i9UDq24okA+x9Jxs4D1F2FJkqsPpx+RkgnQ3llzRbtBnLIbP3wRCNAq5Btrc7
 E5cPRM3rIYkVTeGNH+HvJaGoSo0Rex8McGqJVRFR1s7uCLk3HUlbAN92q2EdMd6UGS2C
 53mw==
X-Gm-Message-State: AOJu0Yzcr20DrQeF6RfrnPKjvEzfMnKqC8IKLW2whQ0iMkvvnR/yUTuZ
 ipAyhmBb6fnhaB+/9Zx0S44nsbr2OBTIlZvvRS+rxw==
X-Google-Smtp-Source: AGHT+IFzPLz8nmkSn4ecfadsyXVTG01NL3FMy7mV6JypGrI00FX8oXu7IpU7qDSfDArhbTa9SBQmYrQr/EohBlkMb60=
X-Received: by 2002:a17:907:2cd5:b0:99c:b0c9:4ec7 with SMTP id
 hg21-20020a1709072cd500b0099cb0c94ec7mr9824388ejc.26.1692103345542; Tue, 15
 Aug 2023 05:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-4-maxim.uvarov@linaro.org> <ZNo3+qhKIEqmdMTh@hades>
In-Reply-To: <ZNo3+qhKIEqmdMTh@hades>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Tue, 15 Aug 2023 18:42:14 +0600
Message-ID: <CAD8XO3a-C1oiZdcy_sk0DOzKwPEq7pBW6CsDeSHM-bmLE=RXHA@mail.gmail.com>
Subject: Re: [PATCHv6 03/14] net/lwip: implement dns cmd
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@redhat.com, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, trini@konsulko.com, goldsimon@gmx.de, 
 lwip-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Mon, 14 Aug 2023 at 20:19, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

[...]


> > +/*
> > +* This function creates the DNS request to resolve a domain host name.
> Function
>
> You need the name of the function as well.  Please have a look at how the
> rest of the code is documented.
>
> > +* can return immediately if previous request was cached or it might
> require
> > +* entering the polling loop for a request to a remote server.
> > +*
> > +* @name  dns name to resolve
>
> @name: etc
>
> > +* @varname (optional) U-Boot variable name to store the result
> > +* Return: ERR_OK(0) for fetching entry from the cache
> > +*         ERR_INPROGRESS(-5) success, can go to the polling loop
> > +*         Other value < 0, if error
> > +*/
> >
>

Is there any command to check all the files for the comments style?

[...]
