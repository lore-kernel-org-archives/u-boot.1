Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27A4606A325
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nAUsNat0;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ORAbZKUn
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D17B5405A9;
	Wed, 18 Nov 2026 17:42:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jdQZXihiki0H; Wed, 18 Nov 2026 17:42:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 30D11409D5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795023733;
	b=UwLQLHBPlvqjAU5cXNFYzE/QGjxq3+zkkFY3DqGr+dRpN+8q1n75OBku02UGvBiDV5Ng
	 XfvGwIghGLKrDsINLspYjTur01uzeCigJr0UjWK8wnDhNhGPCl34OdcMdEvL62OztIwif
	 QgxoN2aAyNiucbKcAKdLuW2DpcVWArFH0jockjZOaYmT7zoqvPB2NgDsaUgKsEu2+pm//
	 rgaE33gELroXtbh74DZBoDCw6WroE8A+gSw8scwN7HXsSDobfeq/I+2cmgXVM7fYtEIvb
	 8/XcpdqbqzoKeI0c2ltSsZEeUUDplFT9DViYvPJB0kuTN/gNT+22ld38nhe6XZZLVUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795023733;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Uw0Cq8S4NHpttod6/svnYzgmUh/YvIRWx5XT9zJ0cuE=;
	b=O5LrxlTij7O5SmaLjz/zDtaRt7wQIhjPbnhOiq/l1TiAPhs1P4fku1wjY0NaOS4oecq8
	 RfwQI0n+pr/fOhEmHTFkBieUp01UWGyPGgPO0kVLcDysxfJPANPPBIut+9F1k0aG43Fzu
	 +nFDwPTH19SeXmyU98Psc/V2KJbgqlAFeLb7VrzmFAb86sLkcoentfFxCmxbxXHBurFoV
	 NzLhlnFL3obd8YaRGsjiMlAvGlIMhBQzURDvriF7JcLcS6kdZjKXh/zxQSJKRf8+YtH1X
	 x8GcOebr+yeMVa04SbVTznS7cBESnkx9+psXhsFxQruTbH1zuevutYV2/3ofRAh7gpw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795023733;
	bh=Uw0Cq8S4NHpttod6/svnYzgmUh/YvIRWx5XT9zJ0cuE=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nAUsNat0tJDS3y9Pdz67+WdR+M7yn9us4ePxiCHH3lC4DDGe7RksirCeuzd57iV2+
	 XigqqeA770lOAq6sGdYUkog2vwnhPj2XAYeuwClPbnGcfUjWDQ+FuOKHnvN/ioEWGf
	 13l8n+yQ1Nky6fGg8FSAvlZmbfmOj989/1JnIJPM5YAq5SaaiTTfZF2LUQMV3u81Ek
	 caoPtrivFQ+mOTF0dUkB0fh+BXN/juBqShuXk1ePx46IWwChWMGsdgZ2K8GafNF5M5
	 BVfrihrSlmoSmSbxhC1RaKkKytkGqZS3PpRZvmpTU9aau9A9P+FrIyjqiROlvXUCU2
	 FCL+DPoL4NS2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30D11409D5;
	Wed, 18 Nov 2026 17:42:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E562B977
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:42:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CB3B180DB2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:42:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fx0JILv5JtZV for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 17:42:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B9D0180D3E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=ORAbZKUn
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B9D0180D3E
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 17:42:10 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c5123794038so51483166b.2
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 09:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795023728; x=1795628528;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Uw0Cq8S4NHpttod6/svnYzgmUh/YvIRWx5XT9zJ0cuE=;
 b=ORAbZKUnlUQzqTe5ceFbygu0a4PKXswSyHJPNDp+Oholk1jl1icrvnlCXWYJXMcOvL
 H5QlDojdfZN3luWV8e6Xpedw/34Kaii+7nxEPtbDBKmZUaEInn2Iap1ZX6VbEsbhrM4H
 iRCJ6f4AD6oWwsftGD2K26nnFmJBsLtIxNLuawnFEzNKqYnDArBZu8VCV79beMu0AUas
 AMWwp3QB3TDJo82GGmz2XW3Fqr+J/mlIViehaciblXlFJGlLvt9pcG3Y5ZfyJgzJQN7Y
 ye4CF0qdCzJInSAUp3DrkhHWIt4UsTUPWqQC2wSMcxtXzsBWpjxJ3JPSr69MAAaDvouc
 TXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795023728; x=1795628528;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uw0Cq8S4NHpttod6/svnYzgmUh/YvIRWx5XT9zJ0cuE=;
 b=sLW9flG4o9LIm+ptvnxzMXA5YkmEqjfzF4Ih9+f+0lzh0LndQRBevfR/4PauzrKVKf
 QfxBiZyp0Q5+r26JdqK+VDPhaivxhiuQgtMUd1OrONiKkfsuXfaVH7QdFzg53MYbxG2x
 GW+k9l68AuP7f0GrSH03mxaB+oC/MnFlb+Xm2To1Uo40TspK561RdWJlL2ryQmd8/+Fi
 fxd4le+WjBuDcwaQakv4e3CAqA4i7nZ+qHYM57YJBBegQNz4ffSw6n25DELjDFcAAxgm
 NM9tojhrVndR5DYvBiGBkjeD4UtqaED8+6UeQFWfaYA8H5d7LA3mAV7SmC0LNQcb8378
 kpYQ==
