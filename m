Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB05606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 11:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PasWo9BQ;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Vo4N/p0F;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kRYemkIk
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84DC1407CF;
	Thu, 29 Oct 2026 11:17:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gqwjJY8wm1Gj; Thu, 29 Oct 2026 11:17:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CD52A407D3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793272671;
	b=jcZNqAu1CXLBHtEnP4lGjBZ1phSzmGHiKDa2/UXNkkxlsTvpwm3Auxpk0L0U72dF4P4M
	 il1LqLC9yxnCiO6yeT+12vRcphL34QtdBM0SqV2bH8flxKbSbasoka03fth3w/lEhOi97
	 mwyAd81EXVnwwnjt+FQAhAWDjpCTXx9LKixnlScGWhB2RV0CkiTMro5Yh0q62Eprigs50
	 0NNvby1V6VwG416W7F/RDYqtr8n2lnFP0rYNJ6jCRIglVFfoh16IgESXj2EpDXpebWMEq
	 KaYBBZtXkPMRLOSbqWA624Ip46ttSmexcwZHYNZWSXrwyRMoAIUjdSeQ8PZtEPaSq3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793272671;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DiIj1S8ICoQXkxDD2q9JQgtICPlRJLyasVwSLPSMFQQ=;
	b=Nb8pjkMjcQpLrVjOvxKp73pmBCldTlEtGyxzStjn47WMqebiG4654QiGVA7fC7Q3+Z2I
	 nujRYzJFw1rdz9Dz5/Bn0jViSPVR64OPUshOY9lENUhfB36amUgyozl6az12hW8XyCf3G
	 KIHztSPUHHLRYHM4uz7igurktwQ8YADf9+ysSKkaeEmN32snSqweDzZhbPMbBiGlKI30U
	 Y+3yljVm58WGx1gzZsuZNF4mLYFsR1+fMAPGGeHAL4q9c1Vlv4k4+Js+gS/1ZZFiyT58P
	 BH5/LEdqrVZ22o77F7aosh3gHzLSVHzaaWvIuAmZS8A5sxbdD85memf9NqXmj4oUv5g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793272670;
	bh=DiIj1S8ICoQXkxDD2q9JQgtICPlRJLyasVwSLPSMFQQ=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PasWo9BQCr1ANHusQ30j4aLZ+YxmgxE4yJw/CWhqJZYfA1OFBuAsvtyGXBGlN7Xk6
	 pYLBg4RzFklUD02QLDHsSv3Bp/bGUu6zbzMXt8SG81wnxE+EXw+muY8xvmfGckmQzr
	 uLfMzxEELGT04FwFHu2D2Q6wiAWh5Eabi3w/aMQRtUkawklNJxqatjVySzbRsjviYr
	 f0ws/zLtG5c/B8OfGaCeeaV8jp2JBsTd8LcKXWkbYmQ//GC92kIc3hoSqqjPnfDxNp
	 V2UCbrxcpi2jip1+J7RSIP8RFhrwRJ9FE8ZUN5TUmuUwtVcKYpJ7oDWqlUTXeyBIyw
	 Dx18ktCUAT1/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD52A407D3;
	Thu, 29 Oct 2026 11:17:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3ED51334
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 11:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 24A7740342
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 11:17:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zzE8ByT44Dfp for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 11:17:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 60B864032E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793272666;
 b=IX46gw5C4oAr8XdOByZJUUZV/VMGN9jfPLyF+et37p2dZxv3N02L4KAo9lPdEkahnho3
 g4FSKhmi8Ujojbu66Ou3BCpsReJ26lPq22qCG8+3rD9LWq5qaYz3c9UH0QTJmDLeHbq+D
 mfS8W17KV2TslLz17MhtfUKpDq34cK9f4USXxmj5pua+CYdDi7IX/+xQH1WpIStfznE6A
 5/gSf1E7aHOKbjG0hoKQdThNJRD4GOeCZYlsbysAJ5S9zfKc5Xs0P8sq+QKpBPm9h3NZa
 9To3rBbiZWtW80EP4g5gV29EikIkr3gPdmaZE76BKyIOQ+6oZ1wXKfDgeA8Rb2sJL+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793272666;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=DiIj1S8ICoQXkxDD2q9JQgtICPlRJLyasVwSLPSMFQQ=;
 b=cjzJFWe3cRXevJIBbzBSoQHyLrdnmFj2MnQipwrvkGjzLPXA/lhf1DbMT3Q7OQqfm/WB
 tdWsCMGVrQOzc7XUWmGvSyrZhqQbxnZhIX8SrnhE4Kky8qrS1GOYvKfAVq3Lj3LRnyC44
 fTdtHVwmMEXSih0Uh8CMhWV/2c/JNporaaHGwwncybEHknbO2PruAa1fmfjVnDFV7QSpT
 V6pWCgjQFubgd9hs5d9xoUtDz51/mlGbNFx29vXvct/jMK8m++RjUbMxFWXEFbXqG8BOL
 rBQdMOgI9urPLCTeFDoWuwf/Ubnus9RAqYI3gn/2lbWApumt1AT7lSYF3Q2XzQ113hw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="Vo4N/p0F"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kRYemkIk; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=Vo4N/p0F; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=kRYemkIk
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 60B864032E
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 11:17:45 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T8vD2P2912461
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 11:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=DiIj1S8ICoQ
 XkxDD2q9JQgtICPlRJLyasVwSLPSMFQQ=; b=Vo4N/p0FPfL9tRJNzIS3h2gJmwt
 pnvkJ1wAfsoFl6uZxjgOX5nTozrpqXzmSJ0SpX/NPCSH1AsxqfDMRhpsA8wjSR8u
 jOi/ylFLIzn9u8FqB9EjAN5ER4w9w4fwsoarkeJz0rxld0Odpy8pjr2bZ2i0rstV
 H9VpH07/fJUrwc2J3Tn5h5iS5PMAeZnjpj7m74ZwN4excjYSIPL6Od02kA3YAVmZ
 KCtu4YxTo+fLjaMcAxHsgclo2AP2edNmBFEigbgQawWpxdgBwXLr2OlEcM9p+YsB
 MzAoL1TIkizUUy+eYKVhTgNXL93JpoRHhjXdG2icWHkl6+eBgfoeCcLDpkQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknb2bpav-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 11:17:45 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35cbea41088so2769271eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 04:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793272665; x=1793877465;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DiIj1S8ICoQXkxDD2q9JQgtICPlRJLyasVwSLPSMFQQ=;
 b=kRYemkIkzaeZiC7caMGkximUOrfCeSsGBUV72TSY+WPsbIy6NQo2cXBzw4s1Pz0qNj
 h7+mw1Jxah8wTykaOjDpzVNJMWF2fcLzQELIJb7fVB0MAmfroCMrPofvxqj0N804DdhE
 zc8BFch246zHRid4z/TKl2+LcwybHHARRUpFfU+J/UCJ2gpupUSesEpy6L62jTx7VqTM
 w+r895NL6fEl35bNvDtovtyxj9CpIM9JwmFIT7rUH5ZJjvaNZ9FsHsDr+FQ5i/CikBFX
 B+/dZwTQNTQtU4kyDkA8RjOH7MtWcnebMTureHsuRPvI1ZyRjugwWCvfjXqAK3qOW5qU
 WZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793272665; x=1793877465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DiIj1S8ICoQXkxDD2q9JQgtICPlRJLyasVwSLPSMFQQ=;
 b=h0/Z3U5ci8IAHtFVlvgbUL7aVepY8NYNi3sYegCsqYXegue5rCX6DSrZoqyJGakEC5
 lPdhEChng5eXb8DKhxP6vIcoODBXnSdgZb4aqtyElPvZ7xbNbOEN1mQ0aVUxZbdSLsWb
 qnsaN7QxyprfOb7tT5p+MxClE73hBDptAjlX7lDa2UQbyCtHj9JWE9p8MQeEk+nGfk5o
 qTVTcoT7Wiop8oza4NnoRo0U1toJuGoZuJh0yZoVGwK3+mJOqZLK+RRacJ65VOUs58Rl
 1wajmRnVkUFR8KInR7Ayi4VvtSWTF7N2WYk3+Dngb79ElMHoJslKg4qw5hF5TWwWN36/
 ngfw==
