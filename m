Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CEE606A324
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=puOBCq9B;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=c3BbndWF
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2E44F6076F;
	Mon,  2 Nov 2026 10:20:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TDuu4Oc4xJXk; Mon,  2 Nov 2026 10:20:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4987A60758
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793614818;
	b=mWwO7okCfyaDecBGJ7zcPB//V2eoEzeZ/zN2owZFXwhgxx4gUTHuVXzZYmNSmoXbY+Sq
	 d8U3gpiVQPjbJitMTtSxyWddY8vlZ8UFSGB/l0bSI+uFzzU6jAPfLGLcF4BE3JQPeGfR0
	 XGa0NcpRcb+aTtVF3jDcVOS/e2yXVwLr0ph9F2A3ALfsAmDxU4krLyn9QLnCADIhZg8Cy
	 PTASD1uPNPEQ+spLz8oGaXXiaPW4RxASXMEuAjGMIE1JujwX/MqAcJYMO0c6MBVnn55w7
	 69XNhcGC/1EWCja8O9a+AOoQ/4GVfbMh0ArQ8ZSTsW/EEeqGx+mDU8xGUafdxQv7k0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793614818;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:Mail-Followup-To:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kZ7kWUXMY9ApKlmuc9ermE3D/WkEby0GcQL/ifvEpZY=;
	b=ZURZflYoSSbRl37gSCBZ7xnTHw4wRadmafe/im1houVgST13mCurcdXaZF7cB1eyEkgP
	 v2gjCltv9wEbpZ9JlfDypbgC927IDf9yICOFJMYOOgIMV7s5rE+GACGhnteZTqSbCXY1+
	 czjdKYb1TybdTj3LpmPFvTjByXhzZaRuZnrDBpeVfkJbOnZGFwL63CXXNdzEWmgBiTFUf
	 fmudIXFg0tSpkUa4SOu/M29QiWDlKiOeDZWRtNz/yPpp/axPRT+Dx7XOM+5E6QJEbVIYu
	 yho0E2urpmC0boGkNwFsfeCDC2uVyhCgwYJVV9BpQ4ic2hgE/sD3mCeB7aLPR8NhIMA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793614818;
	bh=kZ7kWUXMY9ApKlmuc9ermE3D/WkEby0GcQL/ifvEpZY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=puOBCq9BBRtw/RqKEy9UzrpekgpTJsRyXgEz5ikSYPqcVyGEMeWXxwSycxDzPnBpx
	 XfW5VA1D1KEWNDHwiamKBQDPTH1JSvAP90rmvAv/hOjFm0Z8BYZ+6SjMIgtLuKfrzC
	 1enoRzCqW2dmeOT5kRDCf7zpD+Q8RQIruOiC/29cOoGdH2BtL6PjsUSfL5y1nJ3p37
	 BmTAe3mRxnOyEra3kl+170oPUt+/Eb2+NC2bH/acE9FIbJSfONnMN5p2ujod0bnC2V
	 OePiuamqW+CvojFavXLXhQupfOUijqyNPPuwa/Ymx3G6zP+FRV/dAb/8ZlWMdCU4pL
	 L9bAQsUa6MKdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4987A60758;
	Mon,  2 Nov 2026 10:20:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D9AFBD3A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 10:20:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB03940719
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 10:20:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AHlpfHUKabA8 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 10:20:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7E0D44070C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=67.231.156.173
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793614817;
 b=Yjn6GU4d/ArqgOrq5h11xbcvrDhIX7QqH3VCMPNsZHmcM5jfFShdbPjoXEKyVnFSYmqU
 mcbUzdnEIDvExbqPLk5WIMLWtOGgzjhyLnrtminVbE+iqXYcpWJW1k4pJ2kF58LQA7N6t
 bH6GglajGoK/ibnUcNdkBwe/RKIvyvy3max6mma2msoaYf3PAtMCdfH0EFWCGodaGR3AA
 7JSl7NTf7aLy7Nuk7zEj34QOP1A9h7XKCQqIT5QuJbYPL+3w4Z0SnjpHxahHZoDeWQk8W
 twqhWUpqkjKW1JCu79LnQbrZKa6RrF05wqaaG9nKNs9MXSDwWGwMx3gRoe122tvHBsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793614817;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:Received:
 Received:Date:From:To:CC:Subject:Message-ID:Mail-Followup-To:
 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version;
 bh=kZ7kWUXMY9ApKlmuc9ermE3D/WkEby0GcQL/ifvEpZY=;
 b=Ag69cBDGQoXga7FHAd+JfECkEIt1+cRrKAhSgevz1q5q4VeRfAqNLRRLgNlhdtY2SMoi
 izcuByviqCKFtCpv8ihAl6NRYwpciM1HcN9oaqFq/Ian3oifwoBqaJ/ODqJdMHzKhLNjD
 x6N2W2cGDBodzR0uM8hHEg1bTMOHgd0+hgnOMK1CYB40PHSYmKJxUtxit2+Xrpq55R1v7
 9hV3Mx1z7wQkIkNnD46R3qjN/TZf+EoLZpHz3MgLjA/294i2aZoVh1Il6KyFKlzCTrJb2
 b+MvVDChlNKa+tvMGXaMq19XU7k13Uh8mfmH/SgsBWVdqd505lR1sLaoiz+m4LPYgUQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=marvell.com;
 dkim=pass header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256
 header.s=pfpt0220 header.b=c3BbndWF; 
 arc=none smtp.remote-ip=67.231.156.173
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=67.231.156.173;
 helo=mx0b-0016f401.pphosted.com;
 envelope-from=prvs=2766062cf2=akashn@marvell.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=marvell.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256
 header.s=pfpt0220 header.b=c3BbndWF
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7E0D44070C
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 10:20:15 +0000 (UTC)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29FW931501429; Mon, 2 Nov 2026 02:20:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pfpt0220; bh=kZ7kWUXMY9ApKlmuc9ermE3D/
 WkEby0GcQL/ifvEpZY=; b=c3BbndWFszDk2K5qC3sUZT2anzVp6w9MtvE80gM1W
 rBu9O1Q+D9croR1TBX6vnvDlsnNr8Lm6Ml+eiwaioN0FHMZhKpou+C+h/9qKaorF
 6bFJCJ3CtGki8tA32cqmjRuT8yOlJsxSjH833442c0pMp15mqsdEm1tJSz8FK8xa
 i3soSZ4dh73fOs3BD4FzAOvtN8VCgIyRYmDLpxVEQ8TmjynVXWRGO2N6YdcLdYDC
 T79UsRjWvnRPyKnEybIH88GfwigtrPmF3C6OQQVEH8QGu/xFxBxC1k7FDthjIGx/
 UydosFXj3MHQyFWjH6iCjPdBHp4cipL3LNmHvJoeQc8jQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hpmqegrwn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 02:20:10 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Nov 2026 02:20:09 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 2 Nov 2026 02:20:09 -0800
