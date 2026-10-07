Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40124CA6009
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 22:16:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F3D6140596;
	Wed,  7 Oct 2026 22:16:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dul89v8v4euX; Wed,  7 Oct 2026 22:16:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4DAD240549
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791411405;
	b=g9rquCduwTijku+8gxj1SCJNPJvgQZIyaMlB/07attQzCW/SYNaMyMtuGndeTlXoXjtj
	 ISVr/fTD44fcn6mm+/0ufa/wKgI8b1koODxqlln1eifKXm2Fn3v3yNFXl+yTHPVvYhneI
	 bS2gUgGjsO7alr/8rKpCIea3yPbT3YELqmo8vlPW/UXrF9MRAABb15l4HsTJsOXaxtw1h
	 B0U0qSlAh/PgXP9b5qdLdu+hJggNmMQYIW8M91iseAOobNzJ7UkOYkM1NINvudSJgTgYJ
	 /2oa0mIrKPmVUBQUbNZ3tLvOSppbh0t0P96XprqfVQoeOVrQ9gifCr6V3SgMl5NEGOw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791411405;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=q5n8lIx8thMvOs0MOXNWATHSSjk14+JjSRX4Vorvlw4=;
	b=d70m4+RABK6Yyu43RchseYj9E8AE7Hr5N7sUllCU2RKLHSlC/WbSehkKqGPjLDS2f6Tr
	 Jn0nfnTh5mMeG9RHu1YpTtMkB9vnoSl7tTmyO3YR1/dVtXe7javWJpZmxLs5nWIhWz3u2
	 HsRUe+y1Les1rsEDCwQDGyG3XD+pmHbPW3QcUg9kF+V/OUIewx/9OS2MeDtMPaQ4we39s
	 0TTwpSNYsDJuDJjmwvOG7yP99A9Z6SNp4PdzfEJvkTA2ywiyA59vem9/nmKIELnPdljCf
	 5TpVDoOXyWCFQ8Rdg3FsfoG0jMZP4in/sz7uk/2gxxTY2qCQE39EeRMU9u4w6GmER/A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=D0CiX9ky;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791411405;
	bh=q5n8lIx8thMvOs0MOXNWATHSSjk14+JjSRX4Vorvlw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wNYTRFn3YCl7YFTypnnJieO2HhfHaXHOrYKCWlsJCyOetNg9hkUY1EDaSXNnWRvyR
	 vELG6p0KUrlz/AIIuTOMp7TI56Rxyk6jcCA/zzldAVWeHTNzoY188/S/f9Oxf67mq2
	 bL5ExZ/R5VYi/+DteySoAFgcKpkLbvP3Ko0KrI6N6QbBMnZApI1Ki0HQ+a8sFfaj3R
	 JyGD5+9FIxj5Jk4Je8QKfLbzHqexemRJisEv4zoTcznmBj4xuEGq+jUV2musSKqaOW
	 fFGTBsAeQun43Rl67bluwGEdlDMLI33qoCQLXpW8FQd/vkwRY+n2ozHMZnQ0iKw2K7
	 r8kd1npb4/OkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DAD240549;
	Wed,  7 Oct 2026 22:16:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B29B22B
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 21:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 516DC40786
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 21:28:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 11tMT7F-CzPi for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 21:28:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4ED5940794
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791408480;
 b=Xr/DfEOxq0TUnE9WsyINj7NNdow/3iq9ImHm0b54PwA7KKqSNoPu0Cq1GnA/Opq2B7kA
 7S3bq4tEvXvwsstrZi/NtxYlGgMp9b7Z4RTjOJCvbrj+s+bvJ6PEbiVJ3QYV7RPbqHPVS
 i7V/CrHVEg7MDyxu6lh3lfbhtyl9Fcl1GymoIjAOKXxiAxq0zKuz3WgJqdFAIdHCvd304
 m/bkB5kB0Ka1Ug16HvOol93b56DjFNG8OYXTP1CV/okRDM430e3dFbBV8qX/M7lYco2Yn
 pwpIFKGNGARAb8Ua+n/ZTgUsMhvRmROAsKiOR8Af2DNHtWLgv4AcV42lJBSFNnRg6qQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791408480;
 h=Received-SPF:DKIM-Signature:Received:Date:From:To:Cc:Subject:
 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
 In-Reply-To:X-Zoho-Virus-Status:X-Zoho-AV-Stamp:X-ZohoMailClient;
 bh=q5n8lIx8thMvOs0MOXNWATHSSjk14+JjSRX4Vorvlw4=;
 b=PE+bJFLzd4LNCAO1DN1KVuB5DXvE/C63tCwOjR4DgKRB9Bc+gObRdnaPSx/nUXo8TxkB
 37Dyie5SnwLRnQdbWHZg6cB7ra9JK6wRP66R3dxtma56bNCdo4BwJcZ1NtbnVm20ZycUl
 66iuy+s9upiiRB0CWtDNjfg6vwnXgtEj8K7WGGzx5BeTiN7tVtgKYlkTtrYmAu6X6gIpf
 Dr3inm1awj+XDGZN63qzzV0ci+Ql7Wa9m1AorGOdYsXk8YPIZJKJdfpNEsGBaXLV6y1r7
 XfVCK7lIQAiOWsq1Bjx6U4G8no6YwM2Wh/kA9Ak1+8XpB/jv7nnfus+G58FY9jo0nrA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=D0CiX9ky; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.182.15;
 helo=sender5-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=D0CiX9ky
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com
 [165.173.182.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4ED5940794
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 21:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791408465; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fUiBXejEN3Rqtg6UVyko9oCiet6byNo8Tz6ZEbfoJG0NwIPQoOT9c668fRhk1+9SV5T+W6itTNjcMLxtMqHxerZdpHgc2Y3uaO8IFGbottg1/URvGhvyv+NR/PHkMEhPH9zotCHABgdlWEfU5/xJtWQh06Hvt76wMIPCHgheR6M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791408465;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=q5n8lIx8thMvOs0MOXNWATHSSjk14+JjSRX4Vorvlw4=; 
 b=b51O+FVpRJIsUMtLU2uP6aAJd7nCBlgac3PmMRdkLrQt3EDnLnXkhx7DNhOAb1p1YehaErJTh+KBJ7kpdHxCxg2OkPW9zoyHpLEcH1pSuBj44xXdvgscE05Tf5yOyB/l11ZwobvwTjef7I8BDM3mBkvFqgroTQm3yadlP5ohOjI=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791408465; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=q5n8lIx8thMvOs0MOXNWATHSSjk14+JjSRX4Vorvlw4=;
 b=D0CiX9kymaZfOD/4rogkgr+2C6XLeyosNHV8BXfB4TdP5Uwfd43UqEWlTpp8eejF
 euhiErzjVLXxQIRImHLXSLGvA+ERRNnTylxRaFuTOujj5+pvIkww/9WQFzNG2ATT8mk
 QxJ/nREuRdJ25bt1WESxnY2mbkpN/IeNpyQ/G0Qs=
Received: by smtp.zohomail.com with SMTPS id 179140846423676.0880176438153;
 Wed, 7 Oct 2026 14:27:44 -0700 (PDT)
Date: Wed, 7 Oct 2026 21:27:38 +0000
From: Yao Zi <me@ziyao.cc>
To: Hiago De Franco <hfranco@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: Kongyang Liu <seashell11234455@gmail.com>,
 Tom Rini <trini@konsulko.com>, Yao Zi <me@ziyao.cc>,
 Zhuxu Ran <zhuxu_ran@zohomail.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>
Subject: Re: [PATCH 0/3] board: sophgo: milkv_duo: enable standard boot
Message-ID: <asa5Ska2hH6cG2cC@pie>
References: <20260929-milkv-duo-bootstd-v1-0-1b75c9ad6483@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929-milkv-duo-bootstd-v1-0-1b75c9ad6483@baylibre.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/291.389.60
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Tue, Sep 29, 2026 at 07:20:30PM -0300, Hiago De Franco wrote:
> The Milk-V Duo (CV1800B, 64MB) does not enable CONFIG_BOOTSTD_DEFAULTS
> and has no environment file, so U-Boot has no bootcmd and none of the
> kernel_addr_r, fdt_addr_r, ramdisk_addr_r, ... variables required by
> the extlinux bootmeth.
> 
> Enable CONFIG_BOOTSTD_DEFAULTS and add a milkv_duo.env with a memory
> layout that fits into the 64MB of DRAM:
> 
>   0x80200000  kernel_addr_r       (16MB)
>   0x81200000  kernel_comp_addr_r  (16MB, Image.gz decompression)
>   0x82200000  fdt_addr_r
>   0x82300000  scriptaddr
>   0x82400000  pxefile_addr_r
>   0x82500000  ramdisk_addr_r
> 
> Also reduce CONFIG_STACK_SIZE to 1MB. LMB reserves CONFIG_STACK_SIZE
> below the relocated stack pointer, and the default 16MB left only about
> 1.4MB between ramdisk_addr_r and the reserved region. With 1MB, about
> 16MB are available for an initrd.
> 
> This series depends on Zhuxu Ran's "riscv: sophgo: Use upstream
> devicetrees for CV18xx boards" (v5), which sets CONFIG_DEFAULT_DEVICE_TREE
> to sophgo/<board>, so that fdtfile matches the Linux devicetree install
> path (sophgo/cv1800b-milkv-duo.dtb and sophgo/sg2002-milkv-duo256m.dtb).
> 
> Link: https://lore.kernel.org/all/20260927-milkv-duo-upstream-dts-v5-0-7f64983e59e1@zohomail.com/
> 
> Tested on Milk-V Duo, booting Linux through "bootflow scan" and an
> extlinux.conf on the SD card.
> 
> Signed-off-by: Hiago De Franco <hfranco@baylibre.com>

For the series,

Reviewed-by: Yao Zi <me@ziyao.cc>

Thanks,
Yao Zi
