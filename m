Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F90606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JLN9azuq;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F1EuRVEb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OB4AkgYE
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E0AED407B9;
	Wed,  4 Nov 2026 16:35:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cfUt-Pr_pjEW; Wed,  4 Nov 2026 16:35:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ADA07407FF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793810110;
	b=rwwAjJASb8ulDxMcLOfIRevyZCZzI0kK8BNq0u0UsU+xNr5TMlVIg4vnWVB6KBhFcIYo
	 tBFei8b9XAjfO9xWpg7KqzQwD7TCSOmrE78pamsUxqb5wzky2dp9oMX7Zd3NU5aKBZBCm
	 AzIqB9oHsQ3u107G5LpO9lkobcqBHlv4yZxrYf8B3ER2IEgNWzZEirWkNwGeq8hamGL+X
	 75C1XL97Ghy0KsQw943uuNu4y7EABOybakQCV9Qsk1kzjo5/xsbYfweAVV+HxTmgNpL5A
	 3mAA5H61xqlIFvlXVzpPQ+M492AvAMzEkef9AnWw/SJBREfRTooh06/P2ltjgKIZkSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793810110;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jBZGpCHro/wr21RSTyPAd6Ta82FGuVsasusfExoyWm4=;
	b=UmPC6NYhTu+/y8w4l30hn+nVGe02WTCvha2cNKblS208FTPj5EHxiql8bmzyMj3bZiTH
	 k7clEUheQw2a09xjj2cqrrhvgFC41s3gB9iZ2AqIMqqlddxmAhP+AMngD0KWSGFXiIjHf
	 3vbCxN+kNZKAl7rejV9UBFJwPbfaJ2+hKIH3RkSB84SK0/dkspVU1YZuS/5A8d3VO64KK
	 h23hOV/UsdHmShUj8dveEApKSEpfFmmG6QTnNaSG6wtF+M1zGPfVxXKBAVzMTnUxiI7RW
	 BXLwsJoB3Wrr1WKCL2m5Bb1W1BkE+ZqDvQFYfA+JZ06XNxH860n+b3swN2mwWk9JV5A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F1EuRVEb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OB4AkgYE;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793810110;
	bh=jBZGpCHro/wr21RSTyPAd6Ta82FGuVsasusfExoyWm4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JLN9azuqK38kMEqmS6eXaSwdy+jFEmIP9MPZIYttwrfjOGBXzDAgC2FHlsniSoHkQ
	 zz5FK+z36MYWhjMdP3xaeEz7OuCNCgjxx5gDrnlBXKfnTlTp0gtVscEURMCPIS4AXd
	 Xr+zZVKF4w3BVsULUo6YC/yAJF8U+UN9kw6rlxboUpvkugG012mRTdxKMYbRDxLNNS
	 e3a4111xCtik0VnLebqUCHjr7gsYC1OpROxhBTb5BJaRKIu0gM8boAk3DI6hkM3mbd
	 j4MT4fDurVO3dfjn2dmy6OPcVHcwdoJcWMhnqW9crlwGr4XSqZwch8fFrfqkoMudi6
	 sa/fXdx+v0o9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ADA07407FF;
	Wed,  4 Nov 2026 16:35:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B3DBF341
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:35:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 95BC140826
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:35:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5SAKhYa1MfVl for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 16:35:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 78ACA407B9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=F1EuRVEb; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OB4AkgYE
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 78ACA407B9
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 16:35:07 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Fj8CT2828741
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 16:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jBZGpCHro/wr21RSTyPAd6Ta82FGuVsasusfExoyWm4=; b=F1EuRVEbODdeYzr6
 cRKAEbq2Zd9/9FfS5axwzZsHsbDdnQ3tImgaQvsi4b3ONrjr4IkFIj4bf4teFWg3
 684+YhWaR7Q3Js0zS3kMGY41J3jqgwqEdF07mXrhJpU29S2/+j3BBUAhJyqiemMq
 PxopZgygMrezITXpOTBWsIuFYv5FG84/tI3ZenjfhlpU0ruGF+JkYkcCrb5+hpDk
 VIxTSLT9WDhV4tLoH4RHfNdhvdQbu6NwDw15gaU1pCcaYrtoLgwfTsnFMIpZow1V
 SuiNBNLWgdZ5Lg8sx2pYvog0CRz46CyoDJIqJbZ6eWZQy/VKuYpMDVeVA0mBY4/N
 kS+UvA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr284smww-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 16:35:05 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36d69ab3c2bso523974eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793810105; x=1794414905;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jBZGpCHro/wr21RSTyPAd6Ta82FGuVsasusfExoyWm4=;
 b=OB4AkgYEioNE8xJxc7KM2igzqcaQ++Z1eK9EihEIYo1s9+JwHSHgw/s214d3r7V7kk
 8MsqXGZ9mol2G8h8Y7o5Vg7WMgrrUEZN2WBEejXekorBB4/cfIrFSagCMRh7x24Te24U
 NLSttTXkPvwwv7GXpgMORlDf/092ZsTT6QNBIwe//6m73SF04XTf/vwb6GxB1Fc+pn+t
 1qwyqn9UD6DwuhMa7f8leIZMDDRJgK3+9yZPZzZsbwNi+awfqXKGpp0RHBI07C43UTqD
 DU76ybB38jQlzOGqOnKSgDSuea/Ml3DgFHD8quJpJwwjTMw97o2tn/Rao2oe2xSs/QwJ
 eWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810105; x=1794414905;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jBZGpCHro/wr21RSTyPAd6Ta82FGuVsasusfExoyWm4=;
 b=n2V62IPz1fylHzk7d+XUOjYE17FctgN4nVqgzT+UctPbO5JBa+OLOxK5qj9d5ZOk6x
 3runksSQ+ic+Vl03IJtKG4aKjK87In/y+hBuYRMCl4kiwZGhy+95lm4tYr8zjX0p/8jK
 jPOx1I4FMJXaex5YJlyJoYkgLwmccBgPX6Y/X9D3bhGciGxDAtF0GZMRur4rnTrQvcJD
 Y24hvZimFLLpwq3TJMsG2pvYBLm0NKPL1XrDoY4dxvicTWmQhsLRIqqib+XV/vScpqyc
 3Vr4Iao4nzCEIefPvLeF4kUijEUfWHu6JK7UL3oh4XWBkdAm7jpkEdB+XwsICO9sCNDI
 7lBA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWFLuZJnT9YQcJjQ3doib7POuZqEeD/IxvL4trnc871W60/meevSmQCjrZMqNrIvo77rEXf4Q=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8E9ZTLPkCzXhyomXTIh1nrR7gR4C4nIO6YI1qGrkGs102AT25c
 Hg6WuLCxIwEOpW399tGvU+A3TNvIMRrf4f0EaZKBRXRp/Wgbh/r7GNg4CiFZHT9iqKDWTnGK2qE
 eL01eQt0P9EbG2XIrRiioyvQSTVAWEFNsKctPff34BjA3h2igStFnvmPbNoVYlDuC1jTkOlw=
