Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9044E606A327
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 04:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XQ46r1sU;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=evlcqtRg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YprmA/IH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 69D1E40EC5;
	Sat, 14 Nov 2026 04:06:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NQ63lFTnwuqh; Sat, 14 Nov 2026 04:06:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8195940DEC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794629197;
	b=pQ4/Um+QlO3hEvRBpkMGiGYohkF5Bn2rjHmqhHjB6UDBy/NFbssSSm5s+HzLSTRBnhVb
	 YGJQ2TJyQOPfig3wWqWPt5n3IAyIUTJMil6DRKRI9oq6874wk5ZBRJVCOlITzH0bZKFAT
	 6y15mbCjgDEumdYuv/kEMKYsUPXGe2nWR1IbvO5WonCnTLCRM5yGLnsLQ7yh+fX467iJp
	 l1Gsu31jKfuytbvbqJzsmfrjeyb0bvfSadLEbad+fafcn/BaNJse5EIZ6bUmoK72eq8C1
	 uxGGQmHOwB4sEypLsJISINMxhiD5HG7nTVbjrNja/NcQ4n2ruGKLmcPZNv7fQfuOH4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794629197;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:Received:DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=6bd0f7CV5LEgiqqnqTT/hJG/GdqMx/Dx0CKPieq+XM0=;
	b=Sm/Yu6KIk8gx5mxjti44+TALWHiqnB9CFJUA1hva+e6AMrIQCHVQ/Vh/o7+ATLSKmBxV
	 Aqy2MnV1W0DRuWJH8WvU8eA6FGZSvuxdE239fhL/xicre8zSbBBj3Ziw00b14fMeNLLiO
	 NHSr9dlkcw6IV+A+ztiQOYxlItbkEZIrP2uT2u8S3wwllSsm/QS34zeogQMRBrnN3f69t
	 tFQ5RtvXfrSOCpUiMDIkWIFrOkNUBr08FT1Vjxwgyl8UQ4Ix8RZ78H8aL2ceaLPyN6XpU
	 FOqTRkrFG5Nzhv/rH+m3IoeXh0nht/Z2vd6hdx2baIlLPeRCDzHGa+zR0FosvY3HAEA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794629197;
	bh=6bd0f7CV5LEgiqqnqTT/hJG/GdqMx/Dx0CKPieq+XM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XQ46r1sUNWnSS+pHK2SHnq2WCaz3wajI9XwQhU9/J6Y4gppvaLDwmwSp7DvL7ndeZ
	 GubhwkXbbpBtGb+IQrg3LAklzDdE4nYTMfvYeVyLM6ziTamzfCYLglvlcPQYQGZ/3Y
	 Japy05lQflSmffLPY9bFjidd5ksW1jYRjIy4ZmynB3y5MDJg9BMzab0iFD0EFeDX7i
	 7mvsSRp5Bhx5Rr6Vq/fG4EDtzlU4C2JqXDRNrYgH4EETAfQvIrObwPfhetJdV9Tlo6
	 jHDJZoOwlCpXeEaVLhFm43lAFJ4K3Vr17WQWW91brUVBk33TD+BXy+7LZv/nVL940/
	 MrrtE8bh+7tSg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8195940DEC;
	Sat, 14 Nov 2026 04:06:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id EDDF672D
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF3AC81AF3
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:06:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VKV5e8TmVMGm for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 04:06:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8E0CC81C44
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=urvashi.sharma@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=evlcqtRg; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=YprmA/IH
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E0CC81C44
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:06:33 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F64D847FF; Sat, 14 Nov 2026 05:06:32 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E67C584821
 for <u-boot@lists.denx.de>; Sat, 14 Nov 2026 05:06:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=urvashi.sharma@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AE20E4k3639044
 for <u-boot@lists.denx.de>; Sat, 14 Nov 2026 04:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6bd0f7CV5LE
 giqqnqTT/hJG/GdqMx/Dx0CKPieq+XM0=; b=evlcqtRgGQQJQPMq9z5JdIvT7hS
 CRKk8m+QVYYAXw0ok6V8q4CEBIp2PWP5TH7d4mZibpk1k0L6PZyR/H0EgAAQkFau
 QgoCL+1qtw061EWhzGD4Gzrdi/8upTfu9BCuZ6wKNqLj2PsrbtHfxu0GizyuqhER
 VK6px2F3nLexJ36FSbRhBXFLziCHaoti7cvK4eP5Ixmfhpc6wtG28Je/NmY/4qPw
 WerPod764DT1r0+xd+8xFz1iTHAAHcBSDW7g8tri/evYVb+7hHWQerzE1sa0iAPF
 xanr39YNLbhgxspPKIFV7+p6CkZmGm7tEA8uFv1ssyAsxto2TVN6vFjBe/Q==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxdbnrduw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Sat, 14 Nov 2026 04:06:17 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36de26cb4b3so2032258eec.1
 for <u-boot@lists.denx.de>; Fri, 13 Nov 2026 20:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794629177; x=1795233977; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6bd0f7CV5LEgiqqnqTT/hJG/GdqMx/Dx0CKPieq+XM0=;
 b=YprmA/IHp93nNT5h8uXATdF9ULbaqFmnaw+H2+jmphUVi1RJTWHmOyf1eBcOLUtla4
 o/fLZwcHxLiV+6hNn2XBTlCKkfQEdxzqENSPVqwIj1t4HLXdUmD5pbRF0Pb1K9jjC+U4
 CX3bOn4vf5ltiI0d5uNtua6HnWMbTUKM37mwfx/AAUH2R6MM6dbPA5xxskf1nhHYq+Tw
 /sSiqW1VLLHtGWCDFAdRI78ejCiu/QpctmOcHPsrfVfnnHG3MvAuiz7ctcmYtXFCsb+x
 bHlqeV1tpW1+za3KAlwwhnIoRkA/2Z4t3eiTKrDUQmNd7OvWn2b/wFc606hwAHgZCskR
 ARgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794629177; x=1795233977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6bd0f7CV5LEgiqqnqTT/hJG/GdqMx/Dx0CKPieq+XM0=;
 b=QOIA/86jW3DEab2SFpPMjl9v0r8gFLCW8XgN9eeXv+HZ4VFPh1aY7ALYRMyk6Ljcgn
 tHwxhprq3/fjCqAyBRC8SXjxXX6HJ5HPQ5sBphErOUsL8fuJRwhZMIlCJhoioIZ2ntjB
 eg25b1SkQ2Y1NikEKEQr7i105536eb5+KfkEVJmcNRMuRBpalL+lo9W+WStq0MOktu0N
 Kl2vB4ghQQLbgLdUfop7eV2h6TzXpXvbtpgg++K9brb0cCaB579vzdX2mRFCH24gjaFs
 3VTsiEG84y7vuA/WHLx1o1JC2UanqwUtUfURlQJd9AaWHxAv9gLHeIM/aLwXsbfHv1+x
 80yA==
