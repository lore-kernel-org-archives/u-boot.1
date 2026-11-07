Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A5D606A334
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YWreCsxF;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kY3J7UHI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N1//bODX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 09DEB81B70;
	Sat,  7 Nov 2026 12:53:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 22wqxaW0waJp; Sat,  7 Nov 2026 12:53:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7235681B7B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055993;
	b=ppuqUrv7MpqgoIhMruAWL+2hvv+nEoJl5yhsWKO+ZTi1F1n/Mvhoz5H2UMV6zW7YHzgR
	 YkdIqrBvE0q+HEtdYB6xmOiGFxUkzY4CPGfQYjU+xKx6qwixGvECyPoWHNqtgVy/e0S4o
	 WasIwlsYSTgWixD3P+En8jlqtL70rBd7jkGV5WTVjmlCQ+63t88E8SgzObRLZa38pweiH
	 vtrYYUPbyLN0urJIfZHax1L1DKw44wCMKNMbMHGnMwCRtOam+8kbLiXL180kdEa+TpnvV
	 P9k/lW/OHuBdMyVjJ6zzikd9eX4hRs02KOTjuYJaNWfKJDPeiFJsh/vhljPCeBxLUHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055993;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+0xTHY0BPUyfbs7CKQGpmFPoa6thk4YkOXIRZ/hYvqY=;
	b=iTN6u2VGS6fp32LRS0LRcIJTRwl7oVOifgs/XQJ+0PSE7rDiqScsFbOXjSx5kO3ND0R6
	 XVEZrQQ5vwVbjA4h3j8Tauq2dOLjj75NQdDwJIz6Y+kVLmaqJ7IkAwl+LhMEcdxoGnXIQ
	 EVAOayzEpBmJdoa552Fwr/D7CkNpOiF239NdeKY46Tgn3cjd24pbmf2vjNHoWCX+9QVdJ
	 5qQzK5f2mPlJBOR9s4MRwflE0MT9Kuv67jnYmuU08QPQrJKuRSHGH2V5qKUOVjA7cuhNP
	 Kn0c60HVqmmfaNisfzRTP9eQYrR2hnlC1Wdm2YTb2sIx0xmlamD61e4Z+m9z+ftfIBg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055992;
	bh=+0xTHY0BPUyfbs7CKQGpmFPoa6thk4YkOXIRZ/hYvqY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YWreCsxFwVoe+U7Wtt56Dhw9OlnjoefeVSnYi9wi9n/9cgaMj7QZ7ptyDtDOul8nW
	 t5iUIbtRhYxgAaP1erp6QRo+J9/hB8MCu8wa7XYLqKOJX4WURhl1AN9jttr+ILZ/S9
	 WDMGjjcJ6eX6WDh3mQurWwKTeYaTmi7s2eJxPKwSSzUf+k5cjq+uqt24ZmRBjpRoY5
	 jqLKb32y9ftcfYIGmM3IK4dre+MsfbnGORURXRKp7WqTXCQYLdHTNzslfjIWCAx4u6
	 K2PZlF2FNVoZRY1dARNItKJb+iEJsVV2cOlzg2i4Y6wHxzwYT64BnrFztQsvzGtx7O
	 WbPZgY0YaLPWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7235681B7B;
	Sat,  7 Nov 2026 12:53:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2338F211
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 12:53:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1521040786
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 12:53:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Yl17TuXPD9a0 for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 12:53:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 120B440785
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=kY3J7UHI; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=N1//bODX
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 120B440785
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 12:53:04 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A7C0WCh1626991
 for <u-boot@lists.u-boot-project.org>; Sat, 7 Nov 2026 12:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +0xTHY0BPUyfbs7CKQGpmFPoa6thk4YkOXIRZ/hYvqY=; b=kY3J7UHIV0NZo0U9
 5FOn7Tf9nVkQ/i8X+A4QtrnTsq3BXTu4LfovbW7cOoEGyKMginEYj1BHOSFM8s2v
 LTxlOc3L/qoME7TAANTmh2dNgHPbgHZOs4t6tXl0GMyuwp0a82B76aNptUMWWX6K
 2hOB65ZvJnomqInA7yo/SfSJSn7SK0/Ozw2H2lzkVSTM8inIqI3MKGN3+hf590EN
 D6lVvpKwThGs1xdAa4qs1o39zad1O72zO6WqwfuzQCIRv/+pkcWVQsgc2u8uufrp
 H6mZuKecs901exsp6LBLEZRs4Bz5HYJysoE+mqzxDFwwEva0flrY7Uobg+2eHNyV
 G4t07g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsvc6gty9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 12:53:03 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f13c143c8so308743485a.3
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 04:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794055983; x=1794660783;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+0xTHY0BPUyfbs7CKQGpmFPoa6thk4YkOXIRZ/hYvqY=;
 b=N1//bODXlHhnIFHd6QC3ddP7slZ6oUUQ2PH3RwtS+Wm1D7hepBev6CLaqSLrUc0tiY
 X520A+EtJxv72fTJu6Fwd8o0HbgJVwkK7DwBv0tkh3tx49CqcGqZIRGiSPf6Tir1cP3P
 h7s5D4SJBhpmVm6Ux5x52XZ8fQIUDCLaUG0xmDMIq2GH0cy57ymWyxwZSQPK4ay3+XXU
 e0Oytp/7cR/cCKFBrxjaIZlLGOvscyHelj0+EfC6SkfeyBOi3yuziY0NI+oPbx5ixpcu
 0RnmlDY12ejzonFLkEQ91/5KbYbPExvOm9Fg7z1/qlSxph/awxZ4rMUI+q7D9I8+X09g
 OyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794055983; x=1794660783;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+0xTHY0BPUyfbs7CKQGpmFPoa6thk4YkOXIRZ/hYvqY=;
 b=lK+dvIVgDCNZ3C1KsTTvfey8qBKl13/a0TksGrScFsDDu63eoq2tvYoAMKZGInNCaH
 b+uxaE+d1bX+jrZD5GN8PT0g/Dxy8G/J5S/nyH6Y+U2bmwPhO3/Vq2r0Ba/GOdiaCfGZ
 jkAeqIuYTp196GrBydvfgT2OYUgLWIXisbVKkkKHQQB4MsI9/4itG1vO48+7s0S0eDuP
 F4FKOqjtks3w8vSl9tSd1jTHV+HrpVDT5Kn/7hql1g2rZ6NF7BAH09Ay3mJhQlBg1Xi5
 epzu1NytGyhAtRxK5lPyD//gnlX9wKkGuEHWSdtOUYrvEZJlTVdI3XzD5cR1bwcmWZmx
 qhZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8+0kag5kWJ8OaWvvkAkqSyhGzXtNd2CMiwxBjjxu321iBONPQ0M2NEfnIcNBY/kINfVzh8hE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9720RThq2OgRnwWuX/tgD9JQ+kAzNdVXZMntGFO/9YSgJUAE3x
 iMuB3XGYWP6h+6On7Fb0CCFdcLQTvryc7IfV2l/QGYmcUSBbf5zla1bWpkmDgTmHWPsmyyOv57v
 ZxmQTZBpmWxEsdf3C+8jrTBgwTfJUTyfC9EZgn0goeZZwO1qGSD2W4RKzP6h/EQOFh0L5jm4=
