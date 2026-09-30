Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788FECA5FB5
	for <u-boot@archiver.kernel.org>; Wed, 30 Sep 2026 06:35:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 25A7740862;
	Wed, 30 Sep 2026 06:35:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WKmA_2LEL837; Wed, 30 Sep 2026 06:35:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E3A7940A2B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790750118;
	b=qy9Est9qE8W+U2JPxRjuTT2Sxqbffl+2eU05n2/eRkR8S3M3xuEY86Dz7Ibzft1IcbnP
	 sO2kqhN2x16ZSCkbMheF9FyqaFr1aY5hzwuT6ZgoKPZNKwxiUdx8KafQTpby0ooC9BqlA
	 9a/WTzhXYynh99Qgoy6fRceLXoHb3bAjKDE5aTkCLZcXuxs5LugeGqKkElMR2AvTGSCeN
	 FgNb6F0bWequb74PP+7blsJqD94JhaLpjnoD9TJ+YksKwRHxvZGgWLnsKw+TSuAwbQ2Et
	 LtiCGQMBWZn4LeiCYC1ztPSIOzzx9gxwG3OpfxAnAuTR2ytm/tThVbIswE67Z7pAFpQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790750118;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=;
	b=bplAbAMcPmYHjeR92VmXiw63GoeTxOYJKFRVfKhpTeqTblPoHwNcibkVsrhngDOlfmnw
	 PDsPsegcnJI5r0Nqss3DiAdQudnzC0ch+q9dqIgxznL8sFgY90BvTkqPrs+AO1XbvN2Gz
	 g61kFWte8+9b8Ra7vJhuh3QNXzQrBrstLUAHdjPk3lP2J5/letkWLYvd6sf0M2UytIl2+
	 +wTUdophHuy8Zm7oLhSCN0iasFrgz2xVkY8N4IAfVZFPO1SkCrTAirX6eLSrF2dGYNppB
	 XKNvPurEz6s1lOv5MO00hYe7z9pU8KH9jy1z4iDL5ZR58eX4ksfNGd4GrmHqj2egoWg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SgfRNXH1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SgID9kmj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790750118;
	bh=WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=H7ON2GduCxca2NK/9hMn3zqGCtXUNopvd+PTHItj0FZLAzuodPCL0ctNYwNtdagGm
	 uUTSeDCxxCzBYnKatKOXNdDnYAk3+JJ24wgGfPUo0SUPxGZQOsUCNz235KowuQns8S
	 7+2RA/3yqf/yC2gSxPSDZU5ErI0e6kbbo9lImUp56ePhVR+UpVfporfK2YGj7K9r6e
	 vQ4ljowoiyuLuQA6Y1s0ejcJTGIbp4B448jQxAK2gt4Y0nsFpFu0Us9buIEUCD7CBl
	 UsbdaoXD0rF6/W0WJ14mvfHBDREdHPxjSDFZDbG4T9aVWmGDeNFnv0rVuL60XDVq7p
	 NnaDbXlgvaKYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E3A7940A2B;
	Wed, 30 Sep 2026 06:35:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FDED32F
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3319B40844
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ajZSuxNxUsmV for <u-boot@lists.u-boot-project.org>;
 Wed, 30 Sep 2026 06:35:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5880D4083E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790750110;
 b=kMf8HVd8kDIXuj4yDBzZwVe0o+nmtz2CIA015xSJ9ki/lCCbBtukzbQhc6s/gRtqPd/N
 0cv5qHzeitb1Rk5QNXkbIhfd8l6q/k6rU5ETYzuBF7K5JNvIiYVkJg6j/g9iwO+R+5NXr
 IfjJUorZIksKBV9zP5uYkmkJ5vRhzLh8oDEmDRuwWNaM+UfCJjmfUwkbh9rPSvB2TcopU
 LRS4Xc2O4wjaOPqPogZIqrGc6yOuts4Prj4BuAOAK3HA7kyVZ7Xz/OHK3rjHMRkdmK4yd
 lK/q5Fqudqjp+WB1oyyWt4poEGaqVK6Jsv1GrLE9m4W7J+zHt0xfINcCm7O0OVevULQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790750110;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=;
 b=N7sfidIEiKdjpF3UNCMpKxN/Ez4P2oqyA0/JU/bihIYD8uNfJ1Mrb/LhlHcKxIkE6HKz
 UdEA5dP2EaEjWW7Q0Anxz6Stv+mHGC+H+r6qaYA8urQncpXvAOuXdyUOWDVY4lie97sJY
 SRlHPVk0I/FjQ6OxBlqWYrLRrRxn+O6JxD/YAKzKIuEiY6Z2z6LDg48Z46xr+1sdlIzSM
 ZPwupIxJn2bDUqOUfzjWRm7b6+uQu17QPRKZF6xqfLLBhVO0cmvvvLLL68ok8mh4zTgd2
 CbCT+sbUkrAj5fpXC+znXj8sBK0QxdtSzrbG9dc1H5+eeE0gtD06VLa3vQXLuMFLE1A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=SgfRNXH1; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SgID9kmj; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=abhilash.v@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=SgfRNXH1; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=SgID9kmj
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5880D4083E
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:10 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U6GZDC2971653
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=; b=SgfRNXH1/ktJmIpY
 ZXIE6zFibDosTU1q8mA2kYHUsZnkBJ6Awg4VkV5aIZVqrl9UY9S/fqjcrfnbcJlR
 Iu/iERQ96ort+o6iTzCMomuPIUrgI6xH4Ib9/VBPmgCHni1FeIJ010jJZcjsi4IN
 TCBZYikSX4NgLwr47Ac9nRSPe+vPOzOMvN5ISVioe5OLHkGbKT7FZPPKfGeJ+C+5
 k+U86RLNJBvPX9pvGj0TPFkowCsSOBGNzVUHd1lMjqtAkVNmtlY4+nE3dqAQwj+j
 8hPnhsvd+gxwKK0nx4A6j99RARzy/PP+3pTtwttT7DdXsRuRWvfJWgJidqp0ggkI
 UXe4TQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0mfaa36y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 06:35:09 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-313d1015161so1800729eec.1
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 23:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790750109; x=1791354909;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=;
 b=SgID9kmjfnf4F0QzH4wtuKsjykUYtDHcCGHSh4WPrLhS/6REr2AvW0z3PMMHdj1LYd
 vK3WiPzxh6mnNI3Anhg6+y6i3y3AFzZtfZWzPcMQSXbugybZ1/oTAwUMh0QyPqWthB9a
 8UT7ZMeMgezJCHemIMZhBSJ55WKoiOgUsf5zghx8eqsmcxIo3s8E4nQbzrQeTul1bdlj
 uwdVd2R19BZaLVUa7YIA0FnNzDQLH1FNq4w2UNwEer8dkR5eNw24ehj38sM20LD5UeWb
 SlUNP3mGC7xjBtTjVrggV5Hx8I2r29r49Y6CnuFIRseDYi0d21Z7fU7YBUblrSLV9hXK
 MYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790750109; x=1791354909;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WkaJ9kh22sZcVRNr/Hkn4qrAjQUcROVGD99sCOXTWZA=;
 b=Q5CwrjzFx9GyttSbFLLsFUYbPPgeFz4lTDTmWQVMUdZvX7JedsJsnY99Ko4PEjCCi2
 eV9avcOl/lIgavR7pvEpLnkD+9UlAC8ZJrvpbo8lA9DFvXyzTpDE8+aRPER89IKOX7Oy
 K4YfBYEdboUUcBLDu3hOa07iPPSSkieHPOJbLPEc2DQvBAqcgry74I+AuGWEw5m/+Vic
 KE0D0bz9nyd4jTbIzTVKsXuzAXw/+T9ZiLl1tfpMEc1a+34woeOUYAXAuCwmRa6sAJhf
 dbX1XKorfWjs8wNJ/Rtc/QYz8eXKT20LNOSSQQSWRx3SEBiRz7Ei8ojGfrPoJTpGKb4Y
 cwsg==
