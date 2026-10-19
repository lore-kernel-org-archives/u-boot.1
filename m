Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69828CCF2E3
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 12:04:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A615405A9;
	Mon, 19 Oct 2026 12:04:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R77svje0QtG7; Mon, 19 Oct 2026 12:04:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3BDB34066F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792411467;
	b=AacejyrAHU9t8Hc199kUvxvpDFZgyb7KkScGpETfi64qRuRN2NX1PUyq+fho7joto+Ks
	 OoP7AoCXQfsJwD0FdCIrcv6pM0xQ/XIJ7QHJCJrjl5cMsr21ARDkbbR08y9+KGEQFkHJa
	 Lvr5nJUQIIUqbcEU6+0Pe3oal/xrwZANlupMmTgNP9wB+ZQ6YypovtDEt0KAidvJItTXP
	 sw0wtf+69ZzqZHx2E/eQYat4Pgy9WRoARHWuifAWSM4bp5FspSHgOa7Zj/lcuyIziXSrh
	 l6XDUKu9HxTBuEJ0iDg0tJa/aCTroTDy02PffkPFH5UCBPeAqROIpvtDfluAEC/5XQw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792411467;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=CUtMD386uKeNQtLwlv/1jp1V1hrIypZ274qYV2arQyQ=;
	b=IbPAgjnDILA7VHf1StJle8rnELWwa+uJ7+xoQE7eggwMRl93EBZp7yZYyQEpNUoe2WDW
	 UsXJAlYNX7mpo22xIlhqhW3J2w8ZRwDegEGbF/LDy3oYMjqQrWHGJfmmkPXqnN3ZKjTUU
	 Qk2XWslSmu38QvbHkcg0qxNbk77xYjxGKILtb9Rr70K6HjYquz9mqlhTrGg1DaLPC1AS8
	 RBD17hl1jisZSNKX9IJd61k4kbYOtdtmE36UjKH29cGTxSv141qECc6Ae/JgK5E6LHB1s
	 lKMC33BqJChTuIaz/rUnGakZYIhWdswGV/ywLv10Icd+3ths0E4cGK9E4TTANLSh9ZA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792411467;
	bh=CUtMD386uKeNQtLwlv/1jp1V1hrIypZ274qYV2arQyQ=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fI4IVS9Qe5bNQE9vh4NtQnpTDcvcSkX1vuCRoW8OYO4Y4vwv6YSdI+JRmpf9rKQHf
	 nEHavXBHG4XOrxe3a1yh/Mq4ktvdJkB0ERmbQOPGX7+nxn2y/sp5P+6WIYAdX7EyPT
	 ODmmIkutB4J9s3yc1J9l9P/LXEDhr8Km5dULzJiWsGKlt0xVFZiQmPpaZkKPGVtXFl
	 0Q+rcRoiXAvM1OpFM1iDXE1TIrHYmh+KmBXQnzsCBicH31yi6z61EhLWtDGz5FwB4J
	 r8vD/eFhEah2TeZCDSV9UZClgVbm/DLgDfSDy6k1PZ8eF4HngL+Ahm/xYawODTB3Hq
	 qr0JfH3xwNCJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BDB34066F;
	Mon, 19 Oct 2026 12:04:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 685A022B
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4EA48400B0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:04:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KHKGWdLpUVfe for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 12:04:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6EAFB40079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792411464;
 b=NgaC/3FZ8SdGn6gvvTu64Nw+ExCH4MVTLCiSUVQF4BPlbkY32eU6U+Sa98pDUWxlcoYD
 4PcJX6KWK7mb32cTx4d8GqkPNyiKggbY75zUscyzbg/xtoSg/QrhbKIu4Ini8wBw8lS2g
 JUvCbPw/TnJw0zzQ11Iuqq+lM9zAWBO+dDOAoUjMe7Dm/82lmVcbZJS4zJqWkts74CgFl
 U1bpc/Fumt7MYNhEjbHSOdwYcMJsnQdmDw5iz0PYQp2A5StL1zshtPulv6uBQO6TIls9X
 eVeFvT3EXaQ8HVAPB3gRmrqe9nuCNig05u995+h+aRiZe4usUAN45D9ebmGtch1TuLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792411464;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=CUtMD386uKeNQtLwlv/1jp1V1hrIypZ274qYV2arQyQ=;
 b=lu0+UJXovCg2Zf6NmKHx0eR4ScFixXV8lBxa+TC5M6KXP+P19eKsyAediqHFtlaAGNjj
 54oCvJUt9XnOqaD8yMnSXnrIL8yON/gaXos14YZWQEShHMmDEttieHBMwU8HCviKM9g9a
 mHQN2TIvBM8Vnwy1Un4BjoyZDBQHwNJr9BY2LH6uhkTE38vZhpaRnbTAAS6yKw4L/HMWt
 U4JRkm1QKkZrP0pG71kOabs9qjDLDW88uFsH4UP1kw28ie8+mCNKcLGSb8p5hvPqvi9YK
 DDCwFlSl1VdKJgEty9rvZpt5Nztik10F/r42nPFYA3ShdAdo2dQ0WKEcDBV2ISsi+HA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=CgbEwx8K; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ND4flCXl; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=CgbEwx8K; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ND4flCXl
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6EAFB40079
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:04:23 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8YhZP2688707
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=CUtMD386uKeNQtLwlv/1jp
 1V1hrIypZ274qYV2arQyQ=; b=CgbEwx8KzA0mw6XbPSyRw0V4DRzckMA/mf6rjz
 13HBwJ52mA3ntq+/vHn7m1hyjD/scbdZTFS6h7zcQUg4oQ/8m9SP0Lcg/8QpKiZ3
 w+REVJKfRMXsHNzYs+NjTp2RP+eeZoq5SEd0fpwLCe3p5op0SMMdyUkF2ClcJcFn
 v5nGUqHtPLycl9Vay1HKTzxNJf5AYbqir36/N1CUSeeUevaCK2bZMGGnKle2f/u5
 GsAAWGu5kNs66iFm4snEYi7q8iYrDwiiDDzgAXV6r/7Gh/0tw3GnanfcPbQhf7wV
 DLqp075TEDSW5dvwuq5RHeQSVioSe5MtNdmPwE4T45SK/sqQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdftn0s9b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:04:22 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so4415238eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 05:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792411461; x=1793016261;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CUtMD386uKeNQtLwlv/1jp1V1hrIypZ274qYV2arQyQ=;
 b=ND4flCXl/Rbcf0FJW+vLPS1K/ipLMnL+sG5jhPRMyFccdaYkLLniGXMGveFF1KxUCu
 MAGa4r84brzbwQQzxLBbg9t5h3eRWrmza3X+V+8fZCb9OYpweuKY+e1LtQqk3EALmIFa
 iafigLcbhctyuzBA3Ew+Rjh6ecJWkhHokSQdX7DltR5oI6H1GMH/+lkDoUa26t437Mr4
 8gPm8t3hzwYpwrlUk0zjv7WSLZRdexcrn4JlFbL0gX/G3P72hdp0B/G7lksDl4Qb0G7J
 v5M2EikjyesUesRXhdQO+qB3fSkKBxvyGwuG+gWV+7gVOhbrysG0+aQgowzpndgAR2Fq
 8fVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792411461; x=1793016261;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CUtMD386uKeNQtLwlv/1jp1V1hrIypZ274qYV2arQyQ=;
 b=ZQ+wzZJiIfB6AneMo5Dxmqm6YOVqz/Gyk6UvlICYo3BlxPOg4yh+48zDaH5js49DMI
 UzHhRQ9Qh9jNrQBrgKsmuWaRt0rJeIbQpdjiYJrQQX1ECKosECMDebyyNzrG5V1OzPCR
 jOmr5/gN2QhL8xjqe/iz+uvdra+ostu+yYVu7tv99H+etDzfDnAp4CWIyU/b3vGx90Lc
 xYVmQXDMDLWKQX5VTXTlJkDCsukcs4JkqvfMT9LFe7beMeWLzDiVywVwnckXLjrKZ24r
 RJdDy0J5gp5bpt8QQTZglMGRkOuSy+0Z7mDrANWtl/4a+9JDeYRH26vbbWJeMEIqa1sS
 Z8xg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrM0chIeNcR+o+gcu8zlfsomVIQMgdDkPUi4ge009BXe+HB99UxQ5uzSu19siB+6C+LDCS3Yc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLmc+6X5OT3hO6p1ezhdd3oJmdDgPZKcEl8MMJb+K+DkEbzpJmQ
 0U504GLcMvYt1Rv4VTdsPlq9f4EY3FMowe//PghypVJaCG+ZngFwleiUEPl5pYHExyqTZDWPUg1
 vXkZXrtzJsVjpvABghxZAM5tVQRQ7E/sTi/VRP1H5V7n7E25dmfEKEZRF4FsMj6yLf8bV3gDmO8
 Q08T0=
