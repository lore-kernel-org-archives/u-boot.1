Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932ABC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 12:50:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCB1482AC4;
	Tue, 15 Apr 2025 14:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="FEpkQaJb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C339B82047; Tue, 15 Apr 2025 10:15:05 +0200 (CEST)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 607D581F6B
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 10:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8FFBB42E79;
 Tue, 15 Apr 2025 08:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1744704902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IKzGuRlkt/bgYhxnImD97YEhJW4bX0cOyGEmRbh/nz0=;
 b=FEpkQaJbORbj4Kj4AMeJw/ZysEv4fNvBMZa2iVrfdU1KHSZ8DvHmt0u/s5UUYZ/XACvKkB
 IHpUxzEFgUG2QqFSdrSpeFcucwt26V0sMc03PfOTAzhUzme03GCyseUqe1UgR92T4p7t5A
 UaPFLIWykUvlfgXEFy60NyD7IcbE8UT2U6CJQR1oPee9uws8Cb9rqUS3uHl8ga/BBFleIG
 peHVbBBWrfkF4tVTkBflwK7QlSI9rhMzQJ/ng8uhfWtRoUtUpb4aVjyEYhMNBm37FPdeIL
 tPU2XpJZivFyQ87ThPiR/fRWVd4OmMTNwm0AWlQuh4N4iDh4D05cuzoZ6qw+6g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Neha Malcom Francis <n-francis@ti.com>,  Tom Rini <trini@konsulko.com>,
 Nishanth Menon <nm@ti.com>,  Simon Glass <sjg@chromium.org>,  Jaehoon
 Chung <jh80.chung@samsung.com>,  Lukasz Majewski <lukma@denx.de>,  Sean
 Anderson <seanga2@gmail.com>,  Anatolij Gustschin <agust@denx.de>,  Fabio
 Estevm <festevam@gmail.com>,  Peng Fan <peng.fan@nxp.com>,  Mario Six
 <mario.six@gdsys.cc>,  Svyatoslav Ryhel <clamor95@gmail.com>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  u-boot@lists.denx.de,  Ian Ray
 <ian.ray@gehealthcare.com>,  Michael Nazzareno Trimarchi
 <michael@amarulasolutions.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>,  Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v6 05/12] power-domain: Add refcounting
In-Reply-To: <20250415065115.GA10924@francesco-nb> (Francesco Dolcini's
 message of "Tue, 15 Apr 2025 08:51:15 +0200")
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
 <20250403-ge-mainline-display-support-v6-5-478b5e3dd872@bootlin.com>
 <7ae54055-7106-47f3-9e99-c7799f84a0f8@ti.com>
 <20250414180727.5d5zyenfagdc5qw2@unable>
 <20250414200635.GC5495@bill-the-cat>
 <20250414210041.GA8754@francesco-nb>
 <352905ca-4308-4928-9a39-5d9842f1ae9c@ti.com>
 <20250415065115.GA10924@francesco-nb>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 15 Apr 2025 10:15:00 +0200
Message-ID: <87wmblyh6j.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddvleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehmtderredtreejnecuhfhrohhmpefoihhquhgvlhcutfgrhihnrghluceomhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeefleehkefhgeeuhfdtiedtkeduheethfejhfegkefhffdvieeuiefhleevieevnecukfhppeelvddrudekgedruddtkedrvdeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeelvddrudekgedruddtkedrvdeftddphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhhiqhhuvghlrdhrrgihnhgrlhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepfhhrrghntggvshgtohesugholhgtihhnihdrihhtpdhrtghpthhtohepnhdqfhhrrghntghishesthhirdgtohhmpdhrtghpthhtohepthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrtghpthhtohepnhhmsehtihdrtghomhdprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehjhhektddrtghhuhhnghesshgrmhhsuhhnghdrtghom
 hdprhgtphhtthhopehluhhkmhgrseguvghngidruggvpdhrtghpthhtohepshgvrghnghgrvdesghhmrghilhdrtghomh
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

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

