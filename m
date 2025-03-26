Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70039C3600E
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 04:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CF9381FBC;
	Thu, 27 Mar 2025 05:24:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="bUjHSCSj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AEAE81951; Wed, 26 Mar 2025 16:48:22 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A80058070C
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 16:48:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE40144289;
 Wed, 26 Mar 2025 15:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1743004098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RNZqAKmyiATM3qHImsGNegQzp3L1dIzmd0VdXa4BPYM=;
 b=bUjHSCSjqucMx+Yo40Qjw8xg4TpATUur3Pf4Vxt8v8bOHypboVVg3gQXCFzyqF1nRYAC1W
 uJRNPzxRllUWn0i63gOJaeS1HWWVPK8Z4xvzyWFRNzxaedbaUxOdQFIHqhuyXJ0CT5EiMT
 XqdTN3g15jn7yZE4F/QjeLiMxMiARCMA4ZTuGRxxr+ao3QoICRnQcle6Nt82zmWW7mtOl0
 8Ao/vtsVY+5/htRx146hFvYNTHTahszdqQbzEx3OhpX/dTUSgi//KCk5kiaiFH8ADs9ByF
 Tsuk5jYYSMsS1vSHfVRd+k7tHHOdyISmVFgJoi65jWnnGCS2e7LtPMMVw64ttA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Adam Ford <aford173@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,  Simon Glass <sjg@chromium.org>,  Jaehoon
 Chung <jh80.chung@samsung.com>,  Lukasz Majewski <lukma@denx.de>,  Sean
 Anderson <seanga2@gmail.com>,  Anatolij Gustschin <agust@denx.de>,  Fabio
 Estevm <festevam@gmail.com>,  Peng Fan <peng.fan@nxp.com>,  Mario Six
 <mario.six@gdsys.cc>,  Svyatoslav Ryhel <clamor95@gmail.com>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  u-boot@lists.denx.de,  Ian Ray
 <ian.ray@gehealthcare.com>,  Michael Nazzareno Trimarchi
 <michael@amarulasolutions.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v5 07/12] clk: imx8mp: Add media related clocks
In-Reply-To: <CAHCN7xLSWwY8Ffi2FVS3fh99wbR5dASLokU2DvAmwdQzwHA7ow@mail.gmail.com>
 (Adam Ford's message of "Wed, 26 Mar 2025 10:39:44 -0500")
References: <20250326-ge-mainline-display-support-v5-0-ea4bc3fc9bca@bootlin.com>
 <20250326-ge-mainline-display-support-v5-7-ea4bc3fc9bca@bootlin.com>
 <CAHCN7xLSWwY8Ffi2FVS3fh99wbR5dASLokU2DvAmwdQzwHA7ow@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 26 Mar 2025 16:48:17 +0100
Message-ID: <875xjvpzcu.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopegrfhhorhguudejfeesghhmrghilhdrtghomhdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehjhhektddrtghhuhhnghesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehluhhkmhgrseguvghngidruggvpdhrtghpthhtohepshgvrghnghgrvdesghhmrghilhdrt
 ghomhdprhgtphhtthhopegrghhushhtseguvghngidruggvpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Thu, 27 Mar 2025 05:24:46 +0100
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

Hello Adam,

On 26/03/2025 at 10:39:44 -05, Adam Ford <aford173@gmail.com> wrote:

> On Wed, Mar 26, 2025 at 10:01=E2=80=AFAM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
>>
>> These are all the clocks needed to get an LCD panel working, going
>> through one of the LCDIF and the LDB. The media AXI and APB clocks are
>> also described.
>>
>
> You might need to rebase off the 'next' branch.  Marek V submitted a
> bunch of clock changes that slightly tweak the way clocks are
> registered and it impacts the parent-child stuff.  I am not sure this
> will apply cleanly anymore.

Thanks a lot for the early warning.

I actually rebased this morning and got the conflicts. But in a second,
look I did it incorrectly. I need to go through this file and rename the
oscillator clock name.

Thanks,
Miqu=C3=A8l
