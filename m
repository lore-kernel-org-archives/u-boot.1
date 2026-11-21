Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F82606A33C
	for <u-boot@archiver.kernel.org>; Sat, 21 Nov 2026 06:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=M2lAoHX5;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gPZSjCCJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LN6224gS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0945A81669;
	Sat, 21 Nov 2026 06:39:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tVEn4s9f3GcI; Sat, 21 Nov 2026 06:39:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F29F9814D6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795243175;
	b=K5lBzAGBhiKsp3xfuOZORq2926diJOJrhnV7Azp9nwLOWCxZMmeDNLtKdOi8KoMn9HEI
	 u1Za2DTDDj/407grsjzBACrD3UeoVJ2gX/6IVXg00VMljuvL5SOs8RbRP57kzsALkyiGZ
	 LapobTcLIuQm+1NH8tQ+/IseORGb9UVPjqPPb5REgvVyinWIWSpxxrNCACcitLwzhCWI2
	 cWoOtRyswZqZ/DxbZaAK6G29P8WerQgUK+S9rICUf4RE1XDIa1j252U9C7hwwhPhn4Gz5
	 67exu7Alj+NWVcyLL7nVZhGYFKMRLY63wm0uhpP85gYq3m0XGLEgnp6ptIm5uz99/nQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795243175;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:X-Google-Original-From:To:
	 Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dd6RFzdvtsKJ0LYvYGgVmRd3QGjEaZVwDoocYL6+lZc=;
	b=WKKviV+h8Pzg7OwouiC+L59jAKiO5RCdxYZz6pON9eGhoJLO6kAzSef8w8FzWy1TYD/m
	 TZYERLy+bNFlbweNkukf6b5dJ+oFhwSLMBi+G9E6eRP4hEYQUiywAcxaJuk5F0hP6Aivv
	 r2TMErQxR/ymIZ+StB7tLVuacC5ZyJKUjPDP0yOpIkHEogWpJqBI+ZoY9oHZFTuAkjnCk
	 lscx+ncfF+IL0ajeJbPf65/7N0jFfKdy8hxASZX18Z4/7xdPrO2pT85qFM6ojrorivu+5
	 FyzGaIiZ6bI7r2Wpe0xi9Q3cHPD+g6GozOYT+eWV2z0f2dXbROw9hT76sFqxUA5D0gg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gPZSjCCJ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LN6224gS;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795243175;
	bh=dd6RFzdvtsKJ0LYvYGgVmRd3QGjEaZVwDoocYL6+lZc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=M2lAoHX5Q9Ub21oc02l7eRCf+hmHstbPBIfTAHybnEsSTGQdS+fvhW7fYGbI17Lx/
	 2p5SvMOwN67H8AFOSjTqHb8zKWS+2PELWx7/m0rX9tWACZ5rR9FpTcFN1hNfumOSZe
	 ajNcEQe4GAbx5X0yUkpx6ee7CAPJJCyRYw8804s7yWkjuJ8aehh7Jp2ySIrTHmy4SW
	 XhiTPOnadf5AOK/E7PCUM51b7PKY9BZRaLZzSokOQRsvJHtDmJSynLmMadKbhJo8bt
	 X5sM6fNB9Pvc1HalXsBpbtTIE4mgjn24XvN4iHr+7v0AJOxgghT1dljWESlKhxhMca
	 6ZVapuQXZWC0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F29F9814D6;
	Sat, 21 Nov 2026 06:39:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CCD471AB
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:39:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B3917814D6
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:39:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TqgWoS0hCL9d for <u-boot@lists.u-boot-project.org>;
 Sat, 21 Nov 2026 06:39:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A4C1F80F7B
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=manikanta.mylavarapu@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=gPZSjCCJ; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=LN6224gS
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A4C1F80F7B
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:39:31 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AL4Allt475515
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=dd6RFzdvtsKJ0LYvYGgVmRd3QGjEaZVwDoo
 cYL6+lZc=; b=gPZSjCCJ54d5a6bCjs+0ktRBkTEfwHVJA62vBGwejM27TVsyPmr
 23Wx5EvgTLGUpUNZOCJVwNaXqqutNgO859sM3npY4g94xd7D13wYr53j5pAlDxDG
 a+swnAxMH5+nChJmy8X0E0BuMCf3bshVnM7ftkElk4XT/lUKFY7jljMFI/qwwk35
 0TLtWgfrPcRqw8rzdB2WCAntr6itQjgr3eyigE63r4i3cdTBYDcqLOF3AWHOSjKD
 Rwkv2q7WSaidY+D/Tj62kDP/4vR8HN74OT4XuApk9fzwyvF0wC7bvE4uS3Hwuy5l
 esvPmvAM7PDTmesp+YqtCO397H74FebLjQQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j310f8p4e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 21 Nov 2026 06:39:31 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-375bac6bd21so1788255eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 22:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795243171; x=1795847971;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dd6RFzdvtsKJ0LYvYGgVmRd3QGjEaZVwDoocYL6+lZc=;
 b=LN6224gSfly2bxupv/hm5MSVjHFP1H64uU9X8PbbGqm7ovbGp80F0HnkkSTHbGBkP4
 mIZcdQqh/YmOM0kTH0NS6U9EtEWl/WNAQKKQ1r6hV0K065xZRYlbUrwI4hd94jk8W1Du
 NLnNVnlNnzYNu1/HJW7Rrn7V2RO8HLG9mDgxdF+pkQjKfl79p6i4ND4V7OgMv+J0WGlm
 ofESv1sdkM3u5mr1WVdU6kGPlr+pCYFdsIqrJtV0+vvqwBukMcmPVbGwosN3c7UO4EFC
 7N5rxjYGnNTAoG0jTd/SjBnqmveCUhmkwD06nILt+KAuR2c0ZxKZb4RKNt06zyMqTDXO
 B1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795243171; x=1795847971;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dd6RFzdvtsKJ0LYvYGgVmRd3QGjEaZVwDoocYL6+lZc=;
 b=WVBWJ+Zme8G7+8Y12hjI1xD4HcO3O9WXEUOQY1A5GFovbCRjLUZzvjqR/LORBl4qFg
 qK18WoLVOhktcYX14CXIaNmJ+FIOHFrahOfmp5X/Pevb//2XyFLuLSIcKLnPz7i96zdt
 qubjpWWpVpBxjxX/5bnpeBa2JN/Yu48exuJBpLFDNXAQYJIHEum5dbwALsr2bylbhZjg
 uydeyzaQWi6gwUGjIyk7sostMyBroWPbxsAfY0+If3RylazqLPlgHYR87vq9tIWYulzf
 HbEi0awyjaxwQcPwUwFKkML6fg4ucUjNNtoGeotJn0VQbDpq58/p21lBlL4dLZkkICkr
 0+Uw==
