Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51552606A31B
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MbRXW9GD;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=Q68XLvD1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2953E409A8;
	Thu, 22 Oct 2026 14:03:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7IQ-n-Z0hN8R; Thu, 22 Oct 2026 14:03:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7470D409A1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792677817;
	b=owg9UetgITh044G5zeWjqrRvBCjqNQL/73qaOKPL0/s3xniQoaHhfxzamXCdT+lQQucp
	 m1hPHpD+4nk+tMJE9cjss4926GOiPaVboCLl0CVoyjqME0Obxx7/QzoEVmtR8TI9uMxE/
	 2tk74aer56zMGolMnM+3qxGWWK6dr3D86CLv740Qbmu6QzaTh5MKWFsScBZWUzQJ9GUFD
	 mCieIDAnaL+mz0PJMI2mfrnnquVeNCrGWYv/ItypWd+VDITn8ubOUdapqGKhxkvc710GA
	 l89pkL+vdSV/RHj4IBIaODZNH424kwiD9DLT5AwLXiQ9Ye6rjwxpA4IuRFKTGanHkMQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792677817;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VVMBLvPhpySc1/oT12ft0Sv5SL7+d8LF5Olah6tVXBU=;
	b=GlO3fMRqJmauvSLvZKIJiXwaRogzrKDdxmYF2h3aCe9dmhOw6Yt7iTWFAqeX+6rLafyL
	 ot7J88STg/0Uw2Fe9FZEsTzHS8WGERi8BNXdyb6Lo94fbDmIy2mcL6WI+Gg70gS6VSoE/
	 MA8jhfMRPVFg8/XbChHaaY+REEosX1fH5ucOD65B+4F0dWQ4k9QqGB++4KTKtyg2oh0ni
	 jOTiY8pJ4Ay/ZhqpT0PZi7MPAxtlIIiVF9lUpOMJKeUY7MrZLH1Ljji38FbWdDoSXUKwB
	 Qu92LAZACp8XeiAIcqKbg/9xC+76J9b+dcmp2YOsQm8ZSujMS+QAEqq/cdKRnd9T0TA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792677817;
	bh=VVMBLvPhpySc1/oT12ft0Sv5SL7+d8LF5Olah6tVXBU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MbRXW9GD1ZFwckM2aj5ecUmPxQ71Kxt/XJImvT/7IDnBdKRqBHBtwmM+Vz89Gmnak
	 w0P4XRa0NCgopi8iw3R435hPCaLZHN5kd1s22oXJ6f6sXlf76RVyFnz16NjMjcl2zQ
	 e22WYV0Xx+YvQt4t0m+qDlZsXEbFEAUIQPPRkcGbQUZ0sXQVj8bOLOmDi5N2SSrutV
	 I/mzawxn3cnCZbt/2pDw3wDiKFS7faggSIZkI77lWc101/jlVeMx91MPlAiyomy22V
	 Oxq/A1jZUcepRLiiKFat7S26HXQyE2sBHpyE11VTENpAtrpxbJr39IDL08BneLXNZ6
	 OCt+j5UFxMzWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7470D409A1;
	Thu, 22 Oct 2026 14:03:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8FD632A8
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:03:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7834660787
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:03:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PwVc87DhVcWA for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 14:03:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 524D7606D7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792677810;
 b=WyOnUC6ZCFGry0SsizGe+VoXvbxwCQvLfXvtMhHiAuGIaeJQVj0okgzl5t1jqHq/hIoP
 hT3uHpH0hkTcx05tyow5D7SObjwnN1WVOLF9CzUxXlREMsifouMIR9oh5j28e3VC9lR0X
 LLoXDy1+Dwa4lwyFF0WRHl/QX46MYe8WSacoM2VEaXV1/oqNOTg1av+jJczA7GmHfpLz+
 dt6Oly0thIPwEYsDtIwhh26Aen/AoGvoyXSxPCRTmaNumJyOtwmDENd7UI5j+MGWF+FxT
 uS81cyW9nWTnCUHt2F8vKBBuRjnjavOiFNFYpR2n0+w/2ZWKwKxMbQU+WGHCb8tgU3A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792677810;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=VVMBLvPhpySc1/oT12ft0Sv5SL7+d8LF5Olah6tVXBU=;
 b=ckYszW7Io+DdWRca3LtyCj6jfVfF3XBu8YTOKhu+rKaPJZ1lsdkO93LUqZ6NGdNoWrSZ
 +nuRmG4VjaF08jALC+1UzLWmz/m8Z4MqQ9UeM7O/+WV2WwRglMVaDSuwYWKQ90eszmF1g
 LU7zYBjAG+HP6FS2+6KIvFehD7r89WTasPhuZjSdAnEEBSgR6EMb/nOtpqe262MyVO1DE
 KZSxNrKhcOQsFLm2o7MetYXJhy2c5cqKR2FsqOyMajxCqkc0Dlj38drjNrrPVIocDvb44
 2mzl0kj2d9pMBfDAUJcPXLFLByo9310Q+wL4eNomKYY8X2t20JhFlZyUXib11pA0Kfg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Q68XLvD1; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=Q68XLvD1
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 524D7606D7
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 14:03:28 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4a1df146015so14953085e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 07:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792677807; x=1793282607;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VVMBLvPhpySc1/oT12ft0Sv5SL7+d8LF5Olah6tVXBU=;
 b=Q68XLvD1UdAlWhtZt1u4OtOR9sIAS7juKwpGHf6gLuAMTvbdV6SjDmOjl0WbM/gHHp
 yj34tHlbJKChTBlvMRZvBJ/bv5zwpzZboNgrJI9dCE36T7o3UKaq1ZSNy6Gf6LbRQotk
 q0eraRhS27lCnecLLZSIOEyFiJwEAnBCeQ0kVYIZ+G0mhV3JCNPkbg0aZu4WoroVVxzx
 UVy5Tx6mwc68GnDQz5LdQhiaP76ApI6gnDd1nYZeX1PYh8xPnbbi2v1d/dHKeYM7r7jh
 eonXtw857gMMT5nKH+VNjT83q6s3Keu/rIVVFxaUZtH8dLJKpt6LdTY+zROH/4YSgwqR
 Tt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792677807; x=1793282607;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VVMBLvPhpySc1/oT12ft0Sv5SL7+d8LF5Olah6tVXBU=;
 b=NNXTQQM9yHzAbovPd3cdxyzufNEzxqJuRNlj4zZwNn5GDsg8no+4KzWIJ/tvrozc15
 FC6TaBFXHNNFEv6Fg+LNU7tc5C2nV5i1VBoIoFzmWUD1r0DSlsbvzizl+Vb+w+vatQWs
 Pj7BGcf6SXNxbIwNHJbFXlxHKuEp+cJseWyVE8T+6+TdO8Vof+3goqhBP2mm5kzt4xOc
 LbCljLHOtGudZuHZHgjVNI/v/lVYk64Ue7A7K1g2ykkU5oZbY+LNu/OvlK02+I9aI0es
 V5eM9y/hYBmYajdDOXjlkB4VipA957X8eivczT1N+UVDV/ipaoLEJa7+3fDKO7ICOnyW
 7wbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0ETIIAmYp31rk4X67XQEefyf6GHC6+iSKongHroLSvuc+cvh5RnKbXg4V7itTIjc+T6XSowc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI0nvLPqIiopKBR7Np/pTcSMIZjFQiGzZn6g/uwoaanAlp0uu+8
 kkre54giXs9bPvn1fYcBlo9fD8pfNRMvrdpomme4MCLVprE/VH3O22whgyZdlrLJR1U=
