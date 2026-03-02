Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F220EA4E06
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 13:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2BA783F2A;
	Mon,  2 Mar 2026 14:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EGWONKa5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D458B83F3F; Mon,  2 Mar 2026 14:53:50 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F1D883F0A
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 14:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fPgQ31GKRz9sdM;
 Mon,  2 Mar 2026 14:53:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1772459627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sue7xeeSWSFBwOP9oO/51gMf/Qof0JHWn4+w5HnSgYM=;
 b=EGWONKa5wr5jdwgKlNoxd7oUkRJmgLMqvSdIQ32NLfENg3wZZnUXzvNlLgzB1c0wWidK65
 tjf6PidLcuNvS5nBS6nfAp+5DGPMDoXjDAfL3gLli+jp1H+mJ4CPDzh0OzMkhM1YZU3+7W
 jRTPWchVemJobcs4ny0MFdVkCAky+ic3dkbPiQuqRU3lFClyObRns/FztWqpN7fG5h2sxE
 Q2IhlN+enejXrXggMR8ylX8CIe9fyTNCQW6OuejM5BXahCwZNCkayOY431ZSJ3Z02EoDe7
 fbFfobyYKS4Jlp/K3DgD7eCNbLEjgvwp0GIMRNidCrW0myiRtaPZV9GYWabr/w==
Message-ID: <7be2c3d8-b696-430d-9f02-e867eba588e8@mailbox.org>
Date: Mon, 2 Mar 2026 13:53:10 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/4] iopoll: Fix read_poll_timeout macro documentation
To: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>, u-boot@lists.denx.de
Cc: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
References: <20260302044532.2891813-2-ronan.dalton@alliedtelesis.co.nz>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260302044532.2891813-2-ronan.dalton@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 33e4e5fe3fc9a1ed674
X-MBO-RS-META: x35pdf7cujr9nrogtszxuza7hofz57s8
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
> The read_poll_timeout macro has some incorrect documentation. @addr is
> referred to but that is now replaced with @args.
> 
> Update the macro documentation to make it more similar to the equivalent
> Linux documentation, which doesn't have this issue.
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