X-Gm-Gg: AYBFou1C2XqmVCUKXsBZEI7Kah5doN6/bPqDN2uCMMwUm7OseaMf5ieirOTlcTTuVJC
 /uw7Ql/AXIxKbmSXfPDjpozWmRF3oSZqepFxHluX9g2do/AIakD7BkQKb5Opjlbe355kDr/X1b2
 yMyCkAy9gDKU/8c6o0LktK9STYKZC7LvwleI/SGjB0ttu8X/SWgtONQIan7FJEHhk8zU+bs+wVK
 5eDVt5OhSn9U6qbJooOcLavD6nVpFG8bxa7i/vHR637cUCFLFizlk19am3WJq4OvXxPPmI8+cvb
 GSWjQ7kqQncTccMWPec38xOfoMYZgwAZaJz2EMpaPZEdEjIXmOeUvPvONJA3DkdeI3sncCwSnmE
 q4AZMFBon3etuKpbQnnIed6Jm390jq8EAa0cGpbrTVHf25b33jG0URixUV0YyDm7F+h6IzzaE2s
 n9OLzWXQffw37n
X-Received: by 2002:a05:620a:4448:b0:93e:4d74:68fd with SMTP id
 af79cd13be357-945f35731d7mr847046685a.65.1794055982884; 
 Sat, 07 Nov 2026 04:53:02 -0800 (PST)
