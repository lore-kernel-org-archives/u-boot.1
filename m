Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C63CA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 11:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D4B1810AD;
	Fri,  9 Oct 2026 11:37:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x-ToU63Q-gbr; Fri,  9 Oct 2026 11:37:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A26D781375
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791545821;
	b=EugSLqTmn6/Sy/7n9zTN7dskikMF7aeCFQGNPlL3qmvhGDfWd//1Ld21cPil/GHfnIAs
	 tDKhDLHxFtEnEkV2ey80o5lhfnFEWcHfxNZo1D/R3qz50V0d9EINgK2iATvMs+n/Irj3J
	 dty0ikJdDOLIphiDry09kq3vEOrzyaLX4ULlIl/BKfP5LIb7Tw8UsZLlKDKT+wuc3GSt7
	 L6QBrVB4bnlHLi+rVZXYjabD6RLPAhTQH/bgmKQzpgLW6hCzuH03679JBA7xOxFF64gSl
	 +m1gEYE8tzoOtXekNhlvAQslvEDmBQCpE+OwYt8qsHcdpktNnGawqp/r9rzcGMu2TjA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791545821;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VV7+Ai5gvfL84zDVY/b4hyOAfzCUSsYQaZwfrtCbDJw=;
	b=ldllwzRjBgZfoRqrpmJonLG7ngVIHAQFQD86tsP53R+J1pQ8ZVCViM9MhPLXUxXTXrjv
	 TBE8+87fwG2Iw9q4sE81lbu7Wi75sy4vIcvaaLApnf0y81bxzyg2RGoTXs6ERbu+NqIzI
	 +6DziDDdkDK5g2d588D2AmDxWDQx1M1EWkZL5I9Xelaa+DghHSaFkRnae7Ghu3zGFYzep
	 Ng0oct6C71WDOHOKk2dCVpuOa5oYNeu0MjZylKhsIbgvyMkRLET5E1Jg/3gqNvcFVR05v
	 xVtYKtFN8Cq4LuiFH4jhRY1VDfhjDEpZSikxJ1+bAL8YjwHo9yXsVW6K90YGuIY/75g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791545821;
	bh=VV7+Ai5gvfL84zDVY/b4hyOAfzCUSsYQaZwfrtCbDJw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mivs85CbzsS28hbanMUl6Qjf1mpeC75m0PAa7TQSz30/DoCuV6YuOSwOl+RouagG5
	 WbNOfBWI7bkdHMn0QlrMSpNq2Fywujnrh3zOB3f+CfhEudpqWUmDTDLng3LBDJDFZK
	 AbfO5g6++IRTYCHUTQzRprX+FM+LvAq8GpioG0sYRypDCujbm4xE706ywKRSrtTbxt
	 O13apwIR4/gOYUQcdvsDzYUn0rHSCDXceqYm3JJfsv6fWeBHB8hz9baSHlFukZ3dNd
	 JubYBDwnHxrFB4ZWy7hYLEhlZ94N/4F41werkTiWmfpcvoqDIJqb8uShVWMRiGcD2N
	 0JWBS4N6oJgtA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A26D781375;
	Fri,  9 Oct 2026 11:37:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B500156
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 11:37:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E5B5540098
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 11:36:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z3VMSUAXgqNM for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 11:36:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E178740061
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791545819;
 b=oZseVN24kDmg/chgtj6ZKyaRSLPS3IVmTTPv/N4qFwJBWrgGriD1uQWMw/bF2aUhllqn
 nF/oMMHhXn6Y4p9fxoz3FHFcdGAxVOlQovTzru4sa3mBlQ/gMYzX7MPnxfCiXIUQDEnlr
 UE1pXqpKbsE77wnVEYvsm0DHhKoGm+QSONYxtovdbRbZeTZRqYtxcLLjSeA0RIEdKIQRX
 /K6yWa2lzSw83s+xDdEU+I5jPqh4BKoQq7GwobvGanjVWIFRzxOTeMZrD3dgZbrN63hvX
 uWJSO240MZSUNHps3KsIeBHOBgHTK4UUBmE6Qo+LpXUNbzFPBDPkVeB5unVuoSa1oUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791545819;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=VV7+Ai5gvfL84zDVY/b4hyOAfzCUSsYQaZwfrtCbDJw=;
 b=ULgODBFSfwUkkn8STqBOrpQEy+Z3Sl3ndxj9ATOG7WLA0Ye+f1Lw1C6Io/ZunE6JdwRS
 cEkyGTSnepztyGHase8M2cyFVqLRZiklvDFJb3WjwcxoOHKkfRfG01Ch9rvF+iHO/pQgE
 YEvkUPezFeRWI5KtbdjQqc2PXdTq81gbh0xHBm3vAizLAlcxZPsnymrBRiwfau1v/w7LE
 aPpp8NDQtbNP5cHaPIXT4y4ISyiPhN2vgo/QAViAVJ8tDIh1cYdWQ+4ISIfCzB2Z2dFlW
 aWLhCcLwoWbmjTdPQ6ubLlEwSfLHeLrAqq6WqJObPG6XjfThqPc71//Cyjo5VnATrcg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=W0DeAftY; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=ghidoliemanuele@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=W0DeAftY
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E178740061
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 11:36:58 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4956869750eso24281895e9.2
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 04:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791545816; x=1792150616;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VV7+Ai5gvfL84zDVY/b4hyOAfzCUSsYQaZwfrtCbDJw=;
 b=W0DeAftY/tbK72UfxUR2bGI5X2vg+RM3U1geNCTEP9R/zhH58rDekcaMhCz6Yr77bD
 vJVme0lX/4XYeWSIvZU7iDUvX9mBleHeOvhOuaNbAMBVlgutSMGkLir/9U8Ouevdr/a2
 F509jCfWoGulDx/rGeWFVTMhfGwy7p/4ehX/FaVh/hE3+V0MHG9Cs/XBpq+h+Uq0QjLJ
 H4PcqK5MKCrLQFE9Ux5K+Xe8B0/yBD0rgg8cw2ikRMGQZtiWFSkgovHXiM8LB2mUEZol
 Avz32yU2R+hAcdAmpObWHjKZGmlH7mkca3pnUxv4MVoj4sHhgNcYE2iBL1gRxONxSuUT
 2Hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791545816; x=1792150616;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VV7+Ai5gvfL84zDVY/b4hyOAfzCUSsYQaZwfrtCbDJw=;
 b=PVMEvTRtgaNQ3y6aNLLP/sPY/Z/W6oW33hE3F78KulaObSwrde+0YZJ/1zgG55jmyM
 mLDRYQvrTo26si1w56hrcq72KajaNUhrcbSlODReNjC+FgQVOHVdF9kvub9wF2VwuqvZ
 UX0KeMYVrsT+7bn2gkR4EpYfvqKwa8r16KYVeuA3j53/IwlRI2oLyDHKgYDl/lcehk/S
 Cviq79tOILH4nqdfJJbQXvC3GHE6/RQ0pO81UK95ldNLNmerv3tiJFkk1cbDIJhQZzhi
 dBZyd6qGp+l4H0rnwGmNHxZYIAoWYFLYCAwzORYV2U0h682LSmdlVLxG5x9hbHEhSqG6
 BBtA==
