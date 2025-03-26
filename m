Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F122FC36010
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 04:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6474681FDE;
	Thu, 27 Mar 2025 05:24:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="CcuHGQA7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52902810E8; Wed, 26 Mar 2025 17:47:24 +0100 (CET)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [217.70.183.193])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C781281D25
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 17:47:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 645E444349;
 Wed, 26 Mar 2025 16:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1743007640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XFpsh709Q0eKXjU+UHaYU6FE9HGTILTHSQuQ0sWReos=;
 b=CcuHGQA7vdL3SC2bMKs+yymn3hKv0ydMRCqq3KGSK/xOMo9qpkJGcnCXRl+FfhGUR8Wpol
 Xx9H4utu9U+tqgj38PsHgaigYFjLnzO2yhzadcdTJKUEbvRYn1Hf0svn/iaTs3sa60tx0d
 jhrETE5Fcvu+cL1zEP3RaZZ93t+qYbFRPLfO6dzCN4NsRvIPtHr96aNIOFcdWJfkT4vjLZ
 fl0RIqrLwJwTGetkj/Nz0DSfzRIKl+WyTiH0BA1zDGfu3oxFbg5HOioHvfEJCxBfUGGEhP
 7baEydZdpysG++wIwl/qUAi3Zh+ZBVlekjpfsqPerD7uqXMDG7YmIMknnErvcQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,  Simon Glass <sjg@chromium.org>,  Jaehoon
 Chung <jh80.chung@samsung.com>,  Lukasz Majewski <lukma@denx.de>,  Sean
 Anderson <seanga2@gmail.com>,  Anatolij Gustschin <agust@denx.de>,  Fabio
 Estevm <festevam@gmail.com>,  Peng Fan <peng.fan@nxp.com>,  Mario Six
 <mario.six@gdsys.cc>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de,  Ian Ray <ian.ray@gehealthcare.com>,  Michael
 Nazzareno Trimarchi <michael@amarulasolutions.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v5 01/12] core: ofnode: Fix a comment
In-Reply-To: <CAPVz0n0hZCXEEwrE=22SV_c-L9=7GfL1B=sCrY-6cddEQuTESg@mail.gmail.com>
 (Svyatoslav Ryhel's message of "Wed, 26 Mar 2025 18:31:02 +0200")
References: <20250326-ge-mainline-display-support-v5-0-ea4bc3fc9bca@bootlin.com>
 <20250326-ge-mainline-display-support-v5-1-ea4bc3fc9bca@bootlin.com>
 <CAPVz0n0hZCXEEwrE=22SV_c-L9=7GfL1B=sCrY-6cddEQuTESg@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 26 Mar 2025 17:47:19 +0100
Message-ID: <87tt7foi20.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeitdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopegtlhgrmhhorhelheesghhmrghilhdrtghomhdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehjhhektddrtghhuhhnghesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehluhhkmhgrseguvghngidruggvpdhrtghpthhtohepshgvrghnghgrvdesghhmrghilhdrt
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

Hello,

On 26/03/2025 at 18:31:02 +02, Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D1=81=D1=80, 26 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 17:01 Mi=
quel Raynal <miquel.raynal@bootlin.com> =D0=BF=D0=B8=D1=88=D0=B5:
>>
>> Naming between the parameter list, the prototype and the main comment do
>> not match. Fix the comment which seems the be the one that is incorrect.
>>
>> Fixes: 9057077cf4e1 ("core: ofnode: add of_graph parsing helpers")
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> ---
>>  drivers/core/ofnode_graph.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>
> If you will be rebasing it once more, adjust please commit title to
> "core: ofnode_graph: ..." since this commit targets existing
> ofnode_graph.c file. Thank you.
>
> That is not mandatory if the rest of your patches are accepted.

There will be one, I'll fix it.

> Reviewed-by: Svyatoslav Ryhel <clamor95@gmail.com>

Thanks,
Miqu=C3=A8l
