Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727CBF9D0CA
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 12:55:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 117408422D;
	Tue, 14 Apr 2026 14:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="n61Yo1BB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EViFBtFx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7C5383EC6; Tue, 14 Apr 2026 07:50:25 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A7D9838BB
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 07:50:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=gurumoorthy.santhakumar@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DLCRtS280759
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 05:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Kej3fKCruf1qbsToMzFLSVf/N4OI3SGhYX8
 YCfZWtZU=; b=n61Yo1BBBxil2+UnTutbUy/XHU0ckZkOYb5cPszgRH8BC24Qgt4
 3w5sIUqVhcslDR3jPvogjl+9VXPKg2JTr/aUIODc6/t8TPg5MWEZkxFHE4Bl7nk+
 lU4/3IyLcou+/Jw1Igxt6098pz3h24binX147G/b5WfCJs5KarGhnKlAX9Sy9moJ
 P3QqAmZEkrmxJVhIcmey8PDpQ3uow0dxb+tkww9ravOK8pBhgQulTIklooN4YjsG
 7pocdB1nTG2u/DSocPo8Mba8eIdgHyeYl00W9Gdm/tiEdHUNNlYfjGWjDwmBBD8m
 YgjDXf3xF9IJyX2LOHbQnOUz4ufPI6j25+g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh86vh779-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 05:50:21 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c7948640854so396813a12.1
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 22:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776145821; x=1776750621; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Kej3fKCruf1qbsToMzFLSVf/N4OI3SGhYX8YCfZWtZU=;
 b=EViFBtFxwAXnfetNnm9rTEZ+jIXJorl7tfbusjfMWorBi54zRyaFWh+et/fPGJ+W9W
 OEJwHDD23gp2na037BePxoO9GrBE8MUVw31sz8aY8nCWaY73BlWiGw8ovHIAho3sKen7
 /fLk31MGh5/aseWidoahif5Mh2GUjID84N4m+rk8vs8jn5kVOmv1lSEa/M5aQu0SPQ//
 W35t1fNe4YLwSjtwgjlRrejfHhRTsf/Jc2lX2cn0LjRGYCGwS/fAEs8ibvqqHAXU9ZdH
 p+j06JrPtDCrCtKlaNmXQbkQOOHctXzHdlK5RJgKrWZMrmMBPpAj64Sz/0IvVt4dYGGW
 PnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776145821; x=1776750621;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Kej3fKCruf1qbsToMzFLSVf/N4OI3SGhYX8YCfZWtZU=;
 b=sx5Vb7HH1Yi1yidkCibnDC2OM8hZdA6jvGe2lGDErbDh4uRA4DIRKosUuX9G88SHvh
 +cyn+Or1J11SYwwajruMYcfjDMUSpfTjQe8pVK6bjGAFCtWIJroK/V27ZgKYVXxkCBnz
 pcFZ/VxUvT+5PvVSrRzRqGeC/XAK1MbZqGFk4zuDLaavcLMRfTSXVbUTzze2gFhNaeFP
 PisSLpcNf2LXlbqsV+wyzY+W6SXv9tgvH8+kZQIs+6xem4K1BCvazjkwfCXxUgLaguSF
 1mgngHemzVs3L/BvIfxtlnAK5xvZbiQ1yvSnwJmULqAohog2/faU4eUjPV57ZPQo97Vf
 M5Ag==
X-Forwarded-Encrypted: i=1;
 AFNElJ+/AQaw3o2t+8RFaO+GSBTR71S8EsSbcAtmUJUdw6LS2cgeZ5NaypajmxHMnni0vHr469J2b1M=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/DKgzAnxCxcH5X3I+9kSUOworOVx8fV2aTUXw5WoOdOYBAzEw
 qTwuBZqBAndz6LftqSH5fkDfulU2ENZfN31TXHbZXo/f9lDKx0fD9GP077n4Rg5IbPiDjkKqm1K
 dmPoRZvFdwT9CP1zT43+o29GDdCdTikSf0R0ayY+Ft+5NB66Xrq1Lq+lc
