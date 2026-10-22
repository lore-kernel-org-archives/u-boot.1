Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C715A606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yhWgp/lO;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hEYRJvfy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VOaFXxMY
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DDDB40782;
	Thu, 22 Oct 2026 16:38:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PXZ1VcuWPnLP; Thu, 22 Oct 2026 16:38:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8EB9A40719
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792687114;
	b=hZz479hdt+ng81LkRsyHc2iXZpdjwn6xxqmLafBOyrOXFXnG+vHTTAuw1S9RzRk3IRVs
	 Ssg7yJrn/LiZ2zYUVSxwakqku4JTdrHyRBUVpHyNpqshcI8ym3fAbFCSLyT8Wy1YVrhIi
	 rbEur4aXFY1drdjBwBDbBWGhP+R1UekNUEW1+J6oChLWoEYJ9ZjqMilGzEe91HmNQxgUw
	 S6nXpzSo2/yKrCSQx9+QCsK0MqsDAd0wuCFzg8o6Y6dRntPmJeHIcdFDNfklys5MwHlva
	 Ip1VWdvtL1hk4z3Za8C2zn6/MjIWtDfuvOR5k7xObWcviPPbANGqGe6oRcwsllpy/Dw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792687114;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=3nViC/pQT98b6qhoaiqlfI5RWAh0mGIikE+TP0nrcrs=;
	b=F0f4NDwVOxHeu8tyxEeAc43IQhQ/9OWEOktR4ybejefvc9lLeX9PLsuKDSlLLCejA3IW
	 93Iwoxn0/VAMR1+zUs7TrOqR1GDor4AGTKYGofWv3fP9WCr7v3EtnEcPHnr5lkBn3HVd0
	 om2eHS7mCM6Kl7gF+zfMl79LzxWhEcOCw2GmNnl4B3TjYJlQNUil1s00Sxim1Ein2j7lm
	 9M16kTpMBW6kcRLpp1uxgKBn1npcC9Ucw1t9F0eVYyUK8ufp8B2X2DZz5oG0mKm+Qkjq/
	 bJtGISITNyT1tDuXG9cApYfkp4be7VwiZPoi2WBXGCgzX74ZLJ/BdjxjZB97j2V54TA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792687114;
	bh=3nViC/pQT98b6qhoaiqlfI5RWAh0mGIikE+TP0nrcrs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yhWgp/lOXixr7jTuv0+qNwiWSvEoWbLHooRjsDYD0m9KlGsj+vi1LdRDL9RM7IMKT
	 XNZBJRLROh1Oy5uj4o5zH+ZDiYM4e+p3aZWBCwKaOZD7M6LP1IuT5usV8VV4teM+di
	 cGT/EJ4S9f6vbCXw2R+MYyPNsAZgaH7/9RuabXO2pGAg1I6xzlznc81YjlqQ6yzxWG
	 35G4TxlqZ76xncl7KY/vBImhPOr9no9zObXVnTw97UNJiMGzp4zBi6UfnoCx8EpDbM
	 nZ2+RkKgZQY92w4EDqD7NylLJXWJCUo34gjN84ptudBH3xypC8J2bMAAfdvbJTT/D4
	 1K2iiS0absWvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EB9A40719;
	Thu, 22 Oct 2026 16:38:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id D69A53AF
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:38:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BCC374016D
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:38:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 34spH1s3vhTe for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 16:38:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 36CDC40122
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792687111;
 b=ji7cBDQ58Tgxk2TP0vJ3BAb9OqLj931jSzbgdNmYff5ffSbqBVg0kwm1TzNqFAimDLMv
 aK8CWAw+LcfeqY4uiMsyK43hobOofXC+U4gaCxDzc33tEnnZNRK8R5Bc46Fkco6fsZ6D7
 rPfpL/UDGBJMFQVtP5mBpjf8gaEyTpQhofB7piQeRLrpQ8TfLPD0wg7TYFIfkA3uiNd39
 ljVa+DDUyJpyTVMS7e8AY0oICMkhOlwgytC4hEmXD8GJYB4CLr0vPsVClMXiZVSVFY6pX
 E3oVvA650X4o0ix+5xuECAEREH3IcDWdhXQ1Lyw9CGfP62i415iXe5tftfGkL/slUhA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792687111;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=3nViC/pQT98b6qhoaiqlfI5RWAh0mGIikE+TP0nrcrs=;
 b=hTBHPRtb7zq+gypdeCmKw3lngl5p5ETVIM+ZFbA4cvzlVJ+dgdsLwUi7xQl3n+WRsIQ4
 kaB+6KtKEAlL6NVzb/mi7nh4NrOFvHp4jeZKnQEc7uGUR5+Uo2KyG6Ttm6/1o7HOqNCzN
 GpiNBsDvSSjTaDH7EU6zfKFYKcViWx5jcBe6Dw/ZX5yMruxGC8ynbW3aE6fOY8W/leRRk
 kRYuo41kTVROgsILfE55/h67mATTTSWWFVyiRzia7KFWaNnsdbkFnxc9sjwF/PFHlLC1M
 B91C223zv2VKZIuifSIjCQcXg/hQ7vVjiTnEfJUV0KGg1AcvcjVyoSSW+KWr/W4xfGQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=hEYRJvfy; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VOaFXxMY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=hEYRJvfy; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VOaFXxMY
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 36CDC40122
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:38:30 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MGO25G733774
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3nViC/pQT98b6qhoaiqlfI5RWAh0mGIikE+TP0nrcrs=; b=hEYRJvfyzVnrVM3s
 niLayiwu10NYLbHVLB8x3wUa8+09JSrT53GQOmEXyQHFO8KTBsrzhDg4AKNSzS49
 ttJitWkXklTz19iDopL/FKEaRt/piM+CIYHLAYjgvdjOuV+x2xnfKFRCWd2MRbV6
 pZfMmHJHbYtrvidWZ3/F7NoudPuCdFC3sxnqGkQsMOSBqVC7SRyjItliJK7M89ev
 tP1JIRu9sNf6K5aNFUTwB8RrMwnkeANkTNwDEMz6gg3LoOi0/us4xeaiQ0fuERPL
 nuA9xv8sL1zFOIPuV3y4UcL8LSl0GI6LfDQqaaqvaUnpP0CigbfSYPtJ/byncvaP
 sg3uJQ==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ccnu9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 16:38:29 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-679a3664e1fso118407d50.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:38:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792687109; cv=none;
 d=google.com; s=arc-20260327;
 b=Ao0SdxhyE/fanPNnYUXP7T+b8fog7bxJVEI3o2JhcTIrWHNTXXN4lSuakSHiP2hfrs
 0VxnHU84PynwFC9jjN7svi3h/B2M/wAB4+ZgtNPmOQV6FhUO6d2YOYlaKxf3OLl1/ah4
 VatcxQ0tyxq6tQWRuOQaLUwURtQX11A4F3a8xUXSGu7v61MmAOJBGWbsnbn196L7tqr3
 PxChtIJkVIzmfBZY7ktxRhgB4s34Jc5CspL3P+KyQJ2lgHnNNFX9ojkIZ5D6hw0Ipfkj
 9Xv6qc+zs8hp86EVdNlk5AGBYVb6xbk2sBAv/eH0LOVxBUfY6xZEcrtJChfeVW4lVO0O
 bvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3nViC/pQT98b6qhoaiqlfI5RWAh0mGIikE+TP0nrcrs=;
 fh=B/74zyIPA+OIGamhd+/pDRyIIyRZxtG2dAqtplxVS3M=;
 b=NTEAWd+gkTVztgyKIrBelfMfvwu0bj8WIcL/BwcSRtnrxk0TBzMsqR50Mp5uHBh+Sw
 2qpav2lb5AfPHGea92DC7SBaZQTT48UfRDnKx1OePZ61F7hJ2XtT4eIVnNXr6YWtjeTw
 Ko0vjNFrEaFOvUfuQv7EfNgPJ1WA2zTkQwahUkMgZGH1AnStxcsW/4KLTHImF99knpg6
 wDJYuAohAAcqiICfY6LrT2B5Z/c/8pMVfY1zpg4Gt3gIOxbQoKePw+W+B6JKd2VU9IVI
 jVJjmmxuN3tlpclbixG5hx/6Z9YF1Z17NM/iQybX+gddkwlvKaeTlYnY74hzD0wejF45
 +p7g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792687109; x=1793291909;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3nViC/pQT98b6qhoaiqlfI5RWAh0mGIikE+TP0nrcrs=;
 b=VOaFXxMYERJCNHVTKR8ORxw4vtmzzmLFIDVP+an593dO/2GISqxOz3n38ZaO5dbnZI
 HV67lIUCZvt/YWK4a/7zWAZD46r07iy3PRiWucINZ64Bbi/+5ymVfRgLF6yN/eqVj4FZ
 UUTFBZFmv15gkZXp/4ub3mQiEh2+JtHdJtxm8SKKj85fFgGgQT+i8EVOdCweW6pB5G9T
 nvkvpJi2fy5DZRf24uGl8n1slaoVbyGc7PrR7w2lSgJsVm0i8p34bWyLIxdi9w/BOymG
 4PGGTxVSD7nmQhMU0Na7AT5vxDbsgHaYF1CvLLzu6MY2C3gvu+9utLluow2t52vBuwfj
 6kug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792687109; x=1793291909;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3nViC/pQT98b6qhoaiqlfI5RWAh0mGIikE+TP0nrcrs=;
 b=KKB4T6HfdX/xzvQ947agA0vk7pCKdPHzhHkuljxiEIgqd4deCALt1ZNPNXTTmjkhke
 raXOMDHzF6rQsi7J+cTRP+hrD4JJy2kJgByqetJYWE93YZYKfGJsWfYdMRBcRsKjQZCF
 KjaIySNZ6vnIuOCkT9MhM/TBZsR5yLuifnxwOSs6PxnfLMjVxwG0nIo3Fv2mVPsW2cwM
 rQO852Mt+oxwgwDYc3dln8mKxSbACsu/8g3YcrMqk+F45GVKTjrXek3Scni5xfENymtP
 OzO0X/OZcaaAUydvFV4LbRyF2kCrPlX692NpprF7Y1PMOyZmIlpLLwVqEexgsXljMJVM
 yBUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByU8qZUWoclKf57HbhkAehReWtysjsDuLaBVWoLtw8omfz3bD30xEk/CfCJ6qOmJ6Nb4vl6Aik=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKA/ogIuJ/DeUCf75dJL/kKdT5fxmQAELVZ9rkSVuskzHJ/6OQj
 55dsRmmgt9BQQHZMwfm3VVuFJHgscvWlDe4IyEdTE+gAKqSHgjJiSLE37mloVUoluX476Yxdln0
 NeeMUiOwR/GHixDuMsc3xkto7XECDq/KTq4TJ7McKrzaIDbfbM3eDKmahDD9wxyVO5MtUEyjltI
 HbYH6TrZAnpQvbiEwaQDHgIlV59HXp3Qlthd7f0xN70YtuNA==