X-Gm-Gg: AYBFou0CfBd3k+8rJZfLMNpCMIPkYMT8D1b7gVOZ27+Of8D11IekLa36Bf2AQ+xoTmR
 NaHgkzINmDDzavESoKhIqSO/48W7gGjTyKz7LsxoKH9GQSvbUUTl+bh3JNo1mgG+rI7WVXOIcn6
 JTrws+ul+C1COxF+qd3HAWpy+wXK9ekcqrX4ugLnM+E8t9YOw/BE4IxjRIeEci0pg7G9gg4V1s7
 0r4buaEA7GRh8PgUFJ7LKHPlcauBZzVkx85loOvfUqXU9LBY+/WMgktiAiTSOLdZPhO6NsZR1na
 3TV3f/ZPY2qceQklMDrs5x/iY1tSOqaiTM1tZNq8Zf0eZMcUh7zNA8LoIVSk04by3u7pUTHEbZQ
 DA/1ylIEPsi73lnMn8wYzNinIt/BTgkL7LPsMm4RtvXSye8epTFrmAAp65vE53Tz74AshPYhcnX
 zAJdxrKCRzN5WVL3psE7IlX9hN5sSveJH1pyB4tnrJE6T4Fwv+f0CYOzm/oRHHaXQg
X-Received: by 2002:a05:7300:e9dc:20b0:36d:9900:bb92 with SMTP id
 5a478bee46e88-36d9900bf16mr1052361eec.10.1793810104408; 
 Wed, 04 Nov 2026 08:35:04 -0800 (PST)
