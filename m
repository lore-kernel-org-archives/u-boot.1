Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0263EFEC0EC
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 17:59:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73DB8838FA;
	Tue, 24 Mar 2026 18:59:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o0upVMYs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ACi6XHkV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 688EB838FA; Tue, 24 Mar 2026 18:59:49 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3DA880087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 18:59:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OHSc2f409241
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 17:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=/cRcwvBOww6inZ50/AB6gs
 QTaouMEZoE5m8is4Ug1YM=; b=o0upVMYsw5FROM9DpSeqJ5rAPQpuV7kF0I/CQI
 SfkSBooC9KMSqe7Hvwc6Uzgx0omKjDq0PFhWxPPnFxrIhD3Tqm3NOQaSMIlJm4QZ
 VuVn2aAuDKfvR3RzRH7ud20EEuC4dOohbMqO39VQf2Jwh0VLurHtT3Bk4lwVeCO1
 PqTTRSLn4XEdtiM+7eKgt2Uzs6qZsn97uT25TU3gy4+50gk1GV6R675INWeLlt22
 TzIc2E/qbManiJLEFh9krNCbRFOoVnWIhQSMHuNR7ElCsGwCtPA7NnbPuY1AhsgH
 VeqKJjsfJ/tmpTe82cBoA2cGwazwiCQa1YkleWugepjImLGg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3nextpv8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 17:59:43 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c7414516609so975855a12.3
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 10:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774375183; x=1774979983; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/cRcwvBOww6inZ50/AB6gsQTaouMEZoE5m8is4Ug1YM=;
 b=ACi6XHkVd2oaA6fUgEkbx8+9FjYZAsqrepYzC2AZjnGu6pk34XHOCdypUhNmlmNjO2
 sYI866NS1xmn33JePS8KhgCP3TMHYPRUbBQHVbebvvaRhi8VhOEEOpr6h3x3BBID4OdL
 CCzr54PxV9DKaMmG0hc+Mi2nrXRccdG36p6aIApro2Y2ffBA25kG1SVQriq8i3CehZF1
 p/xjLfPg3ZKTao/qlC0qdmG7K6NJB8FBJJ3YKIG+KpIYquxyNPN2mIUa/+iqqXkMz7VX
 PWUNPgqkYSNAb/uwOyz9fCn5OM/7lVGbsnmABMEifS6aDNvlZEr7kICKirGqQbHfEOoS
 zs0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774375183; x=1774979983;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/cRcwvBOww6inZ50/AB6gsQTaouMEZoE5m8is4Ug1YM=;
 b=riKukGitkC/YSzVdduxUefozOwDmDDmFzudqrkOKMH30XkyqqSON/jTJdfIyVlx2q4
 fIOyJRhp6rIekDZbSsDQO8yQy1aKrzdjWcWY0LfjLGSmHAG3gXVaw3Z9XqXC/CorcFLa
 kLduMX7WrkSuZxFyH//RxofZuT9T/UBktbhroD+oKM0t6dLhqYnJ8nkDclWwjfdyQqRE
 qsgA9b/ZiUiWyLO6LH6TlLhtIjO6RT3c1D/EJ05GbQcQDEnTbPiJgMQWrvQEA0+y5OH1
 hlyzwHDiMQ1Wre7QMeejg2qmY4htXzOsMkJmWmEGGF4rgjC8LgR3nVBg4u1lmHnpWBrK
 n35A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLHVkJmcw/NGdyW7Z9rUmI1FnlpN16gv+zka4TCoFxFXhJ9Bkeb5/82rXuvUt5WHBp0xXhon4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6Y82vPq0bKOxM/1sprXN1gumsEtKjWVE3eI8Hth4pIO6G1UF2
 /7kfbw8uoMoAP88OvlVyickr6e5Uo2/O0NJxGulIQvL5Lbe0bhTEVQENUjfmfzBBDu1sGXSZ7k/
 k3zut3LKfHMWhkpV5+28kD5Xfn/Rfzft/jgOH/ugcfxclnyti7S0USk7S
X-Gm-Gg: ATEYQzwnySgAcyL+AMerucpl/5FEvG0IqinoNUM1WoTM+fK09NaHLtVRXOEPE4T59Vc
 tfhxmYt4TUmhQuWyMXkEjQw6+ABLyhiHdmknwXDd8WqWulF/MbHtF2q6l7v22kvHlmfV0dH4nY+
 InWub0wnG0hE3owmR5rjAnR4wMnELeQGUmdJR1L9sgJT+ln2kaylSssYV510cJoXZVyRr8wkiSq
 gro9RZ+yCcI/O4I2GrLWnlApmy3c75IXtKHoHCfd6ONiI5ngyUkAIMS5T3tjAJAq798MJ30Dhb6
 gwg3HHrP0sJDygn4LMni+ynD64scxF/EUvKJo05gFbYtmJ4PsudNyQNG/MbfPf00mbRUFkF5VFE
 Lnwoku5AvrWc4ZPmvmjjrJcmHL2nGyL8BzhIzWHQDIvaIxcRte26mn8EpdgQG8/y8LzgV19rkKt
 ShIPiV62261LmBx/YdpzFMnj+8qoLS+KE=
X-Received: by 2002:a05:6a21:6da6:b0:38e:9220:ebbe with SMTP id
 adf61e73a8af0-39c4ab57c1fmr689969637.23.1774375182505; 
 Tue, 24 Mar 2026 10:59:42 -0700 (PDT)
