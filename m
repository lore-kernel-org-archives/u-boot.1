Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8ABCD98D0
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 19:33:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B394483FF7;
	Thu, 13 Nov 2025 20:33:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LfpkHOlS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D3DE83FFE; Thu, 13 Nov 2025 20:33:08 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A07083FF5
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 20:33:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b735ce67d1dso100134766b.3
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 11:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763062385; x=1763667185; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JMCwLqGoOVfR53lIm65rCEreYwnqx4ro8h0T9ld759s=;
 b=LfpkHOlS9gdDLLHXUGJJ6STW3njPBS1Rtti5S2iCTRIw7wLJIke+1dXNyuGUWCzkId
 pqimOmPpku2klvTOGgGjhvUL5mB3pyP3IUeGnWRq3lA0DgGz7WUdEIDWQ3YZoT1VaOvF
 kDO3K5Bk/YF09u3Ujxn7r0jPyEBNTefnibKk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763062385; x=1763667185;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JMCwLqGoOVfR53lIm65rCEreYwnqx4ro8h0T9ld759s=;
 b=EXnBQgeGwD5zxyADl1sEfHoXF5JqtGhyFPm1dpnTQjETOwMm1HV5apGmO4/5nvvc+P
 uFkkRaIWwGxdtrdaRVBSb4y4pJAXvnissqRO/5r4RsAjUCmgF3PdXDo8QwoVlV38BqKW
 p8qy4Er4IV7V4Ke/Ogm9lniK2NoTbmNZRMitHQyqCzkDz7UBxTI1IOTqmC0ZTVwTtFi/
 WnMwuE65CFT4QdX08FX+TVnJO8Qfj7+lj/dEt+BEQOpVBdRHNWpUzKxro+9U9jhWjsVJ
 6OXBLhqpfGD6nlj3S0Sg9WpwYRju39zGJdA07jBnUv+NRoDrOeNMWE00NJuMS/sByT05
 335w==
X-Gm-Message-State: AOJu0Yz9UFD1iycerCy6VH8lhHLt/sbtcRdnxlNRc0rCqWrygH/eBsDY
 nXddD8giOtIPUN8BTIaZFSNnjBE/s/0NGeHQyOX909kPZBHc8wqeGd1zBp64wNs1faQEzOKD2Vv
 GP4PZ3RRxDeHlB5/wNj0OBrssK81vkB8+WNVuTHyf
X-Gm-Gg: ASbGncvBcdFOaDhnXeRqP6cg601CELV182EMBtaZy39MH9hjaSy+VLybprco4RFijwD
 cUf/c2TP+s5vXz9VzCdD9ZddH8sEWeQTIYnzpUoWQzcak24uuwhkTaO7bga+sZqObm737LdBtMg
 eMQOThhKvPPq8ZOcEAvynI1Ro0Bk6NR9ymZRKdxb833WX9MTOwf2655AMnlgaWv+DrY8Qwwonrz
 ttRaD6FVxPjYCCc7trkJjrGghh8QWOg0xrH3X0SvgIY0Ualw4XBRqRnfJxj86CIasds2zMKY/mR
 5Wev
X-Google-Smtp-Source: AGHT+IHZxov1pa/kQ6O0zDBFlCy83oLMEc9cOhsMgBUNP0VrKNlJP6Qh9DF6veHua8GIPj1OWfwgMNfBSMUCvUDkQXc=
X-Received: by 2002:a17:907:a47:b0:b73:2aa1:f9fb with SMTP id
 a640c23a62f3a-b736793d675mr33515566b.32.1763062384795; Thu, 13 Nov 2025
 11:33:04 -0800 (PST)
MIME-Version: 1.0
References: <BESP194MB2805EAEA32CBD02FF8F2E7BFDACFA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
In-Reply-To: <BESP194MB2805EAEA32CBD02FF8F2E7BFDACFA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 13 Nov 2025 12:32:51 -0700
X-Gm-Features: AWmQ_bmWY0boInVztTQAse0in5TddecTmyUPA6UaiozRKag7Ki6fsadtbN9ThIw
Message-ID: <CAFLszTi60Nps0wXO4fRq0aw+GgW8gbn=PU4iHW3VWW7Nk6_b=A@mail.gmail.com>
Subject: Re: [PATCH] upl: Fix buf array size
To: Francois Berder <fberder@outlook.fr>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On Tue, 11 Nov 2025 at 03:37, Francois Berder <fberder@outlook.fr> wrote:
>
> Size of array buf was incorrect due to sizeof returning the
> size of an integer (typically 32 bits) instead of a u64 type
> (64 bits). Hence, buf array was shorter than expected.
>
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>  boot/upl_write.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

That is a bit nasty! Thanks for finding it.

Reviewed-by: Simon Glass <sjg@chromium.org>
