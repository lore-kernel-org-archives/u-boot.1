Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26AACA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 07:53:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3682980C86;
	Mon,  5 Oct 2026 07:53:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XDxMimYam-E1; Mon,  5 Oct 2026 07:53:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1DFF080B12
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791186837;
	b=r/K6slDvJMnCdU+SYSZ8ncUcZ+APvdxbVWxwytjn1TkA6WKnbKLElS7VmFrNRXvg+6n0
	 le4YZ5xzkdW5llJGvlxoXvV6ogmZbvuKWKdiEx4He/mt2tw8qTdP7jcHWzfznoCY08/9z
	 lPh+Rqr28hqPPDw3Dj12NHfzkUBlfmam0EixZb2cBXhkuPo4EoXVO74CKw2ETmOh5MfoJ
	 M7o0cDJcZ9zjvQy0egIRRsdgn9uJvpuwg0rtcDKRmnFkClOOgAj7k/QJVSTlRKHbk0aeC
	 5lW4y505CwpEGzhiXNGePFIulwF3GaJC9pVscU/kNs+HofRUGTQBHKjqnWl3r0tBwbg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791186837;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0rLw/tKX9s+80aRL7Py2NQJcrHHqOvoCxNJXnW6MLBU=;
	b=NzvmIM57QscytBxYWYUTyXBsLim8KJlC+Dhp1AlFLNktibtx0Qj65RgzR9zx+wBJ9yE/
	 LM4Hb/w2jn0006IA12ASjiKcJTcjdFehnWKkfQ7BQi2VVUfGsX15mo7ksNikMkmC6uNnF
	 WSE7yhuWpK4h0A0JmrlKhiM+svgzehGorwvp5GZkfPBy+0SeRdE4HDqO/FvmSfJcPgu5O
	 ryJ8uIUWMXLeHrHMwjJFZflc0a8LbpJE9Iv/h6vbbb9h8rakXBbMzj8a8Nq5Adj/pJk8E
	 3M1yj7YwrIHC6xGkKSmc1S8k1SMUkcIcIVziHxqf7RAddrsUIvlbMM5gLJb0MZmr7mg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791186837;
	bh=0rLw/tKX9s+80aRL7Py2NQJcrHHqOvoCxNJXnW6MLBU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FvulCQOU2B90blNwukATjipmei5iF7qbTc3TIjGdXml8OJV02RCRs/PZbJUSVOsq1
	 suDS3BztXrc6jxGMQxRDCRQiamlwz1it461dZkoVb5IjCg9tQxmAYE5zYEgeAt+d8h
	 R4Q7hlJkyVYRnJdaGzXhHV7l2O/saOt6ZM3Bp7gXlfwMnEiJFrcKjaH3W2GaClTLKa
	 riAXiz+tZCuOYU3rlElnEjhiY1Qh83Gpo1YCey+0na2kw0ftx+/Pp9l7o1nx7Q5pU9
	 YyqUevwK1uTFeRP5Ha684bZt+5j33ezbZT2D0jbrQJ+dIlZkEzWOzvieqTs8zit001
	 Z1vOcWqarm+iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1DFF080B12;
	Mon,  5 Oct 2026 07:53:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C6BE335
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:49:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5B67F60606
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:49:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DbYg3k0Q2X3X for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:49:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 52AD4605E8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::20"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791186546;
 b=BbSg7XMbMKJsh68zTrBi2ftVLGrnDMmJsc+sTjY3clkeBTzK5VLIss+wHOXVRwvDyUuY
 tcT4evts3pCKhwSD3wmYK2zHRslX45dq/SCxSBRW3y8G47mR99mJrzG2ljqJeA+TZk+Lx
 wI5J3G8NYL8TbI9hoG87AWLZpoTawu7QPh77Xu1XKynCpvbGTbItIjvVG2tUKL2CkFNoz
 C+fqSTQhrr/84LvQeY7B/8wmczz+U/QaFDlX1U608aZgHBhddMLWcANwTFCVYLSeL+RyI
 WPTX1aI4youfIx5a0gxpBoPHhUv+3UMDLdtnSyhS8uLmLG4DDVGZJJ2IDDqLJUxCA0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791186546;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=0rLw/tKX9s+80aRL7Py2NQJcrHHqOvoCxNJXnW6MLBU=;
 b=HL/ILywI869l2/FqlcsD+V3/dpfIneUo7/V7bPkfCr4TCs4DH/QZuoEikwEyOs2Ntf6q
 smPOOzOefXYBhGsFrrmSrQsrRllZ96SY587hG8TtCK35nBeL06QlQJFxOQ9fSSJnECo5j
 PNG3SAiHDZSCWsXiv69fG2XgU1zAcneD03/hWOT+bkes3Ulmf1whHKEylF93JMQbfGvyb
 Gx1HOE6pTLhyPoPhwYjdKJ2OrVffml9m2mH1iUyq5uYnp+iXsTK2Xt+fIqpiUjHKPcAWE
 xdIZCJE4BVwiCkt+aJloLOXLDyakGmMiXNMFvMA7Ydv+DIbqmknsqRsS6wS1QYL6/NA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=yy4920gG; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::20"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::20; helo=mail-yx2-x20.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=yy4920gG
