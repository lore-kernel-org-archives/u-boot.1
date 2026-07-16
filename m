Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B85C44501
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 02:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A66F884D72;
	Thu, 16 Jul 2026 04:46:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cSqC5QUE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j7SyrsJN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D95E984D73; Thu, 16 Jul 2026 04:45:59 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A936E84D36
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 04:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rahul.pathak@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G0XnJp1226890
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 02:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z30AOS/Tc8MlEo9cI/X156wbLMNoLI53ViHl7GYk8k0=; b=cSqC5QUE1LKxwY9I
 qIZF2tHiPb7MrvKIVJlmZZWMHhw7aYEJOhhUKEegHYqYz+NaUGuLBqLKQdcea6qC
 Z4RFkEYhc7rUMtP75KV962L77Rj0WUWJUMsYu/fYUQHpcnmEyaPwA5wjoIvGFY/s
 JDuJcQOYNrbx0s3EcnfBPv3jh38qLGVFsxWZLAW+pg/TxWLWDRFhSI0iGALEyfbT
 6RSUEt8Nifi7cBCUJhFrtcnHIUpOPO33VuVWMCP+vz9EbeigY9PQyxFzGPh9Gfm/
 p0+tPZrRtu3lwUcIsOUihKcfWhiJ6AA9D/qgThE/Lm8LXVrhQwDTS2YCThws8hNH
 vet4tw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feeg1hny4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 02:45:55 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e66f9e2baso442545685a.0
 for <u-boot@lists.denx.de>; Wed, 15 Jul 2026 19:45:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784169955; cv=none;
 d=google.com; s=arc-20260327;
 b=hNRdcK1xkvue5EL92xAqg8ya/N81UH3iNAAkAK2kt5Oz7X+ApOTFD5Iu+kKXAnrrc5
 BZ6WjYcwO54P5pO04Ofxzsfu+GxA38m3CxrbNx0hiA4R17bdKCDCXxhau+Q0kmSnE6DN
 rfw9fkYS2fDe/Fd0V5u7D0H9gzboUiCDKi6Bdl9z9fLloIYBPlWtIaV7/8FaOtTFpime
 W09OCWZ1mKBIGtvfrurV9sfa3dU2cal/wKoOu8y3kSiS4L/0HQdVt0up3yqR1KXB+FKY
 /HAXxl8HVgoCx4cxGIITTdYkM7vNuUhHivwHP8B+rWe0vze8o1kpKrJEbXP920+gDOCs
 6/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=z30AOS/Tc8MlEo9cI/X156wbLMNoLI53ViHl7GYk8k0=;
 fh=lKF8suJlCFCP9fZ6gCQfGg3jHgNxOnuuzuUhGi7d6ow=;
 b=Bov5mRwIEokJwngcaoPra8A3oNTz0Z/PaX7CQ07jvXVE7JDfcEiJxN0DwZDauP+ISH
 G1gcokcf09/OZCCYjadqHksWn2MUJ2CdNMk+hKsLkREa8fgctjWooqbdnKlSRxQrPZHg
 cX7ndDojaSq/I/ur7a0+qfEZ/zdJPpmVqqbnFbPM/csu3CFlT4EN29ij1wBYBjplVbqS
 bswxQhwLjc51jaNJeRREBJhqHsz82aeZk6ghz0q0o39JrDGHHBZu5oAce5D55Uwc21G0
 QvsE3SGy8Q5+aw27DoXUjMSzVsW4lpmpKAEcPS+ju6wo2cYTsTsn/7o/FCeJOjA7GSgX
 hXkQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784169955; x=1784774755; darn=lists.denx.de; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=z30AOS/Tc8MlEo9cI/X156wbLMNoLI53ViHl7GYk8k0=;
 b=j7SyrsJNNNxPWKJjI87DtZuiESeQWq0z9ooiSGYxszZj8GLxBaxAiEcTHrFMa8/IrA
 IYuZ3P9/iIx729eLX7yFulVuHjJRI5YtX85vA8aH1KQ8lR7gHyXnt9U8VXbQnO0XSbfP
 mWjjtKM4jDrDhUFlUaJeef/9p9PtjbvehHatn93tkePeO5eBzYK0KTRb+Kxu0n2IXtbr
 +IGEl+pWfBSuRdIfd1fiEUlFJpS7BNq8GoO5q2DY19t4hIsnz3lK8o7ueBYbgwJR71VQ
 HkTiHVcztB3voCIePZrEQbOyiY8idM4TXTgjBTVi1ft/qpSBCgRUOMeIeZCYZOeJFqjw
 de+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784169955; x=1784774755;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z30AOS/Tc8MlEo9cI/X156wbLMNoLI53ViHl7GYk8k0=;
 b=Sss8cmf/czOBhF79t7SBUPl1JhNkbtRxWGvukv02XhrmlfwDK8xq/i9NbUegIeRwLR
 UPnO1C8B3p5H5/KX3LdHv2B/SbFw77srxB8JCi3NX2AhZVJIXBq/6HtdkGA1rdWU5c+h
 aKmm2cUSF7+ULgN5oSyWK7Wu/7seqpPxukZWwuTDT64HsVXieu1cfJ5mjbx4aPxBNnPj
 mUgb9NgIflGkoZkiEJX4pHkFfkTFpRL2zaGrPfTAOEVFgV5/3Pr3ik07zwrFJlGHRhvK
 HDZ5p9Zab1JRTTQGDVL+hBITAqKsyn6swxodylbrHJpW49KjmrAAcyjYl5VBSrPIx8Fe
 u46Q==
