Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EE1CD6E6B
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 12:30:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39A7784931;
	Thu,  4 Jun 2026 14:30:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="U6Vkc52H";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pce/AIET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E7728486D; Thu,  4 Jun 2026 11:32:06 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39E9D84868
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 11:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6546uukS2477944
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 09:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=GQT2JVkI7Vx
 mWvnWqULmsYFFSSMV6tlYRfGq+NhP2lg=; b=U6Vkc52HocBnM94yDwcbJss8igL
 9S7/HAetB0dh/onTMj9KMKqkRRnNyNM7JEm0+WK4d6AQaLIGs7WaPM+lMTgztNCq
 mCCLRuK1lbra6v26NwVzA1KUAMuVpBMLkM28Yk91hOM4jLQfMx3RpASIceyI1dy5
 n+LpFrRQyrtuwovHbC2iSpBcqs4n0Re0C+uSuhNsdA3d6QN1CJEhrFChuBAr0RM0
 i3AqKk5dza+q8EXYODH0j6suPYJi1e7L7CbCG+ZWrk666yVd4oGI8JYrfFMjsYKh
 K5RKA3rx6RbmiZPq/VCnaeDBHS4nWbIzP/U3IBbWGdyETjXO3OdiwxfCOlA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek4hvgkbe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 09:32:02 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c85dcdbe502so454380a12.2
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 02:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780565521; x=1781170321; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GQT2JVkI7VxmWvnWqULmsYFFSSMV6tlYRfGq+NhP2lg=;
 b=Pce/AIET+jEpH8MonpNeZD1ZBEhKK26HmfYQS0gQa1XHWUUVSI14nR5DDrHHpJis/p
 Jzv8hg9905CBmjJ2nFYI9Th3WRJldvj+Zp1mtRc3up48fNkJY2VBP/wzYqYiveTo4E+N
 b2zFO6Do5fuHtpynPrIrGQ/HbBoEG/fQPGLM2REuEOe3vkJQH0zbGtevOnsK1FBtS6qW
 IUZuWMp+wjlljNZsX+QGnpzPhSIoar0sqHhh0INUYx8dA2CndPcuYSkNX++KIt5VKF5l
 aRG1juOEPgWpCIneb2+Pl+ClpAinkWmjLcrAhdkyudddpMTnqNsRJi4ikOzHU3C6bRSI
 NDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780565521; x=1781170321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GQT2JVkI7VxmWvnWqULmsYFFSSMV6tlYRfGq+NhP2lg=;
 b=VBU9XIwNZ+1mMwvvbJ74ZK5EOK2dQA33cPlXSAGTmn3Tk9jRLQ4AwhRmpoyW3huoat
 vpQFlzgbbekMKSnnVUn+k6mt+a10ZrIvNKQx+0EotYTUefZC6uRbvIHOmHye62biGG3v
 XCqMuFn5rnDd+UVWRrrWAg2Y+oTD9W191XPY3lR0KuRBcZFRmFAk3ljg8786GuGRvKUR
 kn8x7J82DnNacBXq8/aUxpVXDTHSVD/Peno1m18hJHGrNP+9TvDy9wPZ2vvJwUf1KQ4d
 q3KdhCzltbJMA6Ic3/SwFp9VE3PJQr8xUKlzBhBXFBn6x07VE4XbchBbf+diMRQu6EET
 /GPA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EJYZA7uBjs/N6S+dXzT7HUIemTUm/gF/YgedCCgM8o+c0vCQEN0SXCVTcWRIH+cD3YmmU+N0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9mpr/NZ4iMpBscSG42flK8Mv8sZ2Nr0ehHGSXJMDv+wYgQunQ
 MdXtTV6rVMHlvTuzabfdlxaDf7hfkZyTEQAxviQ6X74OEI19fD9WVRSs2IzccjYpnf+QlDDH2d8
 iOpSKbHZeBRDQhrkHSkPPw5X3IQnj5wL8L6KWTJ0itHiqo7kFTY2hiQNe
