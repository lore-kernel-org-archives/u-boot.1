Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B33C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 13:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7C8088657;
	Wed, 10 Jul 2024 15:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="pPr9AQm/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73DDE88667; Wed, 10 Jul 2024 15:43:31 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DEE888606
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 15:43:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1720619008; x=1721223808; i=frank-w@public-files.de;
 bh=lG6kjitS7TQtkJTongZd++iPiky/70ZsEFV5iPw/4t4=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
 Content-Type:Date:cc:content-transfer-encoding:content-type:date:
 from:message-id:mime-version:reply-to:subject:to;
 b=pPr9AQm/Grx/ImwWAHLIUR8b0q7jflD35xFZ3lfInCl9Zg84mLDIguS8q4WmAVtS
 qKZX+6TRPmvt+m4q0FaP9z2gKcRt+sc1NUfGerV9uw2ZAi2l/CeiSXQF9Vz+wj7q/
 S8PbDWFffjsENhHR+u5z+sVuC7XP851osDfTnz+Mjwp4Epaz1EU1uq/QaeQcRp2or
 2rJ//BRdjYWySknXrK6ZM8aaNfiu0ZaAUwTtwZPq1mEAP7KhgKFgE/+qn6dDJZX1W
 FM52IwVF8pgjoh3qDXBk8KRtVwuAJvZKLgYaU5jznKrPmweS/86MyyZFrV77DqFvb
 HjNyEJyxA8NmQPNcWQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.158.245] ([217.61.158.245]) by web-mail.gmx.net
 (3c-app-gmx-bs04.server.lan [172.19.170.53]) (via HTTP); Wed, 10 Jul 2024
 15:43:27 +0200
MIME-Version: 1.0
Message-ID: <trinity-c68bf542-baa7-4122-858b-c6d5ef8bf843-1720619007870@3c-app-gmx-bs04>
From: Frank Wunderlich <frank-w@public-files.de>
To: u-boot@lists.denx.de
Cc: Daniel Golle <daniel@makrotopia.org>, "Christian Marangi (Ansuel)"
 <ansuelsmth@gmail.com>, John Crispin <john@phrozen.org>
Subject: avoid syscon fallback class for getting regmap
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jul 2024 15:43:27 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:zDa1qhVkDvuqq/m8LKiU6YOlh4G42NIZXRtIQ3wif3hpfiAxt2gFdN+byF2tYxkYTuLxt
 BYUY7XSwMq3p9wIrsQZ7Gg3+O0wkNpXR0Q81VzWvokZvu2vFKzSRAUe6LYdH4iwpjRFGDelLOwdR
 98FA3eqt7ZNxdYJn3G26pPAP11rGmd0h13VT7rcSqZvsyMl74dFP1eTwwiwMF5+ZfHxbw50m8lPb
 +yoJSghZ3tP1UqdbntBoNQuzV9MLzG9s2NUi3ZO1JSPOHPz8SUUJnRlkHKLVoRlOfLyMPC6l/QLN
 0U=
UI-OutboundReport: notjunk:1;M01:P0:+UmebA/u3XA=;06IlNwQ+aLqPOT6GHyGlclKGg/C
 n+19fHUCAX50iBmtvQ2S11fS25L2LlnaVeOhXn6AB9be37P80P8Ug+0jZw0aLshJQG2OH7QrS
 w10m0sVmxfIg/RiXiBppJbaxjpOtMFujOmCbvdO+mmhRXwKF/DDZkhW/GcyyedzsknWbDCnnK
 LCjLC3b0qJEtgH/z3BsyNosizt9EAvKAPn1LAwrc88YY2eruYbVS8d2T19s3O1D1y4+EPEllr
 GSJd9L7Ned1oMvK9XGf/aegs8IgBfNrn8RSWbsfthnFzjA2MvA0KxMe/K+/Srp2MuMlbigUTu
 2OEyraVSzjmKCV/otBjA2jtEssm4ysHE1xUlOztaCSBLuLYr+MsAkzyex0MzewDLRleJaREjN
 olNmmDaqVb005XINVDFHhdoWVHt122dOgqUQqwxs6ZNgP5qM0BoRIDFW8h4R0VcaVF5Xlc/Qp
 nijIeQTQWCh06h8rGMSkO/4QTi7IT1Az7IZ5GPHm2LQkT6g3Ijti9wEoTzzInUnsJA2WYA7Ka
 w6lqnEComkn24cAptm5tVK1Kv+vn6yc3H1NWEFAWg87EvbatA7OY3qT1sp4X3ZOK7ZcioiZzr
 3I09JbbdobmVMSmmZk4HeLMczocH2c+doPkpwdNRRA+6Nt1VMBkZ5HHWc1p07RpYZykrbPkOj
 a7ZK2L7pR0zb+Fih/i+8XnQyelX7PDOHy40NB1kqbg==
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

i'm working on OF_UPSTREAM for mediatek boards and noticed missing syscon-fallback on some (mt7988) devicetree nodes.

i know that u-boot uses this fallback to get the regmap shared across drivers, but only initializing once with the syscon_uclass.

i tried adding the syscon-fallback to linux device tree and got pointed [1] back to uboot to solve the issue there...

are there any ways to avoid syscon in device tree and get the regmap of different node?

i guess i could use [2], but then it is possible to aquire same regmap multiple times which may result in issues (e.g. race-conditions).
I also want to avoid creating multiple drivers doing the exactily same thing like syscon.

one easy (but maybe unwanted way) is to add all compatibles for affected syscons to the syscon driver...but then it is no more generic (baed on compatibles then vendor-specific).

regards Frank

[1] https://lkml.org/lkml/2024/7/10/669
[2] https://elixir.bootlin.com/u-boot/latest/source/drivers/core/regmap.c#L242
