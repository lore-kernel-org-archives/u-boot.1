Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DFCCF34C3
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:26:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FE4F83FE7;
	Wed, 19 Nov 2025 16:25:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PamTkE8X";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TxAv2Err";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EF4383FDF; Wed, 19 Nov 2025 16:25:54 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C82A383FE7
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:25:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AJCCIab1727410
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9ucbQtuN+Lp
 ElXKzOu1RhT/+lTd5oGFq8PsaiQqwMY4=; b=PamTkE8XIkYIaiNfLwuCP+P/t5X
 2GS4XtRX7PLh6k8LwWq1ebA9VObmCjB+9SWlPlZYQHOfXXlhkMq1x8Ys20sCU7g9
 o12vf4xhpibXtv1Lt0pV+CAzLlnkGFCwGLrSjThDtrKqLNXCS3qbka3aCEW+PnJh
 +LBjNVe5KWHP+1nOKP1MBqpVz/v7M6P60Ivg5jQSCcFxOdqZTzZX6DbpUSYXBay/
 e829BVkE8aE8wXmD8wi5fIAbVEQBcfLqmCfmGv4vjAuETLEKIKjcU/Vi705PllIH
 lyjSh6TjjG7lnYtBG4eQdKUjFjQyYj8WubWBz2FBb7hMXa4v9d47rdPBlew==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ahdpr0hwe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:25:49 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-34374bfbcccso6788606a91.0
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 07:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763565949; x=1764170749; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9ucbQtuN+LpElXKzOu1RhT/+lTd5oGFq8PsaiQqwMY4=;
 b=TxAv2Errl+0AHHtns/mibFPqp/25G5wnJgo/UC8K4HLF0FcNyEhFOWzBs4OuXDyd/M
 axrpkcRENwkAiyJNMqumuU59eKwQUDpSHlSEOdS5lz11qyYFHngZaTroelBD5S8zdHR7
 HiKrZheFuVLZ+e6uS8M/pLulLooyBN8o1Vuv6GSBLbig3dRl8Mo2wisPmcl0Svu89sgU
 9U7i1gWzng510AV8swyW3kzeEde+MxzoEeJfFHgKyrGgrhZmgKIMYM0cv+5Juri0TBlQ
 eE8avxJnK4tN/6UR1swtJjlU1FroTbLBWhrqDjgV7Y/KHxnUehLOx6FFVI5gHO7AUaZK
 L/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763565949; x=1764170749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9ucbQtuN+LpElXKzOu1RhT/+lTd5oGFq8PsaiQqwMY4=;
 b=HSyp5l4DV1rRy75q3BAeKfJYqNfZ62N7BYX2XH5Ekt/6xeJCWCjfr57fyLUXhmx9ha
 arOwAYgswsVFYpCx0bBhRuXoWjWHTT3XWK4eGNowj19bV44HwCUGOUKmPmSB4HRB9HdD
 2g8X0IrgebjSYtbiOxTZVBexM+5OEqe2d5jksuWjzwpzAvB4jQxcMgslm/9cE0LdukOt
 i5fg+DIyhfGrgSSXkP2KeFY5LGJ//jwJcLABlh4ChjLQT95/ND4pmOIRym0w8echD9GR
 OlZnzmCtiTwPoZ1LKPLbIFcdQ5Ht/qxzlXxrN5qEndo8c8dypQiTEApK9wgD7EUqouPG
 IaAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAiSsPdyAFgaf02NTVwYuYs04omSExrL2MfsaC9kwKDXHS9zIVOHG6KLjouLTBnPmTB5OFkP4=@lists.denx.de
X-Gm-Message-State: AOJu0YzLN79Q9FyAqCidtI28GihUKyY3fmwWrWNI7d4Wd/d9tYvlEuiL
 vXGudsMEOewMFJheFqKnSnv2N0K75Y/3p0QR0RsGvJfrL1zlbyfMeR9PJfEA23OqQRqRTb3wS/c
 rXH4sWJ619l0pkZyXXkUBuKFAc4rbJXztgaUudYLssLoI23+J3YIaLyNR
