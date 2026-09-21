Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D312C982E6
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 16:51:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E65860749;
	Mon, 21 Sep 2026 16:51:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 795MYEJLvf7O; Mon, 21 Sep 2026 16:51:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DBE1660738
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790009507;
	b=RwP9/GZ4AO/znBvpxpm0y69KoPY+ZkBB5zA+ETUZHqSLk6lYcIy5bfDJClOQMKsBrQkQ
	 J35z3j9H1vuQBVb1DmOx2opnlchbTQCJ7W52r9609+RMmLp3TWB7OKoa9IXUUx4CzLD5k
	 FxpZSZjSzx/54IMOV26utx8ca37qfodbSx7USrzBJQLLLCSurpXM+bND1jkLptcXVyLDA
	 U2YnuAW36cRD8mpYwi/bVun/L2TSLDiodlbuQtr++gxDpCvvoJyyHdHubI7109SeQzskA
	 pHaJB4OMqPdD+HC8IVNbybGouGWH4kXKUI+8lTMGo0guG2L1aJUmrQDclmwXS+9CSaA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790009507;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=qo8VLLXa+BL6TBvs5YKsNjyxo6pvnhsa3QQA42K1Ps4=;
	b=Wj0Mq716xeZU8VtOEXDHUnPHdwHLKY5ScTSa1ZTp1XQW1jnvVdYUV45U+6k87FiDXZ51
	 RBnGbbIp4Wk4a0UVQSEhAX6A44b8nfSi3Rw4CQJKnv4SZZF42pHLY5KUlrhEIplH2i95Y
	 6z0KjKZ0ZKS5H1+fZ20fao+ECMw1hxLUjELWGez5TkMJjT7e4TzbX0M46m6mqJ18Bl4tV
	 1NgS5RkGauvdxw43zK5yFj0Bap1S0Qy8L+UymBSVzmoSVCmGDUnYGudS9++pPinKxadI5
	 m7xBWbAYI8QVGCtTs0u5SfYGjKly4Hht9n11ggJNQ/6Og2ddawFOiWwUTkAnAjosaLQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790009507;
	bh=qo8VLLXa+BL6TBvs5YKsNjyxo6pvnhsa3QQA42K1Ps4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZTyT1o4XtYY/1Fdwqfc+lK6R11Vly0tuui8S3wHMC1EuV7CHQFtaki0fa8igfyy1s
	 VJFi7guX0ofyPgOp2rL1xo+9BYSlGJORU4V9zSmDn5xK7CwoAN/HpI4NSJjEnS03Qa
	 6VywFSIefDcM4jF6aUcy+1jDb4v5pXZ0HsPSf/u3gcxdmQQgjAJFSwnez/6Tyw5Z4G
	 mGebjsbFWrk8eJxCDBQDK7LUcnyzb0yArudW0l9PxV81mfR1wGhzeWRpG6M1wbF2HR
	 qsj6b+9MeAReTvCGL3j8OCIrsvRWj8L5CtaYHdbL5BoSuz0D4Au+RPx/te1nyE5Ve2
	 Z76iYqiKcuyaQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DBE1660738;
	Mon, 21 Sep 2026 16:51:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0EA8D224
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:51:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D6B3540AD9
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:51:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PNI2gBuX67dq for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 16:51:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3C50040AA4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790009503;
 b=bbO4uGeFY0B4qKSDgz2g0SpPgHgvS+kNXD9pJtbXgKDPcjezOJN4YEzgPfa3SX1+funA
 cPkxNZ+ec2fJOMy8rP3LWBLaTr+up+dZlhH10oxAESDfj3c+oKlkweX1UjP+CdqF7iMLF
 D0KGsMBlZmvvIUWbAlF0NNaufYY54khpjGyTWxMpcBRxB48FqJjCG/2S8je6xr47hGIQW
 i38r5ELuzz4sFv1YD1zeT/p2qS4PZoVqVNQuVobyttOiG59ZnNzVo589acX6snZtl00Va
 CiKRAQc3oDFCxzbmQYDUtmhG5gehBoCKaJkSgQ3T6AaafVDcf5ASpgrADH+q/nOdX3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790009503;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=qo8VLLXa+BL6TBvs5YKsNjyxo6pvnhsa3QQA42K1Ps4=;
 b=fYkl98umpPEj1Aze2RQ4x6rk9FGwojGQ2lUWd1T+rUV4vtgczPuClIhrmJVGATox0Y4C
 x4GRD9PdrqTCnmrV89ddCW+eXSFQ0DzIAVr5R4WpH5U3DtfFerHMKn49qtelO9cL6TEmO
 vrdBkIDjRKlUoz9eonQEHflBVwcEE1vjY53+TnP6IMf1xAENA+ciW0qabRjm3M7t1G3rC
 RivLluS0X7X4Mu/iaG9MQSbagUdjwFQa1WcknU27xCOHUf2cBGk/UQyaDZ5i6bMZ8MBOq
 EgRBDPqMleyKyQtMt8Qaz3Wv095PluMxVgN/Fpj17Nb7zcLIdrgUfQc91xdmmyW/2gQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=iH5OBkVh; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::f;
 helo=mail-ej2-x0f.google.com; envelope-from=massimo.pegorer@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=iH5OBkVh
