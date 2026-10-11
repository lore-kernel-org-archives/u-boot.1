Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDB9CA9EC7
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 14:39:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95A9E80DE8;
	Sun, 11 Oct 2026 14:39:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gFFbS0RmaDOX; Sun, 11 Oct 2026 14:39:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F3BAF80D85
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791729574;
	b=mxPg50GC5xhPf4PZ4Q+0Qpsg/39GPgTh6SJ4IL4P0aEBn+4nSEK9bOjPC9+y1FIEtCcN
	 Kks7no4/Exk/vyo0SOYSt3rSTBISupCQWF1yMhgjdt/2zvkkSPI7ulzwTYVgiSGZvrsBF
	 srN2NAY1E3uFuF3X+Z/JS+hgcMQVbZipk5YK4zCaHr0ayevXGRtNa2iTshsDbfVtSofMV
	 rjrS83ofBDlUJEoFvxvfsJtbflzFx0eAf8XZK26j2iQ+DNYl4thhjesmghCiPGh0LivLu
	 l6FxxNOyABn14g0cI5r+Q+ZE+hkzDd7X6bRBPkbvg9VA2tdebnC+05CEqjyqVIKjWcw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791729574;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=MGfe2/wDDBfogEnMYOiVyFGxpkipOkjok5pn1aqkR40=;
	b=qx0qrRf6X8Hld5YxxWQoxEwCkoW2sJPyjZ6q65dIb08CRebv6BcS50kbi8KxnEuhgi7D
	 zTbCxdBGUARo87MToy+sfBcyoStoYjImVLXZ94TUedAOZQz+PMcQTYiwyF9X+yth2+6wX
	 GqzAHFuctYc6dhNQQqWBhnvc9v1CHw1NSQ9+9ogJwiNm3RYdXHGVYrROdpW6ax0Hb2R74
	 y3cg8pBb83IZ+zIPeM3DgT61RgnPRlQvgCOej9TL1ZhicwN+TaVTu5HzwEOPhvDyafZER
	 C285BSRdp99EooenJ+7FOjrsqyFsuH9LPRRNflEkngViHjQNk7k54G7he9wBlG/NRog==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791729574;
	bh=MGfe2/wDDBfogEnMYOiVyFGxpkipOkjok5pn1aqkR40=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vuHKRNwuj+9E+EfBLYPX9VyCodJZ5Qxi8M3AK70XH9SzYGyYmOgry9txvU3NC35AE
	 FilKcgI8YOxjkJ9o1FGmVmBWlL63G8d/zqoV5BlOOXR3IDdng2ZrxDADfr5YRY5Dp7
	 tYpaRKqg3aWyASkJXsjRGyEyGiYSSXm6KqFTQw1nl4D/WHBF1sxkBQ3l4QLaNHFjaw
	 tieTdZYM1WvpJ9dvYIjyjr/xK/wZcpZ1VY6yFmM4TX11AARW3IYX8O1kbi3ECLDzMv
	 2d7bwoKqcTdPe7l7aVtkUppNFHHCwZpVHbUYcCbR09qmOJgx4pnroRyoufb1uU1MHz
	 BKrk5QYQe+f9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3BAF80D85;
	Sun, 11 Oct 2026 14:39:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id CF8DBD5E
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:07:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 70F14400D1
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:07:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OlUyyYhCl7e8 for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 13:07:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 6DDC54008B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791724071;
 b=Eq8bjDlS0kABiXAsYkO2WSAUBG38n0flD0/i1nc4Ysq5MXw1m2emYJ6vbc9T/sofDCTD
 nWXYwqecHu/f7RtH0nPGBdvxydvk4Y1pKJ7AgE/BsmdNaiitF+W4FuIXeY04PuWWzcxzG
 i1pesPvbQK+TkzTgNs3wDi80Gl8s82VPxHuiC4RTV4niTrxlXUUwN8IUxxZ70Aid7avhn
 ik4dl0p44iWFNBIGioxTt83llklM7LywLo1xO/2h+ZkIw6Bc1+Rzpa3deUCYvKgNkXMEr
 1UggvXFMr7DgjNwkLUYXNygSqQ6+V2alVOxyHY10MQLNTnnAVzGKYyc66r5+N4sfGVw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791724071;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:
 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=MGfe2/wDDBfogEnMYOiVyFGxpkipOkjok5pn1aqkR40=;
 b=cE2fxdTnD4U2MKlIdSa0EMcoFik0RALpOz9Ni7mLMmqkXvWg7sPbHFs/wBqheyg3CYT8
 Vmm6xSX6AlFcBJItMs/C+cd9jUNA5rtmtPLH/EJvwsSu9h1KIk+1C6alcCrZmTn/bytlM
 BKaKXBGRtjQORodEjYO9No93SMHTPXEf4bXMuTDBct6DoCO1mZHN/N8hzXOax7AiAN9O1
 3Xdh6W2P5W4DcFVXbAYdj+sS7nGfzQThWgdKNZ7k+MRieyPR8rWHV6jtk3jQkZFOs+v9q
 UK/MWYlW7c/ps95bzYbIqFbJs/68PZwJx4aARG3XH1yoOh6BBw83mSeR7fJvkfy4SSA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.qualcomm.com;
 dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256
 header.s=qcppdkim1 header.b=FkXixbTK; 
 dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Ot2J19Jp; 
 arc=none smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com; envelope-from=igor.opaniuk@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=FkXixbTK; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Ot2J19Jp
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6DDC54008B
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:07:50 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69B857q72381410
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MGfe2/wDDBfogEnMYOiVyFGxpkipOkjok5pn1aqkR40=; b=FkXixbTK7do1C59I
 a8hmzQHGBUbuRms8CM6p5BDPq6mWja/xxYQzi6qEfeJdMK76rpxq1kwjpKk8VDh8
 zm0X6Yc7VgxFVZcV7DZpYQllv1O8oy8oFpzod7UaCQ/OeosNskD8ggli3GpIBJBJ
 FFxjQ+e13AmWEHVOGt83ED8FJP9IixhmSXOyZCshNmfWz5HKItiiFMQmcdDfnLCl
 G+mFhlLN0EeIRdnA/fuBYWaGxlUPgmWRSg+36LHr0xpLNtz6VPuuCsvWrL5sWtf1
 QA4A6Qp76igjFt1GV8HfAQiFooXdquKgdD7Z/dh/sYIh9sutZgCd+U8+zDzIawgK
 DjuuuQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7e4eawj7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 13:07:50 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5e1c96a0d70so511711e0c.0
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 06:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791724069; x=1792328869;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MGfe2/wDDBfogEnMYOiVyFGxpkipOkjok5pn1aqkR40=;
 b=Ot2J19Jpe/1p7q5pbTKSAaZPU+y7WXTb1ydGQ66/jo5E//FmbTrFJwXL3Rs5pIXEpr
 QiIbW7nTEuRRxTMa2KDwLb0eI0tPMS7xplQE++qqrvxsrH/gFGnKGLl9rgGD8YsxCH/U
 FUBOfeHnG6fHzC6gb29roqWYHvY3X5RJvP6dTPWmR475AJIEyf4Fm2TMjyOtWlzJmsv6
 K1g1d//g1qBZ5D5OpV78G9zGViqOqWszOB7KePMoaVlgY/+cYb772nvy0rj4j2EKSzPr
 HXCqVI1m3TpRiVUMbIMhFwwy6NIMt8pFWYteTE/XURTXClowVJJJdSWFEENfxQbMcxPS
 hyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791724069; x=1792328869;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MGfe2/wDDBfogEnMYOiVyFGxpkipOkjok5pn1aqkR40=;
 b=RfIOVVaRjrOHpwskiS6exwFO5njkxgtIl8B78TX9Qm3ODqszfdubSJXTh1SbP72/Zx
 2lA0DyH/wZJ0AFeKEeJXiWZqtXamWxADa2AsqJrZ9kpLsGaPJzCogt+2+0zwZzPgKv1z
 NH7ceGVJVIQf4nHku2E+i1rfNyyq9XCDUqhWaJBfFsAhe0dVPQu6/uqdml7N7AV+qsrh
 PJQSCIAfkkwtLHEFyS35AnQ4egpjraRrK3Kb16I5Cev2dkMaf5xjqKUNliafCYE5Y3rX
 78TlaiAF0c4KJQAttrxvAHi6jQug8DwtI6gGxB3FzWZEoBn9jTjEylTsWLpxNpJfAi/j
 P0ug==