X-Gm-Gg: ASbGncuxRlxpgp5hDAHQI6yxPeSpNS6aRQHSEu2aHYTHHSckMTCFuhmMWDOnI4cTnyJ
 TVbo/iu9on4aH8fU5JYi0OslEGcfFc8iefyB2YtVHIPx8bARMNqKnq9HtiCqK6ppaNK+p+ia6cZ
 vqB8/d/8+3SaYmJG9NPR0mtTSfiYZTsFbKPGQQn3UQA88YL46xsJvR1dDCctlqSbapwpdugzUe3
 /IwuBVchmzWSPVMTSc5jqkd8NHLpvGjYPBY+6yW9YjVtNBAfAZWcL6oMIGB/hu3J/3qr6jB2WTW
 qrmdK1ChYZepGBNUOVrueqfTR3FFvQOAQBXiQ0fQOg/ZKHCqmDEXWVEj3tZ4lDmN+nKCAF5zRPd
 S449xOoEhsSLJHpaRpHasg5XBmKmPQGsxwRwJHPbTrzwHRJn6G8H3NXZznSmK/+fOL+w8e8G9yc
 wZpxeSXS+vtl12NkhiihCBb+MkSdtFhrvapoWxuQ==
X-Received: by 2002:a17:90b:1d02:b0:340:be4d:a718 with SMTP id
 98e67ed59e1d1-343f9d9074bmr23916459a91.7.1763565948915; 
 Wed, 19 Nov 2025 07:25:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFt9H+Vq8KjWnjEVS/B7uuLt2DSEdDJxADcqXJYQCYSyGcghCb7LFspUltW4B4upDvUNxI4TQ==
X-Received: by 2002:a17:90b:1d02:b0:340:be4d:a718 with SMTP id
 98e67ed59e1d1-343f9d9074bmr23916424a91.7.1763565948384; 
 Wed, 19 Nov 2025 07:25:48 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-345bbfc8eefsm3083157a91.4.2025.11.19.07.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 07:25:48 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 rui.silva@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, mkorpershoek@kernel.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: [PATCH v1 2/6] drivers: usb: dwc3: Add delay after core soft reset
Date: Wed, 19 Nov 2025 20:55:26 +0530
Message-Id: <20251119152530.4175628-3-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Uq5u9uwB c=1 sm=1 tr=0 ts=691de17d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ss--aXFnE7Wsk0pJjiIA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDEyMyBTYWx0ZWRfX1U97q/vaH8e6
 gSkhlf8cYPc+kl2wAzIP2kPw0U3KsZ+eRDXlBl5Lseqg3L6VuRNI4erzqeQCr+oYSzUDgrzdIFE
 WrQDcdco7DNqaw4iVox5E7wwLquaZ5pVP3Hg7q5hKBUXWnd1AGDbFU4xoj+teTSengZJaEIDR09
 sIIF5xl5Q1h8eZGFuDOcEBAjidV0vql+D1v8tG37TLfvnxDkSBoFL6adcfpfOmYUZx5xyZsEfVx
 V1dsWzgAzhbmR8w0wI8RrzUQhd/PRmgJvai0WuT0fpK16LOV+ux9o01F1rHf4N94PYMrTrW+7Av
 29aME4w48YmkEUP0xhfJJV5Ty/199ZHX29XKeOFE6qS77MwNw+lTBBiyPZSw5PZYBgmawqXKiQe
 EVbDvgVJmKmXNhzHCWmu3MXOghcG3g==
X-Proofpoint-ORIG-GUID: vtlwb94kikN7xy-ls9nGk8wjU7yTWIto
X-Proofpoint-GUID: vtlwb94kikN7xy-ls9nGk8wjU7yTWIto
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190123
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

Add a 100 ms delay after clearing the core soft reset bit to ensure
the DWC3 controller has sufficient time to complete its reset
sequence before subsequent register accesses.

Without this delay, USB initialization can fail on some Qualcomm
platforms, particularly when using super-speed capable PHYs like
the QMP USB3-DP Combo PHY on SC7280/QCM6490.

The change is taken from following upstream Linux implementation:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/usb/dwc3/core.c?id=3d25d46a255a83f94d7d4d4216f38aafc8e116b0

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/usb/dwc3/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 847fa1f82c3..ff0bca0dd8e 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -94,6 +94,8 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 	reg &= ~DWC3_GCTL_CORESOFTRESET;
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 
+	mdelay(100);
+
 	return 0;
 }
 
-- 
2.34.1

