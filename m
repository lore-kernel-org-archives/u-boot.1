Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F709C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 18:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E5B981C67;
	Fri, 14 Mar 2025 19:50:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p9lBGK9K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E86281E92; Fri, 14 Mar 2025 19:50:05 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B93080F9A
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 19:49:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e64096aa08fso18105276.2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 11:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741978198; x=1742582998; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2BYKXGSkSjfL7qfAPawm6+bU+QQyj5P5ukoDaMzTTRs=;
 b=p9lBGK9Kw4J/D85RWYIDY4tAvsUny+eIC7UHOKvGYjmQR4FNNCMqQ4ZBt3zcLSIdJb
 Hgsj2Z0SQlr5FFW+yOMhJlnZgflDoMPrILjlLVMoXZy00sE2W3NLdk2SrKrpA96e+lOA
 HDCVJfItSVH2pyrPPiRqJOUw5Ww4unVqycKB3RNNR8s8Nwp5wWku6EgN5tj5JLw19q/5
 7yAzeeCWF+Zq3n0F9W9pGWI+hq+x4Y5enSWsklY2D7mlNn9q/I3yrecQZlfh2TF+jGVh
 qHrGuLQZeSF+irq1RDta/PZ+WwMHxcmL8ZnE7Grfsx/oFTIz3EYdQ/aW0WaHXDW96BEu
 2eGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741978198; x=1742582998;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2BYKXGSkSjfL7qfAPawm6+bU+QQyj5P5ukoDaMzTTRs=;
 b=dmBQITKmRGht4XG/hZ9wJs/W9bTfKQ9TjNR4qAizUwYyPq6YJkY7it/OgXsO2jiqLJ
 L3r96cp04XCx528cizhlkD41FOSPCNocif3/3+c3vxuQsEu0uJJRnduTgVJ9XeaxNA3+
 /MeyYbehMlx9FJjRX7kwHRBfeJJUpLarffY40MMzOnneFskgz3Lx+tK0kHtdgT23TpLv
 LNEbL8qiQ3U8D5wtup9q9WJdFXMTKSM+BOGkg5lEHcfBcFcQrR0VV0GpeEvyw6ABUfUo
 7eq5w0BPcki/8FYojM4bHvSjyUCLJQC9Fk3XW5HYatlcK1mXHCOEx/1lzPQw9wdH/pto
 pduQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhUTta53d+oQ/OFwHcCneyTTT4fd7UWqFoeWUamCQY4I6yBtWvpqleemaCiZpu2RVMgp9LwAY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0EfKG043BJh63zl4GZtJCU9bBwsa9PSfZXAVRU6ZPHEIjgBKU
 hGqgi+Iwy5hx3fUqwrMXptwOzb0hcR9oyOQEcL1X0MgrfxjKVNxHKGj6hZo4WREaUHItGhkjP+Q
 rbdaWGDGIx9puhpRCFWgfKbIH0ChGAaxGr2Z7fQ==
X-Gm-Gg: ASbGncvqW1aRjWlKYwM1vgB7rcGQVo9DRHX4bafWJfQ2UczcYkCLoRIMu3ZXWP5AHbg
 dSvmThwg0VL2uJDrb1Aesbv5++vrCS2RR8HPElMlWkYzKEvkat/HbihgQbOdQVMCdlN+FBI9yU3
 jeq2rIOC7zK4hbs/Kdsp0RKUr3DBs=
X-Google-Smtp-Source: AGHT+IH+VEy877SOFbugqhtr8cSkhsDUBPntfnqmucKqFSB9iWC7hz7kGwsgLz+9iUxTzVw83HXK7c6f9V/NfELnsuM=
X-Received: by 2002:a05:6902:114a:b0:e5e:1034:db93 with SMTP id
 3f1490d57ef6-e63f65b50b4mr4660758276.34.1741978198463; Fri, 14 Mar 2025
 11:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250314105703.277315-1-ilias.apalodimas@linaro.org>
 <at3MKdVWObOe2t0ulEO_390BtudxQ52-_iW2VGgpz0spI-UhNxRfC9TCtcUduXUIHSuBPt7vTR3iC4bOhT1IZTyI9hKIrHhBt8-82P4PIqM=@bens.haus>
In-Reply-To: <at3MKdVWObOe2t0ulEO_390BtudxQ52-_iW2VGgpz0spI-UhNxRfC9TCtcUduXUIHSuBPt7vTR3iC4bOhT1IZTyI9hKIrHhBt8-82P4PIqM=@bens.haus>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 14 Mar 2025 20:49:21 +0200
X-Gm-Features: AQ5f1JpwjCl5bf1m7LwzlBwln8kICStepX0UTNlxMQT9tW5B9IacS0LJQbztx9M
Message-ID: <CAC_iWjKGxqF8L=3r1-EuDN=Jmb0rPV+-54+g7x79m8dm-4o=yg@mail.gmail.com>
Subject: Re: [PATCH] lmb: change the return code on lmb_alloc_addr()
To: Ben Schneider <ben@bens.haus>
Cc: xypron.glpk@gmx.de, ardb@kernel.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Nam Cao <namcao@linutronix.de>, Baruch Siach <baruch@tkos.co.il>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Janne Grunau <j@jannau.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

[...]

> > ret = lmb_alloc_addr(ram - 1, 1, LMB_NONE);
> > - ut_asserteq(ret, 0);
> > + ut_asserteq(ret, -1);
> > }
> >
> > lmb_pop(&store);
> > --
> > 2.47.2
>
> Tested-by: Ben Schneider <ben@bens.haus>

Thanks Ben.
Especially for the testing and the whole debugging saga

/Ilias
