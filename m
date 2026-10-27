Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A5D606A31A
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 07:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hN5RkI/T;
	dkim=pass (2048-bit key, unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=nkWTV6sk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F919606C7;
	Tue, 27 Oct 2026 07:19:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ePZ5onC1Y1Bq; Tue, 27 Oct 2026 07:19:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org ABE36606A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793085571;
	b=ThYfwmQlf6q5T52hPeum+JN1NtGcr7TqNRbSO4ql/ZEjzwOG+VlNpZW4Hr9ngD/TTHAU
	 MWXFuuAxz/pxyutqUXbAK8UYnnT+NzeS1GSDNO75qVokL+zaqO0qXqG8ddvyClvgiORHl
	 IJUdVLsRAarPxVmqst8ZaWf0HFvDeXNOaWuYk3/AwCZVGI8W8ojbD71/n/lE21LJ/BN67
	 bs+rHjiqwxoX3HUNOI39tgprHWroZU8panSlbcB7y+acnRax9cgU9H6Iau57SDahLQNoi
	 vU/42b7jD0QkaAinIedl1PxAi7CRRQ6D2EGM17SdVpOLgJeh30RUIDmUl+S28KCDgtA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793085571;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zXuyVaVQsLAQ16OH6Xoy9qQI2kbSBjdu92NdcgTKf20=;
	b=nULAcpNDPcnQmUm3w1Ub7vDL+wEIA6S8Hdg+VCEykcSgKbzYokNVakPtcSfNbsvzpzaI
	 fT5wAA3qMrV4BRgr04LgViKNcKqH+vlQUBDl0XUIAr2l/nxfC1uU1QkBsUEoQNCVva6mV
	 WNqv+ECl7tDcQOPGIE1PgBjpjGV8u7ywt1Vh1Fxq5FhbhN+XNkUXFbt5qCRdExjgw2nMd
	 LFQL1RGMGj3yrvDsfBjYpTDr7AGck9NbWcFkWhpERWqTOTIgdBLWp9rjwZZTbBWEFVtRT
	 /tjCb1Gd4CQCJB8SwiiejD+0faKsy9Fm5wCaxhksTkZ20cEw4pmRezpeifWg2oyWxCw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793085571;
	bh=zXuyVaVQsLAQ16OH6Xoy9qQI2kbSBjdu92NdcgTKf20=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hN5RkI/TIAoPJYM8Svlb80S5JKLoU0V6WDTBDZIw7G35raPbFs88trL/vQMkCbwu1
	 NfY5MzNI42bs29ISANph9TiJyfdTPNO6bI6r6TI8u6QUlzLg0XDXzXaBM/l1jMe1jV
	 a4fK2d814aQAxiNsga+jEx76iek5qLaW3gPsdG8CSCl/4Nwc+SGuYjuahX1BJtIAsR
	 OATx49wXa/QACImLZG+9L45B/CIywGSFsIqnX0a5Na4RpVV2P5UhfibKRAKMZCAWtq
	 e0y6fkmyA//eTt5bNMi1wZjXwdjt1I9dkTPOHhiyLst5EB+wXk/go3DMGByHh7QTQr
	 KgaGDjDFx7iJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id ABE36606A0;
	Tue, 27 Oct 2026 07:19:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 12BEC356
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:19:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 025F140062
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:19:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SEwmBOi-H61y for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 07:19:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A751C40116
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::62c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793085568;
 b=i0pSwGhmCOZ7SeEvM4cOCJNS4KhvtLioTk+qI3Pbl1Oa7PrConWtSAcdxVYWpPXZD24A
 kUZwmR3ZN3C8q19yOnToMOGftoU1/EptYOdqg363wLnhBLEQgzhIppS4bOyg7Vh3w9dBd
 z5OEEMAUWAc/99O+f2mOk0hJbfEWhI5E//9JZNNqWAhvpPzojYyX2VQdNsWpLrVJrCkaG
 AmITpl7rDeDMXSq/U3+lROmyRGFwcdZ27g56LIn2IEH/aLpzCqIgmcg0zX06jmeR2FYOk
 OCI9zzEEcWS+kn5nv6pUNe0EV/6DeaXPSoC8hjuZLT6jicUmVmJPs139AHLLDhijMOg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793085568;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=zXuyVaVQsLAQ16OH6Xoy9qQI2kbSBjdu92NdcgTKf20=;
 b=pvwqOWXiqCvC7q0ThDMGxd78B6Wfg1pWjYsk21zKLzH+7283IQR2aUSrtI8L/NqYFfnP
 98CV4iQVjcTSZqQkn23vKdl/kDChlAwdF4S7kDav9Pg7xA7x0esCYqg8trrGJy/35/mHA
 nKZ8rmvQP2L7VsT+A8PqwFD5BURL3bg245OQVSAF5DutEk9RHnimC4WG+kVUJX4Cyr/tl
 E3l8j5B33pqaBMjZ8cdXbW6RYkTfoEyxL/uNzwK1nZb1/4FnYvtMcaCgsyhyBRmrGWnZs
 8KwEA/Pkg2l4AMB6HPhWsYQXbaszJ8gFDV6xRcFU3EvJEbvLKBK7VTppnVj2j4WLOaA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=flipper.net;
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=nkWTV6sk; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::62c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=nkWTV6sk
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A751C40116
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 07:19:25 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c43fbcb4393so530701166b.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 00:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793085563; cv=none;
 d=google.com; s=arc-20260327;
 b=swztu2qBfhhp3pGesfiUTijtO8Vc4sH4z96cFkc+g9BzIMch9QEN7XSwbtFqTO8Q9j
 oEFhDg3qTN13Ea87su0nPcTKh2AXZrpLCw8iEQ+WFoZlxnhUahN6LasbpLsK9uKHMgBK
 fiG2D0LjcsH+/IG/BYbeojQ+HYE+KbZ4m0dfM8RldpGXfwB41Vlqigl1EOYY7NdidMfw
 LgA26501I8PQKMm9mWv9NgE8ps9u8kpU1+fzviF9rrIv1Y/Kj+JdDmm6XuBY7iMyxoHm
 VY16rUfYGuT7q1I8d+Q1L6wjxHNygyvVSd+39vsSBM5Kf44L8htkoBEi1iUf6jiRQxfn
 9+rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zXuyVaVQsLAQ16OH6Xoy9qQI2kbSBjdu92NdcgTKf20=;
 fh=7fEkcMyBEEEd5QMuJZqTYY1iOBl6HgMgADL7jbQoEvI=;
 b=U6DPK3hP0W6F/ZZnsvgluxHMqVn2+tYJRMYuvLa3LZb5wPaS0MO8zXH4K1++2HSQDf
 9qyoyLfiS2odfDS0nonM3UYCHL1QKh8oWTvYYoF6DZdAbzgxd4k6r2HsfQzxw0JUBbHe
 R73PS09MpnEaEylnD/i5mSmgO+f/vaNVJUdW9ehk+hiszK0t1iBqN5kzRGm3LuCxbGji
 dUTxi7NESb5zgItbJOjNt+H0UojY6ll03Vb5HaDmiu0uXgApUYc+I2s83YXGiAa5HbxP
 8QCojXR0C8dHQ22qmA6we7acfJbepqYcmDkE4KjIHrsU2ZlDfO5g5wRgLDpnnSYQFvP8
 GQXw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1793085563; x=1793690363;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zXuyVaVQsLAQ16OH6Xoy9qQI2kbSBjdu92NdcgTKf20=;
 b=nkWTV6skW93qCSdYSpyHK1OOdJecPe+YuOslVeIR3CkOu7LXEeg622by4n6RztaEGK
 czLnOXhqscQhxP7t1HTVn/2XScyVOISAbL+IbByjXyBjz/O+YHcWIaQvhBHbvP/yVbCq
 ZAzGS4KUdHE5w19hJsPp4BptuDOsj8f/xgjrnkvlru8wxztw8vKZ+6Zam1qCHqwdgx7x
 eTM2LAFHPh394rr8JdOa7EuLNbiNuMchudnx5J9y9XoVVpF4RY3o+2TCjkR3wv7ckNhU
 qXtRycBbeK/WeO9CDhnTxQgxlq2/Vm9kAivgyc8MThsYsm99Hd6yaW/Q3KtbvWoir38I
 PYnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793085563; x=1793690363;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zXuyVaVQsLAQ16OH6Xoy9qQI2kbSBjdu92NdcgTKf20=;
 b=2ENFt/gF5f/GL01EPWq/PkNvvjF7ir0RBD2TBUiRhBLnc6TVW2Ak961GY2jJS4ayo/
 +Y237tOL0Rg7B9qM8bTAB4yVdI0NZdNy2k55gTJiB31LHOUKGsttlfqs+O0Ya1a5IGjA
 iP8d6fm3+3bt81V598OtNsJ5yNHXc8mdQmo9DxYOYAOsRGCg3j8dYvQlxhK1Z2aT+MmS
 E2j9nsrcrRBWYZm+A2hPWtvhwBk2++3MeIz6q4F0CzU2MGan0UPfMlxoXwmzZRuUpAik
 UpeoQO4SHEYzafzVypdy4whLgfeilWHlwrec9R0fGexe/3RKnOUaB3pftsXGnjlQLKMY
 nCBQ==
X-Gm-Message-State: AFq9FYI9rQYnPOgRbD3DXEQgStGhU/LDH7h3lXg/B2UouRx/axqRosR8
 6e//vJ6XOaf23VnNeLAdlM7HDv2cVxLDr3n2dPhYrI1gdLmRmdpKfFsm8y3h0Hdt5UL7TzyOCff
 Q1vbJ2TOGkWZlsiBC8LD8EcpQu+IAbs/lKNDOlGcjXg==
X-Gm-Gg: AYBFou1e1fRezf1SVuHvGTTwEsbLcGhQIuPMZOoz27e3zrIMihs2rqxeQ83FpCb696L
 dNC489wKqi9n/9QuAJbpvYAUlNMgD8KEBuj9neD0KGF07kl/RY02y2nn9nScKaRNqYlOFyCq2x/
 vjKlM9dx2WlDFfufvXk+Eabs/WDkc7R+C2wQ9TbAlJpHZjCtCLSRJS+EV809loKXZUsFiHJM2yW
 xYsnqFBlbY8IjLT47hLIVSH1jTkOoA+5/KEZ06ChLqp9P5+PUZVVayH5066ICPIOYWClq4R92sY
 NMrwGdEzcBN9SdPVdlUSq0pl1ESxcSU7XZP+jdyHBEmZuykT7p34egzi1ZZUq4Qgbh7V10/kMcM
 5RQrrcoJhztbjQuKmoK1DUKOAiLxBYKElRQinwmGI0Cm05u8sVU3H0UtQYW2J0Q2VlgYB
X-Received: by 2002:a17:907:3e07:b0:c40:d920:746f with SMTP id
 a640c23a62f3a-c46bdecc45fmr1039384866b.46.1793085563267; Tue, 27 Oct 2026
 00:19:23 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027012709.GA2177077@bill-the-cat>
In-Reply-To: <20261027012709.GA2177077@bill-the-cat>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 27 Oct 2026 11:19:14 +0400
X-Gm-Features: AclHuK_eAqfqofqWfUR2LpEKilO4dwylfyX9qfiaWWYkrzR1vnD8Ti-z1sn7d7Q
Message-ID: <CAKTNdwFp68LxY2BrghRCH=kCcRf6Z4Q_v4zXAPgM-VFB4QbxwQ@mail.gmail.com>
Subject: Re: New Defects reported by Coverity Scan for Das U-Boot
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Cole Munz <Munzzyy1@proton.me>, 
 Pranav Sanwal <pranav.sanwal@amd.com>,
 Pranav Rajendran <pranavkasthuri@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Carlo Caione <ccaione@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Julien Stephan <jstephan@baylibre.com>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Samuel Holland <samuel@sholland.org>, Petr Hodina <petr.hodina@protonmail.com>,
 Eric Chung <eric.chung@riscstar.com>,
 =?UTF-8?Q?Jo=C3=A3o_Loureiro?= <joaofl@gmail.com>, 
 Siu Ming Tong <smtong@axiado.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

I've checked 661173 and it looks like a false positive - but one that
is likely to reappear going forward.

On Tue, Oct 27, 2026 at 5:27=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> Here's the latest report. Since it says 20 out of 25, I downloaded a
> report as well and the 5 not listed here are:
[...]
> CID 661173, String not null terminated, boot/bootmeth_bls.c,bls_boot
>
> CID 661173: (#1 of 1): String not null terminated (STRING_NULL)
> 7. string_null: Passing unterminated string label->name to parse_label_ke=
ys, which expects a null-terminated string.[show details]
> 309        ret =3D parse_label_keys(&body, &scratch, label, true);
> 310        if (ret < 0)

The string it complains about arrives via memdup_nul(), which does (in
lib/string.c:357-358):

        dst[len] =3D '\0';
        return memcpy(dst, src, len);

Apparently Coverity misses the assignment of the terminator which
precedes the memcpy call and flags the string as unterminated. Shall
we swap the order of those two operations to keep Coverity happy going
forward? The behavior doesn't change either way, although directly
returning the memcpy result (as it is done currently) looks a bit
neater to me.

Best regards,
Alexey
