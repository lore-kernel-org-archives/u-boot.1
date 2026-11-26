Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E192606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=s+9wA6k8;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nWb+77WE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 041D7409D9;
	Thu, 26 Nov 2026 13:19:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GjleicDPptql; Thu, 26 Nov 2026 13:19:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 24805409D3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795699196;
	b=ZppguL1YNNn+LAU/hlxeyviFzTRTf/rcDvRz0A7keSfyqF1IsnNYJ9JtGPnTKfcGnOQn
	 KF98Hb7kElPdHgiUODxYN5Cj3R3NunJAWDVs7WeDy838Iz0PGxUnu1yEz1gnG6ulLURpo
	 Nj3MZGC8rn+2WYoQpPJ+MuEVQkyTyi2Qj8CFVACvc8wDCHYicbGnrjK4raf6dMEFfLIOL
	 3JZbrRpmhDXPua1KwMNde00bnweHtjOZhcVTEeSKDZKJ5uYv+ssEbw8KAp37Ft5FVRlMM
	 ueON5nyOO+WBIVj54JNOiEtE+qL8QfI2XCeiPXDDKQbFJGxrHoE4rZy6LUTjAgGIr7g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795699196;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Znscht0jBgkxKQLWhbPOBUh+GjCFH0l5WNgX3wCTmg8=;
	b=EvchijnnpXrYb1WsSasxSuU8/6Xsgl2FsYuAxaq+eQoq1eU9aWVDnQq4tgUBXu5PWwGg
	 ZJPVabkN3jRzOXP9u4DCcAvbKWIl1Ciw/sErNuWiu07ob7MRoZOMNTcIPeUWURUDe8R4I
	 zrPOYcRHm+TfRX4oXg1to6CtiXsJDnXTKdK1/+EKoGedEKhH4l5zP+k4ClOXoDO1ZvlvM
	 Cn1v6/jj2js8/Gnb997XO3ZRVEhC/6A0RR0NCbqPaDU4iNJ8+N4m8WENJX4sf5O2aNO/w
	 E8dIIEZiKcAdAvVHiyEkmZsKHzbpshZsp3CkA1pmaEfxVgDbMADlIMTV/SL7WVb/4iQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795699196;
	bh=Znscht0jBgkxKQLWhbPOBUh+GjCFH0l5WNgX3wCTmg8=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s+9wA6k8j2f5BQoIkM7j1sLJbu/Ky2cWJylcsvL4bpyhyn6ZYWTNkz/ADbY7okNDp
	 9CJj11RC0OGqdfrEN+TWBnOwEO6Xhori75Lcvs883eOEiuKilPnL8iGt8n95OqA8Z3
	 /z4mAT/3ipEp2DKr4ACWTSR+0t+aPV6vJuQ/amwvoGEyb6ARuIruYGNgSTDkvGlsxK
	 VrLNEBtEGL2kbKLD0E4IifK3VtgLESDzYlRVFi758++7Bt9EbZW8BWS2+bx7d0ATQP
	 W08tiVr8KHrkJwlxKVJU6956n1GSEpljITPoLwmozhjakogVu+TSU6UxIDUI9+/9Yu
	 Phw0SupszhnUQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24805409D3;
	Thu, 26 Nov 2026 13:19:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AE9CC325
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:19:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC8FF404DC
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:19:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U5iCXOISrq6S for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 13:19:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DCE65404A4
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=sumit.garg@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nWb+77WE
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DCE65404A4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 13:19:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 87ABF61189;
 Thu, 26 Nov 2026 13:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B881F000C0;
 Thu, 26 Nov 2026 13:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795699192;
 bh=Znscht0jBgkxKQLWhbPOBUh+GjCFH0l5WNgX3wCTmg8=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=nWb+77WEHGvs30BHw0elB/2iDvcNHhKzeb6B4BwPmuEIfVglKuUCHvAkn8kCDgCSq
 73yxw46Tkq/pl1O5wBp2rn9QzQqzQY9QQgeSQnQd1yi9NXV6NBOy2ubh5z4nBzbm/a
 yBW0GFW4zhfht14duWcOHJ51NE4hqIXdZpveJG4k14pCqO8YA64w9cL/zEFvtlsDdc
 8CsaA8rUcyCHrrs4eQ4/+OdA33bdHnDAXoZivcwlmxOlQQsabbLo28sOw6ljYFAlIp
 4FB6GVcFKAHTSUOtgutz1kmcq7usBHymNg6V5sTyOj8YTvE65i+tGo0iGzik3TUoaE
 4E9fH/nbXl+XQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 0/2] qcom: Enable CONFIG_SKIP_EARLY_DM for Faster Boot
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com, 
 ilias.apalodimas@linaro.org, casey.connolly@linaro.org, 
 neil.armstrong@linaro.org, sumit.garg@kernel.org, Michael.Srba@seznam.cz, 
 jbx6244@gmail.com, nathbappai@gmail.com, 
 balaji.selvanathan@oss.qualcomm.com, naveen.osdev@gmail.com, 
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
In-Reply-To: <20261106061202.3049194-1-aswin.murugan@oss.qualcomm.com>
References: <20261106061202.3049194-1-aswin.murugan@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 18:49:41 +0530
Message-Id: <179569918195.130558.9627049795678715668.b4-reply@b4>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-06 11:42 +0530, Aswin Murugan wrote:
> Enable CONFIG_SKIP_EARLY_DM on Qualcomm platforms to improve
> boot time by approximately 50%. Address a serial driver
> crash seen with CONFIG_SKIP_EARLY_DM enabled by properly
> handling error pointers returned from clock operations
> during early boot.
> 
> Changes in v2:
> - Move CONFIG_SKIP_EARLY_DM from qcom_defconfig to an imply
>   on ARCH_SNAPDRAGON in Kconfig
> 
> Link to v1: https://lore.kernel.org/u-boot/20261008103146.706211-1-aswin.murugan@oss.qualcomm.com/#t
> 
> Aswin Murugan (2):
>   mach-snapdragon: Kconfig: imply SKIP_EARLY_DM for ARCH_SNAPDRAGON
>   serial: msm_geni: Fix clock enable on error pointer

For the series:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
>  arch/arm/Kconfig                 | 1 +
>  drivers/serial/serial_msm_geni.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> -- 
> 2.34.1
> 
> 