X-Forwarded-Encrypted: i=1;
 AKwUvByl/FTAe0FBqf0MEluLxLvkRI0ZbspbhQTDHKO3I+x4DiHu7zoMSUJuqhRQcdkqpxI7oTKkEDI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kWhopxslEvqXUgAhBpzcdcAAt3h58FAfAtMDa7Jmjh9HhOGiBs
 j66WTVDjMl9+GlSnzkjxp3fsuYKNXgvRVzN9gFsCysC9jxHVl8U1625X
X-Gm-Gg: AYBFou39w9W42M3FxLOjUCvOJVcq9e037vSRwm4UY7fXZ72x7h6WR55ZuLUxkq3IHSW
 xKRT13ZZ+KCxyWXfSiqz0XrXV1TMCLHPhrehvvrAmidoWFhRDoswTQ4TKBknDoQiBhgEicq4TlF
 cnATVzreapndHREZE4f/jOK27sdTu37fOmo6wr21Qd5EIJIYgonG1KIhcrdxXJqcNXM1pOio6Ok
 whyEvc+PZB6o0gOgZy+/58YY7995sLNEHPV954A6q0SULMdh7En5+9xaM01pS3MjWfKwa0+tYH2
 A3r/wfdG707HRcTa3C7lsHJalYOKrKxPNhZBhpmJIJiEmRQRkX1vHq4q6UHBp2jeWBbNlVUd7o7
 nNCpeXYf9T629WhykXu2+Ncd62f/0ooVrDqzFCyjxNITY+afKYvZDEMfM/AeysrlDjdj1HSzWth
 HpzGCPvPCsbkQLUD7bz91UBW8A1he0epvOhn3hNhAkbEQ8hNa4TmsEACknFWyLQ6gprAbc9Prv7
 Sx98m8qUCrnrslYmXZ6WmzmjTb9J8XV
