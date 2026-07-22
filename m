Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BECC4453A
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 09:46:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7990D407FA;
	Wed, 22 Jul 2026 09:46:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vTh4_7JD-YUB; Wed, 22 Jul 2026 09:46:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B0DF640433
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784713573;
	bh=0ZCPiJnBnRnNw5yQbUkVEyNiQZTL2vhiD6XXR/MbtzM=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=wUTxC4bM58Sa0UMxKbu0FUdEmepISRAgyHJGdQfagOThxOmgC6lQsI7DmPSfcCP+c
	 cnP7ld+Xp6y6ueEt8hjKKwyI0OOnTxNX7R6aym/NtkzPvauUvvb5Jokbqk7oU1BaUE
	 QAtFAGQDS2sqqpcbSvud9crGSZIxzWEQGONK6dUgmjQxqLCgMvAFwaEvvczMBthmA0
	 mdZWOpCB/tB8VYeGZrCQOucG7olPj0ICMVvd0gxGwrBTfMGguIcbhQNZ3Kdd7ux50a
	 bZmopV0Z1NcHqSg6CuTaaZyelEgXcdA7j4BXJgKB0bisOOcVH+kaGz3EB7dkmNCFDd
	 zO36Ltvc3lDYQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0DF640433;
	Wed, 22 Jul 2026 09:46:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D817109F
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 09:46:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 53323607A3
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 09:46:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v3APa0zbLXHF for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 09:46:11 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E424E60737
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E424E60737
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E424E60737
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 09:46:10 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A526848BA; Wed, 22 Jul 2026 11:46:09 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 323C3803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 11:46:07 +0200 (CEST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M8xXfr351336
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:46:05 GMT
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6d3ddd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 09:46:05 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51ebdfceddcso153450241cf.3
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 02:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784713565; x=1785318365;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:date
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0ZCPiJnBnRnNw5yQbUkVEyNiQZTL2vhiD6XXR/MbtzM=;
 b=qAvx16wredWdaAvUE1gvnbwZV6lu/jH0Z0QW++y0a/hulq/oi3elYumkfGAPTmGOGN
 yvCzxU6Oim7KyDneVkLyse3bkmVtpyaqndANdmd3N2Ts6lm5UJ263lzDdRUhc6Um3Vf2
 6/z6HOEoHRjQGkZihG4aYUWd6By7AFz/fNtejJM1b8iRVAM3mda/tdnLj50LVFwk33zj
 XzU2esIYT7cQNfSVKBa7uLrY0CM2zXgZMwGfxEuCdjydEg+AWyVmaoBrpDcqbxEZ7weT
 flOgAX6bXmn4NcVruB3kUr1n2vBEQpX6Dbj0lwmtGgSqzrJFD5hBkPNZz+POzAoQbfIA
 YPnA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRb9zAvrh9DXNRtN4zZmpC0+opKt98XYwSLaaETpT/o05LfFrK3LnKWSzj50BU9sX0z8rV9FQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxRp1BEWrnX5wyPRc6uvrGowhNszWpbGe7cMWg6GwM8CMTNRFZW
 vW0x/SaBukl0mKov0ni8hs6dW+JJlBZtLzvMPpJRipP1fde0AES9wI0Le3ZTCai3hiyCrKqyptO
 B2HWPf8qDyMO7YIkLHXkdm9p+5Mcx1lDJFvJxWDUkfLpcVQHbgg3CYXK3
X-Gm-Gg: AR+sD13pQomhc1KyJYcBKc30QZweYD3RCwYOz+k2RjHHmpBAqMH2z8v3MX9JGfwN41Y
 o3zaSJTz44RGQaq5CJM/7s5HEGmBNmU6fHFVLoIhcflqZhpx0aPevuba+szQ75OhThn1DPdom7F
 UnoACdnUOyzm0eo4ERXq35SDPHTRPca/aMylkJ//UrvD4cg2gBA049wcsuc4ygJGBU50ni7Rrb7
 8CT7H3DIn8I0K+UwP2Bc9FBrHd6Vi/uxjG0FbvcnZ2VqbrdExILwTkIaIUlCSGFtfsO8fZmSOAT
 NAZsB33pf2+eeoCyVJ8/lUG8YZWTYGnIyrigSzbe4X5WQ2/Fob8hes5D3T1G1HxpSa+tKM9D1zD
 ZZUhFrmWearnOrOhZP90A5CnPczyTQen9bsU=
X-Received: by 2002:a05:622a:15c2:b0:51b:f635:9aa1 with SMTP id
 d75a77b69052e-5213daa1d6dmr202911241cf.48.1784713564659; 
 Wed, 22 Jul 2026 02:46:04 -0700 (PDT)
X-Received: by 2002:a05:622a:15c2:b0:51b:f635:9aa1 with SMTP id
 d75a77b69052e-5213daa1d6dmr202910931cf.48.1784713564086; 
 Wed, 22 Jul 2026 02:46:04 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a63e3a8sm63807285e9.12.2026.07.22.02.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 02:46:02 -0700 (PDT)
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Wed, 22 Jul 2026 11:46:00 +0200
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, trini@konsulko.com, 
 jens.wiklander@linaro.org, ilias.apalodimas@linaro.org,
 bhupesh.linux@gmail.com, n-francis@ti.com,
 marek.vasut+renesas@mailbox.org, shawn.lin@rock-chips.com,
 igor.belwon@mentallysanemainliners.org,
 yoshihiro.shimoda.uh@renesas.com, alchark@gmail.com,
 tuyen.dang.xa@renesas.com, padmarao.begari@amd.com,
 macpaul.lin@mediatek.com, jstephan@baylibre.com, bb@ti.com,
 j-mcarthur@ti.com, venkyada@qti.qualcomm.com,
 hayashi.kunihiko@socionext.com, dlechner@baylibre.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 4/5] optee: rename rpmb.c to rpmb_legacy.c
