Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4CF606A325
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ln5APTKZ;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jYxt1GrD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bqOcmgNr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3629880F7D;
	Thu, 19 Nov 2026 06:10:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fafqOdU2kJ5L; Thu, 19 Nov 2026 06:10:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AD5BA810B8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795068604;
	b=WIZnIO8M7biaut5pNikqVPs3zWr7zcJtCkCwLSZ/V3N45G00gjTB2pi6o0twQ4V347cy
	 tkQPM4zEUC/axhd7Xx0lQYmIWIvuinnHhzAmhYya/FXnXB8v7ixFP+CNpeYDN3FfeyiqP
	 aTm+90OJRxQVtH6lKdHfYuYuBvZmi9u4iRmRLtJImdxXINuFKQo1QhIskraFqWmiO3vSF
	 CeMX2lhRMruVNLsprktPsE0W1HAiOnde5hlAGSudOgpWENcvSi3ySvTZVFlgpOJ7jCD1M
	 LqQS3jaPxen+mj7LWbNQmaB+H8luV2gAgJ0LkH5JQVFIwvpGUC8uotousgsbPrqk3Ow==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795068604;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MelJKFhXmjOujlJyDfuuCHWbLVV0XnHfR4RmHw3kd9o=;
	b=e5Rj0XhP4QKQDbVk0+jddgZxz59biRujptYLRwCdFDXQpiXGCdhVh5M7A3+2sL8J7+MX
	 7T2xda04CFfXXYSbBNDlZZgn2Cx+9fQ0E/vx4avWIzJ3UGCNXNOnM8Bqpl48Ma0Wvop+k
	 s2MCKDspte3M4K/SgLdkwopqsgvrRctriQUPPusHzb8W10bCiv4brnTK33HNtujXWm1Jt
	 GDCTUu9+8uYzyQEIJ9ahrV0fujHDwDsESbPOuchsohVeAeW9oJEYU6hUEzqFmF7cb4lgO
	 /C3hsrTOgM6MlSwKXmjpuaDv4WEuMTg64C6PvJLpHHjNrZ7GJpgeFepyN3ig7NvA9ew==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jYxt1GrD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bqOcmgNr;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795068604;
	bh=MelJKFhXmjOujlJyDfuuCHWbLVV0XnHfR4RmHw3kd9o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ln5APTKZFFKQS8xPld6F6mxJvJbrrF6yzGq9GtJ+dgtHgVmNSwjIeNmWD3sO1xYT2
	 QZ5RG079DskkvuNPPXD9ZfiTl2XeBxV7Bsm2KvdUQrnbHVYnwtx4A19hkdg1QrFx7B
	 EvP71bu5e6/yeahy8OgmleoyETCyVzUgi6zDmb6+a8FtVdmx8quYllz/MxHK14sjMV
	 Hzg/DJj/J0abLevhOuNCPhULTXgRGupBGWqhW1qoPqZhTYMd45bJ7DNpnlxyWoo4Q+
	 BQkymBxq30w+hRtwJoUSw43K7NhAol5DAYfy6so7QqcY9kfkRzY03Xd7wPBJF+pj3O
	 tCGPbZ/ea55VQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD5BA810B8;
	Thu, 19 Nov 2026 06:10:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id B19F61C9
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9774D810B8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:10:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I6nFnd74Wi9S for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 06:10:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7F57E80F7D
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=jYxt1GrD; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=bqOcmgNr
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7F57E80F7D
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:10:00 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ1Atdp3780060
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MelJKFhXmjOujlJyDfuuCHWbLVV0XnHfR4RmHw3kd9o=; b=jYxt1GrDniPF2/h4
 5n4hjlgIs1RGBMyreqz58T+njfdaxSLDUVpGNDmnOfOtT+OfqzbueQmQx1q9wQAJ
 3XHjQhAkJRIO11fuT75Tjx/0UbAgQkl1+GRdilzE8tZA/oafh8bGvF4c8DJexBGt
 kYBHfRLM0yFdKaC7UkLwc72BbxTrorVHuurVrUgs2sf2vPpnBRXy66bJUmOA2ylc
 qfL8Nic9alKGBZIlmGSiShKzNvX/decBvNXVSm+CLbvSbjYDtLyN5rlyaK7h+q5Y
 3lluJSVo+RNIephe4rufhoXsd/we7zuP0GKgCTLwimfJmfgetXRaHEe9I+AH1N91
 bCjkHg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1fpnjx0h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 06:10:00 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3846d5f54c1so296143eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 22:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795068599; x=1795673399;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MelJKFhXmjOujlJyDfuuCHWbLVV0XnHfR4RmHw3kd9o=;
 b=bqOcmgNrpl51/OFUCWURZHrLyFC6MdN+j2QqkXKUz/24yoZLVS4PFEG+22ExtdbvR8
 /Qr5L/oFGrhPXkOXMyJeRG26jpj67Brl8+UcVx5dH42aUlbnNkYbrud/dhDC29iyVOUs
 1bf/giACPoUqJRDxD++b/Hip3U8atbxmZyEul+CuVcL+ZTX3VnidJSZn7upLpQn0ALLP
 lrrZr6fAT7z96WQ362486On6H/8LHOFWr4If8Pqu/lKnAXNLO8iDCC9vCNkB0Ak4TdVT
 Vd5c+HG0uSVZBZ0LDcgxRSAh6mbH6ASgitrBVYhBL5WR3tz25BU53VCCFBuXsfUh2XRH
 9SKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795068599; x=1795673399;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MelJKFhXmjOujlJyDfuuCHWbLVV0XnHfR4RmHw3kd9o=;
 b=A/Chldb9d1ZWNbcV6VP7PhtjwkDdq0VzHRbbT/ndKA1zdNtsaVtgWDf6aalNk2nurl
 j5lv5txcP1xFAgZ+8pbOz7hnFyqg0xgTTeWJT1F9ei/sJENjzAJ2mm9//6fE2CCAi2m9
 /hSYjYZriep1rLXBJp4FZXScUro5K6xYwEyASUK0wLBC1txDpn5+Sfi2Jn7i5Gq91KyX
 WRxHUWL9Gt1aJLdQdHmn6Tq3qr5wCXBPa4GcqzxqcBGCfAs/p26c7MBG9XGUY3pCfVBH
 J17CIzkh3uU+IT7utv/GJs95lY8B2fluWEbhH7DRslMeiguNDoyMnd4c0AvgVM03N/DR
 YH/g==
