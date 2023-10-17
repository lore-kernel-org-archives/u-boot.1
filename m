Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932C4CDB474
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 07:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F368F86BE0;
	Tue, 17 Oct 2023 09:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFB5386C91; Tue, 17 Oct 2023 09:23:07 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A785186BD7
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 09:23:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 39H7Mw5g071226;
 Tue, 17 Oct 2023 15:22:58 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Tue, 17 Oct 2023 15:22:54 +0800
Date: Tue, 17 Oct 2023 15:20:05 +0800
From: Leo Liang <ycliang@andestech.com>
To: Randolph <randolph@andestech.com>
CC: <u-boot@lists.denx.de>, <randolph.sklin@gmail.com>, <dylan@andestech.com>, 
 <tim609@andestech.com>, <peterlin@andestech.com>
Subject: Re: [PATCH V2 7/7] riscv: spl: andes: Move the DTB in front of kernel
Message-ID: <ZS41pbe4IF97CCA8@swlinux02>
References: <20231012063509.2963258-1-randolph@andestech.com>
 <20231012063509.2963258-8-randolph@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231012063509.2963258-8-randolph@andestech.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 39H7Mw5g071226
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

On Thu, Oct 12, 2023 at 02:35:09PM +0800, Randolph wrote:
> Originally, u-boot SPL will place the DTB directly after the kernel,
> but the size of the kernel does not include the BSS section, This
> means that u-boot SPL places the DTB in the kernel BSS section causing
> the DTB to be cleared by the kernel BSS initialisation.
> 
> Moving the DTB in front of the kernel can avoid this error.
> 
> Signed-off-by: Randolph <randolph@andestech.com>
> ---
>  board/AndesTech/ae350/ae350.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
