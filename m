Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A417C606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=axA7Fi0R;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XlTp9meh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SyBvb8Sk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 755AB607A1;
	Thu, 29 Oct 2026 11:17:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bp_wFGxwiiTw; Thu, 29 Oct 2026 11:17:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 97D0B60793
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793272672;
	b=Ts8J8/0usxEn0bxFj9KwcZwEkBg1gV3QQUWrrIB6l+/+jkz5ow4/IVB6xzI6WUC92tvY
	 VF9nGvyALNYgeR2uq6lKx9GzFygJSG9e40tqfYlu9gqVDIWwEvapqh79MdIM8ZnG7k+fJ
	 meh1GcldQrFHWMXkc3hBZrs54h8oGAEOh7srR5GmYnXDDjFyAGYlJx3wy7GkqOVzwfcoW
	 8tCSdAqBylaxUX3403QmQwhJZ/wkNzdUUBG2o/NaJoL/3NCEM5X8RlaCQTmsg8SCxmSll
	 uC7tkExmEhBAyN1FUPIBKfgW3AwsnR10quCw/FLJVbdIJBxo5hlNxG2z60RYSwLk3ZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793272672;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XAVNSZNRVSYHZ+A0ac43GOdVtJGDxgissrL2AdCwTSM=;
	b=mVIs8e44UIPX2EHUTtDm4ylyehC9oalhAVEoAf7F9eI7aE7zhNqAsLX9AszUhtoCrNDm
	 zIsOUjAA2ZTiG9FLoLmq1NON4zvs5eCSEe6lfKpC3tlhtk607fzwPuDr8jtxCumwbMDlh
	 ZwsjPfHvYPHTQ0CL6P+6RZdntPVn64qGvMCWe42GLypIi614WqchpLd29al8FpE1yXSR3
	 tjlMSXJCKPsvQDDzGCdk+3QW8vDC/jZaBCa5Tg0Vvo61hChLBS0buRIaf+5NXmoMi3tte
	 QHNb58whpMXFkN+y1wNHVEXVlzQ90DldWjTX1JNmoAiCLHkZ3PtPblt+en/SzXtvgkA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XlTp9meh;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SyBvb8Sk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793272672;
	bh=XAVNSZNRVSYHZ+A0ac43GOdVtJGDxgissrL2AdCwTSM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=axA7Fi0Read4VEwQJ4gkysINuPz+U0LS4tWUzIbYmBn4wrRlKQ89egMVktHroIjx8
	 I6dmrMzxIZNz1+oCs3T4lBnukVdz5a6oBgkiDWluKcRlufngXBTK9uIcTwz3xop5Xu
	 UwmR9+1wSTeEer7QLUUkA7HMWTToUBAO/T6bsc/Z2yUmhrFJZAjA1jMfACQfjYCDlf
	 5PbjeKjfVHo2BCLAWSNZr01LpKwVyJunMLin42mN6fYjhiRmyuZqbAcv785wWTSJMS
	 6otBJn1eDHcWiSbHy0eYDG8FHRrLc58lBJdMkLSEzSGGTINYhKC8YSjxBqNYpuuWSA
	 6UZXIrYOtrmXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 97D0B60793;
	Thu, 29 Oct 2026 11:17:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AD6D21DE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 11:17:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7420C606D9
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 11:17:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JMMETxfS0CuC for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 11:17:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 38EBF6069F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793272668;
 b=klEdZZOoHdDRmskBLYJD0jPbCGk0dBNkGy6fbMYLDhh3yaAlFaT4WRuMKbW4OsTAIHhr
 +/RMbp1XESdQDWTE1OW9PFx5GqMtBQThm9SRRavwvrHMm/k0LSWhak3pl6o8TeSwJUjo9
 tu/rSPEVHVSqcalkrFG/66ts6WFPbmJiCovHSAG2wPZaOSurwiG/ullfStUGQlJ7dusOD
 6i1sE5w2YOf5vF71i32LwCWFTu/7j5h+nwyD9FswWdaxPsRgj4pgvWXDkbut3VF110bfX
 bazaANM0To57O8upPXMaXUugW2OZtUqpBqsdMi3IMrPuPr0VXc5eovOH4slX3D5EXKQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793272668;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=XAVNSZNRVSYHZ+A0ac43GOdVtJGDxgissrL2AdCwTSM=;
 b=dMwl3XfKzW3m5t3ZlzcPJh2J5lL4TaeJCOkWdpcnNgRC2Bpo2BRbsS9TeyOhXt2gwntm
 Krv21Te3gP8gHQVQZwyGXWE9Jdudzhif2pmhnvpNuvhnSAUuqd/gLx/zoVSr+MzJxOISB
 EYd0ShqM74e4+RkfOEiL8K9RPeaVkC8e9+s9MmcBH0jxpBRQpyVMWJ70D4AThp3a1etzc
 fgWF0vgKPvklTihfLVaZiZf8grnpeV/if3SvaT0N9T1nmGRKAiVyCF1IZJyMW3TQzgHC4
 Erwn7+4+zi4AzoG+vkiEVQmevdCzc5OmIhE154WICWBJe6YKmE//heJ5qE8cN1LFErg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=XlTp9meh; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SyBvb8Sk; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=XlTp9meh; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SyBvb8Sk
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 38EBF6069F
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 11:17:48 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69T8vPU22273464
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 11:17:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XAVNSZNRVSY
 HZ+A0ac43GOdVtJGDxgissrL2AdCwTSM=; b=XlTp9mehADSiAldY4UO6q7UbZSf
 PKd5snk7EDmZZ1Tjz5iNV55rPzPeyKKKTdd9SVsNrih0kZFY5VCBs/miqrqSD3M0
 xvXi4JepGSX9pkKNYICg+Yd17mV+yymU3rfj2wWMkjYozfzuCqEvV516ii6FppK3
 osrmhzu4n1fvlMses5kCWcjLdHBWSZzpqfz0poI8krBRdUZUCGS462Y9AYDE4MK7
 F4ntwuBPi96Qe4JL3Gyh5iF6ZPUp3oQM0Vmb7nK3IuIP/6KZBpJvkvSGf0dFnNbK
 mp2U2usu0kWis8dq9wv7JhiSUlLRzPTsaYYK8VzCpekpjUdSiXKTb5iRGkA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b0hty-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 11:17:47 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3692c5b061bso5612571eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 04:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793272667; x=1793877467;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XAVNSZNRVSYHZ+A0ac43GOdVtJGDxgissrL2AdCwTSM=;
 b=SyBvb8Skwu6/ryfuz3Ooi9jX3cgPftzfzC2s1aeCWx/Sa852oU1PTs53giWbC0Lp+U
 M8mu3gsEA5tpnp66meMLnUiyHLQgu96j9KXrmzBzmd5hE9A7V/F589K/krywxARYMSsE
 celaYfW2A3pUmVStGPoza0kl2MW1vSxyK6dZ+rBGAHqD5D/tgfh+Y28/h5ncgP76oYLy
 887WIJZdW36LzT33cgk6IGCR7n4UwHrU7J6WYeVyCUmtE8VdFCsf7JCeydEkiQNkuWli
 SANcZ7OXBRFnhTs+bwNkgWqnMd8AThCrR3nAH8eB1OsLfUd/LXnXaZzQB9/dEx7u4h+s
 ugKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793272667; x=1793877467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XAVNSZNRVSYHZ+A0ac43GOdVtJGDxgissrL2AdCwTSM=;
 b=eqnVO5q+kyRguPa98FF5gesXCz+rA2HGRN+r5AbNi+oU83RYz4/Gn5s5zyQQCENFnK
 ApaHmiYq3pkBViiieq3nSGOLDJ2cTSWUqmEUaU7g2ozMjX9JfCLEinWIXktE1QVw3h5s
 I7t1AeiQfpKJEWXaeLtr/3nVfY1RZI9D3wbT6H8ygNcBM9QvDX8r+P4yBV3FFFpCI/dt
 755A/BT/Nk7pKWRgb4q8dAgv07a8X6aaoilx1Cx1PIUTpGYQDkkIOlZsvurTwZ0j3zKH
 VItoKkDLJSdYG+nJHuoMBuuRPpFGNOzp83zQID3se/eJPZ1GXUPGI121YP8Pv9fERbmM
 ivRw==
