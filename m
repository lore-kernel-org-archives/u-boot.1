Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E1E606A338
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SlBHrhx/;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=isGGqeUa;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bzfmQdG0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9F0C607B6;
	Sun, 15 Nov 2026 19:00:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4RP1ysNQ6LCM; Sun, 15 Nov 2026 19:00:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 905D7607CB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794769250;
	b=rQsJyKHmdgb8KyicJ+aWkIHx3iqc3ghNJzqhS4bZZQfiN6FiUX7L8Yhdy6vVx8G031Sm
	 WXe7ay4wTvd/tNE6noMMd3ohf6Uzpw6CVZxnokkPpUMmUZQPOZ8rxShqXMiHCpgtrnfcX
	 gY97UH4xk7EWyL2cYRxlKy0xTXzk82RfbIvh03IPt7kncs3QUiKCJIKyvCDy2prfWNiea
	 FThhSt3WbTC6fhKqFa+yiSAh8GRyKOyyLQoEPqb27WT9jylPlD5F6CgLRP3KcnKuQ6ld2
	 cCADGHgFEqse2ZQ6LLJNtRCw62IkiklaOrMTqMkdW5yIFBJzYnOxHB/3TY/2p7oRWxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794769250;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BB7TKafhZSgp5+K2GGpNaJR0X1ANBmbKCZ+OVwuCzdQ=;
	b=Y5IlJhUYCOHqdrLDhrRju3XsJ34a+VwQQ2rtc7rc7W4k20afgJh8SdXEgGl1fHi1gGiL
	 DhpWVcFWERl0p5pbqJxxcUzjCyXVclnfXQ7Sob5gS3ZdXEJCZtSpc1+LoRWIIQ6M0m0xj
	 clluzjomtisKf2XK/8rBsauUwvMxBmnc4wj10SKv9z0pBtglFQxd6JrgYDChYNoL447pS
	 TTzCd9OSYTPoesoJ9ywt/bWup2BfYsQQOmG/NVXPz4/QOSJ1wpfZMvd0v2VHumFPG9NXd
	 JVbvnL1yV6dzxLZ0/E+6TJdri4hX2hnrb1MLLkjfqLDhUGpUS+/Bzmc6jDnj9Jmsgfw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794769250;
	bh=BB7TKafhZSgp5+K2GGpNaJR0X1ANBmbKCZ+OVwuCzdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SlBHrhx/jsZoWqoL8E22h9YzSVycq+mdSQhLv/JB/cbCsM0JdIho/yGDY44G33mXV
	 o4e2CMRyHuiLzLb/Pz7NQV4+PxrpARx8k7VbxLfoS+NKt4Deyc0sOjWyDmPuUKrg/y
	 Zy7Zb3KW7TBwtqAgYn0zxZHqZsccV0mwfvQ+KEU7yjVO8aPIbsQ5hAQ5egM6hIWWqA
	 sQOv161vhUg7PXEfUpPweP5isisuFdLViAa6QFZfUBb0n55gPaij+BzH8FSfNosZKu
	 Xg98CZb8HVXHI/6z92pwvY426NV+AOYQKYBVEaFDOk/Xgs/8Y4+whV6rCL1ofxECTt
	 joLlyqXVc88uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 905D7607CB;
	Sun, 15 Nov 2026 19:00:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CC5E71E7
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BE73140061
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xoc4phYWzUd5 for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 18:20:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2478C40048
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=manikanta.mylavarapu@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=isGGqeUa; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bzfmQdG0
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2478C40048
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:21 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AFFBU4o3084041
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BB7TKafhZSgp5+K2GGpNaJR0X1ANBmbKCZ+OVwuCzdQ=; b=isGGqeUa89/XX9sZ
 rKi4aT/Tj+PpOyp8zEBPmrkjfFWVVvZVTR0v6UXWWh6FeHnwwgD3WlQyZ8jS237W
 66oO0YvqS97Uy1ec5U782JkR5w0pJRGLZiZjySfkDBlz5BH3hUaSU8X0e+kf4HrE
 TNzR3xRZMGdTeJI8hyjcqpp+8JRTuJVDnLhd4S4lk2ne8LValEKBf7eRZa3U6T4w
 KC6nML0pq4rMallYmRI1z2yrzBeVw0aIaVYnN8K3tOt7zmaUHlHhZS0kRAnMgcqa
 sGIg0x8YgEjolVRSvW3EhFJPABXvEmnYq5hVzZ1PuJeldQe4QKDPjdvDONeNO9fh
 VI4PEQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhk23hdy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 18:20:20 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36f479b9819so972804eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 10:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794766819; x=1795371619;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BB7TKafhZSgp5+K2GGpNaJR0X1ANBmbKCZ+OVwuCzdQ=;
 b=bzfmQdG0yPNh9KfqAA2kKTklOiI67FNS5lONpPlH5chRSzeID805iollxJQdVwAny2
 1FiZYNSf15qSO7aW3vYwvd9qhoAwpoIkUcvj6g7nj2BCNGUoSaNF3RnDvM5iBpOQ9pUO
 nLZnt46LZ5oU2swn9FsqTEEti74MezXhG6rEMiZlQlfIa1HEdhTTMD2srQgVUyxP7h4G
 WpJdViA4akBguFwXPuyR6YaSB8HNEvD/W80q+TDub3irfGIMCsADwujAGJFpHxtP+eVk
 7jEY14tJbHghs0w19v5ouMuAYQX4+Y7a311K1S3Gl6iY1z/PIwxajmr+FppM5XmeRhrt
 GD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794766819; x=1795371619;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BB7TKafhZSgp5+K2GGpNaJR0X1ANBmbKCZ+OVwuCzdQ=;
 b=TTpK7pMmQxKw9V4/eaGRqZxF2QoUSJp8tg8zPlIfVtp9xQWsGF0Xtdux9BBmEClhUW
 mON2b6aFb1fUT4mNoSoz+NohFitteCVmrvA2mBStOF+1BskMm2fONg/bl5siBtxK/aQ1
 IpLp6aw86+mMgDrAemwCCoEiiS4O4zLNlMtkSSrF7UpUVB+Vl6JiWBvPQhYv73+4gxi3
 bFsYgni8iHyrThjwOKW4BNWnmXke2qTehFBALoYrULZ03eTyiRFkgvppsz5QUyJV34MZ
 Ka5tZ6k4ZN6xoW5dXjN5ch1AHLRKRyFosR60+JEg7A6MbInbsFUt6txwhYyxOsEamTts
 Y2jg==
