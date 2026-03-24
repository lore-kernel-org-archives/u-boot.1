Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF271FEC0E6
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 18:00:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98C4D83CD3;
	Tue, 24 Mar 2026 18:59:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="abnJ56ei";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="crrr9mnM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEEC883E4C; Tue, 24 Mar 2026 18:59:57 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9538483BE1
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 18:59:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OEYOt82323409
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 17:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OKT1E67LXBj
 v9n3G89uM+82b+HsryUf1I4YIBzoLHNQ=; b=abnJ56eitCzREwXTzjtvU2amXYo
 fY6zofDk9RQ+ekF0C82B1DS215cIVFoUdd3eATNoOXuhNy5/L+0HKGtYi59cidrH
 O51SkSwdxPjs4ENlGQA3egnCDhf0dX5GFCvEJevu9cb6k0JVolUsX3wZUEU/u86s
 G+hpdTkVvL8M+MUvZXKzeAMLzEGM8zAm2G+mZzryGi/gReTyLu5AhPdxRY0fu/bS
 Cn0EDTRS8NUtLOwBHFpiPEtPH6SNfOaEe/O9ugMgh0EZ9ehIMWG2vTKmCsv9guQo
 nbMmXSrDK8H1pP9eCzHG3X1rbESw9e/OeZU8Zpa9t7jWt8lKakJSa6Xsl1Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3qket69e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 17:59:54 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c7414516609so975949a12.3
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 10:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774375193; x=1774979993; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OKT1E67LXBjv9n3G89uM+82b+HsryUf1I4YIBzoLHNQ=;
 b=crrr9mnMXkZSS8OKWSwv/KnMySHWceine4M4HLGvfhh0qMFzNpTnyjhrnzNHAsxRE0
 iehMkzJ6iiCt5NP85ZHgT/L+/pW6GYz78n64oB1xJH+KhUX27+EVXhgjyBAoa+/LV/PC
 QWD06U/KIkomruYQGMM9wO5adDPdcQQFz5uoMwXAXXgDHf8AeUAgEDHI8baWSxs8dJl9
 R3Prr4+/Wdu9Y2tsPtjWSVHvHzqdVPIOVL0naRZRE+TzQMqa/7Gan+HESptykOdH53/i
 GbBxbB9+k0FfA9n91EQ+8uXyF7YSwbyEiQ5r6k3WU9bnTrXcCRR0QbWGzd5BxPEtKqSY
 eEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774375193; x=1774979993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OKT1E67LXBjv9n3G89uM+82b+HsryUf1I4YIBzoLHNQ=;
 b=AUBuj7rZbnyx9rszgHtXK3HQITg1rZk3Uy0CA34i8rccI3UGsaHv6mrgCFILspVlx7
 L8B+cxZiV5Gq12ozW5GZmDFZE7FwJV4f/PGhmLxpLxSOGPPFTaCFnjzHihfy5MrKfXU8
 hblPBbOGvq0iVzaV//fpIZBYktclaydzqOzgghb9ufILsXgO9tsTufmzWfN7+7WIySfl
 MsiYO+CJkYbIpcKtKJjmXARqP1AiJLTUYzZbK2YW3Uq67G6jJO0t93N/ePXn0gVnUv7q
 bUgcZBD9Pzm26SrPH171LdglHRrq3tNg1LTUX9SLOYHfj2cLP8elw5I2VZ2mAl3sTvH9
 ob9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmeKEObx6eFNVgwohfX1cnWSAqvxsC37j4Ld0vi6zB8pq4NzypyVd5fzxDWtydpjrWv1QfcpI=@lists.denx.de
X-Gm-Message-State: AOJu0YypPlNl8hWOqrcjn3pha/w124NrS3jrGRyd9z2vgSHcQJUzpZS/
 2zCqFuxoXyuwirgbJHW/H0nQhh9ITOgfR41rC8DOAGVsLyxLeK5oSP8Ke/vj/Fm0YYwOMWRggrt
 NDNoGzu1XUeq89oH0kpAmdD2G7DOOSfsor2YS3XyBAS4eZF0vLRpPlq4c
