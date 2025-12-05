Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE9CD2F7D1
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 10:05:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C40C4841DF;
	Fri,  5 Dec 2025 11:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="TtGxb6ux";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F7E84051; Fri,  5 Dec 2025 09:02:36 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEFF783642
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 09:02:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2B9031033CA; Fri,  5 Dec 2025 09:02:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1764921741;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=w7FW65ajDlOxt9PuZ41nsvZzrTZlCORuDzRzCtS9b7w=;
 b=TtGxb6uxiIMUxpBLcSIgf1bPt9oyKH/OJg8PaSh+wMSegHbCmqoY9cfvOasrqsCoZepZ7G
 d36/02Qcfhqx5E16/fk7wT8EH+59eSmCKlrYm2Pv3nAk/wVphfkIpzO9Sqx4aL8x/QLaGN
 dZwYdWstIGgn3eNNuZe9scs7QH/GAcIinqEjDcVHJHO/GABRYBOeCInsbI3k2s1nLrfXZa
 jO/ZIXIFR8OKoCEpEwU0BAjZM58g0X496llJPmjhnbUDwPl/FXZd9RQ+QwH7abPX2zJATL
 ratW6vfqR1RXbxgMuRrpdw+SelpzNidvoxScjmI7M9MLPWvPO+bdeUetoI5CaA==
Message-ID: <6d29ed19-4fd5-afc9-56e2-f4c9df34ff70@nabladev.com>
Date: Fri, 5 Dec 2025 09:02:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 0/6] Add support for SM3 secure hash
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Greg Malysa <malysagreg@gmail.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymondmaoca@gmail.com>, Sean Edmond
 <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Sumit Garg <sumit.garg@kernel.org>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 briansune <briansune@gmail.com>
References: <20251118043042.27726-1-hs@nabladev.com>
 <176487670995.2050783.17410258029578449020.b4-ty@konsulko.com>
 <e2b4a1f7-d915-8e83-2f9b-7f48a56d8e2e@nabladev.com>
 <CAC_iWjJJEG2aUKhNLLY9KgqnROtTbCKd9Ex3-mhviado=r++Cg@mail.gmail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <CAC_iWjJJEG2aUKhNLLY9KgqnROtTbCKd9Ex3-mhviado=r++Cg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Fri, 05 Dec 2025 11:04:35 +0100
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

Hello Ilias,

On 05.12.25 08:24, Ilias Apalodimas wrote:
> On Fri, 5 Dec 2025 at 07:03, Heiko Schocher <hs@nabladev.com> wrote:
>>
>> Hello Tom,
>>
>> On 04.12.25 20:31, Tom Rini wrote:
>>> On Tue, 18 Nov 2025 05:30:36 +0100, Heiko Schocher wrote:
>>>
>>>> Add SM3 secure hash, as specified by OSCCA GM/T 0004-2012 SM3 and described
>>>> at https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02
>>>>
>>>> TPMv2 defines hash algo sm3_256, which is currently
>>>> not supported and prevented TPMv2 chip with newer
>>>> firmware to work with U-Boot. Seen this on a ST33TPHF2XI2C
>>>>
>>>> [...]
>>>
>>> Applied to u-boot/next, thanks!
>>>
>>> [1/6] lib: Import rol32 function from Linux
>>>         commit: 6a0c939b88fd42c6b0a374f7c87317f292df46a1
>>> [2/6] lib: import sm3 256 hash parts from linux
>>>         commit: 41c0131b950a16747929ab310588cf5db8e38123
>>> [3/6] lib: sm3: implement U-Boot parts
>>>         commit: c4ab316269debc321907acc4f8f02dfe5653aeaf
>>> [4/6] test: cmd: hash: add unit test for sm3_256
>>>         commit: 213601a600f1e8894cea76b0bfc131f038882407
>>> [5/6] tpm2: add sm3 256 hash support
>>>         commit: 7c3f05ad51e4bc23dd4f411f28968f1d8f43099c
>>> [6/6] test: cmd: fix a typo in md5 test
>>>         commit: b30557b3b46c5162cb88a57907c517ed95557239
>>
>> Oh, may a little to fast, as Ilias and Quentin had some comments
>> about tpm2 implementation/test (tpm2: add sm3 256 hash support
>> patch). But I can send changes on top of that patches (but
>> give me some time for it... end of year rally has started...)
>>
> 
> Yea I pinged Tom yesterday.
> tbh, my main concern was testing the changes. I dont mind if we revert
> and reapply or send the changes on top.

I am fine with sending updates on top.

bye,
Heiko
> 
> Cheers
> /Ilias
>> bye,
>> Heiko
>>
>> --
>> Nabla Software Engineering
>> HRB 40522 Augsburg
>> Phone: +49 821 45592596
>> E-Mail: office@nabladev.com
>> Geschäftsführer : Stefano Babic

-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