X-Received: by 2002:a05:6a21:6da6:b0:38e:9220:ebbe with SMTP id
 adf61e73a8af0-39c4ab57c1fmr689945637.23.1774375182000; 
 Tue, 24 Mar 2026 10:59:42 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c212ac8a2sm15503901b3a.17.2026.03.24.10.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 10:59:41 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Google-Original-From: Aswin Murugan <aswinm@qti.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, aswin.murugan@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 sjg@chromium.org, mkorpershoek@kernel.org, jan.kiszka@siemens.com,
 paul.liu@linaro.org, j-humphreys@ti.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v4 0/2] qcom: EFI PSCI runtime reset handling and config update
Date: Tue, 24 Mar 2026 23:29:11 +0530
Message-Id: <20260324175913.92858-1-aswinm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzOSBTYWx0ZWRfXwxdSfNmMGhcv
 P5Qp/7LnmfsXzO0Uz75eh14GPXm5aG0j1znJcnRHqLw4V1yKDUXhSzC4vy56Z1NNB093u9PPTlM
 VIXtpMFqejdbcyMYoE6b48BdH6Zag+h4OJjLE+EXd2ei/7fa1EObfEzp0RAMc8VCWw0JvUViTZb
 rHGM7vR/5IaJAFQnnLMNUwKmrOpJ8aP1zi7nehwsNDAW5/40Va5+kbZpwgSfwzFpVfbpLIefEGd
 i0rPjD9hRPjXZF6P4KbdOGNvXQSS0pkNkz9G/85N1LUoAwD1xGNoTUEF8s7EiLwqioSQ/biPSbR
 Lo+APENB60Y12MpIU2zXs1lTBQMjbEb1TWnaMYhXKGYONVZslJbdQIR31gyS2jnrQUgI9ukAZT+
 I/7CVoR1X/pohVS2ni4t/AoSlRnIMjxll7BawP8JakSNVy4qKqReNAm5R+3apr44pcP7pd1Pd9i
 OFvkoV2JDga1lsYNADg==
X-Proofpoint-GUID: jcwKPc_Hnhvwo5sxGAostVjlYrjDwNtm
X-Proofpoint-ORIG-GUID: jcwKPc_Hnhvwo5sxGAostVjlYrjDwNtm
X-Authority-Analysis: v=2.4 cv=Bd/VE7t2 c=1 sm=1 tr=0 ts=69c2d10f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=0tKm7Dcz37VmyEHRsAgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240139
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

From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

With CONFIG_PSCI_RESET enabled, EFI runtime resets always use PSCI, but since
it cannot pass the arguments needed for special reboot modes, requests like
bootloader or EDL fall back to a normal reboot.

This version updates the earlier series that introduced configuration control
over EFI PSCI-based runtime reset handling.

During review [1], it was pointed out that modifying only the Kconfig option
was incomplete, as the EFI runtime configuration table in
lib/efi_loader/efi_runtime.c also needs to be updated to reflect whether
runtime reset support is enabled.

Additionally, the reviewer suggested that instead of introducing a new
EFI_PSCI_RESET_RUNTIME option, we should reuse the existing
EFI_HAVE_RUNTIME_RESET knob, making it user-configurable so platforms can
opt out when the kernel must retain full control of specialized reboot
modes.

This version implements that feedback:

1. EFI_HAVE_RUNTIME_RESET is now a proper Kconfig configurable option
   This allows individual platforms, such as Qualcomm boards, to 
   explicitly disable U-Boot’s EFI runtime reset callbacks when required.

2. The Qualcomm defconfig disables EFI_HAVE_RUNTIME_RESET so that the
   kernel can manage advanced reboot flows (EDL, bootloader entry, etc.)
   without U-Boot overriding those reset modes through EFI runtime
   services.

3. The EFI runtime table is updated accordingly to conditionally
   advertise reset support only when EFI_HAVE_RUNTIME_RESET is enabled.

These changes maintain existing default behavior for platforms that rely
on U-Boot’s EFI reset services, while enabling platforms with more
complex reboot semantics to opt out cleanly.

[1] https://lore.kernel.org/all/CAC_iWjKZXsE86J_wJ=JTE0TGL=MqGm8YRYsq4BrkU2ba3me6OQ@mail.gmail.com/

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
Changes in v4:
- Made EFI_HAVE_RUNTIME_RESET user configurable & used it to disable U-Boot’s EFI runtime reset
  for qualcomm platforms
- Link to v3: https://lore.kernel.org/all/20260213110527.1254098-1-aswin.murugan@oss.qualcomm.com/

Changes in v3:
- Updated the commit message
- Changed 'CONFIG_EFI_PSCI_RESET_RUNTIME=n' to '# CONFIG_EFI_PSCI_RESET_RUNTIME is not set'
- Link to v2: https://lore.kernel.org/all/20260114111624.2321852-1-aswin.murugan@oss.qualcomm.com/

Changes in v2:
- As per review comments made default y for EFI_PSCI_RESET_RUNTIME config
- Disabled the EFI_PSCI_RESET_RUNTIME config for qualcomm platforms
- Link to v1: https://lore.kernel.org/all/20260108105146.1285450-1-aswin.murugan@oss.qualcomm.com/
---
Aswin Murugan (2):
  efi_loader: make EFI_HAVE_RUNTIME_RESET a user-selectable option
  qcom_defconfig: Disable EFI_HAVE_RUNTIME_RESET in qcom_defconfig

 configs/qcom_defconfig | 1 +
 lib/efi_loader/Kconfig | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1

