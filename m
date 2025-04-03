Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB08C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 12:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EAAB8215E;
	Thu,  3 Apr 2025 14:36:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Jca99spd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7F3481F69; Thu,  3 Apr 2025 10:08:18 +0200 (CEST)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
 [217.70.183.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94F2180194
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 10:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F07BA43290;
 Thu,  3 Apr 2025 08:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1743667696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B6wI/EQzRsuWr+QiNDX6NsfsOyiyryzbQDcG5ad0liI=;
 b=Jca99spdmMMNflQRegB8Npg0Dgo4Qp7nUuPiPP2WblO2clolWdaUgbqhvkCgXpneFII7mn
 CkqaKk49Wc8CBpSp1klUoGikwZ6yexVjs7EIGz/nTVkNT6HPi7mFie1OUoo0+uSOuSwHo+
 fQm0MgF3jLByOb7TPFYR+d65hJ+9PwzXGNAqeTkZw2NyWPQ9LY/HK2XbHEN2A/IQQBCpj7
 g2xn5rSosXerWtc6StIhrXTY0uIU6GnHzJkflK9wjJe+uzD8FQrBTJgLww4BT28A2Kbsgo
 o4fVpbu8u+OkUiodtWhdprHioi1D5bXiGNe/BwlztOTmQTonXvyTpfvWKpD4MA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,  Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>,  Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,  Fabio Estevm <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>,  Mario Six <mario.six@gdsys.cc>,  Svyatoslav
 Ryhel <clamor95@gmail.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  u-boot@lists.denx.de,  Ian Ray
 <ian.ray@gehealthcare.com>,  Michael Nazzareno Trimarchi
 <michael@amarulasolutions.com>,  Dario Binacchi
 <dario.binacchi@amarulasolutions.com>,  Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v6 03/12] dm: core: Add a helper to retrieve devices
 through graph endpoints
In-Reply-To: <20250403-ge-mainline-display-support-v6-3-478b5e3dd872@bootlin.com>
 (Miquel Raynal's message of "Thu, 03 Apr 2025 09:39:03 +0200")
References: <20250403-ge-mainline-display-support-v6-0-478b5e3dd872@bootlin.com>
 <20250403-ge-mainline-display-support-v6-3-478b5e3dd872@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 03 Apr 2025 10:08:14 +0200
Message-ID: <87cydtoefl.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeektdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledvrddukeegrdduuddtrdduleelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepledvrddukeegrdduuddtrdduleelpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedujedprhgtphhtthhopehtrhhinhhisehkohhnshhulhhkohdrtghomhdprhgtphhtthhopehsjhhgsegthhhrohhmihhumhdrohhrghdprhgtphhtthhopehjhhektddrtghhuhhnghesshgrmhhsuhhnghdrtghomhdprhgtphhtthhopehluhhkmhgrseguvghngidruggvpdhrtghpthhtohepshgvrghnghgrvdesghhmrghilhdrtghomhdprhgtphhtthhopegrghhushhtseguvghngidruggvp
 dhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvnhhgrdhfrghnsehngihprdgtohhm
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


> +int uclass_get_device_by_endpoint(enum uclass_id class_id, struct udevic=
e *dev,
> +				  int port_idx, int ep_idx, struct udevice **devp)
> +{
> +	ofnode node_source =3D dev_ofnode(dev);
> +	ofnode node_dest =3D ofnode_graph_get_remote_node(node_source, port_idx=
, ep_idx);
> +	struct udevice *target =3D NULL;
> +	int ret;
> +
> +	if (!ofnode_valid(node_dest))
> +		return -EINVAL;
> +
> +	ret =3D uclass_find_device_by_ofnode(class_id, node_dest, &target);
> +	if (ret)
> +		return -ENODEV;
> +
> +	return uclass_get_device_tail(target, 0, devp);

Please disregard this version, I forgot to update this helper. Going
through another validation now...

Sorry for the noise,
Miqu=C3=A8l
