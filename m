Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FD5606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 13:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yJAJzqr4;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IJao8Kqy;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Cbv+nZC8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0373880DDC;
	Mon, 16 Nov 2026 13:02:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9b3Ohp7hu0sb; Mon, 16 Nov 2026 13:02:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 28EFD80E35
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794834139;
	b=YcE3FwHamGcuc0ze66fVCWFnGxAfOhZG5/kBwcNby8gR9QJONz2ULqH1JQlDfbWe6tHZ
	 umvcGhu5FDcvQFZ/3yuV+p+Fu2hDxzmTnJf+OLrr5labXHYh3nZK5qdwxtVzE7/v0prJ8
	 E+t1ryJ4Zapfidj4MGkhfU1MkRgLZf25v99r+0lYJDHRmNyXYhsCoUPhlLkdsUz6SScUl
	 fY+31rS2hRJeuNtGWJRwcpRH1jYp083cWw1wzq4djY472iwTbt9pS+B26J6fwk0QgixGv
	 3ouvGTye8754+lwCeASIBeOaNgGzmE/ofRXWqP4PAN5pjGgOVwr60rf6Ob898USCupg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794834139;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:DKIM-Signature:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=d3qqgETqBSDy81c6l9RGN4UNu8jF2SiZ8xQCUBKwBuY=;
	b=RUr3aUfUPCgsgrLDR7vFJPEsLS+FmU81r5Q0acnVz2ZYq1BiqOVjpI/yh97rQwnd/G3S
	 LSidcd3vuI1GEiMbS6mKe7HYF/p0jUyYWd+b8ogt2khwDPQQTActY+zGTex0F+Ah9xpzB
	 SmlYeDpGVY/6PSM9rvpBi4/ixCx8S/y32ovBc+U7bb5aR6vlplBSZ9GLN49wgAhH4fBbW
	 ytClmEzMdKC7X8RWlNYt85rTEi34mvN2OpYl/T1/mKWC5HU5RGxAGd2EEvv5S6p4gaF1f
	 vKjnJgwhm2uXmPpczb7tbPKMQ9VQ85Rj+mTcPNuzu57wtRrBqOZVIzR9g/UbANT6zzQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794834139;
	bh=d3qqgETqBSDy81c6l9RGN4UNu8jF2SiZ8xQCUBKwBuY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yJAJzqr4jFKLqcKTNJl5/2YnnCwjN1ucnJWDSMJi2yneYPR85wtF/ScMAtOcoYEGR
	 jVwS+ik88ijmGkZbMnVya9sm84SHUYg85eXyk6ImIZapoy8PFH8CW6QbxwfmcmrX6L
	 EZGcwWJtoa4JO9nIgWrJIIE8b7/X2Jo5dHI+cLPIgbG1SplIn749k3RBMTbIzlLGMU
	 GHcQj0qEl9FnF1Cgwc1hXs45tncjLdJRHwfl/MAVnandBBWSNl+n+e6C6+lfHOmFN9
	 G6tHsGITGrKcvXf91MVNBB5LaP9OFpRidCWVWWwk6MF9nxPHiMK2QExnhj84c+Uy4i
	 ZTyh+p2ceejQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28EFD80E35;
	Mon, 16 Nov 2026 13:02:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id EE1F02FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:07:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E06124008C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:07:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fN1PIrRLwktX for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 05:07:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B4EA240012
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=205.220.168.131
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.168.131;
 helo=mx0a-0031df01.pphosted.com;
 envelope-from=subrahmanya.lingappa@oss.qualcomm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=IJao8Kqy; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=Cbv+nZC8
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B4EA240012
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:07:46 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AG4R0YG3056795
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d3qqgETqBSDy81c6l9RGN4UNu8jF2SiZ8xQCUBKwBuY=; b=IJao8KqyP1R4rIvk
 nBRe/sQO1BsrbDYpZyL3MWxmsysF7X9ZfZZLNmf48surpvELY6zTGXshvhr3yecn
 8DffEl48pweJtSOtrcDty4XnPIWk6u9vuOnZRVq2Vpl2ie3Nn8vwF/0EPDMW1aQf
 PRqg7GtparARSzBqOVEP1XSHgGyUB4DBeqesQBdIhDEVpANbNLJPyXA9TbrlfcZc
 INy1XIwKmz5vAcykNyOxl6M2OxFCIYn9UIoFxEb7gmxiI5Id2k9GlndJteHog/ZQ
 LETEwsGc0wnZDExaeUoDfJPS2bgzw2vkIDdzy2G/Jf88p+VAHnSpZ52nosFrOMwg
 D0X4vw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmccsd8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 05:07:46 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-7d2c5352d1eso156087137.3
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 21:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794805665; x=1795410465;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d3qqgETqBSDy81c6l9RGN4UNu8jF2SiZ8xQCUBKwBuY=;
 b=Cbv+nZC80FJTd4CMJjrU3zIf3tKB6VI/oJTjWoawUdVEH4/TwRSGGcNiwMtPb09r96
 kcZd0Y/Z4zhArZ08cHwNsfQT3ptMclDdNmkwZ5SXt4K21HxXap0RgJtv6qe6Vg4O+aq3
 CCBSMtMBBPzOkj76sK64dpnCqazBTXMRKTLO8L6SQNRO5VbO6GyfZKWXW4AsmRHjVU1W
 jhBeoH/EDH7y7Qx5eTd4Zym73HOoO5DtQItlG+/dajzKU7CW7zflNmqanN1+h27haDiR
 SImT5QJTw3qaloui7JOuBHazRxmGa9/xQjmjx0yHT8gXs5SgOTl9vonY21mbPl0K8A77
 aMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794805665; x=1795410465;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d3qqgETqBSDy81c6l9RGN4UNu8jF2SiZ8xQCUBKwBuY=;
 b=fez3qrmNkvnmsHnpcgxwB9h47B+FFy20mRNvrPxkcRI4HmF6JNp38M7xbcFgRp6Efc
 cv057W3tUqroZ3Zv+5tngmuSfjV8l/MaCdIrOBDNltlwe+mmNiZiv6eMA/xAa7Nb+k6p
 3Jc6sCCxcTiH2TrmHWQ5+1PsrTQ2BcBHh8UgYF1Ecqrqza9UuT+Ps4/YrMrFLA2YAokF
 UGNXMTk2wq82wvgl2Kgi/UnG4PzbNzscqxz8dVgq1fSpfNaZjIJgjrCrF+P3dgSXIskB
 pYEv+s9MZMT3bHny+Thh85CBB8xVMPEc3wn5V0V2uBJuEZ2mReOJFeVWmx6lVs4EMuy0
 hWTQ==
