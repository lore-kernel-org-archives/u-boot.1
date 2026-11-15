Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5017606A889
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ua1jjcKE;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LVrYoxh1;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fH0wNfoA
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A329C6063E;
	Sun, 15 Nov 2026 11:05:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gaa3D82CvmBA; Sun, 15 Nov 2026 11:05:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DC5116071D
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794740757;
	b=adg4UVza/MgiSeSwbarjBU7SalEFHtBYEb8lG7qbVGAnYfxOZyepvDNWauZPvIVPvlyN
	 rOjMsVXr71Hg1yl+gdlwMGxUk4d3POlIEBQ6+jGGsoHuIA6y7T2P2V59ayuGgG45xqs7u
	 dQy0exDwmn9/u1pXOcFbkNFSE+Mvj7VxURRDUFY0bx2tRhC17b281Z78lySrkOcD4TxZk
	 h4hSI44cCJ7xN4rJEHucCfWUYOuUAu3Nvv4E1L6FJixk5CSVQLzwwZYAfJHjfuRWQNPWY
	 m3R85NxlESA0TfK0lJOudGQOFG8Zr/hV/f24TeTXGqe44cRsopQc7wk2VxmYhWaXJSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794740757;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=RsivGCg10uVUOGDnyuHv8pCiguAKlyBwqXOCQL2Yai0=;
	b=MwmM4KFDQGfCgMuRaedYTieANO6QcbG8+sI7dLj8uNT1pP1RcPOWZjWviSGUZwWCBn+Z
	 QmQ0p4FPHlgsk6SKi9S5xGGPhcXMTWTpQjZmLc+OrY2eAILgyLK0YWs9pPuSyAzWVkAxv
	 kdC+DLXgEkIGfX0rSuao+qiOpfLTjnZfTgeLSHIydpBCgdx6SctmFtgV6NiRtQZCxKLF6
	 9zSNfyNSFy3FzetzlG9vrTH3QiALyxtOuW0Y9cKxLhgiraz/LdPtAVAHHDRDSGyZ5Ghw6
	 rEsMy2WkIA+jjGWMOV3iaXdoUII/W0H5+FokPedIECPSU3HP2LzGCyLrBDdoAj0tuIQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794740757;
	bh=RsivGCg10uVUOGDnyuHv8pCiguAKlyBwqXOCQL2Yai0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ua1jjcKE/vUapax2NcSEws1gmXlRSVKjjCsKAo3FzDgUao8iQ3LEX+c7XkR5+ccGb
	 Wf+kJoTgZWAtd8BEZ0WeRpdycs47Tvin8DfuX5ZDwT1dEevqbnQvP1VZeZwrBvRC3+
	 C6IbHRi125I7zB/o/GQMwhu1+iBue5E+RVd4pKNZ4ISaI2AdwRkAsE+nOQP1TjQVxF
	 E/4RxLgDdlQSDMlTP9Y2oBbYsWquDHoSG2A2aRfH4HWPvaC8ieUNPEtepoUF65xr4r
	 I0B9yv/lTMeZIx82NuJya1/8bjFsnG6pD1VsmAhsNhq3O7f5wWzyWNePUAMJK6kddv
	 vWO1jWxQjjV3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DC5116071D;
	Sun, 15 Nov 2026 11:05:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A5A8572D
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 886F680FF4
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zbVTeJ2Khe4J for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 11:05:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B3CE580FF2
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=LVrYoxh1; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=fH0wNfoA
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B3CE580FF2
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:54 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF80KX02866906
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RsivGCg10uVUOGDnyuHv8pCiguAKlyBwqXOCQL2Yai0=; b=LVrYoxh1r080ppbA
 UMaCjzeYGa3ToYjSExCtqXAbuU8kkTBs9X/YZGbwVR0Tz9zjZTKrR5gHo3ikB+F+
 WqwTFKkaHmLYRpkAIyTF/PsuWflaLMNLBAacJuguOvMzSOwW8pVNtLgy+V5vDk9s
 SUjF+IEa0x2Y6H67ptcOnh4EXpQR9jkFVy6uT1zeYlK6LDIsNNo73YADQJcDh2wm
 P5QBCYsIZ0bO5mNLL4+dFmDBHDcFQdcSmaaV8020dpHHZgZZ9/P2HowqtkO/edCS
 sxqm66paUTsGnY7NarmQO+QcoDAjIN1VE5HG+R7547W+AqVmHG8OgtTfvage+R7B
 m5urhA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmajs1q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:05:53 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36fa5673fccso6724927eec.1
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 03:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794740752; x=1795345552;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RsivGCg10uVUOGDnyuHv8pCiguAKlyBwqXOCQL2Yai0=;
 b=fH0wNfoAWpoNEfMygatsfrvoBdkQS+sQT2syFU1ifJLuXYsVnf/X3VJYFmLDHtVMTy
 7pIM5X/f1tixGCqmaCCppiDz2A0EVL3FnQbpBZd/PP22CQJJkM4apXgaCm12AMKDps3P
 JdhbBeqg3W03BymUrTlGMM2tboJno1rRQ/E/sKabINwaq5KZSXcHoOZvub9J5tRgF7dj
 2vE3G3HWLyBmlQVsuF4yZPKXQdJzrKzZlPPUmK9i7AQUKwD0XzVf1tN6D7/KIedjgQ8l
 ub3Yy4mjMMtESuRpld0A/ijnJJNmWOISKd5jSb/Lzt4uOBrC2n0xERH4y2xdb5+mrv8k
 +W0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794740752; x=1795345552;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RsivGCg10uVUOGDnyuHv8pCiguAKlyBwqXOCQL2Yai0=;
 b=RJVLx++2u5R5YDzgkr7IyyLQ1u/xc8GcbjVt4amnO0DA5iDs6t+Pr0KOKHuIqfwVLB
 plQs347/hXyM4zdRy00aZqmzH8EVWq7WK3xJoKsm3K59VyGP4Iw5PMcui7V3o26ANjkx
 rXcPWin8t/Hk9s6lU9099MA1gGvgSdJzpH5g6GcIoD6BDOuHkV/flAz8gaGy0fU2uJ7r
 kUMXgD6ncy2UZOVIh+D87PcB/yPKWLxsYPyg+pUYvd6XsVVhzATX0vHPE55JhQcaJ5WX
 1SIXp2CNtDRJrMehkiauE+hn9QsKV1sD5NITBnuNm9ylFW+6sulnmopx7DdaMx3iGj4o
 HhsQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHfVD6ObYfl4AvO7+mTJvz8o3FVdDkbHUO9ZTqz6MRE7oEsi3XizivOpeGCS0bgLa+IGEdPE/k=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z984MfR7qTA130RSLrFejTmE0tJpJKVeISGXA2CrtCobm0U0obv
 UyFpCBwdoYdNutpEAG+uhBKMCfZrAPFvIEaLpO3LRny4hiWcMjmd6ICqIhZekKXJ4O73d8M5Dgj
 lUKA07YleVtxsEEyKBj1KeopbBc99Pv5HRYICNyEebwtc27EKTXqrhUD7rwMRVeKsZEoiype5/9
 3x7sk=
