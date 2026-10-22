Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD379606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 08:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IBSfNvzp;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Fl4/KnGu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC6E68135F;
	Thu, 22 Oct 2026 08:26:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OpQopFDSIiXo; Thu, 22 Oct 2026 08:26:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D9EF681329
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792657594;
	b=g1yXEzgXvXbbBk42uAOGkTYH4X+iCHs8VftzblGqc10uGhAncItQ/C72TCN1IGZFe546
	 j3RtXssIqkDvQgrMAi3hnedgHEFytdaR3qv77q9kQjVRyAAeXhJVy7P2kP8bs6NrOPcUt
	 P99Rvyckc1BPI34LR5zDDv/30FWgVE3aPoGGvM2+cQxeY10RMY+C3EiaLc9vzfnefxV9t
	 8luZZ/w6pbxEg/WfU2Uu6RLbzBqVLES3iWS0UdiE16M0bV8/3/kGPrslrCqFi/yuVSLOY
	 c3LdrECRCBIQ4Plp9uE/SDp8IdquTuyvCq1FCMg4gSmZGlfjqAK96gMUKNyQ7VSjJvA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792657594;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=27XOPEQvfz20YpHpPgc9dMIM8QOJ7JZHFuc2qffFaVI=;
	b=Cf4qSXcL92yQJeBrZOfm/bBYj52aXIaK20tCTyNvmtzcEtBM1LW504YHKbHq1ES69y8X
	 beci3aSVHc6E8Lxu8TqLxHkY5fM/9wOGz45+Lu0Q5iLQgWeDdiuCR5nLnFThLAI8HoQAZ
	 4cofKtNRvUQMuB9iP5KDIRj3j9XJtCk/H8f1fPYj5Yra9aJH+dzg5j7Nu6SBSxROIRMvj
	 b1UyL+iUSHyfRsg2/SJk4JCq4GN2rkfffeegW6jg5m6kTTWGNYkc5qwFYWLP2G8xgoNmK
	 0A+dmxyg9Rd7mkoyNOynyZtztNqhVSnuLI0XENmHtPPeeKuPEVqnHyTyuCHPTzqrnGg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="Fl4/KnGu";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792657594;
	bh=27XOPEQvfz20YpHpPgc9dMIM8QOJ7JZHFuc2qffFaVI=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IBSfNvzpgcb3Pxlr2xy053HNdcnUVhoqmP1Vsm2DGxuQdVeGN707U8hn0EA1t+OBf
	 IEC+WwMe7f2myYW5OMm0ti2wFaURrTxjEilVabsslbyjQbRhzqRxvOuSqocU+G/nAN
	 gOjgZt5fPV+t/JnpJk/A8R0wodEY5uVGvDxajG7Mx9vjFwV/GoIxgboCy8nfJyAvf/
	 inN7ougFWWThnucRIIFnAr19UmXaD4w6qdN8RYjNIsNFCwvm4xkImshs3RRF0DsTTk
	 hhJE3fqUPE62ZeLwTT3z85MxabRzmSEbXzQUvbfUo0w9X00HT5fNVrykFGF/OhZX4r
	 OdCgjdcb1x0yQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9EF681329;
	Thu, 22 Oct 2026 08:26:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 555AB3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:26:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 516AC812CF
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:26:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mWGvjNTstjZz for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 08:26:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3211081237
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792657591;
 b=QXemnSfvQupdS2FevVLz2c8L7Xkygo17NIH4NDeRykLyE6BIXKMSqYEwTw+cyZp0TIFG
 t73vE0MQeyzZDm+w2S+zJb/5hWwi4w9WUJGPHAVf94uU58JEEJIol3cdfJzq54NM3SpXD
 rKiTNgjuiNYHPTjm0MfH+z3bgMyVIrDI+rD2CXJXefgtWevmiZ4qac4u2ggQqudJ36aOU
 lSTBi6jafu/9FnBgii07sWW+y0EP6n9T9JoIujL9cWGsDZ8LCu+VybX4uQrYa4sgy39K4
 Smxfq8Y6PxGFba2lUObblo/wv60Bte9oM6BDjdgguR9+IMXjQ7XDvYeS721u60UrIpQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792657591;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=27XOPEQvfz20YpHpPgc9dMIM8QOJ7JZHFuc2qffFaVI=;
 b=Kk6X4Dx11Q5cz2AwoOS6X8kDR1GDkvtbBUHST2iqaDWPbuQt/ZekU79damLy2pmQveKg
 hJ/sQ2GWbrrWHHnrWG+uDSkaVp3HeNwtyKci4R/8yppx6k2k94MpYbGMl9sbEb8T+aFtR
 PlbmAfRIo+yKya8+lO7FqNzdUTk68wht2FiqfZHzGsAK89kgsLnHQ4fFwuz2MaxwFRdi+
 oXcgYqi+un8ub86zEssQUo8Nnan+/tVmesuCISUHCsgtU/YzXG3nx8dwx7Jun2Mxa1cKO
 kuuxXfy+CsZyU4mQcjmCF+28WyhlKyxjobKrwrI1DVCPY/iXzHXWoRHBJ5oSEjNHwlg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b="Fl4/KnGu"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::635"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Fl4/KnGu
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3211081237
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 08:26:30 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2e812e2b31bso8335675ad.3
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:26:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792657590; cv=none;
 d=google.com; s=arc-20260327;
 b=aY+3bfi2jPAOb6WT5+nzWXXdwSAu1bSDjVAUfp9pd43NU4B003OXE4fjgcfDMXWGcg
 584+7oJ/cVNjMNyiw04o5v3aSL4X11xgMQANGNDP/a231/bwfte7/LzOuF/I/hlzfE+k
 wH/eeaQOWu/H0ZWWLuyCKbOwV5f6kXv7KB5jvwV6n8u3MSmSnH+/rmOdz29VKQMbo/Sq
 +J/F7fHu82WIVG/uAGf8EmV9R/laui+sc6a7ZvqNytq9/hQhgxy+b220arnXQvjow9IY
 f1ZrKCMBQjE6u74/JVQTDXz2ASW6ZDcFmDG28Hb0xwd3JrUNVxe4cT5tsXcjECs3Dp/0
 B7pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=27XOPEQvfz20YpHpPgc9dMIM8QOJ7JZHFuc2qffFaVI=;
 fh=PdrOO0ErXLg37ymB2VC/iSbYfOlqmXIvFIdHoIAsSrA=;
 b=RwELZ5/xx0isbNjfwCKU4agjFghvU8Vrgnvt6O8nrUlGs7STyHXgL4XH3N1WwCUZfH
 yD93jBx9dxKdXk+XWGdsOdjzdI4xcZF/R7mMk851PJH5svI9kGaNPlvXUGyib1kswbyX
 Aj5UmovEobZXNZACLsXctD97ff2e+NcyJNEWxc5138e9apXrq8l1OhcHRvRXZrtal2aW
 UeJ3vnfcwFBFG2B97uw1uso/LunydnOi8OhdQEFDn3bdzBq83na2gM5m5i6WBMUNZwQL
 khzSCITRM51eYrOwEgtveNwkztwwwDoW2SggyezsGCnYHiFOgXhbdx+BSql+FQ8WrNTy
 OS/g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792657590; x=1793262390;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=27XOPEQvfz20YpHpPgc9dMIM8QOJ7JZHFuc2qffFaVI=;
 b=Fl4/KnGuI9Nb4a1m8chQYOrXJRcndcoLesOQhljzn4/yBXPy9Pj/MXydjibqvhcom3
 Rc60iuep/7LuWX3St8j6sSuDZVudPvwWauPnJRQg+fISs/Iax55ZoNE8XSyGP0vKg6Hg
 UfW3Wnssdm5oJrnWOaCR9G1c2Xh+/WMTQqj6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792657590; x=1793262390;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=27XOPEQvfz20YpHpPgc9dMIM8QOJ7JZHFuc2qffFaVI=;
 b=MxylUHZkMD//eTNTkcRYpabksXCbipVzcgsCtQcsqITLu61z1DcAEVoJN7RLs6gX6h
 VedmOFCl0RdZDY8fkGVLuwxEM45M9X7UEdNvRUx7pk2O7EBkPH0RLOVLgyLl/C6i/CTW
 P0EphdKRs/OoxANzfIenJEl8DClV5Z/8wgppkEte/mfx9aYGxq5859ncOJPwLXPwfsa6
 s9VmM2cTQptEVXaIJsT5YLbxDhsXDC6kZFklR2tTMOuMi3pZndNDk0x74lRgW+v1bqna
 KG2tz+xz689y42/wqrDXSq7FJZeuwsj1ttJoi3ZZCrqsk+Qgs18izX9XMEFBKbgVrym1
 6ljg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxv3J/wQtQgO172Ynm6FeB/vg/cdhjjX4SfGf+DVglnEBuq2vW3bz/GjanDVgrZ/LN6UxnL8oc=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKDkL2s+95Ryv7YHQB6ZIaMh2xxqPaHPPmmKpoaoTjji1bRQ/bb
 Z1Z61TzuGWZHjdvJ2e9bxWKUDubP/VtucNIMzo6k/loPfkkbcrw6SY2toLWQ+rRVfeADLq/Cici
 44jXtJMAass333ofAXv9SqnMaMDcjsi/hP7hqU2C/
