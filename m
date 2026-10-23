Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B77F606A31D
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jX9lL2LJ;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=agnbDm9F
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4FB98116A;
	Fri, 23 Oct 2026 08:49:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MAsEjn0OEhxc; Fri, 23 Oct 2026 08:49:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 84C0380D64
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792745366;
	b=oaz7b4fMv7/WPkA5Zk9+qYzTwrXrul0GyiSlqSWqwlonmamDrIZlGMH6KJg72vhpQRO3
	 yhCn/GSmxNOoUHNjJYhWebirq9Q0/cYNSCvxyUqK5zgR9WS8LRLiAyxdUxisIqOqc+EOx
	 DzCcd8xE1f0nAD0LSE0n/j/wSyGquop7OsfF6SZ3UPzmMQjdVCm5udcgd5GUW6NvtFpjO
	 /t26pPeJoGOMdYnLWxf/jU85KCw5rKUnV0MDdFX6+7L5egrB3EkBc83EaOJD0UYbC+l3b
	 hMmj2VETKRlEJdwbREylDmqnV1IB7wABf9VVTfWv8W0jmF8FAAVQtxH/T6kFcl/XRcA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792745366;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=X+fC4Kq1BHCC5x4bImvHTTg4ULT9ZytB7RQlkwBwbLk=;
	b=es71S1M6AtP7HWUIlPv2gQvRpVJdYOffZiMnlVOo0FgEQ3LdJZLGQudHKsMRIqMG9Me+
	 2vy5k+AbbEdB07/jMnEQx3/FixXO7otx40rdrMFaPurfh2kNpztr+7VMtdm3E+gpwbFu8
	 1mTL/+k6rcysrpF/BG6+BObTN4/lgzB+OZwVaQzUtXL/TQOk/yKG8zM1k8igpDGfosOBn
	 xD42p9is6A64NbDiSxu0rU58ZKT+bbX56BELG6cH7eCVNJi3OEHTVvDjm8bha2LawE5Ym
	 c68QAJgd3s28uxR2RNX1JLYHR61XOVvilyqvx3iu+JozmOcdQtzXOU2rDa35kffHSaw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=agnbDm9F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792745366;
	bh=X+fC4Kq1BHCC5x4bImvHTTg4ULT9ZytB7RQlkwBwbLk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jX9lL2LJnIsDUYCc+9R94soQcsv2DkrnN2vru1lPApMZMOHohJhjPgOZFRKqmdJmH
	 7njFeAaZof+gBtR8X1yKr761I4YZ8WnaPRl6qSLNvwWwADZaJt/PovVzU9QTaT20VP
	 23uRktmzAGhl+MGiw70m1JUKbu/IlG0J6zV1p8083XMbDWQ+MlbXUR/8XptLgZ/S1Y
	 GcE9GhKJKQJ6D/79yLfnnNvuqRiC4xwXNQZ0MYpz9Fa42JT9qHcRuYF0EpITh/uHmp
	 +nesTgUwkwJgfzvz1abooB6ZkraVyR2i/mPnKu9LMlsld1COvBLQfDdH4GUKKl4Nc8
	 nVCuHTmwu9xlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84C0380D64;
	Fri, 23 Oct 2026 08:49:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 004B21FC8
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:49:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E55E580D64
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:49:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d7Orw-E8hH3Z for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 08:49:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 91F1280D4A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::632"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792745365;
 b=ghDg5mr7NBxYeblT2+qALnrSI1SHiIQuVrMG54nNZqz4atksUIdqMNH5AkO7SkfHI+TT
 RT6cdf5llswXPQF1FHyOsdgzDzHXUAHcKs4dwlSGdXIAGlEFMY0Cevpgk7itZHtBsxiir
 tTQB87faSaRSQjussEC2bylGM3vDN7IhUMoWpSwFNv7/SvfV1/XcgOA+sG5TxDx2myux2
 Ve/AD1NOuFxeR4dhAc7g/k7CEguzpH4da2y7b0kGaZnOapqh+jVwEeHU957v3ZF3YmBxs
 Aldl9iy4tK5Je2jE2BFEj91HxLpDy9RYd4Ge3dSVNfYKLG57rOnwSYABQzBk19gLpGw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792745365;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=X+fC4Kq1BHCC5x4bImvHTTg4ULT9ZytB7RQlkwBwbLk=;
 b=jLAPMIKRQDg8KDTthxbNNHfhwbPkR+iWZ13UilqhQ0mY8tzEV8+hcn19PmC6gtE0tWKf
 DnUfkzaqNXfLkUTShrPiYmuCBbYeEMLqOANOgw1TELiJET58onhaRW7notrJ6GU4ELdr9
 ga2pEtvEadeuAaMxMwNcH3tKvf6weySu21NLVX18pm/alLJP255ST/hifXbsujYeEgQis
 Zpn01k4TO+9vddoKvALDuyr05Qe7O4V5oh9TgRMmzU9vH6vyEaU8Ad+CidvVWaQwqQK4U
 4OctIoWn4SK8ZQ0ja9mGL9At4HZJ46U/g7oOjp/qZVr5ZDmhgx493w4SdyhPc3sEx1Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=agnbDm9F; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::632"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=agnbDm9F
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 91F1280D4A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 08:49:24 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so284119666b.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 01:49:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792745362; cv=none;
 d=google.com; s=arc-20260327;
 b=OKX89RdLdA6gsGXqeXw75egdhAJXDIT9Nj7p1ZrNIHYlo1P19iYGaYRllfXdAroVZR
 51/pFHoZSqHsqpmLDzPRs/UaFmYbcMX3PU/dWy0DhEmCBDaQdJtYd5cnO6QDTKiUUAKq
 SklgAcFxza9P+R7ZB2qqeDj0lBc+yRAgAiemT66IZGrDkgIygThg78o5vCT8yaDObuZj
 Hg04t11EhOTksQ+h7mCTHp+6EXAtWGcZTOWl/x4VqZSBT8Qvqdj8Nh33YWlycbFA4aCx
 TUYFkoe6F0lW5hQa3QtoymDVGITiRDV4KcL2v1xyjYLO7Bv/dGQV0+SW+UyS+doiYv/1
 W34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=X+fC4Kq1BHCC5x4bImvHTTg4ULT9ZytB7RQlkwBwbLk=;
 fh=wq2UE3tCXEkV2lEDJbt8MFf3meg/Qj3JXO0aufXh2SI=;
 b=U8fxgzzace+7giHRyMGZmBagIqNzVzoxeSN1pW8dVKj/7XWpgQ5a7OVd1X7mWCpIyt
 hFjdpqWr+O/fGD/4G4T3epavVtZNgufh53y8sDLYUcZa6d+77j7qaT/qc87Ba9/IwzRE
 d6qNft2TyOOPkkJfw2T4FkwI6U7ZMIJZ2unQwar5zpNs3hZji90W0Lftl75HNs4qtr/B
 92vuN7XCF6VYyNPWFGr4lX4Ko/bGrh4p0PolZZZiA/nVIx+voNVprWFC5E+DIvy9KMa7
 WXdmK3AH1CjnP1I9ZL3OewJXqQzo4YFvq9qxpNVhqSZdblX03tjFjwwBsfcKgtGdLn0/
 y5JQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1792745362; x=1793350162;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X+fC4Kq1BHCC5x4bImvHTTg4ULT9ZytB7RQlkwBwbLk=;
 b=agnbDm9FGokx0wVbKHv+K6L+vSIU/uqudgVh5FfIXr1HFFQTj4SjqODBjBj3lqkHQW
 +eSGa0dSF/zQYyOfIVpJTTuAOrRG6mvzkIQ5hiiJ5+hl7S58W0cZpgMNVBcdiPuwdEIz
 /79pSvJ6jS85DDOJVCYm1ZhFksm9nALbbn29uZaH46Ibfd0cdLfIW7clrIVIxo23JtF0
 BwZdSoO2kzaB5vbvMiyIEn+kD7fiMJ7amA9zUGXW45S48u96DHHdfBc9dJvkbY7CmoUp
 AEbPrdmWSsCKc8RTreUuMq+mYJaPpqzrfDAR6ROPyu7tl7bNv70GKM5pKwXyCVo2EMAL
 b7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792745362; x=1793350162;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X+fC4Kq1BHCC5x4bImvHTTg4ULT9ZytB7RQlkwBwbLk=;
 b=J8/KrB4YT4NsEx689rlKn0iROcdHnxFp85H2whUIROt3ZjuZXRDtCgHIquAORXJTSj
 nZLaq6pIuHwVwzwYFcpx44vkG/p+kiGbQ8u49hrnmODZuHQKfH3dh+7X2iJv5tjory0Y
 9XPWF/u91VMAXhb8zU3vmDhXLJKcMCUTUs/IBXiQqjwUGmtZGARRRzFOB8vR6IAEX11A
 P9fgpj+lKZivdhje3C3pv85g1QJJDQqKTGV7Ehph61rFaSQsi/FRcNaXkTu4MxljW2wQ
 U+sj5LyoMH+9bwfp7JrQS+dvES79BbR1urSZjWAQSSE1OslM/+4xf/roAjLC3K8kVRqy
 hw7w==
