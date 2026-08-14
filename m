Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383BBC5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00CE4606BF;
	Fri, 14 Aug 2026 22:44:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8aSmE30JA482; Fri, 14 Aug 2026 22:44:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6665560A86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786747457;
	bh=2DV94TYpfE5HKL+Hiyun7GWyf/i8cV1pXI5sIbaMukM=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=K49nnOHbpgbmi3wrVvGW/MGsx5/eLhfiY/LRznsDjB+0fbBcM4ssI3tadcbaZSOWn
	 kUnc/lGJlAQDiTY4//nWSUOKAdkTa04Eh135GMr2jAmhfKJDlE2bsSz4GRkVGtTrnl
	 9yaNTjADoVbGstKYF47vZcSC52A1doqnLsJyOfPW431awfpU19CCKahEgReZAc6BoL
	 f2vCTINY2doWdh4Rk5b80UqDV8ySI4VspgP3WshcofmA1y8viy5ctRwV7DUddTuAPa
	 RUyyjAWBY0PtMPrBY64PaGqPCQh/8DvczpGkHV3nS70L9w2EisWMjep1f3Ypl2sCs6
	 ef1CxQgxhNGwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6665560A86;
	Fri, 14 Aug 2026 22:44:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 579442B2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D9B540C96
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JpxbnOMFlI1S for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:44:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2B94140C87
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B94140C87
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B94140C87
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:12 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hMHMv0pW2zKryQ;
 Sat, 15 Aug 2026 00:44:11 +0200 (CEST)
Message-ID: <bd60441b-6dff-46f0-8c68-76fad11f887d@mailbox.org>
Date: Sat, 15 Aug 2026 00:19:15 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 3/3] net: designware: add r9a06g032 compatible
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, David Lechner <dlechner@baylibre.com>
References: <20260814-rzn1-2026-10-net-v2-0-ff03583dc2b0@linaro.org>
 <20260814-rzn1-2026-10-net-v2-3-ff03583dc2b0@linaro.org>
Content-Language: en-US
In-Reply-To: <20260814-rzn1-2026-10-net-v2-3-ff03583dc2b0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8jg9rpx7fcuqp6d6gpaiyf9podsh9p7r
X-MBO-RS-ID: dc94123d66d5760a566
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

On 8/14/26 8:30 PM, Ralph Siemsen wrote:
> The existing Designware driver can be used on Renesas RZ/N1.
> Add the corresponding compatible string to the driver.
> 
> See corresponding Linux commit
> d7cc14bc9802 ("dt-bindings: net: snps,dwmac: add "renesas,rzn1"
> compatible")
> 
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
