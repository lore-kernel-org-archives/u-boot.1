Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD40606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=aroU3/F5;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OLY9Qjcn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22049407CF;
	Mon, 16 Nov 2026 16:19:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nbp7ttaCvTqi; Mon, 16 Nov 2026 16:19:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6831D40797
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794845956;
	b=Z76PuXZeWTKKyrOQ9JxWx0SakGTS74++g0JLgRN8BWHsNaXVct3Mk0SuJjikY15thSjT
	 JZHydtkYN0J4U/aA6Hgwc3jx0o3+NQGUgeDUl/RZjoV629jRtQb9sz8OBCPqQ9MHubWt5
	 PBMBItCr5eSy0eWvYp9l0rUpvMldcCtBocE/0t9ZcCL1g3Uk7fDrsLhj6Qos0ClSCuuLN
	 O5wwVu/TmlHL83ag1BexXiIKeI6Gpxdlwmgj5lvzECRGxtGHkcc1yt/tBLByu++LW+bJD
	 Jhlazmk/u9nxv0G5cxeWt3yOQzWC8FOUhh2vlrALfe3KYvl9Jm9B/gBTErBozeDXAVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794845956;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zeEYmLR3dFTd0eSJ1PxtnQq1YFfwZznlOVY/r64oONU=;
	b=mFye3kVW7s9fCYUGuaXfBq4oNlKOpwFA1HyDwoERjaQ1xqFJC091SM2SDdlkA6T0IqH9
	 Ic1kny0dl9QgPPvcrVGvu949HztgOs2hFrQbo/sCri6w6lTDgLRHZe/dPaIZ8LB3DdeNO
	 vAzMgl5bvFpHntJLq2yPiLC3dJUeLbub1pmN3Sf7qHipOaBfI4ULiUEtDfVpJMtufUe3b
	 zUWS6I9zfZpWESmXCIILQIIz2m2qZM6Y5voW2t8nkzExuGq/Cz5QSn02kZ8KT43bNNIoG
	 dXgy/WduS7W66LGxgewHgNq6oI3wQ0xK6fi5lsTNrxOzIK7WHtNnN3pcuPaVtQPtkIg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794845956;
	bh=zeEYmLR3dFTd0eSJ1PxtnQq1YFfwZznlOVY/r64oONU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aroU3/F5xYd0SXl6f0MYjOrYRgLqDkMeoC0yrOD1ByhAa6Aj13gZio333MOB9nK/J
	 NVKA1Jnann04QlsPTYJU7FcByVVvU8uni9ZvjZlCn5z8CCmGtM0Iy7seSBZYXJbgn+
	 CCzh6e7WVqzw9BOnUn0UbM1DASWHPuVU0XKR3AoQn1AMEiykjQ8BA4d+9lxrpUgD89
	 hmuuM3P392Au/Wx1ED4az/2J+zHd1HZ0pLVj33xdpBaTpaqKtMWeH1XoO4yLvAomdi
	 eLIjtCUQsvO9zT6nd2IFD63JchwHmHtHrIQPb6sTfF8K9dFn72+CXb6Gqa3yVCJYUD
	 WABO+VFU/yTNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6831D40797;
	Mon, 16 Nov 2026 16:19:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DB816169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:19:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C1799606CA
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:19:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5rLpFPjMmxwt for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:19:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 074D06060B
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OLY9Qjcn
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 074D06060B
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:19:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D69D415FA;
 Mon, 16 Nov 2026 16:19:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EC51F000C4;
 Mon, 16 Nov 2026 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794845953;
 bh=zeEYmLR3dFTd0eSJ1PxtnQq1YFfwZznlOVY/r64oONU=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=OLY9Qjcndz979bLwocZ4JSwHyKdIitZV3FftmfrrHmgBi9S3NptAegsk8KbIDGHVi
 8md+nIqJE7coTWGL/JGm0pQYCmpbOqVHs17Uq5T20sZjY8JX6/A4a4CfB6c3YKKnqR
 MJgIR1TZUWzA9gqCh7xyyaKnFq7x++/V/2g5WCENwaRWVi7yrLOf02EHk1/ySE6H3a
 6Q4dAXIxKrt0QQAqjD7b6cekZSFJWTmlsJcmpamC0O/XwO7B3Ea3ZrHoPsXwwW3gy/
 Vh62AQQgDH0l3U2nNZrwr53ZGn/ivAH3fxgS9Dj+8jJafn5Di5jAKWHmr1zsEIS2SO
 K/HZRAGAeZdNg==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rng: msm_rng: Acquire optional clock even when
 initialization is skipped
From: Sumit Garg <sumit.garg@kernel.org>
To: Reza Kurniawan <imkyufie@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 u-boot@lists.u-boot-project.org, Robert Marko <robert.marko@sartura.hr>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260915-qcom-rng-fix-v1-1-c7405eebba63@gmail.com>
References: <20260915-qcom-rng-fix-v1-1-c7405eebba63@gmail.com>
Date: Mon, 16 Nov 2026 21:49:10 +0530
Message-Id: <179484595053.21534.13233223056635655439.b4-reply@b4>
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

On 2026-09-15 06:31 +0000, Reza Kurniawan wrote:
> For devices marked with skip_init ("qcom,prng-ee" and "qcom,trng"),
> msm_rng_probe() currently returns early before retrieving the clock.
> As a result, priv->clk remains uninitialized, causing subsequent calls
> to msm_rng_read() to skip enabling the clock which may cause failure
> if the device boots with the clock disabled.
> 
> Move clk_get_by_index() before the skip_init check so that any clock
> specified in device tree is properly recorded. Additionally, treat
> -ENOENT as non-fatal so the clock remains optional for devices (such
> as some "qcom,trng" nodes) that do not define one.
> 
> Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
> ---
>  drivers/rng/msm_rng.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/rng/msm_rng.c b/drivers/rng/msm_rng.c
> index aab602c5e..68f25ac51 100644
> --- a/drivers/rng/msm_rng.c
> +++ b/drivers/rng/msm_rng.c
> @@ -114,13 +114,13 @@ static int msm_rng_probe(struct udevice *dev)
>  	if (priv->base == FDT_ADDR_T_NONE)
>  		return -EINVAL;
>  
> -	if (priv->skip_init)
> -		return 0;
> -
>  	ret = clk_get_by_index(dev, 0, &priv->clk);
> -	if (ret)
> +	if (ret && ret != -ENOENT)
>  		return ret;
>  
> +	if (priv->skip_init)
> +		return 0;
> +
>  	ret = clk_enable(&priv->clk);
>  	if (ret < 0)
>  		return ret;
> 
> ---
> base-commit: 0e2a0ceeefa0ae10118b8364da62f1fb86f286c0
> change-id: 20260914-qcom-rng-fix-a7dabc760daf
> 
> Best regards,
> --  
> Reza Kurniawan <imkyufie@gmail.com>
> 
> 


