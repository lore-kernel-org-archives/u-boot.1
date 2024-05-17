Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CA7C25B74
	for <u-boot@archiver.kernel.org>; Fri, 17 May 2024 02:06:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 065CE8847E;
	Fri, 17 May 2024 04:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="F/1L2/sv";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="M+OpffLk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4156E88479; Fri, 17 May 2024 04:06:33 +0200 (CEST)
Received: from wfhigh5-smtp.messagingengine.com
 (wfhigh5-smtp.messagingengine.com [64.147.123.156])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7438E88453
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 04:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailfhigh.west.internal (Postfix) with ESMTP id 9F8BC1800183;
 Thu, 16 May 2024 22:06:25 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
 by compute3.internal (MEProxy); Thu, 16 May 2024 22:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715911585;
 x=1715997985; bh=MLKdoT9FbYUdABbVPSWF/dm6TovMVwU2bJke+TfE0Z8=; b=
 F/1L2/svzCaEwvr9/RTXUxIHQ7u7r/kFcWBr84xEC54ExIe76UvnB1rbXVq5Q1th
 PTYY4cM3NK0FPalUz0VEtz0w4kdeDCyiojMG59pm13lSMas9eYL/dCoTjNTePsav
 RfYRefNkC+thRTUVumS88FN62qrjenLnQvYgic3erMp93e06UtNLb7s2Lo4X2UPM
 2tIIDt4A88iyKEpARIcmxZPFT1oQcW7QI0hYgV6viEPgPaUPW70Iqjlz2wYuz+xs
 xkmMEjlKTnS1am/LjxSJO+cqkS4RVs/iipzGr/5JlNWqdXIU3QWThVx63PnuLzdz
 EJx8G3eVn71cL6ZG3o0zPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715911585; x=
 1715997985; bh=MLKdoT9FbYUdABbVPSWF/dm6TovMVwU2bJke+TfE0Z8=; b=M
 +OpffLkle61PlfI0ZLFZOihtrgynwbPxdPsuFP+9NKm5F0CNepl/tDXI/o2hpDHW
 t3u6qay5NOTHhxIZmxsNokMQRDlNTx+/Hs8ktD+8ycRs7PlOVg0EA165GyPbsWxU
 KiXlTODSoL5xy+29Bgz9icnKFmxazrSrcNCv1J3sVxcKtgIaxgLW9RaUeCwqDte/
 ysTrI4pUI2zUeSuMNmyi3lU2rx+m13RyKw9+FoabWwQjfo9GZDePdJIbcyrcqYPG
 M038B+cWC0F0KdHIQBpIs2jhh8bgVmdiRCxw7uSh5lbFVoCkybm+83yfaPzxyg1v
 fgMh82UA+rUASoFJuyHyg==
X-ME-Sender: <xms:oLtGZtrEU01vCsEla9cFOCaIjJDYnsPtcCYqy2rMVNtAGb-im9outA>
 <xme:oLtGZvrIdPyC8-xS9aBmkYb_Jjm3BUGZTYt-aqhBgGBy-SwJedhJrGgW0MJLyRvRi
 qTVCQ6jRQ60qTqoqsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehvddghedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
 ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
 hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
 ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
 grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:obtGZqOGInQV-iZHPyCgG51aiuYks44NbTmfS4dPVMOwZ4P4ZYaxdQ>
 <xmx:obtGZo4x0TRgligVAUxZFdnZn6-undQsbF2_QGSV-Dbne43U9tIgQA>
 <xmx:obtGZs5xw37pp5tltA_we0EDBK89KeTzX_q5KNuLVCB1s2fk1gAl5A>
 <xmx:obtGZgglRaAWA6KrzpKSmPMNLr0Ns85mlXEagIdDht5lKclqhJ_S2w>
 <xmx:obtGZn2kqjsNYMM07CDdmyAygtl99mpc7qY2EbRVGCPNmeJBxzPEvRpu>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id E4AAE36A0074; Thu, 16 May 2024 22:06:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-456-gcd147058c-fm-hotfix-20240509.001-g0aad06e4
MIME-Version: 1.0
Message-Id: <209b29fa-ff46-4a96-9169-daac1bb9c631@app.fastmail.com>
In-Reply-To: <2227C151-FA5E-4649-89D4-989B7DE32930@gmx.de>
References: <20240517-virtio_gpu-v1-0-6353b87472c7@flygoat.com>
 <20240517-virtio_gpu-v1-2-6353b87472c7@flygoat.com>
 <2227C151-FA5E-4649-89D4-989B7DE32930@gmx.de>
Date: Fri, 17 May 2024 03:06:06 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Heinrich Schuchardt" <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Cc: "Tom Rini" <trini@konsulko.com>, "Bin Meng" <bmeng.cn@gmail.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH 2/2] efi: gop: Mark pixel_format as BLTONLY if we have
 sync hook
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
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



=E5=9C=A82024=E5=B9=B45=E6=9C=8817=E6=97=A5=E4=BA=94=E6=9C=88 =E4=B8=8A=E5=
=8D=882:44=EF=BC=8CHeinrich Schuchardt=E5=86=99=E9=81=93=EF=BC=9A
[...]
Hi Heinrich,
>>=20
>> 	plat =3D dev_get_uclass_plat(vdev);
>>+	ops =3D video_get_ops(vid);
>> 	fb_base =3D IS_ENABLED(CONFIG_VIDEO_COPY) ? plat->copy_base : plat->=
base;
>
> Wasn't this line introduced to handle the video sync case by pointing=20
> the EFI application to target framebuffer?

This is used to handle the case that U-Boot itself is performing a copy
from U-Boot's shadow buffer to the target buffer.

However, in virtio-gpu (and some other driver like syncoam,seps525, ste,=
mcde)
cases hardware needs to be notified for any update to the framebuffer.

For those hardwares if application just write to target framebuffer the =
display
won't be updated. Hence we must direct applications to call BLT to allow=
 hardware
being notified when framebuffer is changed.

Thanks

>
> Best regards
>
> Heinrich
>
--=20
- Jiaxun
