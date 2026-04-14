Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC63F9D0CA
	for <u-boot@archiver.kernel.org>; Tue, 14 Apr 2026 12:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6EE984222;
	Tue, 14 Apr 2026 14:54:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="irFFr+el";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="joFOB2UL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A44983EC6; Tue, 14 Apr 2026 07:35:39 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BC45838BB
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 07:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=gurumoorthy.santhakumar@oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DLB2WW2510011
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 05:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=6q17JdLWlyFne5tiQpHZ59HOiZRGvIYyXui
 RY5snyr0=; b=irFFr+elL+ZLlZupayGs1zuCHNrbPnHxWEFnXVk5zWpjJKYw/C8
 JL1+JSssTW7nR7Dxr9xy/L1RJ2H/t/3LdcwWDLqjwHF17PVUWMZSBNw2vwhrqNki
 N+59PWLu6Q/0sielp3iTdV8GScTMRmj7+ybMdmhXFWoStOb9IS884GeVSWQCEm9L
 ehVcF8FnUNOI/SazfBomDt0qXs1ra0GO72tqbe1aZ9xaeIf55NQwonQ8FLpeCG+d
 mqJTFrRkVsIf6gQZNNs5nWwDkjsOpTFyNGP81JbuKhTcXnhY83L5vrSG8V72CBqr
 8ZJyJsitnbC8zCIabeBomYaX7wISfZlcqQg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh867s53f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 05:35:34 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-354490889b6so7518761a91.3
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 22:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776144934; x=1776749734; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=6q17JdLWlyFne5tiQpHZ59HOiZRGvIYyXuiRY5snyr0=;
 b=joFOB2ULvtjJjuFejnNoYAwwYsvMVganvXzKG52rQWVMR1I8x77FKkYcC0xTbEQynp
 nfBIyLGnm00cpPclBRl8F7ytO24n787FJ0+zEbVSvOvzk8m7q4a8WuCUMo5aPGWwvQ7R
 zpjmshpJyAhUe3YxPdNCDjlOYx2vy+090OvJb9lwUTCLq/To5bOktJtERMx99PhfDeli
 P9+Vc9aqwri4P/eWIw4HLd+7GzIsJaaj3QQWvLJmnNhsSYyq1NiPb+ViS88ZulGh5oDE
 a77aAm9Quk02i0VjNxUDDKRsBoeHucyiRW4GInsVdX2e5ls+lbjauoj8288Uh7Wsm5E9
 937Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776144934; x=1776749734;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6q17JdLWlyFne5tiQpHZ59HOiZRGvIYyXuiRY5snyr0=;
 b=U93xo9WNtrpOFck0fiuMHgGnsGSH6rUbHdXl2F0BkOpCvv5vgi4JxzRLgeZ2VAySNb
 0IT8iiNIwOGixDZ1s8LXJZCov4bwY55Lz23Rpe9X+/x3cYABD3/xDXx7HA/XOGVhBp/a
 FmQfyAShKmYbDcfJt3Y6o4cszMXVHMtsQCpV+lFmp0HiWt1ETGYQrqyZHDmwfLPlTcoq
 VoEd+4n85dsS1kNxCC1OaEmWFS1yxTVzIWB5bZmJZjYRVLDwn6ioxXsGaW8yR4VgqrPn
 oAjrSeKXp7JUu4cu1dbbt5WuJw9NOkCHwz9dNaGPQ46MyUDHj7IuRqV8ITyTtOc+mwLv
 ClMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Okb7gvuEatLZvOjyLsqPLvqMIObG/udGgcmUhcPO1ZEZsS0ggaKmoueNnQfRUEV7BC0V2emg=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4LLkpCwf4AJptMz1+EO0daGiNz2VFE9FdOjn3Xqw+ST/HnVeo
 J87K7R9I/oSVDKauXp/qMgd2YtyVSmi80W1UBYg+OWKY+Gpt6oTTy5NuUdsPQSYb58Vo205BaZB
 IA39KHtNG9RO9f620Ab25n5U7j9eV/85ddnUtrahnxMi9a+CGpCUsBWQ8
