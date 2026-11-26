Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A4A606A338
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bf4ZCBp1;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZIrIDmc1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gSsisN7u
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA57360AC3;
	Thu, 26 Nov 2026 14:32:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uNDD2oVtj7Ux; Thu, 26 Nov 2026 14:32:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 077E160AC0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795703526;
	b=awdAGiNmgkp6BUfiVD69cijR3TEsD/VRpbcGUzYSU0VRnFa8PrfhuUBXdqxSa5+x/uZf
	 /l5o3HmWHoRQBbwcO9i0Hk/Xqgxrz/hsBVoV1NSV5EEUoR5PfmByfl0jiBhU0UeGZ+CO9
	 /Dw03zZj59zaHrGZLNVzPl7NO5B0mNpqEpp1X9gKvCnBjJoXdgTNIuAnZ7WsUZ3TRyS7/
	 trI1y2pq3c882VDbUUJqinfu8h8j4wF8gy7vRaJCvqNsY08zNiEVyzplU8om21UJthP9Z
	 DlqgZUsvCaqFQaI+rITMwbOd8tCxeykyZeOmpG9PeAGWFWJYE9LhVAoEjhlp+KJuFlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795703526;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JnVp2g6bl8bXQ04S1s4Aw+VDjJMQ8hK/5OSZygbfPZY=;
	b=qaASOFJNtAZ9sJfel5d9FXFJO7k2DprYlTNC1PxKQNRNHLe4JeFRDxkrFcXaWa47frDU
	 g55rTK0vPuo9cM7CGHNEk11WTq6Oxrmo5oFDNjDAqAOPrikFaKlyoJw4lUX5Z3pYAC0m5
	 o8f8+lAgWNboeip8ClT0otwYyUV2KVOVYsAsIxh/Oio9V9h2V6KUj9R4tnkKM7IbkNTk5
	 eWnOZoPQb1amNhAgKQU0g/nb8+mzMh085NHDfW0CvywZcFuxRpsZKxvBADTDagXHSZfTm
	 PkI1BqsLJHelCbOSy9EBbPmhoFAANyr3wHNxNeIFqauHTGWRQhctqCBITNaa3jvfiGg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795703526;
	bh=JnVp2g6bl8bXQ04S1s4Aw+VDjJMQ8hK/5OSZygbfPZY=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bf4ZCBp1EL7FOA3GW0r2/1pNiMMFWgJI39aIOU7FiviK576D4NS404VRWSn4Amkfs
	 H5dZg2Hfgfghg5xqoLRvh/P+T3J8k5z5VP4cDEBznxG0CdutjkylK5r1irK9AW/Djb
	 vTszowWocRl5IExBtD3TSsIAaEEIEZ+d2dNyd2A/0MAlb9C3Fx1RL6NGjjT/BrMbvo
	 iPwdkRx5BD0gYKTejlLbLd/oT6Ww7mmukMBSkErfYvt2GayLxnBWBO/xFIfqtC1KSF
	 0zu3BmZpbhQ4wo6r0T356V8RFPE029bjDNorCqNxu88lvxf5PJRyvPpgOpctxEJxu9
	 7MIEzj1ZxdhfA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 077E160AC0;
	Thu, 26 Nov 2026 14:32:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A3DB3311
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:32:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9460180816
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:32:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3VGov5b8aVfO for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:32:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 71148811AA
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=ZIrIDmc1; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gSsisN7u
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 71148811AA
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:31:59 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQEVAEf088634
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=JnVp2g6bl8bXQ04S1s4Aw+
 VDjJMQ8hK/5OSZygbfPZY=; b=ZIrIDmc1WJ6FXK4uYfy0vM2UKcJZu2TXfWZCmc
 oX0WWUYILTrjB0elL0Sgo6HFLfAS2klMeiyzarfEjG+bIlIFxCftLVco5jMzGpKg
 w+b1mcu7oCpNcHww4KXjmz85kzuqptUBZcV1sMl0ttBqL0INAaJG4ePY+1JyuFpW
 55qNIcVRi70gmfjzT1TbWyCf18tWy3KNuvWSjFiRzCb2EVyfGW2OC9Kpc8dmF8O2
 kRMPJ9XCrpuQsABeKDdPyLelAIlBGuzojN0VE/zXgF/1P7tEXL9jxRAtMGrYd22m
 Ktmii2/DP+2RaAmcOqqKRZmofb/0VRvrUcYV6y+HHv/jndDQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6hm8171c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:31:58 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5e93fab204bso5654447e0c.3
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795703518; x=1796308318;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JnVp2g6bl8bXQ04S1s4Aw+VDjJMQ8hK/5OSZygbfPZY=;
 b=gSsisN7uuYU039JrF495hxZDQHdPXQswzmdzaUP5fKbQgJIq+l+Ffe+3+RipPdrxO2
 j23iMRbasiOyuv0VIv2I38CFFfGiNTeqhN/LAzIBcSbIkeCsOcGFwI6N2KuCB/dhcjyJ
 Uvscjd/68FTYeE9Bv1PlPgF2TPpGujEaSSVFqgqcd2wcNqKCeGpsLh0i1NeABI1+bKdh
 FirFxMMx8ftQlwEtvvjrtJjw4UE+KbUIzmeeIT9ps3r/JHQLTceRhZ8801Rm2ocWlLVt
 gEh0bOGyp/HQ0yijx6+21MBX7xeW4nxNuxmf8QZEHLmrxuCVGw34okd1TPb9xh8XxyJD
 vq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795703518; x=1796308318;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JnVp2g6bl8bXQ04S1s4Aw+VDjJMQ8hK/5OSZygbfPZY=;
 b=cFI9D0GJW38EbGrBYoxdupBvk76CFVSONHSacxMuJ1M2ZloW4++qVuQ5y76uJBHjvC
 l+mf3iAiM4waPajuNNShoMOo2L7bPl7TR3fb00b8qWmGhLMiXX1KmLGjmLA9Ywg9PR5u
 +2EkTfjJAbvCe1TFjodwo62rVSE70Qp5N5Vunh/BXadsDIyLdY3YU52cE4sd7ILO86kA
 62hsSIDEv080KaTqMVvs8iBvi74aS6HtdPNGqghrlr8ikGjH0bXNplP9EvXKKernRdFg
 IsRr27lq3CIVBRN1JO4M9XEp5tPe6DjEZU8i92yLdzB5P0BJO0kFAGyh5+2PEm2BuW/2
 R7gA==
