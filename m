Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B39C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:53:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6C6484B14;
	Tue, 30 Jun 2026 14:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gI9yrb+o";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dcf6wTF6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F3E584A73; Tue, 30 Jun 2026 10:09:34 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B8E84857
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=varadarajan.narayanan@oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65U6CUWW1097910
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=3ym7nhOtC4RegCFkwXWjIWE9
 LNTt3AE9tAtByCPtEeM=; b=gI9yrb+oTa+m2LyAkVS3fdSqmNIhUiFvOFO7yY1K
 2jEWtFbWMM9+sFRPbt7G0qF7aZEzE1aKEPxwJi+wC5b0qA+p/IDdBRRLK4ZrnN/q
 yVrpFccVjZGaUN+AFmpocgoZK6P0acwd0KlG+wJcEd1wMUA4CwIcm1favf871FxU
 aR8E9rHEUf5+CbXRzKaQm1uOeHKAOUqreaMeMQXR7PsJteYgMG9z7KiB4BvW/7o3
 WUlkYQCc86CDNyxDjcq1y3qFdczEcPQdLlyT7qt3IbR2uB9UHhuMW5otAcFRkyt/
 lBoKdDYNNE6YOPsNG3LpJrIs8aEgOTs7N76+zZi+fVPTTg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3x1ctnsp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:09:30 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c011c7cb9so11791127eec.1
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 01:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782806970; x=1783411770; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3ym7nhOtC4RegCFkwXWjIWE9LNTt3AE9tAtByCPtEeM=;
 b=dcf6wTF6oKWJt0uQrX+++QYrZ8hu0vTB/7McIRWPIVCHT4vvnqGARD5/rB9aavI7iU
 rg/ZL53DlsrlAFJJn6sLFtZWYKmpHGbAL1CLc6ymdq1oQBc2lAvLHZcJjpWkGhzCGGrF
 wfYFbs7WJ/e7LvJUV82urhGMn9M7Mha5eg6xILM7P+yDWXWGk8TRWffMexmaDSCLZYLo
 lq1vrQrRfbZemTy5zaYBYI9OdMXqryedqddOT0Lu2fWCQa+sx8eVWf3XxH9h1F0ziQWE
 W3AsAPcGH998Vn6yk2OckfYT+T8sHg3TVLOSlUcdUFLu7hPx7Y+Wt/+ZBConRn4Bx6+k
 wSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782806970; x=1783411770;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ym7nhOtC4RegCFkwXWjIWE9LNTt3AE9tAtByCPtEeM=;
 b=g2aGD1nP2F6hMfRPbsrt6wXd0kY7swE2jB0iD7ALQZi7gmL+U4f/UOU65woGFA8RKb
 h5sFwsBPye3CQ4A9R699Xry4ae7RfA/C39gr48xoFSruPXR/tqh6z3CDaPylXPTef/Kw
 0PnxjeK/sY5OOmKwxssI05XsY/tAdrgqrmnyvbzTmg87YR+UxMYAKSXrilQ0sMG4ixSu
 4h1p7ddGD8uM00eQI18oIxAiMT8sgKo89ate0HFMbswQo2QDRqL1L/Boc6YaUMnYnJlj
 FbYpiTSwEGyzJZeUM/oZsJI5/dCgqKHv6VPAmczTfCb4u2vWT3fOQxk6yY4jURgY4fhJ
 y9cQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RovsXp4Hq6KNrt+uuX9QowUb+bGoA8cf/+cJAC3+Z0uRtLmNDkRdmf9QmXo5sa+3uXfzF23bm4=@lists.denx.de
X-Gm-Message-State: AOJu0YxVVO+9cm7ZG4172flPkY54FyEEM2KA/HpN/JTiRLvVnlcROyDT
 h1poiVCSd4REMjFemo/MggdGW1snvc0kiordnFWuT8V6ZgNp5Mmh95CMCOghkns651pflbLAQVS
 +od+2niSb+qvChGoySkXsbkekbKQ/NKkowcmWTaBUj00gXu2B6X7e6Qj2
X-Gm-Gg: AfdE7clYuCAYS0+4Ur6N8x8ADLB0+EyOgZ50lYnPC2BlD3DmeL/nAi4tUUzlm3jogYs
 y1vEteSfKuR93khkiWC6tEgqXWArH9C8AT+PCBIW0m2Iu06G0MbRPdBuOT9+zndbx++cG7C3QQc
 zTvJjTHoLL//dM0QIREv9eQndebNk+VBDKkIVaCy53AXNbXSosd/RgoWIEt4s3kXEtSurAA0IQv
 fw6b35hLPLLnrUbd1eSLYb2agE1xUwUC5j9I0MU4NxC/m/bVLLKvTY2GlAiwT8kU4RFy05r/5Bb
 GdELKopup866DDlx4ZhzIu9ZCyZIIsvoKHWbZwnyLPi3hfAO0lCfnzh1AcX/QB/CsA3NF5nSX6P
 xEEVWBLW+a7VzRYXc865KfYKEt/orFBeIbF8ghcwX8LxGySgF5/O5VPDohr+TSaod7sDvQLhbOg
 0aqbXwgsfvVfIGjEMixLC/DRbNKfwrhtWx4ThDPprt
X-Received: by 2002:a05:7300:7c17:b0:2ea:5057:a304 with SMTP id
 5a478bee46e88-30ee12c2bfamr2221742eec.2.1782806969528; 
 Tue, 30 Jun 2026 01:09:29 -0700 (PDT)
