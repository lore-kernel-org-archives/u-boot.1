Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A260C79F8C
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 16:23:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E87880AA2;
	Sun,  6 Sep 2026 16:23:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sCmNOFmi1I4h; Sun,  6 Sep 2026 16:23:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 232A1808A9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788711800;
	b=M5DBafTCAB+79OekvLMAnvcFL3qDBoLm9bvpuHN6nB3fSxIkP/PWCXwyMOBx2/8FCCYZ
	 6YZcc46QAbshcjt7IZTRedaJrSxly6lMzvmQ9kHvV+igSKMc0A4WZVSOr52Gi25ApKVmi
	 KWavooj8EkPy4x+Ir8tBIJ6iqSpt4TTEeLhEx768aoDY5Qv4oLLMKysroVAPTeDvHIBf+
	 1bdFzqU5NxbiXoKaQrt+ZpVK98rqZBBDGrbGM0aWVw/sibN7aOQ6ddzf/tCNxVUEiYSdx
	 QaeUFH4I2iNrAabthKcdrtUD8Vk09q4LuCD7V/jgDWTWuTngTwoVJ5aLjekwxVIupcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788711800;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
	 Message-Id:From:To:Cc:In-Reply-To:Subject:References:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gEOz1DspXF3jS1rt5uHCL9uOM7iSr0dbmHvu7mD01DY=;
	b=hhIuDhkFBH0ReVl6LYzzkBIauI5H/BnP9t+3FOMwGEVAb12FoNvf2zGX50M73Vpz4hAx
	 KWkgejMYPQNXyuHwEVOGc2WGPB0MW9OK4JhK/J/gCyLm9MuULhN7CBZydQWal/uiXOnVm
	 xadMlT3M0dH/FX0HxCjeUyTx2ie+MXHjaZi1J9IUU7LRSIyHJS2QRKChbwKCds4/2zQ6Q
	 ZGPncO5YB80QCdC1DWstfnZi7AJtHiiJ5uk69RGjdOYkSfydE82ZM0uTaQbx3z5kuG188
	 cbiG6p+ZU1qux6Hv7ty20+9hlFxJMlnhVspJhRdog5THDQFCtzqm6uHPJg70Ld9wkQw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788711800;
	bh=gEOz1DspXF3jS1rt5uHCL9uOM7iSr0dbmHvu7mD01DY=;
	h=Date:From:To:Cc:In-Reply-To:Subject:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PLrn2/l6cfMRb6a1bASP7fyQ2LS+tmenaXwyR7//mnkyMwGf4xLtaHyjxH8dmzjIA
	 hC/q/pPsEbFbvTYINImnpe0Lh0pJbxBRSZrytn+EnV1HGXj6dVvdI0Hi8w/Q+A32RU
	 dtd3/buRtVmGcN/kNHsAlFyWDSfHs/zJDu/DFIKAjAO3897KbuG7h5GOBG3EO0j3tJ
	 rEMk4/LYwmkmQ+9zNWBG/Cj8M39YFTOXmK4hfF0uN8cbWh7bkzbxBcbW52gUQfQMtE
	 /URa1oDYnu4CRkioVbe7elVVJmvM5tBEbRimSJ1789/RKln9Mb8N7QR3Qz9AnQywYh
	 tSgedqjZsryRg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 232A1808A9;
	Sun,  6 Sep 2026 16:23:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 371AB9CF
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 16:23:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 28B6640067
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 16:23:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n2RWyzc14Qwo for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 16:23:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 133F24000B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=195.121.94.170
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788711795;
 b=HPsTmhMuC98Wfn9AR7FlyZALkHldj0NkQzqDMqFky760XySBvN/Nps+u9O23Q8qZmVeb
 OVNO8TNTvz2hzfXIxifHGor3JQxliixOJnDFYrN7M0XtZZ8WvD+a9+uasATlJXb3pcCry
 R05nwob9W1p/JaTVSKApw2Tr0U2Q0lf0ITilnt/v7rLEQ4GbgaN9rTpZO/Mxk561l1q9f
 gTkaLOFqx3r9ogpZSAcSWwvtsbpx8WJOd/l0B4SsTtea8pUPOBWe09PKL/p3nI68uw4wB
 QMmYfQBfIa0k8sZzMbowkcQtx8EzCTtgm6H7kqfd9YSebnFNNl7+wPpnUdPKYOAYsNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788711795;
 h=Received-SPF:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:Date:
 Message-Id:From:To:Cc:In-Reply-To:Subject:References;
 bh=gEOz1DspXF3jS1rt5uHCL9uOM7iSr0dbmHvu7mD01DY=;
 b=fHjuQR7IINON2ZpJjvy4H8T/d9AhQoFZgEFF5kZ/b204MWgYlwlYEw0fxuxNyrzL9sF4
 z37xZbyc/IrLRj7seo5hojFeMYrDtHw/AZFsjxVOisC6Igz7yOiu8ddrjIWjlbbOWwYva
 cs+b3YcWfxHAHWftFsrJwAVNPOXQ/sLIZwmj73gvz07LSrWCDLuDAFtHQfFRWkTqvTd/h
 DVtmzbsHW56mftDoEoH4LE3hzoYcKfJVen39NgkU2Tv8asgcWmVD2dxzuZ/LEApNL0msy
 FcRKz8Gk7+FU0HgASFwC+UkNVIcLOs69/RvBYerI4VkHPsBVldQZn7S/NquA2XW2WbA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=xs4all.nl; 
 dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=UEvavZRN; 
 arc=none smtp.remote-ip=195.121.94.170
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.121.94.170;
 helo=ewsoutbound.kpnmail.nl; envelope-from=mark.kettenis@xs4all.nl;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256
 header.s=xs4all01 header.b=UEvavZRN
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 133F24000B
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 16:23:11 +0000 (UTC)
X-KPN-MessageId: 3d5ce72b-aa0f-11f1-83b4-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id 3d5ce72b-aa0f-11f1-83b4-005056ab378f;
 Sun, 06 Sep 2026 18:23:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=xs4all01;
 h=subject:to:from:message-id:date;
 bh=gEOz1DspXF3jS1rt5uHCL9uOM7iSr0dbmHvu7mD01DY=;
 b=UEvavZRNIVM9BDOOa2traLIZeOQU4GLs85vZF2JZVYUEGctGARkoiQTPJGrY3mGubaVCxw6J3zGpW
 ayWiIKT6vlaTO+rOCdkXf2ebBCBNG8T1VssYsLFIxBsNQj72PQvK2TBgwWWNFV361nKnFBSd6aMdLW
 0yjkxalNvM6LTAOx7/nRrWMd+DUZ7E0xvGG+JtVTNSz4YBQ+IZa78FOkHcFZUAc1DC+hcKq/AfGjmp
 RTtIWTxaoqwQh9Xp5AH67yPtyi9bJxLLNfqO2+wgHB3CaQfqqIPkhDTEiAtA042Inzv3QeGgvai/Fp
 gBH9Hy9+5IJAV/6a4iNCoIHPCHXpcrg==
