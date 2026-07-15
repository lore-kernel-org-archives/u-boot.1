Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EBEC44508
	for <u-boot@archiver.kernel.org>; Wed, 15 Jul 2026 15:28:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5715D84B52;
	Wed, 15 Jul 2026 17:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sz+Em+jz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WW/zj8cQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1144F84B88; Wed, 15 Jul 2026 17:28:30 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB1A384B49
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 17:28:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FE3Wh94097304
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 15:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=FF8gXS2OhF41neG9ZV81WM
 UdJLjP6Oyz1TTVfiq5IsI=; b=Sz+Em+jzQahvlUsXkyBIn9qJwUkB1BQgR3t+GC
 7lassIGcs+iEQzaedq4MgywTTeAk+XAaMnsK/pS+NHGFLrKslU3sy5C/WBAT/sGH
 UgqHyyQM3ae3ZX5L0BQCvv0mvZlR5cE02DqEVl6A2qfhzTeIRLiWO/Hcq8Nl5bQI
 0Qw4NUBuFhwE14AUHQWBwOVWdvtJOQ6q0BI1UoWCvuGtjor3Fu6OD3x5ipi3Ltu6
 9YGwutz5lcUNLoyWqIHqUgxTioc+A4g0SMjfjSx8sE3QBbcTdR68fxUZ2IOcy0mK
 kDyoMFo6yz9HWgMzLYtb86m71qJOXZUjywoVMdiKRX2KvZfA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe8559b5g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 15:28:25 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cc73f47bdcso99255245ad.3
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 08:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784129305; x=1784734105; darn=lists.denx.de; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FF8gXS2OhF41neG9ZV81WMUdJLjP6Oyz1TTVfiq5IsI=;
 b=WW/zj8cQfPXh8nBCg3T2ANk0IoTIJ3ezB3BVzwxa02nX4cwkf5iO8sw3Z0hbWwllcc
 Lh62Le4PYjPVZo2Uy5923HANegxhKsGWmXN0mHpR1SaX/vMwaCKgNAZEWVE8UtETHmWp
 KAhW95LoC/PRECmeClBVsDxsNCwB+l8grBeRzdbJAPIqUVsooih1v8+bj1TR7BlXpZ9a
 LAhUDRyumxFrhnNHh+0wnuDQ4QtaB66EgSZWBw4msohjfuvzr0+QH9w44a8B1RXXlL7u
 r+7I4LGhC8sEg6IQrJMZLzbXk6Gli+p9Od7xAIXON5+QNKjatkSlPr53IzvM0WlKrusq
 fS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784129305; x=1784734105;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FF8gXS2OhF41neG9ZV81WMUdJLjP6Oyz1TTVfiq5IsI=;
 b=sZXKd6nWqvRH5W5EbChx2TqcTwcul8fEKdIJJzn4OpP1vv28KnQULceyaqnQc6r5A2
 Qm2RBPKxk5DLiumXf6jXRtQh8+KdDGYSRJ2dLSs6ZxRSeYf4HambGJ+LQhpMxLy622a1
 MO1lZ4mvnfsYzph3cn+f71N/fgoSdSRrqtDoB/voZS89w8xO+eucnMvo/sTU3t35n9WA
 ni79pc7P6WBrqX/etQb4STTtjg3e0CTc66MVjJVhFuZ8Ndk/mqZedWpV4nvWFGw4lDjB
 wSxUMocY208p7kMcZha7XnI+DuCXQzn85Jhgtq0JppJQc0T1W69lk9GETbxZiuQC63r2
 3S5A==
X-Gm-Message-State: AOJu0YxUHFtJUM8gbcvYH0mtx3IEvSaEsEADInuno1k5WDalkAcuA3gk
 krA44F0IlIFPXtMWYJyiJk33ZnGoRQv29YjoX7wspMAZz8aKCthy7YB3pUUvTq70T8cViZod7LX
 md8ZFWzwdSGgcoO6TZq6TXOeMq2XBylWaz/hJ6Z1H5EZMC1uvdHnOJzdW5tIV9JT3
X-Gm-Gg: AfdE7cl6dQVax4woDztaHlu2DYeT8Cs1hdk6ipd+E25KWsAdbTQsW8Bglsw4bMrdQPn
 +eKPs7i7wnYu7uKPSI2GvvOXa4ccE7z+g6QzU0y1HIz/C1W/eCTLjVjoL+tAFcW15YT+ZA+Vt04
 w5kkJEHQAF4pDFkIwdVUfgG2nueKRhEPEnV2aTJpf86zi5j+C4qXCql5e7xiEt3Btn/JP4uu3t6
 sv3xdMOwkEw0dyEappQ1zGo8sbz5Nn1yacQ1Xgbabth7ktNWZ1C9VfTTyJj0EWXCLlA5mwMQbr2
 ylDj8Pv6umvYw05DZjHgwgJhHYg4Cs2Qg16U1Gnfd/hlJ9wBDyYQJRNMo+mAc69jlbitwsJyNaY
 yaGI8dmIYxr04GNzkiKESzysqr7jnayEyjrqi99KOYtzj1hk5rKvuyH5TGIlH8Jl/NCKrhOsMnG
 tOpcptzsO8zBdLD8K1HjFY/HwJijz05kDbQlKWKNI=
