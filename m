Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F733606A322
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 05:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Do12dwYZ;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E63rQLJS;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ghA2vRDw
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A37F605F7;
	Tue, 24 Nov 2026 05:58:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XFHyB2HV7PD9; Tue, 24 Nov 2026 05:58:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6D2E0607DA
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795499933;
	b=jK8nUkBS3lyq5i/V7WEPAiGacedf/B0EP+ixVm97YRCszxFE5xnsSMHI3HTqodXmUCPb
	 Z0KQD/rWBgkPcYkmhLJ5WS+LJwf4r/vAxquhy+iwjiDiGwqjprOLbUaScW5TPyIw9ucr8
	 TUCCLUX90+1t772wAFwW4kLOnuq+eDL/4KyHBNd13qOkMKNX1iBW7e/V9RRNqZCs4kCNa
	 nppiGS+7KjQC06fzrHQNzl2CBT16JrkY4OxQ+bMIBoCd5xPH/4IVgsESajKVJb9WkFXNl
	 34/ZxVTElCTErlPZ866MgHtOFLDf49M/KNzR3Gn0Md+7ulZUfD1oQoPQ63PKlsdnRzw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795499933;
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
	bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
	b=ApaSbnqLgpAJZBD+Or7v40U2qP9KY2KcU3arKU4sPPSXg9l8RJliQsNx5B2b0ol60HuW
	 cCOHsRNPxYsyvfY2zioFsLssqHQypq4vWAsSUmIooi/Rsz8Z34ycxH4pMOXFTdfcUNMXR
	 0Wz9RgTe9BsN14vI9Anc9x9cGtIzLSYlXz57ne4bpC2K6UQQcENeoDaS74fG8QPLqwGWh
	 fQApvoAoIJ7st7d/5HB6nyV0ftNcxT9ZoAfKD1LCELBUQdJHC/E+x/bpdzJMBIzZB+4Od
	 awSYTBjsT7wnAGkQ/XVeoAJ8rLB/6CxiOoo/4VfMavJN1dnna/NHVKgPJlqvsGGj1lw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795499933;
	bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Do12dwYZ1i/luTYYaERVzUhhHvzCHc3ed1gXO2FVL0mlu9v7KCm9opPExBk4HOHdl
	 Qui7KXyuY4t1JWS5eF07yOjLSZ+8YTo6C/HDJx0ZImqSMq7YpmSHFAcugEBlQXtY6Z
	 grKUVjdAuc8pGonq3wQ/k4edKvzP1PtLUW3OxNDUQjy0LY28eiXBX97Qv6I6cNhUch
	 8ljrzF4Vh2UpLQ40CrZLSjyJLYbGj7H5955c7SDBRX1sQ3U2Xst4tVT/NTUgVBOTgx
	 fC9J8tVOVbSbDDsxLuM/Cy+gzJVTqSLMiYvR0EXa0S3LP5uJpBccjV/TOgpweZkAx3
	 vzz+iqGaTJOwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D2E0607DA;
	Tue, 24 Nov 2026 05:58:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 672A922B
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 58BA6400AB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0DcU6CxdTP7D for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 05:58:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org F385A40068
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
 header.b=E63rQLJS; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ghA2vRDw
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F385A40068
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:50 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO2k3vq3701186
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=; b=E63rQLJSiahyrlEi
 nW7lNIHSp19liKRAXiqo5SICytyMwiIFx3AxgmYGrZAykFyfvrBvQ6HMVu52Xd3G
 yOwoLF2P0t1SxpTQfbNww5w3vVKZvYht7+IujPVxxe5rOjj49j+6nI68eLxWEs56
 /MHLTWCALR52XKAicUDjqJmVyHEudrE9AfMUmq6xFRcNI/H1+e27czClrr/n+v6v
 6ofruKMRwW7yu9xqf7AMD6o1sbSyiwrZR2N6gV9GdNSbR7COs5MPwuSzreM3LRZ8
 JxIvkwQlegbCH+kUO1TFCryFA/kEwl/OlmrpWzwBqcbPYwlL6ZcYLwNpZDYvMzud
 oxKggQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j50ky0xsf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 05:58:49 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3869accaac2so2337652eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 21:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795499929; x=1796104729;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
 b=ghA2vRDw07TXMzuw2d46VkViwGQwJaz9lZyi1+6Oe/L/+wjpYQ8niPwqJuYpJfzPCs
 LSCDuAW7yty0D0aGwIkyX5IXX9zg/znHWUCdfJTUM2JoWA1DzbKB6oYlYxoT1DY4P51H
 6Q1mYJr6PYLKME42LBelFMWTvegGkFFjtu07Pbb37jU90WDsXpxeRR98PLxiWZ7spxwT
 1W6SU3bnjDZ+RA+owhI1VVQcYOIlCpJtlDpQOZ9+l77hVSU0FLDeDvh7dXWUS2dnXYWk
 NSzjfhRXYDzYvbgw+j85OrqXzM6dthEQwjtCH7xJrKVp1LWAxuhqQl1NXizIvoC7br1e
 qo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795499929; x=1796104729;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uHuPpXbWUarYKkHmWMWYXThH2ErRJoj3FkMrz5Xow64=;
 b=dsxxXP5Vs8is9ZqRR7URAPxP2Xwp6eZHvQ75tFJNzihQcXIMZO6mxvx8MjdxbKsVwW
 pKOorsPXRLewIV98pwXn1RDFOdxYWDxAXH/gH/W5lGugSuHoQg+BsF0gF2QAcL3xmgoY
 8GicMY51s0GplhKZQSFSFDujA7+stp2K9mKhRUavwZj9tPEqmh9oIRRpc9uOrzfLIbRC
 9NOTepRj3lDr4MIKmK/JHCm2N1TR4z/kVhgkPyzmlKM3bmZDo4Uh+AdZK8DbIvGqyw5s
 vx7oP8rRE1jC8KZtyVQFnFM67wItNV5b/5mCCN4Waj5COPhCubx2o2d7QLi6eORmoAyX
 w3LQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE1Cjj3UpniZKgr0r2xTwesOz9NKvXOgOcAOPUMMa/XuJpK3vh4Y8RqBMkXIaZ8F824IzWuf8w=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8L3iQo7veoSYLH5Z8xDX43TDT/JkbulJZ/iOijVpkLK/RLpUke
 NtNHy3AI+GypUV9JYyXM4XaHGL5hedcu/Fgv8plravXxqs7CN4HOh7Y9lelfizu3imcad1tJwI/
 /D2zmFXkjuYygLPygF/EDB7E+/71lQX4kLqU8zO/3TAOVCrQEVT3UjTYURXC8IVJK9/g8361Fln
 HRuxM=
