Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE929606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=v+Ub44lt;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gTeN+C7F
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5A48E810F7;
	Fri, 30 Oct 2026 09:24:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R-sPuR7lnPkS; Fri, 30 Oct 2026 09:24:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5170B810F3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793352256;
	b=EGBFo7TWh6ouYcAA93iRlv5FJhUbIRrg4LyulvU94wKgak5tfDw6z+DDVMKCSYvCC7RI
	 del9wS6IgBjO0mB+x5ngIbY5O/hJgZeybXIrYQoGt96fBx3u//PutjuRFkj9nDVkVqz6a
	 YdYe4tuRBxii/j+oCu72hIP8F+fgFsutjJ9z3oNNLZH1yOc2PKusECQHbDcdU4vkBsYxU
	 w7LFvZF0Ezx/c2EBdM4QskB5sgy8202U3r/D1ExtAS9WeW0PQOab7YUsSEpROjUx7jSa/
	 39SxD1uvx6sSnisHh3grrWXFP+3XG2Q4Y52G5hb103hPxKsW+589Ps1vZ+o69Av51tw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793352256;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=MbUXsc2VEptVIMy62A+c1HqwhNVbhmBXF6DHkQkOhYY=;
	b=MZwi0f4eWwsmuCDZivlLpYfVXsApecLBX0SDFOxJVPJ2GhzvpDAbEcVgMKLi3jKX6USx
	 4ORvzNv7cW5iY2MTPx/fSTh/Qiuc7rObYvQHfdyUYnnzaBVm2jh74ABYYU0Cu1hhOwxYx
	 tK1uV/ck6od/mDAy7ofn6pC+oiGMDCN5eWLgWA3gJylxudfAGOt2k6YTsspHaddXU4va1
	 uYSa/4/e0KOwUDNBONYKSC2dlvWH6v1EIfni+1FK879H2eayiyBGwn+D9ceCgKpcTJ6uN
	 CgiM7oOEcolD28CIdqGs9QlWe/AqjeP7Hj+f+DufnHufI5M+TWdVVCrAlLn3mBJx7fg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793352256;
	bh=MbUXsc2VEptVIMy62A+c1HqwhNVbhmBXF6DHkQkOhYY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v+Ub44ltf+p8y1tuOYP9jsa6qjLF8mVVxHSi6GIouP/CCRZqX73GKZJMkwJsuNAJL
	 XeRLp/98nsX6qaHU4XAQAJYYp/2OjM29qOcXnJZ3vbXQN+G9qWIxO4rlyB95kNTggD
	 QqA87rY7ALpbUilO0lk9qVAMxJpi4WqPxzrAtnf5oK8W1gtru5e/2JxIObb/6djzwy
	 ZObhiYxr599dSOb36CFbL+Gs64seUEsm1EXBBvpDjSklPNtM+iEun2ihDaUCtiqPf5
	 16RnJ83L2PANtjpKExYRfSVg6vD2OienZOh5sQ4f0L76Ile3I/MFaqbqWF1zFgAC8v
	 6OrvuD6ZbhW4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5170B810F3;
	Fri, 30 Oct 2026 09:24:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5EA1F2C7
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 446F24008B
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:24:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xS2-f-sSR6bQ for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 09:24:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E953E40063
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1136"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793352253;
 b=owMDXuGFAq4zFpZoTmdK8EQj2ax/WWmpqlZLovV7aFtVtWg+ThcmtQCRGVITDsT2qE8O
 iaZiGHxMlpEng3NeZfodnHcoCR43SIRtGddWUU4gmeHN7dL1/LWyvGFU4i8QIj4AEb4YF
 ZwXLyjXWgwxZTizFWqNXIzmsQIcEVxRT+5KJ2rPa7O223zfILxCPRUXUxaYy4kvwRhHIZ
 +AXo2l60NR0R0g1ezWuVx/rnoPmwsgrMycYYLqmnLAx9iW252sHXnDUuQfgvNTH/cZOUq
 gAVSa4qZ25QoiHtvgsNmEUVuZKCCJpcPCVHH68zqWpQT2BkQshPRjmiSK1bDB18Yn3g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793352253;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=MbUXsc2VEptVIMy62A+c1HqwhNVbhmBXF6DHkQkOhYY=;
 b=r0nTi668fannwzXZwA6SuRZDoWpW+0Nu4jVnULuE4qRDemhYaNflAIejYAHXvS7AyZW2
 Z+lrxT8IIek2Ni5IGT4Z3OE9/Eo5YDLOUIKto+jM/SgWGaIQ0vrYMf7zzou5OCp7YmoWD
 T45DlQB0tfTws1FBjeReLv/WpUtGGGuksGjZ6ltudhH1kTJ+BGqXt/UPMXRWY50P9JPZ5
 snBvKpGCxcRhjn+mTekZpLexPTaQ0OtzaOY6+aq62p3brWsK9NoXiHltgYRlUEy8F5yKn
 +RyHzM5YBcqXMdkRbgqqk/0ut2DVNGjxkKGgqAGFjWBZPxHFxFVS5yxFxSlxg9zkdyA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=gTeN+C7F; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1136"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1136; helo=mail-yw1-x1136.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=gTeN+C7F
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E953E40063
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 09:24:12 +0000 (UTC)
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8b12b1ee403so2914917b3.2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 02:24:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793352251; cv=none;
 d=google.com; s=arc-20260327;
 b=mYzz6YxMzd127HAqaftAmCyaH0fs9ToxDHiDxg3ZeihdVeEx6KGNIXynWAccD1qDCC
 HAeskKi9HXjZ42DPYiljLvPP0GE24q3f15Q9bqhd9wpvBGf1hd2UXPM07kjHvxAy/OD5
 LPofsN1v2NuvQj+gflBKQqWq75P9HdZqPjFJU6zpU0EZ2zBjHn102I0DuKYpw2P9fVhL
 sGoI4/RMo315T8SX9rBNGpq6f5oD59HL81UREcOXEu/oBxXaQxQ8ABFwx20Uz1kHcAIn
 FIxHi5btLtQQTldO6KiO/7HvmfR0BZmA+mXhKrTNX/b7lHe/hEUqawfSHM1+NMJD1XwR
 tSjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MbUXsc2VEptVIMy62A+c1HqwhNVbhmBXF6DHkQkOhYY=;
 fh=OhOSfS6mWstEu/irkSxD71iDNWnMeRBAfsy0D3wuTYI=;
 b=T+sXdqjiQwmRRUHs5Yrg3osTil7iNJFoT7T8GxokPsw2ukJ31tyJYxsHQqbscZ6YFU
 QW5i1b1h8FbCc09GU/c1SkmoA11+MwSN4IYPTgtFtDGm5KLxM/qNjrK1rEMwLk3yic92
 kDAnq2TX8PrNylWzCZAadJz/fQHCAuZqMHm07lXdQL7Zx00p06LBWjQeFJpxeiQbuidB
 hNOnCaD3mORwewX1V1VjiLZE0OK0WrZNAexgTbF6CRrQHto1kTLoHt774HF7XAxv0tcS
 eKD2bnJ3CCQ6mEFumCPoNECNYZcvwhAI7kLmuuHiO9YxdzrbFYCqwenvwVxQb63NlV0K
 4Hbg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793352251; x=1793957051;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MbUXsc2VEptVIMy62A+c1HqwhNVbhmBXF6DHkQkOhYY=;
 b=gTeN+C7FyVzn8pwBGJUCLrQeSlN12NuAJ/IHJ1koXRZC+BigbRZedwW5dxUn1jye8J
 X/E7NMR3BYnt5e1r2qoLpaNLhVV/NKmk+c0gXEqMVwG7dmknelve/FVAUiGUSrYtOZ4e
 NxMB/yPl/9UHQyOqK2NCwk55vxhFxEgqWCltoP1zNcF88oxdv+QHMu+oEoyVna3e/VNd
 Gnjd6L4wWjWddDL/o+vUkDYD4/gPOwWn9yTTELOqHbZvlPuplcVh0t9rCGM71IqBRyH9
 31wSV7OLBXViZBlWj8GR50Sz4vk/H3uFMyxTgCjZeLHI6jFXMCIard2xV3mDF9cP4Cwy
 z76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793352251; x=1793957051;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MbUXsc2VEptVIMy62A+c1HqwhNVbhmBXF6DHkQkOhYY=;
 b=FGEpylug1/ZkD0RRS7u7oQ/r2eT0HXsWfQTdMYm8CF298sseB/stKXeIZ6SjXK9bwD
 7bbcxX3HWeAlA3xK+SuC87SfeBpGNZTs/javgdj6IBcFd35TXOs7VBOnsj/rUdX7Pmfg
 S8yHB2CtMWGHc/OuJAR5qK+ZEEddDRiqn5adMuan41IiC/CBVDHelmoBZHyWDAcDsNfW
 PKxjFI0oAHbgEV9VHeWBHjE4Ik81XX2f5E8x9iGeyBSCq68dETMaWc1w9ej8qbd6k4DR
 H5SjeucvXSBvXI8N15WBbzrHQHidMNi8LEz34sYWjAVl7HD8DZMx0H7uvl6kArSByW/T
 KXog==