X-Gm-Message-State: APuU4Z/qDkJiO1km2YJ0fYjCcBhGGDPW+yoY7rZFKJ/P+Y6zFwDHqn3h
 ES45+M8RfW0XaeHU23bi4eDT2mKNQ0g4X5shTKHwRyQH5OfdkSh+mtGV5oHoGvRGWQuBX94KhiH
 wANsmo9G0FIq0QeMcBEqBzbvR0SgD2eevhWCcYzVW84e/d0nF7/wz2X50VpHSZcYeMOcb0xPuX1
 a4mr9ARg4omQevzaETm1g0HWmhYMEl+x0hNtctLvOmoWpPKA==
X-Gm-Gg: AYBFou2gy+nISxw6eyLMXwQLZQySiDNkp0H4vRoALjy/yAVaiPiBL2JQ65NLDFBi5MX
 MHBJxsY+cSu7BMyjlzYLvduU23LW7HVDhCRwNJP1WT9iIrh6WfPMoLMkW6bKmEsw5EvajuP9WVl
 ZPX19chC6AMp9te1jzXwQnwh/HBMm9P6BdI2mA69K1cxxtuPmxd8gOd8YISak=
X-Received: by 2002:a05:6102:a1d4:10b0:7c3:83a9:edb2 with SMTP id
 ada2fe7eead31-7d64d454788mr2907493137.1.1794805664700; 
 Sun, 15 Nov 2026 21:07:44 -0800 (PST)
X-Received: by 2002:a05:6102:a1d4:10b0:7c3:83a9:edb2 with SMTP id
 ada2fe7eead31-7d64d454788mr2907476137.1.1794805664078; Sun, 15 Nov 2026
 21:07:44 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113-rpmi_v4-v5-0-6787318ad186@microchip.com>
 <20261113-rpmi_v4-v5-2-6787318ad186@microchip.com>
In-Reply-To: <20261113-rpmi_v4-v5-2-6787318ad186@microchip.com>
From: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 10:37:31 +0530
X-Gm-Features: Aa3M54qIO1vTtLg6SH99jTeSOWPkLj7-L34w3nGL6DCE74WNKjxsBYpKsikofNw
Message-ID: <CAPxK-6fkN2HN+oU0c-o01ZtEWAFoH92GPyuHqoDAYjgnM8xoSA@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] firmware: rpmi: add support for the SBI MPXY
 transport
To: Charles Perry <charles.perry@microchip.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>,
 Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Michal Simek <michal.simek@amd.com>, Conor Dooley <conor@kernel.org>,
 Peng Fan <peng.fan@oss.nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDAyMCBTYWx0ZWRfX6znYdHutgwQt
 x5sQvQ/DiJFXENsc7lxLq3WH3J/pwVNTvk5M+rLKtyKYfYEWqYi+a16yWbbv9o4vxeLpOnGitSS
 jz0PM/Lq4AD30JKhjhYQGVR/gqyRpVE=
