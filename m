Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196FACA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:06:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CD72440680;
	Mon,  5 Oct 2026 07:06:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id W79TazT8O6UV; Mon,  5 Oct 2026 07:06:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 73D8040401
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791183984;
	b=MX5KIT0kex3tMb6BwZm3HF3FXFgqAKmUPctFe0/0XwY7vgrFTSR9i5nUY3Z9ft4Knc9o
	 fbhYB6FZAY90OguEVxTJdnkkx6KXvE2E8b9zEI60PTn1lAK4kkGPZETLmmdd0r1n2Dv01
	 0JBxZbfUpXV797cSnv9iRsLobJcIQ5SjNXnhDhWBdWjDERNZch1UeD9VhN96cWeKpQaGg
	 BNFsAYQkrtDK1Mb7ov9wy0BvYmwLagrP/ENGTq0tcnjk44j34GA8rBLrInRFTwM2v+TqA
	 qnR9yoa/BmK8UCXHJzk7bKq8IRCquSQ5y+WWb0anSnn460ZdsGP9J+5PAQEbc9XBtEQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791183984;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=k6tSImDFKg7pyF2IFQ51VlU2vB/lcggC3WZiKa8WNXM=;
	b=KJN9w1RAslyG6fa+d0qIzLCyf06jBFnTloBZbWFaBISzkhfs+pB9QxJz4eoLMMsbRZPh
	 fxVv0foIKFbzRIZu/lT7SpKl5NBnDUa2OWr/0uysJq0VqcLgo35u86NsXWUOana06ewG2
	 OP04hnhGxjrda6EQLOVn5FqHyCOOTiE9xArXhCw0W1Vxyn0Y+ljBXWwEBA3+LBkioq9nV
	 bTq4w51VfFAuHMfC5Uzk0DIjTpTI7Ng7Sc0evM9Ch+bUZY8C2fd0CZZpeFwyQnhD9TQ9p
	 tdp/yt2SJ+dDSYo2Bg/huwLXLfMz+c2fbIgm7PL11yJ3WF/OoxVrCp4ogGFgeOyK6OQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I70jK4DG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fiQUKvwH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791183984;
	bh=k6tSImDFKg7pyF2IFQ51VlU2vB/lcggC3WZiKa8WNXM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sW3QeOt2X8hiRdRToZZS6WI7+B+HXzaqrQuuJco2RLTSp+RTsBMsJsDP6Kh/qHiDJ
	 2py2i++DohfATwQq5nNH0DOzoQgvO85mRZWw5Yu0Je5iuheG9+mCoynVHN4wXsLOzw
	 F3IBfDHzX6+pNHDRUGNABzzF/TvT7nWA21pRuOVS874aJqwbWgx7BCFhUDMxzWngH6
	 2iTrHCYb9iKEgSfFC0Z6mfYgAR6+J3zPIsA6Ijg27vKyhO0VYpgOfkZoh3AkjX5aCF
	 SJu7PbB9oMPKKdkruovGfOJUApcux9oLetHmWwaCEsYoEgBn7j6JOGu+X6dbq+wC1j
	 fBqdEWlZi7nug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73D8040401;
	Mon,  5 Oct 2026 07:06:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D5D551A6
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:04:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D34C54064C
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:04:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mD9bGZlKivb5 for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:04:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B5E7C4040F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791183848;
 b=hC1QyxHw9EITsYmKeACNwSBkVIg1PupE7ZcBGbBEboI5O1gPIpZYmtXtnIaqrqZ1rQAF
 sdHUDdNCudD+dXXOhkjV3Oz8PPOIcXO9ERSkbDbdDbjhArNRu8tg1WC6//DLqLEtL2w+V
 99vOBXXbVyv76EaELqO6BwWEDCsbSQIr1szsXCBjd9QhNiwXGi84+OrWfPsV3apyps1/M
 zy/WL6qy6dOQ8UWK06/c7A4eNUyCccW+/LDWUWdI+jHulYGZxhi4Io7WcGd5f9xmL/R5D
 q4cVTsYHEX0f+YC4obPN5SYitYZH+Xw66fnb87AXQv0akbfJUjRmEav6LHCoI6CgYHw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791183848;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=k6tSImDFKg7pyF2IFQ51VlU2vB/lcggC3WZiKa8WNXM=;
 b=DcMK3Vu/U/tTP0HMvb6baVsC7QRNgisnPwfHPf83i0nR+OrWCMvS4jbt3ANhAyFKLbjy
 JmOGKkGSp8K2/APyoU/oFxnEAY++EuanE+j/j+rnyeu5PoMlt+L03pmWL0eu7SqWCQYlS
 Ck0+xwMRdzKoiSawnI21+9rVO8P0ZPlBycYoH/ayKvNw+TtaA76lc+ygmQJI+TZqPjF4y
 2Qv87rx3EnV50FGVcFeEqDlignHc93AoTUeuweu/oVQrT6wqyhqSm+iWL06CF7IOiL1lG
 i+yuft93eqHqlFqbAUDjD88oqyRnL7X3tVXEid/TTEq0mrEigpcep7cBLsVQneS1kFg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=I70jK4DG; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fiQUKvwH; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=I70jK4DG; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fiQUKvwH
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B5E7C4040F
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:04:07 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69510IJs787605
 for <u-boot@lists.u-boot-project.org>; Mon, 5 Oct 2026 07:04:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k6tSImDFKg7pyF2IFQ51VlU2vB/lcggC3WZiKa8WNXM=; b=I70jK4DGdN6xfXGQ
 Uvkcd9/YO3inI2FBug3vRm7nagKl2kgk5mqHYYiuq6WSARTsH6y61LwWyeugPMVW
 TVLvQ7rrIbZp1suEDXFBqOLjEp7jqq67Nk/qC8txEC92y0QsAsNM2gfctOV+Q+S7
 gC7qd8OemHJS2cH6UJZJX9kkCSZgRnvXGLKVjTDXHj1tNc0//8sVT5JlGGCNxqka
 kXSjzXv4g/5Sv//a55cITiy9yuVJ65UTwgiKFy20+9NyZfBbap/HEzdWnWi3VSlZ
 wm6lnYcU9ZueTe6pbw5SdHmkHl1RBtMv7X2HBts6HXtMfRctOg9C2n8Oa4ThKCzv
 +2YPjQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2spa4utm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 07:04:05 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34d84114044so6913816eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791183845; x=1791788645;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k6tSImDFKg7pyF2IFQ51VlU2vB/lcggC3WZiKa8WNXM=;
 b=fiQUKvwHEKOKuaNDgoy7yutkCVUkea87wfTs+WUehTsbxaYk7ULKhS+gqysaAFy2/3
 eV7pboiKgloRElM3uMzUMZkK1vjOAsxkrSU7ywzqntv0urMQxiiesv+OazbC8nK5wZHe
 wD5LrLXmlhB59PMR+MpZPOrhhu3CZngNBjWib4zIWmRL9uNXw0DMWl36u5wU5eqQTKBH
 jbGRM32QgxGUB0NNMpkQaKCnLvFL7G+6owNf/ok5rE7Z3ZhbJ9LQ52aUyOW0uzsqilQO
 6itWg8tL8DrAa3hKSfU0Mee71kgcPXnWZEB/GatFR2T6tY2QUuvlbYSFBaJgu4rwP47y
 jfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791183845; x=1791788645;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k6tSImDFKg7pyF2IFQ51VlU2vB/lcggC3WZiKa8WNXM=;
 b=RVjlA+9k2tXOCi8yxTcIZGbBIVKN++4jnyVQAnJMk3ivlzO4EdxLGV35aPjvDsbX2T
 x6h7rDA1gaUWF/IqqVPwJCrjRBTNX9NsB9dy73DFsJsvgi2vB6dJChriSKHtH9UpvCJu
 AkGjOCTsaSIOurHl4QhlYWbqA75stbKDCEBB+2pYcdTwR4l+YOxxG7QU24C7+rWP/edM
 r8qJGRLXRvpYZDpK8zvnKSyoQrvqRzVq4pkwjU34v9qcqHYUwZFc9RpphQ9QGzZtjGl9
 eYa2t1ccvt2JWPPnwA9390/qyQurVnJGRhae+e7XW3eZEeYkMtlIIl0PdG7NqGkhOvOc
 PBTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZsI6ciLBS4gbUbro+N8UWEU+cpFx0pHWncQShQEfAP+oGKeNQDzD/JTZQE9NG0EZ2HHbxPGo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lQjH0FgNm3Ja/Bv/tY4mH35v6SJ8CZmghY2x7ye59hiffGAGGK
 8knDfmD9QvdUcHAIISR/BQCHUvpIHa6MTwsXhOwlPOxm+R+cz9/9030HUIHaLBynwNVt6782IEc
 O068LTJTY/5DIicpeVatvN48OI8KRkdeCBRs9Dno2JtfMTD01/YsDG7QYsQfuZmgTJ110pIg=
