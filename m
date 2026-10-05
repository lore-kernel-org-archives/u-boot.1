Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBEDCA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 11:46:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D6B664061A;
	Mon,  5 Oct 2026 11:46:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WQVioHj7PRME; Mon,  5 Oct 2026 11:46:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1A75E40639
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791200787;
	b=AiAYfQjotySHfstOZbbA3ZlcT3CbWk5WKQ/VPlqaLdIIV5xqBSRQ439jKRzjmLQDopJ5
	 S55hTw6NQ7XREdH+WECLwNS7w5V3ginSA9O38CKl4w/n8DIUMUekF83NSyD7s1zKr21Ir
	 dNnwdaQUx4pHwytlW4A8JU5A5qtnl93wxTVqekbyTRrY8ycVC04cdUvmhBttld6n6xXRn
	 /6K5Vo3XK0kYPYo9mDYhW6a0DXbbXM+nNiwGlJWzykzXtYbPE38LD6Gi/eF8hAcCZsMAT
	 vPfPdzQPsdrlIk7IiUWNnHvMoA3gXDjxJyQAowe8eP5MtapPhkDObO3Se7hWkn36GYA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791200787;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=4bipFEyr4/JWiuuxqs78rWUv40pCtB5nVz5JTdtzj+4=;
	b=I3UM2iFzaj7TFH5NwaPVPWzQXdtCZdbLB1OROR+z2hGfZmwoxxyZ5On22RBF2LPgnZeo
	 PA3Tktg3xkLK7GhocNmTVhhVpSfCfWaGJx6DATAj7jr8/KEdLX3SLanHji3rwH3833orm
	 6NpIMNmVmNVE2mn6GUMKTNJLidcXnCOotJPCXMA1S1Jhqjp2wYAO8UBAwHLKBke3MV8X5
	 eOkP20ZVhHw8cIFcRqKtpZuflC/wqVweXZaH6wfoqxJ3HxnpI9W/yYkgJtZ5r5FyHytdT
	 UssNp77Y00WrOLuPnjWsbPvlTZSCtqIVkhuPMmN6aAuRqCBnT5baRB8YKm9dMrXcnLQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791200787;
	bh=4bipFEyr4/JWiuuxqs78rWUv40pCtB5nVz5JTdtzj+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j3qR2tV1+4x3oVo64nBV4DIYc4vGWcijE491kDPa6VWg0aO9AQlLxrmX4riCFmKO7
	 9u3PlCcPy6DHigPQEvE205X0bVaaTB62t5V7nmfN1QRNtNEXDAti8JAquakwc69TK1
	 TJCdS/PGpx8AhvCaxEieQEbii0Gy2tlXW+evrRzqTi2C4RlWZ3U+Lr3oPX9oKg3L1X
	 OFQZIrtxD+YQn1N2K2/Rsc4N6nbL6zioepU40d8iVDo2wno6aJQIhWVHiZd6gnAjZl
	 2SyjLl6L4mecRlv/ATztVcdqqtgc3tEw7rZf54zmdDaQB+iYvgkNN4rKwPRz8ekNk6
	 dopvu2rUvNORw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A75E40639;
	Mon,  5 Oct 2026 11:46:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5528975
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 46DB060613
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:44:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PTn-TCXZo_f0 for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 11:44:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DECC760603
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791200693;
 b=JdWR2xMq+UYL21awdYY5FpPqAjKBmH/+wEwSg0In4l0m5fDH8HeFjyry0IZnVeH3d44i
 Y4tDTEmBufjVTObTZ2qFzEg6tgumvQ6FnilTJiXqgRNtOFad4a+3jk+3Qh98tywDt3PSM
 cObCcdyP8mR3XWUqbwha7btKV7hvS+k8yTtUJJJoJqWIfr4fK8X8rANxquHVfbC5vuqrt
 kBj3Tx5Z61saecGrnnnyEg2TevCOlV4J/slzjFdtyLita5qyODBZ1v5TNb+abGNUfE8ef
 nyOjmD3oJhaE4gC2W3V6gtRwAu9Y/9fTc7icC2oDnQIQxUWDv8bhd6KCOrkyPid796w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791200693;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:Content-Type:MIME-Version:
 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID;
 bh=4bipFEyr4/JWiuuxqs78rWUv40pCtB5nVz5JTdtzj+4=;
 b=QBqOjgmt0wEtlsFFxgTJ7EY/GYRtqujb2EgpCXgPOmHYDvuC/15QHnWxzJ4aXUeaoPOZ
 41pP/F1A3AZLQu7e+7/kQoqDR63aoGArovF7+HgNWp17D6mIVEJaPYoBfC7psgWMxYfhC
 I+onYWCUEHMTyS043QuvSAizTBM7syndgrXA60TAyXpIpjSgadCBID/XzWt/irgcbjVWi
 zTifmvl6/7fE6J9eG4dYLA5QwhjMiMcEooUEWCgkz3NW0phAJBmIb1smQ2/lkFSvSG+RS
 eWB5ZMovk1U+gzyn5vz2IY5OFsQw7e5oNpFJNxxS8Bg+Y8N+T8CfY4J8s91D+Riv+vg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=mpgX2uF3; 
 arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=stefan.roese@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=mpgX2uF3
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DECC760603
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 11:44:52 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hyyH51kgHz8sYg;
 Mon, 05 Oct 2026 13:44:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791200689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bipFEyr4/JWiuuxqs78rWUv40pCtB5nVz5JTdtzj+4=;
 b=mpgX2uF3Vm1HgSKkSV7RDLTmrT8hmW++0wTIsamuNbW3iUkINuVZAS40LwBumILMNIPA8A
 bo99KjmAd8ekkzWsLn0yNcKfMK5fV9pzDr5z+XJdh4qZo3Pa+De5boxq7y6AYKYiPzz738
 qae5IAq9cSste63MkPTpCV60XQgMFTnsfbuKGcqQzK7Zr5tLt19K93HQYzp+JzlmWBABon
 XuvFYL3KbJ7cGtdZPTQvqY6bKEQZuiRoYAJZ6Bi1iRa46+LbxtoIlHLk9TUY7igCE6gWs+
 tzr0msunvTZ+zJ0R54ndsB8U/m/2npZGKj77DFAf/O3plRC2aXR1i+rnHE5FNA==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Tony Dinh <mibodhi@gmail.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] arm: kirkwood: remove obsolete configs for Zyxel
 NSA325 board
Date: Mon,  5 Oct 2026 13:44:37 +0200
Message-ID: <20261005114447.741892-1-stefan.roese@mailbox.org>
In-Reply-To: <20261002-nsa325_configs-v2-1-56dcaf092b29@gmail.com>
References: <20261002-nsa325_configs-v2-1-56dcaf092b29@gmail.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: qspdfwxqcp6m6e6ntqqgedf51wohsp7k
X-MBO-RS-ID: a1e0ad94b69f69bb000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 10/2/26 13:54, Tony Dinh wrote:

> Zyxel NSA325 board has been updated to bootstd, remove obsolete configs.
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Applied to u-boot-marvell/next

Thanks,
Stefan
