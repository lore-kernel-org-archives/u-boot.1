Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBB9606A324
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XRwDWydi;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gjbyjh4t
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 948AC80DC9;
	Mon, 26 Oct 2026 14:44:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vaMDQwXIljKt; Mon, 26 Oct 2026 14:44:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A109680D7F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793025884;
	b=AaY0I4e53GY78HuMxz9xEdhVCaAuYdaUkXj0e+ve5sP8VBIIbxct/bdNGv/xw8SM6YBE
	 6S/PoqqVw38T8iajjN/97Lcw145Ma1ik9/3OhLfG4CJpa1I9RgGjORi/5YIxprxCtUAT/
	 7AYM2yKcfPVAAQxAVPLZIMW1tkYDQEjD3IZ/uXvUhuyWaYk97JlYbgunuoFTmfSW3MRSv
	 vqjDNkQaOFZE0vixpy0vNuCZD4JmKIEpKYQtsAyuBbdQFm8xTByxJrbc/R05VtIO3c5PE
	 dBpjBXqw71mrtUFn0Gno411jqVpwLICMYCq68VV2cSk+C6IEQZ3bz4lnfTLz+7QIFjQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793025884;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/MuoGXaR7mHIfRskJ7VUMMS+e3FiDCTPCUspsk72bao=;
	b=mOcYCGADCSln+6IdIRwLx0qX4xIfD2j+0+uXmuEF1fIkG36T+tKCNMWKrHSZ80dnlqty
	 W6LWdtS7WiasLzHvxX2CAflk3Edd2mCspya6wIFZ3fX578ywzHdWecrD4RBmv++BMi7Ao
	 qBC6uwrkLCquwChKsEFiugdkFmqY9qHB/8B7JItLHw6MqC+ilyP99Lly67YluhV7c7Tfc
	 ryr2xL5oyU6C0waCAGobCY/FDE7FvFRPTba1PHs3xjvwV8dtle4gbNCEl7mOW30CD1fl8
	 R1ji5EYaAgnDdfpRHBbgbZgxv1MiC7iZ9yY/HU+AQDiCp92c8b1ZLjNbU9jTnuLd7rA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Gjbyjh4t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793025884;
	bh=/MuoGXaR7mHIfRskJ7VUMMS+e3FiDCTPCUspsk72bao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XRwDWydiqgZjqHCpqw/PfA7aS9/cWPPCurh0+8SRmaWenFV6uE8CqMbtnSR4/L6SU
	 wzQN6tGokZFNHv4/BHCFrEyQzUIH9EInbZcrKy0JdJSslzNmsAHY2zvQgaS9WhS994
	 7AWkih/h65E7PNxxlaJx4QUC8zWiCIiV3GwPLzB7RI9SN43MUm6OCrzKZUZIuCQO4m
	 Qw+Kz0wzIJVJxIB1VCWTezuEltpxSA6TKX/5U7RxMNkeSC8N4zTpNB/CweyNhcx50s
	 h95pdWSysMyH8owrQb+9akVbM2Y8ImsNKX8lLvcLAOe0UAOVvrlwMqv+71aLlUjLvJ
	 mSL84zgQnR/wg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A109680D7F;
	Mon, 26 Oct 2026 14:44:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EB8444B8
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:20:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DD1ED80E44
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:20:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HmNnt0WZR_NN for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 14:20:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7AAD580E10
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::22d"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793024442;
 b=dHca/1tGzce0KkCwP9plym3LWebnVFxK3qLYHfxzAP50A9sMNPUixu5NQy3XI81WFqhr
 K3+ZIKU5gBF6xW1j8ueyAqIKGUiQThQH6d7M+cfkYGmRtuQDazWJxiEEctc4UdbtyR4mE
 iNLn/WdoqOOkihRF20SpNSZBH5RSgcitTOVrUngPPH+HD73mQnyy3KHRrSoCrjiv+Lsap
 v5AOD9sneafdbSAip+dGmbI3j/xW1nZMIcqpJKRCCezuL1NR/+6Cr+SIEa42SlYmNjwtY
 BlTd0BnJvLS/l/vocv2tcTy11YJ9+mZXfqCOeFkMDaO2aHFqHorsm3vMve/7Uez8a9g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793024442;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=/MuoGXaR7mHIfRskJ7VUMMS+e3FiDCTPCUspsk72bao=;
 b=BB6n2X8qJ0o5ndfNY6Txm23glBTXDBlmAPehvQR8ILPKy0ArMPORWbc1e2Rf8GYUtFL8
 3n/u/GaE2toR9HBP7w0BqvE6MuTrPUik52M7NlOP15JC6JqFDV6jadjaSkDALSq+GFPFZ
 9ePd4s2TXKEkdscTs0ZnI4NtbHCEHvSaLWXxd+OnAJgowmnDll6Mgxqdw+Mm+mC7Q9Xj+
 ETXMMZz2xkHOCL8kMPACa6jGyc85i897/ksX0oQWMtt/moCVwMFMpOITFpiWKp2s+eL1x
 ajHrHP2zTWpE8W65QxsAXWdJH/7n3pO55haI05wYbB3nOp2CwVPACdbAApdmZwscRpA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Gjbyjh4t; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::22d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::22d; helo=mail-lj1-x22d.google.com;
 envelope-from=mateuslima.ti@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Gjbyjh4t
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7AAD580E10
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:20:40 +0000 (UTC)
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-3ac8c03cea4so4404361fa.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:20:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793024439; cv=none;
 d=google.com; s=arc-20260327;
 b=F97U8GQS43vj+8Ya6NCFhXUAVBvw/Fk9kf5SI0eyoSW7Z0COSU1MCZnX5bVyxbNawZ
 ick2ni8NCGKjpz6A5qnHxewIETBmvKz75WZTQuZs1UNtOjCetWip4WLd1LVoZx27jDTv
 k1HdgFjGWgWu9et3fMVQbmGlOJ/HWn17hZo39rTyNZotGqAKGII1UbaZ2aDIOawivOOK
 e1K1HYbCpfRedNGBsLa+ia2gSXG0mS1OS4jC5DfzTRYh4/YU0AnEBziYoUERr8a/97ZF
 7c7OlOsmIA2Q85d7+JZ0VkOB3lXTLdjI3SsLfAwFUhrr969A04pCshFTDdZapXaQlhZX
 sOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/MuoGXaR7mHIfRskJ7VUMMS+e3FiDCTPCUspsk72bao=;
 fh=QJpni5zS16zrKrGQ0Co933EYfP3m3waD97WTdwrm2Tw=;
 b=XBhc3p9NUFx4mLbUA1eic68NWtfNwlJx0ZYCppeYmWk89RBNSbv8fOkjs2d83vxC2b
 IgFh1mG8T1hqSLome3uMomNzNXv3OQLcyt3KLht0wXc3YwJ4kBXgLf8C0K/JwnEGXbtY
 RbKYDzkQ465bFYIP6FubtZ8E3i5Gheaiv3A20czGELt6ilFfSR9/dXOvk621ZiYmAIZS
 8oQ9ySbhwXSo8+nMbO2XCJb5wPSEBjTHTFv9f7WWnhfewr2tmI0oSxj5zWhgv0TyG4+k
 AthuC9M17Zk3Uir9xWE8NmVr3LKq8sPt3v9dJf+yuw71kkm/pSWaOSTnTeLbJ5rQMCSQ
 iNxw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793024439; x=1793629239;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/MuoGXaR7mHIfRskJ7VUMMS+e3FiDCTPCUspsk72bao=;
 b=Gjbyjh4tEXmiDJKFj/HveOq6H3TXlVFrTiPgBfMJBYnViSuRnDKl983X0OaHCdRhsK
 IU7s9God9iR3Z6E13rf8LYUprBuee5P4WS+hi7eVRP0Qo72EPhAa9yBH8GlT+WZLnncN
 EknKcK5ks/oN4On8MqBRRB3bjCeqeg7uTFvGWVwVOnAkKTcD0Qo4c6Os4+RwTf/Yhedl
 88GZSsStE3oJpdaMI0kE+ufkr9kakR8ZpTyoTLNxjMmv6cMy/YPr57g0+yZr3/QBpsRN
 fvYSbd+kJz0DghgVqC9Up+Jd/HpWqksa7zGg41PWT4xOMe5KYqq+G5cV5m/GwenW5KZq
 BSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793024439; x=1793629239;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=/MuoGXaR7mHIfRskJ7VUMMS+e3FiDCTPCUspsk72bao=;
 b=WozC7Sun9dxc1jlNeTAKkhq9ZSCkWBG5KzaNJjGeNlqX30TSDr/91Lh03afCe6358G
 htkIBgkY8dI/hk8XXatVAIrt7VZRaM4pcWd5BgfOBaVb3AScqgvC8k/kRZsi0nWg53pR
 kbW9kc2LLD9YaZbHoZEQn5mv6sqg5nyrcQX/MssAQaIiANIrmiYQD2oofRSofQFPJH33
 H6pTpoDzZfr00ZpPdKB0QgMs2krepZyx3PBCGs2s5Fll27mM+TmB1+F6cIkrmVLF4ge4
 rVXH1E1S3S6hlPDvAeY1NouLDsKBzklUoqP5M6gxb39cU9Vxpnhf2XUSUeNH8cxqEXn5
 L9HQ==
