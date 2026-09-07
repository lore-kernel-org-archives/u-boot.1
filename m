Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B431C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 21:23:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 49E6140433;
	Mon,  7 Sep 2026 21:23:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nC9LfD9A9HFw; Mon,  7 Sep 2026 21:23:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7ADCC404E0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788816204;
	b=tYi1gaOIwYWt9VSi0TGn1Yt5Facw0GoegNoO4L616uCgOBP8h6O7Yw8rzlsScKbYOY+Y
	 Gm1KCnQhtP7KofNK3Yms1abBkL7kFRhRV5NGYi17YojxGVmnO3zLzFUi87OQKF2y4Bsm3
	 rUVOQfwKbT92VzhL0Y/YDBd262fxLQuJJ/gAUVElxHY4C27mChN5U41BYYkZ3hirGIFMw
	 ooUpte/j6kIL74kYK6WLY2UY8lYSp3r3BB7/J2qH3LrngNPpVl/0ge//8lX+d3hmMgh7X
	 bwWdJX6icNvINE+PR2BqygMe+IcN5CLVeMkzV4/zeWgmSo1NnpcsAvsPSb0U6tjHuZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788816204;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
	 Message-Id:From:To:Cc:In-Reply-To:Subject:References:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IvVnuFeUbloygyYn25mc+9Gp/L3QtXZRWFkaJAOj734=;
	b=WO18qqTkilU0zWAaZ42Wruw7aCLFGHl+5ZtWLqDeYxhrP3o5ZQc4zSAmvob5mUgeYQ7u
	 mNmFb0G6hjNg9QhgsmYXK7WKICiHrRrdsktP4DHCxdmEQSfwWh12ZRqjXSfOg7mrA6GY6
	 ntvhIHlzJvulXediT3M/CeisXHrKVpg+s9EBBlxZDU99n5ERx2t9gDGUwCUX1Ygnf3yYP
	 fQGY4vXP3MvY/fq2k8oBxC+hLjbyBOFothvE/j7DnFQ6SZv9STUbLeDenAoXjU6fRKkxU
	 LcxN/gusNn5A5xcoZH7sdxUACqr0p86yU0PFkVWVU2mtKTPmee7pD4HNTHV/gBWO0Ag==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=xs4all.nl;
	dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=RsVMNezK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788816204;
	bh=IvVnuFeUbloygyYn25mc+9Gp/L3QtXZRWFkaJAOj734=;
	h=Date:From:To:Cc:In-Reply-To:Subject:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QA7O+04E6DU1aBXL1+/fsNByJGwUJ2E+OnZddz2qskISlGLqO+m18+SQhjnqKikVU
	 kytAHAVz8+EqNMmBG5seDZvm7p+R0LBUQDgAuDe9i4Hj9mFr38K+ArYGOWWbJKca+j
	 p+bEsiRogQJMMuUdkiYksSytF5uUt9cMMFNNgadg2rXz3jz19nRTho74cNW4VLbWLA
	 iGRCFAVM7dkAGTOtW03TZ/TEZXL07i6GHgV77Z4VMyHtgBHtMASYdOUaApjD0YGkaY
	 22XCGIaXSJ3dp5EUdvCBOBCDls28cDX/CiojMcgH77C5+FYm5TkuLEAqNv+go3iKV/
	 58l+J9g7INoiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7ADCC404E0;
	Mon,  7 Sep 2026 21:23:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9212D230
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 21:23:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7686E40433
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 21:23:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mapl5qudNeN3 for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 21:23:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AD4E1404E0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=195.121.94.167
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788816201;
 b=Ni+mrkenqU4kTm0qOb5Dnwk1T+U4gNrbQwAq0mEG3e46n9z1Hz2bbxrhou8DsHqUsceU
 voNQWkpq2knIas0sU2c8r3O4za3N4QRsvJaUxcdN194YSC2+7/q9XFAxsrwAzJWt3hLIK
 vcRVeS/kR675dAwQt2imNMKuO1lH30/Tjd4Loo7i7FYiCpt6Ee+mcatf0x8KE4Lk4KyEd
 c+XUbhlv/nrWC5r937EixFiEovR/KOQGRACuIahlhk9ZV4VnwEupA8RtjKp9UmK+X8EZH
 4Jty182Zlrb7miERFAYTqQ9CpOH7d5Q7AVdrHVb8kQtIOoKGZImaKlwPfcVztALLp2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788816201;
 h=Received-SPF:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
 Message-Id:From:To:Cc:In-Reply-To:Subject:References;
 bh=IvVnuFeUbloygyYn25mc+9Gp/L3QtXZRWFkaJAOj734=;
 b=hNGiu+BmOFIzbEAvthscy2ef4/t8xZGhjbIGuhjEZGCnbMzJlsK9At86qFtP3WVYoPO4
 rPf4QL626D8xS5HwWd/lcBZzTM4QhazidgLXGJbs6JaNtTxiT49mFF2ynHbKYboG5D62Q
 XxsLQuduiPN7Jf7zLdL3BTMUKyHw6W6Oj5lwzBDN6o7zZ3y2K/bCzawreA0/P3PEL0urZ
 1kxlgHSu9CvmDBLnkMIl3uhUczOVvDIo6SPlB42tZge1ecTi2XdlT/4zJUTs6KqSOa/YJ
 BUsYLewTL6UKDPo0XPRYbPcmREaqaLLbY1GLSozJ5h6sYCYJPNxgUzAlRLzZEQDaasA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=xs4all.nl; 
 dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=RsVMNezK; 
 arc=none smtp.remote-ip=195.121.94.167
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.121.94.167;
 helo=ewsoutbound.kpnmail.nl; envelope-from=mark.kettenis@xs4all.nl;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl
 header.a=rsa-sha256 header.s=xs4all01 header.b=RsVMNezK
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AD4E1404E0
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 21:23:21 +0000 (UTC)
X-KPN-MessageId: 56dc52ea-ab02-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 56dc52ea-ab02-11f1-b2a8-005056abbe64;
 Mon, 07 Sep 2026 23:23:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=IvVnuFeUbloygyYn25mc+9Gp/L3QtXZRWFkaJAOj734=;
 b=RsVMNezK9AXQMP0JV8alZqyfH5Lj0G5SrkPqxqcYsXzLhChDm12tk4HKFTeBt6pMhRN2frfPldUaN
 dk4RLJXYr8HlYExQlZhlM46g9EJ4utIiSiD5yacHwL6QDm3kYMRK9UpheStHoMpuol4Y3yViXa3wQG
 hEHYMIjFl7k5cbqrUVBlBy//mMhQx1jstQoGQ8+s2qAuUzodiGLqK/7rOKWrrL3a+brjVawigsXAi7
 r7wncQm9OFpk1OUJLWgsxg5S+SQDzV2aa5UZxdQtiCIs3IcbpnmP9r+UXDTpvZUIg9Zk2nDxUiOAhu
 s+x80tScQcjRLPd5BOlig54ypUPapEA==
