Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049FCC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 19:56:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F4A6810ED;
	Wed,  5 Mar 2025 20:56:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="UulTdjO0";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AhNRa4Fo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4B3E811C1; Wed,  5 Mar 2025 20:56:21 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A81A0808A2
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 20:56:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Z7NbR2pjsz9sq9;
 Wed,  5 Mar 2025 20:56:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741204579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MWUeunIW05ux4uykuBdK9BLLKfPUWdo0f3uYZFiWKcU=;
 b=UulTdjO04CGAVKWarrjz1x4qyIZck/CykC0g2ZsluaRnmJyjP0KH+4pwwlIaBhkrkGEANW
 AWBjNFnuAxZ6evkJvKlDfYviNYRrTpmX7wGKS7hjnMtxodqNhhppvAtqA16ffVNHhSgC+r
 5PFlhl7sYa1KCOaeeNHV7wgjFe6A4QhCSY5PogQkc+5osxUBM5iZXa9YwsMuWvvl+92Lu/
 M2BZb5l4g2KKZ7c4+HfTbRAChRy6HlEuAdkEjcSvXAASZ8jEYidrphFkWw8VK7iG9v3g4r
 QO+ItLueHuu7kMRzRE5Jl5QWGN1tRKFbK42PVqCfywFTnsHcr7r1FNwuuh8RQA==
Message-ID: <9d9b37a1-7320-4193-bc0e-f1e4d2342df6@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1741204577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MWUeunIW05ux4uykuBdK9BLLKfPUWdo0f3uYZFiWKcU=;
 b=AhNRa4Foq+TI/mNTFX1ZcgzeqSwW+EC3qmTylJapvatrADOeDhBhdlzRU1981c84qUFNTN
 SzOfYvWUHSz9B/HGLWuwlGGHqN+kmjxVI8mFovJHv2XXWmCPMmpapx5haBmsfzk15GHDQn
 ZZjIAWI4fuP0KxKBswm2RNabuU9buSLV64Jv/DgLzEBdbuEOtLM/pRHLdZlh1lsLmH/7wM
 +15DZnS4EQwS0WiRrzn77C/zQc3koBuMbQhKV1N0sPu5KDBsQw98gpxJIcznW0QjxBQ5s5
 o4wqlKgfvl7KZA/uDR1ABcLUwcI5Mj/IaV1PlVJTQ59e18fhSgJ/GS1SFlekVg==
Date: Wed, 5 Mar 2025 20:52:09 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] clk: rzg2l: Ignore disable for core clocks
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250304194441.90108-1-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250304194441.90108-1-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: b2efd9b2b933d1b3cea
X-MBO-RS-META: 9rbjscpiyzszpdjz5rpjqg9p7o74koho
X-Rspamd-Queue-Id: 4Z7NbR2pjsz9sq9
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

On 3/4/25 8:44 PM, Paul Barker wrote:
> Following on from commit 9a699a0a0d62 ("clk: rzg2l: Ignore enable for
> core clocks"), we also need to ignore attempts to disable core clocks to
> avoid the need for conditionals around clk_disable_bulk() calls in
> drivers which support both RZ/G2L and other Renesas SoCs.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
