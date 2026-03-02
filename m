Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C036EA4E06
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 13:54:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2CBF83F30;
	Mon,  2 Mar 2026 14:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vY7Pvsgz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FF9583F5B; Mon,  2 Mar 2026 14:53:53 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAE2283F0A
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 14:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fPgQ60kk8z9v7B;
 Mon,  2 Mar 2026 14:53:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772459630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9vVZUGmnWDk2H8RXYo4eJ5C7Vxw3O8KtaPPkAhmjqrM=;
 b=vY7PvsgzlrRcW93gqRrF2v8/qYZMLn5lfMDX2Vhbfy0ChLujMKUoHCV7F4JIDSEhNY67Kz
 VboCGKb61hHFnPM0iUcoP/ZYbFktCf/mkirxcoTWMOxRmEPnt8ZG66Qkrw+1oWaDfGnqU0
 G2esmHAoVNefFgwPf3gNWv4RImlKPl844wAkoMzMAWFUhFNHoS701v97M5fy1ceNwp2BUU
 s60GGHlqrSu4DMq26tfVQuOpG30sX0VJIw/fSF1AJjKzIBb/U4wZargzSByuyDEUkten/2
 JAE3CCvtJmI3ahZCXY78PZ1UqitfsBB/VSUqzG7MVTkQnW8t0jt1QIekQ2mncw==
Message-ID: <6ea0b36b-00cb-433b-9834-dc4a26a0e2be@mailbox.org>
Date: Mon, 2 Mar 2026 13:54:43 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/4] usb: Add code spacing in usb_bulk_msg function
To: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>, u-boot@lists.denx.de
References: <20260302044532.2891813-2-ronan.dalton@alliedtelesis.co.nz>
 <20260302044532.2891813-6-ronan.dalton@alliedtelesis.co.nz>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260302044532.2891813-6-ronan.dalton@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: nnxbrqgtdp4p58jwii6hibmkpuyuaaws
X-MBO-RS-ID: 705ab5f1bfb2d0ae066
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

On 3/2/26 5:45 AM, Ronan Dalton wrote:

Commit message is missing , what is the rationale for this change ?