X-Gm-Message-State: APuU4Z9+a7NVST+p4eSE1ozNlutkHdY/WCYNQ9fQaMj9bGhLCE2gozW5
 Mtx9B4vlC3p6EHxjNp8a8HmosIkEF37l1h3BvZsQGH94WKq/pGUfJTNV4pya/9oPjZl63rcU6Hl
 yOpJrbBKMeB9NmU8+70nuWOMyhXzXCtUycWI6dNRCrTlDGCTFKo/cQY3b17sRHc4F
X-Gm-Gg: AYBFou2Pmft/FtCwOMjuGhd2ZE8gNQ+xWKYyKRvLoT0aZnpq+Y0Lq+FNSCnWyhju1W8
 d8xd7RvR/0qcnn+HTl7q5RCwD2mLBLDgMAqYia9YKS63bOPPoZd9xZgbvPn5mg8GKysZOAXd4qv
 ARmrLZTKkN9O8jNjeDo+MkxPg7MKqZmJyrmuORP7buWqO3PBn4xXxwqeS8lBr9SUb21Gz9jb9Gd
 TwWY0eWi+JrIr4f48UDv4ywA/JGMj79t6Is9PbqD98g/xHYr5w0VYzorUXbenZDO50H3AT0eSHV
 qDpQgfyCcim8UrtsJSpRuB6cB5v6qrzIR7T0Ky2gflN19YFi0XB7oNn3IJZZAClMSoWc5P6uDZG
 kKwgEXlY9cG8CbRwLWN8t7uwGwj8r6HvDKbA2BWwf9DmcXQ5/bdYzjTT4USJNy3X8+NzolgxGUA
 JkjKsCrSLKMdB2m10qspCqwEM2Mkqoug==
X-Received: by 2002:a05:7301:4d07:b0:375:87f5:ccee with SMTP id
 5a478bee46e88-379684b56e7mr4343009eec.29.1794629176834; 
 Fri, 13 Nov 2026 20:06:16 -0800 (PST)
X-Received: by 2002:a05:7301:4d07:b0:375:87f5:ccee with SMTP id
 5a478bee46e88-379684b56e7mr4342974eec.29.1794629176241; 
 Fri, 13 Nov 2026 20:06:16 -0800 (PST)
