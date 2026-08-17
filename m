Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CB8C5DF74
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3AECB60833;
	Mon, 17 Aug 2026 13:34:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m-Q3Pv626RjK; Mon, 17 Aug 2026 13:34:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0240160824
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973659;
	bh=vr8gVt8KHnqhOB3Gur8fapHEyA7j5bWtdjdaxCI1kl8=;
	h=Date:Cc:Subject:From:To:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SFdrN1bLDdKjwYGCGi5/XtI+/bRCPlVO18cOlcVnEpYuo+wy31IIJVo579ArvKvCE
	 EI/+M7TEfm+iYLRtL1tSUXDomnSfdRjsiXZHGY7hlMejBfyDYME6OAX8ehCgwAWv64
	 CDu3cTcKttPHQNV2wcjSaRzYoCf9IvZRJZRzveXp3Jifdl9oduQpdgFFJ2UcF3Eexv
	 tEieHh0csuR3HH9J7fymtJlgZWgUDTD8U2rdl+7wouSJLD2+Yh62ktjQ85RvVtV+UG
	 c48X+Zz/8IHcRyvO2VxLxCDZxeIBsQ4KpsCzknb5p1x/Nk1wGzUOJNzRZmBMCzDB86
	 l5zXUNK0UwpYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0240160824;
	Mon, 17 Aug 2026 13:34:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F412C333
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:57:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E5FB340050
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:57:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RRr6tfMpTKXz for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 08:57:07 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=43.155.80.173;
 helo=bg5.exmail.qq.com; envelope-from=troy.mitchell@linux.spacemit.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5A8E640087
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=linux.spacemit.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5A8E640087
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com
 header.a=rsa-sha256 header.s=mxsw2412 header.b=iL95amUZ
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5A8E640087
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1786956927;
 bh=vr8gVt8KHnqhOB3Gur8fapHEyA7j5bWtdjdaxCI1kl8=;
 h=Mime-Version:Date:Message-Id:Subject:From:To;
 b=iL95amUZogJm7WELz86Cw/8n15r/ysD7+VYfLKgxK1nKU/qQxqSIN+srceyyU0Tuv
 XoUDQ5NGegcAPQyxZrxIm6YCPfbxEMQ6z8FIagbLd0rKbbM3d8IAVcNezi+LD7KtXu
 N+mjqAvXqOtCCIxJpJx6c63Hcp87Rq7Mtu37qPUE=
X-QQ-mid: esmtpgz15t1786956925t6840e9c2
X-QQ-Originating-IP: R+b/XMgizHtXXRAFhRK2GrrLDE6W6RhwPmceRVmUAww=
Received: from = ( [120.237.158.181]) by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 17 Aug 2026 16:55:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12801543007123845480
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=5ea6f8d608845a88422dbdcf9080c0b4688324724d0af6fc8188a5c92722;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 17 Aug 2026 16:55:21 +0800
Message-Id: <DKR3D0QIEHXK.KVTC20DJVGJZ@linux.spacemit.com>
Cc: "Heiko Schocher" <hs@nabladev.com>, <u-boot-spacemit@groups.io>,
 <u-boot@lists.u-boot-project.org>, "Huan Zhou" <pericycle.cc@gmail.com>,
 "Guodong Xu" <guodong.xu@oss.qualcomm.com>, "Tom Rini"
 <trini@konsulko.com>, "Raymond Mao" <raymond.mao@riscstar.com>, "Lukasz
 Majewski" <lukma@denx.de>, "Yixun Lan" <dlan@kernel.org>
