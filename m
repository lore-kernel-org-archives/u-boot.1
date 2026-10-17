Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB72CCF2C7
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 10:43:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC084409CA;
	Sat, 17 Oct 2026 10:43:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GvO-EomhySHK; Sat, 17 Oct 2026 10:43:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 13BB540925
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792233805;
	b=Uvs/zX69i+kNoTdA6N/5H9a4gSHhCQPOv9jh4z4WvDP0YEJ3Z2AFVcoqiJF7576e9uJr
	 15WmA7DdzLVIXv6LQqEqiO4vwVdZBUEiwo3vN12xhU7hIFSi8jDZ2JZ+ycGforuhKMfv4
	 VhRxRGiDup37xKyBPVr4kWG+Fc65mAv9wVnf2nCMLwYsioQASibhkjq35Gexo0IpYWZkA
	 Ua70XVTW7YMFZhHPDzR4NoAqjJpakktWpXzHzqG10R58MVwoGseCCYY2N72ra/t5jbTfZ
	 SBh2dLHiJb8Umv1Pe76BlbP296i4DLpZR3chAXzXAqyFZZVzEZlD30bmBsAdnSrgP5w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792233805;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=6qFvFk4h+SPQ3QrqHIqABw7Peh10S+n+JDSyn0CwiTw=;
	b=RfE2gIBcu/z54v0ZSv3nVnsfglIR7PN3Fan2YDFrgBmL6vVCg19NPXp7ei87nylVFrc3
	 C02l/DCy7JpSBbCU0TjNGRO17CDfgOdS5OWLl/+GXmiPS42Dak9/nKC0xKZ7Se/j75T0Y
	 BBfsDM6VkhzAdFe4A5Q6DZ78oURnVDhu9HbbCCRNkANcvPVsHX7hxYCTEQmx+yzzWU2Sr
	 DYcbYcWvVHaQR4OQHMGU/pjLWeSFW0Er2rrQk+xpM2vIvGoalKXjgw8vOoAEIud1oC6PD
	 WTQSTa7VvZGyk1Dx4riVHztK7HnBcWQ+8zBkn3Vi6Kqs1+lRFr5QFrDEKONzHvoAF3g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UZbRWLns;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792233805;
	bh=6qFvFk4h+SPQ3QrqHIqABw7Peh10S+n+JDSyn0CwiTw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y7PxXDydq66sVRlxqpSeL2LTGiCDEpHlsgJb5GwFfAHFnJ/WOukoYN0F3nzQ2C/y+
	 wi0JKlv+tvRKeHIpBu5IWyhQ0jeaNeBlGQhJynIcgOWZP2fP6jCvSgIiEWP5GcuqWU
	 8yYNioU1C+f6U/TSTvVwYY8FEUDQYZQx+t5LlLSEhBL3tqXD2qO5RzJbqMJGzy8Qul
	 whQCvbJiD9RwoZP3vfuaai8cGKS/lAtJmNwB03LuqmpGVbeAFyzyA2bM+yTslvasOW
	 tjkpuJcYSanmXXfQLvCnY2XdliFnT/SLy8+ZwGMRN1Poz3avmIK50TRbnO4w0FuC+X
	 cGRIidqC3Zv0g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 13BB540925;
	Sat, 17 Oct 2026 10:43:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C373722B
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 10:43:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A9A4A40925
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 10:43:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uAWbsFtmh_q9 for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 10:43:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 73554408EB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792233801;
 b=Atigf+7b2qpOwgZoQzTKDdDUXSw/0Kx6CXOmUs3hcJafaN+nqZXCRiZNVSRAVdrgTvqk
 ZvuYlyXThyRX2AKivHaTzw5gU744bJxyrwAF/hSsCwd93+eldVgIIOvlvI8PZmeCY27kN
 fC4WW5D7RyJbsbggRvSyhXQ020MzuUriHknAUlbhW2hG8GqT0wenX/D2Nhe8qSf+ITGf5
 GcXh8+wgjRl699cnIt8aUDISNUeMU+8FB42bhNAbLyXbKG3JpVVGdmIt5dYfcFc31QptU
 VxROUg70kRTtviClfST70pSZV7/0fx5GkICiQuf5XY0YMTn+xkEZBH+Ax3uukxUdR6A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792233801;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=6qFvFk4h+SPQ3QrqHIqABw7Peh10S+n+JDSyn0CwiTw=;
 b=l4K78G2uIfvfHjMLL0SWcMP2E/RiXDL/Vyd0ILn9ujeWBlK5vpmOsWKogcPqAsp4CO4r
 cs373lUI/4qnRIBx7FcK3sYr3ByvtF0SNdEzfxun2OUTSmxeO37pN57KidSKO76Wgu5Jn
 DvFmR+zUCaLkTvq9ORZFQTgOhJ+BvFg2rkB3QCxolaMr0e8ICVksxqfYKecd+AMUoPBba
 n8s6H0b4Qo9CQDHRno05SfxYyTi0jWQvO+yM+wyAdpZ2Ilcwa2u86r+ahjRsHSrysj43g
 Q5GiNA6OhYgaxGOgVF2MfCIAqTrsHGHEz73XznV/eLyO3PGROPs1SgmETpwXogmIPVA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=UZbRWLns; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1031"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=UZbRWLns
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 73554408EB
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 10:43:21 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3ab868eb9cfso433087a91.0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 03:43:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792233800; cv=none;
 d=google.com; s=arc-20260327;
 b=gEdfI/HBpBh8mzXoQkrfe2mLgELcRJvog2JeJLP5coCf/zgzsn/pzxjPMbKWMj1/+w
 YG5uUcZ++2ryNIp+BhFP81NRMuNi1nsW7xzJfU32DXV0spjxQW7VD/6qBvhPZ+IaNcLN
 wSxF0nr9tmLhynd4y4Z2HOBjIGx1/FUjaAcixsbWM8eg+s0jRRPsKdBCricym/vx9/Hy
 WbKig/VnzUIgeeEE3DZJ+5GelzGSQ3PZ7kwh3LpUGs8ld+u38e+oWG2rsdWTqVxTW+cn
 1cZUpETeVqpm/06eG60ibsFHdCeJKZGw4tIMISXgMui4erMgWchI8KZG4iwKgV5zR6PU
 12ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=6qFvFk4h+SPQ3QrqHIqABw7Peh10S+n+JDSyn0CwiTw=;
 fh=+hTg4IWSFNf0xUY20eWHwriWPhB/gtH0YM2D+tHyoa4=;
 b=pTeEdUANWO9UIg1afWsmGKJ7MBBqT8JJKWNWBTy40DKiBOzDLA/Q2miWnSAMpUdzsS
 ZQ1HYuB+wzJ5kdaheXeH1pvjHnS8H7IxIwicoLeM6uXQIs1zJ3zxPKPN/tZmjceXosK7
 v/JmKo1eRrcfEQo6JN5sZN1M9hOtaE6ejQMKcNTDl4qT1nhy18HtiM3I6tgdvaGA4Oam
 CxRHvn9bvsaipTCGXBG7iDWtHdNaIZB5JOJ24twc2I4LbVS0nru1DvbX0PLHTj0WAK1o
 HKXQtGHdAfLiCqRgSRRDPi5mOw7m0w6kZrNpMUc2twMgAXr2ZGafVk/9N+plrXby1Jud
 2mfQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792233800; x=1792838600;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6qFvFk4h+SPQ3QrqHIqABw7Peh10S+n+JDSyn0CwiTw=;
 b=UZbRWLnsiWInkgJPQoCwv6wceVSj++LnTnF6Ad3jbcPFDcHmLyAI/KdrOKEmNuyAgl
 nGrZcl3xupsv2IrXnjEdyZcyC6D87yX7dgrGq3EmH2NE/00W/BWrJXuh9Itg4mLQiwRX
 48CEZiRZo427a6gRffLPLU2m4uz7rTcW1bzpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792233800; x=1792838600;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6qFvFk4h+SPQ3QrqHIqABw7Peh10S+n+JDSyn0CwiTw=;
 b=O88kLyCxwo0H0CHmNCkiFzsmmfmIN1bjn45m+GeT0k4u0/vx91yF1jI9zOfVgnDu7k
 /KP3cUkk63T4GGfYnrMganBomxRr5tnWVmaq3TXJd2QIYKWtIiNNBlevN7jnFM4tTDXx
 dzxQ2JF+BOiAxeq2BcvG3JNg7W8/JSrI+D8mkZGk2pWt9OnCxjGaZW/EIph0gRCiH01C
 Qf152epwM+RW3OtNCZNirK3iG9SIw8G1pGWcYhz2FYmezT10dBBSiGL1o1QSnPXfUkMa
 hILGwvUkXbkeSjChsPqx7Wu7i83Rl0ONZQbX4SMCT7rggjy7cpfAhNwfGtuhXBGKoZ/H
 Cszw==
