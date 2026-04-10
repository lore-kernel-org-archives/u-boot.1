Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062E1F459F7
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 16:23:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 507398418C;
	Fri, 10 Apr 2026 18:23:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="LoZWZbJL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B928484198; Fri, 10 Apr 2026 18:23:11 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D80B8416F
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 18:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=alexander.feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=yRUWICl0RObfWXsnEaIDWY0tucLSgFo79B3fJTXE6Xw=; b=LoZWZbJLlX40MJxe3Pf9I1NfMT
 F4N6QsAl/cIUjSRKqnigVJ+ixfNgLVi6N0/OXsm0m2IXsPap5DCOZRlbh8QgMjFAi4ekCFSNeiHn2
 bN46Clu9IWnriOwz6fncw6WNllwk7kPjZ70vr1k7XFMAYqzAqAo8VMh4RNS8/CeZz9UUvmQA95fhR
 AE34Hca9jrsvuMo6SqdRRqXoVcyhKUozA/P5lSpuSLToFxrkFCEzym77WDFZwHROhVS+b4NgyA/L1
 P/YVVdRkCsbZwKoHbkME88ELB45l+LguQIEJ7TmBMn2Ow9IhEDsxVaArE3CBTbA92UHoXtrHmQYOp
 Pa6iKNVw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wBEdL-000DWG-2T; Fri, 10 Apr 2026 18:23:03 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy01.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <alexander.feilke@ew.tq-group.com>)
 id 1wBEdL-000PdW-1F; Fri, 10 Apr 2026 18:23:03 +0200
Message-ID: <b8710f83-231b-4097-9a74-9eca5e6c0bc2@ew.tq-group.com>
Date: Fri, 10 Apr 2026 18:23:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] Add support for TQMa7x
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
References: <20260407130654.778838-1-Alexander.Feilke@ew.tq-group.com>
Content-Language: en-US
From: "Feilke, Alexander" <alexander.feilke@ew.tq-group.com>
In-Reply-To: <20260407130654.778838-1-Alexander.Feilke@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

I created a CI MR on https://github.com/u-boot/u-boot/pull/926
which is running here: 
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=13065

Best regards,
Alexander

