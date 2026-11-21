Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E63606A33B
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=r0Dg+j01;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ecWcrMhq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kUvsj5TA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 89ADF40DE7;
	Sat, 21 Nov 2026 06:40:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id twRqKGfORp_A; Sat, 21 Nov 2026 06:40:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7FA4440DEF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795243250;
	b=Mm5BW33rBMsq8PoPaSATuwj2/iyqtIStcaQk8nBQy5PDYhDD07k6xF2inxPTM4ThksR3
	 ypNh2jvhjnZGl5kdma1ahXFAJc+tu1lAGG/psTqXEAeAP2sqV4vXoTB0+WHLCTNC1K9Bs
	 baNWUfzQRoJRdrBoLUJKlQTKiXJSiFmmU2k57Cf/ZmyiJL/oq4e481ekIHqmQcjm7fqVN
	 WK9CDelE6D2lB3+H45h5sVMkmLK8tdluRGDloJO/oUtLKxrIvhsCtsDqs4yL8KuBC62Q6
	 gKYOLetj3CPWTpW2E+dgrDfh0LF9oAvroG+Ujg4XUP2HbmgAKotzRwM2jx+AWAJviTQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795243250;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pKFSDp+R93gLZUCaWo4W9/C98ULI3uu3k2jFtLi/IkA=;
	b=D1NxVlpuRddvCgp9ODZHBZnTYpI3xuNqk7zdf7q9WLj290PjN2pmWOyMEriuz5UBbyDv
	 01+X3ECngQaNmX1xoDeJNebGtheaJOWKqkxS0Y7e+LUd4+RNKxcb4gMPeHxmx4uVNFnYv
	 rAf2lXweVcCbeMQyUgiPGnA912jPyEP2m3bRhs+nOxbItd3HguMSYUjUPb9IHIyWmE10U
	 4OY4NFm7/wVl8Ys1p8BhKZEdeguAIXKkDq7qSuAxyfg+75tGDZaxqsO+3h6h6pz8NAOaJ
	 LEqjaSF13SHt00xikwWsww+Og4oZRIdrl1a1qse7pNplvcdG6ht+UArKTApVvFxMMLw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795243250;
	bh=pKFSDp+R93gLZUCaWo4W9/C98ULI3uu3k2jFtLi/IkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r0Dg+j01IJgwiQV0e5/MVFsEqFNTUbwy4TcgAIWzt020AyzXxE/SJoSY3/EOfJ78n
	 caohQHo6IjH/K9AtpYefo9snfEjLsXoBeqGYJFi5S2/tUqNjyUKc/09UlOWze4lOso
	 d+ogYZINTadW2zikxjXfprHKsprZMgNn0S9evlKQrj0Wx8jhaKBibJyZlC5l01febU
	 T6Ob6SeBEJH9HNJU/L7rdYeOznuaPPeuRubV8Jn9ayB1a7xqNgrWBXfMWYnWEBesxE
	 To6camiivgIvZVoZTqdmHtcz1tU3dhuEPh/6hHtgjuMv0qSEYI2AE2AJFYT8zEh3ON
	 mdccrnXNcJqLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FA4440DEF;
	Sat, 21 Nov 2026 06:40:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 589EC1AB
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3EBE460668
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wEqL2zDGg4-Z for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 06:40:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 32DE960665
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=manikanta.mylavarapu@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=ecWcrMhq; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kUvsj5TA
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 32DE960665
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:48 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AL4Aqfp475675
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=pKFSDp+R93g
 LZUCaWo4W9/C98ULI3uu3k2jFtLi/IkA=; b=ecWcrMhqRLhNlsCmPtc3wqIJJNP
 6ZWMKOUGSCRNsa6J2mSOKOBkwHrTptBV5ZUi3aytiHLOMUEEeIEZJ2/iAg0JaWm9
 Jzaz0FTuZG1c4cI7rLTWheDxmq0freyEiO6nYoARfW1L30vJSbHvHW/SsCcYhdj7
 91JJfh+VRkkRd8D8Cpfe2sfyHiV+TZCoNpmKO0Y8MVfP6WyZlnUmFHVr/VtKxWHf
 XGeEqMcYTUnQR1ggqjejNtTG9OWncrKdq0HWvNCQtkQwtTjsqvPlqYstgIPexjN8
 rICcVjvdrAYEig60A8SQ0fxAAPnQGBtecqzghULbF2LclsIvL1o4Aaif0pg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j310f8p74-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:40:47 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-384c78aa0dbso2212853eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795243247; x=1795848047;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pKFSDp+R93gLZUCaWo4W9/C98ULI3uu3k2jFtLi/IkA=;
 b=kUvsj5TAyube+NI1vsveTDC1h3fXt8N2IxV0NOjQCtPWgNZ8uSLp5/NZ7KYnzIi797
 3/evUbxd8RpAezCdE1sgJWyBLAkrrMk1r4K3y5XymzlN20hElY0ILuDUzBfwOn15XhrI
 5O9/uN01rWKd2Ng7IBVqzJBtbWAQGeydnUak+9UuMMb74HNzjK6lfnHn9uXcGFqCSksY
 nxP/zfWGZW6QMZTSUesxZJ+XVuSX1k72UAw2zId+NZQKZZlam4LGtx9OX46MMpLjB98X
 3tCiG/F3XCj9aXhgN3HjFSxOYi2F8OGlJ0WKq4LEP55S7eq67CIcDMpOYLLKfMBdzBsq
 G9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795243247; x=1795848047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pKFSDp+R93gLZUCaWo4W9/C98ULI3uu3k2jFtLi/IkA=;
 b=eJbvrz3jNWhpJEglqgG23i9Y7f8OIHQhfhspOQjbp9dxwozER8CByDRUMekDQOZDkD
 +dSzVUkHKd8cIeQeygtioX4+a5UmAR5nth+82KvH8vphjHkRqMfx3PBsODW88KgpnEee
 0pi43CLh8xKog9gexf6hxv2aZg2gIIu25Sh+eJNkERV39Zc6iWQaL7RohDlPJZeKI0GQ
 fzOPrmG0siy3hq8BWf2wF98jJ6d6u2Rh+lQFpa0/TOfKtFBAcznQ/zVsPMBVTQKuS9cP
 jOGsZ+TnIuL802nb5sjSYwBUB/16h6W9uxmSLurK9LG0Vsw5RWfE9nH9Jr5ZYmHKKDLo
 QSew==