X-Forwarded-Encrypted: i=1;
 AKwUvByb4+l3ATa0bJtiYpDXdfF6T5jaLGurMMkJ/eU30ikjhpXTN1Uv/giZa3FSqIJE1Mo5cLOFXFU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYI931+hPcUnKaW+6wns8vl2zZ8eqkZMlVfdqgCpIlJknrZ3xPRs
 8vCizRAZvnWFPwl3727oVRODegt+HyiuYN4nQ20megmQu8SypSwc5aubpw5rVXghHz7pOk0w/r1
 KS/N2rRW8dSSl8cIGwqAEs56782atDuO1Ux0ZYRO8OwYuRgGvCKw=
X-Gm-Gg: AYBFou2tKYTb2zMshQwbol4TPQ6Wpe/454cIL8oIsdCzJA5otgsLu9qsZTlQSSKwMET
 rrMRxRbiBsv4Z5QrTTvOL7K0ULMGHUCzG2QB8Iq3wQF2bZEySPqRgYpECYt7ZGjqI4akJHtez+q
 mjoscR+I0Yu4enPxrZytip6caKv76TvkcF9dI8sWQBBgFJB7hbnZhG2KDULQovXRafvMCrb05Ug
 MJZ66jEF+DdQvclZZq2Zc7G0FitleF/ULvweAAcKmZraKeRoZWF38ZNReVtIQ2Lm0tm6U5FD+vc
 jupyQONOpaaoC6NVVXHLCxsfBncOUfZ+lv1KoJPkgZZCjdpexIa9easnTXRdRVjx
