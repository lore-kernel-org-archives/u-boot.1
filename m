Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23015606A6A3
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fPY1SLMv;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YHmKVYdT
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EC83E60673;
	Mon, 23 Nov 2026 13:37:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sFhHL6-YZzQ6; Mon, 23 Nov 2026 13:37:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 555096072F
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795441037;
	b=E2PxfdVUZghivARpQDm1w3Bctql0ZRvUwSajFGI4p1AOaPMic84ytYrxCWS6y2g+l516
	 bhsQHFdgb+tE6bZpYsLUyDNt4jY7fcubgBObiLzkpNfL2lc6FLQ1XJio0jakWysNwH1FL
	 znVddNn1j4O2cCrN1YzZ6EsaQ1LU73+Hvf8qsyCHUQSSbCf3CdslJqO0iMs0fK6d+Cbf0
	 dLQHMXvDVhkHxI6OwTAlgfGcNe7/9lfas2N1RdeTq6We1qClVPaBGmpAksCFRDALiw5Sh
	 E/aHH9v24YchSdkvbm3HoPzECfj9u4DOwI/8Fsye62aMs20KOCCB2fgJekTl1OBGrPQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795441037;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=afN1HUxHf4wqbrjWJuAXViF8E0YiIjtIBsV2760Pd9M=;
	b=GhzQ9F/5ZLy4YWjtVVkocZDjr7ahbEYde7eDG+DadFGcYMDTq5ozz6OCDD5/rmA8VpEd
	 EkPBg1cBjBNfx3JAO1L5HEmwTgOTxnox1aP5B4DW9dz/NxLfRJGcCJCizL0oWxQ+Y9+Ys
	 yDMvZlu6O+8BQkZRecNqIY7K6FzP3hqiYYojHa7tmyPxg+pBJ3W/gb5rWtgmSPo9fvbAE
	 I3Osz32I2b2sQpcazAEXnYS99DY+VBd7m/DCPwOGP4A9l6Wqavbf8xlmICtz2nXxVjAqc
	 cId81KojdcwAtLua/g2ZnMtwXan4Lk9dOUeTiOPvxNnAP3IRr6HRzwdSZ1qTDAPO8HQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YHmKVYdT;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795441037;
	bh=afN1HUxHf4wqbrjWJuAXViF8E0YiIjtIBsV2760Pd9M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fPY1SLMvnFz/5yDXcxqBvkNOE+VCdcbo0c4GBYS+rneVbHV7b8IVK98FArDYQrIn8
	 OYl4JonOqUAnTPS94iWW/G7X8byKAWjkqsBTIEHVRDYyh6HGtpeGI0PSxlGy2iIpnZ
	 2ISEjyoPc20EkbxYV/x4GzTPrlyQZhWOByYnIhnAqHu8sC7ZgNJ8d7uT+6bUoEiqzC
	 u3R0JGklAtUmzBIsYCwzXNqIfRS9IjipB5BZ+6o0DXMD9nwn/8Zppt3Hc2AqwAztV8
	 kc0KLMM6e/DnufhDPeTP5GkOZUx7kzNamvtZNZatFJKVZNdkClLArL4WG0AqkrioNq
	 ZhmoKTxmQgS6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 555096072F;
	Mon, 23 Nov 2026 13:37:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A813260
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 06:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C4D46064F
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 06:45:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2wDR963tfT8e for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 06:45:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 89C7260601
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12c; helo=mail-yx1-xb12c.google.com;
 envelope-from=prasanth.padarthi10@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=YHmKVYdT
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 89C7260601
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 06:44:59 +0000 (UTC)
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-67c0ffaae1dso3208980d50.1
 for <u-boot@lists.u-boot-project.org>; Sun, 22 Nov 2026 22:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795416298; x=1796021098;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=afN1HUxHf4wqbrjWJuAXViF8E0YiIjtIBsV2760Pd9M=;
 b=YHmKVYdTB/8/L/fnL/33RlZkhK1qOP56P5p+rP5kzg8BZQaOznW90ABl2PbUrzeD4K
 tzfAp86K8hqjTh9CCWNs9oHJ6pKuqpmdiAa3RRwyk/dTkNJNoH+Li5eQbYBmyANl6ZjO
 E5G33GYFHNdBAErOO0SOgCjdeKVzqnWxzdL7VQEVqembHIxwYu9zkcnuN4UdRHZjffc0
 dmn1eOsF+AZ3tJoxL9q34ZyR/SYSnCYjrJtqWiCk0euiCM88EzJYSFxdsi3KRrve/nwm
 dqZasMiSZTN/4IOwuDCmT6uAKioYPbEcBXcQqsHGUHqaknmGbqrVmSuprTPcdGd/2rnv
 kBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795416298; x=1796021098;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=afN1HUxHf4wqbrjWJuAXViF8E0YiIjtIBsV2760Pd9M=;
 b=e63UyvuoNw0whH50cojJBuBSTBXdIOJ7Ti8G38CZk+aCcYMra38idVa3Of5AYNtqc7
 wxH3AQm0bq6TAxXj04PZY6aMP6ACgNMmlr7ouMk7wMD+rmSH/4AFoAzupUYagoHO3poa
 ksEVwzWbLCMO+qdhlpA3zNpB2dX5/iO3l+YUHy/pauf0Ssbr08Oj80SLbmmZhsbb4D1e
 8yKSYo8rxktwaygTo1cwiSdEAnbjULwYPUAq6zKIXq7nkcYdNSj2Lko+N1CZzv/kz4+0
 X8Y8B8Gyff1ByaHqnQEwJL295BimZyith1Tiv6t4cvuoBowG0XHHvpkl+45Etfx9H9iI
 MrHg==
