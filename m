Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8222CA6002
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 18:12:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D0CCA60BF1;
	Wed,  7 Oct 2026 18:12:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SIdzY3OfzrsR; Wed,  7 Oct 2026 18:12:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A7DC260BBD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791396723;
	b=W8Mm7dyHKsLEJCYmt03XVMJNo42p+kYcppvDQmIfsKrvw4G/Uf6qMoml6EH18Eg2r6Rt
	 phPvfdKVmA/dMFRzhwdtgNeCXAFwmWJHoMD6Hg4pc8RINeTnTsBI9d4xDrOCpmnAGhj+k
	 p/HiawboDHt0xkhHl1WUS1CQh2zGnprpLigeGkRE/7d20ODOmrFgP+lzybj0dumfLithM
	 twgBAhBySwdrsTbjdXJO265SQYf6hEuGW+PWAlg9HJXep4Edo5tC9fw5cFXuS3hdNc0LS
	 m18BgvChIOlOg1MrS/T1aHGBMJPkmi9b6U6l1SckGv4fnTbeeYh3vbra5N7ikwTLfAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791396723;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ejZnjyq8vvNKMiciowZWBtvuaqNdaqyCzW0CMn0QARk=;
	b=s+yoj2vCRLHdEZ8YdmnGk9b4dGCmPSSDCdYbzKZDa7Nywin3MsRZglMhnRKd4FeyQFez
	 rCGl6KkIN9ifVf5AlMoxXQhPsfrwu3ZLmLxYFS8w5x5H3RrGzDiaXEjto5PyFfAXnW21g
	 KPFLj4taDSVKbeix+hkf8jSWqxzCgrPah4SqeqQ0BRj6eF8+FULskyuG1JrUNPNOuzv6j
	 0xwUfI36doAW9jO4TiXgGsW/8MgrvXnBz1Ow8Orkm8JHSL27vjHWRFC4UJhQMvErObYOM
	 I9xifuxuopdeSmuhQ7MCdia2rkV4wh+R3yuWBEwRgpm47WD0P0aOJGOhpN2JlN3z7fQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mqChl6jc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hIMjHNCD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791396723;
	bh=ejZnjyq8vvNKMiciowZWBtvuaqNdaqyCzW0CMn0QARk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DD7lrHoJPo894xZ47VXVflyogQtNiPSdRZ0309XgZszsInCv9fJRxPI9Z9ZW8LJzi
	 BlQYVOk8ZE/zNz1P7RGoETeR0czB+BcoL9vo/BiAapYPqrzKrJmi5J7WlPTlzeXhAL
	 ozj94rqDWWswJkqxXAXjDjFRvkais4eAk2U7WE9Z2iBCSNPAMap0arsambXNQ6XGcO
	 yj8UXJvp4ZmZo/RYGE7WO8+TmlGMU185v1lSPJF3RHID4U/LMR2lSiUQwDn7nrFbd9
	 IOiDPYlui97xCTwJbJ+cUYdjzcLzlvGWPhgVzmYm4kaFnqdOzMNT2CcXFnJstb2q41
	 m05lEtmUI436g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7DC260BBD;
	Wed,  7 Oct 2026 18:12:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 52E5732F
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 17:44:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4CCC1708C8
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 17:44:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rxjtkqDufURu for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 17:44:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E3F9770462
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791394952;
 b=ZsEHCETltRYvanGvB+AqOvwCdTtmAcqGz4KvGgdkxVYC+t4lq929OI2W1M9fuGeOe0+v
 xtghnog2Tc/5xpvT3DeSoghtWzJRLt7eHMwSlefyJmXPSOkhH7yrrzAM+J78WR6JSZfKt
 PvrntycVSOLTBOuwAnfssfy73ens7LW+hEFIID5V+Eku9wUlKogZdidWojOeelv2pjEgg
 zlO2dNvlZy9KepeI0Z1w7PCadM3K+GHK03icAuwCWGcubAwY6vfdJX1Ygf16D1PnPufr4
 C3jvmGIIKxIqNGnQ4AkDyTrz+gAapilsv3Af4Y9quZ2RP6e4yDEt5VTaB2ftQgtegGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791394952;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=ejZnjyq8vvNKMiciowZWBtvuaqNdaqyCzW0CMn0QARk=;
 b=Ol1sO6UvtAPndRi0FUsfrPteDp7lY0FRO9DU95CfBjqNXNRHOF16BpNOCFy5e3++tuQ3
 eJ3nxFfGhM7iv8fe2SrAIxtcKaQz9EgonHyZZ6kPBaveeOy+JTxcEDtKRHW9/hhGRE4ul
 0laiMOFzpemVbE6B1QY2MA9jMxjl33oFfoE8fHwoyZdXqlyYmhCD7poRqPR6eMj0kuBu+
 u7gwPbwKr4osM6NdFrx2bageYs7iDzxpRQrEEmkAW9ykV+dOTb3lY53QEKy6S1yPkcxsM
 D+c4kEZGnhUxPMaDDBTNIkgyPGkFJQ5a9BQJEg99K1SE1rdnOkIxnLGhQUWNd+guaxQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=mqChl6jc; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hIMjHNCD; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=gurumoorthy.santhakumar@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=mqChl6jc; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hIMjHNCD
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E3F9770462
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 17:42:31 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697EtUjw2809041
 for <u-boot@lists.u-boot-project.org>; Wed, 7 Oct 2026 17:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ejZnjyq8vvN
 KMiciowZWBtvuaqNdaqyCzW0CMn0QARk=; b=mqChl6jc5FU5y7EuQ4Ao3IH9D4F
 Ys3k4posPffy+9Ld2vFEtqssZ7b1XGsYkdsrB9PlnjnFHYWuqNx2IOPiaUCkPNnL
 R+6Uht5L3GTbSGwtVl4m/MOWKnwfsdP82UMd71i9heUICeGyURKHzD5Odh5sNkaR
 UHaLie+yIYGgTd7jQEkAE3zLu0aYzePTE8cIqBauC6qQB8C/NZsQS9wmmwAv8doj
 GPqxGXyuJ2HCeNST+2fCVuqu05kLkAJ78N77lcJ00Oi3hM3BexjGHbJlGK45B738
 mF22Sshf8c5ot50NWmsqZscB2KUeNzxRbdfB/6uXhjXy0OuZyje0EHmUiPA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fw8tnq7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 17:42:30 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34d62bb27a1so18031169eec.0
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 10:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791394950; x=1791999750;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ejZnjyq8vvNKMiciowZWBtvuaqNdaqyCzW0CMn0QARk=;
 b=hIMjHNCDiD5xhUgsJepc1BUy7PwcoHahYbyUgBhcqMk3IdBJ77oEXBctXTlbmFiiPJ
 NkszUmP8JE80LmfV+pqYvkGeJ/s6vpIhAd2BBtL/6xIqGNzG8OEM2POW1TdgLnh2Aj5H
 Gz44bu8cJHDU1Gh+YUR37m4C4z5nDWE9CpeS6pJTFY5ZJK+pGigx73Hi+KIzzxJu2vjl
 68uBJ4KAsfphH1mEeujCdOVxnI4zYbtOkWPvZil59vbwZL1m5N2Zw013dEwuEm6hPAbM
 DTX4ncP0eoWYHf6JX3sSLDGuCka5f9ss60jhVVkTyl1x34RPI1oYfFp/twF9inrCcVBn
 kN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791394950; x=1791999750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ejZnjyq8vvNKMiciowZWBtvuaqNdaqyCzW0CMn0QARk=;
 b=xtGgX9WOrLp5HsMNuG45ql+8C8z1ZZbZXgB0Z12JYLBIk8t+XnXmAhBNGYPOcIRm0L
 l0q2DdgPKb2IZuFMRixIcwOxOsOKvLnFmFQ1ck5oVC/tRqAPcrP/c0Nx8Si4tbb2vpCH
 fcWuP1IIvi3POoe313WmjU2+SkwEcEukZ2Ermtj+Uw5FFFyqGNVVqTH1hPZUvx+TW4V9
 QBWNVSJVefHBpUMDae16xUdFqhR7fb/B15grOAkHO4WgUUgaNMRHc8xInGmMVSL64nt5
 L/oQCfK/fTUMpWB7SICwFQz4vMYt2M67JnL9xD0EfAuabjOW92v2/b6A7agv8cB5FHXI
 JfoQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUSEqZ5I+hCrb5owGuWSCyC6CTTGnG2d7vT5OoGEOXt1+bo4bRujx+7VbuMyalvc3rDz6wYQE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLCKklYyRZDSYyUcsIvEmGv8bz6C1gt2/UpybNnVZeKjkF4T6xr
 iqDNGR8rJDjoL6NXB3I7LlTkBmiFy6cHfNGb1PB1QSFTzSjt9ivjqJkNU6NSRpyK8WaSm3tTVid
 AAXch+zjVUfo49+WADGShHCw0bO2NxBDiHMlPKf7bYKvsHOTH05XQpQqGC8YL79hVlwVxad0=
