Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10CACCF2E3
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 12:09:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8CCD405BF;
	Mon, 19 Oct 2026 12:09:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lCuf3Z_1COJe; Mon, 19 Oct 2026 12:09:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CD874405AD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792411746;
	b=NSVX9Fzjrj1YmY7ck3DzolpAx72n3Tvl+Lcs17Jj1hfzJQbmPR4eNTCPfaa0BLfZhcC3
	 DsOXUiXO3spheICUUbfwBwfsNyKGhIndoD5ugFCI74xl/QPZxDDxR/HehZYAElhU1ztD6
	 MbWL8AfHgyQk2wutsKb0VwJyysn1HJfuyhKqisS0sXMJO9f5U4hzzHg0kiIBJpF3yvVZm
	 ki3xzdRAPODyjmfTs76OKIC6fa5gzTQ6++fUaVorV0gtqkFHIVZ8jjTCU/pZVBQztr8WD
	 trm2M+uRBLziDeZQmfoyoupHWIWEXV7fV9Jn89IQ/BJW07XRym7wlYw7v7+xo7EmJnA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792411746;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qAu3dkJWgt/Qw4qsAjFbLGIwH+4NRP3Cn7LAUvfz4WY=;
	b=JW8Fb2hmFxS8mYDVF9JEOYYwJH3BGzgiEobqTTvyQkbKQeCw72OQQnLVdw3FUhjFd8sL
	 sjeYbdZnldhWGv69ifVWqiU693aqgbMVzEQHAB5/xzoLCrWSnNnMW6/F6MfiGboH+5vxj
	 FQKxgOnufh6TQgM1kAqPAhfFikHv7LBtz251u7OqdYgMdSXFH38LW1Veq+zpVR4VAcOtc
	 2dpDQXcYlX9UsS6n412otYiG8tFBIe8mPBSJALXXvRHNfo2trgacABgr3XOuVPuSXLAxt
	 KB9aYMsZeFurreWMS+eU1P1dpiBtraelT9yfEQK+mElNemTgKXyz3GtcJzSFQ1ZtEbw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792411745;
	bh=qAu3dkJWgt/Qw4qsAjFbLGIwH+4NRP3Cn7LAUvfz4WY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zioEmPXHSv0oBv6XS3ct5uwTqnWfJwNPOz+vt7eC2ZYNUuABPvW6Jc+L5M+NZX6jh
	 1qtjd26aqjFYgwmrkJVUr7RdTNYw3WS3GZYJ0GC/TUZcPEfsdA7ZKoEKUS7rOmGyFf
	 Rfocgps+jjt+zahRQXmIqS+DBbyQoDalSiqXXRd464iFXyFs4oDAVNkuAM4Ibs/ZPK
	 H5paCK4ryv3ZAXig93rdK+jnRmSYRspgwIv0bAy+ykL9BMt8Rihj5QR7aOv8mGExh0
	 1I/51Zj+4qAEwePxj/lQuNqCIIGHwlb0HdCdhx49VlDHPoLVIolPHb7iQOhQxTnQFr
	 e/3fquWhWrvKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD874405AD;
	Mon, 19 Oct 2026 12:09:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 246361DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:09:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1636640080
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:09:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dqjmK43oLppZ for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 12:09:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 4CEB240079
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792411744;
 b=lWAJqmfqTfxskfobfFHd9/WWmT7RQ1kqn7eGvN78Z/H25oSdYHz7gmj3arXAiNfHu1PP
 kRS1puJ+SJNoEUnQqv2WEznnFtyUFfutkBPRVdTvtnQ0VB2NaunaUJdN3rir1pxlPWoab
 LCB7mv40WTLftSGL6w4EGukvxcNmmYm3GeFt44G3x7/Td/hA47ceDkRzZXCspBiynUdrx
 wWZ9Yu2dnG1lnnAZsokGMUuZcRXqEjjcwv/rCR9NWMlNTtKXi1SeCqgpqwofMpqm5hoDL
 /Iy3V4oTAqh2XJ/IwaouPQZ+rTuYyYOMDNDT2Hnr7qPopEUp/LotXztFlJeO9dMirTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792411744;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=qAu3dkJWgt/Qw4qsAjFbLGIwH+4NRP3Cn7LAUvfz4WY=;
 b=TUmMYXs8BB4FJ/snhj1ivU+yMg8521ZrqBF8k1rGOkaAoIK5v74hhddd6I0jchjqhXui
 drNqN/mdLCPh1WnLAxbvsGjyWqGX5rFbrGbd9tdRR1k30DxJ780IB64FIkmwtUhMIHeUI
 oOV2I/f420A8Mh43SyaY/MIL80O90Z/om/3vI1DA4jEGa1sVbihv1qi49qpQB4Gf3rSuZ
 okpC9fQGLiAXmKLX5E4xsRZczJpfkRassN3p0LcbPr8X6LAX9MQpSBOQxiym0UB0VxBzp
 poPIYeGHrCo8UtUs+CwOC3FTmUGLzbGvVXqanVCbK4XDAC5c6E5mm7kDvd3htgsFHYw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=maXaF+Mk; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fPi0xLjz; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=maXaF+Mk; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fPi0xLjz
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4CEB240079
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:09:03 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8P3ZQ2753831
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qAu3dkJWgt/Qw4qsAjFbLGIwH+4NRP3Cn7LAUvfz4WY=; b=maXaF+MkW5uIqdvD
 q2M2ma+O1rO8TbUyxKb7miuytL4sElPXe5IQoth0Lrvvg+guah8yw3h1QPNrusgP
 06Vxa59d0MGD8PftdGXrTFVdmleT72KanYN51oZaxXCnAdROnhuaAozFLnJxeHn9
 8ILyr6Pe+N3bnIzFZimp0CSjzW6MOt+5rtIP/KgfDyIngQcmpbvJGOb6fdk0qxMv
 0A78sk7gip3Cwdzc0OzWVyr98DR/T5dfE66HLI28gFdymoM87ATQ/lo+ckvDfUuU
 z096oCoZoB7qQQjv8b0xjc7rP2yFQrsCtk++dC4mIj/ccboSJ+kfQt9ZasLi42q4
 60aIpA==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf48gy0s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:09:02 +0000 (GMT)
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-67694007c9cso3247888d50.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 05:09:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792411742; cv=none;
 d=google.com; s=arc-20260327;
 b=qgWcduBaRmtGhZCisFBVwUEQxrHdBWIzkwqLqR9sjwXVzqW6YeulhisfT+n606lxRz
 khmvpcc/QH4gt23Dy8VfYIHiV/CGN13/e13joEVgvMruaX0ox0/Y0Ox3UoFa15beII1G
 eGUGweF98qg98gKmjqfC5Cwe+vtSAdoxLOjwJ/hjtv4UB5k8uIlF4UR6FRPeWMOKDYpI
 JqkKhNaaLt0M2pgD9ilzqZ9WFEobvmN3H5MMB1k4+Kuc99huFMHsIM5uWA6ZPekzLfpB
 mXSY7uPiuS6P8ODLHzzz6vENVZgBowBFlBdCy9V9N1EeKbCK7Nmg18+SB8lBVokaKIPU
 vtTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qAu3dkJWgt/Qw4qsAjFbLGIwH+4NRP3Cn7LAUvfz4WY=;
 fh=i9/SgGtsL1YneY+55J2+fNQ/znD8XWYmIK8YAy42Jj4=;
 b=CZBqDDjC6RQKrSG/gpt3k+lrAhQ1EzV0EQ9REBvtf1T043LrxsyzNJ0RPWIINPqUf2
 wzTwJBqKjNZDlRH6qJzhuR4tGFb1Cd20TeDqCp5/kK3HV6aNxpECM4905PiwK+OFcvWD
 TvjBQGy0fKeVzakP4pra8RLjYiANmCAAGWg6XFUpBMadWNQn519GWUuz3Mx3Xiic3Ogh
 G0vFPS9wFARzYTvN6d9N2b9mrw5vUWJg1NjP0tY1CqOMNtpp+pTT/664ALmP+MlGtDOw
 nMepk6HrwJrJCWGCRkrLXnYqBesYqsNZOMIk/ih8kSXzkd1VHufU+CQ0fDWpehIZenW1
 P+pg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792411742; x=1793016542;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qAu3dkJWgt/Qw4qsAjFbLGIwH+4NRP3Cn7LAUvfz4WY=;
 b=fPi0xLjzC4gCNCWMB2uy3KHV5SCqfVKrUfE2nmo33V1pkXKlBlE0tB8H75jcEuI7F/
 lgIikeLzVBk4LcBO3oQkGh4OLwiX43wa/vZjHYNzCUPG6UmExgW2CvrQh2gZWa13V+Hk
 1t7lpdUmUVH56bFLTwsyo+0m5JNYfNEo4/OweNXCxntmf0ILqnz4cVd05H2rLhr3SqDa
 58prxUh16jdSCruRc76QZQ/bCzruB+3NfWxflqNkZ6Yt3F9Ik7IHUgryrCIPfBuDf/4L
 Fg/6I2k4z1eRuo73X3o/k+Itlg6MCGjUlhVnFW3c1KD6qqF5rAje21G3Qff49ZNXMrUb
 R6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792411742; x=1793016542;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qAu3dkJWgt/Qw4qsAjFbLGIwH+4NRP3Cn7LAUvfz4WY=;
 b=HRpndMmSI/+PccXRbwSFCgHk95ITx6vFaKopDD+96EDYKLK1+ZwwdpppLPHGCrAJ8V
 mgIBzLsOhmv7BVhsaKhD+d2r8EHmZ3deU3mhjKKL+P5ZVry99d/k5uD4dlHc3rffStCg
 WoXRUqk7oDgS7Obwl3ruK9YOb0RjxriHAP2QEtyyNqtQ69gE7/OrDefc4hTa4mGCgdS4
 6eNv3RU9rfkH2/yenx1EClVQgXl8HhFBpYbL4XVkmpW2Yab/12+T2MVXO3Fb3FSLmDF/
 aPNsqQKshJeLb/GHPTVQmmaPfiHeslJdnEL1WKqcP221uc7sDVIonou/94LY8rQSbpO4
 ++6w==
