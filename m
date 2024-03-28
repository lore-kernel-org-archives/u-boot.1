Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3769C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 11:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B69A88165;
	Thu, 28 Mar 2024 12:59:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E614888165; Thu, 28 Mar 2024 12:59:14 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18D3288169
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 12:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 42SBx5BP092532;
 Thu, 28 Mar 2024 19:59:05 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 28 Mar 2024 19:59:04 +0800
Date: Thu, 28 Mar 2024 19:59:01 +0800
From: Leo Liang <ycliang@andestech.com>
To: =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>
CC: <u-boot@lists.denx.de>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] riscv: Move virtio scan to board_late_init()
Message-ID: <ZgVbhRUNOdoTxrTj@swlinux02>
References: <CGME20240328095912eucas1p1f064f0460cf71edcfd82ca1782906a44@eucas1p1.samsung.com>
 <20240328095824.1179072-1-l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240328095824.1179072-1-l.stelmach@samsung.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 42SBx5BP092532
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

On Thu, Mar 28, 2024 at 10:58:24AM +0100, Łukasz Stelmach wrote:
> [EXTERNAL MAIL]
> 
> When virtio_init() gets called from board_init() PCI isn't ready. Thus,
> virtio-over-PCI (e.g. network interfaces) devices can't be detected and
> used without additional `virtio scan` scan in the shell or a script.
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
> Changes since v1:
>  - remove virtio_init() call from board_init()
>  - select BOARD_LATE_INIT for TARGET_QEMU_VIRT
> 
>  arch/riscv/Kconfig                      |  1 +
>  board/emulation/qemu-riscv/qemu-riscv.c | 12 ++++++------
>  2 files changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