X-Gm-Gg: AYBFou3sa3YbVave0STIBnMS5PcjX6hyJCCYyP/ZLmYFMUSxyI0XJzduM6uz0q4MPdw
 /lcup+h6OBO/nNL8pVnmbqwxXQCyqxVIBx64IP7zp4Lt6Rth7pT/bpcnZm8HFwC/aK4Xfg2/zVU
 xORG0c63j0virie5Rbf712fwQpY2xnn2JIRzJXiZxSkIh9csyZ924MS6aR5PCCciP6B1ehNWHgB
 WXWKZo2E7oeGkhd6kSxe/zWCe0bIY50eZ1Gjz3FA6y3sNpmKCEZh3dCD6+9Jzbc8VK1s/QXTc2o
 FE10ysfNORxHRboqr1Rp15CnYTGXN4xC5oIbm556az7L3Utm3uEyd10Ge6iCEk4eqgFQ7pTeYL7
 ZG+Dhj+cq668Bv3NczQK72JtJoo15GFynK2k3fKEJh779r3r005XNDjWtcTtmfIvVAquSRhsj1c
 aZNcDlFIdGinqhuOoBSeyyxS+QZ1D0E0Xy7FQKacx2ZEv6OxX5W1DryG28s0gHbovL9meCWKXAp
 zUEA9+t1ZWGYQVJ2qYJuyhb7+FSKZYAhGNnG+xOvPmN48Yi0kitrwzKdJGvi+CTKvlWABOKO8Qa
 pQEHXqu5Zg8lUEpf8G6M2LqAGjh5G64JT1yzH4eVnKMknDRICDTVgVFCbyDooT/fzbbCZ9k2sC0
 fpHeAksV1nZ5a5AwJwkR503J4W4JtV8ZAK5+v
X-Received: by 2002:a05:600c:3490:b0:4a2:84c:52f3 with SMTP id
 5b1f17b1804b1-4a2084c543fmr39179255e9.6.1792677806466; 
 Thu, 22 Oct 2026 07:03:26 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-8434-7c41-c701-f269-609e-a542-3b36.rev.sfr.net.
 [2a02:8434:7c41:c701:f269:609e:a542:3b36])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a203b66f6bsm102604335e9.15.2026.10.22.07.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 07:03:26 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 22 Oct 2026 16:03:44 +0200
Subject: [PATCH v3 1/3] power: domain: mediatek: support SMI and infra-nao
 bus protection
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-mt8365-add-power-domain-v3-1-90b82ec1e7fa@baylibre.com>
References: <20261022-mt8365-add-power-domain-v3-0-90b82ec1e7fa@baylibre.com>
In-Reply-To: <20261022-mt8365-add-power-domain-v3-0-90b82ec1e7fa@baylibre.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 u-boot@lists.u-boot-project.org
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Irving-ch Lin <irving-ch.lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Carlo Caione <ccaione@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.16.0
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The scpsys bus protection so far only drove the infracfg register block.
Some SoCs, such as the MT8365, also gate power domains through the SMI
common space and acknowledge their way-enable protections via the
read-only infracfg "nao" mirror.

Extend the bus protection descriptor with a target register block and a
separate status block, add the inverted (way-enable) set/clear polarity,
and retrieve the additional "mediatek,smi" and "mediatek,infracfg-nao"
regmaps per domain. Existing SoC tables are updated to select the
default infracfg block.

This mirrors the Linux driver available upstream at commit ecaf11aaee98
("pmdomain: mediatek: Add support for WAY_EN operations")

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/power/domain/mt8188-power-domain.c | 164 ++++++++++++++--------------
 drivers/power/domain/mt8189-power-domain.c |  74 ++++++-------
 drivers/power/domain/mt8366-power-domain.c |  40 +++----
 drivers/power/domain/mtk-power-domain.c    | 166 +++++++++++++++++++++++------
 drivers/power/domain/mtk-power-domain.h    |  66 +++++++++---
 5 files changed, 326 insertions(+), 184 deletions(-)

diff --git a/drivers/power/domain/mt8188-power-domain.c b/drivers/power/domain/mt8188-power-domain.c
index 265d222f17a..58dd5b2dc92 100644
--- a/drivers/power/domain/mt8188-power-domain.c
+++ b/drivers/power/domain/mt8188-power-domain.c
@@ -122,28 +122,28 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x178,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MFG1_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MFG1_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_SET,
 				    MT8188_TOP_AXI_PROT_EN_CLR,
 				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_MFG1_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_MFG1_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_1_MFG1_STEP3,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_1_MFG1_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_1_SET,
 				    MT8188_TOP_AXI_PROT_EN_1_CLR,
 				    MT8188_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_MFG1_STEP4,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_MFG1_STEP4,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MFG1_STEP5,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MFG1_STEP5,
 				    MT8188_TOP_AXI_PROT_EN_SET,
 				    MT8188_TOP_AXI_PROT_EN_CLR,
 				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MFG1_STEP6,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MFG1_STEP6,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA),
