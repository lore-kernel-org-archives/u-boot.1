Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43D1CD6E49
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 14:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5977584671;
	Sat, 30 May 2026 16:47:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CGJJHhxM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2869F846A3; Sat, 30 May 2026 16:47:23 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB6638405A;
 Sat, 30 May 2026 16:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gSNNl5wr3z9vPK;
 Sat, 30 May 2026 16:47:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1780152439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=giKe7kZTLZYsBbXY7L0KTWK78+rVu8sZFzkwp87B1ks=;
 b=CGJJHhxMcpCfkUafFigEDU7qsHpSqmDOAV6Tx/xMfEDVGZq1+aDxeLqgOxkvezcpQR6whi
 Xtgqa5/UJqmtmklEd/kDktS8jZNOYwdxfkkgcweYSIkK84Tv3qSJQYUI076QPpfkmzCTrH
 oCdx0zQc8Ee5u+m0LkjZ7n4r/Afyj5EotWedqgzLPN1GooniLZ1lApZ2QzT6BqdjV5nhSg
 eo11kgIVMyH+pgiuDWnhQlQw5i4lhWNZJZmS2JtSNhpH0L6dcDeFv5awpzN4OyEADOkPDb
 h8cylRiHXgwiCeyTc3JhBeUHH7anYC20O6rtNafk0FYYcNYQJx0b4iKWrq2VQA==
Message-ID: <12df88ea-5cf3-4ce9-aebe-09516eb5652f@mailbox.org>
Date: Sat, 30 May 2026 16:47:16 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
From: Marek Vasut <marek.vasut@mailbox.org>
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, Gary Guo <gary@garyguo.net>,
 u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, U-Boot <u-boot-bounces@lists.denx.de>
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <CALeDE9PARyt0iUvnfbSfz=rSA2RkQ1AcoaJpU=8RgnYivaPNEA@mail.gmail.com>
 <20260529154446.GC627328@bill-the-cat>
 <CALeDE9MAE6r3pFzNRDbwAXkkkWrZo_0gXEMTavmpnGjQBoxrVQ@mail.gmail.com>
 <c9e810ac-6c0e-4a66-bbae-d6557a26197b@mailbox.org>
 <20260530140644.GG627328@bill-the-cat>
 <e7d1a88c-6542-40eb-b21b-b9382bdf5306@mailbox.org>
 <20260530142249.GH627328@bill-the-cat>
 <9ee24398-2970-416c-a5d7-ba0c91ab37ae@mailbox.org>
Content-Language: en-US
In-Reply-To: <9ee24398-2970-416c-a5d7-ba0c91ab37ae@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ezcn49daxjw7k58o89hizaes3oon9thq
X-MBO-RS-ID: 6096d6b87248cedfe45
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

On 5/30/26 4:34 PM, Marek Vasut wrote:

[...]

> We could probably even make that generic enough and gate it behind some 
> Kconfig option to let users select whether their memory above 4 GiB is 
> broken or not. For SH it is not broken, for RPi it is, so we would have 
> to work out some default value of that Kconfig option.
> 
> What do you think ?

Implementation is at:

[PATCH] [RFC] lmb: Optionally limit available memory to 4 GiB on limited 
systems
