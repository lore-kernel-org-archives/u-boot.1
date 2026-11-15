Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D07606A327
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 05:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=z1Q8JrtB;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cY9cXIBI;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XKAyGewR
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18E5281139;
	Sun, 15 Nov 2026 05:05:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id asCLemNhThQK; Sun, 15 Nov 2026 05:05:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1AAAA81134
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794719104;
	b=sA+1/PPMvX8ruZhDRD3OXrHOI6sQQJNPOt49OJ10SuwGEk6yDRGYBNfV89gY1txq9Chr
	 M7vRAQZWIUwbdd/7Zh3aJrTO0/xePdx4KEQNPUtNeOXM6Lr6j9Oc+/wHdMUB3KRuT7xCe
	 t2qH6ODNa+g1h8HGDyUcG/JTO2w3csjwDp3zsQ8oADfgDcq18Pl2aKpJ7b1FfFm17ncX/
	 CigQJbmXSwZT+GEld+JQcWD1RyE5AW/NIpBufv9K0Qu4As7Fa/Vkmd5G0s7dV7eAhLiHE
	 AVxGVlJCbNlKx9EsOHF/tMBuV7cs+9KKf2TOYl+hs16mv6zekl6TKye8luqS06yp7tw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794719104;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=x63lXhctvrga7kXIUshxuHPY7+huUdEXvmJPy4eQdO8=;
	b=ZeWHoFtjRcl/zXWfZl4tQxOcE52SRNPS0CdeRnLgmqxb6BiMPs5ezwNtHLTtI++6qasq
	 Br8RF0BKgumDXgs8Ua2LsgKZcWQdV1uPtfl8dwryfOs2bYmYWnAwiczbpqgeDtwG+0pVn
	 z0QoHbBs6L5VqArzvd2olvfwiz2LdXDCGY/RR6X9ucJ2zxQ4HUsmGA4LggXD0BRc+9vwL
	 2pLmVND8UVvuyb6nMRnP8G2d7uWIgTG94eP40T4PuzMFuMa7G1HcWU0fLu+u03QGwiUZO
	 Acnf3txCFmjDh75eW3mOz0Z+A16SMvHHqR4UCg1FN4JAaqE0FZisf503p8F9/ToDy3w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cY9cXIBI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XKAyGewR;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794719104;
	bh=x63lXhctvrga7kXIUshxuHPY7+huUdEXvmJPy4eQdO8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z1Q8JrtBxWB0CfC8jxxwUJcIYk3pSoXd+pN4+NprdbyFjLRi0gI0yn3z3WjMDVP2A
	 qzqXKasw4hVh5JLKhplBzixlQOZTUVycU2nwbuk2+wbRZmUFMwNMV3S+o7zdYmHORk
	 Mph7QbIFzZ9Gf2Z2zA5W89ZQQtXLwVTzBSRFGtm4TQxlzpHX9KKJutfFQyQJoCPIGP
	 iTLmKIOQNahySttHJ4tKcyXQRURxEOxS+3YyfkJiByirA6QknzuhS+Hfg31kkBaKBv
	 J2HW5vZDDjFLr4uSlb0uNh9yXl2+UeTh4M5X7rWPeGP5psa84cecCZwsv5elad7cMd
	 E/nqXbB7c2pgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1AAAA81134;
	Sun, 15 Nov 2026 05:05:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5462F28C
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A4FB810FB
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:05:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pblldVU_HOdx for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 05:05:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DD60781134
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=cY9cXIBI; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=XKAyGewR
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD60781134
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:04:59 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF4RxsT1715573
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 x63lXhctvrga7kXIUshxuHPY7+huUdEXvmJPy4eQdO8=; b=cY9cXIBI11M3JDq3
 1Gs7fIkJuUjo2SwxDtDrj2LuzHvR//RBOGj7THHmcJLGFeFehHzdMcl6VJF3Pgp9
 f/FgReFW6Vo12LSyPrTg5iHn4PzUr4CXjs4kZhqz3XaQvJHz2kpy+RH+rt9BrfTh
 A1Pjx9FqeTcRN/BEZhZN2zlU1tRQdKlxM5ogiSfkGhx6QMpiQlCPo6oG6VQiloNd
 Pn/0ZnS5aJz0E+xJrMFy+EkxhFcFj34MvIrmAoutQG6pdHGTipa561lKCW1Uyc7q
 Zm5p/VkLgVwS/jbe84NV7Ea03LglTB6UM+RD9nwEtdMwRTrYx/frjOkbOM0iTMDf
 IGVjIw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhjte6f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:04:58 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-341eff9e381so3700729eec.1
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 21:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794719098; x=1795323898;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x63lXhctvrga7kXIUshxuHPY7+huUdEXvmJPy4eQdO8=;
 b=XKAyGewRfhj764oB6apQoe2kfZS3b2i13QOcwkjzkZ02ZuhP8tolcUha8pWp5QQgMw
 O4V1A38s1zHuf7FaAeeVVARtaaL5of5WSUZCveds2dYqPA6T+Dh6EJNNWHBF6EX+T1Hd
 HNReOaeVToYpyUe9kRk+ifXgqqjUrhC63TVydONl+35AhZG2td8rd25XOb6yWxzXw1Ds
 Zsa2VNe/PxTgIUvSYnxfh51JmEGteSh4UoVHU35HOTWedd0ZfUj2nCf9bG5ifjM/ir36
 6rsLTMuzBoKMXEN5tJlkCqbZndWzoY/y0K8i5Vto7NdPmJnfe7ojkpLUzNcGI2/lUvXn
 b3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794719098; x=1795323898;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x63lXhctvrga7kXIUshxuHPY7+huUdEXvmJPy4eQdO8=;
 b=NQS4HkJZDycWs1OLw7KKQTVeHPCxKJgwJ0YGOKlNR0r7U5+bmGPOSE6GzsbJFXRK1W
 1IPa/Gd+F0mEf1U0Chd/2fkJNpllVU+eR7d8sFFdiIfZKuAhrMskQ1Jgm2qsts55bCWp
 W2uJ2f9za+Eu91T7uZwuE9f5zWhQCt4x6kiceKQFXcXfYpc5OE12GtYHdPC/Yl5uPMal
 DDQAzO7xZ2BeiuLk71sQ6w3FK3dHJ2lLN90dGgBL0ccasQRDQXZIyaaBfn4Q8B2umRXh
 A/mKPwvhUAspdOUK4j4qI6yO/zKNeFdp+yNwQ7exXe5yP4tJ4ZBVb9itYQMEdrVURXIq
 W66w==
