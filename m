Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70327606A31B
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 06:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xqLPLF3V;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UxPxNGz3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WY2IbWDT
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CE85402B1;
	Wed, 21 Oct 2026 06:43:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iRJ7wHAwm-UO; Wed, 21 Oct 2026 06:43:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A26A44082F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792565021;
	b=O81K+gVeMHa3Dr4Q9Pi6tbEM5T270+aMIE2teouQkK0Q9f96aUwr6M+9Wn4l/EO6OdBO
	 l8v9f0vKNyqbrTCC+9jSrT1sjm7P+gN/Ct6c7d2PQUd7wbLX6F2UYdV9ojRL0PMljsP2o
	 dQ0NS+RijsCMuh64EAIhZkanNA3nPYwwxVfWZLBTPdM0S5holyu8yqtrF1d8f+DHK11w5
	 k22yewn/ZjDATAepsiqkb2JEOtVAzFwUuzs0LAJr/7rdLwkEFyOqMI75JvX/Rj7kFyniA
	 uAtsEFu72ndXpncvbLr3NMdYQWGMzgt9iJmjzzxWx2VGPy7u2XiEFtZmuoqVYaTBkJQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792565021;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=T5wYB9TBJMYHkCFXXlAE3wYWPfjg+UwdwuAodcrJvSU=;
	b=JUj8570xqTn8We4HPuG0xi8m82SzNfJsqySHbtYxPbVYu0CUUqyDTUtD/79FlzE9lEFs
	 IZjGvADW0jhAyB1LMmqcB2rOnTxHZGKO1V/DXLv9v0z5mHW9tzsu0oIGVqXhFPs5FTQP9
	 l9bmZeP4uifTueBnnnjsNkCnyn2HVFkTL2+1LefVzYqC7oAeZZQwAg16DqRpN//WZWGAi
	 wBqWLto7p+1mH8bJUSCBRGCmk2VTvQ26iP6y+vxltDYMNvpkq/JFPg+pHA3eh/WB8zV/E
	 0uZGb9mSGv0U29a7tSFHNmgJTq5/jPZetBwxnJtpp+fCVhmFgGRAGby1XNR3mLMtBXg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792565021;
	bh=T5wYB9TBJMYHkCFXXlAE3wYWPfjg+UwdwuAodcrJvSU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xqLPLF3V3XuMUHP/swVSSZu7H8NO+mvHZU0aBebgD2WsYmG/i79wfoYbHZJ3frtfL
	 /uSjYZX3+DFTdwjRgf83mkdtEAxzVn/2+xPKyH0JYLt1nmJk7VgYyNpkzAfcBg8hrF
	 ZRSahB41sTXtmRv+f1vwtOeFPG3AbKeLeWclyzlp/zQqanaB30Jgzss5MEgHZxIbEU
	 0WLOPES21DTTAcw8fPjWDCXzUu2TwIn/JBymeMODG4Un7PbFMaVf8/osEkj53KqkQV
	 r2e8VEGZKQFvNWqH6RTvNnb4HRSvvRKBzOLLizTyrwIOdRb77gc/kkHDdGdYr/yAPa
	 Oao40M6sz0bKw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A26A44082F;
	Wed, 21 Oct 2026 06:43:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DD7BA995
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CA10740380
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5f2JoFL8Ewi0 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 06:43:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org AC99340253
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792565019;
 b=S6/lNeHYQCPd3b/aDVd0FY0DiSCRPWl7CN6UHVnfgy7gVJP4h4g/r9QswRHEkgkciyTj
 Ydz/ZGkZxAdIfuAZbjN7F6NNQx7jNbUf+bpXKa0f7FZQV619sfkJJ332bIw75NBk2Z6tK
 c77ZaeBr7GcweSO08oaPq+xd5UW/qX694b4+FnVdbYWXmY41oOguxFJL/m7Zdfxc9zQXQ
 ZvUBmaVa/RPEoY5cHvs0I8SdZFrCgxh2y4ZEijoaziSpxsEpMv+m94U8/pkx98YGKwOEb
 VPLFr9sFoKHSPCvgZO+0GrZ/oDzHeBuEEWwmpgbLKvua6bAPeS6Wf6tLj8M4TVQ6+DQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792565019;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=T5wYB9TBJMYHkCFXXlAE3wYWPfjg+UwdwuAodcrJvSU=;
 b=qKFQsCWitxaaIN1RQ8Dh0WTAC/FXSd8pkhtto9/P29dMmOd/uBua/RTCvItvKV2zuyW9
 Qu4jLStKKeDY1OsKj8jYbOj0eYBe5iG4ueFnSGX0sMHy1QaCQKAmZsCsgOmCfTVb6s8y1
 qtX78JwXHI3FF06FO8lQ9loWqxP3DeyRTbRPTvtuDkbWKM+bmpJfOLLIMqi8C/jwpElJc
 5vvt5014GJ5EOKlOudDwbvlC3d/sUJ8rSGwi0P6ZbCWme0llKdpoDmkS2F9mCMckwh2aW
 wK6ZZ7O8VcZXz3LQWqC2tjySay8dQPFue5hENqX3d24UQvbqU3asfeO91CXQPJ2NjTQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=UxPxNGz3; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WY2IbWDT; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=UxPxNGz3; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=WY2IbWDT
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AC99340253
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:38 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5jJCn2848275
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T5wYB9TBJMYHkCFXXlAE3wYWPfjg+UwdwuAodcrJvSU=; b=UxPxNGz32PHlo+AS
 R4f0s7N6kb3yZRh+6ygGbsCvbIcpAL1GUK317ZdvF0rojU3rkALKn8KW9vo7DeQ1
 SCEuGKgi0qRwHaulyzEZFMapmVH8hY9Wdpb1vXL22AKMoaWPi95GaRrnudJzL/is
 VQpMgVI8E6PHyp1eskPGBnaUydCQGefBivVJzlIxhz6O2VLJLzqViUKVjdsjyBNr
 xNDxnn6YeCFXW8eHL/nXJJHzOvizbhelQtUKy2WYn7GV8C9hetvqivQX0Po4ctXi
 EkE/O28/PiIlNA3ihTGAADUPTdVKBJwxFuJgrc/sSvPacrHavobpKwACSKpiAPM0
 Aap2RA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heeb9a5uh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:43:36 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35c3c370b17so561718eec.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 23:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792565016; x=1793169816;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T5wYB9TBJMYHkCFXXlAE3wYWPfjg+UwdwuAodcrJvSU=;
 b=WY2IbWDT71HZEBmPJaDCPerJNkbRaE9vY/E48xD2/IKA/E67d9Ynejbscm2coPMym6
 UF72k3F6R/RpOwwPmamwb7p96bsF0C1DSRTzShKp1YeVDydjWUA3Zg5Cva+cLOMzcFGY
 /aWMbejlURTpqIHxmflIGCdKVifGzfYFzGh53W449qEa0u52tSgdUypi7c9vr9aYElh/
 kYZIEibiLun6u+S4jJ3zuqRazew8X2bAmsvLkHq4X6AYPp7cT0R108eHciSTQYAjEgyu
 kbnn+Qof5J7F7gKQSHF/wWOysjCVOr5ufx2SI1rDWSUXg5aD1PcxpmDt7Y9ToDznv8cW
 AVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792565016; x=1793169816;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T5wYB9TBJMYHkCFXXlAE3wYWPfjg+UwdwuAodcrJvSU=;
 b=W1neEvmBnllOmfNfWrjS9eIj9VmYbDBMBbgNc45FNZjaK6XFDmIJ1+FjVfGHzep7hW
 QG3MyNkwFe3hK0FnZH434+8O69pQcuPmPAFEb/iDMIVfmnpGULuMHTYWt1aDvSAcyPwG
 j02zUJh+RsSjsflICJO44gAaL2JQ2rXVp4UsmfvZ04hcXw9Ymdu385w/p4wmtsxDgAuX
 9c4HCEVKg+JVOxFV8FcIUPlE3HfAc0yni3aOhHimcakrlYrBCymIJ9lTYd40gUqb6MHf
 6FUm5vxYYhH1+XAz5xibOEO5jx2WPiCQX6EUY9X5Q4kf69zItSXpDyoUXZhg8u3UK5iI
 sh4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjqLH+OqtVpwtV+LEmpGAvrvGgYuw7NLDAbnbHipHvpCbh+nPlalgHIYiBzrPtbPSz1kyH+vI=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLGflGBuLmEImKJlPGNVNRZrVxSEc1xiIlJHqZOOiu2I1e9X8hW
 ZpN9LM3c1dF7HLvAy05izit8zpLqebD1GCr150RMT2WXaW0/jVNiKseUAyFRwNNyatXS9Za2aVB
 kZKakQgsq+sc35ZdLy5JYT5MiOqY0js0xu8dtRMuOiUm7F5x2bDZy4i2W0cgCYAlR70/ovDs=
