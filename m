Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FF8CD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 17:49:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 778DA84664;
	Mon,  4 May 2026 19:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="LFxbyFt+";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="jH20AmM/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D01D84669; Mon,  4 May 2026 19:49:30 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E67BB80F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 19:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4g8Tfv4czdz9srp;
 Mon,  4 May 2026 19:49:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777916967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g6pLB1/WPHRBBoGyFpJsPLUfLuUUwJth3QCPNFUy21k=;
 b=LFxbyFt+8ALrF8r8SXTphQdxU6HQSpFA5xyrsHpESd7FmRIpj/0XR0T4nlWACPSrwBymKu
 ejEGhFZhp2aQxy1hauAp8Xa7CU5vDnhfen6w9owHprTjsdzPW1dsioJHFWn4FZi+ZMfcCo
 +58njOSJFbmvMhk145d3djjmketBvgWygieMsOeqodhAP7KLoHrIND2bwvxbztFeHrzj+q
 tG241ZhiEGOgu5vJMGstwGlHCHXt3bU5JTDyMIlaDw60E1C+w+qg4MMnYCNEYlS39ENxKM
 4AVq/ThHc8LklvNLiAssUlzy35952iS8qd1IDuZyD9csDzt8SujvTmt79xzmdA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="jH20AmM/";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <16021943-1f2c-44d7-a7ee-4ef77f893d13@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1777916965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g6pLB1/WPHRBBoGyFpJsPLUfLuUUwJth3QCPNFUy21k=;
 b=jH20AmM/orkdP2gufZprMQw49omjtfbn+39cp+UQ6/SuxnknCT5oMXkWGQ85S/FagLcBvt
 Mrh6k7VBBtZ6g025f+/d5/ufY9VNviHTRHWCVe6FdxhwgOCK/8wNuOJTHIZB6E+EXnIgN4
 MfzuieKsL5J4Xw1atMgqwHI7SoWeAxe5x87RuPzx9NgcnnHGak+fT++py/07qBmsIoneII
 W7P0Rf2hIqrHBplYO2cA7onHgh502CM3gLvDnP6t86XslvTT2z4e6RlUiGUYbLsY1ZGErW
 0jNUWGNzzHmy1VwX9uNal45gFW1e/hvDI4ZT+QHKF2/eFD22Sh+jpwwEkTXm4g==
Date: Mon, 4 May 2026 19:49:22 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] watchdog: Add Renesas R-Car Gen5 window watchdog driver
To: Stefan Roese <stefan.roese@mailbox.org>, u-boot@lists.denx.de
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
References: <20260422225104.142595-1-marek.vasut+renesas@mailbox.org>
 <f5143870-961d-48a2-af38-fb1cb22b9bdc@mailbox.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <f5143870-961d-48a2-af38-fb1cb22b9bdc@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: fd9c050f56a3fe42b42
X-MBO-RS-META: 3ftp4sn17jfpyyzsrfqnh55ubukidfdf
X-Rspamd-Queue-Id: 4g8Tfv4czdz9srp
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

On 4/24/26 11:58 AM, Stefan Roese wrote:
> On 4/23/26 00:50, Marek Vasut wrote:
>> Add support of Renesas R-Car Gen5 window watchdog timer. Timeout
>> configuration is derived from CONFIG_WATCHDOG_TIMEOUT_MSECS, which
>> is more accurate than the 1-second granularity 'timeout' passed to
>> .start callback.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> 
> Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>
I will now send a V3 with this tag, since V2 didn't make it to the ML 
(ML was down at that point), and then apply the V3 via SH tree.

Thanks!
