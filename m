Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6C1D1D478
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 19:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D02A08415E;
	Thu,  8 Jan 2026 20:56:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JAnd6JAy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D092B84285; Thu,  8 Jan 2026 20:56:02 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B345E84150
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 20:56:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dnFyQ5DhSz9tPs;
 Thu,  8 Jan 2026 20:55:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767902158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J0CsusszjJXQONSBx8F4YOfDMKtypANsSgK9S2m3Cn4=;
 b=JAnd6JAyBJ/XcR1SGGYyXCfeS4um1akLPp1Z4u3bIUMGqKXrclLQprM9Vv5XPu2aeB1Dxh
 cYSn1oW2qmRHnR5w3Bejs3RbUejhSfV0SsNDzsVCYz4zM9iKH5XX4hBz0apXquZv27ICXi
 29TVMnzA5RaK4DYCx/IolAtfA6H0Oswc0bpQF6nfIfnMQu9bwX9k2WN2fM/jN6tBa/YIxD
 sEYHgoMobJEgeCafuDh93sqWtaZwu8vAHx+oS25IZeJusGX6VeIolWXwd6FMfFSKUOwnzo
 PPI4+0jR27pBJFe8YBY6LUBMkfdIpiVdr1nFXvx7/r+G6ooEpbmmHDUTinWsFg==
Message-ID: <4780165d-9e32-4628-b457-299972a21fa8@mailbox.org>
Date: Thu, 8 Jan 2026 20:55:56 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] ufs: uclass: fix potential unitialised use
To: Casey Connolly <casey.connolly@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260108191626.3119582-1-casey.connolly@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260108191626.3119582-1-casey.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f0c68470489e57f2115
X-MBO-RS-META: 8mxak7rfhwihbdwoi3g1pc1b16jx678z
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

On 1/8/26 8:16 PM, Casey Connolly wrote:
> When host_ref_clk_freq is 0, err will be returned before being set.
> Assign a default value to fix the warning.

Indeed, nice find.

> +++ b/drivers/ufs/ufs-uclass.c
> @@ -1854,9 +1854,9 @@ enum ufs_ref_clk_freq ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba, struct
>   }
>   
>   static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
>   {
> -	int err;
> +	int err = 0;
>   	struct clk *ref_clk;
>   	u32 host_ref_clk_freq;
>   	u32 dev_ref_clk_freq;
There is another weird piece in this function, look at this:

""
diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 3c8e4299259..da46b3ebdfd 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1868,12 +1868,11 @@ static int ufshcd_set_dev_ref_clk(struct ufs_hba 
*hba)
         }

         host_ref_clk_freq = ufshcd_parse_dev_ref_clk_freq(hba, ref_clk);
-       if (host_ref_clk_freq == REF_CLK_FREQ_INVAL)
+       if (host_ref_clk_freq == REF_CLK_FREQ_INVAL) {
                 dev_err(hba->dev,
                         "invalid ref_clk setting = %ld\n", 
clk_get_rate(ref_clk));
-
-       if (host_ref_clk_freq == REF_CLK_FREQ_INVAL)
-               goto out;
+               return -EINVAL; // I think we want to bail with error ?
+       }

         err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
                                       QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 
0, &dev_ref_clk_freq);
""

How about we simply get rid of the whole trivial fail path and directly 
return a return value instead of the 'goto' statements ? That should 
cover all the weird corner cases too.
