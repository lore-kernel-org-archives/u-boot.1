Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF3F606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=V1aGrqrY;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=i4m+NOoD
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2AA2A80FA0;
	Sun,  1 Nov 2026 11:53:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TpmNefXIQWXv; Sun,  1 Nov 2026 11:53:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6209580FA3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793533993;
	b=o5nqA+aHlhfTr/kD1bJfOrGRsRl8gs/qZx5WyvW/xBsgPwPbOKAY4WrH0zN6nq8A4v7V
	 eNKuj+HEV2unD4d1lGJA+wDMo9XhN9MALNohDB4LeilbiwEe2PeF1q3/iqXK6uklae0SQ
	 37GAW5k+lKPTyVSp4BBGuKmTVJ8w18SYgwRKOEchxilSmsEIqmk1tRkhlerc2WyO6DiDq
	 NhmYscjdNpdBnV0aYBM9dM61U82/Ix/6cYIIH6IM0FuXgp078ymAeEArZIhISC3jeF4sM
	 Q5yI6DeiMkwtU8+/3PDdTU+J4i9mwyblu/RN16JuPG6ggXs0bHgtktmWEkigCox8amg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793533993;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=NR95k8bLvy8kZ+NltoEGyYjndBr3KQTpomy0PkegGR8=;
	b=HDQ9InpU+10jRhQkC52I7NLpoKMAN5zAJF9yDyavDS9rimKbkxrcUbVX5st3Aow9oULs
	 xilvFUIl/VIxrPcGTgavp0Sbhbu2mc/kDCpT5hjchPZzsJXgriOcpzbzHF04UQQCL+fJl
	 npC+2BlGI8FXvMrn+wc2TZEIWYH4rwyJOy0P+rG40mPUy/Uxmansfkk3zbGKv68ns6Arc
	 tgAY+wyvMWoJ2hAvNADb6fOlrYHuZM75Xrwzq8Y7/DX6hj63O1Kr3eeGNz2PYfLZ/Zb7k
	 lJvLy3ynFjPzCIx82IXP5/vtvc3WAT2vhsNqtmqGufHRZIBAKH2FwJYdKQ+cQ+KrZ0w==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793533993;
	bh=NR95k8bLvy8kZ+NltoEGyYjndBr3KQTpomy0PkegGR8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V1aGrqrYuZdE0TgtyzkBTwD90dIzayknjT9T843b5Vc1pY2aNwTHVZBli6IFsd64R
	 2+6pP6KYQAlOyNPpMfkdrkkCHVZVhrB5Q3plG0GouL6rJ4Wap1S8tYi92Bo3YmA6uL
	 Y1ZMYDBJgoNuJrZG4DO9qQrnt2oR3VAYknSCQMU3TU/fbqSsrEv4S3gyV7vceIscop
	 TRZnVU9AbzuBWC4xhrYnkQ3+J5Hmivp5YED1gDhwcmUXexvCFojTjmKtKMaDLEevzt
	 4/Kl2sZR/uRf7v8rypisjyIB7IkqfhvtmFtgx5hQ/DP7F4yl5MOzQGaokBEghyDDdw
	 Xh4mZeHNBU2Gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6209580FA3;
	Sun,  1 Nov 2026 11:53:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B514323
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 11:53:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1103E40602
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 11:53:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id El57cEo1lFJe for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 11:53:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 85947405B8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1133"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793533991;
 b=oBw8HcEbp4rLKGfYUeHMEOHwwzCIEzEgOoGIA0XkjJO62WljReG1m0ghfbiSAHXApN+6
 cg4rkBO7t0VJA05vLm0y/9bAJNVoFBM4G/Vr2q3xyXW18fM0e94WxcvolCBW/OU0kp0QI
 uq99/bQQvDSDXcv92BGFsBVx/tMd53ydqF2vRDpdt6GVSwDVS3jimql/ljwkslbJqpiAS
 lZb6E5jJiZXeq4IaV4gauzj5huLFYtEVZJ8qd2lUzrr9SCSs1MwHXRMlmYIvlBRc5AuIn
 q5shYUz+cm4WX+gKGqpvPFiPnElFnoOmM4kjEz0C2HFNA1Kmd9lCNmjJ5/CAugJ273A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793533991;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=NR95k8bLvy8kZ+NltoEGyYjndBr3KQTpomy0PkegGR8=;
 b=LqY1+NBQFiSNDBdnpo+JE47tLKnnDvFT3RFu2l9Rokvm0cba9bsAkzCR1NfOoF151ghf
 AG2z062D15DElyXtG5aB4UOubz3y9GEmRrYPiR66LWvSmN24F0mdx71ZEgUUGb5OboH+W
 VT8+kPHsUP7iTHaGo1LqwqWPgTD7cqGCME5Z6FvkVhpVmBa9SvLJhaDRktCiS2sTxyjKH
 j0qGx682j6noZcj1EiELWVTwjtByhyiIEAqAiE129WOu1NZqh3URwbl2+b/oNXCkXfHn4
 3J9mEvyOrSSDPGg9ekm9lTndmzruveEP1tMGQX/h2Pk6VbN6WLJGKjzM9MgdRQSARhw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=i4m+NOoD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1133"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=i4m+NOoD
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 85947405B8
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 11:53:10 +0000 (UTC)
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8b0e21048f8so17390877b3.0
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 03:53:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793533989; cv=none;
 d=google.com; s=arc-20260327;
 b=KLDIZ74V/w7pA5M8jPdbi65SmXZz4kF2Vnp0o18Y//VPGllG2DxanrvKIJ5Brnengz
 y1o4jXJ1cC3dU7PDDi7jSYG3l2nVhSQs/sQrIHtCs8DB2kXeLM2lKy9ctBs4cW1uE6Xz
 GOKrBxyGAA36oe4i8R8TFdiytusyg+g4wV7/QDh2nccgiQA2KrBinPSyiRGB5SvLwfeL
 2zvS6p0l7u3EQEcto3Jpyg7izLvCYgPVcOdA7Z1GcmXGMiDkBW548yMagl0eCnKziA2g
 Z3dqmrLkdRZViMegOA9ni+bXbcFyCV+zUUDz3dXZKBMuY5UVY87mXIPIAJLWl2/NLN4k
 TXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NR95k8bLvy8kZ+NltoEGyYjndBr3KQTpomy0PkegGR8=;
 fh=7QWwyUnPAQm5WNln6yz2UnPVMLv30rqCuNC8nkM6bR0=;
 b=OoZriXVqsQi63gXP5FVhVMm3VoXxFG3ccBIEBdYTl7u/sQAN0Ib/GPcbFF787q3Ymb
 xBGI02d5v7alKow3HkNuCGYFOl81A8+9HA5AcbtROSI2ynb5nSXju6SMq3g3n8/bpLr3
 /NrEX9KmoX2WHNxlZJsBGhafVX98vyoaDtPOFQ+tP2zjYSBFCDm1GWL55h7CLFPiU5Do
 +NeWXHFylxtI6nIyNXmX5oIOUOchw/NeQvlaftgd8ZqbRBnWKHtbMvADD5pHq5EY7rOy
 9zrjcUMvHWnFaJ8NpliLa4tSYwkoG+AJzcuOu83gomiAV6VREOwbBdizl20oSsac1aH+
 iKwg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793533989; x=1794138789;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NR95k8bLvy8kZ+NltoEGyYjndBr3KQTpomy0PkegGR8=;
 b=i4m+NOoD2odxIqRpWiDXuZ1HKBV8S6eJzheF70rhbJsPi1vLng9rFzdw3xd0NcSqQJ
 BaCY03VP3c+PmTuGyCX8AoLUkgA45NurpkWibezIMqCQ438YhDzNRr3P7sfuIsnwnY/l
 Dmk2480kN7UrxOjfOSJZq/psPj2GQvhzi+jDPqx1Qg34OZxzAELJkxk7fsanyPtmlB2q
 gg026AzThXt3YAZ2/Pr6jvFIsWx8xeQu6MP+Kzy8/uRRe5gwUmNanX8whzB7/nj8Pevm
 Q+X2MXeh4eVClOMcjoDv/8MW+8xRMlSdPqFQuhfhe5Jmfm9CGeZEe5fzmupJIbXl+Ytn
 0v9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793533989; x=1794138789;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NR95k8bLvy8kZ+NltoEGyYjndBr3KQTpomy0PkegGR8=;
 b=13WWV9LHoXMNw7GL+WvhW5HTrWPc/6lItdLDtiQY9ghgGzIxHlTI24LA5+gmKEPXN3
 qpNlBPiJeiNjVRBBEJO2HJNCu817qU5DfpcTbVIzKwrP1wW9ZAMjoiWYMcxMQrPlMyV8
 uqaRpE5D7GxCqqmUtd40lkuHdC0U1rxfR7yAg7fiIGmbZ0Bokw2MoT5TSrW34C/4Gdle
 aFcJUhI69o+LX06ZC2/43VZULnVUzP/bplndpkcBM9YigaRkx02YTDjsgFy1s75Tt302
 EA2COIPPLPJNshR8U1Vc1yqXza05X5juA0LrLIecCrOE6j2EzrHhjYXtS4MVHP72uGuH
 sGDA==