X-KPN-MID: 33|CPZPDnpF0jdvzbt5dcSbL+oYYOALElwn6OD/6vtKFSsqlV6pz11cZ8r60mbH0/O
 cn41EYuv5T8zyCX8UtGVpP+l2TPaLWlXM8MZyrEOhTns=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|VMXgVMg6XmLI4cvtmv0krhvKymC3a3/agJ6WoyzdhF73t4zgqhPL1mTiral1fuR
 d/gQRM5b2yKlW96BpDJh7sA==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id 3cd8662f-aa0f-11f1-9280-005056ab1411;
 Sun, 06 Sep 2026 18:23:05 +0200 (CEST)
Date: Sun, 06 Sep 2026 18:23:04 +0200
Message-Id: <87a4putklz.fsf@bloch.sibelius.xs4all.nl>
From: Mark Kettenis <mark.kettenis@xs4all.nl>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, xypron.glpk@gmx.de, aswin.murugan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com,
 quentin.schulz@cherry.de, balaji.selvanathan@oss.qualcomm.com,
 dlechner@baylibre.com, vincent.stehle@arm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
In-Reply-To: <20260906121751.3550628-2-aswin.murugan@oss.qualcomm.com>
 (message from Aswin Murugan on Sun, 6 Sep 2026 17:47:48 +0530)
Subject: Re: [PATCH v2 1/4] efi_loader: skip fs probe for non-ESP GPT
 partitions
References: <20260906121751.3550628-1-aswin.murugan@oss.qualcomm.com>
 <20260906121751.3550628-2-aswin.murugan@oss.qualcomm.com>
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

> From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> Date: Sun,  6 Sep 2026 17:47:48 +0530
> 
> efi_disk_add_dev() runs efi_fs_exists() on every GPT partition as
> soon as its block device probes, even for raw partitions that are
> never opened as a filesystem before boot. Only the ESP needs this
> probe for boot, so skip it for other GPT partitions.
> 
> ~170ms saved on Qcom SoC bootup time.

Sorry, but I don't think this is right.  UEFI implementations support
loading UEFI OS boot loaders from normal DOS partitions and folks
depend on this.  OpenBSD's install media use a DOS partition instead
of an ESP because (some) Raspberry Pi firmware doesn't recognize ESP
partitions.  All arm64 UEFI implementations I've seen (including
commercial ones like those found on various servers with Ampere CPUs)
support this.

> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  lib/efi_loader/efi_disk.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
> index 4a3ace3a304..4fd53fb598a 100644
> --- a/lib/efi_loader/efi_disk.c
> +++ b/lib/efi_loader/efi_disk.c
> @@ -529,8 +529,12 @@ static efi_status_t efi_disk_add_dev(
>  	/*
>  	 * On partitions or whole disks without partitions install the
>  	 * simple file system protocol if a file system is available.
> +	 *
> +	 * Skip the filesystem probe for non-ESP GPT partitions: only the ESP
> +	 * is ever opened as a filesystem before boot.
>  	 */
>  	if ((part || desc->part_type == PART_TYPE_UNKNOWN) &&
> +	    (!part_info || (part_info->bootable & PART_EFI_SYSTEM_PARTITION)) &&
>  	    efi_fs_exists(desc, part)) {
>  		ret = efi_create_simple_file_system(desc, part, diskobj->dp,
>  						    &diskobj->volume);
> -- 
> 2.34.1
> 
> 
