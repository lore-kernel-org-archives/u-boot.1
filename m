Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A19C71136
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 04:59:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7453A82BD9;
	Thu, 12 Jun 2025 06:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XtHd5s48";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15D2682C4D; Thu, 12 Jun 2025 06:59:34 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EADD82B70
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 06:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55C4xTdO2808747;
 Wed, 11 Jun 2025 23:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1749704369;
 bh=GDcv+u2rjMSHl8WV8VTVhtrlzu8DS+Pn1SMZ4KWU+mY=;
 h=Date:CC:Subject:From:To:References:In-Reply-To;
 b=XtHd5s48yrlECm+Pk2XiQF9cMVpP3nTXKqYmRltRxSEcB5m/QstRFdw1IsfMp+62i
 u+rnuT10V+rDaQjAi8/o4XKRE37UmmbulvksfRydbEM1vREwjYvnhHYQpAjJYxxDUj
 sGVt/+jNzMY9MSgK8YG1ictlXyCcyJPz6fUkNyVM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55C4xThX2287946
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 11 Jun 2025 23:59:29 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 11
 Jun 2025 23:59:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 11 Jun 2025 23:59:28 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55C4xSE81597082;
 Wed, 11 Jun 2025 23:59:28 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 Jun 2025 10:28:53 +0530
Message-ID: <DAKAF5YRCY2T.39SSJYUIINTK7@ti.com>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCH -next 3/5] binman: add sysfw-inner-cert to
 missing-blob-help
From: Anshul Dalal <anshuld@ti.com>
To: Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>, "Alper Nebi
 Yasak" <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250611-missing-blob-help-entries-v1-0-c6de1844117f@ti.com>
 <20250611-missing-blob-help-entries-v1-3-c6de1844117f@ti.com>
In-Reply-To: <20250611-missing-blob-help-entries-v1-3-c6de1844117f@ti.com>
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

On Wed Jun 11, 2025 at 11:47 PM IST, Bryan Brattlof wrote:
> Now that the inner certificate for TI' Foundation Security TIFS firmware
> is mandatory to a successful build, provide some guidance on what it is
> and links to the documentation on how to obtain the firmware blobs.
>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  tools/binman/missing-blob-help | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/binman/missing-blob-help b/tools/binman/missing-blob-h=
elp
> index e28eaa2015443f256a469df4ead87793e23ba219..fcc989ed757e0d0a8d5bc8238=
c3d013da98aa390 100644
> --- a/tools/binman/missing-blob-help
> +++ b/tools/binman/missing-blob-help
> @@ -60,3 +60,13 @@ Have a look at your board's documentation to find the =
latest version of
>  the DM firmware binary and how to include it in the build.
> =20
>      https://docs.u-boot.org/en/latest/board/ti/k3.html
> +
> +sysfw-inner-cert:
> +You are missing the inner certificate for TI's Foundational Security (TI=
FS)
> +firmware which is critical to authenticating the TIFS firmware during bo=
ot.
> +HS-FS and HS-SE parts will not boot without this certificate.
> +
> +Have a look at your board's documentation to find and include the latest
> +TIFS certificate blobs and how to include them in the build.
> +
> +    https://docs.u-boot.org/en/latest/board/ti/k3.html

Nit: With the entries ordered alphabetically in the 1st patch, the entry
`sysfw-inner-cert` should go after `scp-sunxi` instead.

Reviewed-by: Anshul Dalal <anshuld@ti.com>
