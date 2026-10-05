Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D14CA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43F37600C4;
	Mon,  5 Oct 2026 07:07:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XuUYGkPRl3G5; Mon,  5 Oct 2026 07:07:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 78E1A60611
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791184046;
	b=Q43gtu1emspeKr4ZKxZoETB/fVAxRxUoCxD7cHqgoV4recUxgk9R+S0a2hZDxXhyuu8/
	 FFszacqv78Hup02NiqqEXX0alJjLuAXi0twpkMisuzgejnMaB7/cbMoIAWqFRQrvvUv+V
	 n0fDM8iyzT6BIZWoRDZMtUdaDs2FU7fuoko/iVRDyBYOEEqE/3HUkDV3NeSqr6e0flR5E
	 68ohR7ri1wHC0MCU87E+NBqAqoazJpkAM0/L6Uv85+qwzXj6/7ygaHSmg+1tLgPT7N2SM
	 J3tRpn29g/w74x2ico1pPYYHyKuCwU7imtZhP74ZitzWXjMZS/MIHwkDV9e/MnEpGAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791184046;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GqjsUNG1NNgDDSPVJUMALHfaZ2onk5hnNEaUeXRvlXc=;
	b=RMSATBmeS5LqkWs3lIC7V0NB3LnSfuzdk8OiLd/d3K5QVdvEaU1CYDWDR99RlDJ769yE
	 ogJVBIjAr3TIZMzmnbyBdiX3YgcA7uugrqbmNWqKmkj8XxeXb0W0ej2gZuF6Zxg9JtH1H
	 LaQwiM4V4Ulectuqa0x+Ir237zF4LLuHrKqSvzEKtoErqMF9oLDG6ejoRmIJMnnkhOK0H
	 sugbbVA7TyKeuPl0KFFOh6VKG43z5RzK/2jv3lFyh8iO08zd8VDUw4MjoeAEuJRtkrLrB
	 fbSGLsuhYwsh0zDyvWy3t7ZXYK7paKGEI8Ac+EV4bbF2sL8+VyyTTGhlDAJaawD0AOQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791184046;
	bh=GqjsUNG1NNgDDSPVJUMALHfaZ2onk5hnNEaUeXRvlXc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BTRlvXTncvNmzBoDkW8BsQtgMieg7p/b1wlF969sEot0mGSCdrrLgTQNAxbPZfOlA
	 RuPHfRQ80ERmYgtJJwr+D26kj5Cs9ASEee/spVOFzoEAcu9CEes0jZWdMaO7VTejhm
	 iInGl6aO4Re/0vF1PK1QnMXQVmAGbQbv4JqYHV9sX4uu8J+cKNMejPcbcUsGYFuNwr
	 tYkU+XtAa9LjF5U5F5nYjb3LhIZlKevkTswituskv7ugH46/k5VVNMyqvvi4MO6ShK
	 piSkmeALMyZUdrF1GxS+n8x/D2YBZba1PlZOk4R7BFq71OFVlZw1+9x693/R2IJOnQ
	 FtitbBbzGLlQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78E1A60611;
	Mon,  5 Oct 2026 07:07:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D402832F
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:04:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B5B9240401
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:04:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h15Hayw6ONmd for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:04:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C1988406A0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791183884;
 b=YPY3b1u3jKIbLWDalcMrivJqvKPukDR2yPzdt6NZs8uFzt5NAS29+joyKpzWRRIKfTYO
 2q8HBxR/WeTmnbDK7NNHAaLKO2CHpH2coMK/TShtr7l+hAxMVcv2dbeTsreEUMfRByaWz
 GXvQXRYzvUsohWlxbx/bd/YlKmkR7KSZOwA7MG5JmjCVNGy510/KW5H8Her8+LhpQaTvU
 AGppFyYgmP71umV+r+pUDjHcQc+PrSA/zQKfii4RrrEK9PGQS0Py9/SYwWGfU1SxqdIJX
 JSKOBlTP75w72ASejop+Y2BsQiwdCfRrGkEKLpqPTkHf048QqFwJvgL+yEcpmdaeqXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791183884;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=GqjsUNG1NNgDDSPVJUMALHfaZ2onk5hnNEaUeXRvlXc=;
 b=swX8Tt0hbwLAPBhWAJlvMZC31iVY5XENMxPPduM0+9++k8atcCpxeAXcon4UecyO3zTO
 4gRtMdB5eFAgfQ6KeXNcRZ6ycyTe0ZK7/6gFpr8eCFCKuQ6uK4z8kyaa75N3p+LABXxwb
 uUIk2LGMDVhNWeLSpfpTxP6TDmTSaJjR4j7Q/dUe5AU4Ve6SVzxZVoRoOZbrizIePGybB
 MiFemjXEqz+SWIHYxPKCbnw8c4BhprvQdces5gmTXa6Czy3okmTbj4I0gGz6AJBngPT10
 BLypdZKqwiy78D1iR2z3MH6AsPQrwHegdADkfD8X4J8AZh4ADZ4elTvhG7VVY7V4JFg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=di4DWQPT; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NQhwkU99; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=di4DWQPT; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=NQhwkU99
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C1988406A0
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:04:43 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69510Sed497621
 for <u-boot@lists.u-boot-project.org>; Mon, 5 Oct 2026 07:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GqjsUNG1NNgDDSPVJUMALHfaZ2onk5hnNEaUeXRvlXc=; b=di4DWQPT9Q2fJByQ
 wU7xtvfDn3JWmHjVQkhXJ4jIUPWb+iZqT+Uj+WDltjm97VjJEXYBHID56KdKp4Ft
 mOcOAEWdTwyxJ0DB1joWdyhFa4j/IR+Rhn3CfRw/30bx4nWSsV6cgpv8DQ8AAPmK
 oo6d9LIdVKvyGAhD55BNYMQxjGd/IKBonK9eLgUWRJoUPMHpZ0cuw8JAan97HVpZ
 y2vp0m41AFDMzb8ftMvRlbW/HN1/dIWheVdIzPUjG3nN6YTQsxFtoHaZPLUQm8AR
 flpAu+osq0RKtBwkQFizdI5uXWo/HOhSXoatMuezbW8R1JwSfIRXkzVVyB+TXp1z
 KRlNPw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xgys2tr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 07:04:42 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-313d1015161so4550691eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791183882; x=1791788682;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GqjsUNG1NNgDDSPVJUMALHfaZ2onk5hnNEaUeXRvlXc=;
 b=NQhwkU99bKmGJOP8lf/28+8ts7nF85OHekqpKFCGjaT0Cedp8aOPohgMNXuuj7yPTO
 fkJnnzj1HWC0TKibnI9Gm7PsWMvuovFVB0CYlafqZA8anFpGFysGHbTVrydh3DO4tiuc
 sL55w5SxsoYrmuOFmEGgXizBRobipXlPdTKsVFEL7t9RCntmJ/X7iodWU4la5XouhH99
 b4zNCbt7Q8SjcQo6Jx+GmkcqboLOCMB7z2s1LcIhYA51V8TbPBDQrnGPgjoTyE+21Rtt
 J5C0N03SqQ8ezMVTopzFrJPy3EVm5A3k6QeXXBCMds/m0B6p1/4fQe7GFXIqUHlnk2sF
 b4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791183882; x=1791788682;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GqjsUNG1NNgDDSPVJUMALHfaZ2onk5hnNEaUeXRvlXc=;
 b=nuvspvDeR/NeLkSPPNVJETZe2MFH8sayADMEs8nJh6j1qm8NjrBqWLvoV8j6amR5jK
 3Airiq40ssc9expXsI5bjsXV5MG1XbAp4kbo5CYVTNN/jNBkpNDpQMS77e5/tF+Q9JKn
 +u+zarz8j/zC2nkty31oTTibw4bXdALq/e+jZUlDirHVJdKGIgDzU0rpqgivLqn6+z5+
 v/+E+LWyuugF78jB/eKgL7pA1lUpHo/D+EnG0vSRvDP9jtSbBddIHPgvBGiM9IymQEdC
 z6D/aTZwg5lQ7XpZQRG0IEeLRMtSbzv2/uNPvL7hhJD3XrITg6AphLk6oEhLzphLQaL2
 pnlw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhiItp5a5vCC/eAth5Di8A0c7i84tMrZO+2X3vVJ/H1dYCuR/CpcKTwBy292kHhcz974oPVSU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIs9jRQrOdX0uc/w51GBlrII0GIocmPK4YErA3CsLI1MldaCeDV
 uXwmC9mnIaaZWa3St+DR3N0nuwzEp1Qzk1nLbYT55wLEWLeGspX6XPhCSL78DKkQohh439ddYEE
 zPOrqm4NIhnvHkN/20eNPOhUb9t0+huwzUBLTgpWUR4EyBQ5c5Fysqho12H/Oj4iOM1EnGAM=