X-Forwarded-Encrypted: i=1;
 AL+hErHt4VUSqhmXoO+Xm9qeJT/+cseTEXmUzzhK3qPpojFqR1lxGgqzSvTNlStd+bBTMQDBBs+CLL4=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/aTG8Ph9Moo4/znaGH+ETMsYY0cirxAhcUmaa5TdmCVSvRUZj1
 SzPIRs4p79ZGX2Uvk/4O5vdBrOOniumx+6GmG+L7M/wSx5tXiyzw2/qSLLaeNeN0Z7m4Vh57xOZ
 VHkk0yRgVbieQ6Ya+unqT67vzpaMScyySsP9AXCQOZnJBXZenj8XyhagaPyMa84KcaqKGQcFNf+
 lENUQ=
X-Gm-Gg: AZFdTZcNJq8x7kzdamTuYGLSGVy0s4LGCl1V//jbeiGmfURGlcsJY4hLDjgxDiTeJOr
 C3ldz6KddDeQ1uXe3ARvsB9qpitlmu2bxAqk220srAZIY93eRIaLWBIEFl7uqYs4dnl+EOM16/n
 zTDbj2R8VpWq0vn2uyrIb2RFYMvrfcqtEVTpInzENj8ZSmzu/9C5F1KCUkPSAmcAH2gPMwCO6dm
 zrsYVb3RmuO32rn5B6qC1fM2mKLXDFgn8A4ahaOvRRksv3SaAyuDY40kMnkdlYv1541dPornXg+
 tosLiHB/LIAqQAFFiCjQ3k66Qc8lLGpjlUYI6XEP99vd9cP87ii5L0rzOvoBRTPx3hWAA9E80GW
 J+jdceAHpt5DUCTCtUuWUnYMbBMJasocf5pFZA+qCqsFsR6Gc99oBV5dL2rpPBj5pKT4l6toquT
 vPHWMoEoTj/hgq
