Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC790606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V0x7aNRu;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C/kLkect;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hZpIM+7s
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8C59480E47;
	Sun,  1 Nov 2026 10:19:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0OtLBXyMd1Fg; Sun,  1 Nov 2026 10:19:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B398080F8B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793528391;
	b=i3624tZZ7LnHhfbCF9vI/gjlkVW1+J6gWKDRoTPorN7NMi/wvVPYP3AbDHQ90YlFFg0J
	 8F8JIABI8/KRcPjKs0fEkDabeRfE/5JVhg2KKhyTuKK2OHa2OGZxPIaBdBHh6+snXg6sD
	 GgvJycbgp9MmBMbABbIGf8zRMGhpS0gMY9vLJNMhV6cSfSCF0fZ8MLUsse1lOrePT5I+L
	 Ne2fv7K0rdmBLgC3LYqz3SCoJxSoaxVD2Wu+Z0BA553krzvIBkEPu7vzn1TtND9PVt4SF
	 gVaiiobKfZcs2paMw7C/TgHfvPKVEutEiH9N0iPeb4hkBpCyECJT44mSBWRhC+FCorw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793528391;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=uL0IDeP2uCgZhbpATV3J/7+iE9JMEv3bFUK2kbD/veg=;
	b=q3wI/hGDHkhVf1jv5kjE8ThThzQkWGvE8jIo/RE+gdyO3NAOnA7Fq25cAfSoGyYDowSC
	 OTbK0PR1vle7q5UlmkADhcsroCa9u2wsi72NK/kC2MrW3Bg2LLa03dqTk4D8ha4XF8MNP
	 0sO/2GtKXUjUuM1ufhGzzwyrqzbBif38vrznSy6Z90S35l0WRUi6JtPBMveSuTneSw+jr
	 xKQXSCjeYIWZoHu69j8osxFKCguvmeRSdroYBEb4wy2MNnEvnWBT3cxL/4GSkKXb1qbxL
	 VJexz/bCT8W3Ckwu1Yq//pQpLIaFNK0hJ1pZmj1Z+jFPZGaCnqdB5YOwLgd8lJQl6EA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793528391;
	bh=uL0IDeP2uCgZhbpATV3J/7+iE9JMEv3bFUK2kbD/veg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V0x7aNRuPnuFKv3WKA12BssqoSjg4HtmPwfabY8iduVm/Tmpsq/xfiOqVsqkBU2Oe
	 vjCnoGYX+uk45WmvdNb/96KPKqUUNAymMhwjmD4spIRcvjAYpC6u3e2IaAq4coLE35
	 TVp+PjiNdpBv/bHiBkaB3qTQlP7YWmwdkWG8j+kwLmJC+H+ZgcFFs1dl8bYL7fJqgH
	 5f5JHEBWz9QjZD7A+vB0bmkLnZYKrqaSIGCWNgcVaovGAbWv3bdeogb1D8wHv9HDw5
	 EXn36Y5kJU4YUyCAOMTYSHyZ9B+AWzVB9LwFQKdcLQi2bzyd6Y0u037UWHTCUdGNjb
	 GVng1V+Ayg37g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B398080F8B;
	Sun,  1 Nov 2026 10:19:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 34B79380
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:19:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 19B03405BA
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:19:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e_pYzM35wK3N for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 10:19:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2B5CD405BD
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793528389;
 b=Dw2nganHo7R9znGyQJ8aqSeTRfJz//ELBk+RyizlamVfi4qCYOxrGmtYtX/3W2Pgi7K7
 rWDjtSvYQL5wLhFxjITL/Z/nvlzO4EsT6qvxUdVkDe90bhLo6QS3jDEMImlVE2gmuuXfZ
 8F0xnGrNnsdIN7eylcvj3tnPLKI+m/mN8XHQxQyQ214vHZF6O2BrQik3r9EZ1QXn92Lbo
 BgCOQ4GbKWms4so4VghwOduZNAU27Sv47JeBov1bOKRIFBoVvQuMmSwhYbICvpO3xCgVg
 DG0TB1DWBB/JiEWVP0eeIhn/kUNn1453O+008xtAqPJ36c+RoTAraqmseqVoD6uoSdg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793528389;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=uL0IDeP2uCgZhbpATV3J/7+iE9JMEv3bFUK2kbD/veg=;
 b=Q7BCRNlfx5lsYnunvU7/6g6E9K914KcykPsJIEqFZ947pDhbsJY3CxnKFqDhlPtDrSo5
 zHddlUB2JIjcoNTAHmx7swxhsqbQ0vxKNRTiUOfGOBZ07ESoId2hptkNjbqmcC6BblcHz
 U4ktgabnMvqWi7QdLbhvee1CAY6vxVk2ifP4VBanWL2rXdknAscEAYeoDdh+lh7tToUCf
 VIcnqc5dwsiNQzrpPKcuFWChky+pzUYEVf8edtcBAtGH2YpAfHed4EgQyTgVDIDOWBcsX
 TB7jkDy/DqAmxhFV54wd7Nh2DSNedXI9QL3o7YUICKQ8YxxKvbe/zHOKGu2azD6VCoA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b="C/kLkect"; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hZpIM+7s; 
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=C/kLkect; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=hZpIM+7s
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B5CD405BD
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 10:19:48 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A18K29Q341568
 for <u-boot@lists.u-boot-project.org>; Sun, 1 Nov 2026 10:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uL0IDeP2uCgZhbpATV3J/7+iE9JMEv3bFUK2kbD/veg=; b=C/kLkect/jaQ0Axw
 Jr0aQMfndxkeLodt1HhwuKO3t+vQxis4CR0gK0ExPSv10eiLt9DppsXzlJQOgvcb
 hQbey15tC5gDqedQs4jDK4RMlW8PCwVK7/qj8Dc7mp/EunHUBmmk46usgt1uaD40
 IKdQreZ4Re8YmPgsR/14U2ikTN4JDmAPH0xePD21tNEYB9R5q26MHLNo75Q9VNwv
 qouN4GIwBTX6Joz4Erj67BB1qcoZfdmnhyfkINJJ8Elz+XwsPJserZPOIg4mLeR6
 r+9MhdSS/q5OtW3bmZuTtbPjkHMQDRJAD6aRFMhYR6rur8oLuju++L9H0GhL6ZTk
 BU6XmQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8dub46x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 10:19:47 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so9610764eec.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 02:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793528386; x=1794133186;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uL0IDeP2uCgZhbpATV3J/7+iE9JMEv3bFUK2kbD/veg=;
 b=hZpIM+7siTyqg2lQI2ExliIvkhRQ3o5fe0s2q1LckUFFDAw5UtOFjv1IatKkaQTM+Q
 SGoqPo2rPb1LclZ0Z36+nR5uqmBo/UhgD/ZHlj0Ccm50jyCb4dniKT/IiKcCzZXAlBIJ
 e4XPZKh9SIPrRhVIV804eswgnPIjK79R9T29iKCFzOfVDkasYu/QBMhgwhtGz4eLy58S
 zTr4ARnQDB0gC5s08XoPYP2GLFGc1F5TN2yL3QKmajj1EUbbwV3SFi0H/x4h5BhnvseY
 iSe1QoBctgoVoDk4pkNH1CpnBccJvr3UYGGAw3FR2WtkkchaW40jc3f5iYDdaQoTUtFT
 53pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793528386; x=1794133186;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uL0IDeP2uCgZhbpATV3J/7+iE9JMEv3bFUK2kbD/veg=;
 b=UYqeHzz/b5TtZlRoQqRKVSETJJpxmCHasfejdhQW2rpgFOnljtLKgO4gebYRVZD+bd
 sRTTagjV6nxZXzUtpyx7yu1zelCViEu6osSA6+pXr7ga8vKF46wKrQVdqb+lONcuNEJJ
 qJ5DJIKGdyJ22sv2DIVaAZJ5Hvzexx3rHIqwgVAGAJlZFYMwq4JrDBaR9vxC45GN+W+I
 s+J6Q5HICawYBmWxOn0gix7OiEAmYbHNW+nKHsAKZSisPnL+y8Kbz4PLgIOU0rJY0+rX
 Z+NRAfZ/2nOsoyRYMWC0occsNl2a/3AqKIe7JEE9tTuhRUirsnsBQbdkafJdiXKTmufP
 g/zQ==