X-Gm-Message-State: AFq9FYKrf4PeEoTAoUF9AjaCRxce2v6xMtxDNi6j/LzUAvIFsAfqeuYr
 8HLDPjIWJI2/H2WUt8q3BUtIspSVEgP8OcsNsOazwGx8cG2fvtTdXP/W7uDJ8+k3ycARDDvUtYY
 4yI995jAiQW5YMuf4uR8SS2hkaFssij6dwTe3NHRLy4kp+hV3WPo/ezSS9zEx
X-Gm-Gg: AYBFou02vnQ1kb3G+4056y427G1UEI1OSblKCPhpXJaxVRw7GTVwJrvblXoTZMNuDtx
 uJWyiHgVRd4G9mSoXtA4ZP7yYttAHeAmBIAcenZiyxabgrc85ZMD4nRus00/IuboI4qpxPa3myX
 81AFV3Hcl/kMoCnn0L3ICnu2rghwIu7OV7pXNNlY1ZoTcO2DX7apHAqgflLMIAgkJPT8IpCydkK
 PtVhGHree04EqVLeQSjIarNW5fjoEgbu6+UXGOiZ3rVk6+4fSJ8lAV5cS5Z17L1O+I1hDk89J84
 EcJDPyIlSVcprjCFwYKJUQbSP2bpUBZitgjPOrAOuPcIbnaCoAsXEippWuZG+5PZByK1agNxqu6
 tALzFTPkmHpASay9DapK5arLBcVskvYXf7Vv6vop5oGcd6cf+YRu0fyhAoDnHyvpmCn/BaPQ=
