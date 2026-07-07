Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CC9C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 09:52:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0324484942;
	Tue,  7 Jul 2026 11:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fk0rLR7G";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NSO0BXN2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6157884942; Tue,  7 Jul 2026 11:52:55 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC220846B4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 11:52:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678EPBF3204014
 for <u-boot@lists.denx.de>; Tue, 7 Jul 2026 09:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=gWT1NgU5SRvgbP8IpYXkO/
 VSQ34CNuMV35sozRqgv7k=; b=Fk0rLR7GPKzIrBoaRPQtgDQFXpc1LUWnF9Mco0
 3bqq3rvKC/HPks7Jq1sOfZBVLl2qdomAz0Z4LalTg21udH1i/vKjW+sSnnXYBGa4
 Ju4dRQegbiaUFlWC+F5W2Aged5ig4FE6BiDpPWWK/x6nOlu8XnWLr/A/EmthUPp1
 q8MQx+obXtLz7UhnOFRQnk3X++RzMGWKFa4gXyxyC0TrzkgHsHfmwSCbppjoll5t
 5566B17Cl5m8esAPeLLUscHL3HMqf2G4JB3Bu6Vt6eZe05kGfa+aiCZGM8miG2Pz
 TkLOm4M/gSfek5EPmQnZEFamDf40lDSIvpK0aNv1MnMmLQrg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v9a8u6c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 09:52:51 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88aab7c1fcso6682029a12.3
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 02:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783417970; x=1784022770; darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gWT1NgU5SRvgbP8IpYXkO/VSQ34CNuMV35sozRqgv7k=;
 b=NSO0BXN2R5LnIXN3YNQdoysDuhUi+GS4os9f4nIKf7VYc686lrYi6HAKWJ+hMzbnhb
 ibGHvz/QE2jM9/oYH0gZqZPC6E24CJeYY0mF7MT2N4q2/6NKJYEBNSCCZM4a7rQNQVV1
 TNiveJdtcI4OzdB/Q3A4WzwN3WqaOcJO0x5vnMNGdJDuk5eYEIYxahNAy6w0Rm7cpI7P
 SBlve1dsEMKb5bgaHGW61AcJPUrUafYVB2PgpDbeVoWvzVP3RQ1QSnkpx4s1ocT77F3L
 kjF018NGrgGVsaDVT2gUZ3HTNfa4AFC0XqeQmEyCJOl+mURIuzTJdC1ujsE0IMLoWu+X
 jh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783417970; x=1784022770;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gWT1NgU5SRvgbP8IpYXkO/VSQ34CNuMV35sozRqgv7k=;
 b=lLB7lnNLFdIUlzSwTqRBXjDyS4b0ElfId9lnkP/G/WdklHhpiBZJuFIRTdFvaXCOJw
 lcQTXaKfNnfClQniyQX+9pbZhuD1fksqn3GWEI8QfGqgqbUmg5PC3bulo1CNW5FrBAt/
 PyZdhBu6IuNBGx4X/8tBRTpE/ytpIk1OJtXfC+lLI/btCaJjXxdFsluSZQ0jjY70NfmR
 Zfh+zbVCASyHnQmmKSLTf0jiw9kolK7m/bJz2wNHTeffk9Ir9PRVkjoE4leABd8/lFGE
 tLH9C98RxpT6S/4F+tPqAW6tbSNaEQVNNVpCiu356uqQDfQhpEwRxFHyjZ3lHUyYD/SN
 Tj7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3Vv5htv3eADvy1+zCQlT91VUJNrPhSQD63gtOvbd1xQZxsq2xbUXj8vTJj13fN08qRSsUkDg=@lists.denx.de
X-Gm-Message-State: AOJu0YwY/8O2/TYyBYkrWMKFK2hbNYNC4eutujig6a6urDjNWliGbGsc
 rPRukP3ZvotMmiKPtW51yDHqWlVTXXi5I4tIXSrBvXERghXr9AXPS0933NjsthJ5ZuRlXUPz3qG
 u8LcqLLxmMq4ILXAddi0lPsLf4tALfaNcHtueWs8lNa2UK2hf/KlhlW5m
X-Gm-Gg: AfdE7ck6K6WwdwwBOZWEKz8xUrXqjAPbrLxQmpAvE+C3xt+BtmEA4Zq5qHRQOocCt0i
 WK4gzDjxIwXxPY6hKclyVz15igCtE7fM1tIPfLztLnCzFtt7PEVQu0X7tPU+Ec8ok91RNCIR7LH
 dQEv0CEyOOZ/l9mimoTNRRLSE7kc5Fs4YqxyMLAKSFeExKcD3Sny7jgHixzJ0ZNdZMV0gOmIrKJ
 vBUhMVo77OuhOkjgwpP78PEXruojFUR69biMX+dLH3mOM+mcGrxe5+cI8VzRTFQId8f7P+RqlbS
 i5he+Zqm/l9Y0a7+yDeMHF5Lzp9pEcSTL1va2XqGTU+bWxscmkxSN66b91YZ/0Kps+ZOQuYpMX7
 XAYWslDtaMGweDqPfvcnBgLgt3KG3nV01UidEiZFOc0JezrubZ2fM+CPgCPt/5k3V6RUhwbRK9r
 CM0WmGGIsqPaptQuitkHZj+kG2vAb9gzSQhkMnSF0=
