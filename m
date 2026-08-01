Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F17C55172
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 20:16:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DBE204067C;
	Sat,  1 Aug 2026 20:16:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ER0cUNlakUJM; Sat,  1 Aug 2026 20:16:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E97540608
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785615410;
	bh=onSV6isfcAHa/Uz3c1LprPsbU3wfqRdAXOZq0Uv9EWo=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=eg7ytc2dVnawef7ia0mkoxui61r8GUz5KluiKH4B/tN6Zk7LX2i4vI11+jkH0f45D
	 aa5NKaRwYLLIB1WQHBdkOeFdm7meviXR5ezgWIdWwbGbN+LSaGyrK1Nf+gnlI8p/M/
	 JRnQ5pLt9rr16YvNS+NQ0cwvSwGJkg/SfQEIDyIg9e9utTZvY0pL12NMNeS3/4NIq/
	 iYGRiKpLYgLkBixmn/1oLcbwVz33xcnILnrK1GvyN7tuwdifPm+G8w1dFTspOMueXl
	 hXx5p35swCWvDL8Hly76CaC7wSCioZ2ebaf1+AIj/FYP0eu8qG19OsVxltWWKP8HYc
	 Ay8ioxO4UiSRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0E97540608;
	Sat,  1 Aug 2026 20:16:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B587DFE3
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 20:16:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A7EE840608
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 20:16:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OZb9DSRu_Fd0 for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 20:16:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 49D6340605
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 49D6340605
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 49D6340605
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 20:16:47 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C36AC844F6; Sat,  1 Aug 2026 22:16:44 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF99380117
 for <u-boot@lists.denx.de>; Sat,  1 Aug 2026 22:16:42 +0200 (CEST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hCDjj2jnfz8v08;
 Sat, 01 Aug 2026 22:16:41 +0200 (CEST)
Message-ID: <595832c5-e8a0-43fc-871f-7894d3138e5b@mailbox.org>
Date: Sat, 1 Aug 2026 16:28:51 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] usb: mtu3: wait for TX FIFO to drain before disconnect
To: Carlo Caione <ccaione@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Bin Meng <bmeng.cn@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 u-boot@lists.denx.de
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>
References: <20260720-ccaione-upstream-mtu3-tx-fifo-drain-v3-1-45c0e072b64a@baylibre.com>
Content-Language: en-US
In-Reply-To: <20260720-ccaione-upstream-mtu3-tx-fifo-drain-v3-1-45c0e072b64a@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: id9gznnpk4pmbfq9fyzxoxnjmw77dhot
X-MBO-RS-ID: 5184766437624280076
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785615401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=onSV6isfcAHa/Uz3c1LprPsbU3wfqRdAXOZq0Uv9EWo=;
 b=M3Ky78ubJjmiL9YcY22LvuxS3xf86mNZRI61abg3wjSGgA/rgitpNTXAKmwqen5/NO5rkf
 M0X1iqxrnlj+kE1I8oSetOzKWl68oqlNekRcIN9YnkbEpc0Fo1KIiJ82hA6G8tjI8BpGFT
 0YFbpwwFcMmMd2oj2dNvWQdkDp7SkNIbWO/RN58WqE1aWB7MMWy/Nt1oZ28sErQB8f8jWp
 HqeTWtI/t8+YV0ReO/5ftXoUXOPnltcUETanQSCfHh63xOg82npUN2mDtbmxOvLf7f9Xxr
 dyMIw5H7PbfU+zocd0020ryn2gnh1JrFLkHjgFbRR1tt4Tqu/wv940V3bNSrkw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=M3Ky78ub
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=marek.vasut@mailbox.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 secure) header.d=mailbox.org header.i=@mailbox.org header.b="M3Ky78ub"; 
 dkim-atps=neutral
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

On 7/20/26 10:03 AM, Carlo Caione wrote:
> Fastboot unregisters the USB gadget from the completion callback of
> its final OKAY response. MTU3 QMU can report that request complete
> while bytes remain in the endpoint TX FIFO. Disabling the USB function
> immediately can therefore disconnect the host before it receives the
> response.
> 
> Before selecting the high-speed or SuperSpeed disconnect operation, poll
> the FIFO state of enabled IN endpoints that have no pending requests.
> Bound the wait to 1 ms. If a FIFO does not drain, reset its endpoint,
> force the disconnect, and propagate -ETIMEDOUT through the gadget pullup
> operation. Endpoints with pending requests are skipped so an ordinary
> disconnect does not wait for an active transfer.
> 
> Fixes: e09b88cd083d ("usb: add MediaTek USB3 DRD driver")
> Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>

Reviewed-by: Marek Vasut <marek.vasut+usb@mailbox.org>
