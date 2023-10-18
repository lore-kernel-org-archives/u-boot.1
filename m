Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A626CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 18:18:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 640618701F;
	Wed, 18 Oct 2023 20:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697653079;
	bh=SEmw+hq7vfbHtHIT/Hsmj884YzaH/uxIHtPoPxGqwHs=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MJ4ZCDP5s1bBrAA5/R9l3HSpGpF/6fTMHY8i0vsbi7CU81kwx3v0Zs2n/FVSKmKmX
	 0liSyseS2iB3u2BzNTUCdXX1Tuy8qbJeCGZtzCK3Dhcsy2C3CRMujoYoSGf92vqFXV
	 cpBjlhf/aE1YvStmGnnhsp357lhjnCc570etnktqSeis97IdrnUU4tEXNSU3hf3ho5
	 OGa/HoMOUWNDgatOyKADBG4vG+uGMefbKQ15XR/OXJTNqu1/iFKkZ5r2maRAsF/NuR
	 Ma0uuRy+PRn+vLPvOsPxxs0HqHGzpXcFtrkivnRNk6CgIb5uCiN5dYkChDZoKwAquQ
	 qiLTu8msHFnxw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A69687021; Wed, 18 Oct 2023 20:17:58 +0200 (CEST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9F2387027
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 20:17:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sbabic@denx.de
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4S9fGW42Pjz1r1s0;
 Wed, 18 Oct 2023 20:17:55 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 4S9fGW3xhJz1qqlS;
 Wed, 18 Oct 2023 20:17:55 +0200 (CEST)
X-Amavis-Alert: BAD HEADER SECTION, Missing required header field: "Date"
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavis, port 10024)
 with ESMTP id wQehE8lOSjer; Wed, 18 Oct 2023 20:17:55 +0200 (CEST)
Received: from papero (host-88-217-136-221.customer.m-online.net
 [88.217.136.221]) by mail.mnet-online.de (Postfix) with ESMTP;
 Wed, 18 Oct 2023 20:17:54 +0200 (CEST)
From: sbabic@denx.de
X-Patchwork-Submitter: Marek Vasut <marex@denx.de>
X-Patchwork-Id: 1849463
X-Patchwork-Delegate: sbabic@denx.de
To: Marek Vasut <marex@denx.de>,u-boot@lists.denx.de
Subject: [PATCH v2 3/4] ARM: imx: Use correct U-Boot offset in case of
 secondary boot from eMMC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-Id: <20231018181758.8A69687021@phobos.denx.de>
Date: Wed, 18 Oct 2023 20:17:56 +0200 (CEST)
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

> From: Fedor Ross <fedor.ross@ifm.com>
> In case of a secondary image boot from the user area of an eMMC device,
> the correct offset must be calculated. The offset is fused in the fuse
> IMG_CNTN_SET1_OFFSET of the i.MX8M Nano and Plus. The calculation of the
> offset is described in the reference manual (IMX8MNRM Rev. 2, 07/2022
> and IMX8MPRM Rev. 1, 06/2021):
> The fuse IMG_CNTN_SET1_OFFSET (0x490[22:19]) is defined as follows:
> * Secondary boot is disabled if fuse value is bigger than 10,
>   n = fuse value bigger than 10.
> * n == 0: Offset = 4MB
> * n == 2: Offset = 1MB
> * Others & n <= 10 : Offset = 1MB*2^n
> Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
> Signed-off-by: Marek Vasut <marex@denx.de>
Applied to u-boot-imx, master, thanks !

Best regards,
Stefano Babic

-- 
=====================================================================
DENX Software Engineering GmbH,        Managing Director: Erika Unter  
HRB 165235 Munich,   Office: Kirchenstr.5, 82194 Groebenzell, Germany
Phone: +49-8142-66989-53 Fax: +49-8142-66989-80 Email: sbabic@denx.de
=====================================================================
