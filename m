Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE11606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zSNbFLmP;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=deWRqWPx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d2gBOJK9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E486C40652;
	Wed,  4 Nov 2026 08:15:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EQkPL4mGrZ-2; Wed,  4 Nov 2026 08:15:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 15D4140609
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793780115;
	b=OMhWBnR0DvAOHKn4jPZkHNKzMxgcRAn/3BwewWznjsI10j6ElazPYUUshZUodrzEoq/D
	 fnMianhG50AE2zB5HE9qws/XlfOh3Ezm+y5hGpoas+Mqri+CfwibPN7962nFEWIppT9Dg
	 zS3QCLfs07zeVlIy0elP+VWNZt8QdQUlbm2AW3oVFquWKFUVyiOIvwBN34KkR7EzeSaf5
	 xgKTZPVWMu78gwEYLqPw1WRmY2THhjTC/B3Jm0+sjENy4QyYcV7IVOJaOti5af/HyIpzt
	 dCg0dCbugbaoPogSaHPtzOSUGsdTYw7ljjIT884KUJsoH4mlvJv5IZw8F3njFAsabwQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793780115;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=QWARkioTL0j6e6o7PxZz/BFd4xXUCbjO4Y3rD5KNIIc=;
	b=Onsu7JIsSTWihY/Fw5hvaWSlMFYvOzWf8FsdgcOpEOOH1ecizQq4Bv1sb/2fFNWL2LR5
	 IpTtKbYy0vAu/Jz0OAnMW++jvaOW9S8yvV4sgIt3LlBHF8ELkBULoho1fsV9cEfrtD5fq
	 0dlHftvxiAf7j0GR1cSgr4z6Nbt5pXCjlR5ZtQljlEIU2/H/TREJjHGoUGxGXeqYVVPkf
	 f9fOT49PiHYQ6w4a1WK0W2qmbjlJDMXanOxTBhq4eAFw/iFDC3E2BPXIXOFkHP1YeQnpM
	 kfHJhoApoDHTTaif3sz174eplg2FpzLn4EWfeDp/48ZV+yuq6Dxj14lzZDsj4NI/Esw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=deWRqWPx;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d2gBOJK9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793780115;
	bh=QWARkioTL0j6e6o7PxZz/BFd4xXUCbjO4Y3rD5KNIIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zSNbFLmPkIT8BMg9QEnVeyH8HhwBRvPGFmFfd1yDD5CBy8xEDjzcG8GJv13YW2n2z
	 /MCnvSWdSnFTyWYGZgJCzFozP4R9UjyS3MhWTxaxzZ1JRnFlYe1ArH7+cAsU0L5hGj
	 nTcvX/mA01EoZ9ZTjEcTioZr906O+rt5QGY1+GtDue3mA0ouDqIGJUrutTv7wdyDNX
	 +hcwDjVkpMvTEUjGqjPRtPNvxbp4xBxmXbC5ifuMRBHk3kOhk8RLCX1NO2UAULImyW
	 jlPJRop4kBFHSuT2IfGQ4fGqiMklEWeC+ltWearvjCLpg9X5jbWpFjk/s7Fjo5YQjr
	 qGJqTIYUH20bQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 15D4140609;
	Wed,  4 Nov 2026 08:15:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B15C0435
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:15:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A2CC640609
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:15:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EXKjAsj4zm8s for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:15:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3CCA440535
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793780112;
 b=coqHBmKC1LncqAp1c1ZNg8DTQuElecJxnx2dGa1hKl4TCRkVoYLx2A7ANmFqC02W0BZd
 iMpxwolpYn6gdT5Ba0ItYpg5mYRFKRh0g1MjWmPzdqk5pa+PdiWSDjbqs0VuKlQHK4ftH
 3fjDsyaWA82307CokVwtavyHnQAXTtZuVvU2S3+LVbf1WYrZI3Zs61GNYKZ2qEYd/Ncr4
 KAv6jPeggGLD6SpQSWxFF5ewIWvw/rvINdv6Ck2Kaa5XY+k9gsgGqR7veCvi6epRIcEae
 T5EPnuGAAPMvlFkawoGIZi6mVnPJ0Ynq6uC5Hp9CgGRNWcd5bHaGIhDHUW8LGwKK8hQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793780112;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=QWARkioTL0j6e6o7PxZz/BFd4xXUCbjO4Y3rD5KNIIc=;
 b=pAkdbX/bhNYJ4ZMm4KsU3TG2bl0NYkbzNXnNNyXo3W0d0QSCsPw6BK+29bl6lDFxwEWl
 R+Je3SX62T7MAafsFwQLLyIkWDdGTid0aVIc7cK/O0hKUE/PFhsrBxneH5PMPWilAQZyG
 DtEH7EGrOeTBX4F7t3J5hA0KzKyD6MvS1XW45PpG0xY8JnmDXpgHrvG6KsoGT9PQBtXtn
 75znL8+9Fkafn8dTr73dHzGeWixqRE9U5ZkChyZJ0uR3Ny/YK3U5E4C+CcD2RLGMAs6s0
 uYFCqyy92P/jTa/90c0uRs4dZKP5MO6l0ZdGwwS13pJoGkpIyTZDfHg/Ehvy9MvWOvA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=deWRqWPx; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=d2gBOJK9; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=deWRqWPx; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=d2gBOJK9
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3CCA440535
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:15:10 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A46mEhd838527
 for <u-boot@lists.u-boot-project.org>; Wed, 4 Nov 2026 08:15:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=QWARkioTL0j6e6o7PxZz/BFd
 4xXUCbjO4Y3rD5KNIIc=; b=deWRqWPxUaz4V5Xz14C5s1w9iZvy1LPuBgfEiN3C
 RPnP10RJZHCmEhGD9XOLBK0wg+Yk9M9okc2VDf3d1Vtw5rF1t7eTGmEwZUJ9Iv1Y
 Rh/AfBLCmnqLtANWBAVrSkuUKFb7TRazECwfTQPxJKIQt5JEjuQ36e9Czv2sNIeE
 Gtj0nuYsBx0toHQ8rbvc5M61UGbwFS2zCRatZzX9fESyh07VcioCsOa0QGXZONju
 OpgjHVcYUnGD1JXUE5FAFEHrH7bG3MJ680NKRo1mp4P197Zj1ntZiBKGMZak33RS
 s+AVr++D7vUzBUdvBfY+kRh7dvavMK5aKXqC/+C3lmKMKA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqn8mtth4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 08:15:09 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so896109eec.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793780108; x=1794384908;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QWARkioTL0j6e6o7PxZz/BFd4xXUCbjO4Y3rD5KNIIc=;
 b=d2gBOJK9rfvFOYlFT6lhUANbD+kC45CqPwbLJvawAk6t5cuiHkaGuU3ueZo8YUpd/E
 8z1JvaNAJaqvVYbSrePZUf7959GiitJxNv7F9hXpiDLSmQa40r2mRryDv3whRgwCdLz2
 CGw4A9CndqWbwBAOyfHRz9LL/1Qs0NwOMcwEElgepmPCJwp+bXJdeQO4FzTsuhlR8kq1
 9Hk6tADC2VBDjeGr3mHTSBTRzsx3hSBvEGDhXgcQdGwDlsLn3I6k7B+vw277Xa2p4DWc
 G4hwvL3HBiAttwl3MLJxFaaShSnB+i4x+IhlsPyirufJ6tNs6F1DNa6lv9uxRiY7y0ZT
 gwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793780108; x=1794384908;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QWARkioTL0j6e6o7PxZz/BFd4xXUCbjO4Y3rD5KNIIc=;
 b=tcnLKjRcXkiI4jrBlGlG9Z7Nu8dbPXcBfPku6J0s6mtrjIZuen5fvpwqubfxRSsgSH
 9oxG6QsCoRbVo78IqCBi2vaVOnyfR2yaMYq7u3wpgXI/+fjZSpnSnPXy08dexW4vs/Jv
 jO4OjdjuiQn2JWN+jpVYIbI0SykePJ1dOJmWJdvyjNewBvT8aLnF0M192C4SMYFLk9si
 D8l+mwGlNDgZSRdgvR8/zFjLc6fuU393PjB3h+mi6Wm8dWzyqTDJhIjYMoiwFN5DBx/D
 IwpLnG++LaVx3ZAFWyFDbm3e4Fb4p8gNq6nT3xxDPw7/R1aMmr83reATAfq6ui6wygqh
 dp4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnSoHOu2alART+n47jp0IhfX1QZqEiLsudPemU7Rbb5k+cTKZNIL5/aIF5mq+Iw+ymGdttq8U=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9DeEnVOsyPZM3P8UiJMCp8HJ6lURS/qf6x5b9EklOm2RYEDSK8
 jkeVcuiNaohiS4DAQUF+5pTKHa+IKc2KkFm+SjfLB8EVA2cP3cPzTIQ6bPoNEGmgmHMkr3f43c5
 vbExY0QnyJtawiQe9tKXwTvtPpU+mk2SsDX6OpdeU4dtx2gOT5qx2jOdK+qg5sULPA+EwOEQ=
