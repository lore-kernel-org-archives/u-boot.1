Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F76CA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 11:20:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CE814069F;
	Mon,  5 Oct 2026 11:20:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AvxXBRrQiMR7; Mon,  5 Oct 2026 11:20:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A4A0B406A0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791199236;
	b=APCDL8x9Dn7j9l9gpkzt3WZcYSBPYKnK6uj7u4oDVg0ld/LE1IKOlujEwaQ431BT32Gy
	 aRwZpapcgpAYmbv8sNF9exsqvvM3QwZHKaoZfJ6EANVTU/hpD6CmxvFk5xoTrSK7KgSeu
	 RbEHrDMYRg3jFUUeeNoChyVgy4dtIM/syaz5B3v4Rzur+U2khFlo/HEIVRNVbK1s050DG
	 3g2mmB6KlR8uFzRD3cShUCqKfx2xfWtQv2bGAlvvY0nc7+K48yaKpEOdmXMEJj0ixtJeE
	 CBFoXwK5GLzQG85mgKRYVnuHAf2wATFRZNxvfxVNttTaGbQ4jspC8DuWW5gcU3HR1Qg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791199236;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=z+8UmPY57oZViylQ/LsxBkefjoeyN5CVzEu5e3jWOe4=;
	b=OZl3qDTS3xLiO8WJMvCxqdLxAvOowStCG3gp9U9oaAKdiGhGZaxQ5zfVNo5EzTUVQjgp
	 E2L3Rif5TyLLO/yHidrDyguU6Bw9VbNno2FjqfNOzU4Duwdvva/OpBcIe39G+4WE7oWAS
	 8S22WOVpv01ADkcq5GOTcfTGWhTOVWOOwzSldPsX2aplgBS4vhnOI0HrzsyWih0jlZWeC
	 m509yHSpr3zZWqPtmtd/N79Cx/aPMrzBdmnMjFyi6rr5ltMGsl2tfXGsRQjxO35INric4
	 j8+n0pH/cmUM8IZiHJTjSx/YYIflc8IJsT+NXCtUAnm6neLIaI2ercTixtKudEPaGtA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791199236;
	bh=z+8UmPY57oZViylQ/LsxBkefjoeyN5CVzEu5e3jWOe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I5yTj1ona426PTAyXxJgcmbk5lGbp1hyOZ7qqWMIGE9kGlsf5R9T0mg5Rz9jitrXQ
	 Hq3nGm45GuGheGr30PAZh+uM3/bPD2D/CnKxGm1gvlHGnY2soX7K25bFh3uVkSPuh2
	 7kzL6eZG1moQwY5XDjRYqV63+jIaL/El1F/fHNIRMg5OcFMElFoUHG0jLIHqqAsfeg
	 fc7ghvJN/WWZjnkeahlDTR10JkISCBaOF1RyYCWunYg2FN10gkS6f3I46ZEPZeUZgY
	 FoqL0HqT5/hQlX9pvy3LOf86V1AaGp3W6IPw2nGUKdRgXTzfc73sbKzFW8VAOMesG2
	 FNqHuwTmMT+JQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4A0B406A0;
	Mon,  5 Oct 2026 11:20:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 89DB72E0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 769FC80A86
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:13:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xTLWs71i5rRK for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 11:13:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9D29480A58
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791198805;
 b=tVUk4GRifmjhtZtZdKWLs11VJGgibyw86I7x2ICVbB0kDXfMUSFD0eAYPJOXAaUXY6BY
 tCvywh3uuY34tZGpte+YMJfP8+e0LDBO/1ICtBOlOF8nYQ/WoPUNAeQlqpKUz8Co53ISD
 LTCR7bMCcciZjJNmU9JjOifibYYUwLhZQXa6N8dtXQgj3ec1heboKgQGl2gs9IpDJHbSH
 Opr9nVLwcuFH16/TMwEXgeiVTA0iOp/XkThXMgDKB8R0mBeC3P2PPIgRsEY11PRQO3Gul
 fEWJZq1r+83+Gayv1cVEagdzr4PUnmGTFJTr/u3sonVI27yhjyIGA48/EjlAlete5gA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791198805;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=z+8UmPY57oZViylQ/LsxBkefjoeyN5CVzEu5e3jWOe4=;
 b=V3FY5oSGMq1YGl0dpOU6bfoqk3bol8jNLnB4Iym9xQwnBOTffFgCXw30YZaZNlVWBc3+
 fx8xQOrQeL1OirBPaDah4Jj/6lzYzUVLQ74jziBb4e5fEYM9fck94vmkMPTiwjUTzKZCP
 NPKzvUi+Qcn/Z9DSGPo9q2EY1oPbk+cTGp5OEQ17pzKZTdMYJnnFuojV169Glb41P7Z/T
 CyQId+aCu9gH074HR6OYn0rR2erXutzo0Aa3L29jG4U4GcHL8dseNjIoNQCz/BD1W/z2c
 wKuVHiKD2tuDNwUzY0xQBQhvzoo7swhHZ9cC4gpKwE9gw6J0UdtLowYi1l4xZvEl9tA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=QGVGOjcb; 
 arc=none smtp.remote-ip=80.241.56.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=QGVGOjcb
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9D29480A58
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:13:25 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hyxZn59CKzMlYt;
 Mon, 05 Oct 2026 13:13:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791198801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z+8UmPY57oZViylQ/LsxBkefjoeyN5CVzEu5e3jWOe4=;
 b=QGVGOjcb8GFZi3QJNXo2mvdQa3lGUCuXlor8w4r6osqVaNA9rG/ajHOvq8os75VNg3eiu5
 kttblGzcyqiKyhvKK6u425nREHoNulljsYck1/hpHAyOjhnyo5aAeAg6IXSn3f3C/3/qAz
 7FHtnG35Ra4/5PNZkzK/+O5pv57ttjBPgzueQaBnFX2HKeWotE/Lq9DCqulduqUCNPuK6H
 HnOYDpsjnMW5AQ7vr23tFa57mCtcfOxd2PkCAdJs5k3tM+iiUSNoQWqrGq4V6uuupSKV5U
 NlxITrOk9bdGhxz/aXV1V1OhpKPv4lvUbWkFEZa+IgzlAhXwgtTxfseRTJ7jFA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Antonio Borneo <antonio.borneo@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH v3 3/6] watchdog: sbsa_gwdt: set max_timeout_ms in probe
Date: Mon,  5 Oct 2026 13:11:54 +0200
Message-ID: <20261005111314.719129-3-stefan.roese@mailbox.org>
In-Reply-To: <20260818-rinta-watchdog-gettime-v3-3-423f5caf526d@nokia.com>
References: <20260818-rinta-watchdog-gettime-v3-0-423f5caf526d@nokia.com>
 <20260818-rinta-watchdog-gettime-v3-3-423f5caf526d@nokia.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: fdcbye89x1mwp7b1iaze36eenf7wnqkk
X-MBO-RS-ID: 2115cdd10972b95f6d3
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

> Report the hardware-limited maximum timeout value to the wdt
> uclass by setting max_timeout_ms in the per-device uclass-plat
> data during sbsa_gwdt_probe().
>
> The timeout is programmed via the 32-bit WOR offset register and
> lasts (WOR * 2) ticks, so the largest representable timeout is
> (U32_MAX * 2) ticks. This is converted to milliseconds using the
> timer clock from get_tbclk(). The value is set only when the clock
> rate is non-zero.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Applied to u-boot-watchdog/next

Thanks,
Stefan
