Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF86606A32E
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 01:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=AjRpLr4H;
	dkim=pass (2048-bit key, unprotected) header.d=riscstar-com.20260707.gappssmtp.com header.i=@riscstar-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Q4Lf+5ci
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14FA280A84;
	Thu,  5 Nov 2026 01:28:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FUbUzVhp7cPe; Thu,  5 Nov 2026 01:28:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5923880A53
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793842084;
	b=NnvUWAywhY2GjOVZ0BqVNM0HZ9NIWob/NO32dyv6UAoZLfH+njk3tioTHM6iT6VYPfJY
	 4OXMT8ufosSMY6fJLqZpmYETttsKnrqt7EFueNJlmjwg4XB7DmRKbPdv6nhy8FJ6QKxq7
	 31ft9J8ZVVMT76dsrrKsPYVm4uvlqBiaE7s7wd4a5AhChIHIG0z6iRExqwID3dJ7Zor4S
	 kRqjDhRoqX+TIezSMDnst7EHT2FKzTWdzJqwsl2q0ezOREgpn63FwFQTARBwnatPQFqVV
	 aAne99wC68DWf8q6Lva0/960GcQEYUYMcXyqMXXcORwjgwoUbFTnZ4GyVFqBW6Mw3ew==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793842084;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=44vp3LxDttVox8Q9lC4BmC6TFC/UK0aN89BqZXrQ68E=;
	b=BUr9bk3YwiRNV1lxXNPFT5AyP+jtW3j8PrM2fXAiEqh3ZMjnDdRZEXotWtIFLMk8thlX
	 PczMb6zqE1DxSMAu/nQM426zG8BLHrIKM3NuphQ7NDGZWIs+/PZN3pAsXasRTGUuMCGmO
	 KSM7J7CACN3fqpVsxpICEdiiMv4FIcTpSn0lhuz+qSBZaxhh6bxcMkhdL8u0T+ncPS2Mn
	 /2IFxzaBcMcxBTBp4qqnSSzj/nEWZ+P1cmcER4vSyJwpwluKdxls/H0DuDb8lNmvQODlh
	 3zN4+XglYMXx/pR48/GOdfSBXufcF85VBm+EnqqyzwA3k/qZl+C/HbTaYtpF6nu07qA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793842084;
	bh=44vp3LxDttVox8Q9lC4BmC6TFC/UK0aN89BqZXrQ68E=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AjRpLr4HucUO718ZxP+cJDjvhmuEyz9SfFSxnbUvxoAJc5FRgxb/vjTKILVH+Q4Cf
	 PIGCMkFj6AHLpHMEN/Z/YWeEV3L/YknlrFnXuyvNe1Eymkkxfu9RbbCPtdaD+PlWAD
	 pLO15XC9g0QOCqgFfCLGtzu9rCbn0Vo2W8IX/fk+FC0PlJb9mwl5BP8PuHK4Yqj9zZ
	 51925ncwC+t6MAa3UoorbgCelrHeibvduMAUA2C2snBDQfEitLgE38W1/wUjJHB/Q2
	 9g/cblxgBAXbooD/osTXJkhH23OWXezrtE2TxRZzqKzM8KxtHVmyimNcfTp8HFCuDA
	 exoS4WqHoXe4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5923880A53;
	Thu,  5 Nov 2026 01:28:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8610052B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 01:28:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6CB7B4009C
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 01:28:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m2vOfsAWsjwi for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 01:28:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3203D4008E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::52c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20260707.gappssmtp.com
 header.i=@riscstar-com.20260707.gappssmtp.com header.a=rsa-sha256
 header.s=20260707 header.b=Q4Lf+5ci
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3203D4008E
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 01:28:00 +0000 (UTC)
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cc52c1b8286so68023a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 17:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20260707.gappssmtp.com; s=20260707; t=1793842080; x=1794446880;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=44vp3LxDttVox8Q9lC4BmC6TFC/UK0aN89BqZXrQ68E=;
 b=Q4Lf+5ciM51j0QVFhuAxqjVpqH4duW3mFo6myMHvojcL8jPATJYHItV3dXRBPBlFcg
 LpATP6t0NX9mrWhWxXONgJwEirzMO902hnU+iv/FU2Xn/qSQqxj+uahanshsnt9wXBA1
 08y6vZuxgXUdJs0OfVlx+Dz2CYYm7E9WAKG46QpnyFgp8VCpajNxmbfcxNm+9KOECaEa
 3uyXyFKOOTFyTucpsA62dt/DPDlpkKnBILD5lQukYXGeX89UKpBxXCOUBUgctI74Pkip
 F6pWSEi0VloYz1waAxw5GmtSs9OfWFOkmC0ZLeYMnsvibeDSWku+CoGxx+/yF2njG2c3
 n/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793842080; x=1794446880;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=44vp3LxDttVox8Q9lC4BmC6TFC/UK0aN89BqZXrQ68E=;
 b=zFKU8RLCpDAuRt7vj6nOA0ZxwsfIQ924J3aSCMcSq0+6mrdAmpRZazzB0AFYA/Ea63
 VYEIxkph3+kyYY6jjk1TGb1OdQ8X/QjQgpyv2ycNvjb7T9/HlVPObcfYzJ/FMNXsc5iM
 y7XuymnV905O7j2pzvEhAPLMFuEtPWfK02FK9gEM5h8BwMSCTTXKywPjSM8fz9s1zhrH
 bUipc2jNo/rkGybLdc96OGbZthpPtEbnBpIFygxnCNa/QTAALNXAjiQXMKOaP2hDfg1+
 2Rk82+yXfvgI/gIdOA8bN/BsTOFXj3LEPGVffc9zjWSadSYTezO3zruN9pGh3Ij8Qf7M
 r/bA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0SRC3d6cQf3UAgfVsHdFLX+DT50NPIIzWwV1UeLcP+ypOs1bvZE1LKDRf1vz+o+enNCcS6xQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/OIoOcnLsF6E2CIXgx7crZdtpNYL3w6MZvl/Z8lQaDvIJyOF8o
 Om4znSSwnsCc5k29kt+serfJBqCRvbCHXIORSultAkNyBI7byUY/Aa8dCjWnpoNdWys=
