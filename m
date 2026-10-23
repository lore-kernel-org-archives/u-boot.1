Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31ED606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 17:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QzcXP8zB;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ep3CgRFk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EwZNPX3+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A738608E6;
	Fri, 23 Oct 2026 17:47:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r2O6hr1Gr8MJ; Fri, 23 Oct 2026 17:47:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 47D6860649
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792777657;
	b=MAPmug8ED7Ii5nje/p+ki38m1CP1c9RvQgUOSUjLDiNPybV8/8yp3k7hfVR7q1mg0+fi
	 gL300U/d6IOyEr+KzeeSb6rag9FrH0/F2Mp9rbIhN6bsivO05mCBhDWGS8iDHdsK4Vl/b
	 sWHIeBAFKEBEwo+wEKTHGUSxnggOSDChNPU6rXhqVL4K1WOYQDGubsg/wZ3QURcTHwU95
	 NYGWlHrBIAKzrkcgWW8pt1jFwmEz4tbksFIOjceLnX4hfA5++Io9caQIOJnlRm3ulq39a
	 ZfO1Dp4QkvagRrXOthRmotk/PCrbqU9DFUOuNszxW+fIU7BSWDtmg8yXpkkDiivSD3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792777657;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HIomcpEEGluZaI/vVXlHhLD/V3iblGgM5SBGfy/SsDk=;
	b=EJhabYyEkAvgQsDYu/vqWgK10JkRjKQgF87iYDCTUeA9hnrPY94hK1OiWSBvcZDUzAR0
	 JZjmNhdpexhoJIWjAubL4I7qNEMTQnIZXpPEeRYzWMLQtnVbbaRVkIKjpIXfaegyWdm9e
	 oWirCdnt6H7ekZo0mLXuJSZpvk1yGiFt4a3B6TUECdErwzsYcDz/4qMqA9rb5cFFAIRuB
	 szkjItAIabMlKZ0bEvfT8CeMkRVPWJPrOJUs9pD9DY6c8ZpCzlkVZp0miblpXVa9Yf1dt
	 GUdFSnTRHNEqfoS2tdDSC4IyhjW6E7aDM+1Ton05EA/zjY9D11UkXpZUdh7+3nrtJfQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792777657;
	bh=HIomcpEEGluZaI/vVXlHhLD/V3iblGgM5SBGfy/SsDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QzcXP8zBpYayfZraAUjmuQi24/P8x3SqMoK2MsPIz0CF5AEAP3Snrqqi6JKqZJ94J
	 QuPpJiRCtW8YT7n2UrQx84oFCan9PdAdDCcDnbgmGa5m6gFtEyC9wBvZ2TKyHrGjWe
	 ciFPSmNZPbbcE+ZJNU1FRyl6OMBMnPllfx/f+EacwXtc59nEna4yqW9kFKxcHcOUPU
	 0obrveILnufSY9TSv5WOKjpODsqSQORe8h1dI5JHOELJsXP/yJ4dPx5IDjtS16Pkqu
	 LIIF0wicSJTA0h99lJGctZ06vccKxBGJMNfw/Gu86xUuXQyCfRthMmmQQxeHY/C6hh
	 HFMOVu6hKum2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47D6860649;
	Fri, 23 Oct 2026 17:47:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id EC0DA12C
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D1B61409FC
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:47:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JBYnpilS_Ygk for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 17:47:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 26396409C1
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792777655;
 b=epvEY1bvwZ71rnY/cu6kNNOfL+HpnpPSHfHexIbR9mVnPwIJOSD2MYaKgIAXrqARdjAI
 mU3LkDlFhutQg8WsHxjlV5kEK7mg/Z4ZDk3N79TOL27rmB6uxiKmfVrSVA4r4fdsBmrip
 hIOM6N7Xq4r+u1tyy1cl7CWzOViitE4oVQOIYKNR2r/Hfvc83C+KhzcMcPs2cs3YgA/MU
 qMlIqegm8SEtJfIe11uicjiWAGu3DLP1vZODBV6n56fGGhDwc0IrBBo4pSKakX/7AIcO8
 hthdx+btU93NbU7oOSW0IezG8EKHl6iHcCVoI9IamSkiHrfVh5iNc4o1LobonfMZnYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792777655;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=HIomcpEEGluZaI/vVXlHhLD/V3iblGgM5SBGfy/SsDk=;
 b=T0BwIIxqDXjSc8pk79hwV3mxDUjkgapPcPSjHI+nfWjRZkZKKuJVNe5mYOAyPG+KFUTy
 tsMCrHzZUOaEPAmxzGMA9ebm1yVAcEgDMh7iP1beHX5y/YQGg6SUGjvyl6bRWdfVRaiAF
 Ck8EQJSMG7j9wsdq/SlgUAaryLtTWpqy/SxZ1yGAtam1lZiLgg5OTxfZIIjYVrpbf+g7j
 NBiW5HD0ds1Pp3O8HN//BR2L78DEaIgdOOPE4eouCkVJSL2vmZvVGJOmMvJgFKcGbqQRw
 IfG7zhApEMT4s02sZtTah3/XpE7XkY/GPJEJRcNzzCAQLaa/NMh50jnWE/8JZOZA88Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=Ep3CgRFk; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EwZNPX3+; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ep3CgRFk; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=EwZNPX3+
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 26396409C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:47:34 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6Do12462572
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HIomcpEEGluZaI/vVXlHhLD/V3iblGgM5SBGfy/SsDk=; b=Ep3CgRFkgPuA6EDf
 WhkNGjdcQ/7OG+ihDPDw1yX1yL9gDiHxRCFfbn08c9MCWZWRB96m4Py6BZ5YXVKB
 INcbvbuCa368vSVJH7vJ8K0ln6NAUGBLT2AeRHACN3r/JJ+IVbXIpfCE1d8QkGJS
 Ny7eiPJMQxqkCnXSSYrIscHqep0BNDKpUMQd8xrau19JY+zKVVU4lO/CWgTLHCzG
 33wMy+VElkZo+W/J9LS1i6lI039FyRNLriO1STihg79FGrXu3qmXbTWYGjlLUOQR
 BEp2tNakPLtUAVMbUxgIy5A5+StPjvF1Bf/lA1AHydFfb6RUi4MjU/6i20HZX/4y
 vM2T6A==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtvwab-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 17:47:34 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8b150adb80cso21300927b3.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 10:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792777653; x=1793382453;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HIomcpEEGluZaI/vVXlHhLD/V3iblGgM5SBGfy/SsDk=;
 b=EwZNPX3+XCYG0BKEPsrVOw30TJPJ1oJeMThlnoUsR9NVCHONHeDYIzuFSWJbLOH5aq
 lEB5Hpggcl1l7EUqpGd3jLZWKH41hRYiz2WGWK3tSaeNSbzFeHUSIgX3QfrTcxXXC5Bh
 Yyyg/goFpFKS5zDwEx4JhI0OxVjAWmR4Zrv40gH4xxxjt7MAjIr9uE4uXaNSiDkYDXKn
 8WlfO2VlAwCnLvTkmQEBx2Kxq0hpt6BhR8pQZ0q0CKAXMcOquDeeRMVY1hpAAWAj3w0R
 mLeEZNgqRbqjSdS74ORDyAIgIG+aPXPW4S/hMiWB/k40bVPcb3XbgsjwMsW9J4ZNkm6O
 T41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792777653; x=1793382453;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HIomcpEEGluZaI/vVXlHhLD/V3iblGgM5SBGfy/SsDk=;
 b=yAlNv6UjA3tAR+lTcK7jwP9i6zDJQa+cYV9VOQJGnH73XFROwydjyIh4KJPKoBoUKJ
 PM2BNpcLEmwDR7FqgC1X+GVyh04bksVUvLOAAc0jVCrhaWNeqDFhbRZTDgwWxFfRJjMC
 mZNKJg+WnajiViizB1cfKJUu1Co37YErcQ7qE0SNY1uGcVS9eGBBLQjuDs0BlHFOk+ce
 L4eyccdUYNrkgNZwLvqogYV1YR6du+yJzvchqIyhjI//+I9JFIaXKl5Wm09kqhoqHrGn
 29yeBdxpVTQjMbAQS3a3FjV3XY3EL+uR2OpdvGj3VLikSAcn3KXlnTroDvv0GgTFhG7m
 FYQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgsIvxBJ0T5Ba2e9D3EovTOsiPvoBz+z5fuZwZhodxPP9/qYMZ1iX2QHAhRYPvJd1q4qIhj3k=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIp8rQegTmYBVp3qgATR7hYfLdbi254w1ug1WdH9RBe64VZ404k
 ucBgi5yuWR2GJqkX8y65dO3H6RM7+5I8gCzwrg3a/nPDcIRKdxZUGijduky3So7GKLFjI9Emtrm
 F2KxSdOs4dwZjISurV19PMbqMd5CYrCug3/+C8DRtdb9pA+uj24b1bRfAENDzoE5RdHQqnhU=
