Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633D2CC6B02
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 17:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AF66080D60;
	Mon, 12 Oct 2026 17:37:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CbIejTfISHnH; Mon, 12 Oct 2026 17:37:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 93C2180E0C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791826654;
	b=Oe6DrQFQgC0TC0RU2cx90Z0Lqhp0GfX0itpKIDHbYsHO62vi18NLS/FjKeNq+ItsepOS
	 1bWD135HbF4nFponFY3cyJA+vrUBTDjs7PtRujiU+O8ESSTYGdSBF4Q6UoHTwPXKQl9rq
	 kacDAWfLVI1mroRhG7EFpWKvits4oqYWtoPmVY4ckJ2lbonH8aPLYb4qwPTCUHO54/PEz
	 0A5sS6KxF+LMIbwriZQzo5vj8B7R6JZn5Ek4uJ0m9ONpGqmtODCXY31KIqWmZRJwI9VYS
	 yO+kraove4S+Aki89IM0HXfEI+NJvJaNDeeGzbKlYxLv+ne4kRm+CneR6UJsPlZR02A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791826654;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yveN54QKKOlIfXo3OCNlLgsexRzNt+/0izLm+DLjvK4=;
	b=e+dP4Q7Rt7fht4YujQMtFfvqYO47YONT//lmYoUqMyoaquTvaO1ELQBCXWyJnoruagOF
	 w3CkDu0mUqeh87T+H6pdsTMhs00WyohBnHrFblNcPhvBZV+4WN75dqRg6V61d6w6ETGo7
	 EGcovL67yQB+2vSA4gnBbiVZWuO7AJ5kh79zPKLhExmF7r/7vM8F9aqDr/R5HooV33spD
	 j0l1usXmIXg7m+OrEvyIMP4BRTSBmfHFpk2+SUa9XvTZr2qY1v5GxzpVbDS+k9VYN1ORn
	 0DExZ9Xroy8qdhTGX3MdalnOtegzGC8LQ6ImrrySaPPCHX6QKEFpBQTfmkHERau18wA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791826654;
	bh=yveN54QKKOlIfXo3OCNlLgsexRzNt+/0izLm+DLjvK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GcxEAvGlRln1y2cRnDc6rbazPksXV7sKbT6HaypXARlJR6bE+P68OO2GC7BowgGO8
	 Q0B7oc2w7xekk25oWf8kWqgyAkziGVIsi0YRiEXreXkwEEKVLNKWApyDuuyShhywFZ
	 aCDfWXu0DFT2pakXXqQ6QEpj2uyEoxqmTlCHePE8WbrV6SzMnxczIRssUIbou7nYDE
	 P+h31Du9RAe3aX6QRDwVKDbhoyUoUOgo8qHEHtjoZZfTS5d4UX+Q7MNehcwlnZkbsl
	 zKPG8f6UoIJgR1G+8ap6xf+i7QAQtFZd2VFxnxrduyYXaxmdVhsc5aiJvHzD9JdImV
	 WUtAeC9wj1j/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93C2180E0C;
	Mon, 12 Oct 2026 17:37:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 36F22179
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:39:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1BF0B40577
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:39:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DLCpMNR2ySVT for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 16:39:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 273DD40412
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791823163;
 b=T9xzHNvJTddoEykqsmul70itGM0B8Y3pemwN9Y13m32aijmeyP9xgt6Cgonhia/Im7m+
 fOGS7ipI8+U1mO4AN27sGvnx08QJ9NN/oAdANx2uPOiSAAgVY7zjDMUZ3RlyefHs6Ee8z
 EUUnrbzZzaajxvTBL21gx2mR/B1gOIONF4ozoAjV9NBzkNqEunt6/gUiIJtRYKVawVlxg
 uy7o04iho7RUcU2oYwN5oeEJjPpkwJHqbKZRG63tWcb0YeOmFVH5V0trV1Jw5XdkvZHhl
 erlls9+Lr44Q8XX51uqJ6QguLqNnaR1av7gAr3IWY2TWZUJcXdXsAVvZTDGnWNdM/Tw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791823163;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=yveN54QKKOlIfXo3OCNlLgsexRzNt+/0izLm+DLjvK4=;
 b=OZuXy0Jf+ZOo+mtyUA7hO3t/Kj3FtukOJc9FraUxL6HZGhjOvBYw6UVFe8FTXUbrxcYV
 ST3IYfRc/el9nCepIS2sLASmyy2OOkuk4kg7qNmwety8XVTswcPW8OxrdSL0GGWKkMhnR
 3qIsBsShM5T4kImp1KeHUeyfJT6JfOMebEhQJZtWeSLlgL3weHRJ5v214kW22CQvRyJj9
 v+5PtJP2lovf23bZDD1L1BlEvfrfI/Gq7klYUCidy6S+JUDFmtYyZ1LYjjtLh6Z7ydNi4
 QpSNxoPCiiKYHw4EbsBh/yUFQoE94DeapYCpNS326s/xC/3CLSc9F6OEQGiUKoVucAg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=LXFhIeGi; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gBLI5d0h; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=pavan.kondeti@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=LXFhIeGi; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gBLI5d0h
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 273DD40412
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:39:22 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CFexKZ3163182
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=yveN54QKKOlIfXo3OCNlLgse
 xRzNt+/0izLm+DLjvK4=; b=LXFhIeGiYrKu9pRmaU+csJPcpFLNzAyxUQ+oG87Q
 bxxrZNi2KuzeoMgE+Hu5Rcft5uaz1jFPBSo2srkdhMD1gzS1Bsr4DoIvqZitUEHk
 DHznWRbXAEWdMxUa+ctI0/MklY0gUcfXAm0PoqBimlyMGdyd9tGevuBYq+Weosad
 urAj+l2d/I1r5q1CfsvqLBrRIQ/UNb47QSrFOG/Ueg3QGnNP7hM9An5q+5uBlF7H
 dEJPfoaB49eMJyz3shqd94NYyP41mrdEc1N4CdVRKKStdsfWn6vAhIxJhHHv/haj
 3/IfGL/85Tusbr4ok5uGsN239mT8Qz597mIIowKkjVnHyA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sd1tyv9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 16:39:21 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so2219252eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 09:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791823160; x=1792427960;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yveN54QKKOlIfXo3OCNlLgsexRzNt+/0izLm+DLjvK4=;
 b=gBLI5d0hdrpUZGOk5UDzmeNGk90jeyvCMofOT6NV8F2fJpGUMvWuPnue90roSAl3GJ
 ReY7g/qT8E/1Bvq6zguNNvyXNbZUv+g4l7MthTLUJZBt6TqhWgWEVtJUQYv/jtypZx+Y
 4YWz0ZJQfxxh3AP9abHoopeKv/S00r0ZKsS0I524V4ODaovSkDFnG/NI+tWpSNSR3WNj
 yxeTsVDG1ReRUF+RNlt0GNBpWwaSEPSWuE8V+q7WEtclJg3xnQCd/28PPCVCGcQGbOTe
 qUxW2lMk6rUR0aPF7YXfEfs+9Me0aje2NCP1iMmkPFgS8wVUKRglwBd0LhAqBt4gw7oE
 c3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791823160; x=1792427960;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yveN54QKKOlIfXo3OCNlLgsexRzNt+/0izLm+DLjvK4=;
 b=ZfvXq1tgYN2JZzctjbBccUlw4OS4rPQou7cwxmPpvjDCmH0lWRxsmZ17+0LBfgi2sL
 CP9wFcrkzs9KIrmQAwsaDSMkcyKhBJRnuT1ycce1dGauSEwacdLudlawE4aT5+3uEEU3
 hgQ2ehdJJowYppQsGuqDjxFusdhZQd3gTy7BCOO5U52eHpxNAMqgPhkkl5aXCKw1n9/9
 Mq/C5SisYPNvQheglM0wko2Tw97M6soBKRUPTNRZqwasV49J/z9yF/ML3S6gt3baJfkL
 JYQC1y1qdNQ5vGcOGWlcJ5mfNmhpY61al03Knn+kCuUUiElxs2T0eH6hSjmMyLPLbbpI
 aJBA==
