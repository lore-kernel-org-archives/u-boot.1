Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD50C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 12:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC2D182149;
	Thu,  3 Apr 2025 14:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Ct2vdEZ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB89481F6B; Thu,  3 Apr 2025 09:45:05 +0200 (CEST)
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net
 [217.70.183.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2854980194
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 09:45:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9562A44442;
 Thu,  3 Apr 2025 07:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1743666302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=roKpfGS3N/giWeSl0jisb8BR/Uvu0vhSheEDKthRjXM=;
 b=Ct2vdEZ9nGViIbym3JaPF9b2blF4mPplYBsc7+0yRaX3UbPfDFLgWZkZdlVm/hW7tnpszy
 vViwgmerw9KfbVQOSP84u1yAT6ab9vKEt4O0Eht+R0ZgFrsti4McVlsH8XpaVCzdrMFlN+
 K33PamLNVbt2cQ38RqsL857OGFtNb2l7KkAvs8Q0RRC+H5/h5PALvcDEx/7b7AhXmkDXZZ
 seMvkty6KVx/Dk9MRYYxz9tJr2Ph7ZJF3RszpmXWHs1UtbVtywh4F9kGhOgOnhob+j4bfG
 JMw7NzJffg2/wj2YuSJI9xO9usJxxVTmh4zOMZyi3FJVyf1ljxLN8Fu7Hg38LQ==
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
Subject: Re: [PATCH v5 03/12] dm: core: Add a helper to retrieve devices
 through graph endpoints
In-Reply-To: <CAPVz0n2YYXQKNyXFFDZxm83n4egWd2DbeuiudZsLcBAZn8h4JQ@mail.gmail.com>
 (Svyatoslav Ryhel's message of "Wed, 26 Mar 2025 18:47:29 +0200")
References: <20250326-ge-mainline-display-support-v5-0-ea4bc3fc9bca@bootlin.com>
 <20250326-ge-mainline-display-support-v5-3-ea4bc3fc9bca@bootlin.com>
 <CAPVz0n2YYXQKNyXFFDZxm83n4egWd2DbeuiudZsLcBAZn8h4JQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 03 Apr 2025 09:45:00 +0200
Message-ID: <87tt75ofib.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeektddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledvrddukeegrdduuddtrdduleelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrddukeegrdduuddtrdduleelpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopegtlhgrmhhorhelheesghhmrghilhdrtghomhdprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehjhhektddrtghhuhhnghesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehluhhkmhgrseguvghngidruggvpdhrtghpthhtohepshgvrghnghgrvdesghhmrghil
 hdrtghomhdprhgtphhtthhopegrghhushhtseguvghngidruggvpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhm
X-GND-Sasl: miquel.raynal@bootlin.com
X-Mailman-Approved-At: Thu, 03 Apr 2025 14:36:19 +0200
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


>> +int uclass_get_device_by_endpoint(enum uclass_id class_id, struct udevi=
ce *dev,
>> +                                 int port_idx, int ep_idx, struct udevi=
ce **devp)
>> +{
>> +       ofnode node_source =3D dev_ofnode(dev);
>> +       ofnode node_dest =3D ofnode_graph_get_remote_node(node_source, p=
ort_idx, ep_idx);
>
> You may use dev_ofnode(dev) directly instead of node_source if you
> wish, but that is up to you.

I prefer the organization as is it, because it makes it clear what is
the source and what is the dest.

>> +       struct udevice *target =3D NULL;
>> +       int ret;
>> +
>> +       if (!ofnode_valid(node_dest))
>> +               return -EINVAL;
>> +
>> +       ret =3D uclass_find_device_by_ofnode(class_id, node_dest, &targe=
t);
>
> You can use uclass_get_device_by_ofnode here and avoid using
> uclass_get_device_tail later.

Crap, I forgot I had this one to handle as well, this is an interesting
change. I will send a followup patch.

Thanks,
Miqu=C3=A8l
