Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D451606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=t5LKyxBX;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QO1K6l+j;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZdUtUN5Q
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4298C40779;
	Tue, 24 Nov 2026 16:30:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YlbgFiLF-NFu; Tue, 24 Nov 2026 16:30:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 17AF040764
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795537811;
	b=mmp7OKsjbzPk0WtcwakgS05ma7u9NxXT9H/qTLKzkHXG8BbFYSwrggvabGzYq+yKcXD5
	 4++cxDEzVLEkUT8fH5AMRly5H3KY3LLD5I8tZmi8Yv2lF7n0qt5CMt3VZgJrWoZ+puOzC
	 DPmA64f8uyHKNNCtCudJZfB1eRH8b8jnEyru9qQEGcbIY3V4kHBZNvyr00gV08YyUsmqz
	 p9Sma7noaKUTR/xSfMwuXkuPuJMww+ZWNyYShD/ZAeb0DdRLRC1CHStM1za6zasX92RbV
	 r5xh6rjhGR1I4qxD2AjiLAjA7prkfwo0IGG9ItyP1E5yZZcS4ecCEXnxQUeUT9P7/kA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795537811;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=cPodiBCRuAxuzn9GZ1FnJtOIyRaUmLb2POHqJvekAYY=;
	b=Y7kV1bHb+6uEzpMRYA4+2rG73eGnXUBhiV5lfS3qnNeWlgaH7rMK04Krt1w69yNx8swo
	 j/LzAaQQv20rvq8rE5Q4UST6NmA1HGmld5uRIyt+nBGYScVCnPgxZwhXtCOZBf4nmGUkg
	 5dtoiq7rpbPpuJGTkQLxcNRUG6yl+V2IwB/2zgTIYCydkaglf8y1iDQRNMJ3PSiavDZEj
	 7E7SBg3A20OlJGnWAzbYN1nJytKO2p3cOTa2eHVZM6yypJTah18YZVy8YbGuOoFeM8Lm7
	 M+RBpKW4wPkbr8eNuHHt40wxgS9DcGvq3D+12WvubtwYqQpQdUFSeCU287Cq/K00iWg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795537811;
	bh=cPodiBCRuAxuzn9GZ1FnJtOIyRaUmLb2POHqJvekAYY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t5LKyxBXGHAoy+Mp6GGIcc8eCISbES4XQvB6UXpmbFjFQsYu5COhNdQCrSQH9ch6O
	 tji+eorsArn5LBYxRjcd45IJkxSbOlTlGtkHUHaC5/2ZuZLzJy9Ou0G+e6JvH1KVwF
	 65TO1BJZjwjFo0SEYivX4joCxgWLaEqWTg+iaYnl58Jiktew2RHPuH15NfzRE65zUx
	 7Ji1YB6ypxu0Cd9ANWWl2JSsYr8yLMeoenJuewP3eZ7Z6PWlooKlRfloYwSpJKWDiH
	 f4XyTxK0BXYSnYZgIpQgYEIyBqdvNfRF9AI4awFHryXJEo9zlbvHIn47FJlK6xu9Eh
	 5NBSXpAQKw+cg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17AF040764;
	Tue, 24 Nov 2026 16:30:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 61DF91C9
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 467EC6087A
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ddqc9eh1oYXs for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 16:30:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 258F46086D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=QO1K6l+j; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ZdUtUN5Q
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 258F46086D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:05 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFKt332569557
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cPodiBCRuAxuzn9GZ1FnJtOIyRaUmLb2POHqJvekAYY=; b=QO1K6l+jAcgNIj19
 wCLsa0wiOCy/depX1QKFwhUJfqOUxxaNuEmDXGkXZ5flefJFnN15AnkgbFEL//Rb
 5kOEnoYXbRwviiKKJnFx0H5ES/1jxstQZYBVU64+ohiyTTnFD8pdoK3xt2WqbCra
 sWG61mEw8Mi0j+7NmA3eZi/iSLkgeadjLkFG4GsN7xhidV3e+gt+EtzWmNrXoy5R
 F64+DxHys3lCZHXNi5ConISGZTf7naU/B49ILABps5iYk2aqp84iT4qHnHKfG75t
 v8qicIZ3hP02839chi2LBzX7mZaNJsnx6u77B1iyI1KgOmFIb5PyJo14SRVUgZQ2
 qgMsjg==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4w6svceh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:04 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-97e8be2221eso643124241.2
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795537803; x=1796142603;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cPodiBCRuAxuzn9GZ1FnJtOIyRaUmLb2POHqJvekAYY=;
 b=ZdUtUN5QreKWtv5dFJIalvlnoWZ72UFO9HWlVPjLI1xeeEQhL4AHIc3bgoDJGX6g1F
 x6jWmIB6NEL/Zh4T6vNlsRFif2mXYwuN1SnldcK61kIo8jEI9w0BZOCQjhSsp4eCiGYm
 w9IppM/MnyfYzHrEasnHsbeT3LuqW1WnGihBvboawQCBSTfa/KHUhPvX+XIl6yNUsUPT
 nZaX4wJTAskjuWXTQEDjExAQVi+9opT80PvoV2zBNDIQTGnDJKW9y63luRPYu2DGWw1s
 IxkOBGme0VPt/Iy0lAKqVFzZUGT5UstmXM2BtcqYIINLCum7tipadcPfDjt93LKRa3qU
 84Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795537803; x=1796142603;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cPodiBCRuAxuzn9GZ1FnJtOIyRaUmLb2POHqJvekAYY=;
 b=BAQNGz+LXaz4QFDzjzZ/7Yp2ZPLr5WXSru0oMrfKyahz267w7s+TgvWA1l2wvJMNFq
 MKC/OK2EANmas3hI2o3jE1bGejZjwtngl+3LbNF84pmtmevV+rbE7lBUNFQ7J3rP9ttU
 cWnvXe/mRzLpfiPBWeCKHYrqZH6M6tZWO9Y8CNQJpgRkv5/26JjyfUMJsn+/W/lyLILK
 20MM3HfQ0xGiSbsiW7VOat1W4SKxA1USYobaYLfSJcuEVYzeT9pfF83nWYBgJRBUIzcB
 14y6EUFqTPRxZvUSZOfTxeWW8Qh5Tc1nkv/FKuZFMF6FyNW9RW88jY8QcsNOS6muKSbZ
 Zd3Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFUzq3d3htPmarQh6eRbTDFt54lT27Y9FwkRVzhgh0Qw8aKzmRzDgYVHg5fZONt+8iUb0x5F7w=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/CmqxBsU2HdLhcHUQU+5AQcmwz9OCKjQvM/Nkv4tfvpW0qahV8
 6Q8U/zVoBDdfyu1MVqemDE89t3GHX6DUhQqzp5Y10DrNxv/rHnMYckgQeMZUThFXxjw32+I5DSe
 /sjdoomrOWh+jJFc8tW0UvBkxF9tJC4mrDaAZmi2FlisB9s3dvwFFnmE2kesPJhIFeH1nqK0=
