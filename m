Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA9AC001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B5E386977;
	Tue, 15 Aug 2023 00:34:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NAa2O1h8";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vfOA/RFc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FEF58666B; Tue, 15 Aug 2023 00:34:20 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D148F855CE
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:34:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RPq2L44Bjz9smc;
 Tue, 15 Aug 2023 00:34:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692052458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yOU2EAu2gTHR3jUR4Tho0P0+VdH+xgc12yrngMBcRPY=;
 b=NAa2O1h8K0j7lFZfR/YYu8DI1MLO4hrFfNxxVJ8+jAxpN8z51250whzIy3ezd1zOw6tw+N
 nmsiZCJb4W/ginFBxPfsf3AX7EcNLexoMLP3wfmvnXJoorBCjBIezMSCJa8rTYti9wtVf3
 F1FTqR3OT5sDjyIfmG0Ryk26SDBMCoTYypa9CRdRS4s+p5vB1MJO2udfK7L49rOlAy9Rx3
 e5iQ+9S/D8I4gcvbwXSqDYjWC41DTGFmikSE44dUvrAZqv9BcR/zcMyQAf3p4lDbQTcQ6X
 RBuNcjPlosoFjO0TMqcQPafjCC46xbl1mnQ9JbwB7u9mQKPCZnkMjBG3WCbedQ==
Message-ID: <c96bfb16-83bf-7e49-73b9-f3734cca008c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692052456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yOU2EAu2gTHR3jUR4Tho0P0+VdH+xgc12yrngMBcRPY=;
 b=vfOA/RFcrIpY2J9hmmBWXNF3v1oRCH2gMV1wObV67tWmRrVqsrRsi2ndGe56Kvw9W8S2iI
 KS0JTPIPq9XvfgK8pXCDEHnYxM/kTjBh9YQs3aSy2TZhUgY1FK0TcldaCn9rzNz0xS4MPu
 uqFh+pEvKAUWal3pp0zT2qPguOK3F2dk8GWB/Je8APAKrbXMDOCib0cggRv4slamlhULEK
 Vd0apl8a+OjlLJegc0jefxAqXECojwv5SDkgud9iyUx45pQBi12qhTr+sUzZMegTsyQyjF
 h3m5bAw0Vd26kgu5EvUc1LgGOIwUc4pEslrRQT5DOcVgUQ/R3X3T6ijmETBZnw==
Date: Tue, 15 Aug 2023 00:34:14 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 08/17] ufs: Expose 'ufshcd_ops_dbg_register_dump' vops to
 allow dumping debug registers
Content-Language: en-US
To: Bhupesh Sharma <bhupesh.sharma@linaro.org>, u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.linux@gmail.com,
 marek.vasut+renesas@mailbox.org, sumit.garg@linaro.org,
 rfried.dev@gmail.com, patrice.chotard@foss.st.com, jbx6244@gmail.com,
 kever.yang@rock-chips.com, eugen.hristev@collabora.com
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
 <20230814215457.4075025-9-bhupesh.sharma@linaro.org>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230814215457.4075025-9-bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: c18e96x8ff7jip9zwd93y4znxdb35skf
X-MBO-RS-ID: c818fa2e8d433e938c6
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
> Add more verbose debug capabilities and vops to allow dumping
> UFS debug registers / regions, similar to how the UFS Linux driver
> does it.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>   drivers/ufs/ufs.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/ufs/ufs.h |  9 ++++++
>   2 files changed, 80 insertions(+)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index b2c3af429e..15fa3832b9 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -59,10 +59,81 @@
>   /* maximum bytes per request */
>   #define UFS_MAX_BYTES	(128 * 256 * 1024)
>   
> +#define ufshcd_hex_dump(prefix_str, buf, len) do {                      \
> +	size_t __len = (len);                                           \
> +	print_hex_dump(prefix_str,                             		\
> +		       DUMP_PREFIX_OFFSET,				\
> +		       16, 4, buf, __len, false);                       \
> +} while (0)
> +
>   static inline bool ufshcd_is_hba_active(struct ufs_hba *hba);
>   static inline void ufshcd_hba_stop(struct ufs_hba *hba);
>   static int ufshcd_hba_enable(struct ufs_hba *hba);
>   
> +int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
> +		     const char *prefix)
> +{
> +	u32 *regs;
> +	size_t pos;
> +
> +	if (offset % 4 != 0 || len % 4 != 0) /* keep readl happy */
> +		return -EINVAL;
> +
> +	regs = kzalloc(len, GFP_KERNEL);
> +	if (!regs)
> +		return -ENOMEM;
> +
> +	for (pos = 0; pos < len; pos += 4) {
> +		if (offset == 0 &&
> +		    pos >= REG_UIC_ERROR_CODE_PHY_ADAPTER_LAYER &&
> +		    pos <= REG_UIC_ERROR_CODE_DME)
> +			continue;
> +		regs[pos / 4] = ufshcd_readl(hba, offset + pos);
> +	}
> +
> +	ufshcd_hex_dump(prefix, regs, len);
> +	kfree(regs);

Why not use variable on stack instead of this malloc-free cycle ?