Received: from mail-yx2-x20.google.com (mail-yx2-x20.google.com
 [IPv6:2607:f8b0:4864:41::20])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 52AD4605E8
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:49:05 +0000 (UTC)
Received: by mail-yx2-x20.google.com with SMTP id
 00721157ae682-8ab41af29caso8183167b3.3
 for <u-boot@lists.u-boot-project.org>; Mon, 05 Oct 2026 00:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791186545; cv=none;
 d=google.com; s=arc-20260327;
 b=HV3REEjve9aoYGIRKSRcggnx5EmycR/XZf93JIGGYx4KEHMUh34RWUqu8VF7fLnuj7
 CnNOcdg33nZIEWgomzE7aW1TyQflElDq8qRaR3H38OdcI3kCKU80tWeu6fkdEjVBPoh4
 A8c87WlgYq8kFtcZPCWxI0R+pRBIAyBW7i50n9ZVHij8OtaxOK793JY3KlFmDB1yZ72K
 SBnDaroV5Kvs7TGdc0yHibsYqgjOEB8A7F1QkK+uo6CUlOD/V0MhxnP3NA5fQzPCAGsO
 a7KA09DpMAdmFy9/PXzjWA+YMGN7BI/dABljyCRvD4K4JKz67mVeKAc+ZhA2q8q2oGVb
 yqjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0rLw/tKX9s+80aRL7Py2NQJcrHHqOvoCxNJXnW6MLBU=;
 fh=xhUKrUwXjfqKadCYUyhK1GNbU4JDxVQ/itoz3qJhd/E=;
 b=Fr3y+Fa9bA4052VJGhw+T+lYYVpESD+CRW+aWv4lt/nlREEMLzBnEj116N9tIDTGOt
 xMaM2nIO85Ak0N+nGR9i/MMdcsWm4IPnPVFfUjmy5xCaIhqjYwiXI9QBKrZSLpu90qwA
 QtBkbofuJtBToCGetZGgyo8zbH6B8LnBVv0NGrWYkw41oje+3fT3gdev48jEPqWCtlCz
 Ko8am4KseGqEtZZp1bwjbqzLkS+U+cIfHD7Hgp9yQ6dKsrcsBs4XDCz+tS2nAO+EP2R0
 3YwaaQP/xoKfE6FWdgznPhs8tRy1nFiBjRuEHlTVynsiTC6MJ1/0ZTQrHTK4tXsxzsQg
 2APQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791186545; x=1791791345;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0rLw/tKX9s+80aRL7Py2NQJcrHHqOvoCxNJXnW6MLBU=;
 b=yy4920gGDst7AHn9jFEvsdBBEZ+XGNLOF2z9Y5rbQC665yR/udwukcDBYv1okD7a4X
 I97fBQsGAJvo9czTSxZE/RMRIDR+bO6L2h0OzseJ2STxHYbDaP1tLQH1t6e3GLtuBtDR
 G27myHk2/VkyurOwLVg/kwUT9L9tCZD1lJ/L8Z7gjBJgoBa+1s4r2bgE1o+THOYfpXAe
 6d196HRk4/TybZtXWAiUCFEQ9ylS3DtAfxvXPJfyotBzXyZYFhARjc0pmwwV8FV8H9bE
 8cOTI2hff5f78w6wdRtMCKBm67pqkf/cFmchGN0g7EVTJW0WmZpYWyDZ76+YbX4jNzb3
 e8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791186545; x=1791791345;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0rLw/tKX9s+80aRL7Py2NQJcrHHqOvoCxNJXnW6MLBU=;
 b=XSJH4CvnpUjb0pdpSvvK2Mv18M5OYN9ADXu+f3pA/VyO7U5SLWwwL7WdDwUjmI7a3g
 2u/S7ANXMIWIBIzvdgoil236pMuXDpeNmHAiMQuTZ1kMjx3A1jAsKrm48hUwkvd7JOPf
 +4pSCIrWFV04Af4UGBIltovpStN6r6WEwUzbZDU9ppA9KaaoWhp9QeowrZ73LKkzgyWa
 Z1/bn37aisJFYrYzKPPuQjBM+VLCr+cO2FKOZ9sqloW3Wr/1+5CcldNcHSiSUgPX23zY
 ivouRrf3ugf8H+hQUJWIi3waH0MJuIVhANfHvm2QkaC/mx9l9PN1XvyvtCBNXWs1S35y
 /S2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwh7B34p8zfSnRDlaCt176SrjmFVFz6P3PwM8B0cG3I+B2oKiJylE/iNZWYKQ0LXXDN+hsRTkg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJiJIITDqMRZE/RnxD8aPx7xzKDX+uv0oSA2pUxFMQgQgVmLvOF
 wHi1i83hNCsFrYiXoxfarqVvPmmSjrCaI5eUUzRfwpLMZRldN+5jc0HcVaFF1u7B6DXtmy9viL6
 dFC6HWVBhEevsDc+TzyC3uYPI3BSJYeMe2ZMzKjW2lw==