Message-ID: <amCRWI7K4Jj_psYp@trex>
References: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
 <20260722060805.1428110-5-jorge.ramirez@oss.qualcomm.com>
 <f73c5fb0-881a-49bf-a5ff-a0120ab3e3b2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f73c5fb0-881a-49bf-a5ff-a0120ab3e3b2@linaro.org>
X-Proofpoint-GUID: o0K3qz85TGeMs4xHo7FpNb-b2E5WCCcw
X-Proofpoint-ORIG-GUID: o0K3qz85TGeMs4xHo7FpNb-b2E5WCCcw
X-Authority-Analysis: v=2.4 cv=XaG5Co55 c=1 sm=1 tr=0 ts=6a60915d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=E0F53I8y46Uz1Ggle9wA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA5MiBTYWx0ZWRfX7QClJRGWoe3z
 pSFE/qp/oq/rXxE2xVj/Ei6V5/hGpclEHYDLbTB6Vn534bvjWq0mbGFg4ac39PBB/IW0vXQMNjj
 JiTkOBzIUcgmZOmOG6sCSCX/tlLDY7sy1TGGLPLOjwve/GPswuR5ubxyaJXqZ7FtnXkofEzJVP9
 vQ6ZbEvfDIMH/CNSZBhQBC1elb5rMcS7prv7m1+nyVJmAf+LK3eyI/i//oFxk4P70jx9JWF2NMK
 5oSFM8ail9h5eAnUI1Il3QoZwMHxuJMNuPa/F1L3ntdnH8NbpPuZ91edzGkOE9RyG2OhBACQ6nc
 hIEjzgzg6sBOSeksi4ah+Mb+hqgerEJU5Ag/lqPikjLRcfK+jEQpipc1YF0kQ37LncGV7XQjC0m
 qR4bamxhuROMWaPUwhwH99SA07At/w4LiWiLeGswdKzWwZzxgmB60cZuyzkSqCGRzMcEZtYJiBi
 H7PQwbBozQ/U2FBxwig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA5MiBTYWx0ZWRfX7Eym7QlNqDe1
 LnuWFmvs8B7uZgR+Q5QQcp71IUIuD71OiH6hSUk3D7V6GOs5blKfKuImOIdz1tQK2F1SW/DLCVQ
 4E/mjBYZtpWNN0FRUi1WpG+3Oao4LDk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220092
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0ZCPiJnBnRnNw5yQbUkVEyNiQZTL2vhiD6XXR/MbtzM=; b=mxorHL6vA8pOyMpe
 +30h4y1QqpBdxU54ofJIhPvMF1k1D1LrMOzTNCGDpZw2RE7buVTpsECzGc+dyQSi
 q9Nljevrgz1FNgLht4lHQzvtK3Jma6WYCo/56XnNMbTqbz4HnxyFoy4y2WUcx7Kp
 5+AC+VVnsCb964b6h5CSQZ4rMWfDNpM0qCXvKDc3cI4C0XG/LyfjP56EUi6W8qfy
 MIPyHIfeNjEoQfIap+jHHTC0TgCvHqXzwJL20d4AUgthOaYCV077jB8Kit7XreLp
 Awj5j1OaUY4OoCO8XM2OyvhhKm3K1I/i6Aad4EakFaytOQ9cyrukMx7JXEU8Emdu
 OBaQsA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784713565; x=1785318365; darn=lists.denx.de; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:date
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0ZCPiJnBnRnNw5yQbUkVEyNiQZTL2vhiD6XXR/MbtzM=;
 b=JaL+ly/u7+HpXSIou+q0aSXi/BQOSV/7FAUvXqjNmY8rvP5lqnS25VzM73pqs0dL/r
 e8hZOKG44eWhv/mRfLALZFhum+dtHmQkHqDLELLTO2812IGq4PsXT5E4SB/6l0/tqqOF
 5wFHKRfPvfFCm3WwC/oAMvzzsxuosJyV8/8kzVz1HUlUG2Vahs8uuxY/VnGJnGJ5b9x5
 hfUVqKlm3VyKa4RW2ouQBYbFaMjTj57lr66K8NOiBq0oEaD3qw+DVsJqLlkWVD4z7aPx
 RyK/coP1YSnrtToB+sLowTMl5bduNMo536QIDl1l3O3AfJRGpT/DBkdr0L2mbkJoQOkj
 iang==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=mxorHL6v; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=JaL+ly/u
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mxorHL6v";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="JaL+ly/u"; 
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

