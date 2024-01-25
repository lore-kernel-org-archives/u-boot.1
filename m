Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763BEC47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 17:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C457878C9;
	Thu, 25 Jan 2024 18:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hJuzxBfK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D9BE876FA; Thu, 25 Jan 2024 18:13:40 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E497F875FC
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 18:13:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40PHDZUQ049543;
 Thu, 25 Jan 2024 11:13:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706202816;
 bh=+XcYLAiYoacnhRASWzcOPzhJmynyWP72X3UE17v6Yfk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=hJuzxBfKXWp+tnaJrw71tC29+9YtyLglU1ljG8vQHiHsklUU9ylxOdXJdnfLJcyt+
 SyYpWtIcGhsH3tUHTxo3j6D/GBKDSz5e2Gr0J69s60lsiYU2sFMbQ0d80YGUdpYn+P
 FxrjM2yZQ6JeLLF8UDNpPw4Kfk8zIYUtKNvqJfUQ=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40PHDZxH047749
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 25 Jan 2024 11:13:35 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jan 2024 11:13:35 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jan 2024 11:13:35 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40PHDZWr055772;
 Thu, 25 Jan 2024 11:13:35 -0600
Date: Thu, 25 Jan 2024 11:13:35 -0600
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Dhruva Gole <d-gole@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Tom Rini
 <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Francis
 <n-francis@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] firmware: ti_sci: fix the secure_hdr in do_xfer
Message-ID: <20240125171335.qoxphnemadkh7xjd@gullible>
References: <20240124101558.184411-1-d-gole@ti.com>
 <87fryn7zoz.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
 <20240124130859.sdldy4jafknoa23q@dhruva>
 <20240124163910.sp7gt56lihoujm7k@etching>
 <20240124173723.3wfiwfgf6rhwgwaa@dhruva>
 <20240124180813.azl3ldrrg7a5iosz@spoils>
 <20240125054334.zjll7j4fpv66ciyn@dhruva>
 <948db6de-8150-493e-9a15-62aeac9aea6f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <948db6de-8150-493e-9a15-62aeac9aea6f@ti.com>
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

On 10:55-20240125, Andrew Davis wrote:
> I'd say since U-Boot today cannot send over secure channels anyway,
> lets just drop this code and if we ever need it then we add it back
> over in the right spot at that time.


Chatting with manorit, the reason why we need the secure code is
because of boot R5. boot R5 starts of in "secure mode" when it hands
off from Boot ROM over to the Secondary bootloader. The initial set of
calls we have to make unfortunately needs to be on secure pipe (think
j721e load sysfw call, board config load call etc..) - which needs
this support - which again, we should probably document in the code so
that people don't go scratching our heads again.

That is unfortunately confusing enough for code since 99% of rest of
u-boot flow does not use secure comm path.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
