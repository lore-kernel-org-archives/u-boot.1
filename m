Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BF0C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 14:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF96F81951;
	Tue, 25 Mar 2025 15:24:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JeXnF3JN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="w/uhf4ZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93E2A80EEF; Tue, 25 Mar 2025 15:24:24 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95BDC819B1
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 15:24:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZMXHB30BYz9t8B;
 Tue, 25 Mar 2025 15:24:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742912662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C9tzrV/Y97/j8lSCCrrM/kh8mFa1ttYFuMt6D0P3dXQ=;
 b=JeXnF3JNmtXJxniHgwnKEFnwSmeNd1bXrCS7GsPz0exPsa4u+rK/ChsfW+0q/yahdLtnVW
 P3Hbi+ccSNmqepGqM0KkPtQLQuFKVjt23bqBHz84LcsWgoWCf2OcoEqOPjfx8UdmCjvYFe
 V6Z+e08ePUp7Ih5ddz+3Er0Oxpf5CHuJnBLnNPXm0HO4djRMChlZWSnN88J2O69MOVYQxx
 SO5pg+Mc6uLba9ZhsR5gvGNwYdjqv5ckTqvOuySmwxlJhdXhsyBv1+rGzAr2VB24cly8Jp
 6shWjP0oakyYAKVfIin9bwuU3gpy7y5uuQXdUi7Pw/FsWy2UjuZGIlyzfsJmQA==
Message-ID: <5005e7ba-1b9a-4d49-9cd6-d48a8341e436@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742912660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C9tzrV/Y97/j8lSCCrrM/kh8mFa1ttYFuMt6D0P3dXQ=;
 b=w/uhf4ZHfxqWDeDr/92S7+Zv1l73SjfRQHER0IARrs1zHyCSH4SLCPXCv/qlGwGpkSd//e
 6LFUEW9YBhjPw5iEvpYoIJREZHVF32dgSvNjzHgpEsHv75qFCa69ubH4ExnXCuElbW/Ytl
 aTc3PANb4XCEDtiUSlpxJZYGnu1o+ES1Gnumd0Zbh9mdvdcxpRkH+PoAi9Cdlv/50yQL3Y
 58GlRiwf0UhfufiDoOgkjmaLjdyvm9gcz2XL1dIQaYkvONk3gc3s2DZozHWVspvIKxSf6x
 LhZhzjsEk2ynfTzFGO3UJm81KESUH078EezYrEJg5MONkazkH9UcTUHhbW3liQ==
Date: Tue, 25 Mar 2025 15:24:17 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3] mmc: mmc_boot: Support Sandisk and Micron eMMC
 BOOT/RPMB hardware partition resizing
To: ziniu.wang_1@nxp.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com
Cc: pbrobinson@gmail.com, marek.vasut+renesas@mailbox.org,
 tharvey@gateworks.com, jonas@kwiboo.se, sjg@chromium.org,
 u-boot@lists.denx.de
References: <20250325082914.2240470-1-ziniu.wang_1@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250325082914.2240470-1-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: zitt4bgt5hqjwg1hkst937u4eraf4p9c
X-MBO-RS-ID: 808a1857b2272a24519
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 3/25/25 9:29 AM, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> Current mmc bootpart-resize command only support Samsung eMMC BOOT/RPMB
> hardware partition resizing. Add Sandisk and Micron eMMC BOOT/RPMB hardware
> partition resizing support. The commands and parameters for resizing
> partitions are different for each manufacturer. Select the corresponding
> function according to CID.
> 
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
I think you missed picking up Peng's RB from V2 ?

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks !
