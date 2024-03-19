Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF563C54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:39:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DD2F87F8E;
	Tue, 19 Mar 2024 13:39:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="xqvpFuft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAB3987EF4; Tue, 19 Mar 2024 13:39:33 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C21BB87F8E
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 13:39:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ptosi@google.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a46aaf6081fso385328266b.2
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 05:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1710851971; x=1711456771; darn=lists.denx.de;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/THyly3Bxy83XaeciRKCgY0YumTVVOOa+cTvZPTd9KA=;
 b=xqvpFuft2abVBjW8OyhJtT62zRdpSDFLikh8vrqKW0ZGpomdlMmSRSmKU6L6NiDRfd
 uN2OtAX7N6z2nPI39Sv2vwFzXA47wcY7yf2vrfaxLj/xsijI7o22/inTBE4COjCKlXF8
 MPrZFbW1aIdiWYc0W3F2xdeRD2erGaMuJcfm3ukNsPLsPHtb4jPoWXLMmhIl3iEZ8iof
 F6ZtkucGOaj07wFwV0lr8GrpqaVkF4WIeigJa489Vpul4s6DErUwIkKarS58OBZ5oqCK
 dr7Yvtq1u+ec45b/ekXOT5SxVUB1YwChxYD5kSySKTYjw2LsBX6QgSAjM4r+Tw2vsgc1
 sXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710851971; x=1711456771;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/THyly3Bxy83XaeciRKCgY0YumTVVOOa+cTvZPTd9KA=;
 b=n8VUbS76kQGFbgY3x6OtUNbPJfgKmj0YvB8fdv223S8fu4Vm4d+GX5A5t+nWOt/jYb
 2bnan6UPj4iDTDRLpaOQE7fCEgcBj2SwbpIvKliu/7sIDXm2hSPVDEs+Sz8cLSBZz0te
 JpCq6dFGeUPtZzVQuQq4tQkPOneJCiwgygfFqGUJOptK1izgmHSiET+p5WMJqeX+DDMM
 ChidD8bQtpe089AK9GXAnNc+HnNxC/sgeMDUg0Sk8ft28k8cuW+vLEcIKKHsA10UDMId
 mfU7GelknvH1F+Gz5VDYf5NYrbtW3Nu0MTyWU59KGxbCsvC1N+2HDWSXK3JC156xiidX
 JLmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6oEn5QDlA8Lx8WHDG6I/1yoxQNDfr1XCJSBaGzPtXIqyNemQ7TNrcVo1CfPLQpZ0z4bgWfchJwMfg5NvT4CTp6aCxKA==
X-Gm-Message-State: AOJu0Yy7OKs9BBi3YBGx46Q2bW2f5itq33UNbMAkYlD+3K/XXY8BxCRC
 r4O7sJW/nXxS3Ysdyr7OaFCgOcpRrctUZhtyZVNcRgATENQ5Ik1EkK7pFK8KTQ==
X-Google-Smtp-Source: AGHT+IEVt8EXooyroxQLmr2xr0fd+TN1S+1yX4uVZu672dq3pYGkcIpjJNbUa7KU2ZqUMI/gwtYK3A==
X-Received: by 2002:a17:906:b14b:b0:a45:f352:73b0 with SMTP id
 bt11-20020a170906b14b00b00a45f35273b0mr1341440ejb.65.1710851971060; 
 Tue, 19 Mar 2024 05:39:31 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com.
 [34.90.227.64]) by smtp.gmail.com with ESMTPSA id
 gf9-20020a170906e20900b00a46a27794f6sm4005365ejb.123.2024.03.19.05.39.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 05:39:30 -0700 (PDT)
Date: Tue, 19 Mar 2024 12:39:26 +0000
From: =?utf-8?Q?Pierre-Cl=C3=A9ment?= Tosi <ptosi@google.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>
Subject: Re: [PATCH] arm64: Fix map_range() not splitting mapped blocks
Message-ID: <yltha7mziq43ke7kas433zlvxamri2p7h2p7oos3x4dexk2oct@gfhscvngsjcw>
References: <43haokus4jdxguk4arig5tsqcgq2wbezwpbj7oti6pdkvrfual@wa7vz2iypcv5>
 <86o7bazheg.wl-maz@kernel.org>
 <qnca6it6fh6pznsvm33rwa3pf6ushtkpvyui6fds43fcdjxcz5@66tiqctl7arc>
 <CAOMZO5CNgJUbDGdyP4tS7YBXPqcmyT+FkhaF+phbR64grA2i0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5CNgJUbDGdyP4tS7YBXPqcmyT+FkhaF+phbR64grA2i0g@mail.gmail.com>
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Fabio,

On Tue, Mar 19, 2024 at 09:13:12AM -0300, Fabio Estevam wrote:
> Hi Pierre,
> 
> On Tue, Mar 19, 2024 at 8:39 AM Pierre-Clément Tosi <ptosi@google.com> wrote:
> 
> > This means gd->arch.tlb_addr pointing to the live PTs during setup_pgtables().
> >
> > In arch/arm/cpu/armv8, setup_all_pgtables() runs with SCTLR_ELx.M unset.
> >
> > In arch/arm/cpu/armv8/fsl-layerscape, setup_pgtables() is called twice:
> >
> >  - early_mmu_setup() calls it with SCTLR_ELx.M unset;
> >  - final_mmu_setup() overwrites gd->arch.tlb_addr before calling it iff
> >    CFG_SYS_MEM_RESERVE_SECURE is defined i.e. if CONFIG_SYS_SOC="fsl-layerscape"
> >    so that <asm/arch-fsl-layerscape/config.h> gets auto-included through
> >    <include/config.h>.
> >
> > So can CONFIG_FSL_LAYERSCAPE be set while CONFIG_SYS_SOC != "fsl-layerscape"?
> 
> No, this cannot happen.

Thanks for confirming.

For clarity, it might then make sense to drop that #ifdef in final_mmu_setup().

> Only the following Layerscape SoCs select CONFIG_FSL_LAYERSCAPE
> in arch/arm/cpu/armv8/fsl-layerscape/Kconfig:
> LS1012A, LS1028A, LS1043A, LS1046A, LS1088A, LS2080A, LX2162A and LX2160A
> 
> I saw the original boot problem with the i.MX8QX.
> 
> The i.MX8QX is part of the i.MX family, not the Layerscape family.

Sure.

To be clear, the concern here was that split_block() doesn't perform what the
CPU architecture requires when modifying page tables that the MMU is using and
the question therefore was: can setup_pgtables() be called on such live PTs?

For most AArch64 U-Boot ports (including the i.MX family), the answer is trivial
because they use the arch code i.e. setup_all_pgtables(). However, as
fsl-layerscape re-implements mmu_setup(), it had to be looked at separately,
hence my question, which you answered above.

HTH,

-- 
Pierre
