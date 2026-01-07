Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9E6CFD64E
	for <u-boot@archiver.kernel.org>; Wed,  7 Jan 2026 15:35:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F66C800AB;
	Wed,  7 Jan 2026 16:35:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QG0UFyDt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iP3Xwili";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1095483A26; Wed,  7 Jan 2026 16:35:26 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3E09800AB
 for <u-boot@lists.denx.de>; Wed,  7 Jan 2026 16:35:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aswin.murugan@oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 607CLq0L1643113
 for <u-boot@lists.denx.de>; Wed, 7 Jan 2026 15:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=s3NevaM09V69fe6Ac2u1cM2IZPxkEcFLxNQ
 MWdYIQnY=; b=QG0UFyDteuVF038C1GWg15K0fEEIlMe91qiguzIEwtyrhh+A3jn
 vQAGr7FzBX/aYcSS9Zme3AC/D9kD93GTcAaLrclcqYQJG9v7MeiMMW+r3AZdEJj7
 U5cMHdkSw5oKe7GXehwk95DtSvSxPqXtdJ8yJB9oHEcU8dmeNF95AgducLco+RwM
 aGKq0Zdfh6fizw6jdFPasrt9gYC4CLxSo88KHQtIfOYqD/L/hA7LV5hN3tZC72px
 SKMRxH5mH1JEQunf5b2CelB4aeeLW91mLswu5l+3LOr1NuR98COmc1z3re8bU/zb
 DILIILr/DtrjHNZvafwxduU1Pr5oJlNM+Nw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bhgsfhxpr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 15:35:21 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-81c43a20b32so237902b3a.0
 for <u-boot@lists.denx.de>; Wed, 07 Jan 2026 07:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1767800121; x=1768404921; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=s3NevaM09V69fe6Ac2u1cM2IZPxkEcFLxNQMWdYIQnY=;
 b=iP3XwilitM01TBuZueIM+s4LAOL1IVppcGdv8QQzRvqqN4KZgOLqvF+RslyPzlpqsq
 +7aMH4HkoxLhFMES1d5i/ZLSf0NjRoTHu1VsNZTsUzhIZ25X4BWC3qulexw3+/UtQqgG
 FjEJcxZGPiI2ZvpW/87/luRErQu7yNPOG9XaK0jnwncRgxgVTWP6K3Z0J5vRR5XUX4cK
 O6bj2XS25wb6gGQtE5XOSVtAUSCEEVaTp6v2+mpoB0JfdANq4tcitgoCYBbxqKIN9erJ
 mSiro6UPjR8aDu//Qzxij/cvqS+deGCyTgfVWYxmW2ozsDAr/q9LkJkQOHun5s5kbb6i
 F+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767800121; x=1768404921;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s3NevaM09V69fe6Ac2u1cM2IZPxkEcFLxNQMWdYIQnY=;
 b=t5YrYNCBkdNwbKZMiRQ84PABI7BYi6gqfSBJJ2D6BTnXvLX0RKG4cQkjngQi5qdut8
 262bM77siMIEJHfuQI57VUgGerFTJ+SkK1MfLzWfI5V0XqOJ9C0CY1Y5cFSzFqTpev6Q
 eqQ3jTug4Elni9QYgPwFML858OWUT0VdyWhJMEEdXMpye2Jp3MjOOcXbcC7++ZhdxLt5
 lS3mvVsBA19/z7PEtGMkumCeAoQah+kZQb7yCW07AWizoHz5SdTM/pjq2xyu77GHslfZ
 T4sV1MtrGSdsdD7aN848hhWCy3nIYeOueolMouDOvibV/whdX6ilcOkyno+ZcEcfsDil
 DMUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFAcM634VRFu2icWu7EBksx/NcFGvKttpawDRKb9+zOo9d1W+K0nwRDsuUWyuBKdT6UFjR5S8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2cnQ9Yz0cSRAXgNUHTKjN7iCGVRImEC2323CN2/v9xH44Sd0Y
 FEWWJ6RTJrceSRFZZZlPddzyLb/252t/jCMGldeMjHYzOxUWZVofiBRjhlHvlEc2Wu26tqmNo70
 nnhk0UQzyU8k52LIkcwLvcOn6fh74f7lfJASDkbOp0op2CDsmPc83v40U
X-Gm-Gg: AY/fxX5eVqkr9BcXh9ZCmuMtqmFhfuUHccrglsjhAeYE95aXn+Df2hS+o3qrdW9ixk+
 kGeCogVyaECSPfj5OKCFm4pB3QrLAEeslZeiktVFXduFPKxVBGNntjVb8THQz1bRQibUmH4+nPJ
 qpxFoWwGIewimB43f5v2CxfyFtcGGf7jqE5yFbbQvoGipRTys24YDN1s4uH+TPnlAiY9dqou2Uy
 H2aMitxJ4wnHdyTbSTLzR4sS6z77yVjBv6F1Yh8YlYIPMks2t4OLGqvjt8RHT9cWIVtGIq2qywJ
 6AD5ABRZ71eqZ8NvVP9GWK+pu9Ixr77uPW83+nIx2ByNr6x+kisSVCU6z7newYeS5+G/2CHszUE
 f/jU+0hnRLnG5tEEUVJJ/WtmNJb7iI2WZiGraM4D6/UKhz02dyMXoLGKgYNZ1WzVExTm2yr8beL
 /PgcGT51u+Kq2ddSH5idPXKEDb92Et
