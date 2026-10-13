Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A56CCC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 05:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEE2C6076B;
	Tue, 13 Oct 2026 05:33:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id seWrdyVC1sn7; Tue, 13 Oct 2026 05:33:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1C46360747
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791869604;
	b=MJJ0yTvVWZRVki2iVSQ5qEq3dKDOnmvR1zc4U8h1hJHIsUd+qgtLbH9Jox8YEFjT7ATW
	 gISNVtTHzdjXGHAMqkoyo/5oAiQmqUdzUzIFHt1WXmeOZ/uNMLq8jPMOvAUbWwodLsMb9
	 twUKo6AoVqKQWU4RY4ZEW+VV21zn01XsCcHdGXteA9dTYxwcHRYSd0xaqRfNB5Z6XYTJ8
	 OjoqhsgI4hC8iNgJDO/bDH19px/oZL6vu+I6kz/QaQ1OlrzUrdJZJRetZJtA0Z4ekjf3k
	 2FpuBCALrqjq4r5lUZXR6MRKrIXsD1fdRswuXWZfkk+49C5i/CDZnzlCa9o/blY6cEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791869604;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Ru8XYGxifVLsFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=;
	b=KCtx9Ep3ctrV3O0KXLISgwc08k/cZZVvdJOG5P68QOWJs2HxlrG4hrebces63YQxGduk
	 J0LUnHMmWEKYWIbkHbNdqTiB/hyUT1C7SOXZbSF0am6fNVh7XDpqDxyq41y3gixTGt9wu
	 6KYHWhcUFD8iRf7ELY4wg0tfRJ0VatCExZT6jmYRfpBjD0trxiU9jfZlFzcxZU8W4kwxa
	 6Wx4gXhOKjavqwaF0YEnz1zZMjTKj8W84NpRbYHi/yPu8wLWKf2kBJksbdyd9CcMG5d/U
	 VdEGy8mqV9M3t1jikYga/j5cgZBbrOveEQLlnmzCIGuTvU3ZnEaGFEcY4Yt7Ph0BqCA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791869604;
	bh=Ru8XYGxifVLsFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mu7q3kKECYH0HCEZSG1UiHX2z5U4p1VYGnalTZ6mvbPebP80P6kafn2arJ85LIV4w
	 y3zykkvzofhGgZck/e0ZOOYcGCrkFaMnNAiw8lh8Jq3DYbqbl/vhZHR9Hv+J/r6kDz
	 TTCmhKHhgqF0GYcxtbYfyHxrKFODAsXP5HfMdMdS0a1JnNRdBQ9hOBBvaEbX7aNmC2
	 NugSweb+WMkcCu+zCooBcaGG98cAR+M7/RbKed3s0esv/+0KonTNDTPaqLUusXXuAL
	 SYMgdPxxPE4bs3aWpJZFreYPd8FiG9f7v6PSMbe4Hco8KwYnjrkVuizFKwaA33Gczz
	 jYKfuF0AKLoOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C46360747;
	Tue, 13 Oct 2026 05:33:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1FAC2105
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0549A80C45
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QE0tBpcgP2tr for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 05:33:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CF8A380C9F
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791869596;
 b=VjSFK/VGrR5qq0xI4mcaCIDM76uTLMB88ftq2F95kveylbbe2Uny9ltJama9n8nBKXNF
 Ji0xsQW3jfJFe7c1LbgHSLWTyjWQX353NGNGqaF5qBnyrXYF8Of+JkAr/JuOF0COqOgts
 E0p9mN1HdruA7THujEnIxuv1CLOBr/3Do+n/fpN6P9Tk5cZ3R7AhbfEhz2MBiifubCm+O
 ua1urHf/P4ghVc0vZF5T2gAeZ00YrS6lMwoG6hnEXxrxtSkrkcV5aaFHqbvaSppSo9Kjn
 1SGyV4TXEdUpPq8BBoTI7ysHjurROcMz1/154gsxltqpU+0PSxgbuTbucvratx48zNA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791869596;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=Ru8XYGxifVLsFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=;
 b=r7Pq7i/8qb6Oe39TTHWmsrbaUE1nsInaxa0acwVARtuIKsKZDQJ0L2Hon/SOCh89uaPS
 CTF37m3FgwXLTDsHfzh0BaTWQ/IaOG18Or5SHyxtzEQkMrMLQzYcMs/wGNqgHaH4OXoBD
 doDm7s/sOVZL9J0gAFHvxkvNoDaEMUd/2ddFNqbzrQr02FeRx7owl/LsI72bWCEir3H+I
 K71Iqx9xB8tEkfPVNnuv5DAAHhvK48IBNcihFp+D4i59APFdrPa7R23HlkD4XBjMEibVX
 27IQTdWt7zLCg+oObeZunk7zlI82AQ2InOfZFRfOKx1PT8o+RRu1d9m2p6b+NJRBbMA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=hruy4QAB; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UVpamMEs; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=hruy4QAB; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=UVpamMEs
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CF8A380C9F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:15 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D20mdg988774
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Ru8XYGxifVL
 sFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=; b=hruy4QABwKtTrCtNDz9ZtfmTuHB
 aEBU7HJJ9slD/noW2Mf6NLS+XITBYPB2Lu5COj86Us0TPrNN75t7ZLSGWP7n+CqH
 V7QXiKh5YdRY78pJOnZfBy2KK/F+BNIVLWz2MlF8ZutprqvPxvQzoYxX+TrixxiJ
 mzPZ5JnoM6SkYsKAwjfA4598dt/XZvwz20am63vcOT9IPAgitnvxtJKnwsYSjihP
 /5bBmjEBYujCpd6KaTOnPJuV/VG9xeBl79pAUKLEbASDcvEJwEWhjTbf0jjZwMKq
 cudiGDK1A5Ndh3oOxBoVyXdJ/zGj7W39/9ywYwM27cwImOT8UPdQI2kqnnw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98hc980b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:33:15 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-359b81ad4e8so3095498eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 22:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791869594; x=1792474394;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ru8XYGxifVLsFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=;
 b=UVpamMEs05fzwgxta4R0L6MdVqLOQhNu4gWqLgcAOFkyJmhdzc1Eek2QZdNvoFjc8J
 xKrPLLxrNDiOZD+zwMfv8kFhINb4vCXDUNIEhpRExlJJ8rMdYIk8Ipobyev0lIiDkSUp
 97ULTi9oGtarepIjlt5ntbywIYYzjnY+DV16nIyY6QYTvxyDWXv5kJpROUxBoEohkCgf
 +IUHkwt4FOS1SCx8upUPPbhma19E2sBDvsEbKE1GHgidTgXpcZR2mflTZhbaQcno0Dvm
 KM69NZF9LUZih3rjzST7jLlQnqScM5jkFhs6xUjA0nEb680Qmt9es+uEpkVi1+9dV7eg
 PtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791869594; x=1792474394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ru8XYGxifVLsFPw6hFZmmRlRLh41DU3hvz8TAftb4Uo=;
 b=H4IDYyy0G2FPLVhkoN080N24gzNoLHwv/FwlGL4QcnilO+Fs07b6M/HXAuXOxd4FJz
 2j8aVcY7RKvnIIGc06bobAXbBtfQtsW9t5J9Nl9LUvSjfJPGA6fnBw+dpAIl2OiVs5ZB
 viMJtYDIGxGZNFSqlqgqra+q9g0wGzsrN8pipwz43nhgqH/WDQbHoAd5i1DAacOglOj3
 cbBh2rqryCzD9Nu+eyvvkJAUSz6Vc8VlQhJtJmRxK/aWU821T+KyYq66z20YeTKNX5wW
 c0YyH/cFlKceAQiLtT7jIYsozQt3umRFxUIPrIbj1EN0TQFc3QLNDS/fzRTqR7bnBMi0
 Appg==
