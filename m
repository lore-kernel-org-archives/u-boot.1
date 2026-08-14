Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE99C5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 22:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7CA1B60E02;
	Fri, 14 Aug 2026 22:44:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y5fUYvZagjRO; Fri, 14 Aug 2026 22:44:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C404460DD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786747465;
	bh=++Z73AQ95LGVFsNlwiTLOu4Lg86RPjPRRkHvVVj4Y/E=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=Ysif5oy77PoV4JdI18NefYVCzwR1vkI24McyI0tA2CEh2JnkJOFe83EwxQl8nnzdy
	 khwd9vQqdiWS8GqGerdAkziHaqNd9qdG573TktU8utg0D0LZvduDGNFCUlvH+F8Jqq
	 DJuj4MAnDd/BhTNpYXUu/xEJnwiDu7rbPuH+9q4hQjM3sr7UL63r9xRyZC8fSgDk05
	 T8J0UwA0YNCq+UHaLnZ3yCG2iTrsrtdHY0lqtUNN5hzYQiaYhPQmBP4H2odsWLaTG6
	 HxqwI5wiRuEUFDu54t24a01+xbGpNCxiy2rrj7qYxDML8T5C+BwqZ6ctaKIm4f8rXh
	 J5rmJPVZpeaTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C404460DD1;
	Fri, 14 Aug 2026 22:44:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EB13194
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 84E8C40180
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zXEafiaxRaYp for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 22:44:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::202; helo=mout-p-202.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7F3CA40080
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7F3CA40080
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7F3CA40080
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 22:44:21 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hMHN36gwrzMlGj;
 Sat, 15 Aug 2026 00:44:19 +0200 (CEST)
Message-ID: <ab4604be-aba8-4193-97b3-cc997ea05861@mailbox.org>
Date: Sat, 15 Aug 2026 00:26:16 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/8] ARM: dts: r9a06g032: sync with upstream
To: Ralph Siemsen <ralph.siemsen@linaro.org>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Udit Kumar <u-kumar1@ti.com>
References: <20260814-rzn1-2026-10-v2-0-56b6acef0439@linaro.org>
 <20260814-rzn1-2026-10-v2-5-56b6acef0439@linaro.org>
Content-Language: en-US
In-Reply-To: <20260814-rzn1-2026-10-v2-5-56b6acef0439@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: jpnxp87x1adw54tk8uufzf1gi5sfzbgo
X-MBO-RS-ID: 44cefd30d5224f1becb
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

On 8/14/26 8:38 PM, Ralph Siemsen wrote:
> Sync with dts/upstream/src/arm/renesas/r9a06g032.dtsi
> 
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
>   arch/arm/dts/r9a06g032.dtsi | 270 +++++++++++++++++++++++++++++++++++++++++---
Can you use dts/upstream/src/arm/renesas/r9a06g032.dtsi instead ?

Can you switch to OF_UPSTREAM ?
