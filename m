Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3315C3DA42
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 07:16:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AC75883C3;
	Tue,  9 Jul 2024 09:16:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="SMIup/zO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4842387CFE; Tue,  9 Jul 2024 09:16:13 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A12887CFE
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 09:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1720509371; x=1723101371;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hsq9RbmVmDhoFBygj3MZ9PzYnfn7ZhICh61q6z0cfVI=;
 b=SMIup/zOszCmjsdGDRvLVTYCmdHlZipfl9sLbigTmXGOSPC1vNb7x/F2GVT6K9OC
 /sEgSQC/k8bpxOKYvWmcs7gvWr/UQfaLW7jzE+FkpbTnfuYnIzaTFNqy/uh6X2cH
 LVKLPzJhOSsQFL6WCqJ4Z09HJuenP6gXu+oddTIbH/Y=;
X-AuditID: ac14000a-03e52700000021bc-6b-668ce3ba8593
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 96.37.08636.AB3EC866;
 Tue,  9 Jul 2024 09:16:10 +0200 (CEST)
Received: from [10.0.0.19] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 9 Jul 2024
 09:16:05 +0200
Message-ID: <8e0820de-2cd6-4480-a115-aaea6968ebcc@phytec.de>
Date: Tue, 9 Jul 2024 09:16:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Extend SOM detection
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <w.egorov@phytec.de>
CC: <d-gole@ti.com>, <nm@ti.com>, <mkorpershoek@baylibre.com>,
 <upstream@lists.phytec.de>, <t.remmet@phytec.de>, <y.moog@phytec.de>,
 <m-chawdhry@ti.com>, <kamlesh@ti.com>, <jm@ti.com>, <B.Hahn@phytec.de>
References: <20240708060734.4029040-1-d.schultz@phytec.de>
Content-Language: en-US
From: Daniel Schultz <d.schultz@phytec.de>
In-Reply-To: <20240708060734.4029040-1-d.schultz@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42JZI8nAo7vrcU+awZwtNhYtaz0sPn3ItPi0
 8zGrxdH+NcwWlx6kWrw4Npfd4s2Ps0wWUydtZrd4u7eT3aL7nboDl8f7G63sHq8OrGL3OHtn
 B6NHf3cLq8f1M9uZPI7f2M4UwBbFZZOSmpNZllqkb5fAlfF940T2ghtcFQfXrWVpYDzI0cXI
 wSEhYCJx5VlIFyMXh5DAEiaJpet+s0E4Nxklfk3/zd7FyMnBK2AjcWbCbUYQm0VARWL6p5cs
 EHFBiZMzn4DZogLyEvdvzQCrFxbQlVj79C1YvYhAksSyi52sIEOZBc4zSsyc1sgKkhASsJKY
 O3kDG4jNLCAucevJfCYQm01AS+LOlrnMIDangLXEo2mdLBA1FhKL3xxkh7DlJba/ncMMMUdB
 Yva2yWDLJIDi0869ZoawQyWObFrNNIFReBaSW2chWTcLydhZSMYuYGRZxSiUm5mcnVqUma1X
 kFFZkpqsl5K6iREUYyIMXDsY++Z4HGJk4mA8xCjBwawkwjv/RneaEG9KYmVValF+fFFpTmrx
 IUZpDhYlcd7VHcGpQgLpiSWp2ampBalFMFkmDk6pBkb7PRLL5sfVMvd+sWNOt99+o+lmuwRP
 mfyBut3JOi/9ub6fv97tnHtrtlmbR+b+hWvadUuUg4JXxxx1K32sfzLIZoZCaE3BfoM3jcnJ
 IW9Kg/6WNF8vudUhJVXoJnX68W6utAuaHxmvblNql97/+dYKi58+e9MNijdsm3/sye1cyYW5
 Py+kiymxFGckGmoxFxUnAgDZS8XRnwIAAA==
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

Hey,

please don't apply these patches. We just found an issue while working 
on another task. Sorry!

Best Regards,
Daniel

On 08.07.24 08:07, Daniel Schultz wrote:
> This patchset extends PHYTEC's SOM detection for the
> K3 platforms.
>
> It adds generic support to apply overlays via the
> extension framework inside the overlays.env file. Additionally,
> the K3 mmc boot environment applies these overlays now.
>
> It also adds the 'extension_board_scan' hook to the K3 board
> code and adds all missing configs in the phyCORE-AM62x and
> -AM64x A53 defconfigs.
>
> Daniel Schultz (6):
>    include: env: phytec: overlays: Add extension command
>    include: env: phytec: k3_mmc: Apply extension overlays
>    board: phytec: common: k3: Add SOM detection overlays
>    board: phytec: common: Kconfig: Enable SUPPORT_EXTENSION_SCAN
>    configs: phytec_am62x_a53_defconfig: Set CONFIG_CMD_EXTENSION
>    configs: phycore_am64x_a53_defconfig: Enable SOM detection
>
>   board/phytec/common/Kconfig         |  2 ++
>   board/phytec/common/k3/board.c      | 45 +++++++++++++++++++++++++++++
>   configs/phycore_am62x_a53_defconfig |  1 +
>   configs/phycore_am64x_a53_defconfig |  2 ++
>   include/env/phytec/k3_mmc.env       |  1 +
>   include/env/phytec/overlays.env     | 20 +++++++++++++
>   6 files changed, 71 insertions(+)
>
