Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521B5E9271B
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 02:03:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3D06839B1;
	Sun, 28 Dec 2025 03:03:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uiQjTnWQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAFBB839D5; Sun, 28 Dec 2025 03:03:40 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DA8183981
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 03:03:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4df2h84v0xz9tXv;
 Sun, 28 Dec 2025 03:03:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766887416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5rEgg1f7w5dfMVHn/Qw8wgumRtze4b3chkE/GgvdWkE=;
 b=uiQjTnWQK3cc+yhoGZn/qiAC7H83aDN1HAA6BfQymW54FpqxA9/SWBSG1ValZ4xh6MBs23
 wQ0coxgffOqygyRIPTe9h8DwWThc0nbY7HkL1K2L9XYb/PO5S6T/ZNygrxLfGMK/o8Bboh
 rpSKWLZgVY1JtCfNZejDGdcCRF/WQ8mgA7d7uCWllYef5VQed0SFBPNbjvSUG5UqtDAAL/
 Bo/Y5+QDmxfe3LZQZUyXn7PGjbezqGiAucXN7SMcO/M1oscifDeqjEofKMJYN+ri1s3k64
 O3u0+x30s4qaRuLn+94NEL56aaKiaIsAaOwkAeJqS+19E+AymNOgwiHOqsr/SA==
Message-ID: <49554065-2782-43f8-b298-ef575d6355ae@mailbox.org>
Date: Sun, 28 Dec 2025 03:03:31 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] clk: renesas: Do not enable MSTP4 modules on R8A77995
 D3
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251228010327.2836161-1-niklas.soderlund+renesas@ragnatech.se>
 <20251228010327.2836161-2-niklas.soderlund+renesas@ragnatech.se>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251228010327.2836161-2-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e2cbbab8c34a4a4465c
X-MBO-RS-META: c18juu64idyn93hmny9bhs1ty33giao4
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

On 12/28/25 2:03 AM, Niklas Söderlund wrote:
> Since commit a2bd99549c61 ("clk: renesas: Tear clock controller down
> last before booting OS") enabling the module gated by bit 8 in MSTP4
> prevents Linux from booting. Furthermore bits 8 and 7 of MSTP4 where
> only documented in early versions of the datasheet and have since been
> removed, do the same in the driver to allow Linux to boot.
> 
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> ---
>   drivers/clk/renesas/r8a77995-cpg-mssr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/renesas/r8a77995-cpg-mssr.c b/drivers/clk/renesas/r8a77995-cpg-mssr.c
> index f49faa47cb37..0a59a19cb227 100644
> --- a/drivers/clk/renesas/r8a77995-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a77995-cpg-mssr.c
> @@ -220,7 +220,7 @@ static const struct mstp_stop_table r8a77995_mstp_table[] = {
>   	{ 0x03e01000, 0x0, 0x03e01000, 0 },
>   	{ 0x000e2fdc, 0x2000, 0x000e2fd8, 0 },
>   	{ 0xc00014df, 0x400, 0xc00014df, 0 },
> -	{ 0x80000004, 0x180, 0x80000004, 0 },
> +	{ 0x80000004, 0x0, 0x80000004, 0 },
Should we disable both BIT(8) and BIT(7), or only the BIT(8) that hangs 
the system ?