X-Gm-Gg: AYBFou03CRfl+pNaMkWkkPTcChnFh0EmxbrJkYGdLaJv6kBOHhU3FaZbK6LuxXjeQf1
 7kTT+f+QQTtfVp51+1mqNBpYvCesM49212hZcMEadyHJ03LYpKCOQf/ck5B125b3FxyTP36omVm
 quyIWUwNmb3Xzc/1RtepxVWqBrACelTRM/Eb+yknEU++L1101KEULH6sdNJ//bVR/p5eSoyNnoq
 CNY0vfFM/DfH/SrfkBlOTUp48uBK5eWzB9hAlrmJJabKEoqrDO7svrYSn/8mrcAjK5TI4Ktbeub
 sS7mnmfYSlJ9cDb+kw3mA/vpZwTLjGsFs8OYHxIwf3BxaOh8EiyOlANCszXGMqpf8tKvRjpQ9od
 54uKfKWs+4UQOiuCAIlBXom/eD6knsCdDtGmRsK+hIv734BybzVkA8dDXjZ8Bk5zdv+Kur5ZdFg
 QX/LGlG6arPnEzwgDP+/eEzSNL5kk=
X-Received: by 2002:a05:693c:62c4:b0:35b:e2f4:b606 with SMTP id
 5a478bee46e88-361a1d4b723mr9758701eec.25.1792411461351; 
 Mon, 19 Oct 2026 05:04:21 -0700 (PDT)