X-Gm-Gg: AZFdTZfhRxFcXl8Es/YNvSwOfiuHGGoHC9mic34ONTXo/oTiFnhQkiJkvAEVzqQ1sRi
 IdlAO/ThUa7Ay4CnyP5JCuyfQThAQidbRyB6AD6rr0Dlmf+yoWssrGwo9KZjQHY8mGDqwxtnSzc
 xwaXboMHPQC76D3H1aioUrcYRq+GNaySatfxSFkS7Tv4sYyFqH3oqeagYG/62r/N56p/H8f+lg3
 s5iFj0p2soWhoZx8rEgROvjpZGrn7DEIRqBpO7HEHsq1loWuurfnpik4iF6x1QpwFkNvVxPX4od
 YWkUkkP6SNfMLjgJWkMMr7AJAfGqOuURPp1TTIH244k/eFvai5uThdmZTRQ0sO18ilsi9oSFJlQ
 jyTXoQK1jinCBMHt+f+Ylaek/O8uCsi83NEW+OXnNOjfPUCWsJ3zZnrVCc2nFrc67q9TIjd4NnQ
 Uhx0tVrosIazy4
X-Received: by 2002:a05:6122:8c8c:b0:5ec:d5e1:ee2b with SMTP id
 71dfb90a1353d-5ee8af7d9acmr8495903e0c.23.1795537803361; 
 Tue, 24 Nov 2026 08:30:03 -0800 (PST)