X-Received: by 2002:a05:7300:e9dc:20b0:36d:9900:bb92 with SMTP id
 5a478bee46e88-36d9900bf16mr1052313eec.10.1793810103765; 
 Wed, 04 Nov 2026 08:35:03 -0800 (PST)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36db94376b1sm1046879eec.10.2026.11.04.08.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:35:03 -0800 (PST)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 sjg@chromium.org, Michael.Srba@seznam.cz,
 senthilkumar.l@oss.qualcomm.com, sumit.dhami@oss.qualcomm.com,
 manivannan.sadhasivam@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, petr.hodina@protonmail.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v1 5/9] phy: qcom-qmp-pcie: add SM8250/Kodiak Gen3x2 PHY
 support
Date: Wed,  4 Nov 2026 22:03:54 +0530
Message-ID: <20261104163408.1250410-6-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
References: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JdQpPkKV c=1 sm=1 tr=0 ts=6aeb5eb9 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=_TOXqkCupJKFnf-J4-IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: sRdJ14llS1VbtFv7reZoWInlonjeMdSQ
X-Proofpoint-GUID: sRdJ14llS1VbtFv7reZoWInlonjeMdSQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX+Stkpzr6VSDy
 jqM27ofQ3jQjr53jJmmgaQQSLIO8Ej5i+ebNy0Ohi0o3qApjBIz0KsyOTXahKac2pkW2EOj0Et5
 rNRunbNnExqCEeZm5jvUIaicZ7VFNfqRuzUCHOWkaeFS+sleI7Q0SV3gdmdGASFuvI2+KcSa49D
 Z2l30RpTswmHIrW7H4OjHbeq2iw+51ZJ2xp+X/F8T0UHlOU1qyBVv95FmIPt9L4uwhJxywr1U2i
 5IAYfu8+TaQ4yjlP4VCXusrezoR/4L1ZU9ij/KllskY8TgHog9eQYVQoi0zplaQv9lRz0Dndfpw
 ZXNbEPW24AYyqbuKNhawwnxgBksEBNf3dbWrnjrVBK3vi47PtTGuKaWEJCJpQ9zyKhmtu9cn28K
 9z2hXr0lDH2AqhnJzLSPwYfuUZ9h4345NjGuaW8RdWIwwB0z40c5AFySShk5vkCgWU8Pkm3vOvh
 sdcd99L4h3lXsa4HHdg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NiBTYWx0ZWRfX1Sv0Ru3sn7QQ
 UPrVGlkFfmi9wOLCEKjk6FyvH56FaB148bWj2a8b6sXDIrTkvIOjS88vIRlWoFg4c7pXOIlC6rv
 QfTtbO+g14DAL8f+Oq8poChTm6sRE7w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040066
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

From: Senthilkumar <senthilkumar.l@oss.qualcomm.com>

There is no QMP PCIe PHY config for SM8250-family SoCs such as
Kodiak (QCM6490), so PCIe1 (RC1) cannot be brought up. Also,
qmp_pcie_clk_init() only tolerate a missing "ref" clock, but some
SM8250-family DTS files (e.g. Kodiak) name the rchng-equivalent
clock "refgen" instead, failing clock init outright.

Add the SM8250-family Gen3x2 PHY register-init tables and a new
qcom,sm8250-qmp-gen3x2-pcie-phy compatible and tolerate a missing
"rchng" clock the same way "ref" is tolerated.

Signed-off-by: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
---
 drivers/phy/qcom/phy-qcom-qmp-pcie.c | 187 ++++++++++++++++++++++++++-
 1 file changed, 184 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcie.c b/drivers/phy/qcom/phy-qcom-qmp-pcie.c
index 2f6ff259b35..bf6173b80e0 100644
--- a/drivers/phy/qcom/phy-qcom-qmp-pcie.c
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcie.c
@@ -24,7 +24,11 @@
 
 #include "phy-qcom-qmp.h"
 #include "phy-qcom-qmp-pcs-misc-v3.h"
+#include "phy-qcom-qmp-pcs-pcie-v4.h"
+#include "phy-qcom-qmp-pcs-v4.h"
 #include "phy-qcom-qmp-pcs-v5.h"
+#include "phy-qcom-qmp-qserdes-com-v4.h"
+#include "phy-qcom-qmp-qserdes-txrx-v4.h"
 #include "phy-qcom-qmp-pcs-v6.h"
 #include "phy-qcom-qmp-pcs-v6_20.h"
 #include "phy-qcom-qmp-pcs-pcie-v6.h"
@@ -89,6 +93,13 @@ enum qphy_reg_layout {
 	QPHY_LAYOUT_SIZE
 };
 