Received: from mail-ej2-x0f.google.com (mail-ej2-x0f.google.com
 [IPv6:2a00:1450:4864:34::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3C50040AA4
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:51:42 +0000 (UTC)
Received: by mail-ej2-x0f.google.com with SMTP id
 a640c23a62f3a-c264788fd58so493978666b.1
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 09:51:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790009501; cv=none;
 d=google.com; s=arc-20260327;
 b=acOThnQAu1m9GIDR6Zf0n1DA5RRw/kgn9Tkd6EaRaFs7L6aIWlvCwqRY5rCQ+Dx1ss
 6WOZOAgjBeSWyNGpFJjKWTlPGvr/dRYtIriKAd3VrNNlciZ4s//dkD3CRB/t9Z+An6JC
 mmcxw1shGmKXWpfI3zgTBhXrR0Pn3kcwoApSFWLfbT87pkwb0Qoyelb/wHcVd9c3iu1s
 mVcITqyXzxF8i3ChrQohulKabiyXB1GEG9vO8IKMrlF3FffO/IbsBa6L6HfHcR012sqT
 5taQhzvy6Qbr9X01jExoIcxBXhBBYFGy0rNGqJMvxRM6jbd8etmWV/lRL873XDx1JQYp
 GTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qo8VLLXa+BL6TBvs5YKsNjyxo6pvnhsa3QQA42K1Ps4=;
 fh=5zKhfm8AItR00PhJFfnGtz4UvZQJrNQMecpb7cmtyuk=;
 b=KVRocDEPyox9RGXto7XDExV8Lamqwq5+/eCdMJzmD1X7ok112jr3prekeqjUsO+fNy
 SFPNr15gMsS2c484gT4Gb7KiK4LxD+Ui3qkS7v0mDzMOx7rNGDfXJzREAARMGDncwnqo
 P0dxvHspRYB2U9QksWnG/ScIwi5Ivcp0Bdki1dXjVAJabH9JOuzKg4XJR9XJvM0Q4HaO
 RMVki8iqXYa8jqEZQs3rf9Nnz27mN0MCesrFLoA7ESpJVsnoZidAcTZGGKM2H1Flgpjn
 Fv1jZgeUo58AhZ80MSYZyWHbz6UJgtfn83/f02Oz+Bs0oHp12dGQdI2uzj7CzdbgUKvy
 t8Fw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790009501; x=1790614301;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qo8VLLXa+BL6TBvs5YKsNjyxo6pvnhsa3QQA42K1Ps4=;
 b=iH5OBkVhb1l6otH6EeQa9OS74Tq3AvwHUoC9kJj7U5E4Gd4vaDANw1WkQQ+c9IkYyK
 XI/jJHlIkFupcQI2JPsyfDykOyy6JGmBi7baGvL/wCAYY5oDBiiRqatvLQMv07wM425k
 vfwBQZBqZctVNw6Fqwp69Y2PonrxZst5InW+AFQO4waHCfrmSMhhsuQpyE750MWmU4S0
 u1K4uJEnxaQKpZbkvzN64GTFhVqHTEsNRVaZ/X71reD7I+ZVzHlM9XHBXrl7mL2dPBha
 +GyrP+2JGZzTJUYzQpJGtLMNBUkX6uppv3OlHLDH5O6+bP1Rn+2YuOfN7layB7dNf1qR
 JrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790009501; x=1790614301;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qo8VLLXa+BL6TBvs5YKsNjyxo6pvnhsa3QQA42K1Ps4=;
 b=ZXWe6VDp66GU+n0UsaQ2L2bniEqsEFyjh8RLhLiYuFQIQFcpZ5Y0aOD4ubcCUVPbSv
 yLYfOXp9e7Ysiv1bYMnpEGSx47RPBu629srHCV4lVRRKGG1eDQEGVc+2wC22uLlTDJP1
 hmk4pmp9bxfm7IRnQaJW4bR/03mCSlkXL4K6mEvzhUSOxK7YBlp7k1SiSaAP+KaNhAbZ
 cdiQjCTiL2ENt8dLrD0ovH6A22iiupo//nPWZmxmOR9MZSKpS8A6mrfvTLFCClrPG7wB
 PeOe7CEJBhwzEMhIOU2HBR6WkNH603ukNCQcqJuQDdik06ZQ9WIa1HrPRw5sNfYlZP61
 4h3A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBMRMLiRcemKk7q61k8dV8ZIst2ebVC+WDjGKeAwYdUb3bfSulb3StnYvpNb1j4bWTZ7Swvgc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++la2LNPHb+QMrJQBg9istKSiBJbKuH1/ywvTBRsuGZP+ke4qn8S
 Z31QBqmXX3ceIT8WvcQhJ7EQiPsZNFV1ZOwbLgX3xYrlfiu7ZwSCb+/DIRowPTF1D81cUN0zmvb
 Va68cxAtsp1Ce7fpO7CZWGcn7qkhGRCA=
X-Gm-Gg: AYBFou3xVM9Eij4TIX0LsOZKB3qyQgeAzmM1MlNXmuG5VpJFkmd2cFZWc1t0dHV57Mt
 nKIF34n3ZlAt6o39Vnz4jmzTpXDKfSIiRT3sVKEdtaegODkYAJXYT2MZoOsQYhjllQj6IahNwM1
 MUDWrf3gAAs+5ZbRsNKV6+LOBfChyQlajTHQy8PLAhF1uCxg3HfUNf6V7jTYA13pkVD6OAw59fp
 WAjGsTP3V1C0wn+P6341hhhAqvh3jRZeCTlfAm+Br7cwrFNWET9ES4mvYEvJ3AKiYt4i/8k09uo
 i6UvDFVcSmizjvtrJfi/tBMNTBkAfhAyYIj5zm+LPow5KbEm5wFS41MtqEHWX0Ozcw0=
X-Received: by 2002:a17:907:c60e:20b0:c2a:8621:a9ec with SMTP id
 a640c23a62f3a-c2a8621acc5mr118069966b.17.1790009500793; Mon, 21 Sep 2026
 09:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260920-reset-v1-0-42820216369f@gmail.com>
 <ad7869e9-d7ee-4130-b924-ebcf9719b93a@kwiboo.se>
In-Reply-To: <ad7869e9-d7ee-4130-b924-ebcf9719b93a@kwiboo.se>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Mon, 21 Sep 2026 18:51:29 +0200
X-Gm-Features: AcwNN1W7lSzBiuUyJwITZaMZ4pmCTCe9gltXaeT3PVr3Pu9LNM0to8ebwPZ8-sI
Message-ID: <CAC928HZ1x8vM+cQ7BoLEu5EuKzeHCcjMnsCvBugvf+24O4te=w@mail.gmail.com>
Subject: Re: [PATCH RFC 00/11] rockchip: SoC info and reset cause printouts
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <u-boot@0leil.net>, Tom Rini <trini@konsulko.com>, 
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Jonas,

Il giorno dom 20 set 2026 alle ore 17:49 Jonas Karlman
<jonas@kwiboo.se> ha scritto:
>
> Hi Massimo,
>
> On 9/20/2026 4:15 PM, Massimo Pegorer wrote:
> > Looking to provide a way to print reset cause on a board equipped with
> > a PX30 SoC I ran into the following existing issues related to Rockchip
> > SoCs:
> >
> > 1. It is not possible to select DISPLAY_CPUINFO configuration option
> >    with ARCH_ROCKCHIP, except for RK3399 RK3288 RK3568 RK3588 SoCs, due
> >    to incomplete definition of type 'struct rockchip_cru' caused by
> >    Rockchip common implementation of print_cpuinfo() function: see
> >    0f9872c4db11 for the RK3588 SoC "workaround", which I feel not
> >    optimal. Note that DISPLAY_CPUINFO has default y if ARM; therefore,
> >    it is deselected in each Rockchip defconfig except for listed SoCs.
> >
> > 2. It is not possible to deselect DISPLAY_CPUINFO configuration option
> >    with TARGET_ROC_PC_RK3399 due to missing get_reset_cause() symbol
> >    caused by mach-rockchip/Makefile skipping cpu-info.c. I do not see
> >    how e230c579a3f6 commit separated the reset cause from displaying
> >    cpuinfo as proposed.
>
> Please see the series "rockchip: Add and use rockchip_sysreset_bind()
> helper" [1] that already should resolve above issues.
>
> That series has some loose depends for a clean apply, but the idea is to
> fully move the resets status handling into the sysreset driver and start
> cleanup of 'struct rockchip_cru' use.
>
> Please try, review and possible build on top of that :-)

Thanks, I will. I missed it as I re-joined U-Boot mailing list just a month ago.

What's the status of that series? Is it going to be applied to u-boot/next?

Regards,
Massimo

>
> [1] https://patch.msgid.link/20260805174509.2968252-1-jonas@kwiboo.se/
>
> Regards,
> Jonas
>
> >
> > 3. For the most recent Rockchip SoCs (RK3588 RK3576 RK3568 RK3528 RK3506
> >    RK3308 PX30) the checkboard() function is implemented at mach level
> >    to print SoC information: it overrides the weak empty implementation
> >    called by show_board_info() when DISPLAY_BOARDINFO(_LATE) option is
> >    selected.
> >
> >    Most of the other machs do not provide a checkboard() implementation
> >    leaving symbol available for overriding at board level. I did not
> >    find any "regulatory" definition in the documentation, but SoC info
> >    sounds to me more related to CPUINFO than to BOARDINFO, and other
> >    machs approach in my opinion seems more consistent with the function
> >    and configuration option names (checkboard and DISPLAY_BOARDINFO).
> >    Moreover, this approach has the advantage of allowing each board to
> >    implement its own checkboard() if needed (other hooks exist for
> >    board specific printout, of course).
> >
> > 4. Implementation of get_reset_cause() cannot be common in Rockchip mach
> >    due to different CRU_GLB_RST_ST register definitions from SoC to SoC:
> >    RK3288 and RK3399 share the same one, but RK3568 and RK3588 ones have
> >    more bit flags defined (and not all of them seem mutually exclusive),
> >    and PX30 and RK3308 common one differs again having WDT and TSADC bit
> >    flags swapped.
> >
> > Here is my proposal, awaiting your comments and feedback:
> >
> > 1. Create a Rockchip common print_cpuinfo() suitable for any SoC/board,
> >    making possible DISPLAY_CPUINFO selection without build issues.
> >
> > 2. Avoid DISPLAY_CPUINFO deselection causes build issues for any board.
> >
> > 3. Make print_cpuinfo() to execute code that is currently in function
> >    named checkboard() at SoC level (if implemented), which prints more
> >    info than CONFIG_SYS_SOC. Of course, keep printing CONFIG_SYS_SOC if
> >    function is unavailable and on returning error.
> >
> > 4. Make print_cpuinfo() to execute code to get the SoC reset cause and
> >    to print its description if the reset cause is available.
> >
> > 5. Avoid DISPLAY_BOARDINFO(_LATE) printing the same SoC info now printed
> >    by DISPLAY_CPUINFO too: it seems redundant and quite misleading. This
> >    makes checkboard() implementation at Rockchip mach level unnecessary:
> >    remove it and leave the overriding option available for board level
> >    implementation if needed.
> >
> > 6. Select DISPLAY_CPUINFO in all Rockchip board configurations related
> >    to PX30 RK3308 and any RK35xx (all the SoCs that were providing a
> >    checkboard() implementation) that already have the DISPLAY_BOARDINFO
> >    and/or the DISPLAY_BOARDINFO_LATE option selected, to keep SoC info
> >    printout. BTW they are all of PX30 RK3308 and RK35xx board configs.
> >
> > The whole series has been built with buildman for all of the involved
> > board configurations, i.e. those related to PX30 RK3288 RK3308 RK3399
> > RK35xx.
> >
> > ---
> > Massimo Pegorer (11):
> >       arm: rockchip: include SoC-specific CRU header file
> >       rockchip: cru: move code from header to source file
> >       rockchip: cru: remove unnecessary common cru.h file
> >       rockchip: cru: improve and simplify reset cause handling
> >       arm: rockchip: support DISPLAY_CPUINFO on all Rockchip SoC
> >       arm: rockchip: unbind cpu-info.c from DISPLAY_CPUINFO
> >       arm: rockchip: print SoC detailed info with DISPLAY_CPUINFO
> >       arm: rockchip: print reset cause only when available
> >       arm: rockchip: do not print SoC info with DISPLAY_BOARDINFO
> >       configs: rockchip: resync Anbernic RG-DS with savedefconfig
> >       configs: rockchip: add DISPLAY_CPUINFO to keep SoC info print
> >
> >  arch/arm/include/asm/arch-rockchip/clock.h      | 11 +++++
> >  arch/arm/include/asm/arch-rockchip/cru.h        | 39 ----------------
> >  arch/arm/include/asm/arch-rockchip/cru_rk3399.h |  1 +
> >  arch/arm/mach-rockchip/Makefile                 |  2 +-
> >  arch/arm/mach-rockchip/cpu-info.c               | 61 ++++++++++++-------------
> >  arch/arm/mach-rockchip/px30/px30.c              | 12 ++---
> >  arch/arm/mach-rockchip/rk3288/clk_rk3288.c      | 37 ++++++++++++++-
> >  arch/arm/mach-rockchip/rk3288/rk3288.c          |  2 +-
> >  arch/arm/mach-rockchip/rk3308/rk3308.c          |  2 +-
> >  arch/arm/mach-rockchip/rk3399/clk_rk3399.c      | 37 ++++++++++++++-
> >  arch/arm/mach-rockchip/rk3399/rk3399.c          |  2 +-
> >  arch/arm/mach-rockchip/rk3506/rk3506.c          | 10 ++--
> >  arch/arm/mach-rockchip/rk3528/rk3528.c          | 10 ++--
> >  arch/arm/mach-rockchip/rk3568/clk_rk3568.c      | 35 ++++++++++++++
> >  arch/arm/mach-rockchip/rk3568/rk3568.c          | 12 ++---
> >  arch/arm/mach-rockchip/rk3576/rk3576.c          | 10 ++--
> >  arch/arm/mach-rockchip/rk3588/clk_rk3588.c      | 35 ++++++++++++++
> >  arch/arm/mach-rockchip/rk3588/rk3588.c          | 10 ++--
> >  board/firefly/roc-pc-rk3399/roc-pc-rk3399.c     |  4 +-
> >  configs/9tripod-x3568-v4-rk3568_defconfig       |  1 -
> >  configs/anbernic-rg-ds-rk3568_defconfig         |  6 ---
> >  configs/anbernic-rgxx3-rk3566_defconfig         |  1 -
> >  configs/bpi-r2-pro-rk3568_defconfig             |  1 -
> >  configs/cm3588-nas-rk3588_defconfig             |  1 -
> >  configs/coolpi-4b-rk3588s_defconfig             |  1 -
> >  configs/coolpi-cm5-evb-rk3588_defconfig         |  1 -
> >  configs/coolpi-cm5-genbook-rk3588_defconfig     |  1 -
> >  configs/easepi-r1-rk3568_defconfig              |  1 -
> >  configs/evb-px30_defconfig                      |  1 -
> >  configs/evb-rk3308_defconfig                    |  1 -
> >  configs/evb-rk3568_defconfig                    |  1 -
> >  configs/evb-rk3588_defconfig                    |  1 -
> >  configs/fastrhino-r66s-rk3568_defconfig         |  1 -
> >  configs/firefly-px30_defconfig                  |  1 -
> >  configs/gameforce-ace-rk3588s_defconfig         |  1 -
> >  configs/generic-rk3528_defconfig                |  1 -
> >  configs/generic-rk3568_defconfig                |  1 -
> >  configs/generic-rk3576_defconfig                |  1 -
> >  configs/generic-rk3588_defconfig                |  1 -
> >  configs/jaguar-rk3588_defconfig                 |  1 -
> >  configs/khadas-edge2-rk3588s_defconfig          |  1 -
> >  configs/lckfb-tspi-rk3566_defconfig             |  1 -
> >  configs/lubancat-2-rk3568_defconfig             |  1 -
> >  configs/mnt-reform2-rk3588_defconfig            |  1 -
> >  configs/nanopc-t6-rk3588_defconfig              |  1 -
> >  configs/nanopi-m5-rk3576_defconfig              |  1 -
> >  configs/nanopi-r3s-rk3566_defconfig             |  1 -
> >  configs/nanopi-r5c-rk3568_defconfig             |  1 -
> >  configs/nanopi-r5s-rk3568_defconfig             |  1 -
> >  configs/nanopi-r6c-rk3588s_defconfig            |  1 -
> >  configs/nanopi-r6s-rk3588s_defconfig            |  1 -
> >  configs/nanopi-r76s-rk3576_defconfig            |  1 -
> >  configs/nanopi-zero2-rk3528_defconfig           |  1 -
> >  configs/neu6a-io-rk3588_defconfig               |  1 -
> >  configs/neu6b-io-rk3588_defconfig               |  1 -
> >  configs/nova-rk3588s_defconfig                  |  1 -
> >  configs/odroid-go2_defconfig                    |  1 -
> >  configs/odroid-m1-rk3568_defconfig              |  1 -
> >  configs/odroid-m1s-rk3566_defconfig             |  1 -
> >  configs/odroid-m2-rk3588s_defconfig             |  1 -
> >  configs/omni3576-rk3576_defconfig               |  1 -
> >  configs/orangepi-3b-rk3566_defconfig            |  1 -
> >  configs/orangepi-5-max-rk3588_defconfig         |  1 -
> >  configs/orangepi-5-plus-rk3588_defconfig        |  1 -
> >  configs/orangepi-5-rk3588s_defconfig            |  1 -
> >  configs/orangepi-5-ultra-rk3588_defconfig       |  1 -
> >  configs/pinetab2-rk3566_defconfig               |  1 -
> >  configs/powkiddy-x55-rk3566_defconfig           |  1 -
> >  configs/px30-core-ctouch2-of10-px30_defconfig   |  1 -
> >  configs/px30-core-ctouch2-px30_defconfig        |  1 -
> >  configs/px30-core-edimm2.2-px30_defconfig       |  1 -
> >  configs/qnap-ts433-rk3568_defconfig             |  1 -
> >  configs/quartz64-a-rk3566_defconfig             |  1 -
> >  configs/quartz64-b-rk3566_defconfig             |  1 -
> >  configs/quartzpro64-rk3588_defconfig            |  1 -
> >  configs/radxa-cm3-io-rk3566_defconfig           |  1 -
> >  configs/radxa-e20c-rk3528_defconfig             |  1 -
> >  configs/radxa-e25-rk3568_defconfig              |  1 -
> >  configs/radxa-zero-3-rk3566_defconfig           |  1 -
> >  configs/ringneck-px30_defconfig                 |  1 -
> >  configs/roc-cc-rk3308_defconfig                 |  1 -
> >  configs/roc-pc-rk3576_defconfig                 |  1 -
> >  configs/roc-pc-rk3588s_defconfig                |  1 -
> >  configs/rock-2-rk3528_defconfig                 |  1 -
> >  configs/rock-3a-rk3568_defconfig                |  1 -
> >  configs/rock-3b-rk3568_defconfig                |  1 -
> >  configs/rock-3c-rk3566_defconfig                |  1 -
> >  configs/rock-4d-rk3576_defconfig                |  1 -
> >  configs/rock-5-itx-rk3588_defconfig             |  1 -
> >  configs/rock-5c-rk3588s_defconfig               |  1 -
> >  configs/rock-pi-s-rk3308_defconfig              |  1 -
> >  configs/rock-s0-rk3308_defconfig                |  1 -
> >  configs/rock5a-rk3588s_defconfig                |  1 -
> >  configs/rock5b-rk3588_defconfig                 |  1 -
> >  configs/sige1-rk3528_defconfig                  |  1 -
> >  configs/sige5-rk3576_defconfig                  |  1 -
> >  configs/sige7-rk3588_defconfig                  |  1 -
> >  configs/soquartz-blade-rk3566_defconfig         |  1 -
> >  configs/soquartz-cm4-rk3566_defconfig           |  1 -
> >  configs/soquartz-model-a-rk3566_defconfig       |  1 -
> >  configs/tiger-rk3588_defconfig                  |  1 -
> >  configs/toybrick-rk3588_defconfig               |  1 -
> >  configs/turing-rk1-rk3588_defconfig             |  1 -
> >  drivers/clk/rockchip/clk_rk3288.c               |  2 +-
> >  drivers/clk/rockchip/clk_rk3399.c               |  2 +-
> >  drivers/ram/rockchip/sdram_rk3288.c             |  2 +-
> >  drivers/ram/rockchip/sdram_rk3399.c             |  2 +-
> >  drivers/video/rockchip/rk3288_mipi.c            |  2 +-
> >  drivers/video/rockchip/rk3399_mipi.c            |  2 +-
> >  drivers/video/rockchip/rk_mipi.c                |  2 +-
> >  110 files changed, 229 insertions(+), 206 deletions(-)
> > ---
> > base-commit: b8e0086b585791a771416ce51b58ce0097bc0b28
> > change-id: 20260908-reset-e69a40d3f5c6
> >
> > Best regards,
> > --
> > Massimo Pegorer <massimo.pegorer+oss@gmail.com>
>
