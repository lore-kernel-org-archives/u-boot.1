Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 438DFCDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19BED86F4B;
	Sun, 15 Oct 2023 08:38:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oO+rD1dM";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="P6LEyE+l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BF0786DCA; Sun, 15 Oct 2023 08:37:50 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B5FB86F47
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4S7DgH0yfpz9sbf;
 Sat, 14 Oct 2023 21:57:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697313451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zfWKWL1sHAsScth/ot6g+OMTX6iyAB1FV3EPPNTFNE0=;
 b=oO+rD1dM7PeD3XSxbR79f/VGklsCwUw0kb9jVPx9YutgwFaRrgbTPNI7uaa+yAp33cUwCq
 p2YNXtcc1AL0ZvRgZcUciVJAta4rFE0ryB5B8zw/soMosZwJNdVcYx633CB8Da0m+rk8cz
 xuuvPRU8H8lRVCcC7J1kW9c8lnNuphN2+F1oUllArREnMChYbpyI0zQSQFsMghuIUdKGEk
 QdfyssBi0E3tu9p2vLVSyiKXZFY3kPQXAn5Y0MbGq11oDPMFS/zrPW9hVnswfNecbkc7SX
 W18vRV4xAX8O/heVKyR75i6me0J1n9qNkUtYFrjzGBw11vW5j3m/6xLErtg3CQ==
Message-ID: <6bb972d4-7015-4ddd-8466-dc92d061dd8b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697313449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zfWKWL1sHAsScth/ot6g+OMTX6iyAB1FV3EPPNTFNE0=;
 b=P6LEyE+lJGeKFeYeWKzWi/YV11OxD33A3ivBiJhSzoRHDdaWQeOGg4oQ9QtTVx42lt8TRJ
 N08HQ+3scTIYHt9wCIQSt+8GKmUBRCmyypoXgISXZRpTl/2e4EOxqrb6k3HnJ+/XW5OqAG
 qkMR3Nox0TYX3tzpRYbdI9WYtLAOl3jOORFTT9qNJWqi2tjmXkRy0M+bOJeBw0a0wn70mF
 20AT0ANQNUMdwKdNx8UfkUjmy8XUYUptblhEL7DDGSfrxy1wiKXA3otC0Q8or063/4GVNe
 9CIuy49PxgT2O2xMLgfBe6qJJneBs68UgbBvp5kwk3JNdOp6abHuB4DdddsnIQ==
Date: Sat, 14 Oct 2023 21:57:28 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 16/19] arm: rmobile: Add CPU detection for RZ/G2L
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
 <20231009164645.164464-17-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231009164645.164464-17-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: pfjjxziuheradatfq5n68ew4okfwn7q9
X-MBO-RS-ID: 8fce7a3eab36cc0a65a
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

On 10/9/23 18:46, Paul Barker wrote:
> The ARM TrustedFirmware code for the Renesas RZ/G2L SoC family passes a
> devicetree blob to the bootloader as an argument in the same was
> previous R-Car Gen3/Gen4 SoCs. This blob contains a compatible string
> which can be used to identify the particular SoC we are running on.
> 
> We do this as reading the DEVID & PRR registers from u-boot is not
> sufficient to differentiate between the R9A07G044L (RZ/G2L) and
> R9A07G044C (RZ/G2LC) SoCs. An additional read from offset 0x11861178 is
> needed but this address is in the OTP region which can only be read from
> the secure world (i.e. TrustedFirmware). So we have to rely on
> TrustedFirmware to determine the SoC and pass this information to u-boot
> via an fdt blob.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
