Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805A9606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 02:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wIoNowk0;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U7LSxw5p;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W4AqEb9D
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35CF34099A;
	Sat,  7 Nov 2026 02:05:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ifruuDhCp0Ls; Sat,  7 Nov 2026 02:05:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7F1DE409B4
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794017158;
	b=RmLIzGM4i09Z3TaUz2ySziLItdFy93gToBHUfVRlpI/S3r/ZeoIMh41zqjDwBUrZd7Kl
	 l8gnhZle5onvfA5SD8MO7IFOcoC20/kJbV05PTs+TGiMhio3xX1Zbba/FmApeWU3MCJ/Q
	 M2iUWljcVHIxQM9z899T4Z7pbyMFDyJlx2yjKV7K3AdLZh3yBtRVnBFSwVpgad+xLm9HY
	 KslXu3iaAtZpE9aU0znM72QbO5Y80/Wbqqi7UxIs4bv4Z1LBXLOrz2705QXIXC6h0M7G3
	 E+AlId00DupVM/KbiA0G2fH/cnTN9xj+qb9xEtvpSNfG3FUOhG4l6sa27aeUbc43DBw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794017158;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8mUWQawhPoIMEVWwSIfvCUsZ7MnFUoBFzyJbrMJBNIw=;
	b=k/FCHcKvvxz/YMVVk6m0UuDC7IqkudeYbtMea5mG8cVTkHEf9CkOoyXfrEjI+5vZnDKF
	 stXYDZ4SE+nMbkCUESNquua+J31iZn0wrAAJf1HwaPp1VYbmM+7FNGfr0Qc+H8atDt7X1
	 dhZX1Ym1cqvMNUh/W083wvGphqgPlaCHM5vLLiiO7kZ+c46IKA1V/3+UFvRNpwmD/Y1rc
	 vY2HZJr9PJTR1oZ1HmJhlXrHzo5t2fT6d1PWUEiq1B13olgoZXAHgDGlTI9jX7ODwejkF
	 4DfaVCBN+XnBETkyJxClVvhQhQoW0x8mzizZcttlpasiwMV3Xl3YCMf0hbpzlelOhPg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794017158;
	bh=8mUWQawhPoIMEVWwSIfvCUsZ7MnFUoBFzyJbrMJBNIw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wIoNowk0WGfj0wVIupMvOHaQaQ7nE5Lb0iJpFeMzUrkJdpc41/TCiATi4x/96CUVZ
	 NaHW62cVvZRQaJQqxHNSyxXUX8NY+PFApRlArLBKlr1T8EjEVa/KNPScd0qpqxWpOL
	 Bmgu5PTWf7BkpCMApBWJ9AB4iO1Q7RDAYCYcYhwWQgid+b4gk0vwGzt1aD51Ewnrwr
	 gvhyCNR2La0qaz8UdCYR7CTJWK0Oq77loPscU3qkwV9V44E4i9Dlp/kF99bh3cXzmq
	 8/hKsiYE8/Y9arPvki0N+Ph86rgwQclv7//nY0RkwXcR+p4h9lQu5LAE4cUTM9UwmQ
	 rjepy6KdA1FPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F1DE409B4;
	Sat,  7 Nov 2026 02:05:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C89631F
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 02:05:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E734440086
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 02:05:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TR8AIbcCBThs for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 02:05:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5EFFE403CB
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=urvashi.sharma@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=U7LSxw5p; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=W4AqEb9D
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5EFFE403CB
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 02:05:54 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6Mo7i41064710
 for <u-boot@lists.u-boot-project.org>; Sat, 7 Nov 2026 02:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=8mUWQawhPoIMEVWwSIfvCUsZ7MnFUoBFzyJ
 brMJBNIw=; b=U7LSxw5pwLHgLkTOGJoss5dslnRKQuIscV6grdhtGp7wDml74/Y
 H80960MXz7AvnaX+R8mzr8CcwXXOlkNY/4Ih4xzN2qfvOpFQ8HUvFLvvYiJFQUq9
 6/8ckORD/L0q6iALYRgOyNaulqz3YcIYOMyFM8Ch2rW9ylML/WoLou6ftwnpPwHO
 urb+vaZ6B84y5lv3UNEvcXyi+EJ0qjzY+goWp41m0yA8mjiQhC4thq2ZtilkdNJN
 6Jak69qB3Dy3vbvynvHU2zgEHSJhSOYg+G2y8TMROAq9mwIbTuvQFA8bbQ6eL8LI
 cxNmSC9DnqzpPmWdxqheMR3UOaQigM9IjEw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsmyv138j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 02:05:53 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36f1e7d9d4dso2513775eec.0
 for <u-boot@lists.u-boot-project.org>; Fri, 06 Nov 2026 18:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794017153; x=1794621953;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8mUWQawhPoIMEVWwSIfvCUsZ7MnFUoBFzyJbrMJBNIw=;
 b=W4AqEb9DWJVrzey5hXM29xRb9hT3ZLBmGT20vGRTV9y+UMlmVIV6NUpcCxMqI6Rj4v
 t5I5WRhzxDYTveEnBQVdflHtjNfd7GIbIyszbynjMIuIvhEhnobTeaENlWVaIbtJ4mWk
 9COts4TMK02GLhgb2sHQp2xhoxddvNY2pwKCtqscNy84U51x9zFE+USA5+WxVWp6GVVv
 HHlFPzLQgDMg5zI0dqtnblfIiO9FTLDAvxnH7zQuid81a68l/wDhov6EaWGkukfrPPwl
 +jbSqTcZecWqZRspGJRNnSyQ6CSj0Tk++0lq3gkHqLbz/VnDYhIuDlo/frx+YhIStFQL
 QfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794017153; x=1794621953;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8mUWQawhPoIMEVWwSIfvCUsZ7MnFUoBFzyJbrMJBNIw=;
 b=eQ0ZJlZobBusT6CEHdWPqBBy3cLTRqzp9K77O4rEFJAb8JTfWm1QVWexgTl6qBHhyG
 wa62QJUWdfCbvkEubzIt56fPh61hgkrazx7Fr11M9+4NeXpwGSvyPW3KtGEw/XYBBray
 LRmCkMWQvCcktAps9vSE3G3cyPbvV0VQpDKzh3Bu3PVE8Ipr+2FpFfF3bhw7EAOgS1IJ
 pa4/4A4BwHzz2ohWpUNTibfCd9OAWSq2cx776Mxu7SJ8YZ5iBQlRcIyQlpPuZGCdEQak
 mNYqUX3oX3APBpdNl+1bhfZ1mnWZbeyDx+lVGyGK4o2rors7c0QkPb1Mnq8QeRSkSQj/
 KCGw==
