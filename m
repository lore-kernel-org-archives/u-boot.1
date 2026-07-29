Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D02C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 13:41:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24C7D81153;
	Wed, 29 Jul 2026 13:41:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MNoRk344LsXe; Wed, 29 Jul 2026 13:41:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5224481178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785332489;
	bh=pqBaFWLVnAxkBsAyqw6BsCzbf7JmE9M1a7koBCeOmTc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nTrbVCcV9wpbfnyMDvGcRqfYIUQXXCVPykJ35MHYQu1SNof3O6ZbymH8RSyi5mbIO
	 QZL1rJh9Y08xmvNgzlm95gfG6mryI/GZfe/39dSNB2Xj+5qjKd5P0db7qnWxI/9hKK
	 FpBsnE+Z1QjgYOQvHDquTkJVIk6gRxmNI37j9Z9BYMV63ndoZUSwj/xbbq4gg4iiTX
	 kd0D7LgA7Cn1ybXsYBlqkHhoHu/J/zCZS9hihwwwP7A5lUhn9gwEV6xXOuwbCmb3+r
	 Lw7SiMZ/iekGb8/7VGm4Z40l06O3Yrtq8jwjIocbtHam4E34QIqzxXpg40QiIkVR0q
	 tzKwXYkifPOvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5224481178;
	Wed, 29 Jul 2026 13:41:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 44C852E5
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:41:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2AE4C81178
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:41:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vt0JJ2sxWXRQ for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 13:41:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0331B81153
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0331B81153
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0331B81153
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 13:41:25 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-699fbcd23ccso1448680a12.1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 06:41:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785332484; cv=none;
 d=google.com; s=arc-20260327;
 b=jk5eq+8upvrFK7O6kTRex4kO/QgybYWBbiYBOOJQLDA4VDWTKTIdzM3dtBzDbWMWWF
 ZYDXlucmRXwz32r0vqCOWjJbOJ/4RbQaqy5ZS+4l7G5v0udXXEAWzAf+tA2nEQWc/bxu
 MDP+b+zmcph/3Jw26S6ePP56O6VEnYHIrt0t53yCqXYjumiPA4mRG8LKZcy5XedDf8NR
 wmnaQUy7kZj9WjxJ51AZ7Ztpy8Xs1pTzeijTf2rWi46lAn8bXRolc0ZoJmODjn9gbln1
 HqgEvsrYrP727gdgNlxHMBrE5t5dh+iw/r0T/I0umuXhszVqKryXIzu5k8XenplVcWvp
 WFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pqBaFWLVnAxkBsAyqw6BsCzbf7JmE9M1a7koBCeOmTc=;
 fh=YZb1MUgehA2Z4Ef1j4t7Fy6FE19FIvc0CMpQzkhMgdU=;
 b=sB3+tR0nsLNpKNc2gk4PsmpRfjOaDJ7fSb002xy6tfJZ5s6z2pa7PmO1Hxytz1lP67
 kiOaqr3GZs9QOy7MdqPVFxJnRe8tP6cOG2IF5R9KHFyqHeOdQ30+KYY5ZPThaB8ghh3w
 a4UvfLK3IgTyqBcA/g4+Ot/XiGtc9aFwv/kIX0QHSpgOgMYV3Imhi2gOQ2tHjaB5gBb4
 rU9i3dRLZGr0GeQqg85uDxD4/JZ6SBcZsPP8u3blv1fiAakylxLIeen9aGiWug0LGCcQ
 cyimaX7qeBJYqQsAPCGpc7ULgwjQOkG1CzYfFdP2JMucASn2CE1wIGg1ynBp5tgV5S5O
 3nsg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785332484; x=1785937284;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pqBaFWLVnAxkBsAyqw6BsCzbf7JmE9M1a7koBCeOmTc=;
 b=Q2Ruaed4SPWitQ9A1zRmMryADPCiPxJtN9C6Wn/X3GkzdBoanv63oqnjB4ZAvsQJoj
 gMVGwSEaRsdjG/iA3xTEbRtofjJ+/W3ZN/qfipZ0mlpWDo7A0jvEjeY2E75sR/9d7jCg
 +ED64xWmBVS6EV8FZG2skAwzRaobrAWdOIaAqs8hkA6nzCzUC1A7GLuaBhwLkY9I/G+U
 IpU+CuB6s5fiUNfAVPxpkBKCOTEA/prJmoaiqA2rfoLE+rOgzo+yyTKZV87cGHfDY84y
 2ceJ9/qQSleFkZ9eQEDVo56txjDz4k+4NAPeDZRVcUBSUDq1k4jTtmW3yp8mJeBtWVOy
 BCNw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoDULF50zqK77tiNm0n/WSjvm4n3JyANXlV7jgJVBWkD3i3y9DlhCCiHROmtWyok5oBQqRsIZM=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxJjETmU1ZN2PpBT4jdeXXqu1zPn/ntfYaktjkkJHPpgSgsDU1r
 T5iewWvGi+wIple9DRzdau6xu/UoEtLzpurRzLF6V5a4l5w9qEKYhdcvr6DZ7stUI/f/Zno1FQU
 g8fiX4Dpdq2BErFn3Q/USDQOo+B/90d+yE74V66kC
