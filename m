Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589E0C4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 16:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8796087645;
	Wed,  7 Feb 2024 17:51:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="YdxyGJhb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A24D687CEC; Wed,  7 Feb 2024 17:50:46 +0100 (CET)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 801EB87645
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 17:50:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1rXl8D-0008T2-Cf; Wed, 07 Feb 2024 11:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
 From; bh=OekmxtNuTVvcUWl0pJFAuqz2DchobmPKW9cHiPrerdE=; b=YdxyGJhbWjcxGQKHXffc
 X182St2GXMqPhG5Ceoksynir3tVzEo7bfC6NtOKShj2es5WT07tqqXsp3gd4G7e2vcGz998JoQ0Sg
 o9mex2VYhPHb3O1URc7uqA2Ezk4Q+dYQzG8t5R+JuH3zv+AH5wrNpvy2fRtTwKNQC8OOD/Tk12RT7
 G/dr4fr1BNU0Fdt8A8NUAWpxCXVRpL/9zPw6IqNTfvIsV8ITtWQwKrtSf5h/eM+kQjnmK65fqSFEg
 uKBstbM9WivfvX/tz69ZEmgSmGRYqlfU+dsO3LLfgs72KdP52uUdO5R4hNZCaaPB60j29W9XH1fuZ
 5j9keWQS0KQj4A==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: u-boot@lists.denx.de
Cc: Tom.zheng <haidong.zheng@nxp.com>,  Ye Li <ye.li@nxp.com>,  Primoz Fiser
 <primoz.fiser@norik.com>,  Fabio Estevam <festevam@denx.de>,  Peng Fan
 <peng.fan@nxp.com>,  Ken Sloat <ken.s@variscite.com>,  Nate Drude
 <nate.d@variscite.com>,  lukas.skupinski@landisgyr.com
Subject: Re: imx93-var-som: ahab: U-boot is hanging
In-Reply-To: <87y1bx1x1q.fsf@gnu.org> (Mathieu Othacehe's message of "Tue, 06
 Feb 2024 15:34:25 +0100")
References: <87y1bx1x1q.fsf@gnu.org>
Date: Wed, 07 Feb 2024 17:50:37 +0100
Message-ID: <87plx8w74y.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 07 Feb 2024 17:51:13 +0100
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


Hello,

I performed a bisection and was able to fix that issue by reverting
three commits on v2024.04-rc1:

0585c28fda1007e4a90dea5f70723cff0b63dd98
eed8294b75a5908a486945ff6655d4dc9aae5fed
ee23d7466c77d01ee63efb76db2c5fd3b7cdd6f7

It is still unclear to me how those FEAT_HAFDBS related commits can be
linked to my issue. 

Possibly my issue is a race condition and the timing shifts introduced
by those three commits are enough to make the issue go away.

To be continued...

Thanks,

Mathieu
