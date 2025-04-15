Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21522C369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 12:51:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA70782B16;
	Tue, 15 Apr 2025 14:50:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Y55J0N44";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24EA98294C; Tue, 15 Apr 2025 14:44:04 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::221])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61F0B8214B
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 14:44:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D54AE43A21;
 Tue, 15 Apr 2025 12:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1744721040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m8OIvEqsLFAu9sGMQMgIhJryM6Tuok4G/rF4uAeYRuA=;
 b=Y55J0N44STypasI092jQ1RTF8D3Fy8TiLu7d8wzP+TrifQko0HDg9b7JKeKove7h/9ZhtG
 34AS1iWI7GO78OyO4MaU1HbR1AdrvtmOp89MZ6SgUY4PB/pLnE3YmTxhI1oBv/jSkwyCZs
 y6LAJ2fZUE6Xa4wlTCgP5bWtQE+q9oQW8Qj7sC4seMjQWv61mpfEIGge1wXq6lOkPQI6Yy
 rTBc90Btg4d0PIFeX7p6azB/3VN8qLZjdpM8Co7IWr2TehGHfKZ70XIW5RTbh10OXyt3ZK
 fyHeZmN//rLwYiLaQi21ek20LbIi+7Fm9Pp5Ylsp9telvoksFBmu+FbD/DD2RQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Neha Malcom Francis <n-francis@ti.com>
Cc: Francesco Dolcini <francesco@dolcini.it>,  Tom Rini
 <trini@konsulko.com>,  Nishanth Menon <nm@ti.com>,  Simon Glass
 <sjg@chromium.org>,  Jaehoon Chung <jh80.chung@samsung.com>,  Lukasz
 Majewski <lukma@denx.de>,  Sean Anderson <seanga2@gmail.com>,  Anatolij
 Gustschin <agust@denx.de>,  Fabio Estevm <festevam@gmail.com>,  Peng Fan
 <peng.fan@nxp.com>,  Mario Six <mario.six@gdsys.cc>,  Svyatoslav Ryhel
 <clamor95@gmail.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 <u-boot@lists.denx.de>,  Ian Ray <ian.ray@gehealthcare.com>,  Michael
 Nazzareno Trimarchi <michael@amarulasolutions.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>,  Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v6 05/12] power-domain: Add refcounting
In-Reply-To: <2a006764-d335-490a-9bb4-1fdb5f851df4@ti.com> (Neha Malcom
 Francis's message of "Tue, 15 Apr 2025 15:29:09 +0530")
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
 <20250403-ge-mainline-display-support-v6-5-478b5e3dd872@bootlin.com>
 <7ae54055-7106-47f3-9e99-c7799f84a0f8@ti.com>
 <20250414180727.5d5zyenfagdc5qw2@unable>
 <20250414200635.GC5495@bill-the-cat>
 <20250414210041.GA8754@francesco-nb>
 <352905ca-4308-4928-9a39-5d9842f1ae9c@ti.com>
 <20250415065115.GA10924@francesco-nb> <87wmblyh6j.fsf@bootlin.com>
 <1d83aeee-7399-4467-8b4b-fdcde9f8e192@ti.com>
 <87sem9wy6e.fsf@bootlin.com>
 <2a006764-d335-490a-9bb4-1fdb5f851df4@ti.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 15 Apr 2025 14:43:57 +0200
Message-ID: <87jz7lwq5u.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefhedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeelveetiedufedugfejveehvefgvefgvdehleefkedutedtffevhfegjeeggfekkeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecukfhppeelvddrudekgedruddtkedrvdeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrvdeftddphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepnhdqfhhrrghntghishesthhirdgtohhmpdhrtghpthhtohepfhhrrghntggvshgtohesugholhgtihhnihdrihhtpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepnhhmsehtihdrtghomhdprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehjh
 hektddrtghhuhhnghesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehluhhkmhgrseguvghngidruggvpdhrtghpthhtohepshgvrghnghgrvdesghhmrghilhdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Tue, 15 Apr 2025 14:50:26 +0200
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

On 15/04/2025 at 15:29:09 +0530, Neha Malcom Francis <n-francis@ti.com> wro=
te:

> Hi Miquel
>
> On 15/04/25 15:20, Miquel Raynal wrote:
>>>> Francesco, are you also testing on K3 platforms?
>>>>
>>>
>>> Yes he would be, since the firmware print is K3 firmware.
>>>
>>>> Can one of you boot with the patch below applied? It should partially
>>>> revert the commit to the ancient behaviour, while adding more debug
>>>> traces (please enable the debug logs as well). This should clarify
>>>> which one of the 3 different path is likely failing. It should also he=
lp
>>>> identify who's the user that fails to enable/disable its own power
>>>> domain. I will need to know what board/SoC was used for the test, so I
>>>> can look the relevant driver up.
>>>
>>> Booted on j784s4_evm
>>>
>>> https://gist.github.com/nehamalcom/b09687a523bec89f9df3537fdd99b6f3
>
> ^

Ah, sorry! This is very interesting.

There are two things which I do not understand:
- if we look at the very first power domains, their id is 15 and 14
  respectively. I do not see these numbers in any device tree, am I
  looking incorrectly? Could you help me identify what are the devices
  requesting these IDs?
- all power domains appear to be already enabled the very first time we
  enable them. I believe this is the root cause of the problem, as they
  should have count_on to 0 when booting. I checked again,
  'per_device_auto' is a field that is zeroed when allocated (using
  calloc() in this case) so I am really puzzled about this. It looks
  like "something else" is using this data field, which would be
  wrong.

>>>
>>> Currently debugging on my build where I hang in console_init itself, I
>>> think the path for failure is different here, will confirm.
>>=20
>> Thanks a lot for your feedback. Normally by applying the diff shared in
>> my previous e-mail, you should have the console back. If not, maybe
>> there is something else involved and the blamed commit is just the first
>> showing an underlying problem.
>
> I do have console back with that patch, see the gist link above. What I
> meant was the path of failure seems to be different, it's looking like
> with my version of firmware the serial driver probe
> (ns16550_serial_probe) tries to do a readb() and fails, this could
> possibly be because the device was not powered on to begin with. Whereas
> in another case (what Francesco is seeing), this issue is not run
> into.

Clear.

Could you make another round with this extra change?

Thanks!
Miqu=C3=A8l

--- a/drivers/power/domain/power-domain-uclass.c
+++ b/drivers/power/domain/power-domain-uclass.c
@@ -119,14 +119,18 @@ int power_domain_on_lowlevel(struct power_domain *pow=
er_domain)
=20
        debug("%s(power_domain=3D%p, id %d)\n", __func__, power_domain, pow=
er_domain->id);
=20
-       if (priv->on_count++ > 0) {
-               debug("Power domain %s already on.\n", power_domain->dev->n=
ame);
+       if (priv->on_count > 0) {
+               debug("Power domain %s already on (usage count: %d).\n", po=
wer_domain->dev->name, priv->on_count);
+               priv->on_count++;
                //return -EALREADY;
+       } else {
+               priv->on_count++;
        }
=20
        ret =3D ops->on ? ops->on(power_domain) : 0;
        if (ret) {
                priv->on_count--;
+               debug("Power domain %s on failed (usage count: %d).\n", pow=
er_domain->dev->name, priv->on_count);
                return ret;
        }
=20
