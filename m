Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCC1C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 13:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E860886FB5;
	Mon,  4 Dec 2023 14:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7E5486FB5; Mon,  4 Dec 2023 14:00:50 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B554286F1F
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 14:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3B4D0gJG019597;
 Mon, 4 Dec 2023 21:00:43 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Mon, 4 Dec 2023 21:00:42 +0800
Date: Mon, 4 Dec 2023 21:00:40 +0800
From: Leo Liang <ycliang@andestech.com>
To: Randolph <randolph@andestech.com>
CC: <u-boot@lists.denx.de>, <randolph.sklin@gmail.com>, <dylan@andestech.com>, 
 <tim609@andestech.com>, <peterlin@andestech.com>
Subject: Re: [PATCH V3 1/3] doc: falcon: riscv: Falcon Mode boot on RISC-V
Message-ID: <ZW3NeBLQVtogQavE@swlinux02>
References: <20231116130136.2796918-1-randolph@andestech.com>
 <20231116130136.2796918-2-randolph@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231116130136.2796918-2-randolph@andestech.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 3B4D0gJG019597
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

On Thu, Nov 16, 2023 at 09:01:34PM +0800, Randolph wrote:
> Add documentation to introduce the Falcon Mode on RISC-V.
> In this mode, the boot sequence is SPL -> OpenSBI -> Linux kernel.
> 
> Signed-off-by: Randolph <randolph@andestech.com>
> ---
>  doc/develop/falcon.rst | 171 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 171 insertions(+)

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