X-Gm-Message-State: APuU4Z9hKphPIeXF3aTkFVRQvHLmLB9hGHV/eAi9pZi+/jwyLeukbZNh
 X6gn93doUWgwzfL/+lxOK66PB2tQ8Et02NwcDOvAEqslbQE+pQRcOlNsG8oUIykMvIYwCobvzSu
 KBZcAQa/ZvHp6B2pxlTKcuBnCu9CPdYiR11M1mC7W7jb4eR0iO9c8loI8FGHaEynWB9qmzqk=
X-Gm-Gg: AZFdTZdEehJQUm3rOt2Azg5mTIBBn/lEvytbX+9C+kYM5VBmii7gvwDuN5IsHqU/NMX
 w9OGi7hlHP3zrhWoMtLgRdKR4Adh4aH4zZYTH88DJOn6ULhh1gXU0vS/1hJE7dZoj1MFtKfVqGq
 dcIKQtOWfTn/8ORNgDry3Oa4GSsSBEtAj/q3KOdlbrQN73ki7sJG6XkX1wiAY0m1cy8cpw/hX+n
 QtDHxa5Cw3K29wCw54xqTAoyCMJ17cRb97dlbedcsOkZ16oSCjTXIZoWF/mOgb3j+9nE3Ffiqw1
 xrssupsNIY4Cm78hkL+Bu45oi8dwvPCO4GBajFjTLjwXMoLVfAx46aScLNgPBATd5CDI63xZoeA
 KJ9huh0OrkgIl0LyjuVaFZJyTnzUOJtINiwrQ9Jb3lMXb3oo4HZVcH9IrsAzge+OEX6GxvrntkP
 hitK4gYviJnVFCmMiLi1/nUCbzMk4GMFs2Is6QYwkh5M9YhDc1bDXGU2kQ9Y/I8sLO+B3ifbnMP
 co8lg==
X-Received: by 2002:a05:7301:648f:b0:380:c3e7:7814 with SMTP id
 5a478bee46e88-3827ff819f7mr4936465eec.7.1795068599539; 
 Wed, 18 Nov 2026 22:09:59 -0800 (PST)
X-Received: by 2002:a05:7301:648f:b0:380:c3e7:7814 with SMTP id
 5a478bee46e88-3827ff819f7mr4936439eec.7.1795068599040; 
 Wed, 18 Nov 2026 22:09:59 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-382a72eb2f3sm15871489eec.18.2026.11.18.22.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 22:09:58 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 11:39:19 +0530