X-Gm-Message-State: APuU4Z/zETGSCrtycfDGo9zdHTcGGBNtdnvLVIRaYUbti1IuIcHlzxnE
 7Hl/kmP3H7px8R+0VU+YbR6IySxuHrJF3xPCtzG74j5asVNq2zbACWOgkkiBLa9pdMY9IIecJVF
 QGMy58CkaauLwWF158ivqa8Ypes7IKmNeojfn7zqCfjIXljeqfDm9MDaMC+CvqYqSu9WKjUI=
X-Gm-Gg: AYBFou1en25gOb3e7crn729qSvRd9BqfUh7VsUcit/HQRj5bJjE1sj6cdkOXFvAlXbC
 rdDNZEJhgIIVbDXDnohd78zNSFdy8/pUvc3g6F9eZw9T1RkdK1etlM1biMXd9tkRQd7ew1Gt1rl
 PHBvrz1OlJyvXcHSoO+9lKfCvih8EV6rIvP3jnFTQ22fe+FfySk1ZZNHKaY3g2f3deOhwWiCBW2
 qu0eWYkx02JUqaIxAONlPSxSFLrIbKxUm5qmxUuetNs45zm983LqhTYQfVKYPeOORxKj/jUPVHV
 Lyul8UrIxfyq8v5VLOw7aXef8Qk289QffFiFw4CTBwYV5SmvlMuL7BNKoHEB4dqpQc0HbheZAX7
 8b1Q9zsxw4v469qBugYnB2Wc0rtJw2ZPMcGE88cWZSOTdYabD48nNGo1+Cjk7oLxC/88EKrKN7r
 LduPGC7+noWFHYgD63iDEL/ZWt22lv9b4hAbJZCij7Ig2wJajYi3e85kH59A5Poq0FzY3cnF9GI
 QqAEA==
