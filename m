Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FEDC83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 05:32:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8617830CA;
	Tue, 22 Jul 2025 07:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="G0PPSihK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 477D2830F6; Tue, 22 Jul 2025 07:32:28 +0200 (CEST)
Received: from mxout4.routing.net (mxout4.routing.net [IPv6:2a03:2900:1:a::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E641A830C8
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 07:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=linux@fw-web.de
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
 by mxout4.routing.net (Postfix) with ESMTP id 64C5B100867;
 Tue, 22 Jul 2025 05:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
 s=20200217; t=1753162345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OGuDlmVz1Jd5j/jVTjmpIskRXnl7+cijbzx355VDybM=;
 b=G0PPSihKEamK38ke5XdFRhaGfcZ6FgmX3E2sVctptTEH/nRe/abWt6FuQ1XEhuxHD26tGj
 xJgxNLZIFmbkwCooBTW1PC5YMg0ahYimbxkWuK810PTEqWHoc9Q18zOOTQr7f/eaMYmiS/
 vzzPLr7Hw1EcC/x+agvaDAq4Ek575YU=
Received: from [127.0.0.1] (fttx-pool-194.15.83.252.bambit.de [194.15.83.252])
 by mxbox4.masterlogin.de (Postfix) with ESMTPSA id A41C880455;
 Tue, 22 Jul 2025 05:32:24 +0000 (UTC)
Date: Tue, 22 Jul 2025 07:32:27 +0200
From: Frank Wunderlich <linux@fw-web.de>
To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>, "hs@denx.de" <hs@denx.de>, 
 Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Holger Brunck <holger.brunck@hitachi-powergrids.com>
Subject: RE: Please pull u-boot-i2c master
User-Agent: K-9 Mail for Android
In-Reply-To: <PH7PR03MB6942C3609388E34D6B62CD69F75CA@PH7PR03MB6942.namprd03.prod.outlook.com>
References: <06c2b16e-1e3d-7632-70be-d6df4232ff71@denx.de>
 <20250718150113.GU193579@bill-the-cat>
 <3ef949d6-9c42-0876-d5a7-a055340d52df@denx.de>
 <PH7PR03MB69424603B76A18A20C7C7994F753A@PH7PR03MB6942.namprd03.prod.outlook.com>
 <PH7PR03MB6942C3609388E34D6B62CD69F75CA@PH7PR03MB6942.namprd03.prod.outlook.com>
Message-ID: <47613B37-8F06-482E-A7AF-30B432BFF335@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: cc2fe745-364c-457a-801c-b6dcc33a0182
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

Am 22=2E Juli 2025 07:10:00 MESZ schrieb "Maniyam, Dinesh" <dinesh=2Emaniya=
m@altera=2Ecom>:
=2E=2E=2E
>
>I have done the rework, tried to run the CI in github before submitting t=
o denx=2E
>https://github=2Ecom/u-boot/u-boot/pull/802
>
>However,
>
>Facing some failure due to :
>Cloning into '/tmp/uboot-test-hooks'=2E=2E=2E
>fatal: unable to access 'https://source=2Edenx=2Ede/u-boot/u-boot-test-ho=
oks/': The requested URL returned error: 502
>
>seems like denx upstream server issue!

Yes see here: <https://lists=2Edenx=2Ede/pipermail/u-boot/2025-July/594708=
=2Ehtml>

>Regards,
>Dinesh


regards Frank
