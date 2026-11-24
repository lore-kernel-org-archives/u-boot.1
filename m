Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78128606A327
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yklvucmy;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SZ0UV4S5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d8Jm7B+A
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4951580C43;
	Tue, 24 Nov 2026 16:30:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rzcH_uexsgq0; Tue, 24 Nov 2026 16:30:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7353A80C46
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795537802;
	b=k0JLqV9RxV7OyPxE1E1p2CKth1RafGQz+XfbAkIz9O0V4n17NE36tiOkrFog2vXz7mXb
	 0xAeHSo2R0bR81DK0FY7Hp5oyN/mbLXQ+OELkyJ+KJ1ljU6TdEZNW61fgnci/EHGDH0C2
	 MPQP7OJHHZJDQ9F/HZ009jzwZivx9clSZjpUNAVzoKAd9XviEGYGqggdkhyLC6FUNdd1K
	 UHoBFXLi3gRbbTtrqAitTXmHLhXQq2Em+xaq+IEdg2w9ZF3qVsc41Sg7pGfWHawvZ8Nze
	 6TWMXnh+o02HbBHmsYwkwO46dRAYiLHfc5mn/Ddexskris/+lMX6Fxk1HDg0xuTsmsg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795537802;
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
	bh=xD9rJS36TWg7V337aa5gt8K7EC8gHTgg0TKBZDhBR3k=;
	b=mnMctYwWO9fPnTiqGMBj5F+JNx8JYdA4AuvpCW7iiCeqsN2ucWRMO36cWrBsLiGfe0ct
	 ugjeLjHy8x4Xbtvn3fQObMAApK26SwR1RNE5W4lNMI2uh2PyFhgAW39BTSG8e7zGEEkxl
	 xYwpf9HmpKCREZzAvBWcMx2xhBb/7vMuHl1QBwjyIg5wwe4yaK8jfOrRt16r9NQe7lMd/
	 +aPHVUr+HAtgXo8ylXpUvfXAjntSJq4/rcxOTZZjki0sORoefXp18NRITAQAbX3fpcift
	 UVSQao7SnkL64Q34rTTT+KQLVYMBJ4MZ1iaXA8CSLCX0+b8jgAfl7XbX0A0NdGEigxA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795537802;
	bh=xD9rJS36TWg7V337aa5gt8K7EC8gHTgg0TKBZDhBR3k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yklvucmyMHU/GXDFUkJZnz9pusWecVWlwgfws3idHWs3fI+znvzRZvGi0W5kveF2X
	 5iQzj/XULwW0Lv4PDagrD9vJLiVDI3BvFJJOD0kFWzln3LTrAoB7nMT3wJXJMRMVBu
	 84woQSlCxpeRSl3OzAxeVUWUId5bh/1chE0xfaJUhEE1aEdIq7wvUmonzTAgqsygSd
	 7dKZ0nGT49TAoZsQl1Lsa+1ceQAYhpMbAUSPKM1J23nc2OFEydiqsGGgEBIDlJa0Ri
	 UvxuaQ9372fSV3yLPtYh5nBMQFObU7qH9/fvxd8SjpqOl0hfQ2gFoxzj4qXQQIK31J
	 wUr4lUZo8O6fA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7353A80C46;
	Tue, 24 Nov 2026 16:30:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A9682499
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:29:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8F4AA405AD
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:29:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2a3Qmq-N7t2n for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 16:29:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7FE84405A4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=SZ0UV4S5; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=d8Jm7B+A
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7FE84405A4
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:29:56 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFKvsu2569582
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xD9rJS36TWg7V337aa5gt8K7EC8gHTgg0TKBZDhBR3k=; b=SZ0UV4S5wyBqvmxm
 9TK91rtdo+50Ld/oSmIErHw65OvQ6PNLmRQuUG+hE1r06zgBaO3FruZKj/lfduSW
 5iewDVrbul2N5iMC9MjuW1huGxCVnOjOS7E7xr5gjeyHfT/i+hQj+2elk8OHpSg/
 d/41E/ITRvQ6ewMoc2Kyw0fu9ETRSSW5nGYDjDjvLbpbX+RS/J99oRp2y5d7dn3C
 2U5UCAtqyAvTuecvGoog4jxA/TPMS/dXsXeuP6oY47zK8Uaz9yu5e3l0XzBzIl3I
 vpRewqhotsquYKRNYSgLITB+4hrG5+fN6ebXi9rbg9s5mkaJ6kI/9S/toWB596mH
 jKbUnQ==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4w6svcdv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:29:55 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5eaad8219b0so1617190e0c.3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795537795; x=1796142595;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xD9rJS36TWg7V337aa5gt8K7EC8gHTgg0TKBZDhBR3k=;
 b=d8Jm7B+AVcJyt5gTfiAUGCKJP/kpIgmG/A3OLKhxe1ri8GFx9PdAHw0+I8ofS0UPe4
 5DaVc0UgOgI5NsINWlXp8OF8r0HLTV98+vuE6T2yGTPsCP2jaXkTAhnZRG/oZoq0uQcI
 cbjiBjGit1AHjAlQWb5j/xprMXhERpWEZaajtMulcO++k+qMMPHch456NhTNNrjJbhNs
 4Q7DZ+1xomzGhRn9t/gKSeHqhwGaY+UoON+d1YFxaOmGiqXaWwJSZCb/c+Vit5yKy5kX
 hty8FVMPbThKtt4pUO/m+XaLjCgB536bWHqY8WeBThPUebzlccugvw1daQZLvuR8Z8j2
 VIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795537795; x=1796142595;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xD9rJS36TWg7V337aa5gt8K7EC8gHTgg0TKBZDhBR3k=;
 b=Ozi2V30WQQBM3GQ4hvBmmSFeQwdHxbZFbnCwrGqnxNgR07pb9t5ao0ahaUUGwbdDpA
 vx9jKWseb0d8i8vU+SYH3bPEsw0/wnPwVWopSYirkAiGt+sjK9wUynv0JlZ2HUs1KLtw
 2L6Ac2CQmxlYVY2J8pikAJxUEcteINAqBTbI5bJ9fIhOqEGdc28PwSfsWpAMjmWLahOs
 ywH2TvO5HOx6ru9+422P89lvOVPa7IbSoqusCuJ9WEj5pAVZNLJuBhrag9dOfkYaG4wl
 TyzOO5dxoP0wpjI9m55y2KmNJSFFotFRy/RvAtf2d6pfOJgmw7Z8rRe+DdvetKhSs6oj
 ZhZg==
