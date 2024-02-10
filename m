Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0F4C48260
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 11:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AB7187E82;
	Sat, 10 Feb 2024 12:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jannau.net header.i=@jannau.net header.b="c5UPlpPn";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="jgH72y4I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 197EE87E46; Sat, 10 Feb 2024 12:47:25 +0100 (CET)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D453487E82
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 12:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=j@jannau.net
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 8BBBF3200A35;
 Sat, 10 Feb 2024 06:47:15 -0500 (EST)
Received: from imap53 ([10.202.2.103])
 by compute1.internal (MEProxy); Sat, 10 Feb 2024 06:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1707565635;
 x=1707652035; bh=00eD3loMNo5Ay59CAZ+j8IM2Qj6lZ/j+m9yLaidThzI=; b=
 c5UPlpPn+SQrjYmE9sOavRkQjs5RnEl1H0QlvGkNM/KwR+u6ZOLeEmmzwHJeP1V8
 spPyvJM2y0r1mN4A0Ym9L0aETuJYPCZ4LAWCXtiyr4ecLz/vAGkoLRrHVih4Vfxw
 1S+hFydChKhGt5tcisMy7/Ct9Qk/BPm3DRpFLbRrjduX2NKE7zRJU3bvQBEHgTmC
 zTJ3yj+fJhGHNpk5XPLoirWcncox3wzvlcxUbPEbmTg1av1SRXswUhTWasPDCeMG
 hG6lXGKqOhz894zy2Db6VqM4xmZhijIU0xxCjv1/QUds2zA/OTrUPZi1vCfNkX1y
 uS7TlSPvsJePGUeVh8g4fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707565635; x=
 1707652035; bh=00eD3loMNo5Ay59CAZ+j8IM2Qj6lZ/j+m9yLaidThzI=; b=j
 gH72y4IvaFn6W9ZxUgq6GAv84TUgK3OHOu8cMRQE7wF58AlN4Z1m7FmMCzwhH0di
 rokz4uDBor/0BK7gNZsecJh4u8JpBI/QnwBNhoH2Pf3lVh6dtYdAQsD1dYUhcg5o
 Le+uabIirL/t35l8jgtUu4BDr3ad3R4/fTnL5UocQdA8EuBdV+LUX+SyJIQdudd3
 j55eNLhl8qlY1c/essbIpP9rNLSuaR1I9VOpvmi9ZAZICjSnLyBil8oYjIS8lqBF
 tAjIubyiuh59Jo4yOUuLLvp+MLDFxY+jMDAjgrgJ2ejRXECqpdXuoh9wx2mdsCJo
 84j0RRzzx/5P5aQfR5gDQ==
X-ME-Sender: <xms:QmLHZTQd5xHco1lrwJgsBtim-Jjpc8Fqb2FuC-3RgBWmaNmHahbZDQ>
 <xme:QmLHZUxDio_jY_kgCt8VKhMt8SZHB42lQn4l2tgZXZzzp6cbL6yt5nEQSVpl3RXA_
 zNpcG6aVz24w2ZH2Ac>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdelgddtjecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfgr
 nhhnvgcuifhruhhnrghufdcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvg
 hrnhepvdefteetfedtvefghfeuueetleeuledugfefleegffeltdevtddtudfhjeevledv
 necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjh
 grnhhnrghurdhnvght
X-ME-Proxy: <xmx:QmLHZY1HxT-vO4X9PHFjWZM6EySemtoKfwmwpaLNdLojwpKDgyT_9g>
 <xmx:QmLHZTCRJ-acDkny8s8oMpQEWEWHDUoiwPnaRN4C-moeeQ-iG5EYUw>
 <xmx:QmLHZci1zT-UsJoAPAdXYIkuuyjb7tLso1AbQ_vuBjgXLI7LPKymVQ>
 <xmx:Q2LHZVstKR8zXmtPPPFLIpHtYYN7zMcorAc87AAEa5NRRX2bRTthRw>
Feedback-ID: i47b949f6:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id C522E364006B; Sat, 10 Feb 2024 06:47:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
MIME-Version: 1.0
Message-Id: <73a96d9b-0001-44ff-8444-fe5ed9ab7082@app.fastmail.com>
In-Reply-To: <e49eb6ec-fbca-492a-aa7b-7f8cf8b0c1cb@gmx.de>
References: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
 <20240117-vidconsole-utf8-uefi-v1-4-539f7ce74fb9@jannau.net>
 <e49eb6ec-fbca-492a-aa7b-7f8cf8b0c1cb@gmx.de>
Date: Sat, 10 Feb 2024 12:46:53 +0100
From: "Janne Grunau" <j@jannau.net>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>
Cc: "Simon Glass" <sjg@chromium.org>,
 "Andre Przywara" <andre.przywara@arm.com>, u-boot@lists.denx.de,
 "Anatolij Gustschin" <agust@denx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH RFC 4/6] efi_selftest: Add international characters test
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

Hej,

On Thu, Jan 18, 2024, at 19:48, Heinrich Schuchardt wrote:
> On 1/17/24 23:24, Janne Grunau via B4 Relay wrote:
>> From: Andre Przywara <andre.przywara@arm.com>
>>
>> UEFI relies entirely on unicode output, which actual fonts displayed =
on
>> the screen might not be ready for.
>>
>> Add a test displaying some international characters, to reveal missing
>> glyphs, especially in our builtin fonts.
>
> How would I detect missing Bengali and Gujarati glyphs with this test?

Only by knowing what to expect or to check the test code.

> What might help would be an output of the Unicode entries in the font =
in
> parallel with the glyph.

I'm not sure how useful it would be to extend the amount of text to regi=
ster during the test. Even with the 3 second wait added in the the box d=
rawing test time is short to check the results. Running the tests option=
ally with pagination might be an option.

>      U+0040, @
>      U+0041, A
>      U+0A85. =E0=AA=85
>      U+0A86. =E0=AA=86
>      U+0A87. =E0=AA=87
>      U+0A88. =E0=AA=88
>      U+0A89. =E0=AA=89
>
> This would require some new command but not an EFI test.

Wouldn't we need both? Console tests to check if the intended glyphs are=
 shown would be useful but the EFI selftest should still tests that it c=
an render UTF-8 correctly (partial support on cp437 bitmap font consoles=
).

Best regards
Janne
