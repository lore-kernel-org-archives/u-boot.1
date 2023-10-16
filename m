Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A830ACDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 12:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1896F865A2;
	Mon, 16 Oct 2023 14:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SYlucXD7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hZeDio9B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 612D7865A2; Mon, 16 Oct 2023 14:59:42 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 988A386BA4
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4S8HJ93sznz9sTn;
 Mon, 16 Oct 2023 14:59:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697461177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jowDOTISrGHDNgn1lMBXjouV3cWP9lbY4fowEACpbqo=;
 b=SYlucXD7tt5cWdztO4Oxm4rLorRaulU1SM5wQVOe9ET9uGwI3EsIbdFyg13KODUgVcvMFs
 Dmt/eYR5sfFSWK7Icnia0uzPcAOhbZ8E0S08IowQFVNWj77Y5skAv9WaLOWGouC3KYqRqt
 9ZMUDlAYfi53UGUQwNGr6DW44MlY7AMK4eJ9gVsDOkPNM0RBaU8yigDirI/SahlYtAYvSV
 i3pNoUxHI/4hHwyfEd2QLw+SkSlWmp15tB4oddYPM4FTe6ZAeWhXzep5jwXxs4MmaoBhlX
 fGRdM5SNpiY5eWsbHuYGzXSN67xFnI1ifZOZZNBOlbxRZqN9NR/7pJg9ptK1nw==
Message-ID: <ddcc937a-282c-4a77-9002-7ff212bf0c54@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697461175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jowDOTISrGHDNgn1lMBXjouV3cWP9lbY4fowEACpbqo=;
 b=hZeDio9BN3fVyHySod31/O1+/4IetAy/fI1BNUONct63yTHbGRbGP2hv4KL3s06cuhqEHC
 zIBOc1LrIeJAgE2ulTcg2i42CYN4RaCkbS3yr7GXOrdlWXNOekji04CIsGDDI7cuWuHuaD
 Q7tGkc9v7QwsYZpV7o2doq9sey+MRM6Tbl2lP3Mgr+7mLgNSF18KWLhR+KEVnj55PJ77mv
 RcH3qWK9ZPhsc1c7d2F734PX9Gddy46XcrC3P8b29+nl78BWP/l+Ub0XIVOEqFJ3JtMU2b
 KRfGbzKzgA2G/h0jxjWHXlH4yCz1zMaQ8wwYvCC3HFBe0X13lMvHwlJW6W6iMw==
Date: Mon, 16 Oct 2023 14:59:34 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 16/21] mmc: renesas-sdhi: Initialize module on RZ/G2L
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231016092543.3833-1-paul.barker.ct@bp.renesas.com>
 <20231016092543.3833-17-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231016092543.3833-17-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: adf2e536cd14cdae227
X-MBO-RS-META: tsxon3a8dtsd11cjhm1fb3oxx6d816xa
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

On 10/16/23 11:25, Paul Barker wrote:
> On the Renesas RZ/G2L SoC family, we must ensure that the required clock
> signals are enabled and the reset signal is de-asserted before we try to
> communicate with the SDHI module.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
