Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4621ACCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 11:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9CA78394A;
	Wed,  8 Oct 2025 13:46:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PWnzAW3B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E40B88394E; Wed,  8 Oct 2025 13:46:13 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72FD483935
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 13:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 598Bk7vs3967438;
 Wed, 8 Oct 2025 06:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759923967;
 bh=SxDQsXEIy5qVPtFCIi/BDsjvhg4LbVTZASrNVDOC7gQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=PWnzAW3BsxYyoiVt5/91HTD53OxjrfMUxPPeqALM2xw23UMlvFeBPW/8SnQjwBA5e
 E9cgVGdbMDbSb9xeABK9VaqI/Gvu3eScN7X+POLwhh5TExQuQul+sS2gPwL4hFbfgf
 mwgcNqaU6q5sO7xkTVrjyGpxsL42RMU0wk21l8lQ=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 598Bk7OV613867
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 8 Oct 2025 06:46:07 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 8
 Oct 2025 06:46:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Oct 2025 06:46:06 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 598Bk5Df2481534;
 Wed, 8 Oct 2025 06:46:06 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 8 Oct 2025 17:16:05 +0530
Message-ID: <DDCWZ8AB2875.3FWDC8UAWN07H@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Dhruva
 Gole <d-gole@ti.com>, Moteen Shah <m-shah@ti.com>, "Nishanth Menon"
 <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Udit Kumar
 <u-kumar1@ti.com>
Subject: Re: [PATCH v3 0/3] ti_sci: Address some issues found by Smatch
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251008-ti_sci-v3-0-5866bf84adc6@linaro.org>
In-Reply-To: <20251008-ti_sci-v3-0-5866bf84adc6@linaro.org>
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

On Wed Oct 8, 2025 at 2:53 PM IST, Andrew Goodbody wrote:
> Prevent a memory leak from a non-freed malloc.
> Return an error code on an error path.
> Assign a value to a pointer before it is dereferenced.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
> Changes in v3:
> - Pick up review tags
> - Change dev_dbg call to dev_err to be consistent with surrounding code
>   in 2/3
> - Update subject line of 3/3 to be more explicit
> - Link to v2: https://lore.kernel.org/r/20251007-ti_sci-v2-0-7561d7ea07b2=
@linaro.org
>
> Changes in v2:
> - Add cast when assigning to resp
> - Replace malloc with devm_kmalloc
> - Link to v1: https://lore.kernel.org/r/20251006-ti_sci-v1-0-9cef92e1022d=
@linaro.org
>
> ---
> Andrew Goodbody (3):
>       ti_sci: Prevent memory leak
>       ti_sci: Provide error code on error exit
>       ti_sci: Pointer is never assigned to valid value
>
>  drivers/firmware/ti_sci.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> ---
> base-commit: c280c4f7e52f08255f491783b3143a3be1fc08b0
> change-id: 20250725-ti_sci-7bc55cb0cdba
>
> Best regards,

For the entire series:

Tested-by: Anshul Dalal <anshuld@ti.com> (on TI AM62x EVM)

Thanks for the cleanup!
Regards,
Anshul

