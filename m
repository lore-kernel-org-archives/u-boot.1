Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F78D0E6DB
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 13:03:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C02B8405E;
	Tue, 25 Nov 2025 14:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tNRLBREq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C652E84065; Tue, 25 Nov 2025 14:02:57 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF8A883FFE
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 14:02:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dG2t25nNHz9tXW;
 Tue, 25 Nov 2025 14:02:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764075770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e2pk8TkmbS2LES5dVkTHIQUTh7mSaxyeDQpG56pfaZo=;
 b=tNRLBREqmWz+4bHW+/6r+TBQXnyNfwFpb9u7eGF7DoLAuQr9+8np3ABaaRAJ4vImQjfztU
 Rv9zF6aBJXtwvK9A62VExZxCFXjfDu9crQRoxVjhH/WPg6fIZnpERiNHjZ8/oNvxhJcl/r
 yRsI35scPaf4g56hqCzyD25dMMawv8E+KYJddlWMAaP1xBe+h4FyDPFkxn6Be1FnkjLpdG
 i3fMkINfNx7tt1N6zVKJer75y3DQSnxaxogomcoBsKBAf/Mrg33/Yem5iNehMLd4C5ifbw
 H+qhU9zoHYAsBLCEp6nOqrhEayj4lALoSj4RUtV12l8gaMd4RqOGIwkgSryIlw==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <2b7cdfda-c9ea-427f-bf30-692132b15f41@mailbox.org>
Date: Tue, 25 Nov 2025 13:26:52 +0100
MIME-Version: 1.0
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Re: [PATCH 1/2] usb: ci_udc: Check ci_ep->desc before use
To: =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
 Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 =?UTF-8?Q?Petr_Bene=C5=A1?= <petr.benes@ysoft.com>
References: <20251125085846.507591-1-michal.vokac@ysoft.com>
Content-Language: en-US
In-Reply-To: <20251125085846.507591-1-michal.vokac@ysoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ste918zfa3cnpipuoudfgq3ihio3sgjc
X-MBO-RS-ID: 02e4f19abb793c44914
X-Rspamd-Queue-Id: 4dG2t25nNHz9tXW
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

On 11/25/25 9:58 AM, Michal Vokáč wrote:
> From: Petr Beneš <petr.benes@ysoft.com>
> 
> There are two places where ci_ep->desc could be accessed despite it is
> not valid at that moment. Either the endpoint has not been enabled yet
> or it has been disabled meanwhile (The ethernet gadged behaves this way
> at least.). That results in dereferencing a null pointer.

Is there a test case which triggers this problem ?
