Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E61606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 06:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Sc4g2Mhw;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=f2jVD9mg
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21DFF40AE2;
	Sat, 24 Oct 2026 06:23:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Nmuby4uvYiZw; Sat, 24 Oct 2026 06:23:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 39A1A40ACD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792822984;
	b=frhaYzOsHVtqFYmmiIKvJ0wDBB6A81qYUVIHNG9VZilpQSnYEs4+w+yI6X3ITPJMTYuN
	 hUSsRAx1AEXOvydvuJvyljAIGrlPHKBpSMy0ozRyMj0yLydLaoQnBHcEo1lD8GxGG9P3B
	 mAFuIL8gcn49oQXzrqX344Uxn5/sS/t2Z9ya4cvQxbONaxD1fUpRCIrNifoWeGTXZdkUG
	 vXTGLONLH4xbCLqQiJeM38cM8RDGKQh4gPwEJMRUdvRhhJKUJIUGA15c+Qi0+q47GZjA6
	 8VxgEZRDseZE/zNMyC2yL+BqvhWj4vy42PymMVJKc2+Is9e1FAALQ2HTeRjaBFOI1bg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792822984;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lwO6J4HP3L1+RiGQh9t1cvgmSU87LG4TF4PA2njuZKo=;
	b=MEs2acGg8VDmQTAj0+X43SR0e1bxghYmeUfrccfYIhFVCL9DPKieGlBoWffATipZUsWd
	 aU0XojHFZ53uq3cNctxlkX3GqWnjaCi3IRo33rnMIPLbcM+5RrUy1sU+XIZYVlLO7K2DJ
	 7EjYwNJKT2ZpvChsc1XjgNS9Ll8o5nkmpAFbGHxVEDSaVmKRt5xxw5gLtrguSxhBrIJe4
	 cF42h59MeQnYMjNa7eR78mHxF3O0LaLPDVQCtFfSoI6n/6q39n/+RtTrrnm8JRDzzv7aR
	 fA3dF6glMCcp1PbTGHupoflHXuKNgm8TyDBeeHUTyK2FISQ5HkqQ3ZiTGYntNQGn3og==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=f2jVD9mg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792822984;
	bh=lwO6J4HP3L1+RiGQh9t1cvgmSU87LG4TF4PA2njuZKo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sc4g2MhweFtZh80bZWaYZJMcyOrkTvdi7MfozjJRdQsQgCBB6qJdVw+1/THm5TYvJ
	 PMQlz5IcIklW+vV8j5RtLm21polcuIQzgoapjV7lmosoOiHriegR1WvHD08nnR5ADK
	 WiaiA6BcURojixbNgEPJL4HQTfc2alk/llXozVT06V0SLGuUUaIw+hd+Nfk32gLsGz
	 VnQyIRvg/O9h03MULmT/FiKdIG6wyeOohYSAgncCYxF8s3xowrsskWxlmsd4/G7hGD
	 LyB9lOji8dyylNXEIrB/JB6qepwMmwbafKljdAFzB53XkVP0okToZgeJfr/x4zA2Vy
	 OkFh8+260L29Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39A1A40ACD;
	Sat, 24 Oct 2026 06:23:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 64FF03C4
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:23:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 629F440ADE
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:23:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Go0Cm-oqxHPk for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 06:23:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A7D2040A99
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792822982;
 b=PDA+PtY1RzgcQ9h03ubfSDl0CyhZVz0y9l0zK7gkpFN4IP8SuC+54c3+86Ff9Z6XY9rh
 +dxdjYxM63RGvcRuQkUbw62vQGmM58709jnZez5fP3owblVz+usLAhndkWHyIuSHK9Mr/
 aw2gBGrJEe0/95bTCZ4zqkg4iA0ohd5w2ZhBuncYy1L/uPJGVc9ABLsEXiBJufQj0vrBS
 nObbH1TloXr/ZZwcCzhySgnCnNReEHCf+L4y+kEks8HTqbATABTtIZc3cwcB++OT2Y7RQ
 EafS4AkA7ilAoGk7t7YmonoSko8/aux1ZUOgi9GeF3jOk4z1251+kJL+QN1SjWBQjUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792822982;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=lwO6J4HP3L1+RiGQh9t1cvgmSU87LG4TF4PA2njuZKo=;
 b=LJEevQBo4v+cXbUECSCOUe4LmOAmO0W2RiJRLdqR9IZvYLZjwPlMDXxSwwrGHhLz8UHV
 bob6hdYwN3Qo1l9Io3uzr/DFAIf+mdNz5DwJNdjT+7UYgK9U7263Y0Y+A2EWBwECVwhUq
 4/q+aLMDpAJS+Cxi8zm8CSnjetFxGu/tG+6zcgW1XHYj4R6UXmJ1FxELAqZbbPCfRz0+e
 tOA9NlkAr65/oIkbtwNP26MUzSWBGOEbUv6a0yE1hMtk7HIEoki9AX2k3eCj0tfJDRqAd
 Q3Rbe+WW28hdw6gTZxh0YwMIBHNXR6JxIvOtMOBmcYDgNAWN+QulDIsGICDsJUu3kHA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=f2jVD9mg; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=f2jVD9mg
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A7D2040A99
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:23:02 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3ad787e0593so728361a91.3
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 23:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792822981; cv=none;
 d=google.com; s=arc-20260327;
 b=V/HWQWOzaFO1/NrhoqodibC+Lk0Ep7677vgmmCQ7Odc5oOGLDGGGjlvRB1cbiUcorl
 CTsr4IswwXa+AACsNnF4hxG6YjAYy4V8vlEMuaZXg/OPrKCsZCXoOF7KLdbHF4l3Xvl7
 1vYvUyTqsOGoKyNN3c0QBLPuRbP77BZICkYkCDeyyU/FrhCpa5K2EQoFWg2bFi8SW2/s
 wrvPjOjsnRnr/xO2qp+jqvLH2NlwI9xLZV0J69IIlCPDM/H+TpWImwls7Sd9lKGrJRQH
 Qr7+xO7BwYAiC3pnXdGkFrogAYE4PTQ0BRXCdjqQtnQpn4nVHxMNDGRX2XrPaDwUQhy2
 N7GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=lwO6J4HP3L1+RiGQh9t1cvgmSU87LG4TF4PA2njuZKo=;
 fh=4elKA/8R8nsp2QSEXfJoIvGF0mo+aUc0n1hMY1echd4=;
 b=jL8hwE/9bgp0rDm49opVDY74SsDW69g8w5MqRdpsXhy6Hi3MsuXsmEGIjVpuQ/DzNI
 3ZS6UFWxLwvDtb3vsjLBRejNzZmmHgMRHDMM7wQC9ENNsOtlXNt/P2vqPC6dZ/RcJUXk
 48fhVCSGTJDE9ptZUCfyq0s/246AhqHIXwxMZvx8lD7GEQU/5/orlD7mzFK/nnRnB6y2
 8zfiuSlFyDoOvHsk6aWdgvNJDmktDetVzvraLKXBnXD0FFM0DqWxoRSRFYE+s4yo0kNO
 CLl6cAPON4ja2Dpf+HcyE6R8PW9Vhc3Ua74D0jt9AqccTUYu5zeTFqorvU6VDsB/vPnp
 VT1g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792822981; x=1793427781;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lwO6J4HP3L1+RiGQh9t1cvgmSU87LG4TF4PA2njuZKo=;
 b=f2jVD9mg3Xr/7frSDrogLphk4GwEhYymE/71l8SLC7KVG1ORarj9VMBuW9HJB5Hm3E
 e7JByYWqOFVulcfynhb3PxKvb1T4B/O5nHIbV8jDuLIQZ3hewqTuQA39xRTPOJv7cXmz
 JDZLrQNaYZJN8KRPYahsq6qFvHLq+oBnKTjko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792822981; x=1793427781;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lwO6J4HP3L1+RiGQh9t1cvgmSU87LG4TF4PA2njuZKo=;
 b=d3y1GSPViZYbyS/t2oPNSt0K4c+H1nWNNViHduz5BhurjJj5ztqvxrIfAOLVsXiZaw
 5mp8AR74twKatZqYd1YVKdGJszKsoXk0avEsvtinRSOzJDytoa/gZ+CkcFIwoam8W+fP
 YswX9HUXav6ueujKjC2LP90tmxb5kt5hesR00yn9eUUOEfjCqHfIRmGqBR8oKU+gzKG6
 2jv5TvGNxvkTgLUsg6MnZvCgZtQ1J3JS+TpvJDGFvSpqV5ZYtpevx7BxBnSOWevv26/Q
 ZZ6sQFxc4WS7MoGSVg3D45dD0W23N6Pq+QmeSq1Svjk4oKuAoKDwVTClqpyyEb38e5RZ
 CWpw==
