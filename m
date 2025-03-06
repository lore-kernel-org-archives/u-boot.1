Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B30C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 04:45:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B89480BAA;
	Thu,  6 Mar 2025 05:45:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D673380E94; Thu,  6 Mar 2025 05:45:37 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C1B6808A2
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 05:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 5264jINp010592
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Thu, 6 Mar 2025 12:45:18 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 12:45:18 +0800
Date: Thu, 6 Mar 2025 12:45:14 +0800
From: Leo Liang <ycliang@andestech.com>
To: Huan Zhou <me@per1cycle.org>
CC: u-boot <u-boot@lists.denx.de>, Rick Chen <rick@andestech.com>, Tom Rini
 <trini@konsulko.com>, Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH 2/4] riscv: reset: k1: Add reset driver
Message-ID: <Z8koWq8immMfhMr8@swlinux02>
References: <20250304-reset-k1-v1-0-dc9510ff1113@per1cycle.org>
 <20250304-reset-k1-v1-2-dc9510ff1113@per1cycle.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250304-reset-k1-v1-2-dc9510ff1113@per1cycle.org>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 5264jINp010592
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

Hi Huan,

Please run scripts/checkpatch.pl against your patchset 
and respin a v2 after all the warnings & errors are attended to.

Thanks,
Leo

On Tue, Mar 04, 2025 at 03:03:28PM +0800, Huan Zhou wrote:
> Add spacemit reset driver.
> ---
>  drivers/reset/Kconfig             |   7 +
>  drivers/reset/Makefile            |   1 +
>  drivers/reset/reset-spacemit-k1.c | 438 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 446 insertions(+)
