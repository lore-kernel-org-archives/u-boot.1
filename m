Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55F9606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Qepkl7Gi;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bjBw2bQE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 897C380F71;
	Tue, 27 Oct 2026 16:01:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ROajS6e5QYvX; Tue, 27 Oct 2026 16:01:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C212880F72
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793116917;
	b=kRjb/tpKqQY7NV1QcXlDm5H6R2MoPLe11Cs5d01pZe+dp8WIgzOqubK14a82U0iGLMBu
	 qYIwa/QdyPLy5H0+KpSqji8fL/gIDsXE36NAGi58Z0K4O474sAjqdmykBv0TAoshkgkIg
	 K2b5l6/ykfgqVTgL5ct6F4eSmbQpyxy6kkSHvpRDDxx/lVMuYyIXG9tnpnyuInw8N4C8g
	 rpGfj+eKNhHnwoT6b5ZKZ/fLJI5uqf5RoK1+76jOzPCCagarv9ArqV3nZcA3wgYO11A69
	 YOdcU8Q3gbjB6RmPvUnuDLG8G0vSKpkWYG8HbdDFfpBOYRJ7vOC64zECADnvl7M3Dqg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793116917;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=SdhmtHx3YjgNsSn2hutPPsu9V5ar2oI8D6BKBwj7iLM=;
	b=NWQbgzvwT2jN7dtC20At3bRSLhYrjifzt+c5y6SY7jw0e+73n6jI1W4weP5u7bInvXHu
	 lMSGiNeV0dzG7sz3u3L6Ye/D5Nu/sIeG+0DA4foSmFkVkl5k46bzrEgqmviXk+SBhTq05
	 3nwkSbI5pDw5aHqo0upQzpG5fA2UOF11MzpXnGq123x5Sp+quL9ftH1gsQtzSOCwF+ERs
	 S9cIbcSdSNDMr2GAa2DfY1cKtkyr9PtxfSkN81kyXG7t/tLAGwC54m4nmL7nl07sLVLaV
	 NNb+R413sEg1OtdOt08FnY0sDJJr9+Z+rzL0eP6iObLug+voMK+vAGJCjHE9ohemdZg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bjBw2bQE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793116917;
	bh=SdhmtHx3YjgNsSn2hutPPsu9V5ar2oI8D6BKBwj7iLM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qepkl7GirfEYwgnypatOPpZXJWM6z12kg1Uyt/GS46secyque1QFRF2ApMllNJ+cn
	 jSUIvh9G9f8gmkL9J/uu87B8ptMT2Fu8eUp45p9E2jF0J9n0tmBi4GDeV5wNgT3Qrn
	 poOs5NayPGUdjRKoq+ut8g8HmzlDRgrfJXVjfadkBUzdePIGtlKH91099HUC+cojzr
	 bPpAGKlkzYNjS3YoXeq108MvdUoss7hm/lXYyh7vhUR9D3jetBbTOuFGDPpVFhsKg4
	 /mW3jKaq6ewC2D0oJK4iDd57FKsFbGThbL2nqHHDflCs+V5tnOT/vlgejA5wwmJiEV
	 9qQkgTifLeZCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C212880F72;
	Tue, 27 Oct 2026 16:01:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C978279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:21:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 81BA380DAE
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:21:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wxr1x8IbzS2H for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 14:21:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 838FF80D7A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::236"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793110900;
 b=V5Vn44aL6dukHaOCMShTTAwc/NN3Mwrs7XYa18hwnT+AgxtfOm3ffb79mW4z8XwjBejw
 iTud2h9a5je2vvcJj5eCakzszaj6nSE2B846qz06wwtAvc5BI4q3VxwxbLLkGrkWhfqgL
 HBj7za/Z8dpN5hJ6HflNST8M1BxwLuUrS4ToHWG91kJ8WrKOOjn60syYfTFBD3atFxHVL
 RZL6hCBVT8TzoPWMgRNfzvavAL0McO8xP9KLJ76FYaUmm1r9mpI4UAMhpw8cclNoevaTA
 in9nU6hNQgZlW760i3QnF9YEqbkEyput8J2ilO8z0RFFqCG+ltWrDhxQYG4e7xeQluA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793110900;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=SdhmtHx3YjgNsSn2hutPPsu9V5ar2oI8D6BKBwj7iLM=;
 b=PCJSoEqxd+Tu5MrR02BRDmEMDOOOehH9gfpQHrT1V0eESkbceG2YkwjNgFwenxd03EQU
 t8sx239ngb+Dtrd+2A/VEUnLVFu+qDbntD1IBLlgWjTJzNtDV5cqQTIzYRK36mJVcm4mM
 WXMuiG3THlVJvMIxfBrdz+ADq/tYxXWLZxKYAMaKyzWHZwyVIHIH/RxEpV5LgzAOTemJv
 XkHGZkrAF/hZyr3oR88Z0nWeUdedPW2wW1C42XXzfI6gP8S6cBqv9HjivseDlaXLLXrgD
 gQ4d4iah8vM41wtuqBS6EjJpyvAjS1KiyT8oHLSWrRCyeS2nKM8O9X7mwDIA0DzyZtw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=bjBw2bQE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::236"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::236; helo=mail-lj1-x236.google.com;
 envelope-from=oss.patchbox@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=bjBw2bQE
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 838FF80D7A
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:21:39 +0000 (UTC)
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-3ac91f5aa89so6680081fa.1
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:21:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793110897; cv=none;
 d=google.com; s=arc-20260327;
 b=gTt8dckcQLG2Tw47hnCsgFs0HlWeeM5Ry4dCkcLSIGNvE5tth6FLfqiC4YlGt0ME/J
 yFbiBBlIrfu8d3Q4Q1pU1d1geijfoMAw7JF5d2QNtM0KjmuFJrW6pMA89ll3vjIKY3GN
 NQyiwWqhwKVVkOPMgpNt6ncT1o+wB8FyWu/kobc6iaO7dxOxrcpay5T0B/t3aqeSAHDu
 M4s2wxrxZYXrG5DdO8XKtOCsZQovfMIl+DmRWRnuGTTFOqaV4oF/qxvCGzr9umBM2HP1
 cmgzwKjy4ZMNitVlXEJRlZ87VojvQzv5qZ89UApGz5oYBE6QJqDB3im8+O+0W9fz110Q
 pH7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SdhmtHx3YjgNsSn2hutPPsu9V5ar2oI8D6BKBwj7iLM=;
 fh=DWQwWY9o0eVE04RUYNwinJ+obyJiHnyPSsw4wbAdImk=;
 b=S1zlOw4rIjGiqvEZIfMYF1VH9vps5HDebfT+IkYW6S1XW62z9NiKDtLVKIQRRwEl9p
 t6y0TZwJ/GEyAh0d8vPcLpqmckF2upEmZ0uhjOKJ+KLWVk8MnI0dsxE+IqMjiDGpjK9G
 8FKOZptLvaIhRyKvkdt5sh0X8pi/Lpxmc7ITPMUU9n9RmA1fIjQhM+c2M7TiNzFvzYH0
 OsfnqAHJ1W3lzNVPd0YS/L+iKOuxBRcUBAbtP0ShXQ8BcfFkZKajBqNPuqAjEBSTLgRB
 d5fhAhfjVPX7ykIAJ+lRnlIBVzbkYQaZ5J+4kaUNz13tuhmvhnM/+4r8IJIVswbnXgO9
 rlnA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793110897; x=1793715697;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SdhmtHx3YjgNsSn2hutPPsu9V5ar2oI8D6BKBwj7iLM=;
 b=bjBw2bQEVGnRPXLvPj+eOkFpiiWE1WL/Ij6qel6dUjlNWlNfgmBJvnlmp/Ogx3yuG+
 xIXZ96ClpAAqhaR9xgugYK2CLq7pEHVHD3MitlcjltCSelg1xQ3BIMHRHfng4QKekU4V
 9kKwEtQ9GeSaX7/vJVMxlBA3UpsAhpMnGn9aLz7dAChPL3gd8y7P1by3OHfvS7rGrzMq
 oO1gzQliQGn3M0cb26egb88xWB87X7pGsi1PXYjd8fD1Z0oSk4pKnvyJP2lmIYOu6EHP
 049QJTlsHIJa1ffRZCS8SbKliK+Pf65bPAYYf8f4NxaIIbDpjJceC60Gs8tAl0jTrQ5u
 msHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793110897; x=1793715697;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SdhmtHx3YjgNsSn2hutPPsu9V5ar2oI8D6BKBwj7iLM=;
 b=stn6GhQgqPv1Kb7OTuBdkuCm9m+2M2KpFsr4zvUkWhwuBOJZrE50kbb9ZEPQUdJep0
 6He4nx/2YU0vzbpzGWama/O+Q6HF96u2dbJky5MhEBHDTvMWjMMFblrtUQI63Zulh2Cl
 BzJ80tViUBazaM5CWn54nocMTiMPe4PZcmUw4UWkdG7KPERkh80F8eFsricNuqWWb9iR
 xYjQ/Bo5ZL7i/iZplGrE/OQTD9R0LdmspDSgpeAvVNqi4YOJHmfv80mqVT28RT0TRZRT
 oERmfuCC6kg9ef7Ym4brFn5Z0ebjndiUmQmPe+WdTiJ0KSQcHyfekrzXdajJZiHrrEDo
 JniQ==
