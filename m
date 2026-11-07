Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88481606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 12:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zSQmIu92;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oJkVc+tH;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c8yCqc7Y
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F309819B8;
	Sat,  7 Nov 2026 12:53:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZU1uIZE8_aIq; Sat,  7 Nov 2026 12:53:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 93C8281A4E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794055989;
	b=BBRZge/e2d1zXvOjBWDfpQ2uTBq9WK2BydxUN0waz8vl7rXhhePlaRYN9z9xPx/WWG9d
	 dY4BR0ggfBXbEIsMF62oWLNqXFfIOqg5Zwi9Kdijb6kp3swb3q/XaJXYfFeAGeC6w6T4J
	 nXMJliHjiR7AuJdFnSPR/tTsamtsdpTFWiPW1zfU3ojSKH1B4w81Qnk6mW4dY4p/CHMmN
	 WzL8OnFVPLx9NXTHotp2lcYNG+jTsLUgxMK0XEEy/EklJ3fqF0Cse8p9iUudGCiBVe26j
	 DVODI10jjIb2brJ6Eolj9EDBS2BdQlmH2PFwl7EzMcAoCy4LvVGPgLrtRRsdNWZj1Ww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794055989;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Di97Vkv3xnSlpeBXKuxrZqcvYdyyC1qhgcf2hsF9CGw=;
	b=m7gVuZI/vkjbf1KNxDaD92nh95/vEg3Ex6n+TJDNz7qW2wAjQDQsFAWkafBQ71og845A
	 fRrMXAquX53OnTCU10xO4vRWsDh5MS0TOyrLOMGkd7YZ94f442M1398iDeUUpWASJ1RFJ
	 9ke4ZimEAXQGI05GQ2hnlJBIEuWRFaqgYImseCDwLtWMjpZpmRd26+t36U6cBPnujnkxP
	 niPCgHmSgLOgF+0k01DjF18nebutBzctSV2rS8/4w09RJIAFwun/u0/cfEOgZINSzqBZ6
	 5tXmpATLdiRIIiwmOS0DOe8RDUgux85AUYZVEEtexV1s2T+9JJlrzjLMs+BjN4ylC5A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oJkVc+tH;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c8yCqc7Y;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794055989;
	bh=Di97Vkv3xnSlpeBXKuxrZqcvYdyyC1qhgcf2hsF9CGw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zSQmIu92eZ/UHU50msag0E7fAgUFZFh3CZSLep1wisjKEDGpbWCSSn9QzXKemtce7
	 Byo7O9UujFyFtc0s6uiYc8dgNklLJDTww0PR6NRiFWJIQu0eIvGgFOHHiOR6LGAs3e
	 OLKPHgQ+2zdTafCuLayZJxEJzThhZaC8C0kWRl2qWC7XR7CvEutUy7MfwPi0fVZQ7T
	 v/kbUxtoi21SntknYvhjL/4WuDUx8MXnMhHFC9CmtyxVq8bNTmFLtkBebGH5/nMgpw
	 BqinAkMLEgi7NKVDvbF6DLuqorGYbpDJXqAWoG/terhnmotbohaikJAA+ne3hP1ZWS
	 dS8twq2HDcziQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93C8281A4E;
	Sat,  7 Nov 2026 12:53:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B08937D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 12:53:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4E4E081701
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 12:53:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iZ153iG5vyGD for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 12:53:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 66D4D81753
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.180.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=oJkVc+tH; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=c8yCqc7Y
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 66D4D81753
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 12:53:03 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A7C0BCC1626460
 for <u-boot@lists.u-boot-project.org>; Sat, 7 Nov 2026 12:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Di97Vkv3xnSlpeBXKuxrZqcvYdyyC1qhgcf2hsF9CGw=; b=oJkVc+tHO7QBf3J5
 NusqbW/fWwiyNxbHfmN9SPz7x95hWA5ZfkV2WO2T+uU2ePHyzup9Codus2bDrpvv
 oMYxlR6MpYKbvhVRwsCDy3OfqWgwfi+wiZ1dBLmdI/MIAKHXq3R16T79Rq0WeJFe
 Gkr1mMkd9lh6mI007V1BTMH+Pyxczn+ZIeBTnuVwzMMOoOgq3U/lElrLsQ7Z5YFi
 JRyajU7bwSo4+AdyhattEeqyYhX7EzEk4tfDPgU9dz+Y0NaESUFDtPawd4Y7ZTDo
 7v6kPeku+IKsYubkoiib+cDIKIlE+Ef76hy4+dAhFeLOT1r4T1XQocx4lkPWcABF
 JObpZQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsvc6gty7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 12:53:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f20addba1so321459885a.1
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 04:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794055981; x=1794660781;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Di97Vkv3xnSlpeBXKuxrZqcvYdyyC1qhgcf2hsF9CGw=;
 b=c8yCqc7YTIFMAiofs+Td5zLtHb3NpbhRuldFxqwBWaNYNpeLj3P3ipDVib1xr1Pkch
 kS5L2BYwq0eRLwxlcL36CiRdWbuSPWGoMlX+sZArPUyGCsT5gGPs2uAcBs4/ZlZvmCCC
 FZuDLrL9u24S1JXAGBdg+CO3cXgGoTXI9XU78URXORBrFJoJtjMl/DLhvuL67PFte2EN
 bFXj9watj5geeiM5v9AiX0pZhE9Rl51Xg/SAq63604HQJf25HqAtQSKJE/Aybbf1xtH+
 4gFxUbBEZfZQg+6TkUHy0+ci93Xk4ZWjMry4Z9hzTKkgX/vxC4HtXtWl5pULgoudoG+y
 CVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794055981; x=1794660781;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Di97Vkv3xnSlpeBXKuxrZqcvYdyyC1qhgcf2hsF9CGw=;
 b=CX304pph3ZDj9/wC1zNSV/g17gffCCFNEmDU2xORW6/kR5AmFzv1e/8kJzg5bRJ9ew
 /390rP+zAyx1ip7TQ7NmJsitdn18fdnwwVK88vN/mj+ROOeSjBbi9cTmRi040vda5Eub
 rYxa4PahwzcSymuEHMm1OrMYIrOZ9FhFtZyPOo4N6XawAiZQrYIt6/BC7rmRGFMzPpTI
 SpB5kjhX9J+AzIUJl128qx8uQLJq6kj1n1hAXg3WnPhtEFI5Pm/GRBEdOhOlWbWP9oJc
 GFJMiMa4sJwWTopjX1Ql4ml/mQ1dqfyXC5p0spxoOJy72EQLdYsAX/B+jthxRfp7Jf1d
 wDtg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjid0dUuUN2cWoWzNg7+AcS8+aWvIMVTZy4Pv5lp3jwfMlm6Nxas/TMPTcK5SF+kbKUEvZ6TI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/7KVACtGgHJ5rwzfLCzom0DW3L7TzPiIzMnlInrlrfUhQlu+zD
 6wEHl+MvpMqiIHqw98z6zfuoC6XPmDsYhBKitjNbhxFJdiI5IFB0JVcdWedu3Jfhn/3SbV6R9SX
 FwwieItk02HzJLuKuLZymId095qk+ZGR9KLZOqYpp+5lPu6ELnsrPFzMdygHeLW7mEji4Ssc=
