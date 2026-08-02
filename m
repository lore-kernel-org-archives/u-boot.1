Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB65C55179
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 03:51:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AC7880D05;
	Mon,  3 Aug 2026 03:51:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 53zM46NpTo8D; Mon,  3 Aug 2026 03:51:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A0C4E80CED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785729084;
	bh=dWBpfjIfgNqAdEdyxxV7+dxoeBlPPFvJ/CYd6FN8E4g=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=GD3L+9ICEUJfkUga2OL6Uc4Noa+zMYRWHQsDkvPLbMOJsvEmA3KbV/UbZ1GDpqA3r
	 0TewBpX8YI/iOvZQUFnWKqkzQ462c6PKCjR3shcWQ3YiJXV4egT97OJgpLFTCr9Z2o
	 b2078W0/pG9vkOJBanSrqz9JUjpTCbWzAEnI4wbZCjhibCIB5mbp4MvcncpttOf0V3
	 oF9rHQldSLlETNEZOy7+48D9iW1JyAXQdJfEhtUqnTDPBg9lDfnCRxnsfYcVLxuK0u
	 LG3SNw1SU9Ab5gjRudlnGQ921O1aoYo3DpRxi4G/uHZ6EjtPeQmB30ZJBAF31BgrSC
	 ANfZWj2xzdqeg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0C4E80CED;
	Mon,  3 Aug 2026 03:51:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 29E602CE
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 03:51:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0FF266067F
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 03:51:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Eejl0wRiRwV3 for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 03:51:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7F93060615
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F93060615
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F93060615
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 03:51:19 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42773846E2; Mon,  3 Aug 2026 05:51:16 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17C4480087
 for <u-boot@lists.denx.de>; Mon,  3 Aug 2026 05:51:14 +0200 (CEST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hD2lh4K92zKnXl;
 Mon, 03 Aug 2026 05:51:12 +0200 (CEST)
Message-ID: <95be392d-985f-4046-ad38-523063d89037@mailbox.org>
Date: Sun, 2 Aug 2026 19:30:25 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] usb: mtu3: wait for TX FIFO to drain before disconnect
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Bin Meng <bmeng.cn@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>
References: <20260720-ccaione-upstream-mtu3-tx-fifo-drain-v3-1-45c0e072b64a@baylibre.com>
 <DKDEITT18XJS.18WZM0Q9PGROO@baylibre.com>
 <4de93606-a4c1-4b69-bfc9-328c2aa29c4b@mailbox.org>
 <DKE9GVL7TX0W.2VF1JM6SOE2I1@baylibre.com>
Content-Language: en-US
In-Reply-To: <DKE9GVL7TX0W.2VF1JM6SOE2I1@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 6056c8dec62eeb9f8e0
X-MBO-RS-META: wie9byx4jus5757iqe9h4o431ed36uah
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785729072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dWBpfjIfgNqAdEdyxxV7+dxoeBlPPFvJ/CYd6FN8E4g=;
 b=h6XWyGKZD/B2nAvEF22W3kibulz2Tg495QYfpPEAwzYAcltoC6BoVMTp65e4/TY49OsOTE
 1eCaWCK8prPskPFT64QAEy7Q1g4DaSELpPz5oOUTp04jkQjSyZgsEXH3ZcFMjNubfBNcFH
 EsnPk8/KHxbjjKZGQMU/Y+ggBR/Ml3mKuRzrsDV6FMzY5l4vbmU4TAQeJ5zul821dmrabn
 HHBvBlrZathwJxQWSaCIFNhOJcQ8jg/kNrnq1eUxQZkuHSflkNfdVlos6RpR83JKL7B1pe
 FhSxG8Nz8ujWklWuEJDrZR4CxFE0eRF18qeDq+8gcDQucEqGKOOzF3eNjyWb+w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=h6XWyGKZ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=marek.vasut@mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=mailbox.org header.i=@mailbox.org header.b="h6XWyGKZ"; 
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 8/2/26 8:57 AM, Carlo Caione wrote:
> On Sat Aug 1, 2026 at 11:52 AM CEST, Marek Vasut wrote:
>> On 8/1/26 8:42 AM, Carlo Caione wrote:
> 
>>> Hi Marek,
>>> can you PTAL? Thanks,
>>
>> What does this mean ?
> 
> Please Take A Look? :)

Please avoid such random acronyms if you expect others to understand you.

-- 
Best regards,
Marek Vasut
