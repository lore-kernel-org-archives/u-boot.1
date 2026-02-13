Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5726AEDF152
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 11:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B72D983DEC;
	Fri, 13 Feb 2026 12:06:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iZu+i7mW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RMtxEV7x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A289783DEC; Fri, 13 Feb 2026 12:06:10 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F238983CF2
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:06:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61D7FbpM652673
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XMhwnZm/Eg3
 Dxfqr0qgwnk+GpYN01sGs1g6YNwF3lxE=; b=iZu+i7mWnxj+lo2Q4YeF1ZF3kqb
 CahfmZrlEZ7mg52OAW5NO8ToCveqoCw/1uHabxtP7dax8/esCfI8rXcBp3XNS31I
 41ELIL0YCmCpV7BHrKw11nyaMPnXOTxwlp9jP+7AC9GZ28jDfJLSV74qz11jM21p
 6x1QzEbDPfq67CksXis9e1eu8IBDOd0Gv407vdkZ+aIt70RbLVTGmffX8S0KHq/m
 zGjW5maK8jgdPyxi7deq9wqZDlMF5icmsUJp4pBojkk1w6fH8E9sY9UL54nkO97d
 Y80/rd4jJmoNhagxZ6IhJ6Wq8l659uQdxCTH3LaKHoWu/9JuzeiOrdGCL5g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9gbbm4vr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 11:06:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-354c44bf176so913029a91.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 03:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1770980765; x=1771585565; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMhwnZm/Eg3Dxfqr0qgwnk+GpYN01sGs1g6YNwF3lxE=;
 b=RMtxEV7xc6O0XaSTFT2zLm+YTfRjbVgH52XVbL9nksZ/DulROxGio7pSgBZHQpL165
 tivtPAdgAClfYrumeGqzwdzSG4CTBioqfsnBYRyD8hs0s+goDcNyKwxPHSVyDenyf9XC
 jcMWv0r393wJBz7rITBcONBVJ4lK7GAXaohNsEZROJz0y4/glkt4VY0KvWITfApjhZBV
 eNEQns9FO+VURAXI6+YgRzTqJFqFR2IO46Vh28zraBkZbehqRXRJBTdZBetwDsP/fcw7
 3lsnmpCTgEHvBqaKOGDPJKNvbaujnLwnCoj5XogVft3FEZOHJfS/Txt31dRNVNIyqS7q
 rUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770980765; x=1771585565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XMhwnZm/Eg3Dxfqr0qgwnk+GpYN01sGs1g6YNwF3lxE=;
 b=FTpP2o+fvebFaSkSl0/BYz2W5hVzKFgl/7lMwgtKibZ/FxZhvm6a8m2oL4PfG+ejAR
 2ozzcC/c2zsdwX8EY6bBbSFRQ5W6QFi8SH5NOW9Kc3KqouBz1+UKKh4NOe8o0XySkSGg
 L0u9ya+/nVB2+Aze1zVQDfPkGzpVfxRbFdNLs/LtJXU6N6cWk7iaAqA6AdDS5LmF4sZo
 L70LKYSovVafmMWEeLaEBVXzF24VQdyYQhCQfrOZQTHtVZ0Y8k56rfYVMm+zPyesE/jY
 TIyZsDJueE9ygvQjYzdnRlX45LLtnRjA28K0lttrrWLpTOvqe6RQHRemloIpRax2JFk0
 97kg==
X-Gm-Message-State: AOJu0Yy1SsTc/mxfPZg0rBiO+eDwdJn7IJxcTw2dv0FOOTWws49iIkJo
 cQ3Sjpk3hAFolyOTcFHeUlVxhGfTRf0vl7jiLPDaC3bj0PbdxmbC7jmwNQwL8EObmc2O0KckHOs
 h53xQk5JICGkMlvk++lUDq+G5tStJnwphF2agEb8BkUbJqDhyMAnvnWHAkHe09kGZ
