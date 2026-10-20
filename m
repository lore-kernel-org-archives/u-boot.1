Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83373606A31A
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 17:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=eS5cXs5y;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=M1Bo4Dcf
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B7506075D;
	Tue, 20 Oct 2026 17:59:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 112uFnLq5e7p; Tue, 20 Oct 2026 17:59:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C96F6607EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792519196;
	b=IKmVRNK98V3YPvleEETt1TR5lDCZzMJY05J4dqhCzs0HgmxK3hU/oik/fJIHk6kjPNDg
	 QwW5EV0Hwr42di4/3GsaLi93K9efvTeEZTJ8f77KD/PeG6B4x86BE1aqO+8RTPdOz2CSg
	 AefvkbF4IhOrrhP6AZ/IPcu87jbhKJti5PiSMkjny7WMM9kP2eowUZyjrzstvc4sp9Mtg
	 DiP2x7s85aNJN30URqXdJKQmjgOChYB0jHuP/PkHDFernNigl/WiV/GopWDz8ejDc/oS1
	 V6bOjCGiWQf0qliyOuBNnAOHLBBdfFF0tMs5Mxu8ShlkIsWCSBemDUlXP7DVVKtOh8w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792519196;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JX2D15btbNEZX9DQrxG9ni/gbn4VnHKUDz5kBTkhfg0=;
	b=D1I5WsBxHALvQ0wxAftgPOitIw4aJvVQY5mqkaJq8fKf0H2dqSzChwF1n+He+ou2PBcK
	 qx6lEz6NpMJbN0ncWx3R7Sgs0Cmm9oHemZ0rQNvrS6fxvw7+r5tcjaxFyWiSG5FOyj5jc
	 ttLwbca8ElnRlkocwUcqc15ZMWvkbAJM1d0kVInZpGZwWrnKobNg+X+xi6d4fP/Qxy6lR
	 4ErW3oSY2ohvHBXGVlpgk78Csc+BgNQGCC5rgJyPeB2s+CmAK+QvWOD6rbR61gs0WHnrj
	 o7/9d6DecR6sqKC3nGMMBvOF5lSBBMwX2AwpdjoI3XX6sWZFAn6TA8X8pLB+Wet1CWA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792519196;
	bh=JX2D15btbNEZX9DQrxG9ni/gbn4VnHKUDz5kBTkhfg0=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eS5cXs5yoLiThvLP8j0RsZaUVK2ly0Yv7QS/XE5CQPfeWfQ9Z8JoF6LKch5LOxD0K
	 qwZsWDIYpWDaD1EhIaZMoI72urmbZ7pQtgQMWu3+wWv0Vdm2Pi/zt0v7i8llhcXmit
	 LNFtra4zQfvNpjSo3iQR/OKITBrgzqpq/2wdp0kjg7rxOiZJNdeWbaBQaaYBsKXnoE
	 55EkJQymseyUoKkE4mRS648bk9VbQoVLzto7Cq4tavKQYGu5DQ+08f/yBCMvbEx7Ml
	 f3h5BRwtiYfuNNN3IPe4KRdJlObSU03icKxyKBhccimSVxn6ORXssoJPDF8jrE1l26
	 +SvrDN5Ko1cXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C96F6607EB;
	Tue, 20 Oct 2026 17:59:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id ECD4B1AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:59:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DD56140761
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:59:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JdhHItlBErLX for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 17:59:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E0A55407FC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792519190;
 b=o86w1MLW/rTHPEGpCqwmTevNgE0BVBXhYfgNsMUJKYqQYkjqcnXFbUBAD6Iu6zwfJxkP
 GpFV6j7Qz+uO2kd1QzefTT5/Y0BYJ5AN8/lXjT77Kj7PnJddCKtDgsl3kbkeWmauIbnIh
 WWpkfSrLwlHdb0jjtnuyG6tnCZmW1TiV7+4fY5DYtXu7UFBaH97p30W+idLnoKRbm9HDe
 1vb2l/LPJF+XQqnf/yvrsVT0KaZp0fWqgFKqNnWRvZVZcu4lxqfG9W+RG+MYZnguBnAbZ
 GSgn/1KuI5mRf2TWKu0876BS52AtnXyZT0eVEb7AzrZUpC1pRuZOMtjvqoYmxJg1wDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792519190;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=JX2D15btbNEZX9DQrxG9ni/gbn4VnHKUDz5kBTkhfg0=;
 b=GI4iZyEpcTAAjCwmpMlpn9oqgMUvVNzaB1qxJ4qjZGmyP7eSaMlCRxnjZsjnUQitdLv2
 ANryYohOUJku/KZ3l+ZqTj37qPLSJ6FO5km312lY2RRKUDE1NsU90kyPeGDSov5QVuGwk
 Zcd8E1fspn3SrsXdR6YRdvel9SVrH+VU/AP6xarsaRlEhVSDLNIb3b7+n2yHPCMItYDfn
 DQBwonnAfZPmcyT9fkXDmahKJRx/FZwvSJ7ZAHb6XarJK8vK8jmNvElE4+Au0+S5yEUWS
 mpyMwz7F59ZileQxVrnw8AZHt6GyvTRJ5ePlLr2KenR39BR7bzyBGz/Ci8zdtpm4Ydg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=M1Bo4Dcf; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=M1Bo4Dcf
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E0A55407FC
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 17:59:49 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6b170129413so5726492a12.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 10:59:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792519187; cv=none;
 d=google.com; s=arc-20260327;
 b=OawQJOXOY/7nQmAxhRajTBIV6wMyugWz3U9Y735H92RPcLXoFM1ALDz4f1AqXh9Y8u
 pb/8vVuSGFWViUfoAMKCeghcSw5cy177dF0Mqe1eMlednYim8XoucJctZtc9L00hKHN3
 F1EDLT8LsjyXivRKc7pWpQueQtHpccdB5r5AiRxELTjSeRCF7yYF87MKzktwtLY1sgYn
 AkSY1lAHXN6Hp/rH/9neHOWsepNMi0vhj48TsVRx5ePefz/ltl59eOJo0NXwKdtcZ1cH
 YsG7t3dC+bOJ0YnvaGuQ66AaUfM3tr+1+V/g43bSvpbycaYG6ITXzElzcwEZJKh6NmqP
 AoFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=JX2D15btbNEZX9DQrxG9ni/gbn4VnHKUDz5kBTkhfg0=;
 fh=Z98iJJAqvw5Wc/tQkeniw6jCkpkg7czAKKTnRfLDd34=;
 b=sEsEobuKH8+7hJaCNoUhqIAcGX1OhZI52kRs1Vts0bxcULCKjehUwtC+EXzZDfldcE
 5KNfprbKoOb0N5gI8zVLR98mtW9GwWE3vlNFSDXCHPaKyE8VlteR88UartRv5OThStX5
 OHt+hvbvy+KpQMaa1G+7jIZpqdnegSbUc2O7coAXbAA2UVNgpjbwOcI43OE7+wWvqLUM
 ou++W3bNtO2FbUdgSmwUYFilgtA8gFEBLAxfXImbjoPuXX1XmjK5bhqj+MNusJAzfVsD
 7NYUVXd0SSUXI3bzJFPFwUzDppZJZKQTqTd/Ig75FschkefR8OQKVT8xWEcPb2Bamn8Z
 iZbg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792519187; x=1793123987;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JX2D15btbNEZX9DQrxG9ni/gbn4VnHKUDz5kBTkhfg0=;
 b=M1Bo4DcfEAA3V7g5rqAMrPzuH3At5viQ5wl5/L0uqzd7SpMaaktKz1GoVUMyiVqZK+
 ZEOEVPVVGjx0gRiSe0Pjc8MTde+HJhgU+9eGcYKzG8xcdTQZZvNnz+DISXBzLFLSAf4M
 spi/vEiYo0QQ5uXklOqTRZpoUfdLKkWW18wQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792519187; x=1793123987;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JX2D15btbNEZX9DQrxG9ni/gbn4VnHKUDz5kBTkhfg0=;
 b=vUDTg+mYRDCHZ3WQfeWffbbEMv9aF8b9dptkWaFvU5KYnZDuu03s08Q/IdtSpVN3/y
 M8dx51DHt8XM5InU0UGdlTzjX125qGEhSTjbLZhd6/Cvv0BV/FfIkwYZ/IsajW8AA77l
 bzu41fLoyvchAJIVUkr92vXJP3/q3bcZQTMrBlXp24o3k/Pv/qOkwoS6J2sh2nsqvukf
 kqvAitiCJoyYFpgmrKie1mDhz8+7UKpf2bP+37IlTGOuDLa1+WD64+3EW/s6aOGjoWrK
 lfK49dyK7+6KEFyo1q8tjdZEj9Zoo7K/DLygljeahMmce0IBbfwmHm9JjOCvj0lKNwQm
 rviw==
