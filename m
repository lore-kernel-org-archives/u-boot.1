Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770D5CC6B08
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 14:33:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F645605D7;
	Tue, 13 Oct 2026 14:33:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o5x6YVtBs88p; Tue, 13 Oct 2026 14:33:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9A8E260727
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791901984;
	b=DWRbOBx7bYPH1YBMhwChXOcu6miVfoRYQ677jo2RplSRkKaYspY964xo/K8SPcLna+jg
	 HWY5H99sxkedWg4V0VQOBaqTevT+gq6pF6f2Y/oNc/JVzfgblR9GWPi3H7hFvV3jgPuYG
	 5q+goTmHB2rGLWmAtU4MpBFxvWxBM4fIjgK1PJX6Kk9TXEp1NOeFx4AIs/sUsjpNri9hM
	 FdjK6Zlo5XIEbx4ZPTtq/Wlqx2PSgayiZchj/6320rji7UhhsJ92NgV+F0N/b6qaK+A2p
	 RDfFrIoLh/gLBw5U9ZU7DrqzKN1phLqsTMQmLkr9p6LQIX+xaPE3Av5Bwi8NXGh0NbQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791901984;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=M7hxcvLOnHC3szY995mFsNYriBr3C3EUrpz9w/xzpMY=;
	b=B+g5ru8n9dd8cgjQWNd4eIPQM8c3JV9BJSM/AT6I1tXkATgPg820A8IMU4siSfLi05kl
	 QJPZfyG5s0SF0sCl1uoIbJ1xmrqi8hNJZCV6A1G+sIEOiSzWyLB8kgXm3q60VALsC49EF
	 xa5xSb2FXvekM4gv02D8WqSF0Mqf3yH3E4OVp/m3W458St6XyrSuC3Qtgv1+81ajpAEri
	 2PnX1byDcdbT2TymNQY1JmKG+Q5TvrUUM3uv+1hlRoLJy2MHZWp6O9Sj6D92H1OndhYRu
	 YgWUufy/9JbVazOHSO9FwZeNNSpmF3WdUClQSp3mgghn947Cr3TtqLQXNkRvYvudMEg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791901984;
	bh=M7hxcvLOnHC3szY995mFsNYriBr3C3EUrpz9w/xzpMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mKLPtHfMzb0ndOrj985r2Yn1igDbXfTu4Axhc1i0RIM0rj4R7FIfsvfeQz56Evng5
	 RaMPNnwMD/PAFljkF0XS6dgNVs2xu3mpVfzcEy2t0RSjVLTnwpAEKMXAp9ucCBpc7D
	 bflNUHS8xbhHq5jr8MTikf4dACvaPidV+Bb0S7BxxW40SLjAGMmA78o2qDDtYRV+ed
	 +L+q4mccczAFwIIwXK23b3uvlEsTOEPU0266GIVi0mwvD92YtNb1SFkwlX04oy7TpP
	 ML4U1ZnAsp8YNdCcc54LrEWaGJMjfCpNkSXxkV8gB8nfyTCJLaynr9VtZvAHg5Bvr0
	 7h99Kz6AcGDOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A8E260727;
	Tue, 13 Oct 2026 14:33:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 01460235
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:33:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E78BA403FF
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:33:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m6K4EHDWQy-y for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 14:33:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 40BE2403F5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791901982;
 b=mvyc/if/3szb+4OYcgz+XBqaTMtckhNn73CaZwMh8yoNsieb8OBdWnxev6IcWuls1a94
 DVMpQci59jOFiqdGgRv+hS6kyuImF2UY8FlRMfM9tXTcFuuZi/TMGBVtvlcdw4vuWxwO7
 UclGu79hCo+CEaHS0+CXY6n/rvhILOwcVj99TCSJ8Dg+rmUop3uduh9HS0YjlYNe5Rxuu
 yYwGok3poK/kNaSJOQkjF990B4XCInU1zDL8AKme/28GiS8cl32x4KjRRNkOpQHSsTzde
 8U9KduIJ30sJVnisXVkPHoCS5TqHB+m5/rLKh9KMtClBvrk9ma/1PSiM9zE5zsdrFRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791901982;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
 bh=M7hxcvLOnHC3szY995mFsNYriBr3C3EUrpz9w/xzpMY=;
 b=a97fHJRvCSR6+nPHRZlHchsxxYLPCoqyrXBdUNHMubfUtuGt6qlsvDtMP6GuKtWb64kf
 vCh5l5jkk/qmzc1+KrTJTiOxCdj68Nv18DFywNHPozrmVjnzEsOd3UpmJdl1W11eFSF4a
 9SaTC+rOBDRU+9ytO5KbN0VUwL2vQ/aTMGQPFTzVmWFkc2fei58x7loH/rZfW0tMmrtR3
 mJ2c4WTyr1HSKKmU26fC4vVHcXAv4B6mwAykQ/WTqGeCt26Y/nJia0XdvfJdJhTQthMCC
 2fg3JIt2++B7BVq06QXh1c9YjyrwvEqwFUXbt/Tz15fHJzZlXyO9U1760mT8P+3iL8Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Kr7QJ83u; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Kr7QJ83u
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 40BE2403F5
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 14:33:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DB90840484;
 Tue, 13 Oct 2026 14:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACCA1F000FF;
 Tue, 13 Oct 2026 14:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791901980;
 bh=M7hxcvLOnHC3szY995mFsNYriBr3C3EUrpz9w/xzpMY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=Kr7QJ83us7X7M+W0Kih/2BjvqYfgaT5lZueIdAcfw2kHUXiy5Rm3d2aNW1jNRXMFV
 tvtMkIxa/FqMg7KniCcmHVFbHElwGJYcZHX6A9UwIIF4uY7de7LVkpO8fQlCBQViBH
 7rizNwh8fA9q8h4e/DcH4EVZ3dPV1z+NnYulTdEfiMNUVDNUxYqENNLM8rwJaT9vHq
 wlg71cStYuZXCQBtVuCqPdT+iJEhlVBAQUqmlranLkdvmXMXKYtDgO/lSKzUWfRHs/
 VDwC1CVkdWkR5+KihAzmJ9p34n3ro8RJdTaPvYlSjBOxO2cTYXx1UhhNt5uR6pHcmG
 i6K3Sd3EWZFWg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>,
 u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, Sean
 Anderson <sean.anderson@linux.dev>, Casey Connolly
 <casey.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Antony Kurniawan Soemardi <linux@smankusors.com>, Petr Pavlata
 <petr@acrux.cz>, David Heidelberg <david@ixit.cz>, Petr Hodina
 <petr.hodina@protonmail.com>
