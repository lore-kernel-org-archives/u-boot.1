Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DD0C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 13:29:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8520080F9C;
	Tue,  3 Jun 2025 15:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Oq/EliOs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E720282116; Tue,  3 Jun 2025 15:29:25 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCC2D8091A
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 15:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 553DTLoK3523983;
 Tue, 3 Jun 2025 08:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748957361;
 bh=pZwSH1ykrrcxMaZPHwOGj3z+c4ZcQmobKOehA5kXPoY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Oq/EliOs7Dit5yd3+cgn3ZFn8ECvmsfcxqmQt/f4qsA/1SMWEQIpp5FFEvqGklorj
 iw7plxYPnHrmdANDnC1W+jvp0bkE5Zq9PkPI3urFLuD4b3SxS66V8MNc3zIChi7NH7
 +wFEm0hwxXqi8cHevtaYG9RrGdeb8B5VK5dFbuaA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 553DTLRJ3634820
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 3 Jun 2025 08:29:21 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Jun 2025 08:29:20 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Jun 2025 08:29:21 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 553DTKZC488953;
 Tue, 3 Jun 2025 08:29:20 -0500
Date: Tue, 3 Jun 2025 08:29:20 -0500
From: Bryan Brattlof <bb@ti.com>
To: Moteen Shah <m-shah@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <d-gole@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH 2/6] ti_sci_* : Add capability to access DM firmware's
 metadata
Message-ID: <20250603132920.fnhfcdlkzycxxgks@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250528080519.677750-1-m-shah@ti.com>
 <20250528080519.677750-3-m-shah@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250528080519.677750-3-m-shah@ti.com>
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

On May 28, 2025 thus sayeth Moteen Shah:
> Introduce response and request structs to receive and request
> information regarding DM version, etc from TI SCI.
> 
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---
>  drivers/firmware/ti_sci.h              | 29 ++++++++++++++++++++++++++
>  include/linux/soc/ti/ti_sci_protocol.h | 26 +++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
> index f3d9eb453b4..6ef77d83114 100644
> --- a/drivers/firmware/ti_sci.h
> +++ b/drivers/firmware/ti_sci.h
> @@ -19,6 +19,7 @@
>  #define TI_SCI_MSG_ENABLE_WDT		0x0000
>  #define TI_SCI_MSG_WAKE_RESET		0x0001
>  #define TI_SCI_MSG_VERSION		0x0002
> +#define TI_SCI_MSG_DM_VERSION		0x000F

These definitions are in order

>  #define TI_SCI_MSG_WAKE_REASON		0x0003
>  #define TI_SCI_MSG_GOODBYE		0x0004
>  #define TI_SCI_MSG_SYS_RESET		0x0005

~Bryan