X-Forwarded-Encrypted: i=1;
 AL+hErE1H9z8r3cS+q0gDBuVnIYuk3nfn0YoPRiHP6wNNzT76WMYXnhxQyKYM7Lx+HsFvbrKBWC2jqc=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9ji3kTYb7370zgG/wbz2Gw62A0Ga1dLa7WvDCCbQgdWMpjroDw
 mEvfyoc/2pd0FRiAyeOKF7e1PvXqlzPaCLm8SIuoS9pzTGnx1BJGLFZXXG38F70Pslff8CV5Vxk
 incxVkcWiSAP6FQiSIsDEJYRhUy4Z3pMJSqMzKopTXBa12jEcHxiXmOYm3kK//VGnJP2rYr4=
X-Gm-Gg: AZFdTZc7p1CCXlm8oLw2iMvHzWM19dv5SOxw049uGo/y5dsKWb/pIbg2JFk2YwcxiZC
 BtVMXVSZsELQS8ase7m1ca/Q7dtydGciPWqZwiTOtFv1OwV1DIunwPdXmzWqF9anKewxJ518nj+
 WFkJv3g5bew2Bm+Jk+3t2mK4sCDVHu1KMinqx6bK37YHL3ifToiuICQOl3P6LwQpwtmi4HXxm0g
 UD4ISZ/fQQ807Rz+2cALbztjCaZNLfDa8LT/TcihuBzfVm864TMa3yI8NgmB1YV8Ypq0dLz/puq
 68vgn12FCBNjx6u/SmtGDwH4fN0UxN5tY43VJfiOUGAvN/FeMspw/EAVezNJYBMgEQQsqcsEozU
 vm4Omui3ZVQoYmsjixszhWkj5rUtm7ZXQX7Y7AOuWq2sNRehtcNxZFBh6Tioj5A9cVRnc0Q0rTW
 1DO9EVIcgcO87v
X-Received: by 2002:a05:6122:d07:b0:5c9:a60d:3276 with SMTP id
 71dfb90a1353d-5ee8aee5831mr7304743e0c.10.1795537794731; 
 Tue, 24 Nov 2026 08:29:54 -0800 (PST)
X-Received: by 2002:a05:6122:d07:b0:5c9:a60d:3276 with SMTP id
 71dfb90a1353d-5ee8aee5831mr7304674e0c.10.1795537794162; 
 Tue, 24 Nov 2026 08:29:54 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370fbf0esm7058223a12.23.2026.11.24.08.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:29:52 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 17:24:58 +0100