X-Received: by 2002:a05:7301:619b:10b0:36a:1d6f:917c with SMTP id
 5a478bee46e88-36a423c3380mr11802556eec.22.1793528386326; 
 Sun, 01 Nov 2026 02:19:46 -0800 (PST)
X-Received: by 2002:a05:7301:619b:10b0:36a:1d6f:917c with SMTP id
 5a478bee46e88-36a423c3380mr11802527eec.22.1793528385759; 
 Sun, 01 Nov 2026 02:19:45 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a429467cdsm24596555eec.19.2026.11.01.02.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 02:19:45 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 01 Nov 2026 15:48:40 +0530
Subject: [PATCH v10 2/7] arm: snapdragon: Disable MMU early before U-Boot
 reset vector
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-snagboot-v10-2-e73d5cfedb8a@oss.qualcomm.com>
References: <20261101-snagboot-v10-0-e73d5cfedb8a@oss.qualcomm.com>
In-Reply-To: <20261101-snagboot-v10-0-e73d5cfedb8a@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>,
 Hongyang Zhao <hongyang.zhao@thundersoft.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793528369; l=2747;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=b2MZNvbz8+ULKdUaGCWt92X71yqfoatohCj+7IFSRxw=;
 b=7ZXgBDtlRqXiyBvRFghy9rTAyPqdGyE0Okb9QfEAuTMeUeCDUmoHe3UKobbMFUJTqER1YWLuR
 cINVfJT+xFPA6KycITITHFkhweIKXHcC52UFgIpILBMZfvYxsEdcHVU
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=O6esLx9W c=1 sm=1 tr=0 ts=6ae71243 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Q-CY8eKHVbgcYtpEucYA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: CT1NkLbmfh9MocxJhyrScc91r5utISzG
X-Proofpoint-GUID: CT1NkLbmfh9MocxJhyrScc91r5utISzG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA0MCBTYWx0ZWRfX7OYSfYj9/5fJ
 5/8Hi8oqgnd6LnSRf5NQssu/r9J0YFlSyoXQizVeT3uACdQVe3qxnt18TR4fIQ/Uy4DwVgsmWdi
 ik+DMB3F4S4gnItyYY5uQBEmIoYaoNs7K3jDhMy4Xy6LqJE/Z/nPBL3UkM/zuPHY4f0nt2JjWsy
 mP1ZMuyslzK3/8LIXg2drQUgPxIv2iiN1qGCvTvKHIZr8U5tH/aFwRsxAhkYAWu3oCvHHaBK843
 qv9ys/zybWAL0q1o7yHUyjOYoURMI7z0BDWsc0t6nHb1rWdtwFZaDvFXOh8T9zUN6FJ90yhdt18
 sf6zjlHRMEgHw9YC8FnogsAKky7/7/zHz6mLFX0N9RpN4hL3ZuY4hEGUy3DCsF1RVwFA29zugHX
 rt1ixmZ9Vk+s50DbD+V8w8RHn1XQSTvSSUxu9jBvnDczSOjHDIzdz/q+WTxnVZRVf4n0E6qB75o
 VQyX0kBvKJb/A+rKRBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA0MCBTYWx0ZWRfX0ePciGK7FFOz
 uv1+0O5+QdzkLnXQGf9jfThFMpqHS9gso0TP/+Tqvcz3eIbPbP0+Q+7CAOgimsm6HhqQVPYGgkw
 tcaxU1AvCTu1Siqbsk3xpDNwCeG6XyU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010040
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

