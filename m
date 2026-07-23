Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296F0C44524
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 08:01:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D32A640798;
	Thu, 23 Jul 2026 08:01:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XMwUfEKG6Lvy; Thu, 23 Jul 2026 08:01:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C21254079A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784793706;
	bh=4DYeeE5O3Xhq8+jgQesZb4GLxhbXPgQTKSxSCvRJg70=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=0x+9caDBRHl2o2aDR3wRznRuO+mBRipGqCr4DS3lmAnAw+qv0Cr+51xeC05z+3c6L
	 aEWqUX6Z4yB9jDNxk8G/B4wif6PIp6PadZ4Y31zsxkAR6+bNh7LvJfooGE4gE58kO8
	 cz04PyAO1KFRZduE8gfWq7A2v/q/AbThRavYrDEmYOmi1NaXgv21uIO25AHrAsYy4X
	 FQc654LiDgpB7NDJ1ohwuLPuq+Ce5IgrOg0FA0yeyElIvFzQ4nGHcQrXkyOdcLKfIZ
	 36ofbcb2lyqoCaeo729Y1k1bFUw34F622ferSPvX5Q+NkyWvMwccR0j6K6nqQ57DlS
	 kMNWt92hbzdWQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C21254079A;
	Thu, 23 Jul 2026 08:01:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0ADFDEB
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:01:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E523640798
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:01:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 23AxLTXnsK6P for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 08:01:44 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=jorge.ramirez@oss.qualcomm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 711E740792
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 711E740792
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 711E740792
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:01:43 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 665E88404D; Thu, 23 Jul 2026 10:01:41 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77670803F6
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 10:01:38 +0200 (CEST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N7japt2892887
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 08:01:36 GMT
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkeuq81rx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 08:01:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e56b2b350so99028385a.3
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 01:01:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784793695; x=1785398495;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:date
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4DYeeE5O3Xhq8+jgQesZb4GLxhbXPgQTKSxSCvRJg70=;
 b=iiusvgjPkWnMvDVy7Jj9NDE/a6A1OsYX8HisIlFdfRWMAugR2xQiXUChq6QA2WT8sG
 INNFsn1CVh1QaC1K4KXxWhky7qUzwuurxB8ZwBzLKwiAfqbVc3LU8UF25sP1DOycaIUP
 o++g6N5W8tvbLHTnAMZPddzdSLl1ifqwyfwGqVaYLKMp7BWP9b9rTVu3ozGdQ2TH3jTs
 XSveZ+3eypNV/SUbpNZ7k3w88cPTTO4SNOqAnvz0QSZLNMHqkcuzGi3JpLaksB6qeYT/
 6jqE3j5jL7Sb/hkJENWpqdLfuApiV/TyhufiT1fs3G5V/Ic78gxuL521MVTeYst6TCIF
 Sg2g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpGiXZWNiG1Ri4WESF5zXe9vFIknk84rXvjcWDWmDZ4a3fYsSKlEDkDpAbWMUBlfrji4bT19Zg=@lists.denx.de
X-Gm-Message-State: AOJu0Yynuj+gYds4trI05kQcOJj+1sYvcYIqxfgbKG99YxC1peXzcCfw
 DOuEmP64XS+qHPE9T51FwYC4ADzO4oUKQgA3bgY8cTloFhE+3oJ9sUmr2eVsiC4kSOfnnG1Brth
 5zCl8Z2erdXJMzjFlOZoXJI7Zptz2qMaK0AzAiWiJNM7afe82ta8bX+aF
X-Gm-Gg: AR+sD10CciDqcK113s5WDh2ibIcRVyWXZrCOoFlilN5PRU6qkv2gN6WP+rO/gA7f8oP
 /Gnl0UX3Bncm0hKUaOijnGLGzMURLy2Q4HcQrQdQr588wjRuF3fgEX1cb42r6cNDlR6SVDoiqwY
 t2TdaMVjjDt66zSwi+oplkvh+PoMQ+ZVbpm2mif23dlXds8PAhPH5Npryhu3aFDtWNfAVzPnse6
 M8n15IOi/JXzBsMLlYLbl+Q7s/6eYsLUcwGYlvVkTlJwFibuptTTrACGR9J76TX8HdpQUTf2E5d
 /NDHIm1kC1FfIZp5QIt+yx9SLDTx1Dk34eyqzKibAQqAm8mtn5p6nu69LHkHXNWP4rMWqUr/DLa
 Vd5nJ8HDe3bwHODeWwyq0+spwnBbH40QfDhw=
X-Received: by 2002:a05:622a:260d:b0:51c:103:fb56 with SMTP id
 d75a77b69052e-5283dda3923mr18516351cf.15.1784793694990; 
 Thu, 23 Jul 2026 01:01:34 -0700 (PDT)
X-Received: by 2002:a05:622a:260d:b0:51c:103:fb56 with SMTP id
 d75a77b69052e-5283dda3923mr18515871cf.15.1784793694378; 
 Thu, 23 Jul 2026 01:01:34 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a6354a3sm204833315e9.10.2026.07.23.01.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 01:01:33 -0700 (PDT)
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Thu, 23 Jul 2026 10:01:31 +0200
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
Message-ID: <amHKWx4oPDfk4Ium@trex>
References: <20260722060805.1428110-1-jorge.ramirez@oss.qualcomm.com>
 <20260722060805.1428110-6-jorge.ramirez@oss.qualcomm.com>
 <791913b4-d006-44be-8c94-871617418dbc@linaro.org>
 <amDP5roFBAAdOcYK@trex>
 <6f5137f9-d358-4c51-ac2c-f667cf126d80@linaro.org>
 <amEIA0pSVEehZJYt@trex> <amEPgwafY1zm1LwF@trex>
 <4fd9db1d-0194-4f6b-8472-43fffed26371@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fd9db1d-0194-4f6b-8472-43fffed26371@linaro.org>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA4MCBTYWx0ZWRfX8G08V/FbGgb0
 BthM0miGOVuyFFh8yi4ycrKcAAyRCf8zYawO5ov9nx3lLYRbYpL2ksDOzr6sRmOeCEjod/Q4IOf
 Mk2uXMMGDxXUxJt9YWLTkdBka45BW3o=
X-Proofpoint-ORIG-GUID: A6NiqCI8_rXK0qHD2cHWxAqnV0vSln66
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA4MCBTYWx0ZWRfX0gcmefIPNOw+
 f/eK7JzjHX9K8CpqLRXseHr+9/rnEgT55hL+EcHipgJPNN2EtoTx9Pe1LRUeb5FZUnmayWnvSP3
 Ux9tWC85WFq/VXoPM1gxnyKKVdarNhZtcmnZxaS10pp+Q9HTXHZLQ9OJkLzm888EP/IFxs84KG9
 iIZ8E64Vg3B7l2CpC5W6frvrEVwmW9mna/JgzGm2t2jr5pZWEoJnAtZvDqxyJuig/3w6sLT2r4x
 q9KgFrtZQSJ+MTMFeb2gsaRWD9pjPn5tN1GRxXIvctoTtasC0qkgEjdP5eBTVtcQxlNfbnRaBqY
 isRYyVvbghtgaYtwCbbZeDvHg7W9ZQfOHF7kD4psfr8vIek047LLA4+VvSQx1YCy38q97dMEFOs
 3zoTKNbMpTww2mGF2AK7Pa6wtQr00ByueTIkpWsFSVO9kl+EUBtEqstLq0xmm0pfQBUsbPzvmEs
 6CEL5G675RcEa9PzvhA==
X-Authority-Analysis: v=2.4 cv=cPDQdFeN c=1 sm=1 tr=0 ts=6a61ca60 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=om8NvcP2hf6eV6SKCL8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: A6NiqCI8_rXK0qHD2cHWxAqnV0vSln66
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230080
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4DYeeE5O3Xhq8+jgQesZb4GLxhbXPgQTKSxSCvRJg70=; b=gy8MhilBMFHl7v8u
 XrqITT3H5yP4edJ2CULgGXjqTxxRK1GhmYBJ7RQncQHnpTTLtH+iXUVNYrhSGKC+
 ULrcWyoEOcHU7mH1S8KgD7uD+MhTp57vbx96pvK39iCUcf+rG7/DveJVXqV601W0
 brSAUF3IpOyojG+Rbzp13byXKupDUhuyUG8dfTd5w3fzzpaTnFLZ9YbBTVgq8FJN
 oZKHG7cqrrdPypKz5GvQAjF3/axQTiT1M+KH1MOQH/d0j2y8DG68/Gi27xjV87Gz
 aI5TErwQShKyZVQ3jqPT31mncXSIFgTsiXdQxz/ZtIMBYP2+E8ktBxpCXU/xAsvV
 V1Zlug==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784793695; x=1785398495; darn=lists.denx.de; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:date
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4DYeeE5O3Xhq8+jgQesZb4GLxhbXPgQTKSxSCvRJg70=;
 b=DKpmEOMea3eumTYANScSEvxiF8AMVImImNtY7At1m3TAghZRvNu8MtgXIQ9OvGHVQC
 CndvqW0DqCfrT51HrVwC1WQuZ8IIf0L+IRIjPGnUaDiY8FFZhj9eleyTA3iNOst8gaZK
 nzxTAgpTeWNdMjladLCGmtmX9YBCA807fvg1zWmoa/TW4FeZ8IP1suZl085Z0d0J/z8I
 C9Y4c7CqRPIS628Y8Qd4khYIuZms0k7XAC6w8javyr668IeFrwJTE6THP7kyINZkGQ/k
 J9qPNvnWIZFqzDbgw38/4quudw15m8Y8KIXQtLh8U6VWTnQ1axPeT2S60bCRu3pFnaV6
 HEOA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=gy8MhilB; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=DKpmEOMe
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gy8MhilB";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="DKpmEOMe"; 
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

On 23/07/26 09:33:39, Neil Armstrong wrote:
> On 7/22/26 20:44, Jorge Ramirez wrote:
> > On 22/07/26 20:12:19, Jorge Ramirez wrote:
> > > On 22/07/26 17:43:16, Neil Armstrong wrote:
> > > > On 7/22/26 16:12, Jorge Ramirez wrote:
> > > > > On 22/07/26 10:31:04, neil.armstrong@linaro.org wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > On 7/22/26 08:07, Jorge Ramirez-Ortiz wrote:
> > > > > > > OP-TEE's legacy RPMB supplicant interface assumes the RPMB device is eMMC
> > > > > > > and derives the key from an eMMC-shaped device ID, so it can never
> > > > > > > reproduce the key Linux derives for a UFS device; secure storage on
> > > > > > > UFS-only platforms instead needs the transport-agnostic RPMB subsystem
> > > > > > > interface, through which the normal world describes the real RPMB device
> > > > > > > to OP-TEE. Add a UFS backend for it so OP-TEE derives a key matching Linux
> > > > > > > and can use RPMB secure storage on UFS, leaving the legacy eMMC path
> > > > > > > untouched.
> > > > > > > 
> > > > > > > This subsystem backend currently supports UFS drives only; eMMC still uses
> > > > > > > the legacy interface. As the legacy interface is dropped in favour of the
> > > > > > > subsystem one, an eMMC backend should be added here so both transports are
> > > > > > > served through a single RPMB path.
> > > > > > > 
> > > > > > > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > > > > > > ---
> > > > > > >     drivers/tee/optee/Makefile               |   1 +
> > > > > > >     drivers/tee/optee/optee_msg_supplicant.h |   8 ++
> > > > > > >     drivers/tee/optee/optee_private.h        |  41 ++++++++
> > > > > > >     drivers/tee/optee/rpmb.c                 | 124 +++++++++++++++++++++++
> > > > > > 
> > > > > > Why not rpmb_ufs ?
> > > > > 
> > > > > 
> > > > > because in the future (and IMO) rpmb.c should support UFS and EMMC using
> > > > > the new probe interface (eventually removing rpmb_legacy).
> > > > 
> > > > Let's see in the future, if somehow there's need for a common "new"
> > > > and emmc only legacy some rework will be needed anyway. The eMMC RPMB
> > > > hasn't been updated for a very long time...
> > > > 
> > > > Using the driver model to register an rpmb device attached to an eMMC
> > > > or UFS controller would the cleanest way to handle that, but we're not here now.
> > > > 
> > > > > 
> > > > > > 
> > > > > > It's fine to have 2 backend implementations, the emmc is implementing the
> > > > > > legacy optee API, just add a comment in the eMMC file about that.
> > > > > > 
> > > > > > Neil
> > > > > > 
> > > > > > >     drivers/tee/optee/supplicant.c           |   9 ++
> > > > > > >     5 files changed, 183 insertions(+)
> > > > > > >     create mode 100644 drivers/tee/optee/rpmb.c
> > > > > > > 
> > > > > > > diff --git a/drivers/tee/optee/Makefile b/drivers/tee/optee/Makefile
> > > > > > > index 8321cf53a19..7af19834c00 100644
> > > > > > > --- a/drivers/tee/optee/Makefile
> > > > > > > +++ b/drivers/tee/optee/Makefile
> > > > > > > @@ -4,3 +4,4 @@ obj-$(CONFIG_OPTEE) += core.o
> > > > > > >     obj-y += supplicant.o
> > > > > > >     obj-$(CONFIG_DM_I2C) += i2c.o
> > > > > > >     obj-$(CONFIG_SUPPORT_EMMC_RPMB) += rpmb_legacy.o
> > > > > > > +obj-$(CONFIG_SUPPORT_UFS_RPMB) += rpmb.o
> > > > > > > diff --git a/drivers/tee/optee/optee_msg_supplicant.h b/drivers/tee/optee/optee_msg_supplicant.h
> > > > > > > index 963cfd47824..b720d5d7b3f 100644
> > > > > > > --- a/drivers/tee/optee/optee_msg_supplicant.h
> > > > > > > +++ b/drivers/tee/optee/optee_msg_supplicant.h
> > > > > > > @@ -152,6 +152,14 @@
> > > > > > >      */
> > > > > > >     #define OPTEE_MSG_RPC_CMD_I2C_TRANSFER 21
> > > > > > > +#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_RESET	22
> > > > > > > +#define OPTEE_MSG_RPC_CMD_RPMB_PROBE_NEXT	23
> > > > > > > +#define OPTEE_MSG_RPC_CMD_RPMB_FRAMES		24
> > > > > > > +
> > > > > > > +#define OPTEE_RPC_SHM_TYPE_APPL		0
> > > > > > > +
> > > > > > > +#define OPTEE_RPC_RPMB_UFS		1
> > > > > > > +
> > > > > > >     /*
> > > > > > >      * Was OPTEE_MSG_RPC_CMD_SQL_FS, which isn't supported any longer
> > > > > > >      */
> > > > > > > diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> > > > > > > index 1f07a27ee4b..2888257aefe 100644
> > > > > > > --- a/drivers/tee/optee/optee_private.h
> > > > > > > +++ b/drivers/tee/optee/optee_private.h
> > > > > > > @@ -9,6 +9,17 @@
> > > > > > >     #include <tee.h>
> > > > > > >     #include <log.h>
> > > > > > > +#ifdef CONFIG_SUPPORT_UFS_RPMB
> > > > > > > +/**
> > > > > > > + * struct optee_private - OP-TEE driver private data
> > > > > > > + * @rpmb_next_region:	next UFS RPMB region to report on PROBE_NEXT
> > > > > > > + * @rpmb_cur_region:	UFS RPMB region selected by the last PROBE_NEXT
> > > > > > > + */
> > > > > > > +struct optee_private {
> > > > > > > +	unsigned int rpmb_next_region;
> > > > > > > +	unsigned int rpmb_cur_region;
> > > > > > > +};
> > > > > > > +#else
> > > > > > >     /**
> > > > > > >      * struct optee_private - OP-TEE driver private data
> > > > > > >      * @rpmb_mmc:		mmc device for the RPMB partition
> > > > > > > @@ -22,6 +33,7 @@ struct optee_private {
> > > > > > >     	int rpmb_dev_id;
> > > > > > >     	int rpmb_original_part;
> > > > > > >     };
> > > > > > > +#endif
> > > > > > >     struct optee_msg_arg;
> > > > > > > @@ -60,6 +72,35 @@ static inline void optee_suppl_rpmb_release(struct udevice *dev)
> > > > > > >     }
> > > > > > >     #endif
> > > > > > > +#ifdef CONFIG_SUPPORT_UFS_RPMB
> > > > > > > +void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
> > > > > > > +				      struct optee_msg_arg *arg);
> > > > > > > +
> > > > > > > +void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
> > > > > > > +				     struct optee_msg_arg *arg);
> > > > > > > +
> > > > > > > +void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
> > > > > > > +				 struct optee_msg_arg *arg);
> > > > > > > +#else
> > > > > > > +static inline void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
> > > > > > > +						    struct optee_msg_arg *arg)
> > > > > > > +{
> > > > > > > +	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static inline void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
> > > > > > > +						   struct optee_msg_arg *arg)
> > > > > > > +{
> > > > > > > +	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static inline void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
> > > > > > > +					       struct optee_msg_arg *arg)
> > > > > > > +{
> > > > > > > +	arg->ret = TEE_ERROR_NOT_IMPLEMENTED;
> > > > > > > +}
> > > > > > > +#endif
> > > > > > > +
> > > > > > >     #ifdef CONFIG_DM_I2C
> > > > > > >     /**
> > > > > > >      * optee_suppl_cmd_i2c_transfer() - route I2C requests to an I2C chip
> > > > > > > diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
> > > > > > > new file mode 100644
> > > > > > > index 00000000000..9c3e0f031ad
> > > > > > > --- /dev/null
> > > > > > > +++ b/drivers/tee/optee/rpmb.c
> > > > > > > @@ -0,0 +1,124 @@
> > > > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > > > +
> > > > > > > +#include <dm.h>
> > > > > > > +#include <tee.h>
> > > > > > > +#include <ufs.h>
> > > > > > > +
> > > > > > > +#include "optee_msg.h"
> > > > > > > +#include "optee_msg_supplicant.h"
> > > > > > > +#include "optee_private.h"
> > > > > > > +
> > > > > > > +#define UFS_RPMB_CONTROLLER	0
> > > > > > 
> > > > > > Can this be a config option instead which defaults to 0 ?
> > > > > 
> > > > > um, I dont think so - this assumes there is only one controller. If there
> > > > > are more than one, we would need a mechanism to select which one from
> > > > > the enumerated values (maybe a DT alias (ie ufs-rpmb ?) I think the binding order
> > > > > changes as we enable/disable devices)
> > > > 
> > > > It could collide with other SCSI devices like SATA devices over PCIe.
> > > > 
> > > > Usually we try not to hardcode the devices ids.
> > > 
> > > 
> > > right...shall I go ahead with a DT alias approach?
> > 
> > 
> > something like this?
> > 
> > 
> >    8 ⋮  8 │ #include "optee_msg_supplicant.h"
> >    9 ⋮  9 │ #include "optee_private.h"
> >   10 ⋮ 10 │
> >   11 ⋮    │-#define UFS_RPMB_CONTROLLER        0
> >      ⋮ 11 │+static int optee_rpmb_get_scsi_dev(struct udevice **scsi_devp)
> >      ⋮ 12 │+{
> >      ⋮ 13 │+        struct udevice *ufs_dev, *scsi_dev;
> >      ⋮ 14 │+        ofnode node;
> >      ⋮ 15 │+        int ret;
> >      ⋮ 16 │+
> >      ⋮ 17 │+        node = ofnode_get_aliases_node("ufs-rpmb");
> >      ⋮ 18 │+        if (ofnode_valid(node))
> >      ⋮ 19 │+                ret = uclass_get_device_by_ofnode(UCLASS_UFS, node, &ufs_dev);
> >      ⋮ 20 │+        else
> >      ⋮ 21 │+                ret = uclass_get_device(UCLASS_UFS, 0, &ufs_dev);
> >      ⋮ 22 │+        if (ret)
> >      ⋮ 23 │+                return ret;
> >      ⋮ 24 │+
> >      ⋮ 25 │+        ret = device_get_child(ufs_dev, 0, &scsi_dev);
> >      ⋮ 26 │+        if (ret)
> >      ⋮ 27 │+                return ret;
> >      ⋮ 28 │+
> >      ⋮ 29 │+        *scsi_devp = scsi_dev;
> >      ⋮ 30 │+
> >      ⋮ 31 │+        return 0;
> >      ⋮ 32 │+}
> >   12 ⋮ 33 │
> >   13 ⋮ 34 │ void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
> >   14 ⋮ 35 │                                       struct optee_msg_arg *arg)
> > 
> > ────────────────────────────────────────────────────────────────┐
> > • 76: void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev, │
> > ────────────────────────────────────────────────────────────────┘
> >   55 ⋮ 76 │                 return;
> >   56 ⋮ 77 │         }
> >   57 ⋮ 78 │
> >   58 ⋮    │-        if (uclass_get_device(UCLASS_SCSI, UFS_RPMB_CONTROLLER, &scsi_dev)) {
> >      ⋮ 79 │+        if (optee_rpmb_get_scsi_dev(&scsi_dev)) {
> >   59 ⋮ 80 │                 arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
> >   60 ⋮ 81 │                 return;
> >   61 ⋮ 82 │         }
> > 
> > ─────────────────────────────────────────────────────────────┐
> > • 124: void optee_suppl_cmd_rpmb_frames(struct udevice *dev, │
> > ─────────────────────────────────────────────────────────────┘
> >   103⋮ 124│                 return;
> >   104⋮ 125│         }
> >   105⋮ 126│
> >   106⋮    │-        if (uclass_get_device(UCLASS_SCSI, UFS_RPMB_CONTROLLER, &scsi_dev)) {
> >      ⋮ 127│+        if (optee_rpmb_get_scsi_dev(&scsi_dev)) {
> >   107⋮ 128│                 arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
> >   108⋮ 129│                 return;
> >   109⋮ 130│         }
> > 
> 
> No I was just thinking as a Kconfig option along CONFIG_SUPPORT_UFS_RPMB but
> I just didn't find where you added the CONFIG_SUPPORT_UFS_RPMB option...
> 
> Neil

well ok, sure I can do the Kconfig change.

I havent enabled RPMB just yet in configs/qcom_lemans_defconfig until
the OP-TEE support is merged.

This is what I have on my development branch:

# Route OP-TEE RPMB secure storage over the UFS RPMB (no eMMC on this SoC).                                        
CONFIG_SUPPORT_UFS_RPMB=y