X-Gm-Message-State: AFq9FYJLq5mDlHIFRCf1Y9LE9s0w7uzaxRbB4h05uBQPJ/IpeBUuQiCV
 KPKTRRfCiVgFnMFPOtEtfpLQyEtaKK86cd3qF4rjAzHiMA6XXvZhBXFUkuES6CK+lcCGyJfkEly
 x6bUqPncKT5NbhWHJJyMimtZeGL0MdSk=
X-Gm-Gg: AYBFou2rS0YH/S4d+x9HARmlM6njRstnz0uT14Xp9nVDIJn6yWOby0oYRo6SV65SMxP
 XPV5762We7Fde456kKIL65en0vQDEQcmptoXnFydvD4Q1J8I79Ec7BzImnxiSrI3qNR8dlM4y06
 FPY38IqRWec1PfX+IbZbz/Sg7AlBxwilLk9+PpsPzsjxfsjLNWjRj6LDBwzbBATHWUY3R7eJtas
 9lmwXPdO1k5eu1duplbUo3I25jYX2ocIGkAjicw0qwGxIFMTsNAlUsj7rkVD3r2MpCdSeE0Hrpe
 HlhnHRYSQquF34soBd1bykklHJF6vq/gMKI1N0H9B2Hlawdc9772eYsgDlhap70Nd85SmusKWYH
 uRi6NIOj4RGvHLGfGg/qQ9O/5XyunS5myoNs=
