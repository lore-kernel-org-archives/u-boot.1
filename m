Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C3BC27C4F
	for <u-boot@archiver.kernel.org>; Sat, 15 Jun 2024 08:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD11F87BCB;
	Sat, 15 Jun 2024 10:35:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="r6s3NVt3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BF1C87CF1; Sat, 15 Jun 2024 10:35:41 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AACD87ABC
 for <u-boot@lists.denx.de>; Sat, 15 Jun 2024 10:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1718440537; x=1719045337; i=frank-w@public-files.de;
 bh=CscBUABiTIJld3eOacyaaV9RZXIOf/Y6+XvD9jeQM9o=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
 Content-Type:Date:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=r6s3NVt3RefIG8cudLjS/KY3I98gEfNK9dUQ18FnexVCK6/LAKdJ8yLsXf6ioRgB
 C73SBFPdE6zQEXa6Li6+OCBxVI32mDaBHhsp9SBshwa53u5AwZXQ66jrg0qwwIUTf
 RITwVlUdMEMO5BZmNnXcbUJXKWyaSI5dExwUywIkLF2ZIVT0Nat7Xhns3HUEDthb4
 X0zJHD96TVUg4wskX679xGIq5wbsCNTv2l8MfpxORo88Xs56OyXgc7OrANvf92b07
 JdBcRimcBGTb5tkMDKspt2tA5wTluUicnHv8+/IYuIIS9DE2rtA/KAonQzwDwotLy
 voczAr03FXeVZ5e4FA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.159.183] ([217.61.159.183]) by web-mail.gmx.net
 (3c-app-gmx-bap44.server.lan [172.19.172.114]) (via HTTP); Sat, 15 Jun 2024
 10:35:37 +0200
MIME-Version: 1.0
Message-ID: <trinity-e357a9ad-a974-44b8-9efc-a236a499c673-1718440537556@3c-app-gmx-bap44>
From: Frank Wunderlich <frank-w@public-files.de>
To: u-boot@lists.denx.de, =?UTF-8?Q?S=C3=A9bastien_Szymanski?=
 <sebastien.szymanski@armadeus.com>
Cc: Daniel Golle <daniel@makrotopia.org>, John Crispin <john@phrozen.org>,
 "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Subject: uboot 2024.07 regression
Content-Type: text/plain; charset=UTF-8
Date: Sat, 15 Jun 2024 10:35:37 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:DixK8UVHJVbjM9edzn8D6EkxdrDjneulrso2OCYlnunggrn3T+j5S1+87/AIa0NDsNep/
 TpSaEqDjHq5GJjA8poJbi6nbm076V0q77FeQ57cxQcHhYQMBD1BUwe7/NEjWOnMAG1CoAtltTxyd
 dp4B9WBrAyCw3R33CBVm7VaTtgINkGWvHzcEeBJOKq1OOmK6y4X3ZAq14mTbYx3paOVKo5Ms6CFd
 mCYSxll3MBwqHV7kTViuOfbOcqpwPThFvcdvdHcS1t0liWyCLzKnLYHvR+RgQmTnzha7NAgIkp9/
 JA=
UI-OutboundReport: notjunk:1;M01:P0:ukgM/ifsZxE=;lg3O18a0AqZhju9IGdIOkaxILZ2
 MNQIPS+CNbMMTtnTrLYNDKZ0d8/gxn/hxavdXkl/kbuMHftkVW+oiWvbwXD5ColI7z3Qry3I5
 9oeKTxEmVeCZD2wCK4jB/WPFb/7ULTD7+jlf5lzz00utBvhSx6nie/q5I2mRz5BAeh/pC+KhD
 hG1EMV15irjKpvS37kFcw8gvMqG9rUIPwXlopRfO/8pLlzkXYPNvP3bXaW7Rcau22263wU18O
 LjRPwHyAYi1H56O9eejYs8obkiS+Mm+tdrvlEgG4C2VNQXRSDapWL3CYzMHeX3HsnQMko+F1s
 xDkbQpbe7hg1tKvhs1E1Tn6wlG6gk2L/LoGch3UjUvkXoqwEyVNHM28MkUja1qgWICCcGdX4c
 XusvMuB+S43aMTSGiUWOwT/BFzZ185yo/yuFJgXFgAPelf5yF4u25HbD+Y4GL006re/5lvzZa
 PgrYxluZVVIwR/U7dlX31tWPbgvU37Gvo5w3Q1xdIdP4oPiedafWLrKfoV5/iVGEY6FVWpYkZ
 Dp5e2pO7nPcZ7xfSmooxciJtRhQYdlK4KB/B/MbGfk6MPYvvvU7accESfoZKRIUUaTYhzB4x+
 T6bIV3ODTkgipyS8iDQnwEatTODxx7/IMnliWgRN+10RetIVtgIWAGQe5Mg7qbY65zUZW0ayk
 5y6+x0aRuzclMppTyhNYVERDA3cJ2q/GvkxtzLMJr3qPFSDVLOYtZ3EVgqpNahw=
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

Hi,

while testing clock-patches for mediatek as preparation for OF_upstream i'=
ve noticed an issue on
mt7623 based board (bananapi r2) with ethernet (no ping possible) in 2024.=
07-rc1 where 2024.04 is good.

i bisected it to this commit:
ff3bcb17f436 2024-02-23 Makefile: pass -undef option to cmd_gen_envp
and when reverting this commit in 2024.07 ethernet works

it seems not yet reported or reverted (till 2024.07-rc4).

I'm not sure why this commit breaks network on this board, but revert conf=
irms it...

regards Frank

