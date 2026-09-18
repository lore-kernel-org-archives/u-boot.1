Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A3BC982D8
	for <u-boot@archiver.kernel.org>; Fri, 18 Sep 2026 05:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE28560C00;
	Fri, 18 Sep 2026 05:22:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uoBwPwTwP-Hg; Fri, 18 Sep 2026 05:22:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CCE1C60BFB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789708955;
	b=h+nvAKHrCK2LsY3jARfNhsyEjZ9ryUNpNtl64MNd3eBXIkyjqhqocfk43oF0kRVce8sA
	 NT5da/e4ZHzd5RLGR+aIcIJK5WUlTo0/uTlJ3JCZDg6NNuLhb8arWRDaEzHjgTd3B7TnB
	 mHYiskUiP7YCpO1rGxOZ9kjIwZjr/4h7N5B72+uvJnIkzPDvPokURv377dXmdqW1fqOpw
	 LXzGedih/QTMsQv6W1kIUT7/NtWH/8QHxxN1XkP+Kdm5UR5A698AIgV8YDEkTm9kmTvHi
	 m3dyWtNiNn79Aiw7HNSPmSNwNbJhw2C7rQ89OeRjXuvSGhRVlT7jDXCz1gEQFe+6lHA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789708955;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oA35zkwKe+CFz/3LEb31ebiy0I7N/Ad5z+8yZTXdrC8=;
	b=OtGt3qOpwSpy9DPYWGwODQFTb2wpVvMzUUhlmKEIF4AYwl4dZnbffxMW+BhNlHxtfkU6
	 1lhqbH827NNkd56jYslPNm4Vgu8oRSn1N7XNPF7tr26onHNBLR4aSGh57ZDT0kVzGajsg
	 LjKbvyqkyBTsY96zVSPUnTONlMG0eFj8jLuSBOCXhBrM5mAuO7h/pYU87GOGvGr4VCh+i
	 yvB5aXnv02Q1MdOGbcoXh/pALdoPmi9E5K2mqqILAirYpxuruFjoFR2Yv8OCLbh2JMt+X
	 E0tV34NQkEf8OSVQ4XwMg72XCTlRSKL4sHPHrrNzJr8tHjnhpcs0uY+ruSYS0aoI5vQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789708955;
	bh=oA35zkwKe+CFz/3LEb31ebiy0I7N/Ad5z+8yZTXdrC8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wNYccqqo+nd1Gd1OM1O0d6oRWYHXGsx3fZX0jmdDDN1/GDy/nRJ42pMAtzJshHuKv
	 25U3ofcml4P7abuONGJUMPpZHcDGCXDAal2Fxic22x/g5Q3KzYQCqCuDn6Mt/+Oaa/
	 Yy2Y1L/1N41dCG+qGy5iMmeaxL0KQoZQyYneI+v5gnY/yVq0UzvdYQIQCjsxgGw2qa
	 hhC43QIq+EqJdnEBpmF3NsGSwW9L633P1O8D78qfhPlWe/+LNeAWrxF43uioMAdfbT
	 dS63L+j2CeC8Gc7FG2lX1ftOky6uewCyqvHrl2k6/BzaX7C6s/zVCvzmylAiUseeFZ
	 Wn0NJJ1fTlqpw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CCE1C60BFB;
	Fri, 18 Sep 2026 05:22:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3EFF3422
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:22:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 255EA809B4
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:22:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WQYVR1D8haCa for <u-boot@lists.u-boot-project.org>;
 Fri, 18 Sep 2026 05:22:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6239A80994
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789708952;
 b=PFd5F286pGC8PR1iKnR6828/3iUjy0uQG6zitWclQiv4I7vwrxmCygs0LdMjekP6Ree7
 E+Uek+p17KHTEPcuExOFa6tKXKbW3WNgK0XIE4njVlMTQ7Sp4NASH8omvDnvjUObJxSCP
 Jbof5xjsUmVQWv1SKNqjK+5pNs7teH63zmk8gzc0HYBKUmP6JcDGjtOP/fWq2E4hOBx6p
 5eoxGzAvfnhZdNPN9C8JnRC9RUAWGKBxV7r0jHWR7/uPUb1ZcJUt2EhOl7YRQ9Pg0wB6e
 P+bnUKUmj544ZqGj8jQiCd1WkdthNoOS0TvVw3V5l3RhXxLD7VNaemWXvx/B9bVfANA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789708952;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=oA35zkwKe+CFz/3LEb31ebiy0I7N/Ad5z+8yZTXdrC8=;
 b=fsokXGjyAdIQB8MvoioB+I0z8WMCtE+MdW157AGuBZ5cEZHh4qUhy/i5qvlPjJ5jCvWg
 vx6YWXyfkFMaxHNUE0LpnEp4aOoewjrX6qwe5LcyxNsnma9lzmO1Of6owDZXZMiH1GjUQ
 yuI8l7jYravP0UsE4tb4c0sEZSXVsgQvTxpfr00FG+tqBx53iIdVhA0Pc4P4BycdIUt04
 M6eskWtOWK60VU+GR7P1xQhQidrPr65Zu8mpsJGZQe9ZeVT+gIVT4CpX8+J2mXlrP4avc
 CkRDD8XxFpG3iD+wiefXrwHnAa+XIKVCFYisv0ZCIH+UW1jfTfBHDv0Kxa81EvSSa/w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=AwsdjMv8; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XEatB6V2; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=vandhiadevan.karunamoorthy@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=AwsdjMv8; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XEatB6V2
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6239A80994
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:22:31 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I2UcYT2851911
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oA35zkwKe+CFz/3LEb31ebiy0I7N/Ad5z+8yZTXdrC8=; b=AwsdjMv8DnlNdd+5
 NMrQY25rJvZB1HqkeByTjVcY3V5/iUdTpLI0AQ3pa1yN4agkEc2NVIRez/F1Qqja
 qGImw0kz7NW2fLEasYZ3+wTUJc+AwjhO3AxH15DJxRybQdkkqu5DiqlpHB1qHp9k
 x6B9UxjjeVzl9T793HW5Loi4/V/uLtmloDlCbpLHt6dINDIJRKJOuD4ca4GQTms6
 E/MRWrOgdCy8Dd3FfojusNO6+bRfC/MroVNay3hJ8jsPhiQohucj4PaFRiy1MWJO
 ecOCMWkQerJ/DRsJVAfRr+nuGLSbfNKyb6fCK6OCZeYqpb56w2XZlmFYPiEBhbuQ
 yEh4CA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grq2ksvyy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 18 Sep 2026 05:22:30 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39de4e72b33so763680a91.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 22:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789708949; x=1790313749;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oA35zkwKe+CFz/3LEb31ebiy0I7N/Ad5z+8yZTXdrC8=;
 b=XEatB6V2tX6BnajFlmzl4G5++WmjhBVtAee74jWK414tI9zfI0bDoH+qArx138K4K0
 1bVIXwaSto3e4DCedEbQ0ZnDKka9MxOJWNInQZYBTCbFMecZ9QOB5ZbXfUJae5XLaT89
 yPXjrccQ/hxxqKFT+GBAtUUnAhwzwhnBXQezyZM8jNwn3ocA58ZUepn4J8ba4r5Mg0sW
 OxJ7tB2DdsWFyeNE1K+ljXU2yqGNwvcaW4f6owglUEZ5g8aZmq37NGPk4c3dvbL6qBlU
 pi/qZ4jBGcAi7YhB6BGk+ofTnzm3LwkmVKGdpiIdRy5IKD4RUxTR1wNFuBYLRvUnNj71
 R1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789708949; x=1790313749;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oA35zkwKe+CFz/3LEb31ebiy0I7N/Ad5z+8yZTXdrC8=;
 b=KCXUzVDd7GTHn3EMfbIUeWteo3RLJtpmKcwi15Eebm12BfXy8sED0+oCGDcj7BcC1n
 15cXZDMskhDjxxIsJj8k/wZq+j6Z84FNhUFQogANiD1yEVZL/8sCmqPLNGzr+4WSW4Nu
 YiSn0TBALDd6e4byElxT+o1ckujONGoX8dFx2gHFVDqw6MmTmWItUmL+ll71T/jYDrIT
 aqNglgZZKv39N4sU4Jk3ipeLdplXbqUBXwlqVcKnlbvgNwvEzDx8p2WQr7HXNjibfnpv
 1K8APt3SdFMFlOyzcUj+4hj/Yn+s8Ah+Df3m9rsGqjGM7sBfaXYm2gqZ1Wrjt3ELkZ3P
 o6Bg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPSZoWqRWt1DK1iHrcLfNdp7UN38Rg6s1oHvQYE76LE5m4rOgQmphAxwFVUKMhdoaxysiudrc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nb5G3RMQpXAHAjzzuoDJAnrDdrrMwrtIoAfvyGd/avmnCOjHjd
 pr8DGlBlEW5FtIleoh2syDfXDLmS5h35PXzthSlxngQzJvQgm39ivI8vV60lWTTrnD1CZ6ylMxr
 +XvbIQli3q/ZwtXSpAO7OZmkks3r4Kdu35F8ErBm3QMTMgfs+StU5AZnqZ8MY74NhCqO1hME=
