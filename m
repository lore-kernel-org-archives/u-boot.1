Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F1BC36005
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 04:07:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64D2B80F70;
	Tue, 25 Mar 2025 05:07:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F45D81026; Tue, 25 Mar 2025 05:07:02 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 508E180EEF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 05:07:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 52P46o4f030420
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Tue, 25 Mar 2025 12:06:50 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 12:06:50 +0800
Date: Tue, 25 Mar 2025 12:06:47 +0800
From: Leo Liang <ycliang@andestech.com>
To: Huan Zhou <me@per1cycle.org>
CC: u-boot <u-boot@lists.denx.de>, Rick Chen <rick@andestech.com>, Tom Rini
 <trini@konsulko.com>, Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH v2 2/4] riscv: reset: k1: Add reset driver
Message-ID: <Z-Ir1z9MHR7RtSG7@swlinux02>
References: <20250311-reset-k1-v2-0-8a838752c265@per1cycle.org>
 <20250311-reset-k1-v2-2-8a838752c265@per1cycle.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250311-reset-k1-v2-2-8a838752c265@per1cycle.org>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 52P46o4f030420
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

On Tue, Mar 11, 2025 at 09:38:49AM +0800, Huan Zhou wrote:
> Add spacemit reset driver.
> 
> Signed-off-by: Huan Zhou <me@per1cycle.org>
> ---
>  drivers/reset/Kconfig             |   7 +
>  drivers/reset/Makefile            |   1 +
>  drivers/reset/reset-spacemit-k1.c | 548 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 556 insertions(+)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
