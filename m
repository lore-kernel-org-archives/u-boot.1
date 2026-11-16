Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED178606A78E
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=R7sOKTal;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=awaB4Fed;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V/piC7xu
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BF97D605F7;
	Mon, 16 Nov 2026 11:30:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x7g4Ymh9EHpT; Mon, 16 Nov 2026 11:30:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 108976067D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794828640;
	b=iau3pvKKixuVT1HNKRSB7MOs9VHOG5VuN/jiqBXCo0pxuishtQcl/xNxmk+bPPfQ/20j
	 XgCNBxUxoEu1KQmcbuf22dcLTv6CSg6vJQdeqIOi+6ur6iQNXqT7RdMVadtt6jRxYXxaI
	 vrvVTo1Wy6BUy2wADHkqk2LW+9b4IeksHmpjlmDG723XJ9aqWDJc5PJ1WOwIHHPvvgx4v
	 mmPHP7XwJJBYPBIIrT9pLektbhkwA57fFZ/3HgCxcoMAVc1TjuTFvm0oAQAAv/3KcIe5O
	 K7VwlY3qjUAoDTfX3QLuhIdCkxgQ0OAyar+dA1J0k01pPZXlAsdjri5usGAOGtAGu/Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794828640;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0zoM17J2HrC6nUpXgJi5ED1Vs8k4PFKeDM9GaqIX2fE=;
	b=X750MRoDKlElQJpkb0aYVxP+AptF99H1wpbXjz5JxCwsxZATbSTmvTopTWyiudiqNJ+a
	 hKyyInP+tV9zFw+XCCYDL95mS0Uqv/yp1QrbUXPOFkAkpSF7zwiduiek7yna6b76SEiNY
	 dCuEC3XnAbwqPag+tTn4LGgsoTniP1usGyx+PmQzvdkE7adadBk/MIffq21dFe/yTNKxW
	 PA2Lo5B5+Uk/QVW5js/AIjBeTT15gCRUXf3bBxfu5wnXy0W3wHhlra54effuh0TYkoH2J
	 GRJGB9RDG1edxNpRvLimilDonx+OJpm2Zi/EV/JWoSRtZWE6Aj7ENktIbx4/jwCwSeA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794828640;
	bh=0zoM17J2HrC6nUpXgJi5ED1Vs8k4PFKeDM9GaqIX2fE=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=R7sOKTalmb5Gk2t91Ukmco4kRqDMd+bYeyCyNRj6yY028SudT1QQqpOTvJgGtnmjJ
	 GEwGkqpc0D51QrPkiI1sSvi7+Heu5XeTya0ELLPhOaYKRw5S6PjvWFZm8VRJ/CzDH0
	 jQcXpW+obQbIjNYtFX3olCZYA9kggcyza0FAwtOGFQUdEoSx8xttXv2XKF8LJrQ7n0
	 naNxoD0JLK/HNNo27rMbJWYY9CE4nCJ2C6j7IeQvwc7NnaW6mFTjVneH2mSyWJ/mgv
	 qGFGjruo9pOKnrojzWMTeVqYNawt0Zm2MEqDiGMd53TB633vbeIjHs7rzWi89CamrK
	 n+uXb+Jlcv5QA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 108976067D;
	Mon, 16 Nov 2026 11:30:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C9971A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:30:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 628EB405ED
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:30:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A3ouROXP4fLD for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 11:30:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BAD32405E5
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=awaB4Fed; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=V/piC7xu
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BAD32405E5
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:30:35 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGBLEQL449950
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=0zoM17J2HrC6nUpXgJi5ED
 1Vs8k4PFKeDM9GaqIX2fE=; b=awaB4Fed+lNTTXJ5Eq3KEOR3VXiZNVzoMsq7Yp
 JUsQPZ0AQwf6wnIxT6LRZFCyhdIyXq7xhrKtoZW35J3+VL/7AregUXLHKwHvYHKK
 O1nJvsR298vc8JVJH1eKungnKKTpYbMyJHKaGRqX9jthHQLyENf5Zw3RwpRU5Eyf
 twzX6LVrQvmOprPO0dBJ33XuCVxE3/PIHe9F+JRJ5DWWNh4pIjow43bVj1bgiP/D
 LUiL8C/pKjL5K8FAxyZYALzEWh+5Gocovm/xwTnxBA1mYkjzI5q8BuDWh13WvHPH
 exN2l76uDk7Z94TAnSbDMhQfxQlUdtb1bNfZR8RrR13Fbwaw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqgg9v3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:30:34 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0d568830so4335734eec.1
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 03:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794828634; x=1795433434;
 darn=lists.u-boot-project.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0zoM17J2HrC6nUpXgJi5ED1Vs8k4PFKeDM9GaqIX2fE=;
 b=V/piC7xuqZLjiUvBY/d7zlAa3yA84zSd0qROO0ru0gELjjmWtfKbMFxWGhYIRK2DLO
 SrKMteAnSyASJ64fpsE17A2xYokIFP3vtjS1/nrzgzdTtsF9+QJJo+58pqpdtm8gCtLu
 NbwrRv5Qs7jMuecmJOwQdOQ86m6v9EAfV8JfZh64WLUVNw+CoZ0nz3JLS/otL/f8nGj/
 h/+eRs88s2N2AWGLSmdoffU5uHEdUBAB3OYi2euE4m9ZeIl9UO4Njz++WTACdsXW5wa6
 fcYDFSCO7Cbg087VyEqP96Hf0rgrUR4iswqRpVe8xA4YprmiB/dKVBBqBkRGeCFpdy7k
 hI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794828634; x=1795433434;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0zoM17J2HrC6nUpXgJi5ED1Vs8k4PFKeDM9GaqIX2fE=;
 b=d/9g7ko605PGhAgcmvPlllqmKKnpaOmAaxf0j9ed7plz/ksh9O65PKF3quYWxSy6Un
 9QBHrWhUKdd88JxV5NMMqO5rgfp7z/b1OrRlhAncjcr+PzjqjbEGZvGlutQh9OdI90Bd
 zwS0IJKE7HO8gQJptN8ZvNF0ZdzANhGhf4Z0fXErdRXTCQ3USD+298fKB2O4AgfJAiLG
 Pr2dmGgc+wPizs3Y5GjQRMqdHb49RdtVYloMLcoBpntF1hc5+hvqGp6rHBXjbxYIpiaU
 n75tZZXnMF2aSTJM6m6J3Zme5mIB6u4sXh2m7vfFvN4KB3jn0XMxxHNCKgW1kI2bnc2z
 cptg==