+static const unsigned int pciephy_v4_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_SW_RESET]			= QPHY_V4_PCS_SW_RESET,
+	[QPHY_START_CTRL]		= QPHY_V4_PCS_START_CONTROL,
+	[QPHY_PCS_STATUS]		= QPHY_V4_PCS_PCS_STATUS1,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V4_PCS_POWER_DOWN_CONTROL,
+};
+
 static const unsigned int pciephy_v5_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_SW_RESET]			= QPHY_V5_PCS_SW_RESET,
 	[QPHY_START_CTRL]		= QPHY_V5_PCS_START_CONTROL,
@@ -103,6 +114,120 @@ static const unsigned int pciephy_v6_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_PCS_POWER_DOWN_CONTROL,
 };
 
+/*
+ * SM8250 / Kodiak (QCM6490) Gen3x2 PCIe PHY init tables.
+ * Ported from kernel drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
+ * (sm8250_qmp_pcie_serdes_tbl / sm8250_qmp_gen3x2_pcie_* tables).
+ * Compatible string: "qcom,sm8250-qmp-gen3x2-pcie-phy"
+ */
+static const struct qmp_pcie_init_tbl sm8250_qmp_pcie_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CLK_SELECT, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CORECLK_DIV_MODE1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP_EN, 0x42),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE1_MODE0, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE2_MODE1, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE1_MODE1, 0xb4),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE_MAP, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_HSCLK_SEL, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START3_MODE0, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START2_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START1_MODE0, 0x55),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP2_MODE0, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP1_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DEC_START_MODE1, 0x68),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START3_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START2_MODE1, 0xaa),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START1_MODE1, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP2_MODE1, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP1_MODE1, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_SEL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CP_CTRL_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0xca),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0xa2),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE1_MODE0, 0xde),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE2_MODE0, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE1_MODE1, 0x4c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE2_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CLK_ENABLE1, 0x90),
+};
+
+static const struct qmp_pcie_init_tbl sm8250_qmp_gen3x2_pcie_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0x35),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PI_QEC_CTRL, 0x20),
+};
+
+static const struct qmp_pcie_init_tbl sm8250_qmp_gen3x2_pcie_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_GAIN, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_GM_CAL, 0x1b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_AUX_DATA_TCOARSE_TFINE, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL2, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CONTROLS, 0x70),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_ENABLES, 0x1c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x17),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_LOW, 0xd4),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH, 0x54),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH2, 0xdb),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH3, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH4, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DCC_CTRL1, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0xe4),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0xec),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x15),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+};
+
+static const struct qmp_pcie_init_tbl sm8250_qmp_gen3x2_pcie_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_P2U3_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0x77),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RATE_SLEW_CNTRL1, 0x0b),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x05),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG2, 0x0f),
+};
+
+static const struct qmp_pcie_init_tbl sm8250_qmp_gen3x2_pcie_pcs_misc_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_OSC_DTCT_ACTIONS, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_L1P1_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_L1P2_WAKEUP_DLY_TIME_AUXCLK_L, 0x01),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_PRESET_P6_P7_PRE, 0x33),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_PRESET_P10_PRE, 0x00),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_PRESET_P10_POST, 0x58),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_DRIVE, 0xc1),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_POWER_STATE_CONFIG2, 0x0d),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCIE_POWER_STATE_CONFIG4, 0x07),
+};
+
 static const struct qmp_pcie_init_tbl sm8550_qmp_gen3x2_pcie_serdes_tbl[] = {
 	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_EN_CENTER, 0x01),
 	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SSC_PER1, 0x62),
@@ -639,6 +764,21 @@ static const char * const sdm845_pciephy_reset_l[] = {
 	"phy",
 };
 