X-Received: by 2002:a2e:bc85:0:b0:3a9:a1ed:633e with SMTP id
 38308e7fff4ca-3ac6fd3e4e9mr29295771fa.25.1793110896687; Tue, 27 Oct 2026
 07:21:36 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026030925.1002846-1-oss.patchbox@gmail.com>
 <CAFLszTivp4YSez0u=AfLjcY7oGVan2_1yL-T4d1woRos2K49jA@mail.gmail.com>
In-Reply-To: <CAFLszTivp4YSez0u=AfLjcY7oGVan2_1yL-T4d1woRos2K49jA@mail.gmail.com>
From: Yuho Choi <oss.patchbox@gmail.com>
Date: Tue, 27 Oct 2026 10:21:24 -0400
X-Gm-Features: AclHuK8Qm72RxgWnSpiRCMp16LRe8bCEHUbNmCGhr-LemqhqPz6d7fafE66t6Rw
Message-ID: <CAGG=RgDDq3F8n=vjqjfA-bZipSTym2-OvDzo0ca5WjabeA+4XQ@mail.gmail.com>
Subject: Re: [PATCH] dm: core: Unlink the device when bind fails without
 DM_DEVICE_REMOVE
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, peng.fan@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Tue, 27 Oct 2026 16:01:55 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 at 09:28, Simon Glass <sjg@chromium.org> wrote:
>
> uclass_unbind_device() only does list_del(&dev->uclass_node), so both
> branches now do the same thing. Please can you move
> uclass_unbind_device() out of the #if in uclass.c (and drop the inline
> stub in uclass-internal.h which returns 0 without doing anything),
> then call it here unconditionally? That avoids the else and keeps the
> uclass list handling in uclass.c. What do you think?

Hi Simon,

Thanks for the suggestion. That makes sense. I'll move
uclass_unbind_device() out of the conditional compilation and call it
unconditionally, while keeping the sibling_node cleanup as is.

I'll send a v2 with these changes.

Best regards,
Yuho
