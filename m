Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D14C61DC2
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 07:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A84C406C4;
	Thu, 27 Aug 2026 07:35:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4XpoP2K7HJXD; Thu, 27 Aug 2026 07:35:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787816102;
	bh=KvlZILXqnHbh+c53J+OfP5Mxv4n0qdPUwVhzHfxt3w4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qqHpMIea9SI1ovtiAvN9RsMGTE5rEYfmqrSS0AbSbFyYIIicCUZx5Q5B/aosUUq4j
	 rgX8/vMnSqyB/SzQHegIowL6HEQ3xd9bTauoQtE6bpsfi3yAF6kIMqkqKIDH3eIIoB
	 WmrHyfT5nGajsTraClShW9ku85wYczftCG0ijZU/Qr6ORLesz49choWL5TStkilPiW
	 cKUre8wLpdLvbCKnJIGEiUvS9s6JjF2DQfolA6HE4djB9kCfLc3ILZUDYAlwnaCEgM
	 vwDguMib0wL3x4jUBU+Cu8qfGVFV+5ouBh8x6DjYPO5qwsG08M/VxRR97jWoWArAVw
	 +Q/V/rkNDUrXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 837C1406B2;
	Thu, 27 Aug 2026 07:35:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FBDC3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0CFAA406B2
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:35:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hYDbONfpss-y for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 07:35:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=KCzwkR7C; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=H7fwYOvC
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F06A0406AB
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:34:59 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R6R8M43039458
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KvlZILXqnHb
 h+c53J+OfP5Mxv4n0qdPUwVhzHfxt3w4=; b=KCzwkR7Cz14JXD3Qhewzro5dVMX
 0oefO2qstJTGk4po5Ev/GT37BVWRYK6LgZ0UawhtS2yQvNMGqLYm2XY1YxE1gC0k
 Vn3iYLX56mopocXNup2mmfG2ragZd6UliOrOBfwlEvYSCe9+REIhJABsoEu1hyRQ
 zrH/to2cAauthzwgLHelyZfcFyynSjWMIdieg+zTqMM/87ip/8wGOP+3lhbJ6IzQ
 SENG+xx74epqKjqemKetTrJTPe7WmT5/xCxxHfRTZmjY/IJppXQ8EdsRXCwhkU3I
 FcjhQUsLDrKM8K1zcmx9bRZ/mtYElQFO1Mx00kgmSFKUsSR6h1aUF7HI9gQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga03abt2w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 07:34:58 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc1cb806660so2099991a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 00:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787816097; x=1788420897;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KvlZILXqnHbh+c53J+OfP5Mxv4n0qdPUwVhzHfxt3w4=;
 b=H7fwYOvCu+oXvGanhEuduMceFJtbGX9XwI4/2jFEEp06j2S3olp+ylsahlkjiER8gz
 Dwt+C3U/Shr9JQBxH9b/V+yXNA3XkvCILgSK8cAo0GKEtVOrYWmtj6RltTSMccN7L7kG
 nA0ryISsg851Pbir/xwL0SvhNImdpaDmci6dp/RegIi7NApJGNY2M/2MdcXYfkFJgjS2
 YOmZwR4k6o4ziqUxhS70pleZ3bfaZ+s1MjUjfZKA5KNX3RDUcetNpJOcUzoIBe5OjeG7
 mZvEXUOJo6xm1W0l/hMvK28ij/u+aaeuURIW+yUEOpxiMAIGadDHXoIShS72lQhlu98Z
 r7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787816097; x=1788420897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KvlZILXqnHbh+c53J+OfP5Mxv4n0qdPUwVhzHfxt3w4=;
 b=RVkcJ2lJPRo2urgoM8k8ZOmRvOCrI295IGKF1xZvdzvsmzHrEk92pRdBw34ORM6ypu
 N5vsQhFxz95x6XCLRIV6X/vNx6BRfC/LprNWFWm6jbcF1jLj74Ry2WPy36LLFTUWVMID
 Yktyxsym+8Xi9i0qmNQAsI5NHXcLdnsboGG28+C8VTOZprx5vAoFGeyx1ux3enLNc6lg
 hjEP/YmHG5Fel2yyGXZ8Q9FsMai63ttQOVOZRkdlzsAhG6M2CvtlsTriLvdsHI/7bKZb
 flA5oz2gJ4ym1q/PMO8Sc31yXCJIXAm0YK6jz218XKekZaP9DhjVFTgDmcoTK6kgA15T
 fl3g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3DbfsNj6KiAj78BG6NmgWiqx5SMXPf16C0E3WXUqoWE3vXAWRr4ow4uP8Th/usNXQqmT6MaQ=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n7+wLJcjKx1aHQHmvsrx6WP1SqtKpk8xhd2HJMRCNXYBuWAFFj
 sDvouAZXiTOcxRB3M+4jeu3/6wMoxGJgYYsL98oE9s10IgwytE8Espncd1gfBnSeulegMu36NJX
 apAlagig/0F1MXTwkft8ujvFZy0vDZwKfis+Rc+BFdhmXj33OCwmmdQ2HG1jqkBKyxiyQ8Dc=