X-Gm-Gg: AYBFou0MmUigRzCNDp7INgTQuP64Bu/VRFJKFcGcNgtJs+jvqR2qFEbP2IBhmgzsdQ4
 4n8aQibr7sAAt84fZFVDKIk2P2uidJd2tnD2OAMegOs0+ShLYKZj904MCmKzBiiX3h2ovZcCXMF
 rmZUkg4w/22Isa1tLPAgRSQbbxJYP79lOaq01mFLskGyFPqls+jumuUghZCSEOXf2auUME2T0CJ
 WQaSO/mGdBiqUeKA3XGX9Y0TnwC1uWGigIfIxKMsrbMF0CONkKg0YpLgO+KbPjgkP329+Cvq6hH
 /nIzI+2I7YGnCR8OLiCgoMwZWYM6TJcgk2u/LB67JGxmJMa7GxKXjb2L48Odzx8kqU6MNUpws4D
 7LdX+SPNaTPglgFhSEDmCXe42UzHW7qI+Cxq1UXw30BcvJP+ffvl6r3Y7GnboEW1VSQW/pAQfCY
 QBJ6EPM5fPsmsINMGVqsVoaaBo0zCQ
X-Received: by 2002:a05:7301:2514:b0:34b:b410:9352 with SMTP id
 5a478bee46e88-3674b53165bmr2271991eec.1.1792565015418; 
 Tue, 20 Oct 2026 23:43:35 -0700 (PDT)
X-Received: by 2002:a05:7301:2514:b0:34b:b410:9352 with SMTP id
 5a478bee46e88-3674b53165bmr2271957eec.1.1792565014654; 
 Tue, 20 Oct 2026 23:43:34 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-367411bd27dsm4547476eec.17.2026.10.20.23.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 23:43:34 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 12:13:12 +0530
Subject: [PATCH v4 3/5] pinctrl: qcom: Add QCS8300 pinctrl driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-b4-monaco-v4-3-c90f0c01d312@oss.qualcomm.com>
References: <20261021-b4-monaco-v4-0-c90f0c01d312@oss.qualcomm.com>
In-Reply-To: <20261021-b4-monaco-v4-0-c90f0c01d312@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Biswapriyo Nath <nathbappai@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 William Bright <william.bright@imd-tec.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792564992; l=20925;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=y0axIkk5gCGRvI4d7Exzc+3TTTrNTRKlS0YH5mTx18g=;
 b=cYgBxOii0Dss/oGT2rxOJqZ6FIZO5lFusO9yYR01Sm8wMgeNZFVSPgcSFbmCqtvtEv8wGBu6E
 udibBLV3WKUCt2+/VJvq5FuVdiqEhGIBZS0i0+jD/obX3+Yp4uqQQiT
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyNiBTYWx0ZWRfX1jcty9Ew2GpA
 /yPVFzK/oYCRJ/hyCpuyFNH/rGZ82GNHT9aLCKTqMcvfkESFtLW48SmXaxuau4OXbPzNKRmVoxB
 TnPBGDEGjNFLeEdVDbgLsSDkd5Bhw+o=
