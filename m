Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63265CA0EDB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 19:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC80F83071;
	Tue, 12 Aug 2025 21:27:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cVp0e469";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ffCH7b07";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 549EB8319C; Tue, 12 Aug 2025 21:27:23 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEAF783020
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 21:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4c1hN84zhHz9t8b;
 Tue, 12 Aug 2025 21:27:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755026840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vW3qkv3hHCc8jDVPGb0oPXUxAGvNVY3f1G2W5dSxgYs=;
 b=cVp0e469idsMZnnficT9olcvFp4+LsTBieAe6PN+JutWvxFrxBwvR8warY48/Zr5zrSS1W
 2fILu2wALfCBG+jSmFyHhT4JNtXEVbUAFtcnsE4vnj23YeGlkZfgTkmEvPiHai4/x02DY9
 FSYry7CFchwmhRwiC5uq5ZzwUu8WZWsRm8711F/LG6Yr2i5Np6RrXV8YV08LHHAaNl1+jG
 ZQN6QJuds8KSHy7CEqu6y1ozUKcjTh5yFQtUTY4ibLVXgRN2ORbsOmF+M8MJ7WokfQyjv3
 dmEruxOWjIgKj9a3qQ46+lBCRxBbBA4iiwBa8VJDaNhAtcIhHC961MyF4fPpbw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ffCH7b07;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <80600dfe-2ae1-4894-8e92-1d44d8b43d8f@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1755026838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vW3qkv3hHCc8jDVPGb0oPXUxAGvNVY3f1G2W5dSxgYs=;
 b=ffCH7b07/949kiPLKweWsmW24ilTR4DdILpYazBFBBqqlFHIoctFB/vmls5xhlyOxjbPTy
 a+f7Y1sgPp7GFvh2IJOiZ2yV52u5PbC7W0NfnzQWn/UXFsn1+XlAI4HhrYs4+4O/X56wrY
 3DTVCtGMX6mgeYuupOnfCuxxTojaOVyXlGdykY5W2xfUmCe3IQFbZyuJWFkS+dxbP2JiVC
 6rQ37AF27MVIpoyJg398BYOzLTwGtA/QWxDOYxfq6ZnP5ej1NvTjsihr9Z7cURtd2rX3qo
 vkwinkPLDKqVE1NGJMBMVLNAIK6l1JoL7KZkTmLzd0qReQnJVm92D9NYUtQ0Ng==
Date: Tue, 12 Aug 2025 21:27:17 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] env: Correct Kconfig type for ENV_MMC_SW_PARTITION
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20250812173109.1813657-1-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250812173109.1813657-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: r96isyeiamty8waqaqayywjossxscmau
X-MBO-RS-ID: a34799a3e0d3e89d30a
X-Rspamd-Queue-Id: 4c1hN84zhHz9t8b
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

On 8/12/25 7:31 PM, Tom Rini wrote:
> As part of renaming environment related Kconfig options,
> ENV_MMC_SW_PARTITION was inadvertently changed from a string to a bool.
> Correct this.
> 
> Fixes: ffc4914703a2 ("env: Rename ENV_MMC_PARTITION to ENV_MMC_SW_PARTITION")
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks
