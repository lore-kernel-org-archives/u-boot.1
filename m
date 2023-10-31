Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D831C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 11:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46E1E87B4D;
	Tue, 31 Oct 2023 12:23:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="M1hJuQUa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDFA787B1B; Tue, 31 Oct 2023 08:58:22 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4DD687134
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 08:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39V7wHHH118568;
 Tue, 31 Oct 2023 02:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698739097;
 bh=AtUhvmD2bLDX3cgNczhdnHe0/XzH07M0nctDIB9eKnk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=M1hJuQUa2oXt7O2IqjRaBkf7i/4FDNS/RGqA8bVnR4m6t8EvmqphGQZ0fBkiRWcpW
 Csle+0YyD9OUeFb19B18j7w/y3XQ+WfjjNNZWp37AJ//FLefFohnnnuSoNY0JOA7ym
 GTxCnDsFLyOOQi+JNcBhD7k3ytnyLxGVS6vtri6c=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39V7wHdB068974
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 31 Oct 2023 02:58:17 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 31
 Oct 2023 02:58:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 31 Oct 2023 02:58:17 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39V7wGF0104617;
 Tue, 31 Oct 2023 02:58:17 -0500
Date: Tue, 31 Oct 2023 13:28:16 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Nitin Yadav <n-yadav@ti.com>
CC: <nm@ti.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 3/4] board: ti: am62x: add am62x_lpsk_*_defconfigs
 fragments
Message-ID: <20231031075816.74ximv5vw3ixqt5r@dhruva>
References: <20231030110138.1347603-1-n-yadav@ti.com>
 <20231030110138.1347603-4-n-yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231030110138.1347603-4-n-yadav@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 31 Oct 2023 12:23:29 +0100
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

Hi Nitin,

On Oct 30, 2023 at 16:31:37 +0530, Nitin Yadav wrote:
> Add defconfig fragments for AM62x LP SK for for AM62x LP SK.

Please check and re-word the commit message.

> 
> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> ---
>  board/ti/am62x/am62x_lpsk_a53.config | 5 +++++
>  board/ti/am62x/am62x_lpsk_r5.config  | 5 +++++
>  2 files changed, 10 insertions(+)
>  create mode 100644 board/ti/am62x/am62x_lpsk_a53.config
>  create mode 100644 board/ti/am62x/am62x_lpsk_r5.config
> 
> diff --git a/board/ti/am62x/am62x_lpsk_a53.config b/board/ti/am62x/am62x_lpsk_a53.config
> new file mode 100644
> index 0000000000..a568324997
> --- /dev/null
> +++ b/board/ti/am62x/am62x_lpsk_a53.config
> @@ -0,0 +1,5 @@
> +# Defconfig fragment to apply on top of am62x_evm_a53_defconfig
> +
> +CONFIG_DEFAULT_DEVICE_TREE="k3-am62-lp-sk"
> +CONFIG_SPL_OF_LIST="k3-am62-lp-sk"
> +CONFIG_OF_LIST="k3-am62-lp-sk"
> diff --git a/board/ti/am62x/am62x_lpsk_r5.config b/board/ti/am62x/am62x_lpsk_r5.config
> new file mode 100644
> index 0000000000..1532f4e336
> --- /dev/null
> +++ b/board/ti/am62x/am62x_lpsk_r5.config
> @@ -0,0 +1,5 @@
> +# Defconfig fragment to apply on top of am62x_evm_r5_defconfig
> +
> +CONFIG_DEFAULT_DEVICE_TREE="k3-am62-r5-lp-sk"
> +CONFIG_SPL_OF_LIST="k3-am62-r5-lp-sk"
> +CONFIG_OF_LIST="k3-am62-r5-lp-sk"

Changes look fine, so with commit message fixed,

Reviewed-by: Dhruva Gole <d-gole@ti.com>

> -- 
> 2.25.1
> 
> 

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>