X-Forwarded-Encrypted: i=1;
 AL+hErEuZNQ9ZQ2dgsF7XES5VcjI3QhBCYQprFZQpK4zMaXJWUlqs8vFDn8ghsTmsGWiTD1YkJBGBqo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9oWoSxTvlgpdGcltKBkKlsYLKZ4bNQzCEnr9x/7XzmhOdBaMnK
 WAwfIk7Vj9/ZgI+QopIVpJCO2G2sutW09ZTLOsZW5x+EZopyv4hsPhf3uJLF6yKJ6cX1eFHyDnO
 XyQnJckg5wkNy+LpWjQuF0Qis8QE3MEWIbnb83Oi053MvJ2EQDtftIp53d72HY/Or+Bb4Uq8=
X-Gm-Gg: AZFdTZeqFKXFMEkn97SQFni9UejrIA+MjqwEb5tVjlWrN4AiuHQ7nnX5Qahm8/qm+LK
 yGzXQxwRUTQrG8dEbl39ffG1R1fl5UpeFcHMfGj4y3XIFdDGzNFg240C3dBAw+hJAnKjyE/VzP9
 +smwrTzGEZphycVv17YuqqaA85CRjXiVSVK7JZpQl1HG2ZJsWHPT9HuFtApUOoOh/RCVU2v91lr
 HvmrczaeI11cj0q55PplPRQOCqK/wOhqqGPiKLOu7Rh8PvAvjuw9qBhSz1l3wbhz0MtzlgAVIUW
 8w5cQGnxnbjsHPZ0Kg6VmcKLlAH0aXzUAKW6YtTlJLPV9G/Z419eqs63aVz4BA4ak6wwgEbLnxQ
 gZcyQcM8/1TqQ/t5tIT7bNGUSOsXE0ezgElWaI+QeMliMsnIGLP/PA7gCxDPvXu3vgp1RssV65o
 xfQh9aejyWt2OPGVT9lH5fSu3pmLaIdiBMTiciq2EyGYVD0t7/yyVzHjeE76Wy9gmgtdgiWqUlo
 aX8GQ==
