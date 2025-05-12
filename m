Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA1EC3ABCB
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 17:56:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91CEB80C83;
	Mon, 12 May 2025 19:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2826C826AA; Mon, 12 May 2025 19:56:38 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC38F80584
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 19:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 54CHu2h1053573
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Tue, 13 May 2025 01:56:02 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 13 May
 2025 01:56:02 +0800
Date: Tue, 13 May 2025 01:55:59 +0800
From: Leo Liang <ycliang@andestech.com>
To: Yao Zi <ziyao@disroot.org>
CC: Rick Chen <rick@andestech.com>, Tom Rini <trini@konsulko.com>, Wei Fu
 <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>, Maksim Kiselev
 <bigunclemax@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, Neha Malcom Francis
 <n-francis@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Vaishnav Achath <vaishnav.a@ti.com>, Andrew Davis
 <afd@ti.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, <u-boot@lists.denx.de>,
 Han Gao <rabenda.cn@gmail.com>, Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH 04/10] ram: thead: Add initial DDR controller support for
 TH1520
Message-ID: <aCI2LwQqc_YehBAM@swlinux02>
References: <20250426165704.35523-1-ziyao@disroot.org>
 <20250426165704.35523-5-ziyao@disroot.org>
 <aA0TPBV_YN3IHGAf@pie.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aA0TPBV_YN3IHGAf@pie.lan>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 54CHu2h1053573
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

On Sat, Apr 26, 2025 at 05:09:16PM +0000, Yao Zi wrote:
> [EXTERNAL MAIL]
> 
> On Sat, Apr 26, 2025 at 04:56:58PM +0000, Yao Zi wrote:
> > This patch cleans the vendor code of DDR initialization up, converts the
> > driver to fit in DM framework and use a firmware[1] packaged by binman to
> > ship PHY configuration.
> >
> > Currently the driver is only capable of initializing the controller to
> > work with dual-rank 3733MHz LPDDR4, which is shipped by 16GiB variants
> > of LicheePi 4A boards and I could test with. Support for other
> > configurations could be easily added later.
> 
> I wrongly repeated this patch twice when sending the series, sorry for
> the noise.
> 
> > Link: https://github.com/ziyao233/th1520-firmware # [1]
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  drivers/ram/Kconfig            |   1 +
> >  drivers/ram/Makefile           |   4 +
> >  drivers/ram/thead/Kconfig      |   5 +
> >  drivers/ram/thead/Makefile     |   1 +
> >  drivers/ram/thead/th1520_ddr.c | 781 +++++++++++++++++++++++++++++++++
> >  5 files changed, 792 insertions(+)
> >  create mode 100644 drivers/ram/thead/Kconfig
> >  create mode 100644 drivers/ram/thead/Makefile
> >  create mode 100644 drivers/ram/thead/th1520_ddr.c
> 
> And here is missing an SPDX license header and a copyright notice. I'll
> add them in v2.

Hi Yao,

You could add my reviewed-by tag when sending v2 patch.

Best regards,
Leo

> 
> Thanks,
> Yao Zi
