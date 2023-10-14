Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E6ACDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1F2186ED1;
	Sun, 15 Oct 2023 08:42:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XOBp+dnj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="L9MPqYTZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6BFC86E47; Sun, 15 Oct 2023 08:41:57 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9062586F5E
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4S7Drj2Bnjz9sSP;
 Sat, 14 Oct 2023 22:05:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697313941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=413MB3rGXvWTw+2LNuClV50YsSeuBHoSs2GoLaOZX4E=;
 b=XOBp+dnjkH6yxEbwHNB8gtTQX1+CUExhBTZtaJGkyqH94zDn/VZQwJK4UaHsvp90DtGcwo
 oATES4Zt1MukRvJ6uYKkyXhJ4slweLAGGOBaO3LCWCCA/mbql1seLW7MH6C1MD4X/AJAYc
 F9GJcYoW3sdDxcLKiP0Cl+me+LB7gX+LFuf+jgXrhOHw+kRrQSaGp6AKFXv3O+b7eVMFck
 KcGYQPLgw/yxF1NKdZY1T5X8AYLlfY4zCIHgXd+6dGPoqvYQ6knbSPB9+yDqTuSCECErxn
 N8WlY7yxODTYg+POCdxEvtYDaQhB9+hS8UX9Mxjunk7erzOZpsmdqN60zSvoBA==
Message-ID: <8fed1a92-ccbf-43c7-ab89-840d0b73f3be@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697313939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=413MB3rGXvWTw+2LNuClV50YsSeuBHoSs2GoLaOZX4E=;
 b=L9MPqYTZwNAGheV8kVVx6tnJjNKD5KDU+Q835vj1ZcVcoVCBxexVea4Idv2E1PA0WhxVVn
 SyUXTqxt9Osgodl2aGaAChhZBffwBHSIiL7Pde/wqozTt6oH5Ei3g4t9/egkkXXfifAQJR
 Rz9S0zbmlg8CU2Vscc6wfNeq21fSPfPtT+M0x6UB9VwJa67Qy1xUvMXe6jbGELnDHKPXNz
 X9VWwSYkhXQu+2Sz31cdSbDW6nLAzuXM7Dy+2N81JVRgXkfNSvwbFxBVte8uDdN9YOPwKK
 Je1CeD1aKfxezBTZo95SVcW9OtLFf0l1LRkFdr2taDGSLTZLbiSMeewxwVhvTA==
Date: Sat, 14 Oct 2023 22:05:37 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] doc: Migrate Renesas board docs to rst
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>
References: <20231009111136.79646-1-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231009111136.79646-1-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d7060fda31131fcee79
X-MBO-RS-META: c3uu8dt5ih8ps8bazp7fg3914dcgztzu
X-Rspamd-Queue-Id: 4S7Drj2Bnjz9sSP
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

On 10/9/23 13:11, Paul Barker wrote:
> Some of the information in README.rmobile is obsolete, references
> defconfigs which no longer exist in u-boot or has broken links. The
> information which is still relevant is moved into the reStructuredText
> documentation under `doc/board/renesas`, and `doc/README.rmobile` is
> dropped.
> 
> The list of boards in `doc/board/renesas` is converted into a table so
> it's easier to see which defconfig to use. The list is expanded based on
> reviewing the current u-boot code and the contents of the eLinux wiki
> [1] [2].
> 
> [1]: https://elinux.org/R-Car
> [2]: https://elinux.org/RZ-G
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

-- 
Best regards,
Marek Vasut

