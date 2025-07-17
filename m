Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2794C83F34
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 16:31:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50C0283447;
	Thu, 17 Jul 2025 18:31:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MzhKm8KW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D03748343B; Thu, 17 Jul 2025 18:31:17 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA0788344E
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 18:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-558fa0b2cc8so953782e87.1
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 09:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752769875; x=1753374675; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8OJqWAm7slkT9oJlTjfZYWlypq6UPefNbjBtcaVhf0s=;
 b=MzhKm8KW6jcRfOF4V2h1SxlZwk0SxBEC8i5mOGwzDhTz/kFOX3aInIWivhfT19VwvY
 Q0fnMKODVT6S6a6LQfazuiPu17T3bODLe2EpqIVaf7X7LLh4wbiT3NYAAVDlzewiA4Oe
 GeCWFbg040Ez9Qa9eiHMYIclCSpiV8mi5U3QhL7C0O/UvUqbCAPM1A/fe6CVIF7e+jUG
 60VbnKkoOiXrxc+sQPj4x7As/2Kaj/rBC2j8WAPmJpW+gWMmbZyd+d24ebCpK63tErbb
 oZmh/R/tiDxYPcYDmdmiQpXTmV9JQRXQt6zZcltQwYUz1JEaU1nPj08+rIhgW+zgE99U
 BFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752769875; x=1753374675;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8OJqWAm7slkT9oJlTjfZYWlypq6UPefNbjBtcaVhf0s=;
 b=Uec8BW/HN8ewNfmUDpekMyLPyE69D0DMsutsWVEj9ZuD/L6fTBmF76Xh5pdpoy67G2
 2xLS4CDwre+Da6bh5Jn+DMp/xqJ1lOHSs8XidOXbHmEZkTRQM2wR7//kZ46mHV5umjwX
 Nb8Yg84qQobiYUIYfGZF9dR+7ybZuYj77jNzkVNghbQTgHX+HkXOtbAKyrlTARTLuZoN
 ka6qXs2uA3PcK9TD14bIp/vN097ONsd9+1DwuvK5JtTXVoBVQltxFhABKj8J7fqbchJL
 K1h6+hBE3/tu6NlpoHXwMtveXCGzyBYIlIIN5JjosimU9bBd/zxiUZhVoOlEE+KtuVoj
 I83g==
X-Gm-Message-State: AOJu0YxAkEWq4hG3eyFIuU8prS2++tEdyG69kEyLfeR8vppq/K+gfmVJ
 +rwNkr9OF4StAt1HpW775CR3Z0fUYrt4Ggq0Yqhsw2tHvRrtheoFp8m6SGg2Ns+LOdFMyyL779/
 RVOCaSP3SPc+NTyGNmr/66neEXz3YDjlGbw==
X-Gm-Gg: ASbGncuY5s1gL5WMscAJHMbYx643S9KKSF2eWmouwoqDZlhq1CPPWmo/TCt9HLrf0lP
 AAhKpX+vZm7dZyvaBuTATT0w2KDUm40W/1tecKWscfs2l8GrybCl1nEAx74HBKbby+i4oPauNev
 5K2flHjXih/SacX9gpjZ8G6IE9celjCIOus8X82YkZkiQpVw5WNKt496U+WTX2f7vuKIFgbNfU8
 RYgi6pC96fb+24aBeFcmgAgGFf0muadC9+W
X-Google-Smtp-Source: AGHT+IEHkktU8y8w1fKV3d0CH/cBO2ldFNUq/Tqj4G7tAgUn8FffUodYhKN5+OefQEvT3ZZ7i3K7SfiYu/jctOPZs8Q=
X-Received: by 2002:ac2:568b:0:b0:553:2633:8a65 with SMTP id
 2adb3069b0e04-55a23f35a02mr2116574e87.30.1752769874927; Thu, 17 Jul 2025
 09:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250711151552.2224176-1-trini@konsulko.com>
In-Reply-To: <20250711151552.2224176-1-trini@konsulko.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 17 Jul 2025 13:31:03 -0300
X-Gm-Features: Ac12FXzhyGCJUDS4IY7evXJjei-LAACDNDkNUbKvo3goZk9xv58J50Htq-pLiP4
Message-ID: <CAOMZO5B6suF1QeXOQRvVUjZ-D+oksc6-Yg7t_jX6rMtm3+_11A@mail.gmail.com>
Subject: Re: [PATCH] brppt2: Use the correct MMC driver
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, 
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
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

On Fri, Jul 11, 2025 at 12:45=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> As part of splitting the i.MX parts of FSL_ESDHC out from the more
> legacy parts, the FSL_ESDHC_IMX symbol was added. This platform is the
> only one which was not converted correctly.
>
> Fixes: e37ac717d796 ("Convert to use fsl_esdhc_imx for i.MX platforms")
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied, thanks.
