Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB167606A323
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 05:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eudiWUw1;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NHLyuHN5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VgAi91pE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BF3E606D5;
	Sun, 15 Nov 2026 05:05:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UxxhqTYQ2FKV; Sun, 15 Nov 2026 05:05:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 96AB4606C0
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794719100;
	b=Fs1b342NlJBAUEQNVGV7mZyE+8/cyrtdd4taLJTY++/gjhGZXw5PHJjubgHLNIdmzRBd
	 r168avKMngenq7ek+cmvbfLoEz5AaHUc2H5qSJVQuiM8rFLdrndiie7guLBjS5ylnU5rn
	 3hj/T2u4jC0vSY2kiA2/0SSy4cG8QC3OcIrl9f/TPVnnU1CVQkHXHByydaJ94AXVSnDzg
	 7m0xVB+3muYGwFsx2Ii9Q+ArboLesUOe8VQBe5whCaXVGQyPlPJZ+jAh8PLqeQOYEkT7z
	 pTRqdwAn9BXqI1TtzeDifFoBUeH5SzI0KSwGirHLjgdzywc5aHf8sQKbltntDaIt5Ww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794719100;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=L6J+fn6yV/FUjf2O6QUHDllL+cA6B0QNETmP6TRxpYA=;
	b=bZ1c9Uvkv8WHoVGbK9F9Q0M6a3qcpTQXn31PPcyODAKnawkQYzm1zKqvDVteXxF6jvOS
	 NmeSprcO/hJg1wQ3qwzx1aMWa5HXQO1Ws6E1RFlE7Ma63F70w78i6ETPwvyUVNVgTjoOG
	 WMb9PzLrwQmSYn9/XCVfsjL7UGpWkphmmiPn7b1jiENpCjpjD9o64qN6NKbYnz+Mdud88
	 S5X1WVTqLUhxG+p8wNlx3YDJiUJexulwyZBFRWhe3Enn/1+V0eiXwf983KywiB+xslJmJ
	 tl5CFCSskdSTJSOEchjLPQz7UdaR8+s7a/3PpvVOgkCE0vxUaSOJl7vj9I90iXy+Xgg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NHLyuHN5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VgAi91pE;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794719100;
	bh=L6J+fn6yV/FUjf2O6QUHDllL+cA6B0QNETmP6TRxpYA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eudiWUw1sNehDYRPeUi88maaiC+StzBVKmYKywcMbfRdEL8WF6+YwlCUlGg+38uye
	 MasQKtRkwNqNu8A7BlbHfmJqNWz2Xm3gMkWzXxh4Hd0cEDhlwwFatEDVUVhcp+3qHm
	 iYe4QVUExnind/Ajbo34FalZqPMyJDKQazqdFKlUr+vbEdKRj3U5Xt+DWG1Jbg0DDf
	 ilHj58qNI7aRhYdGEJJg2qfUwVk71sPHf7Cn/zzBnYiKJoygx8mm3/lcmXlW/nwSFy
	 KNmLGeahCi33BJX1QRQiFADYe/pMpDgxCKI85ObqAOgmJiem2HlxWSuPHUIkVhvJK7
	 eHWByI2dQcyKg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96AB4606C0;
	Sun, 15 Nov 2026 05:05:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D92D3109
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BF95E606C0
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:04:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lWQqzpZVdo7c for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 05:04:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D2E1B60615
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=balaji.selvanathan@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=NHLyuHN5; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=VgAi91pE
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D2E1B60615
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:04:56 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AF4Rv9E2716233
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:04:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L6J+fn6yV/FUjf2O6QUHDllL+cA6B0QNETmP6TRxpYA=; b=NHLyuHN5IYb7/ccR
 FImnMVQjgHyNmZ6J3JgLPg1yaSkYM2ykAql/Zv6qUAGyBNMFjhLL4tNfP9V4UPiW
 gvlQyFQ2cpWBXYTkn5teZLYo/wnpCM1EDqdr/DswgzasTgsbRJujucElzNJOjHTL
 fP39LwEtjdJMo08ogqE2U3gR8m2KEJ12X53TIMqclGYrwd0wSvJf1LaEGIHiGHNP
 NES2z+1lO7ruhcaeLf2HAKSOC7Alp2vhboXeAoWEXgiHc1EWsPZImHYJRbT2E6n2
 h5CsaELCMwpdgNJ/Nq3vimvOMld27V0hkp/SKgWMszUh/PXVMOQAay4riNtRREne
 zMpwwA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhdt9yp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 05:04:55 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-378722fd4a3so2748852eec.0
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 21:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794719095; x=1795323895;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L6J+fn6yV/FUjf2O6QUHDllL+cA6B0QNETmP6TRxpYA=;
 b=VgAi91pEabr51kktmiwPnGu2TBQ2VeAdUg8MTvlvBs5e/OAHMU6v2WqYFWc46vPyDw
 urApOLwP0xFgHRUCiCoed/e21OeAkxr59+gwuLqUSN88bm0zx6KPwRWm2q4FFZC8QWLn
 rswRhxmq7aMgU8v8aRUvTnOiyE/J0n6Dn3FVBXcPI8h97FVktl+RL/nevUqyP+xzhK7n
 py0XFrB+uPEnZhsPJPrnGiOyXcraDL/E3Kv3H3LP1Z5diS7AVGwqo3ZnTK5dh5tvO4ni
 MA6UU7E6pB/7Nm43jV/f+VxWt7ZNZQLE0v+sHRGG2bZ1upXhh8v3jTqUqrRX2d/JJlmY
 xEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794719095; x=1795323895;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L6J+fn6yV/FUjf2O6QUHDllL+cA6B0QNETmP6TRxpYA=;
 b=ML0JgcyvEHPVukR24C/PR5QMvuJzCiaowcfJpwr8UwCXvg6cET26/Enf+TcsWA2Olp
 XVOEIS5YFcqK9xNCuYIOMgBkCW1kGKCsCN2ZCDjoeA30bF0AC0kLrbf1TSBc4bE7AL3t
 aWAmC1HnDH6lvIAnzMaM1rJHDKoeLd4SwaAU5Q7kmQ2syqbazALo/X4nFtcrev1tbBcy
 GaMoN8vtAtd8t53Yz7W3g/5fL03XZmWl383qBIEJtuuR5Z4U+btw8LHjDbYupBKH3t/B
 YrnCnmEt5CsWye0ohcQcRM+QTQhGl0Ty7iIGCQbNBTNp13T69jfJGKb2XQ+kvFhZ4LFT
 x7vw==