X-Gm-Message-State: AFq9FYLu2KJmdb/nqDItbtLXTtRR1j5Nd1nS1NJ1MuDnMLmz+2nT5S+N
 fQ+Yr9Z0ZfRGzdNWAMKpMqkYlTzotomJyRb5zgS19aHKJs18l9HD9yEY0pfR74PJHRLDeCNtQBW
 fvEs+ykU6Y0fJ8dBMn2xbGpYmsE1AOeyeRW7NW+8C
X-Gm-Gg: AYBFou1taSV7OoR710/N9bJ4I+OyE8J9D6gRj2T4EYKOOcP/5BFCD3csfCiHyX0VlGH
 OV5tC9Ptla7Zg3K2Rm6Mf+SK5Ey5ZvPu+kupOJV1+MCq5wWbV2k9xcAtVgjE4gvo6CZON3NV059
 zcFugs4s914lyzYFe7Uw8RUT8nYe3Y6UH4rlucCao6wHFkohw+nPAKoctF3vaL4jb4Etz1cU/Z0
 3dSFQkoY6FDgjGq4XXdN5Efg0RH8w1deLXcHsHYhIlNGJgIyQ5E4PACscEP6kCO34rhooxU3yAZ
 67cXqa219PfewCk3XS2TDD5Vz5bsRl+ZN3603rpurzl6BCiuSOsWxg==
