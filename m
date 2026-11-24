Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29607606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Hk2qhHhE;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WJDqHXuD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ibMpIxlx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 023526086A;
	Tue, 24 Nov 2026 16:30:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 03fOzGegFv4k; Tue, 24 Nov 2026 16:30:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D93CF6086C
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795537807;
	b=CPVkdPN1hMC8mRKCnA60esuYUkHyz7JCnBp7FMnN4n3G2ZxeaK7xKnaA0I3BacXnhiBs
	 W7iMAwpGv8CCNcefEmiEAZzg5JZj7FSLklEndeizCd25DT/mUrMnK3z6fXEcD8AJ+P08r
	 5CU8B/M6H7l9HCLTjGqvPOhWUxh7DLTXDbCZlyf0XwByst0W+paZFkaQyK0yRGsMjuViz
	 wAlE5QQgGsVzyJGuhMfLL7sTxD4l6LDT/u/qWVQ+mopuN+HuyGukoBeqWLs2Y+BPlK/T1
	 Wf29aaw4e4zJgaRrw7SdC0gv8sVWbwXvpeCRRwyww6gry42WnTekz4BZWqAoXD+Blqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795537807;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WUaNTWeD+U3a/YZs4TliiaYr/I6fZKZx4fXTkcc/1h4=;
	b=eTAy/ANt8yCB048FxwOiWtB2ZV2Zz3slW6MtF0a8RdWa5haiVqc1beq0W78ZATNznsQq
	 IyYwNSUZPDpAbvok3JxPg+aRcJbxJOMbAdt56c5H2qXxS0ucjK1cAH75n75bwPtCT37BV
	 TENEv+4AXbTCVoxQhx5/6ygyegU7dyn6rktygMaHJCfcgZfCPQV9xYWBQSMdEwKOlS1AS
	 VdBQCRYWGvKjMOzBkZEfu/SzOC5iPAoXk5nsfZnbHcFyf7X5/FZRgE9iDY2nzTPBXKwkY
	 ZCdc4ElrZY834G+7zOqpKcSYlvE2VDYAY6y1YLr0BkgNHp04BTIbsycWIxY+VWBYRcQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795537807;
	bh=WUaNTWeD+U3a/YZs4TliiaYr/I6fZKZx4fXTkcc/1h4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hk2qhHhENCHCoKEY3sj6451VAVT9zUk+Q6x7N400aD+27vmfiCPXWQQv7N8W3jI4i
	 5zdU0Ts2rautS5S7hiwQQ2dfszsO+09sbC3Usx0fFNi7qzZyfpHXiGJ/cFd3rM5tzY
	 Abyz2nDWp4MvWTfaT8yG8TqBqBUJsDekw/6UQOT5J7IDrHTe97k4TG0eloClxuEECg
	 3kHyV4IGEDTkarp190ly+qgRD4I0VdbvjCmagbjnf+f0DqmWIgacxwXlymYCLa56aW
	 XRJ3RM9MVqFNwiwejrsUF/mdRc96AhHvQ0081WxwvGwmfCK/t7hS6b6qToSTE1etMN
	 XTU1x72/NP2cQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D93CF6086C;
	Tue, 24 Nov 2026 16:30:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 189B4499
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0A6EA80C46
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cDg7VMmxMTQF for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 16:30:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E76ED80C43
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=WJDqHXuD; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ibMpIxlx
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E76ED80C43
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:30:00 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOFtp6p1684154
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WUaNTWeD+U3a/YZs4TliiaYr/I6fZKZx4fXTkcc/1h4=; b=WJDqHXuDIZ+qPl6B
 O3A8d9x+OeIoGWkya6PPIT4rPP2WCcM9AVyP7ssK28wgTJaqeUcn3v2CMNjexvdh
 g8mQOTqr0YUWWgpOPcjiMttFz9ogpddEz0J7BKK6tEKGbL2dqL0AxB9XTK+TICis
 7t8XRO0+SlRGAQwz/qug7/o73PXkz95+FvxQLzgw86inHoHXuB5mvaigVeOoCL9S
 po2m0loRNHs+YCIldlUjj4CAgldxEtCXM93VuUxcdzAwtoUHe7xR+gnGYdVm3iHm
 fZNe7vYbdBSsh1uK7LkW6q8AIcDK5ulX2Bc8Sw5pATsAy/OWrkrZHfaTBdoYBJBp
 IutvjQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5dngg5fv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 16:29:59 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5ece5510b79so3244913e0c.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795537799; x=1796142599;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WUaNTWeD+U3a/YZs4TliiaYr/I6fZKZx4fXTkcc/1h4=;
 b=ibMpIxlx8iTJmdNsQkLFqo6x1q1mgPl8+j2usbfUVul4DTDRYM0RsWPUUu953OpAmq
 MfTFGUswlgozhsXIdWkDDKYLQN4tFRbgdlAGQlWxNMyPkn6q+V6nh42utCta/s9wlYQF
 EY7LMKRtGKcXGSxmJ6KFKCskSxDUe+MGQ5qVeiSLFhmmwE1k5cKPvCeNGaw4sZic0cI3
 oQ975iQf29/LXjEf3MqO5cYdO/NwZwhX4eenp9H0JObaXdh4g7wgTIcsLKwYnx3A+8Oc
 BYFXqkiNiO0bVWhO1IMNYlu5Xrsb/f5zxgsFli6p1sWIQgt4eSMJKDa1Az8nXRpUwcLr
 yjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795537799; x=1796142599;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WUaNTWeD+U3a/YZs4TliiaYr/I6fZKZx4fXTkcc/1h4=;
 b=jXLOYEtUT4x52zzZRUF7RtW00oc3d+1kOngLU72I1SJxsQD9YhBjebZPuhdvZq/ivb
 HZKidw++mVWwWWUXECCCq/0F1K2woMCw/DCrgWmZX8te/PXLl1Zn/3wxuT3etyGk6z2q
 Q5ob0EvptXYqit5OMrQhYv5YWgxyoC1MyNjxxZ+VsurJSLoI8Yj6wjBKQT3ZrZ80z0kD
 IUlVXIvX5f46iODKXAIxTEeluuiId4/hkv1vfqP8LwFhr7Mh+pj0eCislEl4FvSRELiM
 io90bXT/OPcgV/Ydsu7MsX4/JetLVvRhsNTGaWyoj1Sv6+awnZ+5uYEqyalH4cPTWaCm
 998w==
