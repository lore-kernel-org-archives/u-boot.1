Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82548C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 21:47:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3EDD81F0D;
	Fri,  6 Jun 2025 23:47:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="o+dRY0Cx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17F8682977; Fri,  6 Jun 2025 23:47:34 +0200 (CEST)
Received: from mx2.securetransport.de (mx2.securetransport.de
 [IPv6:2a03:4000:13:6c7::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AF1E807B1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 23:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1749246382;
 bh=FLtBGth+pgJcol2PV1ZL02nJDm+xoKiEcXjNpzQJHgI=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=o+dRY0CxjOJNSO+kQj4pn/jXg4KrR6XPPiByjrFQbKSLsg7hZScSC/I8EA84subdR
 N/H00+Kwzily8qNJxloK3SkvxnNDVC56w24vyZDryq4dDEZexsd9iauWHjMkHCB/Vm
 zddWnzc5/YmaMvSS5uEmbsMizg8CyK8wCrjsJ8mDpBThTgwxeLnoX0MM/LBNHv65Pm
 hgOHX3AuBT1/DQDK88zVotr2CeLGmtPokOdQ3pQfCDXsXgztiPc1+c4QXsBbZFk3A5
 OQKRubgYorEfS2k9duGLY4b6iG5V1Z7dPHut1Y6ZEkzarrUjYFkm2IXA761xbvoY38
 0kkRyOWq46W9g==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: RE: [PATCH V3 2/3] test: cmd: nvedit: Add basic unit tests
Thread-Topic: [PATCH V3 2/3] test: cmd: nvedit: Add basic unit tests
Thread-Index: AQHbwRTjgGGCwSHE6kCsNPNIk2asJLPx5BCAgATPekA=
Date: Fri, 6 Jun 2025 21:40:28 +0000
Message-ID: <84931c2fbfe6497ebff69e54f92bcd06@dh-electronics.com>
References: <20250509190043.28641-1-cniedermaier@dh-electronics.com>
 <20250509190043.28641-3-cniedermaier@dh-electronics.com>
 <20250603201249.GA1510455@bill-the-cat>
In-Reply-To: <20250603201249.GA1510455@bill-the-cat>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

From: Tom Rini <trini@konsulko.com>
Sent: Tuesday, June 3, 2025 10:13 PM
> On Fri, May 09, 2025 at 09:00:42PM +0200, Christoph Niedermaier wrote:
>=20
>> Add basic unit tests for argument checking of the env command.
>>
>> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> [snip]
>> +	/* Binary format with checksum and with wrong size */
>> +	ut_asserteq(1, run_commandf("env import -c ${loadaddr} %x", offsetof(e=
nv_t, data)));
>=20
> This will be "unsigned long int" on 64bit or "unsigned int" on 32bit,
> and so we can't use %x here.

I will have a look at it and make a new version. I may not get round to
it straight away.

Thanks and regards
Christoph
