Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F2DC44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 18:13:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD984413AC;
	Wed, 22 Jul 2026 18:13:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tArXL_ytPqbe; Wed, 22 Jul 2026 18:13:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14A5540E26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784743974;
	bh=l65POKOTA7dJWmC9luTKelMDNVxmUCAjqCNB9DRFSUk=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=NtgbxHnFZJJZ9kA8i08mGeyHW76F618rJeqXJ/xqbzlqxhwNkklzPHx0r4Oq+UmzE
	 At2xdPwtZw4r/fMXgZetC1iKmaMxMgZQOovJ52nOa1dEQoy3zb0sUiMyFfsFwEgfty
	 A7SglmtxZ0/hs4WU7qKe96BJvN5fYH72MlU9UYIm6kmL1EhkkphWFh2JJYOTRtxFTH
	 qi3/ThxcTEuIu4xpWJVCh20l9noZG1hZuJyiFTBFlV/e4E6K1kgz5Aeq1G/PJy8uvy
	 nOSmBsJTn9ZcpZI7iPZlnkMl9vIXLSxLwm5Q+sRYmO6C560oN4l8TYOZLVD9IAdNxX
	 P9971ZbJys0Ew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14A5540E26;
	Wed, 22 Jul 2026 18:12:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 550EC224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 18:12:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 44C3461290
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 18:12:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uqaSNtRIJp8a for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 18:12:51 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=jorge.ramirez@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 81C2A61253
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 81C2A61253
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 81C2A61253
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 18:12:30 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE7C8846A4; Wed, 22 Jul 2026 20:12:28 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7134783E76
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 20:12:26 +0200 (CEST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MHr9EJ1641641
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 18:12:24 GMT
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjt79ag4w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 18:12:23 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-526da7e3c9dso36113441cf.1
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 11:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784743943; x=1785348743;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l65POKOTA7dJWmC9luTKelMDNVxmUCAjqCNB9DRFSUk=;
 b=LNapKb6dHtIi4MR8UsXvCQpzF9+HNd7zHZV6xCQKWir+sFdvS37WXPmK3tKhsVLNvK
 WVJn3TyReZPzjEhJIL2CfdfRmkyrfFqU9Op1cNZ3rNJGaJ8w+Iw1LCmYJ/r8ykk2XMgy
 Oihn2aIgt7x7JUtZzz0R56cLGBiu2cUW5PZgkjuiXyjuQqyjh8JhfKD7W0cc2MQsoRug
 /HZo+oWcOXhqnuS7/MMKcD2h8nUDtKPYBQfmRJp/I65xdwyZc3AQe80iEHV1RzuYLI8i
 qaPK+YhYpC3zVy4p57cySSaIzTsy651c0UEviQw0BE3h0mZwiL+ASOjwJymYSv143lrR
 Tvrg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJQhq+X1q/ulCZfK1fwlICDBPxq+Ph33EwCBFn9Uy5iYhXkf+cR6XgLLIJN6uvj/3OBbj/Uiw=@lists.denx.de
X-Gm-Message-State: AOJu0YwrD5lxPtVNJtocbgH+v4Ro3XtBhFNfKL1YUji21+tWol3alnQJ
 zudX197DPJYVrrr768MBl+sCdNWU+yUwNE9WoOB5+SimoC8ut91/nABRBPdG/FWMaIuuyLH5R6Y
 e/zdygd0UoT0eb7D3fD92EYPin6aLgFeo/P79LzUBFUcM6J80xaRaKEwE
X-Gm-Gg: AR+sD103yjoee4uZzZXBjtvW/BAgRED0APyzu+vjalTD7CcM37DNOBm0f1MS74z1T99
 6/K4hPVKbfrFaRDL0eRLNURMdOH1OS6F71U7Dtz3R6mdQIEg6HN9OXNaTF+J7CL6nZ+XpJ85jZU
 0c/SUM3NzhllMm5auj3Y7Ky454QxNoEUMsiwjpAiBSMRhk+lROsvQqO9WtBayJHmTQxHEPjBSD0
 QI+RMBUtCwgzyvz3+nSDu/FA6GJ1AdMJ/uOZdheUYmGOkWIMdzzqp5ZIJiL/rEQ6gEMGMOGuGfs
 rNq11fDKM5rn5WdgpfHRqyI7lH6+5E4KNd0ExqHBtCIkjtqEuL9UEt9ZFbKJ+D8o91rqCw7cpnX
 XN4qGoTXdQ5rCrBjLnJVHCuCrEkdQFnCtUNw=
X-Received: by 2002:ac8:5705:0:b0:51c:7b12:5fff with SMTP id
 d75a77b69052e-5213e7795aemr220741391cf.75.1784743943029; 
 Wed, 22 Jul 2026 11:12:23 -0700 (PDT)
X-Received: by 2002:ac8:5705:0:b0:51c:7b12:5fff with SMTP id
 d75a77b69052e-5213e7795aemr220740941cf.75.1784743942522; 
 Wed, 22 Jul 2026 11:12:22 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49565373200sm151852025e9.5.2026.07.22.11.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:12:21 -0700 (PDT)
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Wed, 22 Jul 2026 20:12:19 +0200
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>, trini@konsulko.com,
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
Message-ID: <amEIA0pSVEehZJYt@trex>
References: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
 <20260722060805.1428110-6-jorge.ramirez@oss.qualcomm.com>
 <791913b4-d006-44be-8c94-871617418dbc@linaro.org>
 <amDP5roFBAAdOcYK@trex>
 <6f5137f9-d358-4c51-ac2c-f667cf126d80@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f5137f9-d358-4c51-ac2c-f667cf126d80@linaro.org>
X-Authority-Analysis: v=2.4 cv=Sr6gLvO0 c=1 sm=1 tr=0 ts=6a610807 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=tosiwmOeco_hmqAtg9MA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 98vCbaMhu4b4E-tfciRDlNrnSIqfefZ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE3OSBTYWx0ZWRfX2HnSaoMqpfNS
 pcUkewzk/JK6ceZwj30kfvPlvG5PkoTjjQTCkpMxj8e3V5ZrltOIoDkx1L7xQiJVCowMiLZ1xbB
 KuSgn0OncAhTwfaOwfCU51kpo9a3kfcsUhXafWVA9l1EyssSLFhVarM7ZDYhGSJ7sZVIi+yvxU9
 PJvTeqEGj0Duipr7T3HV2psEL5khzuM1/V69CDM33MdOAixOJz5nnOxOhJDH1+HH22y/PBEARVD
 gA3pfgmxv358PJbrbeG3piMSZJ7tASAdKbXDnigq1t6WHg6R19kpt8S/0dLW4VzdM43OKkvaiWn
 BCEP6kWXc4tpEB8+TqIIt0rwNKcC9U6NjFEYtWhSqfJK2YhxsuK6y0EdI2rX1rQCo2x1mrPTWa5
 AOZYUpADY4ih7pPKRZwrNktWZNdDQ+AbmNbvPVuBLiwS9q7UWdO1KCbV2TmGOgbHYZ24/en2E2f
 S378xi5dUAyhOoe9wVg==
X-Proofpoint-GUID: 98vCbaMhu4b4E-tfciRDlNrnSIqfefZ0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE3OSBTYWx0ZWRfX+eaeRGRvagr3
 L82JJVumSqG012SxLGsQHGayDN1g7DcetIlI1sRlEYj8LwDxGOPgcnMDFMU6tlrJTFqNe1gOeQh
 k/ellrLuIE+5N056AWA5Y3qg9V2MQPk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_05,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220179
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=l65POKOTA7dJWmC9luTKelMD
 NVxmUCAjqCNB9DRFSUk=; b=bQ6EZGRoYk+fad3AdXAWBjD9H/0A3SWuG32/zLxH
 JjMbuvmtnRsFRGWKv+GD4Cl3njXQtNgyiBiSGrM0UL3PPMoNQr8fYz5inxExOCHu
 T3r2YzeOg0MIeRl6R0bzD8iVMBy8cZBcER3KXUAITzTginoEQnC86RpC9LDWUwAl
 HZQ/jhrthZkKPEvZGUqQABOBj/bu4VpgB81qw5jKtc1dgjZ1pJql7fEK7x0qoym+
 Qdpcy+bnZuI8Ga7xpevz7iq2fF+4s41LXhJhyll3z7YfiZ7H5SglO/PW+w2YCA4x
 i+ufpICAcDi2/eVgQR9HpFY/NTivNcuV3PXEJlh3jdWoJg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784743943; x=1785348743; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l65POKOTA7dJWmC9luTKelMDNVxmUCAjqCNB9DRFSUk=;
 b=MRJP4l2i58CMJ+2prIKyq2aS8MjHvLnX8cPtSvU3Rkyy8kiXfObCwRtgzS5F9JOTRr
 z0DdoXi3HIdY76XTaFyeYO8IXtC/9wNMQk1dpREndEO1/aU7x89PwhX5dJwW55ExxDv5
 Wgs7OxoKdZCc769gDAZZUPIw7Ua1SvOyMGyj3zZ5M3MrdRgp3T958ifPsnjD7vXPPJgY
 Rwr9U/eQxOHXHM+cZ3+V2c8VIcH8++EUVOjw+mDNgzELyL14b+86+yC0mMnJeHZXYJo5
 Q7oio0Pgx3fLZ0WFAEhrPIpZxCv3mgs2G6r2Hbzxnd1+iOacY+eINUVehjfNs4H2h/Cr
 wuqQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=bQ6EZGRo; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=MRJP4l2i
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bQ6EZGRo";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="MRJP4l2i"; 
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

On 22/07/26 17:43:16, Neil Armstrong wrote:
> On 7/22/26 16:12, Jorge Ramirez wrote:
> > On 22/07/26 10:31:04, neil.armstrong@linaro.org wrote:
> > > Hi,
> > > 
> > > On 7/22/26 08:07, Jorge Ramirez-Ortiz wrote:
> > > > OP-TEE's legacy RPMB supplicant interface assumes the RPMB device is eMMC
> > > > and derives the key from an eMMC-shaped device ID, so it can never
> > > > reproduce the key Linux derives for a UFS device; secure storage on
> > > > UFS-only platforms instead needs the transport-agnostic RPMB subsystem
> > > > interface, through which the normal world describes the real RPMB device
> > > > to OP-TEE. Add a UFS backend for it so OP-TEE derives a key matching Linux
> > > > and can use RPMB secure storage on UFS, leaving the legacy eMMC path
> > > > untouched.
> > > > 
> > > > This subsystem backend currently supports UFS drives only; eMMC still uses
> > > > the legacy interface. As the legacy interface is dropped in favour of the
> > > > subsystem one, an eMMC backend should be added here so both transports are
> > > > served through a single RPMB path.
> > > > 
> > > > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > > > ---
> > > >    drivers/tee/optee/Makefile               |   1 +
> > > >    drivers/tee/optee/optee_msg_supplicant.h |   8 ++
> > > >    drivers/tee/optee/optee_private.h        |  41 ++++++++
> > > >    drivers/tee/optee/rpmb.c                 | 124 +++++++++++++++++++++++
> > > 
> > > Why not rpmb_ufs ?
> > 
> > 
> > because in the future (and IMO) rpmb.c should support UFS and EMMC using
> > the new probe interface (eventually removing rpmb_legacy).
> 
> Let's see in the future, if somehow there's need for a common "new"
> and emmc only legacy some rework will be needed anyway. The eMMC RPMB
> hasn't been updated for a very long time...
> 
> Using the driver model to register an rpmb device attached to an eMMC
> or UFS controller would the cleanest way to handle that, but we're not here now.
> 
> > 
> > > 
> > > It's fine to have 2 backend implementations, the emmc is implementing the
> > > legacy optee API, just add a comment in the eMMC file about that.
> > > 
> > > Neil
> > > 
> > > >    drivers/tee/optee/supplicant.c           |   9 ++
> > > >    5 files changed, 183 insertions(+)
> > > >    create mode 100644 drivers/tee/optee/rpmb.c
> > > > 
> > > > diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> > > > index 8321cf53a19..7af19834c00 100644
> > > > --- a/drivers/tee/optee/Makefile
> > > > +++ b/drivers/tee/optee/Makefile
> > > > @@ -4,3 +4,4 @@ obj-$(CONFIG_OPTEE) += core.o
> > > >    obj-y += supplicant.o
> > > >    obj-$(CONFIG_DM_I2C) += i2c.o
> > > >    obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_legacy.o
> > > > +obj-$(CONFIG_SUPPORT_UFS_RPMB) += rpmb.o
> > > > diff --git a/drivers/tee/optee/optee_msg_supplicant.h b/drivers/tee/optee/optee_msg_supplicant.h
> > > > index 963cfd47824..b720d5d7b3f 100644
> > > > --- a/drivers/tee/optee/optee_msg_supplicant.h
> > > > +++ b/drivers/tee/optee/optee_msg_supplicant.h
> > > > @@ -152,6 +152,14 @@
> > > >     */
> > > >    #define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 21
> > > > +#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_RESET	22
> > > > +#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_NEXT	23
> > > > +#define OPTEE_MSG_RPC_CMD_RPMB_FRAMES		24
> > > > +
> > > > +#define OPTEE_RPC_SHM_TYPE_APPL		0
> > > > +
> > > > +#define OPTEE_RPC_RPMB_UFS		1
> > > > +
> > > >    /*
> > > >     * Was OPTEE_MSG_RPC_CMD_SQL_FS, which isn't supported any longer
> > > >     */
> > > > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> > > > index 1f07a27ee4b..2888257aefe 100644
> > > > --- a/drivers/tee/optee/optee_private.h
> > > > +++ b/drivers/tee/optee/optee_private.h
> > > > @@ -9,6 +9,17 @@
> > > >    #include <tee.h>
> > > >    #include <log.h>
> > > > +#ifdef CONFIG_SUPPORT_UFS_RPMB
> > > > +/**
> > > > + * struct optee_private - OP-TEE driver private data
> > > > + * @rpmb_next_region:	next UFS RPMB region to report on PROBE_NEXT
> > > > + * @rpmb_cur_region:	UFS RPMB region selected by the last PROBE_NEXT
> > > > + */
> > > > +struct optee_private {
> > > > +	unsigned int rpmb_next_region;
> > > > +	unsigned int rpmb_cur_region;
> > > > +};
> > > > +#else
> > > >    /**
> > > >     * struct optee_private - OP-TEE driver private data
> > > >     * @rpmb_mmc:		mmc device for the RPMB partition
> > > > @@ -22,6 +33,7 @@ struct optee_private {
> > > >    	int rpmb_dev_id;
> > > >    	int rpmb_original_part;
> > > >    };
> > > > +#endif
> > > >    struct optee_msg_arg;
> > > > @@ -60,6 +72,35 @@ static inline void optee_suppl_rpmb_release(struct udevice *dev)
> > > >    }
> > > >    #endif
> > > > +#ifdef CONFIG_SUPPORT_UFS_RPMB
> > > > +void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
> > > > +				      struct optee_msg_arg *arg);
> > > > +
> > > > +void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
> > > > +				     struct optee_msg_arg *arg);
> > > > +
> > > > +void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
> > > > +				 struct optee_msg_arg *arg);
> > > > +#else
> > > > +static inline void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
> > > > +						    struct optee_msg_arg *arg)
> > > > +{
> > > > +	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
> > > > +}
> > > > +
> > > > +static inline void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
> > > > +						   struct optee_msg_arg *arg)
> > > > +{
> > > > +	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
> > > > +}
> > > > +
> > > > +static inline void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
> > > > +					       struct optee_msg_arg *arg)
> > > > +{
> > > > +	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
> > > > +}
> > > > +#endif
> > > > +
> > > >    #ifdef CONFIG_DM_I2C
> > > >    /**
> > > >     * optee_suppl_cmd_i2c_transfer() - route I2C requests to an I2C chip
> > > > diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
> > > > new file mode 100644
> > > > index 00000000000..9c3e0f031ad
> > > > --- /dev/null
> > > > +++ b/drivers/tee/optee/rpmb.c
> > > > @@ -0,0 +1,124 @@
> > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > +
> > > > +#include <dm.h>
> > > > +#include <tee.h>
> > > > +#include <ufs.h>
> > > > +
> > > > +#include "optee_msg.h"
> > > > +#include "optee_msg_supplicant.h"
> > > > +#include "optee_private.h"
> > > > +
> > > > +#define UFS_RPMB_CONTROLLER	0
> > > 
> > > Can this be a config option instead which defaults to 0 ?
> > 
> > um, I dont think so - this assumes there is only one controller. If there
> > are more than one, we would need a mechanism to select which one from
> > the enumerated values (maybe a DT alias (ie ufs-rpmb ?) I think the binding order
> > changes as we enable/disable devices)
> 
> It could collide with other SCSI devices like SATA devices over PCIe.
> 
> Usually we try not to hardcode the devices ids.


right...shall I go ahead with a DT alias approach?