X-Forwarded-Encrypted: i=1;
 AKwUvByV/a+qI7Sj9IX9ahZFyThehg3gogVhY4/BWwk/rpzmTc4awM1jHkYbXR+gsHNYxAolmZ7Rjgc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKeEtceY9FjOAFjI4I+JKGK/H6Yy48+AeWBy2iJ75DN0R9rweMq
 eSrvAeLpDx1MmZSMdjW1y32WkMuAEKZNjYdw7VIEqS83/zqvfyLOfYlQ8tU+XNUWWV/GmSHZ+DA
 YPwTncoDN63+klO2jXdN/gtn/aH5cmGGHYbqA610F/Tp2+dJPDSbmIOq9dBjm0Gk6poEOEvI=
X-Gm-Gg: AYBFou1VOw0ZVsQ0bCXcnFBKc7t9ixgE5RyAWJsuG1X8sj7a+iZ1OkOKEiaiRcpR3dz
 osXeaBuB3ZdQkM0HWAUwkcjy9MWQpthFRSTlfkxrjDf8hTrYT/1cGMVmXqPmnjWFH8Sg3ZXzMYJ
 e5//fNGsdSHM/6kH1Q/3Ipd7niPoCsrVPhuwSl9EfzRDRtuqQun+DOnlsdMcF/WstfSGvl0zXt4
 jaUHfndvLeRCStupjEeygMUpIvj7WdKe7LLjKeMMdtpAr8lpt/iQM9S4Q9Q1Et1ZrCSCsHQf38p
 o1OhrfojXPpvqyan//85laFSnjj88xTqeXmfF6VtJn4gPmMVxTQxbRJTDHuRnHgfH725lyxJBbH
 MQ7CWPjLjkCc5vmxkYKidQo4hISl4+zAh4yDbf+nxW4m/NpgoEshKiR99nxwlgmrfx0KhuInCXH
 L3xkg9E/89ig/33RO46Xc/
