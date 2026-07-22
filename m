Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAE1C44512
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 06:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3CE580D3D;
	Wed, 22 Jul 2026 06:10:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iQinUa7-FjQO; Wed, 22 Jul 2026 06:10:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3095E80CDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784700625;
	bh=nHJD2mXVPmC5sGrSlbhqVEoWpWS4kggOjR2/BecOJnc=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=SNd6T5MKIXMLig3M4cEkE0VCMzEGlhQzEbYO5i1eS7vSANgyTQoRQEvPu46i/M6Br
	 FB6nOcDkf19nCvsdqmsto2/7/8TBGzQMAJS+QLNSp4rPTJX34BVON+LEcRGYVbRcaJ
	 HKd+x5OmuZbecnyeu3h6Wp3zbqW+aMXWT9NXQ5mukZSYKXffwScgBfIoKfSvik+wVB
	 3FDqXsj4kV4gTxfoIkoeZuA1tL1g4CC+7HMjhf3Ykdwk3sGP6Suojv46U+zlgGEpaq
	 Y32zJNva7eIK+yALTeDyYl2FzjRyY2ea9I/SzCCSIB0ucNdgnj0AvMIr0m+frWZKOd
	 NVAHbWzVPbdYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3095E80CDC;
	Wed, 22 Jul 2026 06:10:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C11FB313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:10:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6C9C80CDC
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:10:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MxEn3_afbPqc for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 06:10:20 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=jorge.ramirez@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DC7A380C98
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DC7A380C98
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DC7A380C98
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 06:10:19 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23501848BA; Wed, 22 Jul 2026 08:10:18 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83887803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 08:10:15 +0200 (CEST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53iSE3883067
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 06:10:13 GMT
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjntn0jfc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 06:10:12 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51a8db414c7so211837891cf.0
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 23:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784700612; x=1785305412;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nHJD2mXVPmC5sGrSlbhqVEoWpWS4kggOjR2/BecOJnc=;
 b=liGr3MwatXyfHbjOsS0qxH/F/pfjPbuo2zjPcPbeH52h1UX5vhrKw1BtpAF8X3zH4P
 9lAt0q4ioj+bUqcz8OrNAN7og1bm3L2V/O+a38mF52o942jiMhChjFJ2ruoIZ4yagaWY
 ORqM9n+53gm8I9h9WLs8Q8vGG1qpmwlB3RCGf2YvLb42UcMJhX+j+/a2+6y3Hfo4G7JJ
 0CbYFYEzEzkrLyT+feCImis+fb9c6jcS9K1vUlR7KCf/OHrCpzJ/x3xHc/F7yfLOwfCI
 8B+66Cq7ss1q//zMguTFlU/cSMdlTGyG2PCryG5sEmI9npVx1GAbLMoOlRweY1nEZ9rL
 MqWg==
X-Forwarded-Encrypted: i=1;
 AHgh+RotSIGXdvjVNG2gvUx6bjdUM+HiQEt3aVN6htT55rE5BPb+rvfJ3dZOOG/pLNUPPFmsxNPXzWs=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3kgZO0k9g4lhyPMuty8qo9fFtC89dC9iAYNwQCj9ywrlpHYHx
 5ZWe+CbhqQ4AaeCk91t0txHfAmSan9SBBntthN8vswj6xZ1ZtjT4oBmEYh78Kqm0GVK8VcKWFy1
 +XxK2AAt+RdFBX1kh0x5051fW/BO5KkDm/wXCQ/lxm6dKmLMCVLoXv1Vc
X-Gm-Gg: AR+sD10Hf3KxDiBCnpM32MuNoAFsyiFexD2NJ225nFrF/I1rbpokjMLT2vp0JfvYGdu
 Y8aJZssv3LOMfum/XT/67PbkEXfuBLxx30eIxJv0SQPIfa/N1gd1CLwLeGSdyd/htUhK6cTm310
 Er1Z2mCRTAMLRzfu+5eImkpwUz31CIvBnBdpnfuxAFs09lnqzQIAkS4l9cu6FuiVCcuGuWRLblK
 3iW4OFNBxIWDWHxeTEx3EWqEkb8qk2ptRpQv9HPjY1FaI0QVOgvZyE/Xnj1HL/YBzJfFs+THb0a
 f0O5H2Ew4ZuEqD18ewbuUSqBnTkGkqxYmq0OArmIcW5K4DD0NvMjgBdFooqrzy2XwSppTRgXzpF
 bKne18IizP6yMbpLh+9gWkBpJcRSq/Cyum7M=
X-Received: by 2002:ac8:5805:0:b0:51b:ec6c:766c with SMTP id
 d75a77b69052e-5213c8e2baamr202321001cf.12.1784700612077; 
 Tue, 21 Jul 2026 23:10:12 -0700 (PDT)
X-Received: by 2002:ac8:5805:0:b0:51b:ec6c:766c with SMTP id
 d75a77b69052e-5213c8e2baamr202320591cf.12.1784700611387; 
 Tue, 21 Jul 2026 23:10:11 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6e9a2sm2904517f8f.35.2026.07.21.23.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:10:10 -0700 (PDT)
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Wed, 22 Jul 2026 08:10:08 +0200
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, trini@konsulko.com, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 bhupesh.linux@gmail.com, n-francis@ti.com, marek.vasut+renesas@mailbox.org,
 igor.belwon@mentallysanemainliners.org, shawn.lin@rock-chips.com,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, macpaul.lin@mediatek.com,
 padmarao.begari@amd.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com,
 hayashi.kunihiko@socionext.com, u-boot@lists.denx.de, sumit.garg@kernel.org
Subject: Re: [PATCH v1 2/7] ufs: add RPMB transport over SCSI SECURITY PROTOCOL
Message-ID: <amBewH0VMPEafAcL@trex>
References: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
 <20260720085202.537019-3-jorge.ramirez@oss.qualcomm.com>
 <6655cb53-fe79-4163-b148-377ee35fbee8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6655cb53-fe79-4163-b148-377ee35fbee8@linaro.org>
X-Authority-Analysis: v=2.4 cv=AJsSZ1gA c=1 sm=1 tr=0 ts=6a605ec4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=nGqrtihi8Qc3EbD5CxEA:9 a=CjuIK1q_8ugA:10
 a=O8hF6Hzn-FEA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: OfreCs8IWbaF01IkYabhmoOUBPCUQMuU
X-Proofpoint-ORIG-GUID: OfreCs8IWbaF01IkYabhmoOUBPCUQMuU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA1NCBTYWx0ZWRfX2tskQg4vY89y
 HZSKmVIce3CV7sJ4yeLzaFTySJpjSUqUQZDhoqv8JCVyU5D4c+F2XHdoO88+d//KO/iRR8+tYv8
 hLDup2LbVnVwgXrMRoY2zVSTgL3dRno=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA1NCBTYWx0ZWRfX6uY3uRyoMs7Y
 tFskdWUzBaVMnOWCX61t/TJz9aq0xmLXGykYCIBb3eetdC2I95K3Tz5Fzn8ztISGPXIIDLSqm7O
 ufvnU3cA3qUlHVKi8ifarKDiebuQggLlWBcctN67vj2N9rMiULJeApFpgsROKgi7pGyuIGs4D+I
 EKtxbO5e8X0iUNkloZ89gUO2zdl3J2qDa3/jtSpxhjVHsSZnoydZvqJauUHEVrx59b1RkQLVBVt
 dl9r83iwSrUReECWdDYacNmaUxltmOeI7ESzXAAltQM9VML7eeuVZeeutA2CoGWVxd6COt/Yzqk
 BtnI1uEZ1uqYKUYmW10/r8vgr+ibN2dsDgsLNaoLqYltjTtM89F5+dbaCJZzbhhVE9rHaNE5GZT
 /eY/4OH4RtYqIwyvOW/rqxOvH3XFj4J87fA3I8bq0im1TAgMi2vhtsSdpLFIbjrzDZpekU+vZ3m
 KwqYK2ow+Ty73KE1rng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220054
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=nHJD2mXVPmC5sGrSlbhqVEoW
 pWS4kggOjR2/BecOJnc=; b=pZiQdbM7cAh+m2Xo18yko8Lha0TZzXmIovJCOwXp
 R/d9Dr8bUp3N0XFbtH1iGHWYxkKZrq25B9xuE7VNX9haJsvoj1s38ftDzlsMANgn
 m2+sSBPyquhzQuuZceGfGvkrRY/HjwUYff69dLIaQhVOqWiq3y+op5YBYGNBPAoh
 XLO91jsHFGVt7kUvzm2Yu+FDivxzCGN2Z0INl6pBlxTSzgTPEGvz0U+IPkA/mBSn
 L0WhY41qCMT3JIj0y51zpu7a/GIDWR3engiTTu2W2G58hLHZvJr660kNjim1NS8V
 Ifse5aCJTFz+ebj4QLUCng7aOOpQv2XTJAiNwKu6AsyaCQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784700612; x=1785305412; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nHJD2mXVPmC5sGrSlbhqVEoWpWS4kggOjR2/BecOJnc=;
 b=cE/VBQlPYyVUWtELOwGhuo3qNC8wU01/sj7gLB5McWBrh76drS98ymvcMmnFZcxpW5
 Cl6mt28VEI6Eh71UhQAMRSnWixhhGz23R7hc+A0AFW4pDEIVHGVSZk93zGpjc7nNvCte
 GvkIatsrK/TUllSijL+/RrAPEFq8EGjjT4gKhAOcwcflXZMtTgrmzPWaPKbQiDwuOgxn
 8S4KB+K9bI8pikmQnSRb+DFB1UFxPorn7EM7ft00YZjXNES/foBOwZQfiKXtwbjOvK/G
 OYVqF4KZxwETLnAp4/qMmumo8cj7z9cLQqo6Z1oOCmWuKZakuzvtDgbmCyYsYQSLqaS0
 a6xA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=pZiQdbM7; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=cE/VBQlP
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pZiQdbM7";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="cE/VBQlP"; 
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

On 21/07/26 09:46:55, neil.armstrong@linaro.org wrote:
> Hi,
> On 7/20/26 10:51, Jorge Ramirez-Ortiz wrote:
> > Add a UFS RPMB transport that moves fully-formed JEDEC RPMB frames to and
> > from the RPMB Well-Known LUN using SCSI SECURITY PROTOCOL IN/OUT commands,
> > exposed through ufs_rpmb_route_frames() for the OP-TEE RPMB supplicant and
> > guarded by CONFIG_SUPPORT_UFS_RPMB.
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > ---
> >   drivers/ufs/Kconfig      |  13 ++++
> >   drivers/ufs/Makefile     |   1 +
> >   drivers/ufs/ufs-rpmb.c   | 146 +++++++++++++++++++++++++++++++++++++++
> >   drivers/ufs/ufs-uclass.c |   6 ++
> >   drivers/ufs/ufs.h        |  13 ++++
> >   include/ufs.h            |   8 +++
> >   6 files changed, 187 insertions(+)
> >   create mode 100644 drivers/ufs/ufs-rpmb.c
> > 
> > diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> > index 49472933de3..d39fcda42dc 100644
> > --- a/drivers/ufs/Kconfig
> > +++ b/drivers/ufs/Kconfig
> > @@ -92,4 +92,17 @@ config UFS_TI_J721E
> >   	  This selects the glue layer driver for Cadence controller
> >   	  present on TI's J721E devices.
> > +config SUPPORT_UFS_RPMB
> > +	bool "Enable UFS RPMB (Replay Protected Memory Block) support"
> > +	depends on UFS && OPTEE && !SUPPORT_EMMC_RPMB
> > +	select BLAKE2
> > +	help
> > +	  Route OP-TEE RPMB requests to the UFS RPMB Well-Known LUN using
> > +	  SCSI SECURITY PROTOCOL IN/OUT commands. Required for OP-TEE secure
> > +	  storage (CFG_RPMB_FS) on UFS-based platforms that have no eMMC.
> > +	  BLAKE2 is used to derive the fixed-length RPMB CID that matches the
> > +	  Linux kernel UFS device_id ABI. The OP-TEE supplicant handles a
> > +	  single RPMB transport, so this is mutually exclusive with the eMMC
> > +	  RPMB supplicant (SUPPORT_EMMC_RPMB).
> > +
> >   endmenu
> > diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
> > index e7f3c1d30c4..d60440ca119 100644
> > --- a/drivers/ufs/Makefile
> > +++ b/drivers/ufs/Makefile
> > @@ -13,3 +13,4 @@ obj-$(CONFIG_UFS_RENESAS) += ufs-renesas.o
> >   obj-$(CONFIG_UFS_RENESAS_GEN5) += ufs-renesas-rcar-gen5.o
> >   obj-$(CONFIG_UFS_ROCKCHIP) += ufs-rockchip.o
> >   obj-$(CONFIG_UFS_TI_J721E) += ti-j721e-ufs.o
> > +obj-$(CONFIG_SUPPORT_UFS_RPMB) += ufs-rpmb.o
> > diff --git a/drivers/ufs/ufs-rpmb.c b/drivers/ufs/ufs-rpmb.c
> > new file mode 100644
> > index 00000000000..636ccb6e74f
> > --- /dev/null
> > +++ b/drivers/ufs/ufs-rpmb.c
> > @@ -0,0 +1,146 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +#include <dm.h>
> > +#include <log.h>
> > +#include <scsi.h>
> > +#include <ufs.h>
> > +#include <linux/errno.h>
> > +#include <linux/string.h>
> > +#include "ufs.h"
> > +
> > +#define RPMB_REQ_KEY		1
> > +#define RPMB_REQ_WCOUNTER	2
> > +#define RPMB_REQ_WRITE_DATA	3
> > +#define RPMB_REQ_READ_DATA	4
> > +#define RPMB_REQ_STATUS		5
> > +
> > +#define RPMB_FRAME_REQ_OFFSET	510
> > +
> > +static u16 rpmb_frame_request(const void *frame)
> > +{
> > +	const u8 *p = frame;
> > +
> > +	return ((u16)p[RPMB_FRAME_REQ_OFFSET] << 8) |
> > +		p[RPMB_FRAME_REQ_OFFSET + 1];
> > +}
> > +
> > +static int ufs_rpmb_secprot(struct udevice *scsi_dev, unsigned int region,
> > +			    u8 opcode, void *buf, unsigned int nframes,
> > +			    enum dma_data_direction dir)
> > +{
> > +	struct scsi_cmd pccb;
> > +	u32 len = nframes * RPMB_FRAME_SIZE;
> > +	u16 spsp = (region << 8) | UFS_RPMB_SEC_PROTOCOL_ID;
> > +
> > +	memset(&pccb, 0, sizeof(pccb));
> > +	pccb.lun = UFS_UPIU_RPMB_WLUN;
> > +	pccb.cmd[0] = opcode;
> > +	pccb.cmd[1] = SEC_PROTOCOL_UFS;
> > +	pccb.cmd[2] = (spsp >> 8) & 0xff;
> > +	pccb.cmd[3] = spsp & 0xff;
> > +	pccb.cmd[4] = 0;
> > +	pccb.cmd[5] = 0;
> > +	pccb.cmd[6] = (len >> 24) & 0xff;
> > +	pccb.cmd[7] = (len >> 16) & 0xff;
> > +	pccb.cmd[8] = (len >> 8) & 0xff;
> > +	pccb.cmd[9] = len & 0xff;
> > +	pccb.cmd[10] = 0;
> > +	pccb.cmd[11] = 0;
> > +	pccb.cmdlen = 12;
> > +	pccb.pdata = buf;
> > +	pccb.datalen = len;
> > +	pccb.dma_dir = dir;
> > +
> > +	return scsi_exec(scsi_dev, &pccb);
> > +}
> > +
> > +static int ufs_rpmb_send(struct udevice *scsi_dev, unsigned int region,
> > +			 void *frames, unsigned int nframes)
> > +{
> > +	return ufs_rpmb_secprot(scsi_dev, region, SECURITY_PROTOCOL_OUT,
> > +				frames, nframes, DMA_TO_DEVICE);
> > +}
> > +
> > +static int ufs_rpmb_recv(struct udevice *scsi_dev, unsigned int region,
> > +			 void *frames, unsigned int nframes)
> > +{
> > +	return ufs_rpmb_secprot(scsi_dev, region, SECURITY_PROTOCOL_IN,
> > +				frames, nframes, DMA_FROM_DEVICE);
> > +}
> > +
> > +int ufs_rpmb_route_frames(struct udevice *scsi_dev, unsigned int region,
> > +			  void *req, unsigned long reqlen, void *rsp,
> > +			  unsigned long rsplen)
> > +{
> > +	unsigned int n_req = reqlen / RPMB_FRAME_SIZE;
> > +	unsigned int n_rsp = rsplen / RPMB_FRAME_SIZE;
> > +	u16 request;
> > +	int ret;
> > +
> > +	if (!scsi_dev || reqlen % RPMB_FRAME_SIZE ||
> > +	    rsplen % RPMB_FRAME_SIZE || !n_req)
> > +		return -EINVAL;
> > +
> > +	request = rpmb_frame_request(req);
> > +
> > +	switch (request) {
> > +	case RPMB_REQ_KEY:
> > +	case RPMB_REQ_WRITE_DATA: {
> > +		u8 status_frame[RPMB_FRAME_SIZE];
> > +
> > +		ret = ufs_rpmb_send(scsi_dev, region, req, n_req);
> > +		if (ret)
> > +			return ret;
> > +
> > +		memset(status_frame, 0, sizeof(status_frame));
> > +		status_frame[RPMB_FRAME_REQ_OFFSET] = RPMB_REQ_STATUS >> 8;
> > +		status_frame[RPMB_FRAME_REQ_OFFSET + 1] = RPMB_REQ_STATUS & 0xff;
> > +		ret = ufs_rpmb_send(scsi_dev, region, status_frame, 1);
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (n_rsp < 1)
> > +			return -EINVAL;
> > +		return ufs_rpmb_recv(scsi_dev, region, rsp, 1);
> > +	}
> > +	case RPMB_REQ_WCOUNTER:
> > +	case RPMB_REQ_READ_DATA:
> > +		ret = ufs_rpmb_send(scsi_dev, region, req, 1);
> > +		if (ret)
> > +			return ret;
> > +		if (n_rsp < 1)
> > +			return -EINVAL;
> > +		return ufs_rpmb_recv(scsi_dev, region, rsp, n_rsp);
> > +	default:
> > +		debug("ufs-rpmb: unsupported request 0x%x\n", request);
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +struct udevice *ufs_rpmb_get_scsi_dev(int dev_id)
> > +{
> > +	struct udevice *scsi_dev;
> > +	int ret;
> > +
> > +	ret = uclass_get_device(UCLASS_SCSI, dev_id, &scsi_dev);
> > +	if (ret) {
> > +		debug("ufs-rpmb: no SCSI device for dev_id %d: %d\n",
> > +		      dev_id, ret);
> > +		return NULL;
> > +	}
> > +	return scsi_dev;
> > +}
> 
> This is a wrapper on uclass_get_device(), why not using uclass_get_device()
> from the caller code ?

ok.

> 
> > +
> > +int ufs_rpmb_read_geometry(struct udevice *scsi_dev, u8 *rpmb_rw_size)
> > +{
> > +	struct ufs_hba *hba = dev_get_uclass_priv(scsi_dev->parent);
> > +	u8 desc[QUERY_DESC_GEOMETRY_DEF_SIZE];
> > +	int ret;
> > +
> > +	ret = ufshcd_read_descriptor(hba, QUERY_DESC_IDN_GEOMETRY, 0,
> > +				     desc, sizeof(desc));
> > +	if (ret)
> > +		return ret;
> > +
> > +	*rpmb_rw_size = desc[GEOMETRY_DESC_RPMB_RW_SIZE];
> > +	return 0;
> > +}
> > diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> > index 4d10e0b11fe..962b6093762 100644
> > --- a/drivers/ufs/ufs-uclass.c
> > +++ b/drivers/ufs/ufs-uclass.c
> > @@ -1712,6 +1712,12 @@ static inline int ufshcd_read_desc(struct ufs_hba *hba, enum desc_idn desc_id,
> >   	return ufshcd_read_desc_param(hba, desc_id, desc_index, 0, buf, size);
> >   }
> > +int ufshcd_read_descriptor(struct ufs_hba *hba, enum desc_idn desc_id,
> > +			   int desc_index, u8 *buf, u8 size)
> > +{
> > +	return ufshcd_read_desc_param(hba, desc_id, desc_index, 0, buf, size);
> 
> Why you don't expose & use ufshcd_read_desc_param() directly ?

sure

> 
> > +}
> > +
> >   static int ufshcd_read_device_desc(struct ufs_hba *hba, u8 *buf, u32 size)
> >   {
> >   	return ufshcd_read_desc(hba, QUERY_DESC_IDN_DEVICE, 0, buf, size);
> > diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> > index 0f6c93fbce7..e66d2c5f533 100644
> > --- a/drivers/ufs/ufs.h
> > +++ b/drivers/ufs/ufs.h
> > @@ -10,6 +10,16 @@
> >   struct udevice;
> >   #define UFS_CDB_SIZE	16
> > +
> > +#define UFS_UPIU_RPMB_WLUN		0xC4
> > +#define RPMB_FRAME_SIZE			512
> 
> Can this be declared in a common rpbm header ?
> 
> > +
> > +#define SECURITY_PROTOCOL_IN		0xA2
> > +#define SECURITY_PROTOCOL_OUT		0xB5
> 
> Those are SCSI indentifiers, move the, to sci headers.
> 
> > +#define SEC_PROTOCOL_UFS		0xEC
> > +#define UFS_RPMB_SEC_PROTOCOL_ID	0x01
> 
> Those are not UFS internal identifiers, move them to the ufs-rpmb code like Linux.

ok, let me fix all this issues on v2
