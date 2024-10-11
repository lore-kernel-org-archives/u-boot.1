Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF9FD0EE1E
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 18:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFF07893C6;
	Fri, 11 Oct 2024 20:13:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=devpi.de header.i=@devpi.de header.b="IHPKOju9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6AE7893C9; Fri, 11 Oct 2024 20:13:14 +0200 (CEST)
Received: from smtp6.goneo.de (smtp6.goneo.de [IPv6:2001:1640:5::8:31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BC80893C2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 20:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=devpi.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lehmanju@devpi.de
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by smtp6.goneo.de (Postfix) with ESMTPS id 468CA240E99;
 Fri, 11 Oct 2024 20:13:12 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPS id 6D0702402D6;
 Fri, 11 Oct 2024 20:13:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devpi.de; s=DKIM001;
 t=1728670390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Pvu4q+Ex/qIVQuLj6Kh/Ie2hLR8IgLVACYnzRRXtE8=;
 b=IHPKOju9vYPwy7RHZEDT+hskmZMOtXUm6OCvUOgyVQyEJtAGubG1J+sP3rm89PT42j50u1
 3EdwdF4VTkXn0yQAAz3H8Efct39Y8SIGH6APZD41zkiJSfMgJZcoyst+eXgyAs6uVhqHLP
 18C4DTg1rR2TxcOrCP3T/ldCevPCkHbua9QNE9eEz47LWAivOVDaKKm4OlkLmjZdBcl1Ir
 FsRzoE/4aeA0WFWVa+CXuCSU97uGfYtGIb9f5nC8nhSWjvCi+r8S2qzD+iTk2pH2WQ8nkS
 TmUxZF/eVeimQLcBZj8+hw2/R2cygGgRPAH5tdhkcvNJ4JPtCp9QadU6n/1IfA==
Received: from [IPV6:2003:cb:ef39:8710::193]
 (p200300cbef3987100000000000000193.dip0.t-ipconnect.de
 [IPv6:2003:cb:ef39:8710::193])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by hub1.goneo.de (Postfix) with ESMTPSA id 1C57424029B;
 Fri, 11 Oct 2024 20:13:10 +0200 (CEST)
Message-ID: <f8fd758b-1777-48aa-ad25-bdeed49ec41d@devpi.de>
Date: Fri, 11 Oct 2024 20:13:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] ufs: add support for Qualcomm UFS Controller
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240910-topic-ufs-qcom-controller-v1-0-54c0d2231b10@linaro.org>
Content-Language: en-US
From: Julius Lehmann <lehmanju@devpi.de>
In-Reply-To: <20240910-topic-ufs-qcom-controller-v1-0-54c0d2231b10@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-UID: 5a25dd
X-Rspamd-UID: cc9f53
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

On 10.09.24 11:50, Neil Armstrong wrote:
> This iass Add Support for the Host Controller driver for UFS HC
> present on Qualcomm Snapdragon SoCs.
> 
> It adds 2 ops to allow more control on the UFS device.
>          
> It has been successfully tested on SDM845, SM8250, SM8550 ant SM8650 SoCs.
> 
> It builds-depends on the following serie:
> https://lore.kernel.org/all/20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org/
> 
> And at runtime it depends on:
> https://lore.kernel.org/all/20240910-topic-ufs-qcom-phy-v1-0-21ff4b87b962@linaro.org/
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Bhupesh Sharma (1):
>        ufs: Add Support for Qualcomm UFS HC driver
> 
> Neil Armstrong (3):
>        ufs: add device_reset callback
>        ufs: add get_max_pwr_mode callback
>        ufs: allow UFSHCI version 4.0
> 
>   drivers/ufs/Kconfig    |   7 +
>   drivers/ufs/Makefile   |   1 +
>   drivers/ufs/ufs-qcom.c | 670 +++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/ufs/ufs-qcom.h | 147 +++++++++++
>   drivers/ufs/ufs.c      |  13 +-
>   drivers/ufs/ufs.h      |  21 ++
>   drivers/ufs/unipro.h   |   6 +
>   7 files changed, 863 insertions(+), 2 deletions(-)
> ---
> base-commit: 7725e4eb07c03ca0842b0a7ed425af28e1b8ed37
> change-id: 20240910-topic-ufs-qcom-controller-4b2905610963

Tested successfully on SM8150 tablet. However, some merge conflicts had 
to be fixed and maybe also add CONFIG_QCOM_UFS=y to qcom_defconfig

Tested-by: Julius Lehmann <lehmanju@devpi.de>

> 
> Best regards,