X-Gm-Gg: AYBFou3DoCP3zGS7LZkCJm/q/7SOd7uLDlHygo/zZFPfy+3VM0c/Avh+HdbD5YonlZo
 d1alPtgbBT0EKE9Ud4eht3KQCuJAp2CB+VB1yd8ZZ2ramkAdZDlca9/Yan8T99t5kfPnzKJAkYn
 8uLukasZDp4giYJu0ybk7lozh8fm58ZO0fCHc1q7iZZIZ9ybDuqf71jAJe52Yh/uQf6IKCYRYsZ
 pZaNaazEDh0f2Kns3HW5oZNz//mPsiK6NNaypf3n09Mu9WSRHPLFHm5DZcdCBj9t3Fj1TTI72R5
 uoyIedtRbpkaaoFioXowvQJwMvLgD4aBTufwGu0z3yRYp+rPJoKmZXZZXm6I6GvLyetjFXvU6mZ
 XyztIBicxsFLcwTZTRMMT9Fem9/kWRBNwzbE=
X-Received: by 2002:a17:903:184:b0:2db:3b35:1ac6 with SMTP id
 d9443c01a7336-2ea437a72cdmr39710135ad.5.1792657590125; Thu, 22 Oct 2026
 01:26:30 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Oct 2026 01:26:26 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 14:09:11 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-test-avb-fixes-v2-10-997f8f04fd3f@kernel.org>
