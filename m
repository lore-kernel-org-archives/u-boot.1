Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFF1CDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 09:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8169486AB3;
	Mon, 16 Oct 2023 11:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697448280;
	bh=D6TniiQyaCn3k3aEFBE+lxX9MjryvbyC4/QdMcm6Uak=;
	h=From:To:Subject:In-reply-to:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=JiumYmMch3HTvsSHhw9TuULUz8Q+PXoEwPAANFNd2AGFWE59l0jBOu2elkLg1n0Tj
	 RiHBdTX1k1UO8ZlP9Isbws9eGlZ6Qut5HvtQdbvkA0e+tvtxv+frffIp4+wa93pLc0
	 fykPZ6X63josJ0ZagkdMGJYvxIMVK6rMiKKSTYoPB1GC8pBFpKrMjpNCS8yWneOL4G
	 9mjxDsmK4o/zAoK+jwLqVKkwGxymQpAdxmJDJA0KMFL8JY8rJx0zrhTG+Mcsg3z7YS
	 2SRwCKu+FakGeE+/vMB+BorVXg5VCaMdbEb1cFA1UloBwkKVhICfU+MRZeFSTQgcYZ
	 kSMPqtPQlHoZA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E83E86EF6; Mon, 16 Oct 2023 11:23:26 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D598A86E16
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 11:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S8BTw0P8Lz1sClY;
 Mon, 16 Oct 2023 11:22:44 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S8BTw0J86z1qqlS;
 Mon, 16 Oct 2023 11:22:44 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id LEgimGGZjGd9; Mon, 16 Oct 2023 11:22:43 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Mon, 16 Oct 2023 11:22:43 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
X-Patchwork-Id: 1836570
X-Patchwork-Delegate: sbabic@denx.de
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,u-boot@lists.denx.de
Subject: [PATCH] imx8mp: binman: rename spl and u-boot nodes
In-reply-to: <20230919092847.42391-1-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231016092326.5E83E86EF6@phobos.denx.de>
Date: Mon, 16 Oct 2023 11:23:24 +0200 (CEST)
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

> The hab signing script doc/imx/habv4/csf_examples/mx8m/csf.sh does
>   fdtget -t x u-boot.dtb /binman/imx-boot/uboot offset
> to figure out the offset of u-boot.itb inside flash.bin. That works
> fine for imx8mm, imx8mn, imx8mq, but fails for imx8mp because in that
> case 'uboot' is merely a label and not actually the node name.
> Homogenize these cases and make imx8mp the same as the other imx8m*
> variants. The binman type is explicitly given and no longer derived
> from the node name, and the csf.sh script will work for all four SOCs.
> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Reviewed-by: Marek Vasut <marex@denx.de>
> Reviewed-by: Fabio Estevam <festevam@denx.de>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
