Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FECA606A31A
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 09:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=RECd0cE4;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J+/TgaP0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0125B40940;
	Thu, 22 Oct 2026 09:33:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XZM4s0TvGml9; Thu, 22 Oct 2026 09:33:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 513ED40920
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792661612;
	b=CqZoPJoWPLbelpE4+CE0h0CDvuQxdgQJJiCmU/pyhX43Tq88IXZYMu+YkX/OuBHUYBBI
	 1t6IVtpOoh6meKInXLLc8vLZxmTGxucniY/YcvXz4i3VTlkzb8SW3a0f+kLsemZ9cZIoZ
	 TfTzJ9MwJuFAsgtRJXNLSvJ0WNz1/JR9uEPfS3P73099PUsU6fYqFASt6/dWrIV6NaKJS
	 4+ozjOoDOcDtOg+zBvijObtLaeMf50AM6h7hYQA8PuSUeMqb9pZaVekfswPqVjktpshEK
	 VqO1oQ45UeEImjOY3+v2ZKrrYg1S/nNkTBf2/uIGZjM/jxRCo7sBuGRiEd7srEHUAxw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792661612;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=msFl/BfowAmrk9sbsdcuv9YCB85Jci69FylMIt6zhIc=;
	b=BZjDERTh63biQT42I0x/75TKe6HwNVd+DGR0azMBn1czTyrh77HBbVuMK+LhZshv0b61
	 UkCKJOguKnjL3Si+mAslalav4CMJZyEa+Mw/ODeBA8ziljbJJM4B14PalgFuV7ehBLaUh
	 cV9wERujB5/GkoB2pUUA7Fm6nelMIb0aPL+vFyPYkIjzfiggVBt0plS8xzBplf1Jhc0eh
	 d1ta2OHOt+/ixSvkGD6OK2HRdaA7kYjJPYp8DRz7t9e6iFKLDqgCBOsoR89hyLcIpd8Jd
	 qQwKVtmHL4rLgWMchixL2oBV4O+6Aa5S8iQiSI80IH5xXf/lz19lDz+vrQFvDcnp4dg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792661612;
	bh=msFl/BfowAmrk9sbsdcuv9YCB85Jci69FylMIt6zhIc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RECd0cE4826z8qJ46VfRg+5oWAxPhEYcEiU7ETjrsv1TCA5fK0bxA37K4ftkwfl1H
	 VsEl0Y91lSaIY87SWlB9eOqLfvzy8PWuxWHhpaRPGbcKTDx7SJeyPiYQ1NAnDeBprM
	 QDOMzLImAPbLSDfPZV+heBD/u8Bz7QQ5ObWI1A6x4ybZNgg5HKey/N8pTfoogu+LYl
	 0BWyZ8b5PCNam/pXbqpM/o7UKjuN9rhFv/e/lrDsea1vSr1hd0zGRAmvFb5R2FoBgR
	 RWxJhGHZPkdRqv5NNmgvNHy091WQSq9rR7hWwhkPT4pRq/y6ZwWh1WrzSYwCEIVpWC
	 o2DmHrHvaAY4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 513ED40920;
	Thu, 22 Oct 2026 09:33:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B2933A4
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:33:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D32E60846
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:33:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MWZ0HySAQOfn for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 09:33:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B181960823
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792661608;
 b=q9XSOqwrBjZHHPmRgcxlC+vwe2a9lQky+MVx3+YBK99l5CMukkPdpTaaMKTirg+JsqVs
 lfIgDwLH2ZJLPOdB3ee+3n9MnRK/esWNbVU54bEDgnZWhe/n+J92RC5ulYwhHgQ/ioQZU
 eHQ+gi9sBYJ3fl0PqRBrY26UBD3s9qCmVKHMj5X4GAw5xILVDBqa7sgQD/STTgy5eYXDv
 NBs2ldonanmDaLmYGwRj90VQuhEa7+ZU98QL716wLx+Ig6vaZIeaLinqX3er83JiOscjo
 BK2yeIz2cuXDgE2gpqlmCm0gAD7Ql9CpFGfBRby6Sia1htpT0o0/UkbEy+ct/htDv7w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792661608;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=msFl/BfowAmrk9sbsdcuv9YCB85Jci69FylMIt6zhIc=;
 b=LgiVty4J7niEdwU3hppitVOpOLJeQ1Nh7a3eWNzZ5jg0vFp9SrgFbFrHeBsNBK/ze9wK
 dj9J797MkZPzS0H283Kwetz5i159fLHMsijA9hpW+S1vikAEHO7npPpaTWNdy9XQFgAyW
 Q4B5kA5Daam+c/acDZt07G9kzhX3r4xHxRsf5/DCgADk1Kjx266ATOaEv2kteI2tyokPB
 FVOnxTJSNNICAaKkBa9QMbxidyOaWi536FnDHGjHli0azlpcz58y3zSZWfFLRnv+MH3ue
 chvo/YaCxzl0/a12mgWam8ZfQ7SYQ273JPi01ZoduzLPzxfzuu+6ctT7G3aQm2F8kZg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="J+/TgaP0"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com;
 envelope-from=alan.tseng.cs@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=J+/TgaP0
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B181960823
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 09:33:28 +0000 (UTC)
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-8a064fac8cbso1087887b3a.1
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 02:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792661607; x=1793266407;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=msFl/BfowAmrk9sbsdcuv9YCB85Jci69FylMIt6zhIc=;
 b=J+/TgaP0OhPjpTvuQODBd3fG+2+bYqwcdK9RBeGfFMVTgCmmH1yNYsWmn1Z9pth3C+
 f8ANAgCOUO8wH0h01iLZnHuoP/T6JGcmyx/mNMgMYaaxYrU+0sEvJRB/qWmE4sd0hsI+
 cK2TzSjBErXYjLEo4rE6CtRknNHEomN6fnd/rxnIV5zrB02uuicrhV6MfU+OowOvt5HP
 JpZyHnUvpomz7o3QOdk6ytFbQVOR4uiiCFIh6/en6yyoqDmRhYubJVxsp2ijNM8rTK43
 aQeoQFfKOYGRqf08CzkoLAGAiY6V1zoHXHXnSZ+kBm87ivk1gz79OHMpyyv/vDG+Tb5r
 PCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792661607; x=1793266407;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=msFl/BfowAmrk9sbsdcuv9YCB85Jci69FylMIt6zhIc=;
 b=PviFOD+I/m5/Egl05WBi3GE0BEEaSweWISspGop9Coi6aB0jKxDonYTa+hNt4/Dgq9
 d7UsXny18x4Ig3GLrtYuRgJcf9nKk7QQf3t/JEeTpw6+DgvLy1m/hoXQgMGdB9Z6wcB9
 utHB63ibTBKAHFEGjFW+cFFwvs9blDKP/mPw/vGv91kszX8CypyjK0eb9sezdkd0a2Yf
 H0+xXEFwcr3SJ+wZvI3M0INmw9MMU7jmBjaBmgL2NrFS+sP4bCIyW4urczwFF0y8pivQ
 EIj3aa6OYfFnFEBDrSJMyuUSZQE7FFwyfUJ7HB+4aWGJS/HO0/w8jXVYmWPdh8JLQU4G
 0oAw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw3kBicaheIqrbhKH/wguBxvdcAglRPaw10P9GoAeVsj0H1k86iu76dF5E62hEr4ODFivEaWcs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJCZs/Lqzq/SQqAijw+DMVGidev/7/ahWofm/ZpAonXp1wn0Wf3
 TABFZxromEton6JJTLSe7xtVOPohwzKDdu0Yoq20RPrYntDmKt8VN/Kd
