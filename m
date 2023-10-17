Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844AFCDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 07:22:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84A8D86BE0;
	Tue, 17 Oct 2023 09:22:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8857586BD7; Tue, 17 Oct 2023 09:22:09 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F83C86C39
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 09:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 39H7LvLP070662;
 Tue, 17 Oct 2023 15:21:57 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Tue, 17 Oct 2023 15:21:52 +0800
Date: Tue, 17 Oct 2023 15:19:03 +0800
From: Leo Liang <ycliang@andestech.com>
To: Randolph <randolph@andestech.com>
CC: <u-boot@lists.denx.de>, <randolph.sklin@gmail.com>, <dylan@andestech.com>, 
 <tim609@andestech.com>, <peterlin@andestech.com>
Subject: Re: [PATCH V2 6/7] andes: config: add riscv falcon mode for ae350
 platform
Message-ID: <ZS41Z6lV1I_JwvLP@swlinux02>
References: <20231012063509.2963258-1-randolph@andestech.com>
 <20231012063509.2963258-7-randolph@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231012063509.2963258-7-randolph@andestech.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 39H7LvLP070662
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

On Thu, Oct 12, 2023 at 02:35:08PM +0800, Randolph wrote:
> Fork from ae350_rv[32/64]_spl_[xip]_defconfig and
> append CONFIG_SPL_LOAD_FIT_OPENSBI_OS_BOOT=y
> 
> Signed-off-by: Randolph <randolph@andestech.com>
> ---
>  configs/ae350_rv32_falcon_defconfig     | 60 ++++++++++++++++++++++++
>  configs/ae350_rv32_falcon_xip_defconfig | 61 +++++++++++++++++++++++++
>  configs/ae350_rv64_falcon_defconfig     | 60 ++++++++++++++++++++++++
>  configs/ae350_rv64_falcon_xip_defconfig | 61 +++++++++++++++++++++++++
>  4 files changed, 242 insertions(+)
>  create mode 100644 configs/ae350_rv32_falcon_defconfig
>  create mode 100644 configs/ae350_rv32_falcon_xip_defconfig
>  create mode 100644 configs/ae350_rv64_falcon_defconfig
>  create mode 100644 configs/ae350_rv64_falcon_xip_defconfig

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