X-Forwarded-Encrypted: i=1;
 AKwUvByGtk+zrVY7nDZLlg4HL3oRnXdoJmKnSpRcMlMavf6mhnjgDiXwLvai+Eo12GvoQ8dVqilDKjU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI8T5EoCAIrumvcI+hfIzD8CfHJrgct612pDlkiCzoX40bqC0Af
 YaEcasbzPI4QacMQWq9vqy7wCcSTv0uDTwmPB/ezmr/FMUNLOAhKfsfw5V44nG2jvRPFmdg4cO9
 hKt9hfxi7jJiM9B48QtdkqIeXM5UgPJhdItemrow17uMTW9r90JQuKXAsJ5yTXQ0CdLEXR5b1Cc
 h8QyIw2w==
X-Gm-Gg: AYBFou0BJfL7Ad9RyRwbAmR77v6uWcGpQD7JTnvn29WUCq/kfm177yG5tsFyHlB4eWv
 JeSW1LDB+yj4SyWMV+wDmC+17WDSYzcOakfUblxnrQeGh6BKyMrsIx3XquXd+S0wJyk15UZKUrI
 MDcwAWxtTvAhuqAzy78yxv52k6D5n1Z26wP7o/R2O83WkWpolw87LlfO1eHb1A3VfzZnl+//UKQ
 CI3kNORvZN0i6vVeVPDIAnxpM+q1P1WAZtQSQeJsCfICu6U/Xx7isvMbFXLk2MtbOSG8KG4uBJF
 8ZMXmPsmB5B9PqpqpoTyNiTVkc6eDjlvkzD+RmuepXx8/wDf4LISHkxYsiylrpC6YkhER3SlyhM
 Y6u3QCOWq682UI9ijZGTXa/eN1S//S0A4vB1XY2xa6uW/3DM=
