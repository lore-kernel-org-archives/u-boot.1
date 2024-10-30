Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D742AD6B6AD
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 16:52:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1220488C05;
	Wed, 30 Oct 2024 17:52:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mOHWh7NB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ToRBpxeq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54F0F8921B; Wed, 30 Oct 2024 17:52:32 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EE8A88BBE
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 17:52:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4XdtTV1BQKz9sJ5;
 Wed, 30 Oct 2024 17:52:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730307150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Uf51O40ASPdVpdGhk8mN/tW+kh2s5+WOXKt5p9cKq4=;
 b=mOHWh7NBlv0hPwDAXxD6O5DsrtW0Z6l/ZGpFuEbHO4V2nmvXw9kWdfQxa14CMaCGBlR3rf
 JTgCpiW82g4In3tqkPvklNM7ll8WNA+vdQiTagvzXC9DYic0igC9UCOHd4VngARiPjjTCF
 zxdxdriNExRHiR3EXGImz+chyg68AvRjGtmlp0scvnU4mEB2TyQcq6sLejP91QWdqG5sIR
 t6aCCiM+ZEmWDdDW9rmXciIZnO7Ix48bmPaik6cx8Hkih9BSRplKEBN3VwmCs0b3CRYP23
 /FQakWE3fmC4h8cCDyOyIserWJI5X1v/uspEt/qBPAvbNemPCAP7vEJe6N6IZg==
Message-ID: <3692c31f-b54d-4fc2-bd8e-d872f42944ee@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730307148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Uf51O40ASPdVpdGhk8mN/tW+kh2s5+WOXKt5p9cKq4=;
 b=ToRBpxeq1/+Bweo49Z67Yck3J8cZav2sB0ZzuEyKdjsJua6FxA3lEQdJLUHCYKG4sTDThV
 xMK3crGksiSG1R7dBrcuBmgMp5rogLM6aMNE1n1easWGwbWE/q9AfOGLkt7FyDWIL/Pjm0
 i5zin+FL4albf24qTqhLGnm7vPbvp6i1S6iEFjc53BOoZbkb44oyxzulZ4gq4RVw1sG1Ul
 XkatAybrBicoYJ17d3t2TDc41WoJT2BTTgw/9utdiQCMC4ir+xjkRD0g5jtYkZtqnWF/DW
 Ad8aQAAH5o7xhb9X5WjnpH9rUMUU0XXXrVtU8cFTu7LLzGuLBXDZMNwIC89CXA==
Date: Wed, 30 Oct 2024 17:51:42 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] ARM: dts: Drop unused RZ/G2L devicetrees
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241030145137.737-1-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241030145137.737-1-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 9ydxe7rnc9uopakg7j3q6izz9j9h5bzt
X-MBO-RS-ID: e482f4922b31825e05c
X-Rspamd-Queue-Id: 4XdtTV1BQKz9sJ5
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

On 10/30/24 3:51 PM, Paul Barker wrote:
> We are now using the dts/upstream subtree for the RZ/G2L SoC family so
> we can drop unused devicetree files from arch/arm/dts.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