X-Gm-Message-State: APuU4Z+jYYXg1ZUDPc/zFhMAqhhWJlsISexzN753Z7fVSL6ur6lLm10I
 lfqrxP1WJJw6DfnNLum2IlX9nzNdhdoRhOdONO+hPLX4ZRRwqposiFbTfhqfBLDGKqOJXXhfGo4
 XNw5ivOXjVQWvl/HACbbJE2orKPd9Nn+MsenRcQXMa0OB6mxUzCJe9hZmNPswB3rsKFhaPNpJzz
 bhYmU=
X-Gm-Gg: AYBFou221yuDe8JhYId13pchSOv44A768K2ewFn3yhPNKnHcgGflsYwPUxxgXMLewT7
 bZBqRVKnakxqD6IRrgfs70a4E9TheaNKgu4P+js5kIla8qjrms2oZZfgJp+JiOl5WlnicmzB3zc
 ktDOypulpGLbSwWTGnV5yPVtcLIt/wIUB01iorsqYiahHn84kWLCNDEVw+3U59z4UZmt4N00JXY
 u9CaWWz72M/fAlQS/EhEro667tSj6YmLUXJXUkk9zjvBzNV/4Q6fvDokVkT0StkqqbFEdm02315
 VMXmiVVqUwSuS0mOgUBmVw+nyjt934a7V/zRHbs1lZ/SqKaSqrZG7Oq2DYegf54XstfT13nwydY
 5qPjih5V0bcmPC1mI2xGzQQ99k1TAQihZya0Wwq3qV1tYxV6ZYOTJgujW6zcpxoxH5fy3d4zAP0
 JzwJ3BRa3OhPDZeVam3K6+Yc6EI+nWxQ==
