Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59041C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 12:14:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E77B60B39;
	Thu, 10 Sep 2026 12:14:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AeWsfwlNHDcx; Thu, 10 Sep 2026 12:14:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 77ABA608E2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789042451;
	b=MtJrgDKd1qVGAmx7wACY66xj1zPTTsqcUcmsryzG4wX1nUj2WJpayetyt/G7DPcakavy
	 RIq0tEHuUz+n97bd3IkUIJ7vW28CGw1C4uL9wQemjl8NfkrJvJwFH/GCe3tU99bBk+KBP
	 8uh1RxjP4Di4Nzz5MYIbpV57E65HkeClRVhWPhxc8+KUmxZ8Tum5zj5gQwv+/4UL8WEGd
	 gs1aOhj/UmqUgVYb98W+QtWUHO5IhTay2E+qIC0Oop/H08P8NBdp8hj29TIPtH+5ElAtk
	 WX2cQ76tsz29Vp97CVULCMDEoOw0O+zZryPG/9+vGVHy+jIoX5IjbjihG7bDpg42f9Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789042451;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WeXHcc5XMKkXywXFMTAnIrlmrJrayVMy6PoM3GlUtFA=;
	b=SxRFh3OD0NUFTOolj3wddA6m4NcoZBqiKQ7ANOxjRvwUuwbvX63IaqasuhR2UaN/iKzS
	 5OvrkISups4ea96fowXfMPo00YumWa7v6EMz8bB+kdgZd5TaV+1HvK0PT46lE4ZK+2RKm
	 sIaGKVqmrErpQA9D+FgDh3tKxyelGRVC85SBq0zn3LKOlxrlQq5LgHm/zj0n6i4vpZ/NF
	 nc9SyEYr07S8uCMC0+QyabSQiEVbervslZsXMAh66HLUhN/GeNGhqgNmWdP2K/xpKBRUy
	 JRnWnqpQRVackgCnTD1FKuZsT+qmrMSqwrLXa6xQDSYH62IsDSjDW/KxgiObfWm5wAg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789042451;
	bh=WeXHcc5XMKkXywXFMTAnIrlmrJrayVMy6PoM3GlUtFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vZOJbu9MhHNh5k4xNHIMJ+jngumsmDMOexwlAuVN9s3z9GsfL7N6navrsMtlZgDIw
	 34LPvgsDaI5vLWGcmgbdvlEVIyoxj/gzG1EzW6bTyXaejeHKxsJ5O2yNeTJbxMiPCr
	 g0TnVqRfTg/ULf+tPnFTF/tTGc+mEd8FHUfXMUmrdMI4ktta7lG4x6ijZJ85S10PhX
	 JaM+dlT+phJ/QJM61CTDoESvwy1s8T8k4HmREkPgiequGFALsjP383aTTKinNoL0mS
	 WUTZshknI07IlkizSbsbMrt6HsVRZl8g9UbxDQXJgyRLs7duHOviBWha3CWZAlBi2v
	 OvHOWY5zgGtdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77ABA608E2;
	Thu, 10 Sep 2026 12:14:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 39C4649D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 09:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1FD11401DA
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 09:53:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jU4EoKPUgjhk for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 09:53:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 86A1E4006B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789034036;
 b=L82VMBwQaeXCpqwDpyPDwioDB8RZ/EiTUF17IoVxtgr0eR19XyZTQz8CY8SiWAcNTf2J
 fdguIr83A5ebubwjZqaYir/FycGVPhTvL+AQA/v+GgTPzldKAwtHyf4vy1BN4dqCwLbfR
 hLOYZK1BppEyXGmobdaQwgNE1c/tADbJD9cQZUBfypbFFaQPdFZ+AdmGRsRRrvz6Hvxsg
 2IrwjBTYnbjSEQLsM7v3uYD+lI1+MFJCmdZtvoN2e6nwHB88aAcvpfRX7QLXvl0iYde/K
 0rVnLBDV9//uhptjzB3+aXqmoC/GdfYbQMOMEJnHMvRychoL/TeUfUfT/pzeYvaCtZA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789034036;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=WeXHcc5XMKkXywXFMTAnIrlmrJrayVMy6PoM3GlUtFA=;
 b=kupER48sxnyqtWbU1o0etpBGFZRA4daOKE4nIeAHyUmGP9WkQp8dT6H5X2v3Wa9rlml/
 EhVgTvESLPEGPhgM7Ipy4oXFGbvD4tsAu6S3nrEa503/BAa7/krRCG4M1HHMDa9NN9SJC
 C5AZ3aD/Z6Eos74YLR+tJ80MTbeGtk7190rxzTk8Y7gmJHG/YKKIhrQPyYc/zy5um5CDC
 KbZNEQec2vG5K5CTtl3C4taXKD8wfTOBHtyu7zaW30SvxUopvuC1+f5X63Cca8zBFJRoA
 j2B0j6JliclUMwxlO8ZxUyyrIljHyNruJMlQUah+6RT3F6Wf7A3R3kxFDbMMrSuVYEw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=cdC64Bor; 
 arc=none smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=imkyufie@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=cdC64Bor
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 86A1E4006B
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 09:53:55 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccda24afso940828a91.3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 02:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789034035; x=1789638835;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WeXHcc5XMKkXywXFMTAnIrlmrJrayVMy6PoM3GlUtFA=;
 b=cdC64BorDZBHPbVDprWiNfryTh8nueV/GFaL8VBmZChnxvzT71EiNb/YJmKidLxlw2
 MilM1ursYT+i/u2kSIXl4ju87YU5lmnDGuA4qryFtd0AAMALveLL/o57pEajkeoRLWBj
 Fss3F3817sH4mP+MHjuMCef/0iSfxhShaJxaBWvl0A7xfoIPwgtascdClkqMHmp8zAPu
 InnZGM1DimxkGfv7GcRyz+opJDs+q7NPRe1gzIQ31xbVRCFeslzt+0AyizXiA8+Kup2v
 Vx2Q8eLMVNtspf/Uls7iCRlqFkv1TBVC85JTPi9hCnASxjPfNyuRERt2nG5bvia7MohX
 jd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789034035; x=1789638835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WeXHcc5XMKkXywXFMTAnIrlmrJrayVMy6PoM3GlUtFA=;
 b=shX1ibargCxaw1CdiyEpAzIe6qqhCvs2Tx225q80X7ElX704F91PH8QYyUT/QrJhc1
 SibiUrr4RZ49H/bE7RpGUFqxypbImYBLuDYuU17bwLG/r+saG7g4VFjiFtd4zZx/CEej
 7/9qlpLepeMVBFISCc9me+uEE889uaG3xMrt23p9Mt2597q/iI1CvUKZ5+VLYogVsxam
 Llif/D9vy2X5xlb2qQWhlrkNeNq9zd32D49DOjJAx265JPJT5AWQz/aSyuN8zXiNPI8n
 9xR0x8Pfua9DGmiDLfjyj4yKSRcYaAFM0ha269JXVUGbbTYorK6yqufzb7BQFEZOGn5r
 n3+A==