X-Gm-Message-State: AOJu0YwkL8z72MyGlmAnrzu2k+8giOb8qCq5mdql/hI4PlcB7v8s7OFX
 tohRun9XCC1vljXDqLDM+IQbQPUAaYvC0drVZtx93enYdhwjNSYma8BYez0VfHM3PzUBxyKQlt0
 i2bAjSCgcjLRzMx+tiMO1/LEyNHJcURQf3n76VVPvOUsnVoLmzdWJg2+F6PE+muheYukjaemHK2
 Jm06DoSDraOt6vmbUGc6DPlz4qPoU5ETg=
X-Gm-Gg: AfdE7cm3rsOknZi1WeHeIMASd3npd7Hp2V92gehG7K42NQSsJdMUdxuOZhe3ZeJGCRP
 8/67Cf5QKrWD/Gk3KxQj3NwxcRpD7mqPpf9sXMW7WxDU9jPdZlKVLHNQOb7HzM8S1VCd5mYGVUP
 /vDbdixwZD+BSO3r/9hqlHn5Z0J2xmJmkExeb3R4wnzwyVMjoSqPnCAHbZ1w==
X-Received: by 2002:a05:620a:2a09:b0:92e:cac7:96e6 with SMTP id
 af79cd13be357-92ef2c29f1bmr2084406385a.58.1784169955283; 
 Wed, 15 Jul 2026 19:45:55 -0700 (PDT)
X-Received: by 2002:a05:620a:2a09:b0:92e:cac7:96e6 with SMTP id
 af79cd13be357-92ef2c29f1bmr2084404085a.58.1784169954747; Wed, 15 Jul 2026
 19:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260709175605.1070755-1-rahul.pathak@oss.qualcomm.com>
 <alZvl61jiQ0Wlvl2@bby-cbu-swbuild03.eng.microchip.com>
