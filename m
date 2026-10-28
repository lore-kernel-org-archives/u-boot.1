Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B74A606A31D
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y0skVM/9;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=MLmmE07q
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0945F40743;
	Wed, 28 Oct 2026 14:54:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o4sP_0IPY7Ks; Wed, 28 Oct 2026 14:54:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 488F740760
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793199288;
	b=SvEC9stV/bbt5H/twVQE2fBvTJlRTDW62S6itM1psWux5NJSdidwPxxLl0L7Qh6DX4J2
	 iLfoQ7nQxtsMZLxs488Exw7J4Xm4lMx/gcVB6FJI6BhF3GXilgugFA9WZv8ZAJB1VgQwe
	 oU1JIsCVp4oXLMT8h18KNSEFHvy7P6DhFGHOxiwqt4mz3ToacKwBWm7PjyUhzaJOxs6m4
	 BNN4drvNZZ9vFrJzJZytp6oAZbJUN7Rk22EfDbvbbWGcnUp1Vany5wYsU9u8K50OAFkAe
	 IAo41Q2mF6xF5lyhNu2bT31lOUirwnzmX8A7GRWIyhG8uJ1jjIyWT06vCDbx1/h93bA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793199288;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YeA0yErfa11EzxGfEjbt0TCFiXd796/A245ea08nRN0=;
	b=Nj2ByHAKcPVxXTbxDe1AFI4bm+jyet7WXfFe/UEjcjle7ImqwDd6Au7oYKf0kL5Tvmui
	 WjV+pw3gyvl4C7IFNdT40xjaDew2YsRiflY26m/4ZdPDJRYhPGgrdHiwmwmKva2kXciow
	 ZFmFcRoLA8FzHOlOSEESNM/pFGZPIbLel6/CsOTfyA+R+DSrCkVJM4Kd8CS7tNbxaO73h
	 GqIlzPYnxcqQZmTvSpLy3tn0noxnnCzqf4WvI4nXkrzKVlTbjMgxh9HaWc+sgB3RY6eFa
	 /nnjbcTGDQf7VA/LY0DjT+/In4SWpMJy70U/tEaAH00UkQOFb4sMfHgcIPUl7rXx4aA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793199288;
	bh=YeA0yErfa11EzxGfEjbt0TCFiXd796/A245ea08nRN0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y0skVM/9GI387tOt6CKlBVrlNLeFu92jl9CYyUSOmcmlKF3oxYj4zEPWQ/42OGoHr
	 qXV1SCyEwEZBYPFzJKjE9u0cHirYSdyT4xz7FudmYjkU+Ai+tFYE8XEyUSLs+Yx1U/
	 xQohCQ3WDcSz+kx+dahgiHWFq1RR9a8cgA/ZJBErRvfR6mOwnqhv63NoZ+7SlaaaGl
	 tU9gFGU44SSWrugpR/kYxkXYhoaNTm9ksF8h+feneV7bbPc6pryvXaS4J2CLtASgVu
	 ATCOzj/9jkzKd1/OCH6EURC/8/Fnt2tWBG/avlm+SOCnReL6Hda7bzdO58WMwDQ6hz
	 NZE2daGjCfuQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 488F740760;
	Wed, 28 Oct 2026 14:54:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8E6E8356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:54:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 80B0760633
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:54:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 03fDCcH_J2L4 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 14:54:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CA97C605DF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793199281;
 b=B5f8OeqVkBvf3GdvnORt6QpIwE7PVh38gV/i5rJjLj8A6IJlc3ofwSfQQCUedls+iR/d
 /wmtIWvzZMd2hUOtc37i2K4nztfyvxvyQ/DgxcF/SFQtYS0ueV26sFHwoZJkM465y8Se6
 mGn1TeNUy6YhnO6vog39ySjXgVcfPa4lmJaRup9OFZhOt1UICs6hVbhR6MD8rzhRKKKrE
 BUR5xu8CDAgfVd31Tz2qk67KeSfB5dGQ9tmLa1ik6rqaVajIPEeQnu/gxj8hmBz+YNp7i
 pJpWCVD3u+uM3B6uOTe8uQJF2cBDFWhKYLW4jvI/zvjSCfvYgLuT2oPmYH87wLVDPFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793199281;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=YeA0yErfa11EzxGfEjbt0TCFiXd796/A245ea08nRN0=;
 b=FzpXr1o+c5B6DsOtEBsTvj8YrkEV7/1lq8CTcvvH3yplkhlBAOSoDdSDLIvYbQONgcuh
 YvKcB6mLpvCEoTpvKj/qTn5nDWDXkd+CABQOOMPWtgTFLpZI6Bp1oT3rn29wT3V8+tQyc
 whXvy1PAfav6KstFVR8Di6lxpQ28vDc01zshvs2Q7D4xQBdmXcDH+Tk7IIe/E3IFDD/nS
 Zw6fXoNEehmLSO3urrUP7dyEsijXP3F70UliDx2CbiBo59T0wOUHLRgDHVJXCNlwQUqaB
 PMQaIBqlp2F6CBuKRDiBGUYhuvK4EL+yPdXBHtjRp7WK/gMvaIaJnUNQuCQ9aITW+Og==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=MLmmE07q; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=MLmmE07q
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CA97C605DF
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 14:54:40 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-85a5455bd3cso649439a34.3
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 07:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1793199280; x=1793804080;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YeA0yErfa11EzxGfEjbt0TCFiXd796/A245ea08nRN0=;
 b=MLmmE07qS0npzjt6NNTTbJq7gadKIt+Wor0KoF7j9pQLSMMrBHzVkhYazpELPydl9p
 PWLWUDiJA5VH0PWKZwkcxyH6MHieqipUlkiHQ79rQ9NMNBpOF251Ypz2W76SFLA6oJQa
 isT2KrOJ9ljgWdazs90XobCYibmQtVMfOu+1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793199280; x=1793804080;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YeA0yErfa11EzxGfEjbt0TCFiXd796/A245ea08nRN0=;
 b=ijrXq+7m6FCvr4w2SASk1o6+ZQFeunSDMoRRHCgd01SApo8zsUMd35gCwTnophJ2/o
 dz20TKTsEnKFq6XTod6c8du8kqunrmoAABOWk+Ld5V+z1hZjMgYiNJcjHXHuhaKOYNe9
 3HOJt7Z5PK+12nhyqeIMj3uWTgfRWV7V7AkdkXvHHeNuKydHeFAjDwTGGwQpxyDiW7/h
 PZDmIO8PhXwmGLrAlWfju221wVNwGn3KQGAzHXj/rbRG++AYlxDuVtEGBiemvsqr/gFc
 CTGUoDPWB46hpP0tYzkw0igNV6rYM1ukXauyOQxOeJ8MIUagQ5bxshDqXVK+ENLuz4qU
 Tx3g==
