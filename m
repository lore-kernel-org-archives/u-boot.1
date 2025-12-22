Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33872D711D5
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 04:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E45E83C28;
	Mon, 22 Dec 2025 05:25:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="acmeKLlt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WLziM58P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CB2E83D3C; Mon, 22 Dec 2025 05:25:45 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3EFD83BF1
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 05:25:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BLLEcNa043429
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 04:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=OTapWK62w4xPy3k7TaPPnAksZDpl1Y/bdBW
 y/bHl82I=; b=acmeKLltknxBcsJAPFGSVNjtG66HfwW27rX+BakygucRfS8pQ7m
 mCM+8sseYUEPfaCtjIjOSzPh0Slkb9dF6AsjXYHuRViT4UIS72O3z7nKBNdx2zs0
 PTjw9L92qfZKxwPvJ7iky+LXt58RM326BMnDa21LmDcEJ1iERWespYKiNWHP66ZL
 bQ7++sz7nknICIt6LQKZExzw2txdYweeBe6uc7IU2vtrvGenQPcJxoTVapLDjx5u
 twLVvBDU/nlyfjN4KpYy8uhNDeg2kY5oAB0AYbMpnzAvoWLL65gNoQJxN8AVzNi8
 9jKswxn21n5xAvY/L+UrJDpTrjYm6/qqcaQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mubkjp6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 04:25:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a089575ab3so45766505ad.0
 for <u-boot@lists.denx.de>; Sun, 21 Dec 2025 20:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1766377540; x=1766982340; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=OTapWK62w4xPy3k7TaPPnAksZDpl1Y/bdBWy/bHl82I=;
 b=WLziM58PRHti6yoGoxkGIVlb/JE/Wp0tfrvw/msIFUkQ7e1fNbksQfE615E/Lsnm9C
 wVxzwCJIJbc3Ek2Rx9jqtyN80dHGKtvMPTIJqGHMj1iunCNSFMAvM42QC2Mr35uuKtbR
 epP1AWNSKBqzXIYQ1tyzLd5LJQ1r36vNTNNs7MUyctWunAkNsvDIiV+rfWKONqTFVWPT
 hmFxaUGtRWuKIaoSrObA4Ll+hAj6Skubif7ag7cvjPu0tEb/WSeUB3nWmFlGVfR7LKpT
 xLEKFL9zS/2S4y2h7gJQl3eppXRu+PRslfqr5Nu14ZaEA37ltyXyMTVEfASdwXyKXaoL
 07fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766377540; x=1766982340;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OTapWK62w4xPy3k7TaPPnAksZDpl1Y/bdBWy/bHl82I=;
 b=AtJxe/wg6q6ed7Br6QdHFLlveUo9XAGwNaovkKJ1G1l33k4V6MIe9YrUYWK8Vjen2i
 /XDw5qVtaP1AjNVUn+LJbmv5s/fkmZULYwWvIue/hpYIvCxYMSEoun3KCH6xd3354NDz
 6/JaOtVwgaKrLFnlip1LZfhTqyw6i30llb/rvAG/No1ZSqtWsS2oikeQDot44mHUsQ7j
 2qEGo3UaELmK93Yy1kS763a7EZHYpLe3PyCY1y7eiImYN23S0nuzzCA4rFfKe6hWEgVP
 Un3FkOSsPAfgYN+NnFA+I4WSfNAkdEFUGqu5dFGJypK1JFgHXE5lynBJPdp4hM++bkCG
 iqyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/iuIBVSOcPlDmFDY/f+zi5xqtYZQDzX//AH0bgcpxbF+iSCpF79hAGppCBn71UvTcWPEcEpY=@lists.denx.de
X-Gm-Message-State: AOJu0Ywtp0VXKKNPSjPFgA0OGPUnVJVGBSMAX01DGQulidB6c43MEiCL
 b7kHFaIrMAnagSrI/GNxYBgJ6xnElnQ/CvWwy32bZJc7FyivPAWKgQSXam6fZd53dOCz2FnGVsu
 JHDDtRIecg7PWN4whDAsbRvZhwhWZ+mcVKL+PKJ1c9sezZYkrtAiZjvjz