X-Received: by 2002:a05:6a20:914a:b0:39f:91e9:cada with SMTP id
 adf61e73a8af0-3c08ed50883mr5115392637.9.1783417970149; 
 Tue, 07 Jul 2026 02:52:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:914a:b0:39f:91e9:cada with SMTP id
 adf61e73a8af0-3c08ed50883mr5115348637.9.1783417969558; 
 Tue, 07 Jul 2026 02:52:49 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f596asm6516300eec.2.2026.07.07.02.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 02:52:49 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: [PATCH v2 0/2] serial: qcom_geni: prevent spurious UART input from
 stopping autoboot
Date: Tue, 07 Jul 2026 15:22:41 +0530
Message-Id: <20260707-uart-v2-0-d38277b6c4ce@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGnMTGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDIzMDcwNz3dLEohLdxDTLlMS0tMSUJFMTJaDSgqLUtMwKsDHRsbW1AFWmXlF
 WAAAA
X-Change-ID: 20260707-uart-af9daffadb54
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Stephen Boyd <swboyd@chromium.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783417965; l=1640;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=MLOv+DL1Obrehit8IlLD9Iryru8tiWpZDPMlGtGHbsA=;
 b=IICwBZch92lQ2fpICSqLj49gFcFj/WROJ3Z/m4hC24Mdz/aNq8SKupBuogsguTK5GnNSHkzd+
 9C3jP2TEAd8Ac3+n/rAbO7P9LLavkIvCafnhEyw2iPfpsKHQiHmRy84
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: UuuIQA-qvYAMpHtDeuRvGfyYnWPF3csF
X-Proofpoint-ORIG-GUID: UuuIQA-qvYAMpHtDeuRvGfyYnWPF3csF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5NCBTYWx0ZWRfX8p5R3H+nECJL
 HglZZY9r4RNNsRruyaEjWwXMBYYtz02Qlx3skfjZWugLNN+Vmh5i/Gz/bI1Pa1qVEYxnHxdEc76
 VIz/V1n7aPAIV39Zg9u+uTGKhJE0jso=
X-Authority-Analysis: v=2.4 cv=b9yCJNGx c=1 sm=1 tr=0 ts=6a4ccc73 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=k-42gJp3AAAA:8
 a=cm27Pg_UAAAA:8 a=nfnvzbp7LqCd_FgWU_MA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5NCBTYWx0ZWRfXxUizmrmBXgaZ
 C2EmGFjB4ICVDlU9X+DzLXlyChrPsxvc5IDWn4U0Sh8TXowqN7s4XR/RY+cVIWQQGNPu18upbd3
 Cjo4OYDA4abejtnduVQh/fphrDiYx80e5pjJ3PW8VSA0Rxrq31ZAuagYJog5/t8pjLrdDF/eOoe
 b/AKtUyFkhDuzRwQ8AbV4ZXaoCgZ7lkMouKa3U8hlbAhp1Vx7U+sEZblUrTFC4xBRrRYabrF6p+
 QPaynAriJ0DDg2K4LNc/ZjgOHLpMg7pCIBLlD/DzZiYOBG7YqTk/a3HpJrvAbYYUEJa2ezrTShW
 zjz+DJRvY12mb92iVeWgEZS/7uh7hiAUYisy2dpx6OmQeIo9Dr+7GQdvoYAuZVQz5wpEtGvplav
 4ga0A06YcYxTravVNoMbjEg9nhyMag9QKqayA5FjZQwr7aOYT4AWvHDDPalQoX8PhBLyVzam7cZ
 7BrSDJbLMwLFr9vIOyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070094
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

This series fixes an issue on the QCS615 EVK where U-Boot incorrectly
stops at the CLI prompt instead of continuing the boot process when the
UART cable is disconnected.

Electrical noise on floating RX lines can be interpreted as valid UART
data. Without proper runtime validation of received data, U-Boot treats
this noise as legitimate keypresses, causing it to halt at the prompt
rather than continue the boot sequence. This series updates the
initialization sequence to properly drain FIFO contents and adds
runtime checks to distinguish valid UART data from noise.

---
Changes in v2:
- Add initialization sequence for RX init based on Kernel driver.
- Link to v1: https://lore.kernel.org/u-boot/20260629-uart-v1-1-cbc46fe1d7d3@oss.qualcomm.com/

To: Sumit Garg <sumit.garg@kernel.org>
To: u-boot-qcom@groups.io
To: u-boot@lists.denx.de
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

---
Balaji Selvanathan (2):
      serial: msm_geni: fix RX FIFO init with proper cancel sequence
      serial: msm_geni: validate RX FIFO data with IRQ status flags

 drivers/serial/serial_msm_geni.c | 91 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 82 insertions(+), 9 deletions(-)
---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20260707-uart-af9daffadb54

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