X-Received: by 2002:a05:6122:8c8c:b0:5ec:d5e1:ee2b with SMTP id
 71dfb90a1353d-5ee8af7d9acmr8495845e0c.23.1795537802826; 
 Tue, 24 Nov 2026 08:30:02 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370fbf0esm7058223a12.23.2026.11.24.08.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:30:01 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 17:25:02 +0100
Subject: [PATCH v2 5/7] test: py: create the bootstd images for a ut test
 run on its own
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-upstream-avb_tests_b4-v2-5-ed7136c3767c@oss.qualcomm.com>
References: <20261124-upstream-avb_tests_b4-v2-0-ed7136c3767c@oss.qualcomm.com>
In-Reply-To: <20261124-upstream-avb_tests_b4-v2-0-ed7136c3767c@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: IqkFVM_jf3DVLtGr8WpKjMV-F64ahz1n
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2NCBTYWx0ZWRfXxYfE+qfiEMZ+
 ylsV+30sT9sYQ2lt9eOo28OduHG/V4enY8+GgJFX3gP65fBBDAKV85PK6kFNyMS1LC54nWD334C
 t6P6psUG+HTbvxKa3DISQPiR4RJVY2c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2NCBTYWx0ZWRfX/eBpc4s2SivE
 8Brkv+GeANmqbJ8xuvlCtiM0HlCPpUmOjeOgH/Dd5WNOGVbnwftfBN/nHq+5RxgbnsdP3ALcdPX
 Au3cD1UBt5RNbgtTKKvpu3f3u5fDbKZ3dEnuFo8+GuNlj4ghP+saaBV4PQJneczlkDuKPfB04Wh
 dIiEaHrCJKew2p2C+PbcEso9mkSbnZcoBZ8EDfKjYPyG5qOdODfZbO9eTHn14zn8LoSJBCQ5Nnq
 JnS/jRXyZbVVGhlUZjznEMIk979Cveu41d0GBOnlmL+85PcEsR6exiqCw/ar1s78JPqaKywgyf6
 u/7kwpg7cYrFOdyq7pjRwqBotzInb9J+5WRu0pEWXrHmkAhtTflvnw7kXye/qjKAmfMzB+5Jm0y
 1kD5RSu2sBVRNAjHqOlbPxEjWQ6n6QlaIYMKXsFWrrj6nurocvdcVSOIbb+Fg/Lrk//iFP2lzF6
 LOmb+KCrLwUW5Zf8K2A==
X-Proofpoint-ORIG-GUID: IqkFVM_jf3DVLtGr8WpKjMV-F64ahz1n
X-Authority-Analysis: v=2.4 cv=V8DoQuni c=1 sm=1 tr=0 ts=6b05bb8c cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=bLzMUy_wEVep9cgd:21 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=pqL-FJb0ap3itD71dOAA:9
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240064
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

The C tests of the bootstd suite need disk images that only
test_ut_dm_init_bootstd creates. A test selected with -k then fails,
as that one is not selected with it:

  $ ./test/py/test.py --bd sandbox --build -k avb_preloaded
  Can't map file 'mmc12.img': Invalid argument

Create the images from the fixture of the ut tests as well, once per
run. Parallel workers share the image files, so the first one creates
them under a lock and the others wait for it; conftest.py clears the
done file when a parallel run starts, as it does for the build.

Most bootstd tests don't use the images, so if the fixture can't create
them (e.g. futility is missing), it logs that and runs the test anyway.

Reported-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Closes: https://lore.kernel.org/r/179501661323.306911.11688771039281338221.b4-review@b4
Suggested-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 test/py/conftest.py      |  7 +++++-
 test/py/tests/test_ut.py | 63 ++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index 215aaa56534..864d8227236 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -208,7 +208,7 @@ def get_details(config):
             build_dir_extra, source_dir)
 
 def pytest_xdist_setupnodes(config, specs):
-    """Clear out any 'done' file from a previous build"""
+    """Clear out any 'done' file from a previous build or run"""
     global build_done_file
 
     build_dir = get_details(config)[3]
@@ -217,6 +217,11 @@ def pytest_xdist_setupnodes(config, specs):
     if build_done_file.exists():
         os.remove(build_done_file)
 
