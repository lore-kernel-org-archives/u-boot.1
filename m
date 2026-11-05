Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9329F606A329
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CGihOPsI;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mVW/Or1c;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Pb9VtE5e
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 71373407C8;
	Thu,  5 Nov 2026 18:26:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lfVNhuWWsbSx; Thu,  5 Nov 2026 18:26:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9EB22406F3
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793903217;
	b=Nuw2MIGYGdPjS//B8al51+azTVF2Wk05sxJZwHNw0JGGAdhi/2LO4TRSZ85prW+SfCRA
	 hm5/PNEuBJHspXTJSbznPA/OJx8En9X65Cl4mngc5Zzrp+l1kzMB5wHbx286pGDrLjQt8
	 uq09iURbWPO0BNhiAHVZpPf0Oj2KpcbN9qCjIFz6PQkZRDGVCDbFl7fgmY5y0j+Fip5Sn
	 +1T7PutE22i+pYsGC5EJ8PeK0/4g7cbaz2eTXOAQnWbjM0PvO0/Tw8zFTI/uKQTyNghRo
	 26DhmniJ2oBrAlSENCubbZe29kXet3TbMWBl+sSarkoL2LXMeTKX3yo8ahcUjDFWS8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793903217;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=W2ovzM44tG8vaE/z3M654GNrCm+4cAAlD4/vOe8Aupg=;
	b=SSSrWOl2xKJ5hYxJRVvd/IH/n8C+ZKMblljVSwsEdhbcyWwXuBQ7+InDQpGBgfUk1s83
	 Z250HWlSXyvtKdaiw5hAlwdLLsFGgbPBIPk300iv1M65yM96/BNMw8Hv5eoRSYT8UkvML
	 FfW2QUQEXK669EUH6Eh2oWOiRp3vhsQ4j6Ps2syrjZ9AQki1SJaweE6D6vBl5UuIiHm5U
	 A4Cg6B1//tVj4vvedptvjV6jEhP1v8s2jQuKX4z8X+t45WyrqtIKvzz3A+8dm8/sojuFS
	 SP2KL41UMSGjlYe/aJEPy/vEvguERZt+unpA5raVfxa25acHTei3qbApSiYRuyik9ww==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793903217;
	bh=W2ovzM44tG8vaE/z3M654GNrCm+4cAAlD4/vOe8Aupg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CGihOPsIKPuNIhCQgpIgDzXnlyZIyHkLdRC4lfj1F9+tr6Vo9JxClnyiQkqk6+RDH
	 iBnFNKc8LDSz/tNbc0ZXO88SwFxjOecxIgAQGFutkZSxb3Y+DW0Wd1LNgOK330FoCQ
	 7BXh1A8vlpCr21FWmPN2JtHKVBckyPBJEBng2p+Nzetiqicqh2hfl3TQB1W96Yw9Dw
	 /P3sF2YmL0fEs/W/3x9x8WAoW3xzzx2xNbaVWIXkJ3miEzQ8aC9HYJg01aJK/VA2eI
	 jGfg4GJ6AL07hyKG6i1bvuQV8hMDNk3DTC74QM6IuA26T8pzPhNdPYPU2SrSjFlNEA
	 7yVUcNaRQIfyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EB22406F3;
	Thu,  5 Nov 2026 18:26:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E3CE2AC
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:26:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 73F5260833
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:26:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qZd7KJQ1_Y8n for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 18:26:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CDDF660820
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=mVW/Or1c; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Pb9VtE5e
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CDDF660820
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:26:55 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeAno2433580
 for <u-boot@lists.u-boot-project.org>; Thu, 5 Nov 2026 18:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=W2ovzM44tG8
 vaE/z3M654GNrCm+4cAAlD4/vOe8Aupg=; b=mVW/Or1cQDRMzDAzbh24EzZNOGR
 vX8PVNBTaxyJGedfzApA3YpxRb7DIUjY3nv0qTaGQc/TggUWtfNWCyo/98gnFCWw
 NllgPF0l8xm85axzKSRxnPrmwnR+h99e+N6StiYXusRyy8jalUEpNrvJEymi6cIB
 Z8VHdLMZ3u9o60s+g/FWBIvlPypDsSn93C+L2SL0q5Z0aJpTbOvyNrXGrfZn7DHj
 8qPlrit+yMcSbo2JXB1Gc1JfGpBBs9mJeXac2VJN5+0/pwkVMh6TScaiO5GbZIj3
 DjkMHMXktQ2TztfLsPgxS2KFS7sYnQEi5haZjpPfXgm4luv3ugkNbXyyd+g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqpd27ba-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 18:26:54 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36f26e6abe9so469003eec.0
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 10:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793903214; x=1794508014;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=W2ovzM44tG8vaE/z3M654GNrCm+4cAAlD4/vOe8Aupg=;
 b=Pb9VtE5eXMcDBIB0hvA/SJ6SbwvGbcaFA7kyppranfFZgrOIMd9QGuczzjYDuFI3QG
 FAaqPvhmhO/2fKYvLZQ29b0uTXBCGKB6YVvwQLmteHVKuBT8MJ97IZZcWAHTA98mpE7S
 30qclPbQMZDlFhFy/cid6Dkhi3WDWqR9fjizgzXw429dzTBOni2RZnQHYnVkQG9qXJ3l
 iHT+qP6ceLuFN2rGEHdHwoXRvon6Bmsf6PelEfIr7+6b/9dQaPoyeu5690I/UnNk/Snq
 wq5e69J6OrrDY5mPCejAVSTh9q9Ouh0jQ5/qMSy6fU8yqLmi4bAJraZWEwLkE+1KzNgw
 pjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793903214; x=1794508014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=W2ovzM44tG8vaE/z3M654GNrCm+4cAAlD4/vOe8Aupg=;
 b=j+U4SebfWlN+jaxbZwAVnICsOuHEU75kke7EaT3bjU6z1BwkBDGMOLo5/zZh533a0b
 iXMn4vg9A2dKXVN8GpMY4BMPl1N0XYKFGQ6Vct+849TlmLnzyu9J7dlu2LkwoPfu83B9
 TBgH+YP7Kn7SGT9BPd1nCuOJHMn9db8LPHuEgT5u6qLc3hoP7Ow363s/mv8+o8PXRcpO
 bNC4KpNgwotG+jt0MjPPD7eHJKFhfpmnmMsdCd6fJA+f8lVvQ3u4wvQQ3jPuJAWv0sVO
 FER0J2kKRIDnfIzxZmB3+As13s64IlRDu81aHPQsD8ZTpZ0OjDmW4KXy+G4ZtEAUp5S2
 cQyA==
