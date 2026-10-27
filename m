Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E2D606A325
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 17:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vI/NVcF7;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EEERCTRj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=afNfw0Xj
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D8A45606D7;
	Tue, 27 Oct 2026 17:38:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uhntld1ZGHPk; Tue, 27 Oct 2026 17:38:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E038D60699
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793122705;
	b=D0PwOyY7OJB6dK+2TA2QaFe0hTOh1zlMNzGwSgCfm7iJ+2V4azC3KAmwRXDF8BR5/kwu
	 dF8uW7JoxUKpAXIgm90Z+A2kFVn0MZrYMIt6IRNN2VEF0QOUHIqT42hJJ+AGw/chhhQSj
	 fJif2biSZeGPWW3rwPVw6Wz96ZNtT3YEIaL9wzD/tjF12P/HGntgZgLwQGOvpHFljFC5S
	 OWQ0oXCwiFC9WYbs4Th3C68LXTb79qo0LfB/8KaQbOCMsZ7FGv6TZXx7lse5TUTBB+bSc
	 NppE7CuI0MuKvI+dStdizu2Mq3dOYqBtNVv/sorB4hTvBNGxs97vNRkoqNQsDvHtbuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793122705;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=3FQH4C/Lckjb7aAotcwBySLt2EuKeVKiyftMIcNy0OI=;
	b=s5X6lVUe3SYDJLqKDm71yTlIqb0l5qBmSTi5nrct3KcXZRW/hCxb1XnvzcKUOtuENRCO
	 6HHDkzZGw5UObSYFMemfUqCR4wfb1NT8DQFkGAzjytJlzVelfQhlex6xh5Pr6on15UK/h
	 CJI+7CNMFbZF4gIQmqilvQFpAKLMYqksbJ0tQPa+jEMrRyoEeuLxdxfAT44YqUCgxqCMX
	 RNl6Oc28wr/wiju6H+UuDuGZJogUsI+Tz9rX8TfkvMGqEunGiHPFGe0GBi9B7aXfKeNvE
	 X3xrMZbRUpSsEXjw7x4oki5tP6pWvCZpIWbAXdiVE2mCVNrS4+tZMxP+NlxrPNyPX5Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793122705;
	bh=3FQH4C/Lckjb7aAotcwBySLt2EuKeVKiyftMIcNy0OI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vI/NVcF7c9qn7CK73jlodzOE56oPdosToFyU0C7RdML4LmHRKer7BQkg9NXG/jRue
	 9oRos69qPSNd2t7fS0045//xnwmDgjt7lvtaRdjuy+y9QKUGFyQCmR1QjhfC63tCJ6
	 80nVbjFkGfiF9veBWgAeC5t5plQiJ4x92VxQWo3ORMswRazelfRBC0EpOFSw/iKiaY
	 XWVrQDVoGGG8qWj8UFjHeJqLJ1xfYvVUCByMxAphzO12J7EQkOznbQc9mkx68GZ3Y3
	 ldOIKQFUoiqbzw5bVwwsmFNsnpOprHGC7xE4VqtVrmtbkKKW3OCEQ0uPVPNjfDrAR5
	 HChnTSmivvbPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E038D60699;
	Tue, 27 Oct 2026 17:38:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7ED6372
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:38:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 702C7401B9
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:38:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kCbiCG04VUii for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 17:38:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D47744006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793122702;
 b=E2Tuf4J6tOJRea022BNpVwQxkDTRFMv7xAFrBrTF26QR2HcX18vIeE/uCk2iGnQF5G48
 +nG9mjOXDM9070JzmdJ/xlgttiRxL6Ubc6M/0SfEd7XmLECH0OfzIVm8z7C47dcP5s13V
 2cobe2gg3e76pQ1sdri8xtoaUD5Vvk62JHeiXDcv3vVtlZ9R04ha4+FwQqqBS4gDTzXu7
 nJROL8V4sWQIB/3SppyzFqq5K+HQFSVQtZCjrcCJrk210utV5eZ0n6drVj7jF90/JvLY0
 NVotkQR0Qnabr5evAIH0tRsRwfdI1OXNKXP7o+EY5aVApCkHkTVefhycK9sLyy9Bw5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793122702;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=3FQH4C/Lckjb7aAotcwBySLt2EuKeVKiyftMIcNy0OI=;
 b=Ki/4Il8A9MfG9pOp//WqMpseoKeFOVyX8ea3hwIDptLVGcsyv3prnGfol+2lHvFgwcHE
 cgtSFKKEeUrJUgwKGFYp/QWmM++2zdicemHkEiR+DNnu8UneOXP767qGQnoxWvZ41nITQ
 5/fN+m1KJdkpcrHnYBTBbEV3MYZioJhA/yDC/cuaXTLuEij/rXMSXeD//a9m7arTLCmiP
 Cyh/DwYibQHaj3+yhxtSI6uZsz24JPD+e8MbaHpsXmDU0g47RJQ8JQcoUVLwJVqUdw2Sv
 Z0jztfyOO+zOAWflcvrcqkfMXJQDadogG9XywhE6OpAdWm0tFwr3+OV6n6W7YLwvuJA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=EEERCTRj; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=afNfw0Xj; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=EEERCTRj; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=afNfw0Xj
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D47744006F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:38:21 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RH0cq72827690
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=3FQH4C/Lckjb7aAotcwByS
 Lt2EuKeVKiyftMIcNy0OI=; b=EEERCTRjWDuWQC9rp5DF0G6D7kniF6TOjZOFBx
 /lpi9gvAPlGGfcYud8uwC0yJXLtC3YZH7FyTeCY9nL3VlIRUchah/FVaBRWizETg
 9cBPku+h7lwZEss6eDU71JE/CUmEoScb9n/e12yNkM7zSgFH2Tn113qQiiztCACF
 QmMLya9IfP7tUBEMMP1pN6mxshx9gtqsVMZ1eljdcHhTyGoCn4rrJsVUWJG6Zzo0
 KuuYbfEGV6Gh1WmRd8t/aizTw0D7GfokZXfakFGRwUuAaN80ervEpBVKD6ilq/XV
 uaQV3BLIQrA1oQBygi7wYaUfVbH3FBdCHF+idsKMTCcwhDeA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjst1hxh9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:38:20 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb98809caso3828485a.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 10:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793122699; x=1793727499;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3FQH4C/Lckjb7aAotcwBySLt2EuKeVKiyftMIcNy0OI=;
 b=afNfw0XjV/aHDRej4WQVIa0hwnHiw5IWIcmpDUGKg+vALd2FGzdyUZN/sSIJSx2Uth
 lBLBIRr0JSDKIZE6KOpTIJrGiWWSFvrwf5eQ5Sxn50HxEvjeuy6pvfeIKYfpZsyoASnT
 6ePUhHTQ4fpKIlt7hgJAet3NYc40d6ONIPflA250XT9Ot0Qo7xHd2e22hLCS46BU3zPa
 owWWil1FOiLE6mz+Ob81O+58QA2yTHFNmiJz7QABK2A33CtuPFGjzRcYivuuiux0m9gl
 3tw2Tq/fxdTv/hEGJAVclGpTrHCDCBizYKtfOa1uxo+O1kFuKge/0EAFOR3h2zfPKkvm
 /HHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793122699; x=1793727499;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3FQH4C/Lckjb7aAotcwBySLt2EuKeVKiyftMIcNy0OI=;
 b=BV75K6KNlovp0lpsrj1/oKLcvtvwXGJ/kprpfpxci7NGDzABLIMn/7Ekto5c1pWADH
 4FLaA2Svb9ciKFp0xq2BMz47nm3yPXgOrV7RNWc2UnVWmNFXFGXszJtYG8rhMc1a47ZY
 ye/0U9r8kO405BTHWyB4EXAy26/3fcz8vOfzNU9SpHEVJjpCQl8gEGL9sNuvCmsuiSpl
 7cq9F3YbcJn0TGvecxeGzZ+ZuuVYC9iNH0NYnrqioUA9lc/h9nkwtU+baxxRHjEg9pdc
 9+wi4Z9JB7MwEaNtnBlyGSNdbg4+TbCtHlcaYEFspU2EjwtzBOUslg5Rgb2pdmAcqudy
 FXWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByJ3ydn4dN1zoIUUanNy9auwxHs2mIwrNZGK0HAy/AeplZ7wJET8r4K9BVd/c+BvW/PfXiQRz4=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKb8Yk/a8GtOiCx/jxHd0ML3Htg1auLQ/ZJJ0fv7UP9Ale0Wy/L
 ScBQWFajMEnhQvfOs2+2PcQi0v/SnjxUgcyoqz5bT4y/SDIpLavED5TjPwhO1CeYZ8SKmZ84k6F
 CAYJCxcEe3mhP09wlqVav5SB163nngTvXljU/Y1eG4Y5yGw+De6t4Yb7ecgA3vINnFWwuQ5o=