On 22/07/26 10:27:22, neil.armstrong@linaro.org wrote:
> On 7/22/26 08:07, Jorge Ramirez-Ortiz wrote:
> > This file implements the legacy single-command OPTEE_MSG_RPC_CMD_RPMB
> > supplicant (eMMC only). Rename it to rpmb_legacy.c so the primary rpmb.c
> > name is free for the RPMB subsystem interface added next; pure rename plus
> > its Makefile object, no functional change.
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > ---
> >   drivers/tee/optee/Makefile                  | 2 +-
> >   drivers/tee/optee/{rpmb.c => rpmb_legacy.c} | 0
> >   2 files changed, 1 insertion(+), 1 deletion(-)
> >   rename drivers/tee/optee/{rpmb.c => rpmb_legacy.c} (100%)
> > 
> > diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> > index 36ac085ef42..8321cf53a19 100644
> > --- a/drivers/tee/optee/Makefile
> > +++ b/drivers/tee/optee/Makefile
> > @@ -3,4 +3,4 @@
> >   obj-$(CONFIG_OPTEE) += core.o
> >   obj-y += supplicant.o
> >   obj-$(CONFIG_DM_I2C) += i2c.o
> > -obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb.o
> > +obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_legacy.o
> > diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb_legacy.c
> > similarity index 100%
> > rename from drivers/tee/optee/rpmb.c
> > rename to drivers/tee/optee/rpmb_legacy.c
> 
> Why not rpmb_emmc ?
> 
> Neil

right this is what is confusing about the current abstraction; op-tee has two modes:

  1. Legacy mode (legacy_operation = true)

  - Uses the original RPC command OPTEE_RPC_CMD_RPMB.
  - No device enumeration — assumes a single, fixed eMMC RPMB device at
  - CFG_RPMB_FS_DEV_ID (dev_type = OPTEE_RPC_RPMB_EMMC).
  - This is the fallback for older supplicants that don't understand the
    probe protocol    
  
  2. Probe / new mode (legacy_operation = false)

  - Uses OPTEE_RPC_CMD_RPMB_PROBE_RESET + OPTEE_RPC_CMD_RPMB_PROBE_NEXT
    to enumerate RPMB devices, then OPTEE_RPC_CMD_RPMB_FRAMES for the
    actual frame I/O.
  - Supports multiple RPMB devices
  - OP-TEE probes all devices first, deferring key provisioning until
    every device is examined.

This PR adds supports for UFS using the new mode of operation that
enumerates devices instead of the legacy mode.

In the meantime eMMC continues to use the legacy mode.

So the super-sets are legacy (for emmc) and probe/default (for UFS and
eventually eMMC/NVMe and so on).