X-Received: by 2002:a05:7301:1601:b0:36e:dd5:fb08 with SMTP id
 5a478bee46e88-36f773f7c7fmr5451550eec.40.1794017152935; 
 Fri, 06 Nov 2026 18:05:52 -0800 (PST)
X-Received: by 2002:a05:7301:1601:b0:36e:dd5:fb08 with SMTP id
 5a478bee46e88-36f773f7c7fmr5451511eec.40.1794017152255; 
 Fri, 06 Nov 2026 18:05:52 -0800 (PST)
Received: from hu-urvashis-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa8d44500sm10922798eec.5.2026.11.06.18.05.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 18:05:51 -0800 (PST)
From: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: trini@konsulko.com, rick@andestech.com, ycliang@andestech.com,
 e@freeshell.de
Subject: [PATCH v3 0/2] riscv: spl: Add BOOT_DEVICE_UFS via common
 asm-generic/spl.h
Date: Fri,  6 Nov 2026 18:05:45 -0800
Message-Id: <20261107020547.2021618-1-urvashi.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JFQgiAUE6YzUYliWefj4PVRLGcgtH9bx
X-Authority-Analysis: v=2.4 cv=IdYSymqa c=1 sm=1 tr=0 ts=6aee8781 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=x7lnOLRdgEZdsa4TSNQA:9
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAwOCBTYWx0ZWRfXxsj6LkaOIGXP
 GvMtQS7bySf50beIQyXr86xWO7X29EdQItb4UXbtYaf4PhOEeNvMj/ePoxobTHOGUxj6L8RMM+2
 dhIk5oBqI6KJc96/ahfXimdAAZteoIo=
X-Proofpoint-GUID: JFQgiAUE6YzUYliWefj4PVRLGcgtH9bx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAwOCBTYWx0ZWRfX2uTRXyOP6xEX
 rrdyiJUI3ofQHEp7g8iZD9NrreVQZA0Ha7o6m2jI2bF3hHDYKSJXFRDwjYsLduFniwOUmgLhnbu
 w2QHs/sJimXo9JDwMKv8YsyJgfH7UswHGLTzq+zwEGN/IpDlNSNQ5N29RAewaDkFGab+9UqMx8j
 CYyYrOXn1f6RhCu7zlFKyxtaN/HDghxPKijidSmWLJM++MQ1/BQKOzqoTdzp2gQFf3XUiCDXQhM
 V+17ws0MsvlD1UFH4SwdxZkFrYVA0+02Lbe3+BJkNEq936wSnuckFCyPuaecSzJsoqGysXVyaQo
 qhbDEBVq4nkqHArIMWOkYG5SlGjjDjAkrXExrirNFVn6QJiEiVnrcds5toddr3K1UjzFcDYBuIC
 OTbv/4DIQw2+v5kt9yvf/lYmM8L4DadAk5yLJWINOtid2/Oz5jEj2Lym/NtqyJCX1rzONxmoX9X
 ZPxsA47qN2d0MUD8WFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611070008
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Following Tom's review of v2, add a common include/asm-generic/spl.h
with the BOOT_DEVICE_* list, use it for RISC-V, and then add
BOOT_DEVICE_UFS to it. Other architectures that do not need ROM-defined
values can switch to the common header in follow-up patches.

Changes in v3:
- Add include/asm-generic/spl.h with the common BOOT_DEVICE list and use
  it for RISC-V, as suggested by Tom Rini
- Split into a move patch and a BOOT_DEVICE_UFS patch

Changes in v2:
- Add a comment documenting that BOOT_DEVICE_NONE must stay last
- Explain in the commit message that BOOT_DEVICE_* values are
  SPL-internal, so this is not an ABI change

Urvashi Sharma (2):
  riscv: spl: Move BOOT_DEVICE enum to asm-generic/spl.h
  spl: Add BOOT_DEVICE_UFS

 arch/riscv/include/asm/spl.h | 22 +--------------------
 include/asm-generic/spl.h    | 38 ++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 21 deletions(-)
 create mode 100644 include/asm-generic/spl.h

-- 
2.34.1