X-Gm-Message-State: AFuF++nHXgAhGRSelGBP0tEuQbM4xEOyIx9up7akHZn/DFY6CNXBOUMB
 7oJTvxtF31uhGGcDvYPp8PWOtNcAI7tFFA5nn1qDCEEf4iK9+YdEZ2HS3g2XZA==
X-Gm-Gg: AYBFou1/v4ogftOTPYkWsWu0Xz6K1scRkn2JMTMCWpTMl6GY9Oevj2OfPySNi3fwt6h
 8nRL/fUUzc89YUPuGOB/gU+quOy3YIbD8HvvEq7U95SxRokgh+gQbkLP0WVSgzRGWGt/Gk6CUD4
 lcjpDMTS1PPYeIse01RUxnTBYjaA5cwT0W7Tt5BowmYdhP0ex7/lV+iVkhQh+LRkhfVjkugs+Gq
 K7V2TGYJHujUWxU59yIIBxySlls2BfZWqhjTpoc70k2tUaTkz//35d72HceAdA5DKXzSafFcPiU
 gdvlJs7tkAs5/woD2WX1WUJ+i3fEJks617e2iTtCuIEJnkAzpbBXQitCtkDJbuYgiOCYgrmZnnH
 rRiX30fH24e2xsD4oEe4wwC0WfQC0MXoOR6mw1xCBY4lUH4jCxedMS+FquLKczupuXqmcDiDepd
 yke2BjzuuVHJR8n0OIlpkTCnUcu3X8E8rOpKErYTZcC9xC6l1t2gRSXnjAGZromg==
X-Received: by 2002:a17:90b:380a:b0:39b:2b10:d05c with SMTP id
 98e67ed59e1d1-39d709e73a6mr8644724a91.5.1789034035078; 
 Thu, 10 Sep 2026 02:53:55 -0700 (PDT)
Received: from thefoxflat ([2404:c0:7029:b3c6:7b99:50ff:b405:5c31])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d7e77498csm3849455a91.3.2026.09.10.02.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 02:53:54 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Reza Kurniawan <imkyufie@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io
Subject: [PATCH 1/4] mach-snapdragon: Carve out reserved memory at init for
 MSM8917
Date: Thu, 10 Sep 2026 09:41:44 +0000
Message-ID: <20260910095339.110427-2-imkyufie@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910095339.110427-1-imkyufie@gmail.com>
References: <20260910095339.110427-1-imkyufie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 10 Sep 2026 12:14:04 +0000
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

Certain regions of memory in MSM8917 are marked as 'no-map'. These
regions may cause security violation when included in the standard mapping.

Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>

---

 arch/arm/mach-snapdragon/mem_map.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/mem_map.c b/arch/arm/mach-snapdragon/mem_map.c
index f64ec0c67..eb0242ef8 100644
--- a/arch/arm/mach-snapdragon/mem_map.c
+++ b/arch/arm/mach-snapdragon/mem_map.c
@@ -216,7 +216,8 @@ void enable_caches(void)
 	 * reserved regions as inacessible (PTE_TYPE_FAULT)
 	 */
 	if (qcom_memmap_source == QCOM_MEMMAP_SOURCE_SMEM ||
-	    fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs404") == 0) {
+	    fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,qcs404") == 0 ||
+	    fdt_node_check_compatible(gd->fdt_blob, 0, "qcom,msm8917") == 0) {
 		carveout_start = get_timer(0);
 		/* Takes ~20-50ms on SDM845 */
 		configure_reserved_memory();
-- 
2.55.0