X-Gm-Message-State: AFq9FYIUhNPhU4mBa5/WH8WFQFimPsSIQzD7go7LYeBVnHZmCWQE/ykM
 oXEANZbeLrZLuPeK8WpG1k/B3w4uQu+8Dsq9uXBm0fSBn1ZsAs1r5DzEBH8zIYXSt0GpzlIRzYi
 hF1TAYHWu+zb5RfYQoyVJ8e4hUPbw6+ZIG6s8x14kWg==
X-Gm-Gg: AYBFou2HqNzJIKfGaZvTeGtRZa8QLZ3IktyBSja3Ge1LSYcVfXF728g55NE/bQbC/wI
 odMkP7MIMWmfJuRCA4YIrKHltrgbT9JDsAmSoduHM1nDmU/2jVAE1RApc7N/A/wI9+/gTEj/YY3
 AU1EKQ8p5V1qjOKV98WYh2DaUQEUwSU1yH3BmtSLliMfjmKJ+fdGFVPBwwyIRFkA0GKV1zTDLj9
 /XQHSry5Whg7F7YE0bGX6BX8MKsVCPuNk73cFprFcrxd0ooJziTDmHzs81Dq95SKo9UTMKMMAlg
 yuwWj2SF5iRYSHxilDiGP0COId58ou4QnaOZTPzfk+HjKQFCT1fLTorTZDCfPkZc8w0+CJ+s4zO
 P+AP03KqNT7f/myT3mu+mBwt3w4am2YQpBlf2KquRo6qwivRrl71n+gQ03y+FcjKtu7LD4mMNxj
 50Z27SqtkG8YIMR8tahKLyFrJKC++RmQhTkRUXURvrpxH/hdzEOmWlQl/JMoQmjqc4orRS3Fdpy
 SkKuChLDtkPDVBIavpUyrTL1KMOi+4r402M99NKKomRgBh+BBu204RYhhCGcJOCD7xBrG8z2A+u
 IRTqwfEJbEuY1FJyBM7ZlMOnycmZAPpMTeZgmVTxc5gmBEnN6tA91P01IEkDLHdFuUMqiIrRtwC
 6S9DdEhOxJG9+xKwIgnMu84MVfO3GIjhKbA1vwhpXnroJbmYJrez2djL0kI0y5P4RSrY2iyye7I
 /HSh54WWsIaEY4MppcSMi4oBpzRJLkrQ6Zt3I=
