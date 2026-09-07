Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62253C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 21:21:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CC0B40527;
	Mon,  7 Sep 2026 21:21:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z-S3YWAfQx_b; Mon,  7 Sep 2026 21:21:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A0C61404F5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788816092;
	b=Iu75jivQGUJ0oWjnFNt0hk5b22WcHQVrCyIVKQJ9KchDwo3YTfuJYLxML+ARmyfC77CI
	 vAE3uBdJq3ZMS9jSaTRi8k8K56gKKZSEi0ZTtcYytDhW7frKhRZ45Z05RpcSRqjErn+wP
	 wcf2FP+n0js7It9KAESsdjkBh4t5QetUdrDO8LAyXxFGvTuDPQ1So5hIFt9bnaSWe8cY7
	 zOzigYVWO70JQea6w5xkSVsBkRuw3fSXRJdqrK/k7s5F3ju7PDeAvBLc/Rf7MWpC+UPEa
	 bA8+zFOoghxk85hwkQOf7fbbXWAglsTbwEjPjPIUl3+tWeQL6nX3q6WJHdbXp45NC+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788816092;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
	 Message-Id:From:To:Cc:In-Reply-To:Subject:References:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2o5aeHoEjCl49m1sQVkDoagFkvdONDs59op9HEuFjOM=;
	b=drSCm94/pKeDdjKWD+6B/Qb8jTAklQAsYfnRgK4TjwraAnW0eM7KI8qnpYdcOqk1JHCv
	 Jbd1D/WE/cXLLnRW6ecIEMP8vZ9i6SOAUzYYad/Kq15n9xyWhvc5Cz7rVweRomnFoGqwR
	 +QNGsH4o5n+RdSdJGxTfS2uEcbSvFVlJwnThEu9J7LAqCFFl6jUnDAfRYDVlWRZ2vL4K7
	 AcLvgnIJ0v42S2JJbhvt+sT5I5Sk6/4us+yPdVqllymMh1j4TkLzcYhzmecpyRqS3DAxk
	 8+YPGk+kAknwEct9a9779DDR5yvt9Gh8ZAoEyl1SVSMm4cfdOosrcsw3Cu/k3+/objw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=xs4all.nl;
	dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=KIFc078c;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788816092;
	bh=2o5aeHoEjCl49m1sQVkDoagFkvdONDs59op9HEuFjOM=;
	h=Date:From:To:Cc:In-Reply-To:Subject:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e/2DVv6q66pLQnVqvwN9QRkXWJ+aT2pofS1vUvRuEtFOPfIvwrCE6Hg3jaDiVr8UM
	 pTHhkNPm8zdm5rb/blStCtCttAfIgWCpwaSPMQMCcvOCgDYPWupN6VGHEc7YQ1mFC6
	 ylTnY36AoTQl+cV44JD9AzbIRrxZ2wenx6Gj2aFxIQbPUvR2BT3073748Gtn4Gxn4q
	 kKgaFgAbcYxdTEPnsP8fyQl6WdUzUteQTc3zpQ33GGzgwrpp4/tB1TkOrO/iaH4oIO
	 lF6Nig8G0quyZAWUeMyhXF/94U/NskoCk5ysvaTrSxo6Qzwk8J6PggdClv5pR6XVnK
	 4Emf4BF6k7YlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A0C61404F5;
	Mon,  7 Sep 2026 21:21:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 15DC249D
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 21:21:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 07A0B404F5
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 21:21:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KzjZnxSi7QmJ for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 21:21:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9B351404F2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=195.121.94.168
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788816088;
 b=ZnFnS9FlAykXLETQvgsk5toaoOkSF7CANUMecu/Sxq+vuN+5oYkaEOtiSqdCHA1TJXTl
 Rng+Q4p4d1hUH03zWIZ7AXy0Pnii82t2+KG+KFjLiFNFkJs1K4+IQmyeDM5byvXk5VGj6
 OEv7PGdvLsl2z+vXlb4s6KFU0ro/bo3cTu6P7c4EhR0IxCB3GAwoenoGKJvJgosG1CYd4
 6E6YcUyRevBTDetfgeneumGEUNDtcDCj7Bq1D4WhwIiAYTUQZRGvq+79WMtbvwwGe9xsN
 e1H9EqMYEiXOdjJbzXAlGZL/5HNuo3DbxiNRhHH1hNHKs891npwUApPHNNF3REJGxlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788816088;
 h=Received-SPF:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
 Message-Id:From:To:Cc:In-Reply-To:Subject:References;
 bh=2o5aeHoEjCl49m1sQVkDoagFkvdONDs59op9HEuFjOM=;
 b=msOhKXPxG3/Qp3GhrCrL5k8IwcqWscngtr7i8GuOSwJVluFXyoQTr2PuWonOFPscjrt9
 blBVyPol/qiW0IzB05FvX3+g/DPhRBmdlBN0ekhpaoTPl1EVuYXbu2kIGo0/V8zf8SLjb
 SVEYcG1Ro2hgDejaAwB5NI9hqvaEnXaVOww4w1VBs51rX/pOYszE2F9ywCVX/ejZhPy1n
 mpYS1rAzniUx6Kw+lYz3Ijqghd7Va8m/pwwJ5QRZhZPX7f6yg6ysV36C2iVqM+OSnZgHc
 CSmkwZ4UjNHxOVsfKN4bQeYxFnYkCrFxkt5VihHISnlTWd37v3CTdae07kwV3ixJoBw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=xs4all.nl; 
 dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=KIFc078c; 
 arc=none smtp.remote-ip=195.121.94.168
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.121.94.168;
 helo=ewsoutbound.kpnmail.nl; envelope-from=mark.kettenis@xs4all.nl;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=KIFc078c
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9B351404F2
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 21:21:26 +0000 (UTC)
X-KPN-MessageId: 11ac83b9-ab02-11f1-861e-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 11ac83b9-ab02-11f1-861e-005056aba152;
 Mon, 07 Sep 2026 23:21:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=2o5aeHoEjCl49m1sQVkDoagFkvdONDs59op9HEuFjOM=;
 b=KIFc078c2VpLo1SYB5ONbrod09Cuf5gie5FGVy/IBi8Gh4y+aJasJRyuEIM8h9bim9Rye1nGeUFQH
 VkLgwMZvIBhtMtnNHDzgRb2Ij2PV0A2HsIEZNNraTVZG0X7co2vVLfQOJmXOfScwq5C/K/+P9+AA8b
 lof5mAZ+yQdUXR0jDm7nayiPoGYvUheI0N1Lihmy94JS6JdN3oLfhbqz7V0bVIrvbxDhPxysp71YUS
 ETgS99tboB1rXHDQS+YuVQEM8kLDKXAh5hKF86bYnHIwsmNdrOLqm15ycdjsAqqVhfNGqR6zTMGVkz
 ESUNVssknbCoiwEbElDjoPeeRTnFWmw==
