Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29212606EEB1
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pDZR+DBk;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YoUckLGk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iGpKJGDN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6F5741097;
	Wed,  4 Nov 2026 15:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ojJQGFjBnz1t; Wed,  4 Nov 2026 15:57:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4BC8B40A37
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793807841;
	b=mdsKTq1zBelk/Zh9Tm6K+qKzuWDEo8oUVBeVWiXcq9ZasI+6LTvgO0ThVb0DfK3bY66X
	 lY94CnOMi+VdlOqXnF7fzQ28XA5XXQn+q7akKPsfAdZ3Ilp2Cngu5p9qWwGpwuVZesnFM
	 ThQnZG+pF8I8SiKnLtVEgEIcK7v5IOLUchelyxROCC5Pfy1BWGapajeTridCwjXFe1JCl
	 /CvXjYLx7pohYgSIOSLNGOq21ewHIF7F+E4JPE4xfyWrJLYXS0P7NbGW8E4vKvPBNZFUC
	 BkRpZFY/mqPfDEASJEds7aEOf5QlEmDPw7ZuFLLRNqle+JUvNV5gduvdpU4fw/eDhlA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793807841;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Mo7dJqQAwFnFwJrfsVnsBpcexyzBvJStuLxKWutdh7c=;
	b=sT/vDfbbYUtHWO+t+OhBPLTfnXmSjp1+KDeDw44ddKeVbNihPU7s7eCQQf4344mZz7rv
	 CSaLY/+KHifePtbkjyiitKuDyIg2nxc2PFvEeasQcAOHq/pIzcZdx9Di6xvIU9ZQuKaCh
	 JQS2pIrwrIa3EpqOdT2ARKZxbyTiBk7qx2eNExwfWOF2+VCx/K74JOb0POhsnyElhYGwT
	 Bbj6r9BhtR2idoYKk+KUXfTeIOE/86xhNYqv4Us+B2839lBjdI0wIPKL3PcFvSACEYzJl
	 vfPmlZ4dDUa1ecMq+lOy3pk0ARoG82JVrxN+oT31cf0C/ZgBbRzf9zmPDxKGFieqcZg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793807841;
	bh=Mo7dJqQAwFnFwJrfsVnsBpcexyzBvJStuLxKWutdh7c=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pDZR+DBkFrJWxe/d4Ln2gJmenWfjWgGUVHBUWE+YqunnavmXmtA9ZEz1DsouG5jw2
	 PnTxyd4yB7f/yzxzwd5xamFEmjnTkI5Deh4pm4VSMHgRSGThCQffD151NZIudaFa1z
	 mOrSo7c5cqTEI8KFE56KPLwL+y0+xAumPZ6+VWcLHeGctQbc8FLpPzAnJ8mXrUz5un
	 gdyTsrGgU+pY2XSiD02DGRugfKwpnBCqC/smM2sJiYaSF4l1JZ1RSSrz9sidcnlMH1
	 +ZFAHp+l/gRR2lauYKnLZDfHQS+ANxKixdvdBXv33rxIVIlMQ92O8kK2zzLAWeL3XI
	 jyTFKHSK6QJ3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4BC8B40A37;
	Wed,  4 Nov 2026 15:57:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C8EEC34D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 15:57:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B445A80B12
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 15:57:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NkdGZh3CXi9O for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 15:57:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 200BF80935
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793807837;
 b=JgKYv1eRlRXbPy2OQCOCskxDFhWjwvGap9RlSzLodvVCtLJ6B+x4vdYccVBfulrbAS4o
 h0qjD9kezqWMIydtWcKXDYZ3ZNrzNrvEYx0XOPvXXPBUfAwpU6MGOwslbxGphSh9xL88T
 Ze50AjXaOY5dYGfqz6/UqsHDG4URCkUhrReDISYIKK0F1HaypK5y83LpW4VjmMKAdcYsA
 2aF0rilNp8MPkVl/OD5A2Oe2oiy2pNHCK9dWOBL4cj8fLKTpTfAudfCTr5VUlGfCX66Hy
 fIEbhF8BD0shGJvvIipOuB8xdzDvQPWFV+fkOm22RUnAFIaAU/YkFbQo7/TwAzV9h7g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793807837;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:MIME-Version:From:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Mo7dJqQAwFnFwJrfsVnsBpcexyzBvJStuLxKWutdh7c=;
 b=aXj6IWlcGvpO5M2+O7ExU8et1b3SoJk8RHD6TRwHPEaSMsqbwvtAt3F0v7EGnKt/LhzR
 pZgOQvaWTDwTY+QVtaJ+ooOm2FuWih1rnza0YmFDCbYqt030LJdnTLd/4aYEUIMdwTDfv
 4RNDvcaWQdegq5QNEUO414Ehy28uChLDcYppGdgqgqSmCowoNbYd7xvpZcNhXrIKLm+tv
 YYSQHqT7U1g5xKHr0BfuoU9rzEhTnA/yzp1y/Hbgpobd6vacARasrlTbtr12ysPd37itH
 X19in5i+xqZks+Vfcp545PSrPkN3hHo4JxYv/Vhd2VXcDUv/njKdV5DTlzKVH/FVwUA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=YoUckLGk; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iGpKJGDN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=YoUckLGk; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=iGpKJGDN
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 200BF80935
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 15:57:16 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Fj3Cg2251179
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 15:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:message-id:mime-version:subject:to; s=
 qcppdkim1; bh=Mo7dJqQAwFnFwJrfsVnsBpcexyzBvJStuLxKWutdh7c=; b=Yo
 UckLGkR9GoKctqtI/utAqFGQ6iyGqThCJcmAAuU2BUDs+hc9xrTi8w4Y4asXsxLg
 VqQvri9brZSXCX7kNmYVQIhEPayoraTla46CVwcyONJrN85aa1utwSn9MnBFVlEG
 +6zlmICs1b1pGpK82enUyQ3IHXEOeu+ECI9gW0zX6bFAZxEkxBE/BrOWP5aYhC4n
 +VaFLtdtVduuVF8M7HaiW8xL3MywZ8E0L0vE2MoBXIuo8AFpYlzLw8h0EPGcvK7+
 n4TaaSQZwJtFuX7jPE0z3nY1/PBK+jVedmX5HaaeuJHDwC/zsph59LR10g6k/JHT
 krRUZM8p0lTrFaAhMA3w==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr4bn0wtx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 15:57:15 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-67bec5d62ebso1334548d50.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 07:57:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793807835; cv=none;
 d=google.com; s=arc-20260327;
 b=CCWWwqhOCcvpwAukpim78VJAeuRuc5eD50Vu1K4jJ7az7wf5XabNH30bSvr9orXNoA
 j0nvo9d42JED00NmuSg5tzMxVdFxe3mFVWhyTkwJHm6TLn4/hf3hyg+IX95lu6G+Ts36
 YfzExAJjdaxWHY/H7lkMbGS37iMMWf/JfBw0Ld0fiEUu+Mg+7dCH99cL7/W0Bieokd4J
 A5MXA2+Q5F9S9bdGn+1gz19+sNiTAqg7OCq5C1fp8rdjG57ky1JCo1PsLrTmOH9cSQje
 LcZp7pa4VWrSqcV/uhchpkiIzjYbHzWlj0pV+640UqI6YFtndOTMJBpnBES4zwmzlRY+
 6yXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=Mo7dJqQAwFnFwJrfsVnsBpcexyzBvJStuLxKWutdh7c=;
 fh=8v3HBQFE2jLnOb9tg5BFySKDj+hr617aBMHTCQgySiU=;
 b=Ctt6g5QzhvB5YE12wNBS8QmHtdVMpfao320AJAyDnkIHp7b+m7TfMq5fQu0PSsCsj/
 u4u30CWyxv1A4WYJh1rKd+1nBRsPi5yxSLfjJNfnwBe7sH/9B9mJeGc98KTa6zt809nr
 0FXQGckd2clB01HL7xGJmuX46lLFlyfgIT8iXF+xoYSYGuqw5rPGCWKDxYAWuu+MTppe
 OavkEwjMXDb2AqYGEedKtgAwH/uZf89EX2zsntgvlZ2KEPH8SUNNVHID6ivEvpWsiF4p
 QSpM0FmJwJK/zaw8a6/cc5RN83pxLktSn/l8+TknQT2E0R0Gf+cqUj7QGzjWWRb2gi4s
 PTKQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793807835; x=1794412635;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Mo7dJqQAwFnFwJrfsVnsBpcexyzBvJStuLxKWutdh7c=;
 b=iGpKJGDNT/A+pj0U9tYkY39i71/ULCRcYZWkBq8vEF//lUUKkwBrSQU023xIjxYYnU
 imYQDpgDRxMsiSko+yLBfid196phTph8WDBQ69+hb0Bj+swuOkD9HFnZunmRDQeHwP7r
 W1v2VTEASluaNHbFOCfpI/D4OROdAcjiyLoJ2KubAXtIqJkr1mm3ZcOsUGXjQ9LS45ib
 YnY4xiS37Lot/qXO9si/HOJGpZ9kdHqidght73hQqyVnJyksW0Vs7oJyWzeLeYOeAE/t
 YZcp6JhoIUKr1c4Zu1oZImuuAVXRc5/E93mmBczbF3KMsJGCMzOPZwLmztrcIswgzIZd
 TghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793807835; x=1794412635;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Mo7dJqQAwFnFwJrfsVnsBpcexyzBvJStuLxKWutdh7c=;
 b=ac+9Y9P5ExRCHVBWbPy3ND1QnpzlhSpoSWI5jCoAneY9E7oUD49qi8EWyt8L552fp3
 2c9a4aNWtgygG5pYa2a9koE9cNvAc9AvYRZ3u6W4pt3egISfjefxwsq6T+kts6NfSMvF
 DbZI+sFyoXoXNbxGBPUHt7jtwjntTEPPLvRGB9d/SJLLkN9Nf07Jt/MB0uM9xYyoUr9Z
 2eR7CJwheI7AGL1z11ZUaA1SYPPGEkwd2n2Oyqa6Px6dnDP0wPGW+Tg0a66FV1KM6mhJ
 gKvo/Cf8qN0aDMjRrA4h+l8a3iCoDg0pF6wDSQS+aEtHPK6tR67g33R8kOkJ5HdQvVLA
 XOmw==
