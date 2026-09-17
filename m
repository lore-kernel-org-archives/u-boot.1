Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D843EC982C1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:47:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 997476081D;
	Thu, 17 Sep 2026 07:47:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uh_A8z2ZaqJp; Thu, 17 Sep 2026 07:47:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9A39D60629
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789631231;
	b=N03/4V3MgFC4tXcaMRh+HBufmYzx2j9lNyxPrHnnT6xmzivKQOIJijFNHx7kkABn72cR
	 Wh7Iwhg227Ii2zDa0i7Jnl4FAj+e43CUWShApJrGpF/5CuEOolcqaOK610w7lGwVUl5zd
	 IldFYXop2M0/2nR0rC2ZrJUWoaJ7rqmXpQonmgaJ2J1v40pr8k2lYAyOAUQQy9hsR+k6M
	 IqDM8qp/D+LXC8eYbuu0FDqz8li8RhA+zSHZpd7t+TlkAvA9Kjy0hMxih1cWmP7bo6BmB
	 RXAP1o161xZYhchZg/aX/UB9PcY+y//HOSO2UGtSumQMOScKigrmr4cNA+Ylk8fA3oQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789631231;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=EmyOfR80BmeT2Yo0pK+tnM5+C+T6fw8+9BS3mEpckZE=;
	b=ZoTZKtAyvXWulsW4yszsg2s4Wrva4RKjkRCKfMPdpRf9l9Y7wA05iFEGRkMynBCjzwr1
	 g9KQgQwlzCd8o9AwoRTtuCqgcL2p8Qp21hidFx62KPNp2IYje6CYIyjLfL+YOpEwiwNs+
	 lsfv7FptMOsL34K1pkZhYV3k2SMXYg3SrgDhPE1ErD5/Axc7hD8ILNI/0T8RkkJxaQlje
	 WxBv0xtLT9W8RCuQaG6GZF3kwuYpN5T8aLqTwbI/SQhwQq5zPZpuEoN8bV9Wo/pusQzu/
	 Xqo6+8z7+LV/ODM1/ooFbza6xIir8S9b8lu6yTNk2Mr9txBhbnpXVq8dEacZIrjmFPw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789631231;
	bh=EmyOfR80BmeT2Yo0pK+tnM5+C+T6fw8+9BS3mEpckZE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uFHhRA+2zMiJja5VKMjDCuBKq8st/WaqCcKtkB8QsosqAqDWYcLdG+sCmmrczbbcl
	 Z7zItI1dJWcV/XU7oSXSfhN9wY7Fc321mpDbR+t+LZ1GIpIWydiYvTErItZsR2xzBY
	 /9gkbqVurmNt/ImSzeI6JaIvCzIecpK8OolH5Xv3imuL4Lj3GNgSqe27ngiBoooZdo
	 QzdUMSClZmS1gtP2UbrUEsh/RUPKCfxaMCCiTj2QK7J1Sj6tKfUN2Num4XEfLXvtRf
	 yMQhC7eUbpGCj7ABlYe7BGyK4A6i4Nur2pIlYYSW8TkZj1nWPfglcL7v6LRe6W0CJ6
	 wYXIPlPvzYP8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9A39D60629;
	Thu, 17 Sep 2026 07:47:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4418924D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2A3B7400F3
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EuCEIhSNcNu9 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:47:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3325D400F6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789631228;
 b=WUQI7W/tbUNXqhSdGvOx5eTweDK9lwp8ANhhek8Ts5rxeBm7NLSSe2IH0U2nFSVeOhf6
 5er3DshoCHrK4JRjMI7ZyMeReOZjBqNMpcH1AeO0NrtmFAMZVECGvs68dUuibl6DY9YT6
 v/cjJ3rLGQp9mtpFZ2/Xyqvk1CoUm1s+H1D9lLEGJFajZ09ztJyvZsmlhBTN1DAuFMWkT
 nQD6+xKJX6aklKfzrb23B6AjI35eLdPB5bcleRGb6sbOjzT06un6rNIILsHty0aDHdg4+
 XthNz+KcyqlkltGJSeHawAWqMAycLjj1QqSK0g3hHL4Mdkv2l2uRcYam49a26wl3C1g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789631228;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=EmyOfR80BmeT2Yo0pK+tnM5+C+T6fw8+9BS3mEpckZE=;
 b=rRCwMS8oiun56Zlbh2T/Ncn34kKYfkv5BxknQyIKBed+NmInoPXlTsMnOTXkCDY2L6vM
 AeUyk2YG50aslJw8pICZGdtZy4452Q/7ZgUB8fV0H8j/B24UeED24MCsr2YkfJK9+1cDc
 VIlXAL3hq8bVW0wRw8/k5jwL9GNcUX0pfWOp3dwBIou2MPV9hWpSLOkkQuVejpBKMU/PD
 wDOtPxp1PbS5AxY+nqkkfYs3PvWnqZYdy/nPbuRO+yl2CaJSOr6Q4RXuoC2K7fAdbkxo5
 SQbuDDDJqFxoh2EBaBx6Ba2dG+yZ4J6GKayJAIvWA0ywZ21b8n/67Z48tXZkwfFjwIQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=fFGvFsta; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DxIbU7qA; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=fFGvFsta; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DxIbU7qA
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3325D400F6
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:07 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H61Cxk267292
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EmyOfR80BmeT2Yo0pK+tnM5+C+T6fw8+9BS3mEpckZE=; b=fFGvFstaCsQHwMcq
 wBs4AlQ3Anafwo8/D83pyH6qYNgqdKKtd3uMvsHl7c1bqr0Xkc3cMVimkD6ebgmj
 pZCiFANVKE7omvqlYzyJq4MG1glQMpZpPNr1Qts3Hk9dsCZ/OZwPIGfZQP13KWc8
 ffP2yvajUeGmz9SfgQHxzPbraPktTikFQJxBDVaMjiGaEfNNBjTgbwqWb21nl6yJ
 Zqst9hH6OmHBzg7yDX9nd9fTzBfLG3DtW5YVgQTHyc5HGPkwMaePXrp3CKqIslWi
 lsj4IrF6q5g1VHtGzNXJt4job4Wca34P4qp/1DxZnOnluXBZa0UEukicQ+UMKg8c
 Mg4H8Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gquwb47bm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:07 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3968bb86fb7so719622a91.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789631227; x=1790236027;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EmyOfR80BmeT2Yo0pK+tnM5+C+T6fw8+9BS3mEpckZE=;
 b=DxIbU7qAzvrFf6h9IfZknblxxImz/6zGKKdJPML/QNrsDdHO1c4Wc6xrxPrRzZQjpJ
 YMf6y+mpiU/rF3oWg4Wd8J2cLhcn3+S/rneguxPrpMDog+V6hpaWx5qnEZcl0bRCHjXM
 8ePLOkQ8rb7XKKII3UI8p5/XTAGZKSqBJ/k2eYhGzc9iOz5v/Yoc1S6H8TqVPVW0wGvK
 qdYkUBghxDZeMzCvZ0ds+chJjMd0VYnwwa7vcouteyj3NcY3jl4XzR43RJRxjEAJ7vuF
 drLPNeedJ4yz6j/cbldDCyPvuySbdA+/Y+nUGXXgKgngjvQif/kjqB4s5tqAzwJ3o35g
 W1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631227; x=1790236027;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EmyOfR80BmeT2Yo0pK+tnM5+C+T6fw8+9BS3mEpckZE=;
 b=WBJgTfXJzkmCxfLCgbS/3QOH19iQwJWGpKShI9z+ibsEWIllwC6+9YH6oznb39PxcM
 O6/Jc833bNAIR5OWpNlhEWmyytlVnjubWCs1vuU7Ul+JZe0hLQvlTe64rGmNYqqUKJaP
 x3bT6Lp9u9IvS33Z8YepVbdKIVoga9f+tqj+g1zYY6QwPJdI7C4eG/RhrQtbBFoeZ7E9
 CHX0CXDdC4UyWMIGbBIrKdNKPn/TkC4W/SCwdGs6wwlSycVFshegbCtFecXteEYtkJs4
 gY0Rm6aI67U2JRwU97fGnlniiNDMQohaRteiN0/0Z5b2Ex+ljmk1p/w4A8OxiDnYm860
 CJkw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwd/Bc/DsjUi2KtnLo919PN8Un6S9frK1vD968vcvyN11OqUfXGRxXKNIfDMAjjq7SPtgGVGHA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nV2NOanVGvtLP5rhicdjbnTYHfYgi7Av66pStCjxBgt8iTBKlg
 8ykEzVNgbNZGK0zKAlHi1B9GS8ioqk5HRlXjOqXeXyFPeraSZ5GF27dwIa66lBIx9MQCvs8LaOr
 ScLibXYot8rT/YK9YQ4wPClVrS+vYZPRem8D0yDX1eUHb/bTVcMjWYS9LASpMHOve0eomIJY=
