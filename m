Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF97D0C84A
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 10:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AFB183956;
	Tue, 13 Jan 2026 11:39:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="g8tBrDmo";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Whw1LCcZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2B3083942; Tue, 13 Jan 2026 11:39:12 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93A1583923
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 11:39:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60D79MFL175988
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+w1YqDZvkgp
 7MeOoKbWpSzU1NflY4mfjiNxVJ9Kv3XI=; b=g8tBrDmoElKFMl57wYBvdcyF+W7
 HFbaZf4bn5XL6ZUChyqBR0OTD5/ID12V7U3fApaUW9r4jFoj7E4GxDRD60YwkIx8
 B02i0YaTZWwvMsiR58+fx2Tdi53yUYSQOAkTJ/73FJZnREW7txuW4Y0FNUVf4haH
 Thj8V21DShb0oN6M5GKG4m4NqIeIkuzuMUKubVAzc39nWJbj1M4WaWy4ipMhx1lr
 yJNU/7K8ogMzZtG0XIv/TTuoSjBmCC+2TVgJ9OIw5NMrkBOUs1xIjFMKXt38COx0
 YCMHkJH83HD9h0kY1ut+D1K4wfZTJqtSr4PnkxRq8kymnJgeQ3/8qjeHJyA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn52f2vca-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:39:08 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2a0f47c0e60so38736485ad.3
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 02:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1768300748; x=1768905548; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+w1YqDZvkgp7MeOoKbWpSzU1NflY4mfjiNxVJ9Kv3XI=;
 b=Whw1LCcZSXHBVx1TTA8o6hI3QRpdaMEhwqZ7RsrD1h63Em4gX0DSSBjEE3ME5skYPI
 FYUxGDoHUywWbrdCUvR2IvbwkIzvuDHoLA0WYNAhkkul3KqhXtQ4VQIhjEKT/2v/uwRS
 PmKH95U0dKwJVrfYiTTV6RPZvFKMyfJETjtn1lf1T/VySKmUIwfceWToTDSfqxIkGt7+
 K7Qj7WDT6A83uIgoguX1GbJvR891YWUEzKJuVj+GQ7ozWuea1s3s3tby3oKaZY7+7/cw
 F+dKUfleZLkEN1RV351w0ZCyCG6aHcOI4doeZCWzDpEp5NawHVDUa3MJFCqsPYY59/QF
 zRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768300748; x=1768905548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+w1YqDZvkgp7MeOoKbWpSzU1NflY4mfjiNxVJ9Kv3XI=;
 b=rkAm5AMgdg5Umf2u0TdPBLbjSirM83DXwLcLXL48XjGtxakPRHKoSoATg5w/ctnGkx
 ow27zhizTOeNrr3DjGaU8kWsMrT9Vs8HLb+3WjdBtqDUcQs3GsVVz8DaaoNvhX9BmJz2
 qU61CK21en/bh03irSDpIDi2w2sf0uhYcdH9xgWGHP2LSOTKUmMgidDoKN3B6d418urN
 FroVdhCfsrlMyIQygrjRPHcmNTTxMiskpGX4SHcwbp4u8lLLqZwukt7Oitui+omsatbL
 gnrNMC80Odgp2sgJDoBklgxD5QNB2Fl2t5YUH9roYjXFYtHamBv+dlaJOcSfxN6J/k+v
 nhNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTKPLs1z0n23jz/EUb5Kb7by0lFYTmhhI7ILXBT1+tZk4LJry+VPYpopacDAocK1U2UDU3oJc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywz2CIolHkcwfvEAm7aPdmb2PS9j221xrqYfkN7mhb6eYvtW9SD
 neSj+UkofDfPcVrxXHnLFw2orxdpTQvLNoY62BnVD9UgHWEHhY/xmY6tTZtZf+dKaUIB2KTQNpa
 23otTjFTaGqLmOHhPnunjcZE7d/dSo3aJOBCKa8qFXXTFvt0M4kkjdTv0
