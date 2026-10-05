Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DF4CA5FFF
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 11:20:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3EEE40684;
	Mon,  5 Oct 2026 11:20:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GJ22ZU3jj4O7; Mon,  5 Oct 2026 11:20:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DF27F4068A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791199234;
	b=KR79mLLSGvVJLplAhEipEExv2nGrdJ8ZIyCj/DqEhTYJcWsAcqxSQaTzgZNJjQPpE7zN
	 +mfk1NQUccPN9Ghwiqy1sLw/wyCgTZp+V37uA/gWLiq3We2DEy/bbeIDUwyOqknKyJiy/
	 9C8xE8iUban8E0ntaQ/9iy1Ixpm2QADMNr0t2iWswGLVOIy1LBfL+RcGbmE0iL+n2280L
	 /FvH8dn7XIBzkNWNTdP0yqVzRwx4ixSuavO9xkHSV0QuzbdnSqismUfhYIOwaQMzAs0m2
	 /fKbl2Y/UVDEPOblFc2oL8YI7FqKJ+Gmd2R1dOPP4YUgbAlHAxqy6O87gUbJiVCrb+g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791199234;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Wc9HJ96rbQjI1o/Qnn+p4ASWM3goHppGfuwbC+5niR8=;
	b=HNyrFTWldQfVU6aOagw9+hgv1fT+8AiTw5xxWp9wJIsHqJLCyhLlMRwdi9zaJij1//7Q
	 VjmUwtmPVdhKwtlsIqMULhlTB+oNmXg7cuki4wOYH4TUwPSeaSgg88JJNrAnFgipUVszr
	 +tfo67DtWugOfxzgMEs4YEGYo1P9f3AcWYLSjibm6rUuxgRjaR7rl2MAYVWzeO8Gq0nNi
	 oGQyWu0cz4KRv2yr1A1LFIDZN91o2J+rzMH9ybpipc3vXyss2HaVKiW7WNK2PfyW87XXl
	 muVJZ2nJ9OcDDxuNT5f4rKEIjbnZcuIyTyHR4nr/OVSCjJVTGqQP9vgQ3nyowflu6vg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791199234;
	bh=Wc9HJ96rbQjI1o/Qnn+p4ASWM3goHppGfuwbC+5niR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GYd2tbFhdJoAK8CgUSeL5AlSQZ/t5jF1R1fJLJDs3P2NZH5oVfjlzkyv4XhxDIfxi
	 5DDKs1kFnMfhQYQwyRHa+EOt0Vl33hGu56yt8WwqzJBvwiQ2AdM1Z0gvrJ63i6KD4w
	 KrNrkHQJX7yvoDRP/NxprNWZvKKN/bV4HLSauqXhwY3ZClimcBzOhtyJuCkhJUw+DW
	 dVPg3OzZVqB3S7HwHslE/AqDN4PYoxHDF4kS+I9WMjPJwhTUMTHgEDkrOe66S9AT4r
	 Hf6oikFdOSJbaL2roCcdBtcxB5XGJ6WfG04kDceOTWIbC2Kts4Txe8v+RHjRPpXjbc
	 tkGGlp9oNf0HA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF27F4068A;
	Mon,  5 Oct 2026 11:20:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D784D2E0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:13:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C6A6C80A86
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:13:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PF-gH0fCJN4F for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 11:13:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4579980A58
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791198803;
 b=TX/1t1GH3vBPZDhM/CxkrFGXDA88biaLV/1IxYP420oTT6TC89BM35tpXPEsvIsNJ1Uh
 HUJTSroLEW8YlZiFR/RbVK8bGUksBrm/y/smfPrUyUi2vSTuOH57Zqtj3wMhDetQrD//P
 Jn7ehUvmBglgws/S+OtFktpgS+DOGNnmUDtOw6/iRXI6JDPKsEnvee+xEAeLRIBpPunTA
 yz2XLpkiNMYuhvEMHJ3aDso4bWWbEroGIc6irzFMpnLYrWtOAbwBxxtmycamoyo50sV5Y
 SihH0uq7A6Gfw828aYw1bFQ8zplW5eqvuUTmmKrtwRwfmFiD//njCKWBf6DsKwEeu4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791198803;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=Wc9HJ96rbQjI1o/Qnn+p4ASWM3goHppGfuwbC+5niR8=;
 b=ou/1SyLZAxmWDgX+mwWA3xGUCV8y0n7JQh7Hq1hA00d7jPtb3cRWJe1u2zP7HIPRKkiV
 B1n1uMTlRC1X/fx+KoeIczTRjjXeRj5S0m93x6gR2mj7DTHegZmeYi+ERl9IEMNDwgHX8
 zL7LdGhx0FeuC+b14E6v1IthbeODuys0P1Zqpo98KRlIKtagqWOzT2zPqNWbBjl58X5M/
 1jQDRI/hcBDvwMVIhQLP2DwpD2Bs5SCCSjHTbiJjYAu9ufs3mFHjIYt1sWfwCDhKzARei
 pd5hns7kLEtj6dKuU2zUP5JMBcfC+IbYpkWjWTj33xYTPVzK3JIP9MhASMIDWzfzKvA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=cJ52vCkd; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=cJ52vCkd
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4579980A58
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:13:22 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hyxZl31ThzMlJQ;
 Mon, 05 Oct 2026 13:13:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791198799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wc9HJ96rbQjI1o/Qnn+p4ASWM3goHppGfuwbC+5niR8=;
 b=cJ52vCkdgVZQVFDzjIGDbURMwF4U0evwNjAc0sxsxHZJysHHD8WEpNBFp5QrNUnJqr+mhU
 GPxmKpOBaV8+dr9ur7avth9a3sjnWLIP0TzoGKAAzugbg+CyKMPCNxdVHmgt5Mpz3QyQPL
 Knt8/AJgtxWXbI4cu8jrOREncfaFaYc3j5gjWpILq+L/O1qgxf51ThIf3MN6ej2zXlZBHx
 WbYSyRFszBXsUfbKAasTs6OToq2nIcBG+rnUpgjZPhIjbajKtErZ/0QCn8kvuPDZSaOyvJ
 2ZdQ8Je56jD/B8MuI12ihfSgr9FCaHi0S+pDxo76Rfyn6lz3xLwPjMK9E/inHw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH v3 2/6] watchdog: wdt-uclass: report effective timeout in
 start print
