Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57092606A333
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 06:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Hj43JNHy;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nUbqgtDs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LiIswr+W
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2649860793;
	Fri,  6 Nov 2026 06:08:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id htixLoWP1HZw; Fri,  6 Nov 2026 06:08:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 573AC606DB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793945297;
	b=BJjP8oikEYgwKb/uKG+nInrZrsZyJniDOv7DGVIBNdcaYdiVFUstruCQs1lt2ViC7hdk
	 xaRTjLaXYnciRrqh2tnkwV3APfkAT+Kvtc3608Vl8cBbG0lXTcqC2xt4r5p1A/0QMQvhz
	 cELHL7ynDoLWmuLGir3HmdtKiOO/M5wQT+XBHuh51KkYy/gJTrhaR7ZgMTYff84c+wkgJ
	 2mEqn1bu0orsX7gs5pLYmPqknxI+N3DLnomqGAwq/FPd6/73vH4txYYDVkRE9cIuO5Y5w
	 /Vkd7yrpQIss5juzcq3iKAmrg6/5uhuJeH572tZLGSBbsoZFuBOujxDSq4AWgmjhq0g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793945297;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8mGrGwjIiZWAd6cMbvznvP/rJZH6J0fLdKolQVkoY8w=;
	b=a9sqoQwerRQt+DhDqkysL4D1nPf+hVbnq7zLngJ4NeniMY8foqGu8PVZJlKVfpE+JtYQ
	 qqnayfemiAHDPKNC+wAOChV6s3AYGU/hNkXqdmvLXONQAJ5cCOtQbMUwhMYzWzIQuKwxi
	 CcqqPRevbi2NFmnLCG8CPqZT31l7ZaLUDQjTypKDjERWFTMiQRNeKmYCSy4gXzJsslHec
	 kB3zFigDd2m2DPMolP8fgnJiLLdKINuUFrJ8TAe07FzH1svLSWNVUldylL2gh8Ts2DDli
	 T6ZT1gMwNUsiJpiSa1cBfKunNB2BBlNTp+0K5c1V8Q3W6nEBMq2oRFMxA6CbTGaUvmQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793945297;
	bh=8mGrGwjIiZWAd6cMbvznvP/rJZH6J0fLdKolQVkoY8w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hj43JNHyEBTDDBjo53C3GFNnqerRwQhCYoleUe/WtyHQ9a9j1STOULZOpONFry2dL
	 tszV/izuBa3pSObItaJchtqm5HXwoZJTQ4ctA6kJ6U+irvmU4OerDnleZeQcW3UW3w
	 tTw1CoKxYv4Z4YGyt7cBkxnbeqhejJADc88PFxoYBz3WSkM7oBXVKi/wLTN5Tfjs6r
	 naIJznAApMy8/FOZrytW3/st+63GS3ND/usAVSqZu0E//uEgsEZodaer1DqkGwqa5D
	 yrd1153li1iC0PMUPtZnTh/OHu/fhODQtDB4eALvIfvjLsObgNI/v0q2qVZynsLAXP
	 HeaFj6127m9Bw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 573AC606DB;
	Fri,  6 Nov 2026 06:08:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B4AD2FE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:08:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3159D401EC
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:08:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SRYH4keJ4N8T for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 06:08:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6CC4A40070
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=nUbqgtDs; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LiIswr+W
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6CC4A40070
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 06:08:14 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A63xtlu1866661
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 06:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8mGrGwjIiZWAd6cMbvznvP/rJZH6J0fLdKolQVkoY8w=; b=nUbqgtDsBlbyfrXY
 kvCFkxdiQBsTdqOYTI8/gl6RCtdYhfpWscDoBJUVlhK0pol44zSiqyxeTt8+PNeK
 OrzciZTdiXivs68Q+ZoGm3sH1y7xMcvc8WDJ9MT9beqY6heGBYjqgViuUoSJelcS
 FEsMtUsiFca0VNzeRUIVTPKsrrh/qrI6XmjqcAJrY2kZ5vEfhphtqCqHb2tl6fUN
 iQlscnoOymPX/mtruKzm9XlXsLP1pLBZdxT1HrHPXGHH3w4AOvFhd319bj1Vv+jd
 wv4fpyJPMsfF3Osg5wZ0S6468rXaLZyIA2xhGUYrewvoOKihgEa6gPSPjf3JtH9x
 z6x2hQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p997ac-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 06:08:14 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1b20a4b5f2bso552467c88.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 22:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793945294; x=1794550094;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8mGrGwjIiZWAd6cMbvznvP/rJZH6J0fLdKolQVkoY8w=;
 b=LiIswr+WM6cN2Gx/6z1PKd83tYLZs0Fsr2unzmclIw02h52nb4SDeI6g9y8kMg6aay
 OoRxgOtSLV1+lv0vrGr5WzvBvX3x+Q39WBXFXOyjLD13dUFxtaDOEUanfoghF06Dz2Ff
 xFkGlvMiqUotmpyMwnAitN72QSX5siGYJcTMC4Fc7sWNYA9gz9ESZ878cU/rt7oi1pS+
 d2qtjJPK8mC8nP3vEqbzZW+3OpnynnVhK/g1bWgSJOVSzHUEH/houdZgEZ+pFUXtokI4
 h3ViPfNNnbUhG5z5EVZRSv5g9BBMcNeq0d2qqQQs5XV3eXVA7jjOaGGYnf/ZDQFfUJb8
 sTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793945294; x=1794550094;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8mGrGwjIiZWAd6cMbvznvP/rJZH6J0fLdKolQVkoY8w=;
 b=YCRE2n6C5uy3KjTbVBAGlswhqbT5e04Qt+WmNqGxWnZxpr2A8TEZNkG1Ev3YMnslKt
 HIUHj5cWXFcMJqcXSgVH5ewG7EklCej1El2xx8o517hbmdYEmyTtXvlU9spwfzoUyQ+/
 phwBGY/2T3AGWfw0wms0G3tVa9j8vplgZJynp4cc4nmHc4H/Ds555GFUcA2rDkYK9Wi1
 PHWw7RCgPYie/xcVamlvXbBAa5oglp2PtkglOaiaJgDr/vz+43ilGDZ8YUpDO0tiZKUw
 Zm7rzJ4LL2V3othE9PbAa3lVuKTr5eE+I7kx72eQSv03kjxmbCd/ADY4a+x/EW+kXiUg
 18qg==
