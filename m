Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA24B606A31E
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 13:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MGtvpAi0;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KZRo9tV0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7BC1E81815;
	Sat, 24 Oct 2026 13:03:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bc_5kjABwCQ3; Sat, 24 Oct 2026 13:03:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 634D9817FF
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792847029;
	b=V4kWXtdONS1iN/XZklScL72c8uc811W1UzOwsCHd9deS1IQiPE69GzDoKVXt0STIU+R+
	 pMsN7uftXVbp7f/K/tkTNb6eSPaQfuR/mLvqHpArXJSohjeq5laBXpayiyopjzOmT/cG0
	 C9eDUVoBknmArrggEh+k1iTJKc+71s8gvu1qf99PboHFfz4QG959NhYrUjwOCwd7Ao9Vw
	 UQHAU9ivhzLRIPX61QBggehaFszh8K5qttAWP7hZ1L/J7ea6lhRqolt3oV8gwOWEA9Ovg
	 zSJU3tMNO6lST4HYAHayh1ockBZ6Z+Jhef6m8Hwmgc6XCCGCosvAoVdq0WRzOZRvj8g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792847029;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IeZi7dCiPAyTodBZ1XWrFtX6V8mUptc9mMSNBg84910=;
	b=PC2uF7TQP7GcJG1umkJ9du16wZ9HmRwpSCR3wUDqPAJF3yBSi/+6akwaxLvxuJfGNE2j
	 LhklZf4130eCOwjS5Rv447g78rcpSx1+nUejSa4RmVru3SxlGFQ+uYV9NfEI2V3UV7NTm
	 RlZE3tCtYagYlC+D9hHBoG069dEobJtiFuPqTkUUj3h3wxUEyGjOpU6z/gv3k3S8yyqBT
	 wTDFlLWJFeZKVTZVgsIxmulCgfiE8D4cHQND2p7XBN7ChfciYdXRIqyVY1FgapM9Hdu+H
	 aMKd4SztdgiIVwBAnSlBnHVcEFZJKIUmthHz7U5ZpQt491nj6HKUT4l2YVdl5cz/jZg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792847029;
	bh=IeZi7dCiPAyTodBZ1XWrFtX6V8mUptc9mMSNBg84910=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MGtvpAi0TCsVct5qRR1AGc8ujOX+uADEWBWgk2XvIyHlEgVJbkwIxsuhpG3TJJPqM
	 pGCQOdWqvWlUthtHxAytC7lV1hmmKmBSr0u8bbbLi9j0uIg7O3c2cVQ9vBXWg6Pylm
	 PauPvQAbaBtzJG3fjPk78tJnTATwxHMFVPPrAYcK0lwYzqM6c9uBWDd5vMvIaAK1Kc
	 CqRxu6zlF7Kh58Omz4lcERiM1YgusN0BMU8W9TKdG5ePez7Zw2Y7SlE2Cwf1lqUE46
	 8ZAJJnigc004HbYn2eJUem5f2sYiNnMhwbDR1beOMjm7ytcwRi1N1wMvfd5fUJiNau
	 WcZagaVLEGufg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 634D9817FF;
	Sat, 24 Oct 2026 13:03:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 766BF235
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5CF69400AF
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yIMeLbQ2QT75 for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 07:00:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 614F240068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792825236;
 b=F8TSUHCkCZNZ1IUNIECXrTR6tf7Ki6VTopmIJRAmqMmg5APYKK8nhtoWFX4rTVTTZ9OQ
 RvU/WeSI5hp5nqErfuzNJDzduUWADB50FBpPg/5pYSdU6PWh84dREZfBfOWVRqhd6LRkN
 ejYhf+D8vqJuBIQjbozU1brvO0YJrTJ+8lzCaekpkd+0U9uSfVGE4ZFF/6WhmICkCJrZg
 U6KtDd/FW4KYLgfiqrm5iiGNYM7VjIuJhf7rU/VlukVJ8amXri3ow5QpZeJWcPS7zkbcF
 ZskI9e/mkjqTO/cLW/9g603Gt/Up14gjk0x3leWuWp17O2EJfXv3mMZKGeA/uhAM3Qg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792825236;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=IeZi7dCiPAyTodBZ1XWrFtX6V8mUptc9mMSNBg84910=;
 b=QER+HuRMj4WS/A/sRdMaf8ToHvYxnYoT3RIODgmKjujXHcmSMO6VCcNj7wgnjPqA8fdO
 UwcpliMNXwzOp9ZJvuOdy9kbz8vrrkd8eOnmVFIwFB+s/waW3tGU1C2CVBneYLylIo4Ez
 v5Yp1zwJ+p/iBVof53QBSgvnD/3YB2xTVVNpjWojtDdIoFYVbBJ9mIwbEJ2nzeWts9if2
 uvm5yB4TrSAZsVI2g4P/5bnaaAWylrsRL4bTuO7deHXfolTV7MlVR2vlR2ZuiBIFzD0K7
 7ZZfSLqN0Q7EvHf1m15zO12kfEg6y9T1hp8uSX1WKLXPZddFHWp2Lme1/6pzQk48kuA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=KZRo9tV0; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=KZRo9tV0
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 614F240068
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:00:35 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6acb57c2b88so1786193a12.2
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 00:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792825234; cv=none;
 d=google.com; s=arc-20260327;
 b=UmpOLDmsCtt1RH6Lemnh4hl+edMNCl8VdJrjgq7z5OkLVG7Q5s8VuOEl6ChPl+FcqL
 O4bIyca6ETY1X/EQ5zL8MMz3nOTHL7gHxxZlIWhUk/pnWwJRPMxmOGgpWFUvG4XR+wv6
 QKMN0B5tg/tX0pinW6qjHuekn3DYTKk6uvZhOV5ErRKv1YpfxM8MW16x6vvz2J8HkGGV
 So9kMIO89vYxK1tVvSUR882sCQfkuAZG0mfU9pIe/cKvQBHoS25RGkOOJAuzChUOQzKE
 8s8zPeHEekBDrmjelq1bq5h/8PblhvMkoHZMGkdm5epmhlQyTlvtLmv1FNkdLi7c1jJZ
 Dj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=IeZi7dCiPAyTodBZ1XWrFtX6V8mUptc9mMSNBg84910=;
 fh=K3qBHk2ExO+3ijmhm2JLE5PguYt4WNVvCbTK1y2ofoc=;
 b=DjoGppJ5ktGT9rRkfkC6ZGhN58Cq3jdNX/aU7L79lPytO1GqnUPbIReVXVxwv9Ur6O
 z64gqad7HwIGunuNBy0ysX138dPO10l71BkI9PbxNH8kFRu6U5ktVSas2JlwXqfiwxC2
 UURcUwosIhvJkUojevcAsYu7GNRTNOI7ft+d8xHJkVkmfLTmIDGnZZYBGyRORWX/CGXB
 em3ita+uC7RPp7xlX4fmqsx35V2VLvuxobYoS4bZHX2ADVfhTXNTUe5k9eC61HhbW+TB
 PTfcEoTG21z4w2sSS+IXPFwXVnC5laEr7fjYSKqNN8KIBr+j4TKM5efN9N7qGFjeidF6
 WMCg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792825234; x=1793430034;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IeZi7dCiPAyTodBZ1XWrFtX6V8mUptc9mMSNBg84910=;
 b=KZRo9tV0bQbJIJzHj9+pLgPJp1p4/r57e3V6f2QWfsiEWGW8YxBm94+iLt0PVCSysB
 um+KfOoAmZzpyYyz9uo/e++lt+b+0laEVCj8valNk89fdUsPyc3A34FipaUqKZwdJjaf
 aDeHHoi0nzx5Xk7+L21HYihnuGaMYBX8EBUDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792825234; x=1793430034;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IeZi7dCiPAyTodBZ1XWrFtX6V8mUptc9mMSNBg84910=;
 b=sunKigHsjixNL0USlOSIew0ypzIs6GRjMO9ZyCDd9WhEKfrJhj7S5gqbbjbpKUXrsg
 cMDT1KCrMUlhL64QtvcUw6QMivTlxz/1nUg/Vnx3UYjheTRbpxrFmnGKGwdz2m6UiyRx
 +/ZExWA5hiJWgdmdQaBPe2Dw1rSDLXTPs6JOWUXP678M0Cyp1mGSv8XmS/59wEXcFZ1S
 smRTltKuJ0lyTcjtuaY6J2Woyoi2CZzdJdb7h+vnDywZVvX19CzUscJNDdLBS1RzfLx8
 7DB3dD9T47SBiACdsr6vuhuBcfyhG90qlm3ccPFU9/KnbQ1FdCaLARcxrOXPkhSJzhNg
 3FfQ==