X-Forwarded-Encrypted: i=1;
 AKwUvBypzDF0LoAUxBF3I12S9uw3TAJNiRhH0sp9B6aD96+AMU6+OVxsFITjUSM6u/xzXYdvHSzWDRo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJoa7Dafqs+Z9RC5mwqooKmHINWcReMFQ1RA7qvwjNIWbxJZjCE
 h2Uyld7sYt6frnXlzQLyU3/7M+hb0KLAoFWqsIGIOorlNqqay3/8SHi9Tqid/iVo2ZS8h8qBGxV
 8uDLTkqNkaPyA+Mx9WgeZ6js6nEdcrtaon4jLkUCUwxczYLBong2akhU4FPaUvOvPK/TTV28cP9
 e/O14=
X-Gm-Gg: AYBFou2XIoMWfdkMNeDJ+IbHUasXcqAC9j3HnwaF05H7qgMDfhb1kXbrUMKaewDZ0KN
 M5XpdyxKm0hiGfI9oetK2RJT25mv6GH1J5DM4RstpmH+Yl0rz/4TM7UtHX14IuBu062qmCrxXXG
 oxFlqnFSrvGucKcctC2H68MMuIzYiTGt4VIBm4FuTdSM6BaBlWYKRwQ4AwAviavCdUhbF3ozbIi
 Af9+gYYVh8ChwjgYs2tvP4JH9aGOxJi2MBuTxl0ni1shGYGrgkvY6Y0zRLii2op5SQMO0sBhJWg
 c8xBuGQmBcEpFAKWKwnnK8wU63EqUfmKT2zQE8MHqp1sZz7u0GDzBFjCGk9J8Kb9rioE3PFfTOw
 oaVzlwYEeu9PkcXDr2murgUoHZKYVg5NS