X-Received: by 2002:a05:693c:87d5:10b0:351:433a:acfd with SMTP id
 5a478bee46e88-3537e0796acmr15986960eec.38.1791869594001; 
 Mon, 12 Oct 2026 22:33:14 -0700 (PDT)
X-Received: by 2002:a05:693c:87d5:10b0:351:433a:acfd with SMTP id
 5a478bee46e88-3537e0796acmr15986916eec.38.1791869593339; 
 Mon, 12 Oct 2026 22:33:13 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-353810403e9sm39727670eec.2.2026.10.12.22.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 22:33:12 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, Michael.Srba@seznam.cz, sjg@chromium.org,
 balaji.selvanathan@oss.qualcomm.com,
 varadarajan.narayanan@oss.qualcomm.com, nikroks@mainlining.org,
 luca.weiss@fairphone.com, nathbappai@gmail.com, jbx6244@gmail.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v2 13/13] clk: qcom: build only selected clock drivers in SPL
Date: Mon, 12 Oct 2026 22:32:44 -0700
Message-Id: <20261013053244.2954876-14-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
References: <20261013053244.2954876-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfX2JFkagtHhHpv
 kOHRrogVshctlxaEjiTek4EA0DeIdpJZok02iOO9NOokUzpzGw6HLCeDj+AAVlVwDqNdhrytlY/
 FeYhy+FPUNNLoQdIgrhI++4DqrijLrAw84fIH+A+BLjNueGuez8qpt1xzRjvvTiqRXNcLRXU3jo
 xtVXE3D+fppaICQyvu50u7ZQ0T+rXmGTR6cT44e/ydVCT2hqd7KCi5iUPceefq7fgWjT/YYAhj1
 he+M8ZideO2vWv0JUROWCFUGcMsTOckgbwzlTCuybuTEWjNHf4sDL3fLKcOaw4dLAm8WGGnTRwf
 MEpSbDn+Nt20Si9/1dy6a5EIWhiBKhS8Rqd7Lb846dvB2CrpdmNj0cg4SzgMAZRo1aj+63B7ceS
 R+nYtiA3zULFkFRR1tco9f++iVvrXBnazkBcBFGrVXPkB+JLUqsEmcYJSc8O/KwWCFGQGjnJTrV
 pRj7h+xLjbSGkTfrjkA==
