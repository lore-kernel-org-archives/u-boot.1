Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BDC606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 07:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ihHwdNNl;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=T7KuDPzV
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C45BE60849;
	Tue, 20 Oct 2026 07:57:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n6JHuy4mpomE; Tue, 20 Oct 2026 07:57:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F1AE360838
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792483034;
	b=lvuf5TkSxOPt5C8pbRnryg/6aIS3FcXAT+8Ih/C8KeUBxlyhe/RKG0PZoGez+dlo3gzX
	 HJczAuIViOcAaDZ90V0xcJSixuZaU8nyt6edhsGXsB4AAtpgM+soCObTTuBWNmg1ggKHm
	 +6UU/NpvrWuNSbe6/l9lxos47SUpIzpPDZzBLOb4aed/2I7nM1d5NP3s+ZBw97GKpdOkm
	 rnCW5cKRTqAkZK9WpeC6hvh02DNHtMrCItfOG0SkCL6ReaKo+6fmnsjPEzxn3yaMIRNAK
	 QgOU+3rXOr9uE2ke9FRt+1AuQNGlUqEuSNT1UkvHGlgGwDImVeuJ5jwYyEpot4QoH5w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792483034;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0YgFeQv/HrKM8aFlSwDmIod6yQZjhx66mhK00NDmzvw=;
	b=GnSiC6dDyG8PQt7l0g3C7N4TSdOaXetUArrldD6BQscW7DxYm4q7ybb1HWizEnHVtezz
	 fEqw8y6MHetG56K7VLDz+ZFO32XYDy8+6m09SVO0umNiE8gOntpYoty9PgzvosXaanXYT
	 sXFiQzvH7w1ENf32PqhODSJe90FkDqbp4Fq+j06GWNBQJ5mSIrVxY+746Bc7YDj8Vt13K
	 TubecjuprxGXGdmHPrsze2ASqz10c23Xo91ZCph/kkmeEWzcPzJjb9j3kcH8U4dX7/HLd
	 Rp17a+/P4uM2vnJ+nK1N6Ko0o9dMZWmNfmis9TbEph4/oWmB/OC4df0gJeCiOSFmPqA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=T7KuDPzV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792483034;
	bh=0YgFeQv/HrKM8aFlSwDmIod6yQZjhx66mhK00NDmzvw=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ihHwdNNlWocfYK9RHOZZ1+jKgNZYREFvcFILOuQ20ARbJLLOPFpiCqMu3sDomj/45
	 Og2ioSRtH28S3+IrUVSvJ99p2S0cNSPvdrA535LJTRKy6EM7GmyMidvA0lcFlPI0aG
	 5oAIPr0khHRxS2c+WlJDzw6vFFOlsUSIwe1uWmKJltE7zOg3qAWE6Jh9vHQgJHIJhA
	 yZ2Ln1pDItwcs8gZwyuTz7jEO8kwl+A28iyLDcCXVXhUwpsjSgn9uL/zwj437YPJ2i
	 Hlfc46bZXAKfSi9kI147/eYAltoMIC/c7zuR6OzQ3AIcP1Ycz0oGGweX/ytkF0bMS/
	 VvMduLd1B/BVg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F1AE360838;
	Tue, 20 Oct 2026 07:57:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id B6E113A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A598260838
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:57:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id igV_rvt5RO_3 for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 07:57:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EAF20607BE
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792483032;
 b=Ad4FFbbte85fiPf0q68cJL3/B+Sm62JBPByjnxx74tIgTiRkrirtfCC1Y9URQzoKEZct
 vehwcosayB6x5my5GT0R0BPCjKqSYDD16mn3jQut37gJrJzbaSqYZRScqhPFsWmGKV8QP
 KjxpFLO9t9kNM2Djv5wS1SOS9CkX+0tRRFu+FVBke+Ze+RB+F5/ZBFbTghgHQS6TJrFW1
 2ovnHGzFet9AB0+zZgGQ4fc991+vq2oU5tDhdqGMDrFr9SWFl5LN5927nCHzNm5wCDqye
 rQd7aghXTAwUMjLk2mOW5fbQPYE3Mer30TGX/NDUVyfe95npoTkaQiwM51/9zgOA0qA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792483032;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=0YgFeQv/HrKM8aFlSwDmIod6yQZjhx66mhK00NDmzvw=;
 b=gWCNQUl/1MLeQ/EB7dHla//LDyKZ+d76EoGK67NPu6yewRFiXOz0yaQiIWL8L/47lIBb
 pfTrH00DxbZswEHfCO1mqbmPUgLt/j0/ohZpnna2SYzud5/6zCguVJ5ISOzjvC+iIHPYT
 EzeVFT8ypudTkkdjaVj7ET3izT9yQScKSobQCWtHgQLDm8rp5bBA6IjhliO9crYJlE0ZF
 BXvEYB75JFrqAviwItDqoDPWzG00iEV7KLy/2K69LlAHWutPnQbhma3uLX+6ZQkNq3Anr
 q4yP/YHMSbjCmGqwuOSarjXn9aJoKSnVyZyF2VuN25cnBxmUlNtQBsc9DECRpf5yLow==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=T7KuDPzV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::42e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=T7KuDPzV
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EAF20607BE
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:57:11 +0000 (UTC)
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-89ff475a152so774066b3a.3
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 00:57:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792483031; cv=none;
 d=google.com; s=arc-20260327;
 b=OpPmzwqH6IYfQmsqwtLiHKC3AWWyHf3c8msfKsf1Sp7ihCm7ka4GpYVmefyw0qer3X
 kRRJmCm+sFjMP6tYFfEuKg2elLL+HUXIrjJPd7i/bI84wDzo8K73cW4L5S7lppVVk4aq
 qD1kZPYh/CVEkpsu5H4yZhhDnQSwXGRkmWtWdP5pk1sGsUq96eLzvsHBIeT+pfd4OJok
 5T2affr59afCB5CFUhGsk7XMsVjrOr6VFiBjRjxmbc++od7WcdtayKALa7ulJgeDJ+9h
 Y7qWrIbT/3XDIHrOkr86wXYUv1KCHIX0h8ufyyzLA872U9mFZ+T/o41bBhWVd6luYULD
 2+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=0YgFeQv/HrKM8aFlSwDmIod6yQZjhx66mhK00NDmzvw=;
 fh=gJv1TpPsiXinmRJ8Ue9XbQky0phJifbSW/r6XObWM4M=;
 b=TWudirn9C+0iIy1+0KRoYztRtAUdD743bT8bDC6szhOqsmOS3QzO+BA7ePRxjIWGIZ
 iCa2RsAH717d/6lirbaUUWeyMJdnCI6JealN7p+zHlOu96mFfS6f+Ojg0stTvAL1jfRG
 NVJgtNXcI6oh+y0HKgN1wHed5j77Y7KWhHTpI3s18JhCP052MpsYZdOLBcza/MoqcFkd
 cJ/fwPWxXqmkIxpUswebR3cwWmvaeMNmmcPkl229lnTjShFkchzP9vNJyGaGI1yyCCvC
 Cr4PLudiw0/GsLTdyv11bYTkxpi2K5giOl7TQHxtQKnKl87QIjZWIw0edSOmjr2mOChU
 fE0Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792483031; x=1793087831;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0YgFeQv/HrKM8aFlSwDmIod6yQZjhx66mhK00NDmzvw=;
 b=T7KuDPzVQSrAc2If6pU6piBf+gkRyMmaM4UUjagU22BChlkdIItDN2QA1PmrOxVbJY
 QYbydWkiw/Ua4MOw0kjt6hncFseCXXPsYORlnoDLW8fXHQVsB3RnyDFGFNay2mWjckN0
 YxKa+JTpGy5r8lxjC4s6cqJtJPSNu80uwYQ9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792483031; x=1793087831;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0YgFeQv/HrKM8aFlSwDmIod6yQZjhx66mhK00NDmzvw=;
 b=NGLZvRRCsqoAioY++EDk8T/KvaD0b93LhkS4fH2KpeECqpttavBrBcA6Yh6Ugo93LQ
 KqZiu3rxXGuEhqo90u6LAVoE880UAnNoiAzlvtz+CDSzhdnUNvIULG9kqT34Rg/eS9Uc
 PgSozeYDvEyVe/9OTl6LfngeGOX02Jn+JbxiC2DpL5m9nrFlP4NQXGID8xNKrO0UvvQM
 NUOkAMsFp/zWHKUsdIR928jZccWOJT7KEM9+Qgyj9YK/LXnb0JHDquyafJ9JOQTZYcdF
 egEiq7KztO08wf6WndtTedumSZu0rOcTv+adZSawx9UW/+wizz2JrDLkbCcmX9HRkZiA
 9NPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSqo/SXAL3ycUE6kNNA1ZnsJ0Zds2iVTRGhTuIHe5bY8CC81eKfMDy/KBxiVxI2RvfvToZvkE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIbbhJ5QAtMZzcbJMwWZ4scqEbK0rhlsnW2Top0fcI4t9t1vvXm
 Mucqm6+lxXLjnGm/6Yo+dZynHQu/gcjxSa+DxcCroeABuGOkQXLK1psemvL0sB7tZHSyl84IH80
 CqhNoPanaas0Rdw7Fu5Xig4TKI6mmEenGNZoJ3w92
