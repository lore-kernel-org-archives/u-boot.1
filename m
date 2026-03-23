Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF7BF4613A
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 15:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A874C841E6;
	Mon, 23 Mar 2026 16:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="CQn637Eh";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="t4MO3tFT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D7228408D; Mon, 23 Mar 2026 16:05:51 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EF978406D
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 16:05:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ffc1T2Fbbz9tgG;
 Mon, 23 Mar 2026 16:05:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774278349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGbiMB6MI2WkJODNQvsR2JoY9u5UBlkNBgcYxYFjHA4=;
 b=CQn637EhijjzPiXfGq1b62lqFSKMRCjEZ9+xOgoRIt9PD9PGQABnfg6401MLbXJarxustH
 3X+AhzkL6MFT5IYuRsQ0YArgDq4a5HMir95FdZFsSuZmKkDFbYAedX3lNUqNL6Sa+TQfnf
 PbaaKEre83xrsv2qXA8ocI1TAVtRHuQ2Ynvqls1hYL4ca27jDtIxh0QSB7uYfYBxPqEBxN
 47y50sRswzMDM4ZgDO4mD4tx8Ow7Cz86FQKmRszK6ITPtImn8gC53I87wWzMY3dAcKbVtT
 XNg5nmxJd6Pv3qP+UwsVGTLOYXCMdB3drYRT936Y7bJNdQBCZA0LyJr78owOkA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=t4MO3tFT;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <a85f613e-92f9-442d-ab35-ada01540b7c0@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1774278347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FGbiMB6MI2WkJODNQvsR2JoY9u5UBlkNBgcYxYFjHA4=;
 b=t4MO3tFThr7auPL1laggKscmM244QusCw6sU1BNz0N7EZ5YhIbEgNLZbG46nD9EKbcWkWT
 UIfHFyOsXjgmeN2XttTkuE4PkPGYLM9opP6uIgrVWtLfntVQRq/Ja4nms6eUV7yRCoNwPc
 iJI6iEqc8yTlY1cgT9VBw4VssfEF1vZ/Dxi5SbmrrXJjvMZc201oTwGjs9F2bPv6hcYDEA
 NiF+wXVgJVlmPv2+KM+/Htlybb6EEz4+zCkCKllVeY1LzXOaBs2PRhr41CeOqhBlZdM1Ng
 zCw6Dx5Nr+Hs2K5ICsXix/rqQCV0bryq9znZDA8GVSRPsnBWEwt+CPSJCTHi+g==
Date: Mon, 23 Mar 2026 16:05:34 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] reset: Correct dependencies for RESET_RZG2L_USBPHY_CTRL
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260317012443.4162600-1-trini@konsulko.com>
 <20260323143203.2271987-1-trini@konsulko.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260323143203.2271987-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 56e0befa9bb29c92ad4
X-MBO-RS-META: nohzbseqkzu14gahzx9fqd91h5h5hixc
X-Rspamd-Queue-Id: 4ffc1T2Fbbz9tgG
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

On 3/23/26 3:32 PM, Tom Rini wrote:
> As exposed by "make randconfig", we have an issue with the dependencies
> for RESET_RZG2L_USBPHY_CTRL. As this functionally depends on
> REGULATOR_RZG2L_USBPHY, express this dependency directly in Kconfig as
> well.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