X-Received: by 2002:a05:7300:7c17:b0:2ea:5057:a304 with SMTP id
 5a478bee46e88-30ee12c2bfamr2221693eec.2.1782806969072; 
 Tue, 30 Jun 2026 01:09:29 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30ee2f584bdsm5939041eec.4.2026.06.30.01.09.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 01:09:28 -0700 (PDT)
Date: Tue, 30 Jun 2026 13:39:15 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Simon Glass <sjg@chromium.org>
Cc: rayagonda.kokatanur@broadcom.com, trini@konsulko.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, peng.fan@nxp.com, jh80.chung@samsung.com,
 lukma@denx.de, tien.fong.chee@altera.com, anshuld@ti.com,
 alif.zakuan.yuslaimi@altera.com, tingting.meng@altera.com,
 alice.guo@nxp.com, marek.vasut+renesas@mailbox.org,
 quentin.schulz@cherry.de, ilias.apalodimas@linaro.org,
 andre.przywara@arm.com, afd@ti.com, h-salunke@ti.com,
 alchark@gmail.com, mkorpershoek@kernel.org, dinesh.maniyam@altera.com,
 luca.weiss@fairphone.com, balaji.selvanathan@oss.qualcomm.com,
 danila@jiaxyga.com, aswin.murugan@oss.qualcomm.com,
 ycliang@andestech.com, n-francis@ti.com, mateuslima.ti@gmail.com,
 jamie.gibbons@microchip.com, david.wronek@mainlining.org,
 james.hilliard1@gmail.com, philip.molloy@analog.com, ravi@prevas.dk,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH v6 11/11] doc: board/qualcomm: Update RDP build
 instructions
Message-ID: <akN5q6/GL9Vx3BkL@hu-varada-blr.qualcomm.com>
References: <20260623064804.3988799-1-varadarajan.narayanan@oss.qualcomm.com>
 <20260623064804.3988799-12-varadarajan.narayanan@oss.qualcomm.com>
 <CAFLszTi+TayLxOGq0K3G57VPcV3b_-Gc6-rrwODgOPfHDq70fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTi+TayLxOGq0K3G57VPcV3b_-Gc6-rrwODgOPfHDq70fA@mail.gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA3MSBTYWx0ZWRfX++OFJgL45CXa
 U75aGCZDLBdqWan9ybtIunc/MRS4xhkUZcPR6hAvax9wmi5AlxgSGBRKNbC1PAfOKLrdirGypak
 Xrdc5G9y0x5PJQcuSaSIi4ij4ncr+Iv+Pk10OBoRTA2TFjFXXleoTjKh5MHjziyAHXPTEDbBWGy
 yif+K9ZXBNuwK+C3LeLUNf1CYPlHeHc52oprCbjZkJxHmxoyBH/qhBkRQz7HvKJT6U+usBznX/O
 wiOyLNl18d+asJ4EuSPjVtnHXJJQ1hQmTMQ2PINWS192junnuNsRsX4F7saovW2jPEU0e5KDlRC
 YDeD9oiuMJGWnBY9IEd4N+Ptu1GJuc5RBC+9rrcT5rjiYYH0R4dwfbCwyHhoE37f+4uSEIr79tm
 drDbhK0ykxF/ze8A16DjxPVMw9xVTYgDF1wFJAdjz7030tNACiVgI1+5I5Xw0CohYjxH/vawS9w
 N2OGOCMiX5QMzINg9mQ==
X-Proofpoint-ORIG-GUID: keaT9rE8lrCxeg0dSTwREdHvZXoh_WOJ
X-Proofpoint-GUID: keaT9rE8lrCxeg0dSTwREdHvZXoh_WOJ
X-Authority-Analysis: v=2.4 cv=ftfsol4f c=1 sm=1 tr=0 ts=6a4379ba cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=cm27Pg_UAAAA:8 a=IbZP69T4DKiOGkNAZ5MA:9 a=CjuIK1q_8ugA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA3MSBTYWx0ZWRfX0Dnaezm4eWp7
 29c3z53gMTucIRkqsowce5xFatrLsCniaarJslGkAuXgGFnf1cepb0iDxWz+rmBd2nGedPG73NH
 C3imPbnW6iSiFyNiVuq+UYxCXYrPtVc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300071
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:53 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Mon, Jun 29, 2026 at 10:16:24AM +0100, Simon Glass wrote:
> Hi Varadarajan,
>
> On 2026-06-23T06:47:53, Varadarajan Narayanan
> <varadarajan.narayanan@oss.qualcomm.com> wrote:
> > doc: board/qualcomm: Update RDP build instructions
> >
> > Add details about the SPL & U-Boot proper build steps, converting to
> > flashable images, source URLs for the needed binaries and scripts.
> >
> > Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> >
> > doc/board/qualcomm/rdp.rst | 98 +++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 93 insertions(+), 5 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> > diff --git a/doc/board/qualcomm/rdp.rst b/doc/board/qualcomm/rdp.rst
> > @@ -42,17 +46,101 @@ on your device with::
> > -     EDL.  A tool like bkerler's edl_ can be used for flashing with the
> > +     EDL.  A tool like bkerler's edl can be used for flashing with the
>
> I just wondered why you drop the _ ?

Will fix and send v7.

Thanks
Varada
