Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8757E606A323
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CO4gzUvz;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YbJCfxK/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gb4zpBUH
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 193E780F8B;
	Tue, 24 Nov 2026 16:30:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id waJOiAIcxEQb; Tue, 24 Nov 2026 16:30:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7DA3F80C64
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795537808;
	b=HL+1DD4baH99PtPpfH/QL9dmYYZZNHtlbZoGxPONQZDjGofLvmCxqVBFJ9PWevfk+7JO
	 UknEFibBtWwaLUTCSLoJfWtfpKtl74C1UnG7Toua98u1QG24Pz7gFfFh1u37Nhke1wsVb
	 mU0pmH7/QS8WL9sKgrBGQiezVuHEuD38ueRrE1SsxzBBdL8SBIeBIw7qEypb6vrI4O5ws
	 XD/yIG5jm1glQRQNSAWtxzq4zbV4R+XLAVZc+vtOmb1eVswX76UXyaVIf3CJMmq69Q88s
	 3nDQDnymlvHvbTwcytlZv2QoKNLoobE7n6PY3tK6QfUSR1IwQOAMqfbYR5VlhWA0IFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795537808;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=K/F5eZ+jXPcqpVzl7+fFAD0WQvsQmsDesEp+EKSHnxw=;
	b=POH4VCQ/CXSyZlEOTgCP/wSoxfgIzkaMoLah2KVyviPhugo7MZYbBjbhTwCPZIZ5GOeU
	 Py/rVHMPO6/oGDW7aUS1mw/OQRJuGl8IhSmXNNarMgu/XQgRF44c4uzZuxPlh5GQgF8Vq
	 LoJCOv37bD+gjqSov6Cqer8AVGkK6jYaUvtYUofYGW6N8IUJ3IAHu9cECiD0ygQ8EOkog
	 WbS+0oRLHTSgHYzl/VXaGSdltfF+X1MNM/Cnqr619xO8O5l26ZfMCDWX/BwBz5Rskxs2Y
	 C/HumWPF/KnQJzt8JPTa0bxcWcZFJEFSCjIno6FizUaoIbNZvlmrDayag6poLG50q7w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="YbJCfxK/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gb4zpBUH;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795537808;
	bh=K/F5eZ+jXPcqpVzl7+fFAD0WQvsQmsDesEp+EKSHnxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CO4gzUvzJabjTcGRGAvPAko06NaIV6jgrCR0tRTFopJjBFBkpv872N+yDEvIVLmrd
	 WU46EjjoexGUGGsRlujUR09gPOzdZOVWT3mnxHcVMEkVdnhuFECMsuCcvKhqorNuee
	 j5MRsdbHc4l7P5krK8NXg/iY2SuhTMQHuqaRM2+cHWhVBLfT9z5JfSz9bQi85VXjp2
	 sJYQYr6MxamwFXLK8qnvdpKJzKNMT/N8c1Xihq6Im7Rujj7UleyvzWSfDspMvwHmNm
	 XWxLH/RQ7/2Bp1GAJW+C09Gi3U3q/34arrAKIWGN1M47+Bafz+SaopL6umywT3+txg
	 UHpQzGLOVHkLQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7DA3F80C64;
	Tue, 24 Nov 2026 16:30:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3AD183C4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 062E980F66
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b1kpoMW5V7dU for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 16:30:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 74F7D80CEE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=YbJCfxK/; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gb4zpBUH
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 74F7D80CEE
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:02 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFL2i51183783
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K/F5eZ+jXPcqpVzl7+fFAD0WQvsQmsDesEp+EKSHnxw=; b=YbJCfxK/YW2Va0Nl
 0MlE7RgqAH4Y4RVuk8op7fDX+mri5mG5Tp/LMNXVajowfXTWwSpdpFOivfxYIlgO
 /nP6n+hSb92lBenM3TGrk7ZVLEptgKfxPNLqY8F/VqfToOVe6+uoxmBrMkKyr3gu
 3f12OiajI/Kd9Ob/p3lfAWpNv6E7/4JO0pBbF8gcxRa+x7L0DWAR+g94xLZTqow2
 zwerTt3jlLuKwDJzZcjZi+0nNog18240E8fyKpLRXPaH8KsorMmKSJRAXVQ8jlFI
 0crlfJDCT61jmH+BWzqD0NjrvL4ORdMjxtgg4yBrOd0XIy/YiI/ZUdXfa8odT1c1
 bViSRg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j50ky3nyf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:02 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9997828d6c2so711152241.2
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795537801; x=1796142601;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K/F5eZ+jXPcqpVzl7+fFAD0WQvsQmsDesEp+EKSHnxw=;
 b=gb4zpBUHmZVXC9HRo9BExwbA6eT/+yS9I9EZ+6l4Umxu+IOFy5qSt6xE+2UybbnIsl
 FG/+bnBNl0faphLzTuwvxUm8UB0uypl4V1ZPP3FlHfjirMQVTxdO6cNoHyMlzJzDmOob
 Iuj/Wls9LzVpTxRdJm5U/UiqSN+/e7cHf+5PdhUenH1XwWXtFfVbRiu2QdTzA3JQkqH7
 ynm37QQUK1BbMU9xMciNTKuCuVeVtJYMayjU2aVV283vvsLXLSACjqhnPdF0cCcRLF09
 aSD45Lf2tFQNf26AExOqJJtPJo2gf5jXf4e5D8VEEAs7FssIIIUnYvi+wgaNoePo05cZ
 hReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795537801; x=1796142601;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K/F5eZ+jXPcqpVzl7+fFAD0WQvsQmsDesEp+EKSHnxw=;
 b=gUDkXVh9ajC647Md+/0iWWCb0epZ2+A+/Mj8QL03WUGRBLSoz84IEGdbdsUX8Di/6N
 6ACbQzA8NgHX19MNnhYnlktJK9ViY/16YxoSGKR1bzTOeO84+nBnNmfsF5Vc6sRmUXXx
 BIOs0VUpqF4UWS3md2cf2VboV/MZtXv4sVw5z5FCh055B68tA88SqH2VGtblnAwrQo3x
 Sw9fk5CGYiJ6K6rNrrWW8MWhDbStSPH76DYudiC3TB1KR9lGohSdTOAnRZUznSk/+GYy
 v+PRAnQSPjXK3ikNFy6k4LyeY1IGKDmiQUFwNXqZ9lyS1v7HY9wBAbMOXeFDSo+LppRH
 kK9Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEMo14m+pwSBta/UM5QO+WU/bWknzyZAw3y/x7zP+owgNobv+9NfX6C4yo4IvVOOS65w/4V5IY=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/OnjCpwsWI1v2XFGlc3XXKKc7ZwTB3h9lNi3t3fLSOYOZKSG7y
 M9zRfWwyElXzxkc2R6YnD2ceV4DmlnSQjJwS4vCFWEAd7i5q2UHH25+ZfIkBm+9aCvcr98LJF8N
 fPuCaK5wFQEbqn7Nt6ZHxiZhIgnLEH9+tX6cuEXjOWH+j7MlnmsB8eGtWjv2GM/ZLzwHfMbY=
