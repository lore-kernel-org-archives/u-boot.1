Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0020C44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 18:44:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 54B6A80C8F;
	Wed, 22 Jul 2026 18:44:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jXiIxsg4qdlc; Wed, 22 Jul 2026 18:44:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 13F4B80C59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784745872;
	bh=NF2kIvaT3Hr38uaZfML4ODJ/941FGdIALc/HFb8V+PM=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=M5cNon/S1iWu6SxpDWVkGS4s0fhp/vkcU8oUWx5M6U8iA7HGhRH1LzyAJXh3tXVuZ
	 WSgdnqaP3+w4DJ/ZLWeCiXsyosC6ssl7aLIpyyyeKkYOo0zscitEGfOex5eGlNJgO/
	 WlKD8tl2LqAdCjqa9KXuKjfy/TOCL9UZEbi9zDH//zqC3mrnIS90rPTIdm836q2bi/
	 EQyzyNdZ4IbjcLkYd+Svtk8Ksid0IvFlrF2hQmfqblmynIqIBRCEdo3sjpflX975yT
	 Mi0AKUxwWxXq8cMA8Wgjk53UWxKpLS9/+f5NXIdL6owZsFrV9CuFvg5L8XqcibeGkF
	 CnxOTCz0bYC5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13F4B80C59;
	Wed, 22 Jul 2026 18:44:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A9B48313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 18:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9017D40057
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 18:44:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n5jvKz-HcgJw for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 18:44:29 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2E36F40115
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2E36F40115
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2E36F40115
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 18:44:29 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 940E3848BA; Wed, 22 Jul 2026 20:44:27 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BBF883E76
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 20:44:25 +0200 (CEST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MHr6uI1506686
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 18:44:23 GMT
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjxm11gac-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 18:44:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c20762d21so130142201cf.0
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 11:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784745863; x=1785350663;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:date
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NF2kIvaT3Hr38uaZfML4ODJ/941FGdIALc/HFb8V+PM=;
 b=Gb/8e2IJniS4ESZyiWLOdC9rBvl9k2V1LMsQMD/sDh8quO2XMGpr/mrVHVvT4DtoQP
 AV2/Ko6/VG6hmSOdDXwJOM5biKoqltLZVM94XssrAMk3eieRcJqtaTPiNY69IDi0/DWp
 c5HIzywV/4BYnVEQk0tIpKkW4xJXKnzZ+W9VMWfRQbOnkIEnhOm21JlWxIRVrCQo39ii
 10R0yY/NsXv4PrfMM6giEFpIKwIuTyC+X7VnqG6JtCJ7pQUZeQu1hznS4W8nikqUUqEl
 W41DejlhJzIvHRSG1fMbdTV5VSPYeB1L+DVsHu3CXFwI0FgbK5+j9h4Gdgkbe3c2m+2l
 Sd7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpxRIxr40YQaxUQjc+iPp1Tbeg3qFg9vE6EV3s1AVFpjh9uot2hFnBNrDFYMtlzN0SRD53pNQM=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5fG95PnlK3bsFDij0L8sNsIBh3OWP6eS924mPfV+hmQxrg0Wc
 N9wMQJYv9o+bu9M5PNnNqQoxPfhKc6woEnfMNx2G5Gs3wjNFMQ/DOyRqMd9TjxmYnC+eO0rkLBY
 5K0cCkOXLfKibmSWxxp7nDVOY4fmBX5y9YwfAGSy2begsYCmhxyg9OHdN
X-Gm-Gg: AR+sD13lq1dzEavKRk+DbyuyLaWL0UZCLK+YUPyMIoaK9bvhCRCW+mAxMi9c6wEhn3O
 7bvrkRtc1JMa7nHswfGITmS0ur019hus+Z5E2kASbB/RLvpsbf1qa3pTuqAg/WZwP8+GW7+ZRwK
 2d4xCjCioIaLh5hz849O7uLSeCYvrLj+z5Dy2NdzviyzRheJTaEyd6PKaq5NzPOU6Mmii0B9zYN
 F/HPTt1oZPM+ISteL/4jCUyX5Ku8S2pq97/PVxPzbomTfIA6Z71nqrxupct97XNqVHEopR+WvQI
 Wsy0E5CZamdYvWG4Gd1dU+k6hTVSmoWDuwAUMs0Ibkgt4oCb3kXFCplvdOyZlMHBibHxe+YyznT
 IAd52kPdyFIRe6793C0IS5yc11qouBDKvs1M=
X-Received: by 2002:a05:622a:a13:b0:527:f19c:734d with SMTP id
 d75a77b69052e-527f19c876cmr42402531cf.7.1784745862542; 
 Wed, 22 Jul 2026 11:44:22 -0700 (PDT)
X-Received: by 2002:a05:622a:a13:b0:527:f19c:734d with SMTP id
 d75a77b69052e-527f19c876cmr42402031cf.7.1784745861813; 
 Wed, 22 Jul 2026 11:44:21 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a967289sm87759885e9.11.2026.07.22.11.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:44:21 -0700 (PDT)
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Wed, 22 Jul 2026 20:44:19 +0200
To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, trini@konsulko.com,
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 bhupesh.linux@gmail.com, n-francis@ti.com,
 marek.vasut+renesas@mailbox.org, shawn.lin@rock-chips.com,
 igor.belwon@mentallysanemainliners.org,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, padmarao.begari@amd.com,
 macpaul.lin@mediatek.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com,
 hayashi.kunihiko@socionext.com, dlechner@baylibre.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 5/5] optee: implement the RPMB subsystem interface for
 UFS
