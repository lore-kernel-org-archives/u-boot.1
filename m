Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C46606A326
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=X0C4PYNs;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BXDD6lvy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OTfuumCx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FEE660685;
	Fri,  6 Nov 2026 07:02:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RzzaGrfSrnxV; Fri,  6 Nov 2026 07:02:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E7CDC60635
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793948549;
	b=gOzmQgKR9/x1A/U25nH4AHLdhg0R0BAfzpiVK1802xm9frX8AYfH0mpKWebHyn3jMM5F
	 Ke5NF+JLBZDxt0trGs/Oe48iMGxhfEeL6ZYSMLoAW5EfjDBvm7gtJxEOkqt9VIYyMeehB
	 3a8KEjOOI4E2J8NPd+vhgeLJ0jgzQEDF8Q3WyBSHO5UV72+pN1Yd0KEJ0V7f8Gh0CmEeP
	 pQbP7SvXgpr2+NdXNuFjXIFXL+w3n43OMUEyXoUTrE+f66S3C0+/zIoRrUmWW/94XUQDA
	 S1gMBdqb78t3cpdoWKYBETUBv2HkaXhunjaB0synrHcQPGjUzrMUleALXYkNWvCn4Mg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793948549;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XrJIO2yz2F4Wl127cm2Tw1xgJuabtl8ltAJMlqfKHZs=;
	b=q0+qalgWY/deCVto6d/xnYr8dLKKiUfcEWYW4fOTGhCgeomg319xWNs4CSzAOPfaJiND
	 lm+nDZv2sMisHdO0Hqx3po2ICVM4kXsOLB0jUeXSgbmqwxbnoYUPsxYWziWgkuKz0uKYL
	 VVRmMfte1Zk3Z1nguqU2PzAcB2qLlk/idQbs/5UdODLxVFg4ypS3K8taoXJQhwT8DSJmF
	 IqDwaMve56FHfahLtjaUCld4YSObcSSiDWJznzziJJ88G2mr1eaSbD72t0gP5PvIcESGX
	 TChhpCaGXcycQUx40742OH0XMFz3jC16ch6JVxISbuRXdwvH+EO31Zh1f91N9GUOvWg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793948549;
	bh=XrJIO2yz2F4Wl127cm2Tw1xgJuabtl8ltAJMlqfKHZs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X0C4PYNsn5irelrY9F6Np9vM5xqODHQw2cj6OpY94jNx/Xxo1+5w4gvsJ4DztBofM
	 l0nNZqWYelE9s5cUgkJ4OH5T9V+Xy9wfEyKtvwLGpOX/rNG37pG6RPvnfgnXSLuaXP
	 GIjvQqnaQNnI85NGx5gvnTUCvBsNgVW7aaZ61hMkBaP6l7oTLeEvhEeS7b6V6NFJ9G
	 jWEefEr5f5L+IilsqI+CRANDY8O9bHmSlUMpbvSlvZfkguT46GKAaRUyO7W+eAZqv/
	 rsZFAfeVo6hTO/qIejzwGVeSO0JFCamA22DGDxUhgJbYE9GlPZQEVvy+YA/Z/rBRY/
	 oZ6laA2j65Yvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E7CDC60635;
	Fri,  6 Nov 2026 07:02:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AC986235
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:02:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 90D2B407E9
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:02:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RBOMU7TV4zvH for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 07:02:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D7DD2407E2
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=badhrinath.s@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=BXDD6lvy; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=OTfuumCx
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7DD2407E2
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 07:02:26 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6408qH1727876
 for <u-boot@lists.u-boot-project.org>; Fri, 6 Nov 2026 07:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XrJIO2yz2F4Wl127cm2Tw1xgJuabtl8ltAJMlqfKHZs=; b=BXDD6lvylRkOAZYz
 x2OFIRJu33hdggnLoWR7Z1bicry8DNoOo0995f/oWkBQVi5MMmPNzDCHD5/QTUjw
 50hzIR8keorov4ZnMxQLj7ZvVBbiy7b4r6hcmZaYJ+Z6BXwIqEKP+Sc6eKoMflem
 YWJmRTVZ/TxoK+imQ7JP8KLxkC8DL5HhbaIkuYkWjIQy9/XReT5hJOBJHITVu2/M
 F4hjU/XFPy2D38bJpxjDe8eBCHV+i7pkAGbfZqIFw2i832lFYaXq9L1IFI4PplLO
 Brz1uFVifbF4mpsFcDiYYK+pZt+zxNkjtG/4ig9LC3pFInWZ1yPPxv/MexJVyYQo
 ywxqHw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa9fsg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 07:02:24 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1ab289bb41eso353333c88.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 23:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793948543; x=1794553343;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XrJIO2yz2F4Wl127cm2Tw1xgJuabtl8ltAJMlqfKHZs=;
 b=OTfuumCxOPcx0zsDm+wUsXE589x/2dG9sXRxUrDgXJzznRYuJqA/dwmphqgwfe6NdE
 Aik1wMHylRp+VVAIOyxNnf+fAXZHe+fUhHD1oiRkF6GJI0QqoAgjcN767ch/aigsRG4O
 ogMmkpVpKVFRe7bPm3GOi6hRmL/wwWWUw4HzPWs73KSexZfYmdzRLt1BmJLfZGGD6Hdu
 ytqSgG4qYJrL/l8Q4WMFFxZjNo6YbdoAnY4LN6H0xxWOSvkExzcfnom7Hn865g+OIuy7
 JLDleWGgxi13egyL/ZOMQClRZiN10/5xvj0+tB8flkwkoWeJnCsmyFAjQyHuzejbYF/K
 Tu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793948543; x=1794553343;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XrJIO2yz2F4Wl127cm2Tw1xgJuabtl8ltAJMlqfKHZs=;
 b=PrmmdGdYWepFOuPyXfYFwl3UeHGA+YjusLzya21b+osCJR7fCcuAyOATTpCB+qMozx
 A38NPuTMd9JzvFl8tER8W+ao8vX9/v9qoMOwf55E6EyiMjA9jkVqBXbq5wN4n1pCn5ez
 +68fsrWgPNX+MglsrTqwLp++b8L2hp9sScnGS4UDyABZzGv7hY+ydGHLZnL3lCvBciJQ
 LyuOYI3xlVKyXLn0HJJ5htDz6zSa5Wb2GgJcn2yfzqnzuyl50iuBknQUSAFoFO8Usk/Y
 6/y29U8SIPe2tzvIIKUiDwkDAP6dgZUe3YOuImflGkr6lO2pq+1ycuKMXMnoDW6bZxjc
 gtJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGcR7Uyy5YwrvnnqSq4nsDzenP404yfOzuFgiEKFu8Q56eF0SKBsfnFVtFpqHaqjjdpmqI7cE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9X9g3x5z89+JyVCA//43E3dzisSSJpdxdv3pYutgT/KH2PB41G
 aILQ7QzpYw0G2Q6Ju/vPtYG7W2dLxqLdCP34QLbNmdQVhAiYoHEEwxhhb70B+Uqsz1ovsvMeDD0
 HxGiOr9aLkEiTPLawWNhiGDuL8M0qA6FMfHFAxJVOeZxIbY3ehCrgSuLAK+aBqpLuCDl5ysE=