X-Proofpoint-ORIG-GUID: ncwcg_kfOMFo5NPhJQcCslITMNVUV6zZ
X-Proofpoint-GUID: ncwcg_kfOMFo5NPhJQcCslITMNVUV6zZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDAyMCBTYWx0ZWRfX7nC3yUQFA435
 Db42ErYuMHuhKHdij67+pmSonRcAaJsbDJjiyuvsZJrhu/oALBInc84idJpLjo6inMbatVOXEbC
 NY+NWkrIjklPPipcav87CZr+HoC5HC1LzJXHR68167MOYkopRcCjQQLfNzsu4vuM3/gUPHLITT9
 rRLMRuoM8WfFNa819i06ku5IZJnJHGcoRxYrHpXcT6UBuFdtH5P20ImVx65Gp/wR8XDwyC1rm/n
 u83k+KLObvNU7Q1q5w296b/Y3feOhqJkAkVuA92Wc/+QyK9LuXbgD9RXFlyGkm49YgGjiuz0/+2
 yJS1dCYLMK4Ep+3Puj6v5jL0NxMRupg/D9MOh5Vw3cbD4HXd/rUibCHIcpPDMGCtnyt4S2JEdsu
 CGedLPkQ7T+JbvVa4MdR3ceukE+BXroQSAF5NzIkWAd/cGz4kitu5NhaxdbJyJB7EwiF5djYNGB
 qAHbfnpKgZ3QCthVccA==
X-Authority-Analysis: v=2.4 cv=Vpy2kO2n c=1 sm=1 tr=0 ts=6afa8fa2 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=XYAwZIGsAAAA:8
 a=Wqw0UAraFnB7B5Dxd3sA:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160020
X-Mailman-Approved-At: Mon, 16 Nov 2026 13:02:15 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>