X-Gm-Gg: AYBFou0xS14j/UuNhPkOJ2nFmqPGymqT8tcbVQ4bdFRBK4FX6p0FpVBlyQs02MD3mDr
 fTZ/SLH9ydGq3ViDnqa5BzY69FsTb9v32nSc1ZeneDN8ThJcDCuGD1MtNno7B3PFqhf2/Rwlih4
 yTZCagLaoBNu08S5AjSWOFLYJsELL+DDUrz53Goi47oiAFNczDzHuaHMX2vEVVDIY5yLQRWb7PO
 Iz03gqzYS8Bft+4et2olo7KKBypcIy0tWFFOGF5jijo9EA+JU5N97tCUEMBNKyFyIW/LbScA2Ru
 kMgvhKHrNqVVAdmiSUa8Ttbf84kGndcegUSLYiJ4rwm0bvnOTTFzdt25IXZhb00sAIQaBJnjwcR
 OadayM94FptB6qK7ukhuPthbZA1Q9wD8DrQ4GPUiHjZkrtviwLhbhPhBkgRPpSIanM3sBlYKRyP
 u7aslLG7ZbL5SHVYqaf40PoxLBgLXzIg==
X-Received: by 2002:a05:6a20:9184:b0:3bf:b84c:2984 with SMTP id
 adf61e73a8af0-3dd5f4629d8mr14188661637.11.1789631226339; 
 Thu, 17 Sep 2026 00:47:06 -0700 (PDT)
