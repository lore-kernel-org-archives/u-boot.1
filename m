Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBF1C5AD55
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 05:20:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 823F280F7F;
	Tue, 11 Aug 2026 05:20:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ral5fb_swAiY; Tue, 11 Aug 2026 05:20:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 081A880F6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786425601;
	bh=jzDOFHbZYE7662E8vHVPyDi7xs9x3ayPl+lvPAFTrJA=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=T+Lu9PoRZ9lWt3TXdcXb7dt2E5cXvJiPJJv97fPG3mKaPpLiG9KpFPXhD5/VIdhsQ
	 dujdnkCEflwkM+Of3bCrM7fSL6w16H+hj04x8iRbl4fX7N4GcR1GvJ/xrBi/tikzMS
	 lhwe9tNwYnyN3WGf69uENzoAqcBrDg6udh9ggFuwad3xBaEIBPIdDd8DTl2yWbp9PI
	 DZ48Z/8ZMvw4zgbhsZvFtS23ed6xaiipgZtPCs0pyVyuiAR6iMU4MhomGFxXvjGpVC
	 mCWjHeXxtThEHixCXgHbhOGSb4V3KgRXzMycIGD31vQHj3HDku9oxEjgvR/BbXdEUi
	 fV+EROrYFeBDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 081A880F6D;
	Tue, 11 Aug 2026 05:20:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C503F345
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB94B4005F
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cPRFolfE8Cgd for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 05:19:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 906C640050
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 906C640050
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 906C640050
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:58 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AMqNJO2937779
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:57 GMT
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyjjv2e84-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 05:19:57 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cf6acd760cso34464355ad.3
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786425596; x=1787030396;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jzDOFHbZYE7662E8vHVPyDi7xs9x3ayPl+lvPAFTrJA=;
 b=lGbThUuZtFOkBNtSDFgNVqOx72RHvSUcpIh+mUbDnukv+6Lyh6D7vk2jHADkU0FsrZ
 rF7VN/hW4wiIwo0+LDuykEn0m7l0xaRLJXCKtw8aIxNmA85XU5Zxj0jgPfMDilhGeqIv
 T61BMVBncQH/1UEoOe31ZL9M2mhCvSvWRk1teyvCVdqON+TrYNJUaQYpRlMFcNIDVA1s
 /VAM7ObgD25kziEBW38aMmM/EHkmPaeedw6Z5VF6FuOdqgejEfnoUpxEQrkuPZz4cT8M
 hdZGCa4p7iGx/T6V6Y4kOjAYDfwz1CW75NN2mINdUGMfATCGBmDgl8RSYL7UGqEn9wMI
 HzoQ==
X-Gm-Message-State: AOJu0YxpFxut/VSh0v+X9r63K+iSoGJ2Pic+ngkX6ElEdlgSBw0tu5Wc
 NnuKrHop8jDXrKH+S1wJACoXujpEMCY6+SGEN4xH/VHksru6OyNqqDICdQj/oxEk6mQOrPW9QO9
 20OKtnD5rx6U3en6RTwOYAe60VQsDnDu4nx+aJKqN9TU+GXXRYn+xpt2NWlWat9FQo9GV7TI=
X-Gm-Gg: AR+sD13HHPL2hDmc0DKo5v4T/a/uoOsrGk7q6Y4XaZHa95vTPaOzNUcb/BIZT5djKVk
 i7W73FfTTPhOgszeGLn2F/A1SU7zfHFru6cT7kim15ngxXla0q3mOQaguNAL8FKJrn8U3ZEfBS/
 FZDwkPHe+Jza/2yJEr82zi5nzR769KWQaomEqGfzRVWpIE2YgYyzkKIXNHWD/RUopO68/W7IFAK
 P78WOVfV0JY19bZlgi5Ptl29+bVwzbDLHd6EFdWQ4lI4bw4nHUjzQxnuttBMV+UHc16KViNWMLh
 kRCWJpUhzUfGqx24tyil9xezsKpYQo6xJH9oPj9fJ609YBQsigej0Bhj0K4OrtNX1EzUUjRh1ie
 W25ugRJNny+21Pp2WzYEgyvJqicpm49ydjk0Ews+E8qjvQd9MG+3qQdaBAVjfOEdxM4VGLpi+Db
 oOXKvN0fQk8p5+8BAMz+EZzxrLrVHY
