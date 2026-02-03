Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5447FE8B363
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 20:45:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E36D83CBD;
	Tue,  3 Feb 2026 21:45:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="P5nFLxlt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06A5F83D71; Tue,  3 Feb 2026 21:45:47 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1525983C39
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 21:45:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4f5Fqq0yhBz9tqX;
 Tue,  3 Feb 2026 21:45:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770151543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=As6Snm922v0NUV0YNx/WQTumZvczUY5Cbfy3jPn2Tfo=;
 b=P5nFLxltKgEn8AF1eZcdiTjSx3aVxQoFafETaI+ZV63R6C2CyEODEWyXaRBRFMfc68w6/G
 8cp2MyykuSpYjIF9KQUCx5Bz42OgpbJwjgK0VnLaC5rWIp6riW+BPbRzEiiM1EiXHifWfF
 7tFbmXG+Of1K8niNXeyWClgknlyDRe53wSJ9T7Zz1UGyHZOoaAf7RhIn3Y4jcPlRDSqJgp
 0PBZk2FIJ4c1ZWG5nU54H2KbJcF7CNEZ2bY9gdKVZSXNH9JDA8H5d2+nJWmVneTWAggG6q
 lRCwvyjx7Ri25baau0qUyxMCW76Su1SKxn8zqyHbR2cws/JUNF53+o6QLul2wQ==
Message-ID: <a715f817-73d2-4dd0-aeac-14898ef48ac1@mailbox.org>
Date: Tue, 3 Feb 2026 21:45:39 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] mkimage: fit: align DTs in external data to 8 Bytes by
 default
To: David Lechner <dlechner@baylibre.com>, u-boot@lists.denx.de
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anshul Dalal
 <anshuld@ti.com>, Aristo Chen <jj251510319013@gmail.com>,
 Beleswar Padhi <b-padhi@ti.com>, Bryan Brattlof <bb@ti.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes
 <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Wolfgang Wallner
 <wolfgang.wallner@at.abb.com>, Yannic Moog <y.moog@phytec.de>
References: <20260129035512.639362-1-marek.vasut+renesas@mailbox.org>
 <865388b8-1f78-4b91-8ffd-1155fc2643ef@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <865388b8-1f78-4b91-8ffd-1155fc2643ef@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 612bed04ae8fb401cf1
X-MBO-RS-META: 8pfzfn89wri5b5ebpushczooqiipwzaq
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

On 1/31/26 12:14 AM, David Lechner wrote:
> On 1/28/26 9:53 PM, Marek Vasut wrote:
>> Unless specified otherwise using the mkimage -B n option, align
>> DTs in fitImage external data to 8 Bytes, and retain alignment
>> of everything else to 4 Bytes. This should fulfill the DTspec
>> requirement, that DTs must be placed at 8 Byte aligned addresses,
>> even for DTs that are part of fitImage with external data. For
>> fitImage with embedded data, there is nothing we can do, as the
>> embedded data are aligned to 4 Bytes, just like any other DT
>> property.
> 
> Could we fail with an error that tells the user they must use the
> -E option for dtbs? Or at least emitting a warning would be better
> than nothing.

Or make -E the default outright and drop support for embedded data ?

> Not for this patch but for broader discussion, it sounds like a
> `/align/ 8` could be useful in the devicetree syntax similar to
> how we have `/bits/ 8|16|32|64` already. This could (eventually)
> solve the "nothing we can do for embedded data" problem.
This would have to be DTC syntax sugar. How would that be translated 
into the DTB encoding ? In any case, this directive is something to 
discuss with the DT compiler people.