X-Received: by 2002:a17:90b:3b8f:b0:3ac:b185:fa16 with SMTP id
 98e67ed59e1d1-3acef3dc9e5mr2027650a91.43.1792233800405; Sat, 17 Oct 2026
 03:43:20 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 03:43:14 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 05:41:41 -0500
MIME-Version: 1.0
In-Reply-To: <20261012104805.17297-3-yan.wang@softathome.com>
References: <20261012104805.17297-1-yan.wang@softathome.com>
 <20261012104805.17297-3-yan.wang@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Oct 2026 03:43:14 -0700
X-Gm-Features: AclHuK9E8f35myl0wxgxsx76nyxEzw2Xpi1dFh5dJTTeYluh4R2aFfelrutxJIQ
Message-ID: <CAFLszTgXHxWS0TwmicB3n=rAokQ8PXVsMFOJxCxo-5e2LpNHyw@mail.gmail.com>
Subject: Re: [PATCH 2/5] binman: Add test for pkcs11_tool sign method
To: yan.wang@softathome.com
Cc: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org, 
 alpernebiyasak+nodisclaimer@gmail.com, marex+nodisclaimer@nabladev.com, 
 philippe.reynes+nodisclaimer@softathome.com, 
 paul.henrys_ext+nodisclaimer@softathome.com, u-boot@lists.u-boot-project.org
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

Hi Yan,

On 2026-10-12T10:47:59, Yan WANG <yan.wang@softathome.com> wrote:
> binman: Add test for pkcs11_tool sign method
>
> Exercise the three new methods added to the pkcs11_tool btool:
> sign(), _build_mechanism() and _verify_mechanism().