X-Gm-Gg: AYBFou0yrxV3syMSbndsbB1K1GkeayvGXv963e5PLSLPDxnM0bXcTSTwztoReBWPqb1
 f1uEi/9MGHqMcsqgHefYTIFQSZjdOALkxdPY2/uanx0/ZWWQB1VtNYqHYcFMDW1HJ4f0cb55xYB
 OQJKCOodYyUU+2qoO5KCpXwHtmC/vvy9HZdKF7zRjUGLsbrw6Zr9cL9joMi5LI8dMzAKX5Jp4o5
 cywGT3k1iZG2xTmbf622nOiPn3JiYw76sZqNeCGBH0MdrTD8+49IWhPUsXMLeqh0XPcZe705pGD
 ZtYyHSVBb2gdT4VmgQacTnhOhkOGob4cr/ceXDpzVm90CtvP/Ut+AtNGOIKuwdYAIlMvtdLTlUi
 LR2wh57X/7ZjxB4B3UAPCA4xGD27cnv/QPl2HeXOijzNQ3cQAUC+cmtxza9f5FjiNNBUp7NKeLX
 7bVA+0J85tOsbtsF9mIUQ11JKa/7Ku6L7xhg==
X-Received: by 2002:a05:7300:3a97:b0:343:f1fc:9006 with SMTP id
 5a478bee46e88-3515de7effbmr2912812eec.30.1791394949677; 
 Wed, 07 Oct 2026 10:42:29 -0700 (PDT)
