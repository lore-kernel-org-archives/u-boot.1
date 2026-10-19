Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEFCCCF2D6
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 11:45:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F2C4406BE;
	Mon, 19 Oct 2026 11:45:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id awEPIbwKHHO0; Mon, 19 Oct 2026 11:45:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 35BEB40699
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792410348;
	b=YgMP0Ki7SN7/Tsb1lcCh3t2M2sK4Vq0IlM29LMwXcSqh+Zb43uxcHYx11O64Zu+9FQcw
	 ha1bHRZyS0GXNqWplBM3O+eXkIgaFWNxXxFeOn9sLRCxgSonvmQ5/XwWoKLyHxVX4yWuW
	 Yzt/Z/7v/Zw8iGWUJ2EGUHUGL4V7/iJ8rWw5UDNpD5ZSZQLtP6l+IgbciMDWr/hn+vFBm
	 RjJCOZhtrxkpWQpSur8W70jQjUagj30dAcgnrUClUhJMmnp9QYd8yq3Xt4kNnzoVQp8ew
	 VZa1BxCpFnp3yAdWdS0pp0/uPe1OwvXNmNYxq7RGV+G/G3fUuGqmt6WTTh7rgNgm0JQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792410348;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=v89NQ4ysCSx4ZRscDTsq73dtu1D4cJKMdH5Whohsf3Y=;
	b=mxuCxOI2G57AlAgSLEisZLDaj4DUcQtsfionwCgYuDvhdbMiNLRKitCjxM0dtueWNjAC
	 9WALn7PeJc4RXNNty1bCiuC3cErtS115YNemjWVOigszeZE0+/rk0Iz6bauowDD0Nf8mI
	 b2goPEttdEexmY/qiZTeMcFCnKJbwHEEAK9ISKSg4pAFIOY4+IpUVNLaZPLrCIhhOF+id
	 gelzdw4OqA8mfV2RtUc+nCXdec65GA9QdXP648EtxnypdzkMAaxEL5+ZbH6nH3WbXlsNl
	 tMNHNxJyRoIcpB0CwZ479Adj9QB+t6auvYvacztCPkoNV8zY5ZDO4FVUHe5oah+hJKg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792410348;
	bh=v89NQ4ysCSx4ZRscDTsq73dtu1D4cJKMdH5Whohsf3Y=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0MvVX1cLF0q/iIYHEUDdVD93qQVwuX0sNT7+Sj4eaQgg3E0eBZbk02G4HbKjxe8LO
	 KSq3j/g9c03cSZS7D+ZS5IxHls7E3DdhIvo/5s5PXCpqfbtTSIJFTL8lo1lJH7l+AI
	 hz0B5DYEVWS6IFybhx5xQLYrbiyXwO2Aeqte/uWNS5anwDVPWgCh119QVvk3UfH84R
	 J/stVMXe0ODEGVYVy0PfsSVRgIqf8Qv4TrGuwbOO7fSN7eqvJBh4pZLMJzM6C+i2rl
	 ZS/C1Wx1T0nlsHcCY0M4LzEmZv8WYoL29ax5zG10zP6yf3eexNcRMESpSEgO/GXjfv
	 G36JMqBhPImKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35BEB40699;
	Mon, 19 Oct 2026 11:45:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 929011DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:45:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F77640080
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:45:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w6QLz3WsTQ9Y for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 11:45:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9F2D340079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792410345;
 b=ARd7NstO7rbyHi4ovC0GeE7GxNdAvsS14ej6WCmdrk3u0LQHEfLOv5pEEiRmSM3Di09u
 rtS0VGXQ2wuOLr0sADYJ+4NWvwP2mcUt3t8Rs/DRxbWdEISxHTBeMP6/NS3ArSOaf8Cxm
 9/74UnVfWxToewLXAsFa/e1VOFVodrfAAuKop+bm4D517+Q0WLQ+Ua+UtsfooT86zZjv/
 C02rrS3KXpspctNxLYn0Ygc5kU8GzTnQdqhT8MAaglz1Ilnn269/uGPKtrz7j0iWyS7+z
 1xK+TW/LooKwz36Sf1iJZkCBptbTIDeAbQdWIFjKLvWtosGEbCMkD4jB0/9euU/ZICg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792410345;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=v89NQ4ysCSx4ZRscDTsq73dtu1D4cJKMdH5Whohsf3Y=;
 b=LY6IbKxXTZGrZNQ4qKW0ASjqdeY0m/EiHKT34+Yco4mBuRzu0UK/UztrKZVZ+mA6GwI5
 uApUYlOUNn/+Q3HpacxnMVyNJBsbSuEigHXA6UfgwWGsRTGTU56d2zJ1/hRhT5eLLc7rf
 2ZvOVVlI/focjctTdJZ3atcQgLLQtrFwErRQ28tu6K6ckg2quRbScf0VhnA3Roa5qOQbS
 W9MXXi9DPKtymHvthl1RiACn4uc2gYPkd5GBGD9pRaBKovE6cx3YMEtcHoe+9XdNQFMNO
 ks9hr4oDtk+Ps1mC+IIMz74yUkAng4gMPE61YnuXBCHUI6GLPhOCjd0leJTlevr7HsA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=QfX3i+f3; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bEfqwd1U; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=QfX3i+f3; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bEfqwd1U
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F2D340079
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:45:44 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8P5jB1896526
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=v89NQ4ysCSx4ZRscDTsq73
 dtu1D4cJKMdH5Whohsf3Y=; b=QfX3i+f3OJoZ6ojbcsJ/9tq3qNlBHr+1GDr0uQ
 lMLista5C3UL+QPCaqm+o/mjhheeNFF9m/G84BxukRtM8wt2bDWOycrHTjpQeqjj
 wcPGi6wtRzbqWFVpgfhwCeTvT/A9iCbN0J47RYTKZM2IFqZD8VCLlWrc+xTQV4Lg
 tZVPsUPdKAC6z4bCWuhT9EslNPQHAGft9l0LBNqkdq30KXWMQkRtvC/AnHLiSpsp
 jKCtQcmFE5ANCgBaHTSCV8MqLt0jy4mUgZF5CaI5OMMeBxK7ReiKYX2v+t72fM1o
 c5xSzVQeAxMK2BQVch6JuQY62V1wqbhhHympCqWUbJMaeV1w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdbvr9pf3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 11:45:43 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso4019084eec.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 04:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792410342; x=1793015142;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=v89NQ4ysCSx4ZRscDTsq73dtu1D4cJKMdH5Whohsf3Y=;
 b=bEfqwd1UKMxpfOMI/qxAw2TuyoOeodrD6bKghfrZktRwaNZaAbYnxDQe6pxwSDcQD/
 GCC4+DKW8xkj0cWNCRoFnSO6MYiz8MlQ4EvxqMmVnTp4Zm75zbSUCatp1WseRF50DXVm
 I5XPrIIrZNTKgwJJp1UAoaK/+tM4TBDV/S1rdYKMn2cVHPQs9S3JulVin3sxybATI2nA
 Q+FchJIccl97TVb8H99weh5hTlSaJUscCeKEGaS7DUuRrbV2w6NnYhad1U6FGuxV3/Su
 wSDkywXB6N9xD9oJX1n7pdHR6TkY0JAkbB5Opp4ct1AgokMyePj9A9UKyEKxkvCQvYiN
 CsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792410342; x=1793015142;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=v89NQ4ysCSx4ZRscDTsq73dtu1D4cJKMdH5Whohsf3Y=;
 b=Q3eGue5mXT3gopWYpyuUtlg34u9vvdqWKeKlk80r64pNsc4VHSjQXwp1Z85bkwAzYG
 nzc7j8b0XNMst/049yk1OZUbOmgh3m++9jaAJMRcoxzzZIXVz9hDpwz5RPm4dOmeNWbU
 pXFkNPyC57il4tJuophqlpilifW3D23UnSTSSKzfRMdcBF3O0pDp4qJAbfl0ykCMb+iJ
 sCzr8iOBkTjPAnjDKeiwUKMEB8inHexg0IQvc7vY+KI1XOf3G9p/y5qUtxjOXoCOykhu
 /jWf1IBbIlvOnOTQHImFFE3paGILlWnkHCyOrzkdgyFs8x3yXRKyMNZBUAoDtV54Cegh
 pTmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMQRmurd/IA3dMegsYY8N84IQfntYufNMzsYzarbhCj3tGOpxo2cKTBsKqS8wbrPumWo/xj9E=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJChhYgXAZqh62ryfkpCXn906+ze3Ar5VDc3AxAugqMXn+Hxmev
 1J7JVz4ikoXTGZnMuVqFDOaOja0cI50UUjfX6QthuPTSCP1GuTlp49bB1WcM3rQWaFM/9MuVk8o
 +jvmQn+sS23toY2BpFQNrBVjEt4aPHV9X2nDT232BPXSxsmw1WkgYqjAKVb/y8T9VBGJQv6M=
