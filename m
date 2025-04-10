Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491E0C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 22:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8870683995;
	Fri, 11 Apr 2025 00:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=jms.id.au header.i=@jms.id.au header.b="ARYaHWES";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ED64839B7; Fri, 11 Apr 2025 00:37:32 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D741838AB
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 00:37:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=joel.stan@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac297cbe017so425217766b.0
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 15:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1744324648; x=1744929448; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bUr2qcvTMWYs0hExe5jCEm3OK6wx3gkV6/LN0LUHEqg=;
 b=ARYaHWESPxXuj4W9Alhyte/3mmmCx6JBc4cMTCDDUfBJ5UX1JbAIXQJ7ovB0HQUyhg
 PQWfHXA7YG67m4+a3Xcc5j68w+WFqn6rPJn92gROGhH/muatrCLLjQrvMAQl9Ew15VPW
 lsHykjDqdkPGPq3u9ia886mKANxEsDRNz7aw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744324648; x=1744929448;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bUr2qcvTMWYs0hExe5jCEm3OK6wx3gkV6/LN0LUHEqg=;
 b=v7MrlzOm++/HTtezFY4wZlcTfqFSYLlIMI09TUzL7jH9EtP4k9cVONL/VUDaUBj2Jy
 NI08V0rLglCnBJBSBhzOmnV1YYCRJP9ePJYOJRyFFKIk2VOAq1vm7ulDSeLe64T07B0s
 MuhtYphxZ0atY8Me8hDDyhU23KIr42phvcr2oSxSStCAFJ5pFRH8sMwLmoWrazTJAzQy
 7X6fSCglOralEZ2M3yToeqioiBVEXrv+VfQKMQUb5Ngs6koLDy1vcFtFul3qcvQ85teh
 Cb02W75fAWQAUeMq3s44z1z9XaIPpj5lRuZLnN+FPs9crYcYMXgj9jMItmsMptXk1hrD
 QxZw==
X-Gm-Message-State: AOJu0Yyi5WZKtOqh3zvpDieTNTPIY7awQnd28zofBr2vkk6ntilxWZJy
 sLxGZGaL4hWPxttOgrdXUQzfeAoV2/KjuRSBXy5Gip/4i8RkrS1tUXiHbaY55iCFqYahqtwqsTu
 u5NFYdejcaRyoTfBPEB/HL9houn8=
X-Gm-Gg: ASbGncsYUufTI79wFMzoR3KwYxubFGTsCkT7qaxsrq0dj/VdjmbmB4gqW4845rcAGzK
 gyINn/wpDmBawDZ9GaclfdVWhHHPDTsFG5nLpLLymaVdsZdgerhnwq2zlAUb5E7u+xf+jS+bYb8
 rfwGVZB+MJofQyQVE2IWT3qA==
X-Google-Smtp-Source: AGHT+IG8I/GdQJbewMNHgL3UYpMZWCg2N1K5fEdtdJrZxRUjfiRFlfq2L+aw4RG2J4IVsutGWQr4EyIeInlklYhY/DU=
X-Received: by 2002:a17:907:86a4:b0:ac7:3929:25f9 with SMTP id
 a640c23a62f3a-acabc6c510dmr416458466b.29.1744324647770; Thu, 10 Apr 2025
 15:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <7a737a5e-c804-4d46-be33-28aed9c4a113@linaro.org>
In-Reply-To: <7a737a5e-c804-4d46-be33-28aed9c4a113@linaro.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 11 Apr 2025 08:07:15 +0930
X-Gm-Features: ATxdqUFHd60NQvDIbFpb3qa8oG-zMlbLohhliNEWbGkCh5rZep0wDXRd4KWe_Hw
Message-ID: <CACPK8XeCDU+-6+zzJe4=uj=Lduh8nGx6pNr=yWCsM+k-rov2UQ@mail.gmail.com>
Subject: Re: Gitlab runner timeout on evb-ast2600 ?
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: open list <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
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

On Mon, 7 Apr 2025 at 23:25, Eugen Hristev <eugen.hristev@linaro.org> wrote:
>
> Hi everyone,
>
> I keep getting an error on running the CI loop on -next on my tree :
>
> https://source.denx.de/u-boot/custodians/u-boot-at91/-/jobs/1090517

Thanks for the report.

>
> ! _pytest.outcomes.Exit: Lab timeout: Marking connection bad - no other
> tests will run !
>
> Any clue ? It's been like this for few days. It doesn't look like a
> faulty patch.

I can't see that link you sent me, it 403s.

Do you have any other traces or information to share?

When did this start failing?

Cheers,

Joel
