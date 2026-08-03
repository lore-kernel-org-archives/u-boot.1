Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323E0C55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 20:15:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D06FA606B8;
	Mon,  3 Aug 2026 20:15:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ENsLTIAwrfRY; Mon,  3 Aug 2026 20:15:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B50F60601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785788112;
	bh=jUGj/vOALUMItTPmXFHVHQhgrAGxb0iK/Amz3BNYpUE=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=lqoVyaFvGho3pTHZGxM3oxOKUrmzgWDQEKoZLENGQM/xTmLsJxeOr7weQjQENWBkc
	 7jwis1YsjKBZxGQe/4lC1FPBN/vVJOw8YhYLFdXHrcVK0j0qXKhjWmDmVe4rTEuEWC
	 7iu/sRpNnfXiwWlzKNXCwkU8TEuCkKH8E/5OUwCEoQMbx9QGltCydnzAeNEQ5dUZ6z
	 SCMAumHa/giv6B5Q+/Z9YK6kCNZlEMtdhknkXuZLUhoQUjY7dOdydXFVUk1QJupPhh
	 EzRLBV4wXcbHnBu68NyAk+q4+H6XfrMTeTBlxR48FpeRNFG+SZ+r+oZPdkMx5WYXHH
	 ONnfnco84Nspg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B50F60601;
	Mon,  3 Aug 2026 20:15:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 22C70296
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:15:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1315A80AF3
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:15:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zdNXqIhzuUnE for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 20:15:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 472CC80B63
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 472CC80B63
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 472CC80B63
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 20:15:10 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9867C8467F; Mon,  3 Aug 2026 22:15:06 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCC6D80087
 for <u-boot@lists.denx.de>; Mon,  3 Aug 2026 22:15:03 +0200 (CEST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hDSZs3NzpzKw2T;
 Mon, 03 Aug 2026 22:15:01 +0200 (CEST)
Message-ID: <62fde4b6-0e0c-4507-b081-a8473090e692@mailbox.org>
Date: Mon, 3 Aug 2026 19:05:23 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] usb: mtu3: wait for TX FIFO to drain before disconnect
To: David Lechner <dlechner@baylibre.com>, Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Bin Meng <bmeng.cn@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>
References: <20260720-ccaione-upstream-mtu3-tx-fifo-drain-v3-1-45c0e072b64a@baylibre.com>
 <DKDEITT18XJS.18WZM0Q9PGROO@baylibre.com>
 <4de93606-a4c1-4b69-bfc9-328c2aa29c4b@mailbox.org>
 <DKE9GVL7TX0W.2VF1JM6SOE2I1@baylibre.com>
 <a5ef6e24-cf8a-4463-aea0-8533de3d7521@baylibre.com>
 <223e00f2-4a77-40af-b7c3-2226f5a5bde1@mailbox.org>
 <eee9d4dd-a9ee-477e-b748-020577040f0f@baylibre.com>
Content-Language: en-US
In-Reply-To: <eee9d4dd-a9ee-477e-b748-020577040f0f@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 9d7a8200dd617ac6b51
X-MBO-RS-META: q8np49teeozpurtmqshr34df7kwrmy53
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785788101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jUGj/vOALUMItTPmXFHVHQhgrAGxb0iK/Amz3BNYpUE=;
 b=AX0gXH2UoXetFvUtYiG+CiB23tD+8r/SyuhF2YonA58N095Xk+8TaAflsjlU1geU0gsMCF
 u7sZ0wSOguHmd3EAzp0A73+Hq1lR2apRi9FZnAUFRh1eUNUyKcunAqbffyNarAoltQyssO
 uDAv9mP1B/SkdXuGQEWL0ztPN1n6Usep14pSxUn9GSmtpp6RDrgSn2TMUc94tsMJCkvzBy
 LipuNaNq/YwjlhyS3m+CjdFl39MoSUPG066G51AD/9GEd7uy321oxpW6N5FLt+Yi2X1Z0q
 Kw5NobhDylVx5yrlRumYt60mY54tXARDEKaMdNEDf/rXY3jfKZB/QnOT+uH3bg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=AX0gXH2U
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=marek.vasut@mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=mailbox.org header.i=@mailbox.org header.b="AX0gXH2U"; 
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

On 8/3/26 2:59 PM, David Lechner wrote:

Hello David,

>> Which other series do you refer to ?
> 
> v4 of "Add support for the MTU3 upstream devicetree binding"
> 
> https://patchwork.ozlabs.org/project/uboot/list/?series=515127

I think I commented on that one.

Also, are your concerns from V3 addressed ?

-- 
Best regards,
Marek Vasut
