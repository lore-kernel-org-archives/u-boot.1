Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3AACD8CAA
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 10:54:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 291298496E;
	Tue,  9 Jun 2026 12:53:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YdKHBqGV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE9188495B; Tue,  9 Jun 2026 12:53:25 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F179E8490B
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 12:53:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gZQkC5TKlz9tnw;
 Tue,  9 Jun 2026 12:53:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781002403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYh3k4N6lxaStDB57Cx2o/SICAa7FAugSZ+B1kxfaxw=;
 b=YdKHBqGVuAcG+v9sXji7qNYmI1vIG+gfHImODXwidkoZSbM4xG9nEog+1+C/BgP3Ni3FkT
 JI4bXNexoRhF6MeNgtbV7PHRWro3nkYIUc9Elxbj3Hr0bJ+gHdwIyHMFo0UOVnSbu6X9c+
 JpPGtA4nQJPyEvLWz5uy7baaF1zWeDv/KBJq1+TJYKR64O3/s86dCEV6ElBW+qA+Dqgu83
 0umi6MpMT5AhiqdaKb1W3T2+P2QKk0ExpdDgX+nfeCjsM4S2zJrDjEIwexCRUH6m/GYb/B
 907D0+dkzSh0LKxlB6SelUU2dSuIrpnYhnOMs9hoVoWHvoKlrnGFs4U6kvQRfw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Francois Berder <fberder@outlook.fr>,
	u-boot@lists.denx.de
Subject: Re: [PATCH v2] drivers: watchdog: Fix dev_read_addr error check
Date: Tue,  9 Jun 2026 12:53:16 +0200
Message-ID: <20260609105316.1172918-10-stefan.roese@mailbox.org>
In-Reply-To: <BESP194MB28051DF5B61C4ED0C8C0F297DA0A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB28051DF5B61C4ED0C8C0F297DA0A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: d7xhd66khzz6r71egs685eyscnxb73jz
X-MBO-RS-ID: 9c3fb358995368d14dc
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

On 5/25/26 22:33, Francois Berder wrote:

> dev_read_addr does not return a void* but fdt_addr_t.
> Replace invalid usage of dev_read_addr by dev_read_addr_ptr.
>
> v2:
>  - Replace dev_read_addr by dev_read_addr_ptr
>  - Change error to EINVAL
>
> Signed-off-by: Francois Berder <fberder@outlook.fr>

Applied to u-boot-watchdog/next

Thanks,
Stefan
