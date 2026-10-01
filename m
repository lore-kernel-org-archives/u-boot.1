Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C52CA5FD9
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:06:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C29260D6C;
	Thu,  1 Oct 2026 16:06:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HjBGvzqkrrWM; Thu,  1 Oct 2026 16:06:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 961AA60B26
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870780;
	b=LEg0yokBaysFHV5sdupOii1jlx2HA9jY/5c215KTxt+bmfHWeBFICJue52n0RvWy83pD
	 8bg865nZ6RmmSTxl6wuXJAVh+8nhQTQpjX1OijlJCS/B4QmJTLK6lUv2+MrTPOL1s+Nc8
	 l8/Wg6K/soFt3LXu7JhlLMcTnBUm4fCfW6RkudavnGEGKmIEDBNbg3oMAewKW8/1OJN1Y
	 QRnoQl9SDgtrzhLDQEzrgYpa7Zn+ro/ptHnmukRnZYYob0YgTPnmx8MYWbrL48Jq0nM8S
	 zzENWvAZ4VaY1+x625W0l3EDs0uHqFBbEv8Nh2s2s7EqCjoVHRJvheK/X1NiSpEoQrQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790870780;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2d7WtXy2dhO5qOIeJ4C6c83b+gZLDavDu5NCiIIGweE=;
	b=mY6U4bfoEF9TaNk10/wPTSDECf5BLzwATgqycv0WdbdG9AO1NiTYgEXkrclKwylAtTWe
	 Ugv+156N59I7tWuK9+RFQcFAAxC6h8EY158Ao7If8DSyb1Vj9QjYS1repXH5EjPiWqx/8
	 +qmOk/JcnuLbaSWQ+2PdBHBIOVLdTeWY8nBSGHZgc+re3hM/WPh3vXNT1A4LUK4UZd+h5
	 FK7hHJ1hNByHVe2hkCX9xb8bf2mSRDbKwqCu7VNwhwnEejGcOzDcQ2G07rRpTX0c3TtYB
	 5Nvx4KxWSC4PLfGKxEf6DJu9AbiFyipE+Scil/W5r0HNltFFz8JYGQzRPAKZC8Q2r0g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=IddpK2Ke;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790870780;
	bh=2d7WtXy2dhO5qOIeJ4C6c83b+gZLDavDu5NCiIIGweE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eF23EI+zrWv4WbIFyp0w1Lk6tzIWpztOMD+uLq6bE6INtcLKlI/xtb21aqTuYAUk2
	 ICIWc66OKfdYgdi7ibbSVo6S42GWf/rfp832p3wxWaIw4u2+PRyouf1cS8iCS2ZgvH
	 CnjsLDDWnrghLF0xHds2jeqYwZ34TB7cIGVzuPyOcWQz1rf0yF6sb3zwqdtQZg9SB9
	 e3wQPqBltq2K0kYoLEyRUJN1O/g0ycODMs00TYFS2oMsazW1zwQgFSYnCY3FQe6axh
	 9QePtfGHtsu/aOG+UQRtQDgFYmn9zqIyX/n80iNorpCo6PEycmTXEudbBPgp3RrevK
	 HmTkOi4hfTSHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 961AA60B26;
	Thu,  1 Oct 2026 16:06:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 49D4C32F
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:06:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3A51160B26
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:06:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FlPkYAABYzW2 for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:06:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 05F3B607F2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::2b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870778;
 b=FbWfxRdMQYGUv8dfOacZUXYzGfzQl8DXZoHmqFjYgexZtMMdBNMDdeLGaHKwEj/N6aGJ
 wV/l23lg863/i1IsiLWkbv5UsKPNrd7L35LrK/2+WIgEuo05opsOhJH0+JcPMkc/6nQjs
 rQcp6YDpK/HT17xpYeLlD7595UdDpuzjl37k8YSbu2gTHfnwWUfVoto69OVXA9ImFPh1y
 X/hJICEm5RWuIMg45JllLR6Uy8w0NEVXQHzBmA8XAuF1prTI9l4V/calOOkxEdOxwjh0M
 y3Gc1343xg31dR2MytF3w31Sru5ht/ve6v9ckNpRUGOciNswjvw9YCszBaTIkOEl0Dg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790870778;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=2d7WtXy2dhO5qOIeJ4C6c83b+gZLDavDu5NCiIIGweE=;
 b=cUBwTrPNx0iu76yCeUtng4NtNHYD3TZFnWL+mXpBTruSwSPCHi4zqbdwI8gCsKyrO3n3
 UzfEl6iv0/zIt1jKokfXITsckLG+H0A3o9Toh0wK8ehr6CNlpYgGa54ytHOWaP55jqEBW
 zJkekiTddvARtLKbuiTafKqQBk+DW+50hZKaGViX73gOlgo8vwaIvcHz9HI/3Km3nKgrH
 bDDZ/rs+7NvRkVKKIubHDxoGaiM8XTiaXgBUTEBZgPy9ZqawR7K6wDNC2usKGhMuOAZKW
 lSBtfzymGzCK426cG2Lf4TjdrpCkNZEIAhX+f3r9rD/LHPHvYZgiEHnEqdU/xWOE52A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=IddpK2Ke; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::2b; helo=mail-ed2-x2b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=IddpK2Ke
