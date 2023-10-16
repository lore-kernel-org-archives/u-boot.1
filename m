Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA02ACDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 12:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9A7A86BB3;
	Mon, 16 Oct 2023 14:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="cePtU29Y";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xyXCd5LN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B371386823; Mon, 16 Oct 2023 14:59:03 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D844386BD3
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 14:59:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4S8HHT5C4Xz9sqr;
 Mon, 16 Oct 2023 14:59:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697461141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/lG3DkH0uxdLg9ItiqG56MbR2W136yWh6cnsITTMK6w=;
 b=cePtU29YAm6lMv8rbYsfGSCFkJMTQysDAhnwIvm6Em2kktMVRehNjsab+AxY5U+z0VZR7c
 BulwLpqn+vWmAr/woi/AHQ3Wxa3C4l8mvtEFQrWFhKXUnZLK4P2+pcLnGqufoQuHtg9b7Z
 f5JTePx0zlkOSqDcWp5tWoaq7UtnHNmuYHeT2HMVP3P8N/3os/jGetlygkmHyjZd0gHE1Y
 BGEnQFooYRuBXI3EJ1O6HIqjWCSkLRA7571cs54zavp1/hvEnzb9GSC+4qHtmezmNq6xQn
 VVNeYFZ1kwahdXtv1E++DZRgenmeq99hhe5mKxKJgcZff9JuFy5zHN/Ulp3OXw==
Message-ID: <d962c5d4-660a-436b-a9a9-ebd6e7d52287@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1697461139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/lG3DkH0uxdLg9ItiqG56MbR2W136yWh6cnsITTMK6w=;
 b=xyXCd5LNz/I83qR7RErQltby9WO4ZL5VngBFFDOLKo8R94pPQl67GTbQLcsXRSxCLSgYMH
 WWictP8SFH23ukgtwLKfJMm6pBeX4P66lZ53V2vNX75BtNFNAM9tDFhT8gKpAwaUZM8URq
 AieDR2wf7A2X4nRa4fWetdr1vzrVLnY4Ul6e8021UUzu78l/f777dfxt5Cm1tUS+en8wpG
 MVceNZetYW7jiD6jx8ysKcl3FmNueH1iHbkdO78QgwUkQcakMVTh4Y/uWf+8KPhHd3J8XX
 omvHKYZL9TkMDjbFQgiIFKEhJI0DyPMBsdCfmsl6qKv8juMlrh/QO2F7g/8S5w==
Date: Mon, 16 Oct 2023 14:58:57 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 21/21] board: rzg2l: Add RZ/G2L SMARC EVK board
Content-Language: en-US
To: Paul Barker <paul.barker.ct@bp.renesas.com>, u-boot@lists.denx.de,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Hai Pham <hai.pham.ud@renesas.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20231016092543.3833-1-paul.barker.ct@bp.renesas.com>
 <20231016092543.3833-22-paul.barker.ct@bp.renesas.com>
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20231016092543.3833-22-paul.barker.ct@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: bc7f5d6101400e1bcec
X-MBO-RS-META: f65yirknczs8mp47oj7ndm1h1ust713w
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

On 10/16/23 11:25, Paul Barker wrote:
> The Renesas RZ/G2L SMARC Evaluation Board Kit consists of the RZ/G2L
> System-on-Module (SOM) based on the R9A07G044L2 SoC, and a common SMARC
> carrier board.
> 
> The ARM TrustedFirmware code for the Renesas RZ/G2L SoC family passes a
> devicetree blob to the bootloader as an argument in the same was
> previous R-Car gen3/gen4 SoCs. This blob contains a compatible string
> which can be used to identify the particular SoC we are running on and
> this is used to select the appropriate device tree to load.
> 
> The configuration renesas_rzg2l_smarc_defconfig is added to support
> building for this target. In the future this defconfig will be extended
> to support other SoCs and evaluation boards from the RZ/G2L family.
> 
> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