X-Received: by 2002:a05:7300:3a97:b0:343:f1fc:9006 with SMTP id
 5a478bee46e88-3515de7effbmr2912776eec.30.1791394949016; 
 Wed, 07 Oct 2026 10:42:29 -0700 (PDT)
Received: from hu-gsanthak-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515abb779dsm8486756eec.1.2026.10.07.10.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 10:42:28 -0700 (PDT)
From: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com, hs@nabladev.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v1 1/5] i2c: geni: Add 32MHz clock and chip probing support
Date: Wed,  7 Oct 2026 23:11:47 +0530
Message-Id: <20261007174151.2590649-2-gurumoorthy.santhakumar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007174151.2590649-1-gurumoorthy.santhakumar@oss.qualcomm.com>
References: <20261007174151.2590649-1-gurumoorthy.santhakumar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3MCBTYWx0ZWRfX/TfW/Qzufbjb
 L4pTtox4HDF+S0xHWpBI8JytVHBoMe4dzKV94nrJVCVJH2+vxpOj544XMxm4llZMq1ZtKJA+mZ5
 9liZ4tDg7excdvK8C7WMtVoX6ZxDVjk=
X-Proofpoint-ORIG-GUID: 3upVc8QsW-kSVxHZu70GrGgkr80vr52_
X-Proofpoint-GUID: 3upVc8QsW-kSVxHZu70GrGgkr80vr52_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3MCBTYWx0ZWRfX3OCSvM8FtiM7
 gq6/KRB0paozSOBLS43BilQXJGiB9Y8lVU8n9d8yCZcqO8gpBbaaapUOpvUGDl24JNNbD5TxB+L
 J+mWfVIQIGoUSQwJ9RT3ANt2etHCbNKctwNRApAKE99gXY+F+vOyOohj0YvppEbwEr4PZkBEV2g
 Fr4ZFjHCCJ6+JtuyUBP7+2fzD5KWwSbk09e0tRzOytNYu8/KjClhEM4QOwqAB0sIbJFxUXQwMUv
 DjCkXrM0M1p9iksoANku7ixYu/+RNZuhUOJ2p5q0Tg1xYba4C9XMYrsWriOyQmKL+yYh8Ctedpq
 9qkyAN1VzFQi0vY6NDvAzhdlEtKteuzcOwu3K8xC2qeH4QsCy42ziHxOJGdGb2rMFCcSRhzp5mA
 b90Y1md1x5vko6UAiFQD36nGrDKsS6aSILtkVEMwFs61/oY1zX2UlGMzjHWYCOzdK9sRuueQHz6
 jcsTbBwNts88M/sNrfw==