X-Gm-Message-State: AFq9FYI2Lj8bIFwt+5jecJAj3TJkd9S0I/fN95BothmkvVSJbsyi95yd
 PKgPdSBaRA8OwofRb6DCSyWOJPHbRTtCryhu0q9ZzTc5ACZY0QQeYg+cPLi3sqdncNqmMJeE7ou
 Bfo8rKdOA8Qfabt2bVe2YKXGldmUpDkZnM3cula/4
X-Gm-Gg: AYBFou3mRri9rU38WtHwdzSmiv7BNixnJzQVUPswWDq5zhVxrqHm+DwYIEWNilon2ws
 dqPNxdF+nQh0U26LK60eUgUMg4YiN2qk3GDed915b8lDpYp7ITZpUT6Ca5kgKQe1bBfsNJobuXU
 h4ecyHzVTppsOBSrEf7eRjyL5KJBH/GQ6nOrpFbnpCdEIDhL4Hg5N9KtyzbfM7hG0ZC8DkYdvVr
 1DkqtME4KAAGV8LQm8gQ5eORmA41b47C5ms56XcpWk6HLjFgj8w89LTlr/I3tb1LxmguoirjBpC
 eRb7we8Cc5Fsot4LnYnAhz45RjwoFwD0GIGZBrDVXZhGxdccGtocYUBxN618KYpi1oLFE6bAVFj
 mJIjAn3ebGaz1w5y4npAeChBZBWEqjAKYyCA=