X-Gm-Gg: AYBFou3NXjDA6OVd3w2Hd3nAI6CxUPf7mylM7JWJRLo/mrvEOQMzEhd64kf5uKJUvUi
 Une+lv2Yg1wUtqdsn94ZGTx6xe87uAAtgGnfIqHjjhkq6fecGsXvJ2GxzjZLjS34a+xlfXQWY1q
 omzjaqpGLwJDhDVYgyrg7gInSKgstyflAjV6UoqwFy+UpqNnxVni7bfgiGrWe9Wf4ZeifeMsd4o
 nGiRL7dctbxX1v3IokqA96OziQpRqrleC+SK9BKgTMrqrJGEmxaS7cUoSWAx6UUh1RVNJCVFhw1
 ZE99rpxqK0vb49HVlumwm4gBjd3W+EqisO3uTHZ7vLTkOyZLBNvwNLIBYg5hN+P3joe2SJN5BNb
 b8XKwQGJGyNp665QfLoGWlgMcMkta7LFrPIxsSIAkxKm6J6Jrqh0ENSJEJ/jktQUgGwlom0iW15
 HR+ZpsXLb5rijt3F/4rshtqfWSPr5j
X-Received: by 2002:a05:693c:8952:20b0:351:207d:bff4 with SMTP id
 5a478bee46e88-351207dc13amr5779419eec.4.1791183881628; 
 Mon, 05 Oct 2026 00:04:41 -0700 (PDT)