X-Forwarded-Encrypted: i=1;
 AL+hErHvXwqWSEaofBeV/4xqMCRhODULdlTg3qXeQfOgKd4Vo4HD0Av5jHkwWKyZoE5hUSTsXSmCtao=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+iM+TLkDo7UmMR3eXhb8yEY067cSAz1GJkiD+J2l8SVhbbCHRk
 i9i08f3oiNRdG5YdfdbcjGnjD0yPH+SSNsSyAIOeNEHsMDxmcAPE4einNyz9loZd2Ni9yjHbdNd
 HIit+mh4w9Bcw4BdzrW1BIc7xQYxh+Ip+/BknzM6DafRyIo2c8mAchxbd5s5J7bYy8FsFpK/D8b
 rdvLcTRg==
X-Gm-Gg: AYBFou2HyV9RT4gf9wMXbFmLNZhbTxVArkVSwtzstMi/fVBYcDYOuJSfaIXZ2/4p95t
 W94jSfFjZgCtxB09y0DmCcA2r+imVRiN7jKO+TjR6dvF7uWx8qjKkPyCjgCkO74LbALJ1pJTBF4
 d1NRFgYtdW/0z4VvlJva3PuVLclEHvJTpktm5Z+K6f7ZTN2ZrP6Uw+9FxEOCIJ+cVpuVf7wm7nG
 bFd+XuKA9GKTR/c0sQSA5D2kuv/nDkdmtb+Rrkh3fRvK5prEsMrM2NP5+qrzPLzu5wZoch74Twc
 w1NdSbxoph0LdAHUicKZ5YmG6yfYYQ9AaGrcZT7vskPh0G2UePivH4Q3ebNLgI14S8CRUt9aN/U
 doxveqBfYhwDvaDtg4UGjWV4RQUWrzKO1fmOZRdZycrvg7L+wcxoCwLUcCJfh9LKawDoGkqJME4
 Qv
X-Received: by 2002:a05:7301:4206:b0:369:535f:4d12 with SMTP id
 5a478bee46e88-37963a53df5mr7641357eec.3.1794766818745; 
 Sun, 15 Nov 2026 10:20:18 -0800 (PST)
X-Received: by 2002:a05:7301:4206:b0:369:535f:4d12 with SMTP id
 5a478bee46e88-37963a53df5mr7641316eec.3.1794766818008; 
 Sun, 15 Nov 2026 10:20:18 -0800 (PST)
Received: from hu-mmanikan-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955f02ff0sm26598663eec.16.2026.11.15.10.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 10:20:17 -0800 (PST)
From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
X-Google-Original-From: Manikanta Mylavarapu <mmanikan@qti.qualcomm.com>
To: trini@konsulko.com, lukma@nabladev.com, jerome.forissier@arm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 manikanta.mylavarapu@oss.qualcomm.com, deepak.g10@oss.qualcomm.com,
 dlechner@baylibre.com, 3305708832@qq.com, jstephan@baylibre.com,
 macpaul.lin@mediatek.com, junhui.liu@pigmoral.tech,
 quentin.schulz@cherry.de, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Cc: kelam@qti.qualcomm.com, gpotnuru@qti.qualcomm.com
