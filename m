Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB36F606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 05:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CxjaeiW4;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Aj3i4xgc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ajyPEATf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 777A660735;
	Wed, 18 Nov 2026 05:00:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rx5bqTgK9Ga7; Wed, 18 Nov 2026 05:00:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 65AED60743
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794978024;
	b=QGlpfffehNuxvxP+OJEUmXoXOWS1aTe1OLi0ASWzHkW05vo67dBtKkMZ2NR1CebLrtWP
	 ZjmYrKZh5PdJ1LC7f5vRt4VUKZMA3qGKbpnOHz8K3XTUCtzx+5Md82lXGl7gM6td1RN0+
	 9zuQlv3G61tKp8YwzLen61ua5R7zpHvLzQdY7zMoBvw5sK7MDoxuMR27KetNMgkGuBdSu
	 XacQPHY/MBDZhVexrwXs4kJ4a94Mizh9qktA/6XC7glGoK2YwxQ5lj0xrn3dpo9z3OYZC
	 xHIL5IPTzbv0yQ9SjoiXcuIuCXZRmNuAEkpI2TIVSgyQr5BGgcUJOTE+p1qDFOLT96A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794978024;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rEUEeZmHKDmpRlTF+g5jrH3q2cVEaGGxwIZ09i3gH8Q=;
	b=YIyolJGo2gUu2hWRV+9IDlgnHwvtj98RZGJNj6hVGkqxjkYLWiayvpmvrFFxHmKIInN9
	 DmOIcT7J50TeJtIOcvtEA3v3nNc3Mnw+LIScYs2nMuGT9QsW/krt1VmsrTmazZpqhufHJ
	 bcS8F3HVVO50mIIrU3/8Q6/hIyiwQyuYS0sldTAwOxgzM2wu6yykK6GBpxqOIjbXL3Iws
	 DaVZpnUihSW0kJOze/3t05pF6sQCn0C156JscAiJDrdsDdCZJ7zBnnDJ29EiiCWdn0AH1
	 emqpy3OQvgCubxhVBXW7/OOSf49LzR7R+TSb4YUcXMK0pncpWu8YpU05DSO6uyuECqw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794978024;
	bh=rEUEeZmHKDmpRlTF+g5jrH3q2cVEaGGxwIZ09i3gH8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CxjaeiW4g65s24A5FYAyAzpeiXAutAwgfeMQAZmXMLxnwSN3myF+jIUYwVe/+YBfs
	 XX18XBVVKcEL1yRDpuHA0bOvTbQMEf7nUcXuwPV/fQ19oiyokY2G+CzIl7bwBFjZQJ
	 tmzoboY0WPT5V3kShoZwPPhJu7Z0f6q3UFOPBW03CvBUZwBt0ZvgawJB/TPHhHM6Nf
	 uZNs55HFk/eLYBdZwfw3Y2aCQhdhvxnkkSftQa7mOhlQbIPXhVQhKpA7qqEkZMPl/d
	 jjHilbC4fmGQWN4ixL6RGlF+iop/he8wQ0tIWchhmfLSjv+4YLmZmPmr8ZiX2Rf4Le
	 3JUhhxMvixC7A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65AED60743;
	Wed, 18 Nov 2026 05:00:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 42E4FA32
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 28B15407E5
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:00:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T_Z97rbDkjGx for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 05:00:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3649740662
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Aj3i4xgc; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ajyPEATf
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3649740662
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:00:20 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AI2Uo7V3371272
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=rEUEeZmHKDmpRlTF+g5jrH3q
 2cVEaGGxwIZ09i3gH8Q=; b=Aj3i4xgcBN9NrnYEX8HYs7rE90VIZqURKgRtxJVt
 d2I38v8j/RuiF6Btc6Z7C/5yufpEm8c1p1ChEjKgXfICEfdFKr7h332v6+/4O8MC
 pNTnPgbpxDaOTMBAe6duhDpyd/F9vuqz1NUfVMYbp6gct8KowdBpp0UuGy1M8BtQ
 S8N0IgQVYv8XBrMUOuWUe2DaVGEdsckDcibRpCnZWqzjueqCHw+PRencgfoiPo+N
 HIMe6FQpVUM0gfo/75ieY31Zgv/RBYnYnidcxC+meEGXJMB07NcAeWvA/FtiB+HD
 GiMpGP2CUoi9TsJf049WGSxJt6tgSdx3H3W4paxk1vUf7Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv8s8sa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:00:20 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36fa5673fccso1758079eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 21:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794978019; x=1795582819;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rEUEeZmHKDmpRlTF+g5jrH3q2cVEaGGxwIZ09i3gH8Q=;
 b=ajyPEATfYmud0ijpKt6ySsSTQc0UC9a8qj1+e+leZ7q+Z8D3qbIF/+YQtSsNBJlnno
 Dhj29jzqpc6XKGfrlKTkYJHeb9gik+vujb+eDeCBnPuU0eBvxWodp8Aks5n9pk1bDFhA
 6D6sEzoB9aIueSNaTNkixBwKp702jMceBkCSrym4cC6metTU6rBs62sCG12sPUM61IZY
 BWoizzLCnGocA/XGDAm3hUJF/G7t91syfEREJ4G8vJzwLtuF0dVcEjI92aruj0rIMT7/
 rQ5TURDjxnLyJV4gOmIJUkWJiXmNFq2wGWGvq3T8T5kUG/2z4Qhc4XPHWqrbqEAQe19j
 2zIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794978019; x=1795582819;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rEUEeZmHKDmpRlTF+g5jrH3q2cVEaGGxwIZ09i3gH8Q=;
 b=QumM2Y4hLFaxsz6T6GGS1bhoS0YNMgfC3y975vOVnt7En7Gs2rc+Ulh5+lwmZsZnQw
 Bd1M22srJOfGQS8wtVzYvnZMTnZdcXFQ7yXtOaHQ7rHvnkvs0s7beOG5LVq67d/jvbJh
 +zPXeTzmxpUsqmOSpTyBnF3bmPcB2BsBsEKgkhytFG53TY+oT0YT9HlnGGuBe4Dk7dQ6
 LTnxtWjNbmHYXiaqX5aKotX8wN4+rNzxCHDHrIXfrhjzcmj+Vv4mMx/xs7fkA7wrCM/v
 43m35lGmIFiF597O9b1wj+RZfPeD1Vr5tK2HkkZOpDXfzXGvVPQv3TDW/nxhymSfsmrG
 JAHQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEyrlbWGuopJIVedG1fs3QeEFSQsyKdV/Iti99hrTOWqCz351v2HzBKvxk7v/iXbsN9twF1cOA=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/MBVMzOLySbzr84HoHxe5JpwfBGjMx9DITgcgfUGVNZolhLd+f
 lXxJoY1XROJhv9oWZ6UBPthp9lAqECEduOFFYgiFp3tAkPezx0G3TSRjC58/NfnEPwNfLXeWhr6
 uYc/qBLUbiX3Kd2XTEZn0gJLM1DHFCGHaiwdDwzn6ENqIZx7prgt2mCq60K9NF7nT9tsjcxY=