X-Gm-Gg: AYBFou0n8VSHSMXXTh7JbLaDuvZkTDDKGkW7ly5k2vUUIqjheXQ0BIwRKKjt+EzJXqX
 KSCB3Wtr7mYiz5UxUdSD0qk9nSGEulM+bUI+dGxQPjxoO/ERY6l7KYL/Wc6wed7OUmesddSVyIf
 Oknx5UgpjR2ADGb/Q+Pg81N6Gtbx7SQj2p+VwCC8/4mOfKX2TJTGk9pKmTZ9mBdYLG0Uqo4sysy
 b6TrJ9nW0V5e5f03HnqQbuQIynlkhPeNPn8rRK6PaepjogezDORv+UDBITahmq3YrYyn06GzVGH
 l5r6kAd6obkrPilF31XPmtlqbypX+JaZyIvWAFTl9ylkhqgI3enJ4DofdoP6zLQ35ObT4oNmmw/
 Sbpb7KyRMPDUA3S6MVrEQBFVXyGDzEDEQ4mKOLCFilHTL10ddNaUjEaTRbCWXDmZn3V4UalT7nb
 OHY6jzL81vqwuF3bElYRFFRVmoKbYmwDBnWYQDglc=
X-Received: by 2002:a17:90b:134f:b0:39d:febe:7460 with SMTP id
 98e67ed59e1d1-39e54d3651cmr3187851a91.22.1789708949584; 
 Thu, 17 Sep 2026 22:22:29 -0700 (PDT)
