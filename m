Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E088606A321
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hvGmZAYM;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=CZ7tywaB
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 354D6606F2;
	Mon, 19 Oct 2026 19:57:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NoYQqGwm2yYB; Mon, 19 Oct 2026 19:57:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 51F8260615
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792439820;
	b=KD5QJHWqcxDjpmVZnzBxr/9F05c5YyYPb/R7Td5DQN02ieLbWr+oLgFTXsPYQVGZZwmP
	 cJUtTxrpqGoCpckUjf7oSPfdMPPXP73mGfN1VWGfXp0SEtD+PuUb5ZJKc0bZPPC1ANvKB
	 KuVNSPkm2MzfvMU/9lGPgL6pl2R53FGcIIFpfgpp/x9TARldcFrmlwnvHJBZut8P6JySM
	 MK2QqvxHilvrZGon3ffikDx6UfdfXaEFSmKXNVxnXYlfSCDLnVYHolPqH/uUqnpVrHOVZ
	 lJ+8iPfMZN39PppjcukShIJeYQwRE0vQnw+zFT2b2S7JcRaM6TzHEi5A6DObAZ12tXg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792439820;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dH9c+Ow+ZRA2sdeElPE0VKIhKa4zDQWBgi3xL64VYCs=;
	b=m5/mpbDRrgQmWTOY7Sf0BhzVBST4uOtP0U/okr5hLcj4FjQWYleXXxEev2zexFcxjK93
	 BrTqhSnVTRQfUb4kKHdWbF4s9/HvHg61l7moa3qA0C6tllTz604er68O6byjD3pUdianp
	 pAnSAjDm83P7UW/AEPucd0dsdlgy+8rL0bgdMuEgD5DtaEdbKnVNXbKE4ZFKasQfWA6/z
	 tR4s516akhx51o+NwSF57vREMNb8kS1fPD+c0/CnRyqBB3iwZHCnU80wRfPAtqBRdfKuq
	 gNlD5Jt3G4nQfRqWmzmRImpDOr0uC5Ztvqa5/cfD0WoRM9vf6Xagqi5pPtZSMg9egBw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792439820;
	bh=dH9c+Ow+ZRA2sdeElPE0VKIhKa4zDQWBgi3xL64VYCs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hvGmZAYMM2eoMaT3e9BVPF25/U5IGnzzLRyiUwSpBVverCxcA2uLvItw7NYqdofKe
	 ywSDyre6Uo+/Mv714rbWi03XBEYtPJ2RNESVkGacE9Gg+peaFuVLczvHPWyBpJzSXz
	 ipm1mQ7thkPczhINAg1Doe6fsLuH+22hzgfDh/VOmlfU5YUF753yfD8uerFNFMdYxF
	 iGqtPftdQNGWDaVwRgVAQaoOpDJ4psmDB+5KRm76e5zRsgS9qpsioL2V1tglEv9XVQ
	 MlD/ca3VvgscCFxFUC7JRO+qV9qsxHZn18S1ewfxPgFnzOFW34qU3JuHbePnOL/kyo
	 MIGPmgfLzEY0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51F8260615;
	Mon, 19 Oct 2026 19:57:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B62FE1DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 19:56:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9BC9240189
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 19:56:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4RWLjcJsHiXL for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 19:56:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A8D994008C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::3"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792439817;
 b=Z/enmpm3tLC8uzfsJMoKmtqoKLXKJId+STRda0EMgWSYQW62Qg4MqMmWjD0OG2okWTSx
 bpef9RpGyaUOGkH5C/BuXrhCva7hCIAVn69VQ0nwAB2trqT64O54PB891icmQoTvyMBGH
 Lo1JnkdJt1PkY6VWXmW6U/Yy+HfQM6gN8s9MCYB4P/Gkx4Aug5E+bUGoj4Erd0x8zFqtC
 JScM/ZY/23P9wUOtjo6yheay7Nd/WOSttLBeKPklj7CWQzQFOLG75zeMLaXAg+QqvuULB
 R8OJg34upZbYDn18upUy9yFGBclZaiOTRPDyNpJDEAmQlZNVpFF5RsQSPH+ehXFcwfg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792439817;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=dH9c+Ow+ZRA2sdeElPE0VKIhKa4zDQWBgi3xL64VYCs=;
 b=aNtOrY6KFbjwTV85sKzOwUlx0BghkqUdyrVB25O6h9gA5Da0Rqbo9TmcOEbvIDgcTz4u
 a8vM7f1SHH1i+5QflAoje8ewGqhVhJeVZtD4UxXG7OtIqAn93IvCnV+BWq5iQrzhYe5h4
 mSQ9AARjRumqgIuVveBSZQxtgruPve9jZqNjCQxwGOhgfhUIeuFZnMRf4HHoIWF0OzRMZ
 /sKnX0yuVuxK3zXcJ8wZflaJE/PV/14pVwpoPn933yRAF3DkE7aBQNfjjgHYe1GeXkCNZ
 oXJmvhQ8jjzEAbQQeuM17NtBq1CU/QW7toh95DcSoF/g6HxFRpzIHXhK9G7oe3/wUaw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=CZ7tywaB; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::3"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::3;
 helo=mail-oi2-x03.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=CZ7tywaB