X-Forwarded-Encrypted: i=1;
 AKwUvByjOeQYP5lDf/rcIFKePxozye+RuG0mpF9JhWsrg9x45TleCNGYYy79vsOygBBF91b035uBg9Y=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI4q2iEvlNez63Cg1lzr2Ycp/eJc9EzUP7hGczdIaToXtKxEPg6
 GRtO19BcfCSW66Lbnw2SzkwE/JNUm3y0ziJNh8skX6viJNPky/6yiJfYdQOwW6QIs/Ke9lIo8yX
 wlrFDeXmwyUL/yA/hToMdSe5LznDDYqDKRhkHnsUVLaaRJcDvEamcsviGtgrshUUc1oPeHWg=
X-Gm-Gg: AYBFou36ev/5B20QhRAimPRA8e9yAe8mxxXTTsP6KG3JPkgqJGSLE7UIO6UCMABdMPW
 81S6D59aIL762cSuy+zxpGmXHv8iI7vLZQ0rs6ypr/faXWItzXamkjVtcXZARJEd8qXGEzKR23K
 0++048QyJi03jZxSsXNOokAGX6Zxly4ILQX75xp0xDlN16qgZx3tFVaTgWHZwSeE4saFjhcKG8M
 jJ58755SdhFfUrbpQieQ2VRcBnew4pK3LLQtj/hL8K/56tHkfJyv6u/xs84BboHj/I4EP0HIpL9
 5T8t5y4BdEU7MRBgt8p3oKI9EVCdPvYvjBnU2I1KW3dUOHupDdRLcJc3FANOHufzrReEzImKuOm
 eFQl11EFX5xKKQL43ETNwd+qIRHlxQGyJY5ty41X+COvKMKzW26Gs/xIqMIJij0ldPC0P61Conx
 S8Pa768mwaBZz3v3Gndx+x