X-Gm-Gg: AYBFou0S1Ai9O4r2Bj8nbyQsW5wljUmmEwIX9nX02fSaCvl1JDB8RVJiJO14xpshedq
 rcGCWtUijyev8M40TAhpm0s//0KFNjq5Qd1tbD0rro9vD7uvdh06nC7I6seiRCPGzKPP1PEci6g
 U+WvzdukwcBdbezz9naFAyGudUXGayJrPoXFUXLMiXXPqjBgsslrtOW6nTtNwnlvYpqCGR3twu8
 KNt0V7TgYb7uRVoOBgEfq+hqUIuEP4vHOunqCH6he5PLJCmYG/wtRkhjnH2mwpPhzNPG4slP7yM
 Mgr9p/14F+bTe1L8PTKHVPNNyeLna7sHTBBeCJgawtHF3pIimSwKSSk3HAjTXiQp2cJJbB3xwJv
 qqImDk5F9Q3+pbIKCZeia79Vz/kQtDpBPfIl1OQkirX4n2ipZ13gj7J7l/1w5hicOSVvC0EzsH7
 rX05bmvle4PIdD05nQFNmZXIe+0CJm6pc2yTfQY+rZ057MJZcovnR5mUXk9kYDaSvBW3Y18/nZr
 KeQ
