Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749FCCA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 18:07:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E6D0406CB;
	Mon, 28 Sep 2026 18:07:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0AnTqQJ9dGXR; Mon, 28 Sep 2026 18:07:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 20F87406B0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790618825;
	b=FCyAYNPm4TVolu1I74uqDd4HUC++nBz8sdHZXODdKj12XPMul5mSmGooKNXISqAwrs4Q
	 8AIR2AhP/HdscQe2tt0LC2yaeiafL/LyBhF+/+i+vV7dKIAwIpuRINrT03kgjOVpWl8r9
	 LQYIOC6kBG9nKdGkOmPpGjs1+/TimRFgcsW41j0TinaN5n6vQjKU3/CUCnzrCM6SrcZqP
	 KJno0Q8rFHoABZ/fqq5mTPiQvTSsO+qdyFJ6lXMIGOFV2lMFr1RXrj99ozWe41QNgyFuP
	 E/jI3L/BO8+spcdYeVhgn2SRt1pd1jZG651x8SD//P2ECeP54AsJiAFdqFzubrOZlUQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790618825;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OZJh5YBxGEnDmF6bTKwQ1ypOYg9HSeYTBXDTcogBH60=;
	b=L5N0GUhcufSaaRUB7U9J3OiLBx6y0YUCS8Q0mSDyJRNCSi/TDxn/a6ULc4avit5z1a9A
	 0Ph5JxnZVjUoSlX0o9BIm0JIMDVWfU6bZ8IH6YXKTsYScCAZJK8Z69eAp6tJo2IRD7Z+p
	 GOYx/sGMoTmT4pYj7WfytiCA+aYVMY6oE8QFnu1N9vTPpOpfPp29gDlldb51EG5z2SxWB
	 gIfXFyOw8017NR1hrR7gmNfvh45EfdBrC27y1DDJolENR9ApQ4c/GVMFogNql6MZidPMW
	 PsPgsnTTmLzvPOJx5PIIYFtLstcuIIniO4RgV1klKr5cMq3IM0mP4d1fOkUZEKJkqxA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Lov0WcV/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=goN9JeKE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790618825;
	bh=OZJh5YBxGEnDmF6bTKwQ1ypOYg9HSeYTBXDTcogBH60=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vZ9FEPTcDumGZau7WhXYRnktqmfmYLMmfpWevJfwwEJ8uprGlqR/1KnF49k30d0In
	 SxAVYUVetK6ozeTZuysFjPnQ5eBMg22d17/3lOL8O9jkXoSyTnFuWB79aORZGDcvSU
	 NxHZUUYWI4gun2lHkTW0j0mKiYvUeymy91UqkDlaG4i5ZU+h7ANQx/cFMh3cRuW1CY
	 3otSknIdXNa7J8Yd+AAi4NuAFa9g1ps8DSc6K4N/bRSF+0VtcWCR2/nubM8Xj9ht0A
	 uImUhZx7K0sN6XZ1/sAW/7T1Qmolxm5u9VcBjhtLY6+tDoaS3+eS866ld2Fw0hK+UR
	 9UG7C8l8IEHYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20F87406B0;
	Mon, 28 Sep 2026 18:07:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3B363417
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 20B1B405BA
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j5ZwASMnBj7r for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 18:06:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 44F2940525
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790618818;
 b=MLNInOO7xxSowj+OiknU7O8g0Vh8Gi1v61ZRKFOC5668a3lU6ro1ta1JElVyw7A0w0Gw
 Mi1tyYWrGjayMXxdgLsCm5QcNuPeHCg0ETVbtC5+Qub0EwMp8kCYWy3W2yr6F9YavAqSe
 J02/bYCcN8Ccb/+tfmV34Rx9IXxy7HbznoNXOmpu1r9vWK2QqP55K4W7LzCm0AA16uhJM
 HBlLZC44DV75qaew4d8nKDP5ahqtAFr17e9J0+W/hHW0a/5HuQEiawgXGf/kkJg0trztD
 zfEWXXjn4ztRWuaCH/L5pR8QJukbngyuBcf61/aSa0B34DKr87UbV8tYtumvqUG0BFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790618818;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=OZJh5YBxGEnDmF6bTKwQ1ypOYg9HSeYTBXDTcogBH60=;
 b=VhhGDkUv3YzYBSPU7MuW556LAfT9t6y8bG/HjrkXoWMaAMMEY1HshZCDiV1dQKW/CGf5
 2m9bgo8/23Rr+UGrO/yqUDRu6ElN3fuLgxPp4IAcC3Ldci2skYY9NuOvWLgV4tgihVsvY
 1ew6SmCyQ4LSaNqROMsBeE1K5QVTRQsROzQs7PZzWzyx8Oo8H0Shn0ZA06xxrqS1CAiVQ
 BhOHNcjLgMgG5NINXVS3kja/ODoiYVXax1HmDO+4EXiqqU8HMFCKtGywFWPwjOMyvk7nc
 gteKU9Yx2xPM3C9x6LkUTPp2PDl+u8ZP3GNAXRj6+PRfJtJZLhOh8UKdMpliIDYZtEw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="Lov0WcV/"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=goN9JeKE; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=tyler.baker@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Lov0WcV/; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=goN9JeKE
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 44F2940525
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:56 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SI03v91385204
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OZJh5YBxGEnDmF6bTKwQ1ypOYg9HSeYTBXDTcogBH60=; b=Lov0WcV//ygsrFc5
 ZTaksxP+gg75t2zQEgFHuTEjYetx2MlrY2uQtHUtDM87ZmAlOGtzLQpiiGynq/yd
 xLyNADZ9NqoMGYN2Mf4SnstGNPzQi4FF62KWXL1th6LryN7Cm9vmVFXEkTKRpL64
 T5cunW0fSMMGeMgbO6e5p/KOOPlKOASTBEZVuLHkxtaoo6uiYVWjeoIjuMgkV/Dw
 ldHvtUEdQ7+eW+9AHJqOswlNDmLxV+8y0F41rd1DKTxhplPQRVNHoiAx07wLK0D/
 BLMmHN/yq0aubE0StPM1tI5AFYKCC4jK5DkYB4VZJq1GJr8mGLqOf+fNxCcUBqwJ
 yWGFLQ==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyjt12ufy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 18:06:55 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-8a86fae8458so11200617b3.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 11:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790618815; x=1791223615;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OZJh5YBxGEnDmF6bTKwQ1ypOYg9HSeYTBXDTcogBH60=;
 b=goN9JeKEMzIRI1bnpgLSErZalRsggwKkwSXBYbxtvXNycZjYOsV4FYhnImtQbbaTyp
 GQ8oLVET013VthvZKnRgxVdhgTS+tfO/yCW4nP1OpNFvtkAMhrYnEVW50FgXXfakSeJ7
 F5VbvvbTo+MkXSOI7dQbI5lOHvO34p0qzkQIoquZxz4UB0ArDgI2XyEokkGJN1wC77F+
 Nl5qxdDbrALbYh+vwPon27wBvJXmpDk1r911tRzJ1dMZlJ0UIt9u6CtPKDOtpMZIZKAX
 c3Kgx2NnWIuM5HP7kvzbXiEwIUqW+Bfqx7eKjNK/PKwpYNmlNddYikKBH5jZYz7AjxDA
 jXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790618815; x=1791223615;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OZJh5YBxGEnDmF6bTKwQ1ypOYg9HSeYTBXDTcogBH60=;
 b=zY6YKxKwh6FpdeNjA3aHDYJgbg4roI1z6e3753KQ0cBDnLWiRLv1PcRytiFn1orYA1
 n48mjViPxJ52/7ABebwUnP+mn3Y5LfV3NQRE19VU4FVmSMm6UwKj0dDVU0LFdxqz0Fpa
 zvtHrLRv0JudjlxBjETKC4lhZhJcc0mg0aa1eRS0PJm5ygNwoywqaB3aP+Y4R258cxwl
 8Gei5ygh7PWvdTZBkyJ/OI2O8o4mIRnhxsg0RgLBe2lwUI5G+1ZWKJCyI3BJd8XAkU8q
 ArKmpCB2XGXSsBnS3koJ3cQTuffrZG93EKshk/W0M87+UvF0MvkM1s4ZjJH4kNig9mrR
 hxxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByl+5A+naSOZ/i/AnSopjWIf8NQGSpeBQ9SSn8M7YADFxQR0KB5BTam0Wn5kJTfM5RQmPPK5SE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLo4v6w6wriY2akjHwgH1nVqzNLmxZwcmrZ7iBApiTFhgKcuc8T
 UQDhrb1TdlZKHChRDpEd1XnriHE6V6BTBt1pMyuS+oVJHKO0GmWQ+LL/XIqC3AgTEoP5a3+MRwC
 l0v5T/CoksyWhNQNJdkFYGGquGLIemD63TjxV8LIDCmUC8CwsrvJbnjXuv99i3TgsYvsGxdSejD
 NL/so=