X-Received: by 2002:a05:6a20:9184:b0:3bf:b84c:2984 with SMTP id
 adf61e73a8af0-3dd5f4629d8mr14188588637.11.1789631225753; 
 Thu, 17 Sep 2026 00:47:05 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1e38sm14379848eec.16.2026.09.17.00.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:47:05 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 13:15:37 +0530
Subject: [PATCH v10 08/15] mach-snapdragon: spl: Add DDR initialization support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-v10-8-3e83dcd239f0@oss.qualcomm.com>
References: <20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com>
In-Reply-To: <20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=H4JOUOYi c=1 sm=1 tr=0 ts=6aab9afb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=OI4x4kLBNDoJJu7lNuEA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: JmcwytBcXONBQv36HXpuvkD5oQyKM2Ko
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX5EFnBSFsJwBN
 9uj1dJ5cO7qeKsBICTa64x25sqwDv2kYzYG72DgD1AmhYv1//Mto9jy253608bamRY9BHCilTfg
 y9Xa1danxi4vM+k2G+Pp/ltfRI7fBHxhq5S/158hwL0YMjw5FFFPkK2eL2SEVGf+ikvD7JOwJIR
 nYm5811jGtDBF1lgqGW180ClVtPqEiSWibe4y9wkdd8G7SQ+JZVbmQwD2siJQFMdHsn9dzWuftI
 XBpLaYja6Ttnfccx4UiZAIdS6KmnAw20DMlsylDn5ZBgy23guYSPc5gLbzW1EAHmI1msus15aRZ
 Dxg3Qu6p9nOOVAHZ7+60GLiheHJXw/EOvieS4Aj+2fmUnjiuazpBD/uD7kkvW5WFwfK1IxvOYr9
 4hAFn9ZliKbZTLS4XRzaq3Vy1t6UkgYDncuLiXx34wCbO3Z2nmq+QeMY1K1XJbmnllhLP21ZVqc
 TzTK5Ut5YZen5djJVFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX8Eq9Y8eeYjf5
 9NBjjziomXF0M1EYErVveXL6dRTdTldeVP6TkeCI9E6+HGFm0FIC4BnKiX2XcDnCm5e6yW/Sc66
 w9A7zZFIdcIw3APO89jcIsQmgUV0xlQ=
X-Proofpoint-ORIG-GUID: JmcwytBcXONBQv36HXpuvkD5oQyKM2Ko
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170104
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

The U-Boot SPL loads the next stage FIT image into internal SRAM. The
binaries are 'external' in this FIT image. The SPL has to load the DDR init
binary, i.e. qclib and the DDR parameters i.e. qcconfig used by qclib and
invoke the qclib. SPL and qclib exchange information using the interface
table described in doc/board/qualcomm/interface-table.rst.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/Makefile      |   1 +
 arch/arm/mach-snapdragon/fit-handler.c | 131 +++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 4f2f35cb9de..2701f7c6fb1 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -7,6 +7,7 @@ obj-y += mem_map.o
 
 ifeq ($(CONFIG_SPL_BUILD),y)
 obj-y += board_spl.o
+obj-y += fit-handler.o
 obj-y += pbl-shared-data.o
 else
 obj-y += board.o