X-Received: by 2002:a05:7300:cb0b:b0:354:1db3:674e with SMTP id
 5a478bee46e88-36a42330b9fmr29785628eec.6.1793780108001; 
 Wed, 04 Nov 2026 00:15:08 -0800 (PST)
X-Received: by 2002:a05:7300:cb0b:b0:354:1db3:674e with SMTP id
 5a478bee46e88-36a42330b9fmr29785574eec.6.1793780107368; 
 Wed, 04 Nov 2026 00:15:07 -0800 (PST)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca39b8eb3sm6792022eec.27.2026.11.04.00.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:15:05 -0800 (PST)
Date: Wed, 4 Nov 2026 13:44:59 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH RESEND v3 2/4] configs: add qcom_sm8550_defconfig and
 debug fragment
Message-ID: <aurpg1fSzNByWwe8@hu-varada-blr.qualcomm.com>
References: <20261102-ipq5210-v3-0-aacf3930848b@oss.qualcomm.com>
 <20261102-ipq5210-v3-2-aacf3930848b@oss.qualcomm.com>
 <20261102172155.GE3309461@bill-the-cat>
 <aumczyxGU6jw/IiJ@hu-varada-blr.qualcomm.com>
 <20261103154724.GR3309461@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103154724.GR3309461@bill-the-cat>