X-Gm-Message-State: AFq9FYINTk4ezMf5gIdzKbmqdmGkKkCpyANZ0FcQr74XYbHd2/owsdFF
 OWiJQ9GstVnkYCjdt5uoGDX/fcrxA6Ar2jZYoCsf6lV5Ix6dqneNlw/EIZQMBjmOskFAyeg0xFM
 NquPw3em3UOWidr98fS8mB9kfhTEdKCdjASZ/3XRZOoX3FRddc424jJjS7aHwE3EU7HwrkJE=
X-Gm-Gg: AYBFou1GQL1Spau4Ch1ShW3BIoenral2sQfwB4ng3RYG8lPVXEh0ViQ7M7DDzbqp3up
 j30ejpJ4bhosFD7YefUF7uoYeDu9iUxoyItGMhHugffh6lBTsLua0LMq/vVJZlI6M/hG5vTy0nF
 h1ZTvTrfUaBGXKZTx3hmnTiP/ADReN/+wG3s6JSh0pWzfpK8vJ3OHSTrNluJItQem0LVMy+r8y0
 f00TEKL9WrnRi23Z8Do0f5f2WMjKx+CKUS16dByea+wqfW+TjjVuod7nC3pRc913ZqLHJGJB1uB
 hZSgyZ58v9/qZ21yhIpab+aCLU7k+l0gDkmLV9Kjrgjar0i+a+CPFmLb2S7iWhc5qV3MWJtOOQL
 d6EHxHhLxu0ULDs/qsew5deE4g4gEsa/AU86ZWu2yIgXY