@@ -180,12 +180,12 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x178,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_PEXTP_MAC_P0_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_PEXTP_MAC_P0_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_SET,
 				    MT8188_TOP_AXI_PROT_EN_CLR,
 				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_PEXTP_MAC_P0_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_PEXTP_MAC_P0_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
@@ -210,8 +210,8 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_ETHER_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_ETHER_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
@@ -224,8 +224,8 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_HDMI_TX_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_HDMI_TX_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
@@ -236,12 +236,12 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.ctl_offs = 0x35C,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_ADSP_AO_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
@@ -254,12 +254,12 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_INFRA_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_ADSP_INFRA_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_INFRA_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_ADSP_INFRA_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
@@ -272,12 +272,12 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_ADSP_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_ADSP_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_ADSP_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
@@ -290,12 +290,12 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_AUDIO_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_AUDIO_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
@@ -308,12 +308,12 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_ASRC_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_AUDIO_ASRC_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_AUDIO_ASRC_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_AUDIO_ASRC_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
@@ -326,24 +326,24 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_VPPSYS0_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_VPPSYS0_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_SET,
 				    MT8188_TOP_AXI_PROT_EN_CLR,
 				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS0_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS0_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_VPPSYS0_STEP3,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_VPPSYS0_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_SET,
 				    MT8188_TOP_AXI_PROT_EN_CLR,
 				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS0_STEP4,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS0_STEP4,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VPPSYS0_STEP5,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VPPSYS0_STEP5,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA),
@@ -356,16 +356,16 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDOSYS0_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_VDOSYS0_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_VDOSYS0_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_VDOSYS0_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_SET,
 				    MT8188_TOP_AXI_PROT_EN_CLR,
 				    MT8188_TOP_AXI_PROT_EN_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VDOSYS0_STEP3,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VDOSYS0_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA),
@@ -378,16 +378,16 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDOSYS1_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_VDOSYS1_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDOSYS1_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_VDOSYS1_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VDOSYS1_STEP3,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_VDOSYS1_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -400,8 +400,8 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_DP_TX_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_DP_TX_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
@@ -414,8 +414,8 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_EDP_TX_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_EDP_TX_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_SET,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_CLR,
 				    MT8188_TOP_AXI_PROT_EN_INFRA_VDNR_STA),
@@ -428,16 +428,16 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VPPSYS1_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_VPPSYS1_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VPPSYS1_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_VPPSYS1_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS1_STEP3,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_VPPSYS1_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -450,12 +450,12 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_WPE_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_WPE_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_WPE_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_WPE_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -468,12 +468,12 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDEC0_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_VDEC0_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VDEC0_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_VDEC0_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -486,12 +486,12 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDEC1_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_VDEC1_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VDEC1_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_VDEC1_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
@@ -504,16 +504,16 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VENC_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_VENC_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_VENC_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_VENC_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_VENC_STEP3,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_VENC_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -524,16 +524,16 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.ctl_offs = 0x3A4,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_IMG_VCORE_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_IMG_VCORE_STEP3,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_IMG_VCORE_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -546,12 +546,12 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_IMG_MAIN_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_IMG_MAIN_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_IMG_MAIN_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_IMG_MAIN_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -578,24 +578,24 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.ctl_offs = 0x3A0,
 		.pwr_sta_offs = 0x16C,
 		.pwr_sta2nd_offs = 0x170,
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_CAM_VCORE_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_CAM_VCORE_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_1_CAM_VCORE_STEP3,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_1_CAM_VCORE_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_1_SET,
 				    MT8188_TOP_AXI_PROT_EN_1_CLR,
 				    MT8188_TOP_AXI_PROT_EN_1_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP4,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_CAM_VCORE_STEP4,
 				    MT8188_TOP_AXI_PROT_EN_MM_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_CAM_VCORE_STEP5,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_CAM_VCORE_STEP5,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
@@ -608,20 +608,20 @@ static const struct mtk_scp_domain_data mt8188_scp_domain[] = {
 		.pwr_sta2nd_offs = 0x170,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_CAM_MAIN_STEP1,
+		.bp_cfg = {
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_CAM_MAIN_STEP1,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_CAM_MAIN_STEP2,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_CAM_MAIN_STEP2,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_MM_2_CAM_MAIN_STEP3,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_MM_2_CAM_MAIN_STEP3,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_MM_2_STA),
-			BUS_PROT_WR(MT8188_TOP_AXI_PROT_EN_2_CAM_MAIN_STEP4,
+			BUS_PROT_WR(INFRA, MT8188_TOP_AXI_PROT_EN_2_CAM_MAIN_STEP4,
 				    MT8188_TOP_AXI_PROT_EN_2_SET,
 				    MT8188_TOP_AXI_PROT_EN_2_CLR,
 				    MT8188_TOP_AXI_PROT_EN_2_STA),
diff --git a/drivers/power/domain/mt8189-power-domain.c b/drivers/power/domain/mt8189-power-domain.c
index c8bb5d09941..6ad2dd4874d 100644
--- a/drivers/power/domain/mt8189-power-domain.c
+++ b/drivers/power/domain/mt8189-power-domain.c
@@ -84,20 +84,20 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.ctl_offs = 0xe04,
 		.pwr_sta_offs = MT8189_SPM_PWR_STATUS,
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MCU_STA_0_CONN,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MCU_STA_0_CONN,
 					MT8189_PROT_EN_MCU_STA_0_SET,
 					MT8189_PROT_EN_MCU_STA_0_CLR,
 					MT8189_PROT_EN_MCU_STA_0_RDY),
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_INFRASYS_STA_1_CONN,
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_INFRASYS_STA_1_CONN,
 					MT8189_PROT_EN_INFRASYS_STA_1_SET,
 					MT8189_PROT_EN_INFRASYS_STA_1_CLR,
 					MT8189_PROT_EN_INFRASYS_STA_1_RDY),
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MCU_STA_0_CONN_2ND,
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MCU_STA_0_CONN_2ND,
 					MT8189_PROT_EN_MCU_STA_0_SET,
 					MT8189_PROT_EN_MCU_STA_0_CLR,
 					MT8189_PROT_EN_MCU_STA_0_RDY),
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_INFRASYS_STA_0_CONN,
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_INFRASYS_STA_0_CONN,
 					MT8189_PROT_EN_INFRASYS_STA_0_SET,
 					MT8189_PROT_EN_INFRASYS_STA_0_CLR,
 					MT8189_PROT_EN_INFRASYS_STA_0_RDY),
