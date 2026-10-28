Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8A4606A31F
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 00:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b/GWh4WQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=docomonet.jp header.i=@docomonet.jp header.a=rsa-sha256 header.s=20240125 header.b=tyXQQr1e
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 862A88096C;
	Wed, 28 Oct 2026 00:59:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 80_XIoTmrAZx; Wed, 28 Oct 2026 00:58:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8A651808FC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793149139;
	b=jdoEb9H6JD2lxe6eZRqD5Ux8msNVFYCFJeF2n2xC/M5E/oYJvSapokv8tfn9gYjJVRJm
	 5f8IwU2zXzl4qfYm+zRGVGl7UXVqdJ7ckTAC80+Wfs4N7NPTmA26sYVueUfrm2Slk7C2u
	 fEhvANG0uURx+4jnMLKxx/MbyBr3JBDfCuKr+yKT08q4d48aba1d/s62LQ3y1ZLCYPDO0
	 POOOKPhhrF5z72sDPsHkQMi8/4LpftIqj6LdZMD6HD6iKYxlwTRbhGB/PYg0QAHA5Eb5k
	 VLaoIG2+2RNDL0vj0iv0ITvow/JbRl+WvkhRk/0owcD75z7vDK1f7Ri4iGwqyoL6b/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793149139;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:Received:Received:From:To:Cc:Subject:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 In-Reply-To:References:Message-Id:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xhqTLtta6ME6x8PiPoMLk1Xna9/qmQIgv0FiHbj9cBw=;
	b=g8T3rIswaEyVGCeRY1xb9jgy3kZ4d79q15nkRJAhMVD78QUMXmF0L05MWAlYrFssLxVI
	 hTKfNpx3PIec9tCgrdP22bYcCjhymUDtqyMGbDGWvUVdfrVAI4SWFvDZlIQBApQ/P3Ghj
	 cHaEyg+PH2qV7Q0/NgYPzZHXYK8woB9CwILTF2eRF5AkvJAEFH2XFZIFAAs6Bsqctvvee
	 mOAmJ6Z5cGNxNlIV7DyHxwOKlzm16xP9M0L1/ChGMS3xel/bLaZ9zRRqQ05b4yGpMBMRK
	 EidJb7yRHCxJPRFrlPzA4Yc7ubR2S0S080OupUTlWYKSPlzNG3bgxLVzltohxzmdBVg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=docomonet.jp;
	dkim=pass header.d=docomonet.jp header.i=@docomonet.jp header.a=rsa-sha256 header.s=20240125 header.b=tyXQQr1e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793149139;
	bh=xhqTLtta6ME6x8PiPoMLk1Xna9/qmQIgv0FiHbj9cBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b/GWh4WQPaVxPoIRZbI+xJQAaId3GYAgi1Gnu5w3IQfHjAk2wgVKUxerfWc+91wkX
	 Q4E9PmlhBYKv8Q2H7FCeNfJ6gY5TFvaM9d1zcCpDL6ztmDeh4jbZ+gHjOuGfzDW4ak
	 cpZbeKndKDkPpGuhz5gkn8Ufj5cpT3nA0Ce1a/u39L+MrImrUPLQPNFl7tCs4clpaI
	 l2AKgUagGB51DjlsMueIBJa0uVL/+imNNcbLGG5xlVsv3ZWvR6L5IQaEH+wmn4ZkW8
	 5e6Po6liWCye8++emQNfnEo8mvz7nXHKrLZ+57dGJWpD0j4dNGB3XT6c22pSMKOGnG
	 SLJvmhg9UZyoA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A651808FC;
	Wed, 28 Oct 2026 00:58:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 640B1D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:58:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 49C78808FC
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:58:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gd9Rc2rEjPWV for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 00:58:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ED603808C9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=210.145.249.208
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793149137;
 b=aO7UwOKzvi3MHvSJSye09UdbQGhALkeKdLEWIx4x/y5sFGX9QoHYxY2thX0Aar0B9S8m
 0WgK+eRVAjElIMg9/nN4sYbCDTvMdB3Zx7pjlkXags5U1YDEs1fL4fac6m+7WRruyhX1K
 l299D5Bg3EOoi7N+HlicPZjevwaKBB30gLU6udv3X0OvGdqT0Uh8EZyAW8+MfGA0jZ1eL
 3gN717/5oTVb1naDOJgdB9bB3Exbz5Z4WpA42tbZpNH2UhIrmaN4laSw8+vpqvBi94vIk
 VepRLppqtrdpKqkh2FynQxQo+Ftvd5qQ9ynL5tQCjNCAnF98p9pd91n8UWYxNDOYYoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793149137;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:Received:
 Received:From:To:Cc:Subject:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:In-Reply-To:References:Message-Id;
 bh=xhqTLtta6ME6x8PiPoMLk1Xna9/qmQIgv0FiHbj9cBw=;
 b=R0h7veW9yq9IcTBdwas0bz3MQa9T0qEDWtKNyP01z10a9AL9/H2Gdx4NETOY5EojJx0V
 0YLYLqHnp52NLTkFC+QZ78DajUV92ZcEzzhRa/ImrQ7YL1IM2/EfDh8x91Zx9lxBuy9zR
 2FN14G5M9c039YbCN0frkwHjjCs3qpJPN5YVd3lHUGDmubvPfr79a+M0DYTJS5lpt+BCb
 Ci6Iqe07Q9VhArn/+RP0oOhnCsLTVCfBqk0GiIVeIo+5mf1kSqHIqBXGBIwwlA2DR4Mt3
 DyAkArDtqGgtyqfAupmEa4sLfoypjGXtEuPOQ+wbI1za419bnVfqEkpECgTNeSuU3qg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=docomonet.jp;
 dkim=pass header.d=docomonet.jp header.i=@docomonet.jp header.a=rsa-sha256
 header.s=20240125 header.b=tyXQQr1e; 
 arc=none smtp.remote-ip=210.145.249.208
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=210.145.249.208;
 helo=ocn-dfr-mts-208c1.ocn.ad.jp; envelope-from=y-asai.0816@docomonet.jp;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=docomonet.jp
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=docomonet.jp header.i=@docomonet.jp header.a=rsa-sha256
 header.s=20240125 header.b=tyXQQr1e