X-Gm-Gg: AYBFou1qcyKKwIDFnlcE9QxnrmxX8cNm9RZox5N8e3gpSZ6XDRmoLny/XQWjOX9dnwz
 Tg2k2YN6S92Oza2B/3KIAL77aNNcBm+WxOJoYlZ1akFmq2FBXDKAW8JJ+U6tIw0ayCTw1k5u3pJ
 HaPjsuNAB5yksNjw07+XhSTeqBDrX4oLsPsn3vwZWQMF89zHgzQmequ4kh6yM2jIHt71UqipB2Y
 ADJbtwTURDDsov+2xk0pK9ZaJbjhkW0KKgadYIQvwwcnLAqO2JQCb59XQETlG4WzfXVlvX0TITX
 Y4Z8NLTyhnNgzObRX8UaH/LKROIE0zVO6UxJmq4pARlJQq+3nkTnCetox20B0eTiHVjzMVzWfAk
 uldWhSrdOWX366MSEYvpaP7XwYH1Q899dHXVkN/IaUwb4r2XqZeYVDwyNuRy+xgWeyVbBESQRG0
 PqVUmDfRhK3JJ4d19rVl6MrU8jGXGpsKqXYAL8+IGDQR/gu9B8jSnd3Ar3H2V5z+7C2WPcHw==
X-Received: by 2002:a05:7022:f51b:b0:181:6b8:31f1 with SMTP id
 a92af1059eb24-1b24f4bb749mr5452176c88.10.1793948542986; 
 Thu, 05 Nov 2026 23:02:22 -0800 (PST)
X-Received: by 2002:a05:7022:f51b:b0:181:6b8:31f1 with SMTP id
 a92af1059eb24-1b24f4bb749mr5452139c88.10.1793948542403; 
 Thu, 05 Nov 2026 23:02:22 -0800 (PST)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b25e4a610fsm2735554c88.11.2026.11.05.23.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 23:02:21 -0800 (PST)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 12:32:00 +0530
