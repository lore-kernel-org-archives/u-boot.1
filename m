Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF9FCC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 12:59:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A42EE6060E;
	Tue, 13 Oct 2026 12:58:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ReOS16TTaoIx; Tue, 13 Oct 2026 12:58:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ECE8E605F4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791896339;
	b=BMyT1HIAOw1TUHxqMnXCJwcHbFSu1jRtW19Qp7/sRnj/1EnvllouzP5MMUxgOiSouWGx
	 KOnmEFQueIG2w0MO+0uK7sQ+aN2ZAY1R6xkBPVklWVoBYjVHiF+GbHLholsfI5tsadxE4
	 jUAsGX3NlL5bUiGA180LauGfVVBZswhql+X05EnP8nSoYc+B+4Jf8lmpZ4rufiwFs5COt
	 qMNYM2Oe151hPe0wuDxMZF4cGHDMEfcr5YeZIsMS2JoPWSWvcXAbHd0U1ENfav4wwcFut
	 VHMa3mBTIZusXJL1k3/MqurmifjiGVI3sC7wopj7HNgmncfdBls+zPfewDkteGZl6CA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791896339;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=L1GyNeSnhquVS5GQJ4ZNsKZ6CAgmBD3hDYsCrGNLlc0=;
	b=e7XKG3vcjjVQkxP8dxEZ+cFynprb921sJBE44jLyQ/ScHyXntP8Kf88rdCvQJeiyNw6E
	 ZKgW7gjE0FXfSKBAGTmNOUShW2HVb/0rbKfUttL+Kdp4xI1ekmsnyHcMb+GzlmHVqcNke
	 LAyK6wl5SVHMuv4Tl9jqi0oNedE8ax6D6n3qNES3GdZhDUswQWY+uGALdaI1dJBh+VDeX
	 vFx268Dc44hmalWdBKS7fo6BaMKs1LZvFrQ5fVWtd1JHnf1ICSDbt2uDQW2p8RCH4rtQo
	 Fxx4N8eptfgRFiDqPCv2UnLExgHnJqOSLp0E+iSAZfZf7yUAKDN358fq244bGYVtcBw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791896339;
	bh=L1GyNeSnhquVS5GQJ4ZNsKZ6CAgmBD3hDYsCrGNLlc0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0Qt7TKeeCi4SlvGoIYIKtOL+yLT32qB8v/56D863oqvgACiOfcZXblBhPVImGiYDP
	 qJuxWmmRqshkyJHlsAG0V5uLjTrgbv8ldy4adXuRMx1fk7ti1wIBMh/DNZMGPxi5ZA
	 KxwmxHQcZMTasNKTUDAJAJgZw8C1NsSdC5mCGQPghxRipwAQPvMSPbqQEqgMD7XACS
	 cf1d9fZ8eRCpwqLvZs96CSl+NiQAVxqfhgdv94v8BFykslDMK+4dILQ+RIEADo5MzW
	 CKk0xjw1+4xccJWaph4R3/GTVEr0afy9kTHymK/w2Myj8sltFTHkCwqpnKcRuwHBiE
	 fOpZNTOPJxT/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ECE8E605F4;
	Tue, 13 Oct 2026 12:58:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D46C0235
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C624980934
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:58:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QkAhSs7rktJQ for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 12:58:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 02027808AC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791896337;
 b=FpHvgf5xx3RsFW4km3nQtU0irnRry5ZN71jzSH5TvihCOi4sC/oXfpxiCRvsCDA1/b/R
 XdrY3ot/GuS5Q9ccT7k2upc2dDyukc949Hx7yBryKA94/LARWfvj8SYZJlkPghAUp6n1D
 YExAv07idpJve9zY9ZLujl1wbCJADpIfkNEYQ9s0kB/bRIwyf/ZyCfA1ho7wkkvB/AXPJ
 kkyPgj0JZtrrAOV7sFFfCW5RKNuSOcAtP8bDO1heEdCkSGSsgQmQ899jkCtaSPNwizG7s
 VlcNU/gXA6YAnRB2xqlBvy1alQZCEQebOWRz/igWQdJSLuw6qbYv+KM9sVeR4ztlpBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791896337;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=L1GyNeSnhquVS5GQJ4ZNsKZ6CAgmBD3hDYsCrGNLlc0=;
 b=tXYSy7FzY/DiAKSR6GV6IeAu+OZKecILpSmXDKgNaLryA7KUsOjxU0DZAm0gXkydEtGW
 eWxmZoQfKtxm490p+18nBsKAtWUxqULNxjyx9Eo5M2GG7lkQ8iJYzjE42Uj+GNUcBkRRD
 yotAve3L2t6ZCf6Kn67gyYz9AUzr2ndJrbbGJg7mBBGWWECgNIAX4R/Ybhr6XC3sbAljs
 ifomxLBuEq4jI49SpAxEbt+1jpMmx03ueM6TyXVVnwmKQglXVZE+JxGKaVoHoUu3KeB9c
 Y9EBdKSEFJY3tI6ZnUBI/KXinGmuVIiJv7f0gZDi35Udp3vdq1R0kAVvUny9tr6G8Bg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="S5tj6f/L"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112a; helo=mail-yw1-x112a.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=S5tj6f/L
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 02027808AC
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 12:58:56 +0000 (UTC)
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8b06c0794cfso23408417b3.0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 05:58:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791896335; cv=none;
 d=google.com; s=arc-20260327;
 b=L86/xtz3KIyLvYCBXfI00/1r5WJRL/onV/Lw9rkHxRhduAJ7bBvdqgtrrnglQZcqeU
 Crim2FhtxdiLtCXsBrN9lxQqfkkuBowOhsMQJ7mxEW1EG0QPVHNGmWsHXkLZsC7OSOj4
 llyObMDq+h1rbgMQQ2Wolf6F1cJwnk6mDZNaHFvmbldBHY2njBld0bpJUR4p0dhqcpEN
 JtqhURPJtg3JHp6DUfScX547IyG34IYOJlapmJvaUTSW5LI1ey5XMOCe2hmCMdEvYKhg
 BmQqKVQAGguvLYtC20YEz54wL1NRRZgVVm6a8iTBoEABr3HTTmr0dci3tYaZT8kjTwUZ
 3mgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L1GyNeSnhquVS5GQJ4ZNsKZ6CAgmBD3hDYsCrGNLlc0=;
 fh=vUhe+/ufku4UW4uUkGo/4795sR+pLtNMZz4fmw7B1A0=;
 b=Hq9fKWsTa8qKhC8CTY21R9aB7gF/r+WqApbyYjd4OVudAHhjs1iaZsUPNTQgnYGiov
 Ehd0nLNlfpm6z8KCwVyRgD3waWHRirt5NYEfy3M0RDKpWrgwXuh0qbGYJy7l9KeKdNZ/
 WT8Fs2xq7LDZegm0c4ecUMrKYc/oyi/T75hgZfchtaW5s2HXEKfmN1MW1AiTuLWaayGA
 /FZIM5+Vbzc1yxNkDkcdBR3XZ4oRqhoCZnKaduHrSIi4FqGo7K0tCPYnjhWskWVRPq4e
 mVhNs9F59VdRHhrDm19gkCwZpvssV0aTxlaK+ddUYv8HLmBI8IvAFNTH75NHuPmLJ3rj
 HjTA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791896335; x=1792501135;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L1GyNeSnhquVS5GQJ4ZNsKZ6CAgmBD3hDYsCrGNLlc0=;
 b=S5tj6f/LtcMNdtWMBcVj6BLGWHp41cNlqKTUMSFN7WZ+a3/CgLgRUsydJJIeHQgT7a
 Fa19wkTzH0FVkoJPxdi/M9gEG0DgfUg9Q3/wnDKmM8RfrZhOg5oQuSzGF9y6VAuA/QLe
 reqT5iY/7FWFqdVCA9Xw88ME/5f0WaJGzKK3bkRSJmws0X+i2MQ9w643I0Ugp1L2A8Vu
 6OvUfpbuihV7E6j/NsyHjJSUMy5+Yb1gddvhFnSWMn2JKBQ2gTPxHNQcSM0IK+x72334
 GAjhdlVCWBvExy0ZpkWWSG9NYuH5/15yDOo2XlbOBMxhGiKcktTNy/nxdOzvRYQXwt0y
 m+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791896335; x=1792501135;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L1GyNeSnhquVS5GQJ4ZNsKZ6CAgmBD3hDYsCrGNLlc0=;
 b=sCJHqu0ClEd+bDI49wNUiqMrV9lhhUIUvcpv8XfwJgPc7llflIma/M6BPKfZFMLFYi
 iOcuSIl22a0wRVfh5F5BBUnGCTQn40Vw5vsc4ZKXn05LYp+L2DhXSVQE2UNUA5pTjC6Y
 Z32lSTo6FuTygjDzQ36642ImlA9U6BetMGUjed4EC62K/4iUdWy55GMleh8hB0Wyp47H
 EuCkzpfAMj/Rw6mq1bgELaIxewGN/5mdR0Sk9TCNRW25plsG6sC/yUeQoGajV6hccls2
 Z7SoAAWsBb64dWXm6NohisJN1td/S9oKI0K3VbDwMzCLFx8LfpSjljGVOg1wqbQC8+aL
 cpnQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxDqeQ3/HDabtV180/6hSAhRXH3kUzlprxIX85zWsfZ+6szACXC80Y443iCb+95ZdKOHUg3zog=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKEwjhpP/n5/xzFVVf70CrBaRW0Au7mffRFhqdyV8VUUwDKlTKt
 Xdysb7/EOrc42xx1EUTh9cWkFNK3I4G+Qn0KyHnY7E8vxKDVYZ76k+WgTTbJ5EP0H5GKfovo+wD
 Hkk1R6qu9S5ARgLnJmcRDxFNN1mR8kBg=
