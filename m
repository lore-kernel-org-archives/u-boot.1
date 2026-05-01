Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC57FF885A
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 05:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72D7E803C6;
	Fri,  1 May 2026 07:59:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jjUR/02G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 482DF80F0E; Fri,  1 May 2026 07:59:26 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D693E80086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 07:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AB1DE6014C;
 Fri,  1 May 2026 05:59:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D48C2BCB7;
 Fri,  1 May 2026 05:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777615162;
 bh=GJ8P3XVddgI13rsfisohkH4IBek67f9+XC9UxkK8vQM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jjUR/02GG7Zv5KEFcXhnr9s85br9aOB7ZowHMofNnPiyKRu6uBLLbDooDHTtpnTEM
 cWcnJKSHFWG4mA2npJfHxYEvs9JialyikublK+/rsZaF3nIvnMTTArZv+WD12436z+
 jLH0mmi5+XzIMCY4269H9SxILueQvtOjKqGjh8J9VfB7f1+1JQ9aNkzWvs/2qRtK7b
 9KGFKi7glyCHni+vo9pHvrUILVaioB1emwJYe++d9Pkyg9IOmFXlQHmy6u/GSXEPEt
 /9Cit7pIk3QSQM5/eEpN+bRY381GfgfpJE2oDCapTDA4bHPLWUiyzFU9wECNKkpVOJ
 xVr2WPh0Bh5ig==
Date: Fri, 1 May 2026 11:29:16 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/3] Qualcomm: rpmh and regulator fixes
Message-ID: <afRBNIa6wsFXU2VS@sumit-xelite>
References: <20260413-casey-qcom-geni-rpmh-fixes-v1-0-2a83a67ac0f1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413-casey-qcom-geni-rpmh-fixes-v1-0-2a83a67ac0f1@linaro.org>
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

Hi Casey,

On Mon, Apr 13, 2026 at 01:06:13PM +0200, Casey Connolly wrote:
> The RPMh API is frustratingly complicated and lacks public
> documentation. With the Linux drivers being the only available sources
> but are highly asynchronous and thus hard to translate to U-Boot.

There is new source of synchronous RPMh upstream driver which is being
pushed to upstream OP-TEE project here [1]. I agree U-Boot single
threaded execution model requires drivers to be simplified coming from
highly asynchronous Linux context.

[1] https://github.com/OP-TEE/optee_os/pull/7796

> 
> The main issue seems to relate to sending multiple commands in a single
> TCS request, currently this is only done by the interconnect driver and
> while this may not be the underlying cause it seems to be safer to avoid
> this for now.

Can you share which particular peripheral is being tested here to
reproduce the issues you are facing?

> 
> Adjust the bcm-voter driver to avoid sending multiple commands per
> write, and additionally adjust how we send RPMh requests as well as
> improve the cleanup we do prior to booting the OS.
> 

Aswin,

Is there something you can help Casey with this multiple RPMh requests
issue?

> Lastly, add a missing piece to the rpmh regulator driver to ensure
> that when a supply gets enabled we also propagate a vote to its parent
> supply. This seems to have been missed from the original port (perhaps
> because the Linux regulator core handles this automatically?) but it is
> necessary for some peripherals on some boards to work (e.g. to ensure
> that the spms supplier for an LDO gets enabled).
> 

Again it will be better if you list down the specific peripherals here.

-Sumit

> ---
> Casey Connolly (3):
>       soc/qcom: rpmh: properly fix synchronous requests
>       soc/qcom: rpmh: only allow rpmh writes of a single command
>       power: regulator: qcom-rpmh: propagate votes to parent supplies
> 
>  drivers/interconnect/qcom/bcm-voter.c         | 16 +++---
>  drivers/power/regulator/qcom-rpmh-regulator.c | 35 +++++++++++++-
>  drivers/soc/qcom/rpmh-rsc.c                   | 70 ++++++++++++++++++++-------
>  drivers/soc/qcom/rpmh.c                       |  6 +++
>  4 files changed, 102 insertions(+), 25 deletions(-)
> ---
> base-commit: c704af3c8b0f37929bce8c2a4bba27d6e89919c7
> 
> // Casey (she/they)
> 