X-Forwarded-Encrypted: i=1;
 AKwUvByBnqgW4GdF0iwM/HsePkDGlQmwIykrBLg1bOe41A/na7X1PWoE0LuXxhTwtLnCgNbVIpffGJo=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIieBlhT5Jz7aJjKQaBEQDQKjjWeMzptXGqCl5s8JJnaOCoBxlX
 qUvO62tntUaWT+ohsAv1P5BHZjNSh7PznST0t8gwgOf2jRB8qh8c5c1SPINwfBsGKR5KGONcloq
 Z11MugceZV7snCVuTDn1qfiA1dll3s0LYYsHc1RBv10eiPCwHRJcY51eVsROIki1F9BFmtsc=
X-Gm-Gg: AYBFou1sWrV7COVKg41QJDsDLzh7ebRBObLCA71SYKiPrI4iO3dbEPBEAEpGCeMMW8v
 k/62tuJTD+5eH6CgkrXmfEri2t7zBo983M3PwjegUvW+QFCf38E1P0PwpjidG4H2HyvvucQqu6L
 nDd5hAHVTKKUXlLHVWPH5Oe45+12hLdNEcbCzknhxGIrsCM+2Iy0FJfcWHsp68zKwxoHhvXnjaA
 MybWrtFQ2t/z08FcWSpoKMVQWoVLJQhbikWT2PdqouVeWIbeazqsj/SbGVErP6Pk8sXn5rJXUK/
 3MQ4XeQS20oP/emSRB45RWziIaw1bEsx8m9j3dTl+IhjKfIpcOAaXrukWA6p+2DinQ+pft7/Kxo
 jzW3pfmQ6ZCGONsrk4ACcSBoS9h8qP100JBfoOIdwditrtuiN