X-Proofpoint-GUID: zbS9MTMp82eHpTr24bVPmgh1AscUbKew
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyNiBTYWx0ZWRfX9ecmXbp7X7lQ
 3UNQwmBIdrlr5tj1qWOMwILZawyJLLxmL2R+yhXXVpb2JeugGgl3oatNzoobubLnVVHteUGXq0L
 QXxxdCcTKXY3M/eDYCvBzqUUpI12LbgdcBUsC8lxL4BYE39PZhCwQRHBvzl+EIiHHj7s0wl4rB2
 KagmA1eo9JUtL2MaBsHTRGEUQ4fvyojw9QC9fdrXW3Y+YDDAv+9T02gbOpBekkRDZ0CuvZVmpkn
 fjN25RK0k1BCV3GbjJ6JkTcJ5L7CgneQ88vaay+MOdFkbNGGZyEibC/VI+8I6hTdWI/h1+oDBS3
 rF2/kB2vbJNpNzS7NsAg5q03RIIPjHh+ficM23YvyFnL15XA1ZloVrfCzRodLSS/Kqc0dhXazYN
 dfiYEPSzMccJulKfm8HUC56+sP2fGegU96JCqtn2cRkFTuX7dDEfCwq/eUzlYTOI7a6/zX/utQM
 cUS8D7Av5MYjxdC6b/g==
X-Authority-Analysis: v=2.4 cv=R42WitRX c=1 sm=1 tr=0 ts=6ad85f18 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=rbbR4xNNEzaiD-aHh9EA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: zbS9MTMp82eHpTr24bVPmgh1AscUbKew
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210026
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add pinctrl support for QCS8300.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/Kconfig           |   8 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-qcs8300.c | 468 +++++++++++++++++++++++++++++++++
 3 files changed, 477 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 7dd3782c14b..fa0385f159a 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -86,6 +86,14 @@ config PINCTRL_QCOM_QCS615
 	  Say Y here to enable support for pinctrl on the Snapdragon QCS615 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_QCS8300
+	bool "Qualcomm QCS8300 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon QCS8300 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_SA8775P
 	bool "Qualcomm SA8775P Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index a7a9ad03569..97d59f5eac0 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_PINCTRL_QCOM_MILOS) += pinctrl-milos.o
 obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
 obj-$(CONFIG_PINCTRL_QCOM_QCS615) += pinctrl-qcs615.o
+obj-$(CONFIG_PINCTRL_QCOM_QCS8300) += pinctrl-qcs8300.o
 obj-$(CONFIG_PINCTRL_QCOM_SA8775P) += pinctrl-sa8775p.o
 obj-$(CONFIG_PINCTRL_QCOM_SC7180) += pinctrl-sc7180.o
 obj-$(CONFIG_PINCTRL_QCOM_SC7280) += pinctrl-sc7280.o
