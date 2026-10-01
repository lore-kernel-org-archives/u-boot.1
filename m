Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6D1CA5FC5
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 01:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76E5560BC1;
	Thu,  1 Oct 2026 01:22:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5ZqDTlNtzo1P; Thu,  1 Oct 2026 01:22:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CB6DD60B94
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790817735;
	b=ht+4eIn/cTq+PpfC0B7O27WYUjcyTr0XgDqplD7yiAoj61f932PhuEUiSGpN87SKEIW5
	 6e3wx9LCuCEsrhhbBGPpjRfhZjV0YBltJi0TTii4dHvDa4rAu3z7OlnSG5UmSYXig/s98
	 XVdrciWJNe8JMUj91d9/1w6GAMxA1DJuhj2x7XPz/i1vmE6EhqxP0whL1H/8CKQsVSZbl
	 V3S8Wow7V9q4m0G/Kof9QaSNlcWUpv6nBRQkGLbi4HpzTn3gP7kQteO3om0bxWv6G0fpC
	 a1BJYxLP7STiTU45l6iFFSGgrjquJQYenFFwNmopqP1YIiBzVhrEgCEQIeJn1Yvc5Yg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790817735;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=s8jyQoaQp6NkfhX8PTikhgetEBG4kUPwBILwvUNqS2I=;
	b=gtZXa/fFg1CKo5R68Vqf/G0PoyBB17vXky4D7+w4nOLkVzBKeDP5SI+/5dylrnYz/Ju3
	 qkRe5I2K1VCeQkVQ3e2jpu5EpkwZLtOCq80235XzNyNYE1wbNCZLQcBOZygNo4S7IZpdw
	 TIWwfSEtjPMWbesA3PVdeM3VawDjaVwNIzONNRGFn7dFjPISPVVLR059PuVov7M/SibDB
	 Z2rv9EWmKB9F4tniKcIXbaV0zALhcXB202T7ldABds6TrJqb0ZAll12kcCBWE84e+9ekx
	 AjPyFRjIcWk8ijj0JwFOnwPO07SzMjZvnDbwdL8xDrbCwnPO1N03tO52wSA4GA209LQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790817734;
	bh=s8jyQoaQp6NkfhX8PTikhgetEBG4kUPwBILwvUNqS2I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iA8bbdsJr92qCpnjhsu3VdRXmpoJ2ilfd23Y+8YvTM0KXyaD7d9MCDhY6OUiL9uxp
	 /rj0+gRLHvKy1jh7wGVNwiCr4Xdwr2L8L2tgZwGwJPpXap8PbVul69RvNSfHty0hq/
	 0uSeZbVUyPTXj+4lF/faBvWguCivaXapZbYvjBh6WKSgbszQSO9ELTTrJcmHgChZZs
	 G477VA2st6qkVfAJokaVNToN34qkD80MRKNAHwkfT+QfuFPwHXt7PBEKOgzJ48bE+t
	 ZBEzzrjWjTbjBjpRVRFZr5HD7SrHu9yvpjtXnzN88rVNyEO7sPNuRXBQlpWKRHeDXV
	 xPiFAi1GltkGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB6DD60B94;
	Thu,  1 Oct 2026 01:22:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D88C31FE4
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:22:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C9B97806E8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:22:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bw2MJh6lgB9M for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 01:22:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9152381205
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790817732;
 b=VkuWCjhNVsjRoQ+CWqcm+TjnNMYGhDKv9w4sO4DhwebY5XMEO/4ipX8/bioFZ8TRbLTj
 gvxBoqpf0IBTvtpBudf27gF/QT16erIe62PBy6/uYq6ycRN1O9BZZTdB5/LzIwqJxzWEV
 RCvLp2abUwm9VeWhX70dRGXI5LeMcfkwvVg9dNbzyw05pCB3Z78AsKMizGqT//z06lyjf
 eZmQayCBgSNhvgWvV6YPKe08TxVlDiUw8iqYAWRGIoG9Pg8i4nY93XdXZZCb6NlxJG5AJ
 Sw+/GfnMDQTmykFjffE13WKcZGbodIwI0yibguByd7tguRJjHDQdBgdyKGsISHcIUfQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790817732;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=s8jyQoaQp6NkfhX8PTikhgetEBG4kUPwBILwvUNqS2I=;
 b=gOF00Q6WFMjSv2cluqNrhyE8nIbWxI0vj5BAEfAd72CgWk04kD4rIm5wD1OdR3ahdvNq
 T+H2NK6neIDQOuQBCDJMTW1+tgpWZUA+nrVa2spPdpWOm3C1tzNjME0lxatrrx0JMqcTa
 7QLfw9/Bm6xj6vpM2BN53rj2I0BCFR22DsExBsTaVtEixWShHzG2KP7kdVgCdw9Fry1cg
 EJYax29HZ1D0cHqryyQGpoEPunyUkWuT26DYNWBULY4P1tmzsVWsomcepMK53mgDjCisT
 e1zL7vaZN88kQnoU4WRMDWClMYshUOki9oO3zsNriGYV/qB2i8GCwvmy28mFiQ37PLw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RF3Qer1J; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RF3Qer1J
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9152381205
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:22:12 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2dd88a115ebso34101685ad.2
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:22:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790817731; cv=none;
 d=google.com; s=arc-20260327;
 b=TOVZsoXsWBfAfcrcVf+Znhj54d2XGzLSO5iaU/SY9o5utmAp2nO2EkO0pRsmBPtu6R
 hPRFwAtGp5XNdnE6k9eL3sJHIjYnMUjvkW6CPPWB0tAFK8gPeld1cS7/HzGZJ5qGJ7y8
 Zi3M7Kcr+VEytz92h2mOtUxbcTqbdyltaob3dGDNpq6W/nnlRC1uHucpnqsBOMt0OEaD
 2lWltOfzMmIEyZUA1YONROsvudjGKjutZp0yWAMtoc7f8chSB5vW/6sI0eV5zp7MsEqJ
 bjtUgTxQm0MuY3yvBg0SNEREbWQwWJ2D1CTXzgDNMjoXL8oWWdpX3ftyjbko5jU+DLCN
 Yw2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=s8jyQoaQp6NkfhX8PTikhgetEBG4kUPwBILwvUNqS2I=;
 fh=6kp9AZrJQVEoEjuAnsIKLy8CYrEVQCBO5RXt8XAcDf4=;
 b=Y/j+GvvGbl2d9N3EXU0wd4vwZCAUaST8kRYQUnlB231E3KgmBCOdwNuJ2qNgsetCPH
 tbdb92BTuDPsX+oRRM/G/r/I5wBUNOQ1bK1trlzEBasTw8X0DNI4mxVyyWhLFSFUQnJL
 4Cp8DYXJTxsJMn+3hNjf5v9J9NuB2YlMsi+g5XcuTKG71NNjIgMTuRZai+b8pjAM8uxh
 LQkX5irv9YPOfGvZ8Gd8s5ao31A7eWa1y2braZShaDg+nFTo2mWBv/61Ublop/3AIu7p
 7vjpIAADilOAN5oo6dxzDVH/ZfZ6s7Z49YIUFZEcsMIpdSZKzwZFGcbDqBHDnpNbbK98
 FMbg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790817731; x=1791422531;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s8jyQoaQp6NkfhX8PTikhgetEBG4kUPwBILwvUNqS2I=;
 b=RF3Qer1JJLPKLMWqmpGMT7jviPesFT4VhXeiekqMSJXnfjc7WO0SQ8hHRzmH50OhMm
 Tabg8o9o3QmvAqWiBqNIAq5q92NHdDl+9c92/LqzP6zfTVmW8JUbxbAstx9nJAV5P9No
 2slKJTEBP7+hSmyShDut0nGT4iDpzdXxfqqGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790817731; x=1791422531;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=s8jyQoaQp6NkfhX8PTikhgetEBG4kUPwBILwvUNqS2I=;
 b=V9l1XaOWP+U9GqOBCqyD8l9ly1elkCDabnlX7ohAKv166FqlgxblOh/YJcgADVHh29
 wzrIgHogEzilpSdz3+vJyrn2JDK1nVpOY+HuYoi/Q9tZ1hCSXybMtvmrdyd8CEw3DYHA
 pPyCaapgLYc77kIJJMY6VRwRJvfKByD4gJERsqp+LAT64+QPrEgPGE5xFkxZz3PoTQ54
 1O34Vf/V8M38AjEGVAmexVfuQFPaJlX11AVJ/4oC/ZXniU2qSoCoxeIFe0FN8sml5aoL
 WS5y8ioo1ZxNVz+sNW750BVHpGT1AwGcphplRlm+Fv+APcSwLR03zrCNEwga4DovQ1ec
 3ofQ==