X-Gm-Gg: AYBFou03gffjTrzQCJIiyec9gU1eZo7tAOys82rl/laJwLPLK9DpHX6SCVFTSj7Gp7k
 kejcoiSItSVYN8fAd1oS5uibdc5frpkuXD8vzyatGCF9+8nkyKd7y2+Eq/ylqY8wLAXDKFhOoep
 eb/ig2RwwiVVxBxJl+5kG2iCILAWuacyCyArBovbMHsnYFxBLBnnFENcLPN9rOysS1P2pcpyaqp
 VbqDdf573BA9iNAxe2W8y8BlmOEDmEhmautlFyF4TgBMzmHRY542BnLHSS6cHoVTxX7nh/xVqR4
 AOZeM3zyiStYzWy5tJkMZmEej9iHo9uQJ4Q4JbH7q7nxFDcdgoJgOkPpB8/u5NwLTNiGE2l3tOE
 E4bO6VzhmjJxTko4UnIbtMeKDIg3ZQx3DiZ/ZaKCXUhoN51os07ePXsxaTAvzBRsEw/vrE365TS
 5UHSNPtCyXen7V1kccpzt79sBnjhnGSR04RYSGLG/OZmQC/yfijLizNlrZbHLl74zFOpwugxFmq
 amrv+zO5yhMPJhvNAwsk4i4cvTlcFyMoQnxEkj0TEUIZ5FyUtEh9YXKAKcSchLl+WR4kftIlpJ3
 9FdrQMcR7dXuur+bwowDOqcm+bbEdj5wyBTjkVPQzoNhXPk6q+darlGbWoo/dlkGxsPdQYzba6Q
 Qhx0cK7XxOnyIR1aL/LzMIUmz2uglPq7FQ5uPQdkOgyoZr1RHsdTdhg6ACRIgGtx9HWrohJit5v
 Uku+oHCIrxbg==
X-Received: by 2002:a17:90b:5807:b0:3ac:9ed8:f301 with SMTP id
 98e67ed59e1d1-3b0afc711f7mr594051a91.30.1793842079956; 
 Wed, 04 Nov 2026 17:27:59 -0800 (PST)
Received: from [127.0.1.1] ([120.204.59.52]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b096b52911sm2508066a91.3.2026.11.04.17.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 17:27:59 -0800 (PST)
From: Eric Chung <eric.chung@riscstar.com>
Date: Thu, 05 Nov 2026 09:27:46 +0800
Subject: [PATCH] mmc: spacemit: fix the greater-than-or-equal-to-zero
 comparison
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-fix_cid-v1-1-e44bc1da8900@riscstar.com>
X-B4-Tracking: v=1; b=H4sIAJHb62oC/yXM3wpAMBQH4FdZ59rKTpnyKpI4zjgu0IaU9u6Gy
 6/fnxsCe+EAlbrB8ylB1iXBZApo6paRtQzJgDlaY/JCO7lakkE7RkulJaTCQGpvnlP0PdXN73D
 0M9P+ziHGB1RuGzRrAAAA
X-Change-ID: 20261105-fix_cid-fe26c76c2c51
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Cc: Huan Zhou <pericycle.cc@gmail.com>, Yixun Lan <dlan@kernel.org>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CID 661178:         Control flow issues  (NO_EFFECT)
This greater-than-or-equal-to-zero comparison of an unsigned value
is always true. "retry_delays[i] >= 0".

Since SPACEMIT_RX_TUNE_DELAY_MIN is declared as zero, it causes
Coverity reporting the comparison issue.

Now remove the redundant comparison.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>
---
 drivers/mmc/spacemit_sdhci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
index f5578f38bdd1..3e0e7901b59d 100644
--- a/drivers/mmc/spacemit_sdhci.c
+++ b/drivers/mmc/spacemit_sdhci.c
@@ -473,8 +473,7 @@ static int spacemit_sdhci_execute_tuning(struct mmc *mmc, u8 opcode)
 			    final_delay);
 
 		for (i = 0; i < retry_count; i++) {
-			if (retry_delays[i] >= SPACEMIT_RX_TUNE_DELAY_MIN &&
-			    retry_delays[i] <= SPACEMIT_RX_TUNE_DELAY_MAX) {
+			if (retry_delays[i] <= SPACEMIT_RX_TUNE_DELAY_MAX) {
 				spacemit_sdhci_set_rx_delay(host, retry_delays[i]);
 				ret = mmc_send_tuning(host->mmc, opcode);
 				if (!ret) {

---
base-commit: d1d45c926a571fb6c1e6d7105c280833646915ea
change-id: 20261105-fix_cid-fe26c76c2c51

Best regards,
--  
Eric Chung <eric.chung@riscstar.com>