X-Forwarded-Encrypted: i=1;
 AKwUvByEA8xWP5a/7eZM5VobGAXq3osCWsm55Oqnq0cR+U1dVApjG4JmeU70bUAkbwjaXk32GOXg0pg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8tQ2g03uHOtVDu+ooBPGuzmHKCbSpQt8VXPqqNBKSXrAM3uowI
 5zhyvBByxGd4srj1Nzc/v2/41McPDGpZrPle/FAM2chjKXcRaVXCkukDNhcKSHbEwMcn3V6C/jr
 XEe9rz/+Y/3/WyGa7d51tmXoxKfqVuyX+i2WCbvYbxQItj4Xo0gd9wX6NC/kkIMPSl7JbhbI=
X-Gm-Gg: AYBFou3pHryR6d2HTuPo0fPTDmqURfPpN3iTlLnFP+hs9/666GGTiCQKaQIiDWQdIHe
 emJiPxvfRFx+b6Qy1gdxZdiMjDQAZklJwf8aRDtBxszFUepon5yOGLUk+Zf2e8zv2lQx1WljEa6
 lg9V5f4KgBdAfzm1yxwtTVIq+i1TyaEV4u3zvTyIIJsIRnuusTZczDZ2adGh7DcfAV10aVHaAvJ
 QyPMkbdPGSWyh0PDrkZ/l/RH3Nodvyt6ALvU/BHNrxuxGQ4/wrJtKGg06dgvNsyK/F+5ybplWoT
 lRfSeNf+8crm9jsVVkvIX+efkwaj2BqvwBigLtyZ89KuyasiJo1OeqNIXFO6zNd/MHfovTvaGAg
 IPiwQFlhQg+VkdUyamwNP16XCMdiuLeBX+OCe7sFTNTUYeSjLqdaquS4rtxWMsefJt0oQQYf4He
 gcn6IFPfKTITrl5ELxtaQ0QeFUyoXXYA3kQYw7m+nfWvp2S/u2EfWTtkbOu0swWh6QeuRF
