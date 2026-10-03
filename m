Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98AACA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:26:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9861C8100B;
	Sat,  3 Oct 2026 13:26:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V_SSLTjN8Ogh; Sat,  3 Oct 2026 13:26:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D737F81183
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034013;
	b=a4FuwcfWWuBh2NlUqKCrMkMhaN+xzQxxcg4OPL7uyaUBygRZF67WK3WhMbVkTDsErpe8
	 pyPsdMoAmMo/j9mEsj3CQJ8SR8xcqh3TbvcEOAmgPD4AXeDf28hDx0Lubg2F6PXcDxvpv
	 EYJ2UBx8MrSJRtDx9tEAoAHQkKcMO2wwjGgtSE0MX2FZzc3dtq4y92oS5YQrVJJ6mDgAQ
	 iHM4bH1WemwFJbeo6ZnfCBETkLVGmgVdo8LNCQqAkK4mcrDOIrlRjrQM3IPzI8vFoLJTi
	 iDT5HmdFlwaKumpMUzQiZhGIrL8PODSd4EuTSheDpmo4O+Wmv02++lqZ6deiGiMXqWQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791034013;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0ivBFm7Swt7qtlsnV++34YdocbxzxSLNRnhvHKcvWzc=;
	b=mnIR3SPS2yJz28/uQOlmjRH3HPjzERxdSQmfP5eI7Ahla/kEHHnhLDzaZvL/XcKfKqX8
	 QdKZ6YyDEKeRZB97nhAVe+RPIvdq2dsWYfAc6mP+g+DnggdWlDwzfGRnm7AsM9wTI79Ck
	 nVzwoBBGMP4IwG95U6Y6isCs9K/HE9hlxIiMzgRgIX29u3nZpRufw4U/Fl5Ku/Ages+Dr
	 Xs5jxjGwV1wMibU9HZit4wcGBLzN3yQIvtcsYjJrHgOOxcTmqPNCULkCI1eUl+R1myaDZ
	 eBXM3bHVGPQoGe7jVZ7c1HAu4xWzrrqPDP2A9vGn9cmaMf8zNKdisSO9slWUhl/Fx7Q==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791034013;
	bh=0ivBFm7Swt7qtlsnV++34YdocbxzxSLNRnhvHKcvWzc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=soH9AZPlMpbxLV3SZTwBBzar4QA3l4szYypVA4EWT7nmpltddVHHFqCh3eFDXScf0
	 Bq4wZUoAzWk7OEc3Lf6prNUjvnyQf2pv66h4r7AIXLF31zQLExCDWbaNUphlEhs2yK
	 /tfui7x+Ghhp2bhI1Dp8Mf93WPLUpwjETyCwXoSh+N0IdcET4LDX15EN3WCX7QkFSn
	 nGylIj4BRGSs5e/cwRxlUgCFYjAYpm+XaAly5WRioepiUK+yYRUaeIiRwJ3q7TAEd4
	 cQ8tqCoCCI6/RjobO6T4l1fcue2a9SV6UyFUl1CYSEad1omj2cdWmrY7o5bmsmYLpY
	 d4UpNNDphLLvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D737F81183;
	Sat,  3 Oct 2026 13:26:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9CDB3282
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:26:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8EA6D6067E
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:26:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id edOMCOcbpdiI for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:26:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8D54C60621
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52b"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034011;
 b=pq4o+N9MV9bt+xox5jLgxZnLw4q7lmNg4hi9YPJDTNwYbG50v3ft0bnJKTs/m876Xklf
 HjV0dtk635zv3j2KTLsGXy64LLbUW6Uo6aS/sBYTu0VzTP4N6Er437kiLldDhpFK7lE2A
 DY3aufV7u07y+e8iuBAa8nmph3TnGsOBJshIQB8oh4fAJc7HkIQCOKKNPbEprl21m/Hmr
 icM8nH43sDAaTwqFb2uj0YXASLPRKhyTjOWGuW3P+2lWh8Nu8I7UuhlqUN24LJLWBcVR8
 vB3m49GZ4Gn7dW92J7/6kP/W8GOdXq0mtflcjo/g7bQe+bwJI5cjy5cgDb31nezLlkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791034011;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=0ivBFm7Swt7qtlsnV++34YdocbxzxSLNRnhvHKcvWzc=;
 b=KOyDSQaVq76xB4C2++EmDzrISxGq0z6YQ5MvZ7d2kPuS1Cbuu9NgMB5xcAgIHZIIWeW5
 3OahflhzLpOFuMINlU9XuOeCLLNYrZBqklDwZQqpsDtHd7AEwxEOyA3doJhiPELOnZcSj
 XjMbKcaO7LvOGvU1kHkqTC7MoaCDKL5quIt0pjR6tYTqIJu+ONljYe/NhUgkFcq3Vln1C
 CDJ2YqOANXSB26EzrXtry7lYal3RS9/ZwEYPomxOD88Ry3gA2wpZR0boUBXKXEVSah1O+
 sAztJgNJU2UpIdYmbMuhqNVPcHyoPU2H/FEgVgi00EAwF9hpsgSdBq56ihTrvktP30Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=JieE7Ug8; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52b; helo=mail-ed1-x52b.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=JieE7Ug8
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8D54C60621
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:26:50 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6afbc363efeso176110a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:26:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791034008; cv=none;
 d=google.com; s=arc-20260327;
 b=g0gS4ytikssxqIuRXhPRmGbMaFtw+/AFKvOiFLllGsXShhoRWwyLQzVM2sqK9rRq7P
 zRGa84imSDaR0Xe6B/NNnDt5VLz62u9ZmbIvK0d08NIePVxXdhw2cU2PG6SbR1ZnB3VI
 keZogfeePFGEicdQ4nrPgHUZsNA06ooF7LJIiGsKIT1aDTs6GiJi5Jo5KpkTCSbzbf35
 LGKCT4K2iZh82n56Dsng9S5vpXcp4JW9QbfhkjrC5F/QGVgX0CtffJbgRPAII0FQISOe
 /Pu02HzlspuZA+367swP/PNvW3ryentnRR3Fvi3yAXyWeJ8cRkcbAPEZK7kGc+BkCd0z
 ivYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0ivBFm7Swt7qtlsnV++34YdocbxzxSLNRnhvHKcvWzc=;
 fh=8/oVPevi97Oe3BkwdpKpXyOLIh09+9PPc9VOMBflR48=;
 b=TzFoIZz1UXqUCAapuLoVNEt9Y0YiwkseymGwZPJqdpvusNaM8QTdJ1+P+MB2opXCB/
 eiLaEMEIjbeOQgX4seT+dstxjzg6APND6ej91LEwObHLPwD83Xju+hKcNo6tsX7E8f5A
 aZwnDK6BdAee8cm94b46P9jEgyBpg9A8uh0xgjtBXkZSmxo6x2cjfW/chogJyrCZwiqF
 nveIxK/W+kArEjgiRGZl6Tg09L3kdj6audINbnQVtk0RLi+lSN9Sx3fzMpwWfToLKRij
 OKBlRsfU8wS9+Q/0C7UjPeEOHeFFjIMnePzyCfQ6nORbdDhSBRq7bBeD8itu4iRCZpHm
 3bTg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791034008; x=1791638808;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0ivBFm7Swt7qtlsnV++34YdocbxzxSLNRnhvHKcvWzc=;
 b=JieE7Ug8hi4BAtD6C6jJo7vkprS4oawV51h2fle5tnWQJ3Prz7SiZRfeEbEWp/OAEO
 3Wr2+86pEeh5p0my5+khbENn7gxs21gd2kjLDVwcCcIYJ/Qz7syCJLGk1k3bK2GR4pFc
 k5lWnCqy3sAxUN1RVopxS8GogZvpbUYi/GhWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791034008; x=1791638808;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0ivBFm7Swt7qtlsnV++34YdocbxzxSLNRnhvHKcvWzc=;
 b=z/Z5MWKjEb2F3Y91U+pUqGfdIZmpKTQoDPlPATVak8FhsgVmyVrjHihPkUtvwAKpa+
 VDlaJrgQ7M4TdZ48+b84NOQIFFhm4JOFiLMSOVp96EhvEybreg1HzeEsUOrVt3jDRKuz
 DYURb79d0f2ZD8uibp4c7oeeDX+5l/M2mx1bn+K+iH6Trjxy+iLjkROyRuBb1Z5JOamV
 jEunCabtUYtvWniZknRJccInaC+Tp+UFsAEfAcWmvE2l4cuQYE06+SzTxcwUlmgH9r34
 FC54WEowSc2lXATGIWxEwJHKjcrqrkW6Uyv3ZN+vVLRVxZqzdpmm50kdN5ksquIdYKhU
 JGRg==