X-Forwarded-Encrypted: i=1;
 AL+hErFq66tBqSd+aPl086FSUIpVWgwKNBuSq6mmdNmUg0z1OVQ+7a+SCQbq/rn2WxiQ3DbhYgeU04g=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9tnswnV1upKun4NkPWv3/sUFXXS/rPCkdcQ2Ugb4Pa/tN2zxKQ
 /Gyw4+pNvnu4BSAgj6m1gBgU59yvhGLeHGGlLtRpNgVJiRwjhzymF2mpcVizxPZbdNbakXFzQWI
 SNOVWcrB1TWwCVsYFiCT/KUltNAZJx3Knl2b+LkPOFGJ2RgFY9BhWbjqLfzKrT5trmviSSco=
X-Gm-Gg: AZFdTZeIj5KA7c43cVvKB72YKBjdMLMQU1LlpljOd5dReQw7uuNW1DtJibCo7yv8YWh
 T1OyuYo4qOPCCTtZ1Nq0H9mpHthsuNC9LenRQCZ4Ss9jJ6/k5Glo6ad1HnxqcViXGrC1uWAMM5r
 5n/b5W5eahftthG6iL+9MrfGmBp0odraTulsR3FZEddKr1lU3CDZvKZDgLXc/IBc9lAJaqRPa9H
 u3wB80dXTqQK9sLUr4+BW62gpCeSDwXNpPTYz2TbbmHTSSBknwSCpvJpsr/pNZ6n/017MPTBxtt
 6yTapxWFhptXJM40mi3lcDkR+6US89NBeE0iAdrJKKOwjYc6xor9bxVxUtvlhW9fiua4P9TJoLF
 LJrBu8XMqKTjIuLT+HiB94ZFuxcVO574h7/VmhS16nwJ9G5rfJbIHyJri4Y+RZizUZvMhJ8ql+8
 LL