X-Gm-Gg: AYBFou35rPM6OVzUDB2vvVSRsMVFwBqUvRLFk9qbKdACr1uA68h47zhFzDV1hROhx6F
 UGEfbZ89nBU/0iTyDJLZdSTcjNXqf23/PJk9IW18Mw0Sr6ttUZjJCMr7u7PhrCPSR6+Ab2vybpT
 QUv81+HudTo0ht4kocYhWMFGn6xaaNDkKF5ahj1RgiUDlNIb1gbF/1xcGzF/aK70GtbbIjok0DK
 1EYab3xIrM8abt0W52Wpd8scX4XAbfcEmnHLGOKlCBBCTwRx4M1vJxJtcNllkLksmPGrRBxjgAP
 hE5E2TaDob9MF+L/4qs388yrJ+R7osDGTJnKOTDT/0WI/+lTWPwJlAZpiSiWZdKo0JyvLqS0+hl
 iRsFRkcdvsTSRZzDt9jGYMzwiwsKINpKS8fihl0uvXuxksqJfYMgoV220Z4IArdurBONIlcwOEG
 V/ZrHKjkQyrCax
X-Received: by 2002:a05:620a:3190:b0:945:b9c8:de5a with SMTP id
 af79cd13be357-945f34974a2mr933945185a.20.1794055981374; 
 Sat, 07 Nov 2026 04:53:01 -0800 (PST)
