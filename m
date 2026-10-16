Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA74ACCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 12:30:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 699E8607E8;
	Fri, 16 Oct 2026 12:30:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XS8V7uTtgOfB; Fri, 16 Oct 2026 12:30:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8047A607BB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792153840;
	b=HZ43WchVPITxgWgIpx6pg3JlvTcCoegwMC0Y4MugRMQrDRy76xqaOiowg278/g6h8eDR
	 BUAtugz0QWwghlzJzVFtPLxWOYg+/gGHRIhkrt51ZuLl7KeNgBwlwmd4qsh1FDDCNRLGC
	 hw488LUgWihD/6blim+MrVnxrJ7YbMJ1UV3Xk0XSrp7lLLyH7D3UClaw7YgrMtztJBrco
	 4qoa4a8SwHaHFAEhiskBJtA9rb8rK4b089Bcnd8Uc9p3/6hmFtDaAR585oMy4n4fkdvj4
	 BomE2aPHIh7NWbDimBNgoiFaicroFppVt9Sal8+bGCvEJH3hGsBWkm3XizQADm1KeZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792153840;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SYXWbRcUZhMACBNjDPeZxSjz1D6F8Hj3epF/nS2kj0k=;
	b=Okbf0gzUFWm7hHo0YR6y5bxI0+CsWYH90xBUFibNxAw56AwrKhUJC2LpUxRRCzCptS69
	 MavqANxt/xSyDFcl0K7UxA1nD3sYUQUL7nrDq+2Qam3bVTrgLFEjQt87FpAPLYeBSUPlv
	 yJ9Yz+bc+T8NzOHXGrVAqRM06pAx/kEBj7T4TXvB6VuUmZdGfywDbQBVLrFXJiCFpUjed
	 5KKp4oziM1RIXpCePjcCZbI3VDgz4yIdXVCLlKQuGeCglVD6uVu9VcZPKFSl1+zHhCG+V
	 /p1yUcEhdkWdsbnTndEhrbmm/k2vMONKqb8Z7nN4wsnFm/fnfTVXyIfawyH0mBCt7vw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792153840;
	bh=SYXWbRcUZhMACBNjDPeZxSjz1D6F8Hj3epF/nS2kj0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=crdhz8R0ilSEMg9Xf9CabYV0wN87szekm4epIYzG7+l+h+sRYpA2OCnh1OjWtGX6r
	 T79RI1j4SPjrA8wHswojuqskQrEmbj184QvBOUbKvh+8iDeHpUhotcP5/hiH2lHacf
	 nMiwLEY/n44AnTm8GuAcH467oHzXq+bkbB4nUoaR7gZlovzb4IPLixwKIfBtdJONPT
	 Z0WJr8A/JgX59ea7Jp6E0sZBYa8LRi4tFo8V1UdXHN7Re/z4keo9YX7qQiK5JeT9iB
	 GLZK964m8jGZyBO7SzyTLli0S36kEuOOlxJH7t1D+seDJERPPCLrkTYhGDZ7YaOR8X
	 3H5wznlCsOXAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8047A607BB;
	Fri, 16 Oct 2026 12:30:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D4861DE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 732804016D
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:30:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ehv248zaA9bT for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 12:30:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 922644016B
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792153838;
 b=bbksx4AyHOnUfWB5ZrGetJM5Ug+nkqriU7Y8buoKElcrAhPu8g605aUB0Dd/cju5ZQN2
 E9+KOu8YL+a3iW/maBdUY3isdHzwo3pEKk2JRbtRhnMdjVdKBZSJoKwDLtKadpfktPlfT
 6c5zby9WhUMR26GylnqZzK16eWdM6TItIzxouGalXE3odeOl2zqD9RwJT0bS1PH/j7RGr
 RRnCpDJ2FTrvsDpe8KtAWYzu9QRjDr5UfT08xKiNeiDeGfiRaLZlYdd2oP7/RPc81VEwv
 vIvYV+Op8yMvVeC31VzO4tByTZkoFQda7B+8bkbB66DClf3o6gCOwzxmbGfdlZcKYLQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792153838;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=SYXWbRcUZhMACBNjDPeZxSjz1D6F8Hj3epF/nS2kj0k=;
 b=c6Kh6FPBz0QBWUsy4WxeUfHpKTrrIB+ua35S1h6a5Jll7z1i6o1+4VWIy1d2KfvmLjZu
 lRmmzycY/yk1ddhgAqavjOWBFFXfpayjYxvnOxFYFBGPe3cs6Xti1a1HEY/hQmkH2a184
 Ok0MAq/gkzreY5gE2tqKkjEAy+jq1SFOsLHhFT0oJclu3g3wQQa+AhTHwbH7xREHoyARN
 AG/glHBZh6+dGEfwRmUXKAg6Qj9/53WiiIPn3cClneU/GxMQgZveYXrNTo0hu282S57S5
 qpL085uROb+PnZ7nEuJBl1crGXazJjnNm+hmyp+mtJ8p81Q36n2M7ML6Uwhv6MlhmFQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="F98/HuUC"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=sumit.garg@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=F98/HuUC
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 922644016B
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 12:30:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2BC5060008;
 Fri, 16 Oct 2026 12:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BB11F000C4;
 Fri, 16 Oct 2026 12:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792153836;
 bh=SYXWbRcUZhMACBNjDPeZxSjz1D6F8Hj3epF/nS2kj0k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=F98/HuUCZUon5Bu4y1qW3rfYtYI0mOWwfKrL48qpcB19JdbeJzBqGYF9pjzSZVBKE
 6rwGXBGqEJVE5/7to5hcuytkMphKmOs+PYU+MskGsHU53jTU3dfIbGWyJcMeTZzCSJ
 G5/N1a9L0znaI3uoe9YQ6+9uEME0iqusJnmgF1/AO81sSP0KgxDOgYfBJt5uy28lyw
 diVyPm/kxYx+UQ/kQKoWQjfYrsUx2ZF1MB3g3FX7VXO2/THky73JWXZ3TC6Ksj6pQ/
 Os0MkCe1hdUZdm2qTLr/x7Ftacm8mmWvNki+EO0l+7am4xaXvHGQnf2k++C9cuiwW4
 LfVnDmdHRoW4A==