X-Gm-Message-State: AFq9FYLpcm0T3ZbAcD0ER1aP8ha8dIGBfhKqmD3KtHNJdX6T8vrpWwVn
 oiiIkB7u8Bdl9AORs+h8PJMyMkBkOgM65n/JaMc1EkHrFdN4p7S4BPJ9SgPF3HxWL40wf7Sgtoq
 7PzCwnVw4dY8klXLbEAJam1XFxxxSEwLpxJYKOP+YgVWo7BDOyetmm19g
X-Gm-Gg: AYBFou1ICekV0v4vv8EYCt3UU9xl6gxU0kKPq0atK4v4DcL7JCzCCFAcQRQ8b0uYzUU
 xtoaRcWd0q7LCL2EzO4us5MGzBc5OwVk6htRcE8DLPOzX8iiFCfHq4v/2VdEGP46WMtWdAPBf2Z
 tx97B1tQokvwNdLEZTddWDhHx0aaFt0gyztI8LPZ8Dze2R9ZPbJy0B/KWHwdGONq+QuTy1XW3Vp
 HyGbI8hlT28p0pgqfxC15Rjgeri7/e8kEKgUPgm83UrrAb4FvWOWt0SdHo4TtWWFHiWPpM3JNd6
 AvAC2IA7cQM/r/8v7uwsng9XyFzg6hh8yTl/cbGePv3NwpP5mta/Puse
