Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C53CA600F
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 09:49:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EDF58122B;
	Thu,  8 Oct 2026 09:49:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lzh90jYKTHPZ; Thu,  8 Oct 2026 09:49:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 40FC281220
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791452974;
	b=lVDY8QergyPu1ingOXpZojwxogZrrVgzX2d6aqOVciqK7OrCosrfKtGJR+XDQsxcnvi6
	 gplPsE9wSuk6PHfgqnXY0pViS/nZJIfh/mDP0l804GQDBVre4KjxYLOT9HFX7pNAbRGm8
	 4PPRoa1Wk7VkHAFBQRDqrpqzAIb7jQn1/+46OMZc0TPoSuLJlcSXEHsZFKC68wf4ZUEvf
	 mjsZ+zvcM9ImGe1y7Jz9jNvL8VFmFs+ihraTGKq9KwpqCw3ndDOGKyqpeNVgpm0LYqneD
	 RHht+zWtYlNYETjInAdTL93n1+6TohtH07kdjvpm6QJnawtl2tvBS76Y09lEmzUVT/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791452974;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=6tCREOKYDTfhvuzey1in6iO8z4m/J2F6Nthv4/X+YuQ=;
	b=gVYrPSF5jhz5CDBIbfTKFuaKrBFsMLkkPHVpyRqysf94t2A0EHN2EfySw5viCn2hzLGG
	 aKWpLr3UuC1nIxLS+KSNZOEM2R3/0Rp32ByC4ND99cNV/siRWqxYN0GlX9pIZBUjxVwTy
	 DfrFdqXuFCOpFngsPXtfR9wUbRys7SHhfZZ9ILPnIAYXuOj6titVccBJqNNDn+j2B6YNu
	 /yKnARQFbt3tzDKNZT9l6Wx5o8Rya1+qVWvtdral62xW08Fl04A2Cl1NPoAk00J8eCpEy
	 Xt/gXADRv+YVT0jknT2NL0rEuV0fbvB1rwsTGmLCA48TmqsFDU3KPQcE1w4zYzx8nIg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791452974;
	bh=6tCREOKYDTfhvuzey1in6iO8z4m/J2F6Nthv4/X+YuQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UKnSkbr/ZBAVZoVbROsMJ8ma8Qsn0urY7EBWSRfvZRlWPHIUZPIL394hz60DdYhNu
	 SbsNT10pIQoXBOA5PN2E3/E9fWrvZbs6HeMA9LtW6a3Bqs0yr9lcwN3AedeXz3wNAR
	 1rWQ1hvVCqsF/1U32zybvWuFBbpk4gRk/pqya4WG8dtFJQBBBKGaz/8VDemnv3TwzY
	 tkJXWJmdxbXrbJmdPAhBysxh7HwAFJ5HYMl7tbaG2kRt0G3tCCR36bXDE6PhQqa+3Y
	 q6tqNX1cLE0TfUrtGQDbJ/JDJErxnzc8G3qEB7eTT75jA6qsvCTYqfOnotnXkP0gI0
	 UAktMjsoqyJmw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40FC281220;
	Thu,  8 Oct 2026 09:49:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EFE6E150D
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E20D2607D7
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q0rUS65xBWIz for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 09:49:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 814B460708
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791452967;
 b=paP1anBHmNt60OQsysetkwri0UorffxwEdW343QnPG1lN8k1jHzxbMNel7m0lTSumYVW
 aszFWZQCwdxqv5UjW5Sf6fXT8u0yqNBVt6ABxHjmJyA8lYYfob2Wpuvi/S8K7jZBWRbOW
 PNW+nHq2FxeLTJEUHdY4BpWskMKQLTipChxb8WG4M3XbNFzB6RFQ5znQ/QHCYMolm5JHE
 p9IbDM9AOfcwYOu9LS6w6UjWwbOsnn/+9McR+rPsWJHI9Ky3ygiHSvD7vW386xvpLGgM9
 jr77dwMeOrrtl16mDv2Z/Bm1YxUBoG4m1jbND3fqkx23Yciu5laM8fLaIBgoS6/yyRw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791452967;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=6tCREOKYDTfhvuzey1in6iO8z4m/J2F6Nthv4/X+YuQ=;
 b=fY0/q3n3pK9x54AjNybV62+5y4zVSb8a9iJtlHb4Y+p5UV89eTRUFcU2P5h6Dk9hoJ/h
 KQIYkpJTdBp7Z+F2cgpJ9dv+LCVLhjuLUpBCEZT+3Ym3EjwWrI6i1J936PLoc+9qMM8lx
 b2vGD8GvAxd1rmsd5/A5b3iU74hz7XiLPQtflwUl4m9L53za0BsrDjFZS3W6sWBE8I8Xx
 //otoyovwyLW10+mKVeU/Ke3EA09bVVI8EB6g2UlQutdOTss65OMg2IDmf7o//m2uhV0i
 Q7QZrxsXkDqIxNzpJNYR03TykonwJrDo2jOlcAt94JMxD/jW7y/BRywI6JhQjyBcg4A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=dURfoRJS; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dIuPjXqF; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=dURfoRJS; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=dIuPjXqF
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 814B460708
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 09:49:25 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6987K3sm1341772
 for <u-boot@lists.u-boot-project.org>; Thu, 8 Oct 2026 09:49:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6tCREOKYDTf
 hvuzey1in6iO8z4m/J2F6Nthv4/X+YuQ=; b=dURfoRJSGVtiw3GdiqKNobu0GYi
 7LjyTl1tqDq1Mhk4Rr8GujNmAMHV/HlScLXCw8clDuMxvE/sQQoy5gMUIHZNDrJJ
 FDjlGPZi336DS1GvSFkLyACuN+9mLgZNPfBT6iqVYLGMinbaX5XLZicVYoonuzkX
 +UiyfrzTg0gBZrPJV8P0BvvWRXAhDghD0vppkNeQ+vUTvLqx3XZ6LeBQg15dEYOP
 N+csM/BcckN8gZ41dMalciMZPDE0bN9Rw+dT59RRH2eAKlNNMV+SKNmHG32hpT8w
 nL8jtIM0UZGC4yuXnZMUzQUHkUS/v8omGwba7FXncQUsNpTNltli4904SIA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe2t9x9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 09:49:25 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-143826c4a13so3938209c88.1
 for <u-boot@lists.u-boot-project.org>; Thu, 08 Oct 2026 02:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791452965; x=1792057765;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6tCREOKYDTfhvuzey1in6iO8z4m/J2F6Nthv4/X+YuQ=;
 b=dIuPjXqFO3ZJ9JpoUspG//tROjWMSbkTkJy+bbnXRDTZ7q3wpsivZlzHWb5fww19Tk
 6GltE6UmZFYlAVyLj7wDPO+dQwCJ4YS7I0gagSboX9rd3AacftWl/37LFQIbKV5xyKOM
 s3brHdK0yLSmCGie2NPZwEZEc0K3QbHLhv/opOwiJwe2Z+sRYnM0xefkv6VaFly/Wgfl
 BPqGS8StG49l8Z4LagnmSWSFXT74tbO4DcciE8PNBHrES32QJoVQFmIviJWUOEn5tZ0V
 chhHQqKFs2qF8anRmjyW+Gp3DiTxXbsXiiv4yHeL809Ai5fpXt0sGP8D6rUIu0KgBK3h
 mfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791452965; x=1792057765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6tCREOKYDTfhvuzey1in6iO8z4m/J2F6Nthv4/X+YuQ=;
 b=pULoAomhZEEPLIbZ5MwB1ndsj3FrLZ8G0tLRiEGPMDwRYXKVo5sKqnmi9cUZf3wKOY
 tMyiXeCQgoATQdhRr1JiLBc1U8QMM5YjGG3Y8kGBgUeB6/Kankbn2aSzk4RbgPXha7oD
 qx3/je2WKwpH58j+UexlGvX4cjnT52geVg07r0YAGtXT8rr7VhTenuLw9rI/lfjtRXz8
 vvo+RmGfzzYJlgXxjwRZOPGgxcOlhZhNUEebQEp3ajs6lLsNNXQ9SnicLY9Dam/IYits
 CrmPPf8Wq9VAqycpRZO7FAXH/GUNjXeUz8XoCpSpY0l+roHfO93DQwviPVIwTXickv+x
 apOA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrlIzk2PmpymP07xr70Ag6TJSQ3wQzcs4OZZn1XG+/JIqPcgDPeeTmjzxwLabT16KhjZ+Slg8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lXKC0kyZHMB/raHq5ocdTxXfFc0DBeCOabjLwagOU2j7CcvdnB
 0YErrPRZCaGmXEI7JCquqJVItKn9gdiFibdLjQjp+PTcpQAt06cGkq7XcE44SUhr/5oxpoirLo8
 XLMN6Fkndr993xwPq1acaxwRQ05YmuslXgB4ZHip+RsQMQ/qnrsqwERxGg+aZkAhgbthjisc=