X-Gm-Message-State: AFq9FYKkIvAXu6KzggoBPio8iFgY8IT4MH7Lmhm4m4hDr0Cnhbq/8B/0
 GGbsp2A5w6APk0t+rlF0aWXEWTK1F6oXApi5IrZDNJGuB8WbPnhvS5ykSy6T5osTj5Xiaz6HxUn
 G8GZUrGinJ9ELHMQCfGGgeAsb7imQi0A=
X-Gm-Gg: AYBFou2agj8CLAldKFoXboM5DChhhAbsIxONQ0pTq9UvX+lx0xpbGkG9xLWSWOQg5Os
 ODQ6w9Ot3IXdvQ+UIi3ks9EgNTLEkOH8HFVU+6c5q1MqNpP5znUYVjV5zfzf/I68N3Q3D44alJk
 8MzR+IXKWJslB+FCHJNIz9pOd4sz6yB328Fnw8dszLCpmHGBOtC7vmLPRUP/Rucv4uZ9EimTniN
 Hgav5FZVWDiM9CIc+JLFxBZf2iRAFfC1iFQhVfZjAwJIzAP4+Zqjj/iqbE1zowb94cpGuxAW9Qs
 T8aGT8wIwknwpVgtA4wZHVHT3vRXb9C2q7PKRHfoNNhtDakCZ/vbQ+o2l6Xi38exd/XuPxDMAXe
 /0r/wfJ8/Uf22CrqYs9LjCkempowqgv/p++H88NpGvaQLjWpOhWRcEsnetU0tmaGLOmncNVfN10
 tTzSjbXSjNJPs21/Uk3w==