X-Gm-Message-State: APuU4Z/0G88n7MLO2y301XZNBsZnnA3mVlnF/Ossr9Tj1Rt21jX+SsRa
 aphjLJ1mBPLjIHhntKgQi5HUPFCcMBy0uJ+5iZjkE8jGFqly34Zx0BggLL0FQ8ewjr75gD/TIc0
 ByzOiPEQfRZ5ztndpff99pcxUZjvssqmGjQD2Guej047T
X-Gm-Gg: AYBFou0a3qRGm3CfCzehldKfrl8vCPw05ScoyGZfZc4rLmj9tKy1eq3DCpwRcacn4E8
 aPJBjhphEk7mGqYwLQC+gJ/Lcq7KJTOy/XdXS+WohiCcYCDKMNEFhltP9hxgdUeM2wuYbXYqcqa
 e96mk/ZOOlJJEyZDmkb+xE28Eh8s2+LFmzYbUxkpYsUBq8ZCpsdWmYuI/ParFXfmR63J2/OoXoa
 l2B8kxwB3EhybALHXldNBTi6R5j3WS4KOiqaSV2HLmgalpLKWis9iScOf+2XOGFsZIcZBvqf6Sq
 sj7iSo00/bkpBFAJ9ITHuGRHf+kwumtOFjxNQz8cAa5bizPZkhn2C2nMUnJhBUmM4C9Uek8EpJ0
 YgEAljN4NA13G9NbxK0V9HMH5Bosfojw+HtbeXw==
X-Received: by 2002:a17:907:7b93:b0:c2e:5efe:f1cb with SMTP id
 a640c23a62f3a-c510e2a83f5mr336925866b.8.1795023728266; Wed, 18 Nov 2026
 09:42:08 -0800 (PST)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 18 Nov 2026 18:42:07 +0100
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAC_iWj+Us8uL0h_4wdaLkY1DaXqPSULuXYoc2f9KYiH1nnX43w@mail.gmail.com>
References: <dacef858-56d7-4708-b784-16b0133bb6aa@gmail.com>
 <608bd6ca-5dec-4f2e-a17a-83bfd3608261@gmail.com>
 <CAC_iWjLXfmSAgd0nSrXi-OzsKq0ZwRRwACmTUcT9uWEBRqcGbw@mail.gmail.com>
 <CAJnxHsgJNP_kMbVT6583uBd7aur2c5s+hSHd8YkOQQj3Jze20w@mail.gmail.com>
 <CAC_iWj+Us8uL0h_4wdaLkY1DaXqPSULuXYoc2f9KYiH1nnX43w@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Wed, 18 Nov 2026 18:42:07 +0100
X-Gm-Features: AclHuK8pZD1iA2VMWwgi9uEG1bdeYZopf1iozYTA9vco6a4dT8s2q_mTjz1na3o
Message-ID: <CAJnxHsjArMLEYraRPgLTdyUpH27_r66xY6KM6VxxtbhvYR7j8g@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] test: lib: add tests for the PE image checks
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Ilias,

On Wed, 18 Nov 2026 at 16:14, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
> what's "No good one". I assume you'll get rid of the custom struct

I meant there is no good reason to open-code it. And yes, the custom
struct goes.

> Not yet, I need to go through the rest of the patches. There's no
> point sending a new version unless we've had time to review the entire
> series.

OK, I'll wait for your review of the rest.

Thanks,
Ana
