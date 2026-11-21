Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD97606A33C
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 06:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NaHPU0Ch;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CctdJrSq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kkArVEp5
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A2FF81695;
	Sat, 21 Nov 2026 06:40:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vA25_5YOsuHQ; Sat, 21 Nov 2026 06:40:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D84F381669
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795243245;
	b=UXFKh8zSmM00+f+MMtIguDBqvAZpt550S7NT3LZQusIkBrYl+bqQGV83Mv1DLLkHCHXy
	 JyRzyO8r4zZJrTeE60vx3j9d3c8KyygX0bVqPnGLxCWCxzeZhtK1kHSw725rWq2ahpxw6
	 NSlGTvxYq34DbzZz/54eFR7PkCAQ83a6M3HpQHp5oMIriPt6qX/C590V6yrGrMp8l0YvM
	 P8AbSmHV/syVfDjSidtqde0UzEZPrLRALRkZWNnRxBAAH1ykzbaXek4TD9aNgMLDe2yRw
	 Magmj1KC9iZ0plOe63y60yMNJe/p/nfvwzYmv+I87GEK7CUsonsyGc3t9t75AksTxsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795243245;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SlpWy0QVUQNWOIcYredQNP47TxQfdRy1vwIwzOqWdgE=;
	b=pQMgkYOYSxx8gLQ3UOcETYOTy6U30Sfez8e2vIomUrbuGLMOeiSkWM57R4KDZD6yrqDK
	 bimBrHdXKmUnVZevYKUwEVBoJ+Kstr1YOEY6RgwxVjfHyvw5L/nwPZtkyKmmbEBfsFZKH
	 3L5MMQVj8bXRkCzafPjOt7NlWZP6OIGKKMAudw2KT2imtsvaq6kxUQj3CzBNpg5cpB/iP
	 jN3sEwvFGdJ8q0dkNb1eJQhe/BN5yGPWBI3BF92RoaqW8TTFvEj8hN6yByuPMd+Z2kJwS
	 kwXN79sF4XdbU4fHa1sS72HHQWNqviia6wbyFfa7hQuwSg95PZ14+/e5P1MKaQYfYrg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795243245;
	bh=SlpWy0QVUQNWOIcYredQNP47TxQfdRy1vwIwzOqWdgE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NaHPU0Ch/WBjfruVNuchSYm8Mn3/DBxzTCHEcsRB+UCFq/cFiGjzFoS57TieqfVAH
	 MNXl/tAJStoJO23wcKOTTl3AKd2jyfoiGoc560XqfMyR+2eSJBMP7DDlzdNHdxXWgi
	 L5/TFRx1LkzGS77qxvtbA1vSK0nGXehjnSIOQnWWa8GSpNPK7Zg2aRNWHJRzKVxC94
	 PKWkDsHMiCG06sa57IHuofoaJGeAfqFp+r1Cf7X1smBM+dnhtRPoC9KHLuAcYTXiwo
	 nhBRe0nQZS5XVh22DrNjBbKOgCH6YuZ9ebM+y3o9uMCrF57RD3zZpDcdDnx8Ttb5x6
	 BkH2ql16SByow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D84F381669;
	Sat, 21 Nov 2026 06:40:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8F237971
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 80E8160668
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OHx9yQZQV81a for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 06:40:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 08EE460665
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=manikanta.mylavarapu@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=CctdJrSq; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kkArVEp5
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 08EE460665
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:40 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AL4mLl02869019
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SlpWy0QVUQNWOIcYredQNP47TxQfdRy1vwIwzOqWdgE=; b=CctdJrSqUtCb4iTK
 S546OyQbeJr73aOfhMrWxrEtTm3Lj0TBtIU5vsVAv+uYbEOjNcsWIUoZmZ27fNcN
 i78h30jGfRCY8TASYPn0cmyrAbYnrjb3fwsojQN2jjW3j+lbFisNjALnh8DXNk0f
 LqxzdJuDqnvNuiRxfa92vj7h6aCT+T5bibtkxLf1XRsKxSJz/0XswSZCIcrANDSz
 uBIxwm+5kGOrWXKwf6qon0W4ZArvNSasnCY5NuWr4dLN/ySNGMUgeYEJ4ZIBvcGb
 EX3sUGeeI0ZoJ3eql8BcFGvc0xMuyPuvHq6Jy2HNLw8JuKrYUnD+EAlL+X+qxQ0W
 52XAZQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j34ka06b3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:39 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3869865a304so1711029eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795243239; x=1795848039;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SlpWy0QVUQNWOIcYredQNP47TxQfdRy1vwIwzOqWdgE=;
 b=kkArVEp57L9jQifDR2m7D+bASqfZC+qSfQZR8nXEFX5fyTc4qZgRSeFJMlsHiEYhrg
 l2QioVcizBZTeHgK221OgGQY/QaxR7Sz/HxPw9AV1QyQGiuAD+nBcUaOF1JeWNYyCxYx
 OD/06hteSCo8BLa2LaMPxs9qKtdz4ZeFJM5r6oFhX35jlwKx/tHwa0PScph+tFmiSLJA
 SKUGvO9vQQtLO5XQaggF0vrOGdwgdhww1WjV1WYmMW/0BsB5r/DFBk06KgMwpvaB3QkS
 5YVCIfXhQLyawzTTQMgzeqxtrpPQRO+QanZrSbSQt4GHyumvaa/z/DoM8fGNwixLG3Vy
 dG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795243239; x=1795848039;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SlpWy0QVUQNWOIcYredQNP47TxQfdRy1vwIwzOqWdgE=;
 b=bJvY9RJ9ag5+YUBBEBjPguxG80rNCUP9ycvzLLfF1U5pVAcIitsNZqC/+61+GLCHHz
 RXldwnDAhqkKZagq/aHN7muB6JNCG64QKBiDkT4DFMV9gAoqSQO0WT6lnU5wfxo+7Q52
 L6306UUav810LY7gu+D4znY8dD8G9IDbPkfFFCuSNQ0GAxm1ZWqiEFbHo9e4FG2BdoN0
 GssETUfPswwcF7pdq44hDJ1O8A7kc3tnAbQZjSnvWYCCznj5b0BwGkDOHVVLFZR6XPRf
 7x3iEGBcPU68nSNAuOtEXKPzrG5RiybjWeBjIDR+jmz7m9xsEb4vxO8kcFGLfw2JJu/+
 eT8Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFQ2AysFyPy5M/hPOYx88C7QTtbfWbA87xY76ezSJLYf2k9UInWRkkaOZIZ0MppwZcq/nidzgQ=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9geJjAqIfyGnCo5DJ18HNyOi4bMSFosB4tPT+6Nd2n+D2+Uvzs
 acNMCcMNyjchUuVkJTbBtt+uJZDnbdH0HCf5V2ne5qYxssmqQhTUdOBFzrY4vCw0WQcrHIgI4N6
 1vCFvJQGABa0GC4UeM0DwvMQha2YQQ+SL1huHeWBvgUa9pJGxANA30zLHYWH0lw/fhRWwyGU=