X-KPN-MID: 33|zF1CdztyatBJyIyjTqwNl/8pF3eKfHEQdrI3c32ZooJgH8L45DCyXTr4N3Ynnkr
 +KxLVWkdhvQnCJBm0eKPE0690M/T0ZM172Vnfd9NSyAo=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|ceihSx4KgAFGIlPZ9yRJaSS9mhGIGjyu/0dqffsn2Jd8YUIwCVc8sKY8PqvULEr
 jkYDtcQw4VwcM23sI6R/KqQ==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 11298ff7-ab02-11f1-bd29-005056abf0db;
 Mon, 07 Sep 2026 23:21:19 +0200 (CEST)
Date: Mon, 07 Sep 2026 23:21:19 +0200
Message-Id: <87tso0sqpc.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.u-boot-project.org, asahi@lists.linux.dev,
 kettenis@openbsd.org, sven@kernel.org,
 neil.armstrong@linaro.org, bmeng.cn@gmail.com,
 trini@konsulko.com, fberder@outlook.fr, j@jannau.net
In-Reply-To: <20260904-apple-nvme-fwabi-v1-1-f7ede661c469@jannau.net> (message
 from Janne Grunau on Fri, 04 Sep 2026 21:22:39 +0200)
Subject: Re: [PATCH 1/4] nvme: apple: Don't set a DMA direction for commands
 without a data transfer
References: <20260904-apple-nvme-fwabi-v1-0-f7ede661c469@jannau.net>
 <20260904-apple-nvme-fwabi-v1-1-f7ede661c469@jannau.net>
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
> Date: Fri, 04 Sep 2026 21:22:39 +0200
> 
> Setting the DMA direction for commands that don't do any transfer likely
> triggered the PRP NULL check for which we needed a chicken bit. That bit
> has disappeared starting with macOS 15 so let's just do this correctly
> instead.
> 
> Based on Linux kernel commit 94dd5804938d ("nvme-apple: Don't set a DMA
> direction for commands without a data transfer").

It is probably best to keep this aligned with Linux.  However, on
OpenBSD I set the bits based on the low two bits of the opcode.  Like:

        if (cmd->common.opcode & nvme_cmd_write)
                tcb->flags |= ANS_NVMMU_TCB_READ;
	if (cmd->common.opcode & nvme_cmd_read)
	        tcb->flags |= ANS_NVMMU_TCB_WRITE;

(the directions are reversed as the commands are memory -> device
whereas the NVMMU bits are device -> memory).

The NVMe commands are documented like this.  I believe, there aren't
actually any commands that do both a read and a write.  But this would
do the right thing if they ever show up.

Anyway:

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>


> Link: https://lore.kernel.org/asahi/20260806-b4-nvme-fwabi-v1-2-bde19ce8db04@kernel.org/
> Fixes: 50333c94f2de ("nvme: apple: Add driver for Apple NVMe storage controller")
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  drivers/nvme/nvme_apple.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/nvme_apple.c b/drivers/nvme/nvme_apple.c
> index e674eda8344..dc94988e2ff 100644
> --- a/drivers/nvme/nvme_apple.c
> +++ b/drivers/nvme/nvme_apple.c
> @@ -122,7 +122,10 @@ static void apple_nvme_submit_cmd(struct nvme_queue *nvmeq,
>  	tcb = ((void *)priv->tcbs[nvmeq->qid]) + tail * ANS_NVMMU_TCB_PITCH;
>  	memset(tcb, 0, sizeof(*tcb));
>  	tcb->opcode = cmd->common.opcode;
> -	tcb->flags = ANS_NVMMU_TCB_WRITE | ANS_NVMMU_TCB_READ;
> +	if (cmd->common.prp1)
> +		tcb->flags = ANS_NVMMU_TCB_WRITE | ANS_NVMMU_TCB_READ;
> +	else
> +		tcb->flags = 0;
>  	tcb->slot = tail;
>  	tcb->prpl_len = cmd->rw.length;
>  	tcb->prp1 = cmd->common.prp1;
> 
> -- 
> 2.55.0
> 
> 