X-Gm-Gg: AYBFou2thH6VxUC5s0oR0zSKJpHSD07FvowEU7naNv7nsfRsYbF+tk2W92vDrjtVZBG
 A7I/225y3b18ovdtorpmakISVpDH2cT9oi+PfajJ7rnmLGTgTvtXinLlwED/yJVD0JqExb+oZAC
 Q1j9QHaA0XuwheTqqeV5pvW1vzoIMqZahoURlxMVtIr9KBGckKbOKZ3JFIf9WOasYDB20NAQTMD
 hp2Uc2Q+1qFRQaUPfj/+JXSYoxhEZEkF2ZwJfY0rhBZtF44vyj6bjFZhzhsNJK4gR62AIRSM2tP
 O5YqE1QktKagowNwK9pYmuTlcePdrgIQqY1GFTto+nBucD3h59gHud5391XgxBd22OLOD213ENM
 4FeFoYKXzNGdxoV/Mf6X6DaEyHkaH3Yw2YSjDT4CfCNXG23Pg2Jmor2vtegFdJ4wWdupXNphySN
 Jm1z8BK+vVW6pmi05NMeZofSqdd6T0
X-Received: by 2002:a05:693c:66d2:10b0:34e:2b79:3ca0 with SMTP id
 5a478bee46e88-3511162f9c9mr9162085eec.13.1791183845072; 
 Mon, 05 Oct 2026 00:04:05 -0700 (PDT)