X-Received: by 2002:a05:6122:1d06:b0:5c9:a60b:e5d9 with SMTP id
 71dfb90a1353d-5e91f514a4fmr2291756e0c.19.1791724069118; 
 Sun, 11 Oct 2026 06:07:49 -0700 (PDT)
X-Received: by 2002:a05:6122:1d06:b0:5c9:a60b:e5d9 with SMTP id
 71dfb90a1353d-5e91f514a4fmr2291725e0c.19.1791724068624; 
 Sun, 11 Oct 2026 06:07:48 -0700 (PDT)
Received: from [127.0.1.1] (185-164-141-21.cgnat.inetia.pl. [185.164.141.21])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c346637b997sm53774266b.30.2026.10.11.06.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 06:07:47 -0700 (PDT)
From: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 15:07:36 +0200
Subject: [PATCH 1/2] optee: rpmb: select the RPMB partition per request
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-upstream-optee_rpmb_b4-v1-1-7c63edca4b92@oss.qualcomm.com>
References: <20261011-upstream-optee_rpmb_b4-v1-0-7c63edca4b92@oss.qualcomm.com>
In-Reply-To: <20261011-upstream-optee_rpmb_b4-v1-0-7c63edca4b92@oss.qualcomm.com>
To: u-boot@lists.u-boot-project.org
Cc: Jens Wiklander <jenswi@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA1MiBTYWx0ZWRfX/kEJNaeXY3aZ
 Aa4mcy9CAlNg09TrK4tYlRHwycfUM1xRQw6poKVq3Oy6v9eE1pBmlt8tVNJldzp5Iw/lnDMaInq
 ai9HIh8KpTvCVdpfL2i4o7PQVRcr/MZBPAbGtKWgP7lM8CiAnAGJG3TDGjPCdHbWi5JQ7zvTgEy
 RZ0AfV5QLKPFdPBBoiHn4zy/1NizG2T2+J01rRIUat6sUPKZkSJHorCu4UNKKFSI/fHwSZPEtfR
 N56xyIAMX2iaNdtoJq/+zmA9Npi49P1ooQ+q84vSrHP3bOrSqn5tGTI2QSWVj9gqO6kW8zJTXmD
 O5JhOWM9yknHmOTScYmTPKNbpkk7SfussOU5z57CPKg3V5i/zsfi7Y52BBqa0ap7+kYzKUuD+C2
 EDhIp3bYzAEFP1NTpe8GSO0f0rN7tMGyHnTJJT1mHT9ClM++tujlkinaotc2zVHC8OWXvyl4Pdk
 u5iwNZ+jh0vqjMujwYA==
X-Proofpoint-ORIG-GUID: ZaHz0OdBuPurnRku4YuN1WCNXbLDlCnU
X-Proofpoint-GUID: ZaHz0OdBuPurnRku4YuN1WCNXbLDlCnU
X-Authority-Analysis: v=2.4 cv=W5utxhWk c=1 sm=1 tr=0 ts=6acb8a26 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=JsdSkJyxCPcZmfxNhm0PvA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=zL1JONcZbJ0eZN6WwLkA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA1MiBTYWx0ZWRfX8kDEooiUsXo4
 YZXAPAoFFu8ho9+pyvELsBHmyGQ82VyNmFXJA9eu4WLJnWANqkhs50YjZyxpely85zpqXfCK309
 Zey9PjEB+y7Z6bBV72Q8O0WPP3idA1A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610110052
X-Mailman-Approved-At: Sun, 11 Oct 2026 14:39:24 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The supplicant switched the eMMC to the RPMB hardware partition when the
device was first used and only switched back when the OP-TEE session was
released. Between two RPMB requests other users of the same device switch
it back to the user area: libavb does so for every partition read while
verifying a chain, and the Android bootmeth reads boot/vendor_boot right
after verification.

