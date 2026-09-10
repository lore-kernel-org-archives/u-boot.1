Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5B3C79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 10:30:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B1F960B43;
	Thu, 10 Sep 2026 10:30:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hnSs6o2_kem1; Thu, 10 Sep 2026 10:30:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E949060B14
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789036204;
	b=jfLfkbvfUw2hNnkCBWF+DC2dJq4oMNcib56zp0qm7+37Y7mmS2k5wpXmt+Mq4Ih+QiTB
	 QMwvd87QjcK0kAz7yef3FLzsOQq9XkuIwQgYWtf5ILhdMCD/H/jDP3ArgOav7fj9wBNTs
	 IwN8w1SBEQsDJ2R6zME20c0IJbTmMLRlUjaYJ7dr2I6wqYZFhE0MnYqnGm3CKoRsP9AMn
	 6gRM44ZjMOXw7GgbheuEt5wJCm1AMBx4VFvFMae1kNsg5BeVRQ8/ySHgTx9X4ZuC4lWPg
	 pULqjQHkiSfxcHQKeTzCtHKPnSq6j6p06o/uaIsRYnnMEDm+tTRw5U++tkjREnoUU1Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789036204;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=unQf/kVFc5MT2LHgB7VJtvfYFPXDi1LLMAdCZXFZAEQ=;
	b=B8CAvXEAzrbOte8isS1tNAjaVznMg/jNW7vHoIVJ3ePUVfuOqaGRC2eS9e8YLqLZI4wQ
	 VrhkD+LTFyOQ85q9RfT3GLzpZDULDcKDUzDe1iUbyq8pT9BWBc02OCRPAt5Gjz+eynUE5
	 thMe4FW7wyq3mEEiAaAniA1wMqz6Asm2/7RyYeERh3mDgtATiwFW6ZZAuImh0mMGxbZwq
	 7C0zjomRkCCYa1tNzajJQ8fubb0KFBmMeEKZdyH03cVecvUT+Dhw+OKDRNKdzksdGmLKJ
	 laReR7mA+JGqHYvSXYqMhTHBnIWpUZ3cTkCF3vWnDiCvv+PguJhsVmqcINjWWuJYAQA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789036204;
	bh=unQf/kVFc5MT2LHgB7VJtvfYFPXDi1LLMAdCZXFZAEQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FOMNkSiQ0WkOiHEcksVMUSt/26Q8YnZ8F22OZ52ip+NX0tXqmVrBZ/yaksqPvURAz
	 Vq/hYoU2y7pwWi0YtABYL3pO9/fnuF5xoo7r8dAky+uhzpG+d4VxgOT6ikWdtKjSKN
	 s0gC36iCXEN6ymGu1vY5M0EoVmU1cybf+aoiqdMOgPA9sD5DN+ZXCHXet7SFbPqKk5
	 ctQpOhodE8k68z4wjUG8nhWDWws8qdQBE8fDHpVR3hCRryvvNNZksL8COCoTQGm40E
	 0S4m82Rood5eiTloBB6rXrCofa8TEtFY9hIaN8HDBTCeaNDpVcIupumU79174Q5Xco
	 eZ89tEW5QOabQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E949060B14;
	Thu, 10 Sep 2026 10:30:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 420401EA5
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:30:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24C24401DA
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:30:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eb65aQbDeFR4 for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 10:30:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5BD4F4006B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789036201;
 b=P2h8TVLsVtIidHV4yQLf0bclND8zqUBfe3M6esk0IxSzRbus4luMtCshlvioutNSZexS
 HNW7gtnyFVCPg8M95NtaoQqkkcFLKDReVkIarvyd9rZh85F+9wPuNsyAADdU+2BBq5YIk
 3cbhjjV1ubYhVEBJyBirf1zBeKlPnFcYXkGE3+F5A05F8sKfot1EWnVxHI8AJymd3XYAF
 I2lWeg7HG3VsYoOLOwT8prw/LPN2ISyMFI9+zzWoUZUVi+f4ohWL3HKFC6yP/QddsRRml
 ECTqo52piZ9TxHMjQJwkCbg1drLrhGV42GcRp4z4MRSRBy1ZIEM5PHKyXDiwEp0bODQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789036201;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=unQf/kVFc5MT2LHgB7VJtvfYFPXDi1LLMAdCZXFZAEQ=;
 b=fGAHG/lKywftgEk29OJdokSrK3zrMTD9JOMPg63YP4KQhoJxoYATAb/9FsttR9IjH/xH
 ZpzdG76r79mOBELzFPlXe3LaMnmi0fiSfSb8D63a18Fen4UglSFMUyBtd3Shoy5ST5gYQ
 OfKdgjQxL8ptNtQY5F+Vl2tSEpkQJfUemhA1Y/KntDLXnEChWMYOiAreAJe5xAjVqNJ9x
 gjOGPejmU+EEvip2G7BspgtQ4/YrvD1AimKN688QviWCDCq0JiYXXRNLXxEpPZgsqNlMW
 BUR3M/2W9eTM+uWGr28JD3ROkK2VCdwIBMc4ACD5vp7uDNMYQm10ZEOor061rOID4FA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=BZUv6w5s; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fOMXdavJ; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=BZUv6w5s; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fOMXdavJ
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5BD4F4006B
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:30:00 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68A8pb023967631
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 unQf/kVFc5MT2LHgB7VJtvfYFPXDi1LLMAdCZXFZAEQ=; b=BZUv6w5spShwf7LV
 eoEepBpFqTDWB4Z9S9w82csOuOCnEUhmpQPmxNg3c222+UUyiH4mCk6nlq6PbyLQ
 X5x14T1l6cnGum7ClT+mXdvWNk9o48kmfO+IxiByYxF5qUX9Rg95ekUtvd/p/zck
 bvqh81Zu/v/sA4/cSdTLYylXOt3N7jkIbyX7+1umuz3FjCdWNZKJNJRcFw3ad1fQ
 mBO+VlVhHDLCXyKvQtD6SLir2nDReKvi6U+ZyASxSOcZQDYUoPrxBKvqnstRWluH
 O3C3FrMSdvqMQTdEt178Nfx6LtMeV6ZdyUqigB1K38kBi3C2b1YhiyTm18QeYYUe
 Lv45Zg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkrdn8n4n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 10:30:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cee1ec30f2so85076385ad.3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 03:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789036200; x=1789641000;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=unQf/kVFc5MT2LHgB7VJtvfYFPXDi1LLMAdCZXFZAEQ=;
 b=fOMXdavJ+AoI4PLpWSbZV6Osa/xIOvvLvFZRXysqdRoKTDZNV18lpga/BoymUZmln1
 pbF7S/5LDMewLyq+2rqKubyySh6cTsrdkBZird3gHQ+e4PaqULzbrdDkvt8TWLyhImS0
 VOwTHbnrnFoKQWFgZCyyGXzsCoJ/KSoA0lnzJC3X+FnN/GCnHntozUC8LYa8lEsqtc/q
 dgUjWrasaNMVA/COV/XPdc1GdvqKZjEA9HYJe9hF9EabjQbASscc8zwuCSBBmdhK++ap
 8bgQDg0W6SyQKnke+CNLujxP2GLY6DIzgeNRcBtwR8uWV2Rm4xc3Ct12UnxTPbdiyH7t
 BS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789036200; x=1789641000;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=unQf/kVFc5MT2LHgB7VJtvfYFPXDi1LLMAdCZXFZAEQ=;
 b=qEcPsd8bsHy6l4pBR88r8a7+BS/QqIzIRH6sjc5/qqQizxeH3BHW1dpZqmNz0N2mIH
 3uL4XCQ64hbLeR2KI6GVv4kIzqmIF/i3zS3oPtq7Ez82dVkguJhYAfGOWBaEACVpmGcW
 FZc2ZFbMvxR2Xwxzkfa2qKt0si+za/Wh7Sl2Xl41tsfreznrStrRSNq66HnD3MbLFo71
 3TlX9wJUH/+CfI7KHLRw2kJgGe1UYAod67tZIMSXc/6vGQ03Y0WZrEYpWp/poTyFN28K
 PsOKGlNAEnNtD+E15FHIJ/Tctvo+BgglO1hrh9YpE/36n+gXSdUM4dxVzIozkBBcVKz3
 1WOA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZG7XB6SipXDl5a4JaTeiWTwIulRfqZzVVZtGCbq8E54pcqTgL3SIODs6jv4XAhiDFkfQ/FMs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lfERVvdIB1lOu+C4x0Dp+77aUuqQdL+Z+ACSHLAychDUaxyQDd
 6i1VORH1LNzm/0N5bozVbY8xnbq32wpPvyiuOgpQNfiREJ9ct0U4+GVD/m/gnJ0EOBPzYDd1WJt
 wf0aGug44ZhnG9nxLHhqi9C4HzCc/KW9Q+FQWG5Pv4b6Nk7BEhJD5sPG2lYZ2eAmUEr7LQ5w=