X-Gm-Gg: AZFdTZfV10YeTAQubq3K4nwxsKAuLZLKn+0YLLnHH5D1rVVlXMUaAbI23K2Ash9HK00
 4r4HMPjGEcrtcWo9ek+gHSJNVNYyy+f1Cv2Oymmd8kOppKyx6asOdApO9P9t7LqfZtP2SiLDVJH
 Ow4Aas4KXByPuLmBoFrMoFl0M8vmELtVVKaZ6nk68r0h2Kc27fR9PbbcE/2GEFA3Ulz0hI90eXQ
 HOgyOWBo6ai3LShQFfzh0fXKJSx2PSkEbwonQhCEHluB4RFpbieCPfYe1vm/OgWgQ5d6BxvaBtg
 WHpXO9bfrD0YpP+UIedzvLRQzq45tScC6Kiy26dWfei45DuweaF4ZX1BbTCs1+z2wDayz3MrvGZ
 3Zr52fnLdl5PSrkKEZXlDwxPOcdt+LcAaKoIIqxTZP1unLWMUyuHVSADnHaCLFUh/fU7NMQGEku
 Rb
X-Received: by 2002:a05:693c:60d4:b0:360:5f7e:2eb9 with SMTP id
 5a478bee46e88-3857111f65amr5983634eec.32.1795243238915; 
 Fri, 20 Nov 2026 22:40:38 -0800 (PST)
X-Received: by 2002:a05:693c:60d4:b0:360:5f7e:2eb9 with SMTP id
 5a478bee46e88-3857111f65amr5983599eec.32.1795243238125; 
 Fri, 20 Nov 2026 22:40:38 -0800 (PST)
Received: from hu-mmanikan-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd46c5sm16970487eec.11.2026.11.20.22.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 22:40:37 -0800 (PST)
From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
X-Google-Original-From: Manikanta Mylavarapu <mmanikan@qti.qualcomm.com>
To: trini@konsulko.com, lukma@nabladev.com, jerome.forissier@arm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com,
 manikanta.mylavarapu@oss.qualcomm.com, deepak.g10@oss.qualcomm.com,
 dlechner@baylibre.com, 3305708832@qq.com, jstephan@baylibre.com,
 jbx6244@gmail.com, dlan@kernel.org, anshuld@ti.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Cc: kelam@qti.qualcomm.com, gpotnuru@qti.qualcomm.com
Subject: [PATCH v2 3/5] phy: qcom: add SA8775P DWMAC SGMII SerDes driver
Date: Sat, 21 Nov 2026 12:09:17 +0530
Message-Id: <20261121063919.3313168-4-mmanikan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261121063919.3313168-1-mmanikan@qti.qualcomm.com>
References: <20261121063919.3313168-1-mmanikan@qti.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIxMDAyNiBTYWx0ZWRfXxBJK8p7kXZrc
 jg0tPfcCQaLhnUZsWffNlUgY9a8G5C500vJrqhgxtywqtwy+uiu8du5pErQH4ELVGBgJTslyjsb
 AWSPLr73YnRxrLFHNCI//DS5xBrSq4eGr4LdkU4dt5PEctbMb10VWLS/LOXeSL/+eJBT9csPT6W
 21x61xjxd4AFC+EUThC+jGq1EpSwFmgs01qOQObGNjIftYFhK0GgJOh+i2BrANyF9N6I9ZxMKcf
 X98glL9cgRjtxjBPJgRxhGvJOMsZwHl3rjWZYkxSi30q3INZ3q+jJNhxuh+U1k9zvbPdReE70DH
 9T78f32umNO6IU98CNA2CGXGhizlrSah1oHrLwd3eKRytlzYoeLXSs3lRh+e9FtH6n9yCLAbgNM
 4Vxx/zycXQ7SD+YDDb8aRy0JXQhymCbVRaNiEoRNJ69RHxKjU+0Hh5MMURrowcfiGR6Y2O+EgeV
 2Hxm1ZWYgUOoyLt9IGQ==
X-Authority-Analysis: v=2.4 cv=RJEmjIi+ c=1 sm=1 tr=0 ts=6b013ce8 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=504pF03LXijlR9FUMDYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: jA-c3Ak23qJXkOXjmWQc_FhuChsH1KtZ
X-Proofpoint-ORIG-GUID: jA-c3Ak23qJXkOXjmWQc_FhuChsH1KtZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIxMDAyNiBTYWx0ZWRfX1hbiZQFEspL1
 4YhCAwfHisteiYNgIFqGlE2LrQyUkoZyVE5doZUHJjE/eZwTcCTBahu3c0BolEk2wrwYyA1HxWp
 qVDDkb3JB7PG+gKN16s8orePtpKNzwA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611210026
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

From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>