X-Gm-Gg: AZFdTZclN0h5tyFi7SOruKbQS4EVM7zDqYYiWWcv6yBUpu+vDjbat/hoT4HSr73yUxF
 945LFwhhr6urLo0bjgwnK5IxjXBAYbgg2QCxzDF2hzFQAcmdFqVLHJkjc39KASIxTjnLW2JboOP
 982z68yrNiWNwVUG8AtE80do0w58XAR1syeAK9icEZiAetYGo04sJvxiXHml7Jty+fEhSEbac2/
 Vg85uwxadAWoE/feOylRIPip/Nt2w+xremE7VGLIRCmfe6jaajujUarIH/oPP38TgksctoEgPSs
 iR0SMFDMagkO0ts0q4xDP3ETsIqtFCaf5VoRSMY5jq8Wf9MP6spjIGdwpwU29xVV6lKr2zrBMu0
 TpqG4PBrQ5hCGzoXGFOiHf4r7oCYq1iqiBKQfjZF6IeoR8k+fw7p/Zq5N92Mm5Iqn/2RH9J1EhU
 GuePXY3ZyesjnlQ7B4hJaIgDhDZyNpzLbdtCOHLoTi47JlvdTG4S5rXw2M8BQSzUPbfPDIxUwz8
 PoIlA==