X-Gm-Message-State: AFq9FYILNT7LNNwCp1lQ2O9yHvSNcQLCqydQdelA7JehTlnkwhQ6Pdf8
 yGEveQ6uaP6DTFHyXuNikBvq9KYXa0QBzwznmhPRgzuXyKLr5o+ocshVjiUvWxNhmTbuLhL53Za
 +QOvUWTXLCOUVEwznCWFhxNJTJIvozAfkOEq6uHGiiTzPTeM4ZkK2ev+oG4PYU7skGbiRzhtXJU
 GAYdng3KER8eoRLjO5u5It8xfS+GtGWCETADA9zcZz2OZ06g==
X-Gm-Gg: AYBFou0zWte4qNVclr3NUpAk3mrA1xG/99ja9l9keLLwa4KP2vCij1glsKjSV3U1RI/
 unJWGc+5sYWSt3diA88ucYGsdBWeoLKHAVEtOS7ZGV9CMD51gXlxCGTskTZtNjkOUTiv51Wkq7D
 jNyMZU0sinVW8zi+6ojb6i7ZjFG/Upxy3geca0dyZF+dTMpjr5IJs+Ldu27w==
X-Received: by 2002:a05:690e:1504:b0:679:b744:a317 with SMTP id
 956f58d0204a3-679ca82fa90mr2402797d50.57.1792411742045; 
 Mon, 19 Oct 2026 05:09:02 -0700 (PDT)
