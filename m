Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB02C4829A
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 05:06:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2EC287EB3;
	Sun, 11 Feb 2024 06:06:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rBsgxJQp";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="W/yWwe3R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0366E87EB6; Sun, 11 Feb 2024 06:06:13 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2162587EB3
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 06:06:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TXbCQ5FLyz9sS2;
 Sun, 11 Feb 2024 06:06:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1707627970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dl2u1HdLiSjWfyjpBBb4Vf7C1Ef70pqZW5ew5kiCZlE=;
 b=rBsgxJQpCTVTwSVvydRoi7EBmh1i3VejpZ4ijOo6f/lWPchiSRui1jkZT9AcYt0Jqpj8mS
 xo/eHhUCs40Zle8AcGaEYYu++fRELQNcR+DdSfClkAqPUmyubK+RSC/3/UZOTj+98NhTpu
 gf9KOW0EUdDolW8WK13J3otkS4sJFXQIB9QRdGv2t9u6QM/cMIP86YfgCRkydxs4aDeHAP
 p3wFB2xSZAgzcTVpiKIJX8HoaYsoD5J7xLx2S35l++hHS73oiWxXmytHML891ctrz73jwr
 7MTC6eH0obG6TboiqMBe9mAZJgiTNidv+BSurRou/nu8K9YTxtdooa0ky5HfMQ==
Message-ID: <89b2acf3-e61f-4deb-8e5e-3e764507b6fa@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1707627968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dl2u1HdLiSjWfyjpBBb4Vf7C1Ef70pqZW5ew5kiCZlE=;
 b=W/yWwe3RJnbiR+1yyt4mTd5ueyp0DupuUflupPbtJlmsUjV6XbzMfMNtliV0/YKUeF/GSr
 1zb5pt2hvrYo9HcJZPnZyE/NrbmLNi8lXdrh3pU4Mme5TyH0SXKi2U56SiNtEkqWYrjMEG
 iJThTrvOTaokvGu5th2EETC5Jl6f1KJnc1YERgvl6XwqVzimdhIDbWsn3L6u1Yo7EQoQ/f
 rXjfP6Bl+hfmv18GatBeYN9hFjj2/6bDkrMirMvmEDAnUt+Uh6CwjUFgbGSBUiyekzVyXf
 4c968BTYEXF6GCQJ1a5M6/hODw2zMadyn4ZDSfFh6FgnL5MF2MhdhvL6YAcG/Q==
Date: Sun, 11 Feb 2024 06:06:05 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] clk: renesas: Fix broken clocks on all Gen2 boards
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Hai Pham <hai.pham.ud@renesas.com>,
 u-boot@lists.denx.de
Cc: linux-renesas-soc@vger.kernel.org
References: <20240209211535.3313392-1-niklas.soderlund+renesas@ragnatech.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20240209211535.3313392-1-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3f92979d57a8b04016a
X-MBO-RS-META: s6binwiqp5gcosbbd8tgsbystmq7xei3
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

On 2/9/24 22:15, Niklas Söderlund wrote:
> To prepare support for multiple register layouts pointers to register
> tables where added to struct cpg_mssr_info. These pointers are suppose
> to be filled in at probe time and no intended change in behavior was
> intended.
> 
> However the new pointers where only filled in by some paths of the
> driver implemented in clk-rcar-gen3.c. The path implemented in
> clk-rcar-gen2.c was not updated leaving the pointers uninitialized
> leading to a crash when trying to probe the clocks.
> 
> Fix this by filling in the pointers in the Gen2 code path with the
> values used before they where moved to struct cpg_mssr_info.
> 
> Fixes: d413214fb748 ("clk: renesas: Add register pointers into struct cpg_mssr_info")
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

Acked-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # R8A7791 Porter