X-Forwarded-Encrypted: i=1;
 AL+hErH44NHsASV7xOcEyzX+65TqA8wk4dkoBRyo7CPEyqDWSNhxCunMm9ci90uWuUWk/mBdzRklP8k=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+kX8jZFEhfSRHhcELy+c1u7kmXaLIC25yL48mzDDTEmjv1x9Eo
 D48O3oZDkRXc1/upAKRI05GusodBEqMTPJOhJbv3f9Lbc37s/aXXA2RmJYQ1dfvD2JMRjY3nITr
 KPZYGN87Y9HOQuGu5uR/Azzg1zHmfnS8+WYgBX0aPHhf9PYnlSlX9X/7Ej8UzhMiD0rJVIvk=
X-Gm-Gg: AZFdTZcVT3786z3q0+dm+/u+d5jmZgETQpBUdXFEtV8szn2kuVdpqAH4XgPpxHB/nZF
 UGT5lECPrNwv5TtOS1avAZ5r3L0H1rpyj1r4jcfsWWhLFzlHL6O/ERLdWFLvg1kUkvf7Y2FwSXh
 J/+uimeIIgYICdRlwSV/8OKn6H/UDD7tyJbMapySvRJ1+nrF3B6qFQ2XOdayIrnlmEy9R4ZI+U5
 Gi/BfKlDwYmkttvUG8nydvgjkH6bn/x95wRyaxNcktmHpDft7T+WO23IQKMCHDiQelJTVt2KvXA
 CYNqhUykYSAQCKZVJOKpVrw9ec1anrPiG9UHvfvjxW/Kd0jWx/9YTZ6q135jSOZ0RVmk8oyDhRf
 hgSYyMIU1JMGZwa0kviQ0lr2vBIQQQEePgOvc8E5/rm4YTORMqjRTJAhi1XooZN7ZgJ8ZqucBd3
 Cp
X-Received: by 2002:a05:693c:88d5:10b0:386:9e9c:867 with SMTP id
 5a478bee46e88-3869e9c2df2mr628225eec.10.1795243170547; 
 Fri, 20 Nov 2026 22:39:30 -0800 (PST)
X-Received: by 2002:a05:693c:88d5:10b0:386:9e9c:867 with SMTP id
 5a478bee46e88-3869e9c2df2mr628204eec.10.1795243170030; 
 Fri, 20 Nov 2026 22:39:30 -0800 (PST)
Received: from hu-mmanikan-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566cd46c5sm16970487eec.11.2026.11.20.22.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 22:39:29 -0800 (PST)
From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>
X-Google-Original-From: Manikanta Mylavarapu <mmanikan@qti.qualcomm.com>
To: trini@konsulko.com, lukma@nabladev.com, jerome.forissier@arm.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, varadarajan.narayanan@oss.qualcomm.com,
 balaji.selvanathan@oss.qualcomm.com,
 manikanta.mylavarapu@oss.qualcomm.com, deepak.g10@oss.qualcomm.com,
 dlechner@baylibre.com, 3305708832@qq.com, jstephan@baylibre.com,
 jbx6244@gmail.com, dlan@kernel.org, anshuld@ti.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
