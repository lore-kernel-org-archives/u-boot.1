Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778EBCC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 12:54:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13AE360643;
	Tue, 13 Oct 2026 12:54:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 59xs1-sg47UY; Tue, 13 Oct 2026 12:54:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 503C16060C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791896083;
	b=K/rWCEciO37Ifrv47HIXVfqhYHMc9a9WKPqYQSCU6nvNewdi4Ye3jf7ilqIMeEobRb6Z
	 GThFwBHSZrunwiIYuaFVhdBW3+OFTVwOP3LfmfCK26Y+2U05srt07s7I4zymDZ2TOo81E
	 dvqxLOfj61eGmLiH5ZgYwilI0dsPeM8wSe/VY2K+3DiIOBZmfbSdkIrhlhP1u3HAFlCpT
	 4KYotFt+bda1BBRqN8D5oXoHbkebKgtdfmurOElsqV6F/FVrj/d6kOXxgbjJjRfjjfnMZ
	 Wqx8RAWcq8B6nAILnswuZc0ooFQuFBckxuAUonnaBPjijaL4lXI6T8Dv98O4DFDhxZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791896083;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=OAsYhxlBM6SNnTE1gnpXm/LN2p5GO72iN0pkp4J2yZ8=;
	b=RPTXQn4nA8Hlik/JQGluZIhPG54PfuXMm9U4uL5GixtRLl5Nb0bBDyMfar4LARdtid69
	 wnU6ScZ0tIHwIVnE2NZLWPNY238TXJUz+0pcct+5Yfa0av6OvW4VjAJgYQK9bYWxTaO0s
	 aXyUu3R81LaCPw9+W2lozrxRscg1oitm7nInFoZCXkDW4hpFTlksw44H/DdmGV5zUiCXL
	 TkSKokTAk1fHN0Qe8r9YmhiEviwFu5496XS7Egg8TSLksifdOrlZBQXQrmUFj/rzWIm/2
	 zN7Px+I5MkUr8nvYQpJuRcvDjHVj88p98mwq95Kt6IpX+eM0bipz/xiJGoCRACiBCTw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791896083;
	bh=OAsYhxlBM6SNnTE1gnpXm/LN2p5GO72iN0pkp4J2yZ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wGWvCaHuWdOEz5zEGnQ2TrEHeF0YR0VMKcBvhWz//zajAJOAgeXC/XSktsHOfnUGc
	 zTo4tbLEf6dVkFpCQWtVBbe+AhDlbxf62z8gbHuU/2AYVPzde5VB+wr/QGjUXbgOJ9
	 fRcNtD0Jfbpf19aPYbZLIFgtaAbE7YzloJ68p0x3MQ7gFV5aWQ30hGO8RukmKmWR7i
	 gjcaDk07ChhREZevVM+6McPYrfoJk319rNKgOr9qSsLNy84OFLse/kLPhk0gikQFJU
	 oK0C28NSlHUAOWrXL0idlZdsswBV/yJUvOTUeqn/YZkDE4SNZCKBY7leVpJi/QKW4y
	 MEXJjTOsz2YgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 503C16060C;
	Tue, 13 Oct 2026 12:54:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4EA4B1DE
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:54:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4053B403F9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:54:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mduvo3mhdL18 for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 12:54:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 94B8740259
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791896081;
 b=Aww+PVhsoqsZFV8jyj+IPGkTHaurp/Zh65pT0LsX/JYkVv8H0pUFuXr2iXZunZZ9M0fi
 38cp4OBw3J9hIWynVzTZH+tk1gJ8x2jin+je6x9mSqpXqR+1vCD/se6i3ypk5MlwI1nvO
 SHHJyIv29FxxN4fa1tr5SA3q4I+rsjJpE7DEbp/k06lOrV0eSHDNInt+d/Wmw6pB+akRZ
 l6zzQ8UwXF3leSg34NxnLNX9tsXvMjvsJb8vFf91vnDk35ufE2ylI7HQqIMVSEHys+SDL
 5ZCXJQ5qUAjysK6ZQfCasyP3aJQGaE1safWaiF+T9vyj+htWTfnJr0NKX1z0dBK3Jhw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791896081;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=OAsYhxlBM6SNnTE1gnpXm/LN2p5GO72iN0pkp4J2yZ8=;
 b=i2RiNwvM1gbVU+XGy23utAcm8PMJykH9H83YebeQhCqiiUkHO6bvuy9rR0Tof5tzaXZJ
 /OxnZK7CNq/SsXF0Lj1txYyqak9c6Qi2RRczS5e3hDpGI9EAZJt1fN08qWzWntEzT55KK
 TLLI2zEK62wUz/zDoLmOgVl2PxrPzH0qwEgu8bpjNddCR0LzRLQwtbEE6ptS3bEDQdQ0+
 tb2Aqr7BaEZgLhNoFh6TE86yenVxm9o96TQUNu9V98BXvoMwh03Ia0rclQ8M+TP42zmOi
 NwCytncOt+chCrV5pl1KdW7fkFUDvaL/6h1WJtf77xKP/HxJABjyw60vQgFRWLCeM5w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OSF2yC3+; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=OSF2yC3+
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 94B8740259
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:54:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A4C440BA1;
 Tue, 13 Oct 2026 12:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055241F000FF;
 Tue, 13 Oct 2026 12:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791896080;
 bh=OAsYhxlBM6SNnTE1gnpXm/LN2p5GO72iN0pkp4J2yZ8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=OSF2yC3+2rk99YhUcbG0hwLVzhfo773zR1nc5KjHG7VgSd/VkK9u6ra3Y6K1u0GUI
 clNI+bLbL1hFv7lVWlaLw6yTz7WTigxely6aEa7HdPfBirXXJqxAqXzS4Yhx6Xvihd
 ZJxiLR4YqIs03aUkwOvO7/Rv+aL9orIeFq1IBfnLyjv37pHwTvYCEh1slvDMs1lb/E
 01EKhlE72Q313N5jMsbvePxGFGCjdQFsRE5NOXfHXq4Q1PrGu9PHauoGTPJvuBmF/m
 03fqhuu+2m+LhKfhz4q46nbADOSWE82gfIkL6NrYEOFNza4jjFG0I69kHs3kwr9aeR
 PG9EfU2+6vOIQ==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Jan Kehren <jan.kehren@emteria.com>, u-boot@lists.u-boot-project.org
