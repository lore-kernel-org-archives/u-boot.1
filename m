Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8213ECA5FAB
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 06:35:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B3784084E;
	Wed, 30 Sep 2026 06:35:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TNmNkWrzdIFG; Wed, 30 Sep 2026 06:35:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7BD56408B7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790750113;
	b=NBGi76ydOeKo2wM0YvkcoVM47cJKNw+zhdPHBBq4zIyeDAxc1l3KTT/4uNv59paq8rI+
	 Tn8G7cYHnOncvEoUArUs1ryA31TngzzK7g0FbNEEyBb0B7RS5QZ7yRLy3/pFok6kZt2zQ
	 6WkCKSevr5fB8MKpvzym37/vNowIAW3JZZiwlmjCC+I2zOuR5KoBcm9AF/KBpTDzqCkO8
	 v0mrlbgsqsKzpxRWuDEQZ5JtP8Wqr/qwz3GrRQu2lwBXp0g85OyhvbnI9VGyvr+zdCS+/
	 B5sNymf3Z702nWijUVRZ9BATXUhFzrjA+FA2dbf0cANTD7MM7UYPZz8YDVTO2+sQSng==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790750113;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qWc4aScmsAKE71ek+32oiTVtKgVbHdgDVol13RhDaV4=;
	b=FXKGtO4ZGjbHgOn0rEY2hmWzBrMC/9eSBGOvpVWf2PuWLQA383MOgSKR4pIQmFmqXyBl
	 bJuD+qZONyPLHMbnPIP8LsV2cZSCyVh8x7kjVnMm8i9u9Som47ucx72E5eMFvBKceMguw
	 8MyeMOTqeiJ0q8uKZ/WkGdstjzKVG8aIQuy6qSMssoirrzNYzQsl9NkV1OxW5CoBJmh+S
	 iB4qrl0gLpXOTDyby3GQBMxGE+kW6D62Du7Tc/yJ2pnm3/j+PbxcOO8pkgvkViLhXCRIY
	 jS/gtl97N8TDUsRuv8OwRDOf4gU9D1Ll0LwFk5jaln6GiPXDYZ6gKHffB9X0T1BAmkw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790750113;
	bh=qWc4aScmsAKE71ek+32oiTVtKgVbHdgDVol13RhDaV4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=scQ+MxSqTCVErXswJNClRD5jSsGDZEUH7Q3DtaT1X0zzP+EdhOMSjEU6ZmHKiYjo1
	 JGTYdT1OfPD1nbwcevhBLMLdpIFRJ0qeAmgkZD+6/hZyCAB+jVVhAxLSDG+AumVsEC
	 MqoEQ8mH2G/5Np+Fu2nlx02Xq1BuRZpcaV+e3wXnrSrhXGzYMFeDuNkxh9J+9nxlSt
	 /zZA35gsQAUCwjW21ra7S6Yzew1POYL6Qpl9UuhgVYYlKUC6VjBTfA3IO73PZhPJzC
	 Pgz8JwmXTi1vpWnXhNLlzjrLuWzpnUDXEkB1zl5N0zRitA/9Zhi6muo1HqHafC3sZb
	 Z75cjk0Gc+s5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7BD56408B7;
	Wed, 30 Sep 2026 06:35:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E6EA33D8
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D85CE80C75
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X7PJoz4RUafY for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 06:35:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0FBEB80AED
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790750107;
 b=a7SGlihguln6p6PPSYYgZ6iMwdqxRcAgyZVQFBBnv846UHGT6ldxCejGVdW4VhC5wd3G
 QKWrrjljO3NySpP/dlSS/RNvnBq30mSa5XoBe96ggpTj8mmUSajlRxwMfunQ+CdlUSFLq
 8dmjGgWvjSdnMob79OD10b1Vh03G/7zA2OKAjFsmjymbQWOJRkIpsY6pfVLEU6c6TMSon
 Po629fzDmlg4b/xRBT09XotQum/ls2psPYEr72dat2C2dE4oVB9qVnLibpTA1NgRTFglp
 XX1yeuU2vybqiYQcbmNjkOMsQG7nqKwnzPb6OAKLNcZNnEgItORiOLrnznD4b5djeTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790750107;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=qWc4aScmsAKE71ek+32oiTVtKgVbHdgDVol13RhDaV4=;
 b=AYeUQ/4eNkn6fI5cq28MrTJ/houJzvVXbL0jedVwvsFUY6Thj/6gR3cFIdRCvML28M8Y
 Lr+5a+FTQxotuYjtFNSiypLamX1qoKQ5bQL5ZpaTsTLeqjCJpO64xKz9Wzbxfl8QMNJby
 SRo9eLcZ2bkh4iEFDy3uX/XsuuQE5ssN0by214yabf5d4CoObUjTSXdul0IFS7Geh1arg
 uQDpo9qgarPUiOOoT1/4/PT6XT+X4C65kUl1CPFlCI52ju5DRJceHFEl47TeN6f/pPrm9
 7Amg1OqONkfz6L9cZGjbBMzAPfgjZzcWSCAJbE/fQTKXAWSYAxLtvmmLrmYdt++9Ohw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=jUIZYZJc; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b="CQFII/Ta"; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=jUIZYZJc; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=CQFII/Ta
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0FBEB80AED
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:06 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U3Vbu91887292
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=qWc4aScmsAK
 E71ek+32oiTVtKgVbHdgDVol13RhDaV4=; b=jUIZYZJcNKBk2Xxi4iAh/U05pS2
 lyDePiXMXza1wyxV6eUPw48Xyzg/tanwtJgpHoKfflEHon/vZnG64XavGNwSKnAh
 Pao07GSGBTcjxNbbK561/uy+1lIMxTMEptABehMoQnEYxKIUw+xaro0YHLp/4Xc/
 aZ+9X52SCMdMwZp37797tm5mWpmVH096AJBSOcVdjRjmWL/Yb15EHn4sTIMv/sOU
 kkRAUkCP0HfB5gp+jb5XFMOKjbisdATCtLNHEEVMaP5XgEgsP6uaQxitPqqcntLA
 WzhXCS784tpZoj2UdC+X1xyOInETUtbCwSnjUJlPNcgjZoklyWiFdpFB8rA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0tkn0nj9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:06 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso2155345eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790750105; x=1791354905;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qWc4aScmsAKE71ek+32oiTVtKgVbHdgDVol13RhDaV4=;
 b=CQFII/TaIuQBpJA9Yp9MaFPOosZRCzWtUQh1VWnWiZOkfAO8DSdQoscQpgqeCCAgtv
 qOAFjvPlLyhvNS/fgjOBA1QGGJ3AMZ6BGLasnPPRTE//pFSQ8smryeUZFOabHMGVtIke
 RTs/ado7eF3C7kRB1vi4ic0b1U6CeFw8YuNObCWGZ6bySRv8uaJ7C5NI27H9r/FumgQm
 2zVktLrU8wPd2qC3AodYpb27ZXjhBXnCaC4wjT8IAmz/I2bgs/AJXb/BBI8NPWF/I7Kv
 A7vFoh0Gkp2P7DN3jSxudMAv731RBA8k14C6ysVjiOnVV6Yj4g68+jdMLGV3VNnEzTc+
 3YDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790750105; x=1791354905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qWc4aScmsAKE71ek+32oiTVtKgVbHdgDVol13RhDaV4=;
 b=ZL4ixNaBGAbRfaEyJcYEWqAOst4UTVcqVGcaGH3ig/EoxtLKOpq2WcmtgIz+gXnLtt
 KdY0scbMnOYtjo8axkUq9WnSEUFaJVcSu3sw4BtIcYhnpqLvIZMyY1wOneSXMJRoFJIq
 0y5UakVJpJH0Uus/V2+SHNC1wojjmoVAmVrnBd/LX6+Lp3vUgoMDklcCq5F0iBjlTB5i
 0lLtfogUGl2UgOjAmncZqQO7ywYKxj0KEZnD+mM9lmGd6Tsc3aMnSFWrdCjLPbvdGdpc
 QdyXa2wXoZY7ezTvn/+LaCix5cQS+OJfdIKulY8TDfHSVm4x1qtwvqYpFyHWv1NlQXpr
 bPnA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzs8QwThBMsDepgT2WvK3sR5c0xOCEf41tPQCzhAbY7cFSFZIIbDKBK7Y3g87darjaHlHGJdzc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKruof1AePUi76alzfW0iva+zUpvpMZxHxqQIYqWyTKO7F+QmPB
 MQFpRdtXdd6jdEUA4iskXcCvM860fZjtDNcKRwhJORWG1Nf1LxKjlcWU0datmw97T9/fLsEYR7F
 HNkvZn4/Kyu5b6N/Q7g5+h0bfFqYN319aIa72y4K7o9ifELw85s1lB0djvNvJNbpH90cSdtQ=
