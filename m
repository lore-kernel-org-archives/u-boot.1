Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BF8606A8A4
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CobmdlJ2;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=JNx6SxQ4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C00E680FAC;
	Mon, 16 Nov 2026 16:56:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NRugvJwKhcjK; Mon, 16 Nov 2026 16:56:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9B03580ED9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794848214;
	b=LJfZA83ll9sFf/M9mAeMUUCFYKACiee3zn4KEPtqWCWjKx9Sfq11xMsKS7NTXWZyFg1n
	 +fm51l6K/+cUW+yMHrVs0z6G9hXMQjHoFGhUiS1ye2JlTDRyOFDAdOGzQaXl99odKijcC
	 7D+ysKiek5etYMtB2sVa2xuWLF3k8KdC06pgzYdibS1PTdZINUAkWismAHQjlFTzLmp03
	 thkkLgt3HOvRrBSJwtmc/le9EanKbmkjJ74X0/hKm7m3DC8kIVKN2ztSU9y6cT4NSFfvC
	 MH/vc5bj1sZyatvaXmx0m3cVuQY3RJqhUPHuRkOEopCaclc0KNXd1sW1TTmgAD4ndgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794848214;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=mpjN/fVsv/gvGNWfMF8JljM2crftteIRvTOP2A+PRzE=;
	b=f6B3689/VnICPkxfQ4ibuiUncOVPmmc7b/++yLZt/thZ9w6iA909doUULE896u1vzske
	 2QGNYGSvtLdD7/jdj4pk/IpL7jcBnbsLndRdgMKUerOO967N23wDA6CzpHI+6r6ZjURbC
	 CZnvw9gcTTX2Hke5bhQ6G9mZmzV0lveS3tFVWBVqF37cpAmB+kGerPxQ/asBjUssTl2FQ
	 pRpjX3kDQ4DiKllMufrkVMN9zddgefMFSdii7r/isScAjfZvU2MAOcXJSPc5Yjp3MAAb+
	 T8mNLSlEzBI/RGl1bCVD09qP+e7xZ/BTH6vT/gjl1mcUy8Wu9i8//TD2T5feONJhSWg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794848214;
	bh=mpjN/fVsv/gvGNWfMF8JljM2crftteIRvTOP2A+PRzE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CobmdlJ2IQNQovjVK0EZ3rh9d40uqTpqJbD9mZYMONo06cikUDRDGz0X5UhVZHRHR
	 w6AAl/GI0qBUrc6joIXEKjLNlZzaB+0UQqnUcVo3Ub5+HjHvanu+iHqmVCDn5YSZdW
	 gHvSofhJmm+xCGcZwZQyglEtIB5fo8QeQr9ue/WlkRgPeXnLuN6HLyzbvCqgYvLFu2
	 AP8iy8aB18tjrPGopSU4MiGS2/7yPx51pFbzi/bNi4hv2zyL2MfvP6CToR3gigcV+z
	 W7tsUf+Dc0jTRBUeTjdhXjvtOTjLAVCeTnGE3MEU4W6DWS0VIQDOq++QGSCBPIR1B3
	 0he1YDK9dGjbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9B03580ED9;
	Mon, 16 Nov 2026 16:56:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3DE83169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:56:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2757F607B5
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:56:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 83rXv9lVI6RN for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 16:56:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 27A2260721
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:7ff8::42ae"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::42ae; helo=smtp-42ae.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=JNx6SxQ4
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::42ae])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 27A2260721
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 16:56:50 +0000 (UTC)
Received: from smtp-4-0001 (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jSvCg6Y2mz2JrJ;
 Mon, 16 Nov 2026 17:56:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794848207;
 bh=mpjN/fVsv/gvGNWfMF8JljM2crftteIRvTOP2A+PRzE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JNx6SxQ4Vf0h8JaD6KYKGH+7kF8ctGFvgdX/AoE/bcTYwVPvFuorPRCePNJCQS3As
 yv1/PG62bP8lbf+W/u19NeR00Vk2hGI3Pil1bSZC7OmFRd/nqCKWTpwQTomClu2YDf
 1SERDUkmFQRVSuBl66jAtSRn3HgoSwEUv3+oYnDBGMTCSJx+2fyebZh0X4C5p+8TVb
 swSoGdvoTKtp+8+hh6KTNpjmTB2UFhVS1iO8r790wYHWghy978B2DqNgK1dtaNlRtR
 4tnieUJ8NlgKYIFz+bnZWsckFDRQWOizDWVoVdjX7Tu6k1ZRH0xJkc+8JzeZd60w7P
 xiFEBhqMRjrLA==
Received: from unknown by smtp-4-0001 (Postfix) with ESMTPA id 4jSvCf45g5zV3Y; 
 Mon, 16 Nov 2026 17:56:46 +0100 (CET)
Message-ID: <b5b5137c-e5d8-42f1-bdfb-436cda46ae75@0leil.net>
Date: Mon, 16 Nov 2026 17:56:46 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] rockchip: Remove unnecessary clk_set_defaults()
 calls
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org
References: <20261027224742.2527550-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261027224742.2527550-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 11:47 PM, Jonas Karlman wrote:
> The driver model core and clock-uclass will call clk_set_defaults() to
> automatically apply assigned clocks for devices during normal udevice
> lifecycle.
> 
> This series remove unnecessary clk_set_defaults() calls for Rockchip
> drivers. These clk_set_defaults() calls likely originates from vendor
> U-Boot where driver model core calls to clk_set_defaults() was removed
> and moved to just a few drivers with claims to improve boot speed.
> 
> After these changes any CRU assigned clocks is typically still applied
> two times, once for the clock driver and once more for the reset driver.
> A separate series to introduce a driver flag to skip clk_set_defaults()
> is planned to address the unnecessary apply of assigned clocks for the
> reset-uclass driver bound to the same DT node.
> 
> Changes in v2:
> - Drop already applied patch
> - Remove the unnecessary ret variable for rk3576 and rk3588
> 
> Jonas Karlman (7):
>    clk: rockchip: rk3506: Remove unnecessary clk_set_defaults() call
>    clk: rockchip: rk3528: Remove unnecessary clk_set_defaults() call
>    clk: rockchip: rk3568: Remove unnecessary clk_set_defaults() call
>    clk: rockchip: rk3576: Remove unnecessary clk_set_defaults() call
>    clk: rockchip: rk3588: Remove unnecessary clk_set_defaults() call
>    clk: rockchip: rv1126: Remove unnecessary clk_set_defaults() call
>    clk: rockchip: rk3308: Remove unnecessary clk_set_defaults() call
> 
>   arch/arm/include/asm/arch-rockchip/cru_rk3528.h |  1 -
>   arch/arm/include/asm/arch-rockchip/cru_rk3568.h |  1 -
>   arch/arm/include/asm/arch-rockchip/cru_rk3576.h |  1 -
>   arch/arm/include/asm/arch-rockchip/cru_rk3588.h |  1 -
>   arch/arm/include/asm/arch-rockchip/cru_rv1126.h |  1 -
>   drivers/clk/rockchip/clk_rk3308.c               |  9 +--------
>   drivers/clk/rockchip/clk_rk3506.c               |  6 ------
>   drivers/clk/rockchip/clk_rk3528.c               | 16 +---------------
>   drivers/clk/rockchip/clk_rk3568.c               |  9 ---------
>   drivers/clk/rockchip/clk_rk3576.c               | 14 ++------------
>   drivers/clk/rockchip/clk_rk3588.c               | 14 ++------------
>   drivers/clk/rockchip/clk_rv1126.c               |  9 ---------
>   12 files changed, 6 insertions(+), 76 deletions(-)
> 

Applied to 
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip 
(u-boot-rockchip-2027.04), thanks!

[1/7] clk: rockchip: rk3506: Remove unnecessary clk_set_defaults() call
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/21436b1462b5a615e60341a63ca830e60f63085f
[2/7] clk: rockchip: rk3528: Remove unnecessary clk_set_defaults() call
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/bd4eaa65cb2ad056e50a754c373f5985d64a25fb
[3/7] clk: rockchip: rk3568: Remove unnecessary clk_set_defaults() call
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/3345938ebde344c80bcd7b7140c80da26988ef26
[4/7] clk: rockchip: rk3576: Remove unnecessary clk_set_defaults() call
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/27cd730515fa9d22f11b5b405ea36d17791f5c9b
[5/7] clk: rockchip: rk3588: Remove unnecessary clk_set_defaults() call
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/9889115600ed2e1cda978c35ad0e1ac9625d264e
[6/7] clk: rockchip: rv1126: Remove unnecessary clk_set_defaults() call
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/ec120d98e34618cbbe003ac04067f8f01ad15b77
[7/7] clk: rockchip: rk3308: Remove unnecessary clk_set_defaults() call
  
https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/c327ff2de0b0276f43834ba36cadf64492527048

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>