X-Received: by 2002:a05:6a00:3318:b0:7f0:8031:70b8 with SMTP id
 d2e1a72fcca58-81b7fbcbb86mr2913080b3a.51.1767800120598; 
 Wed, 07 Jan 2026 07:35:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXAaLLxqoBVlzm4AnyjhCovhKKoGXsMkuOKARqaZSk/9vpzr7IqP9V8L8AFIJJN+JrZtMAQg==
X-Received: by 2002:a05:6a00:3318:b0:7f0:8031:70b8 with SMTP id
 d2e1a72fcca58-81b7fbcbb86mr2913051b3a.51.1767800120044; 
 Wed, 07 Jan 2026 07:35:20 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819c59e9d42sm5264188b3a.51.2026.01.07.07.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 07:35:19 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, mateusz.kulikowski@gmail.com,
 trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: [PATCH v1] spmi: msm: refine handling of multiple APID mappings
Date: Wed,  7 Jan 2026 21:05:04 +0530
Message-Id: <20260107153504.550450-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDEyMSBTYWx0ZWRfXyosBIapmEsFF
 NYnN/JA9kCEhQS5zgm5Lx+e02d7Iq/6DLW8nGVb9VNkOJxljBDwailSbmIb1XTbOexnSbaTzZg3
 XXE6mtLSSkwnvVkSibWhZt12SKVgv4iTnvzRlISRxL/UC0ZNj796zhVpE9a+ISWK0fi8/00FbRr
 /JH/C/GuyKweS6fKtj00a8/vLFR7Gypej+xfkxh3klB38mZKcFxignfQ0++3vNkzH071b+ywVx0
 2N0RO6oc5BtqTgHj5uz0C6EJm7YPVl73v+Rz79I0lN9FooFHDePLzNzRmG9ey9gAkiX95R2/2Eu
 EfpNcjjBOrHb2TM7tq5wLYEjNW42zk7QYCu1et7TNe07gQAfYx71h+3dtmujNfzKLcxZ5Kl0Kjt
 fKfe7x085VG/bEXenHTggGyzDR0zk/uRvj6QA84DgLrpdRSvSiSaJKJLoUfBDhmDlmCdoMe8T63
 cA+YuYGb6x8uhgH4pfg==
X-Proofpoint-GUID: by9j-T90RuwYWltnlL6YVqjFOHc_jeeZ
X-Proofpoint-ORIG-GUID: by9j-T90RuwYWltnlL6YVqjFOHc_jeeZ
X-Authority-Analysis: v=2.4 cv=Abi83nXG c=1 sm=1 tr=0 ts=695e7d39 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=wz9XmjxeAwFrORu178sA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070121
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

PMIC Arbiter may expose multiple owned and non-owned APIDs per SID/PID.
- Keep current mapping if it is OWNED and a NON-OWNED appears.
- Always update when a NEW OWNED APID appears (make writable).
- If current is NON-OWNED and a new NON-OWNED appears, update to it
  (remain read-only).

This avoids write-access violations when not using the newly discovered
owned channels.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/spmi/spmi-msm.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
index faae54e9fef..f3cd98c3db8 100644
--- a/drivers/spmi/spmi-msm.c
+++ b/drivers/spmi/spmi-msm.c
@@ -274,10 +274,25 @@ static void msm_spmi_channel_map_v5(struct msm_spmi_priv *priv, unsigned int i,
 		priv->channel_map[slave_id][pid] = i | SPMI_CHANNEL_VALID;
 		if (owner != priv->owner)
 			priv->channel_map[slave_id][pid] |= SPMI_CHANNEL_READ_ONLY;
-	} else if ((owner == priv->owner) && prev_read_only) {
-		/* Read only and we found one we own, switch */
+
+	} else if (owner == priv->owner) {
+		/*
+		 * Found a channel owned by our EE - ALWAYS switch to it!
+		 * even if we already have a mapping, we must prefer the one
+		 * owned by our EE to avoid hardware access violations.
+		 */
 		priv->channel_map[slave_id][pid] = i | SPMI_CHANNEL_VALID;
+		/* Clear READ_ONLY flag since we own this channel */
+
+	} else if (prev_read_only) {
+		/*
+		 * Previous mapping was read-only and this one is also not ours.
+		 * Update to this channel.
+		 */
+		priv->channel_map[slave_id][pid] = i | SPMI_CHANNEL_VALID | SPMI_CHANNEL_READ_ONLY;
+
 	}
+	/* else: Previous was writable and owned by us, this one isn't - keep previous */
 }
 
 static int msm_spmi_probe(struct udevice *dev)
-- 
2.34.1

