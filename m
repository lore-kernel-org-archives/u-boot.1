Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033CDCD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 03:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C749C848D1;
	Thu,  4 Jun 2026 05:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="Q0Ljx5Nd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88A2A848DC; Thu,  4 Jun 2026 05:34:54 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A93D5848A9
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 05:34:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3F31B10EC24; Thu,  4 Jun 2026 05:34:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1780544091;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=ewxT7nupvW5UnLqEYlt420OkSnnCSj5QD5gLnrxEqiY=;
 b=Q0Ljx5Ndd/007/2f2qZldH3UvYdL1o/Qing8SMDZX4MFuLlAOInofzpTKHGYbF8RzUOgdy
 rjzgMK4YbMMfIeVJ9o+LALeEYth5B2YLsYXI/0pu8Ihd6pz1nsXa8H/VoP+CXynI/YkZ3H
 Dxj4dZBoOrgd6cgMAa85gcagtq2wYNYzibjhdyA5MTxI2HY6yml2L1jlRvU2FfabqGKGq7
 NPvvnlVewI6Vu5o5aXfZG1ImLP108U28/zmj9IdiVHfNm1OxA+Hp5dDxtadPEud7fxRFhp
 qbbXsvZ6bl456VTAiwPEpL2c1SihFH0CxULYtacM97yyhZkddL3oegWU0kJgPA==
Message-ID: <4a12deb6-b10f-4bb3-a6ab-6a4c508dc2a9@nabladev.com>
Date: Thu, 4 Jun 2026 05:34:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] net: fsl_enetc: Add SGMII support for i.MX95
To: alice.guo@oss.nxp.com, u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>
References: <20260603-sgmii-v1-0-c4a0af0d5d3d@nxp.com>
 <20260603-sgmii-v1-3-c4a0af0d5d3d@nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260603-sgmii-v1-3-c4a0af0d5d3d@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 6/3/26 12:51 PM, alice.guo@oss.nxp.com wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> Add SGMII interface mode configuration for i.MX95 platform in ENETC
> driver.
Which PHY did you use for the tests here ?

Have you also tested this with a 100/Full only (not 1000/Full) capable 
switch -- does this work in 100/Full node or does this work only in 
1000/Full mode ?
