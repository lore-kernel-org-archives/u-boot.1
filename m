Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E680CCD1BF
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 21:42:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A9CB835FE;
	Thu, 23 Oct 2025 23:41:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="rb2UUWab";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5AAA80422; Thu, 23 Oct 2025 19:52:01 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A66A8003E
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 19:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Markus.Elfring@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1761241910; x=1761846710; i=markus.elfring@web.de;
 bh=YOh0RtT3Yv5C1zahB4jKyFAxXuX2HLjrR1CxAWSoRis=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=rb2UUWabL0rWR9oVCuasakPl+s+Dqro5XIliS1eI0i3NudwLSGf9INUFavitCTmu
 ksvxhnolbRWNlXDnigIpFET+s8KS2shahC4Q3N2ygZ223htjpClSnhOpAD4TYvPyp
 S+4iX08NQqbLxekGk68+PdjjiefHcIPAbgbo5LTht1H+ogzZQG3Yv/1zIdTy261R/
 JrJPWDhXbiqkpKZv95rYw9iaejzFybkJp4HEWC93VLrzajW8SgmABrRNQ3LswgEkt
 BmzEhmQzhpNZUd2HB+VUkrY+jqwlJxkkp8L0dNMq0zjgrbgUY+WBxYD4yMKncS5dH
 DBnm+cyo7J9vDOLuJA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.227]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmyr7-1uUvHW3IpT-00aDEq; Thu, 23
 Oct 2025 19:51:49 +0200
Message-ID: <226836a9-6a08-4600-8041-903300d62522@web.de>
Date: Thu, 23 Oct 2025 19:51:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ronald Wahl <ronald.wahl@legrand.com>
Cc: git@amd.com, u-boot@lists.denx.de, Boon Khai Ng
 <boon.khai.ng@altera.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <b21e8dc3-7ec7-4fcd-a0ef-1d214fc8a1e9@legrand.com>
Subject: Re: [PATCH v2] spi: cadence-qspi: Remove cdns,is-dma property handling
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <b21e8dc3-7ec7-4fcd-a0ef-1d214fc8a1e9@legrand.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qIFUamBq9scdk2J4XR7fceVkAUErtt5LlILYZ+9d0uBtMg7c9kH
 jwZUbKKpPd6mtXaxviG1RsQS8tEfAQyVE40ca+yYfMXJg75vedXIRKJbjU/TOlx1O6yWM28
 KxWU+w5G6K20IuIJGBf0TzMClSJkUA7B2hCDPSyt2Vbo0Dku8/wkMh1Nnaiv3W5ymJUsQjN
 zYejOeD3CiS+BIsH3H5WA==
UI-OutboundReport: notjunk:1;M01:P0:V4VL/5m1/vs=;LPWiELFpGiqCedmeeSwd5UUeMuP
 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
 X1gOpszG5e9dcoAZcTt6S3cbqOHkzN5ql+A=
X-Mailman-Approved-At: Thu, 23 Oct 2025 23:41:50 +0200
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

=E2=80=A6
> This e-mail, and any document attached hereby, may contain confidential =
and/or privileged information.

See also once more:
https://subspace.kernel.org/etiquette.html#do-not-include-confidentiality-=
disclaimers


> If you are not the intended recipient (or have received this e-mail in e=
rror) please notify the sender immediately and destroy this e-mail.

Do you expect this action to happen more often with your information?

Regards,
Markus