Received: from hu-urvashis-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955f02ff0sm11536621eec.16.2026.11.13.20.06.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 20:06:15 -0800 (PST)
From: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
To: u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 marek.vasut+renesas@mailbox.org, iwamatsu@nigauri.org,
 trini@konsulko.com, digant.shah@oss.qualcomm.com
Subject: [RFC PATCH 3/3] ufs: add scatter-gather read support
Date: Fri, 13 Nov 2026 20:05:55 -0800
Message-Id: <b6bbbd05adaf00e9baa9217d7c62dfaca81d9c60.1794628845.git.urvashi.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1794628845.git.urvashi.sharma@oss.qualcomm.com>
References: <cover.1794628845.git.urvashi.sharma@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDAxNiBTYWx0ZWRfX+lF6xFraUlgu
 h1fIcaVhjFZwpXfoiREwRZHlBI2s6+JcMKTMVKlIWWMbcRrgCZBvHTX6L1+Ex6AabtA99ZZKUwv
 HQ/ZDNZaEABhHiVDQR8gIGAyOzJ/xYZU/4o9VfFpRQnl1GVmK+OQwn7lxqAPQVCVgosfOG2XDHL
 IlZmSxRbOdNHYsXRTUgtEH/p8kE8hJzhCV1RilBhrZ6aRmliSBDuePo59K1552sV4/hcqPDJ9z6
 IwFMnR/xG2yjeyp4qXTV25hzNJdcx+hM/h7gWEs+UwD5TJNkEOaT9GXLRKn0PnhOOat1I+e/Rgv
 z+zF3SViESUnX3KiwRdDDSjv0nz81k1TKg3hffjYgOmHJljkXbmXwiCSEx8Ivv9Ya875/yi19sN
 CtOpegmE4x9N6XuLJBZOo0IBtGf9s0CApsC5vGwLaw/Q8e/Jqqh0WITb4sEY537G+A3Rdi5E2pg
 /jIXhy9xbkgi4W1Z2jQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDAxNiBTYWx0ZWRfX8VAA1KYPcD9s
 yucfFyTTopljivhwPeJ6ppUsOvS8NEs0k9ootWPMaSiJS5AWcrcp3XTwfT0qKC4fb9ZHLB88N7O
 PY9cvW3/eSGeE7WlutX9vrwbZACEyiU=
X-Proofpoint-ORIG-GUID: t-5kkFIjIP14HXpAMwc4EIQrD-kEqPQV
X-Authority-Analysis: v=2.4 cv=ULFIjyfy c=1 sm=1 tr=0 ts=6af7de39 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=TslIWv8Q_k5keKgfKmsA:9 a=O8hF6Hzn-FEA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: t-5kkFIjIP14HXpAMwc4EIQrD-kEqPQV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140016
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
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

UFS describes the data buffers for a command with a PRDT, which can
already hold more than one entry. So far only a single contiguous
buffer is ever described, which means reading a block range into
several buffers needs one command per buffer.

Build the PRDT from the scatter-gather list when the command carries
one. Each buffer contributes one or more entries, long buffers are
split as before, and the list is rejected with -EOPNOTSUPP if it
needs more entries than the PRDT holds, or if a buffer lies above the
32-bit boundary on controllers with
UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS. In both cases the block uclass
falls back to reading one buffer at a time.

Cache maintenance follows the list rather than the single pdata
range: each buffer is flushed before the command is sent and
invalidated once it completes. Commands without a list keep using the
existing path. The capability is reported to the SCSI layer in
ufshcd_probe() so it only issues such commands when they can be
handled.

Signed-off-by: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
---
 drivers/ufs/Kconfig      |  8 +++++
 drivers/ufs/ufs-uclass.c | 75 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
index 49472933de3..df6502807c0 100644
--- a/drivers/ufs/Kconfig
+++ b/drivers/ufs/Kconfig
@@ -8,6 +8,14 @@ config UFS
 	  This selects support for Universal Flash Subsystem (UFS).
 	  Say Y here if you want UFS Support.
 
+config UFS_SCATTER_GATHER
+	bool "Scatter-gather read support for UFS"
+	depends on UFS && BLK_SCATTER_GATHER_READ
+	help
+	  Build one PRDT entry per destination buffer so that blk_read_sg()
+	  reads into all buffers with a single UFS command. Without this,
+	  blk_read_sg() falls back to one read per buffer.
+
 config UFS_AMD_VERSAL2
 	bool "AMD Versal Gen 2 UFS controller platform driver"
 	depends on UFS && ZYNQMP_FIRMWARE
diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
index 6a51f337e47..2d5efbd7db1 100644
--- a/drivers/ufs/ufs-uclass.c
+++ b/drivers/ufs/ufs-uclass.c
@@ -778,6 +778,20 @@ static void ufshcd_cache_invalidate(void *addr, unsigned long size)
 	invalidate_dcache_range(start_addr, end_addr);
 }
 