X-Gm-Gg: AZFdTZeHyA7FhToo/yTOClyH2FBcDOP9ZDg6VBk3vSWH2BW4+dCeH60WmnmqOItECPX
 7DxHoFsQxgfHsAY9wktZERx3hEtyz1lAna+W7FCH73o5J/I/uTj7fCHU23beR9UW49ttG5vYaeS
 7tTQkho9+X+sIj7N2nPX+VJAYSCDSoHiUzYrlvG2ztJJL8kzs0QcohFBFBAyrRQLT8PeBB3h9uY
 9aM1NgSQJcGGgOaTlRUwp4W5s2NDS/8n2IpWMe68DsBJjfBOqC6c7o2oQX27RunYoznmGxvFRr+
 Lanb3Bs4BEYKu6d/S2UbErPubmrnoji2i4ZHZefAjJDtkjYdhCFfKJ6Vgxqf9vIWLgwo5B/OdUu
 XAraWmeAXoEC5CX06Ixz5/j8ys41qY3U666JonRyOm+rIIhskusnxb8zdIMODnW2Kv/jHXzZ7gW
 x4RpcLeDHrmMCslOFQg1wrZD8+g70duJMVdXST8BMq/27o2JZW4ataOXj8gMu/2exomwWVjao5m
 leD+A==
