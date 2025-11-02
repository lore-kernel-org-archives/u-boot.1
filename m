Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B6ACCFA02
	for <u-boot@archiver.kernel.org>; Sun,  2 Nov 2025 13:59:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A6A38307F;
	Sun,  2 Nov 2025 14:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JJEAPRcg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HbNLeA7D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8F3A8307F; Sun,  2 Nov 2025 14:59:09 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5872800B1
 for <u-boot@lists.denx.de>; Sun,  2 Nov 2025 14:59:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4czxCb3swcz9tWy;
 Sun,  2 Nov 2025 14:59:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762091947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L7q0LmtyI1NT5TT9ilKWbCCubuaK9SNHy1fkIO0wCPE=;
 b=JJEAPRcg1ajAquN2S0S09JkXl5IYZexo9zfCUWnQQ6/aNjy4kSMwGwJsisSvEr7PrrKO7u
 yxMjed4zPvxs6uguwqWmGrdJRMba9gr6yyoXkGHGmpY4xIlqbVSeiNrAURL1bcTZzJASIv
 lMaiMXN8kB4cpqQiyzRt7mFJhRwOiZ+b0n+czo9wbj+N5OeOzU1iScfNi+2N3StyvoF1Un
 UH2H5lndBHT03qcGXITr1y5bsL4rNBcrU22gc5kWuSgDHIKGY93tJUVJDVR4gz4JDXZ6D1
 DX/xOtk7mebl0b4bFEP4rR/rmLf1pc+AUX8WhoyIIpVZsNzC3CXBTCmWsC52bg==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=HbNLeA7D;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <2f894c99-3279-4d8a-8e09-b002a73d85bb@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762091945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L7q0LmtyI1NT5TT9ilKWbCCubuaK9SNHy1fkIO0wCPE=;
 b=HbNLeA7DZsOgYK7QqRMu3q4fzOoJGFICqUVUkXoTF4edrhXgkFvR33nHTbPyn05pueuvMm
 N4z9MOMr7Ui58RjbD+1XIiQnnS3nf73kTug1mROhvhj30RGy3+exMTgSebhz6NZmeexasX
 A5Q6bH9BCJAaWcb8pueI6HmnXmwtSNGmo+u8Gnh+tW504nVJPVfEDfwMWiUzqnV1PLAZZb
 LJfdk9+bImtSdshFI4PjiKeibgXDPsNaiPA8nTF8twH/dV68UN1WK0INfujx+Pd3On6kL2
 pp9b7FqxrYZc36ix5sPvcUQ9PwgWyWadH1emPuWWMM8ooCcKEsHCLPVsDmuJaA==
Date: Sun, 2 Nov 2025 14:59:01 +0100
MIME-Version: 1.0
Subject: Re: [U-Boot, v2, 1/1]net: phy: add paged PHY register accessors
To: "Lucien.Jheng" <lucienzx159@gmail.com>, jerome.forissier@linaro.org,
 skylake.huang@mediatek.com, s-vadapalli@ti.com,
 paul.barker.ct@bp.renesas.com, marek.vasut+renesas@mailbox.org,
 u-boot@lists.denx.de
Cc: lucien.jheng@airoha.com, frank-w@public-files.de, daniel@makrotopia.org
References: <20251006124915.13647-1-lucienzx159@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251006124915.13647-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a1235248fe0a949073c
X-MBO-RS-META: 49u4pxgbjpwq7g8a46ypc171mgcfrd6u
X-Rspamd-Queue-Id: 4czxCb3swcz9tWy
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

On 10/6/25 2:49 PM, Lucien.Jheng wrote:
> Synchronize paged PHY helpers with Linux v6.17.
> 
> Add support for PHY devices that use paged register access by
> implementing the following functions:
> - phy_save_page(): Save current page number
> - phy_select_page(): Switch to a specific page and return previous page
> - phy_restore_page(): Restore previously saved page
> 
> Also adds read_page and write_page callbacks to the phy_driver
> structure to enable driver-specific page handling.
> 
> These helpers allow safe access to paged PHY registers by ensuring
> proper page selection and restoration,
> even in error conditions, which will be used by the Airoha PHY driver.
Are there any users ? If not, this is dead code.