X-Gm-Gg: AZuq6aJ/CXcRKnF2AWgsrvZaHkZ+dwc4ZJTICBv7wYFe/Lc1rhh/XwCcaai84vT8rXr
 x8796XzwQ4tiqhmSyFhC9jojo33T9f2oTrzSWPtDvgbLYPryfUSTs6YvG+JOzXjskc3nrJANygr
 tcgA0bztM+D6sdnrAcflOW8QTcaqkZAj+8TXiIZLfNI+ZEPE2iaX/T9NtWgLQggEEjy/N7DuhuH
 Re8gORT8JlQBVYo327qIA38lmTw6JnFXAoYAB7WSrVw6bY6InzrJ7CqunV+EnzKgZl4daB3UTqe
 lLaGD3mBu3375/WBdFgsgmbCPeROaj1MrJZFarMOe9wFX+XIU/RUaBVR24Pu0qcFmonJBrttwRz
 kH5f4M4VkWAwMDyAcdt/xoKxeuhBXROgWOA0UlROUYP2AJekHFEzVKN6JUhn4faXC5dNqoHO0PC
 LkgDC/8yvrrx15yHwegB9SuqXg10FlGoivKjImXSR3
X-Received: by 2002:a17:90b:2cc5:b0:356:72f3:acb3 with SMTP id
 98e67ed59e1d1-356aadbde25mr1531618a91.36.1770980765026; 
 Fri, 13 Feb 2026 03:06:05 -0800 (PST)
X-Received: by 2002:a17:90b:2cc5:b0:356:72f3:acb3 with SMTP id
 98e67ed59e1d1-356aadbde25mr1531592a91.36.1770980764570; 
 Fri, 13 Feb 2026 03:06:04 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e196a3663sm7943908a12.9.2026.02.13.03.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 03:06:04 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: u-boot@lists.denx.de, sumit.garg@kernel.org, casey.connolly@linaro.org,
 u-boot-qcom@groups.io
Cc: trini@konsulko.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org,
 sjg@chromium.org, michal.simek@amd.com, gabriel.dalimonte@gmail.com,
 jan.kiszka@siemens.com, paul.liu@linaro.org, j-humphreys@ti.com,
 neil.armstrong@linaro.org, me@samcday.com, marek.vasut+renesas@mailbox.org,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Subject: [PATCH v3 2/2] qcom_defconfig: Disable CONFIG_EFI_PSCI_RESET_RUNTIME
Date: Fri, 13 Feb 2026 16:35:27 +0530
Message-Id: <20260213110527.1254098-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260213110527.1254098-1-aswin.murugan@oss.qualcomm.com>
References: <20260213110527.1254098-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA4NSBTYWx0ZWRfX/rMpvw71x+xq
 7pA4IWJLPuvahv9qr65Yb/+eeaBz0gKv46ChSwRmIY9QG47iHW7q1A2F2d5UBnL3dVt7Bg0PDzD
 DV8/qI9XC5c4/4kOFNKTJftOCKx809awRKYZBgtcb2+pfuNGRhc3fKzqAPYZsnB523wp6MDl/T6
 2QpaTWGXWgWej9XjYZHZRw7X4WvCQ0KgQaC8mbi+DNpuPql8wM13pu93KVRP9WTGI7f40hkiEQc
 cyfSAtEigJDAqNrEq15yoOsReUuOO9OqzorA2HlN/YAIxEw9iN/GImbruLL5A4zg7ZYKvdnwyzl
 R9va/Ki+GOSwVw6UIbkG4HABxz9A5OdA267MEZeTeLVQZCx7WjKxqmzXK7Xv/yDdelhUoPS09UJ
 pk1dbT0ygwGg6A3aFxdKYFIJkV6RE3LwPuiMnzpctuIKfYtdUMEg7EBbMoerhs8Wgl6ROAV8VEj
 LGTd3RLwRA2AwhG/8ig==
X-Authority-Analysis: v=2.4 cv=a849NESF c=1 sm=1 tr=0 ts=698f059d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=GMWhSsq5zEkLPb_TLUoA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: J0K7n-ZBKej0APVAgyT-FroEWcfWOCyO
X-Proofpoint-ORIG-GUID: J0K7n-ZBKej0APVAgyT-FroEWcfWOCyO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602130085
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

Disable CONFIG_EFI_PSCI_RESET_RUNTIME in qcom_defconfig to let the kernel
manage reset modes and handle specialized reboot requests correctly.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v3:
- Changed 'CONFIG_EFI_PSCI_RESET_RUNTIME=n' to '# CONFIG_EFI_PSCI_RESET_RUNTIME is not set'

---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index fe5880de1fd..32a37a06df6 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -6,6 +6,7 @@ CONFIG_ARCH_SNAPDRAGON=y
 CONFIG_NR_DRAM_BANKS=24
 CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
 CONFIG_SYS_LOAD_ADDR=0xA0000000
+# CONFIG_EFI_PSCI_RESET_RUNTIME is not set
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
-- 
2.34.1

