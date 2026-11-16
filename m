Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB22606A323
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kDp/TY1q;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dbdIQ7S2;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XEWm1wZl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B85C6078D;
	Mon, 16 Nov 2026 11:39:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IAwCz6OveN31; Mon, 16 Nov 2026 11:39:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E2133607B9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794829171;
	b=R1IsmqmcwNj2TF+YCgdxsgQvzL6VAH1aPqnvGNILZi0LTsZCWhSubNqngIJbrDpcOgZK
	 5hLXDba8gjNwjDiIhw3Oea8crIxrOoKXS5OEcsny+vcPDvPwVUzWBiTXaJYTOm0XDqPvi
	 OhC2ci9QYAwCsPLPUW5Nh2Uay5EBrqT+3+EFlPKgIhnrK9ZNdvPBx7Lw8Mc37MSRalWu0
	 Yzk4yESMo1S8jF/GsmjoCUGs8Vjpd5kfdX5fRhWhZNlypim5Zci9dbvRQ3OasEayaTD+h
	 1pX6TGSo5y1+1zmDRIPlW621AdgkEVFpzGYP9ktblRaGIPhUACbeGQJId46yxeFV7gw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794829171;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cZNsgbR0hExTnLiG5XghEzJQW/9Ed5hup/dv1psr9Qk=;
	b=YnXGQ/dvL4DlSfNY8dx5LQfE/MHASVeOK2TgWdojoSYHzdQD6cbFOv1BYgyMOgzHZFo6
	 ZEifgNVBBnDQhDAJQ/f4sirGL0T68m3OSKXVOBm44rIETtpLBSr4SXUPnPEi00zQRepo4
	 Zm92oMJg5Ydjgy1tkxt7Alv/Lna2h7kuMgJkh6ontJO7f+hmc2QYV7spBINu0XYQmHLm2
	 cF4udPzq3DWgfZdWNLSs1Uj3FSDf5FZY1BVMtROb+qReIC9dkIRfzjWACIa1PwGX20zsr
	 WLxfdWCsWt2DM3jdCZ/8CM0TN2jx8ec/eqlM5z5PKqU6QXmY8OL3I5FNee7I2KMJ97Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794829171;
	bh=cZNsgbR0hExTnLiG5XghEzJQW/9Ed5hup/dv1psr9Qk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kDp/TY1q8LD0BOpfEa6Z7sXdcBalGEvFbwT9Gn+2yj4gozAPiQnPdJXe4oEb06yHg
	 9R9nedGg74cDz/2XFc3bPFyGOMRk9yEbOxuewI60zMG8T2jIbzSxjMQkPtBgKYUrA9
	 YxIgItSLDHqLgnYebyLf0IGdlmTbYIUWyk9y4aconQ6SgTZAR60Aj4lZHkt+zK0NpA
	 nGaVSoybLgmjiPynWvBIJafk1vnW19TsvdN4YATBMkujRVkLUe1g68pAn565Fo76S1
	 xCWqWhSxWXqz4t0FKV1d59mhlXz7jj2lQXxS/1DNl9vPMic3FGxl2Ve5H5TtZ2KeUY
	 yAWxDh3SeMJiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E2133607B9;
	Mon, 16 Nov 2026 11:39:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 702402FB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60E2B4009D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:39:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hZt-ljeqxdfD for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 11:39:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6A78240068
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=dbdIQ7S2; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XEWm1wZl
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6A78240068
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:39:27 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGBM8N81130769
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cZNsgbR0hExTnLiG5XghEzJQW/9Ed5hup/dv1psr9Qk=; b=dbdIQ7S2JjCM8OKl
 SxKCRNF/WRxugKok+urhkFCzwFnQSNgoVHOq71UXgmMDboFQVbn7HoCKakgF2bPs
 1xV3hJkFQkXRA+ujTg+g1CWk7Qz4LyL2kGKEB0pXwmnTC81bzUToMhUYG9V0u720
 Z8sxDtOPSWPB6VVZGFlf6PA2jbVIHpx6GVD2cdQHn1E4AHKSth9SmzlzDfSDU0r0
 tIehvem3I/BSEjq+lI9S3orgneErWkVpmX5oi1CFdPXM00p890aUrvXOW0WlJUp5
 ctmo2SLdNUAd51L41tD6o64V3onHLZ3fu1EZDoGBebSZHQt8c4kErnePubrSiOTH
 tNy3Zw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqy8aug-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:39:26 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36de26cb4b3so4130664eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794829165; x=1795433965;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cZNsgbR0hExTnLiG5XghEzJQW/9Ed5hup/dv1psr9Qk=;
 b=XEWm1wZlKU1/fFkuKmzGvgQksk7uybhdHWIXlmfqssWh9JTyFd+IABaowkpJP0ijKU
 e/7B6M9xPbgPnoRXfAfF/m6DW37i62orcLHiD+hduR7L9MhhzmKR9G5Wi1NuFBHi2F4+
 qsR+NvPDw7Z0l/1iUXdVcxuq4/sLIOBvbARwH9CgCIF1mV9XPlhqOaBZrnB1/ghngjqv
 ddSE6rSGGWAvzGKPArhAxW/29Isw+Jp7W2xlKGcv5v4Qzb6uW/uxHWPWw6PoevfKc6me
 MfbstVh5DOnJ8qoTJ3ELE3gGzm38R/9SpRzhR849J11MaaVqAkCZQKQXuuKj89kfzAQL
 xfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794829165; x=1795433965;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cZNsgbR0hExTnLiG5XghEzJQW/9Ed5hup/dv1psr9Qk=;
 b=Q/U97FN2ip3pG77kBZuco/1K59yJqlIREF665qdLnnSuQkgLgW1Vy4SLpHE0paBfNG
 qD928yiYSxkQ+QHACisa6ByOBTjTa19tY2Ve8/n/1TYPAdL5qBtspWLrYV+t0UxG/RiW
 Jk4JyAYLPWGz5MrFV0XLC90x+p61Flp2mBSFUNGIHIm6lq5A9iUDo+WLM2KWY5sX5xa3
 m71CKTr96HtIZqoBIWYV65voqRKzJBZwJlaCPlE4vjL6WEYLDRuPVSqWU3rxX4uLhrbT
 mgMIgHXGp3JwWWE6/WMOU7cAkY+PK3MMpGJoHoz97K1RlihiEqqHV32iRplW8I54Em4X
 QiPQ==
