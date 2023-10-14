Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D557ACDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCA4886801;
	Sun, 15 Oct 2023 08:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="V4g+ehXJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="XkzTNkoa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93D8E86F6D; Sun, 15 Oct 2023 08:55:48 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E76486F95
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:53:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4S7Gdh3Hqlz9sqx;
 Sat, 14 Oct 2023 23:26:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697318776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=th736lg3MXHn45Sp+NrxJi02vWJP+ud7Pmr50lqy7/s=;
 b=V4g+ehXJuQvWTiAevULG5GTbPauCO2D6NffNdCNnOu6Q8Kgmmyu794QyfZ60uOMD4WCehv
 UaXtp/1CoPieL4IsDuXKg+mL5NknUtY9uwHFFko+cLZVFehMVJb197NiUNgyFGB/nv+BiX
 1YJab5M4INY1fOEjHwHVtZpOGmgFyi5LdoVl0sEduFO6QI4qYXg1+cZfYZmHlWbwfdfJeJ
 237Y1a2GFv6atBspGkTkmAIkztfBRnlLpIrjfLx+SX5dM/QaPiREv8RxdyHP3/lRxNPCYl
 oHAGHggLk7CESU+ep16o4BnkcPvLjz9bcNWbS+HIWP/U+QmEgq2GJHnFDlvDIA==
Message-ID: <c4075b6b-26a0-4abf-bf9e-271e6561ed31@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697318774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=th736lg3MXHn45Sp+NrxJi02vWJP+ud7Pmr50lqy7/s=;
 b=XkzTNkoaf1grhH/1/g7/u6Yi8Ph+NiM+DCjEKEXuYkogeYoYgBYafvGHu5iYKck4NZjotP
 xvagbTiOvR8nB6d8h/di5nFck/xVRdqGtm2xmLdlFE1Sschqi1v+0Kqqox4mcS3j9SUX/3
 44EL+PboH8GNaMhJ/ItOPqsGWF65ThZ/UHAZ27aAwTiA+R/6Qi4FCoXObQ/ohXHEW+kX+c
 sIGfuQGcKmMaxNZ+Z9PurNgNQ36JKm9rZB95q1A+SVMtJAiIdM5g9DA0x2sRndqAXXk1l6
 yRqujNozAKdZawNyKvCgV9fUO+F4+diEPTvaFF62A6mAmxkxwZwIwIG06dnVmw==
Date: Sat, 14 Oct 2023 23:26:13 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 11/19] serial: sh: Fix error handling
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
 <20231009164645.164464-12-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231009164645.164464-12-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 195969a4fca4abb594f
X-MBO-RS-META: juocp4zhbki5hy5amrzfy1xgawgbpjp1
X-Rspamd-Queue-Id: 4S7Gdh3Hqlz9sqx
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

On 10/9/23 18:46, Paul Barker wrote:
> The current SCIF error handling is broken for the RZ/G2L. After a break
> condition has been triggered, the current code is unable to clear the
> error and serial port output never resumes.
> 
> The RZ/G2L datasheet says that most error conditions are cleared by
> resetting the relevant error bits in the FSR & LSR registers to zero.
> To clear framing errors, the invalid data also needs to be read out of
> the receive FIFO.
> 
> After reviewing datasheets for RZ/G2{H,M,N,E}, R-Car Gen4, R-Car Gen3
> and even SH7751 SoCs, it's clear that this is the way to clear errors
> for all of these SoCs.
> 
> While we're here, annotate the handle_error() function with a couple of
> comments as the reads and writes themselves don't immediately make it
> clear what we're doing.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
> v1->v2:
>    * New patch after discussion with Marek & further investigation.
> 
> I'm not going to put a `Fixes` tag on this, the error handling has been
> writing ones to clear errors since at least 2007 so maybe it was
> originally right for some board. It doesn't seem to apply to any of the
> current users of the SCIF driver though.
> 
>   drivers/serial/serial_sh.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)

Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # R-Car H3 
Salvator-XS