X-Gm-Message-State: AFq9FYJYCX9jAGvyplnuBuW69/Nmcj2tn3Fz5/MdR4aci4+xLP5DiI6j
 /ylaV4LrSiXRGYOMHTpD4j9YapxQei4SbvL3dNO3lJS6Z+sFV7KqRDzdQGqnA487optgZxUoq6P
 Bdr5gIO1fqPTafsZweLGFSOgrcDIgEjCVM0eDRwBC
X-Gm-Gg: AYBFou1+iUmgwNJroUSBtOrssZhYj56EyaqRKO3YK2FKBvF1tkAG/J4Eyc0hJmEZxpT
 SKHEleFJHArUwky9aIS9q0fse7gsCuTqgNgDaanuJvZWhz6QJ1WSovgIkJp8hiuNozBj2D1hpj2
 7gzOaJ6lqsQXNShsvfBmpBXzAB+CdAv2gvLDWCFDthtyAnyVH9TZD2MLf4UspSuJz9Qj6PuZm6o
 YWZ+CjWAHPUGVuEkv60KZpdnIfrsgesz3/4uIJl/5QSV/IfIn0bGKbjuqWe7hrYaicD1vJvqTgw
 0O8S2N7mhC15dFJnsY7jKUyqzHflv9FIYonM3RAOMni7WaWtB1XtlodvLJPplwKJbXizHF6SOf3
 96QvF3axAEWsbXntRXBSAMgHBE78hVk4HsViQWouKxlrtuZi3yKkohRZz
