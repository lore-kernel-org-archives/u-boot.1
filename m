Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFED4606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Atu2VzT1;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CM94gYrl
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8AEEC6070C;
	Thu, 22 Oct 2026 17:57:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PuRJokMt0k0d; Thu, 22 Oct 2026 17:57:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2BBA56079B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792691856;
	b=jNv0TnGWBT4tFLVtkpoK/ZE9wvH4zX5yq8A4xoZVN6Tsg+/xQwW82G0OzB5jZ3U4o6pE
	 qjicm4SxdtDmcBYIzRCAsinoN64GWgKo9X509mQjvbzfdjJ6IDh8sKPhhoK1i3J3HrYwI
	 4pl/0xQ36gFmK8EuG8i1k1s6F+uLmgH1rtqWl2wnrNPCUP1UhlZ6YAwg8F0lLQKgp4KXa
	 aCypoUn/iu9nFvbYkJh8L5BLSLuJtufr/XscB342ZdW1szqk608XvHYpRq6EI9Z7DKIAW
	 V4Hm2yrlgecVjuffoBfX9eVvo7Q3V+ka72QFY8WRq158NQvEQ8IMekgvvG3DQnmaIRg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792691856;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=R6yPen0k1Iu+J4g1m1D8jc/GqQd2taU9tInzQK5Y9a4=;
	b=r071t6RztmT1K6BVMkacJCr2PllwgbRmb8hQ7CeenS9rqMx6OLBFovwFN1cBO0/kJ+Gz
	 4zaecfRTrYuRu7HJKk6ZEFEnrwElxqk3QWCfUgGyZfFgyKoK8FYw3G/YTjd7fw+1F0Px9
	 myY7HI/tU7LG+WSzCTbIqajBOWWkDPMtw3XQaClHZK1ZgM0z+ta+vVGrD0ymY9t3Dc1G4
	 dOZU2yxLWrxrlJoLiplkezbjaNVinIQv+wWWsg3DYFcKTofOFloUQCSExR45ZG9sZ7sTo
	 67dUnd43rz3ZqHcSGrSOBrxD0eQXhc8SD8Ckk+wXNLnRQAovNuMYOwX+dN3PEKH2znw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CM94gYrl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792691856;
	bh=R6yPen0k1Iu+J4g1m1D8jc/GqQd2taU9tInzQK5Y9a4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Atu2VzT1WbfCvUHp4V1icrmOkXnIgbQGRNd1ZSW4MnBa9GrYKkdjXNyRAf2kO3WDG
	 aDQRioNbb3rZUMhkB//WdZbns5aLXjAwgNIPXTATGjP0LnlPH7jZ2f4w+NL+o2U9FD
	 mE5aJ0fIYU7t8ZNh/7McQpMojm17Bo/Tolm32ZSKdaT21jjvCA9Y4CGk9OM2QKJnnX
	 ZCRBG1KYLzIBjNdLD8/LfpngbaJcXS/vj3f2VIbF5hphVzRBPt5kV3VMvJc9dEK5SD
	 47wg0whiW5g2gkpLVXxSKZFh5gALeHPhxmk2+liOdVhfllH8FAd+v2lF++M2vgNwpn
	 p/9GOh+5RauTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2BBA56079B;
	Thu, 22 Oct 2026 17:57:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BEB0A3A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 17:57:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BA707606C4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 17:57:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QQZHnij9Kbux for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 17:57:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5C6C2606B6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::634"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792691853;
 b=MUrp2vHv/FTLNDTJY/Ln8Q/3CkX6fmMIt1SmWiqmwxzYLZUvWCLQAGLHYUxnIB7Q0n6u
 w+xFpN22xUHebUogrgjh4Ub94OxCxRIWTmybzzztAG3nU4mcO4ozKAPRUNydPb+PsfHiG
 9FNDAjnXnznN5pUm7a26gzHccY9RwJq0GDkyYJMgZ+ZYghCUYsEbddIzEhnaFKVuneGQo
 eWBIXvN9JZNH3FsDENpTfgQXoAzXNLJz5bElGfgh92ZwLRV9mkdCUL5Z3X6Ck1g5uhnTL
 BvSK7b2A6ZuuebYFGiflXp1azoLkwc/okGtr3uZ8++q9xkY0aJ17f4S+QNwq3LuUm+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792691853;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=R6yPen0k1Iu+J4g1m1D8jc/GqQd2taU9tInzQK5Y9a4=;
 b=eTzkMJgknuBEzq1W9GeonH5MCep0BsgP3mMG9+YEGF2knOSnrjUxb0oiEthAqsEwEcSZ
 u6GysRSODfcKfXLT5uwLNaWIlFPyQQCohvMAZn9AKTdbeAOuotvp9ybnKql3R6IgmarDe
 +CwZ6c7FborSJyzhIRLBTEk46LfRavv/rYf1M5a9yk7OT/EWSy0lO4pThKQVpZIVwWBsc
 d5ZieA1fr0FZbYTHslUMfvTrl5noCyGQZSAlH0oyxH7xlDViCaK4U4JXeYXsTZwH8gwuX
 GkVYBeQXpZDsU73HKkkg40RejO4sDXMYIHUP8PKT+V/1boqYU4fuqITq9/HRd4HlFpw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CM94gYrl; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::634"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=massimo.pegorer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=CM94gYrl
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5C6C2606B6
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 17:57:33 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c40f29667e6so15400066b.0
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 10:57:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792691851; cv=none;
 d=google.com; s=arc-20260327;
 b=ceYcC7c5XOGDc+rWSeGzQmgLDUqe8XdkW1KiVwr0+u5h/+2sD27iCkyPWeBC/4woD0
 loJwYL2Vix/nCaQhHN9cW/1Avv3sRxswLcE6YI3SSz5r+eS5aCerRHte2V9lu4OUNF7V
 ogpPsZ4UshCsIrkhe8ubJAVrh4niJQNVI7kOuKL2OaNob7VWPPeRdsbrepBpZSGRZD0c
 2lHVm/l7xC4gGEZjOHWyDkTamgSF0ltEZtHOlsz67wCJ06iPa+wfJUt/FChMWiTIxjCw
 IvAVPlPgJdYUdxB1L7rGZGrIB0Vzkv2FJ75rMkwYsoLFk6HNTxii2aQKCzKCq9iMEixx
 D+RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=R6yPen0k1Iu+J4g1m1D8jc/GqQd2taU9tInzQK5Y9a4=;
 fh=iTL6dc8GJ+sqOUyUufuGbjxm/+iaWw4yUz7M4xVi9g8=;
 b=JRcAp+l7Dokdpsh3XtNLocYxgeWe7RBznSptTNfpjrxTNa3MHU1vozVIbKdXtdT95w
 gQHpHgi6Jul+fdX/k7zIwkDwM++HCFC0prkUKam8eCPB7CPXEL/AQpgTX8MUSb4zWtzb
 A6f7mKs3GZpUwRuV+0BBNsKTCpswYMdGFAX+lhgKH6pq5cTUZG0Cu45oc3QdRXeN9Zb8
 /dU79x/91kKjoH38z30TkKJOVjscu2zzlINMfd/fDWUWkGH6Xga3bb7C0O+S4S3GCREp
 PjbLlUsbvX0j8v5sUFn81wIg5UrUffyYXQUnk0LYxdNePjEAFU6UtB8ftaayN5ZesknS
 sFvg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792691851; x=1793296651;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=R6yPen0k1Iu+J4g1m1D8jc/GqQd2taU9tInzQK5Y9a4=;
 b=CM94gYrlTxIExJgUk1iijDrCCVKcagFe1xYsqlp5hXoaRuDfeCdKXL0R4SNyvlumj4
 lKQ9EK2l97TDJJpdcuFd8CxODCgaNNJAHD8hwP298GwG8qD0YSKkj9U/g1giD5LGlnzn
 5tSwEUSbTecQjpXHnMW+/Vz0wDYJLQIsBsH+c9RGS8PSE2t/8vwqpDUayaAVC5ZGcbNj
 QXZ5sWZEFtJzLjkne7XVgQA36JpgJAqcZaKHhIG4vgAuB2XzSU1vDa7pDnrrbXq7U1Pe
 CFERRQhrD3Q26PtW7eDXKXvvkWBwLBxEd8IgfaQOaXnrAdagUD7r9M2qnOV9ddRYtcPA
 86oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792691851; x=1793296651;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=R6yPen0k1Iu+J4g1m1D8jc/GqQd2taU9tInzQK5Y9a4=;
 b=P5nfTHsWi/BjyuruuGKPmk8BA+j3xVll3S9hrbpIA7zGDw8PU+5D6QlYWxEZnI4No/
 SgTWJYjPgtTzfgx7fe2Vi60L8j8kdRh+bHJJkYeRPRbWy1RdmEqMCPtetNwBjMg7Q1d5
 XCtgFg0xNJlW2orINTRK8vANrx/bqCnVN1cn04oFpOv9LO3PFqM4KixPvQLUoCcr++MO
 RssoYzNPNaSIWCmJ8Kxcd48QMSLyyi5gyklEGa9ITOv8TXVd6+vZDV9LlqG4UPcBJ/f6
 qOFSWdiNfL9OSeaTsHdFhzbAhHWgZrWzcvrnv2onEtEfu6Jv8HqrUdP8M35Q/W+hSlNl
 yA7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwO9CiwgNNHUBxJbKFc9RW2AxbjainrqANSeV/URioTjH3Eax+Icmsq224oVaH6jQ2kY9Do96Q=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJcrdbFO7y6rTGJDRzVvWRuobV95wtytuwh6OZLI33H8HF3EqoP
 0+4uSZvxk5Gapc3ECBPpgU7YEIikCvYJ78TYP7q0UZfZsyGzDwDGZxBmP72mijwnWk6COfdju1F
 UT4+mlacIqbqfOQHyFuHkOd1nKqSQ4RM=