X-Gm-Gg: AYBFou1Kcc9wAtwNjJXhdIt60P3lhhGmP569ckLeqQWPuJ6/+gh9ebnkmjOk0HxKnOp
 KKraNmMTKY8bU7hx+twFd7cuDKKdo604XLdMrzli45KwsbOkEj1UWtaoVmmP2LMYYBc3QIG/yyQ
 hc6amXud/LypN6PGhD611TVBJz9UWaiLG2NrgWLmi4A4ht8T9J1RwZlBCbChVNNp4xI9DZoNR94
 K+aBIjRkI0hNH4ipq5lYtoJpnbanKqC7PQw/uBQh6YvML5B7paWKhxDHbGULSt0fSgEodaUGYIl
 4WqASqRwK8qmDIAuHJ9D3Wli0bMd+qtm6BOHcrcb2EPF+wiwB6zlAS9/550767yjvkFuBsrwpiN
 9gMX0Mzuf1JCJ80M3354if+i5xvPmCUc7JZwbv6BHah/KBzi0xQbMMF2ZkzJXG+/Zlaob0dN3
X-Received: by 2002:a05:690c:98c:b0:873:5bb2:6c3d with SMTP id
 00721157ae682-8a64ded3494mr50037777b3.68.1790618814935; 
 Mon, 28 Sep 2026 11:06:54 -0700 (PDT)
