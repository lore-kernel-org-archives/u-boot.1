Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5B7CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 08:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C993A80C87;
	Mon,  5 Oct 2026 08:01:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5NswcIzQMsgR; Mon,  5 Oct 2026 08:01:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1F48180C68
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791187304;
	b=qhZ4NGOuHmwSzFTkfBkQPfmIaznY2XVeU2K9yy29yXibw801ppv2gSTFfp1S6RPRUNMT
	 QoF1HyM8ma9Nj5HswBYljJ3NL7wtb/j3clZtaFUllYS7jRohxKAHxoSz2X3JCuvAjhtSy
	 dOe2F9IjaE3XKFBHVS8CkcunJezQYmtM5ya2QX+NITrI1OodSccLH5eJRc5A12AZPnZYA
	 x7b0n4pTHQOvm/heoo2VC6q0JYEifFrmgrjmUNrHFFxjAryYIxRKA6HX6eHUblo3jhQCn
	 /Jk/Sh3ZU8TPDErmlfVoKko4JyRKJI01XDruf8t9zinTY12Ie8KMiT4XVsOzLk0c+1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791187304;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Fu/pzn0A3wxl3ccj2V31nmoEY6MBUGghnVswqpO8/iQ=;
	b=f0T+X2jhJpeOh/1ANtFcaG1GzvJgywT9q0xcoA01y5DEr2JHflkNTifRU4HPaR+/opsi
	 zv8D7f64Jj5Km3Mui0s2v+gptxLLgr5U7ypUc9tF7ThDmoNWayNzyrjxrNWt35OitEAJ+
	 o4c+Px6PsXhJO0tA6Nwzv8h+dHzrtfXKDA1Qyme0WS7HHBFDzPpjd4ikgUXiAT8bDCH3n
	 LQo6Go8/VKShrX7zO9OOEjBr5OHzVl4aIRqR38HjhfSwaa3ZHLAsAVyYNj6YCxP5IStXo
	 YNuCwY88/woYWAJ3SnsADCXM8gvVnQ+lsRSodLEFKfqFdLj+CzY9bdkVJZ9ngd8R0PQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791187304;
	bh=Fu/pzn0A3wxl3ccj2V31nmoEY6MBUGghnVswqpO8/iQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bp24cxxQFHnTEWIFMV7lBJfDLPlrYdel255zrNnJTYTUczLJgm6zlB4tbsUKT6ROg
	 trq5NT6Pkl88yZZf4r8MF/hkHtd7qd9RZXTqZkNSt7A8vTwyXu/3CmXVZErA9citco
	 auaPJWBJYfE5PnW7LVlpgDGr7apCUWOk+Moo3FpZX3ooo8GPsKNB6pMRNbU7K4DLih
	 rZ8SjEctIu4LaiDFPw/ZK+7yh0iuF48EIoathr5pD4s92tHHNxv07pQjjxCGiENGE8
	 kyTLXCW+7Y6od5b8kFIW4GoyZvDnwn84h9xwI1JXmUawZ/UtlX3dEULK+2EsvBdapR
	 o80om4Q627jVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F48180C68;
	Mon,  5 Oct 2026 08:01:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B1BD734D
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:58:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 963D1605F9
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:58:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8xH6SHTJLdb2 for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:58:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A236D605F3
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791187099;
 b=sBxnrxrYfvwFUBoACqEuNFIIesGVgE2fFRGYMjkL9i3+C8UHSqIGijLJl+xY83XMhZlj
 YVyebZNG8DTNybpPGFPT0FGlw8Cj4SNp+AvNSvdozTS48RgwISfGeHIsoDAtrWKAJLmmO
 3wzlQYMLrE67qwvb+xZ0YhAfMtVqnaNPsCrYIdbR9alE7kwjmnvOhRIT6C6jPH5xAJpSy
 TsnDQCCfpCjrQxVeI5NVo2k/GVPLz4mJD56cia/OTc74QSjlCavO3IMbOnZ1teTETNp/v
 Tu8oTHZUauNwfNfibQ6E9PIF5t00ttpOmEhMG9RlGCPGUO8ez8paGXQorRSabj8OXUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791187099;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=Fu/pzn0A3wxl3ccj2V31nmoEY6MBUGghnVswqpO8/iQ=;
 b=YWuG0W2/E/Ju2YnJKu7NTP6Gq5a1UZXysfL22ZwgSU9lZ42rEGQ5kXKwFrnG1WJiH+AF
 ZkjQeFmAYnJXCSdWKMNzEnoZWSl7PEH7X731LK35KdbpyaDHpVjBOkxNCDgbcvcMs2GmL
 mBTlsl9RgGxEPy2t95FcLnH3F2TY3ijPYemY45HkO8WWF7mOi45Nl2chYGKr6zNXknHnC
 CtxJA6ZkUhtMvPLoiZLiLD+sU9cAJ6gM/ql9DmNLpCYj6DSquvNK6CAuOX8orZLBtDe3I
 4hkCT09mLbVij2hOOuvS9H2G1TTFFVDoNHFntkYhrzl45k/6KrrO03cMsiRdOc1UinQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=vNidcA16; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::101"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=vNidcA16
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A236D605F3
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:58:19 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hysFg1jBtz8sb5;
 Mon, 05 Oct 2026 09:58:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791187095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fu/pzn0A3wxl3ccj2V31nmoEY6MBUGghnVswqpO8/iQ=;
 b=vNidcA16tBZGgmN0gAkOjoPwZ4JeU0kCNFvtv7pTz1/76mvSCBzF4aeLCVymmOjDFfe1lo
 XCb67vAVw5AlapPoOiS9guU5chdEKYFHDY9priBnwQ0Rs8N2WDbwp4fElAvFbpDLeB5iPG
 NPgEexVePAcofWK1VRgLDd3A4XDW4qfIyk0eQDSil4HCYeWjpbhq1KBAICQwNWbDbIqDHZ
 1HKr87YLemPtpJCJaCw6xLBrktC0rBLOzvNvjAJ9OZUTvvsiCvJo0ypSbqCGMOC2cPDs2j
 g2JhgmhckLlOdBNpCGrZELk5zaxlR39FcjWTaKG1hpQI6r3HIz8QphSDNjV23Q==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Bruno Banelli <bbanelli@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH] lmb: enable LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_MVEBU
Date: Mon,  5 Oct 2026 09:58:05 +0200
Message-ID: <20261005075813.601288-1-stefan.roese@mailbox.org>
In-Reply-To: <20260820151423.252788-1-bbanelli@gmail.com>
References: <20260820151423.252788-1-bbanelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9oqhexi4wejqxnoitpof4o95yfphq3wz
X-MBO-RS-ID: 4f99ff5c9de5c135a41
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

On 20.08.26 17:14, Bruno Banelli wrote:
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

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