X-Received: by 2002:a05:701b:2813:b0:143:6525:f9f6 with SMTP id
 a92af1059eb24-1a6cd3a1575mr6225084c88.13.1793272664692; 
 Thu, 29 Oct 2026 04:17:44 -0700 (PDT)
X-Received: by 2002:a05:701b:2813:b0:143:6525:f9f6 with SMTP id
 a92af1059eb24-1a6cd3a1575mr6225044c88.13.1793272663964; 
 Thu, 29 Oct 2026 04:17:43 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75a5594efsm19281449c88.2.2026.10.29.04.17.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 04:17:43 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, abhilash.v@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v3 1/2] clk: qcom: shikra: gate PLLs by clock source
Date: Thu, 29 Oct 2026 04:17:31 -0700
Message-Id: <20261029111732.3518237-2-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029111732.3518237-1-abhilash.v@oss.qualcomm.com>
References: <20261029111732.3518237-1-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Yu2a1IYX c=1 sm=1 tr=0 ts=6ae32b59 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=cbElVB0p0K_n_hLG8QkA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: W9lrtngeVsP409t_1EX8dLKMee9fjFiM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MyBTYWx0ZWRfX/sG+lz8hqOK+
 hfJ1wcKstcjueNOXmAUPdXj2hGNW5QYEDi/CxGhkuNtratYAbf7buKoI483+L5xufbzVnV57N/X
 Ud/I0DmQE0zJSH5Y4HQFVX9c7ry7dTg=
X-Proofpoint-GUID: W9lrtngeVsP409t_1EX8dLKMee9fjFiM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MyBTYWx0ZWRfXwfMoZoyFe73U
 NPJ/L3ApgrVZ/cnSv0y/9GjnT/lfUszeQEGVFDoFu7LqcKnwywb0yb/jgbfHSmmUz12EgUXIyd7
 zW1yBZ8boCDdh8KMC35rSY6K/E8bWt+qwc3x09Wmfqq1aYcUYe5naZp5hsXVrke7DOsNNKbinuJ
 ebNZuXecP4Wc/Gtzz3hGYwOYJfMU6LBX60RkQw+oN8Qo7MUWlzLQMkTVT5PXGw++b2bYDyngZ78
 /QFcu6mlEmk4//dnUeMLdlkZYZeoX+ViIyrINpeH3D2Ycv0yDNmWlDRh1SyjgYxl8pDpu5m9MNY
 2rCsJq+WGhvvvj+JwxFl4d5HwAQtfSKe65dYbMO9Rk/Bj0DEGOIa0Chbq3+agTheCMk/b9EEk4C
 6CzKS+S21xT1zxpgUSqhyexrbmCfX2RndBmXTdVCwsTaPSNukQuauzx9Brh6SajBZVmCWLVIlYz
 WJXoA2tQvM5av3rVuzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290043
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

Select the QUP and SDCC2 source table entry before
enabling its PLL.

UART rates from GPLL0_AUX2 must not vote GPLL6. SDCC2
needs a GPLL7 vote only for its GPLL7 table entry. This
avoids enabling unrelated PLLs during SPL clock setup.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-shikra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clock-shikra.c b/drivers/clk/qcom/clock-shikra.c
index a74d529f4cf..ae360894082 100644
--- a/drivers/clk/qcom/clock-shikra.c
+++ b/drivers/clk/qcom/clock-shikra.c
@@ -152,8 +152,9 @@ static ulong shikra_set_rate(struct clk *clk, ulong rate)
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;
 	case GCC_SDCC2_APPS_CLK:
-		clk_enable_gpll0(priv->base, &gpll7_vote_clk);
 		freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
+		if (freq->src == CFG_CLK_SRC_GPLL7)
+			clk_enable_gpll0(priv->base, &gpll7_vote_clk);
 		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC2_APPS_CLK_CMD_RCGR,
 				     freq->pre_div, freq->m, freq->n, freq->src, 8);
 		return freq->freq;
-- 
2.34.1

