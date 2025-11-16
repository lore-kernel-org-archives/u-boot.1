Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23046CD4F3E
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 08:14:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5812283A32;
	Sun, 16 Nov 2025 09:14:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rBP5UCWS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KCSmDD1T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40C4E83A3D; Sun, 16 Nov 2025 09:14:09 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52B9783A2D
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 09:14:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d8Nv26RHQz9tCX;
 Sun, 16 Nov 2025 09:14:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763280847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n0HJJjfttabTLc5C9OOVngBPqgpoc/3Ey2pKPbqAFNc=;
 b=rBP5UCWSnFCEz/rsj4DgDgeePau2XITStHjBWqMGD8yag8JtS4ulRUQu14Wl6CK9/HMej/
 caIlhzDN8EV1qjKZzK8gIwVBabJQFdtdwNs84WPt9im20fVJlepoxT7raVY1wPWQZ8nxpD
 y+gl5E+KXMXPQ/Ab7BbmfE+D+avaXrK8gTdQ7ygNdaGYEsrFD+UL1Ipi6C4AInDizutlQp
 zHzFPV0cgloxvRPCMZdXFkAFOUtt4hlMnL8FvB7xfuddYSJgdUzg2XFVcMOqtlbeULjJ2t
 7cNtJUGYbjQtnewViXBhZKIdlzBrIqTT2QT0Yp9H9PfaSohawQzN0Fqs0vG9Wg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=KCSmDD1T;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <e03127d5-6932-4dab-b374-74dea6413859@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763280845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n0HJJjfttabTLc5C9OOVngBPqgpoc/3Ey2pKPbqAFNc=;
 b=KCSmDD1T8T5Oy0ZkavfkaNZCS3UFfGIl+M7ABBoRM/vyBamDHArd1/2x8NjyjyQrc27gT8
 Hlm4vKag+GtaHkYDFbvnkEe4f2rf+b6Ss6duMACLbsy72Sxm3H9QhkI67Yxjt7OBaI22Q6
 eDme1nLI4yg8HjXspE5jyfEVHzrtOLbpRpzXaY33MXYmvG87LbCAFzOUbgGX/+0dAsgqgN
 kPoxcxxmTveLAJfGeBDaMKhB/6mFf2RPSKUT6lC2wAjTYp5sWz8Io0QGalV9HbyWZGB1+s
 nMRIrzpkJRiAQgLN0j8eX8UFC+4Nyl5Sg+6cMPyGGLJ7ikY3hXRZbb8Y25Jeww==
Date: Sun, 16 Nov 2025 09:14:02 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] rockchip: rk3588: Map SCMI shared memory area as
 non-cacheable
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20251116014531.2133243-1-jonas@kwiboo.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251116014531.2133243-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 9019411e39d89aa6af9
X-MBO-RS-META: 8hzqwrib6hj3rgyh8iajpbn693ububz4
X-Rspamd-Queue-Id: 4d8Nv26RHQz9tCX
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

On 11/16/25 2:45 AM, Jonas Karlman wrote:
> The SCMI shared memory area is no longer automatically marked as
> non-cacheable after the commit a5a0134570c8 ("firmware: scmi: Drop
> mmu_set_region_dcache_behaviour() misuse").
> 
> This change in behavior cause Rockchip RK3588 boards to fail boot with:
> 
>    SoC:   RK3588
>    DRAM:  8 GiB
>    scmi-over-smccc scmi: Channel unexpectedly busy
>    scmi_base_drv scmi-base.0: getting protocol version failed
>    scmi-over-smccc scmi: failed to probe base protocol
>    initcall_run_r(): initcall initr_dm() failed
>    ### ERROR ### Please RESET the board ###
> 
> Update the memory mapping on RK3588 to mark the SCMI shared memory area
> as non-cacheable to fix the SCMI shared memory based transport issue
> that prevented RK3588 boards from booting.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks !
