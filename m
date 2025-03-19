Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807E4C28B2F
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 02:35:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 847898191C;
	Wed, 19 Mar 2025 03:35:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HSC6f+tI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AbTzApkb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74D73815D1; Wed, 19 Mar 2025 03:35:31 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C61F815D1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 03:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZHXr12tCXz9snP;
 Wed, 19 Mar 2025 03:35:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742351729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4U4STGqJeGTEO+Cq9StnvxVQL5cA5Udemom4Wg7xOKw=;
 b=HSC6f+tIOGFEAmaQ6jj6c8EtcCPBg9mafO0f8fYu+t1Te0mz6YoEDbgCxOvjtHPUD6ZuQ4
 srd4+nmu/iOkDkkP6yyZGVKHtR5ChnC8TP16VbanYPisGrqryKPT3h9FZHrgaz3h4Rj4lO
 d920WgbmWuysGnXe5s8F/hGtWzUkyDfFfJzKVC1mKWfN9o5it6Wrta33Inaxn9xtw68hTC
 LMeOfa2N/xZtXv4oE9uv405EAUrlh42w+3GVTPZg4RJ/vdhGBPRKrQdMdiA+S6dQ8uGij3
 kNM+eLNZfM03eyuffU7UoAjCNhFV00DMiYqmDbvbCR7zpiDcbEYWNhTPtKpBFg==
Message-ID: <225446ba-b716-4378-84ee-ebec5378710c@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742351727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4U4STGqJeGTEO+Cq9StnvxVQL5cA5Udemom4Wg7xOKw=;
 b=AbTzApkbgIeCWX4W+32Xqp9YyMm79XbyX8abmB81d4msdUCnyDAYZJRDJsZKuqmA42933D
 7PwzDBedRxJ3M3kmR3Dj46DFOjQJe7MDXXoeV7A+NdUxzVwa2y2sZUWWeixT8T0bAI809c
 rxa8xNY3auZmGQEWqShbzUIcVJOIK/b0osImJixe9ES57yKnXdjZ7RwtlYTH84z2bL7fn/
 UovNqZWfg7BQ12H7TXj4M1LXx0m2j35eV9768W+8h4vUGvaJM/z0dXj8cblIiyxgTP3un+
 Rhn0lefZj14n2cpvBOFaro0Ur5BFfgq354zMb89ff3uN7CC8XI+2kIrvcZRskQ==
Date: Wed, 19 Mar 2025 03:32:57 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/5] renesas_rzg2l_smarc_defconfig: Enable USB support
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250311205748.2492-1-paul.barker.ct@bp.renesas.com>
 <20250311205748.2492-6-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250311205748.2492-6-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 8mymj63er4fko6h6jydsp73efp437uy5
X-MBO-RS-ID: a98266b91f93887701f
X-Rspamd-Queue-Id: 4ZHXr12tCXz9snP
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

On 3/11/25 9:57 PM, Paul Barker wrote:
> Enable support for USB 2.0, USB 1.1 and USB storage devices on the
> Renesas RZ/G2L EVK.
> 
> Also enable the 'usb' command to support USB scanning and debugging.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
