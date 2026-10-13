Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF7CCC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 13:00:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 341134040F;
	Tue, 13 Oct 2026 13:00:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dgO5x1VBT7DH; Tue, 13 Oct 2026 13:00:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 82EEA40411
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791896407;
	b=lST36MKpn/Atg8m3sAaaEdlSNvnBBDgNxaodbveKkSIpdoqpKrSjrHJwGeYrynC5xjIl
	 0LxzEmnBGJ5HA9E47VPKooN91Ux1GezoNOFjG1EF8qmEqwGNaVkqAMM6D44IInHiO31d7
	 ws1CXIBAW2fJegHQ4KJWoCVTpJxYJlS4SPDOrV8tMs23K9quIpJtVbjdzkXDsr5z2388D
	 XDoJxhsT4eC/Qb5K4GC6EBWKtlKEqpZBSe2OfIpnvAWrCGV2ELZ2+3y3vw0z52jwt9ZFO
	 USYoUeGs8m05jlur8GuLiyMrRIPcun/DnIhFE81uYuFjjsGwInbeAzin45tX96NFibA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791896407;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=03hO2GCs79Vuj9Dxd1j75s5u44DIXqgQ6G60qUV5T0U=;
	b=poCJXjdg0rQGiQAqP0Qmmta3lBxV9i2CJSx7z7m5i+gH+cbz63Bgp75GDuyzasGU+ZAt
	 QGugykCvBX/wp2WzjAX9FzooaHytn/24Xrt/AtoRYCdGP5ZNU4dkSioaGs9We4o/QSRaB
	 Fj70gBdS0ZHCky3tUaoSwNfGOGUXpKyxBjTke+tJdh2aMXKlZpNApWMV6pl4lJKv4nhtX
	 w6teSRGVUWtGKsuY7kRS7DsjL1Sds6spS6IDCbJcw+H0Jp2pWYRVuDd5BEcDnLfiabCK8
	 1Oc7M/SQJESyQIuyrFbQwxxY/jljAQj0Q7b1Deu8aLRbT076PfYYpJjEkPx/JXWpjAQ==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791896407;
	bh=03hO2GCs79Vuj9Dxd1j75s5u44DIXqgQ6G60qUV5T0U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A0pVN76s+L1XjPkyTRwKY1SnFo8iXE5LZqxE0jRilEuWiQKOJQzZS7rEP/xFtfztI
	 0x7Rlf9zhz9NuDQVCQBP1wEBpEI0D1ZkTa+sv/olRu2NUl243nF2oGBHGsToq/L5qN
	 sdtXHV5z/b0eTzaLKqbCmb34A3OodkqSrzI3yBFR3qrEOTqoribel4ASvBUkwAR6hi
	 bYFmqjh+oJdtVGkvwFREMunizWeoHHh7dMuA6p2SsXxDNfwkXerwYCQ87FFxzmZQnd
	 FEX9SpXQ19bs9ofNXDf4f9Qbkn6XPR59d3A5fIZvV2ATmct2Us7CdQC4evbpcHaxUb
	 i6B0SggXSZ1Qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 82EEA40411;
	Tue, 13 Oct 2026 13:00:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C34C6235
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:00:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A59B9400C5
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:00:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JhXvt-v2wOVk for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 13:00:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EBC5240070
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1132"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791896405;
 b=enzKJgM1r+V1oaq6MH0yZoBkHhfas5xyOCJxuVWrTeLDuVfyt8mVnNrR9b3TBBumP1R+
 EjjQ9Te+n3rrL3sBJ3Hpi9gTw96RLSD0B5q5cbrJTUCMLc7nKPhRF8waKNJ8eAU430fvD
 qqBztS5h5++JsQnz/imwcV7oRsp3jE/tGohEiDU6/zYqzhDuqAuiJ6leJPICTyCDsFs9+
 4Z9M8VGEZ5UbgzWMisUIELHRAf5Tv+B/OwMeocNSrbWmasduvfUJSXd478Hm0n19vpeHj
 2Pi7EqW1QWejcag0c8wE2klaXVxWHbDh3ByL0C5nVh1Yi9Nh3Bv6206/YwNaoU5nB4w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791896405;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=03hO2GCs79Vuj9Dxd1j75s5u44DIXqgQ6G60qUV5T0U=;
 b=IqIVz7sKyQTmY3SJOJmdJsGMXe/+BVQP0zhGb+ksf6B/pYmUtCrZwyYo4eLezBEuauf0
 SqBzHMyJg6I0iD1PGZ+9HK59/62C87t9RQxJVdMZTKgtWIXCGvl39EDHPaE97Z76909v4
 QBjXJfTmj4vIzqXweLVcTZ62jnh64J+DJuR4NkUG2UVstfzqyjV8I/XAT+uSij76JmWOG
 /3dG81zS0VxMZlL1bT9ovJ4XTdie3k8npIhqfjyU6BPmV18ajg0YtGT94fO4E0f0v2keU
 Mjpxrzq/21ErDaD13pwO69Z08pWIgfx/nlqaJDers4Y9sSlzXMipPq9fpk2prlRPF0w==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qbiwBLEg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1132"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1132; helo=mail-yw1-x1132.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=qbiwBLEg
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EBC5240070
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 13:00:03 +0000 (UTC)
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8ac525c1f05so23604827b3.1
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 06:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791896402; cv=none;
 d=google.com; s=arc-20260327;
 b=DOvM2R2dKwjwhd0qVhylKbtp0Wx2/dCQjuLrf1JeMWoOwFCHXKKoSq8nM4lUMefesx
 GpbFz7/Pxd9D2gyQoNBz6nUhwYdJ/zqPG5lFXV8QH2v+HHt1Wd1QrRhLpL2njTrm8t9i
 t3YlT/FcMwjtzW19sHwjncBWz1L2HiyuQ/8dt+qYDZEPU5wpe+WHbmkgYYGqamu7EUFZ
 TPjZlfCRPV+j+ke4sVWkIRxNKeuRpk0WaFIw7Elv3+0Y03kkLzjPGADZ3sBx3s4n6q7b
 QZm4lYeAogO4q1aMLO63VzjQxW9pPIOQEx7IGXTSqMZbahoGznYWHqk/OU48LQ5fETYg
 Ua0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=03hO2GCs79Vuj9Dxd1j75s5u44DIXqgQ6G60qUV5T0U=;
 fh=dgKixkFs3hS+KXErfG/muTkpopJiS/CG+xsmGTjyGrg=;
 b=nnppm6B55U/L62ZMVEuRyprWU6ZdqPu2U+HZP4DUqLAfDQokF3F6zJLWxKnkTLbcgx
 j+vebmqz4DNU/ZDKTxvwa92Qk2vFb1gW+lf/vJcDn4k4Bvi31VMlW3Y4IXzBZqKr8+/X
 Xx6RG2ipKucNHsO/AI25dDoKl5Hhj9qNR3a36Ybo+itmrzC/tlUvTB9aYCrX0y8mNWNB
 yNp6UIHRPfD856DiTk8cmeTcQdETQTCEwIBXG7SQ7gNAGdkqMJIoCiieUCa+h1s0uUIj
 2vrXQN5br7v1yG/D5J3r1t1rQ293WnZdY2IpGr+cWR8F0X3aUu+7KOHmIMrCMOmTMN/5
 pUUA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791896402; x=1792501202;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=03hO2GCs79Vuj9Dxd1j75s5u44DIXqgQ6G60qUV5T0U=;
 b=qbiwBLEgSIf7scU9CR2OAFuWUAXxnE2pfgJi2cboW+aAu9fznsSo85wmL/Xm0oyxyc
 DZLCAIT47Cig/1QtDKH/bEZV73ywlAnnBiNEqwtBENxAfxbVMmHUiozRsauT8Bz/khja
 YtLxOHrSAc+fnkjciV00aDq4M3d4gZoOKlXeKpqlpvoWL0CjaJiaomTGKMSrfALu+601
 5yFipKiYAzOCou0Ja/0lLZb8X2cFufmXOmR7HJFmNinz4eHW1JiSZdG/otK0jI7Rjrq7
 tgPC9F2AcUDhEAlnDq/herF4B/6H1Mz6slZUj/oKwdjpCG4LuUPLFNnIHYeML/RtzWVx
 ATmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791896402; x=1792501202;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=03hO2GCs79Vuj9Dxd1j75s5u44DIXqgQ6G60qUV5T0U=;
 b=xI48+45ye7eNiEAJeKB4kX9MOCptiomJ4fZ5ArjEiu5Ik+2RoS1IwMnD9wRVOW5l7h
 YXCsq9hUdq8dxr1ftArIC41TcbMRe46FXvyRR4BEu2vXD+Dvt4jCtOAyo9Krddsl/ZzU
 giGm/AT9+HyWRJOW4Z6ybXciYCm2mqCVw8DlZl7WvSzhnVmhYpNYLg3EdouLsgbHFaRS
 h3/b2V/QfQiory5Ffw5cUkUQ2Cw9XyxFl6ugaf538lx2HQnZyvcJiZdRU6qLbw4n5nVS
 T8RK4cB6Vb3S1lJI1YmYD4mVK4VtskS1MXBX+ONf/e5UWH0kHm1VaJMOT6A9QEwnFDGP
 o9jA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjrGjFssDdQKZkJeQxL7G2WeAlmuv7urilcNlL2AriIwkZutGm7w2sTHaiF41El86KQT6PxLY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLhsFxZpAuwM0il3Es1O10nDxkvca9TIYtIkkzaoJ4Gmckdcdg7
 tLR9+HWtl705cNRTyTiR8SlderTXyhR/bGAdZL4jPlIqpRRL4RMprpGy2qSzoMsl00Tua56RpBr
 Kw0dcicohi9NI3bqUrInrj+AgeZcY7Yw=
