Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A3A4C982C1
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 07:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 52C3580EFA;
	Thu, 17 Sep 2026 07:47:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jJMAr8sRCs94; Thu, 17 Sep 2026 07:47:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0326C80EDD
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789631269;
	b=CyPCL+wvPDRa029/RKdp/s4lpoxhHMmcS27h3qpJ1bsz00Fiq87iWDZ90245ZvMrPjVP
	 vIiRy1wnJZf67vl6TbFZD7azPPlkwNjMyHeHSHisj1vtSIt5k22g0C4xtnxFjCcYgp5w6
	 YGKAgd4LVAJZ0EJT1uflzT0SznFbiZjv1zFQVHoZTupuqxZmxC5a9TorQm/f6aegCa35M
	 sbVGmtXekfN/sV+V4zm4d9/rG8WWRDaGWzhGxYhjs0djTKs++yjPKOfpwoEV2Yjg9LB9/
	 EYyLnuiaLm3XJQbkapvs9oAXLmcYiZ7ZNgWJjrFuNxOIS7VorPPIRYKrzT4q/zMVfHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789631269;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=1xdnFGo6mdaM9tOhJk5PkOVt+bWAEsSgFA5K7bZOUkc=;
	b=kcZTqALRxne5zKZdcbSrw/cTRxaOs/71KRJmST+6DBXqsOitpd2Ffz4UF+8xK4q0QWdq
	 nCTRYCfbag3JOauOZLVr1gpdEMsD64Zk0Hwc0s82lOog0msVeL3C2DeGth1xlahJE37X9
	 3tYq/ArDntRCqrjiO6Z7IQGTLL7K18Ev9FUgqBQhcQn79Qr7fd74mag2W1D0GWJQX1ctS
	 jJLl+p3YbDpfRbEI0b/0LWSfZBjjfEMv+lNcPW5o7eRxsrdUqN5qFdhhIcepXqPutCqGw
	 6I45+0TQxJCu/ZhStPSVWcnK1nOEXD20NN9LpMP1D73JGBWlc2DaXkxsgnRtCcjHn+g==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789631269;
	bh=1xdnFGo6mdaM9tOhJk5PkOVt+bWAEsSgFA5K7bZOUkc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GUcXSRUUaR84/0L6ZvWrwbQW8+xpf6HfBDNSiWmdgMMs6Qb+2brMfj7NqQgljQnWs
	 tKRpbgQ0lKSuf2ZJ0JHevCsaMgPu5k/JWI9mhOiWI5Jx77s/TgVEoZPWQxiQNRI1HJ
	 8ICINXHIN/N9UevMuwzD+odYuR8RnSrV/w9P1B0PJv+iwiZyQ0sa6vrtmqt7QCQCwE
	 QumF8D1hL+X15EZy6KmvFjKqAmtedyIv2bQ34G8+DwZcPiS/Xq/aZL+G/IC8Sm0F5I
	 SmFfBEoJgrOwnQtyB+j9hLbgrTr/bv+ByVBL5N497TRrL0fBgkbBhSQQS1JTWZpVNr
	 dv1Rqhe/BOGxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0326C80EDD;
	Thu, 17 Sep 2026 07:47:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0275829B
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E1856406A0
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xq80n_U6Z1Tn for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 07:47:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E7ACD404E9
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789631267;
 b=OuTbV0fxXtg36UOhdYHQhsQsctwZ/sUPQnPzYhaNo8addQTosf8Zww1lKl35N/RqjOFm
 9HxjghzsWzAHAXnZc7wxjmvDn2KbvOtReU9++Zh+rt+APi0WNXLhYb0SAWhwWUkDuVd1x
 xrlxj1/VWWfwClLucMca1WvHc4+DGhSieyNxKiNuj7Dy2xAxPv952GfwkfRTPuAYlk3Px
 sScAhV2zmdpqCVnqnErNOIxsgZqRihZcdJ2q2xCORtrSlfEQ+0oUYjfofe7Gr2EbyIbFz
 EfOa6BI5SUwsaqfiuuonRk5KFEJpdZ8kOcsK6HZS9hLYRQwDG8LNfzI3ImmWAytnc8A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789631267;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=1xdnFGo6mdaM9tOhJk5PkOVt+bWAEsSgFA5K7bZOUkc=;
 b=sDKbLT4DsEtU5M4zoRGHwq6AbAE7XvMRH5sa89EYXU3N2G76OuyF+6nQyUK1+JX9P6gs
 sO+sQs4x5wDtoGsj0cyPikI79epxmouEjMy2U+pHeXvM4Ozv1WQj/70+QKcPq6ifZjAKx
 WKgFDA4ajeAXNzF5eUSABBh9P8jhk/7xUzBKM8v+FonjycefBJUZTR/QoRuSFHDF7DYzl
 vP4R00ozaaMplXr0lUskBhG1PqMR4vuzihzCAk8Q8yrzEZG8cbfkR8mYaGOm5iJrdxFH4
 SSjtv/hfttMfxKtXOBTBwmZh8Pv+IJk8xnV7W3Vr/6RfO7+yK4jnQFQy1XvEVQvXeDQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=oss.qualcomm.com; 
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=U7GYBBct; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KRB5ztuD; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=varadarajan.narayanan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=U7GYBBct; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=KRB5ztuD
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E7ACD404E9
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:46 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68H60u3K901908
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1xdnFGo6mdaM9tOhJk5PkOVt+bWAEsSgFA5K7bZOUkc=; b=U7GYBBctJq4G5aIk
 kccYfacKFu+sWXTEDRIMXxLUXaevmCEUbowPkxZaxjNLfJOM+aGWjQhRijb3fM2w
 LInRZXMYPKop2lp1mfPXH43EO75kvLW+023Lsnyid42bZVrx7i+9pPpV5XHU/XGS
 yPgNGSNsxc9Jp+/DiFKJLtNb+NBaekdjkZYz0aCG7qljdMshgMYeEfb1upYso9E9
 /Usr7sIiC/jErDKu4XFyjGp5AH6zPYU8VdrHBzCzUkNI4mCv6J1qF4e2XeHKrB1+
 EOTKw7lNFJMfWxEkNhlE08YZL8YAawndRiQnDaCb0lfY6E+OJO9YJ7iXJqfsL+58
 YFN5dg==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy2d37w8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 07:47:46 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-6c1a8f2c565so746784eaf.2
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 00:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789631265; x=1790236065;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1xdnFGo6mdaM9tOhJk5PkOVt+bWAEsSgFA5K7bZOUkc=;
 b=KRB5ztuDK5qBT5dSpC3sdoKRWo7UGs3LzgWuvUAy2yO78LrWI4AlATFflShHEAnhxm
 //GPPHOmtqQVxp8k8Frudgb3rzx17lGhtu9luPvhKP0QS/WJ2XGqprx5qYdvGO4mIgxf
 uvHwE79FLAUPWMgnDFF2O3391i0bQ1tBbP3GwqMYlR8JjkWQ8pLpcqccHC0J00q5C5Zr
 48EnevXRcUf0KAqvcs+Yzyrh5TuKPX5KKtupqlbwj1ug3N5uqawTEaTGoGiThy76PcwV
 r/Vw1gVeHEghwhY16tEF/ClFcJJeW/yi8ApnmGQnhdx4yP4SYoOG2gA7plYBCoNnxNDO
 7cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789631265; x=1790236065;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1xdnFGo6mdaM9tOhJk5PkOVt+bWAEsSgFA5K7bZOUkc=;
 b=gQjxvAMPlrnRrzjKsRN2PhaWJqbkPs8GrDh6Noy5hnwbSqws/FvlEGPl8eglbpCZig
 srqehknEtA/G8dh6qQx3NbSUVMZMmI19NBFaQ1J7yo5ZEpg73DPT+LjlQnOZ7PHlyF++
 RQFjZvE4KW/PAtwq0Ub8cZ4gl60mF3Ov74P3rv4+WKMrKgDIRfVRvnEC/VXc36kfxve9
 5Njc05+LN7P/AoLvwQ9eelMAhFenNR1UwJ35shCQSgrAI9NpB3AnGXVl/VHkCoeBNWwD
 hs0cjDBx183k7tREo1jZEEwJLmhsaM1KGiDGffK6YrbfQLmUAg4MsB0OCaxdW3X+42ke
 P4wA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwL8DFLVmPCSkTxdnkz24J42sU3bYm9tpC9R3WlD6qhtkdApDZoJY69HRP5n0cMUK+iJxoqV/k=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lyUVqTrUsR/4q47tIypGDnmdXS0BRvBpxRsVKYwNHreiXYDrHq
 fBFXcaVlgW5X+019qOR8ljHm0wOU1/kh/iYH+wHkT8T6JjzX0TDGikAmsTbhXL6QJVV0jlgBt7P
 TN+VbLxdyNhNkPEYcc+yXpmNuqlZmFgmTe6Zf9bBYQ7wheTIDMH3j0J9tZVVFYY4u7kadjUA=
