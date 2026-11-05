Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41892606A326
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ft6WD+1J;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YCd4TFW6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=adDzSkeb
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0727A60859;
	Thu,  5 Nov 2026 18:26:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4M7xIueaeVfZ; Thu,  5 Nov 2026 18:26:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E321A607F7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793903191;
	b=hQnrsunnMvlMsUyAn3PVjXwJD6M14xYlAWsrwKAnlrbXXtlSiAyqprmvmPXbhWTA19Ys
	 yAH6AzuagF3AYcLtp+dX8yh5Om+nOTWCq8JJP91in7AiofhIws+TdD7hpmGiDYFnp3JXq
	 2pT3SrSTbP/0wySAzT3bfxU2T0fUa32Q9cxfYrwSwkk3dgUV1eiBIBUsge14NQU53gmR4
	 PN6ZLd1RZnkqeT/1iNS3H2mPvDfaTLx0jkiF9EJ+X9qvxAmT3HPX2+ojqyYfTIO+zkP/V
	 T1ikC2Zu9msQ7MRBGj0oeRsTCcDQBT9Bf5JMGVur73z4tSF/AuIqcC+MSSPli76IIWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793903191;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:From:To:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/VWW0y31KXKYze5NFoUhFmEdcgxz85AWtAfPH4swSf0=;
	b=OanDtotkVfI/RKjUK2fFLar5UVxd2/WAcJPdoC8dEjQhB5R32I+Ne2wTKB9XFdI7N0vn
	 D+dqlHRliBLFNKOhn+FflsRurf3GUYxCEgmz/QEVWdOpyBsRE0OhwotH3RYdnyEl8NDoC
	 VqvzyDaakp2O32CQee5TKEScKKHa0AuGX5n0Kl5JG+jZWNTjwci4uKLA5B4vWO39h9q1/
	 CKpc9jqHTqoC78A92W6K5bS+F1Fl16t1Ho5W9pQl0m7ldEGcEtgz6tW+TbPwCt5qYh9So
	 pQJCkUQwkGR3t+ttFwiz51cHTRYz5EGzl3AMesSUJcQeu9Kogj8i9OaSxXjHGqICcfA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793903191;
	bh=/VWW0y31KXKYze5NFoUhFmEdcgxz85AWtAfPH4swSf0=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ft6WD+1JkG/+ZD4GRMgqr6QwW7u32vMlOFq3bPwtUw3HX6W0n9er4sh6Y9/9Av3iE
	 BTsf7nhRaNgbCgF1vcemK1sh/D5nl5P98eaMnp9A2XQ4JNepwHhbjh5rpzPjP0Uyad
	 jRpdVL4W+R8x5wo1nb6d8pAUoOXHTCjXzBVDBJerjv9afWyWpVBhVdlulWeA72xv70
	 c1/WXzT0a4hH/+0UtgOEqft2K1ejmTvU9tAbeXH0ZydX7hxUPvnXnOpEB4QCv6BT1b
	 bCvtrHuDggaKbCkilcB6iTKgfM3ZHR5jML6X+5JE/+GLv1sgXsNNzBhI2ao3qwSio1
	 ItYMCfHYNo1GA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E321A607F7;
	Thu,  5 Nov 2026 18:26:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EFC6552B
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:26:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED035400FF
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:26:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r4RCwPxNaSs3 for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 18:26:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org ECCA240012
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=aswin.murugan@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=YCd4TFW6; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=adDzSkeb
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ECCA240012
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 18:26:27 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeAnd2433580
 for <u-boot@lists.u-boot-project.org>; Thu, 5 Nov 2026 18:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=/VWW0y31KXKYze5NFoUhFmEdcgxz85AWtAf
 PH4swSf0=; b=YCd4TFW6FAKezwW8XVvTi1GyYPD6Ap2oAuWCMgG7/kh28wpAefQ
 ViZDe0fuM4fKV0sPvyP0kFzKBfeSoOzL/cBxCCsqBaMN6omfFFhAcPxKg2kH/aXq
 DtC5qH3TYaLlHFmL1dyOWR2kPJDAvm6OVexVxzcEyrmuZH5+gEU5LGTZ9t+0CVVu
 i8wG+ore5dsiWCSFAbhsFPU5wQ6InS7NY1NksdXRv4cc0B+oLpiRW5O8NVP1lbt5
 3cv3F14t60IT1axVZFrB4xLUYL+rlmxxjnUq8ZifibgqM2jaBuvQ6n3eamHGZdTE
 r8yldnXR3jwcMK3QDHosRz9cF8ZeHA3ggWw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqpd2791-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 18:26:26 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so4123578eec.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 10:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793903186; x=1794507986;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/VWW0y31KXKYze5NFoUhFmEdcgxz85AWtAfPH4swSf0=;
 b=adDzSkebQWFqTQrXv8WBmIyqMzjM8+27fP5xNgkBTM6OrkRjpm1jZuDaInyMUrtYiw
 +koE0iPiD63KB+N4doNzCczXj0I5Lx+2Dte9VMGM7LSNwoMXHmKAvH/PH4fXWxWo+sGb
 yw9STn6DGzRW8t0HgsM5PK4yLqS4XqGNy8Ni4K0PFqLAMSlUNP04gjo0xPHXCXCYdtl6
 PjdwT9Sm/Kl/7G7eyHxJ71Y9tSS1bQ/2aLoqCJ+HnrlcxC4CFxcO9hNCRfJKyylplJ17
 iH+QSC0Mig1pBNyRd9/IEHIaRlhA/LBzGSL7PI/Kwlu2VQ3Td9rZQPtLh7Xr4+WE1gm7
 b8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793903186; x=1794507986;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/VWW0y31KXKYze5NFoUhFmEdcgxz85AWtAfPH4swSf0=;
 b=o+f7EyYKhiNkJ2/ykFuCb1YYQEMlSafuom8mn1urZYCDeJosxedEoRRaCc9Ty/puY9
 5A2OwhUVVZrIZSl+n2IRVxYm/clqo3WDmo+KRZ06A8KODmXMdIGaCGlC/wiAmxIrlfhe
 eHJhWaCVtkbzq80Lijqe92r65oNC115REXPM1s9BeNXHxkDj3u/pDWLjrDfOir69mZn4
 AtiFmF8gYYea++vGQPxB55nKbPPn5irFaS7iZsmAjtPFkXGQW9uJDRSpDmNq3dczQgwZ
 AjVe/70YA0WBkcYphKYBzKVuxjrL3pj6Q3j7jWTFJafpWLTmsxN+FozIixvMKyZwVBS9
 iQrw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEbIw8HuZNY1Z56bTuLSnTnd97++68V2aphHVATtcfTef51lT9qh6Dp2OPHX2L/AuWB2ZlaG8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/ycDADGeWMyNkfV0W09nEGfmnfyyACbi/yzJyTrXXkf4bNB6hC
 UDORZXRIN42YBEIkuRT4rb2eq/oOXHj0GgzB3xrs3gDSQr8J0vpTAqZOKPrWMM43hHAL1fqdbF+
 ZkhhQwTK+aP/nLURWPotmiAWhn50tMxlS0bfldmBx+C/tysUkzCqdIDavAqbXpTqbVfl+dK8=