X-Received: by 2002:a05:693c:66d2:10b0:34e:2b79:3ca0 with SMTP id
 5a478bee46e88-3511162f9c9mr9162033eec.13.1791183844518; 
 Mon, 05 Oct 2026 00:04:04 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35127160107sm9797561eec.11.2026.10.05.00.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:04:04 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:32:26 +0530
Subject: [PATCH RESEND v10 10/15] dts: ipq5210-rdp504-u-boot: add override dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-spl-v10-10-c4ca29bf27ed@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX6O72JgYxC3IR
 HYBCtxTVSA2EWdnEsBaMVSBpH2T0rZ8qJ7BjJ2YcX2OHiD/EpfcG2nRh9t3VjhIBZWiWWC20Kiz
 WgRxc3NNZ0LIqbNzCGFC49mV24s0O9mYj2dZ7Ni/uSaoWzxbJnbO/BM3oBRiMm9uGu7pD6h2fO7
 qYwiKG1Og5qz0qNWZVusfc8u/52/2RWJ25vKkwuT843BOWCz0Yenex8M7Kxy9YL8Me/oVehmtB8
 yRUT6jpgBJEFpAVUVf/ApEysq83HZd1LcwXtA0tXDwK4ukLhgQ8gMJ3W4GFojXHLsC3b6lkq/rJ
 FuBGSdF13tfPI06Dzd7GzQjzXDEEC+1MWvAQpHw29xImz4GY6X6/xNo6a4v2PnXeUWsSvRJ2FW3
 SDIoV6As32kvCTXIS1dzbCpk+ZfreB4MYVEIkF+eVVvjMbTj/en5loN6fjIjdC7n5pp1fCYJlP7
 LrwWjSO+i3goyUV+s+Q==
X-Authority-Analysis: v=2.4 cv=b7MncdGx c=1 sm=1 tr=0 ts=6ac34be5 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=cm27Pg_UAAAA:8 a=EUspDBNiAAAA:8 a=t4X9H54Ucq2VsXYocbkA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: 77JQLqCWocI5yH7hiUvU1o-f7cXwZ94f
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNyBTYWx0ZWRfX25BPdDKgo9wA
 ORGKoWTEAZ0AGYzRzmsGQCXnWGfVyB2ZUIMM4n4xF3FRQSsBLYxmK3p/sk/CW3JfYoL2f04RL5b
 ImVZrl9KZznlmyhsnDFc/te7fRISYi4=
X-Proofpoint-GUID: 77JQLqCWocI5yH7hiUvU1o-f7cXwZ94f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050027
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

* Add initial support for the IPQ5210 MMC based RDP platforms.
* Define memory layout statically.
* Mark the nodes that would be needed for SPL.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 arch/arm/dts/ipq5210-rdp504-u-boot.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi b/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
new file mode 100644
index 00000000000..5582de9bebb
--- /dev/null
+++ b/arch/arm/dts/ipq5210-rdp504-u-boot.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IPQ5210 RDP504 board device tree source
+ *
+ * Copyright (c) 2026 The Linux Foundation. All rights reserved.
+ */
+
+/ {
+	reserved-memory {
+		/delete-node/ bootloader@87800000;
+	};
+};

-- 
2.34.1