X-Gm-Gg: AYBFou06JfrJ94iyYEyYwAfr2O5DiR0B0IX0KNz0BD4yYrIYXjgDDB9p9Ch+g0I5mnf
 xrTfJxee6IMcjvTqUVv3AZ+WgII7gm00/nPArgTi6Nsr/He1o4bmbl0UsIJGQcqNkH0BtcXZwW7
 bJjuIdeP52fEwAiBdqiJOp3eX1UAQN6zVKmayJhlL2MXy4qfn01TACVHYEH/141Yv4YDjhXmA6f
 m/aTPT6KQC4NO6MOoW8E3wz/qa7m4f4WjAFeGneiBPr8cnWF0bEx2MRioJNjg4/J/MtT3w4/UVE
 g4+9R0ViL8ceeYODlTmsdMQsZGGBrDmIGE2yaNYWvTVCtmLeMEYKOzXz/LRDApTHQsAdB/ZArD6
 WsIjfpqxELTJRg1Ft4AdfwyyvRvAaWDaxZ4m0f1lGJBEWbFClXplWWGc0JNLOaLis4f1lZCXs0C
 yacaUhDWWHdivdQQH8Zy6srOAi/eI=
X-Received: by 2002:a05:7301:648b:b0:35e:5ca:e0df with SMTP id
 5a478bee46e88-361a2448d7emr10417426eec.35.1792410341935; 
 Mon, 19 Oct 2026 04:45:41 -0700 (PDT)