X-Received: by 2002:a05:6a21:4a98:b0:3c3:a9e1:a819 with SMTP id
 adf61e73a8af0-3cc2bb05982mr1433379637.24.1786425596090; 
 Mon, 10 Aug 2026 22:19:56 -0700 (PDT)
X-Received: by 2002:a05:6a21:4a98:b0:3c3:a9e1:a819 with SMTP id
 adf61e73a8af0-3cc2bb05982mr1433318637.24.1786425595677; 
 Mon, 10 Aug 2026 22:19:55 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31c619d01f8sm1353804eec.2.2026.08.10.22.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 22:19:55 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:48:43 +0530
Subject: [PATCH 8/8] doc: usage: reset: document device-tree-driven reset modes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-b4-reset-edl-rebootmode-v1-8-2e15adc156a3@oss.qualcomm.com>
References: <20260811-b4-reset-edl-rebootmode-v1-0-2e15adc156a3@oss.qualcomm.com>
In-Reply-To: <20260811-b4-reset-edl-rebootmode-v1-0-2e15adc156a3@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786425541; l=2505;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=tuEC4IEWAjd3158/SkHXuLmkWc05O6Bl3uGfo+1hzfg=;
 b=ZQEBq3Q7oiChvtz2H3L0X+yDgHt/1vN/lVGOlZgvAOXCx+jR5o4h8U3zsD+PdKWUaLgkGWzS/
 G8tJFp/wn0vDISlIZHrrkzPXxeuU7Pp9z40JEMdApebLpTOEZJ/iJ+u
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA0MiBTYWx0ZWRfX4bua6qlHvXmI
 +puunilc7DsHfvs9AJGwFaHMsRoaaG+Xh//xcyr7EtL6MhYH1iZYl3qztZwPfRv3yto/CrW0xpd
 aPOBQ6Iwba3NlhKprcwM6TQYktwxGUN+0IVXBaCmYzV1Keg/lkN9GWGyycHk1dGXQ7UM7jmTi2V
 S5C4yx6UdSKP5UsXVlBN7ZxxFr3LyKVWGTK2R0HmKhv2URknH82CqBXn8ZIxvgzroLVVCp7lIi6
 RpKNzpYzAKf5U2G1P57oWWuLwAweF4sFx9LwpG78/czdVVBUjbf6mAFYZcXk+dndJ0vBPlqzLf0
 KbQSYdA0pR2zDd8pk288SJj/+0TUj6RpWyXCPvDwK3DqRm50uH2FqU3DI1LsF1BaRT94Jz5JU9N
 zIU6hHyfaOrZ/myE6LadkIY33FAECldP7FohdE0OfAob01jFMz5BugngwhCC0KVq8ZWV9WU4WTe
 /B/hT2JrBvYBBq6fqeg==