X-Gm-Gg: AYBFou3gCKGv/MFS46pLL5Qi+GQov8DbE4kkzKh9xO3qwLTJxwZKV2MsIHp48wS8Hf/
 9HHRoeTzQckjWGZ5WskxwBqd/A8ZSRit6Slj90nlgIHlmuFKZBCTh/F5PTdLREVsXyNP64LtS/1
 666g3K5Afm6ug6UbjWOvySR53ELrNjXm8uuvU0GjGZ8H+up/bNf144f2E+Vm5njYUgRrFDmTH+M
 v9n/aQq+/D9kN+CUXJdYERHoHmuNpLheS5iYFGyuKcmEl58q7N5KJbbDOeK2tfKbA9DvttXIic8
 mPd4e/gRizVy/0IFdaDseGfoQ8KBYMbL5vAIuz/OiB0DD9BorVXvUDWe1V4rsWTy8FqTypoLTlq
 AxURttSwvBL4sQE75s6/DcsvkVOrIssUFwdYDHKPKwxzqmGO2
X-Received: by 2002:a05:7300:c8c3:b0:341:c6ca:1df3 with SMTP id
 5a478bee46e88-34cdbeca2a7mr728703eec.14.1790750105185; 
 Tue, 29 Sep 2026 23:35:05 -0700 (PDT)