Cc: igor.opaniuk@gmail.com, sjg@chromium.org, trini@konsulko.com, Jan Kehren
 <jan.kehren@emteria.com>
Subject: Re: [PATCH v2 2/2] avb: Take a storage interface in the AVB operations
In-Reply-To: <20261006092732.3577974-3-jan.kehren@emteria.com>
References: <20260915145629.995499-1-jan.kehren@emteria.com>
 <20261006092732.3577974-1-jan.kehren@emteria.com>
 <20261006092732.3577974-3-jan.kehren@emteria.com>
Date: Tue, 13 Oct 2026 14:54:38 +0200
Message-ID: <xhkdbtsmp7oc1.fsf@mkorpers-koolstof.csb>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Jan,

Thank you for the patch.

On Tue, Oct 06, 2026 at 11:27, Jan Kehren <jan.kehren@emteria.com> wrote:

> AVB assumed its partitions were on mmc: avb_ops_alloc() took a bare device
> number and get_partition() called find_mmc_device(). bootmeth_android
> accepts any bootdev but passes only desc->devnum, so an Android bootflow
> found on nvme 0 or usb 0 is verified against mmc 0.
>
> Carry a uclass id alongside the device number and resolve the block device
> with blk_get_devnum_by_uclass_id(), keeping mmc_init() and the hardware
> partition switch on the mmc path only. "avb init <dev>" still means mmc,
> "avb init <interface> <dev>" selects another bus, and both now look the
> device up before allocating. get_boot_interface() returns UCLASS_INVALID
> without ops, so a caller that skipped "avb init" fails rather than reading
> mmc.
>
> Signed-off-by: Jan Kehren <jan.kehren@emteria.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

