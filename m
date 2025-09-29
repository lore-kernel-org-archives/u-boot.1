Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B19CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 21:00:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40CB48319C;
	Mon, 29 Sep 2025 23:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F4AtJJkg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA434832DA; Mon, 29 Sep 2025 23:00:26 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7013082A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 23:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=javier.tia@linaro.org
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-4de2c597965so33436491cf.1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 14:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759179623; x=1759784423; darn=lists.denx.de;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wogJR2283/xFRAufiEcuMu7iWtvkU+S+omUGdr6KEjw=;
 b=F4AtJJkg9D0Y0/X92nW0cHzuGZb960FKBB+n82AFSr4FDGO9eRMVmr5vhlJwcDVZno
 h3zD5ud5FvdHOJ2Mdzbyu0Nb3NA5EB5ZuFPiT4RzCbhdKMi0vgeq+cVEgwfL+8XPK3eC
 yqzHQzB1ptJyJqt0BZ7btaOBzlZ9dWCzCQMC01nIcGSc80w+L0bRPnD5SxElrvIeVNj/
 sTM2lnJDpSeJzDU9SvjsDe1KpXKwyam2QjOuwnTS9+wFUoY1IZLGkeXeO45yGynpj7Nn
 cj/+bEcFMKF1wLUay+7PYGQzQTLmO+qQS9G/DOusI+njnJGWztQKOScTbSxdRm8dcbNU
 hMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759179623; x=1759784423;
 h=content-transfer-encoding:subject:references:in-reply-to:message-id
 :cc:to:from:date:mime-version:feedback-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wogJR2283/xFRAufiEcuMu7iWtvkU+S+omUGdr6KEjw=;
 b=uoRwLWyDjzEfnuA4OcWRWExIByXm4N4/Ipfy6dIomg2n+md3gTtestgaDxTHCi8n0H
 jFMs000C/6H+tRag6YQlr3KXWelrDss3OTlPUe8qKNv6NgfsmiH9U5bFEo8hl+Onewxv
 dheVHb4SsxU2gPTAc61gyk7NknKsfvpCMq8e/oaLO8EnVavZyRacuK5yGqfk+HQVxVMK
 /3CpfXTsrZ4Gyk4EOhnlBCoqM5ZBg505TlZaZxK+uwhBYnkKuPAQsptCodA3tHM4XP0Y
 ISdcpzi62EGwIEALmHkgWWUZCh2+AvBplcnx218IvWuyllqDOeVPPk1TnkJH/9WqCkfO
 UVAw==
X-Gm-Message-State: AOJu0YzHE8oZJRPqezGcE6BW9X61c2YrWZ/EEZndqzdYr3z68apdhn33
 1gBnnBPtaqBrOWWqKC9i5ZvE9jZv3k/RY+N22lMadhfN6uaYa4gCD8954MmvYB4HIDOHc+BfoJd
 7Qgst
X-Gm-Gg: ASbGnct60DZrjF1DL8sx6lHSP9CdepPJ8Tm1HFBw8B4F1mtXj8Nv3JJxvIY3ogr9hUX
 lGjkzwJwowtArphrpnx/1C42e3dFQu7xipq2GlsoQ3kkiheNq/7GypP7wbyYl2plIr15BYH18Hv
 mQT8OCG7BJn5M0ninZfaFDzO2NWtVscG3jKL1nRgZNeNII3FpX2IvvMQnYF33vYWNFIFDe5vUic
 ZlN3EByw2cQqTc3JkucvKHtFbXAzaYm6NFigVrLsz9V+zLP3eh4H/UDnN5TVLFtCvl5EIGifmup
 6a9fFjlxuq+89/ZPJRHw3jfgzmaN04CVyK79br3a3VTwJzAqesy0IXviQaIrRogtg3w61M5n1/J
 L4YJP2KQ1Vq2XVZywOwMjJU0mv9TodsqJ95DvrXYO0YQeDfF+q/gu3wXOl07BnEPog4EiyHVlcy
 k6JhBEgEgxxKzofM3hlE4w+tjE