X-Gm-Message-State: APuU4Z/wJGzhwlXMyZZeLOGdAZiD7aXAs0Ry/t6Enw51WxYKK3iaqRf8
 J1VVXU//QRpOJMWYSxM7fJyY7sncEXd6BjJ9PGHKTJF8N12elhjlssBXlhuRLuToDJtn8BaG7Ex
 nYmn8rFMQvzTUWnVK3+9LhO1UglceSBx+UpY2vMLoxCkZuIm2qL+dZ+MzwJFAjZf3xnhCaje9x0
 Gi50s=
X-Gm-Gg: AYBFou1toucxARvU30dMOHxGFSg7d2fWXIwr8JIkiIfy4Yg7cMIwBVrDyrVgc1AhD+y
 nsUGEwF6cGY3NUpbeuyex3iLwMi5CTLu3g1tG6u6egqYo9GdfE1cZsEPV+YJ/A1ODXNgcUb2q6m
 0LEnLgmAn3F+pxr8lQNZOvLQceiP0dyqTQKupbuTwjy82IP3qMwnzxuUN0Ts3UpWNGt1GMDknp5
 mn3HAml3/08ZbRJ6tMx4aa0Ko3jtE/0Q64suCizutE7s23J1K6NhHwm212QACRDlnz48EhA6RZE
 90u0kNCF2b3Wfq2UfZrBdZsMKFl5TrLjIHIKXO3eVVLB/ukcBwR5se2pPUL4rQScofmS4UaHl94
 WpWV5arFsY7cnunPk5L6yDZM+bwtOYg9A6DDMr0UG/VchQQ+gVcyg1N63pWcD9sE+CZkXsF61UT
 Rp0kE56XfJ4kJjDcj6g+yUuvK4/lU2ygYcLIu99oo7IVkna+DWdLHVapexyzPqPyNN5Lx+20HWk
 RNz
X-Received: by 2002:a05:7300:f58d:b0:370:d7fe:6585 with SMTP id
 5a478bee46e88-37965ca807fmr7646396eec.11.1794719098213; 
 Sat, 14 Nov 2026 21:04:58 -0800 (PST)
X-Received: by 2002:a05:7300:f58d:b0:370:d7fe:6585 with SMTP id
 5a478bee46e88-37965ca807fmr7646371eec.11.1794719097620; 
 Sat, 14 Nov 2026 21:04:57 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379565d269asm23487034eec.23.2026.11.14.21.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 21:04:57 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 10:34:41 +0530