X-Received: by 2002:a05:693c:62c4:b0:35b:e2f4:b606 with SMTP id
 5a478bee46e88-361a1d4b723mr9758621eec.25.1792411460299; 
 Mon, 19 Oct 2026 05:04:20 -0700 (PDT)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360813b6e33sm33595242eec.7.2026.10.19.05.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 05:04:19 -0700 (PDT)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 17:34:14 +0530
Subject: [PATCH v2] configs: qualcomm: Add verified boot config fragment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-verified-boot-v2-1-8fdb559574f9@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAD0H1moC/3WMwQ6CMBBEf4Xs2RJaVIgn/8NwqO1WNhGqXWw0p
 P/uyt3LJG8y81ZgTIQMp2qFhJmY4ixgdhW40c43VOSFwTTmqBvdqiz7QOjVNcZF9a2TsjMB8QD
 yeSQM9N58l0F4JF5i+mz6rH/tP1PWSisfdLD73nbWmXNkrp8ve3dxmmoJGEopXwpnyWqxAAAA
X-Change-ID: 20261013-verified-boot-83c01372fee5
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792411456; l=1151;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=paWaNzlIJFREtx58jzSZbc3oRdlmPpJDR2wflyfFBAI=;
 b=ygXAkPz6tVbWhFygp/u0B0cuRFvHCOJ69yEeIm3IhzH4UqL9RKWxW/pALhrZCla7MJFoUCvJ+
 DLCSwoJHPNTDToUi5aGt/9oU1l7RQTGAJfTn847iGLh4Bhhhwei3KOw
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0NyBTYWx0ZWRfXydJ2chIk4SO9
 kRhB8050dwChbpg6yWXzgaxFdKp/vGcdVTVWWHkIR0w8MgUK6PuJRLK/PKW0LNW7BuoaF1Z+zhq
 HdWnPpCiRVCBy+9pE7ssecRG60TvHuU=
X-Proofpoint-GUID: gNW-YzMvuf2L4FMYN0HDrZ_hxjHcTqd4
X-Proofpoint-ORIG-GUID: gNW-YzMvuf2L4FMYN0HDrZ_hxjHcTqd4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0NyBTYWx0ZWRfX08mXY9/AP+Cg
 LlNRdPS1LsAeQSvjNnsa1vQeNtL60wMax3erA0EAcP4kXw+JS7kIacYqh/jF5jW5FTtNigKrJEx
 /hkFTuMdmnkr5cyj+o+mkZegMZZ6vjfJP8UFQUb4QAw8tUCQtqA6ISYy9GiB3IfTNVXgguEFsB9
 ELcpMpxlGbv+bzWMIynjBuVZD7k4Bq03K/DY7iIBddPXnXjmZhhMZhrZzWRR8uZ41bYAbMo0lBD
 Sub9x838ikw8obI0PrysMWv9B4KHv0fD9vlmq7yykGSdzyexZF+QyviO+MwHhviyjFBidMEbgwq
 epUAJKpBpwB9bnCGkr7/vSSNig1G5cBQka8u13PhyAmYPHStnfWMnY8u1tm309uEgV1x2Nic/9f
 +P1EHabWF0BcLkfyiAuUCUXI2LRAXGFzuKFf6jZhSON4rykVxElWJBjWiVBx5SFtxzqAcZyZcgh
 vLNKNbAhAZp+DQzV7zQ==
X-Authority-Analysis: v=2.4 cv=OvTaWC/t c=1 sm=1 tr=0 ts=6ad60746 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=p0sy3Dyevd3I9G76ySsA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190047
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

Add a common configuration fragment enabling RSA-based FIT image
signature verification and the required hash algorithms, for reuse
across Qualcomm boards that verify a signed kernel FIT image
(kernel + DTB + initramfs) as part of verified boot.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- Move the config fragment to board/qualcomm/
- Link to v1: https://lore.kernel.org/u-boot/20261013-verified-boot-v1-1-df1fa48a7ac2@oss.qualcomm.com/
---
 board/qualcomm/qcom_verified_boot.config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/board/qualcomm/qcom_verified_boot.config b/board/qualcomm/qcom_verified_boot.config
new file mode 100644
index 00000000000..8aff098944c
--- /dev/null
+++ b/board/qualcomm/qcom_verified_boot.config
@@ -0,0 +1,6 @@
+# Enables Verified Boot support
+CONFIG_RSA=y
+CONFIG_FIT_SIGNATURE=y
+CONFIG_FIT_RSASSA_PSS=y
+CONFIG_SHA512=y
+CONFIG_SHA384=y

---
base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
change-id: 20261013-verified-boot-83c01372fee5

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

