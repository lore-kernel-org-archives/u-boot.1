Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C98C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 11:34:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94AD980CB6;
	Tue,  4 Aug 2026 11:34:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4EI5iQKHj4iw; Tue,  4 Aug 2026 11:34:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86B5A80CB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785843247;
	bh=RaAWygJf3S6Y1UASfaVZ8lgTxiLO/YDbH4et9OsxqzQ=;
	h=To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=pldTjANcHHNhB7XI3SMOlReum8ey3qOw8bcOoUh+GfUISUF0XbflYh5C5nCKwaTvr
	 +hcTqcFi7lpCC/YZ5yedURcHFijuU3oYc8wajBwE9Tqg9Q6+ipprU8MWSM6bWv6niF
	 T68tcDr3qStM7OG+G/nFtzUw2GR8Lkq1UgRqAkWM5+Sd2xpq2+YvLLffGseut/G1oN
	 wpHAf/iHeKcjUubXElney9OBrMkqxPkQZh/65m65nhix7X2JPiRsNiuUN5Gi3E6osU
	 sN03Y37dJifn9lxrwRtxMhwtDxjs9VinwZpwXw5XGwsjwlRZS48xLyLueOfgO5Jdax
	 b/iYXC9nSzjbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86B5A80CB9;
	Tue,  4 Aug 2026 11:34:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 34432194
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 11:06:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 27A1280B2E
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 11:06:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SfcWhDlpI-LR for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 11:06:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=miquel.raynal@bootlin.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9448280B28
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9448280B28
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9448280B28
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 11:05:57 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A2A782991; Tue,  4 Aug 2026 13:05:55 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0D2F80087
 for <u-boot@lists.denx.de>; Tue,  4 Aug 2026 13:05:52 +0200 (CEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 401111A13FC;
 Tue,  4 Aug 2026 11:05:52 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id EFF14602AB;
 Tue,  4 Aug 2026 11:05:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8120911C32B52; 
 Tue,  4 Aug 2026 13:05:42 +0200 (CEST)
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: <u-boot@lists.denx.de>,  GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>,  Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,  Michael Trimarchi
 <michael@amarulasolutions.com>,  Frieder Schrempf
 <frieder.schrempf@kontron.de>,  Mikhail Kshevetskiy
 <mikhail.kshevetskiy@iopsys.eu>,  Tianling Shen <cnsztl@gmail.com>,  Cheng
 Ming Lin <chengminglin@mxic.com.tw>,  Takahiro Kuwano
 <Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH v2] mtd: spinand: add support for Etron SPI-NAND flashes
In-Reply-To: <cade4374b7eba539dfc6c4b94b9c94560ded655d.camel@mediatek.com>
 (Weijie Gao's message of "Fri, 31 Jul 2026 11:16:07 +0800")
References: <20260609084435.56297-1-weijie.gao@mediatek.com>
 <cade4374b7eba539dfc6c4b94b9c94560ded655d.camel@mediatek.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 04 Aug 2026 13:05:41 +0200
Message-ID: <878q6mgn7e.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 04 Aug 2026 11:34:05 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bootlin.com; s=dkim; 
 t=1785841547; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=RaAWygJf3S6Y1UASfaVZ8lgTxiLO/YDbH4et9OsxqzQ=;
 b=rPUXxs3vfDc6E2vEjWN7v2OZKglvKPdqpVCtzrQvlWXtxamtHlLrJ9n3oLbSJ7BktnaIvD
 GXvwm8Fja4QiSHJ+saxT9tdvG6C5nsUKwco6FiSL+KNzcYuk34KZsMPqFRqPD9RnSAOgow
 4tCLOClQ9ROG09eFhTn4IPcxK0Ji/5eoVQRRORgjJqy2JAxQayDC9HEhm5+qU/jRJrskDq
 Y7z+iC29SpHuS6SJ8Zy2WUl0klBFfTXOP4XnoHO8GeDkAnsb6j5PPtkTdGA2Nx5OrWNmU8
 ecH6qEdJbQjBKwqQeosoG/iJkmHo+KGzqZTjrjsq5d2KOn3JWTDItnhahjMndQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=bootlin.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=bootlin.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=rPUXxs3v
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=bootlin.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=miquel.raynal@bootlin.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="rPUXxs3v"; 
 dkim-atps=neutral
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
From: Miquel Raynal via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Miquel Raynal <miquel.raynal@bootlin.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>


On 31/07/2026 at 11:16:07 +08, Weijie Gao <weijie.gao@mediatek.com> wrote:

> Hi All,
>
> This is just a gentle ping.
> Any comments/review are appreciated.
> Is this patch able to be merged?
>
> On Tue, 2026-06-09 at 16:44 +0800, Weijie Gao wrote:
>> This patch adds some Etron SPI-NAND flashes from 1Gb to 8Gb with
>> 4-bits/8-bits On-die ECC support.
>> 
>> EM73C044VCF/EM73D044VCO/EM73E044VCE/EM73F044VCA are tested on
>> MediaTek
>> filogic MT7988 reference board.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
