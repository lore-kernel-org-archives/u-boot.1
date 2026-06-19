Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FCBCD4F26
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 11:11:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55845849D1;
	Fri, 19 Jun 2026 13:10:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lDur326o";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bF/cejBE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C424847C3; Fri, 19 Jun 2026 13:10:57 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1593849D1
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 13:10:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65J7S7Q84001647
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 11:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 djzubB6axADWh4g7tyH7/rZE4gGh9LeScP08lw7UPTI=; b=lDur326o+pVG0NGY
 16Wxk0BuCxpeT15i6znZ9TwUxfnrizcAR8vgTd1Pi1YKfEjji+TmOt4JgNFdPmZO
 bvbapQrmWWLQl844o0Q0nxY0VOaTph7dYQ/YG00KwrV4601MvB2g0/Ikdzp6sy32
 FvT+4CmWKVX//p076B80SMb4x5sLQF5BOamKgq7vkIgzsHG9E4nAE5M0p2eXWXMV
 LOctY3zx4hlTqfU2bg6qtHDBda9WAsFFCYCGOPijrw1BzoObqNxYTRRH/EC03vDE
 mnzjzTRcIkuwBHigzQgYfuq/F7WNnE95DjzTSeeMRBGoYJgHFfOi6D/qrbjUl5oY
 b0T0Pg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evpyutpnv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 11:10:53 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c6b7c75550so19036655ad.2
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 04:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781867452; x=1782472252; darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=djzubB6axADWh4g7tyH7/rZE4gGh9LeScP08lw7UPTI=;
 b=bF/cejBEg96p+PG83BNs6QA0vUox9PqGd9Prd1iH4mGmPLZTEB3LyFcs6pOvnUVPwn
 MhZExXtx0UwIz8D+BnrZwAYFHIc7th7smXP6hSgl3LZknbqqWTIDe7NpvufXv/K0YJ6y
 WkOjsDm944yHDuu/c/MyKtL7tWPg8DerQOacd2LMoOXclILCizbhUgvP4QJ5jv2+AU7G
 pgVysXgnNGXEQe50/Rc427n/2OI5V+ndpiSv7qtt70rrnliBLaiqHXEdfBAgPHyC2bad
 8XdlJfhSwrloPsw6nCiNXSVwbBksrhYB9vzpm6nvZ5O3tgDyER4yUGvWoZ7Ng4F859WR
 O7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781867452; x=1782472252;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=djzubB6axADWh4g7tyH7/rZE4gGh9LeScP08lw7UPTI=;
 b=icmqx5d4qF6OMNTyJUeXB4+F/B9ywF5JBAJDtiza6dJWbm79ITpX55w551DFFwaNkV
 uQbCQ5Ye1wiDbzeQETePgpZeLRgt9kzGn6JUykH3HV0VZrNjeWCuKj+z5IjBCI91izsm
 wYWVRnorJ8YecSQ9iZWMkdphJ5tS0aZ2harNve64kW/PfET3QSouFBVXRiydXNoJYDHE
 LzgUo+TsdHdAV2HCNnbDyKd6bvmnPrV9n6XZdeA5rrPmcctc+ypgCgGetEAzN6rLn0vJ
 D80oPZChVKJHIHqfV7l0jFGpgvcUJ/dqK8js35vZ24Gya4W1FnlboVrAxYmI1bFadzbF
 9EYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Pl67IDSZZbMuH0e2ywuEuCgIzDqg2Qsj1DqRE+HAtLTuJB9IE1kxAXslRKcbBOhA4C6Z9EeE=@lists.denx.de
X-Gm-Message-State: AOJu0Ywz7NGP2YpUnCPafKkw5LYm7Z55a9iwOuwDQ0HVQMAlmHnUCCk4
 2Wm15kkX3S3m1lu8Px1WI+hA1dTFbg/+8VDhEPGa3PIcxXZCQS05QWCJDzh6Y+ONYJPUS+YVj1X
 5BK4G7hDmVRVDCqCW323ihiACgMLRgOG0A1GkLWml03reo89wDrx6M4EB
X-Gm-Gg: AfdE7clt6bG7yqbPacblrXyj7MDoJRyUg5T5v9yMnG1L3/HozYAvXsRXbkV/eXBv6KT
 bAd00/inqkyCwkJVK5PPWKnE5kw/rEbsm3QSWIfP4StgLhU70kJaBSkAdoztO4uzGWtk6TWzv7V
 1VwMXlAKTB3wPsNKo3niFj0s80fByH4GdPhVUGbRcXoYc6z+GGQepme6m5m4kh1dI0um5Z7nWbc
 ZRpw5QqEhQNK9X6MqY3gQBlA34ffvN8Y1dOF8Bgzwc0U7CgaO7W0cz9HGAlKmbFlkvck9lV4LnC
 fvbs+bJgimMxYVQU0zbOaYDHh5Hbz3+iuStAAL0mgGDm0984ZGLS0chij1qDUYyk2MhaYK7/qwi
 DCvmWWpQVA5RgW2pmDgKuY3Qsq7VYPhIhaCH1qufSXDugnc/C7jEkVv4ITUpDhoin1XFqA071RC
 XEe1g5wGP7RMTmguMkC3Dkx4mI8mzeyFpcYd4xM+4=
