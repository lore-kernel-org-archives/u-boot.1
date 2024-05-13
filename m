Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7765CC25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 14:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1B3B882AB;
	Mon, 13 May 2024 16:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="Ka2I/UnW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 293D4882D8; Mon, 13 May 2024 14:07:31 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A348988275
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 14:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anand@edgeble.ai
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-51f12ccff5eso5819728e87.1
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 05:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1715602047; x=1716206847;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7MDzVyT9kLJKMN83I1qYnfSxM2HBEN+9Z9JomDs6j9M=;
 b=Ka2I/UnWJXbK3OFLUwMnJIRiYBISnuDLXK9hFvLtNJ62sd1YTpfe8vd8YApqC49/GI
 3BR3HYPldxfr+fWLRwTndwqAATHgsNwhvS0/c+LJjXgvm0snD2fWNoVkVtwUS9g3GVb9
 ySjkCoXOIRO9JlXFc7BTJ2wT03SdCDve+23Pq/njf2P/dA83wySV0wXwfQr/ca6K3sVN
 7A+5NZbBriUj/nC4DzH9EsCd6fQky3JUdsV/LZG242eKjqICIOwJVrX4ygN7Lu5lSbxt
 zbHpnyMPHLXxS3jeNbog+tKtULQCdIDnF0qMoS9hil8rmJqFKv19yjXUZs9oechydYId
 K+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715602047; x=1716206847;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7MDzVyT9kLJKMN83I1qYnfSxM2HBEN+9Z9JomDs6j9M=;
 b=lTM+GWupRaRWkBGi4izpOddnU225eqaHhegHrV1KURkx6OjBh2vIsFpI+hV2XZ5xSK
 FwbddSGReF/bisPDDsC2B9Ly+2nesWwZsLizd/Sgh0keND0b5vUVwDhpl0nPgnvqyg9z
 NQQu9STdSVNk+e5WUzcUuAbxWXcYoBv19CZVrLmvE10DUO6J5nzjEpYgrqu6eaRwQZpM
 trw1WExPGzlEsN6stplnPKjVnNzk+ZoCBMhTHcLIQsD9JyXvjiprRQpJc6hBI0Lv3E9R
 K3ce8/qJqd4eA0uBIOMxUM9vMBxbHnT1nCV0obQ+8lc8X1drnSRtpAvrFgBiVnrNkWtW
 dSOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7HqFCfSw0D9bJZ3XJ4AKSv6WxyDbbiStjqcHAaiVCgu6VrM8A42eg/v2W2WBN9FuA7rcSeUvaB0d8W5j5y8aPqN8TYw==
X-Gm-Message-State: AOJu0Yy7HoiUzCSKF+4sZoobUTCmLMLbCzKJ2cNnF88zRnweFzzPG4Qj
 Sn4NzAd7CaLXwIFKp85092F5xKsNfABDZkUZDFEouT0Mp1kO0c9LUWmw/1fhIp+y0mARb5ZsdIV
 ENa+yOaYKTTQKcLjhfGX2vMoygvnBw90g1oCQ1w==
X-Google-Smtp-Source: AGHT+IGzr5PBlZUecbzknfSAZOfp4YSAkDEKcMf42F+PcOIWAYm/CpX9tzqWx1MHqc0xVsEmv8rfLM3ed1i6dmhLnBw=
X-Received: by 2002:ac2:5052:0:b0:51d:2017:e65 with SMTP id
 2adb3069b0e04-52210584d5amr5230459e87.66.1715602046696; Mon, 13 May 2024
 05:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240511161224.1176-1-anand@edgeble.ai>
 <6857bc47-895d-45bc-9b7d-d00ac7b0ec1a@cherry.de>
In-Reply-To: <6857bc47-895d-45bc-9b7d-d00ac7b0ec1a@cherry.de>
From: Anand Moon <anand@edgeble.ai>
Date: Mon, 13 May 2024 17:37:16 +0530
Message-ID: <CACF1qncdn9y+bE6vwjCBOAdseTkwPORMHfJ2JFJt6m7ECHGT1A@mail.gmail.com>
Subject: Re: [PATCH v3] rockchip: rv1126: Migrate to OF_UPSTREAM
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jagan Teki <jagan@edgeble.ai>, Tim Lunn <tim@feathertop.org>,
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 13 May 2024 16:01:41 +0200
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

Hi Quentin,

On Mon, 13 May 2024 at 16:10, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Anand,
>
> On 5/11/24 6:12 PM, Anand Moon wrote:
> > [You don't often get email from anand@edgeble.ai. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Migrate RV1126 boards that exists in Linux v6.8 to use OF_UPSTREAM.
> >
> > Following targets is migrated to use OF_UPSTREAM:
> >
> > - rv1126-edgeble-neu2 : Board is an industrial form factor
> >                          IO board.
> > - sonoff-ihost-rv1126 : Gateway device designed to provide a
> >                          Smart Home Hub.
> >
> > Cc: Tim Lunn <tim@feathertop.org>
> > Cc: Jagan Teki <jagan@edgeble.ai>
> > Reviewed-By: Tim Lunn <tim@feathertop.org>
> > Tested-By: Tim Lunn <tim@feathertop.org>
> > Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> > Signed-off-by: Anand Moon <anand@edgable.ai>
>
> Doesn't match the mail address sending this patch :)
>
Earlier I sent this patch with my email ID,
Since I am testing these new boards,
I will use this edgable.ai email ID for source code changes to boards.
if needed I could send this with From: Anand Moon <anand@edgable.ai>

> Cheers,
> Quentin

Thanks
-Anand