X-Received: by 2002:a05:6402:24c7:b0:6ac:9a44:d3fd with SMTP id
 4fb4d7f45d1cf-6afad8eb9bbmr1588570a12.16.1791034008144; Sat, 03 Oct 2026
 06:26:48 -0700 (PDT)
MIME-Version: 1.0
References: <20261002073357.382228-1-aristo.chen@canonical.com>
 <20261002073357.382228-2-aristo.chen@canonical.com>
In-Reply-To: <20261002073357.382228-2-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:25:39 +0100
X-Gm-Features: AclHuK9AAAvDKCWHhN9uPkNP9OGc4P9CTJ4nddSQZjXkIXdJhy8xsrrnFypWeMA
Message-ID: <CAFLszTjgfvkTb1XizmX9OkaeHgd5VH7Hk97kJE3qcbOV7_RvWQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] mtd: spi-nor: drop the duplicate EN4B/EX4B opcode
 definitions
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, 
 Vignesh R <vigneshr@ti.com>, Takahiro Kuwano <takahiro.kuwano@infineon.com>
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

On 2026-10-02T07:31:50, Aristo Chen <aristo.chen@canonical.com> wrote:
> mtd: spi-nor: drop the duplicate EN4B/EX4B opcode definitions
>
> SPINOR_OP_EN4B and SPINOR_OP_EX4B are defined twice in a row with the
> same values. The second pair came in with the Macronix Octal DTR
> opcodes in commit df3d5f9e410c ("mtd: spi-nor: add support for
> Macronix Octal flash").
>
> Drop the second pair. No functional change.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
> Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>
>
> include/linux/mtd/spi-nor.h | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
