Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE86D606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 06:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zECmmW8d;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=DxILkmLI
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBE7F81636;
	Sat, 24 Oct 2026 06:23:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XWzAQR7freOo; Sat, 24 Oct 2026 06:23:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EEEFA81659
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792822990;
	b=EBclBOOK5R8l0ks0zWGdqrLvi7PDP7E01u7yLZxpc57YMfF2LQ87sectewqM3y2zddmT
	 21RCs4v13Jlr8ApyZs809ZnVrjUA3B5LpxRj7lN3+xCaqQ5RHjDLmg9mKv8HyvoZnTehx
	 WvvV2IQC9jjutrtFbdlm/9u/VEwaV5k7eGXpWRoWwOnvjDreO8HtBlRrj4tFTXss9agXO
	 lAkn4vnSNHnNzr5zrP99M2dvaOdFcWPFMh8M+NJc7yj2iwJ+Hhifwn9/V80AgrmuDwZjO
	 ohqcTVmE+GwqWgp/OZPXi/QmZEaj+Q5WOaerjFxcIpN8Ixe6PHXzRq0uDpaglU2do7w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792822990;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YYzvBOU31/X443bP0gYkoPbiPC6bGIl+sHzRvjb18rI=;
	b=pWAEvfmFoh7M7qdiE6jtzwCAJL9OZrJmZQ+r6JlbbCNKIype43KDpRlUOvB5QWBj0Hbb
	 1rYGik3LFpSgt3ALS73srOt7EXPUkG533Ofef7/my2ViNmq2dyBjVC4NxFwgprnGyrBay
	 p5FTqaXl7vMRWNy4z+5CAGzpTJ4VtXuotc0ytpEEIQhzluhhKjQDkPkyoMXWKus8WqOrt
	 AiR/xQ+Rgdr73oISJSAH0FbSf9KJH2+cR340TuxaEGo8jRvhNCvKu71+LDqoyBGoolSus
	 MpGNK2T6+PYSs709sf4Fmk7+fuzHhB2C6rPx9lC1TWDBNGOPYSEllBodf3jTz1jyspQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792822990;
	bh=YYzvBOU31/X443bP0gYkoPbiPC6bGIl+sHzRvjb18rI=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zECmmW8d5Ao/CcLSCLWOEbIRnTBbJh3GBbRBWTT6NnpjxgWSDTE5RYohgD3phfNvj
	 j1lBKClaPhVKgJtEQr6gzpMrcYW3Kfy6O2vNjQSnCR00HB1yc5BtqiQcv13TKOlfI+
	 04CiX5T/j08ncr727tss/1qNio4J6REp7iJA5rw3oRvQHoW4pnrhCurXmdW8AuCtzB
	 77nXU335dH19rIJTGyIF8TNfJ5YTUV1zkmblnuXqcRTcNlA1HWt+yhQVjyQPRJH31c
	 k/QhyfgciU6RZ8Lihrr7Ri3Av4OJHvcuQerBZLQugez4D3J3IiNTF353pAMuXJt7sE
	 J9iF9g1ytG0FA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEEFA81659;
	Sat, 24 Oct 2026 06:23:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 65FAE235
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:23:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4A253608FE
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:23:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VIKhX9QfJALV for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 06:23:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9474760A48
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792822987;
 b=guoc1vIsOkWBvQsW91iO0WBPGqwZ8Dub+J2ECJfH+0QmduLh7UMwTYl/5xUza4LlMAPZ
 +ngQJ/LpTtoF3aoIoPR6EA/VzgCNXzHxPAyfhmSlpNjzMNwaea55+p0uDenfUfp2YIttu
 au9FNLretXQLtJhB3xqcco6XSlghFz2MwMUZOn6vrSAtjMpmE8A0+X02EFOtNnvTg7mfz
 4lZW+HWAHjBDuHAGKkrCUcPleM4cH40Ss+GQJxtmvusH0T6dd/15DpJqQqSgJULslilq2
 zeZ9Ykm/XGdVtkf7cxQ6L+PmGaxW68Hx7E0DQi8OhkM5W8CFJvblJWGFEd6r2PhEBzw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792822987;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=YYzvBOU31/X443bP0gYkoPbiPC6bGIl+sHzRvjb18rI=;
 b=ABDWYvptCVIifg8xDPOKn1qd2vdwqO0HkMGodJnMhnQEQ+Mbjot07UK+VeVpXxWq/WDZ
 Z3h8lF0tt910svm6RD5HBN/CsD10u7SRTSXJZKNIHDUIELFqRjcFdjopu6UQuV7eLpEok
 XSpR3yxLFYDNI6Ux4iv7L3zYGKA8W5as17rmVJXS0VsfWbTYMcxl1KOGrhFxbX8v8aJkm
 dtnv4sOwVNM3YDKOlRe386DqurkGurlJHVCpQ0Zdb8PRJRsghjSRwgUHdwZbtgOId9sxw
 zTYKYPAUG8Y+3NNx1CP8/1I+mfKogPRkv9AWPzyUVMk1uFGdrIaQvGU/a/iCei9vzVg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=DxILkmLI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=DxILkmLI
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9474760A48
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:23:07 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-3ab2cb8d577so1125949a91.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 23:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792822986; cv=none;
 d=google.com; s=arc-20260327;
 b=A9X54QuBvqWzldZT1puT5KTLV54ZvGqIjfd0ApTYfOjaQ4WUtvgKjmu/nDW8a7+tWQ
 QArvhiQ6XkE7d9gtDw3IqTuLiQzMoPl7B3wkdjs9sj/2Av7XWJ9f6KOVI2Yt4ZfUS8NX
 qde8XtMSQUTDp68VwGGysjIBqVnlt9OesbELzw/vHj8Ab0iyTHfBPuP7KaCSFBgEPxOg
 8ilUAuRDVgzbzyZeN9QboFLD6guMRWHUwAtjH9uuS4nYUaQZawZW6l6CgcsFo3VPRiic
 KUVpcR6awScKhwz82rpsN9+8JN2xEVXouFLN1WUZGdJ6TU59wy1xwvlkWfnUP1yKf4c5
 uTzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=YYzvBOU31/X443bP0gYkoPbiPC6bGIl+sHzRvjb18rI=;
 fh=4elKA/8R8nsp2QSEXfJoIvGF0mo+aUc0n1hMY1echd4=;
 b=O4fjSxwbbxeZZeE7TZ1CTU3Om+nJjTvzyz3gQHjeYkvyMRtKD/2pQ2OwxupnNUTkLl
 ogExMIrkMotsjpAAPJcKpVGL7A0V5oMB3FmgTOXn7l3j7e2I2SSen+tkT1PguiWNpZj1
 eYZF7tpBE0m70WLb1GC6rlLUQKF/6IToyKcUggRGCEExbhBmRFF8F5hbaqT78e+1Na91
 cX/e/qrqcaLOqt6b8RVDqip99vmhAMHMd0umoemaSX2svNfkuBsvhSejUfCKw8cpiDJ5
 14PRAFGMkT/WatdjeCmoh3JHbBxR3WGhfun1n/pZ7B7nb8EwSOGCOnfQAJ7XBPYXHa9/
 LbBA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792822986; x=1793427786;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YYzvBOU31/X443bP0gYkoPbiPC6bGIl+sHzRvjb18rI=;
 b=DxILkmLIc1d0rNvT+kbIT7nd4fXftYAl6qsv2P65aCyGvScg9JJN/mjiZz+tMoThFe
 Nw7BwmFCx55UqGw1y5LTHo/yQ8nxwCgmFZeCJwB1pTW62SoXfWush4ezglBPUXg7pKew
 SqIZ0aki/Ji3iEKCe/9TdUonFa6z3nvfmP18A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792822986; x=1793427786;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=YYzvBOU31/X443bP0gYkoPbiPC6bGIl+sHzRvjb18rI=;
 b=vNAjzOsYl3Lt9luXzAqdvOpQh2xSJwzZoAEmrfgH9J4/ZVOn6kuvMY4aUg9spnyvFq
 da8GTqCOvZxeMsHK/mjoxcGSrfd6hyKNMk2aQe1PEFKlxvfXRNTRN1quOIOq5OSYspih
 NOwWbYaEKDCPP9XLRL7ElE/+I1FR8pu1vKw9R/h1pKCq2iTU8LFZI5ZksqUZTZs4lR2t
 pkvsoYQDXzD0qb/clTFf6+eT0zWfjWUQtNiB+fQnJBREWTb7smCmvAVHhkDkM29+8uGd
 47R2reBjgIeUrY6qli9S5pXoyv6IeZHGwS6xHVaXVPF6K7iLkUyek9ExSUF9uRGo3HLQ
 AxNw==