X-Received: by 2002:a05:7301:6e98:b0:353:599e:4f8f with SMTP id
 5a478bee46e88-3537e013215mr15406428eec.29.1791823159971; 
 Mon, 12 Oct 2026 09:39:19 -0700 (PDT)
X-Received: by 2002:a05:7301:6e98:b0:353:599e:4f8f with SMTP id
 5a478bee46e88-3537e013215mr15406392eec.29.1791823159322; 
 Mon, 12 Oct 2026 09:39:19 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cacb61asm37114529eec.21.2026.10.12.09.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 09:39:19 -0700 (PDT)
Date: Mon, 12 Oct 2026 22:09:13 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
Cc: Tyler Baker <tyler.baker@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 3/4] board: qualcomm: add Arduino VENTUNO Q support
Message-ID: <d20bc0fb-ee72-490d-a6f0-d79c566a9881@quicinc.com>
References: <20260928-monaco-ventuno-q-v2-0-0e046c8242be@oss.qualcomm.com>
 <20260928-monaco-ventuno-q-v2-3-0e046c8242be@oss.qualcomm.com>
 <3f4648b3-ccee-466b-b209-fb429aaee803@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f4648b3-ccee-466b-b209-fb429aaee803@quicinc.com>
X-Proofpoint-ORIG-GUID: lseAqv5NEkih9-sdxb73RvB1ojOrWSlE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX6FMCi649Nii5
 QP77kcUfa+CvW0SLVgZFFqmYsWQqfT1MAbZGN1B5+D6pRozuOqtCNub+LBzKPblVFazw2mC08mm
 A0vxug6kTfk/atkSuWHaGJP6nKFiHBg=
X-Authority-Analysis: v=2.4 cv=QtHLTlyd c=1 sm=1 tr=0 ts=6acd0d39 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=aYJjxoplV0FXhZmbNCQA:9 a=CjuIK1q_8ugA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: lseAqv5NEkih9-sdxb73RvB1ojOrWSlE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfXwoCBpMy6JOl7
 LvvYND5abnSO7HD4ekWImKELfZUp2fXi9Dpf00ZZji1hYdwVvNNL9f46F2NeTHDa7WeL4f20hme
 Y/BHyqbeUddHpXqBGs/RTPb2JkBhsP/XazRRaG6ukYclhmh+99lSZgfPKDsjgyvjlmOQrXv2U3l
 W/Js+ouYWeFYZs/9O1MgGK1E2YPoulegRqnekYwpuKEkt/kCqlPmBzkU8kxpznenu2A2G5YrZoS
 E5MBViN3g8MAEBYcxT6yeFCofe8s+t7ipsXHWUYTdkjVd89mZvpzjoby14oJt5OChKztCtZ4LSs
 KoOxzke/I5blxFSRXwThE9XHR6p8VwvKpwVljQpOlNkTwy7IBj9nfqBZBVat4cD+JqlJMXXXbpf
 x9UTZycHtP4WrHg5O27OsiCOb13/6fUg2cYrRcu2HCYvqrUmqj7Q3yu28441Ttxa26RSuINKeqn
 GqfhgWYfepmn6bceUKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120066
