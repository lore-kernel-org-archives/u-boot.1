Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65407CD98F0
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 12:31:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B983A849E0;
	Wed, 17 Jun 2026 14:30:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aeMc9tci";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dOAcXqH5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 016C6841F2; Wed, 17 Jun 2026 12:18:45 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1564838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 12:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HA1t202482243
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cGJO1DVcWkh
 lfRFd1+rTMh7MfBCvweoxsWvYR3veRoM=; b=aeMc9tciuzn52TNuZ90yLmkkjfQ
 Tq7fWfBm72DqLqPP5Dc1+Wq1nbcJmPzrTX/JgAwLqSBPx1XWs+PDuOXQuBxBKRCK
 flRhlyvN8BGdbMySzAFUxpgzbk7B9kHL1m5hZrzSEm3YLxC88eadD/LYVq3vOcQA
 rrNOim7DcbIX8hBmeWFt4MJ9PbvYSNLy3i509PSHP/oW2HSwAOwr8IDTPleYxhwr
 QLekDyRaREHJCFeQoCTMuzUtPQ45ZoaE4yNLfartd4JUV8DEXH+GTwuWivQbs/G5
 3FZatZMaJwQTie4P4BBkvNQiBt+ly5E1NJEvpP7QYz73yjFIBli11J+w7BQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euef2apcs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 10:18:41 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c8581f7723aso2774917a12.0
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781691520; x=1782296320; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cGJO1DVcWkhlfRFd1+rTMh7MfBCvweoxsWvYR3veRoM=;
 b=dOAcXqH5nY0PKlHEEKUabPqbeN1DMPsWECOOxmnUwkPOBO0QDM7Er+ONIJ+9BwDyNK
 /ZhEdCgsGByVe7XJym6E9x8L/9ANyCCe+9k1863qTo30UszBoTHqmj37e1rW1/7ytwfg
 M3vInAG3At7mvC+hJGcD2Iwn1QSEk/6A6LFpHvOLnTITJn5O1vzlAP647+zoK2iA8XWb
 mUVtP42+u6TV/wrjDvISVT69qy6+9ZEGXuSFZpvCEyveJSKqH12DV2Lijn9VE8MnLJ1H
 CCo1XEDjB/AkiBHGchgYW6KR49ClISA5EOMFMC/3UoKSRhrdY/L1OY9XY4aaosyN63cG
 MwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781691520; x=1782296320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cGJO1DVcWkhlfRFd1+rTMh7MfBCvweoxsWvYR3veRoM=;
 b=lzf0Ibct8v5OzHW5xiLkHYFxufh+0PRQaQIjK/dJv5yN+yu0KSIh8lONSx/Atd9rXn
 aVXzQlKUiRKW0QndJ7241IUyz8LLJt1S2yxqs/R2v+7pLoz8+f/juNVcDW/k96f/BwoY
 KrgDgCwCl4ZhwEOFgUs2E/ma1+CNSIJIC83gX56IYZ3s6B5RBSKvxXbEvnO4FzfYHhAm
 rTlHK1v8TPZoe/dxYumXrQAiPxj6N52af3CLRGnwrKN61cZRlw2xpHc4TmsKeH9nayM1
 8EBwRZO075qppc+V4RyJW1PawonCZas+BauNxUHEe4rGML291DafrGq905jHU/rGnO/A
 IGZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xCw5kZajjIWyF2vw7hBvHcNGnL5+OMrcEN38UAh7N4w2tG5iFgZm6R0pV9JhQnNhlU2M+NEI=@lists.denx.de
X-Gm-Message-State: AOJu0Yzemmp0TaQQYMkXTALRJHADeHEfAdGg3nShffU7fejzb7WYrekK
 0JPKaXoCEyd9DxXyS4SCbZtchj1b1Sxj9vrw8jiToR55WuZ9QFtB7ZgtfnFDxpEc2y86CiMjCfd
 pyWaO2MzDgPT+fpPmimJ8H6WDIWz60OvaFY87t6Qu0GkstRmsYYq7+AYc
X-Gm-Gg: Acq92OEpan3Sb2x2ATX48IXSZd2D6yVwmQXRZn83O67bqRX0qTqyxkihYuK5hjCUhEr
 xNx2ZEac6X4eIjarAM/ez3izNx93q/e4NXqStQ519JunCX01BAF0GnoMSPPJzRnf9YJxnvwQTdH
 Dc+d16IspEfQjyRX0xSp8kPS9G886B/QFyga8PI0HopjRvZu69uBY7b6/azapqYgjYQXObSe6CN
 NjrxdVRpkomKuK44TdhnzPZY8Nv+ZTqAEepet27qxDBknsDNYCn1WQDiKVl3fN1QHz92tsKuu4a
 nL/riQB4z1my2iAk9zNSLgrDtRgOAm+DBK4E+Vu66kkDpLSsA+g3iGlqBWUA3ai8jXRhZv2Tu/2
 TZvOA+Ee3c6p4OQ1cj1+fFeH/d8iuFp7QrvTmSenPB2p3vEnKvV8OwnLVBC05TScpZRUZqwXkbo
 IxD9ATJUbv8j5XVqHne/xDfV/GYD/OL7KOck2HDzeX