X-Received: by 2002:a05:600d:82c7:b0:4a0:1b14:e845 with SMTP id
 5b1f17b1804b1-4a18e446875mr30398865e9.2.1791545815867; 
 Fri, 09 Oct 2026 04:36:55 -0700 (PDT)
Received: from [192.168.149.125] (90-182-211-1.rcp.o2.cz. [90.182.211.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18e4a3b4asm79861405e9.5.2026.10.09.04.36.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2026 04:36:55 -0700 (PDT)
Message-ID: <56f0fca7-426d-46ba-a36d-d5070c5b9a33@gmail.com>
Date: Fri, 9 Oct 2026 13:36:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] imx95/94/952: Enable early icache/dcache in SPL and
 U-Boot
To: Ye Li <ye.li@oss.nxp.com>, Francesco Dolcini <francesco@dolcini.it>
Cc: festevam@gmail.com, u-boot@lists.u-boot-project.org, peng.fan@nxp.com,
 uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com, qijian.guo@nxp.com,
 francesco.dolcini@toradex.com, emanuele.ghidoli@toradex.com
References: <20260922022406.1838737-1-ye.li@oss.nxp.com>
 <20260922053742.GA8706@francesco-nb>
 <b914014f-b904-475e-8903-d8c9505aa896@oss.nxp.com>
 <20260922141839.GA242194@francesco-nb>
 <107bfad5-a283-403f-a241-20d6c4515b35@oss.nxp.com>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <107bfad5-a283-403f-a241-20d6c4515b35@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 9/23/26 06:25, Ye Li wrote:
> [...] 
> +__weak unsigned long board_early_mmu_tlb_base(void)
> +{
> +    return CFG_SYS_SDRAM_BASE + SZ_64M - SZ_2M;
> +}

Hello Ye,
I tested this on top of v1 on Verdin iMX95 [4GB], together with
the changes below to enable the caches in SPL. The board boots to Linux
and the caches are enabled.
I noticed the series has already been merged. Could you send a follow-up patch
with the board_early_mmu_tlb_base() change and the Toradex board updates? I’m
happy to test it.

Kind regards,
Emanuele

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 22f9c9d045bd..680a8b403982 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -615,7 +615,7 @@ __weak unsigned long board_spl_mmu_tlb_base(void)

 __weak unsigned long board_early_mmu_tlb_base(void)
 {
-	return CFG_SYS_SDRAM_BASE;
+	return CFG_SYS_SDRAM_BASE + SZ_64M - SZ_2M;
 }

 /*
diff --git a/board/toradex/verdin-imx95/spl.c b/board/toradex/verdin-imx95/spl.c
index 93e76be6145a..31730fc22c88 100644
--- a/board/toradex/verdin-imx95/spl.c
+++ b/board/toradex/verdin-imx95/spl.c
@@ -58,6 +58,8 @@ void board_init_f(ulong dummy)

 	timer_init();

+	arch_cpu_init();
+
 	/* Need dm_init() to run before any SCMI calls */
 	spl_early_init();

@@ -66,8 +68,6 @@ void board_init_f(ulong dummy)
 	if (ret)
 		hang(); /* MU not probed, nothing can be outputed, hang */

-	arch_cpu_init();
-
 	preloader_console_init();

 	debug("SOC: 0x%x\n", gd->arch.soc_rev);
diff --git a/include/configs/verdin-imx95.h b/include/configs/verdin-imx95.h
index b6df4d486955..98fc6f3757f0 100644
--- a/include/configs/verdin-imx95.h
+++ b/include/configs/verdin-imx95.h
@@ -22,4 +22,7 @@
 #define PHYS_SDRAM_SIZE		(SZ_2G - PHYS_SDRAM_FW_RSVD)
 #define PHYS_SDRAM_2_SIZE	SZ_30G

+#define CFG_SYS_SECURE_SDRAM_BASE	0x8A000000 /* Secure DDR region for A55 */
+#define CFG_SYS_SECURE_SDRAM_SIZE	SZ_64M
+
 #endif


