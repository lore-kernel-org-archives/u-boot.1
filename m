Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E997CA5FFD
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 11:46:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5322880969;
	Mon,  5 Oct 2026 11:46:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id veT-bfv-Oi_a; Mon,  5 Oct 2026 11:46:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 190AC808A2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791200789;
	b=pPg0Viq6lsGWpyhZjPueLFpGyflSaR4xdSyNJaarO8IhyKU/a6mPAmQjt1zapaXGgJyk
	 VMnSZqkkrLrsOeBpzdeDynHHNs4LUSEmK8dAhY3LFoAPU/GVt1GD08K7Qsx6PoQupwmEK
	 tR+1TvZXkCspwj9JIEzyg1TNkkuBNf4Y+lfNRPmxpuTW+Yb3f1r69l1Pjt7BRiMVZEjiS
	 uLFB5jB5iW8td85MKAC1NE9NcCYUglKnHaXc+EuPgd73DCrMG8wVv9Fzw42wxLwsiryBL
	 CDM6nReznTbqpUO7rU9ZnEzTBFDD4x329DGEY9autFtxWosnbMYW7CQYXI+IQXm6S6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791200789;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GZLR92SZPN4y8Ht4iN/4wr0f63JPEnzUoXeOi4vWruQ=;
	b=Xxzqlc7lK4oMuSNxbJ2Y1UOv8aWHV6QCpMTInLF7SE9fplgJQ9fcNRGN5SgERRoVi7r9
	 ZD00ZlGLtrIVku+sfPUdCtBke7Z82U8N5G6grSCbmE6Lb1Mkqv57D/l2tPw0ccAH8f4PW
	 OX76xLavvkn0TeZnW/GWCSdnr3S8e/iAqtCtiCDsnYnXZ/pnZzxYAqFXsw5CP65i5Av4j
	 HxVpob3GzPGkzO3pS6leSITgz8J86rxXAppiDiO/oIEAuQmRtg4Wj1RK9Fy+N+gVmFNJB
	 1f+YEhBNO/n7QoO7CYGAQZzbChBz0p/gbfRYf2TUvInG75BouLW8+hG2pniXv8Bod0A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791200789;
	bh=GZLR92SZPN4y8Ht4iN/4wr0f63JPEnzUoXeOi4vWruQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=izUznMiF1wDAaXO4jBUALpLPXiWq6pDvO96OMpTB4bnyWXE/oFfYg6ysA5+X2zx+Z
	 CMOxwA0obK16FI2HZWYIur8+btaZpeBpf4Ow73FQ3OFCDOrS3ekmXT6QZD5r0b8LFr
	 /tTDeSKMIBIYoKr1ozhWIfoNfBNzaPpga7rmzIhL1l9SbSN8dgy1FnVP76sC+ejaLI
	 ZzmcDr7cowq/dXJdHOrsc0zzXf+RjaNM4wqREfY32RQkqxzW5DXDhPva0FhBwEaw24
	 F1DapNW+9jSGec/o1WylweVfUOaxVt0LGAHZif77AIcHThfJAXlPOX7Y0G/XsQi5ZG
	 U82I9S1th9/Bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 190AC808A2;
	Mon,  5 Oct 2026 11:46:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F4D075
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4BDD640609
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:44:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U9-NZ6_xs7ED for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 11:44:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 28E1F40608
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791200695;
 b=L7K9a3/JSg9hDke19+vMAsEpa7IO7dmhHrXOzVt64d+wXbliwvR88k4v7nzvJ90xxw9W
 2p7WgZdoA70mWXFxaqjrRm7XecfBH6a7EY/NY168dI40GnuSx4XMrUKQx5uTbRBc0OTMf
 OOFcoPIR7XHtH8f/xiWIknKMXhZjA1qcT6os9QMVykVSM4aaGs7ygFRGswYpS0c6ySBJ6
 OlNTiDvY4YlkWPPlqLjIRbtgEIl3KWTe164gmw1C6chKE34qdsZXYUBmrQbsakWPEyvh6
 VvZStFagnUgBQAxY2p2BC0xyV5SU2wi8Nai9IVrNS3XFwzEPFlwieSyieRadTrUkcuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791200695;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=GZLR92SZPN4y8Ht4iN/4wr0f63JPEnzUoXeOi4vWruQ=;
 b=rns8rXZjFS0W69WsGQ+0B9br/f4vG5g0thCTDUCRsS1f92g7CHxvn02qnUh/CnNgFQ+c
 xWcSmcWxFrLe7tRg/t2hxaEKF07rI9Cbmg4tWD8NMVYPDbUoTilsQdb9DRi9/pURGDRaf
 BwyTD3LEK2SDbaO6t6jC55TIMWCHNnPsTIrw6JWuVIFWQbHvrc43h52jEKAOyDam0r5F7
 5NericmU4YJuE3cctRUMz3Q7NajwmnOqMI+0V/LFky86AuyHco91/4g5jK2mLWXPaN8yj
 TP1WhYT+TrhMc7rUc7PykWOZUMa1Xx/kFNe50KtUWnI+hZqdYxFIrG2H4V0vG5ffDsg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Y3KB32Hd; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Y3KB32Hd
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 28E1F40608
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:44:54 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hyyH7006DzMlRK;
 Mon, 05 Oct 2026 13:44:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791200691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GZLR92SZPN4y8Ht4iN/4wr0f63JPEnzUoXeOi4vWruQ=;
 b=Y3KB32Hd8Yv5CVBnwn2wtb9J8THPDY2uS6eLf1TexaiQ++CzV9Qra+Iu+w/swZhE+xT3o4
 EYxe7YuNoOmDuBiTuWnpuUytcGGI0kqQyPlXDbOmbp94Uj0BZ/lqx16CZN6ZCufxByzT09
 kgWycXE7GwNXhdSmAhpY4EOh9nxA0f1whD0fiY0uBl/AlfBJwkTXqYvCnC3rEVUfnNh0+O
 Yk/Xw6pPdArFSJ8pFwPsUgbXpz5Lgq2nEIyYCkcZl6I4bhIXWqKt8UyFqooTacLfG6xywr
 eOE4qi8N/5Fu8G/9peHOaFaVB37sngX4yKo80Z9gMDXMWY1E13zrYzoqqkWrRg==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>,
 Dennis Gilmore <dgilmore@redhat.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH] arm: mvebu: helios4_defconfig: enable device tree overlays
Date: Mon,  5 Oct 2026 13:44:38 +0200
Message-ID: <20261005114447.741892-2-stefan.roese@mailbox.org>
In-Reply-To: <20261002-helios4-overlays-v1-1-2e03eb306e38@iav.lv>
References: <20261002-helios4-overlays-v1-1-2e03eb306e38@iav.lv>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: z9x4kzi7pqrainzwpoekgtgz5i8and1z
X-MBO-RS-ID: 12c61f931ce0e9308f0
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

On 10/2/26 19:49, Igor Velkov via B4 Relay wrote:

> From: Igor Velkov <iav@iav.lv>
>
> Enable OF_LIBFDT_OVERLAY so that "fdt apply" is available and boot
> scripts can apply device tree overlays on Helios4.
>
> Signed-off-by: Igor Velkov <iav@iav.lv>

Applied to u-boot-marvell/next

Thanks,
Stefan