X-Received: by 2002:a05:620a:3190:b0:945:b9c8:de5a with SMTP id
 af79cd13be357-945f34974a2mr933941885a.20.1794055980936; 
 Sat, 07 Nov 2026 04:53:00 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d356c3692sm148599966b.66.2026.11.07.04.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 04:52:59 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Sat, 07 Nov 2026 13:52:52 +0100
Subject: [PATCH 4/5] test: avb: test verification of preloaded partitions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-upstream-avb_tests_b4-v1-4-9177277458f9@oss.qualcomm.com>
References: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
In-Reply-To: <20261107-upstream-avb_tests_b4-v1-0-9177277458f9@oss.qualcomm.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDA1MSBTYWx0ZWRfXy9Sh+inUAFUB
 wMQYruj/3ehwoLVcdAQQ4M/wyR6AcecoBABxbxZnXOuH6GNKqPIdRwV6jClspyNuoM+3Ba6uyiv
 sUVVjEIQHLwNGE2w+o7ZEQAIHLihTTRWn9qQwyjVPV9LZlF5x4izB6gmJ3IHIKsiljmjDTjDm0R
 rTyTbKHMYGfDw4Tdwk1upMoy8bhbsa+en1YeAF5xmw+GHG4g0rxXmFy8umGKKpJE4mHfmTTZi4P
 5pql8P2n01TG4xWgt/5yKK5hiuOoWDnVYkb0lPUe4Lai5HiatttAd4q7PJo2UuyVkwRxcHCnSad
 MKAYQxcUEyp9siJ18Zj59s2KnKnw4fT/HXn4JLpPHHfO2WHZCQWzgHDgNPqUBepfdcrJLifmvkq
 VpYtyyXi7O4YNyfQxyNoz3+SXlBrnw1wssDwfZLMkRinWHNwOqXa2KTMi20pRDWfeg1TGyxSzzF
 Lw/nITAWT6rUYeZ85IA==
X-Authority-Analysis: v=2.4 cv=WOjqzXsR c=1 sm=1 tr=0 ts=6aef1f2e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=2LOtb7Bjv0pRYKbAxAIA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDA1MSBTYWx0ZWRfX4CdNGZuOHdyO
 auc05/pT2hHnJVNatCuxGzMOCYCFLL+SmGUQGD2Y6IVU/i8UXyOHWeaje7xWY8sXDTWnrX7ixEW
 CsavpvBs6LCtyzjCHzfFKvDX6sQzLMg=
X-Proofpoint-ORIG-GUID: 9_wTBsxPQ6OyUiclddnuZNvtKzwmmdio
X-Proofpoint-GUID: 9_wTBsxPQ6OyUiclddnuZNvtKzwmmdio
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-07_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611070051
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

The Android bootmeth hands libavb the buffers it boots from, so that the
bytes it verifies are the bytes it boots. Check that libavb hashes the
buffer rather than a fresh read of the partition, that a tail the boot
image header did not announce is read into the same buffer, and that a
buffer too small for the hash descriptor fails instead of overflowing.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 MAINTAINERS        |   1 +
 test/boot/Makefile |   1 +
 test/boot/avb.c    | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 76a06fbf7ab..f2469e28cfb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -121,6 +121,7 @@ F:	common/avb_verify.c
 F:	doc/android/avb2.rst
 F:	include/avb_verify.h
 F:	lib/libavb/
+F:	test/boot/avb.c
 F:	test/py/tests/test_android/test_avb.py
 
 ARC
diff --git a/test/boot/Makefile b/test/boot/Makefile
index a8803ded814..8214151bd1b 100644
--- a/test/boot/Makefile
+++ b/test/boot/Makefile
@@ -4,6 +4,7 @@
 
 ifdef CONFIG_UT_BOOTSTD
 obj-$(CONFIG_BOOTSTD) += bootdev.o bootstd_common.o bootflow.o bootmeth.o
+obj-$(CONFIG_AVB_VERIFY) += avb.o
 obj-$(CONFIG_FIT) += image.o
 
 ifdef CONFIG_VIDEO_SANDBOX_SDL
