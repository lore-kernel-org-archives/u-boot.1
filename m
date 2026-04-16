Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCDAF433FE
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 05:55:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0E1983EEF;
	Thu, 16 Apr 2026 07:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gtAd9NnF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ITFNcZtY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C5B18407E; Thu, 16 Apr 2026 07:55:15 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A21D483C2B
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 07:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=gurumoorthy.santhakumar@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G0OU3d2972348
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=TnKlgmrKf+axqnrTM+lXubi6aU8y0HDVHi4
 unww4wTc=; b=gtAd9NnFor8UnCet3kG/oyIRDYhgeqI5YZoaw9guiOkSDIz8HTv
 KomzW6mwH5llBvwkQdxxLlox0Zl1dQA3RDRpm5sSmJU99sc1n2MDcZyXNvr8qdNj
 sPZBvaSvLivr/sxx4zUUTJ4kEoIY6KZ/A1jsjMFa8MVicaesQYxTJduaIDk7iRL7
 oCNfBv1OgqPJgVRYwpkjuRKOesegS+7oecc70rZmNj2BY50liQS0hz+DTvZNWH96
 +dPLm80Z8eMHiGiab0Q0XxHA7/0skX3vZWQRpnIGq0pYHfKUcTAsA8B/wbjcl9qb
 tDZaCAW325Qj0kR+SK/FB2rzkE3uu/tnjIA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj74gbwn3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 05:55:10 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b2e06219cbso56923445ad.3
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 22:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776318909; x=1776923709; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=TnKlgmrKf+axqnrTM+lXubi6aU8y0HDVHi4unww4wTc=;
 b=ITFNcZtYxL/Rnp0DUAptbDoUdL2r3ZCZyoTwljhesCJ2X4hekYN5NsmBJKVoMs7K0+
 kbGucva/QVfDlgTPyvZhkwnuhzSrk50QQjfxeTMkrKXqHubzpovAuRf98yyLv5UW4gqf
 p+BkcYRE61N9TmopzTmUG3v5s/hyhu7FdfnwIqYKCyxu1yd4mENM/rmAOxDRrlFesF3e
 fZZOQ500wC9jwAsAHDlhOt8gGVpVu5tPcuxYUo5xocaR3oiGoSuDLbovHMfWoMk2wanQ
 Cm5MkSfJXso0zkzRgqUAYQ6Qkpf02tqYVAEMyQtXlAWupIJo4PXFz1xpCK45OVDZ8KwG
 N5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776318909; x=1776923709;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TnKlgmrKf+axqnrTM+lXubi6aU8y0HDVHi4unww4wTc=;
 b=QtDYlKyAB/h49tB9TJcd2l5v1H7GJGsZzibdhD7a/OxSQUDd2R925FqXYuMGpFF7Gc
 L5QmI1XMNGWpQz/fwfoF0vdJJI4IUGRMsu9ITMQvOAbUL0jesztK2vYwpbbxhgutoCcX
 JIJnqmRKUfgNxYt/1iKR3B/ruOkNpAgLImWRcSKfpw8D7dtUn+drh2b5X8V3LIWb3zF5
 BjjQNrbN4sdV9m6/9tScFy4s/dl6JqnIUT3Y037OcoWDWh4bDqYta31RkPWMgYRZocxz
 34WADLw+nSkLP2r5YUqIe4RyRjt7kKVXp75kYW+rskHWOAyJbK4YJSzs2wBBdd4qMIx+
 SapQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CUz6V1d4/N00zbQLnprFa2ypDW0U+T6N2tClSxSWkKIIb+4ktZYHZagMSDhzndjCOoGe8cok=@lists.denx.de
X-Gm-Message-State: AOJu0YzCpw6UtWjusJSrHvuYJmXBouisHZpeqR6L+WoaIttTgAuDE3I2
 7kA72ko/xOQAGp4bjLUwaFd4yyIdwqF+qbSZX5LWSBQ3FPKn3p3k4m2NUHufYBJ+o++uLwt83aZ
 XvVlYDO/RWqCNYq1fARhBE60/ZXTzBTUXVKQ+yz/NLRD2LwOHC3dV029H
