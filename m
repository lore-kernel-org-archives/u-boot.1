Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFEBC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 22:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B569584A60;
	Fri,  3 Jul 2026 00:03:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YVEHlTRw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gv2LkZuZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D69CD84A67; Fri,  3 Jul 2026 00:03:22 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C14CE848BF
 for <u-boot@lists.denx.de>; Fri,  3 Jul 2026 00:03:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4grrVc06rMz9v6B;
 Fri,  3 Jul 2026 00:03:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783029800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oga7ACcd/s1LlrirfJ+YGvGvKyH5Ux7LUv7MzhWhm9o=;
 b=YVEHlTRwfJhYyOmac3uR8eLTsi699sRa4DFxeXdNtZyuAc/0rv3aGcLPfHBf7EwqXlljNJ
 lwZbUrdziA1jQQFdy3PuUAVBSvjVSDg08lJdUExvJtokIVI55YcNtktMadxZR4YLhmTDEG
 D2QTVYgNDByCL0XRI+XK8jYvsprn3iOI6GqPxdNaCLI2zu+ddIA2dEDOMyiu8U+HbG9Z9q
 ETyJxPx4Jdi5ZOmsjhdCjX8U26HQ5cQ5NRTOOPaX68HzJwuP814g9zhF6NtNWTs+JA8bDu
 oo5AK2ZraYDE0IlsxsfllR6w5fxz/d7Wkrt2ZOSvzAqky+kCyi/y9cWEMbfa2g==
Message-ID: <c894c1e4-2078-48d8-a06d-3dec45d9a456@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783029798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oga7ACcd/s1LlrirfJ+YGvGvKyH5Ux7LUv7MzhWhm9o=;
 b=gv2LkZuZW2Ib9UBrPpdcvTFJZ/rQFHWICszvlUQkNeD72vUbKOvEi6YI1rziJlyFqQ/hH5
 WR2k2YOAFyWmhjNDDhP/CQ+agGBkMZ/03La22szpoKrHNXMLl0SmvbygoliQOjSqQ2OTfT
 K7B7ye7mrok3ZPHO2HfTQBd7wyY5MeHJIoBNsE/yuonz8DyLJM/0WxRaQNGdf5HclTBhzT
 4SNAGI/BCMPWYfalyBDCBVN/Hk5lrRenDT4Jr61vb7+klaNZxnMqIcjwP5ctK1ZBDKoyJD
 An4l8ioBHV59GcgRk3LMvu/WeZRcVumLRhs2BCBKJUdse8/PBbUxmpbRYq/exA==
Date: Fri, 3 Jul 2026 00:03:16 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] cyclic: replace uint64_t by u64 suggested by b4
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20260702-optimize_cyclic_run-v1-0-92c5a7011f54@foss.st.com>
 <20260702-optimize_cyclic_run-v1-1-92c5a7011f54@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260702-optimize_cyclic_run-v1-1-92c5a7011f54@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c2eb591d549291c9966
X-MBO-RS-META: m8co71fc3oi4smgo9gyyd6cbtmpxbtr1
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

On 7/2/26 5:24 PM, Patrice Chotard wrote:
> For new patch, b4 is suggested to replace type 'uint64_t' by 'u64' :
>        CHECK: Prefer kernel type 'u64' over 'uint64_t'
> 
> Update cyclic.c accordingly in order to be coherent with following commit.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