X-Gm-Message-State: APuU4Z/AYSIX/nvoeAJ3HaQiFON/nlSPFn0gH6sMKBxk3FHcCyEKXCRg
 e1Is1aMaXh6gxJ9coG51/kwHa1Hbo/UTpZ8wp9nguytn0lcpQ8E8B7x02/J0UbbA0XfN2iOyVjc
 4z/D73Rhu0KDU7boLVvuV8xf/V/yY7y1xk6EN+Kv81pznYeocnVZqB5C+A9rcXQBTm8gnxbM=
X-Gm-Gg: AYBFou1xoUX5K2dScKDZkpV1XY1wvzyX3FlWDsh05ffBMf5fIb6F14wfP8zRnIjIai0
 U1qY3JQnBOSBOy+5dbACfabrOv/iFv633Az6DLFOtaOuXhZ2JxscxyYgFhWAqrhInD/8b8yIrjk
 MH3LispFm/l2O3bwuMpkVp3hJpOifW7JCGi9U8rtIwHaN+EXRpNMNILNZ3eqekBjaNIppI6Bkry
 S3NKMxsa7AHjXHe+nPmz56SmQ9EZJ0B0jC0qenBcTl+Rz3h1qD7hOTb6OcOs4XhsJmI2qnUEC3+
 K4I880/oXBxPyr/915wWgEdpCxdDdS8/9RMGyvZ2JOWUwXsWOEZFfYsNiBGYEp8qXYaMRW+DozH
 GysixPJzlHcyfeewqR5Nl9vMBBxHWESLF9mI7lyj1VZznZrWgq6cirdG4TB1XpH4MGtj7F3gB+r
 6rqUJN+XhFA5ygOMKZaNdDu5HpYEbISHdfPodVZLe6QnviZxNmdMqHI9m4lFq8TKTecJT5x4XO8
 PMS
X-Received: by 2002:a05:7301:719e:b0:36e:535c:60b4 with SMTP id
 5a478bee46e88-37965ca80d4mr6890286eec.13.1794719094648; 
 Sat, 14 Nov 2026 21:04:54 -0800 (PST)
X-Received: by 2002:a05:7301:719e:b0:36e:535c:60b4 with SMTP id
 5a478bee46e88-37965ca80d4mr6890243eec.13.1794719093655; 
 Sat, 14 Nov 2026 21:04:53 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379565d269asm23487034eec.23.2026.11.14.21.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 21:04:53 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Date: Sun, 15 Nov 2026 10:34:40 +0530
Subject: [PATCH v2 2/6] tools: mkeficapsule: Add support for parsing
 capsule params from config file
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-mkeficapsule-v2-2-9fe141b2cc7c@oss.qualcomm.com>
References: <20261115-mkeficapsule-v2-0-9fe141b2cc7c@oss.qualcomm.com>
In-Reply-To: <20261115-mkeficapsule-v2-0-9fe141b2cc7c@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Peng Fan <peng.fan@nxp.com>, Daniel Golle <daniel@makrotopia.org>,
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794719081; l=24444;
 i=balaji.selvanathan@oss.qualcomm.com; s=20260213; h=from:subject:message-id; 
 bh=Vd4XfSyN9hptTJgcF277ClZcvXFucyQ+p1WRjVP78ec=;
 b=gzffUYsXilL7c4yGLECphKcz1+B88re769J/S9Liha79frNsB4kN9Ls311YoPqQxCzz438RW1
 q175mrW/rLFDBZd/pwcezJxNVtfMJXQcB6N0wY+Cl+S+OZ9nuz8/xcB