On Sat, Nov 14, 2026 at 1:13=E2=80=AFAM Charles Perry
<charles.perry@microchip.com> wrote:
>
> This adds an RPMI transport driver for the Supervisor Binary Interface
> (SBI) message proxy (MPXY) extension [1].
>
> This is for S-Mode U-Boot where some supervisor software (such as
> OpenSBI) runs in M-Mode and handles the low level communication with the
> PuC.
>
> [1]: https://github.com/riscv-non-isa/riscv-sbi-doc (chapter 20)
>
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> ---
> Changes in v5:
>  - bound check the returned message length against max_xfer_len
>    (from Subrahmanya review)
>  - Makefile: compile MPXY only if CONFIG_RISCV_SMODE is true (from Leo
>    review)
>  - fix the case where sbi_get_spec_version() returns an error code (from
>    LLM review)
>
> Changes in v4: None
> Changes in v3: None
>
> Changes in v2: (from Yao Zi review)
>  - Reorder headers
>  - Remove struct sbi_mpxy_rpmi_channel_attrs and struct
>    sbi_mpxy_channel_attrs for simpler u32 arrays
>  - Don't null check pointers before free()
> ---
>  arch/riscv/include/asm/sbi.h          |  57 +++++
>  drivers/firmware/rpmi/Kconfig         |   9 +
>  drivers/firmware/rpmi/Makefile        |   3 +
>  drivers/firmware/rpmi/rpmi-sbi-mpxy.c | 415 ++++++++++++++++++++++++++++=
++++++
>  4 files changed, 484 insertions(+)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 47124dbaac84..10e03257d8e6 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -10,6 +10,7 @@
>  #define _ASM_RISCV_SBI_H
>
>  #include <linux/types.h>
> +#include <linux/errno.h>
>
>  enum sbi_ext_id {
>         SBI_EXT_0_1_SET_TIMER =3D 0x0,
> @@ -104,6 +105,17 @@ enum sbi_ext_dbcn_fid {
>         SBI_EXT_DBCN_CONSOLE_WRITE_BYTE,
>  };
>
> +enum sbi_ext_mpxy_fid {
> +       SBI_EXT_MPXY_GET_SHMEM_SIZE =3D 0,
> +       SBI_EXT_MPXY_SET_SHMEM,
> +       SBI_EXT_MPXY_GET_CHANNEL_IDS,
> +       SBI_EXT_MPXY_READ_ATTRS,
> +       SBI_EXT_MPXY_WRITE_ATTRS,
> +       SBI_EXT_MPXY_SEND_MSG_WITH_RESP,
> +       SBI_EXT_MPXY_SEND_MSG_WITHOUT_RESP,
> +       SBI_EXT_MPXY_GET_NOTIFICATION_EVENTS,
> +};
> +
>  #ifdef CONFIG_SBI_V01
>  #define SBI_EXT_SET_TIMER              SBI_EXT_0_1_SET_TIMER
>  #define SBI_FID_SET_TIMER              0
> @@ -132,6 +144,14 @@ enum sbi_ext_dbcn_fid {
>  #define SBI_SPEC_VERSION_MAJOR_MASK    0x7f
>  #define SBI_SPEC_VERSION_MINOR_MASK    0xffffff
>
> +static inline unsigned long sbi_mk_version(unsigned long major,
> +                                          unsigned long minor)
> +{
> +       return ((major & SBI_SPEC_VERSION_MAJOR_MASK)
> +               << SBI_SPEC_VERSION_MAJOR_SHIFT) |
> +              (minor & SBI_SPEC_VERSION_MINOR_MASK);
> +}
> +
>  /* SBI return error codes */
>  #define SBI_SUCCESS                    0
>  #define SBI_ERR_FAILURE                        -1
> @@ -139,6 +159,43 @@ enum sbi_ext_dbcn_fid {
>  #define SBI_ERR_INVALID_PARAM          -3
>  #define SBI_ERR_DENIED                 -4
>  #define SBI_ERR_INVALID_ADDRESS                -5
> +#define SBI_ERR_ALREADY_AVAILABLE      -6
> +#define SBI_ERR_ALREADY_STARTED                -7
> +#define SBI_ERR_ALREADY_STOPPED                -8
> +#define SBI_ERR_NO_SHMEM               -9
> +#define SBI_ERR_INVALID_STATE          -10
> +#define SBI_ERR_BAD_RANGE              -11
> +#define SBI_ERR_TIMEOUT                        -12
> +#define SBI_ERR_IO                     -13
> +#define SBI_ERR_DENIED_LOCKED          -14
> +
> +static inline int sbi_to_linux_error(int err)
> +{
> +       switch (err) {
> +       case SBI_SUCCESS:
> +               return 0;
> +       case SBI_ERR_DENIED:
> +       case SBI_ERR_DENIED_LOCKED:
> +               return -EPERM;
> +       case SBI_ERR_INVALID_PARAM:
> +       case SBI_ERR_INVALID_STATE:
> +               return -EINVAL;
> +       case SBI_ERR_BAD_RANGE:
> +               return -ERANGE;
> +       case SBI_ERR_INVALID_ADDRESS:
> +               return -EFAULT;
> +       case SBI_ERR_NO_SHMEM:
> +               return -ENOMEM;
> +       case SBI_ERR_TIMEOUT:
> +               return -ETIMEDOUT;
> +       case SBI_ERR_IO:
> +               return -EIO;
> +       case SBI_ERR_NOT_SUPPORTED:
> +       case SBI_ERR_FAILURE:
> +       default:
> +               return -EOPNOTSUPP;
> +       };
> +}
>
>  struct sbiret {
>         long error;
> diff --git a/drivers/firmware/rpmi/Kconfig b/drivers/firmware/rpmi/Kconfi=
g
> index 54fd77ad8f48..708d931263ff 100644
> --- a/drivers/firmware/rpmi/Kconfig
> +++ b/drivers/firmware/rpmi/Kconfig
> @@ -7,3 +7,12 @@ config RPMI_FIRMWARE
>           protocol for communication between an Application Processor (AP=
) and a
>           platform microcontroller (PuC). The RPMI specification is avail=
able
>           at: https://github.com/riscv-non-isa/riscv-rpmi
> +
> +config RPMI_SBI_MPXY
> +       bool "RPMI over SBI MPXY transport"
> +       depends on RPMI_FIRMWARE && SBI
> +       help
> +         Enable support for transport of RPMI messages over the message =
proxy
> +         (MPXY) extension of the supervisor binary interface (SBI). The
> +         specification for the MPXY extension is available at:
> +         https://github.com/riscv-non-isa/riscv-sbi-doc (chapter 20)
> diff --git a/drivers/firmware/rpmi/Makefile b/drivers/firmware/rpmi/Makef=
ile
> index d69c718d150e..4976176f07df 100644
> --- a/drivers/firmware/rpmi/Makefile
> +++ b/drivers/firmware/rpmi/Makefile
> @@ -1 +1,4 @@
>  obj-y  +=3D rpmi-uclass.o
> +ifeq ($(CONFIG_$(PHASE_)RISCV_SMODE),y)
> +obj-$(CONFIG_RPMI_SBI_MPXY) +=3D rpmi-sbi-mpxy.o
> +endif
> diff --git a/drivers/firmware/rpmi/rpmi-sbi-mpxy.c b/drivers/firmware/rpm=
i/rpmi-sbi-mpxy.c
> new file mode 100644
> index 000000000000..3398271f8567
> --- /dev/null
> +++ b/drivers/firmware/rpmi/rpmi-sbi-mpxy.c
> @@ -0,0 +1,415 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
> + */
> +
> +#define LOG_CATEGORY UCLASS_RPMI
> +
> +#include <asm/io.h>
> +#include <asm/sbi.h>
> +#include <asm/types.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <linux/bitops.h>
> +#include <linux/kernel.h>
> +#include <log.h>
> +#include <malloc.h>
> +#include <rpmi-uclass.h>
> +#include <string.h>
> +
> +/* SBI MPXY channel IDs data in shared memory */
> +struct sbi_mpxy_channel_ids_data {
> +       /* Remaining number of channel ids */
> +       __le32 remaining;
> +       /* Returned channel ids in current function call */
> +       __le32 returned;
> +       /* Returned channel id array */
> +       __le32 channel_array[];
> +};
> +
> +enum sbi_mpxy_attribute_id {
> +       /* Standard channel attributes managed by MPXY framework */
> +       SBI_MPXY_ATTR_MSG_PROT_ID =3D 0x00000000,
> +       SBI_MPXY_ATTR_MSG_PROT_VER =3D 0x00000001,
> +       SBI_MPXY_ATTR_MSG_MAX_LEN =3D 0x00000002,
> +       SBI_MPXY_ATTR_MSG_SEND_TIMEOUT =3D 0x00000003,
> +       SBI_MPXY_ATTR_MSG_COMPLETION_TIMEOUT =3D 0x00000004,
> +       SBI_MPXY_ATTR_CHANNEL_CAPABILITY =3D 0x00000005,
> +       SBI_MPXY_ATTR_SSE_EVENT_ID =3D 0x00000006,
> +       SBI_MPXY_ATTR_MSI_CONTROL =3D 0x00000007,
> +       SBI_MPXY_ATTR_MSI_ADDR_LO =3D 0x00000008,
> +       SBI_MPXY_ATTR_MSI_ADDR_HI =3D 0x00000009,
> +       SBI_MPXY_ATTR_MSI_DATA =3D 0x0000000A,
> +       SBI_MPXY_ATTR_EVENTS_STATE_CONTROL =3D 0x0000000B,
> +       SBI_MPXY_ATTR_STD_ATTR_MAX_IDX,
> +       /*
> +        * Message protocol specific attributes, managed by
> +        * the message protocol specification.
> +        */
> +       SBI_MPXY_ATTR_MSGPROTO_ATTR_START =3D 0x80000000,
> +       SBI_MPXY_ATTR_MSGPROTO_ATTR_END =3D 0xffffffff
> +};
> +
> +/* SBI_MPXY_ATTR_CHANNEL_CAPABILITY bits */
> +#define SBI_MPXY_CHAN_CAP_MSI BIT(0)
> +#define SBI_MPXY_CHAN_CAP_SSE BIT(1)
> +#define SBI_MPXY_CHAN_CAP_EVENTS_STATE BIT(2)
> +#define SBI_MPXY_CHAN_CAP_SEND_WITH_RESP BIT(3)
> +#define SBI_MPXY_CHAN_CAP_SEND_WITHOUT_RESP BIT(4)
> +#define SBI_MPXY_CHAN_CAP_GET_NOTIFICATIONS BIT(5)
> +
> +/* RPMI message protocol specific MPXY attributes */
> +enum sbi_mpxy_rpmi_attribute_id {
> +       SBI_MPXY_RPMI_ATTR_SERVICEGROUP_ID,
> +       SBI_MPXY_RPMI_ATTR_SERVICEGROUP_VERSION,
> +       SBI_MPXY_RPMI_ATTR_IMPL_ID,
> +       SBI_MPXY_RPMI_ATTR_IMPL_VERSION,
> +       SBI_MPXY_RPMI_ATTR_MAX_ID
> +};
> +
> +/* Possible values of MSG_PROT_ID attribute as-per SBI v3.0 (or higher) =
*/
> +enum sbi_mpxy_msgproto_id {
> +       SBI_MPXY_MSGPROTO_RPMI_ID =3D 0x0,
> +};
> +
> +struct sbi_mpxy_chan_desc {
> +       u32 id;
> +       u32 max_xfer_len;
> +       u32 attrs[SBI_MPXY_ATTR_STD_ATTR_MAX_IDX];
> +       u32 rpmi_attrs[SBI_MPXY_RPMI_ATTR_MAX_ID];
> +};
> +
> +struct rpmi_sbi_mpxy {
> +       struct udevice *dev;
> +       void *shmem;
> +       unsigned long shmem_size;
> +       u32 channel_count;
> +       struct sbi_mpxy_chan_desc *channel_descs;
> +};
> +
> +static int rpmi_sbi_mpxy_read_attrs(struct rpmi_sbi_mpxy *mpxy, u32 chan=
nel_id,
> +                                   u32 base_attrid, u32 attr_count,
> +                                   u32 *attrs_buf)
> +{
> +       struct sbiret sret;
> +       int i;
> +
> +       sret =3D sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_READ_ATTRS, channel=
_id,
> +                        base_attrid, attr_count, 0, 0, 0);
> +       if (sret.error)
> +               return sbi_to_linux_error(sret.error);
> +
> +       for (i =3D 0; i < attr_count; i++)
> +               attrs_buf[i] =3D le32_to_cpu(((__le32 *)mpxy->shmem)[i]);
> +
> +       return 0;
> +}
> +
> +static int rpmi_sbi_mpxy_send_message(struct rpmi_sbi_mpxy *mpxy,
> +                                     struct sbi_mpxy_chan_desc *desc,
> +                                     u32 mpxy_fid, u32 msg_id, const voi=
d *tx,
> +                                     unsigned long tx_len, void *rx,
> +                                     unsigned long max_rx_len,
> +                                     unsigned long *rx_len)
> +{
> +       void *shmem =3D mpxy->shmem;
> +       unsigned long rx_bytes;
> +       struct sbiret sret;
> +
> +       if (tx)
> +               memcpy(shmem, tx, tx_len);
> +
> +       sret =3D sbi_ecall(SBI_EXT_MPXY, mpxy_fid, desc->id, msg_id, tx_l=
en, 0, 0,
> +                        0);
> +
> +       if (rx && !sret.error) {
> +               rx_bytes =3D sret.value;
> +               if (rx_bytes > max_rx_len)
> +                       return -ENOSPC;
> +               if (rx_bytes > desc->max_xfer_len)
> +                       return -EIO;
> +
> +               memcpy(rx, shmem, rx_bytes);
> +               if (rx_len)
> +                       *rx_len =3D rx_bytes;
> +       }
> +
> +       return sbi_to_linux_error(sret.error);
> +}
> +
> +static int rpmi_sbi_mpxy_get_attr(struct rpmi_chan *chan,
> +                                 enum rpmi_attribute_id id, u32 *data)
> +{
> +       struct rpmi_sbi_mpxy *mpxy =3D dev_get_priv(chan->dev);
> +       struct sbi_mpxy_chan_desc *desc =3D &mpxy->channel_descs[chan->id=
];
> +
> +       switch (id) {
> +       case RPMI_ATTR_SPEC_VERSION:
> +               *data =3D desc->attrs[SBI_MPXY_ATTR_MSG_PROT_VER];
> +               break;
> +       case RPMI_ATTR_MAX_MSG_DATA_SIZE:
> +               *data =3D desc->max_xfer_len;
> +               break;
> +       case RPMI_ATTR_SERVICEGROUP_ID:
> +               *data =3D desc->rpmi_attrs[SBI_MPXY_RPMI_ATTR_SERVICEGROU=
P_ID];
> +               break;
> +       case RPMI_ATTR_SERVICEGROUP_VERSION:
> +               *data =3D desc->rpmi_attrs[SBI_MPXY_RPMI_ATTR_SERVICEGROU=
P_VERSION];
> +               break;
> +       case RPMI_ATTR_IMPL_ID:
> +               *data =3D desc->rpmi_attrs[SBI_MPXY_RPMI_ATTR_IMPL_ID];
> +               break;
> +       case RPMI_ATTR_IMPL_VERSION:
> +               *data =3D desc->rpmi_attrs[SBI_MPXY_RPMI_ATTR_IMPL_VERSIO=
N];
> +               break;
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +
> +       return 0;
> +}
> +
> +static int rpmi_sbi_mpxy_request(struct rpmi_chan *chan, u32 service_id,
> +                                const void *request, unsigned long reque=
st_len,
> +                                void *response, unsigned long max_respon=
se_len,
> +                                unsigned long *out_response_len)
> +{
> +       struct rpmi_sbi_mpxy *mpxy =3D dev_get_priv(chan->dev);
> +       struct sbi_mpxy_chan_desc *desc =3D &mpxy->channel_descs[chan->id=
];
> +       u32 caps =3D desc->attrs[SBI_MPXY_ATTR_CHANNEL_CAPABILITY];
> +       u32 mpxy_fid;
> +
> +       if (!request && request_len)
> +               return -EINVAL;
> +
> +       if (request_len > desc->max_xfer_len)
> +               return -EINVAL;
> +
> +       if (!response && max_response_len)
> +               return -EINVAL;
> +
> +       if (response) {
> +               if (!(caps & SBI_MPXY_CHAN_CAP_SEND_WITH_RESP))
> +                       return -EIO;
> +
> +               mpxy_fid =3D SBI_EXT_MPXY_SEND_MSG_WITH_RESP;
> +       } else {
> +               if (!(caps & SBI_MPXY_CHAN_CAP_SEND_WITHOUT_RESP))
> +                       return -EIO;
> +
> +               mpxy_fid =3D SBI_EXT_MPXY_SEND_MSG_WITHOUT_RESP;
> +       }
> +
> +       return rpmi_sbi_mpxy_send_message(mpxy, desc, mpxy_fid, service_i=
d,
> +                                         request, request_len, response,
> +                                         max_response_len, out_response_=
len);
> +}
> +
> +static int rpmi_sbi_mpxy_of_xlate(struct rpmi_chan *chan,
> +                                 struct ofnode_phandle_args *args)
> +{
> +       struct rpmi_sbi_mpxy *mpxy =3D dev_get_priv(chan->dev);
> +       u32 channel_id, proto;
> +       int i;
> +
> +       if (args->args_count !=3D 2)
> +               return -EINVAL;
> +
> +       channel_id =3D args->args[0];
> +       proto =3D args->args[1];
> +
> +       for (i =3D 0; i < mpxy->channel_count; i++) {
> +               if (mpxy->channel_descs[i].id =3D=3D channel_id &&
> +                   mpxy->channel_descs[i].attrs[SBI_MPXY_ATTR_MSG_PROT_I=
D] =3D=3D
> +                           proto) {
> +                       chan->id =3D i;
> +                       return 0;
> +               }
> +       }
> +
> +       return -EINVAL;
> +}
> +
> +static int rpmi_sbi_mpxy_get_shmem_size(unsigned long *shmem_size)
> +{
> +       struct sbiret sret;
> +
> +       sret =3D sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_GET_SHMEM_SIZE, 0, =
0, 0, 0,
> +                        0, 0);
> +       if (sret.error)
> +               return sbi_to_linux_error(sret.error);
> +
> +       /* The shared memory size MUST be at least 4096 bytes */
> +       if (sret.value < PAGE_SIZE)
> +               return -ENODEV;
> +
> +       /* The shared memory size MUST be multiple of 4096 bytes */
> +       if (sret.value & (PAGE_SIZE - 1))
> +               return -ENODEV;
> +
> +       if (shmem_size)
> +               *shmem_size =3D sret.value;
> +
> +       return 0;
> +}
> +
> +static int rpmi_sbi_mpxy_get_channel_ids(struct rpmi_sbi_mpxy *mpxy)
> +{
> +       struct sbi_mpxy_channel_ids_data *sdata =3D mpxy->shmem;
> +       u32 remaining, returned, channel_id, start_index =3D 0;
> +       struct sbiret sret;
> +       int i, ret;
> +
> +       do {
> +               sret =3D sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_GET_CHANNEL=
_IDS,
> +                                start_index, 0, 0, 0, 0, 0);
> +               if (sret.error)
> +                       return sbi_to_linux_error(sret.error);
> +
> +               remaining =3D le32_to_cpu(sdata->remaining);
> +               returned =3D le32_to_cpu(sdata->returned);
> +
> +               // Allocate memory on the first call.
> +               if (!mpxy->channel_descs) {
> +                       mpxy->channel_count =3D returned + remaining;
> +                       if (mpxy->channel_count =3D=3D 0)
> +                               return -ENODEV;
> +
> +                       mpxy->channel_descs =3D
> +                               calloc(mpxy->channel_count,
> +                                      sizeof(struct sbi_mpxy_chan_desc))=
;
> +                       if (!mpxy->channel_descs)
> +                               return -ENOMEM;
> +
> +                       dev_dbg(mpxy->dev, "channel count =3D %i\n",
> +                               mpxy->channel_count);
> +               }
> +
> +               if (remaining && !returned)
> +                       return -EPROTO;
> +
> +               if (start_index + returned > mpxy->channel_count)
> +                       return -EPROTO;
> +
> +               for (i =3D 0; i < returned; i++) {
> +                       mpxy->channel_descs[start_index + i].id =3D
> +                               le32_to_cpu(sdata->channel_array[i]);
> +               }
> +               start_index +=3D returned;
> +       } while (remaining);
> +
> +       for (i =3D 0; i < mpxy->channel_count; i++) {
> +               channel_id =3D mpxy->channel_descs[i].id;
> +
> +               ret =3D rpmi_sbi_mpxy_read_attrs(mpxy, channel_id,
> +                                              SBI_MPXY_ATTR_MSG_PROT_ID,
> +                                              SBI_MPXY_ATTR_STD_ATTR_MAX=
_IDX,
> +                                              mpxy->channel_descs[i].att=
rs);
> +               if (ret)
> +                       return ret;
> +
> +               if (mpxy->channel_descs[i].attrs[SBI_MPXY_ATTR_MSG_PROT_I=
D] =3D=3D
> +                   SBI_MPXY_MSGPROTO_RPMI_ID) {
> +                       ret =3D rpmi_sbi_mpxy_read_attrs(
> +                               mpxy, channel_id,
> +                               SBI_MPXY_ATTR_MSGPROTO_ATTR_START,
> +                               SBI_MPXY_RPMI_ATTR_MAX_ID,
> +                               mpxy->channel_descs[i].rpmi_attrs);
> +                       if (ret)
> +                               return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static int rpmi_sbi_mpxy_probe(struct udevice *dev)
> +{
> +       struct rpmi_sbi_mpxy *mpxy =3D dev_get_priv(dev);
> +       struct sbi_mpxy_chan_desc *desc;
> +       unsigned long flags;
> +       struct sbiret sret;
> +       long sbi_version;
> +       int i, ret;
> +
> +       mpxy->dev =3D dev;
> +
> +       /* Probe for SBI MPXY extension */
> +       sbi_version =3D sbi_get_spec_version();
> +       if (sbi_version < 0 || sbi_version < sbi_mk_version(1, 0) ||
> +           sbi_probe_extension(SBI_EXT_MPXY) <=3D 0) {
> +               dev_info(dev, "SBI MPXY extension not available\n");
> +               return -ENODEV;
> +       }
> +
> +       /* Find-out shared memory size */
> +       ret =3D rpmi_sbi_mpxy_get_shmem_size(&mpxy->shmem_size);
> +       if (ret) {
> +               dev_err(dev, "failed to get MPXY shared memory size\n");
> +               return -ENODEV;
> +       }
> +
> +       mpxy->shmem =3D memalign(PAGE_SIZE, mpxy->shmem_size);
> +       if (!mpxy->shmem)
> +               return -ENOMEM;
> +
> +       /* Setup shmem in OVERWRITE mode. (flags[1:0] =3D 00b) */
> +       flags =3D 0;
> +       sret =3D sbi_ecall(SBI_EXT_MPXY, SBI_EXT_MPXY_SET_SHMEM,
> +                        virt_to_phys(mpxy->shmem), 0, flags, 0, 0, 0);
> +       if (sret.error) {
> +               ret =3D sbi_to_linux_error(sret.error);
> +               goto err;
> +       }
> +
> +       ret =3D rpmi_sbi_mpxy_get_channel_ids(mpxy);
> +       if (ret)
> +               goto err;
> +
> +       for (i =3D 0; i < mpxy->channel_count; i++) {
> +               desc =3D &mpxy->channel_descs[i];
> +               desc->max_xfer_len =3D
> +                       min((u32)mpxy->shmem_size,
> +                           desc->attrs[SBI_MPXY_ATTR_MSG_MAX_LEN]);
> +       }
> +
> +       return 0;
> +
> +err:
> +       free(mpxy->channel_descs);
> +       free(mpxy->shmem);
> +
> +       return ret;
> +}
> +
> +static int rpmi_sbi_mpxy_remove(struct udevice *dev)
> +{
> +       struct rpmi_sbi_mpxy *mpxy =3D dev_get_priv(dev);
> +
> +       free(mpxy->channel_descs);
> +       free(mpxy->shmem);
> +
> +       return 0;
> +}
> +
> +static const struct udevice_id rpmi_sbi_mpxy_ids[] =3D {
> +       { .compatible =3D "riscv,sbi-mpxy-mbox" },
> +       {}
> +};
> +
> +static const struct rpmi_transport_ops rpmi_sbi_mpxy_ops =3D {
> +       .of_xlate =3D rpmi_sbi_mpxy_of_xlate,
> +       .get_attr =3D rpmi_sbi_mpxy_get_attr,
> +       .request =3D rpmi_sbi_mpxy_request,
> +};
> +
> +U_BOOT_DRIVER(rpmi_sbi_mpxy) =3D {
> +       .name =3D "rpmi-sbi-mpxy",
> +       .id =3D UCLASS_RPMI,
> +       .of_match =3D rpmi_sbi_mpxy_ids,
> +       .probe =3D rpmi_sbi_mpxy_probe,
> +       .remove =3D rpmi_sbi_mpxy_remove,
> +       .priv_auto =3D sizeof(struct rpmi_sbi_mpxy),
> +       .ops =3D &rpmi_sbi_mpxy_ops,
> +       .flags =3D DM_FLAG_PRE_RELOC,
> +};
>
> --
> 2.53.0
>