X-Received: by 2002:a05:693c:821b:b0:376:a6d7:8f6f with SMTP id
 5a478bee46e88-38280c34ba5mr1665557eec.17.1794978019153; 
 Tue, 17 Nov 2026 21:00:19 -0800 (PST)
X-Received: by 2002:a05:693c:821b:b0:376:a6d7:8f6f with SMTP id
 5a478bee46e88-38280c34ba5mr1665525eec.17.1794978018492; 
 Tue, 17 Nov 2026 21:00:18 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a6fe733dsm2940187eec.16.2026.11.17.21.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 21:00:17 -0800 (PST)
Date: Wed, 18 Nov 2026 10:30:12 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/4] tools: qcom: mkmbn: Updates to support ipq5210
Message-ID: <av0w3LWTq1kgxMiY@hu-varada-blr.qualcomm.com>
References: <20261106-ipq5210-v4-0-5af12cc2b601@oss.qualcomm.com>
 <a2b6bc3d-db58-4882-9964-ae0a1fb218e1@linaro.org>
 <20261112163645.GE554944@bill-the-cat>
 <67e7e8ba-172e-4d89-b5ec-0c1c936f6c75@linaro.org>
 <20261113184005.GO554944@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113184005.GO554944@bill-the-cat>
X-Authority-Analysis: v=2.4 cv=Eu1HPicA c=1 sm=1 tr=0 ts=6afd30e4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=as6OuKTCiBMJsXINuYkA:9
 a=CjuIK1q_8ugA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 3cVpWiFEiPJVLZzn_K9nknvCDWh_AbD_