X-Received: by 2002:a05:620a:4448:b0:93e:4d74:68fd with SMTP id
 af79cd13be357-945f35731d7mr847043285a.65.1794055982418; 
 Sat, 07 Nov 2026 04:53:02 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d356c3692sm148599966b.66.2026.11.07.04.53.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 04:53:01 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Sat, 07 Nov 2026 13:52:53 +0100
Subject: [PATCH 5/5] test: dm: fastboot: test the flashing commands
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-upstream-avb_tests_b4-v1-5-9177277458f9@oss.qualcomm.com>
References: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
In-Reply-To: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDA1MSBTYWx0ZWRfX4hKJmZCpojjc
 LliKY9SuaYdkCqPAoOI6rOR2/8tCzqa9TGg3SnbD2WDYm5EcERzyrERWfXfBYUWH4N8EbxTtPD8
 bEmIQrXTA6F6Aa3qIOA8AWKjiJSFv2Ktd6yz6LK8T0WOeCu1Pa0obbqy+RwYkJDBb0Lkc0hXmxV
 rZwun9jtYTYqXHt8O/Rup0xzgx1zKvgbRehMeIrMcJlVH7eX4+ugwfJ7jIRv2hYWkxuBhY8Rpp9
 pYTedMFiCnQY8w5tWktQ5eltd34Kk5nvgpDj3Py4+lmSiyOIGkLphe71VfXHYS3CWLCTD7eeWEr
 4fYUNqFDNiR1yrthrcnsuKH9UU1G93zwmcCqA+9bAGDf0QUYe/w/vEMxqvjG4Y05/4L0OOa90ul
 UdoChJaWsZ9t/F1FoEy9I3whEaw6hSTMLcaEqeoOXvogIdquNVL32HXfS5MRbnpHL6zwE+AXlRc
 kcFGzlAF6QP5BFNuxbg==
X-Authority-Analysis: v=2.4 cv=WOjqzXsR c=1 sm=1 tr=0 ts=6aef1f2f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=rOiDLTwacElUy9sY8VYA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDA1MSBTYWx0ZWRfX1KOxO9CXyt4S
 8/CRsmDHRNq6OvOrakDAGaWcl9pVVU4Y+2rFuuSJWps8kHlFA7F0WKx4t8A2SqNwm93Faca6m4F
 92hZb9UQN+FmctiT+uktYFsZtW5F0g4=
X-Proofpoint-ORIG-GUID: JaKUW-H4mizPoXsvyIINwqxaU9MbVjj0
X-Proofpoint-GUID: JaKUW-H4mizPoXsvyIINwqxaU9MbVjj0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070051
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