X-Received: by 2002:a05:693c:6392:10b0:34a:f2d6:3ac6 with SMTP id
 5a478bee46e88-34cdbfcc415mr814868eec.23.1790750108684; 
 Tue, 29 Sep 2026 23:35:08 -0700 (PDT)
X-Received: by 2002:a05:693c:6392:10b0:34a:f2d6:3ac6 with SMTP id
 5a478bee46e88-34cdbfcc415mr814556eec.23.1790750102528; 
 Tue, 29 Sep 2026 23:35:02 -0700 (PDT)
Received: from hu-abhiv-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34cf22f85b7sm1287502eec.3.2026.09.29.23.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 23:35:02 -0700 (PDT)
From: Abhilash V <abhilash.v@oss.qualcomm.com>
To: trini@konsulko.com, ilias.apalodimas@linaro.org,
 aswin.murugan@oss.qualcomm.com, casey.connolly@linaro.org,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, lukma@denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com,
 balaji.selvanathan@oss.qualcomm.com, abhilash.v@oss.qualcomm.com,
 Michael.Srba@seznam.cz, sjg@chromium.org,
 varadarajan.narayanan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Subject: [PATCH v3 01/12] arm: qcom: add common QCLIB SPL extension helpers
Date: Tue, 29 Sep 2026 23:34:38 -0700
Message-Id: <20260930063449.3251317-2-abhilash.v@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
References: <20260930063449.3251317-1-abhilash.v@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX9Lj7LEHn72FZ
 FOuhLlqW2HrqAZh/R7r9wnD1kSMCWlY87ts1q4DNKqxYS/DMuSWftFjxwyMCO3RV0T4iu0bf1vj
 X+i1XOveACGGI6hc0RJyE6v0LsJuhRffNCGn5lrm1sonnzQ63rbPDUZmPQzJGzswU6x2wP7lAnU
 /vqfXmgR9iD4PvJPnrBlZFAOybkI30/3H+YWs47M+NUZfW6hQTHgK2Y8Pqt4SKBybxKsrUzoT7Y
 q6IWG9gXybWe/2arxJv/7J09Gn85ws4uxEg9NOdKF5Z1kyBTUCaXj3Rvqsp66R48dXBf64zIAWd
 ZtAalfcb30gnyFmACzmzWP2HZs+QQ/WT3XcaC9eKp9weDjyoaBg1S0RzAsPaAk6V9t7qC0Tt9Ji
 YyBbdqJrOGL+E18kfnhbVXs9Dq2Ul4TFWhapTewiucBv8hdhyXnAK4k/BBx+8qB2/vdOiRDBkgz
 bJoQrMQRtsoVhjuR2iA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyNiBTYWx0ZWRfX+cS+UIj0oTAA
 AWQDmQkWCx9GCn2aTeVAbTOQo3TkU7yIf8nZ3SICt7sz4IHKyEmJwHjSVaviO4n2UTrhvgHviJz
 9g6zJexaGmtrUXW7JAbKHYns+J9ct6Y=
