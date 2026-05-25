Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E383CD5BBF
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 03:50:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 691B9841D7;
	Mon, 25 May 2026 05:50:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rx3uhMkg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1663B844CF; Mon, 25 May 2026 05:50:49 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1B918404D
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 05:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gP23T2H4tz9v8h;
 Mon, 25 May 2026 05:50:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779681045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iTj9gemHYI3xEH9N/JHRItHTW6sEm4VZseHye0XjeqE=;
 b=rx3uhMkg8vleVB/CIR0hk53jkqzulAw6s1Qvk4DKFrx+rjgcVi2io8ZWoAZoELkIDg6Nie
 kiVOzgRcnLbDt4iJ2QUplZX0YFdoQjhlbUvxcHmAwcUohtbie9wH8oSFoXS6/jyv9/8p0q
 Z9QA722vqw8huGVqgq4GNvMZmpSnSmmV1of+FzGi9oLGcTnKVAbvgQk9OnsuBGySihKnD1
 LtoPofMtMN/qF2Y/u1FKZROGugz//ofP+wH1YJ10927AC56gP0HVYMvMwDJ2hsa4tzm52f
 D2utQAE8tNXm8RWl8YbWBPS3ZuFJwTSVg35Nq+lnpQprHeVLAE+N4IgXZHv3ug==
Message-ID: <e770c6f3-6175-4b1e-9a49-ea04e5f1cc1c@mailbox.org>
Date: Mon, 25 May 2026 05:50:43 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] ddr: altera: Use dev_read_addr_index_ptr()
To: peng.fan@nxp.com, simon.k.r.goldschmidt@gmail.com,
 tien.fong.chee@altera.com
Cc: u-boot@lists.denx.de
References: <20260525041018.2369852-1-peng.fan@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260525041018.2369852-1-peng.fan@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: bq7nsnxp17a1o5z1zs5r9jjcrd7tx9b8
X-MBO-RS-ID: 4f890a6b20450e8b8ab
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

On 5/25/26 6:10 AM, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Replace devfdt_get_addr_index_ptr() with dev_read_addr_index_ptr() which
> supports both live device tree and flat DT backends, avoiding direct
> dependency on devfdt_* helpers.
> 
> No functional changes.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Marek Vasut <marek.vasut+socfpga@mailbox.org>
