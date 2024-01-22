Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3084EC47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 17:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 586BC8777F;
	Mon, 22 Jan 2024 18:55:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="rfCzpbup";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4AEB8780E; Mon, 22 Jan 2024 18:55:27 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B9938751B
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 18:55:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=33c1=JB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1705946114;
 bh=bpd6fUYM97A5KgYnr9d3UyVAOCMsclWUdhVD3nUAXsU=;
 b=rfCzpbup5ocJcgfrvDUWELmLOhcQD3DsAbx+2B5XV4itmWfTUcBahXsaLG4fUt6Tawo9oT3/J
 vnDM0kVbmfI0DPoi4FHD1LhG+yWmf56oa1tMH2rZy2n3gEL2iqaO/QV28pHUZ37O0DSwNP99GYX
 98wV1Ufb5i7w1tyJ3FddeRgfErfUSOLeS+NXwApvwRY/Bw3wSeaXYMA6PpthkKT8cdH3cyeD4Pd
 iCTcmSuno/QaNMtnt30QBTMwn5hZe0S0hwBpXSxPL2K2E/hWaUtwVRgB6iSC6MU7rS0cG2MJksL
 xi/f5yibqNQF1iip6JUQiQUdQG1gRsRbHygFA1h9X/5A==
Message-ID: <3739f50b-faa7-42ab-856e-44eee3709957@kwiboo.se>
Date: Mon, 22 Jan 2024 18:55:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: sdram: fix LPDDR5 bank info for sys_reg version
 3
To: Kever Yang <kever.yang@rock-chips.com>, YouMin Chen
 <cym@rock-chips.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Philipp Tomsich
 <philipp.tomsich@theobroma-systems.com>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
References: <20240122074633.654726-1-kever.yang@rock-chips.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240122074633.654726-1-kever.yang@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65aeac029c22f20eaa36e8a0
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

Hi,

On 2024-01-22 08:46, Kever Yang wrote:
> From: YouMin Chen <cym@rock-chips.com>
> 
> This patch add support for additional bank info used by LPDDR5.
> 
> Signed-off-by: YouMin Chen <cym@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
>  arch/arm/mach-rockchip/sdram.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> index 99ecbdc3412..d65c48bf515 100644
> --- a/arch/arm/mach-rockchip/sdram.c
> +++ b/arch/arm/mach-rockchip/sdram.c
> @@ -110,6 +110,13 @@ size_t rockchip_sdram_size(phys_addr_t reg)
>  			  SYS_REG_COL_MASK);
>  		cs1_col = cs0_col;
>  		bk = 3 - ((sys_reg2 >> SYS_REG_BK_SHIFT(ch)) & SYS_REG_BK_MASK);
> +		/*
> +		 * SYS_REG_BK(Version 3):
> +		 * 1) Except LPDDR5 0:8bank(bk=3), 1:4bank(bk=2)
> +		 * 2) LPDDR5 0:8bank(bk=3), 1:16bank(bk=4)
> +		 */
> +		if (version == 3 && dram_type == LPDDR5 && bk == 2)
> +			bk = 4;

The version == 3 test is not really needed because dram_type cannot be
assigned to LPDDR5 (9) since the dram_type high bits is only read for
version >= 3.

Also not sure I fully like the if bk==2 then bk=4 override code style
here because the code comment do not fully match the code flow. I had to
stop and think twice on why the test was for bk==2 when it is bk bit = 1
that should result in bk=4.

Maybe we can make the code closer match the comment with something like
the following:


@@ -109,7 +109,14 @@ size_t rockchip_sdram_size(phys_addr_t reg)
 		cs0_col = 9 + (sys_reg2 >> SYS_REG_COL_SHIFT(ch) &
 			  SYS_REG_COL_MASK);
 		cs1_col = cs0_col;
-		bk = 3 - ((sys_reg2 >> SYS_REG_BK_SHIFT(ch)) & SYS_REG_BK_MASK);
+		if (dram_type == LPDDR5)
+			/* LPDDR5: 0:8bank(bk=3), 1:16bank(bk=4) */
+			bk = 3 + ((sys_reg2 >> SYS_REG_BK_SHIFT(ch)) &
+				  SYS_REG_BK_MASK);
+		else
+			/* Other: 0:8bank(bk=3), 1:4bank(bk=2) */
+			bk = 3 - ((sys_reg2 >> SYS_REG_BK_SHIFT(ch)) &
+				  SYS_REG_BK_MASK);
 		if (version >= 2) {
 			cs1_col = 9 + (sys_reg3 >> SYS_REG_CS1_COL_SHIFT(ch) &
 				  SYS_REG_CS1_COL_MASK);


or possible use of a conditional operator:


@@ -109,7 +109,13 @@ size_t rockchip_sdram_size(phys_addr_t reg)
 		cs0_col = 9 + (sys_reg2 >> SYS_REG_COL_SHIFT(ch) &
 			  SYS_REG_COL_MASK);
 		cs1_col = cs0_col;
-		bk = 3 - ((sys_reg2 >> SYS_REG_BK_SHIFT(ch)) & SYS_REG_BK_MASK);
+		/*
+		 * SYS_REG_BK:
+		 * LPDDR5: 0:8bank(bk=3), 1:16bank(bk=4)
+		 * Other: 0:8bank(bk=3), 1:4bank(bk=2)
+		 */
+		bk = (sys_reg2 >> SYS_REG_BK_SHIFT(ch)) & SYS_REG_BK_MASK;
+		bk = (dram_type == LPDDR5) ? 3 + bk : 3 - bk;
 		if (version >= 2) {
 			cs1_col = 9 + (sys_reg3 >> SYS_REG_CS1_COL_SHIFT(ch) &
 				  SYS_REG_CS1_COL_MASK);


Not sure any of the above suggestions makes the code any easier to
understand.

Regards,
Jonas

>  		if (version >= 2) {
>  			cs1_col = 9 + (sys_reg3 >> SYS_REG_CS1_COL_SHIFT(ch) &
>  				  SYS_REG_CS1_COL_MASK);