Subject: [PATCH v2 3/6] doc: Document capsule generation through a config file
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-mkeficapsule-v2-3-9fe141b2cc7c@oss.qualcomm.com>
References: <20261115-mkeficapsule-v2-0-9fe141b2cc7c@oss.qualcomm.com>
In-Reply-To: <20261115-mkeficapsule-v2-0-9fe141b2cc7c@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Peng Fan <peng.fan@nxp.com>, Daniel Golle <daniel@makrotopia.org>,
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794719081; l=7138;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=cu6LNstONlCLTb7CNDRDddDCYgaHXDUDfq9/krOnPr8=;
 b=PHYStoMLVzYTCyX466VjRxpfMkpXu9StRiEax1fUacro70Xi8SyRumcrQI/O94/msWELpMy0I
 ciotkoFq8q+DQqaaJBJs9urrpdsnn+chs+shtWKZXZCtakbj3Mj/dWQ
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDAxOSBTYWx0ZWRfX+5ZSgpRfziKF
 wuqh0IcepJA2C1gdyYj4jjzbz54udUwYHCO4Jv9MANd/RAHJP6aIXWBrylYIx4H2HQYds5bcxT4
 wUxOVayX15eZ98b+Zvu7y+E+zGsJbPfAS4oV7YV9BzRj0F2w3FdhzeaAhxRNH36lcB2AP70lMBd
 JXd8L2T0nHn1xaPT+mle13lxRnuIpaipVwcV5qVObCgivcejWJDD/9cR1XmIACrp/lK4xcjr8K/
 a9KOnMkT3s3UD5VF/WK/6Fxd5+M2DxbbdWhvawHODib9X6k5dskDENlWk9Je+uO9SvRuMJIU9LD
 itW3FCPOBcjx4cNZU6e9HByraIy/kP/Bo8CGyI0gW4Ja8zlBiplYS/htMOysjJe0zph+yJxbENl
 0DKIYpL/bVeOZO5/ooh8kYfq9r2gOIrbUJEWhjem9ahY4qSTqwUx/EqhV8qZE/vnHfBVJ3Vg5MA
 i/doDMRBhqUJDZeI32g==
X-Proofpoint-ORIG-GUID: gIRhUatS4A2YeIlzFpcaHsxdmeBxZ-4J
X-Proofpoint-GUID: gIRhUatS4A2YeIlzFpcaHsxdmeBxZ-4J
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDAxOSBTYWx0ZWRfXyK6I0+QD9PAX
 yfDoRCM50uVLehvJ80AzNFs+HwhCXFnXmpaHx4uJXwJM+kwx6XNllveHPPIyh4fq/yX1nsOvfoi
 TYcksIiPLkynvTB/IjOl7rcenPUz9pc=
X-Authority-Analysis: v=2.4 cv=X9rHu2Te c=1 sm=1 tr=0 ts=6af93d7a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=_J1Dt5jkBMFLDLoqcH8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150019
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

The UEFI capsule can now be generated by specifying the capsule
parameters through a config file. Highlight these changes in the
documentation.

Also document that payloads sharing the same capsule filename are
automatically grouped into a single multi-payload capsule, and that
payloads in such a group can be individually signed, with an example
config demonstrating both behaviours.

Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

---
Changes in v2:
- drop the paragraph on the EFI_CAPSULE_CFG_FILE Kconfig symbol, it is
  no longer part of this series' tool patches
- mention the --cfg-file long option, add it to the mkeficapsule man
  page and list the config file keys there
- split the example config into separate code blocks
- format the capsule parameter keys as a definition list and explain
  hardware-instance, monotonic-count, capsule-type and oemflags,
- state that mixing normal and accept/revert entries in one capsule
  is an error
---
 doc/develop/uefi/uefi.rst | 140 ++++++++++++++++++++++++++++++++++++++++++++++
 doc/mkeficapsule.1        |  55 ++++++++++++++++++
 2 files changed, 195 insertions(+)

diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
index 3ca22b572a9..c13069eda2d 100644
--- a/doc/develop/uefi/uefi.rst
+++ b/doc/develop/uefi/uefi.rst
@@ -318,6 +318,146 @@ Run the following command
       --guid <image GUID> \
       <capsule_file_name>
 