X-Gm-Message-State: AFq9FYLDFNvkTcSIZq+mKeFI8HJECNAvfilz8YADiZoUSHAbgRSgoVNe
 ztjNV5xFaza2Dq2loLuh0ZYRB6REP3c35OUJ8FQNRLwx8lz9TjJgy9/DeIlHg2UtlpeFXkH42Hd
 TR7WFrM7SHWAZQBNneFXQYRe8CbbYuhCUM5DYpgWM
X-Gm-Gg: AYBFou3Aod6cRZ/i6KW6k89D/7i0pE7FN5FEsr8F6L1bdww5r5RLMWMC3GU0qQLh0FI
 tjY3JOZLz/Lio5FVf8qdjwu/of0mtaiWmVWaVexgpc/RDc8Ircw2dmbzogrANoLIlaFs4e7Bt0F
 lbFe52DV2dgK5BUBLGhBLjCKsBlVSs+v+Xma3t1c3muelzCEcsA/ktBc035zgiiayRuFygMk8mp
 qv0c3Lf4D7/iuqcnPhVEKCyzTJ0QUe84zJGm87kP29qdXMFq4haPDfnOx21bYofpWP/hdE8aoyP
 pRHoCoV8pwL+fReFyoglTn8dcfN1qbMEmeIxznH5xeUdCThcL7OB+Xbpu2+K8ogQUSOhYtBSOza
 kMPx7RB3Mn/sp72fhW9RE/6ERNmulE3FQzMw=
