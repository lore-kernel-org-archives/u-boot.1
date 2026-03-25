Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1B6109C04A
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 17:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9203983A41;
	Wed, 25 Mar 2026 18:51:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="jPtUPrv9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 674D583A91; Wed, 25 Mar 2026 18:51:07 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69B0B838BB
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 18:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alexander.feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=jAkdJyZPzw+p2p1PYTdfXRCTw45UcVk7AsIVf4s9Va0=; b=jPtUPrv9vh55DwyWbxCDKrErfx
 BbD8iiHBNekcdFPyg3BAdradBOttFwd6sWTJe3Jud30lhVPjSeqR0n5Hcu8q1zwOxt+9rPb6+stl5
 HaeHCQ4B9sqAQr1FhuKTXnXBPW+T97LqXu4uyuKAjZT9ATyVYIbLEZgQpt2GFY6tM3eM36YrIUKo8
 EsK5vziZUchSC3oL6k/9wMT12lRIbK7dEmfQS/vnXLFBc4Ea+RCUM3Fdb1ASrSN6Oth+19oZwRn5E
 XhuMY/awXV4cQCkHXeWd4oExMW0Tb+uLjbIisOjG1dDDeoFk5hSECnDF5x/3PBGZFXB+nN39lu2QB
 NcBsTk4Q==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1w5SNg-0005N8-1n; Wed, 25 Mar 2026 18:51:00 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy04.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1w5SNf-000DQ0-2g; Wed, 25 Mar 2026 18:51:00 +0100
Message-ID: <699c7adc-d636-4ef3-9844-52a28333ef0c@ew.tq-group.com>
Date: Wed, 25 Mar 2026 18:50:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] board: tqma7: add code for u-boot with spl
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <20260325095801.47706-1-Alexander.Feilke@ew.tq-group.com>
 <20260325095801.47706-7-Alexander.Feilke@ew.tq-group.com>
From: "Feilke, Alexander" <alexander.feilke@ew.tq-group.com>
In-Reply-To: <20260325095801.47706-7-Alexander.Feilke@ew.tq-group.com>
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

Hi,

Please wait with applying the series. I just stumbled over a weird issue
related to the environment.

The default rootpath is set to `rootpath="/srv/nfs"` (with quotes).
This is wrong. Running `env default rootpath` will reset it correctly
to rootpath=/srv/nfs
However, `env default -fa` resets it back to `rootpath="/srv/nfs"`

Independently of that, the variables inside load_nfs are not being replaced
correctly. They appear to be empty, as I get `Filename '/'.` in the run log
when it should be something like `Filename '/srv/nfs/boot/imx7d-mba7.dtb'`

We will fix this before the patch should be accepted. The first issue seems
pretty weird tho. Any idea what might be causing this?

Thanks,
Alex
