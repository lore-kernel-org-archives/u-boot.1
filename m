Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51C8CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 12:44:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3961984868;
	Tue, 26 May 2026 14:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="PHij8b22";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C42A84886; Tue, 26 May 2026 14:44:41 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECF6D80433
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 14:44:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alexander.feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=YYQDjbYD9xBkRPEhvDTJJxG0JnLuiAAOa2zvy3ohXu0=; b=PHij8b22FYu4ZXQEeKeYewyo4+
 DxgUq39/BKb+KLJgUTxtm66s73YoxfeNmfhkZq7T5q1T63ad3i720B7Ievxx+bVnvoU9iHGpsXsax
 q4UjTvry+IpoO3CxGi0icsSJU+w0h1fQokdtCIZCSOCUdHsIdp/XKCZqTSfqPVz7ph1X7/dBGJN3a
 343W7IcIESSXtrcXD6wr8uJCUJu4xDoZAqTcmOOjwk6XzHh1d2yuji1bJ9UzhOanx/dsuq6LFZdlu
 vuPy/5DmDvapFXLqnLvTS9PWHdCBADetVNuZqsPGgGLYtSCPVNQ/MmvCDlqpgmXAfAKgflkaRaaU1
 FDtzkMZQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wRr9B-000PoU-1D; Tue, 26 May 2026 14:44:37 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wRr9A-000D5y-1l; Tue, 26 May 2026 14:44:37 +0200
Message-ID: <ff90bf80-8497-478f-9a23-3fffa114da14@ew.tq-group.com>
Date: Tue, 26 May 2026 14:44:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] TQMa7 eeprom sysinfo driver
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>
References: <20260526124044.354578-1-Alexander.Feilke@ew.tq-group.com>
Content-Language: en-US
From: "Feilke, Alexander" <alexander.feilke@ew.tq-group.com>
In-Reply-To: <20260526124044.354578-1-Alexander.Feilke@ew.tq-group.com>
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

On 26/05/2026 14:40, Alexander Feilke wrote:
> CI: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13229
>
> Note: I got a strange unrelated error in test_ut in a previous CI run, where
> dm_test_rtc_dual() returned -EINVAL, causing the test to fail. It passed in the
> next run so I suppose its a race condition, but I didn't look further into it.
> Link: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13228&view=logs&j=db15d90c-51e5-5ca3-902e-4c5d558bba82&t=64917d2e-7acb-5ec4-6136-40fc146da71a

latest CI: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13238

regards,
Alex
