Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DB3D6B6B3
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 16:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6561889206;
	Wed, 30 Oct 2024 17:52:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Tq8Ppbwz";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="p4egkiJW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D11189206; Wed, 30 Oct 2024 17:52:34 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1F5189215
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 17:52:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4XdtTW4WZJz9sxK;
 Wed, 30 Oct 2024 17:52:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730307151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QNjNFSf5zz/86BaCW7zIc66O0htu0NENruFkDC4Cht4=;
 b=Tq8Ppbwzo4TPKlzxx+hbd2/y3jiOViOXsOMvDfKzGBj6l5ieFAK+xeWrVaBq//ZVq94FTL
 b955VzO1WPtYGDCdyH0001Weu9Ge0CZnRKwa6OzzrHv1kv07aSSVt3u85GJkL/rTUy3ttn
 +mDrjYjzD/m7KxBp6DmUuHFYDQKM11fc7uQZLzCOWx5sTy37qt3dYU/MX4fvDRrZ/O+n+I
 ItnwMNkXC7qBj3nfy9gM6LzlcWa/o2HDDS4M5c9qpJv/xeroSiIOueowX364X4+kRssZfn
 +hevz8W0DOE7xHsfMNLpAqy2Wt3mAM+Oxgo75JWyCowJqO3ntoN1GudlbSohdA==
Message-ID: <2a1a06e1-d51c-459f-8925-f1b11b0e9a59@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730307149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QNjNFSf5zz/86BaCW7zIc66O0htu0NENruFkDC4Cht4=;
 b=p4egkiJWP4UNHSzuRfGjygo4oQK3gxtcYdfFf+VtLzy7QP+n71V8a/o8itAU0Uhbq4GtGe
 LumtnKZeMvQrywQFPEDpTa45Uq9B89yzs9CAT34QBf9hTq/MCoqj3dg/TkQVwwkGi40Ms8
 pjLgrOgFFSaBawOLOTHTHpLHBrpUdb3OIWwau4pgfrm0ZwVuUM3Hmdxh+A7fGtrXeqwmL2
 6SKe8g8xJ0ndygH7+MZCEmqjFkhT3gtkgYb1XFUL59ZjPPMc1qO+ieEPvvw//A2StUkzZK
 9WgvkfyFzrwq3jg/MooAZghkxem1AV/xDNEUVuFrMXqZQ56gC0jbx8VYS3R38A==
Date: Wed, 30 Oct 2024 17:51:55 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] dt-bindings: Drop unused RZ/G2L devicetree bindings
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241030145137.737-1-paul.barker.ct@bp.renesas.com>
 <20241030145137.737-2-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241030145137.737-2-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ms8ashxboismnxtzqkagq56u5qwdxtth
X-MBO-RS-ID: f5aa9eda37423e2ff90
X-Rspamd-Queue-Id: 4XdtTW4WZJz9sxK
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
> we can drop unused dt-bindings headers.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