X-Received: by 2002:a05:690c:fd5:b0:891:c494:1a99 with SMTP id
 00721157ae682-8b2b673fe8cmr12167677b3.24.1793352250668; Fri, 30 Oct 2026
 02:24:10 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <633dddd6-ee22-4cd6-a8b6-cb7df0650fae@gmail.com>
 <be672b54-42c4-48fa-a7ad-994a7ab47ea7@gmail.com>
 <CAC_iWjLuP0zLWHKCnaCzGL-iG1bR4gR7AqumaPm_yQ9MqgBfrg@mail.gmail.com>
 <CAJnxHsjrmr_6T1vXxOfX0y2N6_Te1w5dKwEHnkUfyW-7yJ+i6w@mail.gmail.com>
In-Reply-To: <CAJnxHsjrmr_6T1vXxOfX0y2N6_Te1w5dKwEHnkUfyW-7yJ+i6w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 30 Oct 2026 11:23:33 +0200
X-Gm-Features: AclHuK92k1hADvamvi9L4FoVjVZnLV2xiUxSXjAqpF7KSqei_ukiOx7Rgt70ifw
Message-ID: <CAC_iWjLxG3kTOgUQW-C7xbrQCm3Xfbaxry9UYY2nVWLG8ybybA@mail.gmail.com>
Subject: Re: [PATCH 08/10] efi_loader: do not load an image that cannot be
 measured
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ana