X-Received: by 2002:a05:7300:de01:b0:36c:a154:db1d with SMTP id
 5a478bee46e88-37963373955mr9392612eec.4.1794828633888; 
 Mon, 16 Nov 2026 03:30:33 -0800 (PST)
X-Received: by 2002:a05:7300:de01:b0:36c:a154:db1d with SMTP id
 5a478bee46e88-37963373955mr9392582eec.4.1794828633081; 
 Mon, 16 Nov 2026 03:30:33 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bb0c40sm35901572eec.28.2026.11.16.03.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:30:32 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 17:00:27 +0530
Subject: [PATCH] clk: qcom: sa8775p: add USB2 clocks and GDSC
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-sa8775p-usb2-clocks-v1-1-36e28f6d47d8@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFLp+moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Mz3eJEC3Nz0wLd0uIkI93knPzk7GLdRLNECzMTU8NUc8tEJaDOgqL
 UtMwKsKnRsbW1AApVVJ1lAAAA
X-Change-ID: 20261116-sa8775p-usb2-clocks-a6a86451e79a
To: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Cc: Lukasz Majewski <lukma@nabladev.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tom Rini <trini@konsulko.com>, Royyan Zahir <royzah@gmail.com>,
 Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794828629; l=2999;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=yIPXC6JqCq4PhDmVxO84xzQP1iXc8I01vCbmaVq8dak=;
 b=xJENgYHe49KdHfKckbY4tthU/H8IcS4ctZtPKL5nM/N46aRQbPqIg81LviRZWVobmvOG1gEuz
 +xcJSPxAX8pClc5l1kPhUeFIJAYxbJq59qwm6Y7U649nmcqI7T/aiwH
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0NSBTYWx0ZWRfX9Zwsm0uxPGpf
 YSNeSHno7ZbU7G/uAC2GfrUdQEFO5ucCgsSSMlh1dC/qOdTuQ6BbbCGqiKxk2h34fzBSZg8VfEe
 5BTEHoHu9Og3UEoOK4aZ9Hq6Xzr23hw=
X-Authority-Analysis: v=2.4 cv=epRKXYpX c=1 sm=1 tr=0 ts=6afae95a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=G69vJWVQgfdsJlPrj7sA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: AUbZgQKuz8GI8Tro9ajxq2ctluA_7GAW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0NSBTYWx0ZWRfX2zR5wZ0cTkuq
 z4XNWTrzcfDLXulxtL9bTR5X3bI6OhXTLTsvyKXUB8jAwbEx1F5o0i6kmCCuBY+Gy38xO4ShmHu
 bG6jwaA9QuVr67wYLRCLdCXOTAWLVFs8ofgzuClOB/tWZXYLVWWT1SQFewSKRk54YW3P98tJLVe
 A6eTFy6rWI3K2WyQQGroP/EobFsko6daltDpfL+nHx7bG9PL6Cq67qbh5j+362VmO78bXHcteFB
 queUkcm3SaALdChIWAnRiGSjD2cYRRGtiGSWvXhM78TZVYVY5la3+j8rwTyntf/LAzVZ684zqns
 OtWSW2I3icmJ1NDMLMU+P/6lRO4unKNVX7NDpOLN7Fd5turt3CwR5YKwYjAKxrX/0NvjXZEQOZV
 tMa4r87RbyXCLTfGuJHp6tgMzVPWSKSGuZs1VqphmSI+J3eaNLWbfKD2RqzuEUmfqDs0da4yNGt
 tF5wRfoUBqQTaIh/FTQ==
X-Proofpoint-GUID: AUbZgQKuz8GI8Tro9ajxq2ctluA_7GAW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160045
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