X-Gm-Gg: AeBDietCIwuwr7jRH0aBlbiAK9Y/CRvWtB6YiTHX8desGeCD2b3ZEo0LCZLzvqRUgRc
 6fpbR2Osxyza2gDU02QnbglO8r/3oexJzyj3CyRj1ArW7y+OMCh25Y45GUyUvlneq7xfoFts8Ex
 2+xzlsrqlPAeZ/XWSjy/Qck3VIPL5oe4gKAexmdSnBOpRQEliawJhxB0kr+2nEYLYmm6zPgb1Zs
 m+ByAjl2EfZpnojd380O54YvZc3dDMaXeN2nb5Cl6QjllU76zLi/hF1Q4/xgXYth5+TAcUWcofC
 xvTL1h3k1TK1caTTArFssEasQtmM4XJ2DDHYbHdvT70W1/pDmEhHKxhRa/rJyv47M0+wJltEX6S
 RehZA7QoZZ+L7HdI5y5gvC0stEJO8+AeaH1JuqxoaynAEQ0I7fI4npvDWxlmr2SLB7qZ74pOgeO
 x1NoE+NDTO96iID+gEW5FqZ7IgKvElYf4r+0kxNQ4vqhs8buU=
X-Received: by 2002:a17:90b:3d86:b0:35c:30a8:319 with SMTP id
 98e67ed59e1d1-35e423f41c8mr16953187a91.0.1776144933895; 
 Mon, 13 Apr 2026 22:35:33 -0700 (PDT)
X-Received: by 2002:a17:90b:3d86:b0:35c:30a8:319 with SMTP id
 98e67ed59e1d1-35e423f41c8mr16953163a91.0.1776144933436; 
 Mon, 13 Apr 2026 22:35:33 -0700 (PDT)
Received: from hu-gsanthak-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35fc6e60635sm1104771a91.5.2026.04.13.22.35.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 22:35:33 -0700 (PDT)
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
X-Google-Original-From: Gurumoorthy Santhakumar <gsanthak@qti.qualcomm.com>
To: marex@denx.de, trini@konsulko.com, mkorpershoek@kernel.org,
 macromorgan@hotmail.com, casey.connolly@linaro.org,
 gurumoorthy.santhakumar@oss.qualcomm.com, felipe.balbi@linux.intel.com,
 quic_varada@quicinc.com, u-boot@lists.denx.de
Subject: [PATCH v1] usb: dwc3: core: fix memory leaks in event buffer cleanup
Date: Tue, 14 Apr 2026 11:05:26 +0530
Message-Id: <20260414053526.2955266-1-gsanthak@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dfYupbADDdUgXZWgwWnLrz3X8Q5nFk5G
X-Proofpoint-GUID: dfYupbADDdUgXZWgwWnLrz3X8Q5nFk5G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA1MSBTYWx0ZWRfX2MI0PGcZdg2x
 u3iztijxIBRjJJb1n9g7TN/N5/wy9JUdzbO3mfRFQy6QqKGdEhVzUT3InXBATCfiQ5ihQFGq5wo
 TOsTjpcVG1UsctHyz6Vm5MokzQC5/c0+whN2U2xWr4HoMmJlDz82IqI/0jW/iihW/P6ifcEbqaf
 0PMOSrIjnFNG2op0TFIx97nmYu7K+TPpd8tyHtHvPdB6NUJ5t2Lg7PzYbY3IaEkdWmxkIPEzLhc
 z6864vdaKlJcKJFVA7rLpWUd5jqwXZh3DlGGCKIChRdExDhjtBCyKWsEVIouxZxeGTEU94kk9J8
 xq6ZtoIrrFGRznBOxxAQ0NU3DxFDWeXx7mLneHCH+3+LSTdwbRfVnRd3JgX/ywDgie4Zg5N3oTA
 VpRWYXc/BChT9mfEWFk+RFzgUtlSHWOka8s+E5UNeqFV3iuGBUk44zRdPn8m7Q0noMdzSJmL7/D
 O2movibyIcF1NbLTx+Q==
X-Authority-Analysis: v=2.4 cv=etzvCIpX c=1 sm=1 tr=0 ts=69ddd226 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=8ukGJnHcqfySqs3Rp24A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140051
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

From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>

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

