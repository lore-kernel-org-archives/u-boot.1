Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A03B606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rM85mXJj;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=A3VMYS/F
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD4ED80FA3;
	Sun,  1 Nov 2026 13:11:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2r0d28l4a2SY; Sun,  1 Nov 2026 13:11:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8F7FF80F90
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793538691;
	b=Befu+8ogXb1fNkfzDXCA4JGNpU3NaS91rm2z5gbFATTq1So1Q1NGjN6FWgLgekDa5cNu
	 zIx5mRtl3HAHCKOIEpsNkJBEMoiMZRLG8PgHH/2v4cq3ZL/X9m+SbizCIQzYH4wjpeH9t
	 93fotuKnn8FwBCF0ucdujS3RDW3ilm9ItrfLQhuWZXtkG2zAMYOnhn8SANcB+/leShN6E
	 S9ZT831eKL+O+pCc8fWwxEbob12bcxK4n7ujkCUlHN6uftb7JhQwNetgr6NUER9+2gCKt
	 s+UsMbHgXmh7vBNWpU+WQqGPgHnHtlYtfRcuYnlzzL4Jfq+0CMuzdYMXg6LMj/wfnig==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793538691;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=W8rQ8KA/nH1ZlPgJmagBxRT2o2HV+h0v4qN2C8wyHCM=;
	b=lGzf8KtQFeVBrVNE34S3ymQLjq66Z2svedNcTc2M7UFXH5CP9tsy8EMqLpJEUCu9qm+g
	 w7hKw57S15iWro9tZEXJT3scCSeOrtygi/IFM6g+kAkRZTugV6Yn6x0bLR0oV2+HrXo2M
	 BjxgeTnTMLLcHTsDvw+C1wKIFpnQYmcpw3URqj40feRl8yvihqfcXXRn+IzxLh6uQWUQj
	 +Rr+YowvBmYLZUkabmxGDrtTJh0fyoBgNQE1SoUtv/7HvyhfhnSZWh5nntM07/a7elTpL
	 k5/s0fepj3ZrTMKUERtyIeWYWh658YhnTZcml2l+X+Ch7av25T/C9hPemHPIJ+uw5Zg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793538691;
	bh=W8rQ8KA/nH1ZlPgJmagBxRT2o2HV+h0v4qN2C8wyHCM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rM85mXJjVrtl2Ycv4MqjE78Fk3gyuZ3QFwuqw8hrdMs86+tyo1BCJ4a65Tz1o7CN+
	 X2RECKAcq7VWSi6tVtnBDz4ntXIxI9eBhpC+Ms/F/y3/6OSTyclkeKU42IbZuyWtsf
	 ZoYByLfTNadTb3X8iG6x6WlQHetKaml0Oz1FmUthAX15PpDxutDKbjvNPfbOlZsR3g
	 eFHBeGRcmkVrnpWGwxmmdrW+hEln8dNnxhgleNdpe1ibPQF3Uqm2hk7WXBab/AzZmv
	 nTUchkSreBOpijCP/k4uQP+I/oOC5DIbC22FLt7t95oMWQ+Dct37h7ifIDy3s3pXtY
	 g1zOU3e4SpGqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F7FF80F90;
	Sun,  1 Nov 2026 13:11:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DB7443A7
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 13:11:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CCCEA400A8
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 13:11:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3dPcoIgpAGvt for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 13:11:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8CE7F4004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793538690;
 b=tMbXGWbtBl5XhusnNu1oEjeuhW2DkpcnWh1PcWtfx+AiEI0dDoIguwU8U4hPtuiPgwOT
 eeTGV5MYXgOhYKVesUUuf32PGfBPeAQ/A9D06txO+Oq0VSa1eK2BSEGfXKfwcbypUhtvO
 IiC0GFqczATtDTsUeoj3nc/VvYvWoFexfGG5iaSgwcC5HANtNY7a0+CvkPb+5D+Zvr283
 J3gtn5tz5+l7oj3XOhvdMXylwy1f81xXDm/pBh9n/YIo8aimJtbpPRck929MYd7nbgvN9
 fhFxcbl+i87F5/B/+iwE3d1mlzG/zoZVXNgpHYzZoTiPyF0XMtqDvqHPShSCj4Onhog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793538690;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=W8rQ8KA/nH1ZlPgJmagBxRT2o2HV+h0v4qN2C8wyHCM=;
 b=ELoKfGBk5BGOKXCOfoXk8IyXuHa8jFCHVHr2WZvGu9b24y3XMWWAxpbJ30ZWLS5tV6w8
 kiaH0VRguJECzQeeiddl9t8T5lmawFGxlDEmKBkbAWdKY3TyXgF4LY0Ruy4mPT/JTOVhP
 vNhHDJaVyMo61wdN02xcBn8lpqIJgpVjvzH19ZmHd0SArJFlfjIoEZ/JArik8lAAc7Qp/
 Fc5BDZLigq7ee7NiBdZHMwdQzLwDduXtjmTe21c3uiv4vmSR6TjSe2vbEC3XH8a+NDCb7
 CwD6u2UIvnllSIcwahApQB1Ssh6or1sUEJIMEHGUfFLewp5u5/JZ8I3shRNuV0BhFuw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="A3VMYS/F"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=A3VMYS/F
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8CE7F4004D
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 13:11:29 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b45f9ec1ceso2377488a12.2
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 05:11:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793538687; cv=none;
 d=google.com; s=arc-20260327;
 b=EwJeUiyv6Bmk61Z7pV+9NeDAF7jn22+JFTJeu1D9J+NsNL6MbLwYXrLU8rPT2P8wTC
 vvKiAupzgSc2uQ3dwvXmavUxxukDFDXew/cCXApB04ZLpaeSLIF9zkCNSnbREiT2uNBR
 ERpvbrreVqGu1m8pyKGqtbaLNDnHzWfzO1EzRyqFlts6Nq4iOO/A1B4ydxtpjl/xh5kn
 nZI1e8loU/RGoaZbv8ueUN2f6oZUCU0X3HX2it3s/4vzqWfhY5yabqM9Nw50T+/gGTJ4
 b3Zky6f7hUrCOz4Px3HarBq+JMkEJA5sf5ClJVCw9+oKhHP7Ohbb8BoP41rbI1aY+d6L
 jScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=W8rQ8KA/nH1ZlPgJmagBxRT2o2HV+h0v4qN2C8wyHCM=;
 fh=S3P+xOKe2N2+WB5LmGdQzo4EjW5190+DQBlcKoe+QVk=;
 b=DWQJVwJsvWaac2QozRQyGMsi8m6JdlysoLJ7R8eNr+UnRrntetP/lFn8hCp6g9YDfD
 HuZwpBYI3KbSM1BR3p2p9uXLggJnc5KRnIy69Em/BPS28y+3slUFiS48toeEvJAVIVw2
 AbUXAtxsWAvXmUJoNqc6BsN/jwhP1Zfs+GCqiDAMgoE+jhLL11blDoxIIvYLtDL1gFZ9
 BJTIv4v93xVhyYpVcqNk+g4wcO5tawmOD5I7aUJLdJTlMev/Cy9j46Z0SyCDaxDStQsO
 SReIxxU9mouHijS/rra5kY9xLTiBQtWpUtdO1aBKGjE6rG56oyYW2sT322EY1i2hBeFH
 xGnQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793538687; x=1794143487;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=W8rQ8KA/nH1ZlPgJmagBxRT2o2HV+h0v4qN2C8wyHCM=;
 b=A3VMYS/FbuYfkhDthNTD2b3jxJrIeyCi+P/HF21tHEgT5N1BcxEvCU0s+RnXUwTssU
 7KDQBofSe3bRWS/rjNTGpaNpzLkwJL+Z6ElXr9nMrncczLtMpCOKbG5t2hRcu1b64Qt2
 OMSmCjlxtwGu78m9C6CZ+eINBLWhabvyk+HOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793538687; x=1794143487;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=W8rQ8KA/nH1ZlPgJmagBxRT2o2HV+h0v4qN2C8wyHCM=;
 b=wl2nFFTOhKF5h1mO4IZ04HM0ZVNbVBsBABqvAdxhUzVzRSaYfL8jRPsIWMrHxvjzLF
 EaCqBZn3zmHVJT1+OCp9xY45AxUIygKTpEQHAycwudP0y+zmhQOSltoDHLPgMkUdKaf4
 mcSINLeoMMy7PuXv/tlIo4uCtoWPYnrHo2Tob5DK3ldDlwPL7GZSJ/NGcMIWtY2jmK0I
 fbGBUtardYV0CR33x9yWV1YpgqV6Fl7sfToW5yfFLuU7g9JeZZaRjuRDTd6MnQGxDtEC
 PLFCVLAxHXs9GmQ4p+wmrUV3/xGNFhRKl2CkybNyTgNoqNwhPLPJoXwwqEpmSGWEwDAW
 7gDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByZFYz2uo222W8+JOmA/HboSohRmR1qh1rubVozdAZbZaD5OCKCpMFrRDEQOhMmRZU1MJ+SNP0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/JTf2r3Y8Cz+b3F+6bPaBj/zys7tFXtbyq9I4uK80NMqOQOx6S
 DRFmbiYrRoc5bv1ImZCaCLIsbbtJ9BSxfXC6I76z0FXXIpT+igVJSq7OQsa5bZrUkzWGkQnRYhE
 rxihQZH+XALJCAqyoy8zNr15WUQvwxR3nmaMqPDWL