X-Gm-Message-State: APuU4Z+NBpaozlGWq2QzVYGM44lDD/PPp9Gtor5VO2fK7KDus8u6cF/i
 ueiC6JuAtpsYkteyfaxYhuiFykvT56HHBWZfnFsmhVwigPRezNyl1wnLEvE4/fyXwyeXjKPOJhq
 2l9O46f85z5/ab3bywX/wP/hGfJdEfrc=
X-Gm-Gg: AZFdTZc6W0FCEcdB/eTU+9E68g8RE85Ut3Y1xDQMqcpUQUI4UUpmr4CMNRZ9nSyLpVv
 3OitWGwRHb0xUEmkGN7crtsMTdLXXBwCBFDZv+rvLh87lJ+wxGggF/pIABNyNAsybQMasbYTO0P
 Og+AGqHIKqMnC7zRtp1f/qfmZboNmHmVF+ravwid2HZGEwlazuOTtoaJF3srsQ1cKuRy8oq5BJi
 0fNkE5a+Y5x1Nyjaj5khPOyfBRW0dOXIFAx1kgtBtjLB9JX2wqgmeqz+cz4QhkPTPN4cpUNSMJV
 DB5x1M4d+4SfN7uosBONGXEobX8aWjZ7054NcsVirgJP/xxB1ql3x94sO6F6HliUUzjVC4TeQPq
 p6G+YhY996KYna6sftKEQLN5kcnGPgmMKH9zPyA==
X-Received: by 2002:a05:690e:1905:b0:679:90f4:3227 with SMTP id
 956f58d0204a3-67df40bd8ddmr3277535d50.0.1795416298219; Sun, 22 Nov 2026
 22:44:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110005930.6659-1-prasanth.padarthi10@gmail.com>
 <179512720182.764313.17131947857361330139.b4-ty@b4>
In-Reply-To: <179512720182.764313.17131947857361330139.b4-ty@b4>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Mon, 23 Nov 2026 12:14:45 +0530
X-Gm-Features: Aa3M54pnpufN680XqBEnZQ6ECx33A-CXZEYRgDmwQzLBjSauTX90qSqgqpdvOww
Message-ID: <CAMFFDGiGNKggzqbcTGaLjJLs2cih0P2xgmZcQJ+eeJ3+A4KWBw@mail.gmail.com>
Subject: Re: [PATCH] arm: aspeed: ast2600: Add B650D4U THRU handover
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, ryan_chen@aspeedtech.com, 
 chiawei_wang@aspeedtech.com, ilias.apalodimas@linaro.org, 
 BMC-SW@aspeedtech.com, joel@jms.id.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 23 Nov 2026 13:37:16 +0000
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

Thanks for applying the patch, Tom.
Prasanth

On Fri, Nov 20, 2026 at 3:56=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Tue, 10 Nov 2026 06:29:30 +0530, Prasanth Kumar Padarthi wrote:
>
> > The ASRock Rack B650D4U uses AST2600 GPIOP signals for
> > host power and reset control.
> >
> > Add a board-specific initialization sequence to prepare
> > the THRU pin selections and release the relevant strap
> > overrides before handing control to the operating system.
> >
> > [...]
>
> Applied to u-boot/next, thanks!
>
> [1/1] arm: aspeed: ast2600: Add B650D4U THRU handover
>       commit: ff6834c4ab49b837a3710f8afae03325e6a60839
> --
> Tom
>
>