X-Gm-Gg: AYBFou0yWfo5O7BuFgnm13XQQLN7lJIb4ylSqFQh5fC17ZgEx2pRooJwiMrbKYqqerj
 u74E3sMo5QuNvT1PGDknZt8X5aTJ+dAWiP1wcP7Ll/Mv3GPzHeCSIZKWY92ZaCE79lnXdmsRXfW
 wVsGVO8EeNFNAVgPlVD+m0P8YOVyBXEVbq4q9OJ2vn7S1orrHL+Pp0XasYWg==
X-Received: by 2002:a53:b74f:0:b0:679:943f:b192 with SMTP id
 956f58d0204a3-67a0e567fb0mr2319405d50.76.1792687108553; 
 Thu, 22 Oct 2026 09:38:28 -0700 (PDT)
X-Received: by 2002:a53:b74f:0:b0:679:943f:b192 with SMTP id
 956f58d0204a3-67a0e567fb0mr2319391d50.76.1792687108137; Thu, 22 Oct 2026
 09:38:28 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020-upstream-avb_lock_unlock_b4-v3-0-e280795a98cc@oss.qualcomm.com>
 <20261020-upstream-avb_lock_unlock_b4-v3-4-e280795a98cc@oss.qualcomm.com>
 <179267995216.3508122.10818786337323706426.b4-review@b4>
