Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C01C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 04:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F93260AE5;
	Wed, 29 Jul 2026 04:56:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v6J51k8gccPi; Wed, 29 Jul 2026 04:56:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1FE6360AE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785300960;
	bh=GaBugiLN8oeBHqVSNj7+mTGlc4ljKe1iWdwgZWktNgU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LzXWJ7xD/+EBP1OYKfJCvJUpvNfYttcKgWdRCy4F+j+fLYAfQZxvTNINtQxYQBoJp
	 sf4q+KUjIedBIPgCx59f8+InjCmoXb8kl7FMS9BSOe4895vk97ujLJXvxQlvhOPbBW
	 yYKu5mhTAamNakjh0r0gHy5fwlINwiVOUVSe7FbCrnpBv7doq4U4YhzU5lUjce6xFX
	 TN3uNsS4UqvFJZ+l5VJU+sT7TLrL/2e4KV3sCdo6Qzn1cdeOSSN3tOkLf3L+juDohR
	 6+x4jG7YIjFIp6o8xjay90cd4Ma/ahEbZxmEG7Y6noFEw81iKHcN30baQREru3q5Uk
	 R4nwpqJ0b5mRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FE6360AE7;
	Wed, 29 Jul 2026 04:56:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B623C4BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:03:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9E26581325
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:03:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lRb9uoIukE7h for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 19:03:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=bhargavdas100@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BA65580CCA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA65580CCA
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BA65580CCA
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 19:02:59 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-69f2c67650aso144556a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:02:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785265378; cv=none;
 d=google.com; s=arc-20260327;
 b=aP+Xj0lJb0m0IlX7bMYIdJ5SCAJekK/7f9EXSss/3CQXdscKV9s8Hm36/r2UtAvi1F
 zyKywhCwtjiz1eiB7F2Qm/Ced37TWdoEtCvR8Qidpu34LZgUGNqWBD23iy2lJgk9J8mv
 pSXlxOJGCVy7qWlx2szluOjwpCTS3o+6AN5/rbpqHLtvFBSfQuteAC8KSdyCKMeIq17c
 EDd8kndpPK7niUnAQHSSK186fR9jv9JmCXxPcKAYHV3RhAU+dbuk2Um/wtYnkrBlyA9a
 ik8QmaqCAzKiKcEMWysATdC1aUIpgoBPih+j59q6sxaT2rYXvzZA12J6DrT1gtSCIAJ6
 sEeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GaBugiLN8oeBHqVSNj7+mTGlc4ljKe1iWdwgZWktNgU=;
 fh=qgasSHWK9ABu1C4X6rYrv/IN0O2UMctworj4pvZ1u7s=;
 b=XAH8jsjFiwzRiY0OMLVjs414/6qsIEeqnGU3LUGxwXx9pWFomQ/59w2bQkVrMjk2R/
 x6kCsdpOsoh19aP/m/TdbkMfVfA4D0k/jHx17XGp9Poenq6KpwY87+fuLPD5KT9kDxs6
 fR3OsDsdP5kWIRuRMVggE1kki6ilk+nfyaN+9oQKvg3dMSWe4uOgQ6Bi6l+Pn8XK1/uh
 RVkcGDZ8el+h5SkNH2upqpvdm4AFVGkAXxtkSrAZAgmF8L8Eb8+ZGPHKi9HrxuEzst4I
 WIJEKd1P/sikDA4x5Qcp8aFseC1IRdmTIN3U7CHo7WUSx21FuT8PfzJxKR8b+GXebTIm
 FpMg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785265378; x=1785870178;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GaBugiLN8oeBHqVSNj7+mTGlc4ljKe1iWdwgZWktNgU=;
 b=aj8GmOQ4xJ3H2zb6bbNAcb0dCuOkUgmAdRgI/UGF+MLAr9ctriljVtWqse0YtWjSiK
 ckVYzTfK2oX13RS8vNIy3CVtx+HDzXMhj622WNoSRaMR2NP9VAPqIyphuwcc+rVyrhDt
 Igtk81SgLhm8pH1xz8qOOCukeenKMCcQohxUh1ABpQ+7FcBNqi3eoeRRmMtPS063nBCg
 8CyaY65lXY9n7vhoDXpUBlxZ0fsO+Tc4wzy6IQkqNdukxvvX6MBvZvs97WTATtw3zzxh
 ZgY+bts/78NvH4BY61dnvUdm3+H4/8c5Kem4LKEIbli7rtd0Zh1iHLmmJ5gBuJkHh8Ak
 OqkA==