X-Gm-Gg: AYBFou1BLesl+h4kRvw0k+fPLOCDid5vnjFZa4vmlbEW/kkdbvsT0HlIQeebxYVZrJ3
 iNUfZD4AnQ+UGluxx94psjuUYSA1+FvhdzKDk9MnI64u6Fq8ojRkxXy7BGQWMub3MxUns25k/Ki
 teaYhGrxOaVix9THIoKm1vFUkt9tXfY7VR8XIBhZ+ta9+1gJgVbCQVsS69NHj8tET6J2El0IdK4
 l9fjqJ+n8c6tXTDAa0m1tRt58eXNbZYxRAHazIukB+JglubE9mJLGXoBUb/mjqyKA0nQ51fh0R+
 tRxJClWruOo1yQ/eGHieZUqxp/ZeuUNhRxWm9kXB1kuyin1FBta/fw8=
X-Received: by 2002:a05:6a20:c5aa:b0:3de:3ab8:d1ae with SMTP id
 adf61e73a8af0-3e2263d2d02mr8049418637.48.1792483030812; Tue, 20 Oct 2026
 00:57:10 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 00:57:07 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 13:32:02 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a29db1a74718b863e7c507af877f0c1f823e0bcd.1791966831.git.daniel@makrotopia.org>
References: <cover.1791966831.git.daniel@makrotopia.org>
 <a29db1a74718b863e7c507af877f0c1f823e0bcd.1791966831.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Oct 2026 00:57:07 -0700