X-Received: by 2002:a17:907:d1b:b0:c2e:62af:b6fe with SMTP id
 a640c23a62f3a-c46a909e888mr232130766b.8.1792745361757; Fri, 23 Oct 2026
 01:49:21 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-22-6647aa23ade5@flipper.net>
 <7a91e605-33b0-4f4f-9789-d10be821d0cc@kwiboo.se>
 <CAKTNdwG22u_51cBLbu3wufBdB9ojSQqGMPMG58x-Nk7u_xC6sg@mail.gmail.com>
 <a451ef1e-abb6-453c-b146-90d64f24f5ab@kwiboo.se>
 <CAKTNdwHMW4HyfhSWkT241URB4H6JMg1MCt1-VOcUsufgm=So=g@mail.gmail.com>
 <322a4e95-2c3d-4a84-8b57-3b078f9ffcde@kwiboo.se>
In-Reply-To: <322a4e95-2c3d-4a84-8b57-3b078f9ffcde@kwiboo.se>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 23 Oct 2026 12:49:13 +0400
X-Gm-Features: AclHuK8gaPITCVN3kDWWodoLHyj4tD8njWhikCu7FUkIQ_D1ESt6MWgFW6dkYOI
Message-ID: <CAKTNdwFRA58G1JUBJR_A1aZY_-B1vTZmnJujHnsLnEaQVg1dwA@mail.gmail.com>
Subject: Re: [PATCH v3 22/23] rockchip: generic-rk3576: Compress U-Boot proper
 with zstd
To: Jonas Karlman <jonas@kwiboo.se>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On Fri, Oct 23, 2026 at 12:00=E2=80=AFAM Jonas Karlman <jonas@kwiboo.se> wr=
ote:
>
> Hi Alexey,
>
> On 10/21/2026 6:17 AM, Alexey Charkov wrote:
> > On Tue, Oct 20, 2026 at 10:41=E2=80=AFPM Jonas Karlman <jonas@kwiboo.se=
> wrote:
> >>
> >> Hi Alexey,
> >>
> >> On 10/20/2026 8:01 PM, Alexey Charkov wrote:
> >>> Hi Jonas,
> >>>
> >>> On Tue, Oct 20, 2026 at 9:47=E2=80=AFPM Jonas Karlman <jonas@kwiboo.s=
e> wrote:
> >>>>
> >>>> Hi Alexey,
> >>>>
> >>>> On 10/20/2026 6:41 PM, Alexey Charkov wrote:
> >>>>> No in-tree board picks a compression for U-Boot proper, so CI never
> >>>>> builds the compressed path of the Rockchip FIT, nor links zstd into=
 an
> >>>>> arm64 SPL.
> >>>>>
> >>>>> Turn it on for the generic RK3576 image, at the highest level, whic=
h
> >>>>> shrinks the payload from 690KB to 296KB. The image is meant to boot=
 from
