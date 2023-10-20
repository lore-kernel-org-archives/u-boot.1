Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F99CDB474
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 04:26:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C94EE86F42;
	Fri, 20 Oct 2023 06:26:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HyBWJsCm";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YXGma3Ll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7F9B86F52; Fri, 20 Oct 2023 06:26:23 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E900B86F0D
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 06:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4SBWk553hDz9sdW;
 Fri, 20 Oct 2023 06:26:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697775981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PyYgILf1CnLfrhxVu04YbZyMF+53tWAxjLircnrEofE=;
 b=HyBWJsCm2rr3j3hR1L8FMuhcMzC93mSv3Q6b1jepa9dgpCEu55qOd4oSs1GYr22RkrePsu
 vYBLdqkTsl+YYhSHkGEarAXTqTjM3KeUYv3h9wbunwcXBZUMFx8H+wpIpX1/G2B4BHRs52
 QF/lxX03if3flPpwunLi69PEUU4AxwiDtiu1+dvkE6vplVM94W7jAHWL3BtJgdJ1P3XIrT
 AQM5uzrKshZVeXXSC4alv8X+sFtM3E8/Ra02LoNeBqLQe62VpGFdT9nulsxUQzqU2J0//B
 xAxlZNuvExXClWyC6jdkTugo4fT/O6wmxCd26MtUVARdeFR9Wwu7B9FMMsYoBQ==
Message-ID: <12dcbb2d-9ef8-459e-a20b-cd70ba0ef653@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697775979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PyYgILf1CnLfrhxVu04YbZyMF+53tWAxjLircnrEofE=;
 b=YXGma3LlM2OS0sDJnbwsfxR23VE6OsFPCRyZVTfZpGxGYr2LafKvWga2oO4GeHyGLoa+4s
 YOOXxBFsZCJWE8+4hwC89N9Xf80rD5H4XJL/mRwi1X5+y+mYpE1vknbBRUjMIYgZ37Svcm
 ti53bhtdaNo+F9qEdTo78eAF7JRGbdjJU4j/2YY7zwfJOrUKarSe7aqpfC/A39ahw1JgW4
 vm/bB/+9HNXrisoCK1cemIMZ2+fSCLSBNqINmQ9H+hL5NbfObR2/dAJ+LrArE3DorKiStd
 D31ScXFoCOZFS0Pg4ZJhz+SUkvyNXagLwinGXzDfz7nvgNXoSZ5sUNJEqPjzqg==
Date: Fri, 20 Oct 2023 06:26:16 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] mmc: renesas-sdhi: Fix error handling in rzg2l_sdhi_setup
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
References: <20231019145038.14701-1-paul.barker.ct@bp.renesas.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231019145038.14701-1-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: fe28ea14bb14b042f8c
X-MBO-RS-META: g4uonnaejhpfc9dyze1zq8beaqcw6ide
X-Rspamd-Queue-Id: 4SBWk553hDz9sdW
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

On 10/19/23 16:50, Paul Barker wrote:
> We should ensure that reset_free() is called in the error path.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Fixes: 93c811b7331b ("mmc: renesas-sdhi: Initialize module on RZ/G2L")
> ---
>   drivers/mmc/renesas-sdhi.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
> index 1ea6e1066f2b..865efdd32184 100644
> --- a/drivers/mmc/renesas-sdhi.c
> +++ b/drivers/mmc/renesas-sdhi.c
> @@ -998,7 +998,7 @@ static int rzg2l_sdhi_setup(struct udevice *dev)
>   	ret = reset_get_by_index(dev, 0, &rst);
>   	if (ret < 0) {
>   		dev_err(dev, "failed to get reset line\n");
> -		goto err_reset;
> +		goto err_get_reset;
>   	}
>   
>   	ret = reset_deassert(&rst);
> @@ -1016,6 +1016,8 @@ static int rzg2l_sdhi_setup(struct udevice *dev)
>   err_tmio_probe:
>   	reset_assert(&rst);
>   err_reset:
> +	reset_free(&rst);
> +err_get_reset:
>   	clk_disable(&aclk);
>   err_aclk:
>   	clk_disable(&imclk2);
> 
> base-commit: 9a0cf3993f71043ba08c315572c54622de42d447

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

btw is email playing tricks on me , or is Jaehoon and Peng not on CC ?
$ ./scripts/get_maintainer.pl -f drivers/mmc/renesas-sdhi.c

(I added them to this mail)