X-KPN-MID: 33|MTWnIGqkllysgsfqHDR98i492UoaM4/A9cguGGH0YWEncjA5h//DzB91+IpzSde
 YeNp9NGsCroSmRCtRmqia7iV98bDyvkQqKgqP7If3f8c=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|HYbRrgTuKesxlP8v4FocLVQ44hkeQvDqXDyPINzYl4Zy93JwNi0EtPVtVNZ8Tem
 D6B2SWnz1jgAX7LOL+43ncg==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 5650de84-ab02-11f1-86b8-005056ab7584;
 Mon, 07 Sep 2026 23:23:15 +0200 (CEST)
Date: Mon, 07 Sep 2026 23:23:15 +0200
Message-Id: <87qzj4sqm4.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.u-boot-project.org, asahi@lists.linux.dev,
 kettenis@openbsd.org, sven@kernel.org,
 neil.armstrong@linaro.org, bmeng.cn@gmail.com,
 trini@konsulko.com, fberder@outlook.fr, j@jannau.net
In-Reply-To: <20260904-apple-nvme-fwabi-v1-3-f7ede661c469@jannau.net> (message
 from Janne Grunau on Fri, 04 Sep 2026 21:22:41 +0200)
Subject: Re: [PATCH 3/4] nvme: apple: Add WARN_ON_ONCE for non page-aligned
 admin queue buffers
References: <20260904-apple-nvme-fwabi-v1-0-f7ede661c469@jannau.net>
 <20260904-apple-nvme-fwabi-v1-3-f7ede661c469@jannau.net>
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

> From: Janne Grunau <j@jannau.net>
> Date: Fri, 04 Sep 2026 21:22:41 +0200
> 
> Apple controllers seem to require any queue buffers on the admin queue
> to be aligned to the NVMe controller page size. Weirdly, this constraint
> does not apply to the i/o queue where any alignment is fine. This has
> always been required on pre-M1 controllers and is required starting with
> macOS 15 firmware or post-M4 controllers again. On M1/M2/M3 there was a
> chicken bit to disable this requirement.
> 
> U-boot appears to always use page-aligned buffers for the admin queue.
> Add WARN_ON_ONCE to make it very obvious if/when that changes or wasn't
> true to begin with.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

Probably a good idea.  We aren't really size constrained.

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>

> ---
>  drivers/nvme/nvme_apple.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvme/nvme_apple.c b/drivers/nvme/nvme_apple.c
> index f615f8fac4a..54821f80c81 100644
> --- a/drivers/nvme/nvme_apple.c
> +++ b/drivers/nvme/nvme_apple.c
> @@ -12,6 +12,7 @@
>  #include <asm/io.h>
>  #include <asm/arch/rtkit.h>
>  #include <asm/arch/sart.h>
> +#include <linux/bug.h>
>  #include <linux/iopoll.h>
>  #include <linux/sizes.h>
>  
> @@ -116,9 +117,15 @@ static void apple_nvme_submit_cmd(struct nvme_queue *nvmeq,
>  {
>  	struct apple_nvme_priv *priv =
>  		container_of(nvmeq->dev, struct apple_nvme_priv, ndev);
> +	u32 page_size = nvmeq->dev->page_size;
>  	struct ans_nvmmu_tcb *tcb;
>  	u16 tail = nvmeq->sq_tail;
>  
> +	if (nvmeq->qid == NVME_ADMIN_Q) {
> +		WARN_ON_ONCE(!IS_ALIGNED(cmd->common.prp1, page_size));
> +		WARN_ON_ONCE(!IS_ALIGNED(cmd->common.prp2, page_size));
> +	}
> +
>  	tcb = ((void *)priv->tcbs[nvmeq->qid]) + tail * ANS_NVMMU_TCB_PITCH;
>  	memset(tcb, 0, sizeof(*tcb));
>  	tcb->opcode = 0;
> 
> -- 
> 2.55.0
> 
> 