X-Authority-Analysis: v=2.4 cv=Af0kjHXG c=1 sm=1 tr=0 ts=6ac68486 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=O9WzaHAwASXt8hbFy1sA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1011 impostorscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070070
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

Add support for 32MHz GENI SE clocks through dedicated timing tables
selected via the qcom,geni-se-clk-32mhz DT property. Also add chip
probing support.

Depends on:
misc: qcom_geni: Add minicore support
Link: https://lore.kernel.org/u-boot/20261005-spl-v10-1-c4ca29bf27ed@oss.qualcomm.com/

Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
---
 drivers/i2c/geni_i2c.c | 76 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
index 7498cbcb41a..9edba3dd551 100644
--- a/drivers/i2c/geni_i2c.c
+++ b/drivers/i2c/geni_i2c.c
@@ -96,18 +96,35 @@ struct geni_i2c_priv {
  * clk_freq_out = t / t_cycle
  * source_clock = 19.2 MHz
  */
-static const struct geni_i2c_clk_fld geni_i2c_clk_map[] = {
-	{I2C_SPEED_STANDARD_RATE, 7, 10, 11, 26},
-	{I2C_SPEED_FAST_RATE, 2,  5, 12, 24},
-	{I2C_SPEED_FAST_PLUS_RATE, 1, 3,  9, 18},
+static const struct geni_i2c_clk_fld geni_i2c_clk_map_19p2mhz[] = {
+	{I2C_SPEED_STANDARD_RATE, 7, 10, 12, 26},
+	{I2C_SPEED_FAST_RATE, 2,  5, 11, 22},
+	{I2C_SPEED_FAST_PLUS_RATE, 1, 2,  8, 18},
 };
 
-static int geni_i2c_clk_map_idx(struct geni_i2c_priv *geni, unsigned int clk_freq)
+/* source_clock = 32 MHz */
+static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
+	{I2C_SPEED_STANDARD_RATE, 12, 9, 10, 26},
+	{I2C_SPEED_FAST_RATE, 4,  3, 9, 19},
+	{I2C_SPEED_FAST_PLUS_RATE, 2, 3, 5, 15},
+};
+
+static int geni_i2c_clk_map_idx(struct geni_i2c_priv *geni,
+				unsigned int clk_freq, bool use_32mhz)
 {
-	const struct geni_i2c_clk_fld *itr = geni_i2c_clk_map;
+	const struct geni_i2c_clk_fld *itr;
+	int array_size;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(geni_i2c_clk_map); i++, itr++) {
+	if (use_32mhz) {
+		itr = geni_i2c_clk_map_32mhz;
+		array_size = ARRAY_SIZE(geni_i2c_clk_map_32mhz);
+	} else {
+		itr = geni_i2c_clk_map_19p2mhz;
+		array_size = ARRAY_SIZE(geni_i2c_clk_map_19p2mhz);
+	}
+
+	for (i = 0; i < array_size; i++, itr++) {
 		if (itr->clk_freq_out == clk_freq) {
 			geni->clk_fld = itr;
 			return 0;
@@ -262,6 +279,38 @@ static int geni_i2c_xfer_rx(struct geni_i2c_priv *geni, struct i2c_msg *msg, u32
 	return geni_i2c_fifo_rx_drain(geni, msg);
 }
 
+/* Probe to see if a chip is present. */
+static int geni_i2c_probe_chip(struct udevice *dev, uint chip_addr,
+			       uint chip_flags)
+{
+	struct geni_i2c_priv *geni = dev_get_priv(dev);
+	u32 m_param = (chip_addr << SLV_ADDR_SHFT) & SLV_ADDR_MSK;
+	u32 status;
+	ulong start;
+
+	(void)chip_flags;
+
+	/* Add delay before chip detect to prevent the bus going undefined. */
+	mdelay(1);
+
+	qcom_geni_i2c_conf(geni);
+	writel(0, geni->base + SE_I2C_TX_TRANS_LEN);
+	geni_i2c_setup_m_cmd(geni, I2C_ADDR_ONLY, m_param);
+	writel(1, geni->base + SE_GENI_TX_WATERMARK_REG);
+
+	start = get_timer(0);
+	while (get_timer(start) < I2C_TIMEOUT_MS) {
+		status = readl(geni->base + SE_GENI_M_IRQ_STATUS);
+		if (status & M_CMD_DONE_EN) {
+			writel(status, geni->base + SE_GENI_M_IRQ_CLEAR);
+			return (status & SE_I2C_ERR) ? -ENODEV : 0;
+		}
+		udelay(10);
+	}
+
+	return -ETIMEDOUT;
+}
+
 static int geni_i2c_xfer(struct udevice *bus, struct i2c_msg msgs[], int num)
 {
 	struct geni_i2c_priv *geni = dev_get_priv(bus);
@@ -468,6 +517,8 @@ static int geni_i2c_probe(struct udevice *dev)
 	ofnode parent_node = ofnode_get_parent(dev_ofnode(dev));
 	struct geni_i2c_priv *geni = dev_get_priv(dev);
 	u32 proto, tx_depth, fifo_disable;
+	u32 clk_freq;
+	bool use_32mhz;
 	int ret;
 
 	geni->is_master_hub = dev_get_driver_data(dev) & GENI_I2C_IS_MASTER_HUB;
@@ -538,19 +589,24 @@ static int geni_i2c_probe(struct udevice *dev)
 	geni_i2c_config_packing(geni, BITS_PER_BYTE,
 				PACKING_BYTES_PW, true, true, true);
 
-	/* Setup for standard rate */
-	return geni_i2c_clk_map_idx(geni, I2C_SPEED_STANDARD_RATE);
+	clk_freq = dev_read_u32_default(dev, "clock-frequency",
+					I2C_SPEED_STANDARD_RATE);
+	use_32mhz = dev_read_bool(dev, "qcom,geni-se-clk-32mhz");
+
+	return geni_i2c_clk_map_idx(geni, clk_freq, use_32mhz);
 }
 
 static int geni_i2c_set_bus_speed(struct udevice *dev, unsigned int clk_freq)
 {
 	struct geni_i2c_priv *geni = dev_get_priv(dev);
+	bool use_32mhz = dev_read_bool(dev, "qcom,geni-se-clk-32mhz");
 
-	return geni_i2c_clk_map_idx(geni, clk_freq);
+	return geni_i2c_clk_map_idx(geni, clk_freq, use_32mhz);
 }
 
 static const struct dm_i2c_ops geni_i2c_ops = {
 	.xfer		= geni_i2c_xfer,
+	.probe_chip	= geni_i2c_probe_chip,
 	.set_bus_speed	= geni_i2c_set_bus_speed,
 };
 
-- 
2.34.1

