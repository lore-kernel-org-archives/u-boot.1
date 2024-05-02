Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53796C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 02:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A050988B72;
	Thu,  2 May 2024 04:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="UTkrwCMl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7819F88BD1; Thu,  2 May 2024 04:41:08 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 222FB88B06
 for <U-Boot@lists.denx.de>; Thu,  2 May 2024 04:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=greg.malysa@timesys.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-61816fc256dso76193177b3.0
 for <U-Boot@lists.denx.de>; Wed, 01 May 2024 19:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1714617665; x=1715222465;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kP1gAJLCvjJZZ2Mqdk0yPRx6+TNnX9QL8EYr3IlmP+U=;
 b=UTkrwCMlHN6wE4U9lVUMhjD1nebp2rDVp34b4p7FCxr9bAGTbyNx3FPhONgDXna7ZM
 BcsxL1WqTRHw8Z++dzTxSTZ0qnINYWGC+NZvRH7eGSAoHbHMrnM6i5oJzKxkv74oL9iA
 5rDIvyipAmOEaulBV8He2ltTntGXcPilyWufmGKQqYa7qVAcGNEUuil6xgpaRsLHJ243
 dncqzQz83HmleeuayHtBaIgYKSRpZhnUwzxBVRb0d/R7zA8HoskfPXLB/DHPDPCSib99
 geptDEYnAvP80E4PUVmhqFP8znEMQ2UT3Z7/XMITsiJPw0V+vXugdroKM7pT/I+0/KJz
 aJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714617665; x=1715222465;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kP1gAJLCvjJZZ2Mqdk0yPRx6+TNnX9QL8EYr3IlmP+U=;
 b=JiDsTfVdxTyezLvtADgr3BVjjslAJvxb6w/Jj9reqsu72rHoTmF8a6OOf4KMFWL1Ji
 mvI4Ktu4y4CX73wLvIw3nJ8SaWx7SEzqJBdcRB+2k2FPm0CEQdrQNsSFEoTjWT4qnD6X
 Fz7H7mSwIYjrx1TvhjknvD34IcEvIjteQOpj9pEihwVlo/LZX5vcdoJ5c2Ixhr8V6XUi
 PH4K9ed4c37bPMvmsYOB6rmxEggOzE5NqCwwqKKbYac/Opz1ypItRXcvNYpzGJg5sqsI
 JGvxgoZuDN8x+fT2IvsyAme+5yb1QhvszZPPwrVDWE/4pnW0Wc6jsRf/la8VrTsH5wp+
 lVsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWqE9a+c9TcmJW6MfkejAR5bIoxSkuGraMK4ayXFzdELrRfQBay6RlUXGrsFGvKRjB1OYVw+8xUd24kTc4W1OQNEp9Ig==
X-Gm-Message-State: AOJu0YxWHk7byclAie0pJXfX6HdRjbNNiejEc+9BTusWSx6hKon0O1cR
 QXSQPM5YsR7krS4OmGwgOb8kS5XiwUBmcKX8mb+MkyKvrPQzB41NJLrluGTo1WJ5tYY4TK1QERa
 CWDjyngRmNT2nXEGwBXnC1ZGEox0EFADzCIMJ
X-Google-Smtp-Source: AGHT+IG5aUOhW2y3Qy8Qk1q9g++yaNDoPr25GRDd7Nyob9rSV4sA//j7U5z1ztd7NKRE3Q/X2RmKAKw0JkvR5cCD5T0=
X-Received: by 2002:a05:690c:610d:b0:618:9353:100c with SMTP id
 hi13-20020a05690c610d00b006189353100cmr4694585ywb.23.1714617664906; Wed, 01
 May 2024 19:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20240426103830epcas1p3720a09dd50c8ef3d16de0a6ff2ff514b@epcas1p3.samsung.com>
 <e6c74bd0-de66-42ef-a6af-0d5c058b12a0@samsung.com>
 <20240426155154.GK1054907@bill-the-cat>
 <33db14f4-f3f0-4e5f-a256-2ce9b5c505fd@ti.com>
 <20240430074221.GA10438@francesco-nb>
In-Reply-To: <20240430074221.GA10438@francesco-nb>
From: Greg Malysa <greg.malysa@timesys.com>
Date: Wed, 1 May 2024 22:40:29 -0400
Message-ID: <CAAjXUaqCWHVmqHT7iMoHOir5PH1E6fhOFoZHBLJ4obdW6bHw4Q@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-mmc master
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Judith Mendez <jm@ti.com>, Jae hoon Chung <jh80.chung@gmail.com>, 
 Ian Roberts <ian.roberts@timesys.com>, Tom Rini <trini@konsulko.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 U-Boot Mailing List <U-Boot@lists.denx.de>, 
 maximilian.brune@9elements.com, curtis.machida@intel.com, 
 Jonas Karlman <jonas@kwiboo.se>,
 "ian.roberts@timesys.com Peng Fan" <peng.fan@nxp.com>, sheng.tan@9elements.com
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

On Tue, Apr 30, 2024 at 3:42=E2=80=AFAM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> On Mon, Apr 29, 2024 at 03:39:53PM -0500, Judith Mendez wrote:
> > A patch in this series caused a regression for AM62x SK with the
> > following error:
>
> +1, this affects also Verdin AM62.

Hi, please try https://patchwork.ozlabs.org/project/uboot/patch/20240501185=
331.1189647-1-alexander.sverdlin@siemens.com/
as this should explain the issue and also fix it.