Received: from ocn-dfr-mts-208c1.ocn.ad.jp (ocn-dfr-mts-208c1.ocn.ad.jp
 [210.145.249.208])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED603808C9
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:58:55 +0000 (UTC)
Received: from ocn-ckd-mts-211c39.ocn.ad.jp (ocn-ckd-mts-211c39.ocn.ad.jp
 [210.163.245.40])
 by ocn-dfr-mts-208c1.ocn.ad.jp (Postfix) with ESMTP id 8FF4F7000020E
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 09:58:52 +0900 (JST)
Received: from ocn-spm-mts-205c1.ocn.ad.jp (ocn-spm-mts-205c1.ocn.ad.jp
 [210.145.246.230])
 by ocn-ckd-mts-211c39.ocn.ad.jp (Postfix) with ESMTP id 40B9620002E3C;
 Wed, 28 Oct 2026 09:58:45 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=docomonet.jp;
 s=20240125; t=1793149125;
 bh=DlfN4F3QwYla2rxXts8khULYIia6QFD/yEbQ+/YYGfQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tyXQQr1e69DFgsSWJXX+dgNNa6J9HC2F9ZkkDlxfChk+iXYLeh1xzcFxX5eDWKpT+
 FkweVsgyNhcBBghz3AWKzoGJwej2rdxxCgFfiLgsBEfy1LjJSDZll/YeXVGuB/9bOW
 a6u60L3lwrhdAr+vSCnXNZN0rOS2tm4zqQ65nCg0=
Received: from ocn-vc-mts-210c1.ocn.ad.jp ([210.145.250.232])
 by ocn-spm-mts-205c1 with ngmta
 id be2382af-18e28ba0fd9f8720; Wed, 28 Oct 2026 09:58:45 +0900
Received: from ocn-sdpx-mts-202c1.ocn.ad.jp ([210.145.249.135])
 by ocn-vc-mts-210c1 with ngmta
 id 50dd90fe-18e28ba0c26bef2e; Wed, 28 Oct 2026 09:58:44 +0900
Received: from docomonet.jp (p3688129-ipoe.ipoe.ocn.ne.jp [153.238.101.128])
 by ocn-sdpx-mts-202c1.ocn.ad.jp (Postfix) with ESMTPA;
 Wed, 28 Oct 2026 09:58:44 +0900 (JST)
From: "Shigeaki Asai" <y-asai.0816@docomonet.jp>
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, neil.armstrong@linaro.org,
 jh80.chung@samsung.com, peng.fan@nxp.com, kever.yang@rock-chips.com,
 sjg@chromium.org, trini@konsulko.com, ilias.apalodimas@linaro.org
Subject: Re: [PATCH 1/2] power: regulator: rk8xx: add RK818 LDO9 support
Date: Wed, 28 Oct 2026 09:58:43 +0900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: HidemaruMail 7.47 (WinNT,A00)
In-Reply-To: <0bc7a7aa-c51f-47d6-acc3-22d554ecc09f@cherry.de>
References: <20261010013237.2269021-1-y-asai.0816@docomonet.jp>
 <20261010013237.2269021-2-y-asai.0816@docomonet.jp>
 <b4abae45-635e-421d-bb8d-e4699b0f05b2@cherry.de>
 <0bc7a7aa-c51f-47d6-acc3-22d554ecc09f@cherry.de>
Message-Id: <4DD66777AE0BE92F3006A@docomonet.jp>
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
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Quentin,

Thank you for your reply.
I think this was caused by my mail settings.

I will send v2 later (with the 1/2 patch only).

Thanks,
Shigeaki Asai

>Hi Shigeaki Asai,
>
>On 10/16/26 3:05 PM, Quentin Schulz wrote:
>> Hi Shigeaki Asai,
>> 
>> On 10/10/26 3:32 AM, Shigeaki Asai wrote:
>>> The RK818 has nine LDOs, but rk818_ldo[] only describes eight, so
>>> LDO_REG9 indexes past the end of the table. Its voltage reads back as
>>> garbage and it cannot be enabled or set.
>>>
>>> Unlike LDO1-8, LDO9 is switched from the DCDC enable and sleep
>>> registers (bit 5), and its voltage selector lives in
>>> BOOST_LDO9_ON_VSEL/SLP_VSEL with the usual 1.8-3.4V, 100mV range.
>>>
>>> Add the table entry and handle LDO9 in the enable and suspend enable
>>> helpers.
>>>
>>> This patch was written with the help of Claude (claude-opus-5-5).
>>>
>>> Signed-off-by: Shigeaki Asai <y-asai.0816@docomonet.jp>
>
>The patch never made it to the mailing list, c.f. 
>https://lore.kernel.org/u-boot/ or 
>https://lists.u-boot-project.org/pipermail/u-boot/2026-October/thread.html, 
>can you please fix the consistency issue and send a v2 and make sure it 
>hits the mailing list? This is fixing a real issue, even though you 
>don't have a need for it anymore, so I would like to merge this but I 
>cannot if it's not on the mailing list.
>
>Thank you in advance!
>Cheers,
>Quentin
