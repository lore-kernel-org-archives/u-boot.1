Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15EBC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 06:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4D2E87CF2;
	Tue, 12 Mar 2024 07:32:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC76987D55; Tue, 12 Mar 2024 07:32:12 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A775587CAC
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 07:32:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 42C6Vp8q032993;
 Tue, 12 Mar 2024 14:31:51 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Tue, 12 Mar 2024 14:31:49 +0800
Date: Tue, 12 Mar 2024 14:31:45 +0800
From: Leo Liang <ycliang@andestech.com>
To: Nam Cao <namcao@linutronix.de>
CC: <yanhong.wang@starfivetech.com>, <chanho61.park@samsung.com>,
 <wiagn233@outlook.com>, <sjg@chromium.org>, <inindev@gmail.com>,
 <rick@andestech.com>, <mps@arvanta.net>, <bmeng@tinylab.org>,
 <u-boot@lists.denx.de>
Subject: Re: [PATCH] starfive: visionfive2: switch to standard boot
Message-ID: <Ze_20XqHsrsaudWS@swlinux02>
References: <20240221120014.149193-1-namcao@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240221120014.149193-1-namcao@linutronix.de>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 42C6Vp8q032993
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

On Wed, Feb 21, 2024 at 01:00:14PM +0100, Nam Cao wrote:
> Distro boot scripts are deprecated. Use standard boot instead.
> 
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  configs/starfive_visionfive2_defconfig |  2 +-
>  include/configs/starfive-visionfive2.h | 14 +-------------
>  2 files changed, 2 insertions(+), 14 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