X-Gm-Gg: AYBFou1KUdDpaKKywF0vhV5roZrtQ2R6soCgB0va4vdasCDPI0NiEHajt4N+0LZok5A
 8Qp4Tvzmyofo6xOF2od2Xpq3ADsKW4/yfwpZdqygyUz/bocBmKEo/lmbKnAZr91IdvMqXex27WU
 EaDgpGVZwppAoQaVWpDNpRQcZCnokBOgUCfQ/m72A4MJJxbwDr8Fe/ugkaLD7sVK0eabBAUxJX+
 qGPwZTZ044mvqoY4r+ZHV1UGysuLZGd9zhFSUueSwU4H7IlQMBXPjyMb6Hu2ycn2qOfQbJArgxe
 lFlNRyAE3Io8FCVWt+vV9HRrrQmlG5Uz0jeG2t3DHNRYj/KRI4G/4lj9GSwxX7izlywPmJkE1dK
 JqyGBx3pOin5cBeFipziCKxUiyZhJI/scgG8Opr/An6S+NeEKhYYG3we0UBHn+16v//EkkwymZf
 8oH5onMnpwXi04luV3E2NOis8fkmK/bw==
X-Received: by 2002:a17:902:da8e:b0:2da:eb8f:b4e4 with SMTP id
 d9443c01a7336-2db124c35f8mr548677185ad.7.1789036199743; 
 Thu, 10 Sep 2026 03:29:59 -0700 (PDT)