X-Forwarded-Encrypted: i=1;
 AL+hErG8u0edClVS29h5savxALo13h2z8dhZcblhVvi+J9/AUGG3/Tkf05R5Ll/IIMbYuvVM+WpD5iE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/fw25tJtZHE58/URFkqmDwRXPQ0ydHDti++e25IxW20+5SSRmc
 ONjdG/AtCgCU87RrHJOtY64/HMADa29w/iu3X7nClGhm8OeR8GtHOT1FBjxGWuRrU4i/Z+XTUh5
 rJdWHYqlSw+XmjZ0YetKWCfT4Pw7lUBfeJWZdYr2eS4lT3DIzlpDN0dKG3XcDswev72CTDi8=
X-Gm-Gg: AZFdTZckX4U0Yjk1qP9pq1KgY8mlV7hznS4lV1lppuZFinBw1OBkaIWvGC1PVwGEEhS
 hSKyQsjJ/5OuDzudo7inQC9wWOo2Sndg2mIxq9La7uflYOs9itZ8uINVkHlN+nNv8Yi8KwCABFn
 iwioAqTqdfqJD814P5wY3mhVMN22CIAZs/Basv8k1kxk/AJuNSyu1rBE5S5qpfwtkGswM+22shX
 owDs4KKUMYs/wuxl7ZdDv73vdf4BdS6easJbl2fnkvbgZlAP/cChw5axK/3EuLGiK1/cTi1d0eL
 XyPnXlj9PJ0kA5iRFaFdszG9avFX5cSeDen/FU9na8L8YSd7rEkRB/B9XdsidWk4qdtXX/GQKOY
 rgSvHYLnnSs4uK222koNq1waGG4JcAupTEPT+5d5E52QVxLPms3CxXrp/6XFd1dmWuVvY5kaI8p
 TeR4LUV/ENEl0L
X-Received: by 2002:a05:6123:14f:b0:5c9:c60e:3a48 with SMTP id
 71dfb90a1353d-5ee8afac64bmr8758007e0c.20.1795537798625; 
 Tue, 24 Nov 2026 08:29:58 -0800 (PST)
X-Received: by 2002:a05:6123:14f:b0:5c9:c60e:3a48 with SMTP id
 71dfb90a1353d-5ee8afac64bmr8757977e0c.20.1795537798192; 
 Tue, 24 Nov 2026 08:29:58 -0800 (PST)
Received: from [127.0.1.1] (93-159-22-70.cgnat.inetia.pl. [93.159.22.70])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370fbf0esm7058223a12.23.2026.11.24.08.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 08:29:57 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 17:25:00 +0100
Subject: [PATCH v2 3/7] test: avb: test the lock and unlock commands
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-upstream-avb_tests_b4-v2-3-ed7136c3767c@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA2NCBTYWx0ZWRfX/nJ1rSwmVbZ1
 U4wBoe2ZTZUbBMTemcfA6A7da2vrSvPEhIh8AcSlc19dfGJl8l+57hqTCXQEaAUJM0AFa/QCOh+
 jLZyY4sB7xoLyDmjoC9QBx522HJbEw4=