Cc: kelam@qti.qualcomm.com, gpotnuru@qti.qualcomm.com
Subject: [PATCH v2 0/5] net: add Qualcomm SA8775P EQOS support
Date: Sat, 21 Nov 2026 12:09:14 +0530
Message-Id: <20261121063919.3313168-1-mmanikan@qti.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIxMDAyNiBTYWx0ZWRfXymcqnjvmUynh
 t5+6ZnfbwkASyeQt9KyXf1NPZsli1ZQNGZjpkYwmc72cNp4OYPcbRojToO0dIu8fSHimYBwJHaL
 9At8pyEAfH5qYibSXjhp3749lG1WP7/yp7D5oL+HbWKC4BIsVX/9z6+J2sNZ+kKIlWr2nU1HSsB
 MrsEaQJXy/QwStg0RVcSLZ6D02JzD9x2D8tW+VAFa49jcE0FeURFsYIKQadOEu2zq1olo5V+tXT
 mK6v+xTQVklBj62aahQBYKOrLfe8M8NnslSMfUPM0CWajjD6rMlxT1kvIdzHGqb7hrrU9CL+vOK
 TyXoYh3y1IBaoGpG3XepmSZjR7/cQKJzlQIyLXCC3MMzDj60hFUpRc5xXm1ne9eesVsvLE1SdcI
 OPY2PX0pY0MQmQTn9Nu8vGifMHCL19Y2ymzqwVTwyQmnJ6p4xFCHvWaEDV3xPviNXFM4spwSDQj
 t/xqDZWxI9vRewBwM8g==
X-Proofpoint-ORIG-GUID: UXHSImwiJMAmVg_8hgc4bdpFXZZ9uQ2H
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIxMDAyNiBTYWx0ZWRfX4I2DDW6CGh5q
 X4w7Myc8DgSOkXS+oYVWU3HKYlXr/ZCxGk321jyBypYjHTRyhueNk3YQD7AxyPTWCSNbVtMy/aC
 yTseiGz6mVQbAHYj4SFKTxCMsSVHD6g=
X-Proofpoint-GUID: UXHSImwiJMAmVg_8hgc4bdpFXZZ9uQ2H
X-Authority-Analysis: v=2.4 cv=UN1Ijyfy c=1 sm=1 tr=0 ts=6b013ca3 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1xilXWlzQkcr8tkQ2YkA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-21_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611210026
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Manikanta Mylavarapu <manikanta.mylavarapu@oss.qualcomm.com>

Add support for the DWMAC Ethernet controller and QMP SGMII
SerDes used on Qualcomm SA8775P based lemans platforms.

The series adds the required DWMAC EQOS support, including
platform-specific DMA channel and MTL register offsets and
2.5 Gbps link speed support. It also adds the QMP SGMII
SerDes driver and completes the Ethernet configuration for
the SA8775P-based Lemans EVK.

Dependencies:
https://lore.kernel.org/all/20261103-emac_clock-v1-1-357a9291d35d@oss.qualcomm.com/
https://lore.kernel.org/all/20261104-gpio-qcom_spmi-v1-1-2e430ec0843d@oss.qualcomm.com/
https://lore.kernel.org/all/20261103-lemans-ethernet-v1-1-cb7c648e5c78@oss.qualcomm.com/

V1:
https://lore.kernel.org/u-boot/20261115181936.1750625-1-mmanikan@qti.qualcomm.com/

Changes in v2:
- Dropped the Lemans EVK DTS patch.
- Updated SGMII PHY SPDX tags to GPL-2.0-only.
- Used the yearless Qualcomm copyright in the new PHY files.
- Removed Linux references from comments.
- Shortened or removed verbose comments in the EQOS and Qualcomm glue code.
- Removed unnecessary braces reported by checkpatch.

Manikanta Mylavarapu (5):
  net: dwc_eth_qos: allow platform-specific DMA channel and MTL offsets
  net: dwc_eth_qos: support 2.5Gbps link speed
  phy: qcom: add SA8775P DWMAC SGMII SerDes driver
  net: dwc_eth_qos: qcom: add SA8775P support
  clk: qcom: sa8775p: add SGMI reference clock

 configs/qcom_qcs9100_defconfig            |   1 +
 drivers/clk/qcom/clock-sa8775p.c          |   3 +-
 drivers/net/dwc_eth_qos.c                 |  51 ++-
 drivers/net/dwc_eth_qos.h                 |  41 +-
 drivers/net/dwc_eth_qos_qcom.c            | 276 ++++++++++++
 drivers/phy/qcom/Kconfig                  |   8 +
 drivers/phy/qcom/Makefile                 |   1 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-sgmii.h |  21 +
 drivers/phy/qcom/phy-qcom-sgmii-eth.c     | 486 ++++++++++++++++++++++
 9 files changed, 853 insertions(+), 35 deletions(-)
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-sgmii.h
 create mode 100644 drivers/phy/qcom/phy-qcom-sgmii-eth.c


base-commit: 990319a87e60fbc2ac26a386f2ec940e4f97978f
-- 
2.34.1