X-Gm-Gg: AYBFou3toKqXqa6eJqHjV0KJACKkVovUe+Z9to5Il9MOpZVcWsXuhXU+afcSFXU84ui
 8DOBBoZQSMAJxLHqBqUzRxsTUqhiZY9hA0T8kEZvNlYz8/Z1RAkWs1GVdWO82yagjhhAra0TZKE
 RzPFRTQV9rL9z86yQYFVs77ViZMBzH11eVCKfTomRV4cygzlbvaudaHrN82mWAtNqXByM5MjDuh
 VrxtXEyH1h2Osx8IcuJp6FIvkRqILECi2xzpE3TkKmKkFULFChlFQ7dAKXCn/yoqSzEdNFsGYeE
 P8bblMpQTHk3MzrJhnS8B0S91I89GCvpm6EVdRjQsBP4TShQW3JEPMMIDfTWU3gkRPzEpumV+x+
 S8SZ8xFOdrRH57D1UP4je0fOfMIoGNbbCk8R2njE=
X-Received: by 2002:a05:620a:7108:b0:93f:5717:e7b9 with SMTP id
 af79cd13be357-940ef8d844emr1630915485a.30.1793122699296; 
 Tue, 27 Oct 2026 10:38:19 -0700 (PDT)
X-Received: by 2002:a05:620a:7108:b0:93f:5717:e7b9 with SMTP id
 af79cd13be357-940ef8d844emr1630911185a.30.1793122698811; 
 Tue, 27 Oct 2026 10:38:18 -0700 (PDT)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd64cd1dsm482312766b.45.2026.10.27.10.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 10:38:17 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 18:37:49 +0100