X-Received: by 2002:a17:902:da8e:b0:2da:eb8f:b4e4 with SMTP id
 d9443c01a7336-2db124c35f8mr548676555ad.7.1789036199267; 
 Thu, 10 Sep 2026 03:29:59 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a62be87sm42824576eec.6.2026.09.10.03.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 03:29:58 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 15:59:41 +0530
Subject: [PATCH v2 3/4] tools: qcom: mkmbn: Add support for ipq5210
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-ipq5210-v2-3-d209f7dc0fc5@oss.qualcomm.com>
References: <20260910-ipq5210-v2-0-d209f7dc0fc5@oss.qualcomm.com>
In-Reply-To: <20260910-ipq5210-v2-0-d209f7dc0fc5@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDEyMSBTYWx0ZWRfX/bdCzzd+wtXV
 Oz8Y3GnfvV0M9fz98FsF6/c6RUJdrR4klGsPOzGBjbSowl+QmC9kGI2Yy7dVu5ip/rahqlyT4cN
 SaMaXE3QuW3YqsjvAmQiaG1BvsAbG8D3sXWcM8x/rjNvSTT3RGMCGwXxWQntoRYAIMdnhqKvdud
 nBhTLXEJnmB1IobWV9/tyU4Ie5rv1sUiAJrzm7jZP5P5pRnaCA0vXDvu5jUx/coK8kFNlVswr1j
 9M8vYfLV5XFYBHRHxxsCLAwQdMMRFXaTWe6IVb8A+OguXiS5MsYPgD4QP8kHHZXoSMLaUkpcydU
 eaBNu4GyH0fMOKo7egpeqO7uQyvz1s4I29iKzogZs6Y4P/XMbXgjy1hD0vz9TfkCB8ta1tIEmww
 AnxkivksFq5KxbxCHudUMdRItRcqmcaXcdzPU+iJ7O4htnrJyA1zKt1KThtwo4RxqZySXjQWM1V
 Y/2gB0+JskJRz370SnA==
X-Proofpoint-GUID: bIxEM6Oth8IEClIL_Z5l4wK3UEUUNi9B
X-Proofpoint-ORIG-GUID: bIxEM6Oth8IEClIL_Z5l4wK3UEUUNi9B
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDEyMSBTYWx0ZWRfX5ZH1iyq7Cejv
 /5yFRE+nsxL2hfnzBJiD4L6DfCXjcWU8SrNH/umao/fAddS9uURiIupA0qSJtMuRvPATDmfdENp
 FzSbwW29yqURoPDlje1Jarl51+2v4v8=
X-Authority-Analysis: v=2.4 cv=eOmGH3p1 c=1 sm=1 tr=0 ts=6aa286a8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=hCIrC7OZVUbHvRhBxBcA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100121
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

- Add ipq5210 entry to the 'boards' table
- Add an argument to specify the SPL load address
- ipq5210's boot rom expects the SPL image size to be 4-byte aligned. To
  support this add an argument to specify the image size alignment to
  enable the mkmbn script to pad the image accordingly.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 board/qualcomm/config.mk  |  2 +-
 tools/qcom/mkmbn/mkmbn.py | 34 ++++++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/board/qualcomm/config.mk b/board/qualcomm/config.mk
