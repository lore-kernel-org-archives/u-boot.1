Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15896606A31B
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 01:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BaUL4/b0;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=gednnOph
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 107E04083F;
	Tue, 20 Oct 2026 01:07:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A-AzLffR1txt; Tue, 20 Oct 2026 01:07:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org ABBFC4082E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792458422;
	b=VJEwK6Zut2rYX5EtNzW1/mp3EbILr0VW9YS6JVtegWetKllT58cPCaH6C5LduaSuG0Fn
	 tLp5DUhvxyAMiEJWaiTEqSByLx6heu8zlpN8vHbvmxgo1jpYDw9BNXH48eHV4tbNhcoBC
	 gkQTL71GmEvQ1OUWw9U8OBe85xoQRH7KzWsu4DHDc8ZnGNFmU0JQcVjeY3B4eLE6WXCkc
	 bR7TlQBexsbnKEH3GXKAj+L2ZMGDdHf5iX2dJWxyWDrpL6eSd5hTXnfGYg1vs8VFL5yuR
	 dZFcQUZ5lLKPMURqq+9WoNsWPVonKNqyc6ueecJXQtT9CpZi5FZwN8LyKQ+85kaKnuQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792458422;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=UMklVo86ZcH4E7rsk+S/T9aKdWE8lxLoeS0f52uX/BA=;
	b=g4elQe3uzUGWgvzhF8XEgwxTk4xxkWuzlonjQ2ipMNLH5PQ4IwvXO6iD3Pp0pXxcBCRc
	 KOtMmCbZMuVoBy9tv6fb6xhXRKmba/ptXv/mAoL0eIBPPlPuc5KS1SEEHzvgb4+SgBQre
	 hzqc3/d8jYVnoykHoH1qZmrSENvLcM46ABduWeH30YS53GaEa7Y4Pe9Q93R8+0CbBpufh
	 wVB/XPoarwpXj/wxveDj2qptVOA78QmfpN9SAnA42MG7FMKp6DJWEtl6S0B0MbyDOA1F3
	 g5PsLd+FRbsLtpZk7pePO5T1hRrtQ3DRiAgNbWglIWfsAOr5hOIvc95tin9tKILIAPQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=gednnOph;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792458422;
	bh=UMklVo86ZcH4E7rsk+S/T9aKdWE8lxLoeS0f52uX/BA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BaUL4/b0w7wXHh7fIa6j+nAp6YQPhrLyMqKblyxgNv0LgG6ZGYjZwZy7j69rFLxZP
	 CrIbQ6VQ/rQP2RlztLSHH7DbJfNmzzYwi6SgAG66WPctN0UQMDJWn5kClHXBOxCxeG
	 0LfhcekZSLcq3sRHQkUmt/bbpVAIMmXB9CpILonwWbwKvsW1smpdbEO8nsf4Pxq0Tf
	 7HZLBDdm/lNmgtquCrfSE1jKJhJu3YcN7hhDGXIw9h+uhL4q5CHFg3YVQlK06RF5XH
	 BJmXVKLoe16WmRIO70GAWx4EI7iMP3hb6TdkR9/C/ANfVZGPL7xsfVPiZTAxjc6rUm
	 86TyR8gXFI8rQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id ABBFC4082E;
	Tue, 20 Oct 2026 01:07:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5686923A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:06:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 320A540811
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:06:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PJdds8P8ziGX for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 01:06:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6142A40805
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792458416;
 b=c+qWdYRU70H90KCsCtbl4d7Dzx/8TlQrcEWbTAJTsN+d8k7lSeyZyCZmWu5OFVH7MxKw
 IhQfXrHmfaIFZ8jP9hjZp0mVQueYHE2+INUpbgIZeT2HGqOVlKthbcRImZfJO+rWcMJmA
 40duxCokEGjZ8L7Bjr5mOuDf2Jm97G6df4cBYLBshMtTLfXlJgBXO9luMl5C9pB5MZChq
 844PWgQ6P8kY3+g9+4kRkuyAwiykwgpwnQxuQnmIoEiiYXv2H+Ghp8xWo1C2TqAfFLu4g
 6+cR3X9GorOEGLL/3mJAVerex/lOx6c0nAs7qAuzF3QdAwiQmGm2J5YQdUctdVleh5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792458416;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=UMklVo86ZcH4E7rsk+S/T9aKdWE8lxLoeS0f52uX/BA=;
 b=QSTAylo8kYjmoTRuDi3JGPQsfPgU1mWyvwMFXd6KrefXB+SqvbGREYKYt74oZGq7ZXoR
 y8sBIRbnC/LvpisrKb2mSdxH7HIXOS1e/XaMZGXMHoBhxDvuID3N9/JCta8viq0nd0AE7
 tOrvQsk3CuHF5s6R5ynoOWPj8NRFcOKDIabzHocZqYZnguZtCzRDKps/ft846b8LdMZXB
 7FhGew8svemyJT0VLd2VuR0RLqRRal6vjOjSmbP7TPEX+JhZso8L8P6mrd6hmI3GGjC0w
 HDPhLof9xV7JMZopwnLcKDNhLfKQKoH+gU4nA5tHjuox3UMCrAdTnr0LS28vb6V3LwQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=gednnOph; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::331; helo=mail-ot1-x331.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=gednnOph
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6142A40805
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:06:55 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7f84a55cc06so1359193a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 18:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792458415; x=1793063215;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UMklVo86ZcH4E7rsk+S/T9aKdWE8lxLoeS0f52uX/BA=;
 b=gednnOphCmnGQAVTV45KEKdteagh3Ciw/W43uhg974gSj8K+ssisfZMDSdmMWRw/gh
 71eUbBC69yfJvkiginXalHWQh7ZJuPbWHUxP4kdK2nHJmdB7GerMb8kryUY+uOPfMpuQ
 DVzN3G7wi98ZgTma3W+PF+cQBABzrHSv1Jc/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792458415; x=1793063215;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UMklVo86ZcH4E7rsk+S/T9aKdWE8lxLoeS0f52uX/BA=;
 b=WEKivDaxJ519J8hocMdEFeoCVzllTuVIC2tSs95V0Ae25owBkW+slcHxfsnFRWqBRq
 rTocnLQX6p+N+cSzNPEGrRDi8ks0XUlbHQ6RLGV3Z9UY3kD+E4HbW7RkleK5SaG/KEha
 F3JGhwAGxSa+APVrllztA4kOyqwXPYWcL1Jcd+UnX/mr30p96rprL/H9sJ51gvQM4jnk
 pC1JdTA7bc07OVaqmlNWv2tb1tKDdCu6SGtq6ME2N85n2A5jmQhv2/TjHXV92DlRw0d4
 UcgqiRFGqelUIIqicUjEzXR95zUyiUIKborOx6uoTmn22pky9gDpKxsknEbPVwxKDojw
 zIow==
