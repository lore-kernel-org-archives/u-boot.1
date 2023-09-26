Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7591EE7D249
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 07:48:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFA9386C2C;
	Tue, 26 Sep 2023 09:48:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 767CA86C52; Tue, 26 Sep 2023 09:48:46 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72A85869BC
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 09:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 38Q7mTA3007739;
 Tue, 26 Sep 2023 15:48:29 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Tue, 26 Sep 2023 15:48:27 +0800
Date: Tue, 26 Sep 2023 15:47:25 +0800
From: Leo Liang <ycliang@andestech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: Rick Chen <rick@andestech.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/1] cmd/exception: support RISC-V compressed instruction
Message-ID: <ZRKMjRnh52d9aB60@swlinux02>
References: <20230921084218.57260-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230921084218.57260-1-heinrich.schuchardt@canonical.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 38Q7mTA3007739
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

On Thu, Sep 21, 2023 at 10:42:18AM +0200, Heinrich Schuchardt wrote:
> Eliminating the C extension on application processors is under
> discussion.
> 
> Support emitting a compressed instruction. This will lead to an
> illegal instruction exception if the C extension is not implemented.
> 
> For testing build qemu-riscv64_defconfig with CONFIG_RISCV_ISA_C=n
> and run with
> 
>     qemu-system-riscv64 -M virt -bios u-boot -nographic -cpu rv64,c=false
> 
>     => exception compressed
>     Unhandled exception: Illegal instruction
>     EPC: 0000000087731708 RA: 000000008773fe44 TVAL: 0000000000004501
>     EPC: 000000008001b708 RA: 0000000080029e44 reloc adjusted
> 
>     Code: 0b93 0000 0493 0000 0993 0000 f06f ccdf (4501)
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/riscv/exception.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