Date: Fri, 16 Oct 2026 18:00:30 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, quic_varada@quicinc.com,
 Michael.Srba@seznam.cz, balaji.selvanathan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v5 0/3] mach-snapdragon: Add early EL2 hypervisor switch
 support
Message-ID: <atIY5ke4hzLtwv2w@sumit-xelite>
References: <20261013110525.2465737-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261013110525.2465737-1-aswin.murugan@oss.qualcomm.com>
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

On Tue, 13 Oct 2026 at 16:35:22 +0530, Aswin Murugan wrote:
>This series adds support for exiting Gunyah hypervisor and switching to
>EL2 during early boot on Qualcomm Dragonwing family platforms. This
>enables U-Boot to run at EL2, which is required for supporting
>hypervisors that need EL2 privilege level.
>
>- Adds early boot0.h infrastructure to exit Gunyah via TrustZone SMC
>- Creates a reusable config fragment for easy platform enablement
>- Enables the feature on QCS9100 platform
>
>Changes in v5:
>- No code changes, rebased onto the latest main branch.
>Link to v4: https://lore.kernel.org/u-boot/20260703172634.140515-1-aswin.murugan@oss.qualcomm.com/

For the series, feel free to apply:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

>
>Changes in v4:
>- Updated Kconfig and gunyah_exit_boot0.h header comments for better clarity on platform support
>- Split config changes into reusable fragment and qcs9100 platform enablement
>Link to v3: https://lore.kernel.org/u-boot/20260515130934.388894-1-aswin.murugan@oss.qualcomm.com/
>
>Change in v3:
>- Corrected the logic to accurately detect the current Exception Level (EL)
>  and fuction properly when U-Boot enters either EL2 or EL1.
>Link to v2: https://lore.kernel.org/u-boot/20260515065632.90772-1-aswin.murugan@oss.qualcomm.com/
>
>Change in v2:
>- EL2 switch is made at early stage instead of doing at the very last stage in
>  the previous version
>- This change is based on the patch [1]
>Link to v1: https://lore.kernel.org/u-boot/20260419173829.1074404-1-aswin.murugan@oss.qualcomm.com/
>
>Aswin Murugan (3):
>  mach-snapdragon: Add early EL2 hypervisor switch support
>  configs: qualcomm: Add Gunyah exit config fragment
>  configs: qcom_qcs9100: Enable Gunyah exit support
>
> arch/arm/mach-snapdragon/Kconfig              |  8 +++++
> arch/arm/mach-snapdragon/include/mach/boot0.h |  2 ++
> .../include/mach/gunyah_exit_boot0.h          | 36 +++++++++++++++++++
> board/qualcomm/exit-gunyah.config             |  4 +++
> configs/qcom_qcs9100_defconfig                |  1 +
> 5 files changed, 51 insertions(+)
> create mode 100644 arch/arm/mach-snapdragon/include/mach/gunyah_exit_boot0.h
> create mode 100644 board/qualcomm/exit-gunyah.config
>
>-- 
>2.34.1
>