X-Gm-Gg: AYBFou1JGPrWitTtsZ937LnzSArXeo7/mBmoZi2NI/m9IWnDoDLK+V/XuVmjFisYY80
 UM8n8OybLh2G+lqo1Ae/y/tEhIKGOH2UDQIH+d4KlN0KcofrIT1JnpICcSSrdNB+FvVyn1sXhhI
 Ffy8DbpWaexjwZl/7BKsJOR5lZSBCNMDEMxw+dEX0OWBYqtsLFWDpJ0J5t5GrIVIcuWInUaZ1UW
 qVRuXcpK3ECa+3FeuBdfj8DO9ghLiydiN5JfQN/gIldKpGHvJrnGG4MA6EwJrYmycM8zyV/NGJs
 6pL7n2a/pmWbrhfrmajKIfIjZVuRMb09cLNfU8wdoVGnoJirGXPKYHtHqHIXwkKM+8/r12JPBuH
 cPgmDqCLuBLjFXHBi
X-Received: by 2002:a05:690c:10:b0:8ab:6374:5637 with SMTP id
 00721157ae682-8b07ee265f1mr50106487b3.28.1791896335274; Tue, 13 Oct 2026
 05:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260826113515.137299-1-jayaramudu.desapogu@amd.com>
 <20261008135024.13784-1-jayaramudu.desapogu@amd.com>
