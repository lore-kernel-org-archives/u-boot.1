Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82404CC6B27
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 08:40:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 539C340560;
	Wed, 14 Oct 2026 08:40:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o52s0bDja-UZ; Wed, 14 Oct 2026 08:40:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ADC63405E2
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791967212;
	b=gHEoHHs9+R17eyMYgKqIWNs+JoqvMVfF2mUQmHMOFMMb8+1OQwnn9q9MWn/Rl92Aly4I
	 HEhozv/qaPBaSxm/I2qHLv6UPcyAvddaXbHv2s4wXmIkJj+ekR68SFxktVU7pX6/kyeML
	 IntA4AkdhpN3FGBHQMwXcsyVA3xpNJE3WJ4KgbW/jOypspQL9ixtDhtmkRZ0DK3DVRUHG
	 IQxauhlD3bfrKT4BB7ABf99RVrJALl5Qw9dNME1sWgvYep5h5g4kmaQxYq0xPL7eU4n5g
	 ln5QryEUWvhXXyLiGrDEvIRZL271/3dGKwhUmoVs1x58xeNQzFWN6qdCiXiAKoHmp/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791967212;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6IP8raRAkLSd/tBR3+o44rVso+tZ8mLJGzHWXdivca8=;
	b=dI3M5NGQtNFGzWDwem4GFDlhBqlnE/mOaD6F/5q9qDfVSL91U9GJCJIx2jopaC+qiAWD
	 BWNts9nMLZes6lJRY5FhqRiRV/TmDY/KSDARtEKpoNwP8Sd34XUsP7MHrYSZqflyTEFfG
	 3Kwn2t7QROervco/xAMHL974mEQ4gGa9VdN6gDWsJQmLYN0ws3zd8rRHaT/7Pgntqs8d1
	 C0C9l8NKEDHNZo6oT0Msrrjjz2rLjxgFc0NLtdf0EcJ+KSSaHN09x2/cZWe0OG4LmngIz
	 R5HFJCSlY2pDRk0p2Vip95m/AdrkL1guRi2NEeoay2cOSw0+uH8C92TB0awFrWKxx6w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791967212;
	bh=6IP8raRAkLSd/tBR3+o44rVso+tZ8mLJGzHWXdivca8=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xn7gEqSmHW4IQeYzlsMgQGYE0xV0QzdYcGA/w3yUkevjF5I+mGXtTKX94WPh4cDcj
	 MBodbiLyInLeiWXd2IiUDhCNbHNM5KshtO/eJFRwny4ZudqqJ8YCkfIdcwrY/bOSSQ
	 Xz/5/X/GQ8oMyapNnVNss6CAsB1wSJmjt/mZHI1tau+cnQQsCWU9IyaoRIiOo9F9W1
	 HnpiXxW3qnlKJCkokLAHrG+WnPfh7FmjSPXSNdLkN/qeH8FRafwkycER+75TDWSb4Q
	 VBlFcnKbOYnDIT/oi0fsCI5A7dApR0MKkJMMFLVgAqFbFhuEmKFJMOjF1nylYRM0tI
	 SDNZ38SbGUXXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ADC63405E2;
	Wed, 14 Oct 2026 08:40:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DB14E75
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CCBC580D4A
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:40:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CyuWTCKG9hIV for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 08:40:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1D8B780A86
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791967211;
 b=svJjw9hjzYaTIL6kb6BD1zhpFgl60ZBiUbocy3ir5HlOm78HjNZN8eVjMJVW2eTC/zWu
 fA6ALlXv4HahWd3a9hFPEBsJs5slG2PtogM5uoGW+0HUJ363Fd2NVhy95QtiMVlHwpRB8
 qoAw/TKzZ5lltQB+uiw2cEKpfxZUSTtQaJS41yT5WYR6J5rWr9IMXJ2U7hJz5W67kofSE
 hog09M1BufygHLtTdfZfNGOa2BKdUrDXxJppidX6cpp1atnFXndZpJpqpItF5qyP7Bv9k
 HOl/SyikX4uO2LVTHDYeIK01ncFLwlpTOQOGGBjJq9LWedGJZ73gjC+cmfq92dRBfng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791967211;
 h=Received-SPF:Received:Date:From:To:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
 bh=6IP8raRAkLSd/tBR3+o44rVso+tZ8mLJGzHWXdivca8=;
 b=Heo93ITEG1g5u0Ch3LPvCWiXXJYIiKH7dwbQs8WG+xdhzjCIcyyCrxLzYdqfDN8rTHCf
 /pjpOACctgiqfgN93lsHk0FcxJpgk4yWAw35wCSgEatQCnyvrtux93G2qs0uuos4l/AXZ
 zJDXSCNBJfoWNUPSGpXN8YcS1lKG0wvCi77WOkbCTniNgwjze2BS6CfI7MSPcoNceoz/E
 NMEQQ3VitlEYeTDCpRGNTdwqAF0ql3Frpj3kOgSbM+Meq0r9ttfco82BDF/bDlB07etKz
 ZZBalS/yoRED90hLwHj+U0/VLb5JxxGKMyPwYODMj279XjcDlt3u510QhEEDM0z6aGA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=none header.from=makrotopia.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D8B780A86
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 08:40:09 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xGuWs-000000005el-48wG;
 Wed, 14 Oct 2026 08:40:07 +0000