X-Gm-Gg: AYBFou0/Bac34vUBbNUKoKX/W2mJ09pX238wlIx3fOqiN7Sc7aJl2dEAxRwG1/4Pcof
 Sevy1aBN3LjDRSvZSKL2FY3f3TQIkX9OU7j/cVYMZqMG9JQmxd2P+CG6mJlMjUBcbKYwfdjm23K
 QIpP3Qi3PkpLmnYzTo77YqtdnIjX0wZ9OxSn8xcjYU/iUTfMFHmWJXsP91LMDtpv4V+2cfXjWPk
 P4sAOJJz943hMiwuNqy52DWH9KEn6sIaoO3HFGGZLOrl552moTnbC0kGTu4PQ/hwdEdBYS3Yro5
 PBj78lIFBsUXlDh0GgK6kwSKF98IDnyHZub9sMQaJLmnaIPRfSGiYNJqqIedfzj2uNV2elZ9kz3
 eHK7bYWqoR0UN+pz7psbnWLIKh4/5ISw9n6QuXdj9Zc7YdPHjRFKBzvCrjx4r1VbSiDVT9Yi0KQ
 ==
X-Received: by 2002:aa7:d658:0:b0:6ac:62c2:bd39 with SMTP id
 4fb4d7f45d1cf-6b4d4675a61mr3629752a12.10.1793538687062; Sun, 01 Nov 2026
 05:11:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026-rfc_i2c_nak_suppress-v1-0-bc01e8393b9a@ti.com>
 <CAFLszTg_ob1mTz9=Nh0BHM-yZDDoyYTu4STzHgk5tWALyZ5yZw@mail.gmail.com>
 <4d4a46e9-e75b-4bc2-a0c6-88a0bbc13b3b@ti.com>
 <d8a62180-3baa-27b9-d98e-08665b00ec1c@nabladev.com>
