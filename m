Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F19C44539
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 14:13:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B41A407FA;
	Wed, 22 Jul 2026 14:13:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Om9KYvyz4INe; Wed, 22 Jul 2026 14:13:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 81240407FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784729586;
	bh=MqKNTkz55H7RjhT8H8oI0xh8BySOGegXyUDXN2wX1is=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=lY7+8vLhwR2vlzKNA5hniJcc1upqSn3UA/iBxZ8ItWJL1V/j2pN7Ga5c01uanUHwN
	 /z52WtAIEZMduddT3wDFTjgYiehBwgHWtgx9bTN7ZvODgVolJyf19rpgaxQvOGg3iC
	 Vps5j7bdgnFpIHdiC8L56zAZnZaOVY7eZCN3cr1AVxbCc9Gap4z3ngiVtQ9SdmT6fP
	 1YDhwJKWaZtyS0lny8wcPYsVtDXJD/7MeOeK55+79e9lP0/3bXOxt8SW09judL9Tcz
	 Bn6cnCt8bXDFznCN/4653Ln4VMa3LbvFVXN4bbD5LOzytJZY2K219ZYl5sxzgjs4Al
	 L1fMZvCWEHstA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81240407FB;
	Wed, 22 Jul 2026 14:13:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7D6402E5
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:13:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6FC08407FA
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:13:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qax-F7Mqt6yq for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 14:13:04 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=jorge.ramirez@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 237F1407EA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 237F1407EA
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 237F1407EA
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:13:04 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8902E8493F; Wed, 22 Jul 2026 16:13:02 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C03B803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 16:13:00 +0200 (CEST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MDWRsp891388
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 14:12:58 GMT
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjxm108c3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 14:12:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so260693101cf.1
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 07:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784729578; x=1785334378;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MqKNTkz55H7RjhT8H8oI0xh8BySOGegXyUDXN2wX1is=;
 b=cmaBcee7KikFydMWG4BpdgVyvZIFbuwrEV5QMxII3bo97gmunblT5bxG5Txn3adyGl
 hcAEpgQ3IOPfhsehf/fVWT+wcjIMttg4DWRHgW8hvPb9Shh+h5bw0Sh7IkFzEtsUhpaF
 dLPlKoH2wrZe6vrj5ov3wQZb1STl558KA3CYB14y42/Ywf8Kaf+fNAQupagzgjBP9cmq
 TZhiuia4rpOso0tXQk9pMXhwLWH8mDSwKfdmhW9xpZeI+8fkwGzvMg1ssHuf88iY4rrW
 GY+yehdTMNRFYhLDrqaX1P/uuUJeN16oNiLq5dxSZKIZPSfXMcNNSlTIZUgh529TP56a
 pogw==
X-Forwarded-Encrypted: i=1;
 AHgh+RquYGOgFjwVHKKJaqZa7nVBwpsmsiFBh8r9swoR4T4RTrttFJEs6ACdXGyt3VzPhw/tY6kHnVE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8FEtAqH6rpnl82SpU13zUxq1gwUW/7LVUU7ImzLZyzNv63okt
 O+N/CaOlXKA2ScEQo9/zk8lJYBKC1y568VqNvo65lb+oqsk64rNKcAR7QqbjBHAu1viievjVXS6
 m6kUmeKp82nhbPpMam1nFBHcgYt9+H0pYcJxziN1wIbm0rw/vepkLfd4G
X-Gm-Gg: AR+sD13CzQ+l+Yr35We0T9R0D0qVK655kiokJCjUFr9rHPUVUjvPPX2JN6aIiVPZFuK
 OkjQAUK/gxvsX2MkK6GK8TTBzh2CM1IyKuY71J8fSz/vOXaRYkGVqSN527nGHTLCbHWJnLzAwh+
 Kd1hAA+6M2ebKWnQwk0gfGMswhJZ2QlkWewlw4PFwAwDAEqMK1g/gmZTPUcnC/wNF+z6kklcTpw
 yzbhS8ITHripnse/RBHfJPRcZ8BuVo9pvujXNvPtLmFg/j/Jkt+zzdS5AzA2bqUowtY9/+p/y9R
 rIp1M+35clwjgJ/BbfLZ4NCKX23TRxX1CclWXDxYW7q1+/WCCNv5CJ64slAReqzSYgkxPNIZcn7
 uHY+M7P8qaRUNV8tKMweMx38nA/TcVA0Lmhc=
X-Received: by 2002:a05:622a:a588:b0:51a:8f3a:13b9 with SMTP id
 d75a77b69052e-5213aa6b248mr227412881cf.16.1784729577676; 
 Wed, 22 Jul 2026 07:12:57 -0700 (PDT)
X-Received: by 2002:a05:622a:a588:b0:51a:8f3a:13b9 with SMTP id
 d75a77b69052e-5213aa6b248mr227412501cf.16.1784729577213; 
 Wed, 22 Jul 2026 07:12:57 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a4f9a11sm69846215e9.4.2026.07.22.07.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 07:12:56 -0700 (PDT)
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Wed, 22 Jul 2026 16:12:54 +0200
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
Subject: Re: [PATCH v2 5/5] optee: implement the RPMB subsystem interface for
 UFS
Message-ID: <amDP5roFBAAdOcYK@trex>
References: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
 <20260722060805.1428110-6-jorge.ramirez@oss.qualcomm.com>
 <791913b4-d006-44be-8c94-871617418dbc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <791913b4-d006-44be-8c94-871617418dbc@linaro.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEzOCBTYWx0ZWRfX0lC+mfMOC2gU
 6+cJYH2A/Gs+FwvIq0UxhHdm85cLm/YgiBTPid+D+pgWJmuHlljjENtNseclKsQNERvwwLeoMdX
 /Rxd7l/vh2OJIFY9MahlRXY1J4D8ShU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEzOCBTYWx0ZWRfX4yzOIDTGQ2Bg
 brOoRmag7FTzWDDb8YMMDWdeKXEm/rPbElt9EeOrhuORga3aLxIcsRZHgKIRQ6udZBJ2UPaWtXO
 lsHwT2GD/5SEoY7Czdjq50LTB/8HCh438htJZYxizLWFZLIwS29p3cOdzbCbOBi8vB5KuLgK95L
 9sZsMRTFZS1zzP6sUqvuUnFmCHR0yH7iSYNHUm9r8EYuaCqIEiLUFWiC/MVNJXhdQcD8qnBC2Fd
 GtoQgKFU2wgTmxoh3BdFHVGSQjOAjP9kIXjB9/odaFCo5w8rTANe3NLQh6TugAKebsukUfJCsms
 9mqXsP1ZvAr9Dxgh5O23HgxMKzKPB8FxMc3DVI9HwKy8Lh9+7YE5GtgenAlJfQScXrHc8uiL9bb
 jlbf62lqCfRSLg+67jJ9xpqsG7JCTtlt7ldoj0MtEFen8ZvqWh7xxeboyF6wB10ZmdiQjumgraR
 uRWylLqRzyxY/0nU8sQ==
X-Authority-Analysis: v=2.4 cv=Rsv16imK c=1 sm=1 tr=0 ts=6a60cfea cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=uY4Z-vfNOv7TJdAcnycA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: fpmFwH81InjQyWpn1qbaUSRswgLTsXdy
X-Proofpoint-ORIG-GUID: fpmFwH81InjQyWpn1qbaUSRswgLTsXdy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220138
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=MqKNTkz55H7RjhT8H8oI0xh8
 BySOGegXyUDXN2wX1is=; b=Gy/K5YV+nOX245Gq07ptRff65vyvG4i7EEynJ5br
 Px8jKm9gP3l+I9R/tYtI3V7+TQwpQlrBXHAib5ZSpJilLTGH0SU5hXbys3ZqapGl
 vOx0VTZJYsg7bqGp4g/+E12d0ZFUxnffkEAo3l4xu653lItQLo29X+9dcBOuVj6N
 XGFd3DQvkDERLEifzuPWUJ/n0zlL9twKVzqH0kNt9mMJ1+dHMT6eY1CJjhP9Jc+x
 aN6xOs0dfNP1vk6K0/D/w/dJvPKZTdqazXAxC7A8nMg2m86PrBwF5c5kxeENJ9HN
 YYeTKiLOa4zmEBcxMIGR3Y25Ae2XzkpRgTUEJodVCdjSDw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784729578; x=1785334378; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MqKNTkz55H7RjhT8H8oI0xh8BySOGegXyUDXN2wX1is=;
 b=Cwreh+JEtLm5laG7ctqBid7X24Jhv/5K4pU6jtn4i1mdsFcxOZQ9vBP6UiwPJMLO3u
 VtHV9qRcDLtPhsTLPByKqPpgKHL3XVD8TtPS73AQLe/2jfy4ITSkCz0NF73Ee2JZ122L
 5utDiLxv7zUI//ln9BxxpEd0BbgJTiPyikbUhc4nGf/1hdOSYwR2EKK2nknJ2TRxone4
 Y+QAh11+ogA+uHs3HfNLZMnYaA6Lx9+EMUvfvDa2eqxgzUVk9YFeyv5Hd4MaQ0fVKmhJ
 Oeh1/pq118Xf8FcJiMKXFIhqzxIlSqrB0/Rf/n2lMc02yetnvXI5nOB4CDibB2L+ZnyD
 Kj4w==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=Gy/K5YV+; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Cwreh+JE
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gy/K5YV+";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="Cwreh+JE"; 
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

On 22/07/26 10:31:04, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 7/22/26 08:07, Jorge Ramirez-Ortiz wrote:
> > OP-TEE's legacy RPMB supplicant interface assumes the RPMB device is eMMC
> > and derives the key from an eMMC-shaped device ID, so it can never
> > reproduce the key Linux derives for a UFS device; secure storage on
> > UFS-only platforms instead needs the transport-agnostic RPMB subsystem
> > interface, through which the normal world describes the real RPMB device
> > to OP-TEE. Add a UFS backend for it so OP-TEE derives a key matching Linux
> > and can use RPMB secure storage on UFS, leaving the legacy eMMC path
> > untouched.
> > 
> > This subsystem backend currently supports UFS drives only; eMMC still uses
> > the legacy interface. As the legacy interface is dropped in favour of the
> > subsystem one, an eMMC backend should be added here so both transports are
> > served through a single RPMB path.
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > ---
> >   drivers/tee/optee/Makefile               |   1 +
> >   drivers/tee/optee/optee_msg_supplicant.h |   8 ++
> >   drivers/tee/optee/optee_private.h        |  41 ++++++++
> >   drivers/tee/optee/rpmb.c                 | 124 +++++++++++++++++++++++
> 
> Why not rpmb_ufs ?


because in the future (and IMO) rpmb.c should support UFS and EMMC using
the new probe interface (eventually removing rpmb_legacy).

> 
> It's fine to have 2 backend implementations, the emmc is implementing the
> legacy optee API, just add a comment in the eMMC file about that.
> 
> Neil
> 
> >   drivers/tee/optee/supplicant.c           |   9 ++
> >   5 files changed, 183 insertions(+)
> >   create mode 100644 drivers/tee/optee/rpmb.c
> > 
> > diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> > index 8321cf53a19..7af19834c00 100644
> > --- a/drivers/tee/optee/Makefile
> > +++ b/drivers/tee/optee/Makefile
> > @@ -4,3 +4,4 @@ obj-$(CONFIG_OPTEE) += core.o
> >   obj-y += supplicant.o
> >   obj-$(CONFIG_DM_I2C) += i2c.o
> >   obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_legacy.o
> > +obj-$(CONFIG_SUPPORT_UFS_RPMB) += rpmb.o
> > diff --git a/drivers/tee/optee/optee_msg_supplicant.h b/drivers/tee/optee/optee_msg_supplicant.h
> > index 963cfd47824..b720d5d7b3f 100644
> > --- a/drivers/tee/optee/optee_msg_supplicant.h
> > +++ b/drivers/tee/optee/optee_msg_supplicant.h
> > @@ -152,6 +152,14 @@
> >    */
> >   #define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 21
> > +#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_RESET	22
> > +#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_NEXT	23
> > +#define OPTEE_MSG_RPC_CMD_RPMB_FRAMES		24
> > +
> > +#define OPTEE_RPC_SHM_TYPE_APPL		0
> > +
> > +#define OPTEE_RPC_RPMB_UFS		1
> > +
> >   /*
> >    * Was OPTEE_MSG_RPC_CMD_SQL_FS, which isn't supported any longer
> >    */
> > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> > index 1f07a27ee4b..2888257aefe 100644
> > --- a/drivers/tee/optee/optee_private.h
> > +++ b/drivers/tee/optee/optee_private.h
> > @@ -9,6 +9,17 @@
> >   #include <tee.h>
> >   #include <log.h>
> > +#ifdef CONFIG_SUPPORT_UFS_RPMB
> > +/**
> > + * struct optee_private - OP-TEE driver private data
> > + * @rpmb_next_region:	next UFS RPMB region to report on PROBE_NEXT
> > + * @rpmb_cur_region:	UFS RPMB region selected by the last PROBE_NEXT
> > + */
> > +struct optee_private {
> > +	unsigned int rpmb_next_region;
> > +	unsigned int rpmb_cur_region;
> > +};
> > +#else
> >   /**
> >    * struct optee_private - OP-TEE driver private data
> >    * @rpmb_mmc:		mmc device for the RPMB partition
> > @@ -22,6 +33,7 @@ struct optee_private {
> >   	int rpmb_dev_id;
> >   	int rpmb_original_part;
> >   };
> > +#endif
> >   struct optee_msg_arg;
> > @@ -60,6 +72,35 @@ static inline void optee_suppl_rpmb_release(struct udevice *dev)
> >   }
> >   #endif
> > +#ifdef CONFIG_SUPPORT_UFS_RPMB
> > +void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
> > +				      struct optee_msg_arg *arg);
> > +
> > +void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
> > +				     struct optee_msg_arg *arg);
> > +
> > +void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
> > +				 struct optee_msg_arg *arg);
> > +#else
> > +static inline void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
> > +						    struct optee_msg_arg *arg)
> > +{
> > +	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
> > +}
> > +
> > +static inline void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
> > +						   struct optee_msg_arg *arg)
> > +{
> > +	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
> > +}
> > +
> > +static inline void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
> > +					       struct optee_msg_arg *arg)
> > +{
> > +	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
> > +}
> > +#endif
> > +
> >   #ifdef CONFIG_DM_I2C
> >   /**
> >    * optee_suppl_cmd_i2c_transfer() - route I2C requests to an I2C chip
> > diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
> > new file mode 100644
> > index 00000000000..9c3e0f031ad
> > --- /dev/null
> > +++ b/drivers/tee/optee/rpmb.c
> > @@ -0,0 +1,124 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +
> > +#include <dm.h>
> > +#include <tee.h>
> > +#include <ufs.h>
> > +
> > +#include "optee_msg.h"
> > +#include "optee_msg_supplicant.h"
> > +#include "optee_private.h"
> > +
> > +#define UFS_RPMB_CONTROLLER	0
> 
> Can this be a config option instead which defaults to 0 ?

um, I dont think so - this assumes there is only one controller. If there
are more than one, we would need a mechanism to select which one from
the enumerated values (maybe a DT alias (ie ufs-rpmb ?) I think the binding order
changes as we enable/disable devices)



