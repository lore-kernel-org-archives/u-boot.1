Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D7AC3ABAC
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 15:57:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D1458215F;
	Wed, 30 Apr 2025 17:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gF8+0FFp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 739BC82B9D; Wed, 30 Apr 2025 17:57:54 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F35B780079
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 17:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53UFvnlM3427367
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Apr 2025 10:57:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1746028670;
 bh=mRdanpvQJtCVfNdMhrvV9Ek34rja0pmkA0THqytxf8E=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=gF8+0FFpTSAvntna4CPWexoZpf7Os1+rX7fbsPMrC8NI/LXwNI3Yi+fR0l+FkpQ/c
 thF4ZUKv7DgRvSf0zdOvFrOZSFs25XNZ0NX3lDRgG4AyTszNNhMIwWtHl0AkoNHrHU
 Q8npYBzY9F22Yei4axXNGYTFOkSgqvvLdnvUsDd0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53UFvnJ2043239
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Apr 2025 10:57:49 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Apr 2025 10:57:49 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Apr 2025 10:57:49 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53UFvm3d124628;
 Wed, 30 Apr 2025 10:57:49 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 30 Apr 2025 21:27:30 +0530
Message-ID: <D9K3I0TAUJ5J.14MKHV437D997@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: Re: [PATCH v1] arm: add call to cleanup_before_linux for go command
From: Anshul Dalal <anshuld@ti.com>
To: Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250430135751.2626849-1-anshuld@ti.com>
 <20250430141657.GO1261075@bill-the-cat>
In-Reply-To: <20250430141657.GO1261075@bill-the-cat>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Wed Apr 30, 2025 at 7:46 PM IST, Tom Rini wrote:
> On Wed, Apr 30, 2025 at 07:27:50PM +0530, Anshul Dalal wrote:
>
>> As discussed here[1], the go command causes undefined behavior when used
>> for running custom OSes since the icache might hold outdated data. OSes
>> usually also expect the MMU to be disabled upon execution.
>>=20
>> Therefore this patch adds a call to cleanup_before_linux before we jump
>> to the loaded program/os which disables both the caches and the MMU.
>> This makes the go command's behavior consistent with riscv platforms.
>>=20
>> NOTE: This might cause regressions with users expecting a configured MMU
>> but I'm unsure if it's a supported use case for the go command anyway.
>>=20
>> [1]: https://lore.kernel.org/u-boot/D9DXL95MTQ8I.3EUY0C6M2L4NE@ti.com/
>>=20
>> Signed-off-by: Anshul Dalal <anshuld@ti.com>
>
> This is the inverse of what needs to be done, sorry. RISC-V shouldn't be
> doing this type of cleanup. I know it sounds reductive but "go means
> go". We have all of the other bootX commands for "prepare the system and
> boot the thing at $address".

Well, "go means go" implies we jump to the necessary DDR address and
start executing. But with caches enabled, it fails in cases where we
have that specific address in the icache already. In that case the
execution starts from whatever's stored in the icache and not really
DDR.