X-Received: by 2002:a05:6122:616e:b0:5ec:4653:2431 with SMTP id
 71dfb90a1353d-5ee8af08643mr13561674e0c.15.1795703517911; 
 Thu, 26 Nov 2026 06:31:57 -0800 (PST)
X-Received: by 2002:a05:6122:616e:b0:5ec:4653:2431 with SMTP id
 71dfb90a1353d-5ee8af08643mr13561636e0c.15.1795703517404; 
 Thu, 26 Nov 2026 06:31:57 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b030ed9sm772664866b.86.2026.11.26.06.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:31:56 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Subject: [PATCH v2 0/4] qcom: RPM power domains over GLINK
Date: Thu, 26 Nov 2026 15:31:50 +0100
Message-Id: <20261126-qcom-rpm-glink-v2-0-15707dc6f396@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WMQQ6DIBREr2L+ut8ALSZ01XsYF4BUf6qi0JI2h
 ruXuu9mkjeZeTtEF8hFuFY7BJcokl8KiFMFdtTL4JD6wiCYaDjnEjfrZwzrjMNEywMlvzCjtNJ
 M91BOa3B3eh/Ctis8Unz68Dn8if/av6rEkWEjpDROW6vO5uZjrLeXnspurktAl3P+Au27nsOzA
 AAA
X-Change-ID: 20261115-qcom-rpm-glink-5140b9a9a0ad
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: zP5qp6O-FgUAyfHpveCGxrNCXrzKKAfx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA1NiBTYWx0ZWRfX1btEvSz2iQ/Z
 lI/g/f8n5UkB4JRe5LH2UrFthipSnw9mYV1Vu6EbgE7bYO9meikSQ315UlJB+1UdOPotmSTx20s
 /SosxoDnSbXyd2gDvsqNfvGypnK9OuI=
X-Proofpoint-GUID: zP5qp6O-FgUAyfHpveCGxrNCXrzKKAfx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA1NiBTYWx0ZWRfXzAHa0+GboYDP
 yLjKS21IO8IvuCHDWSGl7JEEeIVtbsKz73ht6tam6DXcHN9ZGFGwJ7Buciz5Ln6LdPP58+S/H3k
 xte7gPpXtZWdDBuJ4FzEqEugukiPZP37DtrRJF3VcAEc4mPg1ffT2BINblbQnu18N+PrXJLeh7X
 rZg96woNIF7LEbVgWB89hWTco0Vx7krYM58/l/CaiUavZcVCOoJby/qNUk8Biw0BD5DMtL/aiNk
 gGVBk65DelraxazMAd3t7usFF0LMAk4j+Hacoo9F/c1MmBdOzKpao/kzl5enEqNRo8CuslSB/2D
 yXfejHRJPQ0d/F8245/GD3We5+21lOFZaljz/6OfW9WqFZzrw9cOaUI8JiWmOx6GgRVzldCdwcb
 mQk9kV6C435Gc1isWEhWUvLE1FjCe4HfvVwB5eVtHKP+58brZTMDDbKBHPyuC5ve8qRWQGgacYj
 iZohMSC09SACM2XBnTQ==