X-Gm-Message-State: AOJu0Yy03MILubCD5K6Hv3wjmlXnxWQxz3LGaeJ1ZWF0Hu2vtvH+mMVR
 WePRUwgdaQc72t7qMreJ1PiBRU4Pb1y3z9tAbtG75YUTh/wMnXIOZ8V9x2ABjdBT3tnH5bgbers
 acgbXm0KnW/pMbzw5PA7mfGL9Y6EFhqc0Ap3G
X-Gm-Gg: AR+sD10rvaCNLAt0oOcDo4xPtOkmGOF5QTfYku02lGedlKEZi6OsSDyPO2tndQF/HaK
 xEBSrKlT/Gd9fU8fnzjk2+3YgdlUFHldQX1TMcNQnn8wrtCFqU2Dz8Vt2llK005AjTYReIsZGaI
 ARR2W3crtb5x5TBi1Lcw1xAT2afbz1XkPXhBjaoBV6N+Nr8Lz9m9o7HvSLBSigpu2Syf40qkOi+
 sEhniBsDXd03YberiTkX75iGTXTEh8apZc9OD2EqYvc3JN/Vf4Tm5K8FfWOef4=
X-Received: by 2002:a05:6402:4499:b0:697:8d48:7fa7 with SMTP id
 4fb4d7f45d1cf-6a034a5ed84mr1925676a12.22.1785265377610; Tue, 28 Jul 2026
 12:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260726115702.15397-1-bhargavdas100@gmail.com>
 <CAFLszTgw5qa7iE+5o5w2iRxV=38G3csTrj+_oF8cTiFzOh8W2Q@mail.gmail.com>
In-Reply-To: <CAFLszTgw5qa7iE+5o5w2iRxV=38G3csTrj+_oF8cTiFzOh8W2Q@mail.gmail.com>
From: Bhargav Das <bhargavdas100@gmail.com>
Date: Wed, 29 Jul 2026 00:32:46 +0530
X-Gm-Features: AUfX_mzwLfYS7GkbVQOp_Razcz97gyi1rNs20DB85jLIkgNmYMShQRTAaNvCuKk
Message-ID: <CAPEHo3+=qV--r7CoGhirYcO3PxMOq=NCgAZ57R=y9YogMgygcQ@mail.gmail.com>
Subject: Re: [RFC,0/3] Add initial Raspberry Pi Pico 2 / RP2350 support
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:55:22 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785265378; x=1785870178;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GaBugiLN8oeBHqVSNj7+mTGlc4ljKe1iWdwgZWktNgU=;
 b=QKgneNRDT12CQXkzrCACPn786hxd/sqTNF9YPfIHbwyx8tRE39wI4UcZbqGMlKdYH6
 xH2oO3P5ZWJVAYogrAgMZWrpcXLzBxsVXnYzLAaDDE2tWP19nkCEPDUYJ9GfZC5cCkUo
 zY4hoJLLdJpHRbNgT50oQyd3Xn+YmBKCQ6ohCRTbpCEuFKnFKBRaqj/jr10I/vuUZiu+
 we6WMr0iP72LGAMAc5W1GydhuCbspo2HGLGizH1p/s2M71zWE5D3ContBr8ze0OwecxW
 1KanXOxyJ8tW9VTtrF9XawbCYmsOQBPjcxLnnHiCUfqBaQCyPW13pPhYnDvCDijDvN5T
 r62Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=QKgneNRD
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Simon,

On Wed, Jul 29, 2026 at 12:23=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Bhargav,
>
> On 2026-07-26T11:56:45, Bhargav Das <bhargavdas100@gmail.com> wrote:
>
> > Sent as an RFC to get feedback on the overall approach before polishing
> > further.
>
> Could you also add some docs under doc/board/raspberrypi/ describing
> the SoC, what works, and the flashing/boot procedure. You already have
> most of that material in this cover letter (the picotool steps and the
> bootlog), so it should be easy to turn into a doc patch. It is also
> the natural place to explain the 'why' that Peter asked about.
>

Thanks for pointing out the issues and your valuable comments in the
patch series.
I am away from my setup for next few weeks so please expect delays from my =
end.

> > This series selects CPU_V7M for RP2350. RP2350's Cortex-M33 core is
> > Armv8-M since there is no CPU_V8M support in U-Boot yet. Is CPU_V7M
> > acceptable as a starting point with CPU_V8M as a later follow-up?
>
> Reusing CPU_V7M as a starting point seems reasonable - but a proper
> CPU_V8M variant may be better down the road (you could mention that in
> your docs).
>
> Regards,
> Simon