Patch 1 adds four methods, and this patch also tests
find_slot_by_serial(). Please can you squash this into patch 1 so the
code and its tests land together? Binman expects full test coverage,
and patch 1 on its own leaves the new btool code untested.

>
> Signed-off-by: Yan WANG <yan.wang@softathome.com>
>
> tools/binman/bintool_test.py | 374 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 374 insertions(+)

> diff --git a/tools/binman/bintool_test.py b/tools/binman/bintool_test.py
> @@ -354,6 +364,370 @@ class TestBintool(unittest.TestCase):
> +        # Test finding a slot with matching serial
> +        slot_output = """Available slots:
> +Slot 0 (0x123): SoftHSM slot ID 0x123
> +  token label        : test-token
> +  token manufacturer : SoftHSM project
> +  token model        : SoftHSM v2
> +  token flags        : login required, rng, token initialized, PIN initialized
> +  hardware version   : 2.6
> +  firmware version   : 2.6
> +  Token serial num   : abc123xyz

This doesn't match what pkcs11-tool prints. I ran 'pkcs11-tool
--module /usr/lib/softhsm/libsofthsm2.so --list-slots' against a
SoftHSM v2.6 install with one initialised token 't1' and one empty
slot, and got:

    Slot 0 (0x23aea6bb): SoftHSM slot ID 0x23aea6bb
      token label        : t1
      ...
      firmware version   : 2.6
      serial num         : 4b16583ea3aea6bb
      pin min/max        : 4/255

The real tool prints 'serial num', not 'token serial num'. So
find_slot_by_serial() in patch 1 never matches, and hsm-token-serial
cannot work. The test only passes because the sample output was
written to fit the parser. Please can you fix the parser and take the
test data from real pkcs11-tool output, including the 'pin min/max'
line and an uninitialised slot? A token-serial case in the SoftHSM
functional test would also catch this.

Also please use ' for strings, rather than " (fix this globally)

> diff --git a/tools/binman/bintool_test.py b/tools/binman/bintool_test.py
> @@ -354,6 +364,370 @@ class TestBintool(unittest.TestCase):
> +        def fake_run_result(*args, **kwargs):
> +            if '--sign' in args:
> +                self.assertIn('--slot-index', args)
> +                self.assertIn('0', args)
> +            return _CmdResult(0, fake_sig, b'')

These checks are weak. assertIn('0', args) passes if '0' appears
anywhere in the arguments, and if the --sign call never happens,
nothing is checked at all. The same fake result is also returned for
--list-mechanisms. So _verify_mechanism() parses the signature bytes
as a mechanism list and quietly skips the check. Please can you record
the arguments of the sign call, check that it happened, and check
pairs directly, e.g. args[args.index('--slot-index') + 1] == '0'? The
same applies to the key_id, PIN and token_serial tests. BTW the test
should also check that --login is passed.

> diff --git a/tools/binman/bintool_test.py b/tools/binman/bintool_test.py
> @@ -354,6 +364,370 @@ class TestBintool(unittest.TestCase):
> +        def fake_unlink(path):
> +            if 'binman_sign_' in path:
> +                raise OSError("Permission denied")
> +            return original_unlink(path)

This leaves a binman_sign_*.bin file in /tmp on every run. Please can
you record the path in fake_unlink() and remove it with
original_unlink() at the end of the test?

Also strings should use ' not " (please fix globally)

> diff --git a/tools/binman/bintool_test.py b/tools/binman/bintool_test.py
> @@ -354,6 +364,370 @@ class TestBintool(unittest.TestCase):
> +        # Previously hard-coded combinations still resolve correctly
> +        self.assertEqual('SHA384-RSA-PKCS',
> +                         btool._build_mechanism('sha384', 'rsa4096', 'pkcs1v15'))
> +
> +        # Novel (non-table) combination: any hash works with RSA

These comments refer to an earlier lookup table that isn't in the
tree, so they will confuse readers. Please can you drop the
'previously' and 'non-table' wording? The first case also duplicates
the SHA384 and RSA4096 checks above.

Regards,
Simon