X-Proofpoint-ORIG-GUID: 3cVpWiFEiPJVLZzn_K9nknvCDWh_AbD_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAxOSBTYWx0ZWRfX1yRHIwqUW6Hk
 w62FeCT20HCRKRDK2mHgcwPkOfsrWf8xCHd7gcc9Tmg7Nq+5mXFV/RPJveXs0zf+GxILC75vMCT
 Z4rm/xD0ragqLAX15dT6PtlnC/G+JcjqB8XuFMvJbV03+JPvOXdLUwgi4U8MJy8SFNVvAsoTlsI
 kjaRUHU+nshf7HMxb0hrsg57zqrGU4efZSeYa2NZzoJO08S1ddQA/5d2Dju5PPfBb529Vc9MruO
 Tz5OfNYPvj4dxTh8cRHGqkiOaPvK86fJwb4Z3UX0nUwA0jEBQ2728DCdY4JobSH3nkR5UymJ0V8
 IncEWewb/2EpwpoBJLbbR3mF+eMNVj7on4G6hA92xbbm2oVbHd972tIe9EAaP2x8xm9pqAUxpmW
 pm0jssbc+Fe3LNZZV3IudszlScOXYCa13fnL889/d7Aus+3KMmbUjrRAC/lpMbP7sdEVYI+qg9N
 w7miS5a1eF6zXTrlm6A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAxOSBTYWx0ZWRfXytVoI9+IDugD
 DXNFtXgZzzplCWCPyt//huUb1b7g8aJQd+ER3sEIZ1BDWOkIcTfQApuepZUv9nf2WM47gLJvSON
 rM4/dkyNT3VfYIbrVEguLHDbawoQ7l0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180019
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 13, 2026 at 12:40:05PM -0600, Tom Rini wrote:
> On Fri, Nov 13, 2026 at 07:18:41PM +0100, Casey Connolly wrote:
> >
> >
> > On 11/12/26 17:36, Tom Rini wrote:
> > > On Thu, Nov 12, 2026 at 05:21:36PM +0100, Casey Connolly wrote:
> > > >
> > > >
> > > > On 06/11/2026 07:07, Varadarajan Narayanan wrote:
> > > > > As part of adding Qualcomm ipq5210 SoC U-Boot SPL & U-Boot proper support,
> > > > > the mkmbn script has to be upgraded to create images that can be used
> > > > > in the ipq5210 SoC.
> > > > >
> > > > > These changes are to address the feedback in the 'Qualcomm IPQ5210 SoC
> > > > > bringup' series [1] to use mkbn.
> > > > >
> > > > > 1 - https://lore.kernel.org/u-boot/78ff6a8d-5c63-4bc2-bf1e-6b71b8f9c6cf@linaro.org/
> > > > >
> > > > > While at it, fix the MBN version number for ipq5424.
> > > > >
> > > > > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > > > >
> > > > > ---
> > > > > Changes in v4:
> > > > > - Drop sm8550 full defconfig and instead add a config fragment in board/qualcomm/sm8550.config
> > > >
> > > > why this change? let's keep it consistent. please resend the defconfig
> > > > patch standalone, i'll pick the others here.
> > >
> > > I asked for moving some of these to fragments because that's how tegra
> > > handles the case of N platforms that are defconfig + switching default
> > > dtb (and more or less nothing else). It's just a tiny bit more typing
> > > for humans to do the build and easily supported in
> > > OE/buildroot/deb/rpm/etc.
> >
> > ahh i see, i think i missed that - apologies.
> >
> > i've thought about it a fair bit and I don't think I'm fully on board with
> > the concept of having board support via fragments. to me they represent
> > optional additional functionality, and there should be a strict 1 to many
> > mapping from defconfig to board support, with fragments providing
> > opinionated or usecase specific features.
> >
> > If the main issue is the world build CI, would it be ok to allow excluding
> > defconfigs if they're trivial #include's?
> >
> > There was discussion before about de-duping some of the ipq qcom defconfigs,
> > and this is work I'd very much still like to see.
>
> It's a hard balance to achieve. I was just now thinking, can we perhaps
> figure out some way to take 1 U-Boot binary and a list of dtb files, and
> make N u-boot-plus-dtb outputs? Or would that not quite solve it since
> there's more than just changing the included dtb?

Not sure if I competent enough to answer this question. As I understand,
most of the times CONFIG_TEXT_BASE also changes (atleast in Qualcomm's
case). So, the single U-Boot binary may not work out.

	$ grep CONFIG_TEXT_BASE configs/qcom*config board/qualcomm/*.config
	configs/qcom_dragonboard410c_defconfig:CONFIG_TEXT_BASE=0x8f600000
	configs/qcom_dragonboard820c_defconfig:CONFIG_TEXT_BASE=0x80080000
	configs/qcom_ipq5424_mmc_defconfig:CONFIG_TEXT_BASE=0x8a380000
	configs/qcom_ipq9574_mmc_defconfig:CONFIG_TEXT_BASE=0x4A240000
	configs/qcom_qcs615_defconfig:CONFIG_TEXT_BASE=0x9fc00000
	configs/qcom_qcs8300_defconfig:CONFIG_TEXT_BASE=0xaf000000
	configs/qcom_qcs9100_defconfig:CONFIG_TEXT_BASE=0xaf000000
	configs/qcom_sdm845_spl_defconfig:CONFIG_TEXT_BASE=0x14880000
	configs/qcom_sm8650_defconfig:CONFIG_TEXT_BASE=0xa7000000
	board/qualcomm/google-pixel.config:CONFIG_TEXT_BASE=0x80080000
	board/qualcomm/sm8550.config:CONFIG_TEXT_BASE=0xa7000000

Casey/Tom,

Please let me know if board/qualcomm/sm8550.config is ok for this series to
be picked up or should I revert back to full defconfig for sm8550 and post
a new version.

Thanks
Varada
