Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5983BC98318
	for <u-boot@archiver.kernel.org>; Sat, 26 Sep 2026 07:28:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DA64640B17;
	Sat, 26 Sep 2026 07:28:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VcU9OkCfoZE6; Sat, 26 Sep 2026 07:28:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 182AE40A64
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790407681;
	b=SzYyB1dhzwNjTMsrFv+4ZFPvF+cp7hfFdx2gQR27uw0Tl0m/mpTvrWubCZVQSyumiAz4
	 rEll11MnhE2mD196KLjO5GN8TAoJrT317nxpmAYEk5cVn9e85YN/yuYAjGs95bNPSDdxC
	 j/f0Jb2f0+6GNlXnFVXY4vwbJ8reT0l9HZoR6BmIxG3dHXnXoHLfkp+q21HHdZqhF2S0M
	 0vTv1H5TIAuW3BVOvNMcpWZ5s9r8Mjq1v1douBs8Qt83mFUPp3MDeqKuUfNoXITKrAfen
	 r556d+S583x8q+wnBi7AU0DKNUbs7SYy4znvPez/U4to5obIXEOgi6wBch4uEvjtQeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790407681;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GX3qwnTvL/0BGN8kYP4xS1B3Ust33yN6RCPEBbfpzqs=;
	b=EsU67ARAAW9J5J7aM0orDOCj7Sv8cLsm8jK4VDvuz6z0HbWQDEP33nCsDq5/+gxlstsN
	 /oL7SBtlIDR5R1yCtdmkx+ksMr/j0mOzBXwqoLMXHXvy5GPisCqOePixpyz12UYtRO5iX
	 AN56T2gKLwb8zHZ5qR45JvImv0yYbUYYxA4Ek2P2DwYFV1QUlwfxlDe4G+Ie/lyb0JFL9
	 D90d2/naUveND6VOfL4iEwsAwA4rTfFYUQrO4OOGJ/xPsL7RVgsKcGfX67DmpnADaiiXY
	 vGpBnePLeUQ1MEf0UGNglSCX1WSXERqTbmQ7A9Ox5i8WSK/I1XuqpeS48aRl5feaEaw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790407681;
	bh=GX3qwnTvL/0BGN8kYP4xS1B3Ust33yN6RCPEBbfpzqs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rFl77OwD3jsJI+48ySG0JE3j9mu2ogWIhh6WF+pU7X0Ur/+15MIggNcH/UDlFY1wM
	 9FLJCg+wWrT0rCWpQHgz62vrqMor83u0mydOezF3B9xu33C+LZTHLI3wm+qKnuevbq
	 U2G7UkMii/6lTCPIa+gORQ+wEscmCzw0fd9qw6KS5aDgSVMcIB9f7pgxZl2qeCJVuX
	 2De66im2BZ8WdpLG3wHT/3b+PM0Se1xx3XZqeO7RaeSxu2Z3LkqpEeb6D70cPAI/vx
	 YfF+L0A9kN3XR+96n5ANzjLmlaH6M9R6IOIkwAAPnZ0H4xvqmgSfsWRuEasITf5dxd
	 XfpYMjL8sofkg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 182AE40A64;
	Sat, 26 Sep 2026 07:28:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 62BCA22B
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 07:27:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 48AEC811D0
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 07:27:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rAAyIBpgQKEZ for <u-boot@lists.u-boot-project.org>;
 Sat, 26 Sep 2026 07:27:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A2581811E2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790407678;
 b=NZ25AxP37n6qgaLyb3wlyMbe32bmLSR2pF5vwQbeH4QaaF6RRXkt/Ed5B8XSjVmy6V2+
 7p32z3Tpl9TT5yxeAuMgtkD5v2FacOA9hWkkhRHRUFDuhXdOlIhIUzM3YlhzPoCarbvuI
 7lDJcUVtnuuQZEQMyr5h439IXoZzCOS+RCDVXsILReyGvw5KXcXP1BG2Z2ZKeB7k3Xr0x
 srFwxGsDMoYtSKsiigxcfhDgucRZ9X0RM2/hX6dktlwuoXyKYBxafzLNviZD4qemjzqN/
 UY/V1St+4K5VpZz8b3ol2Dnw5ECeULv2erB29ADE3lMbFb/xAyYdXtIs/205tzF+Xow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790407678;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=GX3qwnTvL/0BGN8kYP4xS1B3Ust33yN6RCPEBbfpzqs=;
 b=BIxFBBqEx7PvCEJ2nR5DrGOXlC1BNr6vPbJvNcTDhYieg8jhnLUTlsfqUB+0AFFZkKLf
 AgMLJjD0a1A6iAay1LlaLAfRFEbQzzhNRvjsSibbC/wfyfkOa3XXPzFYN8986YEXT/SSB
 a0J7yQ00EeXVDKbBY4psPxV3cLZ0N05vbJdNvBPOAgMyjUwnsPWPIRqz4UxNii3ikEAGi
 hArCo2NA28OAW2SN7yrqdIBuExCEXrnnME4xwOMe5aJFtqQOFf8xaUy7o4vuObhd6NymG
 vLxkTShQhL00EYMJ9ncQHc8gvO/KyurP4JaXsJ0tOhrxQFWCJjwobrmMJN7aL3P0F6g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=HEDLiGZH; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BMqdBXEt; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=sumit.dhami@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=HEDLiGZH; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=BMqdBXEt
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A2581811E2
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 07:27:58 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68Q6PXTe3449303
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 07:27:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=GX3qwnTvL/0
 BGN8kYP4xS1B3Ust33yN6RCPEBbfpzqs=; b=HEDLiGZHlvJIcjSpjiFWm3EwzV1
 ZW05kgm2vgd0dgrnbjmsIr1f7Cvo0rACmxyRF0Xk4XveZnDOQpjgRmU38dYNJRdM
 EcBnhYjrnm2s6FnSDBMrTl0BOF2ZhDb4fAdwMU/gtcjpVGsIcY3jTvzW9/xYj9MP
 DXx33YJBg79rgPURFZE1lWd7Or7Ds+HAoY9e+LgXiYShywTeGQ3pjKibkllelmKv
 FfyHsbXhmL9Qmdc3MGhXlnSA4lKtoWQrvzjPjsAW0NaGzZDaIHoEjyDGCPXGxkpM
 ENr1XWc6UBfebOCRmZD8F5FaH+EmGhFPRkzA6J9jZEUgWh10FszgpRSvF+w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx6938d89-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 07:27:57 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso2683403eec.0
 for <u-boot@lists.u-boot-project.org>; Sat, 26 Sep 2026 00:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790407677; x=1791012477;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GX3qwnTvL/0BGN8kYP4xS1B3Ust33yN6RCPEBbfpzqs=;
 b=BMqdBXEtDoQyy2CyD18r+TYGtakFqEsQy0zDvm5KbUiSFwoGOU7x7XRz3wD6YmV49b
 /9TmwffrhCDm0FO2OaJmup3M/z2ZI8WrgWV7331Z5pp8vsS3+4UypL9JjuI7AwowM/KO
 2u9Aap7hbJcfz37KQw3EC287L6q8jnpYTQX2jK21pEBpewb+83kx1kpUhZNQhSqgvZnz
 xv/6TUmHnZN95TvXNsFz55hFDML5xYgYX9x9SVGmoQM7cyn+g6NExXR518DWzEfMRWIc
 B0G7BqKGTRriUP3ESZufoXD0mMlv2m9K9N1efpr4PYtHw/lgD3Qy1qX5QWsgJ5Gl1FKC
 chPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790407677; x=1791012477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GX3qwnTvL/0BGN8kYP4xS1B3Ust33yN6RCPEBbfpzqs=;
 b=GpDT722g1t6yrrYeeV5Miu+Oj26EX+Id3T683xYQlRha/YoJYLcTjVvBW41MUrFG4U
 d8iNqX1anlemS2b76h3f1F08DVZyMxVQ7hknkLb/dFgkpiYY7zAToTQR5ZZl3GmqAt9y
 WDVsLqANQDAKwzSwSfYpb7tlw5++CzJPKvIE7On4sqiswZ8EG48EdW0bpcyz1VdB4RG8
 ReOZwgBdwWUvJH+gv9Z589FXT0+Ik232l48Zuco8r9eafWk+EpmHxRxN7yweJNzuIhiu
 QVtQYyp0bzq5BtV+3fuwrmjRYrsMeZdM+G63xKSTp1FhTfJfQbCe4M8DjL0JpLTfdmcH
 6/7A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwdSgKwD9rq90X9GIVkLR3XnIN+E6tel8ZBmapuSmWEwlzvLIcMmufU/LY6CdsTJzQdeX7zvc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nIMJ+ysftsf6OeiU8w9vKwTW8G8zmIWmEt/lr1cbqDZYwVDil4
 VPH/8O7ySdubHpFktRtoSGtK9dH+xntqmN0X5/9jXVPgiRm7Cif8mDV3BX/zzdzt42ITumr8gxy
 KKueLiIvnCtIedvAs/3inHTCcwiknoYCMVRBj/6Jy9Id6lDlS8x4owqEYGrK4Qe9sbWdeb/U=