X-Gm-Gg: AYBFou0gLfCOj0eXQ0lLhxy96I/qmbORNMfNLPMePW5Xhf/QP+r0Hb/NOLFvDShFIp5
 gWd1RNlt0a6hQGRj3G7FSeIIV/QPf2b34QXlrYLNDppu66i4c+0bqi6N+WIBD9swrdNoFDaekJ4
 oDYsOCGjPY9YVFoB6c9in+ABVjn/ZFnl+CoTkmKYDA16v+/+asHRSK8hkWnz03AbrJBh4pMuani
 1XxrgJ33DuutL6we9AtyBzlFTsmGusvGT2upsAz2SzrIdGcWUakvjkzdeH1t1xQKW2w7io01klm
 2uuUd9gAtC4JgotSAjE3Prdj3XsXHWlwpKZ7ZYxfEClX0rDWMIEFnP2fVEdHD4EtNz9yGY/9ntC
 U37dYrHdbXbVaDjAZ7W9caTK3P3CE/tcPIhZRs70+hKqerg0CY95FipSV5Hdt
X-Received: by 2002:a05:690c:c509:b0:8b0:e13c:2852 with SMTP id
 00721157ae682-8b1456af9c0mr47188327b3.7.1792777652947; 
 Fri, 23 Oct 2026 10:47:32 -0700 (PDT)
