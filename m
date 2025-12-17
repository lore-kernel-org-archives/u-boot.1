Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64016D66BA1
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 20:24:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E33F183C0E;
	Wed, 17 Dec 2025 21:24:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="au/+V0Ri";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TM8qbC6j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD72483C19; Wed, 17 Dec 2025 21:24:02 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7FA283B32
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 21:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dWlcv6B6Nz9v7W;
 Wed, 17 Dec 2025 21:23:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766003039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WSkEAd0tUPqVHPxuKpJAWOSNYX6YlP6BdG86tiLzzEg=;
 b=au/+V0RiqvfSF2nKvFMK6ciUA/2lCa2IobUgE9F6vyLwY6eP2SWWhO3XAsPtqpaqh8M7U2
 p2Kl/NKOsD2czW0vJ/N4gzWadoiR7jNf6bmSyQxjRZuVzxwCcuPf/wNL35g33Ld0BUSWHi
 eWFTK4t7aH4qukywWA4z9gwSSCjIal43BEmuuxEOQA+9TdjQCFOd3NaV8OhueSYYMcFBSh
 kt0MPuSyJI6HHDxOXRpJN34WjyHGHrA4KLy+pIhCWsqRUesk9k6vYfReHEENJK8lDLdXQG
 q2yb1bKv1jyn+ksTZp9ofud5vmD0QYYYP9dMet0KQwWxop7F+gZAbC4gKH93PA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=TM8qbC6j;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::2 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <5836aa5b-a35c-4e07-8e25-271f6950970a@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766003038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WSkEAd0tUPqVHPxuKpJAWOSNYX6YlP6BdG86tiLzzEg=;
 b=TM8qbC6j+Nb1furCurx5eFVQjAcTDGGRfKv5Dtgq16VyEMOxzPCpY8L/eNS1kgvQcDSukn
 okoHotdh8U/t8B1jmn8b9tznbTG6yMlYJsmXrBJujM3/7W5pWTwBR+ChCnwSmUwdhU4fRc
 fXimZhkgiiLEnG7jxr4bdmv8DTcJUC4bjPo9MyCxDsqnDxnjXn8oHs5qlxUvau22MUUje6
 Q6JQ39EgqD/F7dMhlhcQRtGis2TqsE3DCDKpG4stFp00DFlm3cp7pUiGo6SZIHcqZp7blj
 4VcWYrXHKDDl6z+nsHA7xHI2GvzgEwrGpFwLNBGBxuFat1BSUyaVMbGn5yUomQ==
Date: Wed, 17 Dec 2025 21:23:54 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/3] clk: scmi: Fix priv initialization in
 scmi_clk_gate()
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo
 <alice.guo@nxp.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>
References: <20251217-sqqs-v3-0-f3405fb2ad1f@foss.st.com>
 <20251217-sqqs-v3-2-f3405fb2ad1f@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251217-sqqs-v3-2-f3405fb2ad1f@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 8bf562ab77d5d482e07
X-MBO-RS-META: tyq6wm9hoszy1k1y4w8tzkuqdfyxhfax
X-Rspamd-Queue-Id: 4dWlcv6B6Nz9v7W
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

On 12/17/25 5:45 PM, Patrice Chotard wrote:

> @@ -156,6 +156,15 @@ static int scmi_clk_gate(struct clk *clk, int enable)
>   					     in_v2, out);
>   	int ret;
>   
> +	/*
> +	 * retrieve the correct priv which was set in scmi_clk_probe().

Sentence usually starts with a capital letter, i.e. Retrieve ...

> +	 * in case CLK_CCF is set, priv was set in parent_priv

Same here, also ends with full stop .

Also, please expand the comment, this terse comment is really difficult 
to understand.

> +	 */
> +	if (CONFIG_IS_ENABLED(CLK_CCF))
> +		priv = dev_get_parent_priv(clk->dev);
> +	else
> +		priv = dev_get_priv(clk->dev);
> +
>   	ret = devm_scmi_process_msg(clk->dev,
>   				    (priv->version < CLOCK_PROTOCOL_VERSION_2_1) ?
>   				    &msg_v1 : &msg_v2);
> 


-- 
Best regards,
Marek Vasut