diff --git a/test/boot/avb.c b/test/boot/avb.c
new file mode 100644
index 00000000000..f2c3c58cccf
--- /dev/null
+++ b/test/boot/avb.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for the AVB operations used by the Android bootmeth
+ */
+
+#include <avb_verify.h>
+#include <blk.h>
+#include <dm.h>
+#include <malloc.h>
+#include <part.h>
+#include <asm/global_data.h>
+#include <dm/lists.h>
+#include <dm/ofnode.h>
+#include <test/ut.h>
+#include "bootstd_common.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/* mmc12.img: boot (boot image v2 with a hash footer), system, vbmeta */
+#define AVB_MMC_DEV	12
+
+/* Verify boot with the given preloaded buffer, return the libavb result */
+static AvbSlotVerifyResult avb_verify_preloaded(u8 *buf, size_t size,
+						size_t max_size,
+						bool *used_buf)
+{
+	static const char *const parts[] = { "boot", NULL };
+	AvbSlotVerifyData *data = NULL;
+	AvbSlotVerifyResult res;
+	AvbOps *ops;
+
+	ops = avb_ops_alloc(UCLASS_MMC, AVB_MMC_DEV);
+	if (!ops)
+		return AVB_SLOT_VERIFY_RESULT_ERROR_OOM;
+	if (avb_ops_add_preloaded(ops, "boot", buf, size, max_size)) {
+		avb_ops_free(ops);
+		return AVB_SLOT_VERIFY_RESULT_ERROR_INVALID_ARGUMENT;
+	}
+
+	res = avb_slot_verify(ops, parts, "", AVB_SLOT_VERIFY_FLAGS_NONE,
+			      AVB_HASHTREE_ERROR_MODE_RESTART_AND_INVALIDATE,
+			      &data);
+	*used_buf = data && data->num_loaded_partitions == 1 &&
+		    data->loaded_partitions[0].preloaded &&
+		    data->loaded_partitions[0].data == buf;
+	if (data)
+		avb_slot_verify_data_free(data);
+	avb_ops_free(ops);
+
+	return res;
+}
+
+/*
+ * The bootmeth hands libavb the buffers it boots from, so that the bytes it
+ * verifies are the bytes it boots. Check that libavb hashes those buffers
+ * rather than reading the partition again.
+ */
+static int avb_preloaded(struct unit_test_state *uts)
+{
+	struct disk_partition info;
+	struct blk_desc *desc;
+	bool used_buf;
+	ofnode node;
+	size_t size;
+	u8 *buf;
+
+	node = ofnode_find_subnode(oftree_root(oftree_default()), "mmc12");
+	ut_assert(ofnode_valid(node));
+	ut_assertok(lists_bind_fdt(gd->dm_root, node, NULL, NULL, false));
+	desc = blk_get_devnum_by_uclass_id(UCLASS_MMC, AVB_MMC_DEV);
+	ut_assertnonnull(desc);
+	ut_assert(part_get_info_by_name(desc, "boot", &info) > 0);
+
+	size = info.size * info.blksz;
+	buf = malloc(size);
+	ut_assertnonnull(buf);
+	ut_asserteq(info.size, blk_dread(desc, info.start, info.size, buf));
+
+	/* The preloaded buffer is what gets verified */
+	ut_asserteq(AVB_SLOT_VERIFY_RESULT_OK,
+		    avb_verify_preloaded(buf, size, size, &used_buf));
+	ut_assert(used_buf);
+
+	/* A change to the buffer fails although the partition is intact */
+	buf[0] ^= 0xff;
+	ut_asserteq(AVB_SLOT_VERIFY_RESULT_ERROR_VERIFICATION,
+		    avb_verify_preloaded(buf, size, size, &used_buf));
+
+	/*
+	 * The boot image header may announce fewer bytes than the hash
+	 * descriptor covers: the rest is read into the same buffer...
+	 */
+	memset(buf, 0, size);
+	ut_asserteq(AVB_SLOT_VERIFY_RESULT_OK,
+		    avb_verify_preloaded(buf, 0, size, &used_buf));
+	ut_assert(used_buf);
+
+	/* ...but never past its end */
+	ut_assert(avb_verify_preloaded(buf, 0, info.blksz, &used_buf) !=
+		  AVB_SLOT_VERIFY_RESULT_OK);
+
+	free(buf);
+
+	return 0;
+}
+BOOTSTD_TEST(avb_preloaded, UTF_DM | UTF_SCAN_FDT);

-- 
2.53.0

