Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83A7D0E6D8
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 13:03:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 049B984066;
	Tue, 25 Nov 2025 14:02:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="o5GQiQcb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7A0C8405C; Tue, 25 Nov 2025 14:02:42 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CAB38405E
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 14:02:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dG2sl74Wqz9tlj;
 Tue, 25 Nov 2025 14:02:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764075756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=coV4WH6w/kr1Q5mmwywlJkb894ngbrszvgahmbf7Vbk=;
 b=o5GQiQcb6x6hGyGQZ0C8HCbIZNaNDR51lSGtxFjElfBgiLNowlqcKu4StCyisH5uPo9Fo9
 kIX4JWVEVUALC3hWcnKd6zsbRafOTyB/pxfKD9B8231M2jkM5He14HNVakICSywVadNzIX
 OJpgHqjj6ceY8f2A8DfBzSKakAuw07IGp9TESjBhrgVcKD7wse/8G2D/efC9z1GLzbS4ER
 PFlaX5VYiHQto2Vnnd/eqAJfPKZjn5d2KyXfPOyvsVXjyCo++iD5tgZMUiFAWeA7I6pTjV
 gjqlqnWbvlieIPRGgW5CNNiwArEqfQ0SHRxASjMdUEpHgVbt1HDmwbApd0bZpQ==
Message-ID: <e7640e90-8bb0-4f6a-85ec-4f4700393bf9@mailbox.org>
Date: Tue, 25 Nov 2025 13:24:29 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v1 4/8] mmc: socfpga_dw_mmc: Restore legacy clkmgr address
 retrieval
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Brian Sune <briansune@gmail.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-5-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251125081316.17329-5-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: eg9ijugxq5pi6tbud5fdmr8idgwzwerk
X-MBO-RS-ID: 69f35c858a8f053755b
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

On 11/25/25 9:13 AM, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> 
> Restore legacy implementation of retrieving clkmgr base address from
> mach-socfpga/misc.c driver for our legacy devices.
> 
> Excluding Agilex7/7M from this implementation as these devices' clock
> driver is already following clock driver model and is supporting
> enable/disable APIs.
> 
> The legacy devices' clock driver will have to be refactored to support
> driver model which enables us to support enable/disable APIs for these
> devices.
Ideally fix the clock driver instead of more ifdeffery.
