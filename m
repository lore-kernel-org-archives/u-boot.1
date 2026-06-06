Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72518CD8C8C
	for <u-boot@archiver.kernel.org>; Sat,  6 Jun 2026 12:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 119548488D;
	Sat,  6 Jun 2026 14:46:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LC30fUYd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wl8Yj1nx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A77448405A; Sat,  6 Jun 2026 12:20:18 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F260838BB
 for <u-boot@lists.denx.de>; Sat,  6 Jun 2026 12:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65663qxU688439
 for <u-boot@lists.denx.de>; Sat, 6 Jun 2026 10:20:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SOLxQftalt1DwO/pwK6hJ26iXmXodd5rgOGRVyzxBkE=; b=LC30fUYdyqMz+qkU
 K5T4rDiVgkrP3JayDox5AnLZU9PtlsbPdDr2BskjGMltcB8sKsvP+42anzS19pjV
 fMJ7mmOUaS+iPPzJpwF9fuUs+Dib6ut7Gok99oKzGK7EgXtc7tSRnSB5RVdvnj44
 vFhprZffojMKhV2Q2DRgtiYt22FeBviEBtPII463GossN2VSx+d4oanmICcW6IQJ
 NU2JISCa5ddoeypJUxagZFbGq7PFmgtlKUmzCFxxvn2bFNELSHMQQ+TUq2A4t8X+
 W+1FjDwBBeCD36+JD5WL+Rd2ExuLLAB7CfQ0nVzcbp4jbsaL7JrokQDbY4m0tuzU
 X9HiNA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emaj4s386-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 10:20:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c0c36f4b76so27713395ad.3
 for <u-boot@lists.denx.de>; Sat, 06 Jun 2026 03:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780741214; x=1781346014; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SOLxQftalt1DwO/pwK6hJ26iXmXodd5rgOGRVyzxBkE=;
 b=Wl8Yj1nx33JHFoUgDr0egb1ZUFHDKg3foUetVPzfVCaWLIwUvjAECqK5xRgsiadHWd
 27iBLoucZ+nULX8Zr5n+AKw9h8FLsKC4AqZgUKdadw4159/QIyE4bY9QogCpZu8k4eix
 a0iP+BBb0E83qkmvlw3mxwVhlJALdJMAZdth1lwxFVpWZxK8MTaimiwDHrzAw9doKnfz
 ioAfu1TVfmrjdbVmma9eVDknyrwBqkYTiynFfW8fx643lv0TcudcoDGrJd6fpfGqMPgn
 PokAUn6O1201VctTjgSvgG3F8ANTI4CnF+HlIbS82puFA89OtVg+m2qS5akBNcOrc+TX
 SKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780741214; x=1781346014;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SOLxQftalt1DwO/pwK6hJ26iXmXodd5rgOGRVyzxBkE=;
 b=C5VYpCWYz3xS26n0PtP1ciuu13etZBLKwoOauplucJBAyywi2k9P4oUTDUkKXFk3CX
 hIXj8Oxh+ehn/mkyfAEw7WIOWduaI2rvY3MZCJA7GvjN6rZkKfanpCrzYGXvRgOCeyv4
 ck9d3BSbjMZSuU+BPxRn4FxN6a5RRsFfpiRkGdFHc6j4a3hEhr/8MXBblI+itRfBokvG
 0G72RWiAvvGU2e54fX8b2xlcwArzE/MqfXQoOjgx9DIkTHJ9xZMayTkc8id5cYLg2nYK
 AQXcP05G7zYVMaCrU0GzqVFG6yEGD8mFwFXW1HI0eXzTKo3PXB9kcUizmxA+G3Lzakh3
 uq7Q==
X-Gm-Message-State: AOJu0YzNur9ev+Bt7Ig3olRJkBdwUM/vmQikoQ4jYcTkiB8VblCh1B5F
 vI7lJa6fYdUafLfqANXHXDFLVbg/JiIbSQG1xPeTkxbthh/JamTu9GygHoFrf2nMJ36GPWaAjdd
 nJgRFTHlmEghhYZv17t8vQycAzB27oeQwqHNpPK6aWDsGxk1jk8pEqkhL
X-Gm-Gg: Acq92OEi3ub7B9dTK5Kz832PyrQDQ3AsrA7qPVZ3NCxbpGr0TuNNaSHvDe2lvZiWOGJ
 XPIxY7aRyf5M6GcjDUFubAoDVO39oorj7bjXH6hP/2+wWkYwC3+v7N0sR1K7XxfpVTaXpPDzSt1
 nyeAf0VUjxmZlmmyO43DkPcuTbKO+tr7oPBqYwT3z3M4Tk77X/fdQ5kNKmVv+UPbR4agK2SkKtC
 REAIUV4RfW7R8AbAktuKOOkPpndj1V+/kG23woXp3Vf3TUFYHZg8oBDxXWL6n27Lc2+EqNQPVrw
 8q9IPCjOtDVCzkpRxHe2QOQSNzofAZQ6rN7uXJ8EguWH0CIX/rB9KZHSbItaMB78zAPgbaPG48M
 8XL0GgZr2B3Kk3PQyl5G5i9KrzXGc0G57d1JF9tf0FwnAdSBOePg25ZTDuY7l+ASx51408GPnyV
 eYypT40XwYs8dQZ14B7cEuKzUe9nC3o1K5qy6552p7npbrAFrrdJfkOYmmCvRp