X-Received: by 2002:a05:693c:8952:20b0:351:207d:bff4 with SMTP id
 5a478bee46e88-351207dc13amr5779391eec.4.1791183881076; 
 Mon, 05 Oct 2026 00:04:41 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35127160107sm9797561eec.11.2026.10.05.00.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:04:40 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:32:30 +0530
Subject: [PATCH RESEND v10 14/15] configs: Add qcom_ipq5210_mmc_defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-spl-v10-14-c4ca29bf27ed@oss.qualcomm.com>
References: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
In-Reply-To: <20261005-spl-v10-0-c4ca29bf27ed@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Anshul Dalal <anshuld@ti.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Andrew Davis <afd@ti.com>, Michael Srba <Michael.Srba@seznam.cz>,
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Lukasz Majewski <lukma@denx.de>, Luca Weiss <luca.weiss@fairphone.com>,
 Danila Tikhonov <danila@jiaxyga.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 David Wronek <david.wronek@mainlining.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jens Reidel <adrian@mainlining.org>, Erikas Bitovtas <xerikasxx@gmail.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: ZmdtzEgzTTpgThUxH2VhAGi3q_xEmtKQ
X-Proofpoint-ORIG-GUID: ZmdtzEgzTTpgThUxH2VhAGi3q_xEmtKQ
X-Authority-Analysis: v=2.4 cv=A6b5rKWG c=1 sm=1 tr=0 ts=6ac34c0a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=bkeBrEV1CVOi_WhrbfQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyOCBTYWx0ZWRfX68RVtwjNX7B7
 QPpjOlToUcWxGCzJN5uczqzBn/qS66FODjN3kSdlCCkRe0LVlS03xT7lF+8eqU/kpRdQcUuBp51
 lV9EBd1vcjttRhTzUrRuqSL3AbHKYffetTfjPxfZhwpQaD9ic4ZstbMFgm1lIFIU4yEtbtCKOcg
 f3nr0RwueR5TYV/D6aM0XoGBtn8gCZ4IkVmpi3ZVKICN6Veyd/XzB2ooPaSgJ83fzMKmKV9pOEs
 SjN18V58v0NGjflycslZT6yv7hBqi6Vbs0pJw1bW+miVdDQWyGKxp4QwJ2X7NHgGUcXJV7ftjqX
 gDKNRBbuWHBWLLZFfqeV6viwRQ568c+vEoEm2ChVmK22OPNLAzHBQLe5DuBXbleE45/HFPG7GyS
 +IW3zc/ogC5+nIdCqtrWkju0JF3IGYPTlpFVZ4X9Fcm+nNbvdtkC8XUAITj8l7gdRmQ93rbmzv1
 SZEAoXRh5T08g1oJ8Ig==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyOCBTYWx0ZWRfX+bZQpgVzBzzt
 B7O5Hx2akeKiQOKk1faQbAmHFDruY/A2+L8EXBv/m+trvlncD7RLBD++UPiyqwublA4UDBzLPBP
 gJj64RXngl866y4bM5rCdeEKZcTZ0Us=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050028
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