X-Gm-Message-State: AFq9FYJJdXjcV6VtHHk4yJzdRsPEYlFqEs9NcwFesTCMwD1HO6lXRx4c
 tyfkeiqai6Lh5vf5R7x9W1e7cMnOwG/tVD9bAxSj6ZcF4ujiLb6SnN5PdNkjQNpv3WDK2RXELtR
 M7hV1fJpEknnt
X-Gm-Gg: AYBFou1U9bQE3uEp/82ei4FhQZHN8fNZUk+Nv2bYAliQusbBjCYoM1yORT3ihTTcSAH
 5TpayNz7BTWT5TO+Ofz1RKhEmTTcQF5dDgELPukXiEkByOdipitmWqoRxKlDoGiRyhagbUxuYcl
 46CJjBaz/WvIXiJ9U2jg2vAjQbH3PD943b2c2XpQxFdzumWVi5rnC7PyDvnhNiM1NDkLKgU5yGC
 oKcg5yPkgVqnWxpviiPOF0MDRimqhp5+JKKEy+IaTi/yn4Rw5iGYtNuQYSYyziLULc/Ms82yYEG
 50K8RILcLUGcym5UPCO93SMYmtz8qmZ/bWfYLmphm/1HZSrI2fGZCcPBvU9IyfGWBgxfl8IK4yR
 bDtGBv2c9mnQNrWLDg8h9HZUVNjNRrz/FXPLlAZoS7Pwr7wR81z0zxg+/+wcE6M9VpHJzg0TQ54
 7eeHbYFTQSzOGpcuUzuf9NTqV1N38u4zRExn748Jg236pOkuKMUyTLrKimxRzouOgOB2gn6NKSk
 tQeIQu0K1Z2XAM4wrLv3KJke8sIxA6F8PcxoISJQsqkPKgXnVKN7Rp9pp+POR/uVFhahEl/Z7gQ
 ZoHV045nnPiDtUj+vw==
X-Received: by 2002:a05:6830:6413:b0:83c:1efb:6424 with SMTP id
 46e09a7af769-844f8cf84dcmr8575905a34.1.1792458413943; 
 Mon, 19 Oct 2026 18:06:53 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-845b9e280dbsm7868871a34.19.2026.10.19.18.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 18:06:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, bslette <bslettela@gmail.com>
Cc: nm@ti.com, robertcnelson@gmail.com
In-Reply-To: <20261003054432.1027871-1-bslettela@gmail.com>
References: <20261003054432.1027871-1-bslettela@gmail.com>
Subject: Re: [PATCH] configs: j721e_beagleboneai64_r5: enable K3_QOS
Message-Id: <179245841267.885845.5058350767185667098.b4-ty@konsulko.com>
Date: Mon, 19 Oct 2026 19:06:52 -0600
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

On Sat, 03 Oct 2026 00:44:18 -0500, bslette wrote:

> The J721E QoS table (arch/arm/mach-k3/r5/j721e/j721e_qos_uboot.c)
> gives the DSS read channels order-ID 15, but CONFIG_K3_QOS defaults
> to y only for AM62A, and unlike j721e_evm_r5_defconfig the BeagleBone
> AI-64 R5 defconfig does not enable it. The DSS QoS registers are left
> at 0, so the display competes with VPAC/C7x traffic at the same
> priority and underflows under vision load.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] configs: j721e_beagleboneai64_r5: enable K3_QOS
      commit: 6a9b4ec892ae7e6362f09f0d64dba08cd2c68dd0
-- 
Tom


