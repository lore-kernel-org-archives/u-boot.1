Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543C3C61DBE
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 00:17:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5F6E403F4;
	Thu, 27 Aug 2026 00:17:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H3R6wxmbjqs5; Thu, 27 Aug 2026 00:17:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787789821;
	bh=8p2rHBYqrxefb5oUWrNo+FfDfSqwUMnBeDunJut9THY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iIw97nDASwPKOvR8etqRReGCFLbPv7bSXvnGGOB8iMQiG8qGmJeygwq7Q0p7SvoDL
	 Cx3MEOGvvFhRUyd4Hryw2yWJHV7Sj9kIj/52Ea24Mlo24thF+jjBNEFnrCRCOq2epK
	 WrRbMZTmme43g8NR/yf+Zg6fL5Kq4sVDRb4aLF/bb44HEjGBfqHD31oyrzo+A/4rTk
	 ek4wYIzpCfCkIpArZqb5N9wDg5fwdJpT0AG6upa2a15Z01tC6HHadzO0X+0RlE1ghM
	 Q3jczAEYUT90vt4Zwx++gA0dhZdvjX5dLkSMseFPiJREiPcPQZO5nHf3+ieTCkw3UC
	 5JlEwSenwcYTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E2E54403F5;
	Thu, 27 Aug 2026 00:17:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CD57341
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 00:16:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5E85A403F5
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 00:16:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JeoepmNq_Xz9 for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 00:16:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.180.131;
 helo=mx0b-0031df01.pphosted.com; envelope-from=urvashi.sharma@oss.qualcomm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com
 header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1
 header.b=cNHFUMu8; dkim=pass (2048-bit key,
 unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com
 header.a=rsa-sha256 header.s=google header.b=gPcElCSs
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5A7E1403F4
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 00:16:57 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QKdWfi2340300
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 00:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=8p2rHBYqrxefb5oUWrNo+FfD
 fSqwUMnBeDunJut9THY=; b=cNHFUMu8KUKU2otH+Lds17PTPLsWzrCmIYte5fUq
 CWKltWQ69jOv8JoLFDkvaDUvfxAsv3gfQB88evN0/WCXpcEzhMH7xVeh/AbAvvwd
 zJ+zXQQ+4T5OkZQg2bGylOldvkpQKbTzTVkygt2PVJd1K9GKfwtplH3jYsmZUcpC
 2x8KYeTUT2fTYu6+KalBBc8iASJkXeX9g9v0qOSwAaFySmC6YZB0/pnovfMd0lnG
 7EH54oWopCNeYcMnmNA8JnbLHnj73RWbth96cEDQQJtAAFPjrSVtnOuh1Dom3vrl
 a+inOHPq+tM+Vaq++eaCDVpMXI6XbdTLYjEEyWEJtdjsyw==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4egha7d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 00:16:56 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-66ce373dc9cso3462687d50.3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 17:16:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787789816; cv=none;
 d=google.com; s=arc-20260327;
 b=iZ7qxLI23A0vl+6O6IyS5p4/lEUO6neuR9n0o8H3kJzmnFNb4khcPUm7glYrIG3hVR
 NhR9GP6MEME1Z/0Etf/dfJJyirANh008d72aUfs7/7yx7tbOfZmoF0bG6shLuL+61dfy
 egN8pP8ImDRO5qwaC9mVjw7Ok5CECzLwUdqDqir8sVXn80AFoPEOPisuZfKPQ6khCPN4
 meLfIONcl1PyGiboi/gooY+LffnBqoCmEvOyccLYeMY3WkNgPgCOYj4efdgti9lcCt5I
 VmCjkAMoYu2uSxnargvKT+Sled3ElalXZd429Zplr8DN55zpitKl1W7SGcQum43IxeQl
 2HCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8p2rHBYqrxefb5oUWrNo+FfDfSqwUMnBeDunJut9THY=;
 fh=dTODIB8eOV8QmMXTO6NS9hJAq2JPVHLo51odT60wrm8=;
 b=QWcPt3rB1dEsKGmh9OBUVIKA5vXPVNTS5kXgVszXH+cObTY6uCZ3Ob2Eo+721seoHo
 pC9D8hgTlsQ0ym0T+YZwWmVjhoSrFNkF37n8f6kRRc8FSIOaVceBFLkKyAYu91uoNlX/
 qaB/PlM5pQA0EekTxR7X51K4GZkgNZRLztaPhKT+s+mAt83oYWWpmLcaP3gnQz5n0Q45
 dEnK2zcu9kA2NcLiZXEz0R0/xi9lAERRFGseIMJDJYZIVH/HutlKtBTz4j2fiheLcqln
 W+Aby+rFeur0Wv4RfiT2XvVQXlCIj20u9X2GDBAd1xFdM6osZ2GG3bqeUfgDx+KMc1jT
 IizA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787789816; x=1788394616;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8p2rHBYqrxefb5oUWrNo+FfDfSqwUMnBeDunJut9THY=;
 b=gPcElCSsCBTseQxhln8qvGjBF1gPMHhpexTRrvluiaKpJJ5tsuh0qWOoa7D3jIbAfA
 ixNVC/CJ4UstE5Cdksangf+O80TBdVzQCBmSRCRSG3RCjghuzkYO7QypV9yDeQOkgx4X
 P/+7la27HU769P7ioB7zw6jUorg9FePcVwGLcY+S68kgWZa8DZXn78wWKijX78m17x6y
 wN0XA/iJWnxQ+XHL7nXM5lvyI9GgXbhpJZaWpzldS15ZDbam6bC3YrYTfnmowUy2Drv7
 qWnMGNYSxwx1YhTihT/0KaNYdO/nyRDk4ce0Kt7+gu5f2k39kB3kq/UD56lWe3ja8qqL
 TneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787789816; x=1788394616;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=8p2rHBYqrxefb5oUWrNo+FfDfSqwUMnBeDunJut9THY=;
 b=pz+E6HMAL7+TRdPoinwUA6eZFxBl98t22QOgMjkx9oiyMbAKeHeMFpH/edAphFnjCp
 doTFZ6P86CFQnqiVYZzDnQDM2mK4EQ8LnW+Tv7nQmvXGuW9DDe11CrAMX8diNI9+8jHe
 1R5w8UE6VNNn+Nrgm7WsYeOrFHnyJygxzqgR9WUZUGbk+DDfo8We2mZAK2lXY0AXgMBy
 cvFg/GNfrF9CgrcONeqxlUIP+KHf/0UIC3gaasV3a4nV0/wXQATxFTGRVrgDZKjvtN2b
 Zn2Q1IJt4/ZBAuwreSrFaBn0JiidAoaqb0F5PfMo19qksw4QzQ3uwcUeGRKYd/LcRyZB
 FRJA==
X-Gm-Message-State: AFuF++mdIC8REnOVKP+u3JXL4NfGPGdrgDdcllPN4IcsJHyki3d0S/hb
 k6SwAiLFo3wOR6nxEGwuScMi3jQMqV0t2n0bBijtO2XgTMvRxDz76hCeA4dtF0o07uMCW56Qc63
 AWMhFoHlNkaboeGdRhhyFJ1OpX7pFD5IuLEYO/aWcrksNBnog/xqIJb5hHAUPuZg0liQxidMs+h
 5h01sG5hT8got6s9aAFb81FIKJfs0ab6IxLLHIEXe59/Dkuw==
X-Gm-Gg: AR+sD10tu4Ajh12gYqYPjVlqxM0U9rDvTsU7xU9y6dc7k4zO/mvmBtFDv4ZF58iVPDr
 f+dch+Wd8H05I84rRK5I4SFTybt4P7kVDbiVc6By+MLDBuJmeslawzwnNFzTGk7f45xjysWuRKa
 R9+c5ZP1zLYzbjqXJvxI9A028OeYiJ51IY1tXDxnIxLJu4IRiBWwvQ1QWxUw==
X-Received: by 2002:a53:cd11:0:b0:66c:bf45:bc0a with SMTP id
 956f58d0204a3-66d25666916mr3130436d50.11.1787789815865; 
 Wed, 26 Aug 2026 17:16:55 -0700 (PDT)
X-Received: by 2002:a53:cd11:0:b0:66c:bf45:bc0a with SMTP id
 956f58d0204a3-66d25666916mr3130419d50.11.1787789815399; Wed, 26 Aug 2026
 17:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAJM1RwPMXB8qLm4+4h_hBLqsq9=YBW_GndXroi5En4VGBVq-oA@mail.gmail.com>
 <20260826195843.GA3959812@bill-the-cat>
In-Reply-To: <20260826195843.GA3959812@bill-the-cat>
From: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 17:16:44 -0700
X-Gm-Features: AcwNN1WIYuCIqc0ev0BN1w50XwDBkmPNjY0HbOFJaRGR_THRsUCFDoW60nUqugI
Message-ID: <CAJM1RwNf4__=jf+1G8yGMsr42_gi0sJaos=WEBi3T9FbiwRA6w@mail.gmail.com>
Subject: Re: [SPL] ELF loader support - design discussion
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Content-Type: multipart/alternative; boundary="000000000000e15d120659fc4093"
X-Proofpoint-GUID: lVuYqQy95XX_u_CZO2aMUIv2wA5Xf_vK
X-Proofpoint-ORIG-GUID: lVuYqQy95XX_u_CZO2aMUIv2wA5Xf_vK
X-Authority-Analysis: v=2.4 cv=DsRmPm/+ c=1 sm=1 tr=0 ts=6a8f81f8 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=k-42gJp3AAAA:8 a=o7LuFKMD63xQu2NHcR8A:9 a=QEXdDO2ut3YA:10
 a=WFSIVGnu76LWaUlKG78A:9 a=PRKcepLAuR2n34U9:21 a=lqcHg5cX4UMA:10
 a=yHXA93iunegOHmWoMUFd:22 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDAwMSBTYWx0ZWRfX5z7LdWaMI5iA
 x1qHg4hHwT3IBIMTsfE3++7zLmqTkvu4UXCyI3/4fUU7jhgprodl+AqNPGteSE0ZpK6fIKlIwfW
 ggBg+KktqSedEHVoYYsoNV/PLAMj3q62au+KTTDf+WV0iAJDvS8DZMD7Po3v2tt47k5WIOOzcSJ
 jDqrL2udemoTOfPeuqAm2LNnQsHTOk6GwuTHeRcadO1EDJ39EGfPHWLWnO5TFHL4Nwg2yE1iyv2
 D3H/2Fls+ks6l4I4fiVkcUYwB6KyMKP1cu/kQbZ13HFNS0Pg6AA9YcIMRdqGP5m7iNAe6vGnA/D
 6HdfpmKbUi+XY8q7ddOOyeYI6IQhLr86fTvuNjl7VFhAxy46BQlpxZXguHTZRQmtAZfXdUizcO5
 4sPUQqhXRg+ztnZ8zCVe0hGM0u6OuWsbq9R3P7d3nAh3ReRtyclYC4XMMCG0iqL7k/yXlBlh+Qq
 erVSCD90q9j/ciQNzTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDAwMSBTYWx0ZWRfX2RzmBFrV4JCD
 +I48TZhljRyq1W9TZCPPC7Dow4p09/68fDGve9qwsigqDS7yyDVEg0jRnAiV4R3DwavJGg3mm60
 f+9Tf5WHB0vTscM/+vWxveuH5Hao2fM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270001
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

--000000000000e15d120659fc4093
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you, Tom, for the quick response.


Yes, I understand that SPL Falcon mode is intended to boot Linux, and that
actually aligns well with our requirements. Our plan is to use SPL as a
lightweight secure bootloader that loads a set of images and performs some
platform-specific initialization before handing off to Linux. At this time,
we are not planning to include U-Boot proper or any additional boot stage
in between.


Regarding FIT, I understand that it places image contents at their required
load addresses, but that is not really the problem we are trying to solve.
From our perspective, particularly from a secure boot standpoint, ELF is
deeply integrated into our platform architecture, tooling, signing process,
and secure boot model. Our entire ecosystem is built around ELF. Having
said that, Elf provides us many benefits that suit our secure boot model.

As we move toward U-Boot, we would like the transition to be gradual, since
we do not want to disrupt the existing ecosystem all at once. We are
therefore trying to take small, incremental steps.

Thanks,
Urvashi

On Wed, Aug 26, 2026 at 12:58=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:

> On Wed, Aug 26, 2026 at 11:56:36AM -0700, Urvashi Sharma wrote:
>
> > Hi Everyone,
> >
> > Hope you all are doing well.
> >
> > I'm working on a use case that requires booting via SPL in Falcon Mode,
> > where SPL is the natural choice given its minimal footprint. Our board
> > specifically needs to load an ELF image from storage (e.g., MMC/NAND/SP=
I)
> > directly into memory as part of this boot flow.
>
> Note that "Falcon Mode" is specifically SPL boots Linux. So please
> explain your use case a bit more, so we can help.
>
> > U-Boot already provides the bootelf shell command for working with ELF
> > binaries: it parses an ELF image, maps each segment to its linked
> address,
> > and jumps to the entry point. However, bootelf assumes the ELF is alrea=
dy
> > resident in memory - it does not read from storage itself. This differs
> > from the existing SPL image loading methods (MMC, NAND, SPI, etc.), whi=
ch
> > combine storage access with image parsing in a single step. Since the F=
IT
> > and legacy image formats also don't meet our needs, there is currently =
no
> > existing SPL loader path that can take an ELF image from storage into
> > memory.
> >
> > To close this gap, I'm planning to implement a new ELF loader within SP=
L,
> > built on the existing spl_image_loader framework (registered via
> > SPL_LOAD_IMAGE_METHOD) that already lets board/SoC vendors plug in thei=
r
> > own storage-aware image-loading implementations.
> >
> > Since this would be a significant effort, I wanted to check with the
> > community before proceeding - has anyone worked on something similar, o=
r
> > have any suggestions/concerns I should consider?
>
> The SPL frameworks, generally speaking, are around ${content} from
> ${location} and then executing it. So at the high level, you should just
> be needing to add "validate and execute ELF". But the baseline
> requirement is to explain why you have an ELF and aren't just reading /
> executing something in say a FIT image already.
>
> --
> Tom
>

--000000000000e15d120659fc4093
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p style=3D"margin:0in;font-family:&quot;Segoe UI&quot;;fo=
nt-size:10.5pt">Thank you, Tom,
for the quick response.</p>

<p style=3D"margin:0in;font-family:&quot;Segoe UI&quot;"><span style=3D"fon=
t-size:11pt"><br>
</span><span style=3D"font-size:10.5pt">Yes, I understand that SPL Falcon m=
ode is
intended to boot Linux, and that actually aligns well with our requirements=
.
Our plan is to use SPL as a lightweight secure bootloader that loads a set =
of
images and performs some platform-specific initialization before handing of=
f to
Linux. At this time, we are not planning to include U-Boot proper or any
additional boot stage in between.</span></p>

<p style=3D"margin:0in;font-family:&quot;Segoe UI&quot;"><span style=3D"fon=
t-size:11pt"><br>
</span><span style=3D"font-size:10.5pt">Regarding FIT, I understand that it
places image contents at their required load addresses, but that is not rea=
lly
the problem we are trying to solve. From our perspective, particularly from=
 a
secure boot standpoint, ELF is deeply integrated into our platform
architecture, tooling, signing process, and secure boot model. Our entire
ecosystem is built around ELF. Having said that, Elf provides us many benef=
its
that suit our secure boot model.<br>
<br>
As we move toward U-Boot, we would like the transition to be gradual, since=
 we
do not want to disrupt the existing ecosystem all at once. We are therefore
trying to take small, incremental steps.<br>
<br>
Thanks,<br>
Urvashi</span></p></div><br><div class=3D"gmail_quote gmail_quote_container=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 26, 2026 at 12:58=E2=80=
=AFPM Tom Rini &lt;<a href=3D"mailto:trini@konsulko.com">trini@konsulko.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
On Wed, Aug 26, 2026 at 11:56:36AM -0700, Urvashi Sharma wrote:<br>
<br>
&gt; Hi Everyone,<br>
&gt; <br>
&gt; Hope you all are doing well.<br>
&gt; <br>
&gt; I&#39;m working on a use case that requires booting via SPL in Falcon =
Mode,<br>
&gt; where SPL is the natural choice given its minimal footprint. Our board=
<br>
&gt; specifically needs to load an ELF image from storage (e.g., MMC/NAND/S=
PI)<br>
&gt; directly into memory as part of this boot flow.<br>
<br>
Note that &quot;Falcon Mode&quot; is specifically SPL boots Linux. So pleas=
e<br>
explain your use case a bit more, so we can help.<br>
<br>
&gt; U-Boot already provides the bootelf shell command for working with ELF=
<br>
&gt; binaries: it parses an ELF image, maps each segment to its linked addr=
ess,<br>
&gt; and jumps to the entry point. However, bootelf assumes the ELF is alre=
ady<br>
&gt; resident in memory - it does not read from storage itself. This differ=
s<br>
&gt; from the existing SPL image loading methods (MMC, NAND, SPI, etc.), wh=
ich<br>
&gt; combine storage access with image parsing in a single step. Since the =
FIT<br>
&gt; and legacy image formats also don&#39;t meet our needs, there is curre=
ntly no<br>
&gt; existing SPL loader path that can take an ELF image from storage into<=
br>
&gt; memory.<br>
&gt; <br>
&gt; To close this gap, I&#39;m planning to implement a new ELF loader with=
in SPL,<br>
&gt; built on the existing spl_image_loader framework (registered via<br>
&gt; SPL_LOAD_IMAGE_METHOD) that already lets board/SoC vendors plug in the=
ir<br>
&gt; own storage-aware image-loading implementations.<br>
&gt; <br>
&gt; Since this would be a significant effort, I wanted to check with the<b=
r>
&gt; community before proceeding - has anyone worked on something similar, =
or<br>
&gt; have any suggestions/concerns I should consider?<br>
<br>
The SPL frameworks, generally speaking, are around ${content} from<br>
${location} and then executing it. So at the high level, you should just<br=
>
be needing to add &quot;validate and execute ELF&quot;. But the baseline<br=
>
requirement is to explain why you have an ELF and aren&#39;t just reading /=
<br>
executing something in say a FIT image already.<br>
<br>
-- <br>
Tom<br>
</blockquote></div>

--000000000000e15d120659fc4093--
