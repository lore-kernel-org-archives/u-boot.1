Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECD6C88E5C
	for <u-boot@archiver.kernel.org>; Wed, 16 Sep 2026 12:40:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B258D6080F;
	Wed, 16 Sep 2026 12:40:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OSo4ZaYipuzE; Wed, 16 Sep 2026 12:40:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D212D607E9
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789562424;
	b=dDBrGPv0utCHyMrMgpzahwKd9wLeSWAiaAYJYZauL12/Q51r1oIWMjGSsKimv3mTr7M/
	 bbtNHUJyGBwhvaUPQ2Mck0JtyAyrbA5V+3ES6/Jyst4PRJA8rhJz1N3szy0X7tvNpDzgJ
	 Bdyth5Ld2fWDZwKNv7l77J7waWBq22VrE3XN6XfLpb7utWVMpbhNa3PNMsrHdY/cGcaU3
	 vd4oXpxqc7A1/nKOjikU3F2f0XFUa9Y7oMxE01yCDv2UnmUytip20c7UXwLkQExKqcN8g
	 wkKUmIqJ4ugjTjEYYPAtNT1NBsR1qmQV1HACiNQAIwLRQt24Jj9ThcrTpVxU4KF3ZYQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789562424;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=R4fsRr+ueXor2AjVl9iELi8NVvi7incjPtxYKZ1oal4=;
	b=CsraRLDxqKvw1GgUKwe41pGWredvb7UdAKaeDx2tMxPzTx2eCF/+mJUQMqSTqRlYR8g5
	 4ox6k5LHL68Opa0Q+UMgFAyeYR2KOmjqi8tCcX3UWdZbgn4VGMJj5VvAqYPKJcegxCv9G
	 Nhwd5bkRIEpNPb16sj1HgRME/qoJW1qrS2Q/KmBPkrINQ5LDFJzJYhZEoy1MnKSvH/Puc
	 4exh1xiR8EPeL6nWVbxmSKK4oI+vzh+pN/z/jNqQRsgMlAbHZhggOG3NVFnDTNzIhGOUI
	 fo+NMqOYiXI3Yv7y8WP8PIo2v6iYtlatOSJOFBzHqOv39MAeVp5pp3WFl34DniLqPBA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zt3qOGr3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789562423;
	bh=R4fsRr+ueXor2AjVl9iELi8NVvi7incjPtxYKZ1oal4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LCubKqzjh5mQK+pi25Arcpbl1fkFj8FNyx0df3+jqfBhUUhmV0dLWGGbMrUSrm/qA
	 OMRFILbn9/M3cIadOMO4BntPW6XTBkAjYrCjrBw5X0pjf3vtwMhDriEaYBq4Ne+2Fa
	 qQJcf/BVjynyIn6XVEHHbSdKnAbfh0MU1COl/etdE/PrOGhMUhu+C03DvqZZE4i27a
	 qrwC+aqJV4XmXiqQw0Z8sGlEoTYqIQ+2V2UJflGqpfD6wdxt/iCrngbpVxVWT4xJ7Y
	 oZIlKzoMZgx/QWQ3JcaN04WAeXIgx9JSYWaUHsD3MYiBqysYsQsnvrEZgK4kRxuuUf
	 kgKUlrv84VxEg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D212D607E9;
	Wed, 16 Sep 2026 12:40:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CA61E352
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BC0C9607E9
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xPuDwdJpb5hD for <u-boot@lists.u-boot-project.org>;
 Wed, 16 Sep 2026 12:40:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E9BBA607D2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789562422;
 b=FWCg6u5FgBj/cz+nvEUdCQi3Zd4nShVEcF8zj21CivowigaTPCrccsmW9f2E4lWR5h1o
 wq8u6K2p6ynTF4lmhCKC1B+Ue2x/8gBd0Eio6DcceqLbdP18PogojRSiFILne2tYLTjQh
 I8OucP8M/YMXfjgYwsac0wJuQk55Mq+ThssKPOC9GUnlbJxDu6PXZY5gftqKestW2iThM
 PPuDT86XlHmMogZP0dp4MHsI2XgitdwGezPnFvzAQQjEkoWwqFGf4qRcw2uN/j11Iyx1Q
 cYros3fyIbW8FPii6Owvx5GWUGDyjn4JkXslhuyiWsblczMwDfdURkDBQzCHawaHLbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789562422;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=R4fsRr+ueXor2AjVl9iELi8NVvi7incjPtxYKZ1oal4=;
 b=RyoyWg8NTD06U1ljY/lka1x2JODgdIoAzhC0MRSirljlntBc0sxIu7yt5SXtId9vQ7aJ
 J4r58nRvxRt3XMFkS/ideD2Axjejhsq9aKBPCYaPUzqXujIDBSPGw1Gx9H7NRplahQEdd
 kZftc0eJPWQ/tiHJUrM6japjhm9AshiJVOesgqDeLmVDISuMECAGuxcq2QjQqm/0dG+ac
 /dpnq5G3HPt0H4hDjv+7DdZR++2tFa3urhBxSErXyi+exFmW+7K36Pw27E2mY7qXj478Z
 qYqc8XJkTPp2d2G2RZBPrHQa5TDCBLqcISYQTRNqoRkRnoB2CPCndqgG7p7NRSOSgFQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Zt3qOGr3; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Zt3qOGr3
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E9BBA607D2
 for <u-boot@lists.u-boot-project.org>; Wed, 16 Sep 2026 12:40:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A23366053C;
 Wed, 16 Sep 2026 12:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD62D1F000FF;
 Wed, 16 Sep 2026 12:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789562419;
 bh=R4fsRr+ueXor2AjVl9iELi8NVvi7incjPtxYKZ1oal4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Zt3qOGr3t1FmZiidqQkxpIfaLmHdrMaHsWGI98gTCQOGD2PCzJ9pK2sI9zwg6/7Zm
 +4HBQOQ0YIlPJwDiErQW2x0xoJXhTBiTtm8HY02ETMbnhMHFydJ2s3Ja8FFoFEEtdM
 CZoK1voAxOpKGgNjI2FFrBxygKIrZDTZvImC4ozx3ppfzDHuH2AD4l8sZc5aBnymew
 nilAfEm+I1L7giet4n4StaFmbNy8k/tMZN0pFBx+tfW8pp5WWzEXX6CMUrJ8YdKdoo
 HDMa0rMzOlOwu5t9sh6QGU5bYA39p9m0pfvElbIKBS9oAU8pI0Im+8V3Td7LKEraSw
 HfZTZgTXrRq1w==