Introduce a defconfig for the Qualcomm IPQ5210 SoC based RDPs.
Presently supports eMMC.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 configs/qcom_ipq5210_mmc_defconfig | 113 +++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/configs/qcom_ipq5210_mmc_defconfig b/configs/qcom_ipq5210_mmc_defconfig
new file mode 100644
index 00000000000..56a22ce346a
--- /dev/null
+++ b/configs/qcom_ipq5210_mmc_defconfig
@@ -0,0 +1,113 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_EVENT=y
+CONFIG_TEXT_BASE=0x87980000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_OFFSET=0
+CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq5210-rdp504"
+CONFIG_SYS_LOAD_ADDR=0x90000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+# CONFIG_BOOTSTD is not set
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_PREBOOT=y
+CONFIG_SYS_PBSIZE=1024
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_EFI_PARTITION=y
+CONFIG_OF_LIVE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_CLK=y
+CONFIG_CLK_QCOM_IPQ5210=y
+CONFIG_MSM_GPIO=y
+# CONFIG_I2C is not set
+# CONFIG_INPUT is not set
+CONFIG_MISC=y
+CONFIG_QCOM_GENI=y
+CONFIG_QCOM_GENI_MINICORE=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+# CONFIG_MMC_SDHCI_ADMA_HELPERS is not set
+# CONFIG_MMC_SDHCI_ADMA is not set
+# CONFIG_MMC_SDHCI_ADMA_FORCE_32BIT is not set
+# CONFIG_MMC_SDHCI_ADMA_64BIT is not set
+CONFIG_MMC_SDHCI_MSM=y
+CONFIG_MTD=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_QCOM=y
+CONFIG_RGMII=y
+CONFIG_PHY=y
+CONFIG_PHY_QCOM_QMP_UFS=y
+CONFIG_PHY_QCOM_QUSB2=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_QCOM_IPQ5210=y
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_MSM_SERIAL=y
+CONFIG_MSM_GENI_SERIAL=y
+CONFIG_SOC_QCOM=y
+CONFIG_SPL=y
+CONFIG_SPL_FRAMEWORK=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_OF_LIBFDT=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_DM_GPIO=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_DRIVERS_MISC_SUPPORT=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_SMEM=y
+CONFIG_DM_STATS=y
+CONFIG_SPL_SYS_MALLOC_F=y
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x20000
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SYS_MALLOC_DEFAULT_TO_INIT=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80008000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x20000
+# CONFIG_SPL_SEPARATE_BSS is not set
+# CONFIG_SPL_USE_TINY_PRINTF is not set
+CONFIG_SPL_BSS_MAX_SIZE=0x4000
+CONFIG_SPL_TEXT_BASE=0x08c2e000
+CONFIG_SPL_MAX_SIZE=0x3D000
+CONFIG_SPL_MMC=y
+CONFIG_SPL_MMC_SDHCI_ADMA=y
+CONFIG_SPL_MMC_WRITE=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x00
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_SPL_STACKPROTECTOR=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_ATF=y
+CONFIG_SPL_ATF_LOAD_IMAGE_V2=y
+CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
+CONFIG_SPL_HAS_LOAD_FIT_ADDRESS=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x08cbe000
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_HAVE_INIT_STACK=y
+CONFIG_SPL_STACK=0x08c2e000
+# CONFIG_SAVE_PREV_BL_FDT_ADDR is not set
+CONFIG_SPL_EVENT=y
+CONFIG_SYS_BOARD="ipq5210"
+CONFIG_SPL_REMAKE_ELF=y
+CONFIG_SPL_REMAKE_ELF_LDSCRIPT="board/qualcomm/ipq5210/ipq5210-spl-wrap-elf.lds"
+CONFIG_QCOM_TMEL_ELF="../tmel-ipq52xx-patch.elf"
+CONFIG_QCOM_GENERATE_MBN=y
+CONFIG_SYSRESET_PSCI=y

-- 
2.34.1