index 769e4a51ca0..dd61ffd98e8 100644
--- a/board/qualcomm/config.mk
+++ b/board/qualcomm/config.mk
@@ -8,7 +8,7 @@
 # Create Qualcomm signed elf images
 CMD_MKMBN = $(srctree)/tools/qcom/mkmbn/mkmbn.py
 quiet_cmd_mkmbn = MBN     $@
-      cmd_mkmbn = $(CMD_MKMBN) $<
+      cmd_mkmbn = $(CMD_MKMBN) -l $(CONFIG_TEXT_BASE) $<
 
 u-boot.mbn: u-boot.bin FORCE
 	$(call if_changed,mkmbn)
diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
index 8d2078acc30..6fe66fc4e55 100755
--- a/tools/qcom/mkmbn/mkmbn.py
+++ b/tools/qcom/mkmbn/mkmbn.py
@@ -18,6 +18,8 @@ import sys
 from enum import Enum
 import struct
 
+MBN_ALIGN_SIZE = 4096
+
 verbose = False
 
 def log(*args, **kwargs):
@@ -63,19 +65,17 @@ class MbnData:
 
 
 """
-This dictionary is used to map a board or platform to the appropriate load address and
-other MBN metadata. When adding support for a new platform to U-Boot, the appropriate
-data should be filled out here. The load address can typically be determined by looking
-at the uefi.elf or xbl.elf for the platform. For the uefi.elf it is the load address, and
-for xbl.elf it is typically the RWX section in the middle, just BEFORE the section loaded
-at 0x1495xxxx or similar. Looking at similar platforms in the table below may help.
+This dictionary is used to map a board or platform to the appropriate MBN
+metadata. When adding support for a new platform to U-Boot, the appropriate data
+should be filled out here. Looking at similar platforms in the table below may
+help.
 """
 boards: dict[bytes, MbnData] = {
     # Exact matches for boards, these are preferred
-    b"qcom,qcs6490-rb3gen2\0": MbnData(0x9FC00000, 6, SwId.uefi),
-    b"qcom,qcs9100-ride-r3\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ9
-    b"qcom,qcs8300-ride\0": MbnData(0xAF000000, 6, SwId.uefi),  # Dragonwing IQ8
-    b"qcom,qcs615-ride\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
+    b"qcom,qcs6490-rb3gen2\0": MbnData(6, SwId.uefi),
+    b"qcom,qcs9100-ride-r3\0": MbnData(6, SwId.uefi),  # Dragonwing IQ9
+    b"qcom,qcs8300-ride\0": MbnData(6, SwId.uefi),  # Dragonwing IQ8
+    b"qcom,qcs615-ride\0": MbnData(6, SwId.uefi),  # Dragonwing IQ6
     # Fallback/generic matches since most boards for a platform will
     # use the same load address
     b"qcom,qcm6490\0": MbnData(0x9FC00000, 6, SwId.uefi),  # rb3gen2, rubikpi3
@@ -85,6 +85,7 @@ boards: dict[bytes, MbnData] = {
     b"qcom,sm8550\0": MbnData(0xA7000000, 7, SwId.uefi),  # C8550
     b"qcom,sm8650\0": MbnData(0xA7000000, 7, SwId.uefi),  # SM8650
     b"qcom,qcs615\0": MbnData(0x9FC00000, 6, SwId.uefi),  # Dragonwing IQ6
+    b"qcom,ipq5210\0": MbnData(0x87980000, 7, SwId.aboot),
     b"qcom,ipq5424\0": MbnData(0x8a380000, 7, SwId.aboot),
     b"qcom,ipq9574\0": MbnData(0x4A240000, 6, SwId.aboot),
 
@@ -100,6 +101,9 @@ parser = argparse.ArgumentParser(
 """
 )
 parser.register("type", "hex", lambda s: int(s, 16))
+parser.add_argument(
+    "-l", "--load", type=lambda x: int(x, 0), default=0, help="Load address"
+)
 parser.add_argument(
     "-o", "--output", type=Path, default="u-boot.mbn", help="Output file"
 )
@@ -149,8 +153,18 @@ if not mbn:
     args.output.unlink(missing_ok=True)
     exit(1)
 
+if args.load == 0:
+    error(
+        "Cannot proceed without load address.\n"
+        "Ensure CONFIG_TEXT_BASE/CONFIG_SPL_TEXT_BASE is set\n")
+    exit(1)
+else:
+    mbn.loadaddr = args.load
+
 log(f"Detected board {match.decode('UTF-8')} with load address {mbn.loadaddr:#x}")
 
+data += b'\x00' * (-len(data) % MBN_ALIGN_SIZE)
+
 elf.phdrs.append(Phdr.from_bin(data, mbn.loadaddr))
 elf.ehdr.e_entry = mbn.loadaddr
 elf.update()

-- 
2.34.1