X-Gm-Message-State: AFq9FYJzIj3I9LbVZOIWqlU8ebgzRta5w/TdOrx8HKXbVR+FxowzsNy6
 hj1v3RO1gm7yhI4SgCJpwerVAmAWMwT55FJqMMs1BX5FPDHBWlZ4bAu6hkzViIQ1cO5mCymiO1a
 DzHIT11DQPob2y0FSWQK4LvoAwSZlufY3I80GuZ0e
X-Gm-Gg: AYBFou3fV7Lcwk2JAoG+2PIrgKNQiww8dB+QjFy+nL/N1cThvOwUzm7tf6HS+3WuDUu
 ieezdQSIXaa0F3HigjmWREGe9BMwE21GRKajaW4ySTSkdV6wvlH8EPyT9IrS+tzWArdPMexP9Sg
 WG3gxVUokAnfEUogNI1SWmBDLViIpprcuFXqxbwkh1r7fI9y+Xv5xZ4+NG1BjON7bg+MtshISxq
 2c8pi+Q//GkjL9hcLFunDY6jtnBsDhPYnBr5OxLvOY0oOmidvlfYFQLnpIyzhib8UDfwVOSaQE2
 jDfjVd1qygurN1ganK1meFlUa2jWfdXOH6+6kpKCRmH7J+wFXJws5gT1
