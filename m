Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F2BC44529
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 14:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79DE880A4C;
	Tue, 21 Jul 2026 14:55:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id unPT6jaIxApN; Tue, 21 Jul 2026 14:55:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 85CFD80DEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784645716;
	bh=wTB+T41jRSiA6PYi4KeUHdjvIaf6ezV9quZBSr/14So=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=v/0q3QtsAB3IiQB5s1KEcxrIjNXjKaVvzMKhXVF1793K9Bd1V44gG6DsknotFPXV1
	 OyLx+NF/HT483mZMUTdZRO960OjX/BfrHClDTY4DHG8NEKABHhLKnLRfbF8WWQVjXP
	 ToGy0PQGzdqg0KcFYGYy9tvLmKNMjC0vuxS32QYEHpmc3uwpV+9IepzaUmIV6Qhye7
	 R2sGhE6N+Fdv7fNrsbnMHElZrlsyfIgVv/1LFuN7c789RbEGN4Q29/QeCYYvcfYMBh
	 7W1sfPm5Blv/hQAccGehbwVjFhcpb72zru6haBAezFHEsgtjT+f5ZRIdZIrT5YaPJU
	 xqHreuK3eLCnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85CFD80DEE;
	Tue, 21 Jul 2026 14:55:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 983B0224
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:55:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 89CBA40071
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:55:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U42bTKyJic2F for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 14:55:14 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=jorge.ramirez@oss.qualcomm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3ACF840055
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3ACF840055
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3ACF840055
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 14:55:14 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD937846A4; Tue, 21 Jul 2026 16:55:12 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FD78803F6
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 16:55:08 +0200 (CEST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDg0iu1707355
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 14:55:06 GMT
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj9ae8j1t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 14:55:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a8b0a08d2so166347781cf.0
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 07:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784645706; x=1785250506;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wTB+T41jRSiA6PYi4KeUHdjvIaf6ezV9quZBSr/14So=;
 b=gymIM6cMxnO1K3tMIwx7EMPC2vpSIMRgQkb6uEJ/anhIS/wRGv3Las7bSI7x79VBFM
 ++IPL867EQJMBfVyyWB9PUBpI3OZc6f2sic/OCxzAg3s/WHIGdhduZrqEMjm4Nxbeen7
 wJY4geekQXgTUj5MRZjpt4aTQTXBS0poIQUbxNM2by/kseeU+A5qlULLBng7sw6vRc09
 5t6yJJyHBF0X/X+EYaVuoFZNm3DvwP3/UwDgK3tQ3YH+E+MS6k+KjYc38McMcxnUJ03e
 jgi/kdTDXWG8CLHwKeZ5PWp9lC7Zg858UB76s7VO7qc/h+gAjU6sR/tgKbqvhwOsOKdP
 /NWA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrtXhv+owxvNaSt4/1WCwd/bJ7D9l2F/3aUkdDCKXCdcqBIgmo+14T6OgkX6mil1zEbmAKi6A8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2l+DyfAlhgKfoiidPfC0TbR909oFwohTD/zUgfmYW5wq3mh4A
 CdMNO2RV55vEs2fpHtMgMz2tnzq9uvpB0EZuaBrosTCQqrwJbOStkAP9JLMalhhbxxgqz2bg0YZ
 wiSdBYDM0q4M2WCSg4ihTnJQvEv5Ac1z6B63iEHXVQosOfdAu8pazOcM0
X-Gm-Gg: AfdE7cmvFpSU/OjXB/7+OIq9rXTbSvF/ZRgRzJAeSz9vZmT+oam8HHnxwMuIFdsoE8h
 eVRgo7MEoowFzRTQXtgcD9ybFKprvKQvduzYvvjfhgw0xroWlsa4iyUX4s2SmegqT9EKQxTHBsH
 UIyHuu3NiMgeDziVZFl56pc+D/x0P/kw6YyKzwNlTiQyrr4h+oqvfQCv9jdyj2yad3F5KCFDynt
 V1SmD8wS6IlVweOCLUCkt0LzUELVX1HVNhd+MLg9M1Wb/00BB8UWpOfPQodtE79w1QJcpSMQrwI
 FN/bPQnDxYBQAx1p8VYBZ+l7j+dRtVRlfuZr9cL9LmL8BGCVO8XXbw+mF5m9pHF1rAe83WdO6dx
 58AQhoNErTm1LVmviy1K54Rdm6ezjq/gLY6k=
X-Received: by 2002:a05:622a:d0e:b0:527:6d4a:192d with SMTP id
 d75a77b69052e-5276d4a1cfcmr9721541cf.68.1784645705380; 
 Tue, 21 Jul 2026 07:55:05 -0700 (PDT)
X-Received: by 2002:a05:622a:d0e:b0:527:6d4a:192d with SMTP id
 d75a77b69052e-5276d4a1cfcmr9720791cf.68.1784645704737; 
 Tue, 21 Jul 2026 07:55:04 -0700 (PDT)
Received: from trex (182.red-79-144-196.dynamicip.rima-tde.net.
 [79.144.196.182]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63edda9bsm39917498f8f.31.2026.07.21.07.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 07:55:03 -0700 (PDT)
X-Google-Original-From: Jorge Ramirez <JorgeRamirez-Ortiz>
Date: Tue, 21 Jul 2026 16:55:01 +0200
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
Subject: Re: [PATCH v1 7/7] optee: implement the RPMB subsystem interface for
 UFS
Message-ID: <al-IRbDxlRhIlLzu@trex>
References: <20260720085202.537019-1-jorge.ramirez@oss.qualcomm.com>
 <20260720085202.537019-8-jorge.ramirez@oss.qualcomm.com>
 <95756976-4fd7-4f6d-9ea2-865dc2d4608a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95756976-4fd7-4f6d-9ea2-865dc2d4608a@linaro.org>
X-Proofpoint-ORIG-GUID: 9n9x-V-dkf-taFbIIgmUXnFUOEFcDTxL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE1NiBTYWx0ZWRfX3zvzPoRItT7r
 qr/M/CfrqUYwdRNEjHSY1pLtBf14RLvC8D9V1hXz32g5sZl9odbhlEYGAmTfPJ6FjtSq3Ohz4ZU
 LP14mTebfzNhJ2I3xBmJbHOtgaRGZqw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE1NiBTYWx0ZWRfXwxmMGdhGYlmv
 5nGArVyQ/C/A4OVWdUbdAG/lIhIkttsr+n+p+HVBaHceW+Kb7Dfn27ZQS3iqXSAxaslgQwV4Pbo
 c71WRNKJ+MwFs9szTN8KzLz3Es8O9/x3oLfHvP2rqs991i1mih7wEk45mRzAT3W2dXXbLD5Bpa3
 VgJoHuDLrt4TFKJPUfwBwx55LueiCmBlYneqQpOo6tPgLrPFUrZ0Y9fBABv/ENacAvoQRLvpzaV
 oXvjabtRhZLxkExkBEzkc/aVOn9gD2cSisVEtIV/s294IFsrzWvQT7edkDZeYACoTB8pYz7/vZJ
 7hn48TXq8tHEF1x8+hjMAMBy303v5tJfrCr+tBVpUwhDYiJ0cyApXlZW2/IBLguym7CT3Ba5DDu
 Ab2cqgQ5R4m23jmrrtYtIHCg1bf/IYtusf6InqGh6Fo4b4l0hnmhJeqlVDChn9T8bm19TCf+wlG
 eRkz9pMQxXQHUKjVg8w==
X-Proofpoint-GUID: 9n9x-V-dkf-taFbIIgmUXnFUOEFcDTxL
X-Authority-Analysis: v=2.4 cv=Cr6PtH4D c=1 sm=1 tr=0 ts=6a5f884a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=2lELrtOEK2EaG96G7mOeag==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=2CE9OQuB28qvQVSolVcA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210156
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=wTB+T41jRSiA6PYi4KeUHdjv
 Iaf6ezV9quZBSr/14So=; b=M9e3gILNDgxLjlNJJtcIfS6eGcS+YezhA+zo8fM2
 g/jPrrv0X9S4veQMfOBeeNxeszHZDUNfvr4MB0i7a2Z7fv9AC33JgXB0upB1MIBg
 ZcrX0trTI0RvKJsOIdM685H+hCsP5zowU4b+hUBOwW4Rz6WvrFMGMLkqDlVb/iDX
 rVUDK98k87jj/yjNDINFFRNgf9cYdJeuyytWOzSOEBSxmrFu0hZzStrblRx27rHD
 O+nWUJiWYzL9i2Wo4b5ndfATe5+EbU1dgOg0Hy6e9Z5eqqmCv8u1JSe9d7FEZ5A4
 uulhWy+e/uAJVkmNX7/VpfRP44CYyuDr5MsZcB3T1mgXHA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784645706; x=1785250506; darn=lists.denx.de; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:date:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wTB+T41jRSiA6PYi4KeUHdjvIaf6ezV9quZBSr/14So=;
 b=JC8ivf1fF1m78YMbb7IoEJIfUds9ryBzbEClrRxAtwiE7ae/wIox/+9bBbZcB69tkP
 dA1y4BzvgaFApQxWy+hRPhKoVCI28UivtmXPD5GnuZ0UHEfn19r8sAyYzRR8pnUYAHoc
 dcN7gRKlmlJL1lj7Z5e6qvGlsX5w+3k1Awres53ZQ7joJXAAPMB9K2a+dEMoI0dY4fbq
 tiHP1/FlGZG76em0ELycB6UwSM24joM8a+z/Vznmv9xTLmuU6Na0WTNFaQKnEp0ddKnt
 vkGZBiyWGQVizBduz0xnf7wYiozaiofmjezc3cZisxGv4upeSengc/T5nNEtr/+3jm2Y
 HVwg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=M9e3gILN; 
 dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=JC8ivf1f
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=jorge.ramirez@oss.qualcomm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="M9e3gILN";
 dkim=pass (2048-bit key;
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.b="JC8ivf1f"; 
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

On 21/07/26 09:34:45, neil.armstrong@linaro.org wrote:
> On 7/20/26 10:51, Jorge Ramirez-Ortiz wrote:
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
> 
> It's kind of sad eMMC RPMB support is not implemented in the new interface,
> how hard would it be to add the support ?

I dont disagree - it makes the encapsulation more obvious as well - but
I currently dont have the cycles/hardware for it. if you delegate the
prototype to some LLM we are probably talking about a couple of hours
tops - any lesser model will do; then  a day or two of tidying up.

The issue is always verifying in real hardware - ie deciding to write a
key that you will have to remember forever. In my case I burnt the key
in my Qualcomm RB8 which means that I cant use QC's OP-TEE HUK driver
(since the value it reports changes when secure boot is enabled). So on
this hardware, my HUK will always be 0 (easy to remember)

> 
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> > ---
> >   drivers/tee/optee/Makefile               |   1 +
> >   drivers/tee/optee/optee_msg_supplicant.h |   8 ++
> >   drivers/tee/optee/optee_private.h        |  41 ++++++++
> >   drivers/tee/optee/rpmb.c                 | 126 +++++++++++++++++++++++
> >   drivers/tee/optee/supplicant.c           |   9 ++
> >   5 files changed, 185 insertions(+)
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
> > index 00000000000..3b3bd0ac12e
> > --- /dev/null
> > +++ b/drivers/tee/optee/rpmb.c
> > @@ -0,0 +1,126 @@
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
> > +
> > +void optee_suppl_cmd_rpmb_probe_reset(struct udevice *dev,
> > +				      struct optee_msg_arg *arg)
> > +{
> > +	struct optee_private *priv = dev_get_priv(dev);
> > +
> > +	if (arg->num_params != 1 ||
> > +	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT) {
> > +		arg->ret = TEE_ERROR_BAD_PARAMETERS;
> > +		return;
> > +	}
> > +
> > +	priv->rpmb_next_region = 0;
> > +	priv->rpmb_cur_region = 0;
> > +
> > +	arg->params[0].u.value.a = OPTEE_RPC_SHM_TYPE_APPL;
> > +	arg->ret = TEE_SUCCESS;
> > +}
> > +
> > +void optee_suppl_cmd_rpmb_probe_next(struct udevice *dev,
> > +				     struct optee_msg_arg *arg)
> > +{
> > +	struct optee_private *priv = dev_get_priv(dev);
> > +	struct udevice *scsi_dev;
> > +	struct tee_shm *cid_shm;
> > +	u8 size_mult = 0;
> > +	u8 rel_wr = 0;
> > +	void *cid_buf;
> > +	ulong cid_size;
> > +	int ret;
> > +
> > +	if (arg->num_params != 2 ||
> > +	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_VALUE_OUTPUT ||
> > +	    arg->params[1].attr != OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT) {
> > +		arg->ret = TEE_ERROR_BAD_PARAMETERS;
> > +		return;
> > +	}
> > +
> > +	cid_shm = (struct tee_shm *)(ulong)arg->params[1].u.rmem.shm_ref;
> > +	cid_buf = (u8 *)cid_shm->addr + arg->params[1].u.rmem.offs;
> > +	cid_size = arg->params[1].u.rmem.size;
> > +	if (cid_size < UFS_RPMB_CID_SIZE) {
> > +		arg->ret = TEE_ERROR_SHORT_BUFFER;
> > +		return;
> > +	}
> > +
> > +	scsi_dev = ufs_rpmb_get_scsi_dev(UFS_RPMB_CONTROLLER);
> > +	if (!scsi_dev) {
> > +		arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
> > +		return;
> > +	}
> > +
> > +	while (priv->rpmb_next_region < UFS_RPMB_NUM_REGIONS) {
> > +		unsigned int region = priv->rpmb_next_region++;
> > +
> > +		ret = ufs_rpmb_get_region_info(scsi_dev, region, &size_mult,
> > +					       &rel_wr, cid_buf);
> > +		if (ret < 0) {
> > +			arg->ret = TEE_ERROR_GENERIC;
> > +			return;
> > +		}
> > +		if (!ret)
> > +			continue;
> > +
> > +		priv->rpmb_cur_region = region;
> > +		arg->params[0].u.value.a = OPTEE_RPC_RPMB_UFS;
> > +		arg->params[0].u.value.b = size_mult;
> > +		arg->params[0].u.value.c = rel_wr;
> > +		arg->params[1].u.rmem.size = UFS_RPMB_CID_SIZE;
> > +		arg->ret = TEE_SUCCESS;
> > +		return;
> > +	}
> > +
> > +	arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
> > +}
> > +
> > +void optee_suppl_cmd_rpmb_frames(struct udevice *dev,
> > +				 struct optee_msg_arg *arg)
> > +{
> > +	struct optee_private *priv = dev_get_priv(dev);
> > +	struct tee_shm *req_shm;
> > +	struct tee_shm *rsp_shm;
> > +	struct udevice *scsi_dev;
> > +	void *req_buf;
> > +	void *rsp_buf;
> > +	ulong req_size;
> > +	ulong rsp_size;
> > +
> > +	if (arg->num_params != 2 ||
> > +	    arg->params[0].attr != OPTEE_MSG_ATTR_TYPE_RMEM_INPUT ||
> > +	    arg->params[1].attr != OPTEE_MSG_ATTR_TYPE_RMEM_OUTPUT) {
> > +		arg->ret = TEE_ERROR_BAD_PARAMETERS;
> > +		return;
> > +	}
> > +
> > +	scsi_dev = ufs_rpmb_get_scsi_dev(UFS_RPMB_CONTROLLER);
> > +	if (!scsi_dev) {
> > +		arg->ret = TEE_ERROR_ITEM_NOT_FOUND;
> > +		return;
> > +	}
> > +
> > +	req_shm = (struct tee_shm *)(ulong)arg->params[0].u.rmem.shm_ref;
> > +	req_buf = (u8 *)req_shm->addr + arg->params[0].u.rmem.offs;
> > +	req_size = arg->params[0].u.rmem.size;
> > +
> > +	rsp_shm = (struct tee_shm *)(ulong)arg->params[1].u.rmem.shm_ref;
> > +	rsp_buf = (u8 *)rsp_shm->addr + arg->params[1].u.rmem.offs;
> > +	rsp_size = arg->params[1].u.rmem.size;
> > +
> > +	if (ufs_rpmb_route_frames(scsi_dev, priv->rpmb_cur_region, req_buf,
> > +				  req_size, rsp_buf, rsp_size))
> > +		arg->ret = TEE_ERROR_BAD_PARAMETERS;
> > +	else
> > +		arg->ret = TEE_SUCCESS;
> > +}
> > diff --git a/drivers/tee/optee/supplicant.c b/drivers/tee/optee/supplicant.c
> > index 8a426f53ba8..50b780037fb 100644
> > --- a/drivers/tee/optee/supplicant.c
> > +++ b/drivers/tee/optee/supplicant.c
> > @@ -89,6 +89,15 @@ void optee_suppl_cmd(struct udevice *dev, struct tee_shm *shm_arg,
> >   	case OPTEE_MSG_RPC_CMD_RPMB:
> >   		optee_suppl_cmd_rpmb(dev, arg);
> >   		break;
> > +	case OPTEE_MSG_RPC_CMD_RPMB_PROBE_RESET:
> > +		optee_suppl_cmd_rpmb_probe_reset(dev, arg);
> > +		break;
> > +	case OPTEE_MSG_RPC_CMD_RPMB_PROBE_NEXT:
> > +		optee_suppl_cmd_rpmb_probe_next(dev, arg);
> > +		break;
> > +	case OPTEE_MSG_RPC_CMD_RPMB_FRAMES:
> > +		optee_suppl_cmd_rpmb_frames(dev, arg);
> > +		break;
> >   	case OPTEE_MSG_RPC_CMD_I2C_TRANSFER:
> >   		optee_suppl_cmd_i2c_transfer(arg);
> >   		break;
> 
