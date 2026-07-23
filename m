Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2187C531D2
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 14:39:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C0B1F409FB;
	Thu, 23 Jul 2026 14:39:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J8ZtHz3GzHMH; Thu, 23 Jul 2026 14:39:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 530E440A08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784817552;
	bh=5+SKdk5l0vRsov+IRkQsvEdXLkPsXugI78RVMRPCD9Q=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=D7n8pu4b9+mg91Dsep9MAqmloP4OUsLnDMnAGsPMEBOxcprxW6/cnUCpnV4CTYE8G
	 IctzzrkGUklX8SRTMBTV8f2lfCVGX7yuxSUvfb6w7GJ/1uw1UtKd97MhST1PPrD+V9
	 s3RsNHnIM371NBGA9Y28NUvNFf6hhRPe5ddecYnNDBDhBByFif80SynE8icyNCFKg5
	 uLVc5EAADnWB3ynNaD991Z01xtnQZcVgTduHdwPODCczOT5MIsnBujpW/AdOZs7k0Q
	 grB2hXIgmC1zNC3PSY/swS3R6G9n4QOUBzBuoOmf3XzhYF5kAMlK8pc/HK3Bjr/Fgr
	 x0W5J/4FrEwSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 530E440A08;
	Thu, 23 Jul 2026 14:39:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A150788
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:39:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1FAB6403E9
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:39:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W6uSCvLOEfNf for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 14:39:10 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 8D822403DE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8D822403DE
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D822403DE
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 14:39:09 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AA938493F; Thu, 23 Jul 2026 16:39:07 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4405F80087
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 16:39:03 +0200 (CEST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NCw2fZ3952085
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 14:39:01 GMT
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkjnu8pag-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 14:39:00 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8fdace20927so7571086d6.2
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 07:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784817540; x=1785422340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5+SKdk5l0vRsov+IRkQsvEdXLkPsXugI78RVMRPCD9Q=;
 b=Ru7aecPBKV0JmkTP8bNgjXTawa788pMm6P8GVtWFPmTit08dbJsg8VNawgN2KmSUMv
 jdfMU/P9pZCk7JLLkQCWhOJGdia7Gn4FO5yQJmWUgvY0k47YoFVNYH/wyDkO47/DyX0A
 YDB/GMrKua/+Cihvbq6gZNcXd34/kwBlBCdyPUWlI4q+mD7h7dcct168bSYBwiDJ8p8p
 g+xPX+h/8KM4QW/4lwOhv2oXaoBxsND67+kiV7O/iM5laUrZb22ZyrKTG5btW5NZcJX2
 oPG0dAS85gJHJerWb4hiosK5ebpI6vx7qbJbl7JiTGiPNm/2Cg1WZxsmekYAIGz2xfEK
 4PxA==
X-Forwarded-Encrypted: i=1;
 AHgh+Roo0rPp2lTTtzPjToAd51R1C/n4xVtrz0GnGIdJ0zCoAnB3r2F0XR9oEIpmJ1UrQAr/pWgck7k=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6Lkh4AWq5iLurRS1rzatvrJ+jmFQA3I8cpiKxMNRpmssuXh9S
 YpJLOan9u/zi0Bz8z/NIDTgbYCLoxlVFfUihu0Kzbk5auprKwPOJYGLsd9CermY8Xh4nK0f8j7/
 /ffPbeE8REbuW2f9PmDCIpGBnx6Hb1M7Gy+xZXbJrAosdDl/2FHQXKq3v
X-Gm-Gg: AR+sD13VzP/Pa7tMfNuoihDLt53TG7wMKTkiyuSrvMQvIb8taAPKLMX5y2xx2cf5lri
 18WhUojn2C0SjyTqs6elKESTGctq206FlLXcREkF9f9WojBaYB3aSj1gHORsuA1/WeapbtOz9pC
 mY2Dv3yP5PGGr71+SXowWZWHXOJa7WlU4Q7JkNQ9sVh0V4CAv3oUPKUyDjr3M0siCwxFJ8ePEnr
 SgGSUpn5i55odw41FFZQupMdgOuPxJluhZz8J1urWg7EL9j0gFRO3ngrvARvD/29PKulMWf+zRq
 Wnv75kLDNCMXQzskMf+KvUMbL859O5BzaSH0xgUv99bDGTzZCqZ6kXtWzZ8vZhmm7WW9uzKq+Yt
 p4+ZJ8Xusp8uMZpVcS4l3yvh6PT3A5qeG45sncxs/Z4gzA50ZVYI=
X-Received: by 2002:a05:622a:5598:b0:521:8a01:98e1 with SMTP id
 d75a77b69052e-5283df3d435mr31536481cf.63.1784817539765; 
 Thu, 23 Jul 2026 07:38:59 -0700 (PDT)
X-Received: by 2002:a05:622a:5598:b0:521:8a01:98e1 with SMTP id
 d75a77b69052e-5283df3d435mr31536191cf.63.1784817539255; 
 Thu, 23 Jul 2026 07:38:59 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c67339sm16968193f8f.31.2026.07.23.07.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 07:38:58 -0700 (PDT)
To: jorge.ramirez@oss.qualcomm.com, neil.armstrong@linaro.org,
 trini@konsulko.com, jens.wiklander@linaro.org,
 ilias.apalodimas@linaro.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 bhupesh.linux@gmail.com, n-francis@ti.com, marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 alchark@gmail.com, tuyen.dang.xa@renesas.com,
 yoshihiro.shimoda.uh@renesas.com, padmarao.begari@amd.com,
 jstephan@baylibre.com, hayashi.kunihiko@socionext.com,
 macpaul.lin@mediatek.com, venkyada@qti.qualcomm.com, j-mcarthur@ti.com,
 dlechner@baylibre.com, u-boot@lists.denx.de
Subject: [PATCH v3 1/5] ufs: decode string descriptors as UTF-16 big-endian
Date: Thu, 23 Jul 2026 16:38:18 +0200
Message-ID: <20260723143852.2287208-2-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723143852.2287208-1-jorge.ramirez@oss.qualcomm.com>
References: <20260723143852.2287208-1-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: t9QhTx7k1I4bqnxsOy3F7D5vNBMDKFED
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDE0NCBTYWx0ZWRfX5rkLTd5tU0BJ
 jl3hF4O46WJ2ai8c8IFfiZmT3c2hREwaSXZkQ44LzvMufynE95MNda/Z92C/0PL9hqxzact/9UC
 u5KvSloQ++Lw/5pli1Hm7a+++HFG6gVR1QuLT7i/VQ6APAkXNsd/rZZRma5Kz0+G8kjpCtomV18
 5hkh1Os65G63zqqauWJomwKwF9dqFJL9cpX23CEjeTbTl4vZhR5gDQVs9FCsTefPgZfv1JmSxRf
 SaQ0RfTDZPBuMzbd6hvi/pEQ5WgzPAogRXuc8pZGfOwHD4U2DBvh3jsqlqhkLL/qlpx28uQiAnf
 qGmHOB5I1bekTiHtvSCOaQbU+FuIMfPnZp6lmKinqn+ATn6RdSyiYKOVdhQDSoVKdiH4XfCYA4Z
 MrjMCrRiuUvccCV1/sqO08pA4ifncBzu/GKxkSvb+yoUEBMJms3FaesrJDhNL+qMQcJZOF1J5Xy
 Js8Sr6PJqXHyMcc3gaA==
X-Authority-Analysis: v=2.4 cv=Een4hvmC c=1 sm=1 tr=0 ts=6a622784 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=JJ5SyZhPYCvuiZDi1AAA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDE0NCBTYWx0ZWRfX2jp7rud9/ZjZ
 PpCTv6ZvC75Duq9sZz7TjD4aqvmg2gX2xmV4yEy2u1HBgTb6CcfTZYMEXwfbU2hRxMtXpmJXurg
 ROWeon4/4A71p8y6XwoH4gxQo9gzrgg=
X-Proofpoint-GUID: t9QhTx7k1I4bqnxsOy3F7D5vNBMDKFED
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230144
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5+SKdk5l0vR
 sov+IRkQsvEdXLkPsXugI78RVMRPCD9Q=; b=PMeUOW0j2pIaZCkoYhUu7/N5ZEJ
 I6QpaL07glAW1t04yRuoO2IqmJHFkQfXcCSKzlOojJ9HcfW8hxpOsSQKoR3LrWxH
 erzgjL4HUO1hnf9h3hEa3E5QyJnlVC8L0Fg+PBUDeWjugfNQV+cRctXpvxk4gR1y
 tge0moH7hBCg+qj7TORLfT1XCgo+rKrG1rOrAlu8cW/kQcAPX57ZLJctsqp+xaWE
 RUdXrdiMu1vKWSZWSNR0q0jfTkWqP6BqfTyz3zsEHhu46sexDvpGyfLO7GcZGlvt
 k8xgN9h/0GEiPEUD4rLK2pnj3gTqaGQOniaUU4yh0IOa3CefmiaJ2OE08AQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784817540; x=1785422340; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5+SKdk5l0vRsov+IRkQsvEdXLkPsXugI78RVMRPCD9Q=;
 b=jztD7uaSLUsXiH4uPmVCUoy7n0Xa6g2AG5cUcP6xGj8BzQ5ilhFji0WkMGMdI8DJo9
 FdPgQfuCTc0L+iFMzOKLTNZ3oXzH2iVn4ZpxioBt3iGhcu/92Abowopoh/JHU4/HDBRE
 TltwIgT2IxJwpMsf7osmOevij8g+iXsInf/egV515eV93pyrKv8GdNj6s382u8sUApWn
 T5eWFE5LBn3hO2FsoHOyDRPs3A4BoDxniSAT+DL37gyoQXBln+8EiBeqmavhArC6N1uF
 UlPPjgHNduFEFpvcHIlH6REuAvp66B4K+X3JKGr8nEWIdMT3MXOeLWPpb4tvDrJ6e3fS
 R6sQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=PMeUOW0j; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=jztD7uaS
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PMeUOW0j";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="jztD7uaS"; 
 dkim-atps=neutral
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
From: Jorge Ramirez-Ortiz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

UFS string descriptors are UTF-16 big-endian (JESD220), but
ufshcd_read_string_desc() fed the raw bytes to utf16_to_utf8(), which reads
host-endian code units, leaving dev_desc->model blank. Byte-swap to host
order before decoding, matching the kernel.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 drivers/ufs/ufs-uclass.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 6a51f337e47..8f120fbbee8 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -1533,6 +1533,19 @@ static inline void ufshcd_remove_non_printable(uint8_t *val)
 		*val = ' ';
 }
 
+static inline void ufshcd_str_desc_to_cpu(u8 *desc, u32 size)
+{
+	u16 *p = (u16 *)&desc[QUERY_DESC_HDR_SIZE];
+	u32 len = desc[QUERY_DESC_LENGTH_OFFSET];
+	u32 i;
+
+	if (len > size)
+		len = size;
+
+	for (i = QUERY_DESC_HDR_SIZE; i + 1 < len; i += 2, p++)
+		*p = be16_to_cpu(*p);
+}
+
 /**
  * ufshcd_uic_pwr_ctrl - executes UIC commands (which affects the link power
  * state) and waits for it to take effect.
@@ -1765,6 +1778,8 @@ static int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
 			goto out;
 		}
 
+		ufshcd_str_desc_to_cpu(buf, size);
+
 		/*
 		 * the descriptor contains string in UTF16 format
 		 * we need to convert to utf-8 so it can be displayed
-- 
2.54.0