X-Developer-Key: i=balaji.selvanathan@oss.qualcomm.com; a=ed25519;
 pk=CDpYiUU3SH7KGEtsBvY2tBGPiWfMxqWJF0p2LftOfnc=
X-Authority-Analysis: v=2.4 cv=VOVIDNPX c=1 sm=1 tr=0 ts=6af93d77 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=7CQSdrXTAAAA:8 a=EUspDBNiAAAA:8 a=44x9OQ46fbIuOdL4i3YA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE1MDAxOSBTYWx0ZWRfX9i7a7DYy4C4f
 d1Fu5NBMKRKhjDsDkwczpT96kx5l6byMnTKbCFpZ7sCBeo9HmPScS6icQ7AHlR2xFbsWTMtxVCA
 3fOnf+wmB6CkeMVwLP8gDkvnbaP8cN8=
X-Proofpoint-ORIG-GUID: rIW1Nr6W3ndU0fEO1iHHJsSr2hqQUKwW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE1MDAxOSBTYWx0ZWRfX6ObXRmG04My9
 jCcoXb5YJkJaAGjNPRqCc2C77aSRapEKan9JatWjAOrrLmCKSMNO2M8OV87Dag0X0a86fILgZu3
 H0yShk0dDzJsAOVEHxD/cazj5bYiSons8n5CoAd1txD0cXhuqL18MuHJ1LCHQ2U/DBj5EW3pI9+
 0xtoGXp5+ozVLj5pCQr4VidTRhwHzO+a1i8AD8xCEq0ZrhADRYhB04hi1PuMrg2gk6eeP7GDWAY
 v7mjuXhi7yRsF78EHRXKbwZTc1nFs5OnohDsnotTDoz0pKe3EWLOaGoJ8stMG/NtWbgvWdHhoYK
 LeLE3bMiBJRTEp42jXseiekIrP678xbCMbON9sJtA2NVWUu3P8+PSQG8MwfGp0aWz3Vo9mzmxUn
 zrY4A700iAOrIpYZAGhF74+WyHr2SnDVOFgbVyoPzMQq9iW03SsdavaLJwduo0QLMgxscthRYkz
 d7FKAt3QCZVLs310T8A==
X-Proofpoint-GUID: rIW1Nr6W3ndU0fEO1iHHJsSr2hqQUKwW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-15_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015
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

Add support for specifying the parameters needed for capsule
generation through a config file, instead of passing them through
command-line. Parameters for more than a single capsule file can be
specified, resulting in generation of multiple capsules through a
single invocation of the command.

The config file can be passed to the mkeficapsule tool using the -f
option, or its long form --cfg-file:

 $ ./tools/mkeficapsule -f <path/to/the/config/file>
 $ ./tools/mkeficapsule --cfg-file <path/to/the/config/file>

Entries that name the same output file with the capsule: key are
combined into one multi-payload capsule. Each entry is a block in
curly braces, for example:

 {
	image-guid: <guid1>
	image-index: 1
	payload: payload1.bin
	capsule: firmware_update.capsule
 }
 {
	image-guid: <guid2>
	image-index: 2
	payload: payload2.bin
	capsule: firmware_update.capsule
 }

This generates a single firmware_update.capsule holding both
payloads. An entry with a capsule file of its own gives a normal
single-payload capsule. Accept and revert capsules cannot be
combined with other payloads, so a group that mixes them is
rejected with an error.

Co-developed-by: Sughosh Ganu <sughosh.ganu@arm.com>
Signed-off-by: Sughosh Ganu <sughosh.ganu@arm.com>
Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
Changes in v2:
- mention the --cfg-file long option in the commit message
- drop the EFI_CAPSULE_CFG_FILE and EFI_USE_CAPSULE_CFG_FILE
  Kconfig symbols
- group entries sharing a capsule file into a multi-payload capsule
  and exit with an error when such entries include accept or revert
  types. This was a separate patch in v1 that rewrote this code
- exit after printing the version for -V, instead of falling through
  to the -f handler with a NULL config file
---
 tools/Makefile             |  10 +-
 tools/eficapsule.h         |  67 +++++++
 tools/mkeficapsule.c       |  54 ++++--
 tools/mkeficapsule_parse.c | 474 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 590 insertions(+), 15 deletions(-)

diff --git a/tools/Makefile b/tools/Makefile
index 535a5d51c89..41f035b6820 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -267,11 +267,13 @@ HOSTCFLAGS_mkeficapsule.o += \
 	$(shell pkg-config --cflags gnutls 2> /dev/null || echo "")
 HOSTLDLIBS_mkeficapsule += \
 	$(shell pkg-config --libs gnutls 2> /dev/null || echo "-lgnutls")
-mkeficapsule-objs := generated/lib/uuid.o \
-	generated/lib/sha1.o \
-	$(LIBFDT_OBJS) \
-	mkeficapsule.o
+HOSTLDLIBS_mkeficapsule += \
+	$(shell pkg-config --libs uuid 2> /dev/null || echo "-luuid")
 hostprogs-always-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
