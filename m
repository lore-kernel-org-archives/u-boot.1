Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6024C4453C
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 12:24:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A2CA080F0A;
	Wed, 22 Jul 2026 12:24:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gex1V5TX7iz2; Wed, 22 Jul 2026 12:24:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB53080EFB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784723047;
	bh=FWa917PVk9ailMTq2voCULmhzHeLG0MHhzQn2/eLMqM=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=YMFu3xXt5dkHL4oYqhWw1sK1yt7Z2rPAhXjI2hp83AVHq7HcuP3prK3QPZvQbIAIv
	 n/aaH0gdwwCNAFUYdDCetGRgFQ8YEjjteaYvgGKCmhEhldJ7ZIUG+eSKmFtMTal2U2
	 ORVgJKNF1nJ0Va+qYAe3ZaWrq/5NxibmT/PvvklgvGcUq5Zwvmqjc8ad+wWXnHv9us
	 bRwcqkxykYqd1pEmxSbFiKuogxXiTx4Z4Uw6QWrWqXk1eBmPaxBcE9ivyBXdQZwrey
	 UhFXQSUvh1lDVQwYwX6YOYzV260yoB5YczpdADBEtdqv2rSelKVZKdbe2O/awh5VBa
	 iIjHbDbGh3Yfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB53080EFB;
	Wed, 22 Jul 2026 12:24:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id DBBB2788
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:24:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C0966607C5
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:24:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5WNdKD-hUlPo for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 12:24:06 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=jorge.ramirez@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9D508606A8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D508606A8
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9D508606A8
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 12:24:05 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2140B848BA; Wed, 22 Jul 2026 14:24:04 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB714803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 14:24:01 +0200 (CEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M8xIxf4018304
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 12:23:59 GMT
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6fv0q9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 12:23:59 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso255410001cf.2
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 05:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784723038; x=1785327838;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:date
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FWa917PVk9ailMTq2voCULmhzHeLG0MHhzQn2/eLMqM=;
 b=sCkJO2SwKJpfD9aTP163zT5ivThSzA5Gx2oJTRi1XqzTyNFP2Z12bU5qGbUhvC7UN9
 PqYywpygfGBpXveTEnZYSNA5zK5uip7+AG2XiJ7dzgccTS6116cN4p3ZwycDwL7SH2Z8
 Wa1tpgsQSMBZRDtVJA6G27+YgOY0llvFEkIsIUi8Q4ogYMZZi4dL4YWQhrD3EGNSkfP2
 shWJiOBM9TXMZUurfQOZkpGF6ZSgzb/1926EUL7T85tvDQMGVjEH/RC1Dd/hzh5i1YEe
 7Vo5omX8CzBw0VYe3KfdDnfdQK8xCCEpjKpn4nTL35v60u86Zi26jtUxAw82CHQjgrIQ
 2TVg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4+++GVeJDl85El8d23h1Xss/Zc4mUmUzkErjN0xpfw2ICD4vOXZop8BlknB6yOSGVkQIkXPE=@lists.denx.de
X-Gm-Message-State: AOJu0YzPVQsKXeYXgrARs/dPDEUiV3dvOSXCpf3o3nGUSCSrpWhSq26Z
 RH/z4iBFIKclHqrzsIkhKeQkY55ilUJm6SfDVYj25Xk51HU1SAeQLZDL25eZFMuTG6JbULMAfbj
 9amNpJ/bB4vJk1yIrii9KoJg/GfuyHneFkMWiDki7beKcL5IFhjvxC42o
X-Gm-Gg: AR+sD108GR6aH8cw4TXfOYR/aYZfyDBGW4Vzw9mzQRIrxFxSsY5roDLzvS+nCFrpmww
 Vd2oXOmualsg1/mzugkywtlpvBWoGdYAjGTCIZDUZmAygxCWSf83ieifAUL4CT6/SCp5i9JaW8r
 cmsaqQxMX1xQFcaALfeOdXN+NC97bh98NReARK9kragGeNybSbMROVUxp6ZBfyv8XQ97bPbF/Ja
 zUy6qRECqWmAlm71Y5jqVK0qDvgSm1KDwy8ETx8vs9GLoCvzKX5g1OkEoczv66Ca0gUo3PNl9DC
 oGPdJUgiIT7qm9Oj5xhKUiX1PA8g2YdG7u8yvHzgPSvboJw8Zv7mcX7caVQVNy++piy4OMQwu1M
 yifquOSLGX/0KdzVG1Tp1hOX/Y/F3Lufxs44=
X-Received: by 2002:a05:622a:1313:b0:51c:1e69:bcc9 with SMTP id
 d75a77b69052e-5213c013f36mr217574101cf.12.1784723037915; 
 Wed, 22 Jul 2026 05:23:57 -0700 (PDT)
X-Received: by 2002:a05:622a:1313:b0:51c:1e69:bcc9 with SMTP id
 d75a77b69052e-5213c013f36mr217573671cf.12.1784723037425; 
 Wed, 22 Jul 2026 05:23:57 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b01a758sm57833165e9.4.2026.07.22.05.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 05:23:56 -0700 (PDT)
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Wed, 22 Jul 2026 14:23:54 +0200
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
Subject: Re: [PATCH v2 4/5] optee: rename rpmb.c to rpmb_legacy.c
Message-ID: <amC2WvGzM9Wmh4kJ@trex>
References: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
 <20260722060805.1428110-5-jorge.ramirez@oss.qualcomm.com>
 <f73c5fb0-881a-49bf-a5ff-a0120ab3e3b2@linaro.org>
 <amCRWI7K4Jj_psYp@trex>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amCRWI7K4Jj_psYp@trex>
X-Proofpoint-GUID: 3kiLrkoFo4wIBY9JsWAgMyolAJCOQLy0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDEyMCBTYWx0ZWRfX+C4ppkhg4GDW
 holNyTmyqaJbFHCcqjXktV4uJkYnsPCODFZdoOZyDS05iEaqMyIONYNwJi3x23TjOV+jJ2wp2FU
 n135jvHBziXUapL+2kudtAx4zBg/BIjelij9fW3S6M4NkuvO1WJFkGUBzsrxpMSZQ37uQWT0Pro
 12NashqD9WGc+wP+3QIdpK42nAMAEcfmtccIoS1ttGmVkt+egZ1c6QrazhBmLDiAHya+E65u6w9
 xkGJv6f9627p5ZyTxsR5H5Fbx84W0Mb1x67vO3OC76WjmdRuWoqc0MHArPwu/vcD1ocgq2FAvCI
 QK2ZwBcxsmgpdYsZ1jo70TthI7gT6UM59Q8cMZgC3xF2xLf8nAEP7DCgJV25fN1tpica21lIB61
 DSc1d+Wt8AUhshtcJ3/vXhQTwZPF0MGNQqxDu3K5zR+YHUBc3Z55q9OXkds+53pHNzg9fbUfsJ0
 jjKVWuTiCH8tBc2KZNw==
X-Authority-Analysis: v=2.4 cv=e/o2j6p/ c=1 sm=1 tr=0 ts=6a60b65f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=3lBABACTZsfq1MwG7BAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 3kiLrkoFo4wIBY9JsWAgMyolAJCOQLy0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDEyMCBTYWx0ZWRfX0/NWyNMf65Ms
 m8ARhMkUk8HxL6QKeCqJIcaGAm29jyEtMEqoFkcCxhJQ/jc0I7Obnpm9r5RTBa5/jWlGFnwwVFj
 zn/JtPQJDHNJK+kGNjC2x8vif2mvh/4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220120
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FWa917PVk9ailMTq2voCULmhzHeLG0MHhzQn2/eLMqM=; b=iQ0d9ap5MhNBxB/6
 6CUmOV5y9/svcegxP6bZOdrHgmH7iZ3jTz9zhWPSZh6oVLsXTcUMKtI6O7D3TWeJ
 3a9fkJ+rRQY9owIuhwGgoeWpPmajMzoy03X9xWt3mSpahuOTKVcNnSKTbWMGkBVG
 sgWHGB8cutOvf05wU0LROkg8rbDydbKCdj6YIcmo14EAagnycFeLDzM9IXSuRTSP
 bmJfFjsNpf0q+ajeorwm/mzih1xjsShd5HPQVmnoWlR+UyCJv6niuddM4vbtzBIH
 caGfy3T1Go67lnL9w9gJj0EMqAdCIhjeQ0Wdnp6wNk2dKH2rXZBkhpAB8SKIgfo2
 G3tlSg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784723038; x=1785327838; darn=lists.denx.de; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:date
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FWa917PVk9ailMTq2voCULmhzHeLG0MHhzQn2/eLMqM=;
 b=ImszaVVJOlR57kSAktsxYhS5uL+ybCRMUafojqU4HmcCA3spt7u5HgcShff2d+QQYI
 iMfnpYfk6F1VrwBrhqaQ+9nB3kuGOf3BEn0YcYLXQrFwlx49Ret1tiVe7zHRHB2UVKdU
 RUo9vX1gvJf14K2rvFbiV50HpmyxS5VajOLv1VJSxdAYKdKzdwWtn+F+B1wpJJsuvcIr
 8vtPeoaDLMNAl/l/iNjqtPe+xSijEChUQJix5yNMIe4H3Q4T8XREF3MhJWMITQvSs2HG
 kHknDNw+1wYYG67+Z1KRrddmcNqDuEangK7+/wN9/2M5Z2F9+x3AiqtAy0QYn6XFCKe0
 vyzw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=iQ0d9ap5; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=ImszaVVJ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iQ0d9ap5";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="ImszaVVJ"; 
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

On 22/07/26 11:46:00, Jorge Ramirez wrote:
> On 22/07/26 10:27:22, neil.armstrong@linaro.org wrote:
> > On 7/22/26 08:07, Jorge Ramirez-Ortiz wrote:
> > > This file implements the legacy single-command OPTEE_MSG_RPC_CMD_RPMB
> > > supplicant (eMMC only). Rename it to rpmb_legacy.c so the primary rpmb.c
> > > name is free for the RPMB subsystem interface added next; pure rename plus
> > > its Makefile object, no functional change.
> > > 
> > > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > > ---
> > >   drivers/tee/optee/Makefile                  | 2 +-
> > >   drivers/tee/optee/{rpmb.c => rpmb_legacy.c} | 0
> > >   2 files changed, 1 insertion(+), 1 deletion(-)
> > >   rename drivers/tee/optee/{rpmb.c => rpmb_legacy.c} (100%)
> > > 
> > > diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> > > index 36ac085ef42..8321cf53a19 100644
> > > --- a/drivers/tee/optee/Makefile
> > > +++ b/drivers/tee/optee/Makefile
> > > @@ -3,4 +3,4 @@
> > >   obj-$(CONFIG_OPTEE) += core.o
> > >   obj-y += supplicant.o
> > >   obj-$(CONFIG_DM_I2C) += i2c.o
> > > -obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb.o
> > > +obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_legacy.o
> > > diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb_legacy.c
> > > similarity index 100%
> > > rename from drivers/tee/optee/rpmb.c
> > > rename to drivers/tee/optee/rpmb_legacy.c
> > 
> > Why not rpmb_emmc ?
> > 
> > Neil
> 
> right this is what is confusing about the current abstraction; op-tee has two modes:
> 
>   1. Legacy mode (legacy_operation = true)
> 
>   - Uses the original RPC command OPTEE_RPC_CMD_RPMB.
>   - No device enumeration — assumes a single, fixed eMMC RPMB device at
>   - CFG_RPMB_FS_DEV_ID (dev_type = OPTEE_RPC_RPMB_EMMC).
>   - This is the fallback for older supplicants that don't understand the
>     probe protocol    
>   
>   2. Probe / new mode (legacy_operation = false)
> 
>   - Uses OPTEE_RPC_CMD_RPMB_PROBE_RESET + OPTEE_RPC_CMD_RPMB_PROBE_NEXT
>     to enumerate RPMB devices, then OPTEE_RPC_CMD_RPMB_FRAMES for the
>     actual frame I/O.
>   - Supports multiple RPMB devices
>   - OP-TEE probes all devices first, deferring key provisioning until
>     every device is examined.
> 
> This PR adds supports for UFS using the new mode of operation that
> enumerates devices instead of the legacy mode.
> 
> In the meantime eMMC continues to use the legacy mode.
> 
> So the super-sets are legacy (for emmc) and probe/default (for UFS and
> eventually eMMC/NVMe and so on).
> 

What the patch tries to say (my intention) is that rpmb_legacy.c should
not change moving forward and rpmb.c and tee should be extended with
eMMC support on the probe path.