X-Gm-Message-State: APuU4Z+etGBTVCroArFxaSSV36W9YbAns7HPvpBMKVWc4J2yTZ7QKIqa
 gehfajBAebER7ZiGazfKtlDXs6ui5HZBFWOYbiRP5bFR/7wwNjTWL/EbYBBoE2/8So5aDTPgY3N
 iyZ7ZwoazmECXFe8+/GIEgMkau3kun10SOZqVVJiueb10agyGJtPCGsGPP2i9B0DmEe1HoRhJpO
 kv08/L6ulI3PH2iBHvO9BSUFH9fRipZSXwHLMpR5sKBRQKbFnNuc/dYyFP
X-Gm-Gg: AYBFou0jz8TiPJz1tKI2hjjNdTnjYatXWZCHXb9XkGnZl9v7tJBQWFXBArxVxWfhaUU
 yfm6qBh5YTHrxwirwfK77o2qjlS9hzhl2c6tgmcUK1vif4jDVmQ9VPi7f4/6NXdSQ3SKIbPyoe6
 Il0Cg5XiF/ToURgziA2BG5bui4IFFcowbOrbqs+8xVf+1c39oyQOrOIBw=
X-Received: by 2002:a05:690e:4802:b0:67b:ec5a:2075 with SMTP id
 956f58d0204a3-67bec5a29bemr1240483d50.78.1793807834650; 
 Wed, 04 Nov 2026 07:57:14 -0800 (PST)