X-Gm-Gg: AZFdTZdAOgmAXHQAeE5uAKdh7LVnbvcCPlxKifWSVothwaslnDnPLgagzg1c9iAucua
 IWDYfTYKUOrOqnlxIAmm5OttvCDym2SrMtZz51fsXu9QPR88PxcSeBhWAfc+tbTlt7i/5sXZiA0
 NYu4Ny3Eh6iIVuzTQCYeSs/aJrN2Z4DgOuvo3RESuBMrD5BkebWRVEoQ+WvqGWhGqpTpZ4ZfLqF
 B0oGmqHbUqi88Wmxrm8ax9LNRaE7KURzre5xdN8Y/77/lI91iMP+1ZKFbv2PkrXTWENcnA8ThbY
 kuBQKvhx23SHPd38RwEcYgLjoYM3kN5So5A9QcS9rHG1EbwygwnUGYy5iGDpvtaW0EYpfwC1dLK
 0j8C+MEL4LLjumi8Cnl01FUEHtV9lTNYHU+S1xqBwTdIN8MMRIM1qPybUvbYNy+BI0HOYJUwWHY
 Ui1a6B1fIBBKcZ
X-Received: by 2002:a05:6122:3d11:b0:5c9:a60b:e5d6 with SMTP id
 71dfb90a1353d-5ee8af30e79mr8193859e0c.16.1795537800977; 
 Tue, 24 Nov 2026 08:30:00 -0800 (PST)