Received: from hyd1-dt91330 (unknown [10.29.36.146])
 by maili.marvell.com (Postfix) with SMTP id B3EC33F7040;
 Mon,  2 Nov 2026 02:20:06 -0800 (PST)
Date: Mon, 2 Nov 2026 10:20:05 +0000
From: Akash Nair <akashn@marvell.com>
To: Peter Robinson <pbrobinson@gmail.com>, <trini@konsulko.com>
CC: <u-boot@lists.u-boot-project.org>, <jerome.forissier@arm.com>,
 <rkannoth@marvell.com>, <naveenm@marvell.com>,
 <marek.vasut@mailbox.org>, <alice.guo@oss.nxp.com>
Subject: Re: [PATCH RFC 0/2] net: pcs: Add generic PCS interface and Synopsys
 DW XPCS driver
Message-ID: <lzwsvngwxn3zlb734f7bwegmvzcutnqovzmshjbisp4kledgxp@skaln3tgaucn>
Mail-Followup-To: Peter Robinson <pbrobinson@gmail.com>, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org, jerome.forissier@arm.com, 
 rkannoth@marvell.com, naveenm@marvell.com, marek.vasut@mailbox.org, 
 alice.guo@oss.nxp.com
References: <20261028100259.2491887-1-akashn@marvell.com>
 <CALeDE9MH_tPQi+vHBis3jQVAUuCQLRU7a_GXPt_gOzYz1Y7k=A@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CALeDE9MH_tPQi+vHBis3jQVAUuCQLRU7a_GXPt_gOzYz1Y7k=A@mail.gmail.com>
X-Proofpoint-GUID: 4On-oLmvt5E7yLTryZG43R0RdsBucsg0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX6kph5Z9S8PiJ
 YNbx05Tj7IYUvj/Hh60RRzDuDRkonLTpxkfXW0Xycd2qMqQZXw5l4SXaaL/Asl0tT8KhdaIiehb
 wPEVsHO3slbYNvwJr4Co38FsZvJ7Wax9E3dF8DQK+TK6eEu45FV9Hi27g1lG0AhsqVhf0V+Qfdm
 +S0o7LjZHp24rYyvFah9Vp8PRYKSgg6NR3zWetQrY/2jyJ1dF9VegPZewsPDe3qOMLPcIGZUelI
 WLp/aGGIHWCBeZwe0vb8Wnph+maiR1K8hnfWc9wrvz/suAOOcZNOdXaFdu5EiYnSWwANyADc70X
 qgYd2CEKH/sZSGzl1U9kRyuhjJHoLHseYjMSPDVpwWToDkAGoCjoaK2cnpjGSyVci69PcKH9als
 j1nORFaI//5ILqzgQwhbvltd5IKidWE6MejHaL8/tQdJrdZwjcjSYBmdlubSv/vMLfnkGLEkKDd
 WEQ0Ho9kSnagEIxql/w==
