Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081D6606A31E
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YaXf++x/
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8FB0940A01;
	Thu, 26 Nov 2026 19:07:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MkihIBqcAcPF; Thu, 26 Nov 2026 19:07:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BD881409FB
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795720023;
	b=pLMst7y9EQLX0EaLCaWbQmoz+tsXwb6C0+s/rXI/0wJtzlvtORhCYWjx/p4KULMiFj52
	 j97YgZVsr1OcX0fTpu8HZakRWStRYw6wL2IMWkUlZRMUSxyq/eZ89elZDjf9W0KGy1Zwf
	 Qa1+b1yse0zp7BC1dc//3q02NQud+oVV1SV08TkXmzcXeesiYi4wTYHR4NleB4fB/AXmY
	 7mlowAb63cx3IdMwkzuX8tyNWlp/RJRgkl6nMTteazxCGGpn/p6hPVFxSZTtWWftMu4cw
	 4D06OO3izZ/cwsc44br7yMB143dCKpdrdqPB+GJ3bCmIEGwHwfaa/mKvTKl2yAXS3Gw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795720023;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=bh+1MAknXgKoho242un+52sSApHm5MRkQBTgAv6TJf4=;
	b=lO5Wu8vLPgIzZzN6RyfHxagaa56pKXhbE1GlMoLBozcUCCnmaGwtC0ZLcy+MIUvcSggh
	 3vnnp8a86rPkJi8lStZT0nCA3EgBTrztNniwZUIGohVSrp26ZKElimvSGMtzHcd9Xf4f8
	 Js2CCtow529tlNuDcLsrCebwbpc4BIajOhWM+ehrlIYG7p3BDqKte2aGQsVFj8EJSrHqn
	 smfa7G9R/BS45mHPD7K2qZvhczfK/e8CjI3Kc50VyhfI0HGNh3KcyDPs80W1bY2cjH0mR
	 1ERoEvDPZCvsfykl6ATh6lQdHdSyVEPQbJJQAVm9YZb74HJz/RbPVqlsoHqf7L6/blw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795720023;
	bh=bh+1MAknXgKoho242un+52sSApHm5MRkQBTgAv6TJf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YaXf++x/JvzcJiYm/TucODYTfQ2+7//rbb1V7S5HOFImkbSWRL8zyjkFgTomdL5xd
	 w0tJ4doXmLpTL4i3WabelTxRLRDn6IxEqnSTW4di94Am1UAJWdMYw7eO/2HpAIwnyy
	 BQgXRrAr6fXb8yrQaE6T2SuYhxodGUTVBe/7MLJm6C6T+sgCzcgcjQmiY55o8sMnCI
	 FHaOJd/sb5FZZTZvJCn7gB24c8aQrGe2Xe9jBvpbEyCT7zg8BSoRhSzCEjagPDd/8U
	 1UbFTGhNJ+sDoimR/V2EgQelA/2YuvLLpyVoU6GP8El17c6mYJgPBpoHOCX+Ntbb3+
	 qvKn5yeAApW6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD881409FB;
	Thu, 26 Nov 2026 19:07:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 187EA1AB
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 19:07:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0A99B811B9
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 19:07:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DqlTjU3RCGsB for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 19:07:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7FD9B81111
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7FD9B81111
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 19:06:59 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xWeo4-000000007ra-2zj7;
 Thu, 26 Nov 2026 19:06:56 +0000
Date: Thu, 26 Nov 2026 19:06:53 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Alastair D'Silva <alastair@d-silva.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@gentoo.org>,
 Enzo Adriano <enzo.adriano.code@gmail.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Alastair D'Silva <alastair@d-silva.org>
Subject: Re: [PATCH 17/26] sunxi: dram: a733: Add ARC PMU 1D/2D eye training
 firmware
Message-ID: <awiDTdTwKwnvPoBp@makrotopia.org>
References: <20261113023236.569054-1-alastair@d-silva.org>
 <20261113023236.569054-18-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113023236.569054-18-alastair@d-silva.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alastair,

On Fri, 13 Nov 2026 13:32:27 +1100, Alastair D'Silva wrote:
> [...]
> +	is_pm0_mode1 = (is_pm_0 && is_mode_1);
> +	is_cond_or_m0 = is_pm0_mode1 || mode_zero_cond;
> +	is_mode0_pm1 = (is_mode_0 && is_pm_1);
> +	step_val = is_mode0_pm1 ? lo_margin_val : 0x50U;
> +	is_eval_active = is_mode0_pm1 || is_cond_or_m0;
> +	timing_reg_alt_b = is_eval_active ? step_val : 0x51U;
> +
> +	alt_reg_sel = (is_mode_1 && is_pm_1) || is_eval_active;
> +	hi_margin_val = alt_reg_sel ? 0x4fU : 0x4eU;
> +	pass_reg_a = alt_reg_sel || (is_mode_0 && is_pm_2);
> +	keep_pass_regs = pass_reg_a || (is_pm_2 && is_mode_1);

The selection of the delay registers to sweep is wrong for three
combinations, all with a non-zero swizzle flag: operating mode 0 with
sweep mode 0, operating mode 0 with sweep mode 1, and operating mode 1
with sweep mode 0. In the per-bit scan this sweeps CSR 0x50 where the
two per-bit delays 0x4e/0x4f are meant. On my Orange Pi 4 Pro (4 GiB,
see my reply to patch 15) most per-bit delays then stay at or next to
their reset value 0x40 and CSR 0x50 is left at 0x7f on every lane;
after the vendor boot0 it reads 0x35.

Suggested change:

diff --git a/arch/arm/mach-sunxi/pmu/pmu_eye.c b/arch/arm/mach-sunxi/pmu/pmu_eye.c
index 1c1ebb35363..9fb59d99a82 100644
--- a/arch/arm/mach-sunxi/pmu/pmu_eye.c
+++ b/arch/arm/mach-sunxi/pmu/pmu_eye.c
@@ -2529,12 +2529,12 @@ void pmu_cal_margin_matrix_scan_eval(u32 channel, u32 rank, u32 slice,
 	is_pm0_mode1 = (is_pm_0 && is_mode_1);
 	is_cond_or_m0 = is_pm0_mode1 || mode_zero_cond;
 	is_mode0_pm1 = (is_mode_0 && is_pm_1);
-	step_val = is_mode0_pm1 ? lo_margin_val : 0x50U;
+	step_val = is_cond_or_m0 ? lo_margin_val : 0x50U;
 	is_eval_active = is_mode0_pm1 || is_cond_or_m0;
 	timing_reg_alt_b = is_eval_active ? step_val : 0x51U;
 
 	alt_reg_sel = (is_mode_1 && is_pm_1) || is_eval_active;
-	hi_margin_val = alt_reg_sel ? 0x4fU : 0x4eU;
+	hi_margin_val = mode_zero_cond ? 0x4fU : 0x4eU;
 	pass_reg_a = alt_reg_sel || (is_mode_0 && is_pm_2);
 	keep_pass_regs = pass_reg_a || (is_pm_2 && is_mode_1);
 

With it CSR 0x50 ends up at 0x35 on all lanes of both channels and the
per-bit delays are trained. With pin swizzle disabled the flag is zero
and the change has no effect.


Cheers


Daniel