X-Received: by 2002:a17:902:c945:b0:2c9:c952:6e9 with SMTP id
 d9443c01a7336-2e2e49167eamr27962095ad.2.1790817731371; Wed, 30 Sep 2026
 18:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260929110315.2879640-1-suraj.hanumantkakade@amd.com>
In-Reply-To: <20260929110315.2879640-1-suraj.hanumantkakade@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 02:21:56 +0100
X-Gm-Features: AclHuK8PgDAXmHs94VU8WoUSLuF5wa_8XVzclZ3sg-l3ejXML11-DP0XzdVQAMc
Message-ID: <CAFLszTiOjo1fWH4pyP0VAi02Qb=rxXLCsROtC+C78LUNo_8PqA@mail.gmail.com>
Subject: Re: [v2, 0/2] scripts: dtc cpp flags via response file,
 GNU Make 4.0 cleanup
To: suraj.hanumantkakade@amd.com
Cc: u-boot@lists.u-boot-project.org
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

Hi Suraj,

On 2026-09-29T11:02:52, Suraj Kakade <suraj.hanumantkakade@amd.com> wrote:

> Patch 1 fixes a build failure where a long $(srctree) makes the
> HOSTCC/CPP command line for cmd_dtc/cmd_dtco exceed the shell's
> argument limit, by writing dtc_cpp_flags to a response file and
> passing @file instead. This relies on the $(file ...) function,
> which requires GNU Make >= 4.0.

>
> Patch 2 raises the enforced minimum GNU Make version to 4.0, adding
> an explicit "GNU Make >= 4.0 is required" check to the top-level
> Makefile and dropping the now-dead GNU Make 3.x compatibility
> branches.

Please can you swap the order of these two patches? Patch 1 depends on
Make 4.0 before patch 2 enforces it. On Make 3.x the unknown $(file
...) function expands to nothing, so the response file is never
written. HOSTCC then gets an @ argument pointing at a missing file,
which gcc treats as a literal input name. Anyone building with an
older Make, or bisecting onto patch 1, gets a confusing dtc/cpp
failure instead of a clear message. If the version check comes first,
patch 1 can just say that it is now safe to use $(file ...)

Regards,
Simon