X-Received: by 2002:a05:690c:98c:b0:873:5bb2:6c3d with SMTP id
 00721157ae682-8a64ded3494mr50037687b3.68.1790618814523; 
 Mon, 28 Sep 2026 11:06:54 -0700 (PDT)
Received: from x2e.localdomain
 (108-208-224-205.lightspeed.gnbonc.sbcglobal.net. [108.208.224.205])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8a860e5e9besm49390177b3.11.2026.09.28.11.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 11:06:53 -0700 (PDT)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 14:06:52 -0400
Subject: [PATCH v2 2/4] mach-snapdragon: allow selecting the boot CPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-monaco-ventuno-q-v2-2-0e046c8242be@oss.qualcomm.com>
References: <20260928-monaco-ventuno-q-v2-0-0e046c8242be@oss.qualcomm.com>
In-Reply-To: <20260928-monaco-ventuno-q-v2-0-0e046c8242be@oss.qualcomm.com>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org,
 Tyler Baker <tyler.baker@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA3MiBTYWx0ZWRfXx5lKF8YY/dBV
 dQpmhD7cLk3VsGlDBxVTlyc5A/AMyp2yZQqt1M+MCPIpmojHrEFmgY1lneQfqU1nHKAVKfDhk3B
 onQgGClTbuXiktFMGM8Za3BkLl3zNfMi9Fv8AF0UbSs4mIFidwEPGz9Jl2O+lgsBKoLsODcMAcd
 j5gVI6Nycl9biAiYqw1zLmMSMk9eYgXDf0rXxMrQqe0jPHSeV+Vc6Efx0TIRSaa5U09BAyu3k7G
 Q/InBas84WVV0xVfhBLY2/f8zXXmMHNuu1SRaAu6OqVzARCPiPdGMw6h7KE3Qg2DxLr1l1eyg1D
 NMdLv7x+z3zfU+qIi3NLsnp7/I8C+Wn+sEMhY/SEAEkAd97/+zB6ueNPVTWqNY6p80OAF4tQsrX
 wf0AD8SPjrs70AaEsVLQwU57M5bhv3f5Mq61fKFZqS3T2wPr2OQht/boeRqt5Tf0Vp3WrQAKY63
 NfTFSsgIsY8k0owjphA==