In-Reply-To: <alZvl61jiQ0Wlvl2@bby-cbu-swbuild03.eng.microchip.com>
From: Rahul Pathak <rahul.pathak@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 08:15:42 +0530
X-Gm-Features: AUfX_mwi-y4lnmE6ByKCkUOsdmi3BWpEqJynQxuFu6FZu1TCy8zxigtrjHI6KeA
Message-ID: <CAFR3w36bcmGtSMLwt2NBKh7OQ_AW_7dPJfYrqc0=KpGC6LwnUg@mail.gmail.com>
Subject: Re: [PATCH 0/3] riscv: Add generic SBI MPXY interface and MPXY command
To: Charles Perry <charles.perry@microchip.com>
Cc: u-boot@lists.denx.de, anup.patel@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDAyNSBTYWx0ZWRfX3jQHeXz0usBp
 QKOA/177M+1u95ksOq96AGaugVnXI/WWUo3eGRjl7R0s0fabckUfK32ZXRMztI+upt4LlEVGv+C
 +Zufjghb2pYeKBfUkcoj8syMExGeNuCnp3X5JWL3W6yzqnC8sI4V70lOwTnjaXtjtEu+vou5WyH
 rK4cVqXMZKE9yjO1jQk4PA9N9NlkUoBShuRhgPdE/GVLS0VIcs9KGv67LkSu89FkUHHQHXIgSVn
 Y6ZirTQm65uYzqq6Sbb/HkjQWiQBrRZBcKrxkXyWFwN2ESM/dsOFcLRkB0jeOWscBshuVua8g/Q
 3PCVvBCrRmYnFQuI5AbeEqZLvB/x7YlYirH9ZepiLogvWCSFXZ7gTMfjNA9vm6uM6jt3+5F8Wtz
 sfdV92vQ46FZ+Q0IN1f51a9NHxzzJEWaOlYT9JboGKv+MSZ4+FM2Qn6gN+ta3kGVW/hBWLG/JpH
 4qB+4nPCvra5dM6XjAA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDAyNSBTYWx0ZWRfX7DdnNOhajWhm
 hcaR7e1kxsQT4+E67HgmC5+MoP9BbNDd2vNKqxa/sRLasEXfjf/0iwzKLpmMHeTZwGxBNQ3m60M
 DpJigkTXlGBGaEcIyBhk6Ka3cjMFaww=
X-Proofpoint-GUID: SJN5ARpk91l_7-QicwYSW5dhAc6Ycq5r
X-Proofpoint-ORIG-GUID: SJN5ARpk91l_7-QicwYSW5dhAc6Ycq5r
X-Authority-Analysis: v=2.4 cv=SsOgLvO0 c=1 sm=1 tr=0 ts=6a5845e3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=XYAwZIGsAAAA:8 a=YJLxltowQ5SDOXdSQccA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_01,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160025
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, Jul 14, 2026 at 10:49=E2=80=AFPM Charles Perry
<charles.perry@microchip.com> wrote:
>
> On Thu, Jul 09, 2026 at 11:26:01PM +0530, Rahul Pathak wrote:
> > This patch series adds a generic SBI MPXY extension
> > implementation which provides an interface to interact
> > with platform via supported message protocol (eg. RPMI)
> >
> > It also adds a mpxy command which uses the generic
> > SBI MPXY interface and provides cli support to
> > interact with supported message protocol. Currently
> > it supports RISC-V RPMI message protocol.
>
> Hello Rahul,
>
> I'm happy to see that you're interested in RPMI support in U-Boot.
>
> Can you share with us the context in which you developed those patches?
> i.e., what hardware are you using and how is the "mpxy" command used.
>
> Is "mpxy" mostly just for debugging or is it expected that a bootscript
> would initialize the platform with calls to "mpxy"?
>
Hi Charles,

I have used QEMU RISC-V Virt platform (with OpenSBI + librpmi
providing the RPMI firmware side) for its development, and in terms of
use cases its both actually which you outlined - debugging and
configuration.

Debugging is the pretty obvious usecase where mpxy command allows
anyone to access message protocol in case of RPMI, it lets you
access any custom service group implemented without changing u-boot.

Boot time tweaking of any attribute or any platform state changes via
scripts is also possible as you mentioned. The configuration can be
board specific and expressed in uboot environment scripts instead of
compiled in driver code.

Thanks
Rahul