X-Proofpoint-ORIG-GUID: 4On-oLmvt5E7yLTryZG43R0RdsBucsg0
X-Authority-Analysis: v=2.4 cv=IewSymqa c=1 sm=1 tr=0 ts=6ae863da cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=l0iWHRpgs5sLHlkKQ1IR:22 a=QXcCYyLzdtTjyudCfB6f:22 a=pGLkceISAAAA:8
 a=DoHy0CeRISRvG1poRpcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX16SvviQ14sVm
 drYAM236Zy9OtRRYtMiCzdK1iPjN6bkDLnnxsmiO5NhNJ3Da+o6ek5Rjo9E91FloaWkHg571E+m
 jWxYLG8acZ9j2ZF6iPbof4S2nk8ytjs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-29 at 09:25:23, Peter Robinson (pbrobinson@gmail.com) wrote:

Hi Peter, Tom,

Thanks for the review, and sorry for the late reply.

> I would typically expect a driver, even if explicitly labelled not
> ready for merge, to enable people to see how this would work.

Agreed. I will post the MAC driver as a separate RFC series and link
it from the v2 cover letter, so the interface can be reviewed together
with its user.

> Do you happen to know if there's other drivers in U-Boot currently
> that are poking the PCS interfaces directly? Not asking you to convert
> them, more just wondering if it's been hacked up elsewhere.

Yes, more than just Airoha. I went through the tree. The same
Synopsys XPCS is already driven by hand in four places:

  drivers/net/fsl_enetc_xpcs_phy.c   NXP ENETC / i.MX94, over MDIO
  drivers/net/dwc_eth_qos_intel.c    Intel mGBE, over MDIO
  drivers/net/sja1105.c              NXP SJA1105/SJA1110, over SPI
  drivers/net/designware.c           NPCM8xx only, MMIO with a
                                     hardcoded base and the same
                                     indirect page register scheme

> Is the DW driver based on the proposed Linux driver for this? [1]

No, it is not based on that series.
The register names and sequences
for the Clause 73 auto-negotiation and 10GBASE-R programming come from
mainline drivers/net/pcs/pcs-xpcs*.c, and I will add the Linux
copyright and SPDX lines to the file header in v2.

> Can you explain why you chose to depend on UCLASS_MISC for the
> functionality other than scope? I think I would sooner see a
> UCLASS_PCS now rather than a lot of driver duplicated work that will
> need to be fixed later. Maybe work with the Airoha maintainer to
> convert that driver as an example, the Airoha support is quite new.

I agree that a dedicated UCLASS_PCS is the better design, and I am
planning to add one in v2.

> > Questions for reviewers
> > -----------------------
> >  1. Is UCLASS_MISC with the ops in include/pcs.h acceptable as a
> >     starting point?

> I would sooner we go straight to UCLASS_PCS, it might be a bit more
> work now, but will be less maintenance overall.

Agreed. Will work on this.

> >  2. Are struct pcs_config and struct pcs_state enough for other PCS
> >     drivers, or is something missing?

> I would like to see what other drivers poke the PCS stuff in tree as I
> doubt this is just Airoha.

Besides Airoha, I found these drivers that program PCS :
- drivers/net/fsl_enetc_xpcs_phy.c
- drivers/net/mtk_eth/...

> >  3. Auto-negotiation completion is polled from get_state() and the
> >     interrupt is not used. Is that fine for U-Boot?

> I suspect it's probably fine, does get state use the event loop interface?

No. pcs_get_state() does not block and does not use the event,
cyclic or schedule() interfaces. It reads the status registers once
and returns. The caller decides how often to call it, normally from
the MAC driver's link wait loop. The only bounded waits are in
probe and set_config() (reset and power-up, 100 ms timeouts).

> > Testing
> > -------
> > Not tested on hardware yet.
> > Build tested with CONFIG_PCS_XPCS=y on qemu_arm64.
> > checkpatch.pl --strict reports no errors.

> I would like to see actual tests as part of the patch series.
Agreed.

> > Not done

> Are you intending to do this list below? It's not clear.

> > --------
> >  - Interface modes other than the three above. More modes are planned
> >    once this is approved.

> Please outline where you expect those to go, it helps provide context
> to the actual reviewers rather than telling a small part of the story,
> it also may show that a PCS uclass is more appropriate than using
> misc.

> >  - Clause 73 Next Pages: a link partner that uses them is rejected
> >  - Register access over MDIO and the "direct" mapping
> >  - Clocks and the interrupt from the binding
> >  - PMA/SerDes initialisation: not done by this driver, it must be set
> >    up before pcs_set_config() is called

> How is that done? How is it documented? Again the sample driver would
> likely show this.
I will document these things in the v2.

Apart from these I will have SPDX headers in the files.

Thanks,
Akash Nair
