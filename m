Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D778CA5FAB
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 00:06:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 155D86070E;
	Tue, 29 Sep 2026 00:06:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kBCtdVohiy8r; Tue, 29 Sep 2026 00:06:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 43F806070C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790640362;
	b=hbjdEhE/JgxziB9byRuSMqiK1cPOCM9fEL44xgtofdbRwsyFEwI2Y+8fLSX06d4B2ILQ
	 naUP34Uq+nA0SOHHQ4rbWvCpR+pKc5FU8o7oPPaqkkaQCO3OHcfGDnqxvfcoWUovXpah/
	 XenpYI/AsyOZrvUg1VPe5IVA11UpyNFDJezrKVk/2WutZawqu8M0F8qZTTU71+4guvdvS
	 YCgY13JZFKK7H280RQL3hQPr/5VC/+07ld4ztziitRJLO11VKOJm+ZANN9cRCLBM2JhOB
	 2MPqUOzW1OSAQKSvHnQx2cKl+sw1B9vvpUKclLfgVjmX35qaYme/TsMmd3URyFNm4BA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790640362;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=YB6vv9WDUe5IhHUA41NRg1B41anJtYluI+Ln2crrD28=;
	b=IVO/P96cUJvtn3FDl/pPQbwo+MuXsVBRKfuqwrb05otrWXjj6G0GENORBcDRptsz10MC
	 exjKiPm7Jo76Ocf/OL5PFDL0+tsIGehmc2O3W5U9khQF25CRhnpwJZiKixVeoXnus2asy
	 liOGoJ9PHhq09cA1kHhoFGiIVRjajESmwvIt0GfbI849pgRER8i1wXvg7kV22+YxAKOiY
	 VL7bcWLJuvSs4QRI5Ct+zjalF5QE2JA3RWm6OMHvlpb3aVR4hHBG+V3KFB0UOtO072inp
	 WcgDYz26no9PNWgP6w787txX/YOuuMuVNXyhg+S6jFVF8TMO+pDbeZ8p19l2zfrD8aw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790640362;
	bh=YB6vv9WDUe5IhHUA41NRg1B41anJtYluI+Ln2crrD28=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PIw4ie8scsyPMZoj6gNVeEuFoWBAPXSPafAdEZ0uJcL2szmu+Eq/JO2NKkzTuJRyV
	 Pax4NtWszP03U3hcu5u/S5GUNdFRG2HB5eyk1vPIxEcGPtmOcZZXrGmBuQvYrfrcxx
	 gNV5CuM7YzRiIA6kqIJYXbZ4uUMejEKT+8xkAxl0txarmiuBD6xYepUkvRHE1lmVTN
	 jo01vIMYGLnas3c2QJ8wauKwP2dmsmX53tYADlNPqrtxAm6T0Aa++C3fV2XN1aOa7L
	 jzbAzaaH7Mrbfq+6a6mCc+qpLQM/t1/u60MeoL4NHVcOwsZQKhdI8UIpp3NUtI5qtE
	 4l6Pzm0kvQmDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43F806070C;
	Tue, 29 Sep 2026 00:06:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B84E335
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:06:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7B0524056E
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:06:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RVLNChHcwT2K for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 00:06:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org D6F4440568
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790640361;
 b=rSdmh6ti5EbObcr3KTf+PDNuROQmDTDd75rBo64BKLQTdG70X89nMQuO9bEVxeODZI22
 74J1c7vq2eShrCMJ+m6hfS6c9+v2UI7rMBH1WS2kFVVfuNb1cFuV26UpQVQuGrvYkbt/8
 Ff445B8/z3teD27ZQIWxlrFwbjMS5mDNq0kJ8frHFj7U45GYwpx+iWh0y2lDe4gYUIkC8
 rp1pCy98QDlL8ilLeYq25ETCWq22O6cBqbSm3rXxVDJ+mbwqgtQ85Xzzu+MIPuQbnAwZ2
 LFLLoTXvuW+DuiRs3kDqEJQKypwJbmMLGE/snPqbUoN4eq+CstEubNhOaXf3GPv799g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790640361;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=YB6vv9WDUe5IhHUA41NRg1B41anJtYluI+Ln2crrD28=;
 b=M9llxECAOS+OWEbniEAj15PxqarD9D3LkBwGBLArNjpT4tDrks3osLahezha/qGY+tDI
 yG08Npj2xQnxEnr7ss/CiC4a0JrF91wBX6uO1p3waUdhDScwZqRFKr7iyj5alrb7z6ZqL
 bsB8yvnkqfhuqDn8mjo1a4N5m0FbMckATe6oK7tHAoqDWskm3UQihHYOsGJBYq7/g8Wt1
 NX/EoNGl6HjbdsMKucEWT3f4ZZB4j4u5OiL2CsS8EhYtQ3Ym1nlEQlN7R3QZxDFeLM65D
 QInWVmfVWw9oUJVqMEIydBp+Lqs/RxvFyFR0ujTddeMbpL+8oOsyOZHCnzKgtzNWz3Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=none header.from=makrotopia.org; 
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D6F4440568
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 00:05:59 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100)
 (envelope-from <daniel@makrotopia.org>) id 1xBLM3-000000001Q7-03AR;
 Tue, 29 Sep 2026 00:05:55 +0000
Date: Tue, 29 Sep 2026 01:05:51 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Kyungmin Park <kmpark@infradead.org>,
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>,
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>,
 Weijie Gao <weijie.gao@mediatek.com>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 09/11] boot: bootm: release the imagemap on every failing exit
Message-ID: <09c5c1f0cb1b49d571529f8c04191b8a24eb5505.1790626459.git.daniel@makrotopia.org>
References: <cover.1790626459.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1790626459.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Three error paths in bootm_run_states() return directly instead of
reaching the err label, so the imagemap device and the LMB reservations
its translation table holds survive a failed bootm: the missing OS boot
function, an unsupported subcommand, and any error carried out of the
earlier states. The first of those also left interrupts disabled.

Route all three through err, which already releases the imagemap and
re-enables interrupts.

Fixes: 46d32e38ee4e ("boot: fit: support on-demand loading in fit_image_load()")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/bootm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index b6ae0163b27..92c8452a5d3 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1265,18 +1265,17 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 
 	/* From now on, we need the OS boot function */
 	if (ret)
-		return ret;
+		goto err;
 	boot_fn = bootm_os_get_boot_func(images->os.os);
 	need_boot_fn = states & (BOOTM_STATE_OS_CMDLINE |
 			BOOTM_STATE_OS_BD_T | BOOTM_STATE_OS_PREP |
 			BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO);
 	if (boot_fn == NULL && need_boot_fn) {
-		if (iflag)
-			enable_interrupts();
 		printf("ERROR: booting os '%s' (%d) is not supported\n",
 		       genimg_get_os_name(images->os.os), images->os.os);
 		bootstage_error(BOOTSTAGE_ID_CHECK_BOOT_OS);
-		return 1;
+		ret = 1;
+		goto err;
 	}
 
 	/* Call various other states that are not generally used */
@@ -1318,7 +1317,7 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	/* Check for unsupported subcommand. */
 	if (ret) {
 		printf("subcommand failed (err=%d)\n", ret);
-		return ret;
+		goto err;
 	}
 
 	/* Now run the OS! We hope this doesn't return */
-- 
2.55.0