X-Gm-Gg: AY/fxX7rhyanFWXDSP+7ZuIATBouCP72KhpbLLnQlK/Vsrg1oPQ8JrDdGPwa8AySOef
 3CpNK5B9z5jCl/HGmneceXjf1I9yEjxYYj/SoLxkR5GvIEzKxUQGXYQSsEqgBcogXoWDiNe3ExF
 mOVFB2WKqfQfkGKjGPYjWx/8/5GEKJbYIRpmN0Jg17K+mMGa9x/YtmjIlrqxvTCZXpgx5r7KbAk
 R4Z0qMRK2ncTc93wZZkQEGBukvGjhquhYELAKmzxaQuK9JZNW5/NTUnBFodRCJj5kJ72CQx0N3D
 HIkBDD6ZCkhZQe+KUPFgdaS5nAFgoCsToSMg6nKBIm1T6gjkXuZeJ0usj6jrkcgSNUaPt7nrq0k
 B/hee78omfBAA6oRqEuOxEhVcuEciKl91rT3NNE5m6GCq2nmi7ERsABI8vehUAicWnca65bCHw4
 XUXDYXOgaz2uWiPeR0iCoPZUUBdjobHkR9afLCLA==
X-Received: by 2002:a17:903:234f:b0:2a2:d2e7:1601 with SMTP id
 d9443c01a7336-2a2f283cb23mr86497895ad.48.1766377540254; 
 Sun, 21 Dec 2025 20:25:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6Tsw36Z/w/pn1jrS47Ew7OYO7CSWxeZk2vd1bn4AYwoCTqavpu+oa1wXy5L/iID4LrRQOcg==
X-Received: by 2002:a17:903:234f:b0:2a2:d2e7:1601 with SMTP id
 d9443c01a7336-2a2f283cb23mr86497735ad.48.1766377539744; 
 Sun, 21 Dec 2025 20:25:39 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3d4d363sm83174415ad.62.2025.12.21.20.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Dec 2025 20:25:39 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, neil.armstrong@linaro.org, quic_varada@quicinc.com,
 casey.connolly@linaro.org, balaji.selvanathan@oss.qualcomm.com,
 andrew.goodbody@linaro.org, bmeng.cn@gmail.com, u-boot@lists.denx.de
Subject: [PATCH v1] drivers: scsi: fix double decrement of block count in
 64-bit LBA path
Date: Mon, 22 Dec 2025 09:55:33 +0530
Message-Id: <20251222042533.2024310-1-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDAzNyBTYWx0ZWRfXxtg1+1Ht+PsI
 TrvKmOUje65QPNQ3FgaNaogOGIG8kHHOSKPEFS1+oIyJS2mp5U9o1irJ8Q3jLmFE43an5iyX/5o
 SWJsdzTofBGHO/VWiubPXzea42klaW7pM1mj9Fo9W5A2cwV0472RW9P8HLY7xgu5OralZc3PoCp
 eehi2GE3mTAquAoE4S/OEIruLGiyzAZbLL5Jf6JLs+zN57cr7oeG5Oz59hlqqTBB8Q4UZaMT2X+
 uxuY7tje6alsFobxc+5kt7NxYqs+i9J1xQ2HfKL39AhEz+ozHrw6g+IixyV6bAKL1bk6c8gTOix
 Gta8Amrun3v3Im7LfUEF4Bf+sRbYauS4eh6wvfjCpibjU1zP3X2WIjJRLRKaEpr4vhaquhNkB4+
 5TWpsVZWP3ReZ2a4IboPsJ5TgeIeoL2Kb9F9Z995aOHg9YAu0a0jDaBhUYYmLQj2n77P5fU/Yf7
 6vehQwdnUkmm2wF++rQ==
X-Proofpoint-GUID: W_tGLPcVaC2jMceR4B_Akk2zoFnnmnYX
X-Proofpoint-ORIG-GUID: W_tGLPcVaC2jMceR4B_Akk2zoFnnmnYX
X-Authority-Analysis: v=2.4 cv=KYbfcAYD c=1 sm=1 tr=0 ts=6948c845 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=fcOCyAeKJhZNpJ7CcjkA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512220037
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

The scsi_read function incorrectly decrements the block count twice
when handling large disks that trigger the CONFIG_SYS_64BIT_LBA code
path (reads beyond block 268,435,455). The variable 'blks' was being
decremented both inside the 64-bit LBA block and after the successful
scsi_exec() call, causing incorrect block count tracking and data
abort errors on large capacity disks.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/scsi/scsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index b414d022f3f..8fe6b38a8c7 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -220,7 +220,6 @@ static ulong scsi_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcnt,
 			pccb->datalen = block_dev->blksz * blocks;
 			scsi_setup_read16(pccb, start, blocks);
 			start += blocks;
-			blks -= blocks;
 		} else
 #endif
 		if (blks > max_blks) {
-- 
2.34.1