+mkeficapsule-objs := mkeficapsule.o mkeficapsule_parse.o \
+		     generated/lib/uuid.o \
+		     generated/lib/sha1.o \
+		     $(LIBFDT_OBJS)
 
 include tools/fwumdata_src/fwumdata.mk
 
diff --git a/tools/eficapsule.h b/tools/eficapsule.h
index e51e549e674..27ccb66c3e8 100644
--- a/tools/eficapsule.h
+++ b/tools/eficapsule.h
@@ -191,6 +191,62 @@ struct efi_capsule_params_array {
 	struct efi_capsule_params *params[MAX_PAYLOADS_PER_CAPSULE];
 };
 
+/**
+ * capsule_with_cfg_file() - Generate capsule from config file
+ * @cfg_file: Path to the config file
+ *
+ * Parse the capsule parameters from the config file and use the
+ * parameters for generating one or more capsules.
+ *
+ * Return: None
+ *
+ */
+void capsule_with_cfg_file(const char *cfg_file);
+
+/**
+ * create_empty_capsule() - Generate an empty capsule
+ * @path: Path to the empty capsule file to be generated
+ * @guid: Guid value of the image for which empty capsule is generated
+ * @fw_accept: Flag to specify whether to generate accept or revert capsule
+ *
+ * Generate an empty capsule, either an accept or a revert capsule to be
+ * used to flag acceptance or rejection of an earlier executed firmware
+ * update operation. Being used in the FWU Multi Bank firmware update
+ * feature.
+ *
+ * Return: 0 if OK, -ve on error
+ *
+ */
+int create_empty_capsule(char *path, efi_guid_t *guid, bool fw_accept);
+
+/**
+ * create_fwbin - create an uefi capsule file
+ * @path:	Path to a created capsule file
+ * @bin:	Path to a firmware binary to encapsulate
+ * @guid:	GUID of related FMP driver
+ * @index:	Index number in capsule
+ * @instance:	Instance number in capsule
+ * @fmp:	FMP header params
+ * @mcount:	Monotonic count in authentication information
+ * @private_file:	Path to a private key file
+ * @cert_file:	Path to a certificate file
+ * @oemflags:  Capsule OEM Flags, bits 0-15
+ *
+ * This function actually does the job of creating an uefi capsule file.
+ * All the arguments must be supplied.
+ * If either @private_file ror @cert_file is NULL, the capsule file
+ * won't be signed.
+ *
+ * Return:
+ * * 0  - on success
+ * * -1 - on failure
+ */
+int create_fwbin(char *path, char *bin, efi_guid_t *guid,
+		 unsigned long index, unsigned long instance,
+		 struct fmp_payload_header_params *fmp_ph_params,
+		 uint64_t mcount, char *privkey_file, char *cert_file,
+		 uint16_t oemflags);
+
 /**
  * create_multi_payload_fwbin - create a multi-payload uefi capsule file
  * @path:	Path to a created capsule file
@@ -206,4 +262,15 @@ struct efi_capsule_params_array {
 int create_multi_payload_fwbin(char *path,
 			       struct efi_capsule_params_array *params_array);
 
+/**
+ * print_usage() - Print the command usage string
+ *
+ * Prints the standard command usage string. Called in the case
+ * of incorrect parameters being passed to the tool.
+ *
+ * Return: None
+ *
+ */
+void print_usage(void);
+
 #endif /* _EFI_CAPSULE_H */
diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index befa01a9672..816906729dc 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -35,7 +35,7 @@ static const char *tool_name = "mkeficapsule";
 efi_guid_t efi_guid_fm_capsule = EFI_FIRMWARE_MANAGEMENT_CAPSULE_ID_GUID;
 efi_guid_t efi_guid_cert_type_pkcs7 = EFI_CERT_TYPE_PKCS7_GUID;
 
-static const char *opts_short = "g:i:I:v:p:c:m:o:dhARDV";
+static const char *opts_short = "g:i:I:v:p:c:m:o:f:dhARDV";
 
 static struct option options[] = {
 	{"guid", required_argument, NULL, 'g'},
@@ -51,6 +51,7 @@ static struct option options[] = {
 	{"capoemflag", required_argument, NULL, 'o'},
 	{"dump-capsule", no_argument, NULL, 'D'},
 	{"dump-sig", no_argument, NULL, 'd'},
+	{"cfg-file", required_argument, NULL, 'f'},
 	{"help", no_argument, NULL, 'h'},
 	{NULL, 0, NULL, 0},
 };
@@ -66,7 +67,16 @@ static void print_usage_guidgen(void)
 		tool_name, DEFAULT_NAMESPACE_GUID);
 }
 