X-Received: by 2002:a05:651c:1444:b0:3ab:5423:dd80 with SMTP id
 38308e7fff4ca-3ac6fce6af2mr19045971fa.9.1793024438417; Mon, 26 Oct 2026
 07:20:38 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <1d0d70c48d2486b06c57edeb56d68341bb02145f.1792893601.git.mateuslima.ti@gmail.com>
 <64aa14e2db0472120fa3a6ace2e326ccd0d548ac.1792893601.git.mateuslima.ti@gmail.com>
 <20261026004529.GB329625@bill-the-cat>
In-Reply-To: <20261026004529.GB329625@bill-the-cat>
From: Mateus Lima <mateuslima.ti@gmail.com>
Date: Mon, 26 Oct 2026 11:20:26 -0300
X-Gm-Features: AclHuK_F5snRMVd4VhHtB-hu8vQahIFSLwPpJ00EGYAKXArwVb6HvPuSPOIx2KI
Message-ID: <CAP8WwTHquzoOnf8hRORFyz0hE3r5SOTxSuK78wd_E3jGQcX_BQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] configs: ls1021aiot_sdcard: Reserve 1 MiB for U-Boot
 in the SPL memory map
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>, 
 Alison Wang <alison.wang@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000b9be71065ebf086c"
X-Mailman-Approved-At: Mon, 26 Oct 2026 14:44:43 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000b9be71065ebf086c
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 26, 2026 at 12:45 AM Tom Rini <trini@konsulko.com> wrote:
> Please follow-up with enabling perhaps BOARD_SIZE_LIMIT so these issues
> will become link-time failures in the future, thanks.

Thanks, sent as "configs: ls1021aiot_sdcard: Limit the U-Boot image to 1
MiB":
https://patchwork.ozlabs.org/project/uboot/patch/20261026040403.1863907-1-mateuslima.ti@gmail.com/

Mateus

--000000000000b9be71065ebf086c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Mon, Oct 26, 2026 at 12:45 AM Tom Rini=
 &lt;<a href=3D"mailto:trini@konsulko.com" target=3D"_blank">trini@konsulko=
.com</a>&gt; wrote:<br>&gt; Please follow-up with enabling perhaps BOARD_SI=
ZE_LIMIT so these issues<br>&gt; will become link-time failures in the futu=
re, thanks.<br><br>Thanks, sent as &quot;configs: ls1021aiot_sdcard: Limit =
the U-Boot image to 1 MiB&quot;:<br><a href=3D"https://patchwork.ozlabs.org=
/project/uboot/patch/20261026040403.1863907-1-mateuslima.ti@gmail.com/">htt=
ps://patchwork.ozlabs.org/project/uboot/patch/20261026040403.1863907-1-mate=
uslima.ti@gmail.com/<br></a><br>Mateus</div>
</div>

--000000000000b9be71065ebf086c--