X-Gm-Gg: AYBFou1nPPaymzUNlJVWuDd2W+ICiCifXCx95gWH/cgQ7tnTbFNbFOpI6qJrHBw/Aoz
 wnb68Wr8ai1kF9h4Yw13vnTJSp0FHyV9Js7Bz6X8ZQiW80Difiq8DyoXMLh2jUd4ZQjGCfUnNVM
 Jy+5Kfe8INR7+q8aUyBR/G/mGf2rtsEioenaGnHCCm/GM/xv3x9ZPVyvO9s6wwr+Frunn6oAfD6
 Y1SEum9PFdLNfnrZ19c0hqbxRiXKrUtRVgMbSqt4RP6R4tMxW6Z5NtUIuaW2O82yODBakSxAtsb
 J9kUnQ5U0lhK5mChCR3IcY/9USW1mPtu9z1u4rcBgn44JpNdS5e5g/RUHwog5j0EfWFblpp7Z7k
 P6Oif1QN8tRA6AQ1u+8Om4AT+KSw9N/NwKs9yz0empTtLouEiJLupaovSvIn8OHFSSgv5fhOoDx
 OkHqnQdOK2+45Zqlbn1PhUXN8Tpva6hO+tbfIYGVGQUa2riAq7gol8iTMtl6DVJ7B6mYttIx8ck
 TvF
X-Received: by 2002:a05:693c:4099:b0:36e:8e6d:a0c0 with SMTP id
 5a478bee46e88-37966a5a930mr8779187eec.19.1794740752224; 
 Sun, 15 Nov 2026 03:05:52 -0800 (PST)
X-Received: by 2002:a05:693c:4099:b0:36e:8e6d:a0c0 with SMTP id
 5a478bee46e88-37966a5a930mr8779167eec.19.1794740751622; 
 Sun, 15 Nov 2026 03:05:51 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379563e6b6dsm43456454eec.21.2026.11.15.03.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 03:05:51 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 16:35:13 +0530