X-Gm-Gg: AYBFou0yQIEoWc+5pF6dqUawyzhFFhHl1gv0nTXvzmYKNIbBYabAkCx6tgBXsei4fe+
 rQZXRkkLMkwkKVa+IuiI+kQM85VSS76uqJC99niZ/jKbS8aGByA5vzeOcBVCzR3ip6vnKCt9Fg2
 x4XWXFfD54OAQB/Oz0zqMCd6hEg3w2z+73nNLa3+2SnhomIwCnMa9FTJtJSZr2FSw+x+g2sQjat
 bo9OSgf51PDoResdZ91aFj2EiQMHEhYE2oYqbxsT+asuamU1iQWqZbnatc1Nl9eoHCW/w8xEwWu
 VZNWF4aVtv8kWj9R5jnhGiXiCNMSSKSeB12TjW1RFS8vEALN2IxHtIBaPa2zo/RxrPjvmIZlRUA
 lKLEmhMbvtXztqD/pf6sYRfC1xJXKUQoTBDPdvFb+chqcpnc=
X-Received: by 2002:a05:7022:7e09:b0:14f:b80a:33a5 with SMTP id
 a92af1059eb24-16206475f27mr6770217c88.28.1791452964387; 
 Thu, 08 Oct 2026 02:49:24 -0700 (PDT)
