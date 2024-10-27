Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4599D1356F
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 16:34:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C308589051;
	Sun, 27 Oct 2024 17:32:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nAuM6Axw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Et9/MgCg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9F0A88F6C; Sun, 27 Oct 2024 17:32:28 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84ABC89099
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 17:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Xc29T1vBvz9sjc;
 Sun, 27 Oct 2024 17:32:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mMMDFAmR7V8h48Fe+0Fgx4UgA+l8rMdxoZ77K0LEWno=;
 b=nAuM6AxwbC9LvaOY8a1kZNLnwOoKl0DzGF+DK8j7Lono/kDahzURFz7al5GuOqgmano8pN
 a7IGw9lxNsP2N5Nltzrj9rMnLkm5KCytrqBSXTQDsgfN3zY1yKNgKVBkZr+srHC5fdccY1
 R7+8bo2Ak8pQOmPvLWnK3fW0SRy/MPfnQgl1uObbPFR1yjv59NUjHc1AgiUNNC2t2NYKxg
 PQ9uX+WjQ2N9L042/OrlLTGI6vjjEiHgzMvVcU0dygzj0WzbUGMlga1gOolVaPOlXcGphr
 3R8XrUCl6a7t9gELZnhzU8+/GPYaipus9UYQaJd3CZ95r9Y4PAr0YVik/PSjTA==
Message-ID: <1aa8a914-dbd6-429a-a6ad-1c3753cad9c5@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1730046731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mMMDFAmR7V8h48Fe+0Fgx4UgA+l8rMdxoZ77K0LEWno=;
 b=Et9/MgCgmquqedcdiG+KFF5MY1ts4Ddsxj7U6N4xm7zS4XH1M9usI86ESKnf9ryk7jpaPf
 Ah/jPiZANXhMe0+sAYN7gAGHzPhRUTkk8OXO4syp+arcdmwX3eAlg7UhD/R4C0k86VLN9r
 Qt+8p0/qd0HPZYKXVUxhr2GYakPnKC7VIGrPgnyLt8PRoh0T0dniORK8k3GGFGfA5aeHIJ
 LSdwepVhUQrNvWKx0rviFQnLNS5yPnf5sTn7ET5XaCjserK5xNJlcT3St9Hmssi1PW0L/e
 HmbQmilWHcxeIWyxGBogMxFzMjQhi5P76oyifhitPRSB93e/etQTtXxuEp86VQ==
Date: Sun, 27 Oct 2024 17:31:08 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] mmc: renesas-sdhi: Add compatible string for rzg2l-sdhi
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de
References: <20241023105319.334-1-paul.barker.ct@bp.renesas.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20241023105319.334-1-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c3787a3c383ed8c6aaf
X-MBO-RS-META: gkitfmumpsrd5dmdpbfpuxrobtbksfsd
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

On 10/23/24 12:53 PM, Paul Barker wrote:
> After the recent dts/upstream subtree merge, the sdhi compatible string
> used in the device tree for RZ/G2L family SoCs is "renesas,rzg2l-sdhi"
> not "renesas,rcar-gen3-sdhi". This broke the ability to access the eMMC
> and SD card devices on RZ/G2L boards.
> 
> Fix this by adding the new compatible string to the sdhi driver.
> 
> Fixes: 136b7b6d2e98 ("Subtree merge tag 'v6.11-dts' of dts repo [1] into dts/upstream")
> Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> ---
> Changes v1->v2:
>    - Moved new entry after "renesas,rcar-gen4-sdhi".
>    - Added Reviewed-by tags.
> 
>   drivers/mmc/renesas-sdhi.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/renesas-sdhi.c b/drivers/mmc/renesas-sdhi.c
> index 23db2a75c444..92afa6adcdac 100644
> --- a/drivers/mmc/renesas-sdhi.c
> +++ b/drivers/mmc/renesas-sdhi.c
> @@ -864,6 +864,7 @@ static const struct udevice_id renesas_sdhi_match[] = {
>   	{ .compatible = "renesas,sdhi-r8a77990", .data = RENESAS_GEN3_QUIRKS },
>   	{ .compatible = "renesas,sdhi-r8a77995", .data = RENESAS_GEN3_QUIRKS },
>   	{ .compatible = "renesas,rcar-gen4-sdhi", .data = RENESAS_GEN3_QUIRKS },
> +	{ .compatible = "renesas,rzg2l-sdhi", .data = RENESAS_GEN3_QUIRKS },
>   	{ /* sentinel */ }
>   };
I can take this via sh tree if that's OK with you ?