X-Forwarded-Encrypted: i=1;
 AKwUvBygpnRNs2cUh+jOejqr+dlj7dVCYvrTSgqKZNZBd6qO/NEpuajv08tb0KFG1jAJJaR4hcGmKBc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+ibZ99EQ0m/MThrlrLBBfin7IaOCc2iWntfeNwDZy93uAglety
 0GYNl5Q1tkBFxukK3CbkFTFifEMIw8hpi8kFo+alQ95eq9lJZ7BDcyiDuCH9YIXD3qdcWdIUCwv
 N5/xazv6tWq/xmPuXZzQ6dobGZ6NYtchGDBhMLL54TAoCfbjZ1AR8MbfxnDf4/4Q0+Z7qdVw=
X-Gm-Gg: AYBFou1GvhqdnuwNzQcj9UgCfAAE3yTwU9Zlj3YjcHnGTs61gsRzTxCbEqZeZ15v1LW
 pNqRuFg0DCnr8KN/zXQBECPgpN5822yTVo/I05dqr4qUz/6JrvmZnxkQW/hR+BUwiY/Swi3fCEg
 OkMZ7rvhEdv45o/D9Kp89YsgWIT6mCp+12hZIeEjoxugDzcn4DXybUZqYslox4UtB0n1LoT+sKW
 eMd/1KUYHUkaXDKPAS+WRBdwnknQz3Yrl1/UZS31zPhravVwTfH8cSg71rbSnkyUeRaj3y9NNNy
 iJeJzK13sMcokIovC+9u02tteCwEx9NQIfLv/1W8+ptT/+9tVQ1LBRKVcIiZmBFyKH4vgounlJG
 k8asRgyKCItEAKb9a1w7sHkvyYHT6dNCwst8gAI89G7CzWBfiaEH3EA+fmcmUgiyhMlvNftUp6/
 +wTbGnCaJ42+HhSyx+/AGRzUCS5kx3C9cfl2GpH1a1L+6eIqgLBnkE0KArGyj1+tX5ZY7+oS3A9
 r4iUF0=
X-Received: by 2002:a05:701b:465a:b0:192:fd91:c567 with SMTP id
 a92af1059eb24-1b25d315b9amr1656372c88.11.1793945293339; 
 Thu, 05 Nov 2026 22:08:13 -0800 (PST)