With RPMB left selected those reads hit the RPMB partition, and the next
RPMB frames were routed to whatever partition the other user left
selected, which ends in status timeouts and I/O errors (seen with
the AVB TA on QEMU's emulated eMMC).

Select the RPMB partition around every data request and restore the
previously selected partition afterwards.

Signed-off-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
---
 drivers/tee/optee/rpmb.c | 61 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
index 7ae6045511b..ea5507af086 100644
--- a/drivers/tee/optee/rpmb.c
+++ b/drivers/tee/optee/rpmb.c
@@ -42,24 +42,15 @@ struct rpmb_dev_info {
 
 static void release_mmc(struct optee_private *priv)
 {
-	int rc;
-
 	if (!priv->rpmb_mmc)
 		return;
 
-	rc = blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
-				      priv->rpmb_original_part);
-	if (rc)
-		debug("%s: blk_select_hwpart_devnum() failed: %d\n",
-		      __func__, rc);
-
 	priv->rpmb_mmc = NULL;
 }
 
 static struct mmc *get_mmc(struct optee_private *priv, int dev_id)
 {
 	struct mmc *mmc;
-	int rc;
 
 	if (priv->rpmb_mmc && priv->rpmb_dev_id == dev_id)
 		return priv->rpmb_mmc;
@@ -86,19 +77,44 @@ static struct mmc *get_mmc(struct optee_private *priv, int dev_id)
 	}
 
 	priv->rpmb_original_part = mmc_get_blk_desc(mmc)->hwpart;
-
-	rc = blk_select_hwpart_devnum(UCLASS_MMC, dev_id, MMC_PART_RPMB);
-	if (rc) {
-		debug("Device id %d: cannot select RPMB partition: %d\n",
-		      dev_id, rc);
-		return NULL;
-	}
-
 	priv->rpmb_mmc = mmc;
 	priv->rpmb_dev_id = dev_id;
 	return mmc;
 }
 
+/*
+ * The RPMB hardware partition is selected for the duration of a single
+ * request only. Between two requests other users of the same eMMC, for
+ * instance libavb reading the user area while verifying a chain of
+ * partitions, switch the device back to the user area. Keeping RPMB
+ * selected across requests would make those reads, and the following RPMB
+ * frames, hit the wrong partition.
+ */
+static int select_rpmb_part(struct optee_private *priv)
+{
+	int rc;
+
+	priv->rpmb_original_part = mmc_get_blk_desc(priv->rpmb_mmc)->hwpart;
+	rc = blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
+				      MMC_PART_RPMB);
+	if (rc)
+		debug("Device id %d: cannot select RPMB partition: %d\n",
+		      priv->rpmb_dev_id, rc);
+
+	return rc;
+}
+
+static void restore_part(struct optee_private *priv)
+{
+	int rc;
+
+	rc = blk_select_hwpart_devnum(UCLASS_MMC, priv->rpmb_dev_id,
+				      priv->rpmb_original_part);
+	if (rc)
+		debug("%s: blk_select_hwpart_devnum() failed: %d\n",
+		      __func__, rc);
+}
+
 static u32 rpmb_get_dev_info(u16 dev_id, struct rpmb_dev_info *info)
 {
 	struct mmc *mmc = find_mmc_device(dev_id);
@@ -130,6 +146,7 @@ static u32 rpmb_process_request(struct optee_private *priv, void *req,
 {
 	struct rpmb_req *sreq = req;
 	struct mmc *mmc;
+	int rc;
 
 	if (req_size < sizeof(*sreq))
 		return TEE_ERROR_BAD_PARAMETERS;
@@ -139,9 +156,13 @@ static u32 rpmb_process_request(struct optee_private *priv, void *req,
 		mmc = get_mmc(priv, sreq->dev_id);
 		if (!mmc)
 			return TEE_ERROR_ITEM_NOT_FOUND;
-		if (mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
-					  req_size - sizeof(struct rpmb_req),
-					  rsp, rsp_size))
+		if (select_rpmb_part(priv))
+			return TEE_ERROR_ITEM_NOT_FOUND;
+		rc = mmc_rpmb_route_frames(mmc, RPMB_REQ_DATA(req),
+					   req_size - sizeof(struct rpmb_req),
+					   rsp, rsp_size);
+		restore_part(priv);
+		if (rc)
 			return TEE_ERROR_BAD_PARAMETERS;
 		return TEE_SUCCESS;
 

-- 
2.53.0