X-Gm-Gg: AYBFou3FLWXV9Kh1fEg4TgT1vBsm8ihWmRLdnV09OPcMTiucNpFVeZOxfgbAtnaVMyG
 Dd/917GIgYLft4sTyY494T7eoIM4NYNQnDlBnDTSUDwQNqN4bwycx08EwrlXies3dhvli8GHQ57
 B+g5D3kSqo9jZ9wMZ5Wy6amh7GdwjZvGS6qQllhykyOZ8sNlB9OSqs3JTqmnBnaiygT7pSGsfj0
 XAYyLLpuNy0MFk/q0WrNyG5R+KGSQVHNuEiLi2R0cQSdLvEBaXd9qTQuS4ar4ukTMX8oUmu+0p0
 B83Mjx+0pDBJwKFlmaJSAm1sdFmpXoVAbu39Jd/zhIJ27jbZHVAkqbRUM2YpWC5rO/LRs8jemaC
 QJlbWOnmmw1p/ICKKf+R0LtfgifCX4KvLMIWiTw==
X-Received: by 2002:a17:907:86a7:b0:c26:1648:a06a with SMTP id
 a640c23a62f3a-c4679684c8bmr627511566b.37.1792691850876; Thu, 22 Oct 2026
 10:57:30 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260829-ddr-multi-v1-0-c0c7837aed20@gmail.com>
 <20260829-ddr-multi-v1-2-c0c7837aed20@gmail.com>
 <0bba4247-2950-41c2-996f-d9c29043619c@0leil.net>