X-Received: by 2002:a17:90a:e18b:b0:3ab:36c4:b500 with SMTP id
 98e67ed59e1d1-3ade9b2e977mr1208391a91.5.1792822985944; Fri, 23 Oct 2026
 23:23:05 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:23:01 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 11:48:54 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261021102626.264091-5-ayoub.zaki@embetrix.com>
References: <20261021102626.264091-1-ayoub.zaki@embetrix.com>
 <20261021102626.264091-5-ayoub.zaki@embetrix.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 23:23:01 -0700
X-Gm-Features: AclHuK9z9RId3UUZpJ7X03wFNH7JurgTyohSdL88DBYcMpEczcQDLaqLfbGcLDQ
Message-ID: <CAFLszTiZLXpYHGT9JpUBZ=4uVObday-b_SMaq+hYH2V2UCNd2g@mail.gmail.com>
Subject: Re: [PATCH 4/5] lib: rsa: Accept .pem private key files as a fallback
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
> lib: rsa: Accept .pem private key files as a fallback
>
> Allow mkimage -k to use a .pem file when the RSA .key file is absent.
> Keep .key precedence so existing key selection is preserved.
>
> Signed-off-by: Ayoub Zaki <ayoub.zaki@embetrix.com>
>
>  lib/rsa/rsa-sign.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

BTW binman's _get_keys_dir() in tools/binman/etype/fit.py still looks
only for '<hint>.key', so it won't find a .pem-only RSA key (or ECDSA
key). That is outside this series, but worth knowing about.

Regards,
Simon
