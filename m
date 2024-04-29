Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759D3C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 13:34:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7E67886E6;
	Mon, 29 Apr 2024 15:34:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="mn/XoNUM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 210E3807EC; Mon, 29 Apr 2024 15:34:38 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 365E288795
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 15:34:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1714397675; x=1716989675;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lzx4SXR/GbCPTkZSShdGuHEIgr3gmFnJdJUhIZHH92Y=;
 b=mn/XoNUMYioUuLGMmxeX/t6Z4bC0GMJ2YB4TwEzduaXvtHBDKzmcEIeVWzatLbH6
 o/idpYePdO9bYAs2QVy8C+Kx1sQd9wc6aJEZPijnaAUrvOGd4U7SL/fRiwxlvNx2
 hbO0e7i6Dmad3riFWsi2qasyxED6T9VpRn7loBvDZ+E=;
X-AuditID: ac14000a-fbefe7000000290d-fb-662fa1eb68f2
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 47.E9.10509.BE1AF266;
 Mon, 29 Apr 2024 15:34:35 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 29 Apr
 2024 15:34:35 +0200
Message-ID: <b6232b4c-4bc0-4b0a-8017-55333cfc1490@phytec.de>
Date: Mon, 29 Apr 2024 15:34:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
Subject: Usage of fdt_addr vs fdt_addr_r
To: <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsWyRpKBR/f1Qv00g6kfNS3e7u1kt+h+p+7A
 5HH2zg5Gj/7uFtYApigum5TUnMyy1CJ9uwSujJObrrIUfGCpeLBVpoHxN3MXIyeHhICJxLxP
 v1i7GLk4hASWMEn8/XcfyrnLKPFp0w12kCpeARuJQ3s/sYHYLAKqEk/+LGaGiAtKnJz5hAXE
 FhWQl7h/awZYPbOAuMStJ/OZQGw2AXWJOxu+AQ3l4BAW0JBo7EwBCYsISEm87NzIDBJmFpCT
 WNZfBNFpIbH4zUGoKfIS29/OAdskBGS/uLScBeJmeYlp515D3R8qsfXLdqYJjIKzkBw0C8kR
 s5CMnYVk7AJGllWMQrmZydmpRZnZegUZlSWpyXopqZsYQaErwsC1g7FvjschRiYOxkOMEhzM
 SiK8W6brpwnxpiRWVqUW5ccXleakFh9ilOZgURLnXd0RnCokkJ5YkpqdmlqQWgSTZeLglGpg
 dEyb+odjPwtv7cZdlftizv3j/lnovviJR9I5ky0/vdt/sW3wPv4/Pf4Us1PnZG4Rqf4k9RuR
 vVKpbTc2vyy/cOP3lvKkydIfpqmHZl3/Vyn6/o9z5dtup8zph9M1/3jOdz3HsrZwxRPWKYpX
 3H+WrdhlVDxh7Qq5jTknJgavmbM2pFud77pHuBJLcUaioRZzUXEiAFVU55pLAgAA
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

Hi,

there are multiple definitions of fdt_addr and fdt_addr_r:

usage/environment.rst:
Tells us fdt_addr is in flash location and _r in RAM

develop/distro.rst:
fdt_addr -> Mandatory for any system that provides the DTB in HW (e.g. ROM)

I also noticed that bootmeth_efi.c/distro_efi_try_bootflow_files() will 
copy the dtb it has found into fdt_addr_r. But efi_install_fdt() try to 
load first from fdt_addr. Shouldn't they use the same environment variable?

Doing so would allow efiboot to use the dtb it has detected using 
bootflow. Right now it seems to fallback to fdtcontroladdr.

Regards,
Wadim
