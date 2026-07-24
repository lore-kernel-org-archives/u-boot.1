Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6C2C531C9
	for <u-boot@archiver.kernel.org>; Sat, 25 Jul 2026 06:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4DA940A96;
	Sat, 25 Jul 2026 06:22:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gRKn_8mjPtbj; Sat, 25 Jul 2026 06:22:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3070A40776
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784960524;
	bh=3BR4JJpYel/qyqDWw0BF3jwJuVEbaFw5t5aLvjMtrUs=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=fwq59C28NyOoy82X832lhBiGhzuScTElTm32TP3a0hBUM2lu355FBzeCHXw88dssp
	 4bRCVo4hETgy0VmeDprI5st5jq4soMCn5/0w7YLMf3Mu8Lmw+sxHBBheKG7JzYegHP
	 DXrUzoTm9N6r45wrhwI6xrF4H+yelmeGkEoF74CYQ0dxhVcIzhnjBVP4kNDzDaaNjR
	 r3sgaNXi9Isg1lgOE8d6KF7o6OfPcUV1J44ccviRVPT21djzD3iIxbhjymWfHcZMkB
	 JacVl16ltvp3v2D7zxnua+IvO/UKyIXW9eBUr9nnpcKzKXClUGb1XmYQ4KF8HSED6G
	 acawsdEF19LXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3070A40776;
	Sat, 25 Jul 2026 06:22:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id F3DA33B1
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 06:22:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D9A054005E
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 06:22:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pu9NoftiODd2 for <u-boot@lists.u-boot-project.org>;
 Sat, 25 Jul 2026 06:22:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DFFAB40050
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DFFAB40050
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DFFAB40050
 for <u-boot@lists.u-boot-project.org>; Sat, 25 Jul 2026 06:22:00 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h6ZWm2JBDzMlG1;
 Sat, 25 Jul 2026 08:21:56 +0200 (CEST)
Message-ID: <66ed1858-c0f7-46e9-86f7-8f2e562549ae@mailbox.org>
Date: Fri, 24 Jul 2026 14:41:39 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] Revert "drivers: usb: dwc3: Add delay after core soft
 reset"
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Chris Morgan <macromorgan@hotmail.com>
References: <20260724-kodiak_delay-v1-1-57b687e6d67c@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260724-kodiak_delay-v1-1-57b687e6d67c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e9aca3611355dafd48d
X-MBO-RS-META: g3tz8yxsoh4go1cdpzirxken5ccpuzyt
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1784960516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3BR4JJpYel/qyqDWw0BF3jwJuVEbaFw5t5aLvjMtrUs=;
 b=i94vwvxXE27gAZ0J7FdfS8KuG0jSZXtjHA2JspZT5Ik5aJgKtjSPEvHXnl9s3kXT/rvEXh
 shT6JvzsGDmIXwN+z5xMN7oqyNfQ97JsHKnuw0z9ig0GAozGqwt/6ZkHFQKXWsSbqPwMj8
 ZFxEpQxVtK3qBb9zoRPOI5xhDpQb/oWAQN6PFjV67JdilvJmADcTxKh9R0aVGjeVQHpMdD
 MhCOPSWMvoVIPZo1feeEyK0D1OGI0UlVh50WClobtJR4B9JfXGOrvhh446tirBoX6tIrR3
 lMYil36gvIwzhswKi482lmmBBYwdbsrQQtw0tqXLvGiaQnoTyMehs6hS+JvlxA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=i94vwvxX
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

On 7/24/26 11:28 AM, Balaji Selvanathan wrote:
> This reverts commit 6de333b5caf035c38d7af9fa7596aeffcc49db42.
> 
> The delay is unnecessary. Upstream Linux does not add this delay after
> the core soft reset and the USB works fine without it.
> 
> Tested in QCS6490 RB3Gen2 Qualcomm board.
The reverted commit states this:

"
     Without this delay, USB initialization can fail on some Qualcomm
     platforms, particularly when using super-speed capable PHYs like
     the QMP USB3-DP Combo PHY on SC7280/QCM6490.

     Taken from Linux commit f88359e1588b ("usb: dwc3: core: Do core 
softreset when switch mode")
"

Can you test this on one of those two listed devices ?
