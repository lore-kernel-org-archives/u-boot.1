Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B7BF557E2
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 08:36:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 421A683E16;
	Mon, 20 Apr 2026 10:36:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ila+p78K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA38E842B7; Mon, 20 Apr 2026 10:36:10 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4278839D5
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 10:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alexander.feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=SIXnFyDhmafa/ZfygSPrpkWMT73fG1EXkHpIamvCZ8k=; b=ila+p78KWCGUbR5vEE8XePaawz
 SCJ5XScbKkzJQ6c73umLKFdPBo7SOVJIAImY54QSBCHaek9bL89nx6B4k/NNE5WXpMxA70FT73/YU
 zDHDyBE0V2gI443j4rLTu3JrHFjfgSkB6S0OXFwPkImCv8o6QS6vP7l3kZ+UQdV4aOXog6KzL3dyq
 5lNlW/TyFuWiEHB0V4S3Wr/IsmCcy+7Dv5Up7v39zOuonuld33edfEFs/k1SckmhkCQFGrjtactRH
 EubUghNyBBeJcVSDHuhNp34zzPxf2UxELMwowF5+cCSlXDpthMnMv9SmzxC5Y/LjKlfYc2KqAp+W0
 IkqnTXww==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wEk6t-000PJF-1k; Mon, 20 Apr 2026 10:36:03 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wEk6L-000Ovu-3A; Mon, 20 Apr 2026 10:36:03 +0200
Message-ID: <c5da72b8-fb21-4aaf-b349-a4ee28ffc8b7@ew.tq-group.com>
Date: Mon, 20 Apr 2026 10:36:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] board: tqma7: add code for u-boot with spl
To: Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <20260407130654.778838-1-Alexander.Feilke@ew.tq-group.com>
 <20260407130654.778838-7-Alexander.Feilke@ew.tq-group.com>
 <CAOMZO5CneDfsmw5Lt8GnQttz7eOmbFJJ9zKZz-5W383bWNTyYw@mail.gmail.com>
Content-Language: en-US
From: "Feilke, Alexander" <alexander.feilke@ew.tq-group.com>
In-Reply-To: <CAOMZO5CneDfsmw5Lt8GnQttz7eOmbFJJ9zKZz-5W383bWNTyYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 19/04/2026 22:05, Fabio Estevam wrote:
> Could you detect the RAM size at run time instead?

The RAM size is already detected at runtime when using the default MULTI config.
The separate RAM size configs are necessary in case only a specific RAM size
should be used for customer hardware.

Best regards,
Alexander

