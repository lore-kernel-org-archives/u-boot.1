Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7332EC55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 16:26:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3AF9980BD7;
	Mon,  3 Aug 2026 16:26:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id elHQU91j-acN; Mon,  3 Aug 2026 16:26:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B49C580875
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785774372;
	bh=AJ5tWocCQsWl3XuSMzIAbkYFLc69uO3U2NVhAv4CPQI=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=XzuM+pGWU60B9d9TfrCp/BJd0wThEoweJGP9QEdCzb9fjtw3idrndUkLwhMPDbuAa
	 33iMf3zqtuuj7uVa27A+jqLx6BmGBSCE/s/uncZIoJEfbtxTTUTS8SarDji8SJwYTW
	 4i/P3WhAIBO3j18v3UoRB1WINygmsUECDg1lBX+vA/WllBAy0NRybPqqwKsIhNJShu
	 6E5OdzHhuANaDO4V9p3P7WwsreqzanGscbZVmO0Hq1n6RhL8r5fKizUCHfy9NpQ77l
	 M3zj44tp5xRx4XgrHOdSmUUJX0mv5aLSMigNK5RpcA8cd3hAJLD5BHuTN8SUCsY4J4
	 GN6qhApriXb2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B49C580875;
	Mon,  3 Aug 2026 16:26:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D57FC389
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 16:26:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C7AE140402
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 16:26:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q9sdGyuBAPrB for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 16:26:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 034F0403F5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 034F0403F5
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 034F0403F5
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 16:26:08 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hDMVh5TYTzKn8k;
 Mon, 03 Aug 2026 18:26:04 +0200 (CEST)
To: Ryan Chen <ryan_chen@aspeedtech.com>,
	u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] watchdog: ast2600: add AST2700 support
Date: Mon,  3 Aug 2026 18:25:58 +0200
Message-ID: <20260803162559.3212020-3-stefan.roese@mailbox.org>
In-Reply-To: <20260702-aspeed_wdt-v1-1-1c44c38430e6@aspeedtech.com>
References: <20260702-aspeed_wdt-v1-1-1c44c38430e6@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: hsordnrkg9ouj961wsx9kgfw73xkx3i7
X-MBO-RS-ID: e63bfa7c1e5a074419b
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785774364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AJ5tWocCQsWl3XuSMzIAbkYFLc69uO3U2NVhAv4CPQI=;
 b=ycMEGliHuH0aRiUV7soEHuERTRnUGBKtCVJeUXQKYPn1m/RZ2/7ihidqHraWBNXGD2N+iy
 rZIIXURlgRFUvJg3DAGWR5hkvUul9B7jg4T1TMvFu2TBeBxuCyqRhM9jnX45QBe2MZx04O
 y8CxYBDxs4YTlDn9XaJ/0jzKEotIpC+qGaOVuGFNtSfZbn9QqvehvdMhIVgMC7MaGS4NLx
 XXlO1D91OFW2lkJJFc9CJIMefl7EMhe9+5y9f+Qe1V4SQiSn/mY7QfbQUkKb93Ov2giHFc
 FZtFDacOHQ7f2HlbAOlIjHRaSaknqDbGSnZAdFi88afnB3gN8tpIGIkYho/icQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=ycMEGliH
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
From: Stefan Roese via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Stefan Roese <stefan.roese@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/2/26 15:17, Ryan Chen wrote:

> The AST2700 reuses the AST2600 watchdog block unchanged. Bind the
> driver to the aspeed,ast2700-wdt compatible and enable WDT_AST2600
> on the AST2700.
>
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>

Applied to u-boot-watchdog/main

Thanks,
Stefan