X-Received: by 2002:a05:690e:1504:b0:679:b744:a317 with SMTP id
 956f58d0204a3-679ca82fa90mr2402792d50.57.1792411741616; Mon, 19 Oct 2026
 05:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20261012-upstream-optee_rpmb_b4-v2-0-85d76a54273b@oss.qualcomm.com>
 <20261012-upstream-optee_rpmb_b4-v2-1-85d76a54273b@oss.qualcomm.com>
 <CAC_iWjLeSNEAdVoSg2GSYeupH8daBUwT-oVATjGv0W0H0yri1g@mail.gmail.com>
In-Reply-To: <CAC_iWjLeSNEAdVoSg2GSYeupH8daBUwT-oVATjGv0W0H0yri1g@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:08:49 +0200
X-Gm-Features: AclHuK-Tc8BAMVX-6qvBnIj-Ws3uuDjHzgZyakHn6g1Q8cfXvmOIBfSQ9seeLgM
Message-ID: <CAPzfCAaht7DeOnVGKfdnz+=YR1-7X_t+yz7XkniFMuzcjuVZbg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] optee: rpmb: select the RPMB partition per request
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Jens Wiklander <jenswi@kernel.org>,
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfXwppc5HdWv6O7
 //6dEj+6Ud2vPF3kw2F9Fe6XDwB72BDgq3tmxx1nenromtZcadhjbVv5S6aOqLXfY/ceptPILBW
 0C+rs+G7XGWwheINLhAROWMJD6T4vO0WMMBFcqR4xT3Qr505twpBTXuIi5525LQ1ifKyxrz0aCc
 Wee73SEQk53BdUyTpWJ3EwLlaFTwIR5kYve4E8nOjVWY2qY7u2rcWtQsYgNCOgaAtg6Q3lS3iSB
 nFy15iGsOu5f0tiCNwsiB1FEEQW0KW8UOf/XxTu8JsFoHwXYm9fi19D9OTD7yBLWhd4Y7c1aKk6
 cwP9qG4HCoaawA4g/GV2Rjqa3GVTKmGH/IfRjiZP/BYNHp3b+M1bJMTsWK4VyxqRL6yw1HmaC8j
 5CiRdX7hn6YB1Cq0/FPt+WRfxxmXTwBOPoPw+/j1W4MyHj7YhJ4AHf/ldtEJ0+oc0cxr8GWlm6e
 26JO1Yp7fJfVLRB6Nzw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0OCBTYWx0ZWRfX6XEIu89cuvW+
 QaLxlntCFTMF/Cg7AZzwEND1EhaTq5HelsegYVRsJkf6Ruk0v5J2TzFt1yO0UJmnOyFLsGOW+Vk
 aIaagOPQIfkbo/AZFFX+rVck6ZqDHgE=
