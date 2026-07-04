Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C94C43458
	for <u-boot@archiver.kernel.org>; Sat,  4 Jul 2026 05:35:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76D4E83FEE;
	Sat,  4 Jul 2026 07:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gysob66R";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uybl8VY4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C73184119; Sat,  4 Jul 2026 07:35:09 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 426A28341A
 for <u-boot@lists.denx.de>; Sat,  4 Jul 2026 07:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6644BmAt1836824
 for <u-boot@lists.denx.de>; Sat, 4 Jul 2026 05:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=7Vi/aYDnIw8dGop3Xy7FR9PEEVjTm0PAjm7
 C3wNsVfY=; b=Gysob66R+heaCuS8iWZvpXHeyLuEx2uYtDkADk4MtWYVPmwuXO2
 ukCJYAJQz+ZyUayhyLWAWGhW0JT6VbVK0E+6GtET4vXScmYfkKRGxQLffZGcCC0c
 IwcUz46rb5Xe1Kku7/4wyT/YQxywrluLraKX18oA121C6yUSP8hyAc2mtsPWpvsL
 iDuy9i5TuPKb6ldpO3YQtTHYdMUEhBrCt7KomZu0VVxeQiDYc6BQD8xRS/4EjItr
 FdF+7v5HMT8NnPXPfAGCq9GN4dIt5T64r3+nXvqLGErCYMCZrAg8iEYtapd7ewcc
 Gu9K9nnOcBbGIs/jiLl5ggzwin9oC35zeQw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txeg4br-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 04 Jul 2026 05:35:05 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c8952346bb9so973468a12.2
 for <u-boot@lists.denx.de>; Fri, 03 Jul 2026 22:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783143305; x=1783748105; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7Vi/aYDnIw8dGop3Xy7FR9PEEVjTm0PAjm7C3wNsVfY=;
 b=Uybl8VY43kKxapAKvv9wNXpcBAFqQC/NHM+kfqjgInEJt/iK3wF/eTshFWiV2RCCYb
 ixOPlSCT0P6ZmnHQXD3iJ2HHCm+j2BC/K5/P9As+1EMgdDNimW6rb2ayjMdjVehPiR/d
 BN+mlSlENUfhOhZrPWJApFTbFeLSBWgkvz2mYLzgiULGstLWvMuprots3D880ntNyN5N
 5pnswGZ/IEh0Dxt+1cXYOxRoQubsX9+Z0wF55hDOqw/xlzFR0cEGGWrmORa3HkGzM9bP
 uH5IwPGNfl5CUiCjFelUzJRHQibw/fBChq5kKkU3n27b6fPORamkdro1AJFmhQ8nj42g
 pwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783143305; x=1783748105;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7Vi/aYDnIw8dGop3Xy7FR9PEEVjTm0PAjm7C3wNsVfY=;
 b=OKH7el+VYMvR2VwkBh0/hG2chuI5movsItP9uDcpceRN1PsC8/6PGE6PNscoKH1Y8f
 +JXw9c+nDUvPspJmtecYsm9K5HRAZ24ccGKatW4hi647Uw0DS8LpwcKXQHHem3slnnxZ
 jmwl7IRegCt7WdGXZo9fh7zo2YNpUEMrBX28XwJcNpgZuhCdfzeTX6isI3uhFS+/no47
 F0LFW2VqY+0Uh5qGQomp7RmZ5/rB6ZBHZ4FZirAq4h6zDidJIOLJqHxYwd5JQSSAKhCD
 2ZHPKTXgg61vB2/qwsiNRPFimcOYSOVPZzOJn/GICWZW1wjBUL/q4d5Pi67ikOLwzBhU
 ASOg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kjErtBE1jYM4mDLSJ06/oxXGKH33B+pQLt0fdAgUJEnooayy7isP+o7w1hyVzx/FOS0CKkjM=@lists.denx.de
X-Gm-Message-State: AOJu0YyOAd+zbhtGR7AeOdl28QQuDuIpfUs13z8lWafEtsPhNT+KZZl3
 /1BGqIwhGNoA2fns6E9Pgs2mqrhcisoCY8ULvpEkfLd2B8WKc9yewxSHULLKqPYEXQmtTICJRMQ
 dXQzbCBqo/iDahLQuS/aFRolKnGNz5QvYVk9OgG+XommyPpkqZ18zB4dg