X-Received: by 2002:a05:701b:465a:b0:192:fd91:c567 with SMTP id
 a92af1059eb24-1b25d315b9amr1656330c88.11.1793945292432; 
 Thu, 05 Nov 2026 22:08:12 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b25e4a610fsm2341373c88.11.2026.11.05.22.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 22:08:11 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 11:37:45 +0530
Subject: [PATCH v4 4/4] tools: qcom: mkmbn: Add support to create multi-elf
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ipq5210-v4-4-5af12cc2b601@oss.qualcomm.com>
References: <20261106-ipq5210-v4-0-5af12cc2b601@oss.qualcomm.com>
In-Reply-To: <20261106-ipq5210-v4-0-5af12cc2b601@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: U-TGA1peEh_IZBiPwDj3t3VVnpFhuCQ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAyNCBTYWx0ZWRfX1ypYmv+xeZhr
 yCKlkQ6j9TkTz/h6F74SMxzWI79eOn2G62Qown3Sc1dd4ETD7nZvtvxTXCLf5by7eUMw/uPw/BO
 8LzfHNmvPohFvQz5Lkbezp6KM0KufxLpb1nSBWAlyZOX5WEP2zx3C8PRHTWeriJ8GNjBgZ/vJRZ
 XOM+Fv4SPOOIIbrqePHCCxzYftkx3TOplfJ+pd8eWPQaSwl2IrnjjKGRuqoO03OMEnA6db72IPE
 4xAIm1MA1uBgWAxcMoJFEhEab6iM5GuedYlVLpfsFLqPuqXv53fvv3tMJ8UcAo8dsiDfBA3g+4J
 fvc2lwwyxj7+CCUO1efcLonM3awEWBqG1UYIMdj7o2nL/BCAlWh9spmwLlCEDUuMn2+Ue/xuTII
 TQ59vX7fFK9Mq7VwZf6/veqn/fvLmric3VqxAI1bo8OaHvT34pAo6zZ8UKPzH7EMyKlB/mq83Cv
 T+BtDE8ZhClwIx/fRvg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAyNCBTYWx0ZWRfX+cVDywbWbJTN
 DzdoY6+kS1tciE5r3F3Nv7yeH5fu3ZYP4G8BcXmYfsB9pDZWUh8DCnsxdWeBr0Lq81Lg5O/V0Vk
 DABBKNy44g8x9nY0aiIL6pSvXS6bQxs=
X-Authority-Analysis: v=2.4 cv=WMzqzXsR c=1 sm=1 tr=0 ts=6aed6ece cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=R4u_GeB_J0YJdhSkb_YA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: U-TGA1peEh_IZBiPwDj3t3VVnpFhuCQ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060024
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Modify the 'bin' argument to take either a single file to convert to MBN,
or a list of files to be combined to create a multi-elf expected by the
boot rom.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 tools/qcom/mkmbn/mkmbn.py | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index da4d45b600a..7afaa463d87 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -110,14 +110,32 @@ parser.add_argument(
     "-v", dest="verbose", action="store_true", default=False, help="Verbose"
 )
 parser.add_argument(
-    "bin", type=argparse.FileType("rb"), help="Binary to embed (e.g. u-boot.bin)"
+    "bin", nargs = '+', type=argparse.FileType("rb"),
+    help="One or more binaries to embed (e.g. u-boot.bin) or create multi-elf"
 )
 args = parser.parse_args()
 verbose = args.verbose
 
+if (len(args.bin) > 1):		# Create multi-elf
+    try:
+        with open(args.output, "wb") as f:
+            for path in args.bin:
+                with open(path, 'rb') as tmp:
+                    f.write(tmp.read())
+    except Exception as e:
+        print(f"Error: {e}")
+        sys.exit(1)
+
+    sys.exit(0)
+
 elf = Elf()
 
-data: bytes = args.bin.read()
+if args.bin:
+    data: bytes = args.bin[0].read()
+else:
+    print(f"Specify the binary to convert to MBN")
+    sys.exit(1)
+
 
 # dtb is at the end, so find the last match
 dtb_off = 0
@@ -155,7 +173,7 @@ if not mbn:
 if args.load == 0:
     error(
         "Cannot proceed without load address.\n"
-        "Ensure CONFIG_TEXT_BASE/CONFIG_SPL_TEXT_BASE is set\n")
+        "Ensure CONFIG_TEXT_BASE is set.\n")
     exit(1)
 
 log(f"Detected board {match.decode('UTF-8')} with load address {args.load:#x}")

-- 
2.34.1