Date: Wed, 16 Sep 2026 12:40:16 +0000
From: Yixun Lan <dlan@kernel.org>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Eric Chung <eric.chung@riscstar.com>, Yao Zi <me@ziyao.cc>,
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Wei Fu <wefu@redhat.com>,
 Scott Bambrough <scott@riscstar.com>, Huan Zhou <pericycle.cc@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Anshul Dalal <anshuld@ti.com>, Siu Ming Tong <smtong@axiado.com>,
 Johan Jonker <jbx6244@gmail.com>
Subject: Re: [PATCH v13 2/7] mmc: k1: add sdhci platform driver
Message-ID: <20260916124016-GKA292047@kernel.org>
References: <20260912-m4-v13-0-71043b29630f@riscstar.com>
 <20260912-m4-v13-2-71043b29630f@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260912-m4-v13-2-71043b29630f@riscstar.com>
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

Hi Peng Fan, Jaehoon Chung,

On 20:36 Sat 12 Sep     , Eric Chung wrote:
> Add SDHCI platform driver support for SpacemiT K1 SoC. This driver
> implements the necessary platform-specific operations for the SDHCI
> controller, enabling MMC/SD card functionality on K1-based platforms.
> 
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> 
> ---
> v13:
> - Sync definition values from upstream mmc driver.
> v9:
> - Disable CMD18 (multiple-block read) for SD cards in SPL.
> v6:
> - Remove ".data = 0" in spacemit_sdhci_ids[].
> v5:
> - Remove MMC_CAP_CMD23 as the CMD23 support is now a separate series.
> - Use tabs for macro definition alignment.
> - Use read_poll_timeout().
> - Set pinctrl state based on selected timing mode.
> - Add the definition of SDHC_DLL_REG1_HS400_VAL.
> - Remove the condition based on quirks.
> v4:
> - Add bulk release operations on reset and clock.
> v3:
> - Enable CMD23 in capability.
> v2:
> - Enable ADMA mode support.
> - Use CMD23 for multi-block read/write.
> - Move ASR/AIB register into pinctrl driver.
> - Correct pinctrl state from "fast" to "uhs".
> - Migrate tuning support from the spacemit linux driver.
> ---
>  drivers/mmc/Kconfig          |   7 +
>  drivers/mmc/Makefile         |   1 +
>  drivers/mmc/spacemit_sdhci.c | 684 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 692 insertions(+)
> 

Ping mmc maintainer for this patch, would it be Ok if I take this patch via
spacemit's custodian tree [1], if yes, then I'd like to grant an Acked-by

Or, if you guys prefer to take it with mmc tree, then I could handle the rest..

Btw, FYI, I've already pushed for CI testing which looks good [2]

Thank you

Link: https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit.git [1]
Link: https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/pipelines/1284 [2] 

-- 
Yixun Lan (dlan)