X-Gm-Gg: AYBFou1usbR9oGOFi/DasksSmKLFw0h0HKt4iTL4Pt1fSIWv9EEj/2yQQSQjGJfYTNu
 cPO9H6MocG1fCK7tGn5wboI2zytp1L/25zQuUDvmIXar5T9xdbQlD0EW1jHv+GzZVeasnoJUpmm
 PrSmEgrWFjXEUtqae1vgCTkXgXiiwT4Z0df9TUjVniXwR+tAZtkZGQdNDwBKFd3tOIn1N1Hl1wv
 yTnREZJk4ezn4uAymR1qIBvwJPyn+7J3NAq9IFFtukdO9h1hAPK6XvdB1s0p0xLHDVAmT8Ii9ZU
 IOqFEaHMXZP9nac01mWtvdlQBDn5od9jf1ZQFsITLL+vATXL5in9VRCvbpSGi+TMBZ0TUOYTR2I
 p+aeIDtxiPv+gK2clx4Rm454Ha1Q2iHRDOoqK6Y7z9OtouvBjMT0juDXbITb7vPkR9FigCUsR2y
 VLmTMbRKIjBGeSCkUmHYMpJgvYlyrhVw==
X-Received: by 2002:a05:6820:c2c8:20b0:6c8:dccc:eb0d with SMTP id
 006d021491bc7-6c8dcdc3041mr2343502eaf.53.1789631265300; 
 Thu, 17 Sep 2026 00:47:45 -0700 (PDT)