Add the GCC clocks and power domain needed to bring up the USB2 (HS
only) controller.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
 drivers/clk/qcom/clock-sa8775p.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
index fa341d05f69..322bb3059b0 100644
--- a/drivers/clk/qcom/clock-sa8775p.c
+++ b/drivers/clk/qcom/clock-sa8775p.c
@@ -17,6 +17,8 @@
 
 #define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR	0x1b040
 #define USB30_PRIM_MASTER_CLK_CMD_RCGR		0x1b028
+#define USB20_MOCK_UTMI_CLK_CMD_RCGR		0x1c040
+#define USB20_MASTER_CLK_CMD_RCGR		0x1c028
 #define USB3_PRIM_PHY_AUX_CMD_RCGR		0x1b06c
 
 #define UFS_PHY_AXI_CLK_CMD_RCGR		0x8302c
@@ -121,6 +123,15 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
 				     5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
 		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
 		return rate;
+	case GCC_USB20_MOCK_UTMI_CLK:
+		WARN(rate != 19200000, "Unexpected rate for USB20_MOCK_UTMI_CLK: %lu\n", rate);
+		clk_rcg_set_rate(priv->base, USB20_MOCK_UTMI_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
+		return rate;
+	case GCC_USB20_MASTER_CLK:
+		WARN(rate != 120000000, "Unexpected rate for USB20_MASTER_CLK: %lu\n", rate);
+		clk_rcg_set_rate_mnd(priv->base, USB20_MASTER_CLK_CMD_RCGR,
+				     9, 0, 0, CFG_CLK_SRC_GPLL0, 8);
+		return 120000000;
 
 	case GCC_UFS_PHY_AXI_CLK:
 		freq = qcom_find_freq(ftbl_gcc_ufs_phy_axi_clk_src, rate);
@@ -159,6 +170,11 @@ static const struct gate_clk sa8775p_clks[] = {
 	GATE_CLK_POLLED(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x1b084, BIT(0), 0x1b084),
 	GATE_CLK_POLLED(GCC_USB30_PRIM_SLEEP_CLK, 0x1b020, BIT(0), 0x1b020),
 	GATE_CLK_POLLED(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x1b024, BIT(0), 0x1b024),
+	GATE_CLK_POLLED(GCC_CFG_NOC_USB2_PRIM_AXI_CLK, 0x1c060, BIT(0), 0x1c060),
+	GATE_CLK_POLLED(GCC_USB20_MASTER_CLK, 0x1c018, BIT(0), 0x1c018),
+	GATE_CLK_POLLED(GCC_AGGRE_USB2_PRIM_AXI_CLK, 0x1c05c, BIT(0), 0x1c05c),
+	GATE_CLK_POLLED(GCC_USB20_SLEEP_CLK, 0x1c020, BIT(0), 0x1c020),
+	GATE_CLK_POLLED(GCC_USB20_MOCK_UTMI_CLK, 0x1c024, BIT(0), 0x1c024),
 	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_AUX_CLK, 0x1b05c, BIT(0), 0x1b05c),
 	GATE_CLK_POLLED(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x1b060, BIT(0), 0x1b060),
 	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x1b064, BIT(0)),
@@ -284,6 +300,7 @@ static const struct qcom_reset_map sa8775p_gcc_resets[] = {
 
 static const struct qcom_power_map sa8775p_gdscs[] = {
 	[UFS_PHY_GDSC] = { .reg = 0x83004, .flags = RETAIN_FF_ENABLE | POLL_CFG_GDSCR },
+	[USB20_PRIM_GDSC] = { .reg = 0x1c004, .flags = RETAIN_FF_ENABLE | POLL_CFG_GDSCR },
 	[USB30_PRIM_GDSC] = { .reg = 0x1B004, .flags = RETAIN_FF_ENABLE | POLL_CFG_GDSCR },
 };
 

---
base-commit: 6487c50b8a40f2668ab98a892b9300ad5c181f38
change-id: 20261116-sa8775p-usb2-clocks-a6a86451e79a

Best regards,
-- 
Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