X-Authority-Analysis: v=2.4 cv=V8foQuni c=1 sm=1 tr=0 ts=6abaacbf cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=JCgZVOSgT5sbgH6HSegA:9 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-ORIG-GUID: blQuI6V5FOlMBumaWVd5E9UrZ5Usnifu
X-Proofpoint-GUID: blQuI6V5FOlMBumaWVd5E9UrZ5Usnifu
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA3MiBTYWx0ZWRfX9vCNSiNJO9Dr
 GqQ3Zh7r26JPGz3Q6/K7+VNh+gZCBkHDIS/gR3gUZ7u9nlYwKJHh9DDZfxYHstFnEFH2XTTFefp
 YsOfJsQnMMXj1tWa3sDosyWoBQCPU3A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280072
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

A kernel with pointer authentication enabled cannot bring up the
Cortex-A55 cores when booted on a QCS8275 Cortex-A78C.

Allow U-Boot to start on a selected CPU so the board can boot Linux
on a Cortex-A55 and bring up all eight cores.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
---
Changes in v2:
- Renamed from "mach-snapdragon: add a boot0 hook to run U-Boot on a
  selected CPU".
- Depend on ENABLE_ARM_SOC_BOOT0_HOOK.
- Keep x0 in x19 across the PSCI calls.
- Reworded the commit message and help text.
---
 arch/arm/mach-snapdragon/Kconfig                   | 18 +++++++++++++
 arch/arm/mach-snapdragon/include/mach/boot0.h      |  2 ++
 .../mach-snapdragon/include/mach/boot_cpu_boot0.h  | 30 ++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index ddded0029e..fe215bcb9f 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -80,6 +80,24 @@ config BOOT0_SDM845_WORKAROUND
 	help
 	  Select this if you are building U-Boot SPL for sdm845.
 
+config BOOT0_QCOM_BOOT_CPU
+	bool "boot0.h hook to run U-Boot on a selected CPU"
+	depends on ENABLE_ARM_SOC_BOOT0_HOOK
+	help
+	  If U-Boot is entered on a CPU other than QCOM_BOOT_CPU_MPIDR, start
+	  that CPU at the U-Boot entry point with PSCI CPU_ON and turn the
+	  entering CPU off. PSCI must be available through SMC.
+
+	  On QCS8275, a kernel with pointer authentication enabled cannot
+	  bring up the Cortex-A55 cores when booted on a Cortex-A78C.
+
 endchoice
 
+config QCOM_BOOT_CPU_MPIDR
+	hex "MPIDR affinity of the CPU to run U-Boot on"
+	depends on BOOT0_QCOM_BOOT_CPU
+	default 0x0
+	help
+	  Aff3..Aff0 fields of the target CPU's MPIDR.
+
 endif
diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
index b71aab37f4..2f6b724fe8 100644
--- a/arch/arm/mach-snapdragon/include/mach/boot0.h
+++ b/arch/arm/mach-snapdragon/include/mach/boot0.h
@@ -8,6 +8,8 @@
 #else
 #if defined(CONFIG_BOOT0_MSM8916_PSCI_WORKAROUND)
 #include "msm8916_boot0.h"
+#elif defined(CONFIG_BOOT0_QCOM_BOOT_CPU)
+#include "boot_cpu_boot0.h"
 #else
 	b	reset
 #endif
diff --git a/arch/arm/mach-snapdragon/include/mach/boot_cpu_boot0.h b/arch/arm/mach-snapdragon/include/mach/boot_cpu_boot0.h
new file mode 100644
index 0000000000..f278360d0b
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/boot_cpu_boot0.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Move to the CPU selected by CONFIG_QCOM_BOOT_CPU_MPIDR: start it at _start
+ * with PSCI CPU_ON, passing x0 as the context ID, then turn this CPU off.
+ */
+#include <asm/psci.h>
+
+	mrs	x9, mpidr_el1
+	ldr	x10, =0xff00ffffff		/* Aff3..Aff0 */
+	and	x9, x9, x10
+	ldr	x1, =CONFIG_QCOM_BOOT_CPU_MPIDR
+	cmp	x9, x1
+	b.eq	reset
+
+	mov	x19, x0				/* preserved across SMC */
+	adr	x2, _start
+	mov	x3, x19
+	ldr	x0, =ARM_PSCI_0_2_FN64_CPU_ON
+	smc	#0
+	cbnz	x0, 2f
+
+	ldr	x0, =ARM_PSCI_0_2_FN_CPU_OFF
+	smc	#0
+1:	wfi
+	b	1b
+
+	/* CPU_ON failed: stay on this CPU. */
+2:	mov	x0, x19
+	b	reset
+	.ltorg

-- 
2.47.3