X-Authority-Analysis: v=2.4 cv=RZEFmFtv c=1 sm=1 tr=0 ts=6abcad9d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=WN52PlUurRMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=2F8QJI7O2KTJmeVboGYA:9 a=3ZKOabzyN94A:10 a=xE34mhsjmDcA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: MgPj_3ETRwu52egBTW5KeiN3oCGu12lV
X-Proofpoint-ORIG-GUID: MgPj_3ETRwu52egBTW5KeiN3oCGu12lV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300026
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

Add helpers for adding QCLIB interface-table entries and FIT
blobs, expose the DDR self-refresh exit address, preserve
U-Boot global data across the QCLIB call, and provide weak
reset hooks for SoC-specific SPL code.

Signed-off-by: Abhilash V <abhilash.v@oss.qualcomm.com>
---
 arch/arm/mach-snapdragon/board_spl.c          |  8 ++
 arch/arm/mach-snapdragon/include/mach/qclib.h | 16 +++-
 arch/arm/mach-snapdragon/qclib.c              | 77 +++++++++++++++----
 3 files changed, 85 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board_spl.c b/arch/arm/mach-snapdragon/board_spl.c
index 3293eab8f81..5aa84a3a6d1 100644
--- a/arch/arm/mach-snapdragon/board_spl.c
+++ b/arch/arm/mach-snapdragon/board_spl.c
@@ -27,6 +27,14 @@ __weak void reset_cpu(void)
 	hang();
 }
 
+void __weak qcom_spl_soc_shrm_reset(void)
+{
+}
+
+void __weak qcom_spl_soc_rpm_reset(void)
+{
+}
+
 #if IS_ENABLED(CONFIG_SPL_SMEM)
 /**
  * qcom_spl_populate_smem() - Populate shared memory (SMEM) information.
diff --git a/arch/arm/mach-snapdragon/include/mach/qclib.h b/arch/arm/mach-snapdragon/include/mach/qclib.h
index b44874c514e..10865b03ea1 100644
--- a/arch/arm/mach-snapdragon/include/mach/qclib.h
+++ b/arch/arm/mach-snapdragon/include/mach/qclib.h
@@ -65,11 +65,25 @@ void qclib_set_qcsdi_address(u64 address);
 u64 qclib_get_log_buffer_entry(void);
 void qclib_set_log_buffer_entry(u64 address);
 
+/* DDR self-refresh exit address accessors, populated post-QCLIB */
+u64 qclib_get_ddr_sr_exit_address(void);
+void qclib_set_ddr_sr_exit_address(u64 address);
+
+/* Interface-table entry helpers */
+int qclib_add_iftbl_entry(struct interface_table *table,
+			  const char *name, u64 address, u32 size);
+int qclib_add_iftbl_fit_blob(struct interface_table *table,
+			     const void *fit, int images_node,
+			     const char *name, u32 size);
+
 /*
  * __weak SoC extension points. A board's spl-<soc>.c may provide a strong
- * override for any of these; the defaults in qclib.c are all no-ops.
+ * override for any of these; the defaults are provided by the common
+ * Snapdragon SPL implementation.
  */
 bool qcom_spl_soc_check_dload_mode(void);
+void qcom_spl_soc_shrm_reset(void);
+void qcom_spl_soc_rpm_reset(void);
 int qcom_spl_soc_pre_qclib_routine(void);
 int qcom_spl_soc_qclib_override(struct interface_table *table, const void *fit,
 				int images_node);
diff --git a/arch/arm/mach-snapdragon/qclib.c b/arch/arm/mach-snapdragon/qclib.c
index 7f25f37b5d9..b9a74863c1c 100644
--- a/arch/arm/mach-snapdragon/qclib.c
+++ b/arch/arm/mach-snapdragon/qclib.c
@@ -2,7 +2,8 @@
 /*
  * QCLIB interface-table protocol: generic, SoC-agnostic orchestration of the
  * hand-off to the QCLIB firmware image, plus __weak extension points a
- * per-board spl-<soc>.c may override to populate SoC-specific table entries.
+ * per-board spl-<soc>.c may override to populate SoC-specific table entries
+ * and provide SoC-specific reset sequences.
  */
 
 #include <cpu_func.h>
@@ -15,6 +16,17 @@
 
 static u64 g_qcsdi_address __section(".data");
 static u64 g_log_buffer_entry __section(".data");
