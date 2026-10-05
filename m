Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD02CA5FFD
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 11:48:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 808B98087E;
	Mon,  5 Oct 2026 11:48:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8wnJ4SQKP12g; Mon,  5 Oct 2026 11:48:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C27B6808C0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791200896;
	b=MG1iIIwXJRE5XAdB04ayD5cVIlCoHpxuZI+Hr8aV7dTxQEbEfRil7GBXbX70aQEXHLU3
	 HksElUxIOLTpoxumIUHrEb96Oz85flIWJu+HjKChhfzl4qTTRByF7pTkD/d0Ld8SjR+Ow
	 EtMzK9AXjYitvz54c5a76JLvdigZJL6Zl9DguhoDSeqsvqGkk0JtOKY4pja8Efe665lYf
	 H8VdnNqQ8YjqFAvlcmQ+E1aw+R36zt0aKCcHndiHXdrBok3vB8DFd8QEX5p9PDACEcQfI
	 NLvKMmKiE9c37pi4ePeNIi0bAJqoocnXZCFd8V/wM00Mek2SRBYMzeBUtNoHouasbTg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791200896;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-Rspamd-Queue-Id:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gH/chGV7YjS8Xoi44KDOvRj/znJs0a900Ntzgjl9z24=;
	b=mOM/3tcAT7CVlDeGbPAFbyI+W8gkcddX9olktet6yVINzjU8VbEl6SgL26N2M2bUKAL1
	 TEiXmC4OszZGUclbDMjqqm8XK6tP0slmq5IonN9HZo6F5QZY9bNUWspifnZRR0yzztV/s
	 EgubqHQxfmXAqYAD4OFte+UybxYEpByvU22bHoLiP9CAdz2cG6zzqcAei2gKejWVRdOVH
	 9NeC5yw+mgAP6ZLKsVs6uOBk5Sdxii1jUslFCgJR1tqGdl9KzAwNNaURTMhE4nOIiZ0lb
	 fLEq0FSME4QoEEMxoE/ms8C/rsMnZcV98ZgMKGcHn8HvX4Su7rTRkPEEbnsRkgDx/cA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Xzkfp9wh;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Q6pNvCk5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791200896;
	bh=gH/chGV7YjS8Xoi44KDOvRj/znJs0a900Ntzgjl9z24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L3/Tr5fbaDhUh2fyD0S60Hkp4xSjxg6PNT+ICBVuMV6gs3OfB1QtVqrFDBnWMv1JB
	 QVic1i7rZ2Hlv8nuVK7C+p4Rq31Q9YKS7so8Z/JQPFfcjZcmBXDZdwUyC7xCfbh5c8
	 w9fRJHehN6mSAX7gqlIJVMDSSo6zYpjJPpS4/NY6uBSoBd66G+/1mcNS2VAZHVn2tG
	 zlevv4EgC7Mcn4w8EyIV4LzEdQEsBJ42VLGZYqOGPEkjCMgQfkrlPkpCR7d3I+BNMO
	 w8YnmrTx+M0V8G/jm5l0pmnI0opPezpMacnHZzlj0UUnzphdkd34CG1pN9dvxtjFRg
	 LiPcln9tS/4qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C27B6808C0;
	Mon,  5 Oct 2026 11:48:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 73E7132F
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:46:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7159580880
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:46:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IqfCQtSSpmRN for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 11:46:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 960228086C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791200778;
 b=e9TTjblkDLuiMWPQ9kYqcRkQacjpz+vRrR6vi7L8z4NgNPPTdEqTrzAo3kbgruWKYk8H
 K+o2ciaiu3HkfvCsewOxC9iy0+fwx23Z6Tdl90ivRXR3/yjHMoI+03s3dUM9dAgmkEckV
 Yo8XZLHVgMkg4VFSuOU6OuvRnhbfTE2w1TqZxS/E7sMOPeC0kQvdR96sfeJEnDrnHD0ax
 T0TdvISz8/BPB/MI5pX4P4bYV0u+m92hCrH4TspkvVsILvkAcj6KlDSehqi1w6Q0NZPhW
 9GiuP8sTbPxv6j557I5N6WqgGqEkzSPk/ks6AL+WdU/xbtvcgYID3TOLKocugwRI3cw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791200778;
 h=Received-SPF:Received:DKIM-Signature:From:DKIM-Signature:To:Cc:
 Subject:Date:Message-ID:In-Reply-To:References:Content-Type:
 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
 X-Rspamd-Queue-Id;
 bh=gH/chGV7YjS8Xoi44KDOvRj/znJs0a900Ntzgjl9z24=;
 b=D2dRFOtrpNJ18cuAlZCgFTcDE7hZhIXFbv/0vJHjYiNZ3ZYtLcLFyMqkVTalswHyqA+t
 /rag/gWNfToNu4anzhq7MZIRfZjjPXajIce7LsIJWOQ1s1Rk7WO2bjbR6xtzjVyni4B0b
 N4+K8kn4PpPiDxrL7DDloCCw7we/B2eVfS7by7Hsj/wiDSobzM/YAaUCEGYllu+dQWUC0
 uOM5YvaaMDBxcER3pBSwAv6g6YCbopsYI1JXpJ+XsVZfXuMbwTmNTuIrlsRPf2WcvhXaz
 BqK+7VqrdAIMdhKMVtsXgD/n1QnchSsx6efuhcX+W3vYVdCNA4WZlKCKfClIs0iKzLw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Xzkfp9wh; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Q6pNvCk5; 
 arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Xzkfp9wh; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Q6pNvCk5
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 960228086C
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:46:18 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hyyJl2xFGzKn8r;
 Mon, 05 Oct 2026 13:46:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791200775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gH/chGV7YjS8Xoi44KDOvRj/znJs0a900Ntzgjl9z24=;
 b=Xzkfp9whFk6gjKo+utcoG/9DvII7wHUOHRtZ8YMyzp1QBSnm0En14LmCEwzUVxSL+BfFaf
 jxuJs0kKGGNmzlUfTOAdSFPIsBcFM5MxDVqNqfKSvpXUP0TnMcgoXfnarJs9tKwE8hwQyF
 6DzmIKIfKWk9pzNo7kRWLhz000yDfcXP01t2DhACNZYNgH4p5Zaujs/yxc3tw5WEiiQm32
 5MrS2yScXLkL5MLHZuHx2ulAWSTFI/XoRktAqg+r+TyeKnroZ4lufEX7RP7qajemKA10cs
 gPPDJRK7T81Xw98DkrPMWRJ9WquJzfb+KR0ARMDIfYBp8AMD0LKsCENIaO/muw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Q6pNvCk5;
 spf=pass (outgoing_mbo_mout: domain of stefan.roese@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=stefan.roese@mailbox.org
From: Stefan Roese <stefan.roese@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791200774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gH/chGV7YjS8Xoi44KDOvRj/znJs0a900Ntzgjl9z24=;
 b=Q6pNvCk5sAnYWSqSrvlK1yOY1OI1rMmXl5QP3oRog08dMTu3/HUuCUzV+L954+sm/Ku9j1
 5wlgY3ehznNkkA6O/doKGSSf5rkB8IeF2EUuHQNpDnWP8VqwZgCYRkBZcoOLUP7G2NRMEa
 LruwNUGbzQIIvZ43zvb8yNhwUiD6GuZpcctf/OQmjCt7UNcdRM8rGmxKx1bQKmAIqIY/+C
 DWujzC1iYep+K82vXB445zDsxOMTsjowTnw36MzsTcXf86jKEM79h4tUPL5ImMIF5S7go7
 OO0i4TZZOhwVqJNPCgGVQ5tqgEM/xW9yrMWarDZ72F9PWzUFnH6K/irxXMk7Vg==
To: Bruno Banelli <bbanelli@gmail.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH] lmb: enable LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_MVEBU
Date: Mon,  5 Oct 2026 13:46:06 +0200
Message-ID: <20261005114611.743343-1-stefan.roese@mailbox.org>
In-Reply-To: <20260820151423.252788-1-bbanelli@gmail.com>
References: <20260820151423.252788-1-bbanelli@gmail.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 77gbxoxxwqkmgefasuuyaaa4aff6pihz
X-MBO-RS-ID: ef7f5bcfcf78ec6a42f
X-Rspamd-Queue-Id: 4hyyJl2xFGzKn8r
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