X-Gm-Gg: AeBDieub55fh+zKXZPMWc/7eaGCdZeY6NbGHBZNU5/V+U+p0wPYjZG+c2UDdJpZGHs7
 ARRNTGqXNw0MHFAcSpm8AEs9srdlCN89srr8LjbT5S7r3/1VAujSrWsCa8bztQYHFb9ZyEdFpTb
 UH1gHCge6c7hxZQJDLMmG3d0EI/ToAJqPlw2I6IYRoi6RZr8kl52I6ho2qetrX22pZaNYhCEoro
 Zo+/Vjl1+cvld45nQa+/2GAF72sUuJ0XCQDX623oKWW7+7Hgvq9FNXu89nSZ5TDj3SGlC6DrEc/
 vrP7LcSVpYViMbgNrBaRAITYulxD6FNw6za110bQcU2pWr8hmWSh/pSbuzkHX2aFHJLrIURrv5w
 iHGtjpOBRFQ8Ad+nEYC+scnXfZHTXwtj5lMdwVINydofjzMh+ioua8xzqSDkGaNxe2VXH0T8QaF
 DhSTRquhZnkBN/Xlji0CoZxwsqkDVGEK9Pze8AUOcG6gVQBy/FEXi3/BB7Mpyhj+7wNsc=
X-Received: by 2002:a05:6a20:6a1d:b0:39c:3de:efec with SMTP id
 adf61e73a8af0-39fe3ca18fbmr19435326637.14.1776145820864; 
 Mon, 13 Apr 2026 22:50:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a1d:b0:39c:3de:efec with SMTP id
 adf61e73a8af0-39fe3ca18fbmr19435297637.14.1776145820384; 
 Mon, 13 Apr 2026 22:50:20 -0700 (PDT)
Received: from hu-gsanthak-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c79216fff97sm12312303a12.7.2026.04.13.22.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 22:50:19 -0700 (PDT)
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
To: marex@denx.de, trini@konsulko.com, mkorpershoek@kernel.org,
 macromorgan@hotmail.com, casey.connolly@linaro.org,
 gurumoorthy.santhakumar@oss.qualcomm.com, felipe.balbi@linux.intel.com,
 quic_varada@quicinc.com, u-boot@lists.denx.de
Subject: [PATCH v1] usb: dwc3: core: fix memory leaks in event buffer cleanup
Date: Tue, 14 Apr 2026 11:20:13 +0530
Message-Id: <20260414055013.2978223-1-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: NPqTg3lW0gOAT14pk6e6YwGr3KMkDP6H
X-Authority-Analysis: v=2.4 cv=cffiaHDM c=1 sm=1 tr=0 ts=69ddd59d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=8ukGJnHcqfySqs3Rp24A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: NPqTg3lW0gOAT14pk6e6YwGr3KMkDP6H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA1MyBTYWx0ZWRfX9HY/yqeHFs0U
 FJqqghZCFXSsa0v87mpaz4dkyck3VNUgJN20OBGWR6tk3KiWhQW4Dagdmhm8BLjhpMlqeDIKNym
 /UTd5IxGHCodH51QezQ/h0NLsRY9H0Gt//wS3UE2kbqipq02IazIFczjQYC+MCC2OO0s+fcW5Yd
 xVPZq7kyb9qUuqsTiqaUPsmQJjCOaA0ubgB1JlVh+QVAjdiNSq5QyDDxuIxUtlVWqGz7OzugJmA
 5AjWhbRZgsWGf18JOjNbGIhAysvWVYf8Pso7M35vgNcW8a9ynysgFYWzIcft+wnx4vZJ1gw3Enh
 Z8pn0vLzNge8/XQZX7hyzzsoo06NpZTnXlDq7fhkd3Hd6gRZ4u8cI55q/T4EUehvF6RZgN3ZEkV
 AsgyTfY2SRYjx7BlFbodyNunv9uTRgUDnzGWSwuANr0JPfbDC4H3Fo2jpss2sSvTJmPnm7960XS
 ETbWn8Zh+EXfrsLDErQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140053
X-Mailman-Approved-At: Tue, 14 Apr 2026 14:54:51 +0200
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
 drivers/usb/dwc3/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 6f22b9232ba..e0c4cb64c48 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -206,6 +206,11 @@ static void dwc3_free_one_event_buffer(struct dwc3 *dwc,
 		struct dwc3_event_buffer *evt)
 {
 	dma_free_coherent(evt->buf);
+
+	if (evt) {
+		free(evt);
+		evt = NULL;
+	}
 }
 
 /**
@@ -252,6 +257,11 @@ static void dwc3_free_event_buffers(struct dwc3 *dwc)
 		if (evt)
 			dwc3_free_one_event_buffer(dwc, evt);
 	}
+
+	if (dwc->ev_buffs) {
+		free(dwc->ev_buffs);
+		dwc->ev_buffs = NULL;
+	}
 }
 
 /**
-- 
2.34.1

