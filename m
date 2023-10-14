Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D06CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 06:44:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0705286F04;
	Sun, 15 Oct 2023 08:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xuJyPATH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="iXmXJyCR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CAF88652F; Sun, 15 Oct 2023 08:24:18 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D46BF86529
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:24:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4S7DRH62NMz9sWZ;
 Sat, 14 Oct 2023 21:47:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697312827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pQ0ic/Fxf4pl9YZvHZ3pRYALI9ngqzZgAgDMk4+7xwM=;
 b=xuJyPATHACum2d8Q9o0+f+e79+ArCuMxVXd1IkglWY1YDa42qSlQGinJNqIG0eo+Fp39F5
 WJ1ve0k2KU8eGVqYHf16aNzUZJQI8IsdJ9dcz5JtnoPlkTpNbvghFR2Yj3bjgR61OOgy7B
 j78aEtAMWy7bj/+I6u7UkSY7N0cCiiugvy79kFFZ7vXKW5oUtqiH0+cTa4s5at9NVt/I8c
 BiW7CU34jcJKfmSFqcaYosTtgisy9/58hjeaoxfWSZwvKTT9KC2ljNJZ+FEa0p/zrkns2R
 FnIAjnJZLROwzzdwn7kxZhqjtsoY9XBYpJvIitozE8VHdbph9IOu3FqhabQMOw==
Message-ID: <45c7a2ae-bde8-42d9-a0fd-c38101e5b57b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697312826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pQ0ic/Fxf4pl9YZvHZ3pRYALI9ngqzZgAgDMk4+7xwM=;
 b=iXmXJyCRog6DZFyW69JSbpLrIFwXxfNH0yIYZlVsg7YCGlbpHpzQ6hd5ZGxoJGAArkF9HS
 ao7CT4j8cV3b+NyV5pARPvwTKcxEh1Ym5HNE7HBGbduQ+vS7CIxT7Pmm+FY4dO1d5w+ybh
 6TLFXvbvSk7ziiWyi9awELI0TpL0t8yNuN/nVsE8uZbkjYNnW2xRP1ykNSC7JhtUGLeEW0
 zJFTNP36qUWSjee8LHOPD24k8emV2LGW6KT9yUmYe6lidowMKxtOUEeuCZ4/X9ejxVOwxa
 Rp/gd82c+GdEP5tBruySxmzYOjhQJ9GUfzgv/hAHPGf8NTqWPxtT8ni68qPB1g==
Date: Sat, 14 Oct 2023 21:47:04 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 07/19] clk: renesas: Add RZ/G2L & RZ/G2LC CPG driver
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
 <20231009164645.164464-8-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231009164645.164464-8-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 4194c1844e3f5db505d
X-MBO-RS-META: aakddawzofunk67htqauk1ryofyqhmmx
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
> This driver provides clock and reset control for the Renesas R9A07G044L
> (RZ/G2L) and R9A07G044C (RZ/G2LC) SoC. It consists of two parts:
> 
> * driver code which is applicable to all SoCs in the RZ/G2L family.
> 
> * static data describing the clocks and resets which are specific to the
>    R9A07G044{L,C} SoCs. The identifier r9a07g044 (without a final letter)
>    is used to indicate that both SoCs are supported.
> 
> clk_set_rate() and clk_get_rate() are implemented only for the clocks
> that are actually used in u-boot.
> 
> The CPG driver is marked with DM_FLAG_PRE_RELOC to ensure that its bind
> function is called before the SCIF (serial port) driver is probed. This
> is required so that we can de-assert the relevant reset signal during
> the serial driver probe function.
> 
> This patch is based on the corresponding Linux v6.5 driver
> (commit 52e12027d50affbf60c6c9c64db8017391b0c22e).
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