X-Received: by 2002:a05:6820:c2c8:20b0:6c8:dccc:eb0d with SMTP id
 006d021491bc7-6c8dcdc3041mr2343480eaf.53.1789631264847; 
 Thu, 17 Sep 2026 00:47:44 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1e38sm14379848eec.16.2026.09.17.00.47.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:47:44 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 13:15:41 +0530
Subject: [PATCH v10 12/15] pinctrl: qcom: Add ipq5210 pinctrl driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spl-v10-12-3e83dcd239f0@oss.qualcomm.com>
References: <20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com>
In-Reply-To: <20260917-spl-v10-0-3e83dcd239f0@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: sZV_YprKbaRESBdQkXDeyLyJurkAvcZe
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX5OogXJp1BeS4
 SwPDyRFonpn2egTwD4Sru4f/rXnbIJpYtpkZM/swPN6f8UFCDWQYhZQ0vePEp0H2g160LlO4CGM
 yOSMjf41aM2enZbxnTpH6usiRvuKhFY=
X-Authority-Analysis: v=2.4 cv=HbeB3SE8 c=1 sm=1 tr=0 ts=6aab9b22 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=NzvCGKM8m0lGn9t9IsgA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-GUID: sZV_YprKbaRESBdQkXDeyLyJurkAvcZe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDEwNCBTYWx0ZWRfX385F+CQIHkKU
 vWbT1qlj36stTl2w1cPG2Qu/W8YJGaGd3KOyTqwplwOueDayBfNCBWepIUHo+0dwTQUE4r+YzA8
 w8/QWauRW+eHWlvmr3uzyRhQMOO4N0urFODo/tnyWpw8Ckb+hVJNv8LyMUzj6XcyWhIaOfhmgQS
 PFuVcu3wKWF8yG95/eI3oZgadhbTA4EL1oQQ84gluWCIdEGyFF/0y+1zbZ49qsNomCt+3bgrIQT
 LGVq/E28o4RAV78bSYA8hOcR9pu4S6pe0jnqJp41Tz5oYy+BjkkPQk751BpHoyCbiwSdoN1+hy/
 uiCXFsJE7W3peXo6jrlsl30zZ+zuEY11M/sfrK4BHaNwlQpGDhCoCrdQwo5nI2CErR+X5hNJmvZ
 L6Rc9ueAzE00MTKs3ShX9UQsyDa94QEUXV/wnzgdNKgDbW/Y6vRKw79stAzvXscqu58Y30l0MK6
 1NIed8steVCm4sGS8cA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170104
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