X-Received: by 2002:a05:693c:87d6:20b0:376:40db:faec with SMTP id
 5a478bee46e88-3856f65f251mr4712359eec.10.1795243246448; 
 Fri, 20 Nov 2026 22:40:46 -0800 (PST)
X-Received: by 2002:a05:693c:87d6:20b0:376:40db:faec with SMTP id
 5a478bee46e88-3856f65f251mr4712326eec.10.1795243245768; 
 Fri, 20 Nov 2026 22:40:45 -0800 (PST)
Received: from hu-mmanikan-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd46c5sm16970487eec.11.2026.11.20.22.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 22:40:45 -0800 (PST)
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
Subject: [PATCH v2 4/5] net: dwc_eth_qos: qcom: add SA8775P support
Date: Sat, 21 Nov 2026 12:09:18 +0530
Message-Id: <20261121063919.3313168-5-mmanikan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261121063919.3313168-1-mmanikan@qti.qualcomm.com>
References: <20261121063919.3313168-1-mmanikan@qti.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIxMDAyNiBTYWx0ZWRfXwvAFPoaIdqkW
 aIufAF6JoF4rgfpPNLdT6zF70LdVhb+MY0tDCpCFX96y40ob0+WkosO5ujMXPmC3K7hXIif8tPA
 k8G2VtISDVk58ir1F1C7CdiX7hezXwn9ZIasR4LmCrmZy89WLDlXiL7lSVkHUPcB3/akMGOeYUg
 IqnHpCoB4+NmhrjaTU+e0+oQhMzKYYXmUWZTn35vTFP4nQweXMlrjQDDZxcnm4nLcLwLUJ4Peis
 VeFwvhiejHcsVn0EmUql6437E+v6bi9xMjY9wNaoSFvO9vX2EhTzI1AjI51qp8jbACTS+M3ILee
 sx9kx0yjwPMMVQRgmPq8k4Wh3KLuhwm9WAwa4pLNPY5kDQ8A7H9sMw6Djbk7130kls2+xooZ8S5
 iCVfKXPNq9wfeXQcKYtwzNRA2FANx8HzD++5p9ZMK1MpjdfzQCruajNcsRQ42dD2f8xZ41BC2EI
 EZ3TZJ/1mny0e9LT9vw==
X-Proofpoint-ORIG-GUID: HqXGdrz-98o8ckz5b-cEDYdlS585-N3z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIxMDAyNiBTYWx0ZWRfXyYqfaAJyjRCR
 p3/iV6898R8f8K5xdeMwYWfU4Qc+rYTCzc1iNShSzHTGanOaLWDOMMdcl38JxsGX5vwWPBhfyhO
 IMcwot8pqKJFtNi+4jOwgOsHT1xwo4o=
X-Proofpoint-GUID: HqXGdrz-98o8ckz5b-cEDYdlS585-N3z
X-Authority-Analysis: v=2.4 cv=UN1Ijyfy c=1 sm=1 tr=0 ts=6b013cef cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=RN49KxeIwWVS5ikiMusA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611210026
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

SA8775P uses the Qualcomm EQOS wrapper with an external SGMII SerDes and
relocates the MTL and DMA channel register blocks to offsets 0x8000 and
0x8100 respectively.

Add SA8775P platform data and resource handling. Bring up the SerDes with
the Qualcomm clocks, use the wrapper loopback during initialization and
configure the MAC, wrapper divider, PCS in-band negotiation and SerDes
mode for 10, 100, 1000 and 2500 Mbps links.

Enable PCS in-band negotiation for SGMII and keep it disabled for
2500BASE-X operation.