X-Received: by 2002:a05:690e:4802:b0:67b:ec5a:2075 with SMTP id
 956f58d0204a3-67bec5a29bemr1240477d50.78.1793807834129; Wed, 04 Nov 2026
 07:57:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Wed, 4 Nov 2026 16:57:03 +0100
X-Gm-Features: AclHuK_25NMo9HlSxmi1AAZ9S7sv9LvRneEMDbtiTmHrwYM1ixNA_P87UmjM6jY
Message-ID: <CAPzfCAaR_oeEQW61U9Pf0ahS3pBm=tcMPbDeXQeoKffMB_vWQQ@mail.gmail.com>
Subject: [RFC] Qualcomm Firehose flashing protocol support in U-Boot
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+usb@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 ricardo.salveti@oss.qualcomm.com,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, andersson@kernel.org,
 nicolas.dechesne@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2MyBTYWx0ZWRfX93caST07LDFx
 Hi/ITR4fBrF4I+gcfhdSXZd24Jm4tHrLkSgNQV1K6ndLYJMSiEK3lINy4mjfqz0YUFWEeq/XRBS
 AiZAuAm/dy6RTuD2DuiLpvCuA2PjeKBoahsvVaOKhjNLmFUwxtRDqFMner8NgCeR9E3RdTaWPDI
 RBpDnbmCvbqbAjrYfvfh0eDS7Vz+wPm3aSU9hb/YNXdWZpx9V1DTXJWMGNTKqpaiIlv5ODEgZ6y
 jSRDW74UpBjtBkID0xNIaAaIduFzGkWgHsyBE8dNnEPgp6fVMv8jObZPfVD96II8WGAEnfwpk8f
 eMZxP6GEKc/4CRvpjR4PBgJZsUxCovRj5R4SU3V7x7/o/wiNebhlv5gI/cmxUoHhvpv2c6KoaL1
 oZxyKNnRvEEJbfnlaw14EVHlHa0sDZna/nya/QC9DVxd1HF9kui4AN75+lteJNtEk/USA3dsA4r
 9jAMN02/4OUxcTS4zbw==