+/**
+ * ufshcd_sg_cache_invalidate - Invalidate cache for scatter-gather buffers
+ *
+ * Invalidate cache for each buffer in the list.
+ */
+static void ufshcd_sg_cache_invalidate(struct blk_sg_list *sgl)
+{
+	unsigned int i;
+
+	for (i = 0; i < sgl->count; i++)
+		ufshcd_cache_invalidate(sgl->entries[i].addr,
+					sgl->entries[i].len);
+}
+
 /**
  * ufshcd_prepare_req_desc_hdr() - Fills the requests header
  * descriptor according to request
@@ -1656,6 +1670,50 @@ static void prepare_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
 	ufshcd_cache_flush(req_desc, sizeof(*req_desc));
 }
 
+static int prepare_sg_prdt_table(struct ufs_hba *hba, struct scsi_cmd *pccb)
+{
+	struct utp_transfer_req_desc *req_desc = hba->utrdl;
+	struct ufshcd_sg_entry *prd_table = hba->ucd_prdt_ptr;
+	struct blk_sg_list *sgl = pccb->sgl;
+	int table_length = 0;
+	ulong len, chunk;
+	unsigned int i;
+	u8 *buf;
+
+	for (i = 0; i < sgl->count; i++) {
+		buf = sgl->entries[i].addr;
+		len = sgl->entries[i].len;
+
+		if ((hba->quirks & UFSHCD_QUIRK_BROKEN_64BIT_ADDRESS) &&
+		    upper_32_bits((uintptr_t)buf + len - 1)) {
+			dev_dbg(hba->dev, "Buffer above 32bit boundary %p\n",
+				buf);
+			return -EOPNOTSUPP;
+		}
+
+		ufshcd_cache_flush(buf, len);
+
+		while (len) {
+			if (table_length == MAX_BUFF) {
+				dev_dbg(hba->dev, "Too many PRDT entries\n");
+				return -EOPNOTSUPP;
+			}
+
+			chunk = min_t(ulong, len, MAX_PRDT_ENTRY);
+			prepare_prdt_desc(hba, &prd_table[table_length++], buf,
+					  chunk - 1);
+			buf += chunk;
+			len -= chunk;
+		}
+	}
+
+	req_desc->prd_table_length = cpu_to_le16(table_length);
+	ufshcd_cache_flush(prd_table, sizeof(*prd_table) * table_length);
+	ufshcd_cache_flush(req_desc, sizeof(*req_desc));
+
+	return 0;
+}
+
 static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
 {
 	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
@@ -1665,13 +1723,23 @@ static int ufs_scsi_exec(struct udevice *scsi_dev, struct scsi_cmd *pccb)
 
 	ufshcd_prepare_req_desc_hdr(hba, &upiu_flags, pccb->dma_dir);
 	ufshcd_prepare_utp_scsi_cmd_upiu(hba, pccb, upiu_flags);
-	prepare_prdt_table(hba, pccb);
 
-	ufshcd_cache_flush(pccb->pdata, pccb->datalen);
+	if (IS_ENABLED(CONFIG_UFS_SCATTER_GATHER) && pccb->sgl) {
+		int ret = prepare_sg_prdt_table(hba, pccb);
+
+		if (ret)
+			return ret;
+	} else {
+		prepare_prdt_table(hba, pccb);
+		ufshcd_cache_flush(pccb->pdata, pccb->datalen);
+	}
 
 	ufshcd_send_command(hba, TASK_TAG);
 
-	ufshcd_cache_invalidate(pccb->pdata, pccb->datalen);
+	if (IS_ENABLED(CONFIG_UFS_SCATTER_GATHER) && pccb->sgl)
+		ufshcd_sg_cache_invalidate(pccb->sgl);
+	else
+		ufshcd_cache_invalidate(pccb->pdata, pccb->datalen);
 
 	ocs = ufshcd_get_tr_ocs(hba);
 	switch (ocs) {
@@ -2189,6 +2257,7 @@ int ufshcd_probe(struct udevice *ufs_dev, struct ufs_hba_ops *hba_ops)
 	scsi_plat->max_id = UFSHCD_MAX_ID;
 	scsi_plat->max_lun = UFS_MAX_LUNS;
 	scsi_plat->max_bytes_per_req = UFS_MAX_BYTES;
+	scsi_plat->sg_supported = IS_ENABLED(CONFIG_UFS_SCATTER_GATHER);
 
 	hba->dev = ufs_dev;
 	hba->ops = hba_ops;
-- 
2.34.1

