Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA02C5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:44:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF9AC40CCA;
	Fri, 14 Aug 2026 22:44:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0SHdHBlMRaEV; Fri, 14 Aug 2026 22:44:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DA01C40CE5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786747468;
	bh=pLvYhv1jTW3YDMS2XAI7XHgpt0w330zNN8JOfhQmDk0=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=tWSGBufvXIuiMgSgNoMhteX8SyolKlcNuDYlZCuzTXNsVPtT4R9e6O4tYubfzj6wh
	 zqQtbtJtzF0wH+T5X6ov7TKoueRNfJwffg/D//Pj+NB+oREWHU9v1Ud2I6Avss5lNR
	 w7y5aGUYEIYqBfrO85QMRmpTct606HUMkDRVH72Fm/+G0wS8x0IdHy5WzpSd4XBfND
	 uuk2mmYzG1P7hM5c86BLQJafvNrFx01vKUiGjuf8lA1EmetjS1Nb7Uq8ArUwAUXT6h
	 W06lEiVOBtj1IqPipJlMHZKfpYp8bImLCwY+4Xq1oKHbv3s8W+76ez9yjj6Y2356+X
	 Rtv8ILB76GhpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA01C40CE5;
	Fri, 14 Aug 2026 22:44:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FF99139A
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1219360DDC
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cwXexoS05BGT for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:44:24 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6ABEA60A86
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6ABEA60A86
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6ABEA60A86
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:24 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hMHN62FCdzKryQ;
 Sat, 15 Aug 2026 00:44:22 +0200 (CEST)
Message-ID: <3ed59460-f04e-4eff-8839-bc766fe52292@mailbox.org>
Date: Sat, 15 Aug 2026 00:28:01 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] mtd: nand: add Cadence/Evatronix NAND flash driver
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Brian Sune <briansune@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Phil Edworthy <phil.edworthy@renesas.com>
References: <20260814-rzn1-2026-10-nand-v2-1-7aadfa5ca3d4@linaro.org>
Content-Language: en-US
In-Reply-To: <20260814-rzn1-2026-10-nand-v2-1-7aadfa5ca3d4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 9ab1ukzy58qkyapiodnmkmsjnwmejm53
X-MBO-RS-ID: 75a88442c116e81adc2
X-Rspamd-Queue-Id: 4hMHN62FCdzKryQ
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/14/26 8:31 PM, Ralph Siemsen wrote:
> Driver for the NAND flash controller in the Renesas RZ/N1 SoC.
> The IP is from Evatronix, which was purchased by Cadence in 2013.
> 
> The Linux specific code has been left in the driver to make
> it easier to synchronise changes between them.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> 
> Taken from
> https://github.com/renesas-rz/rzn1_u-boot/commit/76c8d3bf19dc64697dd964d7f69ccb3f4fae0094
Would it be possible to port the mainline Linux driver instead , rather 
than some downstream one ?

drivers/mtd/nand/raw/renesas-nand-controller.c