X-Received: by 2002:a17:903:1246:b0:2c0:ccdb:e023 with SMTP id
 d9443c01a7336-2c1e83451a5mr84558235ad.17.1780741213821; 
 Sat, 06 Jun 2026 03:20:13 -0700 (PDT)
X-Received: by 2002:a17:903:1246:b0:2c0:ccdb:e023 with SMTP id
 d9443c01a7336-2c1e83451a5mr84557425ad.17.1780741213299; 
 Sat, 06 Jun 2026 03:20:13 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16609ed97sm123124235ad.41.2026.06.06.03.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2026 03:20:12 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sat, 06 Jun 2026 15:48:36 +0530
Subject: [PATCH v2 05/14] part: enable part_get_info_ptr for SPL UFS
 partition boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-spl_ufs-v2-5-72fed24ef01b@oss.qualcomm.com>
References: <20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com>
In-Reply-To: <20260606-spl_ufs-v2-0-72fed24ef01b@oss.qualcomm.com>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hrushikesh Salunke <h-salunke@ti.com>, Alexey Charkov <alchark@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 =?utf-8?q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Peng Fan <peng.fan@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Javier Tia <floss@jetm.me>, Rasmus Villemoes <ravi@prevas.dk>,
 Jan Kiszka <jan.kiszka@siemens.com>, Dhruva Gole <d-gole@ti.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Korsgaard <peter@korsgaard.com>, Heiko Schocher <hs@nabladev.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Jens Reidel <adrian@mainlining.org>,
 David Wronek <david.wronek@mainlining.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Daniel Palmer <daniel@0x0f.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Yao Zi <me@ziyao.cc>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 David Lechner <dlechner@baylibre.com>,
 Bo-Chen Chen <rex-bc.chen@mediatek.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780741114; l=1252;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=4AJ1WNfekqoJnOTu21MQzrY71zWr6NS3vUert7RyXE4=;
 b=Tb6YXFQ/i9/CPUHXQWQslPfwy0KIyRnHbhkv7TKdVnWHcKg5lKPDF1rq61mskPVl0BWoUK0Cz
 PetNx8LIOhjCBNiFrazuU4JQa61nkub4Ry+eMmqgsv1LEjexh28oVf+
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: gxCmxgsIcqQtQirkSynD11a923xR8YMb
X-Proofpoint-GUID: gxCmxgsIcqQtQirkSynD11a923xR8YMb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEwMSBTYWx0ZWRfX7PkEUg8fBUcZ
 nuF7cb6dsJexsLv2JmEoaPQDglUk2yCaCJfH6a61+4p06MbDMpzcajECJMHuxFe4Vz4RFelIs0Y
 vFlDZ4E1pXWIWu+wmC+TrSNoTiQtlBGov9MoniF9lG0urrWqHdv35jaR76RpLhT7O1pZH4LwGjp
 KUISxDPETquf9sCOO8017tb4CbQfhUmNhVrGQqBYPdPCA05/UJkoHC83/tHCOckF01dAY9N/kja
 IJJJjIGAm3JttQqBBqBP6525pt2tyqhHd3oe7TL8ixrV+O6p6ZXJoLm3rYsETdYiWRyPvxcwMjK
 G6gHoY8E1EGalS3ouhWF9OH+cgxuf6GHq966bvEQcjBSlOkPnAPKD8th8QEHhag9Xk5CDuhDQaj
 NFmZTJ1Eqzmsvf083H1G/X30TJ1pGDFId7wafdQ/2s3wT3aDkQS59IolxHW1Jc8O6ljye5NHBJB
 3/h4k6eHaJztjV7rJAA==
X-Authority-Analysis: v=2.4 cv=TLh1jVla c=1 sm=1 tr=0 ts=6a23f45e cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=nXLrjZHcL9H6pKHq5Y0A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606060101
X-Mailman-Approved-At: Sat, 06 Jun 2026 14:46:23 +0200
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

Add CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION to the preprocessor
guard in include/part.h that controls whether part_get_info_ptr()
resolves to a real function or NULL. This ensures partition lookup
is available in SPL when UFS partition-based boot is selected,
consistent with how MMC raw partition mode is handled.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Added enabling part_get_info_ptr for SPL UFS as a seperate patch
---
---
 include/part.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/part.h b/include/part.h
index 15daacd7faa..47b91e2043c 100644
--- a/include/part.h
+++ b/include/part.h
@@ -463,7 +463,8 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
 # if defined(CONFIG_SPL_FS_EXT4) || defined(CONFIG_SPL_FS_FAT) || \
 	defined(CONFIG_SPL_FS_SQUASHFS) || \
 	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
-	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
+	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE) || \
+	defined(CONFIG_SPL_UFS_RAW_U_BOOT_USE_PARTITION)
 #  define part_get_info_ptr(x)	x
 # else
 #  define part_get_info_ptr(x)	NULL

-- 
2.34.1