In-Reply-To: <179267995216.3508122.10818786337323706426.b4-review@b4>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 18:38:14 +0200
X-Gm-Features: AclHuK_ae6nfUX_4ROVn3YXiSQo9qUmCxmeMWfjvFpmsRDu4bpuEi0-O5JkkW6s
Message-ID: <CAPzfCAZ0oDiHj+R8nN=7JD9sVR45LZ1Vu3oDsSmE6SvhSEiocg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] fastboot: add flashing
 lock/unlock/get_unlock_ability
To: Guillaume La Roque <glaroque@baylibre.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>, Jan Kehren <jan.kehren@emteria.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2NiBTYWx0ZWRfX1tXbazppvzI3
 19pRVdafNYrSlnarG/fXuyJdgAK8GX6+0p8PGqQJYD15yW5d4W5jT9TwIDE92IDAaVxAfrDO2a9
 Cs/LSqEpLK16Ji14DyzIt2M71oM8FEg=
X-Authority-Analysis: v=2.4 cv=ReAFmFtv c=1 sm=1 tr=0 ts=6ada3c05 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=Oh2cFVv5AAAA:8 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8
 a=3blcd9rcsblN3AsqdZ0A:9 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
 a=7KeoIwV6GZqOttXkcoxL:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: 9n4Fx-W-7SKPnx1_yWmTASn7vdJ5JEFi