When U-Boot is loaded by XBL in Snagboot mode, XBL leaves the MMU
enabled with its own page tables. This causes stale TLB entries and
incorrect memory mappings when U-Boot initializes its own MMU.

Disable the MMU and invalidate TLBs before branching to the
reset vector. This ensures a clean MMU state for U-Boot initialization
in Snagboot mode.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v10:
- Rebase to latest boot0.h file
- Add missing newline at end of snagboot_boot0.h

Changes in v7:
- No changes

Changes iv v5:
- Clear C bit (Dcache enable) also during MMU disable

Changes iv v4:
- Remove handling for EL1 or EL2 entry as for Snagboot we would
  only enter U-Boot in EL3 from previous bootloader

Changes in v3:
- Brought the MMU disable logic under CONFIG_QCOM_SNAGBOOT_SUPPORT
  ifdef condition
- Moved the MMU disable codes to a new seperate file

Changes in v2:
- Newly introduced in v2
---
 arch/arm/mach-snapdragon/include/mach/boot0.h      |  2 ++
 .../mach-snapdragon/include/mach/snagboot_boot0.h  | 27 ++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
index c34627cf62c..0e199b973a9 100644
--- a/arch/arm/mach-snapdragon/include/mach/boot0.h
+++ b/arch/arm/mach-snapdragon/include/mach/boot0.h
@@ -10,6 +10,8 @@
 #include "msm8916_boot0.h"
 #elif defined(CONFIG_QCOM_EL2_GUNYAH_EXIT_SUPPORT)
 #include "gunyah_exit_boot0.h"
+#elif defined(CONFIG_QCOM_BOOT0_SNAGBOOT_MODE)
+#include "snagboot_boot0.h"
 #else
 	b	reset
 #endif
diff --git a/arch/arm/mach-snapdragon/include/mach/snagboot_boot0.h b/arch/arm/mach-snapdragon/include/mach/snagboot_boot0.h
new file mode 100644
index 00000000000..899a37092f8
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/snagboot_boot0.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Early MMU Disable for Snagboot Mode
+ *
+ * Disable MMU at the earliest possible point for EL3 entry.
+ * Snagboot mode always enters U-Boot at EL3.
+ *
+ * After disabling MMU, invalidate TLB to clear any stale entries that might
+ * cause issues when MMU is re-enabled later.
+ */
+
+	mrs	x0, CurrentEL
+	cmp	x0, #(3 << 2)	/* Verify EL3 entry */
+	b.ne	reset		/* Unexpected: not at EL3 */
+
+	/* Disable MMU at EL3 */
+	mrs	x0, sctlr_el3
+	bic	x0, x0, #1	/* Clear M bit (MMU enable) */
+	bic	x0, x0, #(1 << 2)   /* Clear C bit (Dcache enable) */
+	bic	x0, x0, #(1 << 19)  /* Clear WXN bit (Write XOR Execute) */
+	msr	sctlr_el3, x0
+	isb
+	/* Invalidate entire TLB for all ELs */
+	tlbi	alle3
+	dsb	sy
+	isb
+	b	reset

-- 
2.34.1

