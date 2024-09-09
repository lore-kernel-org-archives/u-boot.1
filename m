Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3935CD4F4C
	for <u-boot@archiver.kernel.org>; Mon,  9 Sep 2024 07:10:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 172BF88D36;
	Mon,  9 Sep 2024 09:10:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9584488D36; Mon,  9 Sep 2024 09:10:08 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F2A388C7C
 for <u-boot@lists.denx.de>; Mon,  9 Sep 2024 09:10:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 48979thI012224
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Mon, 9 Sep 2024 15:09:55 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:09:56 +0800
Date: Mon, 9 Sep 2024 15:09:54 +0800
From: Leo Liang <ycliang@andestech.com>
To: Eva Kurchatova <nyandarknessgirl@gmail.com>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/3] riscv: qemu: Enable booting from NVMe
Message-ID: <Zt6fQvOgPWykpDX7@swlinux02>
References: <CA+eeCSMKifhHwf+oYm-vamSyimoAycEN_U5RZj3bCX3Q5qsdwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CA+eeCSMKifhHwf+oYm-vamSyimoAycEN_U5RZj3bCX3Q5qsdwQ@mail.gmail.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 48979thI012224
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

Hi Eva,

The other two patches of this patch series are accidently sent via "Reply".
Could you please re-send this series of patches to mailing list? 
Other than that, LGTM. 

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>

On Wed, Jul 17, 2024 at 09:22:26PM +0300, Eva Kurchatova wrote:
> [EXTERNAL MAIL]
> 
> From da876ced5ff607a4f21e30ab26fb1a972af56570 Mon Sep 17 00:00:00 2001
> From: LekKit <50500857+LekKit@users.noreply.github.com>
> Date: Wed, 17 Jul 2024 20:31:21 +0300
> Subject: [PATCH 1/3] riscv: qemu: Enable booting from NVMe
> 
> QEMU supports NVMe devices, but U-Boot only tries to boot from Virtio.
> This is problematic when explicitly using NVMe, so fix that.
> 
> Additionally, RVVM virtual machine is almost fully compatible with QEMU,
> except it only implements NVMe drives instead of VirtIO.
> ---
>  include/configs/qemu-riscv.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/configs/qemu-riscv.h b/include/configs/qemu-riscv.h
> index 2f594bfc..cf4fcb90 100644
> --- a/include/configs/qemu-riscv.h
> +++ b/include/configs/qemu-riscv.h
> @@ -22,6 +22,7 @@
>   "stderr=serial,vidconsole\0"
> 
>  #define BOOT_TARGET_DEVICES(func) \
> + func(NVME, nvme, 0) \
>   func(VIRTIO, virtio, 0) \
>   func(VIRTIO, virtio, 1) \
>   func(SCSI, scsi, 0) \
> --
> 2.45.2
