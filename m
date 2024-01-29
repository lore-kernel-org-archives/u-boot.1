Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C52FC47422
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 12:20:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7FC087DC2;
	Mon, 29 Jan 2024 13:20:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DbT6L/Bp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 542A187DC5; Mon, 29 Jan 2024 13:20:13 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92FEB87D5D
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 13:20:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40TCK8NC041368;
 Mon, 29 Jan 2024 06:20:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706530808;
 bh=DiTb8Ta4cCYbmLEq9dh9qal8OzRZ+luS0VrwEXbjQBs=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=DbT6L/BpuzeM8ppd4JaaKqlDe1yhOpWw7wXQ6n+b2hHsygXVWKf46me84fL/r0cr2
 1GWIsIcAu/RzxxHp6zwBILV5aa2Z3MYibv0HxY7ywxzFG6bGMc1Ff1byUVPufn3/kM
 OXKd61cDk+XIZ6WdKNdblrR8bP65nD20/ER0Hps8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40TCK8MS096526
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 29 Jan 2024 06:20:08 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 29
 Jan 2024 06:20:08 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 29 Jan 2024 06:20:07 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40TCK7SL077356;
 Mon, 29 Jan 2024 06:20:07 -0600
Date: Mon, 29 Jan 2024 06:20:07 -0600
From: Nishanth Menon <nm@ti.com>
To: Dhruva Gole <d-gole@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Francis
 <n-francis@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>
Subject: Re: [PATCH V3] firmware: ti_sci: fix the secure_hdr in do_xfer
Message-ID: <20240129122007.6p6rg2lnzaxw26j4@excretory>
References: <20240124130758.237233-1-d-gole@ti.com>
 <20240124180906.5gi46xdsb56rhx6h@prayer>
 <20240129061406.u2fpdgf3v7urxigu@dhruva>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240129061406.u2fpdgf3v7urxigu@dhruva>
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

On 11:44-20240129, Dhruva Gole wrote:
> On Jan 24, 2024 at 12:09:06 -0600, Nishanth Menon wrote:
> > On 18:37-20240124, Dhruva Gole wrote:
> > > The secure_hdr needs to be 0 init-ed however this was never being put
> > > into the secure_buf, leading to possibility of the first 4 bytes of
> > > secure_buf being possibly garbage.
> > > 
> > > Fix this by initialising the secure_hdr itself to the secure_buf
> > > location, thus when we make it 0, it automatically ensures the first 4
> > > bytes are 0.
> > > 
> > > Fixes: 32cd25128bd849 ("firmware: Add basic support for TI System Control Interface (TI SCI)")
> > > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > > ---
> > > 
> > > Boot tested for sanity on AM62x SK
> > > https://gist.github.com/DhruvaG2000/724ceba3a0db03f4b0bff47de1160074
> > > 
> > > Changelog:
> > > v2 --> v3
> > > Address Kamlesh's comment on v2: use sizeof(struct ti_sci_secure_msg_hdr)
> > 
> > Lets finish discussing in:
> > https://lore.kernel.org/all/20240124163910.sp7gt56lihoujm7k@etching/
> 
> Bringing the conversation back to this latest patch revision,
> Based on where we left off:
> https://lore.kernel.org/all/20240125171335.qoxphnemadkh7xjd@gullible/
> 
> Would it be better to add a comment above ``if (info->is_secure) {`` in
> drivers/firmware/ti_sci.c as follows:
> The secure path will be used by R5 SPL bcause it starts of in "secure mode" when it hands
> off from Boot ROM over to the Secondary bootloader.
> 
> Kindly advise if the patch needs respin with that minor change, and if the rest
> of it seems okay?
> 

improve the commit message and add a documentation patch to add
information around if (info->is_secure) please, so that we don't yet
again need to dig up history.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
