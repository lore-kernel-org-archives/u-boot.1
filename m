Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A4C3CAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 10:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 373A083542;
	Fri, 19 Sep 2025 12:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A036383335; Fri, 19 Sep 2025 12:50:20 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 029E08329F
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 12:50:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 58JAmuhN069049
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Fri, 19 Sep 2025 18:48:56 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 19 Sep
 2025 18:48:56 +0800
Date: Fri, 19 Sep 2025 18:48:52 +0800
From: Leo Liang <ycliang@andestech.com>
To: Vivian Wang <wangruikang@iscas.ac.cn>
CC: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 "Auer, Lukas" <lukas.auer@aisec.fraunhofer.de>
Subject: Re: [PATCH] riscv: qemu: Remove fdt_high default
Message-ID: <aM01FDY8I6CGwDe9@swlinux02>
References: <20250915-qemu-riscv-remove-fdt-high-v1-1-661178447396@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250915-qemu-riscv-remove-fdt-high-v1-1-661178447396@iscas.ac.cn>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 58JAmuhN069049
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

On Mon, Sep 15, 2025 at 07:45:49AM +0800, Vivian Wang wrote:
> Setting fdt_high to all ones is discouraged and does not appear to be
> useful for RISC-V QEMU. Moreover, it causes a boot failure when the FDT
> generated internally by QEMU is used while booting. Remove it to allow
> U-Boot to pick a suitable address and relocate the FDT.
> 
> Closes: https://lore.kernel.org/u-boot/8397369a-9b0b-4798-9c30-3a81165657d6@iscas.ac.cn
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> Reviewed-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Lukas Auer <lukas.auer@aisec.fraunhofer.de>
> ---
>  include/configs/qemu-riscv.h | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