X-Gm-Gg: AeBDiet+laK+82Rhgxdi0PWMEi8wqL8iVmslXmAaZzOUBd5qn27cl46dKXsNSY54Nu1
 ifdpa+AQnaGRMOYWdY4gUwncAlyVNwSbaTNVFzpUOCdcOa9AMtNvFa5Zk3zzC6EcbEuIM80kINb
 G2GyWyAtZpXW/BOK+w8+M+cZUd+3zKfXtA7W9rsnYenLGxaw7/mD+EIN6LycCNpiQUjkjBn1Ywg
 2zfTSLlIT4Vp375UbtX3J2K/Dg0r8ayMvxg5+nzHa1fUSNIJeUf79/sfCOjtI+ywJ5tqH6bd6+R
 QRqEs/oQyY7Qut6TmDe0K01OmjUuSM1gXo3EPIiRlyHpjuarINWNvby9OJCHIB7THJGk2duQLSK
 vrTkIX0bs5kvppw3xaYruEOkCOdFLyvCgYTrSXue92/7awK4nB4s+vil2m+BJkQGuufJJrgKnqB
 H7ZESN9SMYfFWb9tUtkAZKt+3kFiYmcV7kBrU2HD8RmdktCaT8OibNmZY/wq7PPhPUT1U=
X-Received: by 2002:a17:903:3de3:b0:2b0:624f:8edc with SMTP id
 d9443c01a7336-2b2d597d43dmr178466025ad.12.1776318909521; 
 Wed, 15 Apr 2026 22:55:09 -0700 (PDT)
X-Received: by 2002:a17:903:3de3:b0:2b0:624f:8edc with SMTP id
 d9443c01a7336-2b2d597d43dmr178465815ad.12.1776318909040; 
 Wed, 15 Apr 2026 22:55:09 -0700 (PDT)
Received: from hu-gsanthak-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b478109a4dsm42652295ad.18.2026.04.15.22.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 22:55:08 -0700 (PDT)
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
To: marex@denx.de, trini@konsulko.com, mkorpershoek@kernel.org,
 macromorgan@hotmail.com, casey.connolly@linaro.org,
 quic_varada@quicinc.com, felipe.balbi@linux.intel.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, u-boot@lists.denx.de
Subject: [PATCH v2] usb: dwc3: core: fix memory leaks in event buffer cleanup
Date: Thu, 16 Apr 2026 11:25:01 +0530
Message-Id: <20260416055501.494002-1-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA1MyBTYWx0ZWRfX7br702XDZcej
 EEIX33bL+6Y14H8BnIdtosU8ciTdauH8CUxsZ2uKBPzN2u0BQuxj3BonpAV3aruSYb4mLC9Ot/G
 9BremoM19mw7u93nvG/EIfTLObkoUkPY0JCWhWQr1ssnScawKpumJYBbrnvgDT4c5Ie5eA/rPl7
 KIrOE8UGJpiR7RNfExRuc0SNdV6bedHXqf1aFcF//eQxc7MJwi+k9jswlebs2/cwb21D7RM+3a1
 fzK4ipA0ZUljpARLjC1FrXiipsNk05HuembF9zfzZHAZq1gTsE+bBJTonUNpQScrXHRia2kZa+n
 o9/LD0eesAPAp+yScEuL2xhNvqfmh4lYXLtfATqRu9WbZdRCOvTbW6lOagcYeQleWhV5081rXws
 NVwa8xVoypvZwmry8QIQ8dXpbFEyttJ/Yb5djIIOusG+s/RkoLK+DoJeQ7hRcIxSWEWXHPSNcEz
 COc1K0NHddPx2vcBOcg==
X-Proofpoint-ORIG-GUID: AIAu_hR7oX_78ojHGig20zRoNqVBQZ8c
X-Authority-Analysis: v=2.4 cv=ZIfnX37b c=1 sm=1 tr=0 ts=69e079be cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=8ukGJnHcqfySqs3Rp24A:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: AIAu_hR7oX_78ojHGig20zRoNqVBQZ8c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160053
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

In dwc3_free_one_event_buffer(), only the DMA buffer (evt->buf) was
being freed via dma_free_coherent(), but the evt structure itself was
never explicitly freed, causing a memory leak.

In dwc3_free_event_buffers(), the ev_buffs pointer array allocated
with memalign() was never freed after iterating and releasing all
individual event buffers, causing another memory leak.

Fix both leaks by freeing the evt struct in
dwc3_free_one_event_buffer() and freeing dwc->ev_buffs in
dwc3_free_event_buffers() after all entries have been released.

Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
---
Changes in V2:
- Removed redundant NULL check before free
- Removed NULL assignment to the pointer after free
- Link to V1:
https://lore.kernel.org/u-boot/20260414055013.2978223-1-gurumoorthy.santhakumar@oss.qualcomm.com/
---
---
 drivers/usb/dwc3/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 6f22b9232ba..65c4d1a4e6f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -206,6 +206,7 @@ static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
 		struct dwc3_event_buffer *evt)
 {
 	dma_free_coherent(evt->buf);
+	free(evt);
 }
 
 /**
@@ -252,6 +253,8 @@ static void dwc3_free_event_buffers(struct dwc3 *dwc)
 		if (evt)
 			dwc3_free_one_event_buffer(dwc, evt);
 	}
+
+	free(dwc->ev_buffs);
 }
 
 /**
-- 
2.34.1