X-Gm-Gg: AYBFou2zPgEfYmt8XnzfXHvI/izTqUZKDrposGBaKFSeRPE0kyMNPueHAfoE70fEeER
 FPn5p/5AwijohKFL3cTxr8BBrTXqrHAe3TiIQOx80awa/Ocwekrs/ZKrBbHFuQKeKB/uzWUF0BL
 O5B7gJLYouPikmzn2MaF1XE7h1p/pbXM440Chb8NAMoUgbgHf3vrOQneya+iLzvqTciZq4v+S90
 oG/pWj5c/EbNC+OUU7ci7jYLaoJpC3nLoSkisdEM09euAj8SikNw/lWAqH4Y40icM5bP/2tAmrm
 U6MN81TZ7ZRDqTNjN8EnPu/ORIITfX0Z1pEKTWnQzlLOrkD89cx9HradZR7qpdbGEhAb+6090ot
 70t4Td6bzUHGgQVB+zN8INyWAbPKbWSpZCGytzwO1vm1Bri4CwMD8OaU0Lsr2Wf2d328P/Qttje
 1hmYQnApe8L9hVLyc=
X-Received: by 2002:a05:701b:4289:10b0:143:26f5:c618 with SMTP id
 a92af1059eb24-146d02a7e38mr2083373c88.33.1790407677037; 
 Sat, 26 Sep 2026 00:27:57 -0700 (PDT)
