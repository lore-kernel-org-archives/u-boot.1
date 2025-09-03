Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA508CA1014
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 03:38:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E67B4836C1;
	Thu,  4 Sep 2025 05:38:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Xa4BdQxD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A18E183616; Thu,  4 Sep 2025 05:38:01 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEF88836C1
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 05:37:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cHQD54s3vz9smc;
 Thu,  4 Sep 2025 05:37:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756957077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BMhae2qOgA4OAaDJ5kO+ZQdKC+Bb0LvRM5gYjGp7/e4=;
 b=Xa4BdQxDV7z0shEpPMG+X689VF7/p+n3GNw9f9ubiqQAhhG5ebkJbeFHJhXkRUW8km6FIG
 dLClW0lppfmKd8v7Rhm66ilhj0G7JKE9m/h8dwKSmYf9B5f9O2EPJDDBagiNqJgIn2PK9h
 J+CE32Lh3c0aHt999RdU5XTRkz+A3JrhGW/Li7t/jzSEMNR57Ql8dKoEQZh7mp6tQX+pM7
 zIwCkTuIXteTIKv5kKijsRZRGvOvMuJ+CtDZzi6TWlvQ7chZ9j5yZ+kauQNVKsW/VmOz6c
 ADGUqwkDpXiW309ozUP2PPUH4PNR5x0/gy3MtvnIX0THci0HtA3lngr3HoQCwA==
Message-ID: <937b1be4-68cc-4853-94e5-2f14cbcef194@mailbox.org>
Date: Wed, 3 Sep 2025 15:02:20 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 4/5] Image size checks: Deduplicate Makefile
To: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>, Ye Li <ye.li@nxp.com>
References: <20250903105653.335417-1-pro@denx.de>
 <20250903105653.335417-5-pro@denx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250903105653.335417-5-pro@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: h7sgx1ko7fowrh88bpeboyc6t5yd1n9s
X-MBO-RS-ID: 9c5d69d60e68a8f10ed
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

On 9/3/25 12:56 PM, Philip Oberfichtner wrote:
> Deduplicate some redundancies within the SIZE_CHECK code in the toplevel
> Makefile. No functional changes.
> 
> Note: To make this work for the special case of SPL, spl_size_limit.c
> has to print an empty string "" instead of zero when there is no size
> limit in place.
> 
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> ---
>   Makefile               | 45 +++++++++++-------------------------------
>   tools/spl_size_limit.c |  4 ++--
>   2 files changed, 13 insertions(+), 36 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index a17d8b57196..b6f01591ee9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -428,8 +428,9 @@ KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
>   # Check ths size of a binary:
>   # Args:
>   #   $1: File to check
> -#   #2: Size limit in bytes (decimal or 0xhex)
> +#   #2: Size limit in bytes (decimal or 0xhex), always return OK if undefined

You should be able to use the HAS_ variables to correctly test for and 
handle the undefined case .
