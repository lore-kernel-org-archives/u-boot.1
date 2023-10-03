Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39247E7AD4A
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 13:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69384872AD;
	Tue,  3 Oct 2023 15:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kc98tCEL";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="shAy/a2v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A62B48723E; Tue,  3 Oct 2023 15:40:46 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E00B086E13
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 15:40:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4S0Jqc60zRz9spF;
 Tue,  3 Oct 2023 15:40:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P8GhSyyIDzCGaIw9Ytez5dBkAqpOKd/O62nnagNscx8=;
 b=kc98tCELMreZnFY4Nr/UM+WejxigTsRJQv4cgl5HWxnNHDGbfQDj2MNVfPPbYn0w+C+Uzf
 wl/K5s2GH3l2pUdhpaYDJwC7ml+Rs02kwm8eE81G1X8JBuZzLXkHJTSfOtx8fMiUiwDGdp
 +2AHltkcnjVfYjEYR8ob0GFZCRzGpN8MDhUoaDiRYbeHWtHyMxGLZEXBPpTnH8OI4fVhj0
 FI6FjCS8wiuyLWUG0+m8N2N3gkBxUQR8sobYG7AtgfD0/GRsu14czxhe4XOvoCEueAaWSZ
 YmYVlYVKmEvmcyiO3mr3K3YexqPng90e5urwNTxaQ42DYssKdLxw+BedmBN2zA==
Message-ID: <6ad8b69a-665b-6bfa-9849-c4b5d72cd537@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1696340443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P8GhSyyIDzCGaIw9Ytez5dBkAqpOKd/O62nnagNscx8=;
 b=shAy/a2vkSp+yeU6Iex8sVG2kSm/+0OlCLQmbDPmUV4nCIYOqx0Kh1EzPRaJPu0YMwCW3K
 CeI4Wwmm5Ea7sKK7OTK2jRpfS3fnCWanawP05X8camMK8QI8bKryMECXBOjKJl6AaUumCS
 z3t4syYEUSCcWXTZRUykl+D6CQSFU3h3tDbedSKOrcyRf4KUU0GogBcTKQ1kJFNQoYA+kB
 TxG9I50KhnnKKGPD/DHpYMh9WO3Ilnb7CfIBwiV2Mrx4/EseJ0THZE3hol09nEtPyIw0XT
 CmF5EN39s52GkCt9J/Y35CY6UgfibBXtZpSUgq7nQHeNi558wdaOA/1xXr8cDA==
Date: Tue, 3 Oct 2023 14:42:57 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 03/16] dt-bindings: Add RZ/G2L PFC bindings
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
 <20230920124212.63535-4-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20230920124212.63535-4-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f89f5e9ee7bced2899a
X-MBO-RS-META: hyy3kp9m4mit9ikk76so6f1tojdc9iu6
X-Rspamd-Queue-Id: 4S0Jqc60zRz9spF
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

On 9/20/23 14:41, Paul Barker wrote:
> Import bindings for the Port Function Control (PFC) module in the
> Renesas RZ/G2L SoC family.
> 
> This patch is based on the dt-bindings in Linux v6.5.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>


Please also include the exact commit ID in the remote project when 
importing files from it, see example in e.g.:

a7be3fb54a65 ("ARM: dts: renesas: Synchronize R-Car R8A77990 E3 DTs with 
Linux 6.5.3")

With that fixed:

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