@@ -110,8 +110,8 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_PERISYS_STA_0_AUDIO,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_PERISYS_STA_0_AUDIO,
 					MT8189_PROT_EN_PERISYS_STA_0_SET,
 					MT8189_PROT_EN_PERISYS_STA_0_CLR,
 					MT8189_PROT_EN_PERISYS_STA_0_RDY),
@@ -145,20 +145,20 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_1_MM_INFRA,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_1_MM_INFRA,
 					MT8189_PROT_EN_MMSYS_STA_1_SET,
 					MT8189_PROT_EN_MMSYS_STA_1_CLR,
 					MT8189_PROT_EN_MMSYS_STA_1_RDY),
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_1_MM_INFRA_2ND,
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_1_MM_INFRA_2ND,
 					MT8189_PROT_EN_MMSYS_STA_1_SET,
 					MT8189_PROT_EN_MMSYS_STA_1_CLR,
 					MT8189_PROT_EN_MMSYS_STA_1_RDY),
-			BUS_PROT_WR_IGN_SUBCLK(MT8189_PROT_EN_MM_INFRA_IGN,
+			BUS_PROT_WR_IGN_SUBCLK(INFRA, MT8189_PROT_EN_MM_INFRA_IGN,
 					       MT8189_PROT_EN_MMSYS_STA_1_SET,
 					       MT8189_PROT_EN_MMSYS_STA_1_CLR,
 					       MT8189_PROT_EN_MMSYS_STA_1_RDY),
-			BUS_PROT_WR_IGN_SUBCLK(MT8189_PROT_EN_MM_INFRA_2_IGN,
+			BUS_PROT_WR_IGN_SUBCLK(INFRA, MT8189_PROT_EN_MM_INFRA_2_IGN,
 					       MT8189_PROT_EN_MMSYS_STA_1_SET,
 					       MT8189_PROT_EN_MMSYS_STA_1_CLR,
 					       MT8189_PROT_EN_MMSYS_STA_1_RDY),
@@ -171,12 +171,12 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_0_ISP_IMG1,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_0_ISP_IMG1,
 					MT8189_PROT_EN_MMSYS_STA_0_SET,
 					MT8189_PROT_EN_MMSYS_STA_0_CLR,
 					MT8189_PROT_EN_MMSYS_STA_0_RDY),
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_1_ISP_IMG1,
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_1_ISP_IMG1,
 					MT8189_PROT_EN_MMSYS_STA_1_SET,
 					MT8189_PROT_EN_MMSYS_STA_1_CLR,
 					MT8189_PROT_EN_MMSYS_STA_1_RDY),
@@ -197,12 +197,12 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_0_ISP_IPE,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_0_ISP_IPE,
 					MT8189_PROT_EN_MMSYS_STA_0_SET,
 					MT8189_PROT_EN_MMSYS_STA_0_CLR,
 					MT8189_PROT_EN_MMSYS_STA_0_RDY),
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_1_ISP_IPE,
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_1_ISP_IPE,
 					MT8189_PROT_EN_MMSYS_STA_1_SET,
 					MT8189_PROT_EN_MMSYS_STA_1_CLR,
 					MT8189_PROT_EN_MMSYS_STA_1_RDY),
@@ -215,12 +215,12 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_0_VDE0,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_0_VDE0,
 					MT8189_PROT_EN_MMSYS_STA_0_SET,
 					MT8189_PROT_EN_MMSYS_STA_0_CLR,
 					MT8189_PROT_EN_MMSYS_STA_0_RDY),
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_1_VDE0,
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_1_VDE0,
 					MT8189_PROT_EN_MMSYS_STA_1_SET,
 					MT8189_PROT_EN_MMSYS_STA_1_CLR,
 					MT8189_PROT_EN_MMSYS_STA_1_RDY),
@@ -233,12 +233,12 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_0_VEN0,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_0_VEN0,
 					MT8189_PROT_EN_MMSYS_STA_0_SET,
 					MT8189_PROT_EN_MMSYS_STA_0_CLR,
 					MT8189_PROT_EN_MMSYS_STA_0_RDY),
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_1_VEN0,
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_1_VEN0,
 					MT8189_PROT_EN_MMSYS_STA_1_SET,
 					MT8189_PROT_EN_MMSYS_STA_1_CLR,
 					MT8189_PROT_EN_MMSYS_STA_1_RDY),
@@ -251,12 +251,12 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_0_CAM_MAIN,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_0_CAM_MAIN,
 					MT8189_PROT_EN_MMSYS_STA_0_SET,
 					MT8189_PROT_EN_MMSYS_STA_0_CLR,
 					MT8189_PROT_EN_MMSYS_STA_0_RDY),
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_1_CAM_MAIN,
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_1_CAM_MAIN,
 					MT8189_PROT_EN_MMSYS_STA_1_SET,
 					MT8189_PROT_EN_MMSYS_STA_1_CLR,
 					MT8189_PROT_EN_MMSYS_STA_1_RDY),
@@ -285,8 +285,8 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_0_MDP0,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_0_MDP0,
 					MT8189_PROT_EN_MMSYS_STA_0_SET,
 					MT8189_PROT_EN_MMSYS_STA_0_CLR,
 					MT8189_PROT_EN_MMSYS_STA_0_RDY),
@@ -299,8 +299,8 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MMSYS_STA_0_DISP,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MMSYS_STA_0_DISP,
 					MT8189_PROT_EN_MMSYS_STA_0_SET,
 					MT8189_PROT_EN_MMSYS_STA_0_CLR,
 					MT8189_PROT_EN_MMSYS_STA_0_RDY),
@@ -327,8 +327,8 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_PWR_STATUS_MSB_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_PERISYS_STA_0_SSUSB,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_PERISYS_STA_0_SSUSB,
 					MT8189_PROT_EN_PERISYS_STA_0_SET,
 					MT8189_PROT_EN_PERISYS_STA_0_CLR,
 					MT8189_PROT_EN_PERISYS_STA_0_RDY),