X-Received: by 2002:a05:7022:289:b0:18d:96e8:b913 with SMTP id
 a92af1059eb24-1a6cffd2ca3mr6088423c88.47.1793272666912; 
 Thu, 29 Oct 2026 04:17:46 -0700 (PDT)
X-Received: by 2002:a05:7022:289:b0:18d:96e8:b913 with SMTP id
 a92af1059eb24-1a6cffd2ca3mr6088389c88.47.1793272666318; 
 Thu, 29 Oct 2026 04:17:46 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75a5594efsm19281449c88.2.2026.10.29.04.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 04:17:44 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, abhilash.v@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v3 2/2] arm: dts: shikra: enable IQS SPL SD boot
Date: Thu, 29 Oct 2026 04:17:32 -0700
Message-Id: <20261029111732.3518237-3-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029111732.3518237-1-abhilash.v@oss.qualcomm.com>
References: <20261029111732.3518237-1-abhilash.v@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MyBTYWx0ZWRfX8MrF6C4Y//cJ
 ClqolxesvnkX/hAExzGpYaeA2AgXE8dwcy2ELK1y7cuP50BX9rBJTE/AQRD3VT0nOHgAlDPNIh6
 4a8dK6mcWP7QekFMmvdNPIcwFq7U/Bk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MyBTYWx0ZWRfX+sBUV0RtmH4/
 fvNPTm77RqAP5cdhDDXSgmYijGywDkLLu6QGI7Dnk027Kp/y/tIpPmD0mkrTcQadbf0U2wk8SjG
 u/r67Bsjkx3nMoFnPNw1paq+BImdCko64lfUGiwCs7+55e5Ph5wQLoDOYFNEV+0YSJAvnkWirZJ
 PE4WbFSIJ2t8gqwO28wk/kp9KyObFoAD7RhtoV+TRG7eWw8Gmd+51NdGeBtejGD8D8pbGZGNw/y
 BjUDHFbSk3NEiyviGFjoaNJQHVR5mnuCqRy/f3y+0Fe7KuoQeEMKoJZ5KRN8eSqzq+BuTWkYuM5
 Y7maTPEXu3ZQMb86CprgF7cf+qcnjlhdPwX/kghjwtfzmW/6jRratbZHHMv+4nQbvFp7JtK00DZ
 5vzkFFEDpZDHvyhGKo43JZahmC8HmMA+1ltbBBuc1KGINSAwF3It8Q9H8tzDS9z7nZwqZRJEVHl
 +5KQ/loSVG4W0lyZTNQ==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae32b5b cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=iKMKvdUHVnxoxgO4XnUA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: dTwV3xMUeqIxbrYyQXtz2mAJxYw80D84