X-Received: by 2002:a17:90b:2fcb:b0:38e:e9b:ffa4 with SMTP id
 98e67ed59e1d1-38e1add8ae3mr6151192a91.6.1784129305284; 
 Wed, 15 Jul 2026 08:28:25 -0700 (PDT)
X-Received: by 2002:a17:90b:2fcb:b0:38e:e9b:ffa4 with SMTP id
 98e67ed59e1d1-38e1add8ae3mr6151164a91.6.1784129304720; 
 Wed, 15 Jul 2026 08:28:24 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e6e9cd8sm2278094eec.27.2026.07.15.08.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 08:28:24 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 20:58:11 +0530
Subject: [PATCH] configs: qualcomm: Add verified boot config fragment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-verified-v1-1-8cda869cbede@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAqnV2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0NT3TKg+rTM1BTd1BRzc9NUI/PkJEtDJaDygqLUtMwKsFHRsbW1AP5
 Ok8JaAAAA
X-Change-ID: 20260715-verified-ed775e27cb91
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784129302; l=945;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=jaAxaHPzT0hHwTvpl+BhZm5R6WZj3HkEK0WodFJczio=;
 b=ljLtQeue4xSeUHTy5lFRaLWhlUcFs9w/4cNWk8eIqQJ9DdM4cBvnHczO+NHmZ8PsQ63Xro5Pp
 7kN58AJ3mKiDlyf+0klVqjGxjfMFXyvXavydmJG+eifLnUhpUmOmO3e
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: gqdqWRW2QiXk-6P-mjxi8dUK0GAlh9Ja
X-Authority-Analysis: v=2.4 cv=KOlqylFo c=1 sm=1 tr=0 ts=6a57a719 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=wIccDC1-F7bu2At-tl8A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE1NCBTYWx0ZWRfX65ln5rAIDsKh
 EN2MWzrm0UgKuH6HBTDKBvrde25R30tCgGEFLit94HVkxf2/q+6vg1q9oF/GepppgwZBV/fRKaw
 JDb1NsaU8Ayoy0cA90qYWsdb8KWizdv8R1MI2uE67cICd7gjJpDC4s24UjMFIZottmTj3J/if3d
 9E24u2VCWxMI1IJgtUEJC0wjkEDwYzbs+z1bf+N04urmBavib9zew4S0iiClV/TNy7Jb3IA7uzL
 lISfbTXOBffaSKJ+4oFtAOIeNjS7iGrHU/J5HfjAVgPXGKh/t5H4qc7WOjtPaqzpqqeGMQUwmTP
 WHjIzijFzp6fpx76LfxOiXc+T9M62sn5degNN84ZHb8Cc3EQKjPXKQKbR+H74UOWD+MfpvEznGp
 TZlANS35056RmI5X89aGvNoB9mXyyvwp5O1AVTHEllLjoAFiR8eemGQXZmEVhIRVO9QmyOkITrL
 w/G/xVridv+8nrj9cCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE1NCBTYWx0ZWRfX0zv32MGkCCBP
 s3btGD75fy2bkraKu2bgXj3VUxHOteHY9eNVjRSab/od2wfdTujZUS+HBzUPciKHOAAuVbFQKMb
 hUrtFMJQPEY3hCidds7SHNcl5JiTevM=
X-Proofpoint-ORIG-GUID: gqdqWRW2QiXk-6P-mjxi8dUK0GAlh9Ja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150154
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

Add a common configuration fragment enabling RSA-based FIT image
signature verification and the required hash algorithms, for reuse
across Qualcomm boards that verify a signed kernel FIT image
(kernel + DTB + initramfs) as part of verified boot.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_verified_boot.config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/qcom_verified_boot.config b/configs/qcom_verified_boot.config
new file mode 100644
index 00000000000..8aff098944c
--- /dev/null
+++ b/configs/qcom_verified_boot.config
@@ -0,0 +1,6 @@
+# Enables Verified Boot support
+CONFIG_RSA=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_RSASSA_PSS=y
+CONFIG_SHA512=y
+CONFIG_SHA384=y

---
base-commit: 501d76ca801343cce6dafb17740a8b679ed17072
change-id: 20260715-verified-ed775e27cb91

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