X-Received: by 2002:a05:6122:3d11:b0:5c9:a60b:e5d6 with SMTP id
 71dfb90a1353d-5ee8af30e79mr8193766e0c.16.1795537800366; 
 Tue, 24 Nov 2026 08:30:00 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370fbf0esm7058223a12.23.2026.11.24.08.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:29:59 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 17:25:01 +0100
Subject: [PATCH v2 4/7] test: py: android: replace a disk image in one step
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-upstream-avb_tests_b4-v2-4-ed7136c3767c@oss.qualcomm.com>
References: <20261124-upstream-avb_tests_b4-v2-0-ed7136c3767c@oss.qualcomm.com>
In-Reply-To: <20261124-upstream-avb_tests_b4-v2-0-ed7136c3767c@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Y+ptIReN c=1 sm=1 tr=0 ts=6b05bb8a cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=HApEYhZYatcvUlySpNIA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: mMRWnk0L5MjZ_rsc6xDM_0yhS68NXpK0
X-Proofpoint-ORIG-GUID: mMRWnk0L5MjZ_rsc6xDM_0yhS68NXpK0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2NCBTYWx0ZWRfXzNMJAobzOF+5
 Ia3qID6IHxhGC55XJiH684NPa6ORctqs2gDxUgrLtqBHJczxw655dwYjUmrh+CcJSHRAQGXnpPu
 beDrI5dzLoaHFrFBnYxuk3oxogBAv1w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2NCBTYWx0ZWRfX5tlpIrQwuYZ8
 I+m3ajUYrxdcGf45FfMR4TjYO3e+w/mjOdk7xjLR+9BUSzOg9Iwkd/hNb8iwQGKMyABk+PBrIBm
 r5R66F+N06/HWJQNmcljQVYD6NB3W0o3Mt5XLEf6FeRZDnFYWrVvlcq8zix5t9xsJ4w/Gb70uVk
 NnuVeMajq+AX5vZsWBP8f0mtEauZDyK1++op2gnsisTZqP3bNHGSNw1sixf1/QJlzhuCjLvYGac
 GcriqIYyE1i8co0po6VtA06e+nWnODa0FBK+DlNU6yfVuUegvEissWx5DncQXg96zF3VwpV05gS
 UHYWKVMMwj+zficKrmn44NjCkGctRc6q7EyvSqd3ZIc0bzkoifg01kwWoel3tgeCCbYZRh/xChP
 BmSap1oMuuVYlsdgvbKAnJpazfA1T04s31jIJYDwXrTCpC5/eHajn+KyzPlcOhCub1xLNvRFI3P
 vj9HaamkoCEhtgzykCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240064
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

create_gpt_image() writes the image in place, so a test that uses it
while another test recreates it can read a half-written image. With
parallel workers, the AVB tests then fail with "Magic is incorrect"
when test_ut_dm_init_bootstd rewrites mmc12.img under them.

Build the image under a temporary name and rename it at the end.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 test/py/tests/test_android/android_image.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/test/py/tests/test_android/android_image.py b/test/py/tests/test_android/android_image.py
index dbfba8a403b..1ea2d4c81f4 100644
--- a/test/py/tests/test_android/android_image.py
+++ b/test/py/tests/test_android/android_image.py
@@ -25,7 +25,11 @@ def create_gpt_image(ubman, mmc_dev, required_parts, images):
     """
     Partition = collections.namedtuple('part', 'start,size,name')
     parts = {}
-    fname = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
+    # Build the image under another name and rename it at the end, so that
+    # a test using the image never sees it half written
+    dest = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
+    fname = os.path.join(ubman.config.source_dir,
+                         f'mmc{mmc_dev}-{os.getpid()}.tmp.img')
     utils.run_and_log(ubman, f'qemu-img create {fname} 20M')
     utils.run_and_log(ubman, f'cgpt create {fname}')
 
@@ -67,6 +71,7 @@ def create_gpt_image(ubman, mmc_dev, required_parts, images):
 
     with open(fname, 'wb') as outf:
         outf.write(disk_data)
+    os.replace(fname, dest)
 
 def setup_android_v4_image(ubman):
     """Create mmc7.img: boot image v4 with vendor_boot partitions."""

-- 
2.53.0

