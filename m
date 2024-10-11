Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D868DD0EE19
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 18:10:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53A6A893C6;
	Fri, 11 Oct 2024 20:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=devpi.de header.i=@devpi.de header.b="YpJrZOOA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07E34893CB; Fri, 11 Oct 2024 20:10:37 +0200 (CEST)
Received: from smtp052.goneo.de (smtp052.goneo.de [85.220.129.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEC92893C2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 20:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lehmanju@devpi.de
Received: from hub1.goneo.de (hub1.goneo.de [85.220.129.52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp5.goneo.de (Postfix) with ESMTPS id 77A5E240E20;
 Fri, 11 Oct 2024 20:10:34 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPS id 89630240564;
 Fri, 11 Oct 2024 20:10:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devpi.de; s=DKIM001;
 t=1728670232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YaG2c3yoSTl/5/DpRCOnBKCgNeufi6m0xpmnmRIYd0o=;
 b=YpJrZOOA7ln4c0rvRCkp1Ve6b/ng/PiLR0o2IHtLgjgbgxRe7RiaejiIqMYNfS+30fxo1Y
 BB5MWDDQU+2j+JhERtjEZ+KbUzZ/SaM9Updmsb5MmhZ6FtBd0mHyQAMMC/X7g/wugGZ5fM
 gLCrV0UcAQRpBjFlllbqbbctjSVTAzMXtAjmqYbL8eqdvfPuRY6JzrddJolo8lxGnh6Kst
 L1D3bPPFeKHkHr86iMa9q6XKC9T5eoVyYoG30rxy0jpCU8YfnzSJoTkeJ2VrYebq02gams
 sseH9ezunAVXbuR35mCdmwqDpTSMXSMdpcNg50VsijtcLXYFvkaVsBTERJGwoA==
Received: from [IPV6:2003:cb:ef39:8710::193]
 (p200300cbef3987100000000000000193.dip0.t-ipconnect.de
 [IPv6:2003:cb:ef39:8710::193])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPSA id EE4292405B9;
 Fri, 11 Oct 2024 20:10:31 +0200 (CEST)
Message-ID: <659abbc2-037f-4f62-9f62-e17ff1972223@devpi.de>
Date: Fri, 11 Oct 2024 20:10:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] ufs: enhancements to support Qualcomm UFS
 controllers
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Cc: Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, bmeng.cn@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
Content-Language: en-US
From: Julius Lehmann <lehmanju@devpi.de>
In-Reply-To: <20240930-topic-ufs-enhancements-v3-0-58234f84ab89@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-UID: 7aaefa
X-Rspamd-UID: 73a96a
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

On 30.09.24 14:44, Neil Armstrong wrote:
> This serie regroups all the fixes and base enhancements required to
> support the Qualcomm UFS controllers in U-Boot.
> 
> This syncs headers & defines from Linux, and includes 2 set of
> fixes that were sent separately:
> - ufs: core: remove link_startup_again logic
> - ufs: properly fix cache operations
> 
> Without those 2 sets, UFS cannot initialize on Qualcomm controlers
> since v5, and a numerous of Cache issues makes any UFS controller
> fail to initialize.
> 
> Since UFS core hasn't changed for a while, and since UFS is core
> technology for the Qualcomm SoCs, I volunteer maintaininig the
> UFS subsystem if Bhupesh & Neha Malcom Francis are ok with that.
> 
> It has been reported to show regressions on:
> - TI K3 platforms (j721s2, j721e, j7200, j784s4) [1]
> - AMD platform (amd_versal2_virt_defconfig) [2]
> 
> [1] https://lore.kernel.org/all/38f599a8-7094-4a04-8ff6-96fc8b9d168a@ti.com/
> [2] https://lore.kernel.org/all/SA1PR12MB869713CA620F99077B75EF0E98632@SA1PR12MB8697.namprd12.prod.outlook.com/
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v3:
> - Fixup patch 9
> - Link to v2: https://lore.kernel.org/r/20240920-topic-ufs-enhancements-v2-0-65ae61e73eaa@linaro.org
> 
> Changes in v2:
> - Added review and tested-by tags
> - Updated patch 12 message with more explanations
> - Synced patch 9 again with Linux 6.11
> - Updated patches 7, 8, 9 and 10 with informations about the origins of the changes
> - Link to v1: https://lore.kernel.org/r/20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org
> 
> ---
> Bhupesh Sharma (5):
>        ufs/ufs.h: Add definition of 'ufshcd_rmwl()'
>        ufs: Clear UECPA once due to LINERESET has happened during LINK_STARTUP
>        ufs: Sync possible UFS Quirks with Linux UFS driver
>        ufs: Add missing memory barriers
>        ufs: Fix debug message in 'ufs_start'
> 
> Marek Vasut (2):
>        ufs: Add UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS
>        ufs: Add UFSHCD_QUIRK_HIBERN_FASTAUTO
> 
> Neil Armstrong (6):
>        ufs: allocate descriptors with size aligned with DMA_MINALIGN
>        ufs: fix dcache flush and invalidate range calculation
>        ufs: split flush and invalidate to only invalidate when required
>        ufs: use dcache helpers for scsi_cmd data and only invalidate if necessary
>        ufs: core: remove link_startup_again logic
>        MAINTAINERS: Add myself to the list of UFS maintainers
> 
>   MAINTAINERS       |   1 +
>   drivers/ufs/ufs.c |  98 +++++++++++++++-----------
>   drivers/ufs/ufs.h | 203 ++++++++++++++++++++++++++++++++++++++++++++++++------
>   3 files changed, 241 insertions(+), 61 deletions(-)
> ---
> base-commit: ddbcafeb53e7093c58488596bfce6d8823777c3a
> change-id: 20240910-topic-ufs-enhancements-fe8ef9ce39d8
> 

tested the whole series in combination with 
https://lore.kernel.org/u-boot/20240910-topic-ufs-qcom-controller-v1-0-54c0d2231b10@linaro.org/ 
on a SM8150 tablet

Tested-by: Julius Lehmann <lehmanju@devpi.de>

> Best regards,

