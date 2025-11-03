Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC55CCF9FE
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 12:45:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22F068331F;
	Mon,  3 Nov 2025 13:45:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="x5f2koID";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gvr8OSI+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D29B28331F; Mon,  3 Nov 2025 13:45:25 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D746080050
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 13:45:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d0WX31J3Lz9tHp;
 Mon,  3 Nov 2025 13:45:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762173923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bEAhhHSRSzPee12NeHR5JeiPUbB5PkJ3/2VCKiENKbU=;
 b=x5f2koIDEK9+fYGoxzi/6+rv9q3BW/CZocIV6vvwYJKUZxC8hZBaOOagN2XW0LNCU7RP0H
 91IUQSJsXERmYjHO1deb69WfTMN4mll+HkzILczmmOKuOBGxvoseSJx8o6TlKmJH/TzXCp
 Ly0STy+/d2StW6ICm9F2FMvjhRMUfF5OTH1SPA+1FPoneVlSpec0fUx3SDE2ARlY9Y2iLR
 vLyc3d/YS6UNySjAICASt+KPNZ7gyV/CXbuQ9CY9Lwk2ejZaKrGAbzwp5+UKp9zKytW3eQ
 +R6Q0/oJBdx7UVZg9TQt/RTxgy4kBp46Gxs/KjqYQDyLJjGCQZVYtKJPE6NEZA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=gvr8OSI+;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <3f069778-3516-4ace-9782-d3bfff5d3031@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762173921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bEAhhHSRSzPee12NeHR5JeiPUbB5PkJ3/2VCKiENKbU=;
 b=gvr8OSI+WXTL6SfYjZuzApnr6uOaa4FX4L3s/jhUwfHYN2yLLru4ovZt9ayb761GIyK5rq
 RrOnv/WvfdaeGOqd65SO2VXN4vMTCgbzdW6kVZlWSvz7ezoVFj4b+BzR3oo/aa2eFs3Obh
 BpyfswNpuB4RQwgb2hCgkDtkIV/2uSkMqHxoCxs4iUN1VEdZ/7syzWySvZ4FCQ55E+cAim
 9D+5H4DsFYtPURPuJm1pM/wjYAdXSoB6zVgFPQiUAD9vrAjjrCZnGX1D8mdtFIhwl10eQY
 hDRMqP0oPW/n22mP7UtpuoS6QhEWHDAaXDM/hIN7OWShX45QWG83gT95WUkGUw==
Date: Mon, 3 Nov 2025 13:45:17 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] arm64: imx8ulp: Split SRAM0 mapping to isolate the
 SCMI shared memory as non-cacheable
To: alice.guo@oss.nxp.com, u-boot@lists.denx.de, uboot-imx@nxp.com,
 sbabic@nabladev.com, festevam@gmail.com, trini@konsulko.com,
 marek.vasut+renesas@mailbox.org
Cc: davidzangcs@gmail.com, sjg@chromium.org, ye.li@nxp.com, peng.fan@nxp.com, 
 alice.guo@nxp.com
References: <20251103073654.2106782-1-alice.guo@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251103073654.2106782-1-alice.guo@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: o8j7ats9pfxauiwbu75xmxigjrjujxrz
X-MBO-RS-ID: 60d36f7f6e4c61673d4
X-Rspamd-Queue-Id: 4d0WX31J3Lz9tHp
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

On 11/3/25 8:36 AM, alice.guo@oss.nxp.com wrote:
> From: Alice Guo <alice.guo@nxp.com>
> 
> This patch splits the 2MB SRAM0 mapping into three regions:
> - 0x22000000~0x2201f000: cacheable normal memory
> - 0x2201f000~0x22020000: non-cacheable device memory
> - 0x22020000~0x22200000: cacheable normal memory
> 
> The change ensures the SCMI shared memory is non-cacheable, which
> avoids cache-related issues after removing
> mmu_set_region_dcache_behaviour() from scmi_dt_get_smt_buffer().
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
Thank you
