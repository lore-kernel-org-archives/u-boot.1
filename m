Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F56CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 06:02:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B763D86E3B;
	Thu, 12 Oct 2023 08:02:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="auSQNDnJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A5FB86DB1; Thu, 12 Oct 2023 08:02:26 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 706EF86D41
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39C62AKk067539;
 Thu, 12 Oct 2023 01:02:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697090531;
 bh=Y4PgvB+gZhmAdW09Pt6IbGD1ebP+wTATlswwlZVbHE0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=auSQNDnJrUbq7p8eKv2YPIi3JI9ZTxUDknMtKmOwL5OcLhnh/MXXWDYHdjWot1Z2z
 RcqaEJNbowjsiEGMU1aRcMnOFjlQ+/4+pMfHEmsQVoP1M1QKZCGsXRy0p++VvtBEsW
 +uadKm+cWl/tDMUyr8pgloD1/5FOUIHDAyxRtgaQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39C62AQR057207
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 12 Oct 2023 01:02:10 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Oct 2023 01:02:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Oct 2023 01:02:10 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39C629SA024219;
 Thu, 12 Oct 2023 01:02:10 -0500
Date: Thu, 12 Oct 2023 11:32:09 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Neha Malcom Francis <n-francis@ti.com>, Andrew
 Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>, Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon
 <nm@ti.com>
Subject: Re: [PATCH v4 1/8] binman: ti-secure: Add support for firewalling
 entities
Message-ID: <20231012060209.ufdhnpqnxjcetx75@ula0497581>
References: <20231011-binman-firewalling-v4-0-a08085d300e9@ti.com>
 <20231011-binman-firewalling-v4-1-a08085d300e9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231011-binman-firewalling-v4-1-a08085d300e9@ti.com>
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

Hi Simon,

On 11:54-20231011, Manorit Chawdhry wrote:
> We can now firewall entities while loading them through our secure
> entity TIFS, the required information should be present in the
> certificate that is being parsed by TIFS.
> 
> The following commit adds the support to enable the certificates to be
> generated if the firewall configurations are present in the binman dtsi
> nodes.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
[..]
>  tools/binman/btool/openssl.py   | 16 +++++++-
>  tools/binman/etype/ti_secure.py | 90 +++++++++++++++++++++++++++++++++++++++++
>  tools/binman/etype/x509_cert.py |  3 +-
>  3 files changed, 106 insertions(+), 3 deletions(-)
> 
>  from binman.entry import EntryArg
>  from binman.etype.x509_cert import Entry_x509_cert
> +from dataclasses import dataclass

What all python versions do we support in u-boot? I see that dataclasses
are in-built from python3.7 but for older versions we would need to
install them separately, do I need to add this in buildman requirements
for those versions?

Regards,
Manorit