X-Authority-Analysis: v=2.4 cv=VPVIDNPX c=1 sm=1 tr=0 ts=6acdc29b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=1OAO5j4Zegv94xHJGxAA:9 a=yafjnGloKYvRJXMp:21 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: SXmtnnzt5U4Hpxdr6POM1fPnDnJ3HQQ8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyMSBTYWx0ZWRfX9n5adOjfspPL
 w3xk2wAq+OzhVvQ7yrWuJNP+MPA/JMgYOU/CttSMa64HX5YcPDft/8USoSttHq/S9XCE6GUh1Fd
 Gzd97UrYYtaRdbq8UksMcw83beqL0mA=
X-Proofpoint-GUID: SXmtnnzt5U4Hpxdr6POM1fPnDnJ3HQQ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130021
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

From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>

Make Qualcomm clock-driver selection phase-aware so SPL builds only the
drivers it needs, reducing the SPL image size.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
---
 drivers/clk/qcom/Kconfig  | 208 ++++++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/Makefile |  48 ++++-----
 2 files changed, 232 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index aff3f5418a0..899f44cb8dc 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -5,6 +5,11 @@ config CLK_QCOM
 	depends on CLK && DM_RESET && POWER_DOMAIN
 	def_bool n
 
+config SPL_CLK_QCOM
+	bool
+	depends on SPL_CLK && SPL_DM_RESET && SPL_POWER_DOMAIN
+	def_bool n
+
 menu "Qualcomm clock drivers"
 
 config CLK_QCOM_APQ8016
@@ -15,6 +20,14 @@ config CLK_QCOM_APQ8016
 	  on the Snapdragon APQ8016 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config SPL_CLK_QCOM_APQ8016
+	bool "Qualcomm APQ8016 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  SPL variant of CLK_QCOM_APQ8016.
+	  See the help of CLK_QCOM_APQ8016 for details.
+
 config CLK_QCOM_APQ8096
 	bool "Qualcomm APQ8096 GCC"
 	select CLK_QCOM
@@ -23,6 +36,14 @@ config CLK_QCOM_APQ8096
 	  on the Snapdragon APQ8096 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config SPL_CLK_QCOM_APQ8096
+	bool "Qualcomm APQ8096 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  SPL variant of CLK_QCOM_APQ8096.
+	  See the help of CLK_QCOM_APQ8096 for details.
+
 config CLK_QCOM_IPQ4019
 	bool "Qualcomm IPQ4019 GCC"
 	select CLK_QCOM
@@ -206,6 +227,193 @@ config CLK_QCOM_X1E80100
 	  on the Snapdragon X1E80100 SoC. This driver supports the clocks
 	  and resets exposed by the GCC hardware block.
 
+config SPL_CLK_QCOM_IPQ4019
+	bool "Qualcomm IPQ4019 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm IPQ4019 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_IPQ5210
+	bool "Qualcomm IPQ5210 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm IPQ5210 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_IPQ5424
+	bool "Qualcomm IPQ5424 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm IPQ5424 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_IPQ9574
+	bool "Qualcomm IPQ9574 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm IPQ9574 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_MILOS
+	bool "Qualcomm Milos GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm Milos Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_QCM2290
+	bool "Qualcomm QCM2290 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm QCM2290 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_QCS404
+	bool "Qualcomm QCS404 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm QCS404 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_QCS615
+	bool "Qualcomm QCS615 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm QCS615 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_QCS8300
+	bool "Qualcomm QCS8300 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm QCS8300 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_RPMH
+	bool "Qualcomm RPMh clock driver in SPL"
+	depends on SPL_CLK
+	help
+	  Enable the Qualcomm RPMh clock driver in SPL.
+	  This provides RPMh-managed clocks needed during early boot.
+
+config SPL_CLK_QCOM_SA8775P
+	bool "Qualcomm SA8775 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	select SPL_CLK_QCOM_RPMH
+	help
+	  Enable the Qualcomm SA8775P Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SDM845
+	bool "Qualcomm SDM845 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SDM845 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SHIKRA
+	bool "Qualcomm Shikra GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm Shikra Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM6115
+	bool "Qualcomm SM6115 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM6115 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM6125
+	bool "Qualcomm SM6125 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM6125 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM6350
+	bool "Qualcomm SM6350 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM6350 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM7150
+	bool "Qualcomm SM7150 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM7150 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM8150
+	bool "Qualcomm SM8150 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM8150 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM8250
+	bool "Qualcomm SM8250 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm SM8250 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM8550
+	bool "Qualcomm SM8550 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	select SPL_CLK_QCOM_RPMH
+	help
+	  Enable the Qualcomm SM8550 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SM8650
+	bool "Qualcomm SM8650 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	select SPL_CLK_QCOM_RPMH
+	help
+	  Enable the Qualcomm SM8650 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_SC7280
+	bool "Qualcomm SC7280 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	select SPL_CLK_QCOM_RPMH
+	help
+	  Enable the Qualcomm SC7280 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
+config SPL_CLK_QCOM_X1E80100
+	bool "Qualcomm X1E80100 GCC in SPL"
+	depends on SPL_CLK
+	select SPL_CLK_QCOM
+	help
+	  Enable the Qualcomm X1E80100 Global Clock Controller in SPL.
+	  This includes only the clock driver needed during early boot.
+
 endmenu
 
 endif
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 8da2ff7e73e..7c4db9986d1 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -3,28 +3,28 @@
 # (C) Copyright 2023 Linaro
 
 obj-y += clock-qcom.o