X-Gm-Gg: AYBFou24/oGAg21pAWgKB5JLHCJ4KLZa0FEIENoaxTHtc+4zu+hm6LUJCfVtLPIROYA
 R6/sAO7Qi+23fdTP2GQWrgxKBmsHEY0c6aRycLK09/YyEI8lN4qFBULYuagmTaGzHOwGhIX9iuh
 jfUZ4Ox6nkETBLC7GcoP/wrEnApvU0Enf2gGPB7x152OPmL+jLlsaTPtYjni6inWYFaN795AzwK
 rKq1kQUvyDXRMUfXeLMK8RLYqrTcVLNRL87kUwEoqbLagwFMxXgKsQE4fRREXA8zIOUiCZA3Z4z
 T6eq6duw+58BG3iw9LKrEbKOb1QF9zzPiQgw48vLtMs/x1olCuFFSZ/wTjwFJNw0k9HNIhEyz8X
 KZwvrCFaMRaCtlVIf3dOkJnf7yB4=
X-Received: by 2002:a05:690c:7283:b0:8b0:b060:ac92 with SMTP id
 00721157ae682-8b0b060b374mr15199907b3.33.1791896401933; Tue, 13 Oct 2026
 06:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20261011070600.2788775-1-bin.meng@processmission.com>
 <20261011070600.2788775-2-bin.meng@processmission.com>
 <CAFLszThH326=6CEt-1mmJjm+w9HR+TnMTKoVRwqouPD54Gcm-w@mail.gmail.com>