X-Gm-Gg: AYBFou2yJiQshGLvHH55eWRAhbWEryt3gxqtwstZk4X8umDzeTYZRY0/e+kxxWVYbBC
 avjBLiKl5jkYMSc1ygDjE24MsP+cRDx14m9mOe8KrGRrPgpqwmc22z6mwFattMoZsMW62FPny7k
 cu7HuN2klcSC5FHQZzrueQLFuQ//OCuBZlGHcIcDUa/ATQbSjwV5R16sqGSZ9Bb4rKIMeC5Izih
 e+b7PUxEFCh/sh/BqtmXJeYV6ZNfg65cI8D6V9BLO8XXzCT3Vmi1Fu4Sh3b5VNNh1Zg/a24dpaa
 lLQgc88rngBH3mR8iFoh7sssk9OBj5yxyVwwnMrlugV427sjvTI9XlBl5fvBKJ9WASBQK+1X0EP
 p6F56/7awYTfD9TB4SvUM5xlPb69LnhGOfeVZFsHpyILfPnSt5AxJWoFdGTfGqH/kNfnyAbofDR
 CWq7B2g/+qihyuAn4bR09QSbncKRzhm0QiIru7Db0TAx7pB7/js6UmWPWrIEFGSqwP+D/D38i9N
 5fd0VEFL8QQ6NvQh9rlRJYk27ZUljYoImuDIJGeBZuecENNbnqnnQsYusa29bc/RN+qdTQF2Kh2
 vvepVPLgly2lS+UcT8h/NLJ9AQL2xqAREwFYcNpXorl674MRYCggGvgmHfigdlqIrFzjaSkcLvr
 4Nb0eE7VO61/5NMbfMe9hyKarVde8Kd4X6JLKKcfvxnY8bGATUG4YXw==
X-Received: by 2002:a05:690c:6d83:b0:879:44a6:1076 with SMTP id
 00721157ae682-8ae397b974bmr38147057b3.32.1791186544381; Mon, 05 Oct 2026
 00:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260930090512.52342-1-michael.haener@siemens.com>
 <CAFLszThPOmn6Z3hA6H1r812kKdEWxtv_RV70BNW_w5U0M1TBDQ@mail.gmail.com>
 <CAC_iWjJqezM8j=5jcAA8w9ApNP5b+pqC=CkRxEA8mqdNCu1RFg@mail.gmail.com>
 <CAFLszTgXVSKxOhdmgGqUG=YEyekP=3jtz=AtHF4zD8Y_CKY50g@mail.gmail.com>
 <CAC_iWjJ+4G_u6sCPcM6HMhVRcnkmGLSaAYHkOScy5CVSDrpS_A@mail.gmail.com>
 <CAFLszThMBuKz_6PBdyriug6-2EEsV6EqKin79YQvLuX4Y8cyCA@mail.gmail.com>
In-Reply-To: <CAFLszThMBuKz_6PBdyriug6-2EEsV6EqKin79YQvLuX4Y8cyCA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 5 Oct 2026 10:48:27 +0300
X-Gm-Features: AclHuK_5Lb3Sr0zizUJhUXPykuXrdeLXYH3VusAkATp-eKmhiJNtpc7MGPsU2ho
Message-ID: <CAC_iWjJpDTRXWjQk2mfmSxens=1-J2Gbba79MUwVHu440uRUXA@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add an option to start the TPM during init
To: Simon Glass <sjg@chromium.org>
Cc: michael.haener@siemens.com, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.u-boot-project.org
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