X-Proofpoint-ORIG-GUID: dZ2hw2iX2JU6q7-wAwDk7qtocFLG89x8
X-Authority-Analysis: v=2.4 cv=Qr/LTlyd c=1 sm=1 tr=0 ts=6ad6085e cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=mkAz5_Mpa9ljycyXiBcA:9 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: dZ2hw2iX2JU6q7-wAwDk7qtocFLG89x8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190048
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

HI Ilias,

On Mon, Oct 19, 2026 at 10:35=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Igor,
>
> On Mon, 12 Oct 2026 at 22:56, Igor Opaniuk
> <igor.opaniuk@oss.qualcomm.com> wrote:
> >
> > The supplicant switched the eMMC to the RPMB hardware partition when th=
e
> > device was first used and only switched back when the OP-TEE session wa=
s
> > released. Between two RPMB requests other users of the same device swit=
ch
> > it back to the user area: libavb does so for every partition read while
> > verifying a chain, and the Android bootmeth reads boot/vendor_boot righ=
t
> > after verification.
> >
> > With RPMB left selected those reads hit the RPMB partition, and the nex=
t
> > RPMB frames were routed to whatever partition the other user left
> > selected, which ends in status timeouts and I/O errors (seen with
> > the AVB TA on QEMU's emulated eMMC).
> >
> > Select the RPMB partition around every data request and restore the
> > previously selected partition afterwards.
>
> Overall this seems correct, a few comments below.
>
> [...]
>
> > +/*
> > + * The RPMB hardware partition is selected for the duration of a singl=
e
> > + * request only. Between two requests other users of the same eMMC, fo=
r
> > + * instance libavb reading the user area while verifying a chain of
> > + * partitions, switch the device back to the user area. Keeping RPMB
> > + * selected across requests would make those reads, and the following =
RPMB
> > + * frames, hit the wrong partition.
> > + */
> > +static int select_rpmb_part(struct optee_private *priv)
> > +{
> > +       int rc;
> > +
> > +       priv->rpmb_original_part =3D mmc_get_blk_desc(priv->rpmb_mmc)->=
hwpart;
> > +       rc =3D blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
> > +                                     MMC_PART_RPMB);
> > +       if (rc)
> > +               debug("Device id %d: cannot select RPMB partition: %d\n=
",
> > +                     priv->rpmb_dev_id, rc);
> > +
> > +       return rc;
> > +}
> > +
> > +static void restore_part(struct optee_private *priv)
> > +{
> > +       int rc;
> > +
> > +       rc =3D blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
> > +                                     priv->rpmb_original_part);
> > +       if (rc)
> > +               debug("%s: blk_select_hwpart_devnum() failed: %d\n",
> > +                     __func__, rc);
> > +}
> > +
> >  static u32 rpmb_get_dev_info(u16 dev_id, struct rpmb_dev_info *info)
> >  {
> >         struct mmc *mmc =3D find_mmc_device(dev_id);
> > @@ -130,6 +146,7 @@ static u32 rpmb_process_request(struct optee_privat=
e *priv, void *req,
> >  {
> >         struct rpmb_req *sreq =3D req;
> >         struct mmc *mmc;
> > +       int rc;
> >
> >         if (req_size < sizeof(*sreq))
> >                 return TEE_ERROR_BAD_PARAMETERS;
> > @@ -139,9 +156,13 @@ static u32 rpmb_process_request(struct optee_priva=
te *priv, void *req,
> >                 mmc =3D get_mmc(priv, sreq->dev_id);
>
> get_mmc already selects rpmb_original_part, which we now always overwrite=
.
>
> Cant we fold in select_rpmb_part() into get_mmc?

Right, that assignment in get_mmc() is a leftover from when it also
switched to RPMB;

Folded the fix in for v3


>
> >                 if (!mmc)
> >                         return TEE_ERROR_ITEM_NOT_FOUND;
> > -               if (mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
> > -                                         req_size - sizeof(struct rpmb=
_req),
> > -                                         rsp, rsp_size))
> > +               if (select_rpmb_part(priv))
> > +                       return TEE_ERROR_ITEM_NOT_FOUND;
> > +               rc =3D mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
> > +                                          req_size - sizeof(struct rpm=
b_req),
> > +                                          rsp, rsp_size);
> > +               restore_part(priv);
> > +               if (rc)
> >                         return TEE_ERROR_BAD_PARAMETERS;
> >                 return TEE_SUCCESS;
> >
> >
> > --
> > 2.53.0
> >
>
> Thanks
> /Ilias
