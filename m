Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA23C36010
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 04:24:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 467C381D6C;
	Thu, 27 Mar 2025 05:24:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="iqyig8oK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A3B581951; Wed, 26 Mar 2025 16:01:19 +0100 (CET)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::226])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12EFE803CC
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 16:01:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A582944264;
 Wed, 26 Mar 2025 15:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1743001275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YyZTnJbI6gx1p0lJTm9YdlbQedAIEgckuOtR/7wtfd0=;
 b=iqyig8oK7V6s/UgzTygipH24mdDoX1+tKXtAXfkrYSKF/RCsyAEnPqwnon+RGImGJhAuGG
 4vP3D6amSJUW3sr2n5QHS2pyWYpNMENO8VbghSRVPpujA1uJuzvrHhNFqjTssaRCZ2zeSL
 fCSW29VuoeSLLIPJwwMa1RnVlzoQt3dyPAsR2DU5g7SWz/zwPyaCY5R92iuLFYZ/06FDfa
 xoAEa6MCa0/4tX5jdzqtYl/pYOTPBRMfqEU4nnGDd66eDOL0wCO00Li/c+Oc6pFqnxlZ2R
 cm4e1omtMbLtpCZH57Nz7Py4sC2AK3zPadmLuy96McBB8ZaKTjo+sjWL9+C58Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>,  Tom Rini <trini@konsulko.com>,
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
In-Reply-To: <CAOMZO5BMZi3adJCcxVq3-04YY8yAAVqkdcy8Q1tMzMsK+W0rEA@mail.gmail.com>
 (Fabio Estevam's message of "Thu, 13 Mar 2025 15:26:30 -0300")
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
 <CAOMZO5BGBv_hM30W+_J8AS_X3fqj6MXy8DYDhoyROdC89=k7aQ@mail.gmail.com>
 <20250303170640.GS2640854@bill-the-cat>
 <CAPVz0n01g9JghOb1JCPg1sCwOf-w0AcjMZRngGZbAK_C_VhGcA@mail.gmail.com>
 <CAOMZO5BMZi3adJCcxVq3-04YY8yAAVqkdcy8Q1tMzMsK+W0rEA@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 26 Mar 2025 16:01:14 +0100
Message-ID: <87pli3q1j9.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopegtlhgrmhhorhelheesghhmrghilhdrtghomhdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehjhhektddrtghhuhhnghesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehluhhkmhgrseguvghng
 idruggvpdhrtghpthhtohepshgvrghnghgrvdesghhmrghilhdrtghomhdprhgtphhtthhopegrghhushhtseguvghngidruggv
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

Hi Fabio,

On 13/03/2025 at 15:26:30 -03, Fabio Estevam <festevam@gmail.com> wrote:

> Hi Miquel,
>
> On Mon, Mar 3, 2025 at 2:15=E2=80=AFPM Svyatoslav Ryhel <clamor95@gmail.c=
om> wrote:
>
>> If seems that we are working on the same OF graph stuff
>
> Yes, there is a conflict in next when I try to apply your series due
> to recent commits from Svyatoslav.
>
> Please rebase against the latest next, run it through CI, and submit a
> v5.

I rebased this work on the latest next, fixed the conflicts, adapted my
changes to use Svyatoslav's work, fixed the CI.

Then I pushed a PR to trigger azure tests and figured out you applied more
patches (imx8 clock related) which conflicted. So I rebased again and
fixed the conflicts.

Azure testing is failing though. I just pushed an empty branch with just
today's 'next' and it is already failing, my series does not produce
additional warnings as far as I can see.

So I am sending a series that has been tested locally. dm unit tests
pass, v5 is on its way.

Thanks,
Miqu=C3=A8l