X-Received: by 2002:a17:90b:134f:b0:39d:febe:7460 with SMTP id
 98e67ed59e1d1-39e54d3651cmr3187820a91.22.1789708949183; 
 Thu, 17 Sep 2026 22:22:29 -0700 (PDT)
Received: from hu-vkarunam-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c286dc939sm1162060eec.6.2026.09.17.22.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 22:22:28 -0700 (PDT)
From: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 10:52:12 +0530
Subject: [PATCH 2/3] misc: qcom_geni: implement fastboot_oem_spi_nor_reinit()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-series3-oem-spi-nor-init-v1-2-319dfeed6c2c@oss.qualcomm.com>
References: <20260918-series3-oem-spi-nor-init-v1-0-319dfeed6c2c@oss.qualcomm.com>
In-Reply-To: <20260918-series3-oem-spi-nor-init-v1-0-319dfeed6c2c@oss.qualcomm.com>
To: u-boot@lists.denx.de, u-boot@lists.u-boot-project.org,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789708933; l=2162;
 i=vandhiadevan.karunamoorthy@oss.qualcomm.com; s=20260817;
 h=from:subject:message-id; bh=ECboWg8lMBJLJY2cyROrbBb84vsb2mM9plElgyueizs=;
 b=t9rmNXsDOrO3Gx2tmJzsZvE4ORJ3ccpeJ7zZjTl40vvfcXEfME7Up8pgOo9QK2PH5dM+T8S20
 9G6YOyjn1h0BzaKejzA2V1AmOD8dQSvBIT22UKDK7UmUtG8c7rpdmWr