X-Received: by 2002:a05:7300:c8c3:b0:341:c6ca:1df3 with SMTP id
 5a478bee46e88-34cdbeca2a7mr728654eec.14.1790750104544; 
 Tue, 29 Sep 2026 23:35:04 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34cf22f85b7sm1287502eec.3.2026.09.29.23.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:35:04 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, sjg@chromium.org,
 varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v3 03/12] board: qualcomm: shikra: add SPL board support
Date: Tue, 29 Sep 2026 23:34:40 -0700
Message-Id: <20260930063449.3251317-4-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
References: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CKy/zhrD c=1 sm=1 tr=0 ts=6abcad9a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=U7ebsduSVgTrIjsT4N8A:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: qWtoOYmmWQdXubHyv7mdw4ZMWjnmVC0y
X-Proofpoint-GUID: qWtoOYmmWQdXubHyv7mdw4ZMWjnmVC0y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfXzzHcJXbIhH/t
 AEv9EyIoJf32EJ26vX4hGzvO4NBALdKxHO1XHp8h7ePaOV82UcTpyyjnNfIBrZyDIMj3Qn2GJtx
 4NGpj2jrNa1QEhXplFyipHLYTENNhpQftNwnxQHpIs0jNY1Ti+kb+PxfBqySyVzGaxMeOSoQA0R
 3GZ15L676bhGA3D5bPTPL/hIhn+zuENiWPCnfvuBK5Lpssiwdsf7lWj/2Bl+3y/+xrP8g4AKrTT
 VkIVJiQjTyRnDOcSGSAysuFIgXj9GVMDcR7suKe8EGeFEnKlPW+9Q+F0cdba4tgZRjacJGbaSd+
 /m7kP2cbo1ViAVHKKsHqagH5JyaYaHo9r3G/nn9zBMLeg73DHhV0kmKGli8soB15Ie+11uhYhfw
 nUV8QrPNx08njJFm/ad9LrDzj+r1YykjVuFIkNVeCmJkh+cHQ76vfEvLGzoq3DBHBV4gcuPvZ6k
 xS1eLCZv5pYLDLJaJFQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX2wopuxn4SSoi
 goV2qSkEVaccu1KSY0sib9neUDN6gl+DYm+sq4Sskk2SCPDTjTqmaik0yTblxA6dztJDDXg4fil
 LvZ35TeWVIBae8GBiIKOEUuOHsXiVbA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300026
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