X-Gm-Gg: AR+sD103t5JplV1KP8OB2cxwU5kFmsR/ef+FJ5+P8kCpydUQqz19vtygGudAtD53rUV
 yWEMb/dqTA6w5S5H8m0Q1/xihowtZqp5eL4Lyn/fBMA0lhPqi/R+YQREOFnSwpY6luK36nAMa45
 qCqBQBG7GCgGmNinkn1L/zOc+sMRQWfY5rWOd5cauZHzANCPmGSSTVjDLUKGEekuVhAhapoU034
 BKnj9xuwP6yXB8XN4HPKvrw2Omwy6+w7pM0rCvu7CtQUFyzmTLTdR28MpApuqbL/oUpGVDbwmzp
 onkETHRkho1qUsu/O0VJrre3DClQCfp6P1wgHXRxDGE=
X-Received: by 2002:a05:6402:2348:b0:69f:b1c2:1eb9 with SMTP id
 4fb4d7f45d1cf-6a0349bc944mr3507941a12.6.1785332484107; Wed, 29 Jul 2026
 06:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <734d54aa-6523-4c2b-ba3a-a51b063a340e@gmail.com>
 <5c9acc31-33f4-4305-8858-983595ce5607@gmail.com>
In-Reply-To: <5c9acc31-33f4-4305-8858-983595ce5607@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Jul 2026 07:41:07 -0600
X-Gm-Features: AUfX_mzBB3ZlxZpldZCRoTkOhKC1qRKTWfOj0TmBcJV8AXa1X3ITdyS-2ibByjc
Message-ID: <CAFLszTjVRDei9=d7=99N_grXMwG6yjTXJqrZ5pSjqkNDWfrp5Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] rockchip: tools: add comment section to rksd.c
To: jbx6244@gmail.com
Cc: u-boot@0leil.net, kever.yang@rock-chips.com, sjg@chromium.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785332484; x=1785937284;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pqBaFWLVnAxkBsAyqw6BsCzbf7JmE9M1a7koBCeOmTc=;
 b=hYb9NH41woDXBdrY6E9pph8dKnwBn/46ahcjKeLV44dImCMiheTtWEuJCWsOvjl0iz
 ns6EPsX8/IFDPvk1r6qYOHy8bW4asw/VEe1LlF9p3sHItIzpl9tYxQPUzTt0i4hniur8
 ZJcr/6jdFeg4nmRTUSsmmQ+Y5aIhetI6Ni5Uc=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=hYb9NH41
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-07-28T06:51:38, Johan Jonker <jbx6244@gmail.com> wrote:
> rockchip: tools: add comment section to rksd.c
>
> README.rockchip must be removed.
> Move the rksd comment section to rksd.c
>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>
> tools/rksd.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
