Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D7DC28B2F
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 04:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BA8580F4C;
	Fri, 14 Mar 2025 05:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oELqS+Rd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86FD680F6B; Fri, 14 Mar 2025 05:51:18 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04BDD808A2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 05:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52E4pBnc2043982
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Mar 2025 23:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1741927871;
 bh=a1SP0lFW1ZTiRpmV0CI8dQBH0QP0WSfiPlyipnbu9VY=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=oELqS+RdKO4kadMhdOmRdj8nwUpRU4V8Z4mIBMVncDPT7rKdx4a3hDvIps35Iu3Bl
 p6kjsyBrSB23MrPvZD5t8+d+aXHCjiZDBx3TH+VFimflOan2Gy8mBKAjQMrMw3511g
 N4dK46kXQga5bTjKD/k39OrIjvqT15yJYroGGRL0=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52E4pBMe018100
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 13 Mar 2025 23:51:11 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Mar 2025 23:51:11 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Mar 2025 23:51:11 -0500
Received: from localhost (a0543016.dhcp.ti.com [172.24.227.196])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52E4pATL081204;
 Thu, 13 Mar 2025 23:51:11 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 14 Mar 2025 10:21:10 +0530
Message-ID: <D8FPW8AY1U12.2MPS0YXJXMTJ7@ti.com>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2] config: falcon: move CFG_SYS_SPI_* to Kconfig
From: Anshul Dalal <anshuld@ti.com>
To: Anshul Dalal <anshuld@ti.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.17.0
References: <20250311044414.3155688-1-anshuld@ti.com>
In-Reply-To: <20250311044414.3155688-1-anshuld@ti.com>
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

On Tue Mar 11, 2025 at 10:14 AM IST, Anshul Dalal wrote:
> CFG_SYS_SPI_* are used in falcon boot to specify the offsets and size of
> the respective payloads. This patch moves them to Kconfig keeping the
> values consistent for each of the affected boards.
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
> Tested:
>  * U-boot CI: https://github.com/u-boot/u-boot/pull/750

Refer to the below link for CI tests instead:
  https://github.com/u-boot/u-boot/commit/acf49ef771fb993e1b8e313dafb6b682c=
1037ebf

Anshul