+static u64 g_ddr_sr_exit_address __section(".data");
+
+u64 qclib_get_ddr_sr_exit_address(void)
+{
+	return g_ddr_sr_exit_address;
+}
+
+void qclib_set_ddr_sr_exit_address(u64 address)
+{
+	g_ddr_sr_exit_address = address;
+}
 
 u64 qclib_get_qcsdi_address(void)
 {
@@ -36,6 +48,42 @@ void qclib_set_log_buffer_entry(u64 address)
 	g_log_buffer_entry = address;
 }
 
+int qclib_add_iftbl_entry(struct interface_table *table,
+			  const char *name, u64 address, u32 size)
+{
+	uint entry_idx = table->num_entries;
+
+	if (entry_idx >= table->max_entries)
+		return -ENOSPC;
+
+	memset(&table->if_table_entries[entry_idx], 0,
+	       sizeof(table->if_table_entries[entry_idx]));
+	memcpy(table->if_table_entries[entry_idx].entry_name, name, strlen(name));
+	table->if_table_entries[entry_idx].address = address;
+	table->if_table_entries[entry_idx].size = size;
+	table->num_entries = entry_idx + 1;
+
+	return 0;
+}
+
+int qclib_add_iftbl_fit_blob(struct interface_table *table,
+			     const void *fit, int images_node,
+			     const char *name, u32 size)
+{
+	int node, ret;
+	u64 address;
+
+	node = fdt_subnode_offset(fit, images_node, name);
+	if (node < 0)
+		return -ENOENT;
+
+	ret = qcom_spl_get_fit_img_entry_point((void *)fit, node, &address);
+	if (ret)
+		return ret;
+
+	return qclib_add_iftbl_entry(table, name, address, size);
+}
+
 bool __weak qcom_spl_soc_check_dload_mode(void)
 {
 	return false;
@@ -43,6 +91,8 @@ bool __weak qcom_spl_soc_check_dload_mode(void)
 
 int __weak qcom_spl_soc_pre_qclib_routine(void)
 {
+	qcom_spl_soc_shrm_reset();
+
 	return 0;
 }
 
@@ -60,7 +110,7 @@ int __weak qcom_spl_soc_post_qclib_routine(struct interface_table *if_tbl)
 int __weak qclib_populate_interface_table(struct interface_table *if_tbl,
 					  const void *fit, int images_node)
 {
-	struct interface_table_entry *log_buffer_entry;
+	int ret;
 
 	memset(if_tbl, 0, sizeof(struct interface_table));
 	memcpy(if_tbl->magic_key, MAGIC_KEY, strlen(MAGIC_KEY));
@@ -68,17 +118,10 @@ int __weak qclib_populate_interface_table(struct interface_table *if_tbl,
 	if_tbl->num_entries = 0;
 	if_tbl->max_entries = MAX_ENTRIES;
 
-	/*
-	 * Reserve the "qclib_log_buffer" slot — common to every SoC.
-	 * QCLIB fills in the address itself; SPL just allocates the entry.
-	 */
-	log_buffer_entry = &if_tbl->if_table_entries[if_tbl->num_entries];
-	memcpy(log_buffer_entry->entry_name, QCLIB_LOG_BUFFER,
-	       strlen(QCLIB_LOG_BUFFER));
-	log_buffer_entry->address = 0;
-	log_buffer_entry->size = 0;
-	log_buffer_entry->attributes = 0;
-	if_tbl->num_entries++;
+	/* Reserve the common qclib_log_buffer slot. */
+	ret = qclib_add_iftbl_entry(if_tbl, QCLIB_LOG_BUFFER, 0, 0);
+	if (ret)
+		return ret;
 
 	return qcom_spl_soc_qclib_override(if_tbl, fit, images_node);
 }
@@ -146,9 +189,13 @@ int qcom_spl_invoke_qclib(void)
 		register void *x0 asm("x0") = &if_tbl;
 		register void *x1 asm("x1") = NULL;
 		register u64 x8 asm("x8") = entry_point;
+		u64 saved_x18;
 
-		asm volatile ("blr x8"
-			      : "+r" (x0)
+		/* U-Boot keeps global data in x18 on AArch64. */
+		asm volatile ("str x18, %1\n\t"
+			      "blr x8\n\t"
+			      "ldr x18, %1"
+			      : "+r" (x0), "=m" (saved_x18)
 			      : "r" (x1), "r" (x8)
 			      : "x2", "x3", "x4", "x5", "x6", "x7", "x9", "x10",
 				"x11", "x12", "x13", "x14", "x15", "x16", "x17",
-- 
2.34.1

