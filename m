Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DD5CA0EE9
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 07:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6EA9808AF;
	Tue, 19 Aug 2025 09:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QOHzXMg6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AA818006D; Tue, 19 Aug 2025 09:14:00 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97C7081D5D
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 09:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linux.amoon@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-61a893d5226so141723a12.1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 00:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755587638; x=1756192438; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3hNWMusfpDcAS5W05iQVs4V2VQC3mcPWTXoRviWjW7c=;
 b=QOHzXMg6zB72uKYXvkgAYqen8sVGdCyZGQA/RwSnpdJuFt5kV+ePj2fhS0LGheB03/
 8QOJAM2fplzlFMz6dv3GAqHRAOXlFbe91L004P9VLP6olT87lyhVDoaTMym1Txeh4pZn
 e/1MTGyxouW32o6ujb+sSVUMLPESGsibJJ+mh8SUWLWPbvPzmGaf4/wmg50mIN6BGGxx
 TeZT4rIWZQXyqPohcw4s6MFLg5pYWvKjj+oegRueeecxiZGIBkDC1ncQOlNXN7CbTbU4
 OQHCHPQ7hz3CHAcAThJA+nZS8dGjV7cbF0IcSZqqs9SOGyndaKq/oUA8oEIb4lG3fBB4
 TcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755587638; x=1756192438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3hNWMusfpDcAS5W05iQVs4V2VQC3mcPWTXoRviWjW7c=;
 b=jyLtXO0Fe46C457RjpTGFmnSXOUAafYJAJoeLqyVbGsg2Tv+k3R+zevmbTm7R4dXCO
 ca6JbNfV2eMufd1boB/o4v83ix882Eu5TogMJtz4pnCY/u+kwXGY+DKU4WGpBvt6BvZ5
 rbuXE8dh4q8+vf8kLPV6P6oeYRYbXReZKDREngLKegbJpw95s1171w9lPejHMFpv4geP
 qsKN3M5Ds3JDPtE9wLuUlBzq5bSYV2qz4jN2M/o2RN7oJbn1Am/0O9imS1Q0ZOtNoGvw
 Dow+/6fJiKKOU866yW9KR2R19zfaAziO9tlBUoyM9FgVU6iEfl+ir3V2y59FjJRc7lca
 BIPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWa4fNLn9IqMDxJTkBDfHaS2LYedyJfpiDD+Jvn13Jz9Ucx4w6AccMf18Z0+oJ1pWsJHWQtCyQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzmGU59TINUTJDXmE/m1oBo2XdmWDs8zYxrJoBz5xZSxiGfvjBF
 0hZAoX53bdhJBdSiP3eN4ha4eM9tY5yy/CYuAShbkgNGtlzqnouAApBAKF3CO+kxtx/tKekZH+5
 pjtmREkgjA20eYy8iTH377JnED3wicno=
X-Gm-Gg: ASbGnctsMBVxGg0bLmCBxicaMWw4nP2L2rmHpjX3AXWNnvv3LeW7LVaD0rna2cpOUBV
 YiZ7mkqkUZx8SYv7qperXMEfofOlyQ72+zul46AVu8LzJGH6AAzu0MyAylQYp6iZr22ih3QlUtm
 3aP1a/zeE8RU1zFx03J9hWAbP+f28dmrV5eio7cG5CcEzhaHyJL1tiTYnghp5vFzpYMvCDU1Luq
 T4mUCwE6HQvV0+AyQeUss8SaIY=
X-Google-Smtp-Source: AGHT+IGRJI1trR+DvCEKe4dhvMtmkEJP9POdRsmOLqGRK/CToVmYLxiO/f7KyfeCXLEOHDqXEVPOvvIzm5QdYpjQVxo=
X-Received: by 2002:a05:6402:3546:b0:618:3182:9ef3 with SMTP id
 4fb4d7f45d1cf-61a7e756c48mr1175329a12.27.1755587637700; Tue, 19 Aug 2025
 00:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250806-net_xilinx_axi-v2-1-6311cf59451d@linaro.org>
 <CANAwSgRvnJcZ71eNRCf+9G2NJjq8CxzV43h6w-cGEsmHLGGz+A@mail.gmail.com>
 <b61eb3a3-1c86-4d03-9a80-642ef64f71a6@amd.com>
In-Reply-To: <b61eb3a3-1c86-4d03-9a80-642ef64f71a6@amd.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 19 Aug 2025 12:43:40 +0530
X-Gm-Features: Ac12FXytDHcBGtAqC9-VWJLEjpubuuAgO93WGX9WYDvPs_o8PLaudyvop9cVZL0
Message-ID: <CANAwSgTS2rwC1zyz+PiV0q2=djOuu1AufFgG0VV-krqrho6iLQ@mail.gmail.com>
Subject: Re: [PATCH v2] net: axi_emac: Fix timeout test
To: Michal Simek <michal.simek@amd.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

Hi Michal,

On Mon, 18 Aug 2025 at 18:48, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 8/18/25 13:40, Anand Moon wrote:
> > Hi Andrew,
> >
> > On Mon, 18 Aug 2025 at 14:54, Andrew Goodbody
> > <andrew.goodbody@linaro.org> wrote:
> >>
> >> The timeout test in axi_dma_init is not correct due to the
> >> post-decrement used on the timeout variable which will mean timeout is
> >> not 0 if the timeout occurs. Make the timeout variable an int instead of
> >> a u32 and then test for timeout being -1.
> >>
> >> This issue was found by Smatch.
> >>
> > You can use read_poll_timeout instead of a while loop timeout?
> he could use it but then this should be split to two reads because two
> conditions are checked and not sure if it is worth to do it.
>
I initially overlooked the separate readl calls for dmatx and dmarx,
but replacing the manual while loop with read_poll_timeout would
significantly improve the code by making the polling logic cleaner.
> Thanks,
> Michal
Thanks
-Anand
