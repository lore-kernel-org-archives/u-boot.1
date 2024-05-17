Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFB6C25B74
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 02:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89E96883BA;
	Fri, 17 May 2024 04:26:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="LpT7WKlz";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="I64EmAAD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5744088453; Fri, 17 May 2024 04:26:27 +0200 (CEST)
Received: from wfout2-smtp.messagingengine.com
 (wfout2-smtp.messagingengine.com [64.147.123.145])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1D5788318
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 04:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfout.west.internal (Postfix) with ESMTP id 926621C0019F;
 Thu, 16 May 2024 22:26:22 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Thu, 16 May 2024 22:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715912782;
 x=1715999182; bh=tTj93SaIY9EiPn+UO1InH0vNkpmxN2r80gE89i48IQM=; b=
 LpT7WKlz4YH8m4GKNtEjSwWXfMCfZnKm1T8j6BVrUts6WwAFKRI2s22xddnrW7WD
 Mt2MGxfBT8jtDXFOS1RAwTnklgbrRpK5oFH7ukke+iwpEKkJkFMvegfSB8eG388+
 BynVFqEhlm973LusHctp0vi9Otz/MAil9cIxz7XwhmkEFxDRJmWEHev7ojYZPnhc
 GraKrm4hcGZ2HWpqyKMK4AnIWokbqiEXZwC88HxVA5Jhunw5OJFaBtCcsOMteYur
 Te8wWi1210Ccc80F0mXPCWPckxG10dKKRd5y1qtLDD1Dq5N12cevqYQMt7GuGRKv
 FzINXSReTvQWWcZ1rLl5HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715912782; x=
 1715999182; bh=tTj93SaIY9EiPn+UO1InH0vNkpmxN2r80gE89i48IQM=; b=I
 64EmAADiGrZCtKAIud+LtYTlSvfcxHxn3JqQHAS+FVrg9OOJTLo0lXAgX9ZjZJEA
 h7jfrRGHbVR0P93LyQqo094HTaY6LqVwg+Q6NDgX6Z9jZRNrV7jqPLm4+vUyuU/F
 SxxuHaxFhoeqGeNgp15ITjjIdsIoeat7sP343abhXtK/7U7KB2IirI7Ao8+zkhyZ
 2ix3SRf9bemO1dnwR64Ka/eZGPpzpby4vbNCSWBVb/7MXwgRN9l2GP8D4iiDLzP8
 91JQNanOTEY5k0qSTPvrvbgn23O+dlTe3JbRGfaSaqY+uD5ZqFRGsOBnyR4nU9Cu
 zSZY0Gca7cctU0vTR2gMg==
X-ME-Sender: <xms:TsBGZhkunikCriRcrGPsQFCTJIni5OyB_tKmBoi3NrsJv-WkKTeICg>
 <xme:TsBGZs0yxkpKOL_YO3COrJjQpWQ_222z0JQn0x4KmkBIPlHEbeNaJ1L7Fo4-TUCBg
 YlR0vDf5FPY08a2zuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgtdefucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:TsBGZnonZHpR-3IQmPAlJ-7-GbnGPy4bkrynj67elQku95xStl_VcA>
 <xmx:TsBGZhnXd41fw1OtJyKffFFZt1N8seQRXKDaBnIykYzcSj0hLt1RpQ>
 <xmx:TsBGZv3Plhw_jmtr4a1TqyYRJe4jE_-cm163MMhkgR5n3Da-dHvRtw>
 <xmx:TsBGZgt5Nk-ehRbNJ1Arp9ixM5wbqMObmGaAwVXA0xtXtRW0KuQ9IQ>
 <xmx:TsBGZqQd8fdKOA0znBGeH8FOu83tHdswJ0kmxnokI466uUPE_NAGJRJl>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id E844636A0074; Thu, 16 May 2024 22:26:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-456-gcd147058c-fm-hotfix-20240509.001-g0aad06e4
MIME-Version: 1.0
Message-Id: <47734ebf-6c33-4b0c-95fa-3e8986e3d91b@app.fastmail.com>
In-Reply-To: <0664F4C3-6C95-43DF-A283-760A8BCA1811@gmx.de>
References: <20240517-virtio_gpu-v1-0-6353b87472c7@flygoat.com>
 <20240517-virtio_gpu-v1-1-6353b87472c7@flygoat.com>
 <0664F4C3-6C95-43DF-A283-760A8BCA1811@gmx.de>
Date: Fri, 17 May 2024 03:26:04 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: "Tom Rini" <trini@konsulko.com>, "Bin Meng" <bmeng.cn@gmail.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 1/2] virtio: New virtio_gpu driver
Content-Type: text/plain;charset=utf-8
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8817=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8A=E5=
=8D=882:56=EF=BC=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A
[...]
>>+config VIRTIO_GPU_SIZE_X
>>+	int "Width of display (X resolution)"
>>+	default 1280
>
> 1920x1080 would look like a reasonable default for me.

1280x1024 was chosen because it is the largest resolution being defined =
in
VESA VBE, hence guaranteed compatibility everywhere. I think it's Linux's
behaviour as well.

Carving out a huge framebuffer out of memory might be a challenge on
some platforms, so I'd like to keep it small.

>
>
>>+	help
>>+	  Sets the width of the display.
>>+
>>+	  These two options control the size of the display set up by QEMU.
>>+	  Typical sizes are 1024 x 768 or 1280 x 1024.
>>+
>>+config VIRTIO_GPU_SIZE_Y
>>+	int "High of display (Y resolution)"
>>+	default 1024
>>+	help
>>+	  Sets the height of the display.
>>+
>>+	  These two options control the size of the display set up by QEMU.
>>+	  Typical sizes are 1024 x 768 or 1280 x 1024.
>
> Haven't had such small monitors for a while. Why should this be typica=
l?

Haha I copied this from bochs driver's help text, I can replace it with
more reasonable text.

>
> Doesn't QEMU allow to read the size of the output window at runtime?

Unfortunately, it's always guest to determine the size of display.
VIRTIO_GPU_CMD_GET_DISPLAY_INFO simply returned 0 as size of the scanout
before guest initialize it first.

It is possible to parse EDID provided by QEMU to get a resolution list,
but I found implementing the whole modesetting procdure here is a little
bit unnecessary.

I think resizing display in OS is generally done with VMM's guest agent.

>
> Best regards
>
> Heinrich
>

--=20
- Jiaxun