+    # Disk images of the bootstd tests, see ensure_bootstd_images()
+    images_done_file = Path(build_dir) / 'bootstd-images.done'
+    if images_done_file.exists():
+        os.remove(images_done_file)
+
 def pytest_configure(config):
     """pytest hook: Perform custom initialization at startup time.
 
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 80252e3a9b0..1eb66705f4a 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -13,6 +13,7 @@ import os
 import struct
 import os.path
 import re
+import filelock
 import pytest
 
 import utils
@@ -21,6 +22,9 @@ from tests import fs_helper
 from fs_helper import DiskHelper, FsHelper
 from test_android.android_image import setup_android_image
 
+# Set once this process has set up the disk images used by the bootstd tests
+bootstd_images_done = False
+
 def mkdir_cond(dirname):
     """Create a directory if it doesn't already exist
 
@@ -622,11 +626,12 @@ def setup_rauc_image(ubman, mmc_dev, part_names=None):
     boot.cleanup()
     root.cleanup()
 
-@pytest.mark.buildconfigspec('cmd_bootflow')
-@pytest.mark.buildconfigspec('sandbox')
-def test_ut_dm_init_bootstd(ubman):
-    """Initialise data for bootflow tests"""
+def setup_bootstd_images(ubman):
+    """Create the disk images used by the bootstd tests
 
+    Args:
+        ubman (ConsoleBase): U-Boot fixture
+    """
     setup_fedora_image(ubman, 1, 'mmc')
     setup_bootmenu_image(ubman)
     setup_cedit_file(ubman)
@@ -640,10 +645,52 @@ def test_ut_dm_init_bootstd(ubman):
     # Restart so that the new mmc1.img is picked up
     ubman.restart_uboot()
 
+def ensure_bootstd_images(ubman, required):
+    """Create the disk images used by the bootstd tests, once per run
+
+    Parallel workers share the image files: the first one creates them and
+    the others wait for it, so that no worker overwrites images that another
+    one is using.
+
+    Args:
+        ubman (ConsoleBase): U-Boot fixture
+        required (bool): True to raise an exception if the images cannot be
+            created, False to only log it
+    """
+    global bootstd_images_done
+
+    if bootstd_images_done:
+        return
+    try:
+        if not os.environ.get('PYTEST_XDIST_WORKER'):
+            setup_bootstd_images(ubman)
+        else:
+            # conftest.py removes the done file when a parallel run starts
+            build_dir = ubman.config.build_dir
+            done = os.path.join(build_dir, 'bootstd-images.done')
+            with filelock.FileLock(os.path.join(build_dir,
+                                                'bootstd-images.lock')):
+                if not os.path.exists(done):
+                    setup_bootstd_images(ubman)
+                    open(done, 'w').close()
+    except Exception as exc:  # pylint: disable=W0703
+        if required:
+            raise
+        ubman.log.warning(f'Cannot create the bootstd images: {exc}')
+    bootstd_images_done = True
+
+@pytest.mark.buildconfigspec('cmd_bootflow')
+@pytest.mark.buildconfigspec('sandbox')
+def test_ut_dm_init_bootstd(ubman):
+    """Initialise data for bootflow tests"""
+
+    ensure_bootstd_images(ubman, True)
+
 
 @pytest.fixture(name="ut_ubman")
 def ut_ubman_fixture(ubman, ut_subtest):
-    """Fixture to restart the sandbox after known problematic tests.
+    """Fixture to create the images a test needs and to restart the sandbox
+    after known problematic tests.
 
     Args:
         ubman (ConsoleBase): U-Boot console
@@ -651,6 +698,12 @@ def ut_ubman_fixture(ubman, ut_subtest):
             execute command 'ut foo bar'
     """
 
+    # test_ut_dm_init_bootstd() is not selected when a test is run on its own
+    # with -k. Most bootstd tests don't use the images, so if they cannot be
+    # created (e.g. a host tool is missing), let the test run anyway
+    if ut_subtest.startswith('bootstd '):
+        ensure_bootstd_images(ubman, False)
+
     yield ubman
 
     if ut_subtest in ("bootstd bootflow_cmd_boot", "bootstd bootflow_scan_boot",

-- 
2.53.0