X-Gm-Features: AclHuK-5sJ42lhsdFO6OCOtgsrO3OtSEe_zGomhcifSYuDA2DQlF0GljIfIhnbg
Message-ID: <CAFLszTiw9nTGnYZNnR9zMxoGiJM3jirNaBOYpP9jcHct2DqYRw@mail.gmail.com>
Subject: Re: [PATCH 11/11] test: boot: imagemap: caller-owned region not
 resized
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Vincent Jardin <vjardin@free.fr>, 
 Anton Ivanov <anton@binarly.io>, Randolph Sapp <rs@ti.com>,
 Anders Roxell <anders.roxell@linaro.org>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Daniel,

On 2026-10-14T08:38:38, Daniel Golle <daniel@makrotopia.org> wrote:
> test: boot: imagemap: caller-owned region not resized
>
> Add a unit test that locks down the fix in imagemap_map(): a larger
> request against a region recorded by imagemap_map_to() (which the
> caller owns and is not LMB-reserved) falls through to a fresh LMB
> allocation instead of resizing the caller's memory.
>
> The test reserves a caller-owned buffer inside the LMB-managed RAM,
> records a 64-byte region there via imagemap_map_to() with a guard
> pattern beyond the payload, then issues a 256-byte imagemap_map() at the
> same base. It verifies the returned pointer differs from the caller's
> buffer, the guard tail is unchanged, and the new region is LMB-reserved.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
>  test/boot/imagemap.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)

> diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
> @@ -316,6 +316,103 @@ static int imagemap_test_map_to(struct unit_test_state *uts)
> + * Mirrors the scenario Simon Glass asked to be locked down: a guard
> + * pattern in dst beyond the requested 64 bytes must survive, the returned
> + * pointer must differ from dst, and the new region must be LMB-reserved.
> + */

Please drop my name from the comment - the preceding paragraphs
already explain the scenario.

> diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
> @@ -316,6 +316,103 @@ static int imagemap_test_map_to(struct unit_test_state *uts)
> +	phys_addr_t dst_phys;
> +	u8 *dst;
> +	const ulong dst_size = 512;
> +	u8 guard[512 - 64];

It would be worth lifting 512 and 64 to named constants (or deriving
the guard size from dst_size) so the two spellings cannot drift.

> diff --git a/test/boot/imagemap.c b/test/boot/imagemap.c
> @@ -316,6 +316,103 @@ static int imagemap_test_map_to(struct unit_test_state *uts)
> +	/* Returned pointer must be a different buffer */
> +	ut_assert((char *)p != (char *)dst);

The casts to 'char *' do not buy anything - ut_assert(p != dst)
compiles and reads more cleanly.

Regards,
Simon