X-Proofpoint-GUID: i2A27tixWJCDbNfENMSyMK7FhilkgPl3
X-Authority-Analysis: v=2.4 cv=IcUSymqa c=1 sm=1 tr=0 ts=6aeb55db cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=NEAV23lmAAAA:8 a=ze3FE_zdffSvRcE2OWQA:9
 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2MyBTYWx0ZWRfX0RkijYg4Awn4
 b4paOuA/8+qyvajQ7fdah+Sfyq6i0qZT5AtrdTTvrPZi1Tj1oG9UgsX05PxbbrxJfXZLYz4IEqi
 o5zTBM/7Z2LnQn3Y5ribpuy09bV+f1k=
X-Proofpoint-ORIG-GUID: i2A27tixWJCDbNfENMSyMK7FhilkgPl3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040063
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi all,

I'd like to run an idea past the U-Boot community before writing any code.
It touches the USB gadget layer, block devices and a protocol U-Boot
has never spoken, and I'm sure your feedback can save us from wrong
turns early on.

Some background first. Every Qualcomm SoC has an Emergency Download
(EDL) mode in its boot ROM (PBL). It is entered when no valid
bootloader is found, or on request (button, test point, reboot
reason). In EDL the SoC enumerates on USB as 05c6:9008 and speaks
Sahara, a simple protocol for uploading an image into On-Chip RAM. The host
uses Sahara to upload a "programmer", a SoC-specific
Qualcomm binary (prog_firehose_*.elf) that sets up DDR and storage
and then serves Firehose. Firehose is the actual flashing protocol:
the host sends small XML commands (<configure>, <program>, <read>,
<erase>, <patch>, ...) over USB bulk, the device answers with
<response value="ACK|NAK"/> and <log/>, and sector data goes in raw
binary between them. This is how Qualcomm boards are flashed in the
factory and unbricked in the field with qdl [1].

We are moving Qualcomm boards to an open boot stack: after the stock
XBL, TF-A (BL2/BL31), OP-TEE and U-Boot replace the proprietary TZ
and UEFI stages. The Arduino UNO Q (QRB2210) PoC boots this way,
and the platform support is going upstream in each project. With
U-Boot in the boot chain anyway, we'd like to reuse it as the
programmer image too, instead of shipping a separate closed one. The
code that boots the board would then also flash it.

Hence this RFC, before I write the code: would a Firehose server in
U-Boot (a "firehose" command) be welcome
U-Boot community, so that the existing host tools can flash a board with
U-Boot as the programmer?

Why not fastboot: Firehose works on raw storage, not on named
partitions. It addresses any physical partition or UFS LUN by sector,
creates the GPT from scratch (rawprogram/patch XML, sized to the
device), provisions UFS, reads back and verifies with SHA-256, and
selects the boot partition. Qualcomm's build and factory flows already
produce these XML files, so a board flashes the same way from EDL or
from U-Boot.

Two ways in:
1. Recovery, as snagrecover does it: the PBL loads a DDR-init-only XBL
   over Sahara, that XBL loads U-Boot, and U-Boot runs the Firehose "server".
2. From an installed U-Boot, like ums:
     => firehose 0
and then on the host machine:
     $ qdl --storage emmc <devprg image> rawprogram0.xml patch0.xml

The first version covers configure/program/read/erase/patch/
getsha256digest/power over the blk API, with eMMC hardware partitions
as physical partitions. UFS provisioning would come later.

Main concern is XML. Firehose only needs one element per document,
with attributes and no nesting:
  <?xml version="1.0" ?><data><program A="v" ... /></data>
I'd write a small in-place parser for exactly this subset (about 150
lines, input capped at 4 KiB, sandbox tests with malformed input)
instead of importing a library.

Questions:
1. Is a Firehose server acceptable next to ums/fastboot/rockusb?
2. Is a subset parser like this OK, or would you prefer a generic
   one in lib/?


Thank you for your comments

Best regards,
Igor

[1] https://github.com/linux-msm/qdl
