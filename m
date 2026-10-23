Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C9E60A261C
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 07:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Lx6SkKcx;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=eGSU9P+1
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6A978117D;
	Fri, 23 Oct 2026 07:26:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2fVYkb4KdVPV; Fri, 23 Oct 2026 07:26:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 126F880F30
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792740399;
	b=mw5XRkHtBVIZIH9hjBQxr3IeFqfEaNinkRFY5dPtPuKMIlAcCkWDkoJJPluCy3F7Onug
	 VATzxTns0kBotUWBLGSI7dFF5r0DJRbWCOKhCFEvcIB7oi2zz+bI5D/VCsnDFOUFT7NzM
	 WQKjnlYk9dgpNCZqUwXimxl1yrK4CBVH77IUqUZaE5X0fytBYhornL+ZLWW9qLxwWqnGS
	 DEfp1uAvRhnMUlAZAzNqhG+WZKogeozunrn7zunACCU6t/JIwCqm6TbYgqd4neR+wgaRT
	 T/aencpsYf6q+W9rK26BUTiP7Lv/8VWo5syuXOLEsVhgmI5CtPBrUueB26+5lBb251A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792740399;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=Cp6zU0zCIzIygBQ8A2L1EyACgPIsdgG+MEkCDy0OqmQ=;
	b=blvnf3KGRE7wZwr0nUDutguSx96ZcRa3nLNGRzr3oUNcvjt++5+NaOFoFcT1nrsA9U12
	 smYa3W15lFb2fMoCXCD/1etaEfGdjoo+Aa6TUxOJqEoNsDH7y0D9UPcZKtCQIa4En1Lho
	 Jn0TJt/CCtosNq7GCqArUzCpGghhAy9GkW5wwjSRHskx2D5C36OEM8DCrF0gaAgcaZPgS
	 ofWMzzlMXoQAHnxklOLt5KJ0T10Q9wIsap0swwsEu4dnncVP8qs5a6ENsrx05msQyA9uO
	 rYFiGYmzyOLgkzPHSFIucNP7q0c7KzS9zYSXYjxc6jWHZITs5u2JpDSzzGPmNT4Vt+A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792740399;
	bh=Cp6zU0zCIzIygBQ8A2L1EyACgPIsdgG+MEkCDy0OqmQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lx6SkKcx3Xd5h5VTVuuMSDWg3FLy+mQLhewIsG3OGVRdMdaqXfjKzalUWGuJqjJcn
	 IgzLD2GgMgKaJeGJGSA89xxAK+5vx8NyHzLfEI0b0mQnPd/uWZueW1GKF02yozauHN
	 dS8TjWxGrES4pG3CImkMeOFENLDdXySn/szDhQM6YUomWuEl2XxDsys0PJqGBMFNLf
	 4SCXbnRK6n8GRhDTFhW5NKS5ReP/w8ToT8cAYldeKqcwMLTAjD+lJ8h+h2WqiXtl8D
	 S4BxflA6DQwhzKKd2+iYU9bqr0Zk5T/YoA67q4Yo+tc5TkjWYw72//Ib63/LDKMqYP
	 CmjUOBz70LC1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 126F880F30;
	Fri, 23 Oct 2026 07:26:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FA9A49D
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:26:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 416B5400AD
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:26:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a54VIqGTrMNI for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 07:26:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org B8E004008A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792740397;
 b=VersT+IpdaF1/xM1Wh85xIyB45aGNfnbduYLwnxvWUyMa+gLNvjY5KigFk9/WsroQj9b
 LSSH+112iMSgZf9LZPIA0EK7Lw0t1GpbfITxkU4LLi70MsbJq9+urena3QGMSAelo+6rQ
 OTJUxTXD7/k18W5IBUINld3Tjg/1/0EK2VnyXeLRo6YAG4j1cF5HCeysLso5mCpzWXOTm
 j2UGxi0apzAySaUolWhN0xJKG/ofzXXPJbhi4BsebjIyowI407XV9o6j9NW4F4PXEaEj1
 Zk4tq3DAgtNQucSkNq6f6c1fqVCl/u+fdFF/zOFuLAbmnGw9zDkBnY1iIPnRH4DUKvw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792740397;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=Cp6zU0zCIzIygBQ8A2L1EyACgPIsdgG+MEkCDy0OqmQ=;
 b=Tl8lrmR7D7QeYaBdGiZjbQO3h8mPT6tmFG9ifPijCSk7ES4WCNH+p5LUFusy4K6etkUW
 nPTe6HSzDYwczXtyCphnI06byHTsWwvlFodOsErJiabEwHwGoZObEAisyzZ3TFtx2Jirc
 hIvuMVcd84rTnIfk/iZkkS0uhXlrn++KG79I8GCX8D3XHgL/GVIMIPSodclWIPbqHUimZ
 nifWgSWIsbJdVxZH6GkmMeLi+Cv694Oa9G56qKAgVFnA8PWDdJSwmPdQsdb3/MfINhBiP
 yRcoGHnn6S0Y4eybV92b89G6V882u+kVFR7A+t2kYK8N8kT/Hro3ZGVvcbmhrXgGiQQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=eGSU9P+1; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=eGSU9P+1
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B8E004008A
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 07:26:36 +0000 (UTC)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8a83d2706fdso5591927b3.0
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 00:26:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792740395; cv=none;
 d=google.com; s=arc-20260327;
 b=Aj5brMOs1V6f5wXWWy64NVUYDWOFzhbfoSjv7FqHOdS5Fcd3GMMKgELvqsh6Hi15U1
 kAlC9jF9NDEzO6LDV1dyjce9kp/yArwE9zndUT/lKHuMso1G7Jw7B8HRvZPW657TIbGl
 8SYZjvKVRalVfo+aujr45b3QKVsfj5vKH8zhPq+68m6UTXiT70JaaCogUop3lcjHcw7W
 eDCmSjO+l/ykzdKtk/Eeeza6FN4FeAx9IXkrQgXYb9K8AsP5SoS70ktF6pBc+Ubx6b1u
 buVradZYoK9PtQ+SgXjUzXAiU0WQ9GTjuodeQkV3UONe6qQP3IybDubzAAVYLG3mf1Q4
 9Ygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Cp6zU0zCIzIygBQ8A2L1EyACgPIsdgG+MEkCDy0OqmQ=;
 fh=lZ5WkYkUsrHZYsKSvFiP+0jCNTbDaq8mFviKu0f7zXk=;
 b=hV5eRkms2AXZIpyVVd/a908KfkOz8eSFAS3semNSO0ojfiN7i/TuyeZzW7tryiKC1n
 8FaEgxMLKH5xsUoCg1TP2GH82JU0KS8Igxi6h2m5jiOZBtP8qgZlXhO/Z2UwsRYXDh4x
 pl34k+y9LfctMFEdwiIfGg7UUFsBf3Ock8WNalf3YwwgR8NtzSjQB3oKofXoSHcy1BUu
 g5nIpPpdvLBry01N+7qvc5twp/ndjlLIvPGYF4uG9aZvfXgV8rOGJZKGasSVcxqomVz3
 3FAG1UlrS5qnJSsij2lV/q6CasQGHA37MR1z7+V+L8KaZRN1bjDZSLuU7vUKBYoxmOz4
 tuvg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792740395; x=1793345195;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Cp6zU0zCIzIygBQ8A2L1EyACgPIsdgG+MEkCDy0OqmQ=;
 b=eGSU9P+1uzwSTSGyAO2Rkr5+KHxwfCwc8EodGCSnRP1sEBRScFJJ/onsjrvM2AYWXJ
 1/86tOsrLPj81ID6IVUuIWLnhR6E9n4NP7e0sHPO72shnYRzgUK79PtiXW5FC6aqr43k
 xN20koYctA00yn6y3hLXqupaTDQVxv4RNoaz+jhegfVvgnJdlwqDsGzXBa4idadwnaMi
 wAuW0vPCcxTRBzxM4uSgzhCBEBQj5zmDyAZGYj13Z5kWnrDfALgHmzeYUuaSSaSx86ub
 I1VKPTOiLtLlowd/pNF/Q7UISfDpNI+o52OcpPs0L6mg01201VkeW0usvnxwwAgTtsvF
 FiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792740395; x=1793345195;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Cp6zU0zCIzIygBQ8A2L1EyACgPIsdgG+MEkCDy0OqmQ=;
 b=VNKKqWChI51G4HxDmaCaPw3Uqb+jbY4M5EbkSajdGAWN7jcNJMWjOYhP+ouif3BWMY
 iLZ52HlqLJmvqJvf3dtDAeyAPWfZKHEzifa2HvQ4tjwpXKws8uH3PExO/mcuk8Fwy1xQ
 2oi3r9MDxHOvAaSYwPOJQUrgmbIBUyeZ5/1Akay70h5mOUEvDoU9BVSI34vv+Vrint60
 +KMWG2mj+RojkkzJ2eO5XqHKXgPlhSXB4UmyZnREMy9gMx7Fzt3D8G9zqpuAWdeycr2n
 cBf0W+vY4jUlN1ZUUs7uK8nE4/sUkbnP0TGRLniZJ/YBNawsWeJxyNj9RpThTwRxY3i+
 bOEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgcdyV1wt/hJoun4s/ot5mJSVdmew7Dx0vVa87gEZEg7jjIiCwZZ0P6/qC6yosPfGCJueuB5A=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJKHM0IH02tFsa7A2EgDCQVSihUSSwA5U0k7pKJzBZ7ampJbtLN
 Gfdu9/p3kBiMCjm1XGLPGS7hUMvotc5K+WoEjIsjOdqlDZEv9t+m1iJzpS7dIvPR0gO7dnzOHw5
 Oglo78ovldefbbkv5Hdy4MDS7UH8F0OZxAGi6YufT/Q==