Subject: Re: [PATCH v2 4/4] clk: spacemit: k1: remove bus gate from TWSI
 functional clocks
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Junhui Liu" <junhui.liu@pigmoral.tech>
In-Reply-To: <20260815-k1-i2c-fix-v2-4-7d2a48607233@pigmoral.tech>
References: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
 <20260815-k1-i2c-fix-v2-4-7d2a48607233@pigmoral.tech>
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N79g/BZ3s2bFtnh9HhABap3IJcXtxB/UiOWMQrxyufUv5c5ii3vv+Spj
 Wzael8qHqPKn7fCH5b6NTP4+HeMgLQg6deex4gd0UK7orjNEdpB9wpbPNPdvvYdq+yNh6Z6
 em0XSapy5BSTOuMBSy2zrucZsDcubsZWRl6WnZWwR9uRXzQ7UuaZbiY1hEtVs+p69Uib2tz
 rrmvtRH86MZAaA9cJFQx5lV/lsHmSC6uDMpbF2NNHjD6OWdNRjZYCkGuSRpsnhc0oFLFzud
 4BlqkI/sK0ZzAco78PCdFqs4tA4utEwdibnTpmocEXOsbnbso0Ct7bfl6EUh+1jQAPwHW6x
 dfnT7WNVcjrL6rJRlsSTf8C1B5/VYMtTZLwfFEsVvU2k/AgvELBvLrazfAAoVRsCH2/IX8e
 R/kfaDpzjRcLygOyjbHqlGsBShw55m8zBiSFZMi3CxWaLOJrQQx8DUYxnKb09ZJtTV9s+NV
 UB7UtPrFQBCzejgdsdjxxmCrq2mXtU5Rsej96rltIzAtn6jCVrtRM6+LL7M5OVu01GtimoL
 tl6Vab3CN8EZLph4/FwbWe/BLoqIVpkfDQxbi9eUSEFIkcM1GA9090tPa8sCFwicnsEdgtX
 cgI0kglGGtrgBcyQ90GlKQsMNa5/6x/HA9X7aPRZCK+5cbuD6DvPXOOfh8XSk/ZeexEfp4D
 niNQedEQpYRGpLfgCfUVtIM1xcjtbRS+msggmztehCjTHa7V9a5qh/dk6Pp28x35t+JhZIr
 GDgChMDXI9u8ULb0aSC9CYSM8u/m6hr3guXTqhMkQUghB9guPn9u1WXDKubnN+Ur/Xcwq5q
 HdGZybL6+zePrlxEk33/DjIxnCkEZXPEP2pEVfpOXltpK5T0YC5kRf3tAtgrp4traLGmuvw
 GGJCWILcQEryUIXM9uVrCO6qi/nd+K0i2X4xiOd0mlc3uHxAUoLqyKBPRzoT/7CaRXYMC7I
 bq6SjUdU+Ch4dB/YUfXXIi+oyeLLCvvRdqRtMh6gsJhBFFMhCPbEJKwnjDB/ryBugusUoxV
 H2SvUywXaeaK28drVEBxCp+DGE/0TD+Kvac23Wj0/fh7PJ2pbZvnmwklve3uc=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:58 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

--5ea6f8d608845a88422dbdcf9080c0b4688324724d0af6fc8188a5c92722
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

> The TWSI functional clocks incorrectly include both the functional clock
> enable bit and the bus clock enable bit in their gate masks. The device
> tree and the full clock tree model the bus clocks separately.
>
> Remove the bus clock enable bit from the functional clock gate masks so
> that the functional and bus clocks are controlled independently.
>
> Keep the combined gate for TWSI8 because its clock control register is
> write-only and therefore cannot be safely shared by two clock
> instances.
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

                                            - Troy

--5ea6f8d608845a88422dbdcf9080c0b4688324724d0af6fc8188a5c92722
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIMEABYKACsWIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCaoLMeQ0caUB0cm95LXku
b3JnAAoJEJgJ74D5MzQvPUgA/i0TZYHnU1pKMd7r7MkOAn+QXbSMLZfa8waB0vJg
J+HtAP9PtfwkB7BC2CT4kMmkXsD4J0VgDzCeIzAatToXVa5DBw==
=yt61
-----END PGP SIGNATURE-----

--5ea6f8d608845a88422dbdcf9080c0b4688324724d0af6fc8188a5c92722--