References: <20261020-test-avb-fixes-v2-0-997f8f04fd3f@kernel.org>
 <20261020-test-avb-fixes-v2-10-997f8f04fd3f@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 22 Oct 2026 01:26:26 -0700
X-Gm-Features: AclHuK-_drxVLWJPhAiMZBpyvzodcTs8v-50qDbbMhT830w5LDYn9og9hyeLb9A
Message-ID: <CAFLszTgWWB_ez_ue6WDToWdCKFAbTbh+5zoyY9mxfj72OyHrDg@mail.gmail.com>
Subject: Re: [PATCH v2 10/10] test/py: avb: Fix find() logic when matching
 response strings
To: mkorpershoek@kernel.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, Guillaume La Roque <glaroque@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mattijs,

On 2026-10-20T09:25:49, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> test/py: avb: Fix find() logic when matching response strings
>
> The AVB test suite runs some avb commands (such as "avb verify") and
> then parses the console output for success/failure.
>
> It does so by using the string.find() function which returns:
> * -1 when the subsystring does not exist

Typo: 'subsystring' should be 'substring'

> * 0/a positive number when the substring exists
>
> For example, here is the output of:
> $ ./test/py/test.py --bd sandbox --build -k test_avb_verify -s -v
>
> Hit any key to stop autoboot: 0
> => =>  avb init 1
> => => avb verify
> get_partition: no MMC device at slot 1
> get_partition: no MMC device at slot 1
> avb_slot_verify.c:644: ERROR: boot: Error loading footer.
> Verification failed, reason: I/O error occurred while trying to load data
> => PASSED
> [...]
>
>  test/py/tests/test_android/test_avb.py | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

> diff --git a/test/py/tests/test_android/test_avb.py b/test/py/tests/test_android/test_avb.py
> @@ -64,7 +64,7 @@ def test_avb_verify(ubman, avb_device_id):
> -    assert response.find(success_str)
> +    assert response.find(success_str) != -1

It would be worth using the 'in' operator here and elsewhere, e.g.
'assert success_str in response', since that is the usual Python
idiom. It also helps with debugging: pytest's assertion rewriting then
shows both the expected string and the console output on failure,
whereas '!= -1' just gives '-1 != -1'. What do you think?

Regards,
Simon