On Sat, 3 Oct 2026 at 15:23, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Thu, 1 Oct 2026 at 19:07, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon
> >
> > On Thu, 1 Oct 2026 at 19:03, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Thu, 1 Oct 2026 at 09:41, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > Any reason why we can't add this directly to the uclass probe instead?
> > > > According to our docs, the probe is supposed to 'make a device ready
> > > > for use'.
> > >
> > > IIRC we talked about that a few years ago. Probing a device is
> > > supposed to get ready for using the hardware, so we typically have a
> > > separate operation to actually talk to it and get it into a particular
> > > state - otherwise just probing the device would take quite a while (it
> > > also means that TPM cannot be used for certain things after init()
> > > unless the board is reset!). The same approach is used by the
> > > keyboard, for example.
> >
> > I am not sure I follow this one. What do you mean after init? The TPM
> > is only supposed to reset with the CPU.
>
> Yes...TPM2_Startup can only be sent once per reset, and it determines
> things which then cannot change until the next reset. For example, on
> a resume from S3 we must send TPM2_SU_STATE rather than TPM2_SU_CLEAR
> (see tpm_resume()), or the PCRs are reset and the OS can no longer
> unseal its data. tpm_auto_start() always sends CLEAR.
>
> If probe does the startup, then whatever happens to probe the TPM
> first makes that choice, and nothing later can make a different one.

What choice are you describing here? tpm_resume() isn't used anywhere
in our code and I really don't expect it to ever be used. I am not
interested in theoretical use cases.

>
> >
> > >
> > > But given that this keeps coming up, we could perhaps provide DM
> > > support for this sort of thing - it's not obvious the best way to do
> > > it in a generic way, though. We could have a DM flag and perhaps send
> > > an event that the TPM uclass picks up on?
> >
> > What would we we gain from the event vs just initializing it on probe?
>
> The event runs once, at a known point in U-Boot proper, and only on
> boards which ask for it. A probe runs in every phase which touches the
> TPM. tpm2_auto_start() starts with a full self-test even if the TPM is
> already started, so a TPM which an earlier phase, or coreboot, has set
> up would be self-tested again each time.

What do you mean by 'every phase'? TPL, SPL etc? The self tests don't
*have* to rerun. We just always trigger them becuase tpm2_auto_start
sets fulltest to 'yes'.
So I think changing the first call of tpm2_self_test() to TPMI_NO will
take care of that, but I have to take a closer look at the spec.

> Also, if the self-test fails,
> e.g. in failure mode or lockout, the probe would fail and we can't
> even talk to the chip to find out why, or to clear or update it.

Why? What's different in ingoring the tepm self test result during
probing vs having it fail later? In both cases the device is unusable
and you can access it, no ?

>
> On disabling the TPM in the DT for speed: U-Boot often passes its DT
> on to Linux, so that would hide the TPM from the OS as well.

Which sounds correct. The role of the TPM is to measure the pre OS
environment + some OS specific measurements. e.g on the kernel we
measure the initrd.
Do you have a real world use case where an OS wants a TPM with zero
preboot measurements?

>
> So I'd prefer to keep probe as it is and take Michael's option, which
> gives boards that want it a started TPM, before the OS boots, without
> relying on the environment.
>
> BTW, by design, driver model aims to do the least work possible in
> probing a device - actually communcating with it is supposed to be
> done only when needed. That is mostly about speed and simplicity, but
> it is particularly important for devices which have state, such as the
> TPM.

So the TPM doesnt *require* to run all the selftests. Just the
functions you will use and they can run in the background. But that's
a bigger change and unrelated to the current discussion. Also the
documentation says the device is 'usable' after probe. Maybe we should
update that with what you described?

