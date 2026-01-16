Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CEFD4A609
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 08:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EE9E83015;
	Fri, 16 Jan 2026 09:54:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dbGaQ5Il";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7A508309A; Fri, 16 Jan 2026 09:54:38 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EE7982BF2
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 09:54:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DC68060160;
 Fri, 16 Jan 2026 08:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D81FC116C6;
 Fri, 16 Jan 2026 08:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768553674;
 bh=92IwFuPqipp4TAVGjzzitwVHQ4VeDktC1YyTd8CDex0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dbGaQ5IloZi6I7rOPEsUcU8VKZy6T786oLxN2+gwgHEYD7Jd3ZMDESOGeyH1J7Kzy
 rQceqcU6l+SuKSwJLnFRZhm1kKeEJTezznWy/2x4RC733JBD0v/5SR0V9z7qwUvQ1l
 ebZId+c0ebQ1aq7c4VewpB0nsLSwZtR7cHCyDdPWGn/KnAX9/VShTNUnWjSLwbMSAD
 4Ym/u9UdAZiPt7pCNMfMQR3cSEABfuVA87vTHheewdKNJBHcIZaqnLxDVPQI8dphAE
 WSBrQURuEvUOfY3x3XQYrLsEbUVt1lXcDyWoRYSSde4rFkAwC0PyfMfzA3kioxhLnR
 wRNGz9JmyAuaQ==
Date: Fri, 16 Jan 2026 14:24:26 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH 0/6] qcom: rpmh read support and regulator fixes
Message-ID: <aWn8wruoylbCrnjL@sumit-xelite>
References: <20260108-rpmh-regulator-fixes-v1-0-d1b5b300b665@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108-rpmh-regulator-fixes-v1-0-d1b5b300b665@linaro.org>
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

On Thu, Jan 08, 2026 at 09:28:42PM +0100, Casey Connolly wrote:
> Fix some significant issues where we leave the rpmh core in a broken
> state and don't correctly poll resulting in bugs and Linux crashes,
> implement support for RPMh read and use it to populate the regulator
> driver state.
> 
> Lastly, fix an oversight in the regulator driver that resulted in PMIC
> modes being set completely incorrectly.

Thanks for the fixes, atleast this patchset doesn't cause any
regressions for me on RB3Gen2. FWIW:

Tested-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> ---
> Casey Connolly (5):
>       soc/qcom: rpmh: document rsc registers
>       soc/qcom: rpmh: correctly wait for TCS flush
>       soc/qcom: rpmh: add RPMh read
>       power: regulator: qcom-rpmh: read votes from rpmh
>       power: regulator: qcom-rpmh: correctly map pmic mode
> 
> Neil Armstrong (1):
>       soc: qcom: rpmh-rsc: reclaim the TCS to avoid spurious irq in Linux
> 
>  drivers/power/regulator/qcom-rpmh-regulator.c | 90 ++++++++++++++++++++++++++-
>  drivers/soc/qcom/rpmh-rsc.c                   | 89 ++++++++++++++++++--------
>  drivers/soc/qcom/rpmh.c                       | 38 ++++++++++-
>  include/soc/qcom/rpmh.h                       |  4 +-
>  include/soc/qcom/tcs.h                        |  1 +
>  5 files changed, 189 insertions(+), 33 deletions(-)
> ---
> base-commit: 81f887ab1a06be17ef81b0a905203cc385c3d4aa
> 
> // Casey (she/they)
> 