X-Authority-Analysis: v=2.4 cv=O/usLx9W c=1 sm=1 tr=0 ts=6b0842de cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SDtVj0WfO2EGTSlb_voA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_03,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260056
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

RPM-based Qualcomm SoCs (QCM2290, SM6115, SM6125, SDM630, MSM8998)
vote for their rails through the RPM, which U-Boot only stubs today.
On QCM2290 the eMMC therefore probes with "power-domain driver not
found".

This series adds the APCS IPC mailbox, RPM requests over the GLINK RPM
transport and the rpmpd power domain driver, and enables them in
qcom_defconfig. The link is brought up only when a consumer needs it
and is handed back to the RPM before the OS boots.

Testing, on the Arduino UNO Q (QRB2210) with Linux next-20261112:
- the RPM acknowledges the requests and the eMMC no longer reports
  "power-domain driver not found";
- Linux then binds rpm_requests, rpmpd and the RPM regulators, 10/10
  power-cycle boots without "Invalid open ack packet";
- with the link forced unusable at probe, the eMMC probes with the old
  warning and Linux boots as before.

v2, same board, with the GLINK RPM nodes dropped from the clock stub:

                                    RPM nodes     eMMC          Linux
  v1 (stub entries behind #if)      RPM drivers   HS400         boots
  v2 (stub entries dropped)         RPM drivers   HS400         boots
  v2, RPM drivers disabled          unbound       probe fails   no boot

v1 and v2 give the same driver model tree, and Linux logs no "Invalid
open ack packet" with either. The last line is why patch 4 also enables
the transport in qcom_dragonboard820c_defconfig: a clock stub user with
a GLINK RPM node in its DT needs the transport driver from now on.

Biswapriyo Nath tested v1 on a Xiaomi Redmi Note 8 (SM6125), including
a regulator driver of his own on top of the transport.

Not tested: the other glink-rpm SoCs (SM6115, SDM630, MSM8998) and
Shikra. DragonBoard 820c (MSM8996) is build-tested only; a boot test
there would be welcome.

---
Changes in v2:
- Patch 2: no #if around the GLINK RPM nodes in the clock stub (Sumit).
- Patch 4: drops those nodes from the clock stub in the same patch that
  enables the drivers, and enables the transport in
  qcom_dragonboard820c_defconfig; retitled. Tested-by not carried on
  this patch.
- Collected Tested-by from Biswapriyo on patches 1-3.
- Link to v1: https://lore.kernel.org/r/20261115-qcom-rpm-glink-v1-0-6255beacc93b@oss.qualcomm.com

---
Igor Opaniuk (4):
      mailbox: add the Qualcomm APCS IPC driver
      soc: qcom: add RPM requests over the GLINK RPM transport
      power: domain: add the Qualcomm RPM power domain driver
      qcom: bind the RPM nodes to the RPM drivers

 configs/qcom_defconfig                  |   3 +
 configs/qcom_dragonboard820c_defconfig  |   2 +
 drivers/clk/clk-stub.c                  |   2 -
 drivers/mailbox/Kconfig                 |   8 +
 drivers/mailbox/Makefile                |   1 +
 drivers/mailbox/qcom-apcs-ipc-mailbox.c |  68 +++
 drivers/power/domain/Kconfig            |   7 +
 drivers/power/domain/Makefile           |   1 +
 drivers/power/domain/qcom-rpmpd.c       | 169 +++++++
 drivers/soc/qcom/Kconfig                |  11 +
 drivers/soc/qcom/Makefile               |   1 +
 drivers/soc/qcom/smd-rpm.c              | 772 ++++++++++++++++++++++++++++++++
 include/soc/qcom/smd-rpm.h              |  41 ++
 13 files changed, 1084 insertions(+), 2 deletions(-)
---
base-commit: 36d2b7b46c77b44021f0a6f36684a123e5560492
change-id: 20261115-qcom-rpm-glink-5140b9a9a0ad

Best regards,
-- 
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