diff --git a/drivers/pinctrl/qcom/pinctrl-qcs8300.c b/drivers/pinctrl/qcom/pinctrl-qcs8300.c
new file mode 100644
index 00000000000..91f7c4fcf1e
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-qcs8300.c
@@ -0,0 +1,468 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm QCS8300 pinctrl
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define MAX_PIN_NAME_LEN 32
+#define MSM_PIN_FUNCTION_COUNT 12
+
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+typedef unsigned int msm_pin_function[MSM_PIN_FUNCTION_COUNT];
+
+#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9, f10, f11)\
+	{\
+		msm_mux_gpio, /* gpio mode */\
+		msm_mux_##f1,\
+		msm_mux_##f2,\
+		msm_mux_##f3,\
+		msm_mux_##f4,\
+		msm_mux_##f5,\
+		msm_mux_##f6,\
+		msm_mux_##f7,\
+		msm_mux_##f8,\
+		msm_mux_##f9,\
+		msm_mux_##f10,\
+		msm_mux_##f11 /* egpio mode */\
+	}
+
+#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)\
+	{\
+		.name = pg_name,\
+		.ctl_reg = ctl,\
+		.io_reg = 0,\
+		.pull_bit = pull,\
+		.drv_bit = drv,\
+		.oe_bit = -1,\
+		.in_bit = -1,\
+		.out_bit = -1,\
+	}
+
+#define UFS_RESET(pg_name, ctl)\
+	{\
+		.name = pg_name,\
+		.ctl_reg = ctl,\
+		.io_reg = ctl + 0x4,\
+		.pull_bit = 3,\
+		.drv_bit = 0,\
+		.oe_bit = -1,\
+		.in_bit = -1,\
+		.out_bit = 0,\
+	}
+
+enum qcs8300_functions {
+	msm_mux_gpio,
+	msm_mux_aoss_cti,
+	msm_mux_atest_char,
+	msm_mux_atest_usb2,
+	msm_mux_audio_ref,
+	msm_mux_cam_mclk,
+	msm_mux_cci_async,
+	msm_mux_cci_i2c_scl,
+	msm_mux_cci_i2c_sda,
+	msm_mux_cci_timer,
+	msm_mux_cri_trng,
+	msm_mux_dbg_out,
+	msm_mux_ddr_bist,
+	msm_mux_ddr_pxi0,
+	msm_mux_ddr_pxi1,
+	msm_mux_ddr_pxi2,
+	msm_mux_ddr_pxi3,
+	msm_mux_edp0_hot,
+	msm_mux_edp0_lcd,
+	msm_mux_edp1_lcd,
+	msm_mux_egpio,
+	msm_mux_emac0_mcg0,
+	msm_mux_emac0_mcg1,
+	msm_mux_emac0_mcg2,
+	msm_mux_emac0_mcg3,
+	msm_mux_emac0_mdc,
+	msm_mux_emac0_mdio,
+	msm_mux_emac0_ptp_aux,
+	msm_mux_emac0_ptp_pps,
+	msm_mux_gcc_gp1,
+	msm_mux_gcc_gp2,
+	msm_mux_gcc_gp3,
+	msm_mux_gcc_gp4,
+	msm_mux_gcc_gp5,
+	msm_mux_hs0_mi2s,
+	msm_mux_hs1_mi2s,
+	msm_mux_hs2_mi2s,
+	msm_mux_ibi_i3c,
+	msm_mux_jitter_bist,
+	msm_mux_mdp0_vsync0,
+	msm_mux_mdp0_vsync1,
+	msm_mux_mdp0_vsync3,
+	msm_mux_mdp0_vsync6,
+	msm_mux_mdp0_vsync7,
+	msm_mux_mdp_vsync,
+	msm_mux_mi2s1_data0,
+	msm_mux_mi2s1_data1,
+	msm_mux_mi2s1_sck,
+	msm_mux_mi2s1_ws,
+	msm_mux_mi2s2_data0,
+	msm_mux_mi2s2_data1,
+	msm_mux_mi2s2_sck,
+	msm_mux_mi2s2_ws,
+	msm_mux_mi2s_mclk0,
+	msm_mux_mi2s_mclk1,
+	msm_mux_pcie0_clkreq,
+	msm_mux_pcie1_clkreq,
+	msm_mux_phase_flag,
+	msm_mux_pll_bist,
+	msm_mux_pll_clk,
+	msm_mux_prng_rosc0,
+	msm_mux_prng_rosc1,
+	msm_mux_prng_rosc2,
+	msm_mux_prng_rosc3,
+	msm_mux_qdss_cti,
+	msm_mux_qdss_gpio,
+	msm_mux_qup0_se0,
+	msm_mux_qup0_se1,
+	msm_mux_qup0_se2,
+	msm_mux_qup0_se3,
+	msm_mux_qup0_se4,
+	msm_mux_qup0_se5,
+	msm_mux_qup0_se6,
+	msm_mux_qup0_se7,
+	msm_mux_qup1_se0,
+	msm_mux_qup1_se1,
+	msm_mux_qup1_se2,
+	msm_mux_qup1_se3,
+	msm_mux_qup1_se4,
+	msm_mux_qup1_se5,
+	msm_mux_qup1_se6,
+	msm_mux_qup1_se7,
+	msm_mux_qup2_se0,
+	msm_mux_sailss_emac0,
+	msm_mux_sailss_ospi,
+	msm_mux_sgmii_phy,
+	msm_mux_tb_trig,
+	msm_mux_tgu_ch0,
+	msm_mux_tgu_ch1,
+	msm_mux_tgu_ch2,
+	msm_mux_tgu_ch3,
+	msm_mux_tsense_pwm1,
+	msm_mux_tsense_pwm2,
+	msm_mux_tsense_pwm3,
+	msm_mux_tsense_pwm4,
+	msm_mux_usb2phy_ac,
+	msm_mux_vsense_trigger,
+	msm_mux__,
+};
+
+#define MSM_PIN_FUNCTION(fname)\
+	[msm_mux_##fname] = {#fname, msm_mux_##fname}
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	MSM_PIN_FUNCTION(gpio),
+	MSM_PIN_FUNCTION(aoss_cti),
+	MSM_PIN_FUNCTION(atest_char),
+	MSM_PIN_FUNCTION(atest_usb2),
+	MSM_PIN_FUNCTION(audio_ref),
+	MSM_PIN_FUNCTION(cam_mclk),
+	MSM_PIN_FUNCTION(cci_async),
+	MSM_PIN_FUNCTION(cci_i2c_scl),
+	MSM_PIN_FUNCTION(cci_i2c_sda),
+	MSM_PIN_FUNCTION(cci_timer),
+	MSM_PIN_FUNCTION(cri_trng),
+	MSM_PIN_FUNCTION(dbg_out),
+	MSM_PIN_FUNCTION(ddr_bist),
+	MSM_PIN_FUNCTION(ddr_pxi0),
+	MSM_PIN_FUNCTION(ddr_pxi1),
+	MSM_PIN_FUNCTION(ddr_pxi2),
+	MSM_PIN_FUNCTION(ddr_pxi3),
+	MSM_PIN_FUNCTION(edp0_hot),
+	MSM_PIN_FUNCTION(edp0_lcd),
+	MSM_PIN_FUNCTION(edp1_lcd),
+	MSM_PIN_FUNCTION(egpio),
+	MSM_PIN_FUNCTION(emac0_mcg0),
+	MSM_PIN_FUNCTION(emac0_mcg1),
+	MSM_PIN_FUNCTION(emac0_mcg2),
+	MSM_PIN_FUNCTION(emac0_mcg3),
+	MSM_PIN_FUNCTION(emac0_mdc),
+	MSM_PIN_FUNCTION(emac0_mdio),
+	MSM_PIN_FUNCTION(emac0_ptp_aux),
+	MSM_PIN_FUNCTION(emac0_ptp_pps),
+	MSM_PIN_FUNCTION(gcc_gp1),
+	MSM_PIN_FUNCTION(gcc_gp2),
+	MSM_PIN_FUNCTION(gcc_gp3),
+	MSM_PIN_FUNCTION(gcc_gp4),
+	MSM_PIN_FUNCTION(gcc_gp5),
+	MSM_PIN_FUNCTION(hs0_mi2s),
+	MSM_PIN_FUNCTION(hs1_mi2s),
+	MSM_PIN_FUNCTION(hs2_mi2s),
+	MSM_PIN_FUNCTION(ibi_i3c),
+	MSM_PIN_FUNCTION(jitter_bist),
+	MSM_PIN_FUNCTION(mdp0_vsync0),
+	MSM_PIN_FUNCTION(mdp0_vsync1),
+	MSM_PIN_FUNCTION(mdp0_vsync3),
+	MSM_PIN_FUNCTION(mdp0_vsync6),
+	MSM_PIN_FUNCTION(mdp0_vsync7),
+	MSM_PIN_FUNCTION(mdp_vsync),
+	MSM_PIN_FUNCTION(mi2s1_data0),
+	MSM_PIN_FUNCTION(mi2s1_data1),
+	MSM_PIN_FUNCTION(mi2s1_sck),
+	MSM_PIN_FUNCTION(mi2s1_ws),
+	MSM_PIN_FUNCTION(mi2s2_data0),
+	MSM_PIN_FUNCTION(mi2s2_data1),
+	MSM_PIN_FUNCTION(mi2s2_sck),
+	MSM_PIN_FUNCTION(mi2s2_ws),
+	MSM_PIN_FUNCTION(mi2s_mclk0),
+	MSM_PIN_FUNCTION(mi2s_mclk1),
+	MSM_PIN_FUNCTION(pcie0_clkreq),
+	MSM_PIN_FUNCTION(pcie1_clkreq),
+	MSM_PIN_FUNCTION(phase_flag),
+	MSM_PIN_FUNCTION(pll_bist),
+	MSM_PIN_FUNCTION(pll_clk),
+	MSM_PIN_FUNCTION(prng_rosc0),
+	MSM_PIN_FUNCTION(prng_rosc1),
+	MSM_PIN_FUNCTION(prng_rosc2),
+	MSM_PIN_FUNCTION(prng_rosc3),
+	MSM_PIN_FUNCTION(qdss_cti),
+	MSM_PIN_FUNCTION(qdss_gpio),
+	MSM_PIN_FUNCTION(qup0_se0),
+	MSM_PIN_FUNCTION(qup0_se1),
+	MSM_PIN_FUNCTION(qup0_se2),
+	MSM_PIN_FUNCTION(qup0_se3),
+	MSM_PIN_FUNCTION(qup0_se4),
+	MSM_PIN_FUNCTION(qup0_se5),
+	MSM_PIN_FUNCTION(qup0_se6),
+	MSM_PIN_FUNCTION(qup0_se7),
+	MSM_PIN_FUNCTION(qup1_se0),
+	MSM_PIN_FUNCTION(qup1_se1),
+	MSM_PIN_FUNCTION(qup1_se2),
+	MSM_PIN_FUNCTION(qup1_se3),
+	MSM_PIN_FUNCTION(qup1_se4),
+	MSM_PIN_FUNCTION(qup1_se5),
+	MSM_PIN_FUNCTION(qup1_se6),
+	MSM_PIN_FUNCTION(qup1_se7),
+	MSM_PIN_FUNCTION(qup2_se0),
+	MSM_PIN_FUNCTION(sailss_emac0),
+	MSM_PIN_FUNCTION(sailss_ospi),
+	MSM_PIN_FUNCTION(sgmii_phy),
+	MSM_PIN_FUNCTION(tb_trig),
+	MSM_PIN_FUNCTION(tgu_ch0),
+	MSM_PIN_FUNCTION(tgu_ch1),
+	MSM_PIN_FUNCTION(tgu_ch2),
+	MSM_PIN_FUNCTION(tgu_ch3),
+	MSM_PIN_FUNCTION(tsense_pwm1),
+	MSM_PIN_FUNCTION(tsense_pwm2),
+	MSM_PIN_FUNCTION(tsense_pwm3),
+	MSM_PIN_FUNCTION(tsense_pwm4),
+	MSM_PIN_FUNCTION(usb2phy_ac),
+	MSM_PIN_FUNCTION(vsense_trigger),
+};
+
+static const msm_pin_function qcs8300_pin_functions[] = {
+	[0] = PINGROUP(0, _, _, _, _, _, _, _, _, _, _, _),
+	[1] = PINGROUP(1, pcie0_clkreq, _, _, _, _, _, _, _, _, _, _),
+	[2] = PINGROUP(2, _, _, _, _, _, _, _, _, _, _, _),
+	[3] = PINGROUP(3, phase_flag, _, _, _, _, _, _, _, _, _, _),
+	[4] = PINGROUP(4, sgmii_phy, qdss_cti, _, _, _, _, _, _, _, _, _),
+	[5] = PINGROUP(5, emac0_mdc, qdss_cti, _, _, _, _, _, _, _, _, _),
+	[6] = PINGROUP(6, emac0_mdio, _, _, _, _, _, _, _, _, _, _),
+	[7] = PINGROUP(7, usb2phy_ac, _, _, _, _, _, _, _, _, _, _),
+	[8] = PINGROUP(8, usb2phy_ac, _, _, _, _, _, _, _, _, _, _),
+	[9] = PINGROUP(9, phase_flag, _, _, _, _, _, _, _, _, _, _),
+	[10] = PINGROUP(10, qup2_se0, emac0_mcg0, _, _, _, _, _, _, _, _, _),
+	[11] = PINGROUP(11, qup2_se0, emac0_mcg1, _, _, _, _, _, _, _, _, _),
+	[12] = PINGROUP(12, qup2_se0, _, _, _, _, _, _, _, _, _, _),
+	[13] = PINGROUP(13, qup2_se0, _, _, _, _, _, _, _, _, _, _),
+	[14] = PINGROUP(14, qup2_se0, tb_trig, _, _, _, _, _, _, _, _, _),
+	[15] = PINGROUP(15, qup2_se0, _, sailss_ospi, sailss_emac0, _, _, _, _, _, _, _),
+	[16] = PINGROUP(16, qup2_se0, _, _, sailss_ospi, sailss_emac0, _, _, _, _, _, _),
+	[17] = PINGROUP(17, qup0_se0, qup0_se1, ibi_i3c, _, _, _, _, _, _, _, _),
+	[18] = PINGROUP(18, qup0_se0, qup0_se1, ibi_i3c, _, _, _, _, _, _, _, _),
+	[19] = PINGROUP(19, qup0_se1, qup0_se0, cci_timer, ibi_i3c, _, _, _, _, _, _, _),
+	[20] = PINGROUP(20, qup0_se1, qup0_se0, cci_timer, ibi_i3c, _, _, _, _, _, _, _),
+	[21] = PINGROUP(21, qup0_se5, cci_timer, _, _, _, _, _, _, _, _, _),
+	[22] = PINGROUP(22, pcie1_clkreq, qup0_se5, cci_timer, _, _, _, _, _, _, _, _),
+	[23] = PINGROUP(23, qup0_se5, cci_timer, qdss_cti, _, _, _, _, _, _, _, _),
+	[24] = PINGROUP(24, qup0_se5, emac0_ptp_aux, emac0_ptp_pps, qdss_cti, emac0_mcg2, _, _, _, _, _, _),
+	[25] = PINGROUP(25, qup0_se3, phase_flag, _, _, _, _, _, _, _, _, _),
+	[26] = PINGROUP(26, qup0_se3, phase_flag, _, _, _, _, _, _, _, _, _),
+	[27] = PINGROUP(27, qup0_se3, _, _, _, _, _, _, _, _, _, _),
+	[28] = PINGROUP(28, qup0_se3, phase_flag, _, _, _, _, _, _, _, _, _),
+	[29] = PINGROUP(29, qup0_se4, cci_i2c_sda, cci_async, emac0_ptp_pps, tgu_ch2, _, _, _, _, _, _),
+	[30] = PINGROUP(30, qup0_se4, cci_i2c_scl, cci_async, emac0_ptp_pps, tgu_ch3, _, _, _, _, _, _),
+	[31] = PINGROUP(31, qup0_se4, cci_i2c_sda, cci_async, emac0_ptp_aux, _, _, _, _, _, _, _),
+	[32] = PINGROUP(32, qup0_se4, cci_i2c_scl, emac0_ptp_aux, mdp_vsync, _, _, _, _, _, _, _),
+	[33] = PINGROUP(33, qup0_se2, qdss_gpio, _, _, _, _, _, _, _, _, _),
+	[34] = PINGROUP(34, qup0_se2, qdss_gpio, _, _, _, _, _, _, _, _, _),
+	[35] = PINGROUP(35, qup0_se2, gcc_gp1, _, _, _, _, _, _, _, _, _),
+	[36] = PINGROUP(36, qup0_se2, gcc_gp2, qdss_gpio, _, _, _, _, _, _, _, _),
+	[37] = PINGROUP(37, qup1_se0, ibi_i3c, qup1_se1, aoss_cti, _, _, _, _, _, _, _),
+	[38] = PINGROUP(38, qup1_se0, ibi_i3c, qup1_se1, aoss_cti, _, _, _, _, _, _, _),
+	[39] = PINGROUP(39, qup1_se1, ibi_i3c, qup1_se0, aoss_cti, _, _, _, _, _, _, _),
+	[40] = PINGROUP(40, qup1_se1, ibi_i3c, qup1_se0, aoss_cti, _, _, _, _, _, _, _),
+	[41] = PINGROUP(41, qup1_se3, _, _, _, _, _, _, _, _, _, _),
+	[42] = PINGROUP(42, qup1_se3, _, mdp_vsync, _, _, _, _, _, _, _, _),
+	[43] = PINGROUP(43, qup0_se7, _, tgu_ch0, _, _, _, _, _, _, _, _),
+	[44] = PINGROUP(44, qup0_se7, _, tgu_ch1, _, _, _, _, _, _, _, _),
+	[45] = PINGROUP(45, qup1_se4, hs1_mi2s, _, _, _, _, _, _, _, _, _),
+	[46] = PINGROUP(46, qup1_se4, hs1_mi2s, _, _, _, _, _, _, _, _, _),
+	[47] = PINGROUP(47, qup1_se4, hs1_mi2s, _, _, _, _, _, _, _, _, _),
+	[48] = PINGROUP(48, qup1_se4, hs1_mi2s, edp0_lcd, _, _, _, _, _, _, _, _),
+	[49] = PINGROUP(49, qup1_se5, hs2_mi2s, cci_timer, qdss_cti, edp1_lcd, ddr_pxi1, _, _, _, _, _),
+	[50] = PINGROUP(50, qup1_se5, hs2_mi2s, cci_timer, qdss_cti, _, ddr_pxi1, _, _, _, _, _),
+	[51] = PINGROUP(51, qup1_se5, hs2_mi2s, qdss_cti, _, _, _, _, _, _, _, _),
+	[52] = PINGROUP(52, qup1_se5, hs2_mi2s, qdss_cti, mdp_vsync, ddr_pxi2, _, _, _, _, _, _),
+	[53] = PINGROUP(53, ddr_bist, _, _, _, _, _, _, _, _, _, _),
+	[54] = PINGROUP(54, cci_i2c_sda, phase_flag, ddr_bist, _, _, _, _, _, _, _, _),
+	[55] = PINGROUP(55, cci_i2c_scl, phase_flag, ddr_bist, _, _, _, _, _, _, _, _),
+	[56] = PINGROUP(56, phase_flag, ddr_bist, _, _, _, _, _, _, _, _, _),
+	[57] = PINGROUP(57, cci_i2c_sda, prng_rosc0, qdss_gpio, _, _, _, _, _, _, _, _),
+	[58] = PINGROUP(58, cci_i2c_scl, prng_rosc1, qdss_gpio, _, _, _, _, _, _, _, _),
+	[59] = PINGROUP(59, cci_i2c_sda, prng_rosc2, qdss_gpio, _, _, _, _, _, _, _, _),
+	[60] = PINGROUP(60, cci_i2c_scl, prng_rosc3, qdss_gpio, _, _, _, _, _, _, _, _),
+	[61] = PINGROUP(61, cci_i2c_sda, qdss_gpio, _, _, _, _, _, _, _, _, _),
+	[62] = PINGROUP(62, cci_i2c_scl, qdss_gpio, _, _, _, _, _, _, _, _, _),
+	[63] = PINGROUP(63, cci_timer, cci_async, qdss_gpio, atest_usb2, _, _, _, _, _, _, _),
+	[64] = PINGROUP(64, cci_timer, cci_async, qdss_gpio, atest_usb2, _, _, _, _, _, _, _),
+	[65] = PINGROUP(65, cci_timer, cci_async, qdss_gpio, atest_usb2, _, _, _, _, _, _, _),
+	[66] = PINGROUP(66, phase_flag, _, atest_char, _, _, _, _, _, _, _, _),
+	[67] = PINGROUP(67, cam_mclk, vsense_trigger, atest_usb2, _, _, _, _, _, _, _, _),
+	[68] = PINGROUP(68, cam_mclk, gcc_gp4, atest_usb2, ddr_pxi0, _, _, _, _, _, _, _),
+	[69] = PINGROUP(69, cam_mclk, gcc_gp3, atest_usb2, ddr_pxi0, _, _, _, _, _, _, _),
+	[70] = PINGROUP(70, qdss_gpio, atest_char, _, _, _, _, _, _, _, _, _),
+	[71] = PINGROUP(71, qdss_gpio, atest_char, _, _, _, _, _, _, _, _, _),
+	[72] = PINGROUP(72, qdss_gpio, atest_char, _, _, _, _, _, _, _, _, _),
+	[73] = PINGROUP(73, _, qdss_gpio, _, _, _, _, _, _, _, _, _),
+	[74] = PINGROUP(74, pll_clk, qdss_gpio, atest_usb2, _, _, _, _, _, _, _, _),
+	[75] = PINGROUP(75, _, dbg_out, qdss_gpio, atest_usb2, _, _, _, _, _, _, _),
+	[76] = PINGROUP(76, gcc_gp5, tsense_pwm4, _, _, _, _, _, _, _, _, _),
+	[77] = PINGROUP(77, gcc_gp5, tsense_pwm3, _, _, _, _, _, _, _, _, _),
+	[78] = PINGROUP(78, tsense_pwm2, _, _, _, _, _, _, _, _, _, _),
+	[79] = PINGROUP(79, emac0_ptp_aux, emac0_ptp_pps, emac0_mcg3, _, tsense_pwm1, _, _, _, _, _, _),
+	[80] = PINGROUP(80, qup0_se6, mdp0_vsync6, _, atest_usb2, ddr_pxi3, _, _, _, _, _, _),
+	[81] = PINGROUP(81, qup0_se6, mdp0_vsync7, gcc_gp2, _, atest_usb2, ddr_pxi3, _, _, _, _, _),
+	[82] = PINGROUP(82, qup0_se6, gcc_gp3, _, _, _, _, _, _, _, _, _),
+	[83] = PINGROUP(83, qup0_se6, gcc_gp4, _, atest_usb2, ddr_pxi2, _, _, _, _, _, _),
+	[84] = PINGROUP(84, qup1_se2, gcc_gp1, _, atest_usb2, _, _, _, _, _, _, _),
+	[85] = PINGROUP(85, qup1_se2, _, atest_usb2, _, _, _, _, _, _, _, _),
+	[86] = PINGROUP(86, qup1_se2, _, _, _, _, _, _, _, _, _, _),
+	[87] = PINGROUP(87, qup1_se2, _, atest_usb2, _, _, _, _, _, _, _, _),
+	[88] = PINGROUP(88, qup1_se2, _, _, _, _, _, _, _, _, _, _),
+	[89] = PINGROUP(89, qup1_se6, qup1_se7, mdp0_vsync0, _, _, _, _, _, _, _, _),
+	[90] = PINGROUP(90, qup1_se6, qup1_se7, mdp0_vsync1, cri_trng, _, _, _, _, _, _, _),
+	[91] = PINGROUP(91, qup1_se7, qup1_se6, mdp0_vsync3, cri_trng, _, _, _, _, _, _, _),
+	[92] = PINGROUP(92, qup1_se7, qup1_se6, cri_trng, _, atest_usb2, _, _, _, _, _, _),
+	[93] = PINGROUP(93, atest_char, _, _, _, _, _, _, _, _, _, _),
+	[94] = PINGROUP(94, edp0_hot, _, _, _, _, _, _, _, _, _, _),
+	[95] = PINGROUP(95, _, _, _, _, _, _, _, _, _, _, _),
+	[96] = PINGROUP(96, _, _, _, _, _, _, _, _, _, _, _),
+	[97] = PINGROUP(97, mi2s_mclk0, jitter_bist, qdss_gpio, _, _, _, _, _, _, _, _),
+	[98] = PINGROUP(98, mi2s1_sck, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _),
+	[99] = PINGROUP(99, mi2s1_ws, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _),
+	[100] = PINGROUP(100, mi2s1_data0, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _),
+	[101] = PINGROUP(101, mi2s1_data1, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _),
+	[102] = PINGROUP(102, mi2s2_sck, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _),
+	[103] = PINGROUP(103, mi2s2_ws, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _),
+	[104] = PINGROUP(104, mi2s2_data0, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _),
+	[105] = PINGROUP(105, mi2s2_data1, audio_ref, phase_flag, _, qdss_gpio, _, _, _, _, _, _),
+	[106] = PINGROUP(106, hs0_mi2s, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _),
+	[107] = PINGROUP(107, hs0_mi2s, pll_bist, phase_flag, _, qdss_gpio, _, _, _, _, _, _),
+	[108] = PINGROUP(108, hs0_mi2s, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _),
+	[109] = PINGROUP(109, hs0_mi2s, mi2s_mclk1, qdss_gpio, _, _, _, _, _, _, _, _),
+	[110] = PINGROUP(110, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _, egpio),
+	[111] = PINGROUP(111, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _, egpio),
+	[112] = PINGROUP(112, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _, egpio),
+	[113] = PINGROUP(113, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _, egpio),
+	[114] = PINGROUP(114, phase_flag, _, qdss_gpio, _, _, _, _, _, _, _, egpio),
+	[115] = PINGROUP(115, _, _, _, _, _, _, _, _, _, _, egpio),
+	[116] = PINGROUP(116, phase_flag, _, _, _, _, _, _, _, _, _, egpio),
+	[117] = PINGROUP(117, phase_flag, _, _, _, _, _, _, _, _, _, egpio),
+	[118] = PINGROUP(118, phase_flag, _, _, _, _, _, _, _, _, _, egpio),
+	[119] = PINGROUP(119, _, _, _, _, _, _, _, _, _, _, egpio),
+	[120] = PINGROUP(120, phase_flag, _, _, _, _, _, _, _, _, _, egpio),
+	[121] = PINGROUP(121, phase_flag, _, _, _, _, _, _, _, _, _, egpio),
+	[122] = PINGROUP(122, phase_flag, _, _, _, _, _, _, _, _, _, egpio),
+	[123] = PINGROUP(123, _, _, _, _, _, _, _, _, _, _, egpio),
+	[124] = PINGROUP(124, _, _, _, _, _, _, _, _, _, _, egpio),
+	[125] = PINGROUP(125, phase_flag, _, _, _, _, _, _, _, _, _, egpio),
+	[126] = PINGROUP(126, _, _, _, _, _, _, _, _, _, _, egpio),
+	[127] = PINGROUP(127, _, _, _, _, _, _, _, _, _, _, egpio),
+	[128] = PINGROUP(128, _, _, _, _, _, _, _, _, _, _, egpio),
+	[129] = PINGROUP(129, _, _, _, _, _, _, _, _, _, _, egpio),
+	[130] = PINGROUP(130, _, _, _, _, _, _, _, _, _, _, egpio),
+	[131] = PINGROUP(131, _, _, _, _, _, _, _, _, _, _, egpio),
+	[132] = PINGROUP(132, _, _, _, _, _, _, _, _, _, _, egpio),
+};
+
+static const struct msm_special_pin_data qcs8300_special_pins_data[] = {
+	[0] = UFS_RESET("ufs_reset", 0x92000),
+	[1] = SDC_QDSD_PINGROUP("sdc1_rclk", 0x89000, 15, 0),
+	[2] = SDC_QDSD_PINGROUP("sdc1_clk", 0x89000, 13, 6),
+	[3] = SDC_QDSD_PINGROUP("sdc1_cmd", 0x89000, 11, 3),
+	[4] = SDC_QDSD_PINGROUP("sdc1_data", 0x89000, 9, 0),
+};
+
+static const char *qcs8300_get_function_name(struct udevice *dev,
+					     unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *qcs8300_get_pin_name(struct udevice *dev,
+					unsigned int selector)
+{
+	if (selector >= 133 && selector <= 137)
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "%s",
+			 qcs8300_special_pins_data[selector - 133].name);
+	else
+		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+
+	return pin_name;
+}
+
+static int qcs8300_get_function_mux(__maybe_unused unsigned int pin,
+				    unsigned int selector)
+{
+	unsigned int i;
+	const msm_pin_function *func = qcs8300_pin_functions + pin;
+
+	for (i = 0; i < MSM_PIN_FUNCTION_COUNT; i++)
+		if ((*func)[i] == selector)
+			return i;
+
+	pr_err("Can't find requested function for pin %u\n", pin);
+
+	return -EINVAL;
+}
+
+static const struct msm_pinctrl_data qcs8300_data = {
+	.pin_data = {
+		.pin_count = 138,
+		.special_pins_start = 133,
+		.special_pins_data = qcs8300_special_pins_data,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = qcs8300_get_function_name,
+	.get_function_mux = qcs8300_get_function_mux,
+	.get_pin_name = qcs8300_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{
+		.compatible = "qcom,qcs8300-tlmm",
+		.data = (ulong)&qcs8300_data
+	},
+	{ /* Sentinel */ }
+};
+
+U_BOOT_DRIVER(pinctrl_qcs8300) = {
+	.name		= "pinctrl_qcs8300",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+	.flags		= DM_FLAG_PRE_RELOC,
+};

-- 
2.34.1