Received: from mail-ed2-x2b.google.com (mail-ed2-x2b.google.com
 [IPv6:2a00:1450:4864:33::2b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 05F3B607F2
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:06:17 +0000 (UTC)
Received: by mail-ed2-x2b.google.com with SMTP id
 4fb4d7f45d1cf-6ae19959791so2717336a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 09:06:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790870775; cv=none;
 d=google.com; s=arc-20260327;
 b=E4hKyn0rsLI50vfw1AeNEc7StBsty4W7sqs1cbhlXP3Mf74AsK2oq1lMuMtCZmDhWu
 AZog09f7q+k2Ah5aNTi53kFDTZk3URW0FRLfmOiIvIpWJ4iOFA6wgYrR6eUspSkddiSb
 6Z5ceB8O5DGykAAe9n8VgCSeTjYDeZX0YLDoZfI56he89fS1BetBO8nOtEmoOzPYQPg5
 CTXp9ehJ2eGwPPBquQGed912U+oTxp/UwTx7Fig4oVHG6gW0QY0XlEvePa9hMhkDLjiQ
 sz8RD5Tf8YlTcQcMU78B+X1m+N3gROejbksjTkUi9FWdLqtit/MlJo1/Qu5fykl6yrYN
 7AGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2d7WtXy2dhO5qOIeJ4C6c83b+gZLDavDu5NCiIIGweE=;
 fh=u5QS1SB/Dt/KeixQ0/C/ovPG15fr1d8zWkl5nfXeE74=;
 b=AWuJ0N00JQ7+pjungQHDmEkI1z9dLGy/4DAB86xq/fZVbiuTUAjJWywiMtO3p9Sllu
 YH2Jj5vgJUtKgSCbXSGCwcxUSaL5+kYGS0BUCamJEj+BZOvX5F9yTQaDvoiRVLpd/nI2
 ZfizeDmRHDNOytpDKvNRpykaR0LCJ3uSU1fJvUhwBUqIiXAkPlWkfwK7KV84Kq3yhVj+
 2XioXJFME1jRvTNtopaae35mm5+4Kugv615KS1l7Tg97l5RWUw7pmKmBRu2qm9R1euaR
 NdjLHaFksgfEjUnmXODrsI+ySnjvXyVHC7F76USbkSJYu7SiX0+jdIrGEL7C7hf34SHH
 Ov8A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790870775; x=1791475575;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2d7WtXy2dhO5qOIeJ4C6c83b+gZLDavDu5NCiIIGweE=;
 b=IddpK2Kerfrr/F0uPuQ/78VWk2si503MVWY/2mTXRp8iKAP6GvHd33gVjDWwdwkrEw
 yFdXodCiHC/zz1/RUl9cO15ydnK6Q8zrEBEmQwIuEQ/v5kSQQU+SDZGaRkHwb6qzL2kF
 01B6TkXb8TeyJah61XQOSjpE99PiQI2XRVjyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790870775; x=1791475575;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2d7WtXy2dhO5qOIeJ4C6c83b+gZLDavDu5NCiIIGweE=;
 b=Ni3jN3RizF79ftZOJb88ZPa2Ib5thCz/qTMmiRtux2+9fiaYwe36PVylP6Uc/84fng
 6DLyoEV6j0NfchW8khg5O5Jv9+FamLgmGjaWBGmzDGRqbIpqybhSbl6AqkBsT/0jCEKB
 CO4IUB2360DHcjFtPqSUTZZ1ZZOSnJ3KGFNnbrRzaxhEMF7N3OmOR2IltDpisE3kN+gl
 HjBQDaRwP3tFCIZMwCW07Qgld9QAEqKblY/bgKRQkXWamdr77UFbBXZb78yhFlZXmbUz
 JtGtouEmZNe0qRJv+ObUVUKO+easx9hkFDQp3lcsSQuXHCZ40aGBTteKvsL9AbIYqMqI
 BO4Q==
X-Gm-Message-State: AFq9FYK38RSb/Sf7JEuvmFlkNWwyLxC5UVLVkkbGwI1GbOMPdk9J6LM3
 JD3OBPB9Ae0ZOdBE5dJFC1zhaYnHU5zsEYvVZ83pChNicNYCHPdQET3zQ78sSgQl7Y91WVZgog/
 dtDJtkvA385YZJf3l+Sd2PDHd9mzv4Nlctb8H3R1v
X-Gm-Gg: AYBFou02/xM3HbQoxyX0o55ZcIAUwST7wiMkc6CwvqOkwkWML6T1H2QWzmzvktEhgHn
 oGD4BS/bmP/itQNp3LOKmsQODJjlHOCJuq4Ym0Pdv185iLC54HvznOJ97hnSAEMYeRioFnowt23
 6oZUl1bgzMlDoUzbfLqiNVLuQoTv8dRN2jZUWDi7eIhGolQURpX0DmdRv/eC7HjLFM9f/e49OV0
 DOaolekGNyHqhtPdRqyYjtr0TdSHMzBMFWDsCrc2gbJuOgBuBML2UMvseDuF2AHfKfVaK5EnP1c
 eu8SC2Ih2OGFjc/wdlAXytyBHqYAtTZpswgwVUJ6atHEc0uCZwdciLID
X-Received: by 2002:a05:6402:46cb:b0:6ac:6c00:bd2d with SMTP id
 4fb4d7f45d1cf-6ae198f1543mr3633034a12.14.1790870775315; Thu, 01 Oct 2026
 09:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260925072741.1966573-1-0xiviel@gmail.com>
 <20260925072741.1966573-2-0xiviel@gmail.com>
In-Reply-To: <20260925072741.1966573-2-0xiviel@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 17:06:03 +0100
X-Gm-Features: AclHuK9_CWZZ3Gc89GRxE18aZu5hy_U59md1nAh5yNxcmh8-XISOC6vWr15y3RM
Message-ID: <CAFLszTgzeteer7k65-sx-fi_+S0urXdaUpjKgEZRDGA=PZZDww@mail.gmail.com>
Subject: Re: [PATCH 1/2] image-fit-sig: fail when the control FDT has no
 /signature node
To: 0xiviel@gmail.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ludwig Nussel <ludwig.nussel@siemens.com>, Simon Glass <sjg@chromium.org>, 
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
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

Hi Eva,

On 2026-09-25T07:27:39, Eva Crystal <0xiviel@gmail.com> wrote:
> image-fit-sig: fail when the control FDT has no /signature node
>
> fit_image_verify_required_sigs() looks up the "/signature" node of the
> U-Boot control devicetree to work out which keys are marked required.
> When that node is absent it sets *no_sigsp and returns 0, so every
> caller treats the image as not requiring signatures. Nothing downstream
> can fail it after that: a FIT whose signatures are absent, malformed or
> invalid verifies successfully, and the only indication is a debug()
> call, which is compiled out of a normal build.
>
> Against a control devicetree holding no "/signature" node at all, and a
> FIT whose configuration signature carries no "value", an unpatched
> build reports both images as verified:
>
>   ## Checking hash(es) for FIT Image at 10400100 ...
>      Hash(es) for Image 0 (kernel): sha256+ OK
>      Hash(es) for Image 1 (fdt-1): sha256+ OK
>
> That '+' is fit_image_verify_with_data() reporting the signature as
> verified, on a board holding no keys whatsoever.
>
> Add FIT_REQUIRE_IMAGE_SIGS, which turns a missing "/signature" node
> into a verification failure on this gate, and report the missing node
> with log_warning() so that the condition is no longer silent. With
> CONFIG_FIT_REQUIRE_IMAGE_SIGS=y the same image is refused:
>
>   ## Checking hash(es) for FIT Image at 10400100 ...
>      Hash(es) for Image 0 (kernel): fit_image_verify_required_sigs() No signature node in control FDT: FDT_ERR_NOTFOUND
>    error!
>   Unable to verify required signature for '' hash node in 'kernel' image node
>   Bad hash in FIT image!
>
> The adjacent configuration gate in fit_config_verify_required_keys() reports
> the same missing node with debug(), after Jonas Karlman objected that a
> verbose error is wrong on a Rockchip board which enables FIT_SIGNATURE for
> image hashes alone and has no /signature node by design. This gate keeps
> log_warning() for a reason specific to the image side. Under bootm the
> refusal surfaces as Bad Data Hash, indistinguishable from a corrupt image,
> and nothing in this function can tell an intentional hash-only configuration
> from a control FDT that lost its /signature node, so a silent return
> withholds the signal from exactly the case this patch exists for. The
> message fires once per boot rather than once per image, the level is
> LOGL_WARNING rather than an error, and CONFIG_LOGLEVEL suppresses it for
> boards which do not want it. On evb-rk3568_defconfig the shipped
> CONFIG_SPL_LOGLEVEL is 4, so on that board at its default configuration
> this message appears once in SPL.

Not quite. CONFIG_LOGLEVEL only filters output at runtime when
CONFIG_LOG is enabled. Without it, as with evb-rk3568_defconfig in
both SPL and U-Boot proper, log() in include/log.h prints anything at
or below LOGL_INFO with a plain printf(), whatever CONFIG_LOGLEVEL
says. So the Rockchip boards Jonas mentioned would see this message in
SPL and again in U-Boot proper, and cannot turn it off without
enabling LOG. The help text makes the same claim, so please can you
fix both.

> Measured on sandbox with test/py, running the vboot tests:

The commit message is very long. The test counts, the 'Not tested'
list and the Fixes: discussion are useful for reviewers but belong
below the --- line or in the cover letter. The paragraph answering
Jonas could be cut to a couple of sentences. Please can you trim it to
the problem, the new option and the reason for the warning?

> [...]
>
> boot/Kconfig         | 34 ++++++++++++++++++++++++++++++++++
>  boot/image-fit-sig.c | 15 +++++++++++++--
>  tools/mkimage.h      |  1 +
>  3 files changed, 48 insertions(+), 2 deletions(-)

> diff --git a/boot/Kconfig b/boot/Kconfig
> @@ -259,6 +285,14 @@ config SPL_FIT_SIGNATURE_MAX_SIZE
> +config SPL_FIT_REQUIRE_IMAGE_SIGS
> +     bool "Fail image verification when the SPL control FDT has no /signature node"
> +     depends on SPL_FIT_SIGNATURE
> +     select FIT_REQUIRE_IMAGE_SIGS

The select seems wrong. In SPL,
CONFIG_IS_ENABLED(FIT_REQUIRE_IMAGE_SIGS) checks
CONFIG_SPL_FIT_REQUIRE_IMAGE_SIGS, so the SPL option already works by
itself. The select only forces enforcement on in U-Boot proper as
well, so a board cannot enforce in SPL alone. Please drop it so the
two options are independent, as with the other SPL_ variants.

> diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
> @@ -201,8 +202,18 @@ int fit_image_verify_required_sigs(const void *fit, int image_noffset,
> +             if (!reported) {
> +                     reported = true;
> +                     log_warning("No signature node in control FDT: %s\n",
> +                                 fdt_strerror(key_node));
> +             }
> +             if (CONFIG_IS_ENABLED(FIT_REQUIRE_IMAGE_SIGS))
> +                     return -EPERM;
> +             return 0;

I'm not keen on the warning when the option is off. Without
FIT_REQUIRE_IMAGE_SIGS, a missing node is the documented hash-only
setup, which this function cannot tell apart from a misconfigured
board, so the warning is noise for every such board, as Jonas said for
the configuration gate. Also, the static 'reported' flag adds state to
library code just to rate-limit one message, and when enforcement is
on, the second and later images fail with only 'error!' and no reason.

I suggest log_err() on the enforcing path, with no rate-limiting since
it is fatal anyway, and debug() otherwise to match
fit_config_verify_required_keys(). That also removes the need for the
mkimage.h shim. If you want people to know about the fail-open case,
the Kconfig help and the docs are a better place for that. What do you
think?

Regards,
Simon