Subject: Re: [PATCH 2/2] arm: snapdragon: export kernel_addr_r_size
In-Reply-To: <20261004-b4-dfu-alt-info-env-expand-v1-2-700eb0e54b61@protonmail.com>
References: <20261004-b4-dfu-alt-info-env-expand-v1-0-700eb0e54b61@protonmail.com>
 <20261004-b4-dfu-alt-info-env-expand-v1-2-700eb0e54b61@protonmail.com>
Date: Tue, 13 Oct 2026 16:32:58 +0200
Message-ID: <xhkdbh5ip7js5.fsf@mkorpers-koolstof.csb>
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

Hi Petr,

Thank you for the patch.

On Sun, Oct 04, 2026 at 22:48, Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org> wrote:

> From: Petr Hodina <petr.hodina@protonmail.com>
>
> board_late_init() allocates SZ_128M for kernel_addr_r but never
> exported the size, only the address.
>
> kernel_addr_r_size mirrors the existing kernel_comp_addr_r /
> kernel_comp_size pairing already done for the compressed-kernel
> buffer.
>
> Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
> ---
>  arch/arm/mach-snapdragon/board.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 829a0109ac7..70d53a30329 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -530,6 +530,7 @@ int board_late_init(void)
>  	status |= !lmb_alloc(SZ_128M, &addr) ?
>  		env_set_hex("loadaddr", addr) : 1;
>  	status |= env_set_hex("kernel_addr_r", addr);
> +	status |= env_set_hex("kernel_addr_r_size", SZ_128M);

If we really mirroring what's done for kernel_comp_addr_r, can we please
add a new define as well?
For kernel_comp_addr_r, we have KERNEL_COMP_SIZE.

Can we add KERNEL_ADDR_SIZE for example?
This will ensure that we can't mistakenly introduce a mismatch between
kernel_addr_r and kernel_addr_r_size

>  	status |= !lmb_alloc(SZ_128M, &addr) ?
>  		env_set_hex("ramdisk_addr_r", addr) : 1;
>  	status |= !lmb_alloc(KERNEL_COMP_SIZE, &addr) ?
>
> -- 
> 2.55.0