X-Received: by 2002:a05:7300:ea17:b0:36c:c434:b6b8 with SMTP id
 5a478bee46e88-36cc4442ce9mr7857858eec.26.1793903214005; 
 Thu, 05 Nov 2026 10:26:54 -0800 (PST)
X-Received: by 2002:a05:7300:ea17:b0:36c:c434:b6b8 with SMTP id
 5a478bee46e88-36cc4442ce9mr7857811eec.26.1793903213224; 
 Thu, 05 Nov 2026 10:26:53 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f6b2be5bcsm141198eec.6.2026.11.05.10.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 10:26:52 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 nathbappai@gmail.com, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, tyler.baker@oss.qualcomm.com,
 jbx6244@gmail.com, nikroks@mainlining.org,
 bartosz.golaszewski@oss.qualcomm.com, shengchao.guo@oss.qualcomm.com,
 andersson@kernel.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v4 05/13] clk: qcom: add TCSRCC driver for nord
Date: Thu,  5 Nov 2026 23:56:06 +0530
Message-Id: <20261105182614.2405482-6-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
References: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX6cP6Ksj+6/oq
 55USqqWrmSyv8R3wO3JgBuFqc2yj+VJLagi+aYqyKx4z4hRGLFOqiKRfXecqHx9xS41Y7pVAQZY
 2c4aDXMEgeiZp7wRcJvvxWx5qnVlb/o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfXyVrrEwmcgE+o
 wM9M/CcQs7NiDVFkhF3rrg47gERMYwLIAnxaROgvljW8cr7ofdwYRUKHTT2lpsT1zE3nT7g7CKL
 4Vocd68xtgGlogGItzfrExO900/OcQhnLqw/TBnleegqCp2p4W4FftVOgrL4Wlwaw9nkRdBVjRq
 mc5jN+N9gQXv+L/f8W9sRSVl6Ed0S9G3VZZ3ZhwA9KsAlwzlIwU6eRQo/yVvaF2LMp7km3BoY9S
 bn2kfIdWJW/MeTLcseis/R2qpraeXx6ONas/MJBUj5nFxagZdsAS4yiF/dNByLWfZMCw8jtK0HI
 RLkaeP4UvMhc55Z/mJx9ykbzeTwojkG1evULFsQtgYwN2e138IyLykGXAQqXb+NeFG/VZQjEfta
 /SIJ8jOMLFbkgPgQVorJn5oW9wfTLAEKxZtrLWZw1KzkAaUongTZOiphhQTodqubUqJ1N3XXqA3
 Nq9n15mtz6cLWZcoaZg==
X-Proofpoint-ORIG-GUID: _M1zvR_RAy8U2YVe5gC80IO250IRKI0q
X-Proofpoint-GUID: _M1zvR_RAy8U2YVe5gC80IO250IRKI0q
X-Authority-Analysis: v=2.4 cv=Y5JtIReN c=1 sm=1 tr=0 ts=6aecca6e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=7MGZdibHHtmag-ezDAcA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050073
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the nord TCSR Clock Controller (TCSRCC).

Implement the qcom,nord-tcsrcc driver to provide the clocks and
resets required by nord platform peripherals.

Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Makefile            |  1 +
 drivers/clk/qcom/clock-nord-tcsrcc.c | 88 ++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)
 create mode 100644 drivers/clk/qcom/clock-nord-tcsrcc.c

diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 19cee32f9ba..bd00ce2c8dc 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-gcc.o
 obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-negcc.o
 obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-segcc.o
 obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-nwgcc.o