In-Reply-To: <0bba4247-2950-41c2-996f-d9c29043619c@0leil.net>
From: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Date: Thu, 22 Oct 2026 19:57:19 +0200
X-Gm-Features: AclHuK8yRaDj7sZSD3-T1KwHGt5OXTRBNSoid2CcNiQbdNaMyWQ4UvaT_VwkZjA
Message-ID: <CAC928Hbi8UudtraNW1JDW5M2rRDcB28LssZyNcxKWP3pVATBAA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ram: rockchip: px30: allow multiple DDR types
 selection
To: Quentin Schulz <u-boot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

Il giorno gio 8 ott 2026 alle ore 22:49 Quentin Schulz ha scritto:
>
> Hi Massimo,
>
> On 8/29/26 7:03 PM, Massimo Pegorer wrote:
> > Allow the inclusion of more than one DDR parameters set in the PX30
> > SDRAM driver. The driver applies included sets in a predefined order
> > (DDR4, LPDDR2, LPDDR3, DDR3), stopping at the first one that makes
>
> What made you decide on this order?

I've just followed the original order the data header files are included and
thus added to sdram_configs[] array. I have no hints to do any fine reasoning
about this. Maybe Rockchip could help.

>
> > SDRAM initialization function to complete with success.
> >
> > The default fallback behaviour is preserved: if no DDR configuration
> > option is selected, DDR3 parameters set is included.
>
> We shouldn't do that, we instead should have the DDR3 symbol default to
> y for PX30 (and other SoCs if applicable), to preserve the current
> state. I don't like hidden defaults like that because you may end up
> with RAM_ROCKCHIP_DDR3 not selected and build a DRAM driver that only
> supports DDR3, which is kinda odd to be honest.
>
> >
> > Due to limited PX30 TPL maximum size, including support for more than
> > one DDR type requires disabling some configuration options such as
> > CONFIG_RAM_ROCKCHIP_DEBUG.
> >
>
> Good to know, thanks. But i'm assuming this likely means we can only
> have up to two DRAM configurations enabled at the same time?