Subject: [PATCH 3/6] phy: qcom: add SA8775P DWMAC SGMII SerDes driver
Date: Sun, 15 Nov 2026 23:49:33 +0530
Message-Id: <20261115181936.1750625-4-mmanikan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261115181936.1750625-1-mmanikan@qti.qualcomm.com>
References: <20261115181936.1750625-1-mmanikan@qti.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TaUu1ZALjKtemm7rV3py4vsK6jTvzPU_
X-Authority-Analysis: v=2.4 cv=QanzLcbv c=1 sm=1 tr=0 ts=6af9f7e4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=9XIREjv9CgeGctGCvocA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA3MiBTYWx0ZWRfX2KOcpu5DqToH
 b2zwiGvSPp3tB/uKUIwT7dIMIMenyHDNtMpDelQRRdH1uVjwpeacXMJyQCyCwSmX/zYRa8otiEH
 UbMeY8PWuk5dHi7lWgNtPVj1qkGA97GZ5TYr+TuCg4Z24IXXyeQUks6YSBdlqZ1S0lhqqvwKQIp
 TfgKZ8fAUDj2lac5WGnoazg78jA5jPSeH/KfBN4QlDikuHAY3qJnfMwKpcuR7ryTSWgnO/M+EKQ
 QEzYUgszUKLcMsLrtb/pcn3DdaVWIvja7Ur2Ml7jkrWNQ70YIrGSzEPW8GmTyBQv/ydGqSxEZUu
 aEagDtgqche+9jNrYkVegUTjPBRJtIscbKn5vaNu1A9q/omexeUYBS/0gzI6QG0ei4MU8i7RaY3
 MxGISy9f/n3CHIPWQiQkDbFSZaGdUywT+uvn4uj0cuNFoNyVo3+FWnXptqwfqPOvvaxEJWvtl4M
 uabhfdKFj7HmBz3ASCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA3MiBTYWx0ZWRfX9szXcX53aLTV
 58uEn2socXddGzrmE9GLG6sDLi6jNRxAs+ZqYKduJgDmu1oe3/7HFRketIKtjJrWhNERiwUY09b
 taPkVtbtPLoE/4mLkUFLNNF3R5kqvmo=
X-Proofpoint-GUID: TaUu1ZALjKtemm7rV3py4vsK6jTvzPU_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150072
X-Mailman-Approved-At: Sun, 15 Nov 2026 19:00:41 +0000
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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
 configs/qcom_qcs9100_defconfig            |   1 +
 drivers/phy/qcom/Kconfig                  |   8 +
 drivers/phy/qcom/Makefile                 |   1 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-sgmii.h |  21 +
 drivers/phy/qcom/phy-qcom-sgmii-eth.c     | 504 ++++++++++++++++++++++
 5 files changed, 535 insertions(+)
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
index 00000000000..2d0815fd108
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-sgmii.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
index 00000000000..730c2bf521f
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-sgmii-eth.c
@@ -0,0 +1,504 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm SA8775P DWMAC SGMII SerDes PHY driver
+ *
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
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
+/*
+ * Match Linux's 1.5-ms polling interval and 750-ms total timeout.
+ */
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
+/* Program the Linux-equivalent 1.25-Gbps SGMII/1000BASE-X table. */
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
+/* Program the Linux-equivalent 3.125-Gbps 2500BASE-X table. */
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
+/* Poll each SerDes readiness bit using the Linux-equivalent timeout. */
+static int qcom_sgmii_eth_pll_poll(struct udevice *dev,
+				   struct qcom_sgmii_eth_priv *priv,
+				   u32 offset, u32 bit,
+				   const char *name)
+{
+	int i;
+
+	for (i = 0; i < PLL_POLL_RETRIES; i++) {
+		if (serdes_readl(priv, offset) & bit) {
+			return 0;
+		}
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
+	/*
+	 * Get reference clock.
+	 * Linux: devm_clk_get(dev, "sgmi_ref")
+	 * DTS clock-names must contain "sgmi_ref"
+	 */
+	ret = clk_get_by_name(dev, "sgmi_ref", &priv->clk);
+	if (ret) {
+		dev_err(dev, "clk_get_by_name(sgmi_ref) failed: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Get vdda-0p9 supply regulator.
+	 * Linux: devm_regulator_get(dev, "vdda-0p9")
+	 * DTS must contain "vdda-0p9-supply" pointing to a PMIC LDO.
+	 */
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
+/* Apply the PCS reset sequence before disabling the clock and local supply. */
+static int qcom_sgmii_eth_power_off(struct phy *phy)
+{
+	struct udevice *dev = phy->dev;
+	struct qcom_sgmii_eth_priv *priv = dev_get_priv(dev);
+	int first_err = 0;
+	int ret;
+
+	/* Keep this sequence aligned with the Linux SA8775P SerDes driver. */
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

