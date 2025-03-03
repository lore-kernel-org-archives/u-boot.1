Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF3EC282C5
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 08:43:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80C1480F70;
	Mon,  3 Mar 2025 09:43:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="JrSGJmEY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E00E0810ED; Mon,  3 Mar 2025 09:43:49 +0100 (CET)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF07D809A5
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 09:43:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C1AF5443CB;
 Mon,  3 Mar 2025 08:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1740991405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gj/uvf/0zD8A23vQt6YySfgNJbFGDBmksH1cqgAyOMg=;
 b=JrSGJmEYlmCZe0pv7C/+KRJDWsIHq45xk971/2oPa4xCIixj1MlnHkTBcRKJ/V4UFAivzP
 ZpgKnjEefOol5bFoHgcA9AT3m137//+P/zaKpCzxVtlC1RQxtPKqk4/rdyP1Sk963ZSJUx
 XrfV2LzLNXdzFLfR0qaPEvTcIAtxs6HKTk9YiA0QlsOVZi07h4BFSlspzLOu+l4I75mNIo
 YyBcAFRLRhIE8GPtjacVLVO8e5ejSmF2vCesUzzU7xiLfhrwIctB0EeKkibsugDCZHy18t
 prJ4MEidfcjssUUmhFNSszobqb7Qm5HSEtgxK+TZsCjTElVJvpLsQcphoNUrjg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Simon Glass <sjg@chromium.org>,  Tom Rini <trini@konsulko.com>,  Jaehoon
 Chung <jh80.chung@samsung.com>,  Lukasz Majewski <lukma@denx.de>,  Sean
 Anderson <seanga2@gmail.com>,  Anatolij Gustschin <agust@denx.de>,  Peng
 Fan <peng.fan@nxp.com>,  Mario Six <mario.six@gdsys.cc>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  u-boot@lists.denx.de,  Ian Ray
 <ian.ray@gehealthcare.com>,  Michael Nazzareno Trimarchi
 <michael@amarulasolutions.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 05/12] power-domain: Add refcounting
In-Reply-To: <CAOMZO5BwB75QnfYKkcnq_kS_7N8yXzLNdpyzcWQ2Jy3zu9V1NQ@mail.gmail.com>
 (Fabio Estevam's message of "Sat, 8 Feb 2025 08:09:30 -0300")
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
 <20250129-ge-mainline-display-support-v4-5-a43b3657ed7c@bootlin.com>
 <CAOMZO5BwB75QnfYKkcnq_kS_7N8yXzLNdpyzcWQ2Jy3zu9V1NQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 03 Mar 2025 09:43:24 +0100
Message-ID: <87y0xma4ib.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffgffkfggtgfgsehtqhertddtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffeghfejtdefieeguddukedujeektdeihfelleeuieeuveehkedvleduheeivdefnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhjghestghhrhhomhhiuhhmrdhorhhgpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepjhhhkedtrdgthhhunhhgsehsrghmshhunhhgrdgtohhmpdhrtghpthhtoheplhhukhhmrgesuggvnhigrdguvgdprhgtphhtthhopehsvggrnhhgrgdvsehgmhgrihhlrdgto
 hhmpdhrtghpthhtoheprghguhhsthesuggvnhigrdguvgdprhgtphhtthhopehpvghnghdrfhgrnhesnhigphdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com
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

Hello Simon,

On 08/02/2025 at 08:09:30 -03, Fabio Estevam <festevam@gmail.com> wrote:

> Hi Simon,
>
> On Wed, Jan 29, 2025 at 7:22=E2=80=AFAM Miquel Raynal <miquel.raynal@boot=
lin.com> wrote:
>>
>> It is very surprising that such an uclass, specifically designed to
>> handle resources that may be shared by different devices, is not keeping
>> the count of the number of times a power domain has been
>> enabled/disabled to avoid shutting it down unexpectedly or disabling it
>> several times.
>>
>> Doing this causes troubles on eg. i.MX8MP because disabling power
>> domains can be done in recursive loops were the same power domain
>> disabled up to 4 times in a row. PGCs seem to have tight FSM internal
>> timings to respect and it is easy to produce a race condition that puts
>> the power domains in an unstable state, leading to ADB400 errors and
>> later crashes in Linux.
>>
>> CI tests using power domains are slightly updated to make sure the count
>> of on/off calls is even and the results match what we *now* expect.
>>
>> As we do not want to break existing users while stile getting
>> interesting error codes, the implementation is split between:
>> - a low-level helper reporting error codes if the requested transition
>>   could not be operated,
>> - a higher-level helper ignoring the "non error" codes, like EALREADY and
>>   EBUSY.
>>
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> Are you happy with this version?

Would you have any feedback on this? I believe we agreed on the
implementation but it's been a month and I didn't heard back from you
since then, and I believe Fabio was waiting for your feedback.

Thanks a lot,
Miqu=C3=A8l