In-Reply-To: <CAFLszThH326=6CEt-1mmJjm+w9HR+TnMTKoVRwqouPD54Gcm-w@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 13 Oct 2026 20:59:51 +0800
X-Gm-Features: AclHuK_-ESBoKc_4tWT5W5Gqp_e4x-4BGK-A-Us4pUgrHtL0cOzQ0ChPz1Jk0fU
Message-ID: <CAEUhbmXn1gth455NMrFxJ4haj-32dZQigPxECRBkJA801Wn9Mg@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86: cpu: Implement cpuid() through cpuid_ext()
To: Simon Glass <sjg@chromium.org>
Cc: bin.meng@processmission.com, 
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Tom Rini <trini@konsulko.com>
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

On Mon, Oct 12, 2026 at 10:03=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> On 2026-10-11T07:05:58, Bin Meng <bin.meng@processmission.com> wrote:
> > x86: cpu: Implement cpuid() through cpuid_ext()
> >
> > cpuid() duplicates the old EBX save and restore sequence and leaves
> > the ECX input unspecified. This is unsafe in long mode and makes
> > queries of indexed CPUID leaves depend on the incoming ECX value.
> >
> > Call cpuid_ext() with subleaf zero to reuse native_cpuid() and provide
> > a deterministic default for indexed leaves. Keep the existing interface
> > so callers do not need to manage individual register outputs.
> >
> > Signed-off-by: Bin Meng <bin.meng@processmission.com>
> >
> > arch/x86/include/asm/cpu.h | 28 ++++++++--------------------
> >  1 file changed, 8 insertions(+), 20 deletions(-)
>
> Reviewed-by: Simon Glass <sjg@chromium.org>

applied to u-boot-x86, thanks!