X-Gm-Gg: Acq92OGbH6jAM9WTLITXBYACeUNvaJvGW7XrmDsnWCRrlt0XhJXXG9GkyaIihCirBcO
 FPQZg851iInUdg49BtVPpQuWqg9rtQdlGvHd+TDFbUOzl32qxTX4HUOoUnIC1Sz71mCfS1txJyB
 Ke9b0oYTDxRwxJ+1ZCXMwRVWTWGWucfUqg9vjIMVL82IH+tftZNzjcF5Xk+R4SqbSSfXdddLL4F
 OlU0pJQbNqcrBZ7pzfHOwcQ9x58NPHO6D4U9NBaxhNa7oAI4eUlE2dMj3Ah+2fAmeKp50vCfb/1
 +J8tkCbzHSotndRSMgKHiIw/3VcK4/nyrr2b6dtb5hKLYKTGU7Ttt2p8H3p4kp99ukmJJgk27/O
 K1mfhd6en9bB9iG03RFgeeBH2wOE4rGaVp/bizw+5Pxl95A4R9OnZhB2Fa4opR35ou9sTDG8T2V
 SeI19lvmW/vkVxK3VBqZt+7IKyAvvOh3jAACllIB3gkFbORo/1R2Rl+ojeJtJz+g==
X-Received: by 2002:a05:6a20:c783:b0:3b4:71a9:cda5 with SMTP id
 adf61e73a8af0-3b4977c7d7emr7752731637.48.1780565521349; 
 Thu, 04 Jun 2026 02:32:01 -0700 (PDT)
X-Received: by 2002:a05:6a20:c783:b0:3b4:71a9:cda5 with SMTP id
 adf61e73a8af0-3b4977c7d7emr7752668637.48.1780565520868; 
 Thu, 04 Jun 2026 02:32:00 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df0b9b3fsm4263552a12.28.2026.06.04.02.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 02:32:00 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, sjg@chromium.org, alpernebiyasak@gmail.com,
 tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, afd@ti.com,
 marek.vasut+renesas@mailbox.org, tingting.meng@altera.com,
 alice.guo@nxp.com, quentin.schulz@cherry.de,
 ilias.apalodimas@linaro.org, varadarajan.narayanan@oss.qualcomm.com,
 xypron.glpk@gmx.de, mkorpershoek@kernel.org, andre.przywara@arm.com,
 h-salunke@ti.com, alchark@gmail.com, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 aswin.murugan@oss.qualcomm.com, danila@jiaxyga.com, n-francis@ti.com,
 ycliang@andestech.com, mateuslima.ti@gmail.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, bdklingerman@gmail.com,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v4 01/13] binman: Ignore noload segments for image numbering
Date: Thu,  4 Jun 2026 15:01:20 +0530
Message-Id: <20260604093132.757583-2-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260604093132.757583-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: r-7dV7sH-ztYT7cI5ScN8wui6LcFuW3d
X-Proofpoint-ORIG-GUID: r-7dV7sH-ztYT7cI5ScN8wui6LcFuW3d
X-Authority-Analysis: v=2.4 cv=Zp/d7d7G c=1 sm=1 tr=0 ts=6a214612 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=ygTIaEK5bUCQk29B4r4A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA5MSBTYWx0ZWRfX4953qiaXN/GO
 BWFp9TlzWr3P50zRI8Bz2WAf2yiZCc3YGnnePl3rIYm4VooUBdrNcVcJJMrCO1dhSSZr52M5Djz
 vpJz8xr1cmUcn8a9BMeStBSePu+5W6fk+S8D8t4A+mviQHeu/3KCRwf050hnEZrn2Bh2oLvwevI
 IXJ6CB/ef41TMcuEwTuis29Q7iBtIcZYLDwjoXOz65n/jyTt3QVAFWZcxv6XthEhICxOF21nY3y
 xkINXWVXIFv8Rn1F2VqPispUbU2DgqRnjmBymIyj7EKyvXn/9VFexTlBsWPNntuJjH213LbHiAT
 txCN3WfOF4EbmDvfUP/YVVHsheX8ts3g1XOEWIOnz3w0I5CaP8ltdFoN+CtFTdEuBHKZ0dDz/SH
 P2WxMm5IYMUI8EP4urgwBOmtRt8zLBa+U/yW/qI8BIHLkslqU2XyIy2RdVZnlSN3yYUKuv9Woid
 IvercmbyCn6wbY/zE/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040091
X-Mailman-Approved-At: Thu, 04 Jun 2026 14:30:17 +0200
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

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 tools/binman/elf.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

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
-- 
2.34.1

