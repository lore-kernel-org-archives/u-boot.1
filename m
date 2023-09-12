Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA35BCA0ECA
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 09:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E083486D84;
	Tue, 12 Sep 2023 11:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lUu5BF9+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADF6986D99; Tue, 12 Sep 2023 11:20:08 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3697286366
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 11:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kamlesh@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38C9K1hI129641;
 Tue, 12 Sep 2023 04:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694510401;
 bh=HgD93YIksJmtw9CjaUpT0m5hdSmKjCxnDVIV7pyyhPg=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=lUu5BF9+Uj5KD3q4ko7XztxlnjYI5L5WBylwwzW6oCuyxUsqtIIa0zfnTz+kmn2dl
 MqpzHNIGL69rTtu7Wllliytx3ivrL6LkzJYuElEkdsU0MKneJUjp9oi+V4rMmwQGJE
 zB+vpRl/oa++yIkTqzw1GsmT4LHcQBnZenCKrO6A=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38C9K1O1009794
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 12 Sep 2023 04:20:01 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Sep 2023 04:20:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Sep 2023 04:20:00 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38C9JxLB007758;
 Tue, 12 Sep 2023 04:20:00 -0500
From: Kamlesh Gurudasani <kamlesh@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Neha Malcom Francis
 <n-francis@ti.com>, "Andrew Davis" <afd@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Nishanth Menon <nm@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>
Subject: Re: [RFC PATCH 0/2] RFC version for ATF and OP-TEE Firewalling
In-Reply-To: <20230905-binman-firewalling-v1-0-3894520bff8a@ti.com>
References: <20230905-binman-firewalling-v1-0-3894520bff8a@ti.com>
Date: Tue, 12 Sep 2023 14:49:59 +0530
Message-ID: <87edj3hhog.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Manorit Chawdhry <m-chawdhry@ti.com> writes:

> This is a start to firewall ATF and OP-TEE memory regions using the
> firewalls present in K3 SoCs. Please give reviews as to what can be
> better in the implementation.
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
Hi Manorit, thanks for the patches.

I hope this solution is easily scalable to sitara devices as well.
Mainly considering the difference in type of firewalls.

Regards,
Kamlesh