X-Gm-Gg: AR+sD11tN6S46gOuCL+puKwiqb952eW/B1I7bLxUCjT967gtTtf1LeO7FC7cm9II+Pk
 ZlGUlQnryNH1tC64qVFjUcY0Dnnkb8BetW31Wn7UrmGosRAAg+mPZRvVSO+VZwH//641rTDG+Di
 wjqeWvPP5Tu6EJ8aevs2LuqZDT+cDufO1FZr1hvCq1tue7OXFK75gvxCrFuLlUfiqQdWALOU5cf
 HQHOsyZjK9A2hzxPiYbBzP9ffwHV8l1thsR9i5O11NVv/sGo/e0+8WGXCX979zvj3RQcYIyw6W8
 HstSW7S628njys+msKD6C6QHJYOq2qXFbDrT4mcqOY02iL7sP8/iCQNfjtaA1RjvSNhxWI80wca
 jk7FVT1W9Qk5SrWKopiQ5PzhExsJXore/jUHd7ZXapTNDcBufMglGT7AgVP/PIEJgs9e+yvyQ07
 zpLUjusRpRCJT5Vs+p2y0=
X-Received: by 2002:a05:6a21:6b18:b0:3d1:39e9:b26c with SMTP id
 adf61e73a8af0-3d139e9b40emr8008305637.7.1787816097419; 
 Thu, 27 Aug 2026 00:34:57 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b18:b0:3d1:39e9:b26c with SMTP id
 adf61e73a8af0-3d139e9b40emr8008197637.7.1787816096971; 
 Thu, 27 Aug 2026 00:34:56 -0700 (PDT)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d886256sm17981719eec.16.2026.08.27.00.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 00:34:56 -0700 (PDT)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, varadarajan.narayanan@oss.qualcomm.com,
 quentin.schulz@cherry.de, stefan.roese@mailbox.org, xypron.glpk@gmx.de,
 jbx6244@gmail.com, hehongbo918@gmail.com, quic_timple@quicinc.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v1 2/2] configs: qcom: enable
 CONFIG_MSM_GENI_SERIAL_CABLE_DETECT
Date: Thu, 27 Aug 2026 13:04:36 +0530
Message-Id: <20260827073436.4113558-3-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827073436.4113558-1-aswin.murugan@oss.qualcomm.com>
References: <20260827073436.4113558-1-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3m736zIgnU7Gx7mASrtBdbYzXxIxHj6n
X-Authority-Analysis: v=2.4 cv=VdLH+lp9 c=1 sm=1 tr=0 ts=6a8fe8a2 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=s3UsFlWg1-saUSqJW8MA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: 3m736zIgnU7Gx7mASrtBdbYzXxIxHj6n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA2MSBTYWx0ZWRfX5J78fiHKnWFt
 egUvlASr0XlDW3dvjDgrlkBT4cYkDXf+uKMH7bPDTVyi2PzZ8Mge7fsxAq664uae29wq980h+ne
 J/CDeaINGllE2FMxB7y3jxQ2bV6sOI7iiNCYAHRthPW0DegqPqk4dznPowBM+cJC9ctRsIdVgTN
 7eXx6p50i9Y22M0ysr3RtmwiYo18KNxT4gphyX5Yr/AOR4cXyIpuMLo/H4nRoA6/poDEYKRGbUH
 rqXEqLDu3cRJgkCF3Exat/pWGkOLN4aDdluGiFMWOMPXlrmpIWnNvEffLZ1b4FMa6HbGTFYPPvr
 diGek9mWrJfjD6rZZdWdR/wrlO2P133edkjVlsiewGqbJV0Shxj8Eyw1VZ3C8gQxr/3c+oPZPfU
 p7uURPIrAF34UyrcqGpj6rOVUAQmMPKc2+PxgFKcKpiIt2WskMR8MsHIzA4soSStFcj+3wIdPmS
 tL9rrSixGR8dez1MbvA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA2MSBTYWx0ZWRfXzzyu/3Pm5MkZ
 eW7TR4kDBETv5c/+t92+7uEUAItRNhAukz+s6vsMVNLfBpo61IrTcNIDW6057IS5oMTUV1CmOPa
 aQTKc/1s4uEixJC1YaJ0rFdIHGqeP9k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270061
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Enable CONFIG_MSM_GENI_SERIAL_CABLE_DETECT in qcom_defconfig
by default.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index c52f619850d..8ef1300c973 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -129,6 +129,7 @@ CONFIG_RNG_MSM=y
 CONFIG_SCSI=y
 CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
+CONFIG_MSM_GENI_SERIAL_CABLE_DETECT=y
 CONFIG_SOC_QCOM=y
 CONFIG_QCOM_COMMAND_DB=y
 CONFIG_QCOM_RPMH=y
-- 
2.34.1

