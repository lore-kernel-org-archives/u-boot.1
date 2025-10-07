Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6E0CAC5B0
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 04:57:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 440E7838E7;
	Tue,  7 Oct 2025 06:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vb5AvrrL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E70C0839A8; Tue,  7 Oct 2025 06:57:34 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97BA28399B
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 06:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5974vRVh4137832;
 Mon, 6 Oct 2025 23:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759813047;
 bh=32xOVUIA7i5IA4+a7ol3CITI/FxwGrWhamzCRiv8aLE=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=vb5AvrrL49xRFks35aWhWxy2uON8GJ+RLmNmIP6F4qfh8eFjxls1wTRAlWbrlRQrw
 ppEUL2So+BSFsx3o9y66LqKwzeWhWLhqEDygU0nkLGmZQml5+o6E8hh8an41zxePxv
 ekNu7JVHf8twDyLquHLfNpj2mNdois/YjEGm3Vqo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5974vR1Y437195
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 6 Oct 2025 23:57:27 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 6
 Oct 2025 23:57:27 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Oct 2025 23:57:26 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5974vPj8340368;
 Mon, 6 Oct 2025 23:57:26 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 7 Oct 2025 10:27:25 +0530
Message-ID: <DDBTNSBH2KU8.2XX8EUHRR7MS1@ti.com>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCH RESEND] ufs: ti-j721e: Correct error detection
From: Anshul Dalal <anshuld@ti.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Bhupesh Sharma <bhupesh.linux@gmail.com>, Neha
 Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251006-ufs_ti-v1-1-f37bf96d3ade@linaro.org>
In-Reply-To: <20251006-ufs_ti-v1-1-f37bf96d3ade@linaro.org>
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

Hi Andrew,

On Mon Oct 6, 2025 at 9:01 PM IST, Andrew Goodbody wrote:
> In ti_j721e_ufs_probe there is a call to clk_get_rate but the code after
> that attempts to detect an error from that call incorrectly uses
> IS_ERR_VALUE.  Instead the test should just be for regular error codes.
> The call returns an unsigned long so that needs to be cast to a signed ty=
pe
> first of all.
>
> This issue was found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/ufs/ti-j721e-ufs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ufs/ti-j721e-ufs.c b/drivers/ufs/ti-j721e-ufs.c
> index c5c08610ffd0422c9cf9d8e85b0396e6102cb29a..d50918912b2168db4e00c3cac=
0a9c54872a76602 100644
> --- a/drivers/ufs/ti-j721e-ufs.c
> +++ b/drivers/ufs/ti-j721e-ufs.c
> @@ -17,7 +17,7 @@
>  static int ti_j721e_ufs_probe(struct udevice *dev)
>  {
>  	void __iomem *base;
> -	unsigned int clock;
> +	unsigned long clock;
>  	struct clk clk;
>  	u32 reg =3D 0;
>  	int ret;
> @@ -29,9 +29,9 @@ static int ti_j721e_ufs_probe(struct udevice *dev)
>  	}
> =20
>  	clock =3D clk_get_rate(&clk);
> -	if (IS_ERR_VALUE(clock)) {
> +	if ((long)clock < 0) {

Should we be checking for clock =3D=3D 0 as well? Because clk_get_rate does
return 0 on invalid clock.

Regards,
Anshul

>  		dev_err(dev, "failed to get rate\n");
> -		return ret;
> +		return clock;
>  	}
> =20
>  	base =3D dev_remap_addr_index(dev, 0);
>
> ---
> base-commit: 7807ed921314cd7af83fd88162d0b8c6fb20a9ca
> change-id: 20250813-ufs_ti-dd699eb6524e
>
> Best regards,