Add pinctrl driver for the TLMM block found in the ipq5210 SoC.

Reviewed-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/Kconfig           |   8 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq5210.c | 349 +++++++++++++++++++++++++++++++++
 3 files changed, 358 insertions(+)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 7dd3782c14b..dbb51cd7fe6 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -38,6 +38,14 @@ config PINCTRL_QCOM_IPQ4019
 	  Say Y here to enable support for pinctrl on the IPQ4019 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_IPQ5210
+	bool "Qualcomm IPQ5210 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the IPQ5210 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_IPQ5424
 	bool "Qualcomm IPQ5424 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index a7a9ad03569..9fe32fb8fec 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_PINCTRL_QCOM) += pinctrl-qcom.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8016) += pinctrl-apq8016.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
+obj-$(CONFIG_PINCTRL_QCOM_IPQ5210) += pinctrl-ipq5210.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ5424) += pinctrl-ipq5424.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ9574) += pinctrl-ipq9574.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
diff --git a/drivers/pinctrl/qcom/pinctrl-ipq5210.c b/drivers/pinctrl/qcom/pinctrl-ipq5210.c
new file mode 100644
index 00000000000..a9b435ad543
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-ipq5210.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Qualcomm IPQ5210 pinctrl
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+enum ipq5210_functions {
+	msm_mux_atest_char_start,
+	msm_mux_atest_char_status0,
+	msm_mux_atest_char_status1,
+	msm_mux_atest_char_status2,
+	msm_mux_atest_char_status3,
+	msm_mux_atest_tic_en,
+	msm_mux_audio_pri,
+	msm_mux_audio_pri_mclk_out0,
+	msm_mux_audio_pri_mclk_in0,
+	msm_mux_audio_pri_mclk_out1,
+	msm_mux_audio_pri_mclk_in1,
+	msm_mux_audio_pri_mclk_out2,
+	msm_mux_audio_pri_mclk_in2,
+	msm_mux_audio_pri_mclk_out3,
+	msm_mux_audio_pri_mclk_in3,
+	msm_mux_audio_sec,
+	msm_mux_audio_sec_mclk_out0,
+	msm_mux_audio_sec_mclk_in0,
+	msm_mux_audio_sec_mclk_out1,
+	msm_mux_audio_sec_mclk_in1,
+	msm_mux_audio_sec_mclk_out2,
+	msm_mux_audio_sec_mclk_in2,
+	msm_mux_audio_sec_mclk_out3,
+	msm_mux_audio_sec_mclk_in3,
+	msm_mux_core_voltage_0,
+	msm_mux_cri_trng0,
+	msm_mux_cri_trng1,
+	msm_mux_cri_trng2,
+	msm_mux_cri_trng3,
+	msm_mux_dbg_out_clk,
+	msm_mux_dg_out,
+	msm_mux_gcc_plltest_bypassnl,
+	msm_mux_gcc_plltest_resetn,
+	msm_mux_gcc_tlmm,
+	msm_mux_gpio,
+	msm_mux_led0,
+	msm_mux_led1,
+	msm_mux_led2,
+	msm_mux_mdc_mst,
+	msm_mux_mdc_slv0,
+	msm_mux_mdc_slv1,
+	msm_mux_mdc_slv2,
+	msm_mux_mdio_mst,
+	msm_mux_mdio_slv0,
+	msm_mux_mdio_slv1,
+	msm_mux_mdio_slv2,
+	msm_mux_mux_tod_out,
+	msm_mux_pcie0_clk_req_n,
+	msm_mux_pcie0_wake,
+	msm_mux_pcie1_clk_req_n,
+	msm_mux_pcie1_wake,
+	msm_mux_pll_test,
+	msm_mux_pon_active_led,
+	msm_mux_pon_mux_sel,
+	msm_mux_pon_rx,
+	msm_mux_pon_rx_los,
+	msm_mux_pon_tx,
+	msm_mux_pon_tx_burst,
+	msm_mux_pon_tx_dis,
+	msm_mux_pon_tx_fault,
+	msm_mux_pon_tx_sd,
+	msm_mux_gpn_rx_los,
+	msm_mux_gpn_tx_burst,
+	msm_mux_gpn_tx_dis,
+	msm_mux_gpn_tx_fault,
+	msm_mux_gpn_tx_sd,
+	msm_mux_pps,
+	msm_mux_pwm0,
+	msm_mux_pwm1,
+	msm_mux_pwm2,
+	msm_mux_pwm3,
+	msm_mux_qdss_cti_trig_in_a0,
+	msm_mux_qdss_cti_trig_in_a1,
+	msm_mux_qdss_cti_trig_in_b0,
+	msm_mux_qdss_cti_trig_in_b1,
+	msm_mux_qdss_cti_trig_out_a0,
+	msm_mux_qdss_cti_trig_out_a1,
+	msm_mux_qdss_cti_trig_out_b0,
+	msm_mux_qdss_cti_trig_out_b1,
+	msm_mux_qdss_traceclk_a,
+	msm_mux_qdss_tracectl_a,
+	msm_mux_qdss_tracedata_a,
+	msm_mux_qrng_rosc0,
+	msm_mux_qrng_rosc1,
+	msm_mux_qrng_rosc2,
+	msm_mux_qspi_data,
+	msm_mux_qspi_clk,
+	msm_mux_qspi_cs_n,
+	msm_mux_qup_se0,
+	msm_mux_qup_se1,
+	msm_mux_qup_se2,
+	msm_mux_qup_se3,
+	msm_mux_qup_se4,
+	msm_mux_qup_se5,
+	msm_mux_qup_se5_l1,
+	msm_mux_resout,
+	msm_mux_rx_los0,
+	msm_mux_rx_los1,
+	msm_mux_rx_los2,
+	msm_mux_sdc_clk,
+	msm_mux_sdc_cmd,
+	msm_mux_sdc_data,
+	msm_mux_tsens_max,
+	msm_mux__,
+};
+
+#define MSM_PIN_FUNCTION(fname)				\
+	[msm_mux_##fname] = {#fname, msm_mux_##fname}
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	MSM_PIN_FUNCTION(atest_char_start),
+	MSM_PIN_FUNCTION(atest_char_status0),
+	MSM_PIN_FUNCTION(atest_char_status1),
+	MSM_PIN_FUNCTION(atest_char_status2),
+	MSM_PIN_FUNCTION(atest_char_status3),
+	MSM_PIN_FUNCTION(atest_tic_en),
+	MSM_PIN_FUNCTION(audio_pri),
+	MSM_PIN_FUNCTION(audio_pri_mclk_out0),
+	MSM_PIN_FUNCTION(audio_pri_mclk_in0),
+	MSM_PIN_FUNCTION(audio_pri_mclk_out1),
+	MSM_PIN_FUNCTION(audio_pri_mclk_in1),
+	MSM_PIN_FUNCTION(audio_pri_mclk_out2),
+	MSM_PIN_FUNCTION(audio_pri_mclk_in2),
+	MSM_PIN_FUNCTION(audio_pri_mclk_out3),
+	MSM_PIN_FUNCTION(audio_pri_mclk_in3),
+	MSM_PIN_FUNCTION(audio_sec),
+	MSM_PIN_FUNCTION(audio_sec_mclk_out0),
+	MSM_PIN_FUNCTION(audio_sec_mclk_in0),
+	MSM_PIN_FUNCTION(audio_sec_mclk_out1),
+	MSM_PIN_FUNCTION(audio_sec_mclk_in1),
+	MSM_PIN_FUNCTION(audio_sec_mclk_out2),
+	MSM_PIN_FUNCTION(audio_sec_mclk_in2),
+	MSM_PIN_FUNCTION(audio_sec_mclk_out3),
+	MSM_PIN_FUNCTION(audio_sec_mclk_in3),
+	MSM_PIN_FUNCTION(core_voltage_0),
+	MSM_PIN_FUNCTION(cri_trng0),
+	MSM_PIN_FUNCTION(cri_trng1),
+	MSM_PIN_FUNCTION(cri_trng2),
+	MSM_PIN_FUNCTION(cri_trng3),
+	MSM_PIN_FUNCTION(dbg_out_clk),
+	MSM_PIN_FUNCTION(dg_out),
+	MSM_PIN_FUNCTION(gcc_plltest_bypassnl),
+	MSM_PIN_FUNCTION(gcc_plltest_resetn),
+	MSM_PIN_FUNCTION(gcc_tlmm),
+	MSM_PIN_FUNCTION(gpio),
+	MSM_PIN_FUNCTION(led0),
+	MSM_PIN_FUNCTION(led1),
+	MSM_PIN_FUNCTION(led2),
+	MSM_PIN_FUNCTION(mdc_mst),
+	MSM_PIN_FUNCTION(mdc_slv0),
+	MSM_PIN_FUNCTION(mdc_slv1),
+	MSM_PIN_FUNCTION(mdc_slv2),
+	MSM_PIN_FUNCTION(mdio_mst),
+	MSM_PIN_FUNCTION(mdio_slv0),
+	MSM_PIN_FUNCTION(mdio_slv1),
+	MSM_PIN_FUNCTION(mdio_slv2),
+	MSM_PIN_FUNCTION(mux_tod_out),
+	MSM_PIN_FUNCTION(pcie0_clk_req_n),
+	MSM_PIN_FUNCTION(pcie0_wake),
+	MSM_PIN_FUNCTION(pcie1_clk_req_n),
+	MSM_PIN_FUNCTION(pcie1_wake),
+	MSM_PIN_FUNCTION(pll_test),
+	MSM_PIN_FUNCTION(pon_active_led),
+	MSM_PIN_FUNCTION(pon_mux_sel),
+	MSM_PIN_FUNCTION(pon_rx),
+	MSM_PIN_FUNCTION(pon_rx_los),
+	MSM_PIN_FUNCTION(pon_tx),
+	MSM_PIN_FUNCTION(pon_tx_burst),
+	MSM_PIN_FUNCTION(pon_tx_dis),
+	MSM_PIN_FUNCTION(pon_tx_fault),
+	MSM_PIN_FUNCTION(pon_tx_sd),
+	MSM_PIN_FUNCTION(gpn_rx_los),
+	MSM_PIN_FUNCTION(gpn_tx_burst),
+	MSM_PIN_FUNCTION(gpn_tx_dis),
+	MSM_PIN_FUNCTION(gpn_tx_fault),
+	MSM_PIN_FUNCTION(gpn_tx_sd),
+	MSM_PIN_FUNCTION(pps),
+	MSM_PIN_FUNCTION(pwm0),
+	MSM_PIN_FUNCTION(pwm1),
+	MSM_PIN_FUNCTION(pwm2),
+	MSM_PIN_FUNCTION(pwm3),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_a0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_a1),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_b0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_b1),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_a0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_a1),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_b0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_b1),
+	MSM_PIN_FUNCTION(qdss_traceclk_a),
+	MSM_PIN_FUNCTION(qdss_tracectl_a),
+	MSM_PIN_FUNCTION(qdss_tracedata_a),
+	MSM_PIN_FUNCTION(qrng_rosc0),
+	MSM_PIN_FUNCTION(qrng_rosc1),
+	MSM_PIN_FUNCTION(qrng_rosc2),
+	MSM_PIN_FUNCTION(qspi_data),
+	MSM_PIN_FUNCTION(qspi_clk),
+	MSM_PIN_FUNCTION(qspi_cs_n),
+	MSM_PIN_FUNCTION(qup_se0),
+	MSM_PIN_FUNCTION(qup_se1),
+	MSM_PIN_FUNCTION(qup_se2),
+	MSM_PIN_FUNCTION(qup_se3),
+	MSM_PIN_FUNCTION(qup_se4),
+	MSM_PIN_FUNCTION(qup_se5),
+	MSM_PIN_FUNCTION(qup_se5_l1),
+	MSM_PIN_FUNCTION(resout),
+	MSM_PIN_FUNCTION(rx_los0),
+	MSM_PIN_FUNCTION(rx_los1),
+	MSM_PIN_FUNCTION(rx_los2),
+	MSM_PIN_FUNCTION(sdc_clk),
+	MSM_PIN_FUNCTION(sdc_cmd),
+	MSM_PIN_FUNCTION(sdc_data),
+	MSM_PIN_FUNCTION(tsens_max),
+};
+
+typedef unsigned int msm_pin_function[10];
+
+#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9) \
+	[id] = {        msm_mux_gpio, /* gpio mode */	\
+			msm_mux_##f1,			\
+			msm_mux_##f2,			\
+			msm_mux_##f3,			\
+			msm_mux_##f4,			\
+			msm_mux_##f5,			\
+			msm_mux_##f6,			\
+			msm_mux_##f7,			\
+			msm_mux_##f8,			\
+			msm_mux_##f9,			\
+	}
+
+static const msm_pin_function ipq5210_pin_functions[] = {
+	PINGROUP(0, sdc_data, qspi_data, pwm2, _, _, _, _, _, _),
+	PINGROUP(1, sdc_data, qspi_data, pwm2, _, _, _, _, _, _),
+	PINGROUP(2, sdc_data, qspi_data, pwm2, _, _, _, _, _, _),
+	PINGROUP(3, sdc_data, qspi_data, pwm2, _, _, _, _, _, _),
+	PINGROUP(4, sdc_cmd, qspi_cs_n, _, _, _, _, _, _, _),
+	PINGROUP(5, sdc_clk, qspi_clk, _, _, _, _, _, _, _),
+	PINGROUP(6, qup_se0, led0, pwm1, _, cri_trng0, qdss_tracedata_a, _, _, _),
+	PINGROUP(7, qup_se0, led1, pwm1, _, cri_trng1, qdss_tracedata_a, _, _, _),
+	PINGROUP(8, qup_se0, pwm1, audio_pri_mclk_out2, audio_pri_mclk_in2, _, cri_trng2, qdss_tracedata_a, _, _),
+	PINGROUP(9, qup_se0, led2, pwm1, _, cri_trng3, qdss_tracedata_a, _, _, _),
+	PINGROUP(10, pon_rx_los, qup_se3, pwm0, _, _, qdss_tracedata_a, _, _, _),
+	PINGROUP(11, pon_active_led, qup_se3, pwm0, _, _, qdss_tracedata_a, _, _, _),
+	PINGROUP(12, pon_tx_dis, qup_se2, pwm0, audio_pri_mclk_out0, audio_pri_mclk_in0, _, qrng_rosc0, qdss_tracedata_a, _),
+	PINGROUP(13, gpn_tx_dis, qup_se2, pwm0, audio_pri_mclk_out3, audio_pri_mclk_in3, _, qrng_rosc1, qdss_tracedata_a, _),
+	PINGROUP(14, pon_tx_burst, qup_se0, _, qrng_rosc2, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(15, pon_tx, qup_se0, _, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(16, pon_tx_sd, audio_sec_mclk_out1, audio_sec_mclk_in1, qdss_cti_trig_out_b0, _, _, _, _, _),
+	PINGROUP(17, pon_tx_fault, audio_sec_mclk_out0, audio_sec_mclk_in0, _, _, _, _, _, _),
+	PINGROUP(18, pps, pll_test, _, _, _, _, _, _, _),
+	PINGROUP(19, mux_tod_out, audio_pri_mclk_out1, audio_pri_mclk_in1, _, _, _, _, _, _),
+	PINGROUP(20, qup_se2, mdc_slv1, tsens_max, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(21, qup_se2, mdio_slv1, qdss_tracedata_a, _, _, _, _, _, _),
+	PINGROUP(22, core_voltage_0, qup_se3, pwm3, _, _, _, _, _, _),
+	PINGROUP(23, led0, qup_se3, dbg_out_clk, qdss_traceclk_a, _, _, _, _, _),
+	PINGROUP(24, _, _, _, _, _, _, _, _, _),
+	PINGROUP(25, _, _, _, _, _, _, _, _, _),
+	PINGROUP(26, mdc_mst, led2, _, qdss_tracectl_a, _, _, _, _, _),
+	PINGROUP(27, mdio_mst, led1, _, _, _, _, _, _, _),
+	PINGROUP(28, pcie1_clk_req_n, qup_se1, _, _, qdss_cti_trig_out_a0, _, _, _, _),
+	PINGROUP(29, _, _, _, _, _, _, _, _, _),
+	PINGROUP(30, pcie1_wake, qup_se1, _, _, qdss_cti_trig_in_a0, _, _, _, _),
+	PINGROUP(31, pcie0_clk_req_n, mdc_slv0, _, qdss_cti_trig_out_a1, _, _, _, _, _),
+	PINGROUP(32, _, _, _, _, _, _, _, _, _),
+	PINGROUP(33, pcie0_wake, mdio_slv0, qdss_cti_trig_in_a1, _, _, _, _, _, _),
+	PINGROUP(34, audio_pri, atest_char_status0, qdss_cti_trig_in_b0, _, _, _, _, _, _),
+	PINGROUP(35, audio_pri, rx_los2, atest_char_status1, qdss_cti_trig_out_b1, _, _, _, _, _),
+	PINGROUP(36, audio_pri, _, rx_los1, atest_char_status2, _, _, _, _, _),
+	PINGROUP(37, audio_pri, rx_los0, atest_char_status3, _, qdss_cti_trig_in_b1, _, _, _, _),
+	PINGROUP(38, qup_se1, led2, gcc_plltest_bypassnl, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(39, qup_se1, led1, led0, gcc_tlmm, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(40, qup_se4, rx_los2, audio_sec, gcc_plltest_resetn, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(41, qup_se4, rx_los1, audio_sec, qdss_tracedata_a, _, _, _, _, _),
+	PINGROUP(42, qup_se4, rx_los0, audio_sec, atest_tic_en, _, _, _, _, _),
+	PINGROUP(43, qup_se4, audio_sec, _, _, _, _, _, _, _),
+	PINGROUP(44, resout, _, _, _, _, _, _, _, _),
+	PINGROUP(45, pon_mux_sel, _, _, _, _, _, _, _, _),
+	PINGROUP(46, dg_out, atest_char_start, _, _, _, _, _, _, _),
+	PINGROUP(47, gpn_rx_los, mdc_slv2, qup_se5, _, _, _, _, _, _),
+	PINGROUP(48, pon_rx, qup_se5, _, _, _, _, _, _, _),
+	PINGROUP(49, gpn_tx_fault, mdio_slv2, qup_se5, audio_sec_mclk_out2, audio_sec_mclk_in2, _, _, _, _),
+	PINGROUP(50, gpn_tx_sd, qup_se5, audio_sec_mclk_out3, audio_sec_mclk_in3, _, _, _, _, _),
+	PINGROUP(51, gpn_tx_burst, qup_se5, _, _, _, _, _, _, _),
+	PINGROUP(52, qup_se2, qup_se5, qup_se4, qup_se5_l1, _, _, _, _, _),
+	PINGROUP(53, qup_se2, qup_se4, qup_se5_l1, _, _, _, _, _, _),
+};
+
+static const char *ipq5210_get_function_name(struct udevice *dev, uint selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *ipq5210_get_pin_name(struct udevice *dev, uint selector)
+{
+	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+	return pin_name;
+}
+
+static int ipq5210_get_function_mux(unsigned int pin, uint selector)
+{
+	unsigned int i;
+	const msm_pin_function *func = ipq5210_pin_functions + pin;
+
+	for (i = 0; i < 10; i++)
+		if ((*func)[i] == selector)
+			return i;
+
+	pr_err("Can't find requested function for pin %u\n", pin);
+	return -EINVAL;
+}
+
+static const struct msm_pinctrl_data ipq5210_data = {
+	.pin_data = {
+		.pin_count = 54,
+		.special_pins_start = 54, /* There are no special pins */
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = ipq5210_get_function_name,
+	.get_function_mux = ipq5210_get_function_mux,
+	.get_pin_name = ipq5210_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,ipq5210-tlmm", .data = (ulong)&ipq5210_data },
+	{ /* Sentinal */ }
+};
+
+U_BOOT_DRIVER(pinctrl_ipq5210) = {
+	.name		= "pinctrl_ipq5210",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+	.flags = DM_FLAG_PRE_RELOC,
+};

-- 
2.34.1

