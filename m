Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E750E748F6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 16:31:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EDA986D7B;
	Mon,  2 Oct 2023 18:31:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PgvDoYg/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91DDD87161; Mon,  2 Oct 2023 18:19:58 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B871870DE
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 18:19:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 392GJj7V092883;
 Mon, 2 Oct 2023 11:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1696263586;
 bh=lh2vJoc8TOB2GxcSoI5Yq39lCkltIbtVLPbSV30+G1w=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=PgvDoYg/93bMR4nK7CoNq9RGk9GvtmiJzpsLqK7M2GKFFnGjQHxKFZw6PqgYgRn4y
 y902X3Jgy3FkH49W3V+Z7GrMBs3PgVaOnEnmXOy+xI5oo73/AZWqUB+Ca5Kox8curg
 P3zKCgo8ZbmtJvS+tzNJUWi/Z0IzZp7hXC0ZSZr8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 392GJjEd098148
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 2 Oct 2023 11:19:45 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 2
 Oct 2023 11:19:45 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 2 Oct 2023 11:19:45 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 392GJjqE042459;
 Mon, 2 Oct 2023 11:19:45 -0500
Date: Mon, 2 Oct 2023 11:19:45 -0500
From: Nishanth Menon <nm@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: <trini@konsulko.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>,
 <sjg@chromium.org>, <jonas@kwiboo.se>, <srk@ti.com>, <afd@ti.com>,
 <bb@ti.com>, <praneeth@ti.com>, <u-boot@lists.denx.de>,
 <massimo.pegorer+oss@gmail.com>
Subject: Re: [PATCH 1/6] arm: dts: k3-am64-evm: Fix boot
Message-ID: <20231002161945.m3ov2xbgwy75wrd3@hypertext>
References: <20230929134646.214781-1-rogerq@kernel.org>
 <20230929134646.214781-2-rogerq@kernel.org>
 <20231002151933.vxjpor26m6g4pgm3@compactor>
 <2da83643-3dbc-422b-97a4-477fcf259c76@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2da83643-3dbc-422b-97a4-477fcf259c76@kernel.org>
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

On 19:14-20231002, Roger Quadros wrote:
[...]

> 
> Please see suggestion by Massimo here
> https://lore.kernel.org/all/CAC928HY2rZoz6L8za+L20GAsbJCBYOe+k75L_N3aE-78smnLfg@mail.gmail.com/
> 
> Do you agree we should change this series to use bootph-some-ram instead?

Actually I dont like usage of bootph-some-ram as a hack. We dont
have any DDR in the initial stages of R5 SPL. I'd rather stick with
bootph-all and pre-ram which is accurate for the staged boot sequence
we are following.

Further, boot-ph-all and pre-ram is already the direction we are moving in
kernel dts to make syncs easier in the future. unless there is a strong
reasoning on an alternate rationale, i'd rather not mess with the flow
in play already.

Personally though, I am miffed at a breaking change of this form :(

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