Subject: [PATCH v3 6/6] doc: fastboot: Document block device selection syntax
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-fb_gpt-v3-6-7ddd7ef832f6@oss.qualcomm.com>
References: <20261115-fb_gpt-v3-0-7ddd7ef832f6@oss.qualcomm.com>
In-Reply-To: <20261115-fb_gpt-v3-0-7ddd7ef832f6@oss.qualcomm.com>
To: Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 u-boot@lists.u-boot-project.org,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>,
 Dmitrii Merkurev <dimorinny@google.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Julien Masson <jmasson@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>,
 Simon Glass <sjg@chromium.org>, Sam Day <me@samcday.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Francois Berder <fberder@outlook.fr>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794740710; l=2894;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=3f2BvSoExQgbHcRApCEYf/RUX/Rg3O4lv62uCBi7p/U=;
 b=3iOtVAIId5K8ch24o1wyjSLOtYCv5sMEfCh6Q7eRluQPjUBTl+I1HD0itdMq7l78jCRcNu2TA
 tHUtFo88XqpBRUEFndGt4g/A9S637qB4kCg2tJ8JvwfsJx2krFN8hMV
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Proofpoint-ORIG-GUID: QAYTg90RqfaPL3ZMIPy5xS4yd_-Kj7QV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDA0NCBTYWx0ZWRfX+4GpM//XpQS8
 7MDYnJwQOR8wE0p6DC94WDlBKs28uQcSws+lXqPMuvoyyRQxMtjZcb31KUdn7ZwF5fPZzPvIodl
 KdCEpuZcf4l+YNUD5uEkzjyDn/sn8q5KEAuxU6OsMJG+OOWIiqyscWe8HXoxndcQz986aygS4i/
 AYYSwJmjBownfAj808nKl6cbZeKv2wyC4ydO65YApyERM8UDmnDxq7XJiuHtJlVr66uXFXATSgf
 AxQlBsRFK0jtOrQBuLe7aC0vhF1p1thTkAxMINUUDj40J6zqoHtgoBLQIkOvsj6rAHuk7H/6JSQ
 9MXL6nJ3oA8I8dfW2PDGePL4TYhLpkiC5ARMspXL5g1aaPxlhB8jKoHKezeIyqhdmdmerJNF1Wa
 sgJM6r0YQWs9y5w5FDPp9jq8+ve0jdEi5pLcQdNuQwU4sQegOl9OlfTKb/92vZ9lg55vWx2/jrX
 yLf7xzTkuuYD5hoMI3Q==
X-Authority-Analysis: v=2.4 cv=NdhzRGD4 c=1 sm=1 tr=0 ts=6af99211 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=XVKabJoNFbJzCh_DuM4A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: QAYTg90RqfaPL3ZMIPy5xS4yd_-Kj7QV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDA0NCBTYWx0ZWRfX+6Pwd+ig8wvr
 gQUcjMMcpBxxoZCqd3olJnzU2iHMatfMKV0gtQFSjSpGn98x3AwGPS2Huzrp0FZzwM9gm/IVv+J
 1xiy9OAnBZveghqxEgkWe1vEz6Otoew=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611150044
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

Document how the block backend selects a device: a partition name is
looked up on CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID first, then parsed
as "<dev>#<partname>" or "<dev>:<partnum>". Add examples for flash and
erase, and note that "<dev>#gpt" and "<dev>#mbr" select the device for
partition table updates.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v3:
- Document "<dev>#<partname>" and "<dev>:<partnum>" instead of
  "<dev>:<partname>"
- Use sentence case for the new headings
- Cut the duplicated GPT/MBR text down to one "1#gpt" example
- Mention erase and the partition-size variable, which use the same
  lookup
- Drop Mattijs's Reviewed-by since the documented syntax changed

Changes in v2:
- No changes
---
 doc/android/fastboot.rst | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/doc/android/fastboot.rst b/doc/android/fastboot.rst
index 8e15f287f9b..404ebfe5f54 100644
--- a/doc/android/fastboot.rst
+++ b/doc/android/fastboot.rst
@@ -195,6 +195,33 @@ The Fastboot implementation in U-Boot allows to write images into disk
 partitions. Target partitions are referred on the host computer by
 their names.
 
+Device selection for block devices
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+When using ``FASTBOOT_FLASH_BLOCK``, a partition is first looked up by name on
+the device set by ``CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID``. If it is not found
+there, the name is parsed in the same way as by other U-Boot disk commands::
+
+    <dev>#<partition name>      # partition selected by name
+    <dev>:<partition number>    # partition selected by number
+
+``<dev>`` is the device number on the interface set by
+``CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME``. It is parsed as hexadecimal, as
+in other disk commands, so ``10`` is device 16. It can be followed by
+``.<hwpart>`` to select a hardware partition, e.g. an eMMC boot partition.
+
+Examples::
+
+    fastboot flash boot boot.img          # partition "boot" on the default device
+    fastboot flash 1#boot boot.img        # partition "boot" on device 1
+    fastboot erase 1:3                    # partition 3 on device 1
+
+The same syntax applies to ``flash``, ``erase`` and the ``partition-size``
+variable.
+
+Partition name formats
+^^^^^^^^^^^^^^^^^^^^^^
+
 For GPT/EFI the respective partition name is used.
 
 For MBR the partitions are referred by generic names according to the
@@ -234,6 +261,11 @@ configuration options:
    CONFIG_FASTBOOT_GPT_NAME
    CONFIG_FASTBOOT_MBR_NAME
 
+When using ``FASTBOOT_FLASH_BLOCK``, the table can be written to a device other
+than the default by prefixing it with ``<dev>#``, e.g.
+``fastboot flash 1#gpt gpt.img``. ``<dev>`` is the same as in
+`Device selection for block devices`_.
+
 In Action
 ---------
 

-- 
2.34.1

