Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737D8C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 12:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C46E381335;
	Thu,  6 Mar 2025 13:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="cRprOfVo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A563281417; Thu,  6 Mar 2025 13:51:21 +0100 (CET)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::228])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 580A9805D7
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 13:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EFB8E443E3;
 Thu,  6 Mar 2025 12:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1741265478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AstUznNHHqpif+6MUfr6qC4/r9fEoq9gf6lR25RaZpU=;
 b=cRprOfVoTENLNvwWX1FVRnCi9bDLx2p9UneU1MsXLxEv+yneoqwr/1hnTNJAJkWnXuToDe
 JNrtErsj3LhPH7xV/SUzvOoQr+44iD55mT+sbC/MUFF25MTWpMY2vFw7Chd6xdVQsYV7J5
 mFaiQIVADzyAvzMbXRwI209kGV/i/bVEfvL9Zezmj/6PmeLbNJ3uqDJIPlKf7JTDXZyjCw
 SafmwJu7HSCmt0T9O2EgFaTBTfdOSbfX3xXlcDYlHu/dp6Ux3DLLHNftACHuFZfRn8QSLQ
 ZxdewGTtcmCfj100j8Bx7u+QuKoVBc89Gvd6VJl5ay0ggKQsEyKhK709opXLDQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>,  Svyatoslav Ryhel <clamor95@gmail.com>,
 Simon Glass <sjg@chromium.org>,  Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>,  Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,  Peng Fan <peng.fan@nxp.com>,  Mario
 Six <mario.six@gdsys.cc>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  u-boot@lists.denx.de,  Ian Ray
 <ian.ray@gehealthcare.com>,  Michael Nazzareno Trimarchi
 <michael@amarulasolutions.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 00/12] Add imx8mp video support
In-Reply-To: <CAOMZO5D_WeB+iv3YzVeBbfL3o1Wr250aM3+phGe7i9Luus9uzQ@mail.gmail.com>
 (Fabio Estevam's message of "Thu, 6 Mar 2025 09:38:29 -0300")
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
 <CAOMZO5BGBv_hM30W+_J8AS_X3fqj6MXy8DYDhoyROdC89=k7aQ@mail.gmail.com>
 <20250303170640.GS2640854@bill-the-cat>
 <CAOMZO5BTCir859QDcR9XEDTnc4JnMHdCSLXTe94Z9z_FY5bwbg@mail.gmail.com>
 <20250305181703.GW2640854@bill-the-cat>
 <CAOMZO5D_WeB+iv3YzVeBbfL3o1Wr250aM3+phGe7i9Luus9uzQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 06 Mar 2025 13:51:17 +0100
Message-ID: <87pliutj96.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejkeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopegtlhgrmhhorhelheesghhmrghilhdrtghomhdprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehjhhektddrtghhuhhnghesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehluhhkmhgrseguvghng
 idruggvpdhrtghpthhtohepshgvrghnghgrvdesghhmrghilhdrtghomhdprhgtphhtthhopegrghhushhtseguvghngidruggv
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

Hi Fabio,

On 06/03/2025 at 09:38:29 -03, Fabio Estevam <festevam@gmail.com> wrote:

> On Wed, Mar 5, 2025 at 3:17=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
>> The series is delayed until someone has a chance to look harder at
>> what's causing the handoff test to now fail.
>
> Ok, I marked this series as "Changes Requested" in patchwork.
>
> Miquel, please make sure the next version passes CI.

Why not just waiting for someone to tackle this issue with the CI? The
handoff test is failing, there is nothing that can go through any tree
at the moment, no? It is not just blocking this series in particular, I
guess?
