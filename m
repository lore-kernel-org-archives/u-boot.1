Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A29C47DB7
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 19:08:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0CA787BC1;
	Thu, 18 Jan 2024 20:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705604936;
	bh=etmENRhZw5dNYcViqhMXfAjOO8drz9gFhf9yJbEl1vs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h786Mzc8KBrJLnSKg4j1jgU9G+buZdafKTYSBMHbpnsFqPmOnCsMhnMOJyWPmy9Eb
	 uMXj/phrvwq3Uk1BTgJIdAGLHKrYa1EYU+wVvEcuPePFRLgB0fLgG0xefoGeFtuHzO
	 m+JKedoTqGxxENRQTSdcJLZRI9rbBKNLPF/iFfy/NRO7gmxtmYv3v2VwyHo9A1Uj5U
	 XR5L8fMN0JNDPtcdbNQOAV6qRueUGovZCNAcx5VWrOCZ38Ij6azG6hHPOotSTLxA/O
	 pkenyLDtekAziQSx5BcXQtfX9tEG2EKEPTaNiGkI4McsvuXg+IGSCSSkR3WVFib/LG
	 vNodaipA+RaMg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 57CA48797A;
 Thu, 18 Jan 2024 20:08:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1705604934;
 bh=etmENRhZw5dNYcViqhMXfAjOO8drz9gFhf9yJbEl1vs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=m3KJk6HmuF2Kb/UXyc3o827fYCqrxMKdlLQnoMf0sv/CjPMF8hS6QDkJLzH0W8/3V
 O/OY66aZnM2WmpUFPHLKU87qcVbrLvRNIbu2I162SZbwgsdLxFXuiynetGTg8RN0Fd
 Vo+N+WJOQnDy5ErJFblqn92K25KI/jl9Tdoz5ZZdYSx5gqXauaZLSjnYzaO+LydfpF
 D/kRDWoST18YGk+s8oOMXPdyWtCSZLV6RHKIIIajPP3hFIs5nUaB46jrjAZKpYct+m
 JTZL4ExSDZkyju+yZpVRvGrB7YiaCgr2QJkq1xjRhx2p/+clWTnHTG41Fs7cs8ct+f
 VD41haFIdc7Jw==
Message-ID: <012d7807-9bdb-491a-ad3e-3172f6ed4575@denx.de>
Date: Thu, 18 Jan 2024 19:43:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] imx8m: Enable LTO by default
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>, sbabic@denx.de
Cc: uboot-imx@nxp.com, thomas.schaefer@kontron.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
References: <20240118150640.3802089-1-festevam@gmail.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240118150640.3802089-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 1/18/24 16:06, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> In an attempt to select ARMV8_SPL_EXCEPTION_VECTORS, the SPL size
> could not fit into the internal SRAM of some imx8m targets:
> 
>     aarch64:  +   imx8mm_phg
> +aarch64-linux-ld.bfd: u-boot-spl section `__u_boot_list' will not fit in region `.sram'
> +aarch64-linux-ld.bfd: region `.sram' overflowed by 1824 bytes
> 
> Select LTO to prevent that.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Marek Vasut <marex@denx.de>

I wouldn't mind seeing LTO enabled for all of ARM64 eventually, but 
that's for another patch.
