Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879E8C4828C
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 02:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BEF1875E9;
	Wed, 31 Jan 2024 03:57:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42FDA8785F; Wed, 31 Jan 2024 03:57:50 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F726875A0
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 03:57:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 40V2vXCb008707;
 Wed, 31 Jan 2024 10:57:33 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Wed, 31 Jan 2024 10:57:28 +0800
Date: Wed, 31 Jan 2024 10:57:25 +0800
From: Leo Liang <ycliang@andestech.com>
To: Aurelien Jarno <aurelien@aurel32.net>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCH] riscv: qemu: enable booting on a second virtio device
Message-ID: <Zbm3FRB8fZNaquA8@swlinux02>
References: <20240110202656.984622-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240110202656.984622-1-aurelien@aurel32.net>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 40V2vXCb008707
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

On Wed, Jan 10, 2024 at 09:26:53PM +0100, Aurelien Jarno wrote:
> QEMU RISC-V supports multiple virtio devices, but only tries to boot to
> the first one. Enable support for a second virtio device, that is useful
> for instance to boot on a disk image + an installer. Ideally that should
> be made dynamic, but that's a first step.
> 
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>  include/configs/qemu-riscv.h | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
