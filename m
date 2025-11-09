Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB56ECCF9F8
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 19:47:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E55D683F3D;
	Sun,  9 Nov 2025 20:47:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="T8hipxCM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F09783F4C; Sun,  9 Nov 2025 20:47:12 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BFD083F37
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 20:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4d4Nbw4M7Bz9tBc;
 Sun,  9 Nov 2025 20:47:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762717628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vp4ASMGGtPtzw1l/Hc18eoGedeQ5ZoOfm7UhieZbbjU=;
 b=T8hipxCMvJ3PIByg2LqBdpgGq4SSL4eosX2g/0uoII+wEshIbPuTCxWQYNmMYwGJDDne3N
 aQN5THWew7W7FR5Q8tkcw65S+rEQAJSABwubZDj+v7fdyjZXi7KjZthpNoP+LOJflipilD
 1cwQiJ0azFmLyzXIqmGZL059wpm8asZ/K7fnleZhh+CMMwDa4WAcoBU1B7IHI3P8WXMaZx
 z2hldXg1uz+/sI4Ep8ozWKH1AZzsES4Qo/2QAepwt77mvd0stXMx2wzr1cXpiaWBez8TQO
 0q3EWvFqU59PQNn/8Ay2C6bfUXkRUseoZH/8cIBeUsArubYkqqwXuQNCMoPB0Q==
Message-ID: <005646e0-a7ed-43c0-9b20-e115d577b431@mailbox.org>
Date: Sun, 9 Nov 2025 20:00:06 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/3] Image size checks: Deduplicate Makefile
To: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Trevor Woerner <twoerner@gmail.com>,
 Ye Li <ye.li@nxp.com>
References: <20251015012320.2331007-1-pro@denx.de>
 <20251015012320.2331007-4-pro@denx.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251015012320.2331007-4-pro@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 954a5945fad04d2d099
X-MBO-RS-META: 9aagb13m1ask3zgw84595hximesejp89
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

On 10/15/25 3:23 AM, Philip Oberfichtner wrote:

The subject tag is wrong, it should be "Makefile:" or "kbuild:" .

> Deduplicate some redundancies within the SIZE_CHECK code in the toplevel
> Makefile. No functional changes.
The rest is fine, thanks !