X-Received: by 2002:a05:690c:c509:b0:8b0:e13c:2852 with SMTP id
 00721157ae682-8b1456af9c0mr47188147b3.7.1792777652592; 
 Fri, 23 Oct 2026 10:47:32 -0700 (PDT)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net.
 [108.208.224.205]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b163d8eff7sm2868697b3.25.2026.10.23.10.47.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 10:47:32 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: trini@konsulko.com, ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 quic_varada@quicinc.com, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v5 0/3] mach-snapdragon: Add early EL2 hypervisor switch
 support
Date: Fri, 23 Oct 2026 13:47:31 -0400
Message-ID: <20261023174731.1554193-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013110525.2465737-1-aswin.murugan@oss.qualcomm.com>
References: <20261013110525.2465737-1-aswin.murugan@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adb9db6 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=H-P9fH510QDsKVragOsA:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-GUID: TADk2LWplFfpebJMiVcYB18WT11DpwMO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfXwX4HwcC+nJPk
 heJWxddstkhJmxU1PUn5WJzt8owy/iCAqedTEDFHoHpbA8NMc3+B2LCwamCQGEbAtt2gA8AhFGQ
 7OoCXinHHQBh03wWBAOmzxrYZ87rGA353VKrlv40veuN2nGSFralBISBfhI28973zEt75i7fAv4
 G9E5Eg1hFt3DO8d05H5wtWjd4vVZxnSx93CK4jHypZyWUiuSYdgAxNd3a9pd44k9XEVPI44KzTv
 e3X3nn/ZvGxSXlRGt0sFZ127d1pOIoEQTa3Ijn9Y0NQflsCZc6tI3gB8lnxklQqtvldSL+smziY
 wzg8IperlLjNCCFOGWJBUQ8+YefyaxNa9cO3oqpAZzHBJ4tWTlCMpVcgPZflFsUE5YT6IgtZJvX
 sRxxOIn+MNLV1DeyAVF2EeUKlY1lmMwctfRWfYng2oum3xeDxwPwWzqeiYxioVMvZ5S1a0DagBM
 EpgaqeIxB2YzjlL6rVQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2OSBTYWx0ZWRfX6YfdZvs5l0RD
 47lLtJRROrZFcw4jaEgdXqlGrj+PPUvDv+LlgETDqO0nAfiQslkI4RZi90rSqR7D/bG6p65Ws8j
 2pwl2ORK1r19aGAbWDzbGug/pXo5F84=
X-Proofpoint-ORIG-GUID: TADk2LWplFfpebJMiVcYB18WT11DpwMO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230069
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 13 Oct 2026 at 16:35, Aswin Murugan wrote:
> This series adds support for exiting Gunyah hypervisor and switching to
> EL2 during early boot on Qualcomm Dragonwing family platforms. This

On boards that take their memory map from SMEM before relocation
(VENTUNO Q on the stock boot chain), this hangs U-Boot before the banner
once it moves to EL2: SCTLR_EL2 comes up with C set and M clear, so
qcom_smem_init() calls mmu_map_region() before there are any page
tables. Can those calls check mmu_status() instead of dcache_status()?