X-Gm-Message-State: AFq9FYI+MBm0fcOAujUhITzXNp8lrSh6FQWoDv53TlETX5zR7T0GBhvT
 0K5IoNqeijWi9Bh4NRtPuTO+N2q72G/AotZgGI5Gu5s3axi19cY1tWumqo1oJSacDpWQfL2zSrR
 /AVgOnzQnuLo4
X-Gm-Gg: AYBFou06AH1z+XSd5tvOTG7xvv+nPOjGaqYqSO0jUesWzCmIbcfLT5c38VOw5MVgBoe
 /VKleVmUdfEgwwR9PkKv/h3jiDIM57bwH6XOLEqdGdLYkitUGgDVl7+3fQMK8d7y4Z2yn0J0IV1
 2VVCtKZsqHMteStRphkyF1Qg0BY9psLiymyv/rmFiwRk56j9tqk2vuPuVtPoYdur2sSl+6j06n2
 +PENGPPY0NXrUlIWdpBngpkQDTgQh4rlm0iy7+uo6CAzlmRGeSeqRLuNIX8nrr7pDhu9pi4Im+r
 z3vub5QgFU+x2HNkjSZK02LkccgEkn4q7pSROlaF3aFXJUO4wikC22p9pefN8vwF5eHtAmZlN6l
 lx6qUoCOELEnSusW456tOK0lM0YS/uPk6gGbwsNtDcOOABdnPeMk8+v5Z8+2ONLNhjKkml2yF0Y
 oiI2GXhw+OH1QtHPl1C9bvYnoWhxU4YsSVcveFJzdWNaRT0WUgMkOa3+3z+zOYPoYRuHTbAYtqL
 BNOPUQgkb5M33BCHAZ1CUqKQU9IEN/NbD1E1/Sxe8k2kJbdsNRGS43jNZBLcLBtutiGTyXk/Y9+
 6dXVY0afomOGdN36lbwlE87nwn/Wqfe8YIo/WuumBGfWUGhcDpah3+d3In/39HvDdve06Y+yLxF
 UN2PSWbf43q9qhfhQfWxJWGO3x+ZhZymuhD8Ixip5k5bGAsrmsbL9+11CzJoaALuUnkr6V1u0e2
 tIRLdxmSPLm6/Q8yBQhgaR9TWTCYjicA==
X-Received: by 2002:a05:6830:6810:b0:7fa:ac4f:793 with SMTP id
 46e09a7af769-85aba328420mr2390852a34.31.1793199279753; 
 Wed, 28 Oct 2026 07:54:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b20217c77sm1871528a34.21.2026.10.28.07.54.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 07:54:39 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Udit Kumar <u-kumar1@ti.com>
Cc: vigneshr@ti.com
In-Reply-To: <20261014042744.2017446-1-u-kumar1@ti.com>
References: <20261014042744.2017446-1-u-kumar1@ti.com>
Subject: Re: [PATCH] board: ti: j721e: Remove HBMC node from DT when OSPI
 mode is active
Message-Id: <179319927890.2677777.16895243308510481960.b4-ty@konsulko.com>
Date: Wed, 28 Oct 2026 08:54:38 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 14 Oct 2026 09:57:44 +0530, Udit Kumar wrote:

> When the kernel boots, it invokes sync_state() on the HBMC node, which
> powers it down. Due to a power domain dependency between OSPI0 and HBMC,
> this also disables the AHB bus, making it inaccessible and causing
> indirect writes to the OSPI flash to fail.
> 
> Fix this by removing the HBMC node from the DT when switch SW3.1
> (WKUP_GPIO0_6) is set to OSPI mode.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] board: ti: j721e: Remove HBMC node from DT when OSPI mode is active
      commit: 6a4ea97571fa7a14739cfed27b4325de665ed370
-- 
Tom