Date: Wed, 14 Oct 2026 09:40:04 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Tom Rini <trini@konsulko.com>, Daniel Golle <daniel@makrotopia.org>,
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>,
 Vincent Jardin <vjardin@free.fr>, Anton Ivanov <anton@binarly.io>,
 Randolph Sapp <rs@ti.com>, Anders Roxell <anders.roxell@linaro.org>,
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Subject: [PATCH 08/11] boot: bootm: set the imagemap from bootm_start()
Message-ID: <a79101a48ba04103503ad7c834c05f160964ec13.1791966831.git.daniel@makrotopia.org>
References: <cover.1791966831.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1791966831.git.daniel@makrotopia.org>
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

bootm_run_states() puts the imagemap back into the global images struct
after bootm_start() has zeroed it, which leaves the invariant split
across two functions: any later state that calls bootm_start() again
drops the pointer, and BOOTM_STATE_RESTART is already close to doing so.

Pass the imagemap to bootm_start() and let it set the field while it
initialises the rest of the struct.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 boot/bootm.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index b9aa83c3328..67df647d176 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -275,7 +275,7 @@ static int boot_get_kernel(const char *addr_fit, struct bootm_headers *images,
 	return 0;
 }
 
-static int bootm_start(void)
+static int bootm_start(struct udevice *imagemap)
 {
 	/*
 	 * Free dm-verity allocations from a prior boot attempt before
@@ -286,6 +286,7 @@ static int bootm_start(void)
 	fit_verity_free(&images);
 	memset((void *)&images, 0, sizeof(images));
 	images.verify = env_get_yesno("verify");
+	images.imagemap = imagemap;
 
 	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_START, "bootm_start");
 	images.state = BOOTM_STATE_START;
@@ -1198,15 +1199,8 @@ int bootm_run_states(struct bootm_info *bmi, int states)
 	 * Work through the states and see how far we get. We stop on
 	 * any error.
 	 */
-	if (states & BOOTM_STATE_START) {
-		ret = bootm_start();
-		/*
-		 * bootm_start() zeroes the global images struct. Restore
-		 * the loader pointer so the storage-backed path works.
-		 */
-		if (IS_ENABLED(CONFIG_IMAGEMAP) && bmi->imagemap)
-			images->imagemap = bmi->imagemap;
-	}
+	if (states & BOOTM_STATE_START)
+		ret = bootm_start(bmi->imagemap);
 
 	if (!ret && (states & BOOTM_STATE_PRE_LOAD)) {
 		/* Pre-load verification is not applicable to storage boot */
-- 
2.56.0