X-Proofpoint-ORIG-GUID: U4jEnWMyyuqvmBoQe5qc5VtyA9qhrXLx
X-Authority-Analysis: v=2.4 cv=KLtqylFo c=1 sm=1 tr=0 ts=6a7ab0fd cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=icUjp4So_0wrBNXIkk4A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: U4jEnWMyyuqvmBoQe5qc5VtyA9qhrXLx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA0MiBTYWx0ZWRfXy3Yf6pqFBM3M
 2iayW13sOGHARAy9yQWuFEhsDgM97AGDGuveYJ5vyCMN2lRQLtqbE4IPadOJkZigeR2KEjOGYFg
 CzONs6+Q+n3Srpwd72o0YYlxMrFEyeg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110042
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jzDOFHbZYE7662E8vHVPyDi7xs9x3ayPl+lvPAFTrJA=; b=MG2CUymwM1SI7dj5
 e/w7SIKJUDxJeEXh/RVNW4nJoSg4izdq/fmdjn/y9lsir1oIMXE3nJkRG+5DfRGJ
 +IMb1a2WmMr5F3DegnEjy/j6pLYk4zYtSHdXVwab9KGs8m6q/RNM/uPqbSg9JFWm
 OGcPaO7r7PrufaCq+7Nsvh7kkuj1dQ4DR02zRgP18cQ+zhG+FF8nuUJ3r7lPBnJD
 H8nZMKEJJW0lxlNzWN3D0v+xrzACHRhWNZoOAPOpJy+D+H3o4+pTw0RppCPKUgow
 yrQdsWXLVEg/1CjuY/Mi5vuvpiI8asm87KvqFjaHgTk4wys+06pgsu2gqjt1z+lM
 jyh6TQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786425596; x=1787030396;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jzDOFHbZYE7662E8vHVPyDi7xs9x3ayPl+lvPAFTrJA=;
 b=T2meLrhT97rkG9HF5hQPgOoJCL1IPEvZw9XOMMFSzScdKyMCxu65rcN7yq8rFeACdP
 jY+PGfAphK4YJmzhj36Ubx876HQdCGYyRI2YuH2wIHo3BOnl6JFtuVV205210RpNdt1Q
 xk99ZqcuzZQNZyoaMOsB4O5CE3vkv+n0G9qWdYPb9W58wBLTCwcv2iSRGR1jdreqPzgE
 UQK30tq+OZsZE9+SfT5oPfQUGZhWyFdJexOAWasyYWdfme562TtpEfUo2H4ewZLEbM25
 wX8pQVMrumafFm7jL47Q72wb17b1ypIziOX0WCfymDBuaTDlIouDRain08MaPrVDVJ5b
 toVg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=MG2CUymw; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=T2meLrhT
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Balaji Selvanathan via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Document the "reset -<mode>" and "reset -l" forms and explain that named
reset modes are declared in the device tree (a "reboot-mode" subnode of the
psci node) rather than hardcoded per SoC. Describe the 1-to-3 cell
mode-<name> encoding and note that U-Boot's 32-bit PSCI cookie means a
3-cell mode with a non-zero cookie_hi is rejected rather than truncated.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 doc/usage/cmd/reset.rst | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/doc/usage/cmd/reset.rst b/doc/usage/cmd/reset.rst
index 78c9c8873bc..ffd2069c0f1 100644
--- a/doc/usage/cmd/reset.rst
+++ b/doc/usage/cmd/reset.rst
@@ -12,6 +12,8 @@ Synopsis
 ::
 
     reset [-w]
+    reset -<mode>
+    reset -l
 
 Description
 -----------
@@ -22,6 +24,46 @@ DDR and peripherals, on some boards also resets external PMIC.
 -w
     Do WARM reset: reset CPU but keep peripheral/DDR/PMIC active.
 
+-<mode>
+    Reset into a named mode registered with the reboot-mode framework, for
+    example ``reset -edl`` to enter Qualcomm EDL/download mode. The modes are
+    described in the device tree, not hardcoded per SoC (see below); an
+    unknown mode prints the list of available modes.
+
+-l
+    List the reset modes registered with the reboot-mode framework.
+
+Reset modes
+-----------
+
+Named reset modes are declared in the device tree rather than compiled into a
+driver. For PSCI-based systems they live in a ``reboot-mode`` subnode of the
+``psci`` node, one ``mode-<name>`` property per mode:
+
+.. code-block:: dts
+
+    psci {
+        compatible = "arm,psci-1.0";
+        method = "smc";
+
+        reboot-mode {
+            mode-edl = <0x80000000 0x00000001>;
+        };
+    };
+
+Each ``mode-<name>`` property carries 1 to 3 cells describing a PSCI
+``SYSTEM_RESET2`` vendor reset: ``<reset_type[, cookie_hi[, cookie_lo]]>``.
+``reset_type`` must have bit 31 set (the vendor-reset bit). With two cells the
+second is the cookie; with three cells the second is the high half and the
+third the low half of a 64-bit cookie.
+
+.. note::
+
+   U-Boot's PSCI client passes only a 32-bit cookie to firmware, so a 3-cell
+   mode whose ``cookie_hi`` is non-zero is rejected rather than silently
+   truncated. Every current vendor reset (for example EDL, cookie = 1) fits in
+   one or two cells.
+
 
 Return value
 ------------

-- 
2.34.1