Subject: [PATCH v9 3/3] configs: Add defconfig for ipq9650 RDP488
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ipq9650-v8-v9-3-23d8919e881f@oss.qualcomm.com>
References: <20261106-ipq9650-v8-v9-0-23d8919e881f@oss.qualcomm.com>
In-Reply-To: <20261106-ipq9650-v8-v9-0-23d8919e881f@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io, Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Biswapriyo Nath <nathbappai@gmail.com>,
 Vitalii Skorkin <nikroks@mainlining.org>,
 Johan Jonker <jbx6244@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Badhrinath S <badhrinath.s@oss.qualcomm.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793948519; l=2128;
 i=badhrinath.s@oss.qualcomm.com; s=20261106; h=from:subject:message-id;
 bh=r0HU3VwRWFiSJ2iDLLL9vIKuCtmheIhZEOSufAGiAE0=;
 b=qL4SKTzbBFiBXZk1/PdzjW+80KNLYoUFo8lktFc7m94EbHGsBZm6sHI2FRIr4PtP9EWzahSCW
 iTpsgUThYwMCU2j48mNQxqvtP08FzTFyi9vEVWgMbLK3s5+Q3jJ4VIX
X-Developer-Key: i=badhrinath.s@oss.qualcomm.com; a=ed25519;
 pk=ZJCDwDnSPTkkqcC32xlBRlzhvdSO5FnWlOjVr6IVBGQ=
X-Proofpoint-GUID: ufjMisQJCH7jBOobf6N4KRoyBpoMdQah
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAyNyBTYWx0ZWRfX15tdAWxXRjbJ
 k3fqy9KI5HOJF0mSZlvyjONB4Pz+s1uRnUtgaryaUCexCOGr1q1O0s5TevdIevFonQWU0gJ2hF5
 oXe/XvBW7zEiKA+0rbo20AItPE4OatMmfDOWKLxncvcIMK8WCfewY3gxIwJLSID8W8lf8X6MCM9
 lZ4fkPHjnh5/apq5cMrK22gZHQEtNvBNEeeQLPJkm08zcWS37Zcnjki5UgJn1JtswTc/bT7KqMP
 Q1qoNdvSKywqF/WHg83NdeDkvY3NYp9SK2sD3pT6xM5xTV/TSiYQCOczLCETi7fIBOiNxzBI1wo
 WRdcKgCqrdLS+DTe5aY9kilF6qn71JkYDABGIKMNZHr4il4MJQszQZJCupwr/oQyWKRX/dhNb7/
 MAmmFeR/wdZoxjbUv9yRA4Bf0z5iApr4EpHiduA5OpJgbE8HJ3ypnXXqvxxY1BUIV9EWMbDiZ9/
 q3WpXr3/TCDJkcSQ+VQ==
X-Proofpoint-ORIG-GUID: ufjMisQJCH7jBOobf6N4KRoyBpoMdQah
X-Authority-Analysis: v=2.4 cv=X7rHu2Te c=1 sm=1 tr=0 ts=6aed7b80 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=UuI9o3pZbsgdCeA7RPUA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAyNyBTYWx0ZWRfX6NMd64ou3mYd
 ymhbY9vzNh5cn+2Edw7BCywM6hB6GDyOqdiWuSe7ohRSngftwbjeQHkI1YqRe7uKiiUXVlcMUQD
 C2uAAyuNRnqQ6oZjxS8NmVrSqTpHkng=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060027
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add default configuration for the IPQ9650 RDP488 board with eMMC boot
support.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 configs/qcom_ipq.config            | 36 ++++++++++++++++++++++++++++++++++++
 configs/qcom_ipq9650_mmc_defconfig | 18 ++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/configs/qcom_ipq.config b/configs/qcom_ipq.config
new file mode 100644
index 000000000000..e649b07cdb2b
--- /dev/null
+++ b/configs/qcom_ipq.config
@@ -0,0 +1,36 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_REMAKE_ELF=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+# CONFIG_BOOTSTD is not set
+CONFIG_USE_PREBOOT=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_PART=y
+CONFIG_OF_LIVE=y
+CONFIG_CLK=y
+CONFIG_MSM_GPIO=y
+# CONFIG_I2C is not set
+# CONFIG_INPUT is not set
+CONFIG_MISC=y
+CONFIG_QCOM_GENI=y
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
+CONFIG_MSM_SERIAL=y
+CONFIG_MSM_GENI_SERIAL=y
+CONFIG_SOC_QCOM=y
+
diff --git a/configs/qcom_ipq9650_mmc_defconfig b/configs/qcom_ipq9650_mmc_defconfig
new file mode 100644
index 000000000000..624d10e83c5b
--- /dev/null
+++ b/configs/qcom_ipq9650_mmc_defconfig
@@ -0,0 +1,18 @@
+#include "qcom_ipq.config"
+CONFIG_SYS_INIT_SP_BSS_OFFSET=0x180000
+CONFIG_TEXT_BASE=0x80280000
+CONFIG_NR_DRAM_BANKS=24
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_OFFSET=0
+CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq9650-rdp488"
+CONFIG_SYS_LOAD_ADDR=0x90000000
+CONFIG_SYS_PBSIZE=1024
+CONFIG_CLK_QCOM_IPQ9650=y
+CONFIG_CMD_MMC=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_MSM=y
+CONFIG_PINCTRL_QCOM_IPQ9650=y
+CONFIG_SYS_MALLOC_LEN=0xC0000
+

-- 
2.34.1

