Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B909CA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 04:23:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DFA880422;
	Tue,  9 Sep 2025 06:23:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="syJYxzG9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 352FC80422; Tue,  9 Sep 2025 06:23:16 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9376A82A9E
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 06:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6F2916013C;
 Tue,  9 Sep 2025 04:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747E9C4CEF4;
 Tue,  9 Sep 2025 04:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757391791;
 bh=8UQai/vt5N0MEUKyCFKhGVGeYmm7Rc6zTesgUdxh0go=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=syJYxzG9gCN3+GT0pS7Ssz3wlxzJkEkZmBNTGtOg5jt4+YGR1yMA0KB4Gnf8rhpmS
 VGeY+168c+oBqa4lxFfpeC27Dq7smt0P5rh9AdJnVqR5c96LubQ6TmMRM1cavASxSk
 Uun+bE3iVjzbkq/2hsVc25uv9Cc8YRBEAx7dXq4cp3j6OC2uJurifeRbNmIKnsOpzp
 t14IixBnkNB84DScdqjl79IexijnPuH2vCGaR4s1el8WUXQUbzl6oGltflAywiqpQK
 iUqp+pcLLTgb1KrzTvos7DdHDRKCyqkQmxh42DEXyIj9FQ9iRnGVPRKyE+bBHbqL0r
 6MP14A+k/c2GQ==
Date: Tue, 9 Sep 2025 09:53:04 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sam Day <me@samcday.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/6] Fix UART autoboot issues on DragonBoard 410c
Message-ID: <aL-rqObot0iTQiHC@sumit-X1>
References: <20250908-db410c-autoboot-fixes-v2-0-316ed98e0143@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908-db410c-autoboot-fixes-v2-0-316ed98e0143@linaro.org>
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Mon, Sep 08, 2025 at 01:31:20PM +0200, Stephan Gerhold wrote:
> There have been issues with autoboot on DB410c for years, where autoboot
> gets interrupted by spurious input on the UART console. I've tried fixing
> this back in 2021, but it turned out this fix was not enough. Looking into
> it further, there are two separate issues to fix:
> 
>  - Spurious input with UART disconnected: The RX pin is floating in this
>    case, resulting in garbage or a UART break event (0x00 byte). This is
>    interpreted as input in the autoboot prompt. Fix this by adding
>    bias-pull-up for the RX pin. I've made this change upstream in Linux
>    6.16 for all MSM8916/MSM8939 devices and it has already landed in U-Boot
>    through the recent subtree update of dts/upstream.
> 
>  - Spurious input when querying console size with UART connected: It's
>    unclear why this happens, but it seems to be some issue in the overly
>    complex implementation of 4-character packing mode in the serial_msm
>    driver. Fix this by switching the driver to use the more simple
>    single-character mode, which doesn't have this issue.
> 
> With these patches, autoboot is finally working reliably on DragonBoard
> 410c (and hopefully will remain so for the future :-)).
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
> Changes in v2:
> - Rebase on top of U-Boot master and fix conflicts
> - Drop backported upstream DT changes (already landed through recent
>   subtree merge of DT changes in Linux 6.16)
> - Link to v1: https://lore.kernel.org/r/20250624-db410c-autoboot-fixes-v1-0-d96c97ae41d1@linaro.org

Nice fixes and cleanup, FWIW:

Acked-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> ---
> Stephan Gerhold (6):
>       board: dragonboard410c: Drop now unneeded bootph-all for console
>       Revert "serial: serial_msm: Delay initialization to let pins stabilize"
>       serial: msm: Cleanup register naming
>       serial: msm: Reset after writing to DMEN
>       serial: msm: Re-enable after resetting
>       serial: msm: Use single character mode
> 
>  arch/arm/dts/apq8016-sbc-u-boot.dtsi |   9 ---
>  drivers/serial/serial_msm.c          | 127 ++++++++---------------------------
>  2 files changed, 29 insertions(+), 107 deletions(-)
> ---
> base-commit: 328747974a0620d0996113fe2b3906b06e96de00
> change-id: 20250419-db410c-autoboot-fixes-ad7f4f5973a8
> 
> Best regards,
> -- 
> Stephan Gerhold <stephan.gerhold@linaro.org>
> 
