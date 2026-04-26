Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7116FF885E
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 16:24:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CB0D8407E;
	Sun, 26 Apr 2026 18:24:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="V0KwAacJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Dv57tvlC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 717F18410D; Sun, 26 Apr 2026 18:24:13 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6076C83FF5
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 18:24:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4g3X894q40z9tZW;
 Sun, 26 Apr 2026 18:24:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777220649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ueHT4GPZEhaWfgfFu4yNfJblAlSbyMgEF7jzrFclH+E=;
 b=V0KwAacJu5LzmViZ/FFowvxzyL0EMxMleXAg/nqkZUsCU0jP2F9OFFKWa40jkStuogAtg8
 O/2dTPbu0J+C8yZKcfZc++oUqsK2WP0ZQuIWKQ/59a112CVHZWulVwHdkPJRbtpk4Q7qzp
 PvidUPzKIMEkOR0F/nBoGdVhaTXzF18CwIxhR22s8K1/LHrlUEW+aThByzo1V2LPpRb3Ri
 TTg73kvb24VvRlKF/N6MBt1foJ0eXhSwGvG5gbVx/G6FeSgAz9qHoYggcR4K5Sn7Tpo/rh
 Tu4iiG4NQG/LDbIhWPfT+r8uQ0y22YxoTcKhxvi2UUXStjKFJqbmFJsJqc+yJg==
Message-ID: <a1e1a4ff-55a3-4d3a-9050-7df48071163b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777220648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ueHT4GPZEhaWfgfFu4yNfJblAlSbyMgEF7jzrFclH+E=;
 b=Dv57tvlC9o1Z9VgRX1gvKupOJ67Y8RWgqTQ0yjQJWOp0adPUkgfgPLKw+VxL+1JgHJx5Kx
 a0I0YrRYcgT68nIScNEaQiR9fu908qW+6jwECpB/E8TJhQU3AtsO/PFbMdNZZwNveLB0ug
 Oynd9oITL4LJtHWdMKG9PV0V4/uojEW35LTWdr9AVZ66Im5spdjPx3xlfiqq0BNOhHtaaT
 vXtUghdqR6NuMizSAWzVdi9BgJ+4CeXL2BhuthgWk2MM5NhUxbRt0tFxX718cOnQuAskoa
 w8TImNYE302BY7Qkw/WCYmZXJoe19Yp0PAsbqU5BFTanPbo6nyGbaer3Ochujg==
Date: Sun, 26 Apr 2026 18:24:05 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/6] treewide: move bi_dram[] from bd to gd
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com,
 sjg@chromium.org, u-boot@lists.denx.de
References: <20260416055948.130041-1-ilias.apalodimas@linaro.org>
 <20260416055948.130041-4-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260416055948.130041-4-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ab0cddf39c9034bfec3
X-MBO-RS-META: 8me8gzrc7k5wxc1yabmsuj4u8q5ub7cs
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

On 4/16/26 7:59 AM, Ilias Apalodimas wrote:
> Currently, the bi_dram[] information is stored in the board info
> structure (bd). Because bd is only valid after reserve_board(),
> dram_init_banksize() must be called late in the initialization process.
> This limitation is problematic, as it forces us to rely on a variety of
> bespoke functions to determine board RAM, bank memory sizes, and other
> early setup requirements.
> 
> By moving bi_dram[] into the global data (gd)
The change itself is fine, but the variable name should be updated. 
Doesn't 'bi_dram' literally stand for "board info - dram" ? Since the 
bi_dram is now in gd, it should be called something else, maybe simply 
"dram" ?