> >>>>> whatever medium the board has, so this suits it, and its SPL heap a=
nd
> >>>>> SYS_LOAD_ADDR already leave the decompressor room to work.
> >>>>>
> >>>>> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> >>>>> ---
> >>>>>  configs/generic-rk3576_defconfig | 2 ++
> >>>>>  1 file changed, 2 insertions(+)
> >>>>>
> >>>>> diff --git a/configs/generic-rk3576_defconfig b/configs/generic-rk3=
576_defconfig
> >>>>> index 5e25653820c2..dec4364876b6 100644
> >>>>> --- a/configs/generic-rk3576_defconfig
> >>>>> +++ b/configs/generic-rk3576_defconfig
> >>>>> @@ -9,6 +9,8 @@ CONFIG_DEBUG_UART_BASE=3D0x2AD40000
> >>>>>  CONFIG_DEBUG_UART_CLOCK=3D24000000
> >>>>>  CONFIG_DEBUG_UART=3Dy
> >>>>>  # CONFIG_BOOTMETH_VBE is not set
> >>>>> +CONFIG_SPL_FIT_UBOOT_COMP_ZSTD=3Dy
> >>>>> +CONFIG_SPL_FIT_UBOOT_COMP_LEVEL=3D19
> >>>>
> >>>> I do not like this, it breaks consistency with the other RK generic
> >>>> targets, which are meant to be as lean and bare minimum as possible,=
 not
> >>>> a playground for testing features, we have sandbox for that ;-)
> >>>>
> >>>> Please enable this feature on a real target, not a target meant for
> >>>> basic board bring up and recovery.
> >>>
> >>> It is in fact quite helpful for recovery workflows, because it
> >>> massively reduces the size of the maskrom 0x472 payload, which as you
> >>> are well aware is quite a thorn in the backside, given the boot ROM
> >>> peculiarities. My reasoning is that the generic board build will be
> >>> much more likely used over maskrom than flashed to storage, unlike al=
l
> >>> the other targets, so enabling compression here is pretty much a
> >>> no-regret move. As long as it works, of course, but that's what we
> >>> have tests for (and CI).
> >>
> >> The generic targets are likely used written to storage much more than
> >> recovery or loaded from maskrom, they are typically used by Openwrt an=
d
> >> Armbian for new board targets until proper board support has landed in
> >> upstream Linux and U-Boot.
> >>
> >> I can understand the idea and may possible have been on-board if all R=
K
> >> generic targets were changed and tested. The inconsistency among the
> >> targets are my biggest concern, secondary that this adds more code tha=
t
> >> potentially can fail during runtime.
> >
> > I could enable this on other generic targets, too, but my sample only
> > includes an embarrassing number of different RK3576 boards and not
> > other SoC versions, so testing it directly is a challenge for me.
>
> I would likely NAK any change to enable new Kconfig options on any or
> all RK generic targets. Please see the generic RK targets as a superset
> of bare minimum required to boot a board, nothing more or less. If your
> dedicated board target fails to boot the generic target should continue
> to have a high chance of working on same board.
>
> >
> > On the potential failures - true, but see my point above regarding
> > tests, which I believe still stands :)
> >
> > I'm not particularly attached to enabling the option on the generic
> > board specifically; I just thought it could help people since it helps
> > my use cases.
>
> Sorry, the generic RK targets are not the correct target for this (or
> other) nice to have feature, they should only include the very bare
> minimum options required to boot.
>
> If these options where enabled at SoC level I would likely not have
> cared as much or at all as I typically value consistency above function.

Understood, and fair enough. Let's consider this patch retracted.

> >> I added these generic targets to have safe and proven defaults, becaus=
e
> >> the evb targets that typically could be used for similar purposes
> >> started to grew in features, and I really do not want the same thing
> >> happen to these targets. Boot speed for the generic targets is also
> >> not a priority.
> >>
> >>> FWIW, I'm also using Zstd decompression in SPL on the Flipper One wit=
h
> >>> Falcon payloads, but it's not upstream yet.
> >>
> >> Maybe you can add one of the rk3576-evb boards as a target in mean tim=
e
> >> and test on such target?
> >
> > I ran this code on a RK3576 EVB1, too. Maybe it's time to upstream its
> > defconfig after all. Along with my local patch patch moving the
> > SYS_LOAD_ADDR to a less overlapping location across existing RK3576
> > boards.
>
> Sounds good, please upstream support for your evaluation board, it
> should be a perfect target for testing new Kconfig options due to its
> intended purpose. I do not have access to any RK evaluation boards,
> otherwise support already would have been upstream ;-)
>
> If SYS_LOAD_ADDR needs to change on RK3576, it likely also should be
> changed on other RK SoC targets that use ROCKCHIP_COMMON_STACK_ADDR=3Dy.

Could you please have a look at [1] for RK3576?

I can draft a similar change for other SoCs to the best of my
understanding of their respective memory layouts, but I won't be able
to test them on real hardware unfortunately. Would you be open to
testing an RFC patch series to that effect on your extensive
collection of everything Rockchip-y? :)

[1] https://lore.kernel.org/u-boot/20261021-rk3576-load-addr-v1-1-2b38b3904=
4ac@flipper.net/

Best regards,
Alexey