Subject: [PATCH v2 1/7] tee: sandbox: keep zero bytes in persistent values
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-upstream-avb_tests_b4-v2-1-ed7136c3767c@oss.qualcomm.com>
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
X-Proofpoint-GUID: Vgu3xPuE-OZb0P8QvvtGzNMWRmXMi4-1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2NCBTYWx0ZWRfX/JAdW6Hv4WAL
 Ycj6HkVmEHfy9zEEyasTkM/VxefQdK+8Qu1U0ll7ggGfZY0h7Jh2yY9iaITyWknKxb9dgrFX8As
 D8LEMzuJPIa+AYoMiW/7Q0+Igp0KXqo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2NCBTYWx0ZWRfX2Nt9I20ij7BF
 S7IcNcBX0WAvDgEVXterDxcYC+ibxmx8IuLkMpxo9+PsCx/LMDXB7n5o1cM+4uCxCMIxdua8KL3
 9Gw34Wh/TdoE9fDt8uBm1taLivcX4dn2xPOs3mMZWu4tjUYeJLvAyjqzRkygE1Ra4uKhIpU/wRZ
 EmqLh2Eb+daXDJI+8uwwailhh78dA6q7DM1Alzk7NA308APHwaOF8wINhW9AudX4AY1T6Ukghsl
 n0LTOhXyXosLPR/Ib2b8mBeoVRyJjkhFGmfLrYeoj/iIeuwWQQk8MWIcNa8kdljhnwy97zoMonO
 6nwub/H6iSGcT0dCxUS7L3QY3buYaRKushKhANvrc34UYsDbx7f+u3RmVtnqS8XhYCibI/SPPjH
 vLCZ/odnKzq8Q00DYbvB3TxQ9GIbIv9azqgkGdd+kO1nVBMUx8sy23rMKKfsnzAlm8wuD3aPJH3
 m04v5GW0P01y3tUoVRg==
X-Proofpoint-ORIG-GUID: Vgu3xPuE-OZb0P8QvvtGzNMWRmXMi4-1
X-Authority-Analysis: v=2.4 cv=V8DoQuni c=1 sm=1 tr=0 ts=6b05bb83 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=IpJZQVW2AAAA:8 a=oRoHww3TWE2v92qkDKcA:9 a=QEXdDO2ut3YA:10
 a=XD7yVLdPMpWraOa8Un9W:22 a=IawgGOuG5U0WyFbmm1f5:22
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The emulated AVB TA keeps persistent values in a table of strings, so a
value is cut short at its first zero byte, unlike with the real TA.
Binary values, such as the digest of a user-provisioned root key, then
cannot be tested on sandbox. Store the values hex-encoded.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Tested-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/tee/sandbox.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/sandbox.c b/drivers/tee/sandbox.c
index 16e5d95616c..24c888fbc27 100644
--- a/drivers/tee/sandbox.c
+++ b/drivers/tee/sandbox.c
@@ -4,6 +4,8 @@
  */
 
 #include <dm.h>
+#include <hexdump.h>
+#include <malloc.h>
 #include <sandboxtee.h>
 #include <tee.h>
 #include <tee/optee_ta_avb.h>
@@ -174,6 +176,7 @@ static u32 ta_avb_invoke_func(struct udevice *dev, u32 func, uint num_params,
 	uint slot;
 	u64 val;
 	char *value;
+	char *hex;
 	u32 value_sz, tmp_sz;
 
 	switch (func) {
@@ -268,7 +271,8 @@ static u32 ta_avb_invoke_func(struct udevice *dev, u32 func, uint num_params,
 		if (!ep)
 			return TEE_ERROR_ITEM_NOT_FOUND;
 
-		tmp_sz = strlen(ep->data) + 1;
+		/* values are stored hex-encoded, see the write below */
+		tmp_sz = strlen(ep->data) / 2;
 		if (value_sz < tmp_sz) {
 			/*
 			 * For TA_AVB_CMD_READ_PERSIST_VALUE2, reject
@@ -287,7 +291,7 @@ static u32 ta_avb_invoke_func(struct udevice *dev, u32 func, uint num_params,
 			tmp_sz = value_sz;
 		}
 
-		memcpy(value, ep->data, tmp_sz);
+		hex2bin(value, ep->data, tmp_sz);
 		params[1].u.memref.size = tmp_sz;
 
 		return TEE_SUCCESS;
@@ -305,6 +309,17 @@ static u32 ta_avb_invoke_func(struct udevice *dev, u32 func, uint num_params,
 		value = params[1].u.memref.shm->addr;
 		value_sz = params[1].u.memref.size;
 
+		/*
+		 * The table holds strings: store the value hex-encoded so
+		 * that it can contain zero bytes, as with the real TA.
+		 * Encode it first, so that a failed allocation keeps the
+		 * old value.
+		 */
+		hex = malloc(value_sz * 2 + 1);
+		if (!hex)
+			return TEE_ERROR_OUT_OF_MEMORY;
+		*bin2hex(hex, value, value_sz) = '\0';
+
 		e.key = name;
 		e.data = NULL;
 		hsearch_r(e, ENV_FIND, &ep, &state->pstorage_htab, 0);
@@ -312,8 +327,9 @@ static u32 ta_avb_invoke_func(struct udevice *dev, u32 func, uint num_params,
 			hdelete_r(e.key, &state->pstorage_htab, 0);
 
 		e.key = name;
-		e.data = value;
+		e.data = hex;
 		hsearch_r(e, ENV_ENTER, &ep, &state->pstorage_htab, 0);
+		free(hex);
 		if (!ep)
 			return TEE_ERROR_OUT_OF_MEMORY;
 

-- 
2.53.0