X-Received: by 2002:a17:903:22d1:b0:2c0:ab82:6b99 with SMTP id
 d9443c01a7336-2c718fc11b2mr35216245ad.33.1781867452134; 
 Fri, 19 Jun 2026 04:10:52 -0700 (PDT)
X-Received: by 2002:a17:903:22d1:b0:2c0:ab82:6b99 with SMTP id
 d9443c01a7336-2c718fc11b2mr35215795ad.33.1781867451612; 
 Fri, 19 Jun 2026 04:10:51 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c72089a6b2sm22619585ad.2.2026.06.19.04.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 04:10:51 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 16:40:25 +0530
Subject: [PATCH v4 2/8] arm: snapdragon: Make SYSRESET_PSCI optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-snagboot-v4-2-385497442db2@oss.qualcomm.com>
References: <20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com>
In-Reply-To: <20260619-snagboot-v4-0-385497442db2@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, Simon Glass <sjg@chromium.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Anshul Dalal <anshuld@ti.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>,
 Antony Kurniawan Soemardi <linux@smankusors.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781867429; l=1018;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Hm5aFVLBwkWNElcR5KF2zLQ8Cy1OotmVpfsd8tKALus=;
 b=s1+K7qRlMD7IZcdpMdd1s4LyP04t41OzaRRdWgW+5R/j0NnG8gOcXGRIcT/uIviyYN5v3kwN7
 nNeQjCYeEOMBjiGaIrxHL8t24thNxsC7mKI1lotsOXGYMvccTW/rQfg
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDEwNCBTYWx0ZWRfX0ttfF4IpFOVd
 Zdq7ZNiuEV/onca5X/8je7ZbAYP5W2RgD3YcDdztWW7F5C8DAlhRW8ifCIz48KyKrQlGdQ14U/A
 isuSH+Mq26efLXxFd0hOdFe/02xA/EY=
X-Proofpoint-GUID: QCcC7_lUoHu8nBiP-eIeHyNkcdNp1km4
X-Proofpoint-ORIG-GUID: QCcC7_lUoHu8nBiP-eIeHyNkcdNp1km4
X-Authority-Analysis: v=2.4 cv=cY3iaHDM c=1 sm=1 tr=0 ts=6a3523bd cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=8xjO-M_dw0ZfjScI2EYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDEwNCBTYWx0ZWRfXyseTVRd7eROP
 qVHAN2wsTuOPQl8Jnb31QOyw5MxbL8Sn/D5Sq4dvVdCyKn5loEeKz/eTe7oD3WjF9ePL78ky7+5
 ek0dULgdu2/NZVZqgTqIOVbf4PEW3Ua5UAv136e0HD9W1OkGnB7ETCDMQZ0FTBh8SUxaMf5NmYQ
 56rhrzPi/0PgsbapDu27HG04G0dwGgvUKOyMv/KPBxyv7hr+YzawYWuq7TJF5IKqRYttHo58/HI
 sVOfkB2J5dKC9UK8rnk40lYOF7T2Z0vaJfW+Gh5f/+biduo9G52dw3E3aRc4/SQqw+cuiXvsukk
 bfc5+/Xi7cr5VKdhgCUa+8oySl6d1fuR+Vi/S1G6InUdOkdkX1BSyy0HWn8/zl+ylOoE+67nIui
 O+/84S4XuOsLbd0wvFGJKYxcGjHweQ9EcgCQhLonabkU1jyfj5BbErLgK72DOoE2FFZged9EybX
 Ue/bKDjo82c5HyJF35w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190104
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

In snagboot mode, there is no PSCI firmware and U-Boot will crash if it
attempts to make PSCI calls so disable it in this case.

Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v4:
- Make SYSRESET_PSCI dependent on QCOM_SNAGBOOT_MODE

Changes in v3:
- No changes

Changes in v2:
- Newly introduced in v2
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 850768282ce..bcb3cde9405 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1149,7 +1149,7 @@ config ARCH_SNAPDRAGON
 	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select SYSRESET
-	select SYSRESET_PSCI
+	select SYSRESET_PSCI if !QCOM_SNAGBOOT_MODE
 	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
 	select MMU_PGPROT
 	imply OF_UPSTREAM

-- 
2.34.1