Message-ID: <amEPgwafY1zm1LwF@trex>
References: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
 <20260722060805.1428110-6-jorge.ramirez@oss.qualcomm.com>
 <791913b4-d006-44be-8c94-871617418dbc@linaro.org>
 <amDP5roFBAAdOcYK@trex>
 <6f5137f9-d358-4c51-ac2c-f667cf126d80@linaro.org>
 <amEIA0pSVEehZJYt@trex>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amEIA0pSVEehZJYt@trex>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE4NCBTYWx0ZWRfX3DaV9ARYj/8Y
 VE9m5zbbEwVFH2MFrKoahv8cdbznNO+LrEG3wR8PTNwugsPp5q8mxUAf9xMD5n92zfkzMV6jxWV
 La4KrL4OcLHdBUVDvk1W5LmbjhPl0xc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE4NCBTYWx0ZWRfX4iwVM+9IMWSR
 OYdujPJGlnRQ2GXQ9CK7IYt5Z2Blty15lJtj8vnc+IOp23E/7UwyUsMYtQrn5Tm95rQPwdxx8yR
 6wpg2o28GgMsEml4Jx+AifNCOYrg1x0uwK9MPKzUlvBdj77qcEhacOMAzj09QKJeyrrQV1utsHl
 8utO7YWTAb3HVupM3SvJj9+S+C3wHnbZo8bwBzCHRQRZdK1wMdBzstJi3ZctZqyG8XYbA5ulEj5
 oLzsU1xbLpZknCZeSwmESgPZaw2xr1jIKvucS/1uC4TqDJ9eWfcIwowjB7Wr+lcgLAsCCLO3Ssf
 I8lPpq7pD4SJ+bVCLPyDiUQW2BIBYdAxZNN54/DHH7a+AKHtgCw9Y3NogwyUOVFGl+nPAvB62ZP
 dcn/Rjf+SjlQbfEQVOnenk71OLmV5KKbW3yx5mUUcgkeVLUk6zMjkmkIboFKHW980ybgv0DQPOx
 rAHpdt7Db9Qt56IyR4Q==