X-Mailman-Approved-At: Mon, 12 Oct 2026 17:37:26 +0000
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

On Mon, Oct 12, 2026 at 09:45:41PM +0530, Pavan Kondeti wrote:
> On Mon, Sep 28, 2026 at 02:06:53PM -0400, Tyler Baker wrote:
> > Add a configuration fragment and memory map for the Arduino VENTUNO Q
> > (QCS8275), running U-Boot after TF-A and OP-TEE.
> > 
> > Boot on a Cortex-A55 and exclude memory reserved by the boot firmware
> > from the RAM map.
> > 
> > Assisted-by: Claude:claude-opus-5-5
> > Signed-off-by: Tyler Baker <tyler.baker@oss.qualcomm.com>
> > ---
> > Changes in v2:
> > - Renamed from "board: qualcomm: add Arduino VENTUNO Q config fragment".
> > - Reworded the commit message and comments.
> > ---
> >  arch/arm/dts/monaco-arduino-monza-u-boot.dtsi | 26 ++++++++++++++++++++++++++
> >  board/qualcomm/arduino-ventuno-q.config       |  5 +++++
> >  2 files changed, 31 insertions(+)
> > 
> > diff --git a/arch/arm/dts/monaco-arduino-monza-u-boot.dtsi b/arch/arm/dts/monaco-arduino-monza-u-boot.dtsi
> > new file mode 100644
> > index 0000000000..e6ba8ba486
> > --- /dev/null
> > +++ b/arch/arm/dts/monaco-arduino-monza-u-boot.dtsi
> > @@ -0,0 +1,26 @@
> > +// SPDX-License-Identifier: BSD-3-Clause
> > +/*
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + */
> > +
> > +/ {
> > +	/*
> > +	 * Boot firmware regions left out:
> > +	 *   0x80000000  SAIL
> > +	 *   0x908c0000  DDR training
> > +	 *   0x90c00000  SAIL mailbox and OTA
> > +	 *   0xd0100000  TZ carveouts and DBI dump
> > +	 *   0xdb100000  TZ statistics
> > +	 *   0xdb200000  CPUCP
> > +	 */
> > +	memory@80000000 {
> > +		device_type = "memory";
> > +		reg = <0x0 0x90000000 0x0 0x008c0000>,
> > +		      <0x0 0x908c1000 0x0 0x0033f000>,
> > +		      <0x0 0x91100000 0x0 0x3f000000>,
> > +		      <0x0 0xd4400000 0x0 0x06d00000>,
> > +		      <0x0 0xdb300000 0x0 0x24d00000>,
> > +		      <0xa 0x00000000 0x2 0x00000000>,
> > +		      <0xe 0x00000000 0x1 0x80000000>;
> > +	};
> > +};
> > diff --git a/board/qualcomm/arduino-ventuno-q.config b/board/qualcomm/arduino-ventuno-q.config
> > new file mode 100644
> > index 0000000000..a8041cbe9d
> > --- /dev/null
> > +++ b/board/qualcomm/arduino-ventuno-q.config
> > @@ -0,0 +1,5 @@
> > +# Arduino VENTUNO Q; use with qcom_defconfig and tfa-optee.config.
> > +CONFIG_DEFAULT_DEVICE_TREE="qcom/monaco-arduino-monza"
> > +CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
> > +CONFIG_BOOT0_QCOM_BOOT_CPU=y
> > +CONFIG_QCOM_BOOT_CPU_MPIDR=0x10000
> > 
> 
> IIUC, Linux makes CPU with MPIDR ~= 0x10000 as CPU#0. This is
> conflicting with the `reg` mentioned at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/monaco.dtsi#n53
> 
> Do we see any issues with that? Also, what would be CPU#1 in Linux?
> of_parse_and_init_cpus() indicates that CPUs are enumerated in the order
> mentioned at cpus { } which means physical CPU#0 becomes logical CPU#1.
> 
> One immediate side effect of this is that `capacity-dmips-mhz` value
> will go wrong which can result in suboptimal scheduler / cpufreq
> decisions.
> 
Looked at Linux Kernel arch/arm64/kernel/topology.c closely, I don't
see `capacity-dmips-mhz` values getting messed up since
of_get_cpu_node() uses arch_match_cpu_phys_id().  Sorry about the
incorrect note in my previous email.

Thanks,
Pavan
