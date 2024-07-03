Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C63C2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 14:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1485B8881A;
	Wed,  3 Jul 2024 16:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X4lVkdFU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33F2988831; Wed,  3 Jul 2024 16:36:34 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 636118838E
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 16:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70af2b1a35aso368930b3a.1
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 07:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720017390; x=1720622190; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OmQdwR+e0f9k6UBvRoPQ4NceMmLLL/pV+9fBmdYn1C0=;
 b=X4lVkdFU3C9RCUo2i+D2+s44g35dHoEfnOex25m4p7Du/4/kzCN6yPsfltNiaYqCOk
 paw2yX8/1RUxwat9kvInemt1P4j/4D8J1/+Yk6wNtp0OAY5y3ebgUKQ9Nhi29FB5H8/e
 lYyYF4iV1y/xrnLN+WhaEsO/9iyZx0eNUOSM5h84dtR3gJmC2YBdeyhgLCnG1PBq0kni
 Jo5hEjjEH4+wgYillnbOLl+RSWuvstVOpNrVp6z/FR4byO8ByTApfwqfyX3NI15SlCio
 rTDWSMwtNjHbRrgJby1x/eu0gnRYJr1b4/E+QkchxHtUIgYbK7zWQltbj7GMiXbjgFjl
 E4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720017390; x=1720622190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OmQdwR+e0f9k6UBvRoPQ4NceMmLLL/pV+9fBmdYn1C0=;
 b=RKz2CkX05wzteMLqMnwSroWD4yH2gTDyjiCHdzwxSTif+FDqbM4j7/DncP0LLWo2Je
 IfIRGikpfqnsCsEtuMYtNgencbvHBz/rejUhNuZu2KG0ayTIMvCUJhJhLcfy97lveT26
 mrWiVA6i8oDHB792GSqBaWnbpeNlCTPtlXcbXD9TwvHFQaNgf4kyswLG6h9FWobfWQRC
 9S+tSoDP7Mo9Y+TvcfPWs6M+h3LGPTFgkiGPh6GflWsRax++j8G8zsLy7eJg7KxHJOtI
 FFa7OnLoNAWuWb2cVhg5rCiCTMv0qvwaK+DulypqaiITVlNUR0DGW1QTBL7m4nQN7mWF
 7AiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFdYUqJXBKoD1WrNib9d+aSDAFtNRJprUrbPRbX4qQpk6ily2Qev6JCxSAxQnRO29D7y86oQEgGEDzbi9uoLo9i4PxWA==
X-Gm-Message-State: AOJu0YyJ+7+HqE10PVefPaSCBiX6inVe7pfbJD6a+NjQwp2pGIkgS7IF
 zaWBKgD6ceZkCbzEPPRxx01AhG74Xxeb5sqEiMFjKavxf6TB1HTSkFk6XU2n4XBNvHvwLOlLpQ9
 Dn+xW2xwL0mXWy9P08Ifz1WCUBQ57wI6Kfnq4cXKRXH6rY8c7
X-Google-Smtp-Source: AGHT+IE759djYb7bbBYvz9zG3v8eENIiMT/PC+0LNYxidUg2QrI/OkBzoctHwenKZHWi2GWFwstOliPMg7D9ZLIuOd8=
X-Received: by 2002:a05:6a20:6a0d:b0:1be:c5f0:6079 with SMTP id
 adf61e73a8af0-1bef613f507mr11292587637.15.1720017389769; Wed, 03 Jul 2024
 07:36:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-3-raymond.mao@linaro.org>
 <20240702205658.GS38804@bill-the-cat>
 <3d513ee0-fa95-44de-81eb-5f281b1899ad@linaro.org>
In-Reply-To: <3d513ee0-fa95-44de-81eb-5f281b1899ad@linaro.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Wed, 3 Jul 2024 10:36:17 -0400
Message-ID: <CAEfUkUKxFX_NOdEZUWNa6H4stSyYZbyvyFQ5DrTSPQ6Qfstu1A@mail.gmail.com>
Subject: Re: [PATCH v4 02/29] mbedtls: Add script to update MbedTLS subtree
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Jerome,

On Wed, 3 Jul 2024 at 03:16, Jerome Forissier <jerome.forissier@linaro.org>
wrote:

>
>
> On 7/2/24 22:56, Tom Rini wrote:
> > On Tue, Jul 02, 2024 at 11:22:38AM -0700, Raymond Mao wrote:
> >
> >> lib/mbedtls/update-mbedtls-subtree.sh is a wrapper of git subtree
> >> commands.
> >> Usage from U-Boot top directory, run:
> >>
> >> $ ./lib/mbedtls/update-mbedtls-subtree.sh pull <release-tag>
> >> $ ./lib/mbedtls/update-mbedtls-subtree.sh pick <commit-id>
> >>
> >> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> >> ---
> >> Changes in v2
> >> - Initial patch.
> >> Changes in v3
> >> - None.
> >> Changes in v4
> >> - Minor fix and move the script into tools dir.
> >>
> >>  tools/update-mbedtls-subtree.sh | 47 +++++++++++++++++++++++++++++++++
> >>  1 file changed, 47 insertions(+)
> >>  create mode 100755 tools/update-mbedtls-subtree.sh
> >
> > Given how amazingly close this is to dts/update-dts-subtree.sh and also
> > the lwIP version, can you and Jerome please co-ordinate on a short
> > series that you can then both depend on a pre-req that makes, I don't
> > know, tools/update-git-subtree.sh and that script takes upstream URI and
> > whatever else would be needed so that all 3 of our "update or
> > cherry-pick from a git subtree" scripts call that and are more or less
> > one line scripts themselves? Thanks.
>
> Sounds like a good idea :)
>
> Raymond, FYI the lwIP series is at [1]. I will make sure I CC you on the
> next iteration BTW ;-). All the information about the subtree is in the
> cover letter and that's basically:
>
>   $ git subtree add --squash --prefix lib/lwip/lwip \
>         https://git.savannah.gnu.org/git/lwip.git STABLE-2_2_0_RELEASE
>
> [1]
> https://lore.kernel.org/u-boot/3c2b8a90-1d4d-41ac-a15a-0d3b2a7d2a57@linaro.org/T/
>
> Thanks. I will send the patch and keep you in CC.

Regards,
Raymond