@@ -347,16 +347,16 @@ static const struct mtk_scp_domain_data mt8189_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8189_SPM_XPU_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_INFRASYS_STA_1_MFG1,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_INFRASYS_STA_1_MFG1,
 					MT8189_PROT_EN_INFRASYS_STA_1_SET,
 					MT8189_PROT_EN_INFRASYS_STA_1_CLR,
 					MT8189_PROT_EN_INFRASYS_STA_1_RDY),
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MD_STA_0_MFG1,
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MD_STA_0_MFG1,
 					MT8189_PROT_EN_MD_STA_0_SET,
 					MT8189_PROT_EN_MD_STA_0_CLR,
 					MT8189_PROT_EN_MD_STA_0_RDY),
-			BUS_PROT_WR_IGN(MT8189_PROT_EN_MD_STA_0_MFG1_2ND,
+			BUS_PROT_WR_IGN(INFRA, MT8189_PROT_EN_MD_STA_0_MFG1_2ND,
 					MT8189_PROT_EN_MD_STA_0_SET,
 					MT8189_PROT_EN_MD_STA_0_CLR,
 					MT8189_PROT_EN_MD_STA_0_RDY),
diff --git a/drivers/power/domain/mt8366-power-domain.c b/drivers/power/domain/mt8366-power-domain.c
index d40cf1849bd..e509f6f6c33 100644
--- a/drivers/power/domain/mt8366-power-domain.c
+++ b/drivers/power/domain/mt8366-power-domain.c
@@ -51,16 +51,16 @@ static const struct mtk_scp_domain_data mt8366_scp_domain[] = {
 		.ctl_offs = 0x304,
 		.pwr_sta_offs = MT8366_SPM_PWR_STATUS,
 		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_CONN,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_CONN,
 					MT8366_TOP_AXI_PROT_EN_SET,
 					MT8366_TOP_AXI_PROT_EN_CLR,
 					MT8366_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_CONN_2ND,
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_CONN_2ND,
 					MT8366_TOP_AXI_PROT_EN_SET,
 					MT8366_TOP_AXI_PROT_EN_CLR,
 					MT8366_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_1_CONN,
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_1_CONN,
 					MT8366_TOP_AXI_PROT_EN_1_SET,
 					MT8366_TOP_AXI_PROT_EN_1_CLR,
 					MT8366_TOP_AXI_PROT_EN_STA1_1),
@@ -81,20 +81,20 @@ static const struct mtk_scp_domain_data mt8366_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_1_MFG1,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_1_MFG1,
 					MT8366_TOP_AXI_PROT_EN_1_SET,
 					MT8366_TOP_AXI_PROT_EN_1_CLR,
 					MT8366_TOP_AXI_PROT_EN_STA1_1),
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_2_MFG1,
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_2_MFG1,
 					MT8366_TOP_AXI_PROT_EN_SET_2,
 					MT8366_TOP_AXI_PROT_EN_CLR_2,
 					MT8366_TOP_AXI_PROT_EN_STA1_2),
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_MFG1,
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_MFG1,
 					MT8366_TOP_AXI_PROT_EN_SET,
 					MT8366_TOP_AXI_PROT_EN_CLR,
 					MT8366_TOP_AXI_PROT_EN_STA1),
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_2_MFG1_2ND,
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_2_MFG1_2ND,
 					MT8366_TOP_AXI_PROT_EN_SET_2,
 					MT8366_TOP_AXI_PROT_EN_CLR_2,
 					MT8366_TOP_AXI_PROT_EN_STA1_2),
@@ -123,12 +123,12 @@ static const struct mtk_scp_domain_data mt8366_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_MM_VDEC,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_MM_VDEC,
 					MT8366_TOP_AXI_PROT_EN_MM_SET,
 					MT8366_TOP_AXI_PROT_EN_MM_CLR,
 					MT8366_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_MM_VDEC_2ND,
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_MM_VDEC_2ND,
 					MT8366_TOP_AXI_PROT_EN_MM_SET,
 					MT8366_TOP_AXI_PROT_EN_MM_CLR,
 					MT8366_TOP_AXI_PROT_EN_MM_STA1),
@@ -141,12 +141,12 @@ static const struct mtk_scp_domain_data mt8366_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_MM_VENC,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_MM_VENC,
 					MT8366_TOP_AXI_PROT_EN_MM_SET,
 					MT8366_TOP_AXI_PROT_EN_MM_CLR,
 					MT8366_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_MM_VENC_2ND,
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_MM_VENC_2ND,
 					MT8366_TOP_AXI_PROT_EN_MM_SET,
 					MT8366_TOP_AXI_PROT_EN_MM_CLR,
 					MT8366_TOP_AXI_PROT_EN_MM_STA1),
