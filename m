Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C49C04A6A
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 026E28662F;
	Tue, 15 Aug 2023 00:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vcR0Kdka";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="oBPCJtFP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33C3586977; Tue, 15 Aug 2023 00:40:45 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21ABA855CE
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RPq9k67bqz9sfC;
 Tue, 15 Aug 2023 00:40:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692052842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cndGi7eGP+cGXk5ERXCJXjcJhOWR5kEA+isfJrsQ37E=;
 b=vcR0Kdka1vdasfeGsU+8xIf6d2taYRLViZa16pJQ15DDVrBjc7JYSgbE93aksM5s0ojqSo
 05aQJzQH5J5DsCxD/LZB9N0l9aJrsLJpU3e6CtQEJocdNRFRzANc6emrpRncoc7MQNMMmr
 /ZpMtszZsCD4qbFoTKl0UfAfXCFeVKXu8M/2XLznJDxf91qrQx3BPq1qgFAGAkOQR0u2mm
 477lXPLfgOuD8E3Vox2CDIT4gteeEFbnssD18vmEUWtDaTo27bJ+tFM/YMiiKSmFmmZMjx
 RA5+YPRdbS9l/F1xwQXkl1Rt81J3WWIL44PSV/NvianY2CuO3dL11m5l1p77uA==
Message-ID: <32b554d0-c94c-2477-de12-bf8b1caa0e1e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692052841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cndGi7eGP+cGXk5ERXCJXjcJhOWR5kEA+isfJrsQ37E=;
 b=oBPCJtFPl2cIZRlACVO0zN5kwsIwFo4K2u+IuYF2juv0tOsXmLUIT1oT/B3E3YDvIpeamf
 slkO5zyQa7I8B/o8m4AlrcFMFG56bm84z2hgQFOSkov5g5LT7ajQjRsrozC/aXtNAIDyfD
 /ogLawGhN+yon2UMOyg4TF6pDjRESTFJG3A8GrfuouFsTXR5PG2DFSpAbDVwjnSYHSVIx1
 qzXcYCqnuWsqwtDQibsMHazcMuyCq8zJYJYiOIB2xgTGWKkumSkAw1w+JOBPG9w9l/o5Lg
 yiNlxwdPMsyFW+5jyfV7mFxgnc2GTGuh2mGmv2nLRHXiSmJVQDSosV2HOug1ZA==
Date: Tue, 15 Aug 2023 00:40:38 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 12/17] ufs: Add Support for Qualcomm UFS HC driver
Content-Language: en-US
To: Bhupesh Sharma <bhupesh.sharma@linaro.org>, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.linux@gmail.com,
 marek.vasut+renesas@mailbox.org, sumit.garg@linaro.org,
 rfried.dev@gmail.com, patrice.chotard@foss.st.com, jbx6244@gmail.com,
 kever.yang@rock-chips.com, eugen.hristev@collabora.com
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
 <20230814215457.4075025-13-bhupesh.sharma@linaro.org>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230814215457.4075025-13-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: af637e07b99ed05197c
X-MBO-RS-META: 17edq8q1wzojdjqwf54zj4spdhnbdk1c
X-Rspamd-Queue-Id: 4RPq9k67bqz9sfC
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

On 8/14/23 23:54, Bhupesh Sharma wrote:
> Add Support for the Host Controller driver for UFS HC
> present on Qualcomm Snapdragon SoCs.

[...]

> +static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_hba *hba, bool enable)
> +{
> +	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
> +
> +	if (priv->dev_ref_clk_ctrl_mmio &&
> +	    (enable ^ priv->is_dev_ref_clk_enabled)) {

Invert condition to reduce indent.

> +		u32 temp = readl_relaxed(priv->dev_ref_clk_ctrl_mmio);
> +
> +		if (enable)
> +			temp |= priv->dev_ref_clk_en_mask;
> +		else
> +			temp &= ~priv->dev_ref_clk_en_mask;
> +
> +		/*
> +		 * If we are here to disable this clock it might be immediately
> +		 * after entering into hibern8 in which case we need to make
> +		 * sure that device ref_clk is active for specific time after
> +		 * hibern8 enter.
> +		 */
> +		if (!enable)
> +			udelay(10);
> +
> +		writel_relaxed(temp, priv->dev_ref_clk_ctrl_mmio);
> +
> +		/*
> +		 * Make sure the write to ref_clk reaches the destination and
> +		 * not stored in a Write Buffer (WB).
> +		 */
> +		readl(priv->dev_ref_clk_ctrl_mmio);
> +
> +		/*
> +		 * If we call hibern8 exit after this, we need to make sure that
> +		 * device ref_clk is stable for at least 1us before the hibern8
> +		 * exit command.
> +		 */
> +		if (enable)
> +			udelay(1);
> +
> +		priv->is_dev_ref_clk_enabled = enable;
> +	}
> +}

[...]

> +static int ufs_qcom_check_hibern8(struct ufs_hba *hba)
> +{
> +	int err, retry_count = 50;
> +	u32 tx_fsm_val = 0;
> +
> +	do {
> +		err = ufshcd_dme_get(hba,
> +				UIC_ARG_MIB_SEL(MPHY_TX_FSM_STATE,
> +					UIC_ARG_MPHY_TX_GEN_SEL_INDEX(0)),
> +				&tx_fsm_val);
> +		if (err || tx_fsm_val == TX_FSM_HIBERN8)
> +			break;
> +
> +		/* max. 200us */
> +		udelay(200);
> +		retry_count--;
> +	} while (retry_count != 0);

Is this some readx_poll_timeout() reimplementation ?