X-Gm-Gg: ATEYQzxwArvAgNTNLTe3fXTpMSp5fMQtYjHV0Zxm0qdJtZ9ucsEiaaWMg69ZTndiL31
 IQR9Oy6VmPqwdlQZaXDNHOsHb0grlI+bOFYxoubbke6dwq2tz3k4IXDSCn/MqHsiLBqu4R6Rz93
 qTsw2+EJeesd5Y6fh79UNcK3TlLK8gZuGalpT5DqbL8771yXD7ChBjk9TdGIb0KyLfWWSM20M/+
 95o8eDUI1thksDt9IoG0GXctXf4Pw2bWeyNCLmd4j5npdjMB4Fb8Xs6dmfyBa7Zzb8cG7cBqaA9
 2tQHqBLAarunJJch4605aSmRkm5CZTFTyAcDsD0mwPiPSkNyX0VTjjJ/fVBnGWF32E98uBipLH8
 1epimohwmCb4ofcRYcm2VGWKr2vJ7IrEP5iU0sVAV3lCU0JHWpGM1cxE1CouT9+Mq8IzwesyQTi
 p1l/uTLRu3n4I1/OWaeWz9i997ckmOZxw=
X-Received: by 2002:a05:6a00:1bcd:b0:82a:e3de:27c2 with SMTP id
 d2e1a72fcca58-82c6e0ca891mr425553b3a.41.1774375192860; 
 Tue, 24 Mar 2026 10:59:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:1bcd:b0:82a:e3de:27c2 with SMTP id
 d2e1a72fcca58-82c6e0ca891mr425531b3a.41.1774375192365; 
 Tue, 24 Mar 2026 10:59:52 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c212ac8a2sm15503901b3a.17.2026.03.24.10.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 10:59:51 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Google-Original-From: Aswin Murugan <aswinm@qti.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org, aswin.murugan@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com,
 sjg@chromium.org, mkorpershoek@kernel.org, jan.kiszka@siemens.com,
 paul.liu@linaro.org, j-humphreys@ti.com, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: [PATCH v4 2/2] qcom_defconfig: Disable EFI_HAVE_RUNTIME_RESET in
 qcom_defconfig
Date: Tue, 24 Mar 2026 23:29:13 +0530
Message-Id: <20260324175913.92858-3-aswinm@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324175913.92858-1-aswinm@qti.qualcomm.com>
References: <20260324175913.92858-1-aswinm@qti.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2rK_4EEMsbBvkhET-k-e5TE-88-kHbuj
X-Proofpoint-ORIG-GUID: 2rK_4EEMsbBvkhET-k-e5TE-88-kHbuj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzOSBTYWx0ZWRfXzfhINg2KhiHv
 p+A0Xf8o5LNATtQYnaNyv4IO5B7uFnOt1c0vFDMIzG9THtxfHcirKDi7SXWV81xv7NOjKhQQWAU
 fyEWLLzzIYMEAMIJyberEOHn4MHS2+G1i4/gGJfDZAgbthldOYKT0QH6aLjaR3s4p02/kehot/1
 inGhnB7cGQH0OAhoOqF7Cc278aCkm2jO4A7kZq3IeQHofE8h+TWAq4uRStsyXz1WIHlTh3Cj1tB
 o1x6b808J+Ai5OsA1ggoOfl1IL/fGoGWzgw+mKbR/D0LF74TRLhGgFrM8sTmVuM4hG+ZqjgItxz
 zocpVAUlA7tlbB55uO616mEu0WBEs/PHBtHl6H+D0hkb95LxaChugRyxXh//U/84N6jGp3JQVas
 /WrJGOtBRx08mFfXCvQr2SkTgUVFy/DSav80PBJNz1UxhA/aqhPySaGx93Rk+ezscDLHy29ju1d
 dnhUL5EKr98HqDFXHFA==
X-Authority-Analysis: v=2.4 cv=Veb6/Vp9 c=1 sm=1 tr=0 ts=69c2d11a cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=0yAwa9zdhTZloVlH2DkA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
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

Qualcomm platforms rely on the kernel to manage specialized reboot modes
such as EDL, bootloader entry, and other vendor-specific reset flows.
Allowing U-Boot to override these via EFI runtime reset services leads to
incorrect behavior when the kernel issues advanced reboot requests.

Now that EFI_HAVE_RUNTIME_RESET is exposed as a user-configurable Kconfig
option, disable it for qcom_defconfig so that the kernel retains full
control over reboot handling on Qualcomm SoCs.

This ensures that EFI runtime reboot callbacks are not registered on
these platforms, preventing conflicts with kernel-managed PSCI reset
paths.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 314fc0c4903..8042855bae1 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -6,6 +6,7 @@ CONFIG_ARCH_SNAPDRAGON=y
 CONFIG_NR_DRAM_BANKS=24
 CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
 CONFIG_SYS_LOAD_ADDR=0xA0000000
+# CONFIG_EFI_HAVE_RUNTIME_RESET is not set
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
-- 
2.34.1