X-Proofpoint-ORIG-GUID: Y37UZ5xrJ6G5HhX-gQi0g7ehjaS29GmW
X-Proofpoint-GUID: Y37UZ5xrJ6G5HhX-gQi0g7ehjaS29GmW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA2NCBTYWx0ZWRfX1vZSmk7CfcmR
 U/sysQY2prVt90foaNwi/QW8+81uQ37JJn4XrZJh5QZxztaFMQQHVjiIoONPtuRuN44IDsnyxYh
 sp0yQTKXxXvUjcUHN5QRy3iAdyQ46rJm55GuHBn5c+V+1WmUtlLmdYkermI34HzDwDInq6ZtK2r
 BMKH5FEOfk8OkZOuDQYUC51Z1Xaggy67YC+R6hZy0Km31ynsIrTLE0WAO84A5yTYOe26TYE8L2g
 zYKwMT/kSN8XJYCBG97qXFd1PklGdhgKyrZ0gKmWjjukGlWCSPtW8jjL4ISClnoyS33k7oVu1aG
 5rKznkXj5plJn0xATRF55tahPOWt5GavLRIAFii9/z6tjxUtG2yx9oqQP035SUZk3WJRKlxXJMR
 A6QA4Z0yaVO5KF1fuVnlO3XdlezoKr4yGK0ovTONa7/v7IjLrqJvFh2tb6x6bSUPQQ8GzmKH9iA
 rh2XXBa7rJ/0ThXMevw==
X-Authority-Analysis: v=2.4 cv=U9cHnuru c=1 sm=1 tr=0 ts=6b05bb87 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=ySe+0nHqNG5yihRO1pIWsw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Oh2cFVv5AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=IpJZQVW2AAAA:8
 a=xbweEYGjddZT2bcmNIIA:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
 a=7KeoIwV6GZqOttXkcoxL:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240064
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

The lock state decides whether the Android bootmeth boots images that
fail verification, and AVB requires the stored rollback indexes to be
cleared whenever it changes [1]. Test both, and that locking a locked
device keeps the indexes.

The test runs on sandbox only: on a real device it would clear the
rollback indexes and leave the device unlocked.

[1] https://android.googlesource.com/platform/external/avb/+/refs/tags/android-17.0.0_r1/README.md#locked-and-unlocked-mode

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
---
 test/py/tests/test_android/test_avb.py | 53 ++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
index f48db30a30d..c5e76f1e60f 100644
--- a/test/py/tests/test_android/test_avb.py
+++ b/test/py/tests/test_android/test_avb.py
@@ -210,6 +210,59 @@ def test_avb_persistent_values_hex(ubman, avb_device_id):
     assert response == 'Read 4 bytes, value = 00ff0010'
 
 
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('cmd_avb')
+@pytest.mark.buildconfigspec('optee_ta_avb')
+def test_avb_lock_unlock(ubman, avb_device_id):
+    """Test locking and unlocking the device
+
+    The lock state decides whether AVB accepts verification errors, and AVB
+    requires the stored rollback indexes to be cleared on every change of
+    that state.
+
+    Sandbox only: on a real device this would clear the rollback indexes
+    and leave it unlocked.
+    """
+
+    response = ubman.run_command('avb init %x' % avb_device_id)
+    assert response == ''
+
+    try:
+        # Locking the unlocked device resets the rollback indexes
+        response = ubman.run_command('avb write_rb 5 3')
+        assert response == ''
+
+        response = ubman.run_command('avb lock')
+        assert response == 'Device locked, rollback indexes reset'
+
+        response = ubman.run_command('avb is_unlocked')
+        assert response == 'Unlocked = 0'
+
+        response = ubman.run_command('avb read_rb 5')
+        assert response == 'Rollback index: 0'
+
+        # Locking a locked device keeps the rollback indexes
+        response = ubman.run_command('avb write_rb 5 7')
+        assert response == ''
+
+        ubman.run_command('avb lock')
+        response = ubman.run_command('avb read_rb 5')
+        assert response == 'Rollback index: 7'
+
+        # Unlocking it resets them
+        response = ubman.run_command('avb unlock')
+        assert response == 'Device unlocked, rollback indexes reset'
+
+        response = ubman.run_command('avb is_unlocked')
+        assert response == 'Unlocked = 1'
+
+        response = ubman.run_command('avb read_rb 5')
+        assert response == 'Rollback index: 0'
+    finally:
+        # The other tests expect the unlocked state the TA starts in
+        ubman.run_command('avb unlock')
+
+
 @pytest.mark.buildconfigspec('cmd_avb')
 @pytest.mark.buildconfigspec('cmd_mmc')
 def test_avb_init_interface(ubman):

-- 
2.53.0

