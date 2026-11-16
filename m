Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C332606A331
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0TTM+cQG;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KNGTliHl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0B395406ED;
	Mon, 16 Nov 2026 16:33:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ur-ij3djh5Jm; Mon, 16 Nov 2026 16:33:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 46CB4405D6
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794846818;
	b=Yqjs7+Hn1dF80tB57CYNRgCE79T+U6CcKXSOIOQOa0ZAHG2QfVoNRcg9qOoWEUzrzDRD
	 UpZM0uJkOrvaFEBdrnokBTpqmqZiyzcZeMn16rMiMsTRBK1UjaTERYG5n1enQ2h4Qx96S
	 swLY6n2HrFfsQniwZCu3ewFUaeELeV7FpQlCxK7vLQua+DuR+mwQwLXS1NkL8wQRjmavH
	 F0fNGT9f1oq9Le41v5BQ0fTdHNsgSr2b+Y/MVzqRuQKKQEsVkPXyCYok6By0sheGjiySV
	 LAFQCc1jXJtFbgygZxMpyCvh0AHGYGRAMct9sMXIb5dY5GPmkUCXm2zpGIQZF0v7idQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794846818;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nNbKlBg4WZ/77FgMKmCMpvWSwwyyJvJPsUNcd/bCGM8=;
	b=KPexqj1EwJLOURm33MJhA4N5pS8XaJnwFCM73T3P9PmbltZwLpEO5bt+GA86D0LsX7L3
	 9bHAV6wgkkhDK93UFkXECtylzWvspKzUOPf8VJhZngOfASFPjRdjcwrpVDakUNGN6M8gp
	 MP3FULnPoIj2PHs1D/qV7fKNt7rCStw2TVatScQeVR0XX0jfRC9Ki8KvbDC6+jGWRMiN7
	 myLZEmTG2iCx6WuEs72wVWhSG2E5176sxTAGumqvS1W04oGvObQT5KqvsVffHcytpepLj
	 JBqhSNZpdhtwy1B1iSnhq2SJPTgdc9zaTXuvkgVeZc1UMozc8F0nVIrmqKim+I45HIw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794846818;
	bh=nNbKlBg4WZ/77FgMKmCMpvWSwwyyJvJPsUNcd/bCGM8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0TTM+cQGAVOuNsfOfK4BvDGV96Gq6jrmLYAy+FlUjHsVJq34o1XwRKT/tsGWyf31K
	 st9+BhEJSmaMWzNf2dHHmU3UWmp9FE58wFO/MmIfBxgC+H9x1TYB/OK8V0W+9sFrUA
	 LraO1ZK0nFuffOws0efbxmMTcwrdrpUnlbihP6DhVkuPeeQXfCHPKKthc18Dp+fpCi
	 S6ZZSJwzrziCZ+NzDg3ID/cjjoVC1PZsNpDydBJ4ewciGhGB5g4MNkzXSaEMW9zk0h
	 YbVVkfssy8p0AbtmZSfpAe5eI/66nacRboV9cXARJZcr+DASlX+PtTAIomlNPPX8ak
	 B6uFocv9tM9lg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46CB4405D6;
	Mon, 16 Nov 2026 16:33:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9A85E169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:33:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7E41880CF8
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:33:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mzm3KxObIRdf for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:33:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B5F7580CDE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=KNGTliHl
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B5F7580CDE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:33:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DF0014163C;
 Mon, 16 Nov 2026 16:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493B01F000C4;
 Mon, 16 Nov 2026 16:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794846814;
 bh=nNbKlBg4WZ/77FgMKmCMpvWSwwyyJvJPsUNcd/bCGM8=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=KNGTliHl4dh4bdlRvyTInsIpdX09oG1GfGeKD63pF0L0dYUK2aweHZFqmZI8KzfZO
 hMpDQWYVrkP+EftoowV55MnDT2ZSuSyHvkaFOlWJMuVAaUNqlV9kRvcMFEVz70tCjH
 Y6Rji1Wj4oeAnosDMu2kadygoKr31IlRgf1Ey0878KIwR2VQT/CNPS2tG5Edgiyuib
 JafsWGSILiZ19yNJZaIvvgCCYtt2ZxtkpWnxU586HA5dvIYm5Wkb7lijbPJOdbBkwc
 VQ54BlXVjpBPP+Xmm5GFnAJ684onN2Z/d7le8auGcp10meDd+1qGP+nE+N5FL7dR/f
 o8K0x5lnfq78Q==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] spmi: msm: bound the CMD_DONE poll with a timeout