Date: Mon,  5 Oct 2026 13:11:53 +0200
Message-ID: <20261005111314.719129-2-stefan.roese@mailbox.org>
In-Reply-To: <20260818-rinta-watchdog-gettime-v3-2-423f5caf526d@nokia.com>
References: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
 <20260818-rinta-watchdog-gettime-v3-2-423f5caf526d@nokia.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3624952b1596f54aac2
X-MBO-RS-META: 6xydxmo97mn5qw5qz4fnnikrgu3g3p9j
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

On 8/18/26 10:43, Juuso Rinta wrote:

> The wdt_start() function may be called with a timeout greater
> than the hardware-supported maximum. This in turn can result
> in a bogus print, for example, if the device clamps the timeout
> to 10s but wdt_start() is called with a 60s timeout:
> Started <watchdog@> with servicing every 1000ms (60s timeout)
>
> Add a max_timeout_ms field to uclass-plat data, so drivers can
> set the hardware-limited max timeout value there during probing.
> For drivers that support this feature, the wdt_start() function
> clamps the timeout_ms value before calling ops->start() and the
> startup print now shows both the actual and requested timeouts, e.g.
> Started <watchdog@> with servicing every 1000ms (10s timeout, requested 60s)
>
> The timeout comparison is done in whole seconds to avoid noise
> from sub-second rounding.
>
> The value defaults to 0. For drivers that do not support
> this feature, the resulting print remains the same as before.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Applied to u-boot-watchdog/next

Thanks,
Stefan