X-Received: by 2002:a05:6a00:9285:b0:82f:390a:69df with SMTP id
 d2e1a72fcca58-84524595987mr3189118b3a.35.1781691520298; 
 Wed, 17 Jun 2026 03:18:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:9285:b0:82f:390a:69df with SMTP id
 d2e1a72fcca58-84524595987mr3189074b3a.35.1781691519853; 
 Wed, 17 Jun 2026 03:18:39 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434ac9c4c0sm14137413b3a.3.2026.06.17.03.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 03:18:39 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, sjg@chromium.org, alpernebiyasak@gmail.com,
 tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 marek.vasut+renesas@mailbox.org, alice.guo@nxp.com,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 varadarajan.narayanan@oss.qualcomm.com, mkorpershoek@kernel.org,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, dinesh.maniyam@altera.com, luca.weiss@fairphone.com,
 adrian@mainlining.org, danila@jiaxyga.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, n-francis@ti.com,
 david.wronek@mainlining.org, james.hilliard1@gmail.com,
 bdklingerman@gmail.com, richard.genoud@bootlin.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 01/13] binman: Ignore noload segments for image numbering
Date: Wed, 17 Jun 2026 15:48:00 +0530
Message-Id: <20260617101812.299586-2-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260617101812.299586-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=F8hnsKhN c=1 sm=1 tr=0 ts=6a327481 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=1sCYvO5Zzrht_IdX2kIA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfX9H8EoBo57y0T
 6VPoX4ND5XQwV89gv46hZON02JM/bDUaWg4b6Lt8QzaI359JyWgT4JuB0i/BgF99NeNj+OV6jVA
 299h5sjOTl9OCV68BpsZoDM83S4/aaE=
X-Proofpoint-GUID: YBzgmODlEc4hseyb28tAynrhx5G0ROQw
X-Proofpoint-ORIG-GUID: YBzgmODlEc4hseyb28tAynrhx5G0ROQw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA5NyBTYWx0ZWRfXzOQET0MEbZ3W
 o0U8HMy7xBrZtyWykKxSiYXD/Qil+mLlrgEo5vqai7SQqTOUiR1GYrPFJplxGki7f/mdAMq+E6A
 9YI5m7E9HVSNQXAA8CykV3ZDFMf/X2QGDSkj1tOD4JAzOrfxdnhLowgWGgkSRFR2/dOsue+0XaL
 zJdAXqAtB2yFirMrjnHCW7jPam3nuIAuqZDlo/A3uezj76ash9GHWMxR9jQvnmrfxqzJe5Kswuz
 ftG7G3QwayVkXZLHwCWFxRQA9oONtnR76zJU6Pl2fgPFVMRZhG+4lbaeILe0PgE9lREfprhrSCL
 dTMb2vjYfmxE30UmWl99Gyv6uH6gGHs7LYTi7JJjDYr3vPC6waAU0/ugUtg6m5dU9Sz9qKMjcfq
 wzyW2KFQai7atDJC1fBbYrSQyeMBdmWIo/7J8ihQSEdovud4oBBDe8yH8DEzoNiKF2NLl8SQBV2
 OBLK1drKqv03Un7B2xw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170097
X-Mailman-Approved-At: Wed, 17 Jun 2026 14:30:36 +0200
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

While including the partial images of a split-elf, binman gives the
segment number as found in the input ELF. However this results in 'gaps'
if the NOLOAD segments appear in between LOAD segments. Hence track the
LOAD segments separately and number the partial images accordingly.

Update the read segments test to verify this.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v5: Update the read segments test to verify this.
---
 tools/binman/elf.py      | 4 +++-
 tools/binman/elf_test.py | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/binman/elf.py b/tools/binman/elf.py
index 6ac960e0419..b43cf490b37 100644
--- a/tools/binman/elf.py
+++ b/tools/binman/elf.py
@@ -551,6 +551,7 @@ def read_loadable_segments(data):
             raise ValueError(err)
         entry = elf.header['e_entry']
         segments = []
+        n = 0
         for i in range(elf.num_segments()):
             segment = elf.get_segment(i)
             if segment['p_type'] != 'PT_LOAD' or not segment['p_memsz']:
@@ -558,7 +559,8 @@ def read_loadable_segments(data):
                 continue
             start = segment['p_offset']
             rend = start + segment['p_filesz']
-            segments.append((i, segment['p_paddr'], data[start:rend]))
+            segments.append((n, segment['p_paddr'], data[start:rend]))
+            n = n + 1
     return segments, entry
 
 def is_valid(data):
diff --git a/tools/binman/elf_test.py b/tools/binman/elf_test.py
index 5b173392898..2799319d0a0 100644
--- a/tools/binman/elf_test.py
+++ b/tools/binman/elf_test.py
@@ -288,6 +288,10 @@ class TestElf(unittest.TestCase):
             self.skipTest('Python elftools not available')
         fname = self.ElfTestFile('embed_data')
         segments, entry = elf.read_loadable_segments(tools.read_file(fname))
+        n = 0
+        for (i, start, data) in segments:
+            self.assertEqual(i, n)
+            n = n + 1
 
     def test_read_segments_fail(self):
         """Test for read_loadable_segments() without elftools"""
-- 
2.34.1