X-Gm-Gg: AYBFou3aPXmrA2ahigqM6Fm7hUil+TQeLSGxpxKALuWewTW0AxjTVgH6oBs1GRz8Yd8
 fb0nrH+hJd5Z8BKmdbDzLU3xJ1ZwMHBTiw1qRNw6xxQCrZ00Mme6FoPMsXTLkzSKhh3y2iPaYWs
 4SmYBe13oA3d+bKZm8g85qZTG2unq7wUMPHUx4F6no1ri0Tg07YdivJpsgV3nEctkIBXtwQ3z7R
 MxckBzXG6I3vfqObTz/pWB7S4eZsHWlbk6WfnMt1QWDbn4E1wUT3OuOSD8Z/+/UaEwsPimvmRnR
 o6GrneEYqd/YPScA/bPdlg0Crz0DjM9LWMjZ29m0QuoIX3zeWKoTFOJOodFkKrp4IiZo257HBl3
 BUgBnXJMRUISbsl5c9o+Kum1q/Yer8TY9G7uMF74DfQ3YN9K98jByu4mpCtqmnlfSXv0KRQNSJV
 crk+oUI+Ba62lhTbGkVTRr0MK5bYicPOUgKDT5xNzuhcM3HRJft0dFZh3RNJ+awOtEK6iq6FW7r
 l/SEcHSe2s5CtIUqBSEPsOmzEmgJbQkLkaCZX/5KpEmIGQKLvk1JYp70NnjPTkYn26Vettobkvu
 wGQrlqIO0Rfchhqxr1r1weh7XJ+Hl57iDqegMHNKlAHXXkA7q/4A97sS18zU44hFEciA8PZiKIJ
 y6Ql2urzCTdkMnxxMP79mAg7G51Vkf7gHzxA6IW9IaBFZvZY58IOIQ4Q9keDpola/EqsodOK27I
 EwTYwhlYKW0UcVkWGEemDinFZWsAk2TpUFJOz8
