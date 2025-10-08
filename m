Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5471ECAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 13:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A78C83EA9;
	Wed,  8 Oct 2025 15:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IWGbccj0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2213E83EAB; Wed,  8 Oct 2025 15:32:15 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29F6A8394A
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 15:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 598DW5DX233302;
 Wed, 8 Oct 2025 08:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759930325;
 bh=hsp3miM8S2XuPwiOSCdGLuaOyRt/7LmdU2ztp3ugZQs=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=IWGbccj0tx1yPAQLBLsc9mAr9VLOUyUaU3PRd4RAljW8RNcM+DA6rG3m/YbyqABiQ
 /FkDXaLAHaxx7y5ErRcFBc27rTMGl9VQpxqmTQoKzKd42tjoewcPXCa5XqhN4/XVU3
 BX7Ycp4Y4AJSrIKoFJLzJY+q5e1pXCLjh2M6IW9M=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 598DW4UK1487444
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 8 Oct 2025 08:32:05 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 8
 Oct 2025 08:32:04 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Oct 2025 08:32:04 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 598DW31w2844142;
 Wed, 8 Oct 2025 08:32:04 -0500
Date: Wed, 8 Oct 2025 19:02:03 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <b-padhi@ti.com>, <vigneshr@ti.com>,
 <trini@konsulko.com>, <nm@ti.com>, <robertcnelson@gmail.com>,
 <w.egorov@phytec.de>, <francesco.dolcini@toradex.com>,
 <ggiordano@phytec.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>
Subject: Re: [PATCH -next v8 08/11] spl: split spl_board_fixups to arch/board
 specific
Message-ID: <20251008133203.34l3xcqhwj6uwvv2@lcpd911>
References: <20251006082852.4008937-1-anshuld@ti.com>
 <20251006082852.4008937-9-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251006082852.4008937-9-anshuld@ti.com>
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

On Oct 06, 2025 at 13:58:46 +0530, Anshul Dalal wrote:
> The current spl_board_fixups API allows for modification of spl_image
> before the SPL jumps to it. This can be used to modify the DT for the
> next boot stage, however the current API only allows either the machine
> arch or the board to use it.
> 
> This limits the utility of the API as there might be certain fixups that
> should be applied to all boards sharing the same machine architecture
> with others being board specific.
> 
> For TI's K3 specifically, this prevents us from performing architecture
> level fixups since a lot of TI boards are already making use of the
> spl_board_fixups API.
> 
> Therefore this patch splits the API into two to allow both board and the
> architecture specific fixups. The order is kept as arch then board to
> give board specific fixups the precedence.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> Tested-by: Wadim Egorov <w.egorov@phytec.de>

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