A locked device must refuse images nobody verified, unlocking needs the
user's consent given in Android, and every change of the lock state
must wipe the user's data. Enable FASTBOOT_CMD_FLASHING on sandbox and
test these rules through the fastboot command handler.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 configs/sandbox_defconfig |   1 +
 test/dm/fastboot.c        | 144 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index c63a4df8bef..fb787101b95 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -213,6 +213,7 @@ CONFIG_DMA_CHANNELS=y
 CONFIG_SANDBOX_DMA=y
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_FASTBOOT_CMD_FLASHING=y
 CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_SCMI_FIRMWARE=y
 CONFIG_FPGA_ALTERA=y
diff --git a/test/dm/fastboot.c b/test/dm/fastboot.c
index 5b51b6bf9dd..d5179630b85 100644
--- a/test/dm/fastboot.c
+++ b/test/dm/fastboot.c
@@ -3,16 +3,19 @@
  * Copyright (C) 2015 Google, Inc
  */
 
+#include <blk.h>
 #include <dm.h>
 #include <env.h>
 #include <fastboot.h>
 #include <fb_mmc.h>
+#include <malloc.h>
 #include <mmc.h>
 #include <part.h>
 #include <part_efi.h>
 #include <dm/test.h>
 #include <test/ut.h>
 #include <linux/stringify.h>
+#include <u-boot/sha256.h>
 
 #define FB_ALIAS_PREFIX "fastboot_partition_alias_"
 