X-Received: by 2002:a05:7301:648b:b0:35e:5ca:e0df with SMTP id
 5a478bee46e88-361a2448d7emr10417386eec.35.1792410341206; 
 Mon, 19 Oct 2026 04:45:41 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3607ee0cc23sm36979202eec.2.2026.10.19.04.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 04:45:40 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 17:15:36 +0530
Subject: [PATCH] configs: qcom_lemans_defconfig: enable Super Speed USB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-lemans-enable-ss-usb-v1-1-d2fd08603459@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAN8C1moC/x3MQQqAIBBA0avErBtQqcCuEi3UphowC4ciiO6et
 HyL/x8QykwCffVApouF91Sg6wrC6tJCyFMxGGU6rbTFSJtLgpScj4QieIrHNhgbvNWNNQFKemS
 a+f63w/i+H0xb17VmAAAA
X-Change-ID: 20261019-lemans-enable-ss-usb-5c29cb91492c
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792410338; l=1264;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=PjG0oRUWc8IMUUW+lailA4NxmhkQOcfr2xVGF8zEBjA=;
 b=Ab+TkmMDKCz4oqZheVkj0Keo/5IfCsewilkd4OtF9vgnqrvUrdYEfz2/10cp/2PLS78n1WpYO
 0cp4xbjg3jwB0mdw51lJ73IxrgFR2jWLY0Fi6es4Ou9qYjKNevn7kA0
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NiBTYWx0ZWRfX6iijGl+RpSN4
 wKvuJDtsVd+/ZWS5hQXfAHI+2XruyT8QE5uEB0phl1URSiked4JMmJs6Qwz0DRGPONI+TKrqcLw
 uWzaB11OtK7+vYvXH7KKkKeBecO3kzAg/7CkHUT9XI0y2DVEtbehJM0nhTJXrzfxVljl4urU1Ci
 AdAjZy0ErF2uMDlN10rMsZ/h0B63ekxbG+CLGAEpjrgkVpok3Giy5P9QJUj79nlIFLwRq626uzW
 7EmgH6MoIyXX4eOqhNQc2tVI3Any33antzBGt1yM4KpOLHII9o7q3Orrk8XxnsbDXFktKJPtPUw
 0ZqZtUiLnjyeJDC9NsV9ZSZIsNj88toshXIEDzp0It7LgOk8aFagE7k+7bwDehN7F8C9KnJZLMM
 GgnalfDCh3MeN1sOSt/qcd4dl2c7vgmZffJHBsmHfkNWMrsPeSfLqwhwkNXOCOOGrfyPLcIjw1A
 wvMmbnlI47Ww/dnWXqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NiBTYWx0ZWRfX94vbgansdEjt
 O4/RPPzsDKIhRTASLgMCYGg9LjYyjKWTE9VT5OSHdDEx36UQYL6nyOEfPFb68D+eGdpu8XqEGyg
 xdYRtqZ7YODmPvPOj5r018rc1z4YKmQ=
X-Proofpoint-GUID: 3TdAYXdST7dNR15MG74nCCiK2dFiM0_s
X-Authority-Analysis: v=2.4 cv=K/+3jCWI c=1 sm=1 tr=0 ts=6ad602e7 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4eok9udz5NSA9M4s0oIA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 3TdAYXdST7dNR15MG74nCCiK2dFiM0_s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190046
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

Enable PHY_QCOM_QMP_USB config in configs/qcom_lemans_defconfig to
enable Super Speed USB.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
This patch depends on the following series:

1. "Enable fastboot support for IPQ9574 based boards", which adds the
   QMP USB PHY driver:
   https://lore.kernel.org/u-boot/20260806-fastboot-v1-4-cab7d64e592b@oss.qualcomm.com/

2. "configs: Rename qcs9100 defconfig to lemans defconfig" (v2), which
   creates configs/qcom_lemans_defconfig:
   https://lore.kernel.org/u-boot/20261009115920.2021086-1-aswin.murugan@oss.qualcomm.com/
---
 configs/qcom_lemans_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_lemans_defconfig b/configs/qcom_lemans_defconfig
index 1710e317fc0..8542016e9b0 100644
--- a/configs/qcom_lemans_defconfig
+++ b/configs/qcom_lemans_defconfig
@@ -16,3 +16,5 @@ CONFIG_ENV_SCSI_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"
 # CONFIG_ENV_IS_NOWHERE is not set
 
 CONFIG_WATCHDOG_AUTOSTART=y
+
+CONFIG_PHY_QCOM_QMP_USB=y

---
base-commit: 4a7115657c2d9bee8e37b42c31212a1b9d79a699
change-id: 20261019-lemans-enable-ss-usb-5c29cb91492c

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