SA8775P integrates a QMP SerDes between the DWMAC controller and the
external Ethernet PHY.

Add a generic PHY driver with calibration sequences for SGMII,
1000BASE-X and 2500BASE-X. Manage the vdda-0p9 supply and sgmi_ref clock
in the PHY power lifecycle, poll the SerDes ready indications and allow
the active interface mode to be changed through generic_phy_set_mode().

Signed-off-by: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
---
Changes in v2:
- Updated SPDX tags to GPL-2.0-only.
- Used the yearless Qualcomm copyright.
- Removed Linux references from comments.
- Removed unnecessary braces around a single statement.

 configs/qcom_qcs9100_defconfig            |   1 +
 drivers/phy/qcom/Kconfig                  |   8 +
 drivers/phy/qcom/Makefile                 |   1 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-sgmii.h |  21 +
 drivers/phy/qcom/phy-qcom-sgmii-eth.c     | 486 ++++++++++++++++++++++
 5 files changed, 517 insertions(+)
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-sgmii.h
 create mode 100644 drivers/phy/qcom/phy-qcom-sgmii-eth.c

diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_qcs9100_defconfig
index 342f128726d..a47a7829c98 100644
--- a/configs/qcom_qcs9100_defconfig
+++ b/configs/qcom_qcs9100_defconfig
@@ -16,4 +16,5 @@ CONFIG_ENV_SCSI_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
 # CONFIG_ENV_IS_DEFAULT is not set
 # CONFIG_ENV_IS_NOWHERE is not set
 
+CONFIG_PHY_QCOM_SGMII_ETH=y
 CONFIG_WATCHDOG_AUTOSTART=y
diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
index 1fdadaccb12..05897b26ddf 100644
--- a/drivers/phy/qcom/Kconfig
+++ b/drivers/phy/qcom/Kconfig
@@ -70,3 +70,11 @@ config PHY_QCOM_USB_SS
 	help
 	  Enable this to support the Super-Speed USB transceiver on various
 	  Qualcomm chipsets.
+
+config PHY_QCOM_SGMII_ETH
+	bool "Qualcomm DWMAC SGMII SerDes/PHY driver"
+	depends on PHY && ARCH_SNAPDRAGON
+	help
+	  Enable this to support the internal SerDes/SGMII PHY used by the
+	  Synopsys DWMAC/DWC_ETH_QOS Ethernet controller on Qualcomm
+	  SA8775P (Lemans).
diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
index 714013dc572..664f113fd9b 100644
--- a/drivers/phy/qcom/Makefile
+++ b/drivers/phy/qcom/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2) += phy-qcom-snps-femto-v2.o
 obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2) += phy-qcom-snps-eusb2.o
 obj-$(CONFIG_PHY_QCOM_USB_HS_28NM) += phy-qcom-usb-hs-28nm.o
 obj-$(CONFIG_PHY_QCOM_USB_SS) += phy-qcom-usb-ss.o