X-Google-Smtp-Source: AGHT+IEU7OqcWJRlHsDRJvZIaBoLLACMq8XEPJvboEbMehtFjHlxwnFx5YJL5qnt+xQk/j1+UD2PTQ==
X-Received: by 2002:a05:622a:606:b0:4b5:ea1f:77ec with SMTP id
 d75a77b69052e-4da41d1c757mr214394311cf.0.1759179621650; 
 Mon, 29 Sep 2025 14:00:21 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com
 (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4db11227c23sm84527231cf.40.2025.09.29.14.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 14:00:21 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfauth.phl.internal (Postfix) with ESMTP id D0381F40068;
 Mon, 29 Sep 2025 17:00:20 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
 by phl-compute-05.internal (MEProxy); Mon, 29 Sep 2025 17:00:20 -0400
X-ME-Sender: <xms:ZPPaaIrzKQVZJWIb0EqlCmuiOUKunhqN5iZ8BtUTeZNYcI58cJ2xYw>
 <xme:ZPPaaJeBce4IYV0LNn7yAuaFfWbRC0YlEh2cVWV5A5Vng-oW0Ox4dzkLt47rA1JM-
 v5fJq483fFxtDKdPD6iP1U_Hc38mJFBXT5Kl6AQwD4TzVaAYepYewI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejledtfecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdflrghvihgv
 rhcuvfhirgdfuceojhgrvhhivghrrdhtihgrsehlihhnrghrohdrohhrgheqnecuggftrf
 grthhtvghrnhephfeftedvhffgieefuedufeduuedvhfeuheetfedtvdekhedtteeviefg
 keehtdeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
 gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfrghsthhmrghilhdomhgvshhmthhp
 rghuthhhphgvrhhsohhnrghlihhthidqudehvdekkeelheekfedqfedufeeigedvleeiqd
 hjrghvihgvrhdrthhirgeppehlihhnrghrohdrohhrghesjhgvthhmrdhmvgdpnhgspghr
 tghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhrihhniheskh
 honhhsuhhlkhhordgtohhmpdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghn
 gidruggv
X-ME-Proxy: <xmx:ZPPaaDVRYLnfgZU-51mFPD557hHXfnsqE7lgvbqwq7Wrlxcq32rBiw>
 <xmx:ZPPaaJh6rnEUWNl1DEhPtap4q0yD9VOC2qDkusfh38lMcBOCVq436A>
 <xmx:ZPPaaG9AVecgAKbf8brDTqDgWtDiLZbKjoJIn1irQ71ZFrZRbpipgg>
 <xmx:ZPPaaLAUHF1AHmFdqmnlT1i_zL7frFF2SAoRHXjI__QK1WTOCgkV6A>
 <xmx:ZPPaaLKhX22rgOzughkwagNxyCmQtI7FvZh_nTSq4mS8cvgzpaIgsYAD>
Feedback-ID: idd3648b2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 95D551EA0068; Mon, 29 Sep 2025 17:00:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: Abu5ZorqbLls
Date: Mon, 29 Sep 2025 15:00:00 -0600
From: "Javier Tia" <javier.tia@linaro.org>
To: "Tom Rini" <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Message-Id: <4a26bcd5-75a0-4dcc-ba2e-8569cbbb031e@app.fastmail.com>
In-Reply-To: <20250929205024.GP6093@bill-the-cat>
References: <20250929-b4-docs-v1-0-a56c1a1856c5@linaro.org>
 <20250929-b4-docs-v1-2-a56c1a1856c5@linaro.org>
 <20250929205024.GP6093@bill-the-cat>
Subject: Re: [PATCH 2/2] b4-config: Simplify configuration by relying on
 default b4 maintainer
Content-Type: text/plain; charset=utf-8
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

Hi Tom,

On Mon, Sep 29, 2025, at 2:50 PM, Tom Rini wrote:
> On Mon, Sep 29, 2025 at 02:39:29PM -0600, Javier Tia wrote:
>
>> Remove explicit settings for send-auto-to-cmd and send-auto-cc-cmd fr=
om
>> the project=E2=80=99s .b4-config. The b4 tool provides sensible defau=
lts that
>> automatically invoke scripts/get_maintainer.pl with recommended
>> parameters, making the custom overrides unnecessary.
>>=20
>> This simplifies the configuration file, reduces maintenance overhead,
>> and ensures contributors benefit from ongoing improvements in b4=E2=80=
=99s
>> built-in maintainer discovery.
>>=20
>> Signed-off-by: Javier Tia <javier.tia@linaro.org>
>
> Sorry, but we just today had the thread on why the upstream defaults
> aren't *quite* right.
>
> https://lore.kernel.org/u-boot/20250929160453.GI6093@bill-the-cat/T/#m=
3d26d2ca4c42d620260fedaeca5f869a41fe26e5

I missed that. Dropping b4-config changes in the next series. Thanks!

> --=20
> Tom
>
> Attachments:
> * signature.asc

--=20
=C2=BB Javier Tia =E2=9C=8D