There are some optimizations that can be made to include all four DDR
configurations. I will provide them as a further patch if these are merged.
Moreover, with the work done by Jonas, we would have more space in PX30 TPL:
I need to test these on top of his patches.

>
> I think the information printed by sdram_print_dram_type() is still
> interesting. Maybe we should have some log level for the DRAM init so we
> can select the verbosity of the debug output. In any case, just a
> thought and not a blocker for this series at all.
>
> > Signed-off-by: Massimo Pegorer <massimo.pegorer+oss@gmail.com>
> > ---
> >   drivers/ram/rockchip/Kconfig      | 67 +++++++++++++++++++++++++++++++--------
>
> No to those changes. Keep it simple please, no redefinition of the
> symbol based on the SoC. For the RAM_ROCKCHIP_DEBUG needing to be
> disabled, the information is quite nice for end users so i could see it
> being added to all RAM_ROCKCHIP_ symbols as a hint (or have it somewhere
> in doc/board/rockchip for example).

OK, but I'm providing multi DDR support just for PX30, not for RV1126.
Therefore, the logic behind DDR config options common to both of them (such as
DDR4) will be different in the two scenarios. Would you prefer a single config
option with two paragraphs in the help text, one describing the PX30 scenario
and another for the RV1126 one?

>
> >   drivers/ram/rockchip/sdram_px30.c | 35 ++++++++++++--------
> >   2 files changed, 74 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
> > index 61a3193b3f5..d74980402ad 100644
> > --- a/drivers/ram/rockchip/Kconfig
> > +++ b/drivers/ram/rockchip/Kconfig
> > @@ -24,38 +24,77 @@ config RAM_ROCKCHIP_DEBUG
> >         This is an option for developers to understand the ram drivers
> >         initialization, configurations and etc.
> >
> > +config RAM_ROCKCHIP_DDR3
> > +     bool "DDR3 support for Rockchip SoCs"
> > +     depends on ROCKCHIP_PX30
> > +     help
> > +       Enable DDR3 sdram support on Rockchip SoCs.
> > +
> > +       Note that enabling support for multiple DDR/LPDDR types may cause TPL
> > +       to exceed its maximum size constraint (TPL_MAX_SIZE), depending on
> > +       other configuration options selection (such as RAM_ROCKCHIP_DEBUG).
> > +
> > +       The driver applies selected sdram parameters sets in the following
> > +       order - DDR4 LPDDR2 LPDDR3 DDR3 - stopping at first set that makes
> > +       sdram_init_detect() to complete successfully.
> > +
> > +       If no DDR/LPDDR option is selected, DDR3 sdram support is enabled by
> > +       default for backward compatibility with existing board configurations.
> > +       Therefore this option is only useful for multiple DDR/LPDDR types
> > +       selection.
> > +
> >   config RAM_ROCKCHIP_DDR4
> >       bool "DDR4 support for Rockchip SoCs"
> > -     depends on ROCKCHIP_PX30 || ROCKCHIP_RV1126
> > +     depends on ROCKCHIP_PX30
> >       help
> > -       This enables DDR4 sdram support instead of the default DDR3 support
> > -       on Rockchip SoCs.
> > +       Enable DDR4 sdram support on Rockchip SoCs.
> >
> > -       Note that even if multiple DDR/LPDDR types are selected, support is
> > -       enabled only for the selected one that comes first in the following
> > -       list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
> > +       Note that enabling support for multiple DDR/LPDDR types may cause TPL
> > +       to exceed its maximum size constraint (TPL_MAX_SIZE), depending on
> > +       other configuration options selection (such as RAM_ROCKCHIP_DEBUG).
> > +
> > +       The driver applies selected sdram parameters sets in the following
> > +       order - DDR4 LPDDR2 LPDDR3 DDR3 - stopping at first set that makes
> > +       sdram_init_detect() to complete successfully.
> >
> >   config RAM_ROCKCHIP_LPDDR2
> >       bool "LPDDR2 support for Rockchip SoCs"
> >       depends on ROCKCHIP_PX30
> >       help
> > -       This enables LPDDR2 sdram support instead of the default DDR3 support
> > -       on Rockchip SoCs.
> > +       Enable LPDDR2 sdram support on Rockchip SoCs.
> >
> > -       Note that even if multiple DDR/LPDDR types are selected, support is
> > -       enabled only for the selected one that comes first in the following
> > -       list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
> > +       Note that enabling support for multiple DDR/LPDDR types may cause TPL
> > +       to exceed its maximum size constraint (TPL_MAX_SIZE), depending on
> > +       other configuration options selection (such as RAM_ROCKCHIP_DEBUG).
> > +
> > +       The driver applies selected sdram parameters sets in the following
> > +       order - DDR4 LPDDR2 LPDDR3 DDR3 - stopping at first set that makes
> > +       sdram_init_detect() to complete successfully.
> >
> >   config RAM_ROCKCHIP_LPDDR3
> >       bool "LPDDR3 support for Rockchip SoCs"
> >       depends on ROCKCHIP_PX30
> >       help
> > -       This enables LPDDR3 sdram support instead of the default DDR3 support
> > +       Enable LPDDR3 sdram support on Rockchip SoCs.
> > +
> > +       Note that enabling support for multiple DDR/LPDDR types may cause TPL
> > +       to exceed its maximum size constraint (TPL_MAX_SIZE), depending on
> > +       other configuration options selection (such as RAM_ROCKCHIP_DEBUG).
> > +
> > +       The driver applies selected sdram parameters sets in the following
> > +       order - DDR4 LPDDR2 LPDDR3 DDR3 - stopping at first set that makes
> > +       sdram_init_detect() to complete successfully.
> > +
> > +config RAM_ROCKCHIP_DDR4
> > +     bool "DDR4 support for Rockchip SoCs"
> > +     depends on ROCKCHIP_RV1126
> > +     help
> > +       This enables DDR4 sdram support instead of the default DDR3 support
> >         on Rockchip SoCs.
> >
> >         Note that even if multiple DDR/LPDDR types are selected, support is
> >         enabled only for the selected one that comes first in the following
> > -       list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
> > +       list: LPDDR4, DDR4, DDR3.
> >
> >   config RAM_ROCKCHIP_LPDDR4
> >       depends on ROCKCHIP_RV1126
> > @@ -66,7 +105,7 @@ config RAM_ROCKCHIP_LPDDR4
> >
> >         Note that even if multiple DDR/LPDDR types are selected, support is
> >         enabled only for the selected one that comes first in the following
> > -       list: LPDDR4, DDR4, LPDDR2, LPDDR3, DDR3.
> > +       list: LPDDR4, DDR4, DDR3.
> >
> >   config RAM_ROCKCHIP_LPDDR4
> >       bool "LPDDR4 support for Rockchip SoCs"
> > diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/sdram_px30.c
> > index 37e62120504..ac9f5827d1d 100644
> > --- a/drivers/ram/rockchip/sdram_px30.c
> > +++ b/drivers/ram/rockchip/sdram_px30.c
> > @@ -126,11 +126,17 @@ struct dram_info dram_info;
> >   struct px30_sdram_params sdram_configs[] = {
> >   #if defined(CONFIG_RAM_ROCKCHIP_DDR4)
> >   #include    "sdram-px30-ddr4-detect-333.inc"
> > -#elif defined(CONFIG_RAM_ROCKCHIP_LPDDR2)
> > +#endif
> > +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR2)
> >   #include    "sdram-px30-lpddr2-detect-333.inc"
> > -#elif defined(CONFIG_RAM_ROCKCHIP_LPDDR3)
> > +#endif
> > +#if defined(CONFIG_RAM_ROCKCHIP_LPDDR3)
> >   #include    "sdram-px30-lpddr3-detect-333.inc"
> > -#else
> > +#endif
> > +#if defined(CONFIG_RAM_ROCKCHIP_DDR3) ||         \
> > +     (!defined(CONFIG_RAM_ROCKCHIP_DDR4) &&   \
> > +      !defined(CONFIG_RAM_ROCKCHIP_LPDDR2) && \
> > +      !defined(CONFIG_RAM_ROCKCHIP_LPDDR3))
> >   #include    "sdram-px30-ddr3-detect-333.inc"
> >   #endif
> >   };
> > @@ -682,19 +688,11 @@ out:
> >       return ret;
> >   }
> >
> > -struct px30_sdram_params
> > -             *get_default_sdram_config(void)
> > -{
> > -     sdram_configs[0].skew = &skew;
> > -
> > -     return &sdram_configs[0];
> > -}
> > -
> >   /* return: 0 = success, other = fail */
> >   int sdram_init(void)
> >   {
> >       struct px30_sdram_params *sdram_params;
> > -     int ret = 0;
> > +     int ret, i = 0;
> >
> >       dram_info.phy = (void *)DDR_PHY_BASE_ADDR;
> >       dram_info.pctl = (void *)DDRC_BASE_ADDR;
> > @@ -704,12 +702,21 @@ int sdram_init(void)
> >       dram_info.ddr_grf = (void *)DDR_GRF_BASE_ADDR;
> >       dram_info.pmugrf = (void *)PMUGRF_BASE_ADDR;
> >
> > -     sdram_params = get_default_sdram_config();
> > -     ret = sdram_init_detect(&dram_info, sdram_params);
> > +     do {
> > +             sdram_configs[i].skew = &skew;
> > +             sdram_params = &sdram_configs[i];
> > +             ret = sdram_init_detect(&dram_info, sdram_params);
> > +     } while (ret && ++i < ARRAY_SIZE(sdram_configs));
>
> A simple for-loop on the ARRAY_SIZE() would be easier to read. Once you
> have a match (ret = 0), break out of the loop and check ret before
> continuing in the code.

OK.

>
> >
> >       if (ret)
> >               goto error;
> >
> > +     if (ARRAY_SIZE(sdram_configs) > 1) {
> > +             printascii("Applied sdram config: ");
> > +             printdec(i);
> > +             printascii("\n");
>
> This is not useful to the user as it's reflecting the index in an array
> that is not stable by design. We should instead report the DDR type (if
> we really want to). You can do this by simply calling
> sdram_print_dram_type(sdram_params->base.dramtype); Of course, this
> won't do anything right now since we need to disable RAM_ROCKCHIP_DEBUG
> to be able to compile support for more than one DRAM type.

I will drop these lines.

>
> I will only be able to test your series in November once I'm back in
> office, but I for sure will. In the meantime, you can always send a v2
> and/or discuss the feedback :)

Thanks, it would be really useful to have further test results as feedback. In
the meantime, a will send a v2.

Regards,
Massimo

>
> Cheers,
> Quentin