X-Proofpoint-ORIG-GUID: 9n4Fx-W-7SKPnx1_yWmTASn7vdJ5JEFi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2NiBTYWx0ZWRfX+RLabYLUhf4g
 czUiQPCYmGx90QS5Wwz85ew5nh19oXsl7bi65ENjCjXUnjk3jiMqK/CWmf5a0f7aq+oSAoHRskj
 54TfzCoMpkr3hDUM5LmhASC6kdlFpr0lQShVzNG7y4dX/wR0BYjpodQZGLUu739CjQqjEgZjLHW
 rwlIL6OQFcSyNmo9dzDegVrKpP6kekOj6dlKtll6c/v1o5+6W4aDcLpNy8pROENO4ZeVMq0nL6i
 YMSeOUYU9jr5NiJZtoJlssie/89+9J2gmtEfU3VJmivENlSV9ZtS6D6hmxUfRWm5k6Juu3K6NIM
 ysSdHvl2FzQB61djLT9g6eOgXLLT/Nc73uKomIArmX3fh8hTvXMEnDL0nMfnEnNdP8Pz7EfczBP
 AQKYxSYTxDBh0JRg/SUv3eV3e40X9kXvl9U2Yl7m5AnJ/UWobo5Lc5rJRBV0u0vRoKoB6jP3uGt
 I3RR0P9DPjjKbvWRqPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220066
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Guillaume,

thanks for the detailed look.

On Thu, Oct 22, 2026 at 4:39=E2=80=AFPM Guillaume La Roque
<glaroque@baylibre.com> wrote:
>
> On Tue, 20 Oct 2026 17:38:11 +0200, Igor Opaniuk <igor.opaniuk@oss.qualco=
mm.com> wrote:
>
> Hi Igor,
>
> lock state was not done in "fastboot boot" command , i don't really know
> if it's needed but in security point of view it could be good to do the
> check too, but as you wnat for this part.
> same for some other comamnde "oem run"/"oem format"/"oen partconf/"oem
> bootbus"/"UCmd/ACmd" probably more.

Agreed

>
> >
> > diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_comman=
d.c
> > index 18d86988f4c9..9d3127ee7a4d 100644
> > --- a/drivers/fastboot/fb_command.c
> > +++ b/drivers/fastboot/fb_command.c
> > @@ -589,3 +627,230 @@ static void __maybe_unused oem_board(char *cmd_pa=
rameter, char *response)
> > [ ... skip 136 lines ... ]
> > +     if (!strncmp(response, "FAIL", 4))
> > +             return -1;
> > +
> > +     /* metadata is optional on older layouts */
> > +     erase_partition("metadata", response);
> > +
>
> no check on metadat erase ?

The erase of a missing partition and a failed erase both answer FAIL, so
the current flow could not tell them apart and ignored the result.

I'll address this in v4, so it looks metadata up on the flash device first:
if it exists the erase has to succeed, otherwise it is skipped.


>
> > +     return 0;
> > +}
> > +
> > +/**
> > + * flashing_unlock_allowed() - evaluate Android's "OEM unlocking" sett=
ing
> > + *
> > + * Android keeps the developer option "OEM unlocking" in the last byte=
 of
> > + * the frp (persistent data block) partition: 1 when the user allowed =
the
> > + * bootloader to be unlocked. Back ends without a partition table (nan=
d,
> > + * spi) and devices without an frp partition have no such setting, so
> > + * unlocking stays possible; a partition that cannot be read refuses i=
t.
> > + *
>
> understand you comment but in android source code does the opposite.
> https://android.googlesource.com/platform/frameworks/base/+/refs/tags/and=
roid-17.0.0_r1/services/core/java/com/android/server/pdb/PersistentDataBloc=
kService.java#790
>
> you dont check if frp was corrupted.
> https://android.googlesource.com/platform/frameworks/base/+/refs/tags/and=
roid-17.0.0_r1/services/core/java/com/android/server/pdb/PersistentDataBloc=
kService.java#440

You are right on both. I'll follow exactly Android semantics, which
makes sense for a production policy.

>
> > [ ... skip 38 lines ... ]
> > +
> > +     if (flashing_set_lock(true, response))
> > +             return;
> > +
> > +     fastboot_okay(NULL, response);
> > +}
>
> you don't check lock status before so if device already lock you erase
> userdata for nothing , is it behavior you want to have ?

No, that is a bug. Will address in v4

>
> --
> Guillaume La Roque <glaroque@baylibre.com>