X-Developer-Key: i=vandhiadevan.karunamoorthy@oss.qualcomm.com; a=ed25519;
 pk=2EVV7DmKqYX4wxSlXPB5QBt44JjomLlz/wTW2AL4H6I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA2OSBTYWx0ZWRfX9YsMme9VyvbG
 0B7wIz3GiQi50cYctRml+p9nzqu3PM3pqHw2+EOCxKWj9Mp8qQuXWvneDT54iowHYVT/6q6MROk
 P2P5qBiVQzuuqEFh+qzega7e8jeQnMaqTICr1rRn6lt2GV+kpy6Xa2mHWL7lSQrtQ5ouvxTzLF3
 lDf/toNda4L0pGAH2LQLgv3D/6vZ6ypIjZE/iPqrSKw+RvNuaK23Q+/DfZeH6Ne056MGom8bx4F
 d/hilWTuH/4nPO7GgWO65ZIodAL4PfqLth736i1vwdqUqxHRndxPCLg+Xc/wJ8rwVsI8VoVdOPY
 LbohQSjbTVrUbxPy94X4DwvCFM42bB0nK56Kmr4Z2vz2gT5Cn1+4NlWweBjmpv8fZC44ChdIGbk
 aeV9ELcimmraSJnTjCwykBUlLLBBjGb+Yz3i0MZ3vmcH5TNsYyrMRoqfTDa2TPcyr/VrKzPYYTh
 pyQWMgA7/2LLywuxirg==
X-Proofpoint-GUID: yfriAvZF1z4BM8CswatOOPvCGwEsipp3
X-Authority-Analysis: v=2.4 cv=bcD+w+PB c=1 sm=1 tr=0 ts=6aacca96 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=3geBSo1JPuQiXASyJ8MA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA2OSBTYWx0ZWRfX1794xPYQgsd7
 LzRCfJO/mt7/saFe9oE9c7Pu8I3nvpcGWtb/r5e+Mv5/YYKg8FmSITmh8ik7a9RlOekBlwODybm
 r3pOyNa3IvGiSXEEXpY5yOfVn8QVZ7U=
X-Proofpoint-ORIG-GUID: yfriAvZF1z4BM8CswatOOPvCGwEsipp3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180069
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

qcom_geni_fw_initialise() runs once, at EVT_LAST_STAGE_INIT, and reads
GENI SE firmware from a dedicated storage partition into memory for
its children to pick up during their own probe(). If that partition
does not exist yet at that point (e.g. first boot, before fastboot has
flashed it), it finds nothing to load and does not retry later. A
later SPI-NOR probe cannot recover from that on its own, since the
SPI driver's probe() only re-reads firmware already cached by
qcom_geni_fw_initialise(); it does not re-read storage itself.

Override the fastboot_oem_spi_nor_reinit() hook to re-run
qcom_geni_fw_initialise(), so that "fastboot oem spi-nor-init" can
pick up firmware that has been flashed since boot before probing
the SPI-NOR device.

Signed-off-by: Vandhiadevan Karunamoorthy <vandhiadevan.karunamoorthy@oss.qualcomm.com>
---
 drivers/misc/qcom_geni.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/misc/qcom_geni.c b/drivers/misc/qcom_geni.c
index a62ae6a2478..d14d74e4216 100644
--- a/drivers/misc/qcom_geni.c
+++ b/drivers/misc/qcom_geni.c
@@ -13,6 +13,7 @@
 #include <dm/device-internal.h>
 #include <dm/lists.h>
 #include <elf.h>
+#include <fastboot.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/io.h>
@@ -565,6 +566,20 @@ static int qcom_geni_fw_initialise(void)
 
 EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, qcom_geni_fw_initialise);
 
+/*
+ * qcom_geni_fw_initialise() only runs once, at EVT_LAST_STAGE_INIT. If the
+ * firmware partition does not exist yet at that point (e.g. first boot,
+ * before fastboot has flashed it), it silently finds nothing to load. A
+ * later SPI-NOR probe cannot recover from that on its own, since its
+ * probe() only re-reads firmware already cached by qcom_geni_fw_initialise();
+ * it does not re-read storage. Re-running it here lets the SPI-NOR device
+ * pick up firmware that has since been flashed.
+ */
+int fastboot_oem_spi_nor_reinit(void)
+{
+	return qcom_geni_fw_initialise();
+}
+
 static const struct udevice_id geni_ids[] = {
 	{ .compatible = "qcom,geni-se-qup" },
 	{}

-- 
2.34.1