X-Gm-Message-State: APuU4Z/M0tGUEJCLlKqTSPPE33UKdoI8y6ukpgR/1pbbEnRh5rxhojAg
 aGDkK6CSSK0h+SyuEjfoXZCoArPyBSu6bvkU/s6ruLfht6gaMRKN120RGTxoqQ+p096tKXb7Y++
 LUkLqXFqK1qX8S1ALWGHrHgfef+aUr5RCNTpzZEcrkg==
X-Gm-Gg: AYBFou0Kpfx6Xanev/NvH8N9iQkQ/wHl0KfoR/aFDuQb/H/RrgttakAMTciL1oGhEjo
 OgigDyMOQDd0I3+bNAyjh+pKmVy7SldSCA1reRhZ6GWiYWjQ8pBA/QTszfI1TX30K2yfY0Iyf0A
 kaWFQ8k8cnJJ6r+g2XFJY/5Y/XiW++vgyMCiLUIbrlEsf3aFhtEfi2ajfRR50ocx6O9fPjyPMKS
 vjS5ypfz8u/nffdbFLBqco1wBW4+H9H6P+N8F1UAJK2l3nj5/bxZDPrWkoKet62O8kNZpexSweI
 1FVuK6tKGxhuN/K41w9PcnhPc7T00GkAQ3qLg8LwJNCBxVfPP+Qx5Bqb1XzJwYgVAD6ecg+4VPl
 IDzUWsky8+pWPwkhvnyy3ry0bfTYVFy8EmRpwTnLIOLRQgIxzIGXeAN5rJs2t4KGoW+4KhMKvNQ
 DqHGyVBFOi3pNhsKmKEVk1i3lRUPan7mcl2+TDrQoy+874LVVYLnVUxstfuByuhtt+f5IVhRM0M
 tbSOaAUV+utVVRNYuBBCGux3FDRt/DLoAbQaiL/0p4kj2kQv5VuV5aNBrN4QxpkJ/4/bOv7BwcD
 2MyEuuGS7Eh/P5UPlmmXPVjehfLAezM/+Rg8ExsCXHYpi2rnjvDP36rd8Cj5C1lUyluUeNnJz3/
 6jf3jB/4PMSEYIzhXIlzMxuRGanw9OQbzGHktsFIG/rUnsh+PGj95wtYf4nijYKYCpE9B/MeG51
 iyEuepoJ2WOJ84ln2Fz6fRoV1MaiU/1DGDRck=