X-Authority-Analysis: v=2.4 cv=Rsv16imK c=1 sm=1 tr=0 ts=6a610f87 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=v0AsJYt0KKq4_wKu-noA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: IrK5NibQbLr_bUMJIg2zGSq6aVw8srOf
X-Proofpoint-ORIG-GUID: IrK5NibQbLr_bUMJIg2zGSq6aVw8srOf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220184
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NF2kIvaT3Hr38uaZfML4ODJ/941FGdIALc/HFb8V+PM=; b=RIXt29A4lXwP4k6N
 8/3gbh0ZJo5JCsotiReyyCt6WjTZSKZ0H60I6f4O0tA8tzxmGTVk819Ryxhtqo1H
 KdBJKIGDPYlewDHMqUZB7ojl1wYLAvm3t7O0EAEnngDp6OjTGLuYMCl9sFue8IZ5
 FCAJzlSntQnoAf9EkUVxA8aAKnP3Eb3NIPwXDx6AW+z1vCDIWZ8b6Oz6ugkLijMU
 S3A9EcYbV5W7gnazhIRkrMb5p7bEscLCkATWApL17ufiX6Axlnv+6vnJhxOn15qc
 JPJMwNYcK0qCBrzGWL9Z6A2fRtKaxgutGSkRyAHWcagxfED61DgUXW1MentAjeII
 BjwAZQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784745863; x=1785350663; darn=lists.denx.de; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:date
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NF2kIvaT3Hr38uaZfML4ODJ/941FGdIALc/HFb8V+PM=;
 b=eLgj2fM9vZAbMGhEiGH3r3tnsrvEh33OrwBo7SQnXmvTow3JrULzO1ket0zmceZ38m
 qbo79P3v88LHjfOPhSSfvcMJwAZ4u+y1EIpZMRllpPNRvJUIWIH6nPKE3vt5Cw/0jc+k
 wOFnDCdt0aP3kabHbqhAbhLWiR18x9gBO/UriCH/vNOqGowBhQXT2Ndip6m2/Vze4jl8
 spKUvH9mjTeJnRTJX+8EFSaiKqgZPmlZyztozZHj5EldclIKzkMrs6IslCdxyMOjcZwe
 paGj+MOi0XFk3tAhSu1ZHK2+ZO6/htnfed04FT5L7Y+uSFQ+z9Xh2GyRnQE+oJR1iI7h
 C5wA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=RIXt29A4; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=eLgj2fM9
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RIXt29A4";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="eLgj2fM9"; 
 dkim-atps=neutral
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
From: Jorge Ramirez via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 22/07/26 20:12:19, Jorge Ramirez wrote:
> On 22/07/26 17:43:16, Neil Armstrong wrote:
> > On 7/22/26 16:12, Jorge Ramirez wrote:
> > > On 22/07/26 10:31:04, neil.armstrong@linaro.org wrote:
> > > > Hi,
> > > > 
> > > > On 7/22/26 08:07, Jorge Ramirez-Ortiz wrote:
> > > > > OP-TEE's legacy RPMB supplicant interface assumes the RPMB device is eMMC
> > > > > and derives the key from an eMMC-shaped device ID, so it can never
> > > > > reproduce the key Linux derives for a UFS device; secure storage on
> > > > > UFS-only platforms instead needs the transport-agnostic RPMB subsystem
> > > > > interface, through which the normal world describes the real RPMB device
> > > > > to OP-TEE. Add a UFS backend for it so OP-TEE derives a key matching Linux
> > > > > and can use RPMB secure storage on UFS, leaving the legacy eMMC path
> > > > > untouched.
> > > > > 
> > > > > This subsystem backend currently supports UFS drives only; eMMC still uses
> > > > > the legacy interface. As the legacy interface is dropped in favour of the
> > > > > subsystem one, an eMMC backend should be added here so both transports are
> > > > > served through a single RPMB path.
> > > > > 
> > > > > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > > > > ---
> > > > >    drivers/tee/optee/Makefile               |   1 +
> > > > >    drivers/tee/optee/optee_msg_supplicant.h |   8 ++
> > > > >    drivers/tee/optee/optee_private.h        |  41 ++++++++
> > > > >    drivers/tee/optee/rpmb.c                 | 124 +++++++++++++++++++++++
> > > > 
> > > > Why not rpmb_ufs ?
> > > 
> > > 
> > > because in the future (and IMO) rpmb.c should support UFS and EMMC using
> > > the new probe interface (eventually removing rpmb_legacy).
> > 
> > Let's see in the future, if somehow there's need for a common "new"
> > and emmc only legacy some rework will be needed anyway. The eMMC RPMB
> > hasn't been updated for a very long time...
> > 
> > Using the driver model to register an rpmb device attached to an eMMC
> > or UFS controller would the cleanest way to handle that, but we're not here now.
> > 
> > > 
> > > > 
> > > > It's fine to have 2 backend implementations, the emmc is implementing the
> > > > legacy optee API, just add a comment in the eMMC file about that.
> > > > 
> > > > Neil
> > > > 
> > > > >    drivers/tee/optee/supplicant.c           |   9 ++
> > > > >    5 files changed, 183 insertions(+)
> > > > >    create mode 100644 drivers/tee/optee/rpmb.c
> > > > > 
> > > > > diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> > > > > index 8321cf53a19..7af19834c00 100644
> > > > > --- a/drivers/tee/optee/Makefile
> > > > > +++ b/drivers/tee/optee/Makefile
> > > > > @@ -4,3 +4,4 @@ obj-$(CONFIG_OPTEE) += core.o
> > > > >    obj-y += supplicant.o
> > > > >    obj-$(CONFIG_DM_I2C) += i2c.o
> > > > >    obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_legacy.o
> > > > > +obj-$(CONFIG_SUPPORT_UFS_RPMB) += rpmb.o
> > > > > diff --git a/drivers/tee/optee/optee_msg_supplicant.h b/drivers/tee/optee/optee_msg_supplicant.h
> > > > > index 963cfd47824..b720d5d7b3f 100644
> > > > > --- a/drivers/tee/optee/optee_msg_supplicant.h
> > > > > +++ b/drivers/tee/optee/optee_msg_supplicant.h
> > > > > @@ -152,6 +152,14 @@
> > > > >     */
> > > > >    #define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 21
> > > > > +#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_RESET	22
> > > > > +#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_NEXT	23
> > > > > +#define OPTEE_MSG_RPC_CMD_RPMB_FRAMES		24
> > > > > +
> > > > > +#define OPTEE_RPC_SHM_TYPE_APPL		0
> > > > > +
> > > > > +#define OPTEE_RPC_RPMB_UFS		1
> > > > > +
> > > > >    /*
> > > > >     * Was OPTEE_MSG_RPC_CMD_SQL_FS, which isn't supported any longer
> > > > >     */
> > > > > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> > > > > index 1f07a27ee4b..2888257aefe 100644
> > > > > --- a/drivers/tee/optee/optee_private.h
> > > > > +++ b/drivers/tee/optee/optee_private.h
> > > > > @@ -9,6 +9,17 @@
> > > > >    #include <tee.h>
> > > > >    #include <log.h>
> > > > > +#ifdef CONFIG_SUPPORT_UFS_RPMB
> > > > > +/**
> > > > > + * struct optee_private - OP-TEE driver private data
> > > > > + * @rpmb_next_region:	next UFS RPMB region to report on PROBE_NEXT
> > > > > + * @rpmb_cur_region:	UFS RPMB region selected by the last PROBE_NEXT
> > > > > + */
> > > > > +struct optee_private {
> > > > > +	unsigned int rpmb_next_region;
> > > > > +	unsigned int rpmb_cur_region;
> > > > > +};
> > > > > +#else
> > > > >    /**
> > > > >     * struct optee_private - OP-TEE driver private data
> > > > >     * @rpmb_mmc:		mmc device for the RPMB partition
> > > > > @@ -22,6 +33,7 @@ struct optee_private {
> > > > >    	int rpmb_dev_id;
> > > > >    	int rpmb_original_part;
> > > > >    };
> > > > > +#endif
> > > > >    struct optee_msg_arg;
> > > > > @@ -60,6 +72,35 @@ static inline void optee_suppl_rpmb_release(struct udevice *dev)
> > > > >    }
> > > > >    #endif
> > > > > +#ifdef CONFIG_SUPPORT_UFS_RPMB
> > > > > +void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
> > > > > +				      struct optee_msg_arg *arg);
> > > > > +
> > > > > +void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
> > > > > +				     struct optee_msg_arg *arg);
> > > > > +
> > > > > +void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
> > > > > +				 struct optee_msg_arg *arg);
> > > > > +#else
> > > > > +static inline void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
> > > > > +						    struct optee_msg_arg *arg)
> > > > > +{
> > > > > +	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
> > > > > +}
> > > > > +
> > > > > +static inline void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
> > > > > +						   struct optee_msg_arg *arg)
> > > > > +{
> > > > > +	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
> > > > > +}
> > > > > +
> > > > > +static inline void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
> > > > > +					       struct optee_msg_arg *arg)
> > > > > +{
> > > > > +	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
> > > > > +}
> > > > > +#endif
> > > > > +
> > > > >    #ifdef CONFIG_DM_I2C
> > > > >    /**
> > > > >     * optee_suppl_cmd_i2c_transfer() - route I2C requests to an I2C chip
> > > > > diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
> > > > > new file mode 100644
> > > > > index 00000000000..9c3e0f031ad
> > > > > --- /dev/null
> > > > > +++ b/drivers/tee/optee/rpmb.c
> > > > > @@ -0,0 +1,124 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > +
> > > > > +#include <dm.h>
> > > > > +#include <tee.h>
> > > > > +#include <ufs.h>
> > > > > +
> > > > > +#include "optee_msg.h"
> > > > > +#include "optee_msg_supplicant.h"
> > > > > +#include "optee_private.h"
> > > > > +
> > > > > +#define UFS_RPMB_CONTROLLER	0
> > > > 
> > > > Can this be a config option instead which defaults to 0 ?
> > > 
> > > um, I dont think so - this assumes there is only one controller. If there
> > > are more than one, we would need a mechanism to select which one from
> > > the enumerated values (maybe a DT alias (ie ufs-rpmb ?) I think the binding order
> > > changes as we enable/disable devices)
> > 
> > It could collide with other SCSI devices like SATA devices over PCIe.
> > 
> > Usually we try not to hardcode the devices ids.
> 
> 
> right...shall I go ahead with a DT alias approach?


something like this?


  8 ⋮  8 │ #include "optee_msg_supplicant.h"
  9 ⋮  9 │ #include "optee_private.h"
 10 ⋮ 10 │ 
 11 ⋮    │-#define UFS_RPMB_CONTROLLER        0
    ⋮ 11 │+static int optee_rpmb_get_scsi_dev(struct udevice **scsi_devp)
    ⋮ 12 │+{
    ⋮ 13 │+        struct udevice *ufs_dev, *scsi_dev;
    ⋮ 14 │+        ofnode node;
    ⋮ 15 │+        int ret;
    ⋮ 16 │+
    ⋮ 17 │+        node = ofnode_get_aliases_node("ufs-rpmb");
    ⋮ 18 │+        if (ofnode_valid(node))
    ⋮ 19 │+                ret = uclass_get_device_by_ofnode(UCLASS_UFS, node, &ufs_dev);
    ⋮ 20 │+        else
    ⋮ 21 │+                ret = uclass_get_device(UCLASS_UFS, 0, &ufs_dev);
    ⋮ 22 │+        if (ret)
    ⋮ 23 │+                return ret;
    ⋮ 24 │+
    ⋮ 25 │+        ret = device_get_child(ufs_dev, 0, &scsi_dev);
    ⋮ 26 │+        if (ret)
    ⋮ 27 │+                return ret;
    ⋮ 28 │+
    ⋮ 29 │+        *scsi_devp = scsi_dev;
    ⋮ 30 │+
    ⋮ 31 │+        return 0;
    ⋮ 32 │+}
 12 ⋮ 33 │ 
 13 ⋮ 34 │ void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
 14 ⋮ 35 │                                       struct optee_msg_arg *arg)

────────────────────────────────────────────────────────────────┐
• 76: void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev, │
────────────────────────────────────────────────────────────────┘
 55 ⋮ 76 │                 return;
 56 ⋮ 77 │         }
 57 ⋮ 78 │ 
 58 ⋮    │-        if (uclass_get_device(UCLASS_SCSI, UFS_RPMB_CONTROLLER, &scsi_dev)) {
    ⋮ 79 │+        if (optee_rpmb_get_scsi_dev(&scsi_dev)) {
 59 ⋮ 80 │                 arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
 60 ⋮ 81 │                 return;
 61 ⋮ 82 │         }

─────────────────────────────────────────────────────────────┐
• 124: void optee_suppl_cmd_rpmb_frames(struct udevice *dev, │
─────────────────────────────────────────────────────────────┘
 103⋮ 124│                 return;
 104⋮ 125│         }
 105⋮ 126│ 
 106⋮    │-        if (uclass_get_device(UCLASS_SCSI, UFS_RPMB_CONTROLLER, &scsi_dev)) {
    ⋮ 127│+        if (optee_rpmb_get_scsi_dev(&scsi_dev)) {
 107⋮ 128│                 arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
 108⋮ 129│                 return;
 109⋮ 130│         }