Signed-off-by: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
---
Changes in v2:
- Removed verbose SA8775P profile comments.
- Removed the long static function comment for speed configuration.

 drivers/net/dwc_eth_qos.c      |   4 +
 drivers/net/dwc_eth_qos.h      |   6 +
 drivers/net/dwc_eth_qos_qcom.c | 276 +++++++++++++++++++++++++++++++++
 3 files changed, 286 insertions(+)

diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
index de06bb46151..0888c7f00fc 100644
--- a/drivers/net/dwc_eth_qos.c
+++ b/drivers/net/dwc_eth_qos.c
@@ -1662,6 +1662,10 @@ static const struct udevice_id eqos_ids[] = {
 		.compatible = "qcom,qcs404-ethqos",
 		.data = (ulong)&eqos_qcom_config
 	},
+	{
+		.compatible = "qcom,sa8775p-ethqos",
+		.data = (ulong)&eqos_sa8775p_config
+	},
 #endif
 #if IS_ENABLED(CONFIG_DWC_ETH_QOS_STARFIVE)
 	{
diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
index b2e35c72423..7f353a8e174 100644
--- a/drivers/net/dwc_eth_qos.h
+++ b/drivers/net/dwc_eth_qos.h
@@ -5,6 +5,7 @@
 
 #include <asm/gpio.h>
 #include <clk.h>
+#include <generic-phy.h>
 #include <linux/bitops.h>
 #include <phy_interface.h>
 #include <reset.h>
@@ -289,6 +290,10 @@ struct eqos_priv {
 	struct clk clk_tx;
 	struct clk clk_ck;
 	struct clk clk_slave_bus;
+	struct phy serdes_phy;
+	phy_interface_t serdes_interface;
+	bool serdes_inited;
+	bool serdes_powered;
 	struct mii_dev *mii;
 	struct phy_device *phy;
 	ofnode phy_of_node;
@@ -319,6 +324,7 @@ void *eqos_get_driver_data(struct udevice *dev);
 extern struct eqos_config eqos_imx_config;
 extern struct eqos_config eqos_rockchip_config;
 extern struct eqos_config eqos_qcom_config;
+extern struct eqos_config eqos_sa8775p_config;
 extern struct eqos_config eqos_stm32mp13_config;
 extern struct eqos_config eqos_stm32mp15_config;
 extern struct eqos_config eqos_stm32mp25_config;
diff --git a/drivers/net/dwc_eth_qos_qcom.c b/drivers/net/dwc_eth_qos_qcom.c
index de0ae090c5d..ab4b088e459 100644
--- a/drivers/net/dwc_eth_qos_qcom.c
+++ b/drivers/net/dwc_eth_qos_qcom.c
@@ -11,9 +11,11 @@
 #include <clk.h>
 #include <dm.h>
 #include <dm/device_compat.h>
+#include <generic-phy.h>
 #include <phy.h>
 #include <reset.h>
 #include <syscon.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 
@@ -70,6 +72,23 @@
 #define RGMII_CONFIG2_DATA_DIVIDE_CLK_SEL	BIT(6)
 #define RGMII_CONFIG2_TX_CLK_PHASE_SHIFT_EN	BIT(5)
 
+/* RGMII_IO_MACRO_CONFIG field used by SGMII (same register as above) */
+#define RGMII_CONFIG_SGMII_CLK_DVDR		GENMASK(18, 10)
+#define SGMII_10M_RX_CLK_DVDR			0x31
+
+/* EMAC_WRAPPER_SGMII_PHY_CNTRL1, offset 0xf4 in the "rgmii" wrapper region */
+#define EMAC_WRAPPER_SGMII_PHY_CNTRL1		0xf4
+#define SGMII_PHY_CNTRL1_SGMII_TX_TO_RX_LOOPBACK_EN	BIT(3)
+
+/* MAC_CTRL_REG bits -- same register as mac_regs->configuration */
+#define ETHQOS_MAC_CTRL_SPEED_MODE		EQOS_MAC_CONFIGURATION_FES
+#define ETHQOS_MAC_CTRL_PORT_SEL		EQOS_MAC_CONFIGURATION_PS
+
+/* DWMAC4 integrated PCS auto-negotiation control register */
+#define ETHQOS_MAC_PCS_AN_CTRL			0xe0
+#define ETHQOS_MAC_PCS_AN_RESTART		BIT(9)
+#define ETHQOS_MAC_PCS_AN_ENABLE		BIT(12)
+
 struct dwmac_rgmii_regs {
 	u32 io_macro_config;		/* 0x00 */
 	u32 sdcc_hc_dll_config;		/* 0x04 */
@@ -614,3 +633,260 @@ struct eqos_config __maybe_unused eqos_qcom_config = {
 	.interface = dev_read_phy_mode,
 	.ops = &eqos_qcom_ops
 };
+
+static void eqos_sgmii_set_loopback(struct dwmac_rgmii_regs *regs, bool enable)
+{
+	clrsetbits_le32((void *)regs + EMAC_WRAPPER_SGMII_PHY_CNTRL1,
+			SGMII_PHY_CNTRL1_SGMII_TX_TO_RX_LOOPBACK_EN,
+			enable ? SGMII_PHY_CNTRL1_SGMII_TX_TO_RX_LOOPBACK_EN : 0);
+}
+
+static void eqos_sgmii_set_inband_an(struct eqos_priv *eqos, bool enable)
+{
+	void __iomem *an_ctrl = (void __iomem *)eqos->mac_regs +
+			       ETHQOS_MAC_PCS_AN_CTRL;
+
+	if (enable)
+		setbits_le32(an_ctrl, ETHQOS_MAC_PCS_AN_ENABLE |
+			     ETHQOS_MAC_PCS_AN_RESTART);
+	else
+		clrbits_le32(an_ctrl, ETHQOS_MAC_PCS_AN_ENABLE |
+			     ETHQOS_MAC_PCS_AN_RESTART);
+}
+
+static int eqos_start_clks_sa8775p(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	int ret;
+
+	ret = eqos_start_clks_qcom(dev);
+	if (ret)
+		return ret;
+
+	eqos_sgmii_set_loopback(eqos->eqos_qcom_rgmii_regs, true);
+	ethqos_set_func_clk_en(eqos->eqos_qcom_rgmii_regs);
+
+	ret = generic_phy_init(&eqos->serdes_phy);
+	if (ret) {
+		pr_err("generic_phy_init(serdes) failed: %d\n", ret);
+		eqos_stop_clks_qcom(dev);
+		return ret;
+	}
+	eqos->serdes_inited = true;
+
+	ret = generic_phy_set_mode(&eqos->serdes_phy, PHY_MODE_ETHERNET,
+				   PHY_INTERFACE_MODE_SGMII);
+	if (ret) {
+		pr_err("generic_phy_set_mode(serdes) failed: %d\n", ret);
+		generic_phy_exit(&eqos->serdes_phy);
+		eqos->serdes_inited = false;
+		eqos_stop_clks_qcom(dev);
+		return ret;
+	}
+	eqos->serdes_interface = PHY_INTERFACE_MODE_SGMII;
+
+	ret = generic_phy_power_on(&eqos->serdes_phy);
+	if (ret) {
+		pr_err("generic_phy_power_on(serdes) failed: %d\n", ret);
+		generic_phy_exit(&eqos->serdes_phy);
+		eqos->serdes_inited = false;
+		eqos_stop_clks_qcom(dev);
+		return ret;
+	}
+	eqos->serdes_powered = true;
+
+	return 0;
+}
+
+static int eqos_stop_clks_sa8775p(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+
+	if (eqos->serdes_powered) {
+		generic_phy_power_off(&eqos->serdes_phy);
+		eqos->serdes_powered = false;
+	}
+	if (eqos->serdes_inited) {
+		generic_phy_exit(&eqos->serdes_phy);
+		eqos->serdes_inited = false;
+	}
+
+	return eqos_stop_clks_qcom(dev);
+}
+
+static int eqos_probe_resources_sa8775p(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	phy_interface_t interface;
+	int ret;
+
+	debug("%s(dev=%p):\n", __func__, dev);
+
+	ret = eqos_get_base_addr_dt(dev);
+	if (ret) {
+		pr_err("eqos_get_base_addr_dt failed: %d\n", ret);
+		return ret;
+	}
+
+	interface = eqos->config->interface(dev);
+	if (interface == PHY_INTERFACE_MODE_NA) {
+		pr_err("Invalid PHY interface\n");
+		return -EINVAL;
+	}
+
+	eqos->max_speed = dev_read_u32_default(dev, "max-speed", 0);
+	eqos->tx_fifo_sz = dev_read_u32_default(dev, "tx-fifo-depth", 0);
+	eqos->rx_fifo_sz = dev_read_u32_default(dev, "rx-fifo-depth", 0);
+
+	eqos->eqos_qcom_rgmii_regs = (void *)dev_read_addr_name(dev, "rgmii");
+	if ((fdt_addr_t)eqos->eqos_qcom_rgmii_regs == FDT_ADDR_T_NONE) {
+		pr_err("Invalid RGMII/wrapper address\n");
+		return -EINVAL;
+	}
+
+	ret = generic_phy_get_by_name(dev, "serdes", &eqos->serdes_phy);
+	if (ret) {
+		pr_err("generic_phy_get_by_name(serdes) failed: %d\n", ret);
+		return ret;
+	}
+
+	debug("%s: OK\n", __func__);
+	return 0;
+}
+
+static int eqos_remove_resources_sa8775p(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+
+	debug("%s(dev=%p):\n", __func__, dev);
+
+	if (eqos->serdes_powered) {
+		generic_phy_power_off(&eqos->serdes_phy);
+		eqos->serdes_powered = false;
+	}
+	if (eqos->serdes_inited) {
+		generic_phy_exit(&eqos->serdes_phy);
+		eqos->serdes_inited = false;
+	}
+
+	debug("%s: OK\n", __func__);
+	return 0;
+}
+
+static int eqos_set_sgmii_speed_qcom(struct udevice *dev)
+{
+	struct eqos_priv *eqos = dev_get_priv(dev);
+	struct dwmac_rgmii_regs *rgmii_regs = eqos->eqos_qcom_rgmii_regs;
+	phy_interface_t interface = eqos->phy->interface;
+	int ret;
+
+	debug("%s(dev=%p): interface=%d speed=%d\n", __func__, dev,
+	      interface, eqos->phy->speed);
+
+	if (interface != PHY_INTERFACE_MODE_SGMII &&
+	    interface != PHY_INTERFACE_MODE_2500BASEX) {
+		pr_err("unsupported interface %d for speed %d\n",
+		       interface, eqos->phy->speed);
+		return -EINVAL;
+	}
+
+	eqos_sgmii_set_loopback(rgmii_regs, false);
+	eqos_sgmii_set_inband_an(eqos, false);
+
+	if (eqos->serdes_interface != interface) {
+		ret = generic_phy_set_mode(&eqos->serdes_phy, PHY_MODE_ETHERNET,
+					   interface);
+		if (ret) {
+			pr_err("generic_phy_set_mode(serdes) failed: %d\n", ret);
+			return ret;
+		}
+		eqos->serdes_interface = interface;
+	}
+
+	switch (eqos->phy->speed) {
+	case SPEED_2500:
+		if (interface != PHY_INTERFACE_MODE_2500BASEX)
+			return -EINVAL;
+		clrbits_le32(&eqos->mac_regs->configuration,
+			     ETHQOS_MAC_CTRL_PORT_SEL |
+			     ETHQOS_MAC_CTRL_SPEED_MODE);
+		setbits_le32(&rgmii_regs->io_macro_config2,
+			     RGMII_CONFIG2_RGMII_CLK_SEL_CFG);
+		clrbits_le32(&rgmii_regs->io_macro_config,
+			     RGMII_CONFIG_SGMII_CLK_DVDR);
+		break;
+	case SPEED_1000:
+		if (interface != PHY_INTERFACE_MODE_SGMII)
+			return -EINVAL;
+		clrbits_le32(&eqos->mac_regs->configuration,
+			     ETHQOS_MAC_CTRL_PORT_SEL |
+			     ETHQOS_MAC_CTRL_SPEED_MODE);
+		setbits_le32(&rgmii_regs->io_macro_config2,
+			     RGMII_CONFIG2_RGMII_CLK_SEL_CFG);
+		clrbits_le32(&rgmii_regs->io_macro_config,
+			     RGMII_CONFIG_SGMII_CLK_DVDR);
+		break;
+	case SPEED_100:
+		if (interface != PHY_INTERFACE_MODE_SGMII)
+			return -EINVAL;
+		setbits_le32(&eqos->mac_regs->configuration,
+			     ETHQOS_MAC_CTRL_PORT_SEL | ETHQOS_MAC_CTRL_SPEED_MODE);
+		clrbits_le32(&rgmii_regs->io_macro_config2,
+			     RGMII_CONFIG2_RGMII_CLK_SEL_CFG);
+		clrbits_le32(&rgmii_regs->io_macro_config,
+			     RGMII_CONFIG_SGMII_CLK_DVDR);
+		break;
+	case SPEED_10:
+		if (interface != PHY_INTERFACE_MODE_SGMII)
+			return -EINVAL;
+		clrsetbits_le32(&eqos->mac_regs->configuration,
+				ETHQOS_MAC_CTRL_PORT_SEL |
+				ETHQOS_MAC_CTRL_SPEED_MODE,
+				ETHQOS_MAC_CTRL_PORT_SEL);
+		clrbits_le32(&rgmii_regs->io_macro_config2,
+			     RGMII_CONFIG2_RGMII_CLK_SEL_CFG);
+		clrsetbits_le32(&rgmii_regs->io_macro_config,
+				RGMII_CONFIG_SGMII_CLK_DVDR,
+				FIELD_PREP(RGMII_CONFIG_SGMII_CLK_DVDR,
+					   SGMII_10M_RX_CLK_DVDR));
+		break;
+	default:
+		pr_err("invalid speed %d\n", eqos->phy->speed);
+		return -EINVAL;
+	}
+
+	eqos_sgmii_set_inband_an(eqos,
+				 interface == PHY_INTERFACE_MODE_SGMII);
+
+	return 0;
+}
+
+static struct eqos_ops eqos_sa8775p_ops = {
+	.eqos_inval_desc = eqos_inval_desc_generic,
+	.eqos_flush_desc = eqos_flush_desc_generic,
+	.eqos_inval_buffer = eqos_inval_buffer_generic,
+	.eqos_flush_buffer = eqos_flush_buffer_generic,
+	.eqos_probe_resources = eqos_probe_resources_sa8775p,
+	.eqos_remove_resources = eqos_remove_resources_sa8775p,
+	.eqos_stop_resets = eqos_null_ops,
+	.eqos_start_resets = eqos_null_ops,
+	.eqos_stop_clks = eqos_stop_clks_sa8775p,
+	.eqos_start_clks = eqos_start_clks_sa8775p,
+	.eqos_calibrate_pads = eqos_null_ops,
+	.eqos_disable_calibration = eqos_null_ops,
+	.eqos_set_tx_clk_speed = eqos_set_sgmii_speed_qcom,
+	.eqos_get_enetaddr = eqos_null_ops,
+};
+
+struct eqos_config __maybe_unused eqos_sa8775p_config = {
+	.reg_access_always_ok = false,
+	.mdio_wait = 10,
+	.swr_wait = 50,
+	.config_mac = EQOS_MAC_RXQ_CTRL0_RXQ0EN_ENABLED_DCB,
+	.config_mac_mdio = EQOS_MAC_MDIO_ADDRESS_CR_250_300,
+	.axi_bus_width = EQOS_AXI_WIDTH_64,
+	.dma_ch_regs_base = 0x8100,
+	.mtl_regs_base = 0x8000,
+	.interface = dev_read_phy_mode,
+	.ops = &eqos_sa8775p_ops
+};
-- 
2.34.1