X-Gm-Gg: AY/fxX7qt2nbYCf/SQUQCyw+27bnXeDK2VXuuqf1aQVJKf7c6afgVzn6/wz+uSaucbs
 9CZulQtru+xfr4RkWl8nAuCBlR0Vx3aLcoxsYqKYvPAp0E/qiGIP5CpDpF4zDHqn9sP6uPadXws
 +wKxSIUvCbWEXbnGDgMQJSJUBHpMh9M9qadwMUikRyBb7UW09l1gCkVFLC8jgjLhbMStMiYUlOR
 ExN6CrqXB54TJ47YmDsCGFZouA9QzL/+JFsZLTH4qoavyroI4q4zwX6S0zOw4Rkhoj881PGg1dB
 WepMVcsbJ94O0+86J1jEm0FAQbRzQYxDlUzTWRRk3lws15ZXUnyoWk+E1zmgiVUtdqpw+uIABiD
 aYI7O2M+2ktnQUFVKRbjIuFGVaTk8eOZUM0ldWCjSV5O5khBzGiS39rs7k6z42hHxdcz6vmUuso
 4opJFSOFsCt4H/qhq8/dOAxNXIDalZ57yfivJQhWE=
X-Received: by 2002:a17:902:ccc7:b0:2a0:cb8d:2ed8 with SMTP id
 d9443c01a7336-2a3ee48ac1cmr200181395ad.30.1768300747681; 
 Tue, 13 Jan 2026 02:39:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhuJmd1FENIYUmuK1M/mtWaGdBfKYX+Ccv7zbdflgFEHy0jp+0phHpGqaABG5khFKclEwEJA==
X-Received: by 2002:a17:902:ccc7:b0:2a0:cb8d:2ed8 with SMTP id
 d9443c01a7336-2a3ee48ac1cmr200181085ad.30.1768300747199; 
 Tue, 13 Jan 2026 02:39:07 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2dd4sm195286965ad.47.2026.01.13.02.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 02:39:06 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 ilias.apalodimas@linaro.org, jerome@forissier.org,
 marek.vasut+renesas@mailbox.org, christopher.obbard@linaro.org,
 me@samcday.com, michal.simek@amd.com, clamor95@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v5 5/5] qcom_defconfig: enable psci based sysreset
Date: Tue, 13 Jan 2026 16:08:40 +0530
Message-Id: <20260113103840.1948029-6-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113103840.1948029-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260113103840.1948029-1-varadarajan.narayanan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA5MCBTYWx0ZWRfX/nUxbilgetP9
 A2qFPLy2URUibbd/jnIX71RhOKl0idjHNBChUbr0hP+1adJS5cRK+XXGTLwC3Bu/Z85ow22Aeyt
 nzrjYac5D8ZFfaZFGsGCYTUlhAt27USxVECekdTv+x8U7Ael6JrxpjHdiyq5LLLHtSZSiThE/Im
 2MK2TqrtCxSw7064CykeYu4g8kV006JCmKNyvRUSG6+A0ac5XG3cnnk49Jv44Kgf8d4qGbkE5gU
 utG8BJxZDjBSXnLrPH4mRCQGZ+2HKBkCQ4pgGbQ8mqlRWyE1m5d/wACjiGL5MQrZeLa6t9jSn77
 usiCa9x47QypfOLFoiAxLN9vwv8bpzoZZVnCIKSpRr+g5/ubqL3fkLElWBoyEMe2zd5jX09rzAM
 E12qGzYEyiMH93kE+T7w/GHR9MNUG1Obr1nj0N07frajICwxqABa0Al1CKLCweI41TnGQIG/TO/
 KMCgQXDHepdR+9dhKHw==
X-Authority-Analysis: v=2.4 cv=TcCbdBQh c=1 sm=1 tr=0 ts=696620cc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=Ev5RKtEX-19Q_cV2JMcA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: PYZde-g0pYX_8IyWqea_MsQ9wu-mPn45
X-Proofpoint-ORIG-GUID: PYZde-g0pYX_8IyWqea_MsQ9wu-mPn45
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601130090
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

Enable CONFIG_SYSRESET_QCOM_PSCI to allow U-Boot to reset to Emergency
Download mode.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v5: Moved from qcs9100_defconfig to qcom_defconfig
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index a210f4dc5e6..75b4f39c590 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -147,6 +147,7 @@ CONFIG_SPMI_MSM=y
 CONFIG_SYSINFO=y
 CONFIG_SYSINFO_SMBIOS=y
 CONFIG_SYSRESET_QCOM_PSHOLD=y
+CONFIG_SYSRESET_QCOM_PSCI=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_XHCI_DWC3=y
-- 
2.34.1