On Fri, 30 Oct 2026 at 09:54, Ana Bobillo <anabobillo3@gmail.com> wrote:
>
> Hi Ilias,
>
> On Fri, 30 Oct 2026 at 09:22, Ilias Apalodimas wrote:
> > This is a policy decision. The logic behind this is that the OS is
> > responsible for catching wrong measurements, not the firmware.
> > E.g sealed keys etc would fail. If someone cares so much about
> > security, wouldn't EFI secure boot be enough to verify the image? IOW
> > do have use cases where people rely *only* on a TPM for security?
>
> The OS can catch a wrong measurement, but not a missing one. An image
> that U-Boot starts without measuring it runs with boot services, so it
> can load and start the expected boot loader itself. That loader is
> measured as usual, and PCR 4 and the event log come out as for a good
> boot: keys sealed to them unseal, and attestation passes.
>
> No broken image is needed for that. An application whose Subsystem
> field holds a value U-Boot does not know, say 3, is loaded all the
> same (efi_set_code_and_data_type() logs "invalid image type" and gives
> it an application's memory types), tcg2_measure_pe_image() returns
> EFI_UNSUPPORTED before hashing it, and efi_load_pe() goes on.

This looks completely AI generated and unreviewed. What kind of Image
are you expecting to boot and measure via EFI if it's not one of the
defined types (10,11,12)?
If you are worried about such an image shoudn't we check that in
loadimage or startimage? The UEFI spec itself only lists these [0]

> On
> sandbox, LoadImage() of such an image returns EFI_SUCCESS and leaves
> PCR 4 as it was, while the same image with subsystem 10 extends it.
> efi_start_image() then skips efi_tcg2_measure_efi_app_invocation() as
> well, since its image_type is not IMAGE_SUBSYSTEM_EFI_APPLICATION, so
> the "Calling EFI Application from Boot Option" event and the separators
> are measured only once it starts the real loader, as when U-Boot starts
> that loader directly.
>
> With Secure Boot on, the patch changes nothing in practice: such an
> image fails efi_image_authenticate(), since the Subsystem field is
> covered by the signature and an image efi_image_parse() rejects fails
> it too, so it is never started. It matters with measured boot and no
> Secure Boot, which is common on boards where nobody provisions Secure
> Boot keys: disk keys sealed to PCRs (systemd-cryptenroll --tpm2-pcrs,
> Clevis) and remote attestation (Keylime) rely on the measurements, not
> on Secure Boot. There an attacker who can write to the ESP can run what
> they like, but it is measured and the seal breaks; an image that
> escapes the measurement leaves the seal intact.
>
> > Doesn't EDKII also disable the TPM if Tcg2HashLogExtendEvent fails? So
> > does it allow to load further images without measuring if the
> > measurements fail?
>
> Only when the TPM itself fails. Tcg2HashLogExtendEvent() in Tcg2Dxe
> clears TPMPresentFlag when MeasurePeImageAndExtend() returns
> EFI_DEVICE_ERROR, and reports a TPM interface error. Even then the
> image being measured is not loaded: DxeTpm2MeasureBootHandler() returns
> the error, and CoreLoadImage() fails on any error of a security handler
> but EFI_SECURITY_VIOLATION. Later images do load unmeasured, as on a
> platform without a TPM, but nothing is extended any more, so the PCRs
> stop short of a good boot's values and sealed keys fail. That is the
> case the OS catches.
>
> An image EDK2 cannot measure because of what it is, one that
> PeCoffLoaderGetImageInfo() rejects or whose subsystem
> Tcg2MeasurePeImage() does not know, gets an error that leaves the TPM
> on, and is refused the same way. So EDK2 does not start an image it
> failed to measure while later measurements still work, and that is
> what this patch stops U-Boot from doing. On a TPM error, the patch
> refuses the image as EDK2 does.
>
> In v2 I will name the subsystem case in the commit message and add it
> to the unit test, and carry your Reviewed-by on 01 and 03.
>

[0] https://uefi.org/specs/UEFI/2.11/02_Overview.html#uefi-images

P.S: Again this is AI generated an I am personally ok to review them
if they fix problems. Please do not copy paste what your LLM thought
without reading it.

Thanks
/Ilias
> Thanks,
> Ana