Add the Shikra SPL board implementation, build rules, linker
wrapper, and board configuration header. Configure QCLIB
handoff data, early reset handling, and MMC boot-device and
partition selection.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 board/qualcomm/shikra/Makefile                |   3 +
 board/qualcomm/shikra/shikra-spl-wrap-elf.lds |  18 ++
 board/qualcomm/shikra/spl-shikra.c            | 202 ++++++++++++++++++
 include/configs/shikra.h                      |  11 +
 4 files changed, 234 insertions(+)
 create mode 100644 board/qualcomm/shikra/Makefile
 create mode 100644 board/qualcomm/shikra/shikra-spl-wrap-elf.lds
 create mode 100644 board/qualcomm/shikra/spl-shikra.c
 create mode 100644 include/configs/shikra.h

diff --git a/board/qualcomm/shikra/Makefile b/board/qualcomm/shikra/Makefile
new file mode 100644
index 00000000000..eb3961a3ead
--- /dev/null
+++ b/board/qualcomm/shikra/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_SPL) := spl-shikra.o
diff --git a/board/qualcomm/shikra/shikra-spl-wrap-elf.lds b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
new file mode 100644
index 00000000000..b2922cd2c2c
--- /dev/null
+++ b/board/qualcomm/shikra/shikra-spl-wrap-elf.lds
@@ -0,0 +1,18 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-only
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+PHDRS {
+	ptype PT_LOAD FLAGS(0x7);
+}
+
+ENTRY(_entry)
+
+SECTIONS {
+	. = CONFIG_PLATFORM_ELFENTRY;
+	_entry = . ;
+	data : {
+		*(.data)
+		. = ALIGN(4);
+	} :ptype
+}
diff --git a/board/qualcomm/shikra/spl-shikra.c b/board/qualcomm/shikra/spl-shikra.c
new file mode 100644
index 00000000000..b967b0137b1
--- /dev/null
+++ b/board/qualcomm/shikra/spl-shikra.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#include <blk.h>
+#include <asm/io.h>
+#include <dm/uclass.h>
+#include <linux/err.h>
+#include <linux/string.h>
+#include <mach/qclib.h>
+#include <mach/spl.h>
+#include <part.h>
+#include <spl.h>
+
+#define IPQ_SPL_BOOTCFG_REG_ADDR	0x1B46070
+#define IPQ_SPL_BOOTCFG_DEV_MASK	GENMASK(5, 1)
+#define IPQ_SPL_BOOTCFG_DEV_SHFT	0x1
+
+#define SHIKRA_DDR_INFORMATION		"ddr_information"
+#define SHIKRA_DDR_TRAINING_DATA	"ddr_training_data"
+#define SHIKRA_DDR_SR_EXIT		"ddr_sr_exit"
+#define SHIKRA_PMIC_COCOS		"pmic_cocos"
+#define SHIKRA_PMIC_WAILUA		"pmic_wailua"
+#define SHIKRA_DCB_LP4			"dcb_lp4"
+#define SHIKRA_DCB_LP5			"dcb_lp5"
+#define SHIKRA_ECC			"ecc"
+
+#define SHIKRA_DDR_TRAINING_DATA_ADDR	0x0c368000
+#define SHIKRA_DDR_TRAINING_DATA_SIZE	0x8000
+#define SHIKRA_PMIC_COCOS_SIZE		0xbc00
+#define SHIKRA_PMIC_WAILUA_SIZE	0x6000
+#define SHIKRA_DCB_LP4_SIZE		0x4800
+#define SHIKRA_DCB_LP5_SIZE		0x4800
+#define SHIKRA_ECC_SIZE			0x400
+
+#define SHIKRA_SHRM2_SPROC_CTRL_ADDR			0x0c36000
+#define SHIKRA_SHRM2_SPROC_CTRL_CORE_SW_RESET_BMSK	BIT(1)
+#define SHIKRA_SHRM2_SPROC_CTRL_DEBUG_SW_RESET_BMSK	BIT(3)
+
+/* GCC_APCS_MISC contains the RPM reset control bit. */
+#define SHIKRA_GCC_APCS_MISC_ADDR			0x01491000
+#define SHIKRA_GCC_APCS_MISC_RPM_RESET_BMSK		BIT(0)
+
+#define SHIKRA_RPM_STAGING_ADDR			0x04690000
+#define SHIKRA_RPM_STAGING_SIZE			0x1363c
+
+#define QCOM_SPL_FIT_IMG_PARTITION	"uefi_a"
+
+enum {
+	IPQ_SPL_BOOTCFG_DEV_MMC = 0x0,
+	IPQ_SPL_BOOTCFG_DEV_SD_EMMC	= 0x1,
+	IPQ_SPL_BOOTCFG_DEV_EDL		= 0x2,
+	IPQ_SPL_BOOTCFG_DEV_NAND	= 0x3,
+	IPQ_SPL_BOOTCFG_DEV_EMMC_SD		= 0x4,
+	IPQ_SPL_BOOTCFG_DEV_MAX
+};
+
+int qcom_spl_soc_qclib_override(struct interface_table *table,
+				const void *fit, int images_node)
+{
+	static const struct {
+		const char *name;
+		u32 size;
+	} fit_blobs[] = {
+		{ SHIKRA_PMIC_COCOS, SHIKRA_PMIC_COCOS_SIZE },
+		{ SHIKRA_PMIC_WAILUA, SHIKRA_PMIC_WAILUA_SIZE },
+		{ SHIKRA_DCB_LP4, SHIKRA_DCB_LP4_SIZE },
+		{ SHIKRA_DCB_LP5, SHIKRA_DCB_LP5_SIZE },
+		{ SHIKRA_ECC, SHIKRA_ECC_SIZE },
+	};
+	uint i;
+	int ret;
+
+	table->global_attributes |= QCLIB_GA_ENABLE_UART_LOGGING;
+	for (i = 0; i < ARRAY_SIZE(fit_blobs); i++) {
+		ret = qclib_add_iftbl_fit_blob(table, fit, images_node,
+					       fit_blobs[i].name, fit_blobs[i].size);
+		if (ret)
+			return ret;
+	}
+
+	ret = qclib_add_iftbl_entry(table, SHIKRA_DDR_TRAINING_DATA,
+				    SHIKRA_DDR_TRAINING_DATA_ADDR,
+				    SHIKRA_DDR_TRAINING_DATA_SIZE);
+	if (ret)
+		return ret;
+	ret = qclib_add_iftbl_entry(table, SHIKRA_DDR_INFORMATION, 0, 0);
+	if (ret)
+		return ret;
+
+	return qclib_add_iftbl_entry(table, SHIKRA_DDR_SR_EXIT, 0, 0);
+}
+
+void qcom_spl_soc_shrm_reset(void)
+{
+	writel(SHIKRA_SHRM2_SPROC_CTRL_DEBUG_SW_RESET_BMSK |
+	       SHIKRA_SHRM2_SPROC_CTRL_CORE_SW_RESET_BMSK,
+	       (void *)SHIKRA_SHRM2_SPROC_CTRL_ADDR);
+	writel(SHIKRA_SHRM2_SPROC_CTRL_CORE_SW_RESET_BMSK,
+	       (void *)SHIKRA_SHRM2_SPROC_CTRL_ADDR);
+	writel(0, (void *)SHIKRA_SHRM2_SPROC_CTRL_ADDR);
+}
+
+int qcom_spl_soc_pre_qclib_routine(void)
+{
+	qcom_spl_soc_shrm_reset();
+
+	return 0;
+}
+
+void qcom_spl_soc_rpm_reset(void)
+{
+	clrbits_le32((void *)SHIKRA_GCC_APCS_MISC_ADDR,
+		     SHIKRA_GCC_APCS_MISC_RPM_RESET_BMSK);
+}
+
+int spl_check_board_image(struct spl_image_info *spl_image,
+			  const struct spl_boot_device *bootdev)
+{
+	qcom_spl_soc_rpm_reset();
+
+	return 0;
+}
+
+int qcom_spl_soc_post_qclib_routine(struct interface_table *table)
+{
+	struct interface_table_entry entry;
+	int ret;
+
+	/*
+	 * Clear the full memory region reserved for the RPM image before loading
+	 * the post-DDR FIT, including its zero-initialized data.
+	 */
+	memset((void *)SHIKRA_RPM_STAGING_ADDR, 0, SHIKRA_RPM_STAGING_SIZE);
+
+	ret = qcom_spl_get_iftbl_entry_by_name(table, SHIKRA_DDR_SR_EXIT,
+					       &entry);
+	if (ret)
+		return ret;
+
+	qclib_set_ddr_sr_exit_address(entry.address);
+	return 0;
+}
+
+int spl_mmc_boot_partition(const u32 boot_device)
+{
+	struct blk_desc *desc;
+	struct disk_partition info;
+	int partition;
+
+	if (!IS_ENABLED(CONFIG_MMC))
+		return -ENOSYS;
+
+	desc = blk_get_devnum_by_uclass_id(UCLASS_MMC, 0);
+	if (!desc)
+		return -ENODEV;
+
+	partition = part_get_info_by_name(desc, QCOM_SPL_FIT_IMG_PARTITION,
+					  &info);
+	if (partition < 0)
+		return -ENOENT;
+
+	return partition;
+}
+
+/**
+ * spl_boot_device() - Get the boot device.
+ *
+ * Return: U-Boot boot device identifier, or -EINVAL if the device is invalid.
+ */
+u32 spl_boot_device(void)
+{
+	u8 boot_device_cfg =
+	(readl(IPQ_SPL_BOOTCFG_REG_ADDR) & IPQ_SPL_BOOTCFG_DEV_MASK) >>
+	IPQ_SPL_BOOTCFG_DEV_SHFT;
+	u32 boot_device_smem;
+
+	switch (boot_device_cfg) {
+	case IPQ_SPL_BOOTCFG_DEV_MMC:
+		boot_device_smem = BOOT_DEVICE_MMC1;
+		printf("Selected boot device: MMC\n");
+		break;
+	case IPQ_SPL_BOOTCFG_DEV_SD_EMMC:
+		boot_device_smem = BOOT_DEVICE_MMC2;
+		printf("Selected boot device: SD MMC\n");
+		break;
+	case IPQ_SPL_BOOTCFG_DEV_EDL:
+		boot_device_smem = BOOT_DEVICE_USB;
+		printf("Selected boot device: SPI-NAND\n");
+		break;
+	case IPQ_SPL_BOOTCFG_DEV_NAND:
+		boot_device_smem = BOOT_DEVICE_NAND;
+		printf("Selected boot device: SPI-NAND\n");
+		break;
+	default:
+		pr_err("Invalid boot device configured: %d\n",
+		       boot_device_cfg);
+		return -EINVAL;
+	}
+
+	return boot_device_smem;
+}
diff --git a/include/configs/shikra.h b/include/configs/shikra.h
new file mode 100644
index 00000000000..7d88dc0e670
--- /dev/null
+++ b/include/configs/shikra.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef __CONFIGS_SHIKRA_H
+#define __CONFIGS_SHIKRA_H
+
+#include <linux/sizes.h>
+
+#endif
-- 
2.34.1