In-Reply-To: <20261008135024.13784-1-jayaramudu.desapogu@amd.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 13 Oct 2026 20:58:44 +0800
X-Gm-Features: AclHuK-Yq-GyGSmzMfaB6jdujbZvEBPDaTZ0m9rw_y8_VEhwNYax3R0RFZpxg7Y
Message-ID: <CAEUhbmVQztPz4L8oQs30w6+ssKomcXw7Q3-_sBYPnt2HBccKAA@mail.gmail.com>
Subject: Re: [PATCH v5] x86: cpu: x86_64: Detect CPU vendor and device ID
 using cpuid
To: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
Cc: sjg@chromium.org, trini@konsulko.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Oct 8, 2026 at 9:51=E2=80=AFPM Desapogu Jayaramudu
<jayaramudu.desapogu@amd.com> wrote:
>
> When U-Boot is configured as a coreboot payload on x86_64, the current
> code leaves the CPU identity at the default Intel vendor and device ID
> 0x0, even on non-Intel platforms.
>
> Read CPUID leaf 0 and build the 12-byte vendor string from EBX:EDX:ECX
> to identify the CPU vendor at runtime. Set gd->arch.x86_vendor to Intel/A=
MD
> when matched, with fallback to X86_VENDOR_ANY for unknown vendors. Also
> store cpuid_eax(1) in gd->arch.x86_device so later x86 code can use the
> detected CPU identity.
>
> This avoids relying on a fixed vendor value and keeps vendor-sensitive
> paths (e.g. TSC calibration) aligned with the actual CPU.
>
> Signed-off-by: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
> Reviewed-by: Bin Meng <bin.meng@processmission.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

applied to u-boot-x86, thanks!