X-Gm-Gg: AYBFou2Hz9VyEpFHCUGjwmvT2vEUiYSzYAWt8Y0fySyL2QTnIwDXnE4EnhRq2/9d2JD
 tyFy6Kqb6A9iBr6VyPit5ab6dK56Mm5uWd6+w1muLGzcsJOK2cY4DRhoXAymaw1D80zdvACwApS
 yIOpfkKsfYsnpaWWsOrKxiiEpNQyDlgWfBqG319/1s6GihTZEL05nOqpsVecg2uo9YsInb7wMMM
 3Y5pY4QOenu+dlPFGshqP5HDFHHMS715jvJjztMLOtClYJwMLdVrUhKfYlP7dguVoUvurjGdGze
 29JYS0d9WidGmLSmIUvH8HVOr7QteRElSfep88qrb1GjuZ+1IdhbAqZVmU/6Ys0rerATtXJjojV
 bPLHgWGOvWT2e3x5G7xjiGfK812eAMPNwxWOJOVdGz3VgsQoa5WDd21haB0KwvmrHREXsxPpd9X
 xlhaug7uVI3njRHr4j0KeAM8htfl80L6fag2MHmPVQmJblQH6LNq1S5WrvBpho9NYseQfX
X-Received: by 2002:a05:7301:fc86:b0:36e:c07a:426f with SMTP id
 5a478bee46e88-36ec07a4913mr2038991eec.39.1793903185436; 
 Thu, 05 Nov 2026 10:26:25 -0800 (PST)