+obj-$(CONFIG_CLK_QCOM_NORD) += clock-nord-tcsrcc.o
 obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
 obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
 obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
diff --git a/drivers/clk/qcom/clock-nord-tcsrcc.c b/drivers/clk/qcom/clock-nord-tcsrcc.c
new file mode 100644
index 00000000000..cd89e1b34ba
--- /dev/null
+++ b/drivers/clk/qcom/clock-nord-tcsrcc.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <linux/types.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <dt-bindings/clock/qcom,nord-tcsrcc.h>
+#include "clock-qcom.h"
+
+#define TCXO_RATE	38400000
+
+static const struct gate_clk nord_tcsrcc_clks[] = {
+	GATE_CLK(TCSR_DP_RX_0_CLKREF_EN,     0xa008, BIT(0)),
+	GATE_CLK(TCSR_DP_RX_1_CLKREF_EN,     0xb008, BIT(0)),
+	GATE_CLK(TCSR_DP_TX_0_CLKREF_EN,     0xc008, BIT(0)),
+	GATE_CLK(TCSR_DP_TX_1_CLKREF_EN,     0xd008, BIT(0)),
+	GATE_CLK(TCSR_DP_TX_2_CLKREF_EN,     0xe008, BIT(0)),
+	GATE_CLK(TCSR_DP_TX_3_CLKREF_EN,     0xf008, BIT(0)),
+	GATE_CLK(TCSR_PCIE_CLKREF_EN,        0x8,    BIT(0)),
+	GATE_CLK(TCSR_UFS_CLKREF_EN,         0x3008, BIT(0)),
+	GATE_CLK(TCSR_USB2_0_CLKREF_EN,      0x4008, BIT(0)),
+	GATE_CLK(TCSR_USB2_1_CLKREF_EN,      0x5008, BIT(0)),
+	GATE_CLK(TCSR_USB2_2_CLKREF_EN,      0x6008, BIT(0)),
+	GATE_CLK(TCSR_USB3_0_CLKREF_EN,      0x8008, BIT(0)),
+	GATE_CLK(TCSR_USB3_1_CLKREF_EN,      0x7008, BIT(0)),
+	GATE_CLK(TCSR_UX_SGMII_0_CLKREF_EN,  0x1008, BIT(0)),
+	GATE_CLK(TCSR_UX_SGMII_1_CLKREF_EN,  0x2008, BIT(0)),
+};
+
+static struct msm_clk_data nord_tcsrcc_data = {
+	.clks = nord_tcsrcc_clks,
+	.num_clks = ARRAY_SIZE(nord_tcsrcc_clks),
+};
+
+static int nord_tcsrcc_enable(struct clk *clk)
+{
+	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
+
+	return qcom_gate_clk_en(priv, clk->id);
+}
+
+static ulong nord_tcsrcc_get_rate(struct clk *clk)
+{
+	return TCXO_RATE;
+}
+
+static int nord_tcsrcc_probe(struct udevice *dev)
+{
+	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(dev);
+	struct msm_clk_priv *priv = dev_get_priv(dev);
+
+	priv->base = dev_read_addr(dev);
+	if (priv->base == FDT_ADDR_T_NONE)
+		return -EINVAL;
+
+	priv->data = data;
+
+	return 0;
+}
+
+static struct clk_ops nord_tcsrcc_clk_ops = {
+	.enable = nord_tcsrcc_enable,
+	.get_rate = nord_tcsrcc_get_rate,
+};
+
+static const struct udevice_id gcc_nord_tcsrcc_of_match[] = {
+	{
+		.compatible = "qcom,nord-tcsrcc",
+		.data = (ulong)&nord_tcsrcc_data,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(gcc_nord_tcsrcc) = {
+	.name		= "gcc_nord_tcsrcc",
+	.id		= UCLASS_CLK,
+	.of_match	= gcc_nord_tcsrcc_of_match,
+	.ops		= &nord_tcsrcc_clk_ops,
+	.priv_auto	= sizeof(struct msm_clk_priv),
+	.probe		= nord_tcsrcc_probe,
+	.flags		= DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
+};
-- 
2.34.1