@@ -93,3 +96,144 @@ static int dm_test_fastboot_mmc_part(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_fastboot_mmc_part, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+/* Run a fastboot command, leaving its response in @response */
+static void fb_run(const char *cmd, char *response)
+{
+	char buf[FASTBOOT_COMMAND_LEN];
+
+	strlcpy(buf, cmd, sizeof(buf));
+	*response = '\0';
+	fastboot_handle_command(buf, response);
+}
+
+/*
+ * Write the frp partition the way Android's PersistentDataBlockService does:
+ * the "OEM unlocking" setting in the last byte and a SHA-256 digest of the
+ * partition, taken with the digest bytes as zero, in the first 32 bytes.
+ */
+static int fb_write_frp(struct unit_test_state *uts, struct blk_desc *desc,
+			struct disk_partition *info, u8 oem_unlock,
+			bool good_digest)
+{
+	size_t size = info->size * info->blksz;
+	u8 digest[SHA256_SUM_LEN];
+	u8 *buf = calloc(1, size);
+
+	ut_assertnonnull(buf);
+	buf[size - 1] = oem_unlock;
+	sha256_csum_wd(buf, size, digest, CHUNKSZ_SHA256);
+	memcpy(buf, digest, sizeof(digest));
+	if (!good_digest)
+		buf[0] ^= 0xff;
+	ut_asserteq(info->size, blk_dwrite(desc, info->start, info->size, buf));
+	free(buf);
+
+	return 0;
+}
+
+/* Fill a partition with a pattern, or check that it was erased */
+static int fb_part_fill(struct unit_test_state *uts, struct blk_desc *desc,
+			struct disk_partition *info, bool check_erased)
+{
+	size_t size = info->size * info->blksz;
+	u8 *buf = malloc(size);
+
+	ut_assertnonnull(buf);
+	if (check_erased) {
+		ut_asserteq(info->size,
+			    blk_dread(desc, info->start, info->size, buf));
+		ut_assert(!buf[0] && !memcmp(buf, buf + 1, size - 1));
+	} else {
+		memset(buf, 0xa5, size);
+		ut_asserteq(info->size,
+			    blk_dwrite(desc, info->start, info->size, buf));
+	}
+	free(buf);
+
+	return 0;
+}
+
+/*
+ * The flashing commands guard the AVB lock state: a locked device must not
+ * accept images that were not verified, unlocking needs the user's consent
+ * from Android, and every change of the state wipes the user's data.
+ */
+static int dm_test_fastboot_flashing(struct unit_test_state *uts)
+{
+	char response[FASTBOOT_RESPONSE_LEN];
+	char str_disk_guid[UUID_STR_LEN + 1];
+	struct disk_partition frp, userdata, metadata;
+	struct blk_desc *desc;
+	struct disk_partition parts[] = {
+		{ .start = 48, .size = 8, .name = "frp" },
+		{ .start = 56, .size = 8, .name = "userdata" },
+		{ .start = 64, .size = 8, .name = "metadata" },
+	};
+	int i;
+
+	if (!IS_ENABLED(CONFIG_FASTBOOT_CMD_FLASHING))
+		return -EAGAIN;
+
+	ut_assertok(blk_get_device_by_str("mmc", "0", &desc));
+	if (CONFIG_IS_ENABLED(RANDOM_UUID)) {
+		for (i = 0; i < ARRAY_SIZE(parts); i++)
+			gen_rand_uuid_str(parts[i].uuid, UUID_STR_FORMAT_STD);
+		gen_rand_uuid_str(str_disk_guid, UUID_STR_FORMAT_STD);
+	}
+	ut_assertok(gpt_restore(desc, str_disk_guid, parts, ARRAY_SIZE(parts)));
+	ut_assert(part_get_info_by_name(desc, "frp", &frp) > 0);
+	ut_assert(part_get_info_by_name(desc, "userdata", &userdata) > 0);
+	ut_assert(part_get_info_by_name(desc, "metadata", &metadata) > 0);
+
+	/* The sandbox TA starts unlocked */
+	fb_run("getvar:unlocked", response);
+	ut_asserteq_str("OKAYyes", response);
+	fb_run("flashing unlock", response);
+	ut_asserteq_str("FAILdevice already unlocked", response);
+
+	/* Locking wipes userdata and metadata */
+	ut_assertok(fb_part_fill(uts, desc, &userdata, false));
+	ut_assertok(fb_part_fill(uts, desc, &metadata, false));
+	fb_run("flashing lock", response);
+	ut_asserteq_str("OKAY", response);
+	ut_assertok(fb_part_fill(uts, desc, &userdata, true));
+	ut_assertok(fb_part_fill(uts, desc, &metadata, true));
+	fb_run("getvar:unlocked", response);
+	ut_asserteq_str("OKAYno", response);
+	fb_run("flashing lock", response);
+	ut_asserteq_str("FAILdevice already locked", response);
+
+	/* A locked device refuses to change its partitions */
+	fb_run("flash:userdata", response);
+	ut_asserteq_str("FAILdevice is locked", response);
+	fb_run("erase:userdata", response);
+	ut_asserteq_str("FAILdevice is locked", response);
+
+	/* Unlocking needs "OEM unlocking" in a valid frp partition */
+	ut_assertok(fb_write_frp(uts, desc, &frp, 0, true));
+	fb_run("flashing get_unlock_ability", response);
+	ut_asserteq_str("OKAY0", response);
+	fb_run("flashing unlock", response);
+	ut_asserteq_str("FAILunlocking is not allowed, enable OEM unlocking in Android",
+			response);
+
+	ut_assertok(fb_write_frp(uts, desc, &frp, 1, false));
+	fb_run("flashing get_unlock_ability", response);
+	ut_asserteq_str("OKAY0", response);
+
+	ut_assertok(fb_write_frp(uts, desc, &frp, 1, true));
+	fb_run("flashing get_unlock_ability", response);
+	ut_asserteq_str("OKAY1", response);
+
+	/* Unlocking wipes userdata too */
+	ut_assertok(fb_part_fill(uts, desc, &userdata, false));
+	fb_run("flashing unlock", response);
+	ut_asserteq_str("OKAY", response);
+	ut_assertok(fb_part_fill(uts, desc, &userdata, true));
+	fb_run("getvar:unlocked", response);
+	ut_asserteq_str("OKAYyes", response);
+
+	return 0;
+}
+DM_TEST(dm_test_fastboot_flashing, UTF_SCAN_PDATA | UTF_SCAN_FDT);

-- 
2.53.0