X-Received: by 2002:a05:7022:7e09:b0:14f:b80a:33a5 with SMTP id
 a92af1059eb24-16206475f27mr6770176c88.28.1791452963699; 
 Thu, 08 Oct 2026 02:49:23 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-16375a1f898sm9977818c88.0.2026.10.08.02.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 02:49:23 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@nabladev.com,
 peng.fan@nxp.com, jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 abhilash.v@oss.qualcomm.com, sjg@chromium.org, Michael.Srba@seznam.cz,
 varadarajan.narayanan@oss.qualcomm.com, luca.weiss@fairphone.com,
 nikroks@mainlining.org, balaji.selvanathan@oss.qualcomm.com,
 jbx6244@gmail.com, u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v4 03/13] board: qualcomm: shikra: add SPL board support
Date: Thu,  8 Oct 2026 02:49:02 -0700
Message-Id: <20261008094912.419090-4-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
References: <20261008094912.419090-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX0IlEIA9nYqcm
 GINRiok3e8OdmGVDQKfTFOojdTT1Os7J9yxOP7WynnMIWre/WAKCxg+cDUSsTHH7DmR5/PaxEvC
 mAokdfH3pdv6Qa4gfDCtxveK3oAkflE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX5tOGCF9rZPiA
 JGEgiutFtbOugFpHUvtkWpoIi0s/DGsfL0PQKvZHC/p3jR1j766JxzuEX/JwrTxgVoevXc0NV7G
 ePuWA9qLaU2jtU/CuQaDetHPrOtuNyOiabwKgtL/8iqdCeVB7jehIMLBA3F16k3Vb4sFq60M5Pu
 keecBnV/faJt1kOL38zoKSSCRhp+L05ZcWJSqyLMlWr28lFf0gy/kdLm+TKHpeOCcGoieJ/F3/i
 D2XZk7nXgvFYudrbcfUbE3EDDBk200GAplQRRKQHey2ZtljXFZPeihG06/Hjg0GGWc/6OHKhuyx
 175luK3Qi+RbyfPENkCTSGnFiTV7DCDcaeuHAGpiDl3/faU1P/dyJpd7vf02UxOYrkh0wVAkrHl
 4aMVZjosN55/SYWYdwoDk6YZVfCL3S/1DiKLH8gvkyuLnuGgYgrLoNRa+Kr215z1fVcL80MP8ia
 tnGUt9UPnnGNgkXqRnA==
X-Proofpoint-ORIG-GUID: eL_uCKDGnrpfGix2ACD1L3zabdyrlAUt
X-Proofpoint-GUID: eL_uCKDGnrpfGix2ACD1L3zabdyrlAUt
X-Authority-Analysis: v=2.4 cv=CIm/zhrD c=1 sm=1 tr=0 ts=6ac76725 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=hzPBnW3WXoijDYWl_3cA:9 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080038
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
 arch/arm/mach-snapdragon/board_spl.c          |   4 +-
 board/qualcomm/shikra/Makefile                |   3 +
 board/qualcomm/shikra/shikra-spl-wrap-elf.lds |  18 ++
 board/qualcomm/shikra/spl-shikra.c            | 202 ++++++++++++++++++
 include/configs/shikra.h                      |  11 +
 5 files changed, 236 insertions(+), 2 deletions(-)
 create mode 100644 board/qualcomm/shikra/Makefile
 create mode 100644 board/qualcomm/shikra/shikra-spl-wrap-elf.lds
 create mode 100644 board/qualcomm/shikra/spl-shikra.c
 create mode 100644 include/configs/shikra.h

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 5aa84a3a6d1..dcc81d5a17d 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -99,13 +99,13 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
  *
  * Return: Partition number to boot from, or default partition on error
  */
-int __weak spl_mmc_boot_partition(const u32 boot_device)
+int __weak spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
 {
 	int p_no;
 	struct blk_desc *desc;
 	struct disk_partition info;
 
-	desc = blk_get_devnum_by_uclass_id(UCLASS_MMC, 0);
+	desc = mmc_get_blk_desc(mmc);
 	if (!desc) {
 		pr_err("%s: Block device not found\n", __func__);
 		return -ENODEV;
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
index 00000000000..99bb670bdf5
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
+int spl_mmc_boot_partition(struct mmc *mmc, const u32 boot_device)
+{
+	struct blk_desc *desc;
+	struct disk_partition info;
+	int partition;
+
+	if (!IS_ENABLED(CONFIG_MMC))
+		return -ENOSYS;
+
+	desc = mmc_get_blk_desc(mmc);
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