X-Proofpoint-ORIG-GUID: dTwV3xMUeqIxbrYyQXtz2mAJxYw80D84
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290043
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,KHOP_DYNAMIC,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Update the IQS device tree for SD card boot in SPL.
Retain the SDHC2 and power dependencies required by the SPL
boot flow and configure the controller for SD operation.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/dts/shikra-iqs-evk-u-boot.dtsi | 19 +++++++++++++++++++
 arch/arm/dts/shikra-iqs-evk.dts         |  3 ++-
 drivers/gpio/msm_gpio.c                 |  3 +--
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi b/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
index a1e506f7dff..f2265c741bd 100644
--- a/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
+++ b/arch/arm/dts/shikra-iqs-evk-u-boot.dtsi
@@ -46,6 +46,25 @@
 	bootph-all;
 };
 
+&sdc2_default {
+	bootph-all;
+	clk-pins { bootph-all; };
+	cmd-pins { bootph-all; };
+	data-pins { bootph-all; };
+};
+
+&sdc2_sleep {
+	bootph-all;
+	clk-pins { bootph-all; };
+	cmd-pins { bootph-all; };
+	data-pins { bootph-all; };
+};
+
+&sdc2_card_det_n { bootph-all; };
+&sdhc_2 { bootph-all; };
+&pm8150_l10 { bootph-all; };
+&pm8150_l2 { bootph-all; };
+
 &qupv3_0 {
 	bootph-all;
 };
diff --git a/arch/arm/dts/shikra-iqs-evk.dts b/arch/arm/dts/shikra-iqs-evk.dts
index 38b13f79c24..0f91678a3be 100644
--- a/arch/arm/dts/shikra-iqs-evk.dts
+++ b/arch/arm/dts/shikra-iqs-evk.dts
@@ -41,8 +41,10 @@
 };
 
 &sdhc_2 {
+	resets = <&gcc GCC_SDCC2_BCR>;
 	vmmc-supply = <&pm8150_l10>;
 	vqmmc-supply = <&pm8150_l2>;
+	max-frequency = <100000000>;
 
 	no-sdio;
 	no-mmc;
@@ -50,7 +52,6 @@
 	pinctrl-0 = <&sdc2_default &sdc2_card_det_n>;
 	pinctrl-1 = <&sdc2_sleep &sdc2_card_det_n>;
 	pinctrl-names = "default", "sleep";
-
 	cd-gpios = <&tlmm 89 GPIO_ACTIVE_LOW>;
 
 	status = "okay";
diff --git a/drivers/gpio/msm_gpio.c b/drivers/gpio/msm_gpio.c
index 7de332c66ae..affbbe5c880 100644
--- a/drivers/gpio/msm_gpio.c
+++ b/drivers/gpio/msm_gpio.c
@@ -274,8 +274,7 @@ static int msm_gpio_of_to_plat(struct udevice *dev)
 
 	/* Get the pin count from the pinctrl driver */
 	uc_priv->gpio_count = pin_data->pin_count;
-	uc_priv->bank_name = fdt_getprop(gd->fdt_blob, dev_of_offset(dev),
-					 "gpio-bank-name", NULL);
+	uc_priv->bank_name = dev_read_string(dev, "gpio-bank-name");
 	if (uc_priv->bank_name == NULL)
 		uc_priv->bank_name = "soc";
 
-- 
2.34.1