Subject: [PATCH 4/5] usb: dwc3-generic: Start the Type-C port in host mode
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-qcom-pmic-typec-v1-4-d197e6d7da5a@oss.qualcomm.com>
References: <20261119-qcom-pmic-typec-v1-0-d197e6d7da5a@oss.qualcomm.com>
In-Reply-To: <20261119-qcom-pmic-typec-v1-0-d197e6d7da5a@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Anshul Dalal <anshuld@ti.com>, Yixun Lan <dlan@kernel.org>,
 Stefan Eichenberger <stefan.eichenberger@toradex.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Dave Klotz <DaveWK225@protonmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795068570; l=1841;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Zre/Bvf1yMwn5VQT8XXlO19b/g8CvtVXZxAgnintsyA=;
 b=nIQKxH3XNAr7y69L7tHeIczGXEpaGf4weWGqNy6S1KFMBK3SJeeRzid/UvjJX+MAzrHLnS9rq
 6f6+MtQ6I2ODmHhqsCBePpruKElo7upwSyn2J31MIlmSAAhqFwSOFNU
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-GUID: OwAd8XTay4zBFM32d9hL3TqHHpQIohpB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAyNCBTYWx0ZWRfXw1TlXDX/bstf
 p5bBK8F6rBtwxzqixVHUQ9YIbFz/peyQv8Ri3XVrY8Tx+ZeI3HM05vkC/QxgsrdDCLIvBOAK9bo
 0e+Ic+Z6kIt3idNgPKsWU6EfmecOkd2uLMpo0COCmnhq0Bo1NOLpimMUKQzs5OO4huHPfMR/Pzh
 JdsjEgJNllII70HT30BYU23XKXz5AzzRY00Cdlw/YbNXlIO1uL8LRjYU8VODH5AP2WvBkuEPd+o
 YSRb0s1I5tzsZhgB7m1LAK5Ig/TswtbbGmK0SdpRw8J8xPM+hBHaPU7Gk0J5NyQTQpANx5iStur
 mDxTA3FhtPMxeNIoy6s+AFd4iJzmby1KXCFDlLW1WrE6cjLpFlTc1ozOq7SQ2NjkB54eAMzDIET
 RMoEGBnNzpN4Sr2SXwUvpV9pyWJbKenfjK20W3TX3/VQ75sZYkvfYZCzpPzw7THAoTUYro3Iex6
 222lOuiY1diOIP2xJvA==
X-Proofpoint-ORIG-GUID: OwAd8XTay4zBFM32d9hL3TqHHpQIohpB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAyNCBTYWx0ZWRfX3KkLV14d9ygK
 X95irBAbcFsFKekEmNbBl0DnY6Z3Q82csL4p9DUTldve54sJJ3yJG+hbNXbeC4sRQhg9WJGmahR
 PudaYdLe3SskC+gSEu1tVNG299edpAA=
X-Authority-Analysis: v=2.4 cv=PJ6aavqC c=1 sm=1 tr=0 ts=6afe92b8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=QkBijRcTZnU3mVsRIWMA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190024
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When the controller is linked to a Type-C connector through the OF
graph, run the port before registering the xHCI controller. For a dual
role or source port this turns VBUS on when a device is attached, so
it is found by the first bus scan.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/usb/dwc3/dwc3-generic.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
index 2406f844617..96f01d24d7a 100644
--- a/drivers/usb/dwc3/dwc3-generic.c
+++ b/drivers/usb/dwc3/dwc3-generic.c
@@ -16,6 +16,7 @@
 #include <linux/string.h>
 #include <linux/usb/gadget.h>
 #include <power/regulator.h>
+#include <usb/tcpm.h>
 #include <usb/xhci.h>
 #include "core.h"
 #include "dwc3-generic.h"
@@ -253,6 +254,25 @@ U_BOOT_DRIVER(dwc3_generic_peripheral) = {
 #endif
 
 #if CONFIG_IS_ENABLED(USB_HOST)
+/*
+ * If the controller is connected to a Type-C port, run the port until a
+ * connected device is attached, so that VBUS is on before the bus is scanned.
+ */
+static void dwc3_generic_host_start_typec(struct udevice *dev)
+{
+	struct udevice *tcpm;
+	int rc;
+
+	rc = tcpm_get_by_usb_controller(dev, &tcpm);
+	if (rc) {
+		if (rc != -ENODEV)
+			dev_warn(dev, "failed to get Type-C port: %d\n", rc);
+		return;
+	}
+
+	tcpm_poll_until_settled(tcpm);
+}
+
 static int dwc3_generic_host_probe(struct udevice *dev)
 {
 	struct xhci_hcor *hcor;
@@ -273,6 +293,8 @@ static int dwc3_generic_host_probe(struct udevice *dev)
 	if (rc && rc != -ENOSYS)
 		return rc;
 
+	dwc3_generic_host_start_typec(dev);
+
 	hccr = (struct xhci_hccr *)priv->gen_priv.base;
 	hcor = (struct xhci_hcor *)(priv->gen_priv.base +
 			HC_LENGTH(xhci_readl(&(hccr)->cr_capbase)));

-- 
2.34.1