-static void print_usage_mkeficapsule(void)
+/**
+ * print_usage() - Print the command usage string
+ *
+ * Prints the standard command usage string. Called in the case
+ * of incorrect parameters being passed to the tool.
+ *
+ * Return: None
+ *
+ */
+void print_usage(void)
 {
 	fprintf(stderr, "Usage:\n\n%s [options] <image blob> <output file>\n"
 		"Options:\n"
@@ -84,7 +94,8 @@ static void print_usage_mkeficapsule(void)
 		"\t-o, --capoemflag Capsule OEM Flag, an integer between 0x0000 and 0xffff\n"
 		"\t-D, --dump-capsule          dump the contents of the capsule headers\n"
 		"\t-V, --version               show version number\n"
-		"\t-h, --help                  print a help message\n\n",
+		"\t-f, --cfg-file <config file> config file with capsule parameters\n"
+		"\t-h, --help                  print a help message\n",
 		tool_name);
 	print_usage_guidgen();
 }
@@ -463,6 +474,7 @@ static void free_sig_data(struct auth_context *ctx)
  * @guid:	GUID of related FMP driver
  * @index:	Index number in capsule
  * @instance:	Instance number in capsule
+ * @fmp:	FMP header params
  * @mcount:	Monotonic count in authentication information
  * @private_file:	Path to a private key file
  * @cert_file:	Path to a certificate file
@@ -477,11 +489,11 @@ static void free_sig_data(struct auth_context *ctx)
  * * 0  - on success
  * * -1 - on failure
  */
-static int create_fwbin(char *path, char *bin, efi_guid_t *guid,
-			unsigned long index, unsigned long instance,
-			struct fmp_payload_header_params *fmp_ph_params,
-			uint64_t mcount, char *privkey_file, char *cert_file,
-			uint16_t oemflags)
+int create_fwbin(char *path, char *bin, efi_guid_t *guid,
+		 unsigned long index, unsigned long instance,
+		 struct fmp_payload_header_params *fmp_ph_params,
+		 uint64_t mcount, char *privkey_file, char *cert_file,
+		 uint16_t oemflags)
 {
 	struct efi_capsule_header header;
 	struct efi_firmware_management_capsule_header capsule;
@@ -648,7 +660,21 @@ err:
 	return ret;
 }
 
-static int create_empty_capsule(char *path, efi_guid_t *guid, bool fw_accept)
+/**
+ * create_empty_capsule() - Generate an empty capsule
+ * @path: Path to the empty capsule file to be generated
+ * @guid: Guid value of the image for which empty capsule is generated
+ * @fw_accept: Flag to specify whether to generate accept or revert capsule
+ *
+ * Generate an empty capsule, either an accept or a revert capsule to be
+ * used to flag acceptance or rejection of an earlier executed firmware
+ * update operation. Being used in the FWU Multi Bank firmware update
+ * feature.
+ *
+ * Return: 0 if OK, -ve on error
+ *
+ */
+int create_empty_capsule(char *path, efi_guid_t *guid, bool fw_accept)
 {
 	struct efi_capsule_header header = { 0 };
 	FILE *f = NULL;
@@ -1249,6 +1275,7 @@ int main(int argc, char **argv)
 	unsigned long oemflags;
 	bool capsule_dump;
 	char *privkey_file, *cert_file;
+	char *cfg_file;
 	enum capsule_type capsule;
 	int c, idx;
 	struct fmp_payload_header_params fmp_ph_params = { 0 };
@@ -1267,6 +1294,7 @@ int main(int argc, char **argv)
 	privkey_file = NULL;
 	cert_file = NULL;
 	capsule_dump = false;
+	cfg_file = NULL;
 	dump_sig = 0;
 	capsule = CAPSULE_NORMAL_BLOB;
 	oemflags = 0;
@@ -1350,8 +1378,12 @@ int main(int argc, char **argv)
 		case 'V':
 			printf("mkeficapsule version %s\n", PLAIN_VERSION);
 			exit(EXIT_SUCCESS);
+		case 'f':
+			cfg_file = optarg;
+			capsule_with_cfg_file(cfg_file);
+			exit(EXIT_SUCCESS);
 		default:
-			print_usage_mkeficapsule();
+			print_usage();
 			exit(EXIT_FAILURE);
 		}
 	}
@@ -1374,7 +1406,7 @@ int main(int argc, char **argv)
 	     ((argc != optind + 1) ||
 	      (capsule == CAPSULE_ACCEPT && !guid) ||
 	      (capsule == CAPSULE_REVERT && guid)))) {
-		print_usage_mkeficapsule();
+		print_usage();
 		exit(EXIT_FAILURE);
 	}
 
