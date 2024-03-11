Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88DFC5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 15:36:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC2E787D35;
	Mon, 11 Mar 2024 16:36:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G70YHgHG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E29387C48; Mon, 11 Mar 2024 16:36:36 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1D2787C48
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 16:36:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42BFaK5C047454;
 Mon, 11 Mar 2024 10:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1710171380;
 bh=q8HHtyyWpEBvFwivGbtGBCsaH1Go/i1sedNYgym41S4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=G70YHgHGS6mkK651fo0+9ESEQ6mWx+GzZWGBjQbJgVG2UAhNb092Io+T4pkcC/1sW
 PHmBupRZGSMmQBPadBz83YlfzbW4MzQ++nRIsAG8O0XiryteikTk8FLpVOjWSwTua4
 shnRsQ4aluo1Z3CHAz2yS/++lLBxnk7XQOKISvsc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42BFaKF8015896
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 11 Mar 2024 10:36:20 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Mar 2024 10:36:20 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Mar 2024 10:36:20 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42BFaGIr126622;
 Mon, 11 Mar 2024 10:36:17 -0500
Message-ID: <32e8bffc-dbe7-48d9-985f-d794aa6a4848@ti.com>
Date: Mon, 11 Mar 2024 21:06:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] lmb: Avoid to add identical region in
 lmb_add_region_flags()
To: Patrice Chotard <patrice.chotard@foss.st.com>, <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Michal Simek
 <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
References: <20240311143918.2927406-1-patrice.chotard@foss.st.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240311143918.2927406-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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


On 3/11/2024 8:09 PM, Patrice Chotard wrote:
> In case lmb_add_region_flags() is called with the same parameter than
> an already existing lmb and this lmb is adjacent to its previous lmb with
> different flag, this lmb is added again.


Same parameter means , addr and size and different flags correct ?


> Instead breaking the loop, continue, at the next iteration, we are able
> to detect that this region already exist.

Once region already exist detected, then you can think of returning 
error , no ?


> Issue reproduced on STM32MP157-DK2 with SCMI DT, bdinfo command's output
> shows:
>
> Before this patch, the last LMB [0xde000000-0xdfffffff] is duplicated:
> ...
> lmb_dump_all:nnn
>   memory.cnt = 0x1 / max = 0x2
>   memory[0]      [0xc0000000-0xdfffffff], 0x20000000 bytes flags: 0
>   reserved.cnt = 0x6 / max = 0x10
>   reserved[0]    [0x10000000-0x10045fff], 0x00046000 bytes flags: 4
>   reserved[1]    [0x30000000-0x3003ffff], 0x00040000 bytes flags: 4
>   reserved[2]    [0x38000000-0x3800ffff], 0x00010000 bytes flags: 4
>   reserved[3]    [0xdaadf000-0xdfffffff], 0x05521000 bytes flags: 0
>   reserved[4]    [0xde000000-0xdfffffff], 0x02000000 bytes flags: 4
>   reserved[5]    [0xde000000-0xdfffffff], 0x02000000 bytes flags: 4
> ...
>
> After this patch:
> ...
> lmb_dump_all:
>   memory.cnt = 0x1 / max = 0x2
>   memory[0]      [0xc0000000-0xdfffffff], 0x20000000 bytes flags: 0
>   reserved.cnt = 0x5 / max = 0x10
>   reserved[0]    [0x10000000-0x10045fff], 0x00046000 bytes flags: 4
>   reserved[1]    [0x30000000-0x3003ffff], 0x00040000 bytes flags: 4
>   reserved[2]    [0x38000000-0x3800ffff], 0x00010000 bytes flags: 4
>   reserved[3]    [0xdaadf000-0xdfffffff], 0x05521000 bytes flags: 0
>   reserved[4]    [0xde000000-0xdfffffff], 0x02000000 bytes flags: 4
> ...
>
> Fixes: 59c0ea5df33f ("lmb: Add support of flags for no-map properties")
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>
>   lib/lmb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 44f98205310..b6afb731440 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -285,14 +285,14 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
>   		adjacent = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
>   		if (adjacent > 0) {
>   			if (flags != rgnflags)
> -				break;
> +				continue;
>   			rgn->region[i].base -= size;
>   			rgn->region[i].size += size;
>   			coalesced++;
>   			break;
>   		} else if (adjacent < 0) {
>   			if (flags != rgnflags)
> -				break;
> +				continue;
>   			rgn->region[i].size += size;
>   			coalesced++;
>   			break;