X-Gm-Gg: AYBFou1Z2Ml29CqDicQIm8zNlP9u/XB2eCxyYoxYOB3+pit+Ijkank0Mhma9T2RmVIq
 KC/AuvAlP48b/hkxKdlj/4MY0RCg2oStEKO1bJBsqqwcHQaGiZqIC7a1N1PD7hEWcEg7Nk7wbpR
 Xo+/mYAA+KQ9/wJXkdu4SajqkJojxBzpyT9FUPWEnDRMp1/nFLOnqfRYZMDnGECpxfdjD1W1u/c
 DPiUaFPQVk9mrW07L4m3OfL5ndeZloMNj/sIqRVxS6J/SC5QJ5Uzk6/ezxgGKJ2cOt0BOcNdzZ9
 UgZlMh/5ji5FDCVtf9P/bnxp2XAvy74BfagNuN/ortCtqrhQZs+HHh8O4uM2wtf6WOXWemqYfBQ
 0rLEifXEeg32Ayb5IaFSI0NwSfJm1WR2DvRU4ElOBIDeDQPMBrWY6WHwMPT+XEhmJTIDOfQCNN7
 S9eIxo0zrme4bG8yXbusgT+wP9rFUqXHUrmsj6XJAtC34sKOtX39izD3P0+ssWV02xihV1gFlQo
 lCWBn4NVSw+O0QK0PpfgC7Pef/wzm/nR60+4GO9lL1oldpuZ/FtbOaS1pf2QUH3ziLsC87cw+rL
 Et4MwcDDiOhIkRI/qtG/5jqG15z5i17fnTw5Zdvr1hUICByAK2E8xBrmpKoXsk+fGl8ulXU9F/W
 tZkgNt9yHJYnPRO8WCfm5uppC49AFrJmEUgQ=
X-Received: by 2002:a05:6a00:4213:b0:893:8a6:3801 with SMTP id
 d2e1a72fcca58-8a089e4f8d3mr3613506b3a.24.1792661607448; 
 Thu, 22 Oct 2026 02:33:27 -0700 (PDT)
Received: from alanhc-14700.tailb22ec2.ts.net
 (180-177-138-120.dynamic.kbronet.com.tw. [180.177.138.120])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a0895e6b14sm1925645b3a.43.2026.10.22.02.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 02:33:27 -0700 (PDT)
From: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
To: Leo Liang <leo.liang@sifive.com>,
	Bin Meng <bmeng.cn@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/4] riscv: qemu: Boot a kernel passed with -kernel
Date: Thu, 22 Oct 2026 17:33:22 +0800
Message-ID: <20261022093322.3412117-1-alan.tseng.cs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014144724.1763675-1-alan.tseng.cs@gmail.com>
References: <20261014144724.1763675-1-alan.tseng.cs@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Leo, Bin,

Gentle ping on this series. It still applies cleanly to the current
main. Please let me know if anything should change.

Thanks,
Hung-Chun