@@ -159,8 +159,8 @@ static const struct mtk_scp_domain_data mt8366_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN_STA_MASK(MT8366_TOP_AXI_PROT_EN_2_AUDIO,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN_STA_MASK(INFRA, MT8366_TOP_AXI_PROT_EN_2_AUDIO,
 						 MT8366_TOP_AXI_PROT_EN_2_AUDIO_ACK,
 						 MT8366_TOP_AXI_PROT_EN_ADSP_SET,
 						 MT8366_TOP_AXI_PROT_EN_ADSP_CLR,
@@ -174,12 +174,12 @@ static const struct mtk_scp_domain_data mt8366_scp_domain[] = {
 		.pwr_sta2nd_offs = MT8366_SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = BIT(8),
 		.sram_pdn_ack_bits = BIT(12),
-		.bp_infracfg = {
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_MM_CAM,
+		.bp_cfg = {
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_MM_CAM,
 					MT8366_TOP_AXI_PROT_EN_MM_SET,
 					MT8366_TOP_AXI_PROT_EN_MM_CLR,
 					MT8366_TOP_AXI_PROT_EN_MM_STA1),
-			BUS_PROT_WR_IGN(MT8366_TOP_AXI_PROT_EN_MM_CAM_2ND,
+			BUS_PROT_WR_IGN(INFRA, MT8366_TOP_AXI_PROT_EN_MM_CAM_2ND,
 					MT8366_TOP_AXI_PROT_EN_MM_SET,
 					MT8366_TOP_AXI_PROT_EN_MM_CLR,
 					MT8366_TOP_AXI_PROT_EN_MM_STA1),
diff --git a/drivers/power/domain/mtk-power-domain.c b/drivers/power/domain/mtk-power-domain.c
index e31ce574e8e..190d2f5be71 100644
--- a/drivers/power/domain/mtk-power-domain.c
+++ b/drivers/power/domain/mtk-power-domain.c
@@ -44,32 +44,57 @@ static int mtk_infracfg_clear_bus_protection(void __iomem *infracfg,
 				  !(val & mask), 100);
 }
 
-static int _scpsys_bus_protect_enable(const struct mtk_scpsys_bus_prot_data *bpd,
-				      void __iomem *reg)
+static void __iomem *scpsys_bus_prot_reg(struct mtk_scpsys *scpsys,
+					 struct mtk_scp_domain *domain, u8 block)
 {
+	switch (block) {
+	case BUS_PROT_BLOCK_INFRA_NAO:
+		return domain->infracfg_nao;
+	case BUS_PROT_BLOCK_SMI:
+		return domain->smi;
+	case BUS_PROT_BLOCK_INFRA:
+	default:
+		return domain->infracfg ?: scpsys->infracfg;
+	}
+}
+
+static int _scpsys_bus_protect_set(struct mtk_scpsys *scpsys,
+				   struct mtk_scp_domain *domain,
+				   const struct mtk_scpsys_bus_prot_data *bpd)
+{
+	void __iomem *reg = scpsys_bus_prot_reg(scpsys, domain, bpd->bus_prot_block);
+	void __iomem *sta_reg = scpsys_bus_prot_reg(scpsys, domain,
+						    bpd->bus_prot_sta_block);
 	u32 val = 0, mask = bpd->bus_prot_mask;
 	u32 sta_mask = bpd->bus_prot_sta_mask;
 
-	if (!mask)
-		return 0;
-
 	if (bpd->bus_prot_reg_update)
 		clrsetbits_le32(reg + bpd->bus_prot_set, mask, mask);
 	else
 		writel(mask, reg + bpd->bus_prot_set);
 
-	return readl_poll_timeout(reg + bpd->bus_prot_sta, val,
+	return readl_poll_timeout(sta_reg + bpd->bus_prot_sta, val,
 				  (val & sta_mask) == sta_mask, 1000);
 }
 
-static int _scpsys_bus_protect_disable(const struct mtk_scpsys_bus_prot_data *bpd,
-				       void __iomem *reg)
+static int _scpsys_bus_protect_clear(struct mtk_scpsys *scpsys,
+				     struct mtk_scp_domain *domain,
+				     const struct mtk_scpsys_bus_prot_data *bpd)
 {
+	void __iomem *reg = scpsys_bus_prot_reg(scpsys, domain, bpd->bus_prot_block);
+	void __iomem *sta_reg = scpsys_bus_prot_reg(scpsys, domain,
+						    bpd->bus_prot_sta_block);
 	u32 val = 0, mask = bpd->bus_prot_mask;
 	u32 sta_mask = bpd->bus_prot_sta_mask;
+	u32 expected_ack;
 
-	if (!mask)
-		return 0;
+	/*
+	 * The infracfg-nao mirror reports a released way-enable protection by
+	 * reading the status bits back as set, unlike the regular acknowledge
+	 * which clears to zero.
+	 */
+	expected_ack = bpd->bus_prot_sta_block == BUS_PROT_BLOCK_INFRA_NAO ?
+		       sta_mask : 0;
 
 	if (bpd->bus_prot_reg_update)
 		clrbits_le32(reg + bpd->bus_prot_clr, mask);
@@ -79,20 +104,24 @@ static int _scpsys_bus_protect_disable(const struct mtk_scpsys_bus_prot_data *bp
 	if (bpd->ignore_clr_ack)
 		return 0;
 
-	return readl_poll_timeout(reg + bpd->bus_prot_sta, val,
-				  !(val & sta_mask), 1000);
+	return readl_poll_timeout(sta_reg + bpd->bus_prot_sta, val,
+				  (val & sta_mask) == expected_ack, 1000);
 }
 
-static int scpsys_bus_protect_enable(const struct mtk_scpsys_bus_prot_data *bpd,
-				     int bpd_size, void __iomem *reg, bool subclk)
+static int scpsys_bus_protect_enable(struct mtk_scpsys *scpsys,
+				     struct mtk_scp_domain *domain, bool subclk)
 {
+	const struct mtk_scpsys_bus_prot_data *bpd = domain->data->bp_cfg;
 	int ret, i;
 
-	for (i = 0; i < bpd_size; i++) {
-		if (bpd[i].subclk != subclk)
+	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
+		if (!bpd[i].bus_prot_mask || bpd[i].subclk != subclk)
 			continue;
 
-		ret = _scpsys_bus_protect_enable(&bpd[i], reg);
+		if (bpd[i].bus_prot_inverted)
+			ret = _scpsys_bus_protect_clear(scpsys, domain, &bpd[i]);
+		else
+			ret = _scpsys_bus_protect_set(scpsys, domain, &bpd[i]);
 		if (ret)
 			return ret;
 	}
@@ -100,16 +129,20 @@ static int scpsys_bus_protect_enable(const struct mtk_scpsys_bus_prot_data *bpd,
 	return 0;
 }
 
-static int scpsys_bus_protect_disable(const struct mtk_scpsys_bus_prot_data *bpd,
-				      int bpd_size, void __iomem *reg, bool subclk)
+static int scpsys_bus_protect_disable(struct mtk_scpsys *scpsys,
+				      struct mtk_scp_domain *domain, bool subclk)
 {
+	const struct mtk_scpsys_bus_prot_data *bpd = domain->data->bp_cfg;
 	int i, ret;
 
-	for (i = bpd_size - 1; i >= 0; i--) {
-		if (bpd[i].subclk != subclk)
+	for (i = SPM_MAX_BUS_PROT_DATA - 1; i >= 0; i--) {
+		if (!bpd[i].bus_prot_mask || bpd[i].subclk != subclk)
 			continue;
 
-		ret = _scpsys_bus_protect_disable(&bpd[i], reg);
+		if (bpd[i].bus_prot_inverted)
+			ret = _scpsys_bus_protect_set(scpsys, domain, &bpd[i]);
+		else
+			ret = _scpsys_bus_protect_clear(scpsys, domain, &bpd[i]);
 		if (ret)
 			return ret;
 	}
@@ -200,14 +233,20 @@ static int mtk_scpsys_power_on(struct power_domain *power_domain)
 	 * Some domains split the bus protection policy in two: one part has to
 	 * be released before the subsys clocks are enabled and the rest after.
 	 */
-	ret = scpsys_bus_protect_disable(data->bp_infracfg, SPM_MAX_BUS_PROT_DATA,
-					 infracfg, true);
+	ret = scpsys_bus_protect_disable(scpsys, domain, true);
 	if (ret < 0)
 		return ret;
 
-	ret = clk_enable_bulk(&domain->subsys_clks);
-	if (ret)
-		return ret;
+	/*
+	 * On domains with a stricter bus protection policy, the subsys clocks
+	 * must not be enabled until bus protection is fully released below,
+	 * instead of here.
+	 */
+	if (!(data->caps & MTK_SCPD_STRICT_BUS_PROTECTION)) {
+		ret = clk_enable_bulk(&domain->subsys_clks);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * An inverted sram_pdn bit is set, not cleared, to power the SRAM up,
@@ -241,11 +280,16 @@ static int mtk_scpsys_power_on(struct power_domain *power_domain)
 		if (ret)
 			return ret;
 	}
-	ret = scpsys_bus_protect_disable(data->bp_infracfg, SPM_MAX_BUS_PROT_DATA,
-					 infracfg, false);
+	ret = scpsys_bus_protect_disable(scpsys, domain, false);
 	if (ret < 0)
 		return ret;
 
+	if (data->caps & MTK_SCPD_STRICT_BUS_PROTECTION) {
+		ret = clk_enable_bulk(&domain->subsys_clks);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -279,8 +323,7 @@ static int mtk_scpsys_power_off(struct power_domain *power_domain)
 			return ret;
 	}
 
-	ret = scpsys_bus_protect_enable(data->bp_infracfg, SPM_MAX_BUS_PROT_DATA,
-					infracfg, false);
+	ret = scpsys_bus_protect_enable(scpsys, domain, false);
 	if (ret < 0)
 		return ret;
 
@@ -312,8 +355,7 @@ static int mtk_scpsys_power_off(struct power_domain *power_domain)
 	if (ret)
 		return ret;
 
-	ret = scpsys_bus_protect_enable(data->bp_infracfg, SPM_MAX_BUS_PROT_DATA,
-					infracfg, true);
+	ret = scpsys_bus_protect_enable(scpsys, domain, true);
 	if (ret < 0)
 		return ret;
 
@@ -431,6 +473,64 @@ static int mtk_scpsys_add_one_domain(struct udevice *dev, ofnode node, int paren
 		domain->infracfg = regmap_get_range(regmap, 0);
 	}
 
+	/*
+	 * mediatek,infracfg-nao and mediatek,smi are deprecated but we need to
+	 * support them because mt8365.dtsi still uses them.
+	 */
+	if (ofnode_read_bool(node, "mediatek,infracfg-nao")) {
+		ret = ofnode_parse_phandle_with_args(node, "mediatek,infracfg-nao",
+						     NULL, 0, 0, &args);
+		if (ret)
+			return ret;
+
+		regmap = syscon_node_to_regmap(args.node);
+		if (IS_ERR(regmap))
+			return PTR_ERR(regmap);
+
+		domain->infracfg_nao = regmap_get_range(regmap, 0);
+	}
+
+	if (ofnode_read_bool(node, "mediatek,smi")) {
+		ret = ofnode_parse_phandle_with_args(node, "mediatek,smi",
+						     NULL, 0, 0, &args);
+		if (ret)
+			return ret;
+
+		/* The SMI common node has no "syscon" fallback compatible. */
+		domain->smi = (void __iomem *)ofnode_get_addr(args.node);
+		if (IS_ERR(domain->smi))
+			return -ENOENT;
+	}
+
+	/*
+	 * if a domain's own bp_cfg has an entry targeting
+	 * BUS_PROT_BLOCK_INFRA_NAO/BUS_PROT_BLOCK_SMI but the corresponding
+	 * regmap wasn't resolved, fail probe with a clear error rather than
+	 * leaving a NULL that gets dereferenced on first power-on/off. That
+	 * keeps the properties optional at the DT-binding level while still
+	 * catching a DT/driver mismatch early.
+	 */
+
+	for (i = 0; i < SPM_MAX_BUS_PROT_DATA; i++) {
+		const struct mtk_scpsys_bus_prot_data *bpd = &domain->data->bp_cfg[i];
+
+		if (!bpd->bus_prot_mask)
+			continue;
+
+		if ((bpd->bus_prot_block == BUS_PROT_BLOCK_INFRA_NAO ||
+		     bpd->bus_prot_sta_block == BUS_PROT_BLOCK_INFRA_NAO) &&
+		    !domain->infracfg_nao) {
+			dev_err(dev, "%s: missing mediatek,infracfg-nao\n",
+				ofnode_get_name(node));
+			return -EINVAL;
+		}
+
+		if (bpd->bus_prot_block == BUS_PROT_BLOCK_SMI && !domain->smi) {
+			dev_err(dev, "%s: missing mediatek,smi\n", ofnode_get_name(node));
+			return -EINVAL;
+		}
+	}
+
 	num_clks = ofnode_read_string_count(node, "clock-names");
 	for (i = 0; i < num_clks; i++) {
 		ret = ofnode_read_string_index(node, "clock-names", i, &clk_name);
diff --git a/drivers/power/domain/mtk-power-domain.h b/drivers/power/domain/mtk-power-domain.h
index 67008b0df10..1ff22d3dd1a 100644
--- a/drivers/power/domain/mtk-power-domain.h
+++ b/drivers/power/domain/mtk-power-domain.h
@@ -52,9 +52,13 @@ struct udevice;
  *			has to be released separately once it is powered.
  * SRAM_PDN_INVERTED:	@sram_pdn_bits is active low, so the bit is set to
  *			power the SRAM up rather than cleared.
+ * STRICT_BUS_PROTECTION: the subsys clocks must not be enabled until bus
+ *			protection is fully released, instead of the other
+ *			way round.
  */
 #define MTK_SCPD_SRAM_ISO		BIT(0)
 #define MTK_SCPD_SRAM_PDN_INVERTED	BIT(1)
+#define MTK_SCPD_STRICT_BUS_PROTECTION	BIT(2)
 
 #define PWR_STATUS_CONN		BIT(1)
 #define PWR_STATUS_DISP		BIT(3)
@@ -80,7 +84,21 @@ struct udevice;
 
 struct mtk_scp_domain;
 
+/*
+ * Register block a bus protection step operates on. A domain may drive its
+ * protections through several distinct register regions (infracfg, its
+ * read-only "nao" mirror used for way-enable acknowledgments, and the SMI
+ * common space), each retrieved from a separate DT phandle.
+ */
+enum mtk_scpsys_bus_prot_block {
+	BUS_PROT_BLOCK_INFRA,
+	BUS_PROT_BLOCK_INFRA_NAO,
+	BUS_PROT_BLOCK_SMI,
+};
+
 struct mtk_scpsys_bus_prot_data {
+	u8 bus_prot_block;
+	u8 bus_prot_sta_block;
 	u32 bus_prot_mask;
 	u32 bus_prot_set;
 	u32 bus_prot_clr;
@@ -88,6 +106,11 @@ struct mtk_scpsys_bus_prot_data {
 	u32 bus_prot_sta;
 	bool bus_prot_reg_update;
 	bool ignore_clr_ack;
+	/*
+	 * Invert the set/clear polarity: apply the protection by clearing and
+	 * release it by setting. Used for the way-enable steps.
+	 */
+	bool bus_prot_inverted;
 	/*
 	 * Release this protection before the subsys clocks are enabled and
 	 * re-apply it after they are disabled, instead of the other way round.
@@ -102,7 +125,7 @@ struct mtk_scp_domain_data {
 	u32 sram_pdn_bits;
 	u32 sram_pdn_ack_bits;
 	u32 bus_prot_mask;
-	const struct mtk_scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
+	const struct mtk_scpsys_bus_prot_data bp_cfg[SPM_MAX_BUS_PROT_DATA];
 	int pwr_sta_offs;
 	int pwr_sta2nd_offs;
 };
@@ -121,6 +144,8 @@ static const struct mtk_scp_soc_data _name##_scp_soc_data = {	\
 struct mtk_scp_domain {
 	const struct mtk_scp_domain_data *data;
 	void __iomem *infracfg;
+	void __iomem *infracfg_nao;
+	void __iomem *smi;
 	struct clk_bulk clks;
 	struct clk_bulk subsys_clks;
 	bool has_pd;
@@ -134,7 +159,10 @@ struct mtk_scpsys {
 	struct mtk_scp_domain *domains;
 };
 
-#define _BUS_PROT(_mask, _set, _clr, _sta_mask, _sta, _update, _ignore, _subclk) { \
+#define _BUS_PROT(_block, _sta_block, _mask, _set, _clr, _sta_mask, _sta, \
+		  _update, _ignore, _subclk, _inverted) {		\
+	.bus_prot_block = BUS_PROT_BLOCK_##_block,		\
+	.bus_prot_sta_block = BUS_PROT_BLOCK_##_sta_block,	\
 	.bus_prot_mask = (_mask),				\
 	.bus_prot_set = (_set),					\
 	.bus_prot_clr = (_clr),					\
@@ -143,22 +171,36 @@ struct mtk_scpsys {
 	.bus_prot_reg_update = (_update),			\
 	.ignore_clr_ack = (_ignore),				\
 	.subclk = (_subclk),					\
+	.bus_prot_inverted = (_inverted),			\
 }
 
-#define BUS_PROT_WR(_mask, _set, _clr, _sta)			\
-	_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, false, false)
+#define BUS_PROT_WR(_block, _mask, _set, _clr, _sta)		\
+	_BUS_PROT(_block, _block, _mask, _set, _clr, _mask, _sta, \
+		  false, false, false, false)
+
+#define BUS_PROT_WR_IGN(_block, _mask, _set, _clr, _sta)	\
+	_BUS_PROT(_block, _block, _mask, _set, _clr, _mask, _sta, \
+		  false, true, false, false)
 
-#define BUS_PROT_WR_IGN(_mask, _set, _clr, _sta)		\
-	_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, true, false)
+#define BUS_PROT_WR_IGN_SUBCLK(_block, _mask, _set, _clr, _sta)	\
+	_BUS_PROT(_block, _block, _mask, _set, _clr, _mask, _sta, \
+		  false, true, true, false)
 
-#define BUS_PROT_WR_IGN_SUBCLK(_mask, _set, _clr, _sta)		\
-	_BUS_PROT(_mask, _set, _clr, _mask, _sta, false, true, true)
+#define BUS_PROT_WR_STA_MASK(_block, _mask, _sta_mask, _set, _clr, _sta) \
+	_BUS_PROT(_block, _block, _mask, _set, _clr, _sta_mask, _sta, \
+		  false, false, false, false)
 
-#define BUS_PROT_WR_STA_MASK(_mask, _sta_mask, _set, _clr, _sta) \
-	_BUS_PROT(_mask, _set, _clr, _sta_mask, _sta, false, false, false)
+#define BUS_PROT_WR_IGN_STA_MASK(_block, _mask, _sta_mask, _set, _clr, _sta) \
+	_BUS_PROT(_block, _block, _mask, _set, _clr, _sta_mask, _sta, \
+		  false, true, false, false)
 
-#define BUS_PROT_WR_IGN_STA_MASK(_mask, _sta_mask, _set, _clr, _sta) \
-	_BUS_PROT(_mask, _set, _clr, _sta_mask, _sta, false, true, false)
+/*
+ * Way-enable protection: the set/clear polarity is inverted and the
+ * acknowledgment is read back from the infracfg-nao mirror.
+ */
+#define BUS_PROT_WAY_EN(_set_mask, _set, _sta_mask, _sta)	\
+	_BUS_PROT(INFRA, INFRA_NAO, _set_mask, _set, _set, _sta_mask, _sta, \
+		  true, false, false, true)
 
 int mtk_scpsys_probe(struct udevice *dev);
 int mtk_power_controller_probe(struct udevice *dev);

-- 
2.56.0