Subject: [PATCH] mmc: sdhci: imply LMB_LIMIT_DMA_BELOW_RAM_TOP
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-upstream-mmc_sdhci_lmb_b4-v1-1-c4724f42ac0f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAMAwA0atI1ha0+AGvIlKaNmrAqjQqgnh3i
 8u3mHlAKDIJdNkDkS4W3taEMs/AzXadSLFPBl3opix0q85djkg2qBCcET87NktAg5WqRyTtqbY
 VIqR+jzTy/b/74X0/f1GGLGsAAAA=
X-Change-ID: 20261027-upstream-mmc_sdhci_lmb_b4-5fbe2de5a4bb
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 u-boot@lists.u-boot-project.org,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=HJ1WhYtv c=1 sm=1 tr=0 ts=6ae0e18c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=k-42gJp3AAAA:8 a=dh_o2C-iFFc48gv_PCwA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-ORIG-GUID: -C0juvMuqebRsrXAIDf0cSocCDQdIMBz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MCBTYWx0ZWRfX/3K/kCZK+E92
 +6HvcyrzfjVU0+pKrYUOUiS1Pi0RRpINOzW9+Qo1miTrK0W8bbEBTbdQYMaffPuu6eskVCnZF+D
 wnU+/C9vXdEbQjbxjrKtPys2VVBGU78=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MCBTYWx0ZWRfX9B4/48c0gRgO
 ENysBU/h82DaWEKyiZF+Dy73HT3saR+KQdas3VBVhKm3wdyOkXuGJe0YFqw3SlJ+SwSIFCH45bd
 3kWmwSHr8l3x9krQtqqRR603CyZG64+7Gcpi/j2TfSmzw8/mk2w+JAeBd9v9f2di3LXB39OlTHz
 N59VoxdattsWyF1nvdJPnmHvsx9RMdFU7xoL/F1scvbzQ1wMe+yfEJh7MD5kjZmMfbIgkBiEFoH
 Cgd4nXiexyZny63jw+W0AQ0FN7QLr93H8KbSMp+7ALeyRer2qe0nvck72EF256yQNbv/ZTRDGUW
 uoWNFTYxKrRD4e5CDmA6lMMX74FIyCqZ5FPs5VNjJnixfrQNzl4kcRj7m3EDvu1S2J/P9ILpXKF
 SSYGtMdNAPGpE0nVk/98WMpaJthFtRm4kz3efcQmJFHNexBPnwywe8QjJHcK8xxPg02sX+OJM6k
 Zc5K0YYdrBAJoXrZiUw==
X-Proofpoint-GUID: -C0juvMuqebRsrXAIDf0cSocCDQdIMBz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270070
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

The generic SDHCI driver transfers via 32-bit SDMA or 32-bit ADMA2
descriptors, so on boards whose ram_top marks the DMA-addressable
boundary, LMB must not place images above it: a later load from MMC
into such a buffer could not be DMAed. Imply the limit like other
drivers with the same constraint do.

The option keys off ram_top, so it only takes effect where ram_top is
at or below the boundary. A board whose RAM extends past 4 GiB has to
clamp ram_top first; for qemu_arm64 that is the patch linked below.

Link: https://lore.kernel.org/r/20261026-upstream-u-boot_qemu_arm_b4-v1-1-223dd8060db0@oss.qualcomm.com
Suggested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
Split out of the review of the qemu-arm 4 GiB fix, where Tom Rini
suggested it:
https://lore.kernel.org/r/20261026-upstream-u-boot_qemu_arm_b4-v1-1-223dd8060db0@oss.qualcomm.com

It does not depend on that patch. Tested on qemu_arm64 with -m 6144
(TF-A + OP-TEE + U-Boot, Android bootflow from an sdhci-pci eMMC) on
top of it: relocaddr stays just below 4 GiB, the eMMC probes, the
bootflow is found and the "lmb" listing shows all RAM above 4 GiB
reserved.
---
 drivers/mmc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index b3731dfe4a1..6f732de8a8d 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -503,6 +503,7 @@ config MMC_SANDBOX
 
 config MMC_SDHCI
 	bool "Secure Digital Host Controller Interface support"
+	imply LMB_LIMIT_DMA_BELOW_RAM_TOP
 	help
 	  This selects the generic Secure Digital Host Controller Interface.
 	  It is used by manufacturers such as Texas Instruments(R), Ricoh(R)

---
base-commit: 559080348aee1da59de83dc32aaeedf4250279e6
change-id: 20261027-upstream-mmc_sdhci_lmb_b4-5fbe2de5a4bb

Best regards,
-- 
Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>