+obj-$(CONFIG_PHY_QCOM_SGMII_ETH) += phy-qcom-sgmii-eth.o
diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-sgmii.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-sgmii.h
new file mode 100644
index 00000000000..d033ec0d768
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-sgmii.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_SGMII_H_
+#define QCOM_PHY_QMP_PCS_SGMII_H_
+
+#define QPHY_PCS_PHY_START				0x000
+#define QPHY_PCS_POWER_DOWN_CONTROL			0x004
+#define QPHY_PCS_SW_RESET				0x008
+#define QPHY_PCS_LINE_RESET_TIME			0x00c
+#define QPHY_PCS_TX_LARGE_AMP_DRV_LVL			0x020
+#define QPHY_PCS_TX_SMALL_AMP_DRV_LVL			0x028
+#define QPHY_PCS_PCS_READY_STATUS			0x094
+#define QPHY_PCS_TX_MID_TERM_CTRL1			0x0d8
+#define QPHY_PCS_TX_MID_TERM_CTRL2			0x0dc
+#define QPHY_PCS_SGMII_MISC_CTRL8			0x118
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-sgmii-eth.c b/drivers/phy/qcom/phy-qcom-sgmii-eth.c
new file mode 100644
index 00000000000..92b0e8ce818
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-sgmii-eth.c
@@ -0,0 +1,486 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm SA8775P DWMAC SGMII SerDes PHY driver
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <generic-phy.h>
+#include <phy.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <clk.h>
+#include <power/regulator.h>
+#include <asm/io.h>
+
+#include "phy-qcom-qmp-pcs-sgmii.h"
+#include "phy-qcom-qmp-qserdes-com-v5.h"
+#include "phy-qcom-qmp-qserdes-txrx-v5.h"
+
+/* QSERDES sub-block offsets from the SerDes MMIO base. */
+#define QSERDES_COM_BASE		0x000	/* PLL / COM block */
+#define QSERDES_TX_BASE			0x400	/* TX lane */
+#define QSERDES_RX_BASE			0x600	/* RX lane */
+#define QSERDES_PCS_BASE		0xc00	/* PCS block */
+
+#define QSERDES_COM_C_READY			BIT(0)
+#define QSERDES_PCS_READY			BIT(0)
+#define QSERDES_PCS_SGMIIPHY_READY		BIT(7)
+#define QSERDES_COM_C_PLL_LOCKED		BIT(1)
+
+#define PLL_POLL_RETRIES			500
+#define PLL_POLL_SLEEP_US			1500
+
+struct qcom_sgmii_eth_priv {
+	void __iomem	*base;
+	struct udevice	*vdda_0p9;
+	struct clk	 clk;
+	phy_interface_t	 interface;
+	bool		 powered;
+};
+
+static inline void serdes_writel(struct qcom_sgmii_eth_priv *priv,
+				 u32 val, u32 offset)
+{
+	writel(val, priv->base + offset);
+}
+
+static inline u32 serdes_readl(struct qcom_sgmii_eth_priv *priv, u32 offset)
+{
+	return readl(priv->base + offset);
+}
+
+/* Program the 1.25-Gbps SGMII/1000BASE-X table. */
+static void qcom_sgmii_eth_init_1g(struct qcom_sgmii_eth_priv *priv)
+{
+	/* PCS: assert SW_RESET, enable POWER_DOWN_CONTROL */
+	serdes_writel(priv, 0x01, QSERDES_PCS_BASE + QPHY_PCS_SW_RESET);
+	serdes_writel(priv, 0x01, QSERDES_PCS_BASE + QPHY_PCS_POWER_DOWN_CONTROL);
+
+	/* COM (PLL) registers — mode0 = 1G */
+	serdes_writel(priv, 0x0F, QSERDES_COM_BASE + QSERDES_V5_COM_PLL_IVCO);
+	serdes_writel(priv, 0x06, QSERDES_COM_BASE + QSERDES_V5_COM_CP_CTRL_MODE0);
+	serdes_writel(priv, 0x16, QSERDES_COM_BASE + QSERDES_V5_COM_PLL_RCTRL_MODE0);
+	serdes_writel(priv, 0x36, QSERDES_COM_BASE + QSERDES_V5_COM_PLL_CCTRL_MODE0);
+	serdes_writel(priv, 0x1A, QSERDES_COM_BASE + QSERDES_V5_COM_SYSCLK_EN_SEL);
+	serdes_writel(priv, 0x0A, QSERDES_COM_BASE + QSERDES_V5_COM_LOCK_CMP1_MODE0);
+	serdes_writel(priv, 0x1A, QSERDES_COM_BASE + QSERDES_V5_COM_LOCK_CMP2_MODE0);
+	serdes_writel(priv, 0x82, QSERDES_COM_BASE + QSERDES_V5_COM_DEC_START_MODE0);
+	serdes_writel(priv, 0x55, QSERDES_COM_BASE + QSERDES_V5_COM_DIV_FRAC_START1_MODE0);
+	serdes_writel(priv, 0x55, QSERDES_COM_BASE + QSERDES_V5_COM_DIV_FRAC_START2_MODE0);
+	serdes_writel(priv, 0x03, QSERDES_COM_BASE + QSERDES_V5_COM_DIV_FRAC_START3_MODE0);
+	serdes_writel(priv, 0x24, QSERDES_COM_BASE + QSERDES_V5_COM_VCO_TUNE1_MODE0);
+	serdes_writel(priv, 0x02, QSERDES_COM_BASE + QSERDES_V5_COM_VCO_TUNE2_MODE0);
+	serdes_writel(priv, 0x00, QSERDES_COM_BASE + QSERDES_V5_COM_VCO_TUNE_INITVAL2);
+	serdes_writel(priv, 0x04, QSERDES_COM_BASE + QSERDES_V5_COM_HSCLK_SEL);
+	serdes_writel(priv, 0x00, QSERDES_COM_BASE + QSERDES_V5_COM_HSCLK_HS_SWITCH_SEL);
+	serdes_writel(priv, 0x0A, QSERDES_COM_BASE + QSERDES_V5_COM_CORECLK_DIV_MODE0);
+	serdes_writel(priv, 0x00, QSERDES_COM_BASE + QSERDES_V5_COM_CORE_CLK_EN);
+	serdes_writel(priv, 0xB9, QSERDES_COM_BASE + QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE1_MODE0);
+	serdes_writel(priv, 0x1E, QSERDES_COM_BASE + QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE2_MODE0);
+	serdes_writel(priv, 0x11, QSERDES_COM_BASE + QSERDES_V5_COM_BIN_VCOCAL_HSCLK_SEL);
+
+	/* TX lane registers */
+	serdes_writel(priv, 0x05, QSERDES_TX_BASE + QSERDES_V5_TX_TX_BAND);
+	serdes_writel(priv, 0x0A, QSERDES_TX_BASE + QSERDES_V5_TX_SLEW_CNTL);
+	serdes_writel(priv, 0x09, QSERDES_TX_BASE + QSERDES_V5_TX_RES_CODE_LANE_OFFSET_TX);
+	serdes_writel(priv, 0x09, QSERDES_TX_BASE + QSERDES_V5_TX_RES_CODE_LANE_OFFSET_RX);
+	serdes_writel(priv, 0x05, QSERDES_TX_BASE + QSERDES_V5_TX_LANE_MODE_1);
+	serdes_writel(priv, 0x00, QSERDES_TX_BASE + QSERDES_V5_TX_LANE_MODE_3);
+	serdes_writel(priv, 0x12, QSERDES_TX_BASE + QSERDES_V5_TX_RCV_DETECT_LVL_2);
+	serdes_writel(priv, 0x0C, QSERDES_TX_BASE + QSERDES_V5_TX_TRAN_DRVR_EMP_EN);
+
+	/* RX lane registers */
+	serdes_writel(priv, 0x0A, QSERDES_RX_BASE + QSERDES_V5_RX_UCDR_FO_GAIN);
+	serdes_writel(priv, 0x06, QSERDES_RX_BASE + QSERDES_V5_RX_UCDR_SO_GAIN);
+	serdes_writel(priv, 0x0A, QSERDES_RX_BASE + QSERDES_V5_RX_UCDR_FASTLOCK_FO_GAIN);
+	serdes_writel(priv, 0x7F, QSERDES_RX_BASE + QSERDES_V5_RX_UCDR_SO_SATURATION_AND_ENABLE);
+	serdes_writel(priv, 0x00, QSERDES_RX_BASE + QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_LOW);
+	serdes_writel(priv, 0x01, QSERDES_RX_BASE + QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_HIGH);
+	serdes_writel(priv, 0x81, QSERDES_RX_BASE + QSERDES_V5_RX_UCDR_PI_CONTROLS);
+	serdes_writel(priv, 0x80, QSERDES_RX_BASE + QSERDES_V5_RX_UCDR_PI_CTRL2);
+	serdes_writel(priv, 0x04, QSERDES_RX_BASE + QSERDES_V5_RX_RX_TERM_BW);
+	serdes_writel(priv, 0x08, QSERDES_RX_BASE + QSERDES_V5_RX_VGA_CAL_CNTRL2);
+	serdes_writel(priv, 0x0F, QSERDES_RX_BASE + QSERDES_V5_RX_GM_CAL);
+	serdes_writel(priv, 0x04, QSERDES_RX_BASE + QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL1);
+	serdes_writel(priv, 0x00, QSERDES_RX_BASE + QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL2);
+	serdes_writel(priv, 0x4A, QSERDES_RX_BASE + QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL3);
+	serdes_writel(priv, 0x0A, QSERDES_RX_BASE + QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL4);
+	serdes_writel(priv, 0x80, QSERDES_RX_BASE + QSERDES_V5_RX_RX_IDAC_TSETTLE_LOW);
+	serdes_writel(priv, 0x01, QSERDES_RX_BASE + QSERDES_V5_RX_RX_IDAC_TSETTLE_HIGH);
+	serdes_writel(priv, 0x20, QSERDES_RX_BASE + QSERDES_V5_RX_RX_IDAC_MEASURE_TIME);
+	serdes_writel(priv, 0x17, QSERDES_RX_BASE + QSERDES_V5_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1);
+	serdes_writel(priv, 0x00, QSERDES_RX_BASE + QSERDES_V5_RX_RX_OFFSET_ADAPTOR_CNTRL2);
+	serdes_writel(priv, 0x0F, QSERDES_RX_BASE + QSERDES_V5_RX_SIGDET_CNTRL);
+	serdes_writel(priv, 0x1E, QSERDES_RX_BASE + QSERDES_V5_RX_SIGDET_DEGLITCH_CNTRL);
+	serdes_writel(priv, 0x05, QSERDES_RX_BASE + QSERDES_V5_RX_RX_BAND);
+	serdes_writel(priv, 0xE0, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_00_LOW);
+	serdes_writel(priv, 0xC8, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_00_HIGH);
+	serdes_writel(priv, 0xC8, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_00_HIGH2);
+	serdes_writel(priv, 0x09, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_00_HIGH3);
+	serdes_writel(priv, 0xB1, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_00_HIGH4);
+	serdes_writel(priv, 0xE0, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_01_LOW);
+	serdes_writel(priv, 0xC8, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_01_HIGH);
+	serdes_writel(priv, 0xC8, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_01_HIGH2);
+	serdes_writel(priv, 0x09, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_01_HIGH3);
+	serdes_writel(priv, 0xB1, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_01_HIGH4);
+	serdes_writel(priv, 0xE0, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_10_LOW);
+	serdes_writel(priv, 0xC8, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_10_HIGH);
+	serdes_writel(priv, 0xC8, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_10_HIGH2);
+	serdes_writel(priv, 0x3B, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_10_HIGH3);
+	serdes_writel(priv, 0xB7, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_10_HIGH4);
+	serdes_writel(priv, 0x0C, QSERDES_RX_BASE + QSERDES_V5_RX_DCC_CTRL1);
+
+	/* PCS final registers — release SW_RESET, start PHY */
+	serdes_writel(priv, 0x0C, QSERDES_PCS_BASE + QPHY_PCS_LINE_RESET_TIME);
+	serdes_writel(priv, 0x1F, QSERDES_PCS_BASE + QPHY_PCS_TX_LARGE_AMP_DRV_LVL);
+	serdes_writel(priv, 0x03, QSERDES_PCS_BASE + QPHY_PCS_TX_SMALL_AMP_DRV_LVL);
+	serdes_writel(priv, 0x83, QSERDES_PCS_BASE + QPHY_PCS_TX_MID_TERM_CTRL1);
+	serdes_writel(priv, 0x08, QSERDES_PCS_BASE + QPHY_PCS_TX_MID_TERM_CTRL2);
+	serdes_writel(priv, 0x0C, QSERDES_PCS_BASE + QPHY_PCS_SGMII_MISC_CTRL8);  /* 1G: 0x0C */
+	serdes_writel(priv, 0x00, QSERDES_PCS_BASE + QPHY_PCS_SW_RESET);
+	serdes_writel(priv, 0x01, QSERDES_PCS_BASE + QPHY_PCS_PHY_START);
+}
+
+/* Program the 3.125-Gbps 2500BASE-X table. */
+static void qcom_sgmii_eth_init_2p5g(struct qcom_sgmii_eth_priv *priv)
+{
+	/* PCS: assert SW_RESET, enable POWER_DOWN_CONTROL */
+	serdes_writel(priv, 0x01, QSERDES_PCS_BASE + QPHY_PCS_SW_RESET);
+	serdes_writel(priv, 0x01, QSERDES_PCS_BASE + QPHY_PCS_POWER_DOWN_CONTROL);
+
+	/* COM (PLL) registers — mode0 = 2.5G */
+	serdes_writel(priv, 0x0F, QSERDES_COM_BASE + QSERDES_V5_COM_PLL_IVCO);
+	serdes_writel(priv, 0x06, QSERDES_COM_BASE + QSERDES_V5_COM_CP_CTRL_MODE0);
+	serdes_writel(priv, 0x16, QSERDES_COM_BASE + QSERDES_V5_COM_PLL_RCTRL_MODE0);
+	serdes_writel(priv, 0x36, QSERDES_COM_BASE + QSERDES_V5_COM_PLL_CCTRL_MODE0);
+	serdes_writel(priv, 0x1A, QSERDES_COM_BASE + QSERDES_V5_COM_SYSCLK_EN_SEL);
+	serdes_writel(priv, 0x1A, QSERDES_COM_BASE + QSERDES_V5_COM_LOCK_CMP1_MODE0); /* differs */
+	serdes_writel(priv, 0x41, QSERDES_COM_BASE + QSERDES_V5_COM_LOCK_CMP2_MODE0); /* differs */
+	serdes_writel(priv, 0x7A, QSERDES_COM_BASE + QSERDES_V5_COM_DEC_START_MODE0); /* differs */
+	serdes_writel(priv, 0x00,
+		      QSERDES_COM_BASE + QSERDES_V5_COM_DIV_FRAC_START1_MODE0); /* differs */
+	serdes_writel(priv, 0x20,
+		      QSERDES_COM_BASE + QSERDES_V5_COM_DIV_FRAC_START2_MODE0); /* differs */
+	serdes_writel(priv, 0x01,
+		      QSERDES_COM_BASE + QSERDES_V5_COM_DIV_FRAC_START3_MODE0); /* differs */
+	serdes_writel(priv, 0xA1, QSERDES_COM_BASE + QSERDES_V5_COM_VCO_TUNE1_MODE0); /* differs */
+	serdes_writel(priv, 0x02, QSERDES_COM_BASE + QSERDES_V5_COM_VCO_TUNE2_MODE0);
+	serdes_writel(priv, 0x00, QSERDES_COM_BASE + QSERDES_V5_COM_VCO_TUNE_INITVAL2);
+	serdes_writel(priv, 0x03, QSERDES_COM_BASE + QSERDES_V5_COM_HSCLK_SEL);       /* differs */
+	serdes_writel(priv, 0x00, QSERDES_COM_BASE + QSERDES_V5_COM_HSCLK_HS_SWITCH_SEL);
+	serdes_writel(priv, 0x05,
+		      QSERDES_COM_BASE + QSERDES_V5_COM_CORECLK_DIV_MODE0); /* differs */
+	serdes_writel(priv, 0x00, QSERDES_COM_BASE + QSERDES_V5_COM_CORE_CLK_EN);
+	serdes_writel(priv, 0xCD,
+		      QSERDES_COM_BASE + QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE1_MODE0); /* differs */
+	serdes_writel(priv, 0x1C,
+		      QSERDES_COM_BASE + QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE2_MODE0); /* differs */
+	serdes_writel(priv, 0x11, QSERDES_COM_BASE + QSERDES_V5_COM_BIN_VCOCAL_HSCLK_SEL);
+
+	/* TX lane registers */
+	serdes_writel(priv, 0x04, QSERDES_TX_BASE + QSERDES_V5_TX_TX_BAND);           /* differs */
+	serdes_writel(priv, 0x0A, QSERDES_TX_BASE + QSERDES_V5_TX_SLEW_CNTL);
+	serdes_writel(priv, 0x09, QSERDES_TX_BASE + QSERDES_V5_TX_RES_CODE_LANE_OFFSET_TX);
+	serdes_writel(priv, 0x02,
+		      QSERDES_TX_BASE + QSERDES_V5_TX_RES_CODE_LANE_OFFSET_RX); /* differs */
+	serdes_writel(priv, 0x05, QSERDES_TX_BASE + QSERDES_V5_TX_LANE_MODE_1);
+	serdes_writel(priv, 0x00, QSERDES_TX_BASE + QSERDES_V5_TX_LANE_MODE_3);
+	serdes_writel(priv, 0x12, QSERDES_TX_BASE + QSERDES_V5_TX_RCV_DETECT_LVL_2);
+	serdes_writel(priv, 0x0C, QSERDES_TX_BASE + QSERDES_V5_TX_TRAN_DRVR_EMP_EN);
+
+	/* RX lane registers */
+	serdes_writel(priv, 0x0A, QSERDES_RX_BASE + QSERDES_V5_RX_UCDR_FO_GAIN);
+	serdes_writel(priv, 0x06, QSERDES_RX_BASE + QSERDES_V5_RX_UCDR_SO_GAIN);
+	serdes_writel(priv, 0x0A, QSERDES_RX_BASE + QSERDES_V5_RX_UCDR_FASTLOCK_FO_GAIN);
+	serdes_writel(priv, 0x7F, QSERDES_RX_BASE + QSERDES_V5_RX_UCDR_SO_SATURATION_AND_ENABLE);
+	serdes_writel(priv, 0x00, QSERDES_RX_BASE + QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_LOW);
+	serdes_writel(priv, 0x01, QSERDES_RX_BASE + QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_HIGH);
+	serdes_writel(priv, 0x81, QSERDES_RX_BASE + QSERDES_V5_RX_UCDR_PI_CONTROLS);
+	serdes_writel(priv, 0x80, QSERDES_RX_BASE + QSERDES_V5_RX_UCDR_PI_CTRL2);
+	serdes_writel(priv, 0x00, QSERDES_RX_BASE + QSERDES_V5_RX_RX_TERM_BW);        /* differs */
+	serdes_writel(priv, 0x08, QSERDES_RX_BASE + QSERDES_V5_RX_VGA_CAL_CNTRL2);
+	serdes_writel(priv, 0x0F, QSERDES_RX_BASE + QSERDES_V5_RX_GM_CAL);
+	serdes_writel(priv, 0x04, QSERDES_RX_BASE + QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL1);
+	serdes_writel(priv, 0x00, QSERDES_RX_BASE + QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL2);
+	serdes_writel(priv, 0x4A, QSERDES_RX_BASE + QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL3);
+	serdes_writel(priv, 0x0A, QSERDES_RX_BASE + QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL4);
+	serdes_writel(priv, 0x80, QSERDES_RX_BASE + QSERDES_V5_RX_RX_IDAC_TSETTLE_LOW);
+	serdes_writel(priv, 0x01, QSERDES_RX_BASE + QSERDES_V5_RX_RX_IDAC_TSETTLE_HIGH);
+	serdes_writel(priv, 0x20, QSERDES_RX_BASE + QSERDES_V5_RX_RX_IDAC_MEASURE_TIME);
+	serdes_writel(priv, 0x17, QSERDES_RX_BASE + QSERDES_V5_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1);
+	serdes_writel(priv, 0x00, QSERDES_RX_BASE + QSERDES_V5_RX_RX_OFFSET_ADAPTOR_CNTRL2);
+	serdes_writel(priv, 0x0F, QSERDES_RX_BASE + QSERDES_V5_RX_SIGDET_CNTRL);
+	serdes_writel(priv, 0x1E, QSERDES_RX_BASE + QSERDES_V5_RX_SIGDET_DEGLITCH_CNTRL);
+	serdes_writel(priv, 0x18, QSERDES_RX_BASE + QSERDES_V5_RX_RX_BAND);           /* differs */
+	serdes_writel(priv, 0x18, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_00_LOW);    /* differs */
+	serdes_writel(priv, 0xC8, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_00_HIGH);
+	serdes_writel(priv, 0xC8, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_00_HIGH2);
+	serdes_writel(priv, 0x0C, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_00_HIGH3);  /* differs */
+	serdes_writel(priv, 0xB8, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_00_HIGH4);  /* differs */
+	serdes_writel(priv, 0xE0, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_01_LOW);
+	serdes_writel(priv, 0xC8, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_01_HIGH);
+	serdes_writel(priv, 0xC8, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_01_HIGH2);
+	serdes_writel(priv, 0x09, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_01_HIGH3);
+	serdes_writel(priv, 0xB1, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_01_HIGH4);
+	serdes_writel(priv, 0xE0, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_10_LOW);
+	serdes_writel(priv, 0xC8, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_10_HIGH);
+	serdes_writel(priv, 0xC8, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_10_HIGH2);
+	serdes_writel(priv, 0x3B, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_10_HIGH3);
+	serdes_writel(priv, 0xB7, QSERDES_RX_BASE + QSERDES_V5_RX_RX_MODE_10_HIGH4);
+	serdes_writel(priv, 0x0C, QSERDES_RX_BASE + QSERDES_V5_RX_DCC_CTRL1);
+
+	/* PCS final registers — release SW_RESET, start PHY */
+	serdes_writel(priv, 0x0C, QSERDES_PCS_BASE + QPHY_PCS_LINE_RESET_TIME);
+	serdes_writel(priv, 0x1F, QSERDES_PCS_BASE + QPHY_PCS_TX_LARGE_AMP_DRV_LVL);
+	serdes_writel(priv, 0x03, QSERDES_PCS_BASE + QPHY_PCS_TX_SMALL_AMP_DRV_LVL);
+	serdes_writel(priv, 0x83, QSERDES_PCS_BASE + QPHY_PCS_TX_MID_TERM_CTRL1);
+	serdes_writel(priv, 0x08, QSERDES_PCS_BASE + QPHY_PCS_TX_MID_TERM_CTRL2);
+	serdes_writel(priv, 0x8C, QSERDES_PCS_BASE + QPHY_PCS_SGMII_MISC_CTRL8);  /* 2.5G: 0x8C */
+	serdes_writel(priv, 0x00, QSERDES_PCS_BASE + QPHY_PCS_SW_RESET);
+	serdes_writel(priv, 0x01, QSERDES_PCS_BASE + QPHY_PCS_PHY_START);
+}
+
+static int qcom_sgmii_eth_pll_poll(struct udevice *dev,
+				   struct qcom_sgmii_eth_priv *priv,
+				   u32 offset, u32 bit,
+				   const char *name)
+{
+	int i;
+
+	for (i = 0; i < PLL_POLL_RETRIES; i++) {
+		if (serdes_readl(priv, offset) & bit)
+			return 0;
+		udelay(PLL_POLL_SLEEP_US);
+	}
+	dev_err(dev, "SerDes PLL poll timed out waiting for %s\n", name);
+	return -ETIMEDOUT;
+}
+
+static int qcom_sgmii_eth_pll_wait(struct udevice *dev,
+				   struct qcom_sgmii_eth_priv *priv)
+{
+	int ret;
+
+	/* Poll 1: COM C_READY — PLL output clock is ready */
+	ret = qcom_sgmii_eth_pll_poll(dev, priv,
+				      QSERDES_COM_BASE + QSERDES_V5_COM_C_READY_STATUS,
+				      QSERDES_COM_C_READY,
+				      "COM_C_READY");
+	if (ret)
+		return ret;
+
+	/* Poll 2: PCS_READY — PCS block has completed reset */
+	ret = qcom_sgmii_eth_pll_poll(dev, priv,
+				      QSERDES_PCS_BASE + QPHY_PCS_PCS_READY_STATUS,
+				      QSERDES_PCS_READY,
+				      "PCS_READY");
+	if (ret)
+		return ret;
+
+	/* Poll 3: SGMIIPHY_READY — SGMII PHY is operational */
+	ret = qcom_sgmii_eth_pll_poll(dev, priv,
+				      QSERDES_PCS_BASE + QPHY_PCS_PCS_READY_STATUS,
+				      QSERDES_PCS_SGMIIPHY_READY,
+				      "SGMIIPHY_READY");
+	if (ret)
+		return ret;
+
+	/* Poll 4: PLL locked — VCO has locked to target frequency */
+	ret = qcom_sgmii_eth_pll_poll(dev, priv,
+				      QSERDES_COM_BASE + QSERDES_V5_COM_CMN_STATUS,
+				      QSERDES_COM_C_PLL_LOCKED,
+				      "PLL_LOCKED");
+	return ret;
+}
+
+static int qcom_sgmii_eth_probe(struct udevice *dev)
+{
+	struct qcom_sgmii_eth_priv *priv = dev_get_priv(dev);
+	fdt_addr_t base;
+	int ret;
+
+	/* Map SerDes register base from DT "reg" property */
+	base = dev_read_addr(dev);
+	if (base == FDT_ADDR_T_NONE) {
+		dev_err(dev, "Missing 'reg' property for SerDes node\n");
+		return -EINVAL;
+	}
+	priv->base = (void __iomem *)(uintptr_t)base;
+
+	ret = clk_get_by_name(dev, "sgmi_ref", &priv->clk);
+	if (ret) {
+		dev_err(dev, "clk_get_by_name(sgmi_ref) failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = device_get_supply_regulator(dev, "vdda-0p9-supply", &priv->vdda_0p9);
+	if (ret) {
+		dev_err(dev, "device_get_supply_regulator(vdda-0p9) failed: %d\n", ret);
+		return ret;
+	}
+
+	priv->interface = PHY_INTERFACE_MODE_SGMII;
+	priv->powered = false;
+
+	return 0;
+}
+
+static int qcom_sgmii_eth_calibrate(struct udevice *dev,
+				    struct qcom_sgmii_eth_priv *priv,
+				    phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		qcom_sgmii_eth_init_1g(priv);
+		break;
+	case PHY_INTERFACE_MODE_2500BASEX:
+		qcom_sgmii_eth_init_2p5g(priv);
+		break;
+	default:
+		dev_err(dev, "unsupported Ethernet interface: %d\n", interface);
+		return -EOPNOTSUPP;
+	}
+
+	return qcom_sgmii_eth_pll_wait(dev, priv);
+}
+
+/* Enable local supplies and calibrate after generic phy-supply is enabled. */
+static int qcom_sgmii_eth_power_on(struct phy *phy)
+{
+	struct udevice *dev = phy->dev;
+	struct qcom_sgmii_eth_priv *priv = dev_get_priv(dev);
+	int cleanup_ret;
+	int ret;
+
+	ret = regulator_set_enable(priv->vdda_0p9, true);
+	if (ret) {
+		dev_err(dev, "regulator_set_enable(vdda-0p9) failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_enable(&priv->clk);
+	if (ret) {
+		dev_err(dev, "clk_enable(sgmi_ref) failed: %d\n", ret);
+		cleanup_ret = regulator_set_enable(priv->vdda_0p9, false);
+		if (cleanup_ret)
+			dev_err(dev, "failed to disable vdda-0p9: %d\n",
+				cleanup_ret);
+		return ret;
+	}
+
+	ret = qcom_sgmii_eth_calibrate(dev, priv, priv->interface);
+	if (ret) {
+		cleanup_ret = clk_disable(&priv->clk);
+		if (cleanup_ret)
+			dev_err(dev, "failed to disable sgmi_ref: %d\n",
+				cleanup_ret);
+
+		cleanup_ret = regulator_set_enable(priv->vdda_0p9, false);
+		if (cleanup_ret)
+			dev_err(dev, "failed to disable vdda-0p9: %d\n",
+				cleanup_ret);
+		return ret;
+	}
+
+	priv->powered = true;
+
+	return 0;
+}
+
+/*
+ * SGMII and 1000BASE-X use the 1.25-Gbps SerDes table. 2500BASE-X uses
+ * the 3.125-Gbps table. If the PHY is already powered, changing mode also
+ * recalibrates the hardware and verifies PLL lock before caching the mode.
+ */
+static int qcom_sgmii_eth_set_mode(struct phy *phy, enum phy_mode mode,
+				   int submode)
+{
+	struct udevice *dev = phy->dev;
+	struct qcom_sgmii_eth_priv *priv = dev_get_priv(dev);
+	phy_interface_t interface = submode;
+	int ret;
+
+	if (mode != PHY_MODE_ETHERNET)
+		return -EOPNOTSUPP;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	if (interface == priv->interface)
+		return 0;
+
+	if (!priv->powered) {
+		priv->interface = interface;
+		return 0;
+	}
+
+	ret = qcom_sgmii_eth_calibrate(dev, priv, interface);
+	if (ret)
+		return ret;
+
+	priv->interface = interface;
+
+	return 0;
+}
+
+static int qcom_sgmii_eth_power_off(struct phy *phy)
+{
+	struct udevice *dev = phy->dev;
+	struct qcom_sgmii_eth_priv *priv = dev_get_priv(dev);
+	int first_err = 0;
+	int ret;
+
+	serdes_writel(priv, 0x08, QSERDES_PCS_BASE + QPHY_PCS_TX_MID_TERM_CTRL2);
+	serdes_writel(priv, 0x01, QSERDES_PCS_BASE + QPHY_PCS_SW_RESET);
+	udelay(100);
+	serdes_writel(priv, 0x00, QSERDES_PCS_BASE + QPHY_PCS_SW_RESET);
+	serdes_writel(priv, 0x01, QSERDES_PCS_BASE + QPHY_PCS_PHY_START);
+
+	ret = clk_disable(&priv->clk);
+	if (ret) {
+		dev_err(dev, "failed to disable sgmi_ref: %d\n", ret);
+		first_err = ret;
+	}
+
+	ret = regulator_set_enable(priv->vdda_0p9, false);
+	if (ret) {
+		dev_err(dev, "failed to disable vdda-0p9: %d\n", ret);
+		if (!first_err)
+			first_err = ret;
+	}
+
+	if (!first_err)
+		priv->powered = false;
+
+	return first_err;
+}
+
+static const struct phy_ops qcom_sgmii_eth_ops = {
+	.power_on	= qcom_sgmii_eth_power_on,
+	.power_off	= qcom_sgmii_eth_power_off,
+	.set_mode	= qcom_sgmii_eth_set_mode,
+};
+
+static const struct udevice_id qcom_sgmii_eth_ids[] = {
+	{ .compatible = "qcom,sa8775p-dwmac-sgmii-phy" },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_sgmii_eth) = {
+	.name		= "qcom_sgmii_eth",
+	.id		= UCLASS_PHY,
+	.of_match	= qcom_sgmii_eth_ids,
+	.probe		= qcom_sgmii_eth_probe,
+	.ops		= &qcom_sgmii_eth_ops,
+	.priv_auto	= sizeof(struct qcom_sgmii_eth_priv),
+};
-- 
2.34.1