diff --git a/arch/arm/mach-snapdragon/fit-handler.c b/arch/arm/mach-snapdragon/fit-handler.c
new file mode 100644
index 00000000000..fc419bd3f00
--- /dev/null
+++ b/arch/arm/mach-snapdragon/fit-handler.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#include <atf_common.h>
+#include <image.h>
+#include <log.h>
+#include <spl.h>
+#include <linux/err.h>
+#include <mach/qclib.h>
+#include <mach/spl.h>
+
+/**
+ * qcom_spl_get_fit_img_entry_point() - Get entry point from FIT image node.
+ * @fit:	 Pointer to the FIT image blob.
+ * @node:	 Node ID within the FIT image.
+ * @entry_point: Pointer to store the retrieved entry point.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_get_fit_img_entry_point(void *fit, int node,
+				     u64 *entry_point)
+{
+	int ret;
+
+	if (!fit) {
+		pr_err("FIT image blob is NULL\n");
+		return -EINVAL;
+	}
+	if (node <= 0) {
+		pr_err("Invalid FIT node ID %d\n", node);
+		return -EINVAL;
+	}
+	if (!entry_point) {
+		pr_err("Entry point pointer is NULL\n");
+		return -EINVAL;
+	}
+
+	ret = fit_image_get_entry(fit, node, (ulong *)entry_point);
+	if (ret) {
+		pr_debug("No entry point for node %d, trying load address\n",
+			 node);
+		ret = fit_image_get_load(fit, node, (ulong *)entry_point);
+		if (ret)
+			pr_err("No load address for node %d (%d)\n", node, ret);
+	}
+
+	return ret;
+}
+
+/**
+ * qcom_spl_get_iftbl_entry_by_name() - Get an interface table entry by name.
+ * @if_tbl:	Pointer to the QCLIB interface table.
+ * @name:	Name of the entry to find.
+ * @entry:	Pointer to a buffer where the found entry will be copied.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int qcom_spl_get_iftbl_entry_by_name(struct interface_table *if_tbl,
+				     char *name,
+				     struct interface_table_entry *entry)
+{
+	uint uc_index;
+
+	if (!if_tbl) {
+		pr_err("Invalid interface table\n");
+		return -EINVAL;
+	}
+	if (!name) {
+		pr_err("Invalid name\n");
+		return -EINVAL;
+	}
+	if (!entry) {
+		pr_err("Invalid entry pointer\n");
+		return -EINVAL;
+	}
+
+	for (uc_index = 0; uc_index < if_tbl->num_entries; uc_index++) {
+		if (!strcmp(if_tbl->if_table_entries[uc_index].entry_name, name)) {
+			memcpy(entry,
+			       &if_tbl->if_table_entries[uc_index],
+			       sizeof(struct interface_table_entry));
+			return 0;
+		}
+	}
+	pr_err("Interface table entry '%s' not found\n", name);
+
+	return -ENOENT;
+}
+
+/**
+ * bl2_plat_get_bl31_params_v2() - Retrieve and fixup BL31 parameters.
+ * @bl32_entry:	Entry point for BL32 (OP-TEE).
+ * @bl33_entry:	Entry point for BL33 (U-Boot/kernel).
+ * @fdt_addr:	Address of the Device Tree Blob (FDT).
+ *
+ * Return: Pointer to the populated BL31 parameters structure.
+ */
+struct bl_params *bl2_plat_get_bl31_params_v2(uintptr_t bl32_entry,
+					      uintptr_t bl33_entry,
+					      uintptr_t fdt_addr)
+{
+	struct bl_params *bl_params;
+	struct bl_params_node *node;
+	u64 qcsdi_address = qclib_get_qcsdi_address();
+
+	/*
+	 * Populate the bl31 params with default values.
+	 */
+	bl_params = bl2_plat_get_bl31_params_v2_default(bl32_entry, bl33_entry,
+							fdt_addr);
+
+	/*
+	 * Fixup the bl31 params based on platform requirements.
+	 */
+	for_each_bl_params_node(bl_params, node) {
+		if (node->image_id == ATF_BL31_IMAGE_ID) {
+			/*
+			 * Pass QCSDI address to BL31 via arg0
+			 * This address was populated by qcom_spl_invoke_qclib()
+			 */
+			if (qcsdi_address == 0)
+				pr_warn("QCSDI address not set, BL31 may not function correctly\n");
+
+			node->ep_info->args.arg0 = qcsdi_address;
+			pr_debug("Setting BL31 arg0 to QCSDI address: 0x%llx\n", qcsdi_address);
+		}
+	}
+
+	return bl_params;
+}

-- 
2.34.1