diff --git a/tools/mkeficapsule_parse.c b/tools/mkeficapsule_parse.c
new file mode 100644
index 00000000000..e8d6c20412e
--- /dev/null
+++ b/tools/mkeficapsule_parse.c
@@ -0,0 +1,474 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2023 Linaro Limited
+ */
+
+/*
+ * The code in this file adds parsing ability to the mkeficapsule
+ * tool. This allows specifying parameters needed to build the capsule
+ * through the config file instead of specifying them on the command-line.
+ * Parameters can be specified for more than one payload, generating the
+ * corresponding capsule files.
+ *
+ * The parameters are specified in a "key:value" pair. All the parameters
+ * that are currently supported by the mkeficapsule tool can be specified
+ * in the config file.
+ *
+ * Entries that specify the same capsule file are combined into a
+ * single capsule holding all of their payloads. Accept and revert
+ * capsules cannot be combined with other entries, so a group that
+ * mixes them is rejected with an error.
+ *
+ * The example below shows six entries. The first entry is an example
+ * of generating a signed capsule. The second entry is an example of
+ * generating an unsigned capsule. The third entry is an accept empty
+ * capsule, while the fourth entry is the revert empty capsule, used
+ * for the multi-bank firmware update feature. The last two entries
+ * name the same capsule file, so they generate one capsule with two
+ * payloads.
+
+	{
+	    image-guid: 02f4d760-cfd5-43bd-8e2d-a42acb33c660
+	    hardware-instance: 0
+	    monotonic-count: 1
+	    payload: u-boot.bin
+	    fw-version: 2
+	    image-index: 1
+	    private-key: /path/to/priv/key
+	    pub-key-cert: /path/to/pub/key
+	    capsule: u-boot.capsule
+	}
+	{
+	    image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
+	    hardware-instance: 0
+	    payload: u-boot.itb
+	    image-index: 2
+	    fw-version: 10
+	    oemflags: 0x8000
+	    capsule: fit.capsule
+	}
+	{
+	    capsule-type: accept
+	    image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
+	    capsule: accept.capsule
+	}
+	{
+	    capsule-type: revert
+	    capsule: revert.capsule
+	}
+	{
+	    image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
+	    hardware-instance: 0
+	    payload: payload1.bin
+	    image-index: 1
+	    capsule: multi.capsule
+	}
+	{
+	    image-guid: 02f4d760-cfd5-43bd-8e2d-a42acb33c660
+	    hardware-instance: 0
+	    payload: payload2.bin
+	    image-index: 2
+	    capsule: multi.capsule
+	}
+*/
+
+#include <ctype.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "eficapsule.h"
+#include <u-boot/uuid.h>
+
+#define PARAMS_START	"{"
+#define PARAMS_END	"}"
+
+#define PSTART		2
+#define PEND		3
+
+#define MALLOC_FAIL_STR		"Unable to allocate memory\n"
+
+#define ARRAY_SIZE(x)		(sizeof(x) / sizeof((x)[0]))
+
+const char *capsule_params[] = {
+	"image-guid", "image-index", "private-key",
+	"pub-key-cert", "payload", "capsule",
+	"hardware-instance", "monotonic-count",
+	"capsule-type",	"oemflags", "fw-version" };
+
+static unsigned char params_start;
+static unsigned char params_end;
+
+static void print_and_exit(const char *str)
+{
+	fprintf(stderr, "%s", str);
+	exit(EXIT_FAILURE);
+}
+
+static int param_delim_checks(char *line, unsigned char *token)
+{
+	if (!strcmp(line, PARAMS_START)) {
+		if (params_start || !params_end) {
+			fprintf(stderr, "Earlier params processing still in progress. ");
+			fprintf(stderr, "Can't start processing a new params.\n");
+			exit(EXIT_FAILURE);
+		} else {
+			params_start = 1;
+			params_end = 0;
+			*token = PSTART;
+			return 1;
+		}
+	} else if (!strcmp(line, PARAMS_END)) {
+		if (!params_start) {
+			fprintf(stderr, "Cannot put end braces without start braces. ");
+			fprintf(stderr,
+				"Please check the documentation for reference config file syntax\n");
+			exit(EXIT_FAILURE);
+		} else {
+			params_start = 0;
+			params_end = 1;
+			*token = PEND;
+			return 1;
+		}
+	} else if (!params_start) {
+		fprintf(stderr, "Params should be passed within braces. ");
+		fprintf(stderr,
+			"Please check the documentation for reference config file syntax\n");
+		exit(EXIT_FAILURE);
+	}
+
+	return 0;
+}
+
+static void add_guid(efi_guid_t **guid_param, char *guid)
+{
+	unsigned char uuid_buf[16];
+
+	*guid_param = malloc(sizeof(efi_guid_t));
+	if (!*guid_param)
+		print_and_exit(MALLOC_FAIL_STR);
+
+	if (uuid_str_to_bin(guid, uuid_buf, UUID_STR_FORMAT_GUID))
+		print_and_exit("Wrong guid format\n");
+
+	memcpy(*guid_param, uuid_buf, sizeof(efi_guid_t));
+}
+
+static void add_string(char **dst, char *val)
+{
+	*dst = strdup(val);
+	if (!*dst)
+		print_and_exit(MALLOC_FAIL_STR);
+}
+
+static void match_and_populate_param(char *key, char *val,
+				     struct efi_capsule_params *param)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(capsule_params); i++) {
+		if (!strcmp(key, capsule_params[i])) {
+			switch (i) {
+			case 0:
+				add_guid(&param->image_guid, val);
+				return;
+			case 1:
+				param->image_index = strtoul(val, NULL, 0);
+				if (param->image_index == ULONG_MAX)
+					print_and_exit("Enter a valid index, 1-255");
+				return;
+			case 2:
+				add_string(&param->privkey_file, val);
+				return;
+			case 3:
+				add_string(&param->cert_file, val);
+				return;
+			case 4:
+				add_string(&param->input_file, val);
+				return;
+			case 5:
+				add_string(&param->capsule_file, val);
+				return;
+			case 6:
+				param->hardware_instance = strtoul(val, NULL, 0);
+				if (param->hardware_instance == ULONG_MAX)
+					print_and_exit("Enter a valid hardware instance value");
+				return;
+			case 7:
+				param->monotonic_count = strtoull(val, NULL, 0);
+				if (param->monotonic_count == ULLONG_MAX)
+					print_and_exit("Enter a valid monotonic count value");
+				return;
+			case 8:
+				if (!strcmp(val, "normal"))
+					param->capsule = CAPSULE_NORMAL_BLOB;
+				else if (!strcmp(val, "accept"))
+					param->capsule = CAPSULE_ACCEPT;
+				else if (!strcmp(val, "revert"))
+					param->capsule = CAPSULE_REVERT;
+				else
+					print_and_exit("Invalid type of capsule");
+
+				return;
+			case 9:
+				param->oemflags = strtoul(val, NULL, 0);
+				if (param->oemflags > 0xffff)
+					print_and_exit("OemFlags must be between 0x0 and 0xffff\n");
+				return;
+			case 10:
+				param->fmp.fw_version = strtoul(val, NULL, 0);
+				param->fmp.have_header = true;
+				return;
+			}
+		}
+	}
+
+	fprintf(stderr, "Undefined param %s specified. ", key);
+	fprintf(stderr, "Please check the documentation for reference config file syntax\n");
+	exit(EXIT_FAILURE);
+}
+
+static int get_capsule_params(char *line, struct efi_capsule_params *params)
+{
+	char *key = NULL;
+	char *val = NULL;
+	unsigned char token;
+
+	if (param_delim_checks(line, &token))
+		return token;
+
+	key = strtok(line, ":");
+	if (key)
+		val = strtok(NULL, "\0");
+	else
+		print_and_exit("Expect the params in a key:value pair\n");
+
+	match_and_populate_param(key, val, params);
+
+	return 0;
+}
+
+static char *skip_whitespace(char *line)
+{
+	char *ptr, *newline;
+
+	ptr = malloc(strlen(line) + 1);
+	if (!ptr)
+		print_and_exit(MALLOC_FAIL_STR);
+
+	for (newline = ptr; *line; line++)
+		if (!isblank(*line))
+			*ptr++ = *line;
+	*ptr = '\0';
+	return newline;
+}
+
+static int parse_capsule_payload_params(FILE *fp, struct efi_capsule_params *params)
+{
+	char *line = NULL;
+	char *newline;
+	size_t n = 0;
+	ssize_t len;
+
+	while ((len = getline(&line, &n, fp)) != -1) {
+		if (len == 1 && line[len - 1] == '\n')
+			continue;
+
+		line[len - 1] = '\0';
+
+		newline = skip_whitespace(line);
+
+		if (newline[0] == '#')
+			continue;
+
+		if (get_capsule_params(newline, params) == PEND)
+			return 0;
+	}
+
+	if (errno == EINVAL || errno == ENOMEM) {
+		fprintf(stderr, "getline() returned an error %s reading the line\n",
+			strerror(errno));
+		exit(EXIT_FAILURE);
+	} else if (params_start == 1 || params_end == 0) {
+		fprintf(stderr, "Params should be passed within braces. ");
+		fprintf(stderr,
+			"Please check the documentation for reference config file syntax\n");
+		exit(EXIT_FAILURE);
+	} else {
+		return -1;
+	}
+}
+
+static void params_dependency_check(struct efi_capsule_params *params)
+{
+	/* check necessary parameters */
+	if ((params->capsule == CAPSULE_NORMAL_BLOB &&
+	     ((!params->input_file || !params->capsule_file ||
+	       !params->image_guid) ||
+	      ((params->privkey_file && !params->cert_file) ||
+	       (!params->privkey_file && params->cert_file)))) ||
+	    (params->capsule != CAPSULE_NORMAL_BLOB &&
+	     (!params->capsule_file ||
+	      (params->capsule == CAPSULE_ACCEPT && !params->image_guid) ||
+	      (params->capsule == CAPSULE_REVERT && params->image_guid)))) {
+		print_usage();
+		exit(EXIT_FAILURE);
+	}
+}
+
+#define MAX_CAPSULE_GROUPS 32
+
+struct capsule_group {
+	char *capsule_filename;
+	struct efi_capsule_params_array params_array;
+};
+
+static struct capsule_group groups[MAX_CAPSULE_GROUPS];
+static int group_count;
+
+static struct capsule_group *find_or_create_group(const char *capsule_filename)
+{
+	int i;
+
+	/* Search for existing group */
+	for (i = 0; i < group_count; i++) {
+		if (groups[i].capsule_filename &&
+		    !strcmp(groups[i].capsule_filename, capsule_filename)) {
+			return &groups[i];
+		}
+	}
+
+	/* Create new group */
+	if (group_count >= MAX_CAPSULE_GROUPS) {
+		fprintf(stderr, "Too many capsule groups (max %d)\n",
+			MAX_CAPSULE_GROUPS);
+		exit(EXIT_FAILURE);
+	}
+
+	groups[group_count].capsule_filename = strdup(capsule_filename);
+	if (!groups[group_count].capsule_filename)
+		print_and_exit(MALLOC_FAIL_STR);
+
+	groups[group_count].params_array.count = 0;
+	return &groups[group_count++];
+}
+
+static void add_to_group(struct capsule_group *group,
+			 struct efi_capsule_params *params)
+{
+	struct efi_capsule_params *new_params;
+
+	if (group->params_array.count >= MAX_PAYLOADS_PER_CAPSULE) {
+		fprintf(stderr, "Too many payloads for capsule %s (max %d)\n",
+			group->capsule_filename, MAX_PAYLOADS_PER_CAPSULE);
+		exit(EXIT_FAILURE);
+	}
+
+	/* Allocate and copy params */
+	new_params = malloc(sizeof(struct efi_capsule_params));
+	if (!new_params)
+		print_and_exit(MALLOC_FAIL_STR);
+
+	memcpy(new_params, params, sizeof(struct efi_capsule_params));
+	group->params_array.params[group->params_array.count++] = new_params;
+}
+
+static void generate_capsule(struct efi_capsule_params *params)
+{
+	if (params->capsule != CAPSULE_NORMAL_BLOB) {
+		if (create_empty_capsule(params->capsule_file,
+					 params->image_guid,
+					 params->capsule ==
+					 CAPSULE_ACCEPT) < 0)
+			print_and_exit("Creating empty capsule failed\n");
+	} else if (create_fwbin(params->capsule_file, params->input_file,
+				params->image_guid, params->image_index,
+				params->hardware_instance,
+				&params->fmp,
+				params->monotonic_count,
+				params->privkey_file,
+				params->cert_file,
+				(uint16_t)params->oemflags) < 0) {
+		print_and_exit("Creating firmware capsule failed\n");
+	}
+}
+
+/**
+ * capsule_with_cfg_file() - Generate capsule from config file
+ * @cfg_file: Path to the config file
+ *
+ * Parse the capsule parameters from the config file and use the
+ * parameters for generating one or more capsules. Payloads with the
+ * same capsule filename are grouped into a single multi-payload capsule.
+ *
+ * Return: None
+ *
+ */
+void capsule_with_cfg_file(const char *cfg_file)
+{
+	FILE *fp;
+	struct efi_capsule_params params = { 0 };
+	struct capsule_group *group;
+	int i;
+
+	fp = fopen(cfg_file, "r");
+	if (!fp) {
+		fprintf(stderr, "Unable to open the capsule config file %s\n",
+			cfg_file);
+		exit(EXIT_FAILURE);
+	}
+
+	params_start = 0;
+	params_end = 1;
+	group_count = 0;
+
+	/* Phase 1: Parse all payloads and group by capsule filename */
+	while (parse_capsule_payload_params(fp, &params) != -1) {
+		params_dependency_check(&params);
+
+		/* Find or create group for this capsule */
+		group = find_or_create_group(params.capsule_file);
+		add_to_group(group, &params);
+
+		memset(&params, 0, sizeof(struct efi_capsule_params));
+	}
+
+	fclose(fp);
+
+	/* Phase 2: Generate capsules */
+	for (i = 0; i < group_count; i++) {
+		group = &groups[i];
+
+		/* Check if all payloads in group are normal blobs */
+		int all_normal = 1;
+		int j;
+
+		for (j = 0; j < group->params_array.count; j++) {
+			if (group->params_array.params[j]->capsule != CAPSULE_NORMAL_BLOB) {
+				all_normal = 0;
+				break;
+			}
+		}
+
+		if (group->params_array.count == 1) {
+			/* Single payload - use existing function */
+			printf("Generating single-payload capsule: %s\n",
+			       group->capsule_filename);
+			generate_capsule(group->params_array.params[0]);
+		} else if (all_normal) {
+			/* Multiple normal payloads - use multi-payload function */
+			printf("Generating multi-payload capsule: %s (%d payloads)\n",
+			       group->capsule_filename, group->params_array.count);
+			if (create_multi_payload_fwbin(group->capsule_filename,
+						       &group->params_array) < 0) {
+				print_and_exit("Creating multi-payload capsule failed\n");
+			}
+		} else {
+			fprintf(stderr,
+				"Cannot combine accept/revert capsules in multi-payload capsule %s\n",
+				group->capsule_filename);
+			exit(EXIT_FAILURE);
+		}
+	}
+}

-- 
2.34.1