Thanks for the report.

>> >>> Neha bisected it down to 197376fbf300e92afa0a1583815d9c9eb52d613a co=
mmit
>> >>> which is this patch.
>> >>
>> >> And assuming it's the same failure I got reported this morning by one=
 of
>> >> my coworkers, we just get:
>> >> U-Boot SPL 2025.04-01050-ga40fc5afaec0 (Apr 14 2025 - 07:31:32 +0000)
>> >> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.2.7--v09.02.07 (Kool Koala)')
>>=20
>> This is not the failure I am seeing, we hang before console comes up so
>> no prints. Looks like the different failure signature is due to TIFS
>> (SYSFW) firmware being different (v9.2.7 vs. 11.0.4)
>
> To me it was failing freezing just after this
>
> U-Boot SPL 2025.04-01076-g739ad58dbee8 (Apr 14 2025 - 17:23:46 +0200)
> SYSFW ABI: 4.0 (firmware rev 0x000b '11.0.7--v11.00.07 (Fancy Rat)')
>
> and, with commit 197376fbf300 ("power-domain: Add refcounting") reverted
> the issue is fixed and I get to the U-Boot command line.

Francesco, are you also testing on K3 platforms?

Can one of you boot with the patch below applied? It should partially
revert the commit to the ancient behaviour, while adding more debug
traces (please enable the debug logs as well). This should clarify
which one of the 3 different path is likely failing. It should also help
identify who's the user that fails to enable/disable its own power
domain. I will need to know what board/SoC was used for the test, so I
can look the relevant driver up.

Thanks for your help,
Miqu=C3=A8l

---


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline;
 filename=0001-HACK-power-domain-Add-debug-traces-without-actually-.patch

From 4b128872b2dbcdfb626b8683fbb6c75d17a5089c Mon Sep 17 00:00:00 2001
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 15 Apr 2025 10:07:05 +0200
Subject: [PATCH] HACK: power-domain: Add debug traces without actually failing

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/power/domain/power-domain-uclass.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/power/domain/power-domain-uclass.c b/drivers/power/domain/power-domain-uclass.c
index a6e5f9ed0369..18ace2cc7256 100644
--- a/drivers/power/domain/power-domain-uclass.c
+++ b/drivers/power/domain/power-domain-uclass.c
@@ -117,10 +117,12 @@ int power_domain_on_lowlevel(struct power_domain *power_domain)
 	struct power_domain_ops *ops = power_domain_dev_ops(power_domain->dev);
 	int ret;
 
-	debug("%s(power_domain=%p)\n", __func__, power_domain);
+	debug("%s(power_domain=%p, id %d)\n", __func__, power_domain, power_domain->id);
 
-	if (priv->on_count++ > 0)
-		return -EALREADY;
+	if (priv->on_count++ > 0) {
+		debug("Power domain %s already on.\n", power_domain->dev->name);
+		//return -EALREADY;
+	}
 
 	ret = ops->on ? ops->on(power_domain) : 0;
 	if (ret) {
@@ -137,15 +139,17 @@ int power_domain_off_lowlevel(struct power_domain *power_domain)
 	struct power_domain_ops *ops = power_domain_dev_ops(power_domain->dev);
 	int ret;
 
-	debug("%s(power_domain=%p)\n", __func__, power_domain);
+	debug("%s(power_domain=%p, id %d)\n", __func__, power_domain, power_domain->id);
 
 	if (priv->on_count <= 0) {
 		debug("Power domain %s already off.\n", power_domain->dev->name);
-		return -EALREADY;
+		//return -EALREADY;
 	}
 
-	if (priv->on_count-- > 1)
-		return -EBUSY;
+	if (priv->on_count-- > 1) {
+		debug("Power domain %s still in use.\n", power_domain->dev->name);
+		//return -EBUSY;
+	}
 
 	ret = ops->off ? ops->off(power_domain) : 0;
 	if (ret) {
-- 
2.48.1


--=-=-=--