X-Received: by 2002:a17:90b:4b92:b0:3ac:6fcf:81a2 with SMTP id
 98e67ed59e1d1-3adeb137d1cmr1057899a91.57.1792822981591; Fri, 23 Oct 2026
 23:23:01 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:22:55 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 04:48:53 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261021102626.264091-4-ayoub.zaki@embetrix.com>
References: <20261021102626.264091-1-ayoub.zaki@embetrix.com>
 <20261021102626.264091-4-ayoub.zaki@embetrix.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 23:22:55 -0700
X-Gm-Features: AclHuK-MbELVaYecxAnEwJM8SKG4M2bqPSINvyO_zTVHsZtxN5_mNQ3VQkM1v_g
Message-ID: <CAFLszThcezHCo4LokzZZsE3C8pEzoeLETWi3g9BDpiaCjvr5zw@mail.gmail.com>
Subject: Re: [PATCH 3/5] lib: ecdsa: Accept .key private key files as a
 fallback
To: ayoub.zaki@embetrix.com
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Marek Vasut <marek.vasut@mailbox.org>, 
 E Shattow <e@freeshell.de>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ayoub,

On 2026-10-21T10:26:22, Ayoub Zaki <ayoub.zaki@embetrix.com> wrote:
> lib: ecdsa: Accept .key private key files as a fallback
>
> Allow mkimage -k to use a .key file when the ECDSA .pem file is absent.
> Keep .pem precedence so existing key selection is preserved.
>
> Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
>
>  lib/ecdsa/ecdsa-libcrypto.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> @@ -289,12 +289,18 @@ static int default_password(char *buf, int size, int rwflag, void *u)
> +	if (!f && errno == ENOENT && fallback) {
> +		key_name = fallback;
> +		f = fopen(key_name, "r");
> +	}
> +
>  	if (!f) {
>  		ret = -errno;
>  		fprintf(stderr, "Can not get key file '%s'\n", key_name);

If neither file exists, the error only names the '.key' file. Someone
with an existing ECDSA setup who mistypes the key name will be told
that 'foo.key' is missing, even though '.pem' is the preferred name.
Please can you mention both paths when the fallback was tried, e.g.
"Can not get key file '%s' or '%s'"? The same applies to the RSA
patch.

> diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
> @@ -396,7 +402,8 @@ check_key_len:
> -	char kname[1024];
> +	char kname[1024], pname[1024];

'pname' reads like 'pem name' but holds the '.key' path, while 'kname'
holds the '.pem' path. Something like 'fallback_name' would be
clearer.

Regards,
Simon