X-Received: by 2002:a05:7301:fc86:b0:36e:c07a:426f with SMTP id
 5a478bee46e88-36ec07a4913mr2038947eec.39.1793903184629; 
 Thu, 05 Nov 2026 10:26:24 -0800 (PST)
Received: from hu-aswinm-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36f6b2be5bcsm141198eec.6.2026.11.05.10.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 10:26:24 -0800 (PST)
From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
To: casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, lukma@nabladev.com,
 nathbappai@gmail.com, balaji.selvanathan@oss.qualcomm.com,
 Michael.Srba@seznam.cz, tyler.baker@oss.qualcomm.com,
 jbx6244@gmail.com, nikroks@mainlining.org,
 bartosz.golaszewski@oss.qualcomm.com, shengchao.guo@oss.qualcomm.com,
 andersson@kernel.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v4 00/13] arm64: qcom: Add initial support for Nord SoC
Date: Thu,  5 Nov 2026 23:56:01 +0530
Message-Id: <20261105182614.2405482-1-aswin.murugan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX8YdbU1+7LFKX
 LTlF6ls155MCY3o3EiScZedRJCTu4MMz/9nj7wtosYnVJXWp2IT1jTRm8Fu6b4H/U1iejHV91eh
 sNdoM+cn0yasO6EysdnbJbxmnMKQG0E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX/uB0fYdWuLTB
 BphXbJpAN4Rbxu9/L1tEnt05F3V6thF0gqc7UbSg3TQ00CIupctpRtfz2kq3jIUhqwKW4SY95V1
 2C3kce/4ZeltkDC3EyGnFgQVo9RLbKPm6UVe+1ohNiDQeOceEy/mitJHa5mC+96MQU0FZjfTrAQ
 dkxlcK4TH+R0qWDLv1Ig9u4BX5QgwJAIBSusTrNbVfkSs3HdZREb0TUUsZ0j8eu3fBpgUEouYlz
 btKP6IVwC61Oi0tQqFUmCl/lZE5yXlYjnpAntMUdfk5tYABoH5e6yWrdyslblqxDsTS32WVUQKL
 OWiw4AlaTEUGKrOAyDO+382mTYlY1tEC2fN6DNAM8FO2OaCoR6siwxSrMxTeFq1MbZs28cNEGvG
 oveOfjLmxSOu5KvWHhPAhirecFMZjn4ClnaYot7QD1Zatdi263ZTOb/E4HooDbkfMIasT1mNkYo
 nGvpvj2qCXw4+M/pg2A==
X-Proofpoint-ORIG-GUID: C5zI4erMB2a9YqGthIZzFxsHIOEro9-7
X-Proofpoint-GUID: C5zI4erMB2a9YqGthIZzFxsHIOEro9-7
X-Authority-Analysis: v=2.4 cv=Y5JtIReN c=1 sm=1 tr=0 ts=6aecca52 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=gu6fZOg2AAAA:8 a=tl6KkQwk3wzYetsA23IA:9
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050073
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

This series adds foundational support for the Qualcomm Nord SoC in
U-Boot, including clock, pinctrl, board enablement configs & doc
required for early platform enablement.

