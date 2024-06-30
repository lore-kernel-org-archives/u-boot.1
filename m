Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7012BC3064D
	for <u-boot@archiver.kernel.org>; Sun, 30 Jun 2024 14:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D0938842C;
	Sun, 30 Jun 2024 16:10:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="C7WP470U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B9288845A; Sun, 30 Jun 2024 16:10:57 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F25C78824C
 for <u-boot@lists.denx.de>; Sun, 30 Jun 2024 16:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1719756653; x=1720361453; i=frank-w@public-files.de;
 bh=nDptJxO6Z4bp1tEh5FfipSvRi8J/rqlo7ZHr6ekgmc0=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
 Content-Type:Date:In-Reply-To:References:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=C7WP470UEMYlm3YGOg7dr6WE0muLjk5yvd+NqgQdkMDWrFQFYYZJYrMjPSywNVRx
 S+S9w/m7pdbS5JufvYlhkMACn6/kbr9lBS6HXzy7zt+SE7VO8zwRdxnSuShztXJ1E
 SsDAjjL5o+194sX9VXWME8ACclGd3xe1cgnr5ctxqN45F0YGx5DbyhxCdvhkmj2t1
 KGtX0j6nNZMeOc1b2hGcXK1q4+KXgfyCIgvbhDM+8kFiXEI63MTwX8gFcSvVb7lni
 Xy72vReay/GG6+iD0uTTEkQhvkKLIieH8Ww82ue81QGEQRHPFGqZOXrgOj4rxRQn5
 uV51W0DmK8y7xe7ZFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.152.236] ([217.61.152.236]) by web-mail.gmx.net
 (3c-app-gmx-bap39.server.lan [172.19.172.109]) (via HTTP); Sun, 30 Jun 2024
 16:10:53 +0200
MIME-Version: 1.0
Message-ID: <trinity-d5e7efbf-06a7-4a02-ab82-c1738850841d-1719756653263@3c-app-gmx-bap39>
From: Frank Wunderlich <frank-w@public-files.de>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: u-boot@lists.denx.de, =?UTF-8?Q?S=C3=A9bastien_Szymanski?=
 <sebastien.szymanski@armadeus.com>, Daniel Golle <daniel@makrotopia.org>,
 John Crispin <john@phrozen.org>, "Christian Marangi (Ansuel)"
 <ansuelsmth@gmail.com>
Subject: Aw: uboot 2024.07 regression
Content-Type: text/plain; charset=UTF-8
Date: Sun, 30 Jun 2024 16:10:53 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <trinity-e357a9ad-a974-44b8-9efc-a236a499c673-1718440537556@3c-app-gmx-bap44>
References: <trinity-e357a9ad-a974-44b8-9efc-a236a499c673-1718440537556@3c-app-gmx-bap44>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:JmvpYH8iimDH1ENZWFl+4O66cmRBvpHY5F5h7y0H5gx1ohsVvEywDlOVaGEWAbuq2dwtO
 qnOg0DX4kT/MdIeDnxgzlRDNCFZIFP3NqgfNCwexDb591GFr0BOsb4fXjzF17jzv4czL+9aTU/Fz
 dOz2ztR7TIsqM865VBaHv9GQm2qe4Q6kafUv4mcshF/vZmfT/QPOlsTxoKbpIQIN0tDP6XdlUAo7
 UcH4x3clll6VYRIHb5bHpPF/mnxU83TdKufeHSAbwX09cFNtze5SGQrZ3mau+vezVK80X93QWFwZ
 48=
UI-OutboundReport: notjunk:1;M01:P0:CtW1/c7iQeU=;8UHF3G94UWkPHEoz2creXbJywug
 YyxQYoKLhWxuuUZmqII6P86iJ38y2xBvULSarWbPnPr//IT5V90sW+fFRhn0FLkEoaHhkTUpp
 VlTH+9ChcuT0XNqNN/HlREWODoQVHMYsdFyqiEkeCd5lgr/uCfxYQYDSXYYUj0/s/G2wR104w
 Bu8lh1/9NLhnHos4q+Zy8o10kMPjxAqiW/aCekwD/XghG+9Nill0+n4Pd++ms/OY3yfAy/Vdl
 6g9XiLSBtla5hvwi0WB+HdX81j4Iu9ZwxsSuK+UtO6yotGm6zacn/51r3rxtR1ZHde87nZau5
 FkOsBI9KIqFpAuhRVO/7W48GS33J7lmlBfmCaNiSS9bXAq1VCg0PZhJ6Ag/lW+1SEw/Vsy3gh
 HkkNHOz14BnRuNh0in7BwpYsaz+jcIkDIr8gfGI0PUhGYjqK1NdUjpEYH8xjd0Defof62MQWz
 OHtGvFulZxPEWJG9D5LueP6+j4vIeYtsWuBl02FEI/MZc/S3NDGHa3W77lnVCEVUHlW2/sNY4
 ErHvyljhyrJ2Tl9uWoJ0gA/fKDA0jJU9H1JBtqAnxbxdkB3J8wzAQ496hMHX0J4V/P63E/+IR
 Y08vLTGdPscMEEh0bweWhGNn8xbTjyIquNEKa15ttzI2NA2ubYLa+JAPEhNxzcaXBy7f5CgQ9
 M19bEw1ZJR+br6vFbFl+wvZxRymfQl5LIwVCGUyaP0Y+bfR0/ghEMa/iIxifdnw=
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

Hi,

any thoughts about this?

Changes do not look like they would cause the ethernet-breakage, but rever=
t confirms=2E=2E=2Ebut i have no idea why this happens (maybe some optimiza=
tion is triggered)=2E

regards Frank


> Gesendet: Samstag, 15=2E Juni 2024 um 10:35 Uhr
> Von: "Frank Wunderlich" <frank-w@public-files=2Ede>
> An: u-boot@lists=2Edenx=2Ede, "S=C3=A9bastien Szymanski" <sebastien=2Esz=
ymanski@armadeus=2Ecom>
> Cc: "Daniel Golle" <daniel@makrotopia=2Eorg>, "John Crispin" <john@phroz=
en=2Eorg>, "Christian Marangi (Ansuel)" <ansuelsmth@gmail=2Ecom>
> Betreff: uboot 2024=2E07 regression
>
> Hi,
>=20
> while testing clock-patches for mediatek as preparation for OF_upstream =
i've noticed an issue on
> mt7623 based board (bananapi r2) with ethernet (no ping possible) in 202=
4=2E07-rc1 where 2024=2E04 is good=2E
>=20
> i bisected it to this commit:
> ff3bcb17f436 2024-02-23 Makefile: pass -undef option to cmd_gen_envp
> and when reverting this commit in 2024=2E07 ethernet works
>=20
> it seems not yet reported or reverted (till 2024=2E07-rc4)=2E
>=20
> I'm not sure why this commit breaks network on this board, but revert co=
nfirms it=2E=2E=2E
>=20
> regards Frank
>=20
>