From: Sumit Garg <sumit.garg@kernel.org>
To: Petr Hodina <petr.hodina@protonmail.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io, 
 u-boot@lists.u-boot-project.org, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 David Heidelberg <david@ixit.cz>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, Peng Fan <peng.fan@nxp.com>, 
 Yao Zi <me@ziyao.cc>, Patrice Chotard <patrice.chotard@foss.st.com>
In-Reply-To: <20261002-b4-qcom-spmi-v1-1-33fbd16ee559@protonmail.com>
References: <20261002-b4-qcom-spmi-v1-1-33fbd16ee559@protonmail.com>
Date: Mon, 16 Nov 2026 22:03:30 +0530
Message-Id: <179484681065.21534.2437527009720707320.b4-reply@b4>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-02 23:36 +0200, Petr Hodina wrote:
> msm_spmi_write()/msm_spmi_read() busy-wait in inifinte loop.
> Bound the wait with readl_poll_timeout() and return -ETIMEDOUT on
> failure when the PMIC peripheral does not respond.
> 
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
> Tested on Xiaomi Pad 5 (nabu) hardware: pm8150l's WLED node
> on usid 5 never returns CMD_DONE.
> 
> msm_spmi_write()/msm_spmi_read() busy-wait on CMD_DONE with no
> timeout. Therefore one unresponsive PMIC peripheral hangs boot
> indefinitely.
> 
> Bound the wait with readl_poll_timeout() so DM can fail that one
> device's probe instead of halting the whole boot.
> ---
>  drivers/spmi/spmi-msm.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Casey, Tom,

Can this fix be pulled in for main branch?

-Sumit

> diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
> index b89dd0b406b..92cd42d8627 100644
> --- a/drivers/spmi/spmi-msm.c
> +++ b/drivers/spmi/spmi-msm.c
> @@ -12,8 +12,11 @@
>  #include <fdtdec.h>
>  #include <asm/io.h>
>  #include <dm/device_compat.h>
> +#include <linux/iopoll.h>
>  #include <spmi/spmi.h>
>  
> +#define SPMI_CMD_DONE_TIMEOUT_US 100000
> +
>  /* PMIC Arbiter configuration registers */
>  #define PMIC_ARB_VERSION 0x0000
>  #define PMIC_ARB_VERSION_V2_MIN 0x20010000
> @@ -161,10 +164,10 @@ static int msm_spmi_write(struct udevice *dev, int usid, int pid, int off,
>  	writel(reg, priv->spmi_chnls + ch_offset + SPMI_REG_CMD0);
>  
>  	/* Wait till CMD DONE status */
> -	reg = 0;
> -	while (!reg) {
> -		reg = readl(priv->spmi_chnls + ch_offset +
> -			    SPMI_REG_STATUS);
> +	if (readl_poll_timeout(priv->spmi_chnls + ch_offset + SPMI_REG_STATUS,
> +			       reg, reg, SPMI_CMD_DONE_TIMEOUT_US)) {
> +		printf("SPMI write timeout (channel %#x).\n", ch_offset);
> +		return -ETIMEDOUT;
>  	}
>  
>  	if (reg ^ SPMI_STATUS_DONE) {
> @@ -231,9 +234,10 @@ static int msm_spmi_read(struct udevice *dev, int usid, int pid, int off)
>  	writel(reg, priv->spmi_obs + ch_offset + SPMI_REG_CMD0);
>  
>  	/* Wait till CMD DONE status */
> -	reg = 0;
> -	while (!reg) {
> -		reg = readl(priv->spmi_obs + ch_offset + SPMI_REG_STATUS);
> +	if (readl_poll_timeout(priv->spmi_obs + ch_offset + SPMI_REG_STATUS,
> +			       reg, reg, SPMI_CMD_DONE_TIMEOUT_US)) {
> +		printf("SPMI read timeout (channel %#x).\n", ch_offset);
> +		return -ETIMEDOUT;
>  	}
>  
>  	if (reg ^ SPMI_STATUS_DONE) {
> 
> ---
> base-commit: ece349ade2973e220f524ce59e59711cc919263f
> change-id: 20261002-b4-qcom-spmi-a3c44ca5d952
> 
> Best regards,
> --  
> Petr Hodina <petr.hodina@protonmail.com>
> 
> 