X-Gm-Message-State: APuU4Z9QjkKJe73vz4U1j2B7r5TkUFkr2fbBtl4Z1tgO3JdLG7Ig4dF2
 OIj1/n1pgUkE3tSwFHDVl2eBNlAxYjvJ6JFUzhxPsmz9ZsG/O+bdsNsoiUEcJBlEMIAiIOhSNUa
 uM1JgBnEErTInIdTn51K8Gdiu9aUOi1g+wFV0o+QQkH7worufNZhEZX5QudzpCe6kYS7TWXk=
X-Gm-Gg: AZFdTZdL6g9ONnBfwr90bJAfuqaJresCDwLtbr0LX45McWChEfk/jFFId42t0kuj+Ay
 Ush0aeXmrvdrG61FLB+PJYCSjNocSG5yzX/7pig0Ekat4Fzbz7pRDTM/9B8QkJ9V5415gIxzM3B
 p8m3goKl7jIVfI3qiI/4sBY5mpoj463LL3lHDXBrAN25jgWOD49hIjUeleTFQCirfGWZmL9dL/x
 hJEclFOT5t4zVh8r16jN7S4clLN7S5b9tPfysaA0Pm8+v5L8Ea/489FKGtX+JrKqBFgDvtu8dXN
 b+E5o+11o7+z0oFF0Kq1FzXUWnWLDRZxq5tM0LjlbudLh3kDZDAYRllHJVtMA2WQXBjt02IzF+a
 Zn2DUg9fJkXhGd3OuZ5I/k+ZwsPSXyxuHWubzwzXuqGErVC6b0zcFxNO7YAlRKDyDnmUeBhADKY
 XZeOXTTVALBVkZTPkyvOiagru/2hIXfjdpqQreERd/66DlpVtiSKLxegN3YLgbtvj2ZaqGynbcR
 d49/w==
X-Received: by 2002:a05:7300:72cc:b0:372:598d:c0bb with SMTP id
 5a478bee46e88-37966e3ad18mr16139744eec.13.1794829165275; 
 Mon, 16 Nov 2026 03:39:25 -0800 (PST)
X-Received: by 2002:a05:7300:72cc:b0:372:598d:c0bb with SMTP id
 5a478bee46e88-37966e3ad18mr16139682eec.13.1794829164566; 
 Mon, 16 Nov 2026 03:39:24 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795533170csm34412685eec.7.2026.11.16.03.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:39:24 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 17:09:12 +0530