X-Received: by 2002:a05:6402:5106:b0:6b3:b3f9:c418 with SMTP id
 4fb4d7f45d1cf-6b3b3f9c45fmr7587751a12.12.1792519185625; Tue, 20 Oct 2026
 10:59:45 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 17:59:42 +0000
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 09:18:15 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261016072640.772964-2-jan.kehren@emteria.com>
References: <20261016072640.772964-1-jan.kehren@emteria.com>
 <20261016072640.772964-2-jan.kehren@emteria.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Oct 2026 17:59:42 +0000
X-Gm-Features: AclHuK8lqdZOAOnkzeQUmpxzo9XrXCcos-un0U7iKICedYeKjKHCphRuSA0Htd4
Message-ID: <CAFLszTjJnbO8mmgovbsfU-x5ZmvkdkJUcSS9X-RU2T-xgRw0XA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] avb: Drop the mmc naming from the block IO helpers
To: jan.kehren@emteria.com
Cc: u-boot@lists.u-boot-project.org, mkorpershoek@kernel.org, 
 igor.opaniuk@oss.qualcomm.com, glaroque@baylibre.com, sjg@chromium.org, 
 trini@konsulko.com
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-16T07:26:37, Jan Kehren <jan.kehren@emteria.com> wrote:
> avb: Drop the mmc naming from the block IO helpers
>
> The AVB IO helpers and struct mmc_part only ever touched struct blk_desc:
> nothing in them is mmc-specific. The names say otherwise, which makes the
> mmc assumption in AVB look wider than it is.
>
> Rename them after what they do, in the AVB namespace rather than the block
> layer's: avb_blk_read_and_flush(), avb_blk_write(), avb_blk_byte_io(),
> struct avb_blk_part and enum avb_io_type with AVB_IO_READ/AVB_IO_WRITE.
> The block descriptor field loses its mmc_ prefix for the same reason.
>
> No functional change.
>
> Signed-off-by: Jan Kehren <jan.kehren@emteria.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
> Reviewed-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
>
>  common/avb_verify.c  | 106 +++++++++++++++++++++++++--------------------------
>  include/avb_verify.h |  12 +++---
>  2 files changed, 59 insertions(+), 59 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