X-Received: by 2002:a05:690c:288:b0:8ae:87e7:9ab8 with SMTP id
 00721157ae682-8b2b683c2damr49746037b3.67.1793533988643; Sun, 01 Nov 2026
 03:53:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029150906.1558380-1-tkirchner@emlix.com>
 <20261029150906.1558380-6-tkirchner@emlix.com>
In-Reply-To: <20261029150906.1558380-6-tkirchner@emlix.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 1 Nov 2026 13:52:31 +0200
X-Gm-Features: AclHuK-2oj0_YztwH7Ji4WVhI06k3i4FQ4xuD9AWBv0_b9yCW_N4zpS7iFHtziE
Message-ID: <CAC_iWjLX_3RAzxeCy7HQHEy+fZS4Jm-J_E6wnv_QG5+DWpX+GQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] tpm: deactivate unsupported banks in tpm2_auto_start()
To: Tycho Kirchner <tkirchner@emlix.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Eddie James <eajames@linux.ibm.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tycho,

On Thu, 29 Oct 2026 at 17:09, Tycho Kirchner <tkirchner@emlix.com> wrote:
>
> With CONFIG_TPM_PCR_ALLOCATE, active banks with unsupported algorithms
> are only deactivated by tcg2_log_prepare_buffer() or, as a fallback,
> when a PCR is extended. Users of the TPM which do not go through
> tcg2_measurement_init() therefore only notice the unsupported banks
> when measuring, e.g.

Yes, but users that will call measurement_init etc will have
initialized the TPM.
The PCR code exists because some users want to use the TPM only as an RNG.

IIRC we can't get rid of the EFI call, because it's there to configure
algos that where handed over to us from a previous stage loader that
only handed us an EventLog. Can't we fet rid of it in pcr_extend
though? Also if you do get rid of, this needs to go in tpm_init()
instead of autostart

Cheers
/Ilias


>
>   tcg2_create_digest: unsupported algorithm 28
>   Cannot extend PCRs if all the TPM enabled algorithms are not supported
>
> Deactivate them in tpm2_auto_start() already, before anything gets
> measured. If this fails, e.g. because the TPM refuses the allocation or
> no supported bank would remain active, return an error. The rationale
> is that with CONFIG_TPM_PCR_ALLOCATE enabled, U-Boot is expected to
> manage the banks, so fail early instead of at the first PCR extend.
> This is in line with the TPM_PCR_ALLOCATE help text, which does not
> specify at which point during boot the allocation takes place.
>
> Signed-off-by: Tycho Kirchner <tkirchner@emlix.com>
> ---
>  lib/tpm-v2.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index 18ec9eb960d..bd049fed748 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -232,6 +232,18 @@ u32 tpm2_auto_start(struct udevice *dev)
>         if (rc)
>                 return rc;
>
> +       /*
> +        * Early deactivate active banks with unsupported algorithms. On success,
> +        * this resets the board.
> +        */
> +       if (IS_ENABLED(CONFIG_TPM_PCR_ALLOCATE)) {
> +               rc = tpm2_activate_banks(dev, 0);
> +               if (rc) {
> +                       log_err("TPM: failed to deactivate unsupported banks\n");
> +                       return rc;
> +               }
> +       }
> +
>         return tpm2_update_active_banks(dev);
>  }
>
> --
> 2.47.3
>