+Alternatively, the capsules can be generated through a config file, using
+the ``-f`` option or its long form ``--cfg-file``:
+
+.. code-block:: console
+
+    $ mkeficapsule --cfg-file </path/to/the/config/file>
+
+The config file describes the parameters that are used for generating
+one or more capsules. The parameters for a given capsule file are
+specified within curly braces, in the form of "key:value" pairs. All
+the parameters that are currently supported by the mkeficapsule tool
+can be specified through the config file.
+
+The following entries generate two normal capsules, the first one signed:
+
+.. code-block:: none
+
+	{
+	    image-guid: 02f4d760-cfd5-43bd-8e2d-a42acb33c660
+	    hardware-instance: 0
+	    monotonic-count: 1
+	    payload: u-boot.bin
+	    image-index: 1
+	    fw-version: 2
+	    private-key: /path/to/priv/key
+	    pub-key-cert: /path/to/pub/key
+	    capsule: u-boot.capsule
+	}
+	{
+	    image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
+	    hardware-instance: 0
+	    payload: u-boot.itb
+	    image-index: 2
+	    fw-version: 7
+	    oemflags: 0x8000
+	    capsule: fit.capsule
+	}
+
+An accept capsule is generated with the following entry:
+
+.. code-block:: none
+
+	{
+	    capsule-type: accept
+	    image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
+	    capsule: accept.capsule
+	}
+
+and a revert capsule, which takes no GUID, with this one:
+
+.. code-block:: none
+
+	{
+	    capsule-type: revert
+	    capsule: revert.capsule
+	}
+
+All the entries above can be put in a single config file, in which case
+all four capsules are generated by one invocation of mkeficapsule.
+
+The following keys specify the capsule parameters:
+
+image-guid
+    Image GUID
+
+image-index
+    Image index value
+
+fw-version
+    Image version
+
+private-key
+    Path to the private key file used for capsule signing
+
+pub-key-cert
+    Path to the public key crt file used for capsule signing
+
+payload
+    Path to the capsule payload file
+
+capsule
+    Path to the output capsule file that is generated
+
+hardware-instance
+    Hardware instance value, used to tell apart multiple devices that
+    share the same image GUID
+
+monotonic-count
+    Monotonic count value, which has to be increased with every signed
+    capsule generated for an image
+
+capsule-type
+    Specifies the capsule type: ``normal`` (the default), ``accept`` or
+    ``revert``
+
+oemflags
+    16bit OEM flags value, populated in the capsule header
+
+Generating multi-payload capsules
+**********************************
+
+Payloads that specify the same ``capsule:`` filename in the config file
+are automatically grouped together and bundled into a single multi-payload
+capsule, instead of each producing its own separate capsule file. All the
+payloads in such a group must use ``capsule-type: normal`` (the default);
+if a group mixes normal payloads with accept or revert capsules, the tool
+exits with an error.
+
+Payloads in a group may individually specify ``private-key``,
+``pub-key-cert`` and ``monotonic-count`` to be signed. Each payload is
+signed independently, so a single multi-payload capsule can contain a mix
+of signed and unsigned payloads.
+
+The following example config groups two payloads into a single
+``update.capsule``, with the first payload signed and the second left
+unsigned:
+
+.. code-block:: none
+
+	{
+	    image-guid: 02f4d760-cfd5-43bd-8e2d-a42acb33c660
+	    hardware-instance: 0
+	    monotonic-count: 1
+	    private-key: /path/to/priv/key
+	    pub-key-cert: /path/to/pub/key
+	    payload: u-boot.bin
+	    image-index: 1
+	    capsule: update.capsule
+	}
+	{
+	    image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
+	    hardware-instance: 0
+	    payload: u-boot.itb
+	    image-index: 2
+	    capsule: update.capsule
+	}
+
+This generates a single ``update.capsule`` file containing both payloads.
+
+
 Capsule with firmware version
 *****************************
 
diff --git a/doc/mkeficapsule.1 b/doc/mkeficapsule.1
index ed296730eeb..fe2345bdc54 100644
--- a/doc/mkeficapsule.1
+++ b/doc/mkeficapsule.1
@@ -124,6 +124,61 @@ at every firmware update.
 .B "-d\fR,\fB --dump-sig"
 Dump signature data into <capsule-file-name>.p7 file
 
+.TP
+.BI "-f\fR,\fB --cfg-file " config-file
+Generate one or more capsules from the parameters given in a config file
+instead of the command line. Payloads that name the same output capsule
+file are bundled into a single multi-payload capsule. The format of the
+config file is described in doc/develop/uefi/uefi.rst.
+
+.SH "CONFIG FILE"
+The config file given with
+.B --cfg-file
+holds one entry per payload, enclosed in curly braces, with
+.IR key ": " value
+pairs. The following keys are supported:
+
+.TP
+.B image-guid
+Image GUID
+
+.TP
+.B image-index
+Image index value
+
+.TP
+.B hardware-instance
+Hardware instance value
+
+.TP
+.B fw-version
+Firmware version
+
+.TP
+.B payload
+Path to the payload file
+
+.TP
+.B capsule
+Path to the output capsule file. Entries naming the same file are
+bundled into one multi-payload capsule.
+
+.TP
+.B private-key
+.TQ
+.B pub-key-cert
+.TQ
+.B monotonic-count
+Private key, certificate and monotonic count used for signing the payload
+
+.TP
+.B capsule-type
+.IR normal " (default), " accept " or " revert
+
+.TP
+.B oemflags
+16bit OEM flags value, populated in the capsule header
+
 .SH "GUIDGEN OPTIONS"
 
 .TP

-- 
2.34.1