Subject: [PATCH 2/2] configs: qcom: enable PCA953X GPIO expander driver on
 Lemans and Monaco
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-pca953x-tca9538-v1-2-1cc09ccffcf7@oss.qualcomm.com>
References: <20261116-pca953x-tca9538-v1-0-1cc09ccffcf7@oss.qualcomm.com>
In-Reply-To: <20261116-pca953x-tca9538-v1-0-1cc09ccffcf7@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Francois Berder <fberder@outlook.fr>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794829153; l=1094;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=/3rwpi7LqTrCwi11lhoU+whaPI5tiznRMdQhh4VjTa0=;
 b=jwdc+Isqa31UEZRUV4oZ4Pfih5G/qesmXe26MIuGzsL2xvNOBNdQrzf3c2EoTwqMMEcUcdhsd
 3MZ9k6xJLvCCCyTPH6OMoOKTurq0njANI7e2zAWX3JvotU0Onlzx9U9
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0NiBTYWx0ZWRfX291KJeZHg0YP
 GEPSJ+suQTl4kNir6FapyyxzHXylPc6QMB9gwjr5tZr/Lcz/enk+FXNJ9MI3R1SHvB9xP+n3fD+
 h+1Bm0YGQJgCz4zE0wBOQWXQwxxI9MI=
X-Proofpoint-GUID: SmM_6Pc09ZtOE6OWX1-IYD9my3VDUZNj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0NiBTYWx0ZWRfX0nbapu64ckW+
 1H03RF2eNDD/8s9nTcrskd7sCeGrCvCoSOL3CKfZvxOKV6xX+BuKDCA7ov3cQscQgQ0QsnWOb/1
 +kCFOq5eNuXs4znqrifHRV/RC5dAcV3QaZoQfQDxWHJ8axgc/JY4MtxC79rrIqcvtLtPeXy8Smv
 MxGxypPlL+DAtc+scLrTwRTqg5T/DlI2Vp00aoZZ6yrKvqoe3AlL3CKNXnQP+IDhoK3UeL8xmU+
 XqXfVIHCw2Wl4Z0KHWCxnX9aRChM4HJOCbMMnDzBOt0iaLPl972xXJPZHDSTQZVT20562i2KSVV
 XgzpEKEAF8Tq0B7OK54QDkeYVyKIa+jD/5kCRBbl3FXSuKTlRUhKRrVwUb4D++NxcK8J58naelb
 PzG7ifu+4HxcMoPlkSSKvNjbTNMZybPd81TB0KxUDyzxFoV2OD1XQtV5E/PknyQOA6ZLh3Go7x1
 Dtc/y5GRsiaJPUCgieA==
X-Proofpoint-ORIG-GUID: SmM_6Pc09ZtOE6OWX1-IYD9my3VDUZNj
X-Authority-Analysis: v=2.4 cv=ePeGH3p1 c=1 sm=1 tr=0 ts=6afaeb6e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=kRR7Y3xhV-IEUTWTJJIA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160046
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

The Lemans and Monaco EVK device trees describe several TCA9538
GPIO expanders on the I2C buses. So, enable the driver in
qcom_lemans_defconfig.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 configs/qcom_lemans_defconfig | 1 +
 configs/qcom_monaco_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/qcom_lemans_defconfig b/configs/qcom_lemans_defconfig
index 422b3e98b1d..5e848c67028 100644
--- a/configs/qcom_lemans_defconfig
+++ b/configs/qcom_lemans_defconfig
@@ -17,3 +17,4 @@ CONFIG_ENV_SCSI_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
 # CONFIG_ENV_IS_NOWHERE is not set
 
 CONFIG_WATCHDOG_AUTOSTART=y
+CONFIG_DM_PCA953X=y
diff --git a/configs/qcom_monaco_defconfig b/configs/qcom_monaco_defconfig
index 80d70ca2858..f42ceb8876d 100644
--- a/configs/qcom_monaco_defconfig
+++ b/configs/qcom_monaco_defconfig
@@ -21,3 +21,4 @@ CONFIG_QCOM_GENERATE_MBN=y
 CONFIG_DEFAULT_DEVICE_TREE="qcom/monaco-evk"
 CONFIG_PINCTRL_QCOM_QCS8300=y
 CONFIG_INTERCONNECT_QCOM_QCS8300=y
+CONFIG_DM_PCA953X=y

-- 
2.34.1