X-Gm-Gg: AfdE7cmK6C7Fpik3bGCTXwkHbhXr8nJdUSBCjgZh5afKbph8kASvWgH5kA7zfgBBt9/
 ygA/3C9tCbCBncNh22IJR2lxzlJuyu0+MN+uz3qUDg7QsOk0/9r7cgMDsbBIWbLFc9FdvS0Ln8S
 GmLAW15nFr92Ch4z6wUWNmON+49a+w0GLqCviw6VSL/8MSQSaFmAwquW43Q+E0V3mZvJuwZe2Zl
 CRnHce0e1IO8gSKb3YySmQWApbpU70Jig/h8LqtTnV0Y+QvHCZt2FwcoIn4a4J3QzkwtFhDmWlk
 UDuG2WnMYWiy3GO3nhKL1ikZ/Ucdzg2Nxy4Ci4WyV3BY5SMqIBCCyBYaWfkhYu4dYh92QkprFUf
 E0rr8ldn13PBoxxu/Y/ke3AhRwiWxgsW/fOVYPlq4dy/GoLgGc/J2/bwxzt4MNbidz05axfqZ7E
 y8uq6wMQhlXLIH5/pV32fVUg7sGfZFSA==
X-Received: by 2002:a05:6a21:3987:b0:3bf:6c04:a812 with SMTP id
 adf61e73a8af0-3c03e4b3ffamr2354928637.51.1783143304658; 
 Fri, 03 Jul 2026 22:35:04 -0700 (PDT)
X-Received: by 2002:a05:6a21:3987:b0:3bf:6c04:a812 with SMTP id
 adf61e73a8af0-3c03e4b3ffamr2354887637.51.1783143304196; 
 Fri, 03 Jul 2026 22:35:04 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bbd221bsm28362250eec.22.2026.07.03.22.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 22:35:03 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 luca.weiss@fairphone.com, andrew.goodbody@linaro.org,
 swboyd@chromium.org, u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1 0/2] qcom: Enable CONFIG_SKIP_EARLY_DM for Faster Boot
Date: Sat,  4 Jul 2026 11:04:50 +0530
Message-Id: <20260704053452.761684-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA0MDA1MCBTYWx0ZWRfXygAmRdbYLUz6
 UdPWawQ9XeB5Rj6zMynrWK1j/KBAlyFbOK3XyleCxBLIqzaPNKbX8I9yDPOuzZb+xVzyOO2cgyX
 ohyXvF+Yg2HdS00O6miwxoDkIyouifw=
X-Proofpoint-GUID: fLvuEpyVx78TfdRY3fNhwvzqbLUprH4U
X-Proofpoint-ORIG-GUID: fLvuEpyVx78TfdRY3fNhwvzqbLUprH4U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA0MDA1MCBTYWx0ZWRfX1WueNe7E7rXp
 uS7Mn607+CPUfDa3bnmiJ5YDgk2VKdSlBykYjGaNcIggrZewXdAdWhgShx9iBH7OZZ4s6ijl38c
 ED0/feOnMrgtUPAIPnnDvK028/Wsr1VERDJcD+9DOCW6pbjA67Vy1x0XzbobOHzF5wgrLQjbRfq
 0wRoQ62eg2uKTnv5xSbX83+w7to6EZMfMlSyHUeJ22QJEgIK2+0rbp/cWhBc/F9u4baFK2RaDEZ
 yBMBvZ16fBcFCMzlHx1+SCXrw5ND9j7tHgKMDotKxQMh7VS3ewHMbIH+MWZMgNejxMK9apo5l7S
 UIvaK0MLU/olhL7rcTSeHW69x+fxTA2zGMk/K6ktm4Lmck4Tuf05IlyMVouA/sp3JbXpSbsYXX7
 K2gWuh3FeNq+pnKEp1XoIOKxxAOEdOKU02b1eSJxWWcmjNHiHwjHV1yDckXbfs0WxpzqJ+FVMyV
 XP5PRC71oEPFs61JvKA==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a489b89 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=NTirQ9JaotmcfQ2UD4wA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607040050
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

Enable CONFIG_SKIP_EARLY_DM on Qualcomm platforms to improve
boot time by approximately 50%. Address a serial driver
crash seen with CONFIG_SKIP_EARLY_DM enabled by properly
handling error pointers returned from clock operations
during early boot.

Aswin Murugan (2):
  configs: qcom_defconfig: Enable CONFIG_SKIP_EARLY_DM
  serial: msm_geni: Fix clock enable on error pointer

 configs/qcom_defconfig           | 1 +
 drivers/serial/serial_msm_geni.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.34.1

