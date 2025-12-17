Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8CCD66BA2
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 20:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBC4383B49;
	Wed, 17 Dec 2025 21:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kUT7aV0Q";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="B6J0b0eL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F016383B55; Wed, 17 Dec 2025 21:22:38 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E28E83B32
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 21:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dWlbJ34F8z9t9s;
 Wed, 17 Dec 2025 21:22:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766002956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6b5qNc49Pvx5/wpqVTceK2y597EuxnBQKG89Tyyl5o=;
 b=kUT7aV0QCsc0EYa997zwcofguLTanjiu95Abv8cetKtuZ1fk9od6OQ5d0f6SQxECbSc+YI
 vqfVDV9voXmyxOz9qU61Cx5uUxVnIqxB0iVaY74WZUvwFiCQTta9TTbBm6CSVUORhI/YX1
 lFok2bM2qr87O3twrDxSG17C+B+P6j4iGNfrvFgjvhIIQ8Cyj8ykhx+wlzwTLDrcAudL+g
 EKhLixh9Lj9qblvx1iWDpziBvn10e5x9eKNMuhBrr6iVtEVf68UBqpE0Ct0Taxl5jojPhc
 U2h4jEHwjHe0TcGV2MY5dRCQo8AOLVE45Da4n9e+qYQFoD5m9X77ZwkjLybU0w==
Message-ID: <44cf22ff-773d-4818-a5d5-85216db0ad0f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766002954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6b5qNc49Pvx5/wpqVTceK2y597EuxnBQKG89Tyyl5o=;
 b=B6J0b0eLu3dC4PC+ekjy11MpXcnSj7/zBUfQGnF8an2cIevlNt1AXUOxP7l9FNllfOUXoG
 oqaYwgrNuUtUs/As7vVeUaztUvQNSuBvH3YMnsKWwk6ViJnpbZhQ4BhM6FgrI4P3LywBjW
 8CRf/fhkbsaaEsjYSXBsaSTCiqhHbBtfd2gZ+SQEJmtDFNfLW3Jedxym/U9fNreZ/EwGt9
 upj6ml/W6/ktT6XQJI190XZAuxxcGNPllrBXWAlSnPctIJ4oXl5K5gsYEtMbVC3EVj97ga
 665SmjoQVFpl078oOoegCsdGl703eQni/4OBfr7zthKVNcxsGlFpFh9yqbYfQQ==
Date: Wed, 17 Dec 2025 21:22:30 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/3] clk: scmi: Fix typo scmi_clk_get_attibute
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo
 <alice.guo@nxp.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>
References: <20251217-sqqs-v3-0-f3405fb2ad1f@foss.st.com>
 <20251217-sqqs-v3-1-f3405fb2ad1f@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251217-sqqs-v3-1-f3405fb2ad1f@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d2921ec8046bcc206cf
X-MBO-RS-META: 73his4nngrgcua1e7r4er3yqtxwr7e63
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
> %s/scmi_clk_get_attibute/scmi_clk_get_attribute/

Please rewrite the commit message and explain what this commit does, in 
plain text. This commit message is sloppy.

> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Add --- here, so the CC list is not included when the patch is applied.

> Cc: Alice Guo <alice.guo@nxp.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Valentin Caron <valentin.caron@foss.st.com>
> Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
> Cc: u-boot@lists.denx.de
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

AB/RB/TB tags go above SoB lines.

> ---
>   drivers/clk/clk_scmi.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
> index 683ac822a01..f6132178205 100644
> --- a/drivers/clk/clk_scmi.c
> +++ b/drivers/clk/clk_scmi.c
> @@ -87,8 +87,8 @@ static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
>   	return 0;
>   }
>   
> -static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char *name,
> -				 u32 *attr)
> +static int scmi_clk_get_attribute(struct udevice *dev, int clkid, char *name,
> +				  u32 *attr)
>   {
>   	struct scmi_clock_priv *priv = dev_get_priv(dev);
>   	struct scmi_clk_attribute_in in = {
> @@ -183,8 +183,8 @@ static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
>   
>   	if (!clkscmi->attrs_resolved) {
>   		char name[SCMI_CLOCK_NAME_LENGTH_MAX];
> -		ret = scmi_clk_get_attibute(dev, clk->id & CLK_ID_MSK,
> -					    name, &attributes);
> +		ret = scmi_clk_get_attribute(dev, clk->id & CLK_ID_MSK,
> +					     name, &attributes);
>   		if (ret)
>   			return ret;
>   
> 


-- 
Best regards,
Marek Vasut