X-Proofpoint-GUID: GoEvKxs4_sMoRM4ZKi8lsMo5G7Kfftth
X-Proofpoint-ORIG-GUID: GoEvKxs4_sMoRM4ZKi8lsMo5G7Kfftth
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzMiBTYWx0ZWRfXz6gWTn7zC42S
 Zeyn5iSt2qI2skOyVxadjeGaBJ0Hd8v0FKzBj28WDj+Nt1G56gJ2o1lrr6hAxO0mylt0OwlIV3C
 BHqTOfM8aQgb5PZZkEvnslQlggpwJFgWeM3CnHJNUOlwnsLsEL7ZTPHqLI1AOh1gxr/KBsg15A6
 wfDTTl4aZ6NMff1YwYYE+fVHWBtr4OA1hCtG8jffWQHhtJGMuGy53EDFnFz7Fercis2vJFSVVo9
 3gfC2Jb2PPxDPT8lQp3mbVxUZ2ngbI81maLyJBue4Dd16BXcyTz5U6U9v/MzNmhwvlgk2A1Rlp4
 Te6WiJ2dIxZ3PHhAm9Lz6bWCklsOClG2wbgWE6XvTvyRNKjCCSRFZt/fyiwyEBhWbtxQi7SsN89
 s7q5eUy51K2baW1WBgXDz7cSqI6+jNzr+uq1YB7hbl50hXbXA0cKpKU9KP40fEZP/LMrAWUq9jn
 wUSTO5j80dlFPxlNMQQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzMiBTYWx0ZWRfX3yuPwad1NTGp
 tQEPOqudHc8bSo3swdOI4jyJT2HaZHIw8Vz4N0BWHtqW9VxK0Cxm5/zvpnCkwiGyz41i5T3vTjc
 9z33xqkKhkD98Jl5WN9cw2Ro8Jc2Pr8=
X-Authority-Analysis: v=2.4 cv=HbWB3SE8 c=1 sm=1 tr=0 ts=6aeae98d cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=LyfWuD1JYzK8jRRvRiIA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040032
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 09:47:24AM -0600, Tom Rini wrote:
> On Tue, Nov 03, 2026 at 02:05:27PM +0530, Varadarajan Narayanan wrote:
> > On Mon, Nov 02, 2026 at 11:21:55AM -0600, Tom Rini wrote:
> > > On Mon, Nov 02, 2026 at 11:22:27AM +0530, Varadarajan Narayanan wrote:
> > >
> > > > Add a defconfig for running on sm8550 as the first stage bootloader and
> > > > associated debug config fragment.
> > > >
> > > > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> > > > ---
> > > >  configs/qcom_sm8550_defconfig | 16 ++++++++++++++++
> > > >  1 file changed, 16 insertions(+)
> > > >
> > > > diff --git a/configs/qcom_sm8550_defconfig b/configs/qcom_sm8550_defconfig
> > > > new file mode 100644
> > > > index 00000000000..40f7c857007
> > > > --- /dev/null
> > > > +++ b/configs/qcom_sm8550_defconfig
> > > > @@ -0,0 +1,16 @@
> > > > +# Configuration for building U-Boot to be flashed
> > > > +# to the uefi partition of QCM6490 dev boards with
> > > > +# the "Linux Embedded" partition layout (which have
> > > > +# a dedicated "uefi" partition for edk2/U-Boot)
> > > > +
> > > > +#include "qcom_defconfig"
> > > > +
> > > > +# Otherwise buildman thinks this isn't an ARM platform
> > > > +CONFIG_ARM=y
> > > > +
> > > > +# Address where U-Boot will be loaded
> > > > +CONFIG_TEXT_BASE=0xa7000000
> > > > +CONFIG_REMAKE_ELF=y
> > > > +
> > > > +CONFIG_DEFAULT_DEVICE_TREE="qcom/sm8550-hdk"
> > > > +CONFIG_QCOM_GENERATE_MBN=y
> > >
> > > Commit message doesn't match the contents,
> >
> > Will fix the commit message.
> >
> > > and maybe this should be done similar to some of the tegra platforms
> > > where it's just and only a fooboard.config and documentation update
> > > rather than a full defconfig.
> >
> > Added a full defconfig since the script needs CONFIG_TEXT_BASE of every SoC
> > in the MbnData table.
>
> Sorry, which script?

tools/qcom/mkmbn/mkmbn.py.

Thanks
Varada
