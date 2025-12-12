Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B6DD59D77
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 16:11:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEAF083849;
	Fri, 12 Dec 2025 17:11:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xPsVWYGn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FTpuuknL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5814D83869; Fri, 12 Dec 2025 17:11:52 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EC0783837
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 17:11:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dSZG81l1Sz9tdm;
 Fri, 12 Dec 2025 17:11:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765555904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1mkaVD5rmXPAFiGZqUPZyEOOdmI1Hk7nmxMsrmKY/DA=;
 b=xPsVWYGnIz2HLlOaoKHvnl6hf6MNDksmVIkvYE6Jw5QOCj3nL4saRgpIXAz+C538kJRHjb
 WlBOgmrEeWNuLIt2oYwlF+nVqA5QGGL8Iyu3wt+ahxVJR4FbxH+aRuyOqDtdEK2z6SZKyt
 L89jvVFzOZcDxlvICBPGBtDF9WxDbRTzYRAp80k9eAH3fsK8j0zGYBd4xPc7Sefw/6343H
 adoK/qE5kB31MHaUmJ18Tlr82hMhrkQvl41R6AX8YeISL4JckAVwSqzNQSfapXQ7JuXNCC
 yBm3MbMM+BhHJqbwTbXMl1D8a8SX8+ugydID0rt80PuijiPzdZ6O/75lJZI9eg==
Message-ID: <849b0052-e9a2-44ff-a019-00b79a3bd3f3@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765555897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1mkaVD5rmXPAFiGZqUPZyEOOdmI1Hk7nmxMsrmKY/DA=;
 b=FTpuuknLdseNxmfpeN/FHjtNax3vM8gynEG3/Yv6n1hlDw8StZmyxYt3//orncs5iXARgi
 7jMtIuesqfloJczmH/01M/PXl+mzsA0AJ7Tgw06ASI2WCfb1s/VYzNLNHfvkqzpVSt7blD
 qB498uxy06VU3BD/65/59w/AIz7reS6H792RRH5qbxwDJhCSPC+4G2QsryM3eqaAg0Wjf3
 5rYi+MRXO0pBn0TpdX2UC92h2tpmZxmid1n7zadh1/oZhGtiK1LtNnvq2cHZLXf32KoEmw
 NMT9aP3k1fOwiOQxV8PPTZDUtUPH6++IoJzcq7Gd/4sRdl2S3VvFP3zJyDa6bQ==
Date: Fri, 12 Dec 2025 16:28:43 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] clk: scmi: export scmi_clk_resolve_attr
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Alice Guo
 <alice.guo@nxp.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Valentin Caron <valentin.caron@foss.st.com>, Ye Li <ye.li@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20251211-clk-scmi-imx-fix-v1-0-9579567da829@nxp.com>
 <20251211-clk-scmi-imx-fix-v1-1-9579567da829@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251211-clk-scmi-imx-fix-v1-1-9579567da829@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: rbzw5rqhh3jkcb3agcbjisx96a9zpds3
X-MBO-RS-ID: 5fbb008808fe26f29d0
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

On 12/11/25 9:31 AM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> With commit 3547e315c188 ("clk: scmi: Defer issue of SCMI_CLOCK_ATTRIBUTES"),
> the SCMI clock names might be defered. However the SCMI clock may be
> input to other clock controllers, such as clk-imx95-blkctrl.
> 
> Without the clock names being resolved, there will be error:
> clk_register: failed to get hsiopll device (parent of hsio_blk_ctl_clk)
> 
> So export this API for users.
Shouldn't the relationship between clock be described in DT using 
"clock" property and phandles/cells ? You shouldn't have to resolve 
clock by names.