On 8/20/26 17:14, Bruno Banelli wrote:

> On Armada 7k/8k only a part of DRAM is mapped in U-Boot's MMU.
> arch/arm/mach-mvebu/armada8k/cpu.c maps 0..0x04000000 and
> 0x05400000..0x85400000 (plus MMIO), and arm64-common.c clamps
> board_get_usable_ram_top() to USABLE_RAM_SIZE (2 GiB) with the
> comment "Not all memory is mapped in the MMU".  At the same time
> a8k_dram_init_banksize() advertises the whole DRAM in bi_dram[],
> adding a second bank at 4 GiB whenever more than 3 GiB is populated.
>
> Until commit e1b6822d6522 ("efi_memory: do not add RAM memory to the
> memory map") the EFI subsystem bridged that gap: efi_add_known_memory()
> reserved everything above gd->ram_top, as introduced by commit
> 7b78d6438a2b ("efi_loader: Reserve unaccessible memory").  EFI
> allocations are now backed by LMB, and LMB does not consider ram_top
> by default, so the first efi_allocate_pool() of the boot - from
> efi_init_early() -> efi_console_register() -> efi_create_event() -
> takes the highest free page and faults:
>
> Tested on a SolidRun MACCHIATObin (Armada 8040): without this change the
> abort reproduces both with 4 GiB of DRAM (far 0x13ffff000) and with 8 GiB
> (far 0x23ffff000), the faulting address tracking the top of the highest
> bank; with it, U-Boot reaches the prompt.
>
> LMB_LIMIT_DMA_BELOW_RAM_TOP, added by commit af4aad1f0a0b ("lmb:
> Optionally limit available memory to 4 GiB on limited systems"),
> reserves the memory above ram_top and addresses exactly this case.  It
> is already enabled for ARCH_BCM283X and ARCH_ROCKCHIP; enable it for
> ARCH_MVEBU as well.
>
> Tested on a SolidRun MACCHIATObin (Armada 8040) with 4 GiB of DRAM,
> which reproduces the abort above without this change and reaches the
> prompt with it.
>
> Fixes: e1b6822d6522 ("efi_memory: do not add RAM memory to the memory map")
> Signed-off-by: Bruno Banelli <bbanelli@gmail.com>

Applied to u-boot-marvell/next

Thanks,
Stefan