X-Received: by 2002:a05:6402:1ed1:b0:6ac:72dc:c3c5 with SMTP id
 4fb4d7f45d1cf-6b44300a8e8mr1650523a12.30.1792825233539; Sat, 24 Oct 2026
 00:00:33 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 00:00:31 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 12:16:34 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-spl-fit-compression-v3-14-6647aa23ade5@flipper.net>
References: <20261020-spl-fit-compression-v3-0-6647aa23ade5@flipper.net>
 <20261020-spl-fit-compression-v3-14-6647aa23ade5@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 Oct 2026 00:00:31 -0700
X-Gm-Features: AclHuK_doWuaoR7EK7IQnzQFpx3ts2Dk7loJa7csWnvKGs_GeOyZHTb7N-Dbk6k
Message-ID: <CAFLszTjoS+fVCfFknH7hpmRjgUUJ7O7aYSPgYJa218tYEbOS3Q@mail.gmail.com>
Subject: Re: [PATCH v3 14/23] test: spl: Cover FIT image decompression with
 zstd
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Max Merchel <max.merchel@ew.tq-group.com>, u-boot@ew.tq-group.com, 
 Petr Hodina <petr.hodina@protonmail.com>, Bruno Banelli <bbanelli@gmail.com>, 
 Carlo Caione <ccaione@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Marek Vasut <marex@nabladev.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 24 Oct 2026 13:03:24 +0000
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

Hi Cole,

On 2026-10-20T16:40:47, Alexey Charkov <alchark@flipper.net> wrote:
> test: spl: Cover FIT image decompression with zstd
>
> sandbox_spl enables CONFIG_SPL_ZSTD so that link errors show up, but no
> test feeds a zstd payload through load_simple_fit(), so the decoder
> itself never runs.
>
> Add FIT_INTERNAL_ZSTD and FIT_EXTERNAL_ZSTD next to the LZMA pair and
> register them for the NOR loader the same way. do_spl_test_load() picks
> the canned blob by compression name instead of assuming LZMA. The plain
> payload was already seeded with that name.

I'm not sure what the last sentence means. Before this patch the seed
is the literal 'lzma', and it is this patch which changes it to the
compression's short name. Please can you reword or drop it?

> diff --git a/test/image/spl_load.c b/test/image/spl_load.c
> @@ -795,34 +800,414 @@ const char lzma_compressed[] = {
> +static const char *canned_blob(int comp, size_t *size)
> +{
> +	switch (comp) {
> +	case IH_COMP_ZSTD:
> +		*size = zstd_compressed_size;
> +		return zstd_compressed;
> +	default:
> +		*size = lzma_compressed_size;
> +		return lzma_compressed;
> +	}
> +}

Any compression other than zstd gets the LZMA blob here, so a new type
missing from this switch fails with a confusing decompression error
rather than an obvious one. Please can you add an explicit 'case
IH_COMP_LZMA', have the default return NULL and assert on that in the
caller?

Also, spl_test_mmc_fs() still uses lzma_compressed and the 'lzma' seed
for any compressed type, so the blob choice now lives in two places,
which is what patch 12 shares image_compression() to avoid. Please can
you export canned_blob() through include/test/spl.h and use it in
spl_load_fs.c as well?

> diff --git a/test/image/spl_load.c b/test/image/spl_load.c
> @@ -795,34 +800,414 @@ const char lzma_compressed[] = {
> +	if (comp != IH_COMP_NONE)
> +		blob = canned_blob(comp, &blob_size);
> +	info_write.size = blob ? blob_size : plain_size;

'blob' is just standing in for 'comp != IH_COMP_NONE' here and further
down. It would be clearer to keep the existing 'compressed' bool and
set the size inside the same if(), which also drops 'blob_size':

    if (compressed) {
        blob = canned_blob(comp, &info_write.size);
        ut_assertnonnull(blob);
    } else {
        info_write.size = plain_size;
    }

What do you think?

>
> The blob is generate_data() output for the seed "zstd", compressed with
> the same arguments binman's zstd bintool uses:
>
>   zstd --compress --stdout plain.bin    (zstd v1.5.7)
>
> Signed-off-by: Cole Munz <Munzzyy1@proton.me>
> [alchark: pick the blob by the IH_COMP_* image_compression() now returns,
> and check for zstd the way image_supported() now checks for lzma, instead
> of giving the new pair its own return]
> [...]
>
>  include/test/spl.h        |  10 ++
>  test/image/spl_load.c     | 403 ++++++++++++++++++++++++++++++++++++++++++++--
>  test/image/spl_load_nor.c |   2 +
>  3 files changed, 406 insertions(+), 9 deletions(-)

Regards,
Simon