Thanks
/Ilias
>
> Regards,
> Simon
>
> > > > On Thu, 1 Oct 2026 at 11:20, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Michael,
> > > > >
> > > > > On 2026-09-30T09:05:12, Michael Haener <michael.haener@siemens.com> wrote:
> > > > > > tpm: Add an option to start the TPM during init
> > > > > >
> > > > > > Add CONFIG_TPM_AUTOSTART, which runs the TPM startup and self-test
> > > > > > sequence from an EVT_LAST_STAGE_INIT handler. This is the same thing the
> > > > > > 'tpm autostart' command does, but it does not depend on a boot script or
> > > > > > on the environment, so it cannot be skipped by a stale or edited env.
> > > > > >
> > > > > > Today a TPM is only started automatically when either CONFIG_MEASURED_BOOT
> > > > > > is used (and then only from bootm) or when booting via EFI with
> > > > > > CONFIG_EFI_TCG2_PROTOCOL. A plain booti/bootm therefore leaves the chip
> > > > > > uninitialised and the OS has to start it itself, which Linux reports as
> > > > > > "A TPM error (256) occurred attempting the self test". Boards have worked
> > > > > > around this by putting 'tpm autostart' into their environment, see
> > > > > > board/xilinx/zynqmp/zynqmp_kria.env.
> > > > > >
> > > > > > Boards that share one binary between variants with and without a TPM
> > > > > > fitted can enable this safely: when no TPM device is found the startup is
> > > > > > skipped silently.
> > > > > >
> > > > > > Signed-off-by: Michael Haener <michael.haener@siemens.com>
> > > > > >
> > > > > > drivers/tpm/Kconfig         | 15 +++++++++++++++
> > > > > >  drivers/tpm/Makefile        |  1 +
> > > > > >  drivers/tpm/tpm_autostart.c | 33 +++++++++++++++++++++++++++++++++
> > > > > >  3 files changed, 49 insertions(+)
> > > > >
> > > > > This seems like a good way to enable the TPM for boards that want it.
> > > > > It would be good to document this somewhere, e.g. where we mention
> > > > > MEASURED_BOOT
> > > > >
> > > > > > diff --git a/drivers/tpm/tpm_autostart.c b/drivers/tpm/tpm_autostart.c
> > > > > > @@ -0,0 +1,33 @@
> > > > > > +     /* A board may share one binary between variants without a TPM. */
> > > > > > +     ret = uclass_first_device_err(UCLASS_TPM, &dev);
> > > > > > +     if (ret) {
> > > > > > +             log_debug("No TPM found (err=%d)\n", ret);
> > > > > > +             return 0;
> > > > > > +     }
> > > > >
> > > > > It seems odd to ignore an error in this case - if the board maintainer
> > > > > says that a TPM must be present, then I would expect U-Boot to fail if
> > > > > it is not.
> > > > >
> > > > > In any case, uclass_first_device_err() also fails when the TPM is in
> > > > > the devicetree but fails to probe, e.g. because of a bus or GPIO-reset
> > > > > problem on a board that has the chip fitted. That is a real fault, but
> > > > > log_debug() hides it. Please can you stay silent only for -ENODEV and
> > > > > use log_warning() for anything else?
> > > > >
> > > > > > diff --git a/drivers/tpm/tpm_autostart.c b/drivers/tpm/tpm_autostart.c
> > > > > > @@ -0,0 +1,33 @@
> > > > > > +     ret = tpm_auto_start(dev);
> > > > > > +     if (ret)
> > > > > > +             log_warning("TPM startup failed (err=%d)\n", ret);
> > > > >
> > > > > tpm_auto_start() returns a u32, which may be a negative errno or a TPM
> > > > > response code (e.g. TPM2_RC_INITIALIZE). A response code printed in
> > > > > decimal from an int is hard to match against the spec, so please use a
> > > > > u32 and %#x here, as report_return_code() does for the tpm command.
> > > > >
> > > > > > diff --git a/drivers/tpm/tpm_autostart.c b/drivers/tpm/tpm_autostart.c
> > > > > > @@ -0,0 +1,33 @@
> > > > > > +EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, tpm_evt_autostart);
> > > > >
> > > > > This is not really a driver, so lib/ (next to tpm_api.c) may be a
> > > > > better home than drivers/tpm. What do you think?
> > > > >
> > > > > Please can you enable this on sandbox and it would be nice to have a
> > > > > test in test/dm/tpm.c, checking that the TPM is started after init and
> > > > > that a missing TPM is handled. Your test could send the event.
> > > > >
> > > > > A full self-test on a TPMv2 can take a noticeable time, so the help
> > > > > should mention that this adds to the boot time on every boot, even
> > > > > when the TPM is not used.
> > > > >
> > > > > BTW, since the commit message mentions
> > > > > board/xilinx/zynqmp/zynqmp_kria.env, you could convert that board in a
> > > > > follow-up patch to show how the option is used.
> > > > >
> > > > > Regards,
> > > > > Simon