The series includes:

  - Clock driver support for Nord
  - Pinctrl driver support for Nord TLMM
  - DTS changes cherrypicked
  - Configuration updates required for platform enablement

Changes in v4:
- Fix GCC clock rate handling & update CBCR-backed clock gates to
  use GATE_CLK_POLLED.
- Cherry-pick latest Nord DTS changes.
- Add Nord enablement patch with MAINTAINERS entry and board documentation.

Link to v3: https://lore.kernel.org/u-boot/20261021160448.3893858-1-aswin.murugan@oss.qualcomm.com/

Changes in v3:
 - Drop the DT binding patch since it is now available upstream.

Link to v2: https://lore.kernel.org/u-boot/20260928120209.1064781-1-aswin.murugan@oss.qualcomm.com/

Changes in v2:
  - Drop DT patches; they will be synced once the corresponding changes
    land in the upstream Linux kernel
  - Drop Nord-specific defconfig
  - Drop ELF 4K-alignment support changes
  - Add USB HS PHY support for Nord
  - Retain only clock, pinctrl, USB, and platform enablement changes
  - Address review comments from v1

Link to v1: https://marc.info/?l=u-boot&m=178695918491771&w=2


Aswin Murugan (10):
  clk: qcom: add GCC driver for nord
  clk: qcom: add NEGCC driver for nord
  clk: qcom: add SEGCC driver for nord
  clk: qcom: add NWGCC driver for nord
  clk: qcom: add TCSRCC driver for nord
  configs: qcom_defconfig: enable nord clock drivers
  pinctrl: qcom: add TLMM driver for nord
  tools: qcom: mkmbn: add Nord board mappings
  configs: qcom: add debug UART config fragment for nord
  configs: add Nord defconfig, MAINTAINERS and documentation

Shawn Guo (3):
  arm64: dts: qcom: Add device tree for Nord SoC series
  arm64: dts: qcom: Add device tree for Nord Embedded variant
  arm64: dts: qcom: Add device tree for Nord RRD board

 board/qualcomm/MAINTAINERS                    |    6 +
 board/qualcomm/debug-nord.config              |    5 +
 configs/qcom_defconfig                        |    1 +
 configs/qcom_nord_defconfig                   |   27 +
 doc/board/qualcomm/dragonwing.rst             |   14 +-
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    5 +
 drivers/clk/qcom/clock-nord-gcc.c             |  165 +
 drivers/clk/qcom/clock-nord-negcc.c           |  193 +
 drivers/clk/qcom/clock-nord-nwgcc.c           |   91 +
 drivers/clk/qcom/clock-nord-segcc.c           |  151 +
 drivers/clk/qcom/clock-nord-tcsrcc.c          |   88 +
 drivers/pinctrl/qcom/Kconfig                  |    8 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-nord.c           |  626 +++
 .../src/arm64/qcom/nord-embedded.dtsi         | 1820 +++++++
 dts/upstream/src/arm64/qcom/nord-rrd.dts      |  424 ++
 dts/upstream/src/arm64/qcom/nord.dtsi         | 4605 +++++++++++++++++
 tools/qcom/mkmbn/mkmbn.py                     |    1 +
 19 files changed, 8236 insertions(+), 3 deletions(-)
 create mode 100644 board/qualcomm/debug-nord.config
 create mode 100644 configs/qcom_nord_defconfig
 create mode 100644 drivers/clk/qcom/clock-nord-gcc.c
 create mode 100644 drivers/clk/qcom/clock-nord-negcc.c
 create mode 100644 drivers/clk/qcom/clock-nord-nwgcc.c
 create mode 100644 drivers/clk/qcom/clock-nord-segcc.c
 create mode 100644 drivers/clk/qcom/clock-nord-tcsrcc.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-nord.c
 create mode 100644 dts/upstream/src/arm64/qcom/nord-embedded.dtsi
 create mode 100644 dts/upstream/src/arm64/qcom/nord-rrd.dts
 create mode 100644 dts/upstream/src/arm64/qcom/nord.dtsi

-- 
2.34.1