X-Received: by 2002:a05:693c:880c:20b0:386:ab85:a011 with SMTP id
 5a478bee46e88-386ab85a718mr6367614eec.27.1795499928954; 
 Mon, 23 Nov 2026 21:58:48 -0800 (PST)
X-Received: by 2002:a05:693c:880c:20b0:386:ab85:a011 with SMTP id
 5a478bee46e88-386ab85a718mr6367594eec.27.1795499928403; 
 Mon, 23 Nov 2026 21:58:48 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567abb870sm34742351eec.25.2026.11.23.21.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 21:58:48 -0800 (PST)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 11:28:35 +0530
Subject: [PATCH v5 1/4] tools: qcom: mkmbn: Fix ipq5424 MBN version
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-ipq5210-v5-1-b509d2b05180@oss.qualcomm.com>
References: <20261124-ipq5210-v5-0-b509d2b05180@oss.qualcomm.com>
In-Reply-To: <20261124-ipq5210-v5-0-b509d2b05180@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Y+ptIReN c=1 sm=1 tr=0 ts=6b05279a cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=5oOYJkjiZhHqBJ3UFLIA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: CRd9aq_4DyAVxQ0zPajg64-0ySlSyP8x
X-Proofpoint-ORIG-GUID: CRd9aq_4DyAVxQ0zPajg64-0ySlSyP8x
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAyMyBTYWx0ZWRfXyeKrZyKtolGz
 cmg5Yn9Zbjbw2HnQoipcYhPkfjISZsMNfmPCTjELVxFk7ZP5ag/aL8nlasw0wjEKLcP+ZNTpI36
 JkXvFOHoCGFWOisds/E1bXtnByBL6Ko=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAyMyBTYWx0ZWRfX4rPb6DNMbTw0
 zog8qZBp+phpHUuimBA3tfrGhmX7fCJ3cGTvSYx5DNkWMizwcGkZeLqKYzbAuU8i3vfDRAKWzuj
 E2/hUFen0VJuUrbJ6Hmhhmmw4gkZuzh0w6BP/cabHkclQimAmXUTF8IrqnAakz2Iz0A6wxeKfbJ
 4i3R50JmbgbqiFafcR7IwxLZVjCsF03GADnIiiI5vv2jzipwtP2kn9cBLzY731D791dfK3fO2VW
 UIgM20FBVo8keEAhnK2bKr43HRBgbgAwxyf62SvxMyEMoS9tom6PcIGRvuofsO22CYbZ6IwMppf
 2s2eHO4JMKKliYaAImhbejNZzC74Q9qBEvidXcmXhEtkxY/xZxdgMjtPVwU9MfBhAOo3IB3tRnM
 KrR/2sVjBXhzaswfOt557FYvPeABDxnFRpA9KKzWiGHslRGDw6+XsQp4nz8dqrbJxOxb971o4vs
 wTOo9dLnwl92aSKlFrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240023
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

Since ipq5424 uses MBN version 7, update the ipq5424 entry in the 'boards'
table accordingly.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 tools/qcom/mkmbn/mkmbn.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index e4484b539b0..8d2078acc30 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -85,7 +85,7 @@ boards: dict[bytes, MbnData] = {
     b"qcom,sm8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
     b"qcom,sm8650\0": MbnData(0xA7000000, 7, SwId.uefi),  # SM8650
     b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
-    b"qcom,ipq5424\0": MbnData(0x8a380000, 6, SwId.aboot),
+    b"qcom,ipq5424\0": MbnData(0x8a380000, 7, SwId.aboot),
     b"qcom,ipq9574\0": MbnData(0x4A240000, 6, SwId.aboot),
 
     # msm8916/apq8016 has an "aboot" partition but the process is the same

-- 
2.34.1