-obj-$(CONFIG_CLK_QCOM_SDM845) += clock-sdm845.o
-obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
-obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
-obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
-obj-$(CONFIG_CLK_QCOM_IPQ5210) += clock-ipq5210.o
-obj-$(CONFIG_CLK_QCOM_IPQ5424) += clock-ipq5424.o
-obj-$(CONFIG_CLK_QCOM_IPQ9574) += clock-ipq9574.o
-obj-$(CONFIG_CLK_QCOM_MILOS) += clock-milos.o
-obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
-obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
-obj-$(CONFIG_CLK_QCOM_QCS8300) += clock-qcs8300.o
-obj-$(CONFIG_CLK_QCOM_QCS615) += clock-qcs615.o
-obj-$(CONFIG_CLK_QCOM_SA8775P) += clock-sa8775p.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SDM845) += clock-sdm845.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_APQ8016) += clock-apq8016.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_APQ8096) += clock-apq8096.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_IPQ4019) += clock-ipq4019.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_IPQ5210) += clock-ipq5210.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_IPQ5424) += clock-ipq5424.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_IPQ9574) += clock-ipq9574.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_MILOS) += clock-milos.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_QCM2290) += clock-qcm2290.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_QCS404) += clock-qcs404.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_QCS8300) += clock-qcs8300.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_QCS615) += clock-qcs615.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SA8775P) += clock-sa8775p.o
 obj-$(CONFIG_CLK_QCOM_SC7180) += clock-sc7180.o
-obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
-obj-$(CONFIG_CLK_QCOM_SHIKRA) += clock-shikra.o
-obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
-obj-$(CONFIG_CLK_QCOM_SM6125) += clock-sm6125.o
-obj-$(CONFIG_CLK_QCOM_SM6350) += clock-sm6350.o
-obj-$(CONFIG_CLK_QCOM_SM7150) += clock-sm7150.o
-obj-$(CONFIG_CLK_QCOM_SM8150) += clock-sm8150.o
-obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
-obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
-obj-$(CONFIG_CLK_QCOM_SM8650) += clock-sm8650.o
-obj-$(CONFIG_CLK_QCOM_X1E80100) += clock-x1e80100.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SC7280) += clock-sc7280.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SHIKRA) += clock-shikra.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM6115) += clock-sm6115.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM6125) += clock-sm6125.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM6350) += clock-sm6350.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM7150) += clock-sm7150.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM8150) += clock-sm8150.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM8250) += clock-sm8250.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM8550) += clock-sm8550.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_SM8650) += clock-sm8650.o
+obj-$(CONFIG_$(PHASE_)CLK_QCOM_X1E80100) += clock-x1e80100.o
-- 
2.34.1

