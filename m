Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF9DC77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 10:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0667822D7;
	Thu,  3 Jul 2025 12:01:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E394F82EA9; Thu,  3 Jul 2025 12:01:45 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C3778091A
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 12:01:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 563A1IY3000644
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Thu, 3 Jul 2025 18:01:18 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Jul
 2025 18:01:18 +0800
Date: Thu, 3 Jul 2025 18:01:15 +0800
From: Leo Liang <ycliang@andestech.com>
To: Yao Zi <ziyao@disroot.org>
CC: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>, Wei Fu
 <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>,
 <u-boot@lists.denx.de>, "Han Gao" <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>
Subject: Re: [PATCH 1/3] pinctrl: Port pin controller driver for T-Head
 TH1520 SoC
Message-ID: <aGZU6-HW7sYG71An@swlinux02>
References: <20250618095457.45926-1-ziyao@disroot.org>
 <20250618095457.45926-2-ziyao@disroot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250618095457.45926-2-ziyao@disroot.org>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 563A1IY3000644
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

On Wed, Jun 18, 2025 at 09:54:55AM +0000, Yao Zi wrote:
> The SoC pads of TH1520 are separated into three groups (AP 1, AP 2 and
> AON) controlled by independent pin controllers. This patch ports their
> driver from Linux kernel with most code for setting pinconf and pinmux
> kept as is.
> 
> The dt-binding of TH1520 pin controller uses a schema where pins to
> configure are specfied as strings and looked up at runtime, which the
> generic pinctrl helpers of U-Boot cannot parse, thus a customized
> set_state() callback is implemented to parse pinconfig nodes and setup
> the configuration.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  MAINTAINERS                      |   1 +
>  drivers/pinctrl/Kconfig          |   8 +
>  drivers/pinctrl/Makefile         |   1 +
>  drivers/pinctrl/pinctrl-th1520.c | 700 +++++++++++++++++++++++++++++++
>  4 files changed, 710 insertions(+)
>  create mode 100644 drivers/pinctrl/pinctrl-th1520.c

Acked-by: Leo Yu-Chi Liang <ycliang@andestech.com>
