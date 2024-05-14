Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BF3C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 10:08:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5B67878E2;
	Tue, 14 May 2024 12:08:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75FBC882B1; Tue, 14 May 2024 12:08:13 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BCB680E9A
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 12:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 44EA7p3P031977;
 Tue, 14 May 2024 18:07:51 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Tue, 14 May 2024 18:07:46 +0800
Date: Tue, 14 May 2024 18:07:43 +0800
From: Leo Liang <ycliang@andestech.com>
To: Hanyuan Zhao <hanyuan-z@qq.com>
CC: <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>, Hanyuan Zhao
 <zhaohy22@mails.tsinghua.edu.cn>
Subject: Re: [PATCH 1/1] riscv: add NULL check before calling strlen in the
 riscv cpu's get_desc()
Message-ID: <ZkM37xOy2DRhMMYz@swlinux02>
References: <tencent_6178F4CBD2326AD3FE5FBAA496630920D405@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <tencent_6178F4CBD2326AD3FE5FBAA496630920D405@qq.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 44EA7p3P031977
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

On Mon, May 06, 2024 at 05:10:06PM +0800, Hanyuan Zhao wrote:
> Without the NULL check, if the devicetree that u-boot loads does not have a
> compatible property then a store access fault will be raised and force the
> machine to reset, due to the NULL pointer we passed to strlen. This commit
> adds this check and will return -ENOSPC to indicate the get_desc failed.
> 
> Signed-off-by: Hanyuan Zhao <zhaohy22@mails.tsinghua.edu.cn>
> ---
>  drivers/cpu/riscv_cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