+/*
+ * SM8250 / Kodiak (QCM6490) Gen3x2 PCIe PHY register offsets.
+ * serdes=0x0000, tx=0x0200, rx=0x0400, tx2=0x0600, rx2=0x0800,
+ * pcs=0x0a00, pcs_misc=0x0e00 — fits within the 0x1000 reg window.
+ */
+static const struct qmp_pcie_offsets qmp_pcie_offsets_v4x2 = {
+	.serdes		= 0,
+	.pcs		= 0x0a00,
+	.pcs_misc	= 0x0e00,
+	.tx		= 0x0200,
+	.rx		= 0x0400,
+	.tx2		= 0x0600,
+	.rx2		= 0x0800,
+};
+
 static const struct qmp_pcie_offsets qmp_pcie_offsets_v5 = {
 	.serdes		= 0,
 	.pcs		= 0x0200,
@@ -660,6 +800,37 @@ static const struct qmp_pcie_offsets qmp_pcie_offsets_v6_20 = {
 	.ln_shrd	= 0x0e00,
 };
 
+/*
+ * SM8250 / Kodiak (QCM6490) Gen3x2 PCIe PHY config (pcie1, x2 lanes).
+ * Compatible string: "qcom,sm8250-qmp-gen3x2-pcie-phy"
+ */
+static const struct qmp_pcie_cfg sm8250_qmp_gen3x2_pciephy_cfg = {
+	.lanes = 2,
+
+	.offsets		= &qmp_pcie_offsets_v4x2,
+
+	.tbls = {
+		.serdes		= sm8250_qmp_pcie_serdes_tbl,
+		.serdes_num	= ARRAY_SIZE(sm8250_qmp_pcie_serdes_tbl),
+		.tx		= sm8250_qmp_gen3x2_pcie_tx_tbl,
+		.tx_num		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_tx_tbl),
+		.rx		= sm8250_qmp_gen3x2_pcie_rx_tbl,
+		.rx_num		= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_rx_tbl),
+		.pcs		= sm8250_qmp_gen3x2_pcie_pcs_tbl,
+		.pcs_num	= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_pcs_tbl),
+		.pcs_misc	= sm8250_qmp_gen3x2_pcie_pcs_misc_tbl,
+		.pcs_misc_num	= ARRAY_SIZE(sm8250_qmp_gen3x2_pcie_pcs_misc_tbl),
+	},
+	.reset_list		= sdm845_pciephy_reset_l,
+	.num_resets		= ARRAY_SIZE(sdm845_pciephy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+	.regs			= pciephy_v4_regs_layout,
+
+	.pwrdn_ctrl		= SW_PWRDN | REFCLK_DRV_DSBL,
+	.phy_status		= PHYSTATUS,
+};
+
 static const struct qmp_pcie_cfg sm8550_qmp_gen3x2_pciephy_cfg = {
 	.lanes = 2,
 
@@ -873,8 +1044,10 @@ static int qmp_pcie_power_on(struct phy *phy)
 	}
 
 	ret = qmp_pcie_do_reset(qmp);
-	if (ret)
+	if (ret) {
+		dev_err(phy->dev, "qmp_pcie_do_reset failed: %d\n", ret);
 		return ret;
+	}
 
 	for (i = 0; i < qmp->clk_count; i++) {
 		ret = clk_enable(&qmp->clks[i]);
@@ -902,6 +1075,7 @@ static int qmp_pcie_power_on(struct phy *phy)
 
 	status = pcs + cfg->regs[QPHY_PCS_STATUS];
 	mask = cfg->phy_status;
+
 	ret = readl_poll_timeout(status, val, !(val & mask), PHY_INIT_COMPLETE_TIMEOUT);
 	if (ret) {
 		dev_err(phy->dev, "phy initialization timed-out\n");
@@ -998,8 +1172,12 @@ static int qmp_pcie_clk_init(struct udevice *dev, struct qmp_pcie_priv *qmp)
 
 	for (i = 0; i < num; i++) {
 		ret = clk_get_by_name(dev, qmp_pciephy_clk_l[i], &qmp->clks[i]);
-		/* Ignore failure to get ref clock */
-		if (ret && strcmp(qmp_pciephy_clk_l[i], "ref") != 0) {
+		/*
+		 * "ref" is always optional. Kodiak/SM8250 DTS also uses
+		 * "refgen" instead of "rchng", so ignore that too.
+		 */
+		if (ret && strcmp(qmp_pciephy_clk_l[i], "ref") != 0 &&
+		    strcmp(qmp_pciephy_clk_l[i], "rchng") != 0) {
 			dev_err(dev, "failed to get clock %d\n", i);
 			goto clk_get_err;
 		}
@@ -1097,6 +1275,9 @@ static struct phy_ops qmp_pcie_ops = {
 
 static const struct udevice_id qmp_pcie_ids[] = {
 	{
+		.compatible = "qcom,sm8250-qmp-gen3x2-pcie-phy",
+		.data = (ulong)&sm8250_qmp_gen3x2_pciephy_cfg,
+	}, {
 		.compatible = "qcom,sm8550-qmp-gen3x2-pcie-phy",
 		.data = (ulong)&sm8550_qmp_gen3x2_pciephy_cfg,
 	}, {
-- 
2.55.0