In-Reply-To: <d8a62180-3baa-27b9-d98e-08665b00ec1c@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Nov 2026 13:11:14 +0000
X-Gm-Features: AclHuK-9agPi7Ieo7SNNX6Um7okLH8HAZZzVcDnnGQXCTtpRHUQIWs72mdfsXos
Message-ID: <CAFLszThBeJy7wHdQRZO_tXw7_2=szSyCK=9LJ9TB-_sZX2OzEA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] Add i2c ignore NAK support
To: Heiko Schocher <hs@nabladev.com>
Cc: Swamil Jain <s-jain1@ti.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Heiko,

On Tue, 27 Oct 2026 at 07:46, Heiko Schocher <hs@nabladev.com> wrote:
>
> Hello Swamil,
>
> On 27.10.26 08:04, Swamil Jain wrote:
> > Hi Simon,
> >
> > On 10/26/26 21:40, Simon Glass wrote:
> >> Hi Swamil,
> >>
> >> On 2026-10-26T07:16:33, Swamil Jain <s-jain1@ti.com> wrote:
> >>
> >>> Some i2c peripherals do not require or wait for i2c ACK, so the series
> >>> adds a flag(DM_I2C_CHIP_IGNORE_NAK) to ignore negative acknowledgment
> >>> (NAK).
> >>
> >>>
> >>> Our usecase is SII9022A[1] hdmi-bridge, while reading the EDID block
> >>> the bridge doesn't send ACK (mentioned in programmer's guide[2], pg 22).
> >>
> >> Thanks for looking at this. Are you plannning to send a SII9022A driver?
> >
> > Working on the sii9022a driver.
> >
> >>
> >> I've commented on the design on patch 1. It would also be worth
> >> checking how Linux handles this for sii902x, since that driver reads
> >> EDID through the bridge too.
> >>
> >
> > Tried following the programmer's guide but will check how linux handles
> > the EDID read for sii902x.
> >
> >> If the generic flag does stay, please can you add a sandbox test in
> >> test/dm/i2c.c, like the existing tests for the DM_I2C_CHIP_RD_ADDRESS
> >> and DM_I2C_CHIP_WR_ADDRESS flags.
> >
> > As per your feedback on the patches will try not to use the generic flag and handle the case within
> > the driver itself. Will re-spin the series
> > with sii902x driver as well.
>
> @Simon: Thanks for the review!
>
> please try to not drop me from cc, thanks!

Oddly this patch had CC: instead of Cc: so it didn't work. Apparently
this rewrite is somthing that Microsoft does? But looking at the spec
it has been allowed for a long time.

Anyway I have updated patman to support CC in
https://github.com/deinde-dev/patman/pull/226 so it should not happen
again.

Regards,
Simon
