Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE504F8D762
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 16:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7132840AB;
	Thu, 16 Apr 2026 18:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="JlCudSzF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 749DB841C8; Thu, 16 Apr 2026 18:42:03 +0200 (CEST)
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com
 [95.215.58.176])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EDE483EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 18:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Date: Thu, 16 Apr 2026 16:40:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1776357718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cAmnLe3TMrW1/EpsT29hZJejYw18kht7JDA3uYfitOs=;
 b=JlCudSzFoN0womi8WLc2gYk5hDTS5G9LfHWJ2eTDSK2MPCwmhuNR7wDXEF5iGkdYDFbYik
 ZpY2bPy6S7LgGadFhg+r1h+BPA1Tq/ng7eHdMomZtflOJjdyZrpacteHPoKX8LwyUd8jfp
 6SBnIErHic7NnWZOhJhTQL/qgYCU88yBUv8cQrNOndeQO28cB5C03126qs/KqSL+q4cRQP
 Dn1ABvxF1WuBzDe6Fj5Va7B36W7gOxiuDaDV/Cvs0xC0dNkwZSAR9+wQPDMG7ohzQuxDgB
 NmRUCOiUwmPjLjHNRHLj8O34Uf21v/HlN2REnJNCTFWi2xqnbKI2ZCFJavfJTg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent (TI.com) <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, Martin Schwan <m.schwan@phytec.de>,
 David Zang <davidzangcs@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 3/4] doc: usage: convert autoboot README to rST
References: <20260416-ui-cosmetics-v4-0-b843ba661b3f@postmarketos.org>
 <20260416-ui-cosmetics-v4-3-b843ba661b3f@postmarketos.org>
 <6c1276a4-5eac-4028-86ba-b21deb34dff0@gmx.de>
In-Reply-To: <6c1276a4-5eac-4028-86ba-b21deb34dff0@gmx.de>
Message-ID: <tdlidf.366vg35n3ww5r@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
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

On Thu, 16 Apr 2026 15:26, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>On 4/16/26 16:57, Ferass El Hafidi wrote:
>> Convert the plain text autoboot documentation into rST, so it is visible
>> in the public docs. Also decouple CONFIG_AUTOBOOT_PROMPT from
>> CONFIG_AUTOBOOT_KEYED in the documentation to reflect previous commits.
>> 
>> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
>
>Please, remove trailing whitespace:
>
>Applying: doc: usage: convert autoboot README to rST
>.git/rebase-apply/patch:234: trailing whitespace.
>.git/rebase-apply/patch:240: trailing whitespace.
>.git/rebase-apply/patch:247: trailing whitespace.

Thanks for pointing that out, I'll remove these. I think I'll wait
for more feedback before I do so.

--
Best regards,
Ferass