X-Received: by 2002:a05:701b:4289:10b0:143:26f5:c618 with SMTP id
 a92af1059eb24-146d02a7e38mr2083354c88.33.1790407676426; 
 Sat, 26 Sep 2026 00:27:56 -0700 (PDT)
Received: from hu-sdhami-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34144757747sm13370186eec.13.2026.09.26.00.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 00:27:56 -0700 (PDT)
From: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 sumit.dhami@oss.qualcomm.com, balaji.selvanathan@oss.qualcomm.com,
 u-boot-qcom@groups.io, u-boot@lists.u-boot-project.org
Subject: [PATCH v2 2/2] configs: qcom-snagboot: enable poweroff via sysreset
 uclass
Date: Sat, 26 Sep 2026 12:57:36 +0530
Message-ID: <20260926072736.3351143-3-sumit.dhami@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926072736.3351143-1-sumit.dhami@oss.qualcomm.com>
References: <20260926072736.3351143-1-sumit.dhami@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDAyOSBTYWx0ZWRfX/IWID1OCSQ27
 TEMylUM1IpzluS9A8GwKuo1glQ/Qh+HaXSMKFtG1wz17szWFNTrhqGIzQ4/DZXk9iNFsoQ+GbfK
 DtCCMQj5KqzK5u6vXZAHzuVldmJREDI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDAyOSBTYWx0ZWRfX7+iZs3YfWIdK
 ek5uXWo4qtUQUavT1YpZAIPMaNjyLBNtwoCYGK3Pc7kgBGowKam4gx3h+zd0x4TvLhv+rTsUaEY
 0hrz1mOx61JHNAILJ3erWZ4wGCOBBoWuHV/k1qClw8q790Ckllc41sIvImBhVCAi1SCRWWl0vb3
 lS4/QGWTSQctEsNb/AqMv9p1y2Ud+kOLA/m1nBuekI6z2XOLnhowmq1yD0fUyVkx0h0fDU4KcIR
 JXnwsJzdSn3SPNvd1bkAGyioQtJCAxnTPLAl+6NCPlWUOYi1vp4p663N8flPobqkVcCOdhwdY9k
 I9Emx/IJIZVuSMUFLOh/z0fobFh57pFWjoOAStfkw/uHwQqf+sjPjasi8ywiVVF84Uwy0Odp/SJ
 EhHOYncMb5Sdx5ASEp1s6705K9R8g7Mo7Tw0Co9XXSHCn5IYTEp8DSdxXdegJ1mwO19o2HOsnx1
 nyosQO1NVyH26CWActQ==
X-Proofpoint-GUID: sDpE4rz4kQr94WaKhQLnrELlY_RsklY7
X-Authority-Analysis: v=2.4 cv=f6Pdl+yM c=1 sm=1 tr=0 ts=6ab773fd cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=Wj_C5qF8xkxlecpl6MwA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: sDpE4rz4kQr94WaKhQLnrELlY_RsklY7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260029
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

CONFIG_CMD_POWEROFF's do_poweroff() is normally provided by
drivers/firmware/psci.c, which is unavailable in Snagboot mode since
CONFIG_PSCI_RESET is disabled.

Enable CONFIG_SYSRESET_CMD_POWEROFF so that sysreset-uclass.c's
do_poweroff() is used instead, routing through the qcom-pshold driver
configuring the reset type to SHUTDOWN in PON_PBS_PS_HOLD_SW_CTL
register.

Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
---
 configs/qcom-snagboot.config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/qcom-snagboot.config b/configs/qcom-snagboot.config
index d19ad453029..07b217b75c7 100644
--- a/configs/qcom-snagboot.config
+++ b/configs/qcom-snagboot.config
@@ -31,3 +31,6 @@ CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME="scsi"
 CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID=4
 CONFIG_FASTBOOT_GPT_NAME="gpt"
 CONFIG_FASTBOOT_MBR_NAME="mbr"
+
+# Enable Poweroff via Sysreset uclass
+CONFIG_SYSRESET_CMD_POWEROFF=y
\ No newline at end of file
-- 
2.55.0