X-Received: by 2002:a05:690c:e68f:20b0:8b1:3707:86a7 with SMTP id
 00721157ae682-8b157e6bcbamr7470047b3.83.1792740394760; Fri, 23 Oct 2026
 00:26:34 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022235602.221357-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20261022235602.221357-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 23 Oct 2026 10:25:58 +0300
X-Gm-Features: AclHuK-0k4P6iq2z4lWXKnBdTbF45J7gRiVbZ0Nlag3xmHKN0VwBWIC6Zm4b-3o
Message-ID: <CAC_iWjKOd0LSgJhAxDE=emrzgn7pW8CygaSCPSvkK_nyzYD7Lw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: fix HII GetString()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Heinrich

On Fri, 23 Oct 2026 at 02:56, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> * Add missing parameter checks required by the UEFI spec.
> * Return EFI_INVALID_LANGUAGE if a string does not exist in the requested
>   language.
> * Handle querying the string size with *string_size == 0 and string = NULL.
>
> Fixes: c9bfb22296b0 ("efi_loader: Initial HII database protocols")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v3:
>         Update commit message to indicate that parameter checks are added.
>         Correct a misspelled variable.
> v2:
>         string_id == 0 is not used by our code. Return EFI_NOT_FOUND.
> ---
>  lib/efi_loader/efi_hii.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/lib/efi_loader/efi_hii.c b/lib/efi_loader/efi_hii.c
> index 90dff91e5d4..47325f7d8aa 100644
> --- a/lib/efi_loader/efi_hii.c
> +++ b/lib/efi_loader/efi_hii.c
> @@ -910,41 +910,55 @@ get_string(const struct efi_hii_string_protocol *this,
>  {
>         struct efi_hii_packagelist *hii = package_list;
>         struct efi_string_table *stbl;
> +       efi_status_t ret;
>
>         EFI_ENTRY("%p, \"%s\", %p, %u, %p, %p, %p", this, language,
>                   package_list, string_id, string, string_size,
>                   string_font_info);
>
> -       if (!package_list || !efi_hii_packagelist_exists(package_list))
> -               return EFI_EXIT(EFI_NOT_FOUND);
> +       if (!language || !string_size || (*string_size && !string)) {
> +               ret = EFI_INVALID_PARAMETER;
> +               goto out;
> +       }
> +
> +       if (!package_list ||
> +           !efi_hii_packagelist_exists(package_list) ||
> +           !string_id ||
> +           string_id > hii->max_string_id) {
> +               ret = EFI_NOT_FOUND;
> +               goto out;
> +       }
>
> +       ret = EFI_INVALID_LANGUAGE;
>         list_for_each_entry(stbl, &hii->string_tables, link) {
>                 if (language_match((char *)language, stbl->language)) {
>                         efi_string_t str;
>                         size_t len;
>
>                         if (stbl->nstrings < string_id)
> -                               return EFI_EXIT(EFI_NOT_FOUND);
> +                               goto out;
>
>                         str = stbl->strings[string_id - 1].string;
>                         if (str) {
>                                 len = u16_strsize(str);
>                                 if (*string_size < len) {
>                                         *string_size = len;
> -
> -                                       return EFI_EXIT(EFI_BUFFER_TOO_SMALL);
> +                                       ret = EFI_BUFFER_TOO_SMALL;
> +                                       goto out;
>                                 }
> -                               memcpy(string, str, len);
>                                 *string_size = len;
> +                               if (string)

This is always going to be true since u16_strsize() include the
terminator. It's a nit so I am fine fixing it during the merge

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> +                                       memcpy(string, str, len);
> +                               ret = EFI_SUCCESS;
> +                               goto out;
>                         } else {
> -                               return EFI_EXIT(EFI_NOT_FOUND);
> +                               goto out;
>                         }
> -
> -                       return EFI_EXIT(EFI_SUCCESS);
>                 }
>         }
>
> -       return EFI_EXIT(EFI_NOT_FOUND);
> +out:
> +       return EFI_EXIT(ret);
>  }
>
>  static efi_status_t EFIAPI
> --
> 2.53.0
>
