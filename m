Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EEFC531C7
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 14:35:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B2D374083B;
	Wed, 22 Jul 2026 14:35:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ehnKjq5l8UwD; Wed, 22 Jul 2026 14:35:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A1F9E407FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784730915;
	bh=CruRYsJtNdisq+RMDC+JbwpuC9jvhABCRMjSpx2rX1U=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=IIT+OJp5NJ5uUwOcKqtvWu2+qiWL2nPiUlAJoZm6zqWV8EJtsf+jv/xrtmPy22BSc
	 JbDVY1OTmmZXe4sP5NCNv3QK6U6a4wUAxEvoTLZNWGMBxf53ACLCRhkEV4fvgi6TAs
	 tFkMO7lRV7M+X9kyMVcrFtUrY8p56cEVkzDCZP/1gbsoMN+4Y5zB4j0UEl5zYQLB6E
	 M5vrLW75aaDa3xqpUL+gDa63DDzCgVLlA3ldxyRF+LzGVF16wGPt/x+5rWizb0oVIh
	 tmv4GDsqrc0O6vi0+a0FMHr7cF5BIoDjQ2nmDN+K1/KCYyv3mfFyrdFaABNb2msHMJ
	 qvv9StxFVAwrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1F9E407FF;
	Wed, 22 Jul 2026 14:35:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A0503313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:35:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 864DD407FD
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:35:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id reM7qsazIf-R for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 14:35:13 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 41E8E4078A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 41E8E4078A
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 41E8E4078A
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 14:35:13 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5C99848BA; Wed, 22 Jul 2026 16:35:11 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EF4B8493F
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 16:35:08 +0200 (CEST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66MDWonG755383
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 14:35:07 GMT
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjnu4tmqp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 14:35:06 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-526da7e3c9dso31714881cf.1
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 07:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784730906; x=1785335706;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CruRYsJtNdisq+RMDC+JbwpuC9jvhABCRMjSpx2rX1U=;
 b=Sol5GKRlhSxtitCGh0b3xv3FJ5mD+28779j6F4CET/sSVCJ2n8XlVjFZAJ/xuzfqzB
 vkhvHbsbl2okmKDpBc4YXv/55HB/FMCUNC/TvAZ0Z897KBujd2U6ZmjqUIXcM1+Mzp7W
 pc/yvWS8qedgqawikXakG9BSYuYEjsSNsn8Vgx63iVkoQA47NwiUEXoLBVZjn87S6nlc
 eMmG6SyMeqzPsRURoOsqsixB2ucNrJ7bBlaZUKpXi9l9UuZ+JCPTBkj6zfmtNGhlP3Td
 Ce0MRSqDRltfbCd9Q/qhsLpsys8Efy9Rc5gBTrhnuOWw0g/HpULSeAUWSSS3U+6czb+v
 nI5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLhoGM8LfQAjMTZLGuAqpYtyAfyS433RaR6t+OPErY2RQxF5DoiWG8BiL2DkuS+QwKvgNxpOM=@lists.denx.de
X-Gm-Message-State: AOJu0YzRjMgqhNC4P96KkORsCy85pdN7aQ/lVH5w9c8ocM+01uedbzWH
 3sn4kcB+1VEbCQIGY05/5HHG9zA9zyWXmEPidCfYbFEhVuEwMdC3xd18BBoZq/J3PaTNn079IXE
 bcoLMYBN8CRSl2941qBemRpThG1a3s2RRSLzb65+kbByUqCtp7ZnhJqkK
X-Gm-Gg: AR+sD12zCvAOt4kGkTvcmloOIBNBEdSroXeUSNtJuDBdVdBSl9VAPvPGD7FSmeQbwPn
 +qU4A7GnEAbyDW4Sz+1b90dq6PQ+GlX3px5t48AKY8twrJMKHIJeSNAELL+fukG6cwo45e+aZER
 CFtK1JQ7lX00j3YWuZVz+6zqapAHY6ZtlQVKse/yw9BE68AD8P34kTslzZO16SUCON3LFDNNAiY
 DG1lYOroCbY+jjsXUcDGx3RQbPZ6Z7uu7PPT6rrx2xdZTnamoZ3EY1naB8zjsiBwGOvIgIX/XsQ
 T4rGGBHMNg2oAIHcrRS+eNJxj9Sfu64j4VUgfa9METXQ/RniF4UIFY5VDNDcaDbgjd4SugdzOqD
 B7OObAdxh8rk/UjlU46v2RoL0l0axhNTImhs=
X-Received: by 2002:a05:622a:5ce:b0:51f:636c:8eae with SMTP id
 d75a77b69052e-5213bb21712mr227423121cf.14.1784730905750; 
 Wed, 22 Jul 2026 07:35:05 -0700 (PDT)
X-Received: by 2002:a05:622a:5ce:b0:51f:636c:8eae with SMTP id
 d75a77b69052e-5213bb21712mr227422381cf.14.1784730905297; 
 Wed, 22 Jul 2026 07:35:05 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a4f25b6sm72211365e9.2.2026.07.22.07.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 07:35:04 -0700 (PDT)
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Wed, 22 Jul 2026 16:35:00 +0200
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Jorge Ramirez <jorge.ramirez@oss.qualcomm.com>, trini@konsulko.com,
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
Message-ID: <amDVFDwma9_JZ2cN@trex>
References: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
 <20260722060805.1428110-5-jorge.ramirez@oss.qualcomm.com>
 <f73c5fb0-881a-49bf-a5ff-a0120ab3e3b2@linaro.org>
 <amCRWI7K4Jj_psYp@trex>
 <CALeDE9PV=1-8sgWZn7n3w9A2p6A_TDus1gHyjetaT_oR5uA0Cw@mail.gmail.com>
 <c4846039-2d4d-4436-a4bd-3baf16547319@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4846039-2d4d-4436-a4bd-3baf16547319@linaro.org>
X-Proofpoint-GUID: wci6tAtkFwRFzbDiQpDJ77GliDJIiUqa
X-Authority-Analysis: v=2.4 cv=KLhqylFo c=1 sm=1 tr=0 ts=6a60d51a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=dChbvKt_AAAA:20 a=1VxDqnHFAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=V4fTAr3JbKj1KKgZK5YA:9 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=aZ5uHUMKh6B-zo3GvD48:22 a=cvBusfyB2V15izCimMoJ:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDE0MyBTYWx0ZWRfX2elxD6EzUSdQ
 jv0kmWhaYXfLmfeiEfYHN+MN9XeKc1XamWBcf58+IofPOUQV7eHR3Akf2oKARC76yd5uCyk1ZkX
 IXr8uETb5NpPLd2Q3pp71j+wCMYgJFyL8URd1pxSfnRy4jsorA1r1S0WRCkBcz2DY1gKR1dCaq0
 YhtZftpzUDWT0BFFbwWPm4CiGzMwQvA8eacoJAWWkL6HAThPC8hQoL7WZRqVUK5IlimbnLmQO+z
 9xFcki2mCkUnwCZibvu/VCvBjgl9DqAMPTNDvsX5dJH4ffd2YpFB+EvrSeAVeKa4Ik6NalRtICV
 Nkzp7pKz+Nj9TN7CqU7fKQB0otzVJpRXvTtOY/pbeIFVpYCgbihny0WVnhf/bnryOGrjxSSBZy/
 GBeQhhlfLtKgbqPr3oq/YxIL4Ko+xM48ESEG24d//g8+ppuvGu9Op7kED2G+KlRb48xWtHS5a8Y
 RRMU4IGvMiuGXYitBSA==
X-Proofpoint-ORIG-GUID: wci6tAtkFwRFzbDiQpDJ77GliDJIiUqa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDE0MyBTYWx0ZWRfXwue7QCr4CeT+
 MZLputk1i/82aNoJ4D3dhUPGsePxvri6l0whYY8msai09zSYJCzVJbLCNr3oIBz0AU5lfqHhNNr
 pcel07hlUWGaYsfjghSl7G5e2X9xa24=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_04,2026-07-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220143
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=CruRYsJtNdisq+RMDC+Jbwpu
 C9jvhABCRMjSpx2rX1U=; b=hR9DO6yebi/FMmcpsNl0VgHNbSh+992jcRJNU6GM
 RWrbzYhxxEb//nViGh7Ka9ji9mzZK1V77Vas34TTtEoyH966E0uqmaHFSx+Qz8fD
 X6qD3pzMuxb3rv1HEjN+WNP3QI6haqueFQtGZOUu5LyuyBNM5cLlBOSBOMCciZ/0
 Fq9t1Z0Nx20P0IFcQ537CbByhIgjBI2PXXdFM5itfLYaE5PAubny9vgEjTDMg506
 q4fh9b5bD99x5s7Hv2Vv9aOU3zUet/q39P8bxwXAGsGt1hEdawAQbRSUo5AHyyHA
 sO78x862cAzquRSGIZ2/DUmYvYSACYNJvC/9Novo5kfTYA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784730906; x=1785335706; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CruRYsJtNdisq+RMDC+JbwpuC9jvhABCRMjSpx2rX1U=;
 b=TKU4SuaK0rc3BuJfurPdC63DRGi2lea72Z+DAY1/HLLQ62HDrQipX4mXmHQz1+F3uJ
 LUAssoalCo9JcduPVjNmyaYevyqDdb7NWLD9MZqydWSOUabt7cgmF1QJDjjOBmJApeZy
 97tsi3RTXpqmB1we37ojNvBQsZgSWzkP5iNQNtXWigxqkhuWk2zEdE5/efi8ZbGbJIjh
 TIOqwB9buezUnV3nXTpGSQEEZnf0+MF838ZUgQ6G3pd58O23zvbfLUzlQeHUwDYTMDF5
 4QEjos2khMyXRuJyj0ehjP5D+hfTN3YUyU+jFr/urrvtlM8Rw36vb1hSrm4bVbb+gN7W
 r0ew==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com
 header.a=rsa-sha256 header.s=qcppdkim1 header.b=hR9DO6ye; 
 dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=TKU4SuaK
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hR9DO6ye";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="TKU4SuaK"; 
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

On 22/07/26 15:10:16, Neil Armstrong wrote:
> Hi,
> 
> On 7/22/26 14:33, Peter Robinson wrote:
> > On Wed, 22 Jul 2026 at 10:46, Jorge Ramirez via U-Boot
> > <u-boot@lists.u-boot-project.org> wrote:
> > > 
> > > On 22/07/26 10:27:22, neil.armstrong@linaro.org wrote:
> > > > On 7/22/26 08:07, Jorge Ramirez-Ortiz wrote:
> > > > > This file implements the legacy single-command OPTEE_MSG_RPC_CMD_RPMB
> > > > > supplicant (eMMC only). Rename it to rpmb_legacy.c so the primary rpmb.c
> > > > > name is free for the RPMB subsystem interface added next; pure rename plus
> > > > > its Makefile object, no functional change.
> > > > > 
> > > > > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > > > > ---
> > > > >    drivers/tee/optee/Makefile                  | 2 +-
> > > > >    drivers/tee/optee/{rpmb.c => rpmb_legacy.c} | 0
> > > > >    2 files changed, 1 insertion(+), 1 deletion(-)
> > > > >    rename drivers/tee/optee/{rpmb.c => rpmb_legacy.c} (100%)
> > > > > 
> > > > > diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> > > > > index 36ac085ef42..8321cf53a19 100644
> > > > > --- a/drivers/tee/optee/Makefile
> > > > > +++ b/drivers/tee/optee/Makefile
> > > > > @@ -3,4 +3,4 @@
> > > > >    obj-$(CONFIG_OPTEE) += core.o
> > > > >    obj-y += supplicant.o
> > > > >    obj-$(CONFIG_DM_I2C) += i2c.o
> > > > > -obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb.o
> > > > > +obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_legacy.o
> > > > > diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb_legacy.c
> > > > > similarity index 100%
> > > > > rename from drivers/tee/optee/rpmb.c
> > > > > rename to drivers/tee/optee/rpmb_legacy.c
> > > > 
> > > > Why not rpmb_emmc ?
> > > > 
> > > > Neil
> > > 
> > > right this is what is confusing about the current abstraction; op-tee has two modes:
> > > 
> > >    1. Legacy mode (legacy_operation = true)
> > 
> > Does the spec refer to this as legacy mode? Presumably it's RPMB on
> > eMMC vs RPMB on UFS (or presumably also NVME) or the revisions have
> > actual version numbers. Maybe name it after the interface that
> > supports the revision, or the actual revision of the RPMB spec, as
> > opposed to just legacy. What happens when next version comes along, to
> > we rename legacy to old_legacy so we can have new, legacy and
> > old_legacy?

yeah, Neil addressed this below. I agree with you Peter but sometimes
legacy can be appropiately used (I believed that this to be one of
those binary instances).

> 
> So I did a small dig and both commands are still referenced in OP-TEE
> and the TEE supplicant.
> 
> But indeed the OPTEE_RPC_CMD_RPMB command is only used in the userspace
> TEE supplicant _and_ U-Boot, while Linux uses the other RPMB Frames
> command like this implementation.
> 
> In OPTEE the usage of OPTEE_RPC_CMD_RPMB it's explicited as "legacy" in
> https://github.com/OP-TEE/optee_os/blob/991587c721a603e831cad228626078289adad159/core/tee/tee_rpmb_fs.c#L486
> so we can describe it as "Legacy", even if it's not described as legacy
> on in the OP-TEE headers nor in the TEE supplicant.
> 
> But, I'll stick to my proposal to rename as rpmb_emmc and rpmb_ufs and
> add a comment in the rpmb_emmc explaining it uses the OPTEE_RPC_CMD_RPMB
> and may need to be add support for the FRAMES commands.
> And the other way around add a small comment in the UFS implementation
> explaining it only supports the FRAMES commands.


I'll push back (one last time), my point being that I expect rpmb_legacy
to disappear where as rpmb_mmc or rpmb_ufs will not (and I see no reason
to keep them in separate files): hence the pursue of a single rpmb.c

if after this you still want to separate rpmb_ufs and rpmb_mmc I'll go
ahead (but we will lose that temporary hint to the op-tee dependency)

