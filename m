Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBF3EDEC4D
	for <u-boot@archiver.kernel.org>; Wed, 13 Sep 2023 13:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 990CA86C23;
	Wed, 13 Sep 2023 15:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="whlUA1Oc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C4B886BAE; Wed, 13 Sep 2023 15:35:04 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F30D86E30
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 15:35:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-501bef6e0d3so11216588e87.1
 for <u-boot@lists.denx.de>; Wed, 13 Sep 2023 06:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694612101; x=1695216901; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1/A+QJLNoJNi+8D/iwIZ/12Rdqo2hGXegNBruu2ciCc=;
 b=whlUA1OcrsfHLVwH6hCEKBoV3m8CzFkkEfCjPSj+l4nzkseNiN+5x9Px6TGLDSAW7F
 elcor3OU5G91MgMqxByH3SKpK80MDH6nXHO72iAlsmjxN+mhHBXWQAIstjAe8IJCtmpv
 GT3nQ6iSWeUW8C9xTTXAyXtRJQ6tSGKxw16577yZOGc7bsgN0iq8usTHronsRj4pPb+H
 QYv4oez+sh3h5AQ8SGvhW+97KBQyT+oKObEMsGqcR8GNzAyQ99gSbT8im6Umlmt5L2K2
 /1ShFNE532kl2qMlEe8GycanF3ORulKZAlCr8w3moLkxlwCRX46eNWdptgIRz2gA3fTj
 GkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694612101; x=1695216901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1/A+QJLNoJNi+8D/iwIZ/12Rdqo2hGXegNBruu2ciCc=;
 b=tkaFzSWSuWaRLdZGpKU+aiY9U058jZitcnL/u8bcYDJLABO7I/ApM4ezjlu+JjYRQE
 NDlFJR2i3EDe1NrY9tyyln1FIxCEAWoPrMmKpMgwMRA4RaoOWeVKg5MGcyD1tK/NNshD
 dHKW9SPLNByYufJEvgXF5r0sVWkP1SZJ0WtSLArpuaitUMQuSLexKshMNFtBeOzuWW2b
 ztwoxaXBQdhBGpU0hm8P5SHyU6jd7UqnhWAr0YqJa4Khd13HSrnkYL/EoYmf/1vtxxcZ
 9pIrRqo9NWij/2GaS8i/PkCE/ugICI29QlCn9u9G8emmrfbUnJvJyxaIDvNBsFEWXu1w
 zY0Q==
X-Gm-Message-State: AOJu0YzcrZQmbkSsSscv+EXgUbXBpHutyvN2h3nbus2oxi/U8aHzEFZR
 /jVvjHqtpE6U89FPydjQwPrsicRN11CvAehNMpm9tg==
X-Google-Smtp-Source: AGHT+IFrsm5UhFNRDBzk0p0r+3+UyAxAycTDeggL6WTqtVDXLL5L7KkcNSJyqHFMOE8skRtzm1ctlh6GC43Ctxlh8+w=
X-Received: by 2002:a05:6512:1305:b0:500:acf1:b432 with SMTP id
 x5-20020a056512130500b00500acf1b432mr2200130lfu.63.1694612100367; Wed, 13 Sep
 2023 06:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230908135320.7066-1-maxim.uvarov@linaro.org>
 <20230908135922.GC305624@bill-the-cat>
 <CAD8XO3bWmefyQ7Dx8fn7kc3s8=uCUhG3FcE6J4H6=qFdwa3gmw@mail.gmail.com>
 <CAPnjgZ2Y6FJELJX7RA3_PehnCQ7zaiCeQd-VKJmtj_8nwnv3_w@mail.gmail.com>
 <CAD8XO3Ynafpncs42KPX9sDw-5VQHQpwJq=22SzXDi27Dz6rrEg@mail.gmail.com>
 <CAC_iWjJXHraJ2gEMgUGaRxjQxM1JUwP+jTNUiftngY1ubcEq6Q@mail.gmail.com>
 <93c9133d-b259-c093-64f4-2acdcedd0dc2@gmx.de>
 <CALeDE9MBUd2_8TZ87PJXx_jF0D6zqGV9FY2vQCSkxG4P2GJ-JQ@mail.gmail.com>
 <20230913131423.GI305624@bill-the-cat>
In-Reply-To: <20230913131423.GI305624@bill-the-cat>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Wed, 13 Sep 2023 19:34:47 +0600
Message-ID: <CAD8XO3aq9+KDOUXKtURaL8UwX96RLqqwAhDz=U2924BfUdz9+g@mail.gmail.com>
Subject: Re: [PATCHv8 00/15] net/lwip: add lwip library for the network stack
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Simon Goldschmidt <goldsimon@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Glass <sjg@google.com>,
 u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com
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

On Wed, 13 Sept 2023 at 19:14, Tom Rini <trini@konsulko.com> wrote:

> On Wed, Sep 13, 2023 at 11:06:13AM +0100, Peter Robinson wrote:
> > > >> Then if for development you need  to pull he history of lwip, you
> can do it with:
> > > >> git pull -s subtree lwip  master --allow-unrelated-histories
> > > >> (but I think nobody will need this.)
> > > >>
> > > >> New update of the lwip net/lwip/lwip-external dir will be done with:
> > > >> git pull -s subtree lwip  master --allow-unrelated-histories
> --squash
> > > >> Squash commit also has to be git format-patch friendly.
> > > >>
> > > >> If you are ok with that proposal I will send v9 with the first
> patch created with steps above.
> > > >
> > > > We've gone through this before.  The whole purpose of this is not
> > > > having to maintain patches.
> > > > Simon, instead of "I had problems in the past", can you elaborate a
> bit more?
> > > >
> > > > Tom said he is fine with subtrees instead of submodules and I know
> for
> > > > a fact EDK2 doesn't have too many issues with submodules.
> > > > Their documentation is pretty clear on building and requires
> > > >
> > > > git clone https://github.com/tianocore/edk2.git
> > > > cd edk2
> > > > git submodule update --init
> > > >
> > > > Perhaps the situation has improved since you had issues?
> > >
> > > While I don't really care how you solve this technically, I'd
> *strongly*
> > > be interested for U-Boot to use *unmodified* lwIP sources where an
> > > explicit reference to an lwIP commit is used. I'd rather integrate
> > > bugfixes for U-Boot into lwIP than having the sources drift apart.
> >
> > Strongly agree here, we want to use upstream and all the combined
> > development and reviews etc rather than forking off and ending up with
> > yet another slightly different IP stack. The whole advantage of
> > adopting LWIP is the advantage of combined security, features and bugs
> > from a wide range of projects :-)
>
> Yes, this is what I want as well, and why I'm perhaps more agreeable
> with the approaches where it's a lot harder for us to start forking
> things unintentionally.  I gather submodule rather than subtree would be
> better for that case?
>
> --
> Tom
>

Yes, submodule will be a much better solution for us. And I also don't
think that today
there are any issues with submodules. It works well of OE, RPM and DEB
builds,
distributions should not have problems with it.

BR,
Maxim.