Received: from mail-oi2-x03.google.com (mail-oi2-x03.google.com
 [IPv6:2607:f8b0:4864:32::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A8D994008C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 19:56:57 +0000 (UTC)
Received: by mail-oi2-x03.google.com with SMTP id
 5614622812f47-5413fa881a9so963974b6e.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 12:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792439816; x=1793044616;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dH9c+Ow+ZRA2sdeElPE0VKIhKa4zDQWBgi3xL64VYCs=;
 b=CZ7tywaBUJdrQJel5rRRHVJJWkphiV1frjUgzMJI9hSNT2aJbYmyz6+tii2RfvshAs
 2fQs/8dit53n1CzuPS9L7shvBKI0vmhYQwMReYXBLN+CJEpUO8cPGNxgbxo9umug80ue
 y3al1OfErTNFdyDwBNx+hbUiaRDXujJXl95js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792439816; x=1793044616;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dH9c+Ow+ZRA2sdeElPE0VKIhKa4zDQWBgi3xL64VYCs=;
 b=V4NjpNUnQQcHf/Cfj1eIeiqAoQPOmiPnGGDF+T+MnkUSRSka3fLhGscG2Jauf6IPXi
 4qb918OaMGUYn7L4iTeSDLPFZQOXnelEdyXHNp1mKXRC6w7CiHaBbA4mBLqsvcS7P32c
 4dGJKCq9dOCzRhf35+N/9mfZ4n2gj8LKlo5vi7u2kV+V+A+j/Q/m6oP8dqUgL1Og6bKu
 IaPqC0Q1QYZ9nZ0piR3G7TZoS6RrWjqWY8bE6mzz8Zf0moPPe3zkbG1ry/gUu63vlLYu
 O0SAH2lluDHhoxa98BsMQO9cRfiBzyA4eSloU+iWfQfFE4Uws0L4HVZS/fJ7GQ9Aetit
 etng==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFp168Ui27Ufp0TdYytpYGZ1MqBS15TfhWjy5S6++p/GQtSa4zAScWs4Vc0DAjHEWSAVD1Ct0=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLbawizXZ8D5EXCyz3l+huko7GFmJ1Hbc1CM0qMqDQh7cUWdwpk
 twFy8EVwDlRFfr7rXMo+XBs1q9cVbIoBiyFwHfMhl6se8P07xtwjax06hm23RLYiGV0=
X-Gm-Gg: AYBFou3a6qQcEfqtwwish/DOubv6m4AX17Du43NKS91mh8kMTD4AFjKXzVppldbW+Pk
 kFIYGfqTiQT+44gEqjrFYiWv70QdHc2DfuR7rx/qelzJR0XFofd9wmFPKT317hwAVTHNP8n3QQn
 IUt9vp184CHZdSAr0psl7wJptO0LiO1ExKtREOiRNNX3BekWB00mQC8eO3WDneCx7qlKXUXJpJw
 LZM1QD4BQDt451rS2r8mTAeERlE4OODYN4h78Qqxx1tolPQ8X0y9TU6pxGM84d5w41pi7+z8YnC
 6dJUV65KYd9C96A34jfVgrY2fPakgOoiybJJY00CG3u7vJGVmX+EI072r08vjtnGPdNMuNDyqQp
 +fbiKWBnNWeEzmpoU/+8Pjb7jgAipmQPjbhvmOvLQckd/HV8s8R3fi7Ael+MOliC1ndD/noxlS7
 xcOblu00mnQvHo2mlCw0m9T0yv/EqHwKomWaFlKvlF1Mv6uYbqxG0oVLBzcCh9gavxSe3wzEbx7
 HENvupHF32w2tvdB6Y2TY1kpoXdgaAUzc+uw1eq2WWRxhSQgy4Zq9l9SLRxp1oedP7YpZq8rpYM
 UQJWUr9K/m0UgbiK3A==
X-Received: by 2002:a05:6808:6546:10b0:549:ef3a:e43c with SMTP id
 5614622812f47-549ef3b2585mr1590953b6e.64.1792439816168; 
 Mon, 19 Oct 2026 12:56:56 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-5388dd87607sm8312006b6e.13.2026.10.19.12.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 12:56:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Carlo Caione <ccaione@baylibre.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Pengpeng Hou <hppiscas@163.com>, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <0d55ba77-176c-4e19-ba12-1b5730275f5c@gmx.de>
References: <0d55ba77-176c-4e19-ba12-1b5730275f5c@gmx.de>
Subject: Re: Pull request efi-2027-01-rc1-2
Message-Id: <179243981476.755361.17937162537471894437.b4-ty@konsulko.com>
Date: Mon, 19 Oct 2026 13:56:54 -0600
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 19:00:37 +0200, Heinrich Schuchardt wrote:

> The following changes since commit 8d534cec0cc0109a37c0ded8854da03f1526dc0e:
> 
>    Merge tag 'xilinx-for-v2027.01-rc1-v2' of
> https://git.u-boot-project.org/u-boot/custodians/u-boot-amd (2026-10-16
> 08:42:42 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


