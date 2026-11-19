Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C35606A331
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 23:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W9JMUiHV;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=YU+Qu8O5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5CD9C60E22;
	Thu, 19 Nov 2026 23:33:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G4PBou-vMpsE; Thu, 19 Nov 2026 23:33:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8E65060D98
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795131214;
	b=oC0677L2MRGBMMCqK58TwUPXZpbsqRLbojyUwSkG6SMRXW+wbsxu/4pINAhur2u36+7C
	 8Xdr5EYArPQMYX0YQEbDz8ib62NX618NbvHbZZ7/PkgH6Qr+Pfj3eeQ3E0gWonk4Yxskx
	 /jglAr+gO8WkoZGDKiEEZ1UL42vXk0S+sDIh9t1ZepKQbxHO2r2dI89lrKuRd+Pvoie72
	 lt3GTvJblGLWgDNrgmeYfvl3C0O7tj2RfvPkNs91OM71QEJX3qS0pkdOncmHGOS7EbkvL
	 qV2ybORvhH5wRuLrCcJe/pArRdU0240YM/7er8YkP4F1bK0qIjmLCIP/lzULj091JLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795131214;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JpmLG4z909WVZg2X5oJgrTf145jYFGeNyl7AcXoZ4B0=;
	b=YEN1rgnrRWwaCQ8dw3WjUfvoIj/3T6nh+FPIMscefnPLrWijNXqfUicJro7Jgliowy5k
	 5v7yu8FD/4WWix3Ox72Jn/GG98SeZ7fnOFR8vy+663d3CfbVWXvtER08TyZMQdps8xgB4
	 QsBU72Ec+uYCwUcPo+JnsAba43w0C3AfElXN6ITFpUib9PfB1BEmBZpBpjR7ghz90mjim
	 ll/kwMAbd+LSyBcbmcjBjTkvfYfp2w87FA4LP3G0wFtnfozCJUuSZptRvlgXAwp+nKVek
	 jQXiRLo2DO145X/CmpuA6XRpGqiRW7Gn789ZQAEQu7/CAA1Vmct0eXHsa7eezU/JbmA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795131214;
	bh=JpmLG4z909WVZg2X5oJgrTf145jYFGeNyl7AcXoZ4B0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W9JMUiHV82wMQ0KtInwibtdT+SVXpr+Sx+ClwsmLm49Y2cc0niNxr3ZAPxcFOq+gA
	 HG6eb71rGzrwab7Nydje8giRNvg9wuIbvsB39GeO93XJ65uJbtbpvNUT8Kh7zRtPdf
	 MwSjEkO1AVCzS5Ctkw85eO9q6HMPV8tx4W0A5yKJyeoVbpcXqzO0ZatqMdLZiHQYME
	 brIG83rsmVX9ApwxFW0V7FFBnFfdjB71R/oZDMdawh+mtqLAq73NBaXKLyzz4SdY7R
	 PZ003nGmNiHbk+olO1mupAHOfRxC7TVNoaiRarDUmcxnnml578wm/24c94KbYffS2R
	 VYiK/F8YTEHow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8E65060D98;
	Thu, 19 Nov 2026 23:33:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id AE7CB3A8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 23:33:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 944D640087
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 23:33:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DMQqJXKzpoBL for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 23:33:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C860B40079
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::231"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::231; helo=mail-oi1-x231.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=YU+Qu8O5
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C860B40079
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 23:33:31 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-571eb508edaso154366b6e.3
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795131211; x=1795736011;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JpmLG4z909WVZg2X5oJgrTf145jYFGeNyl7AcXoZ4B0=;
 b=YU+Qu8O5/DCip3rMBz6H5hsLAt/fB8HluiE3+pGUDoKvtiaXBAKU5tE2UD6jjcCa4d
 Tp6sprhurGsAmtQiL95r0O288PiDHKZZyZqz2/8cAgzi79eWtLKqos13zxlC5hyprq+L
 ECeY4wpXuvOc8H1qqEtkLFqfudJOeKgkhTySuJzE5bVdxCegyrVdtVjqS4KULRh50S2g
 vgpa8KZrfpmHZOtDRkSsmXjQDrUlrrI1/fK674Zi65M/D9vfMySIuNpY3FrX95QewLoQ
 Y6MvzufJdHLInV18vLWz5uId1u7x+DhNph9FNUbJ+H7D7mJ0DLw6cBoz/4fccUoBlfmF
 GP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795131211; x=1795736011;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JpmLG4z909WVZg2X5oJgrTf145jYFGeNyl7AcXoZ4B0=;
 b=yHEsYtb4vxIJRzi24gZdIFEQiWhJohRCQig7DvgeR+9HF1ysH7wZtVqZCOTn5hRvRu
 l2INh4s1IUN1rWDYrfR9Iqo+xiONLQxfDX+3IGeiTiUpgFwoU8OyhJT2NoCpfz3rAlN+
 J3Yg7LXWoRpTVL1KQQxiFDxCs54dQA8EQuI/SOKMDmoqnI2Fo8v6h4pcvbQQIzfV6tWO
 UhnImebP5AuU/8+bYZmiBgG/uHZg4vP35bdViEDu9Xz2lMgOO8IoSIdnThptSv3IAyyK
 PSZguwiWCWNYYQ08oxjfp0VziKUCgff8Y7AetTKtuMvCB7zOiLUWOEtPrq16/wVM3cEQ
 z1RQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFEQ3Uw8c6onpAakaYyD3i8NIHVepHTFXq8UgU2kSdcG54UZ7ZJ+Pua9nQGgMQXXpd1R8Gf+rI=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8/0ndRcb9qgkzRQY9UnH8IjboDIuSTO0zaQ7cDnDm57+blHc3z
 YfCV35vvNfZQUsWg/NZkv+fFQxFvcmT6pn/AOY2XtS83Mb2T/QipzOKboU5wVKO+BwXSyaKkn93
 D8NHC
X-Gm-Gg: AYBFou2BQ6CI99brJT3E7FPuqqXdCtLR37iTuTIawcOqymdbb3elM2dgV+tWED0FOCf
 tAos1QgKusMIOz89UcVTpEbgNcEoK4GqZKSCO78GqOVpgcnz5UpTClldi4jiAadMLwuiOOMB4xN
 B8qkCR/3ukV2Zv4+T3/1Drh5LgzutftaW/oqu9GblJ2F9DSP8gl1N6R+MzQpnfouClD0duIOzjA
 K+UYGn5MFhAvidy/LJiP7cw6LLRD6itepvPLh9m1ToUMuZgHzKRuVXLKnKr8uhE2zrp1QDbgwNg
 kwpErs6vO4vppFayf9+3QPGGUYTmLjmIXxYwvir8T5p9qU4Cja89HY0f3p3aJnRLZY09JLLWch9
 XM/DwLi0wxoEoxzUiIvfmokTYlgBCezC5qZj9gSsGHfoTuKkPrwMlOyy0VpAogVbXTUpmDEIou9
 my8UBzCphEKf+aNCQZizJ+87ZHbn4M6+FtSdyQ4vpDuYii/bQLSLm9i4KXEPlNpLEH+xi+Icbqw
 u6rLYJaGrGFc1pN0Ov2BNVxYmGK/3euXEfYT1AdiLjr4kBxvtVAHya9Waa+65RGbRs0aLUmHcxq
 RX1PXSQcbBkifTVI1BuHJMRoi/gCB4kiVDN3Ede83l1TezSlEZj+DFU=
X-Received: by 2002:a05:6808:1907:b0:574:6f37:6721 with SMTP id
 5614622812f47-57a0a930350mr2210839b6e.11.1795131210988; 
 Thu, 19 Nov 2026 15:33:30 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:43e1:bc37:7497:58db])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a34250ef2sm813561b6e.3.2026.11.19.15.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 15:33:30 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/4 RESEND] binman: bintool: Add PKCS#11 HSM signing
 support
From: David Lechner <dlechner@baylibre.com>
To: yan wang <yan.wang@softathome.com>
Cc: sjg@chromium.org, alpernebiyasak@gmail.com, trini@konsulko.com, 
 alchark@flipper.net, paul.henrys_ext@softathome.com, 
 philippe.reynes@softathome.com, marex@nabladev.com, raymondmaoca@gmail.com, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261117095322.16813-2-yan.wang@softathome.com>
References: <20261117095322.16813-1-yan.wang@softathome.com>
 <20261117095322.16813-2-yan.wang@softathome.com>
Date: Thu, 19 Nov 2026 17:32:57 -0600
Message-Id: <179513117714.2216103.5929570806522249638.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4417; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=8yo9VSuXsjy9U14aGyP3MlukFIgN9HcHQaXhljVI0DQ=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/4ctOs3EuAgBd4BLyGF/w10ia+hOS9H66NRO7
 uzzAWga70uJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCav+HLRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AEagH/2tzXVwkMvae6hPQG5sP3WmEhyrCrs1BuZsVRkX
 REquFFG/iU590j51/PbcNveLbQZ9arFfYWWUqVP7yxQD6tf+I8NobkmQVyFAttP4uDZD0OB4Vys
 g5seIb4QwiJAwELidsON5Yt4GDqKiF6AKuB87s2SOPHHz/dbD3JtsrfEmp/0YEFfu+yeHBRRlcp
 Z5gRKD91WP8MZHPtsVc3iUPF56+nlPdCJGpcrkj9W3deipfH+Jso2WANIo5e/iErUq6TqFs2RLD
 GJNIjI8uJtnV8tpHSZVtgaRl6I+SKXIxLYXctmQAeVjcdoeBESJxC19/ZxpzNpxXycaMpJK8m2T
 2SCY=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Implement signing through pkcs11-tool using the PKCS#11 interface,
> allowing binman to use private keys held by an HSM.
> 
> bintool.py:
> - Add an env keyword argument to Bintool.run_cmd_result(). The given
>   variables are merged into the environment of the tool. When
>   tools.get_env_with_path() returns None, start from os.environ.
> 
> btool/pkcs11_tool.py:
> - Add _build_mechanism() to map hash, signing algorithm and padding to a
>   PKCS#11 mechanism name and rejects unknown hashes, unsupported algorithm
>   families and names that cannot be parsed.
> - Add _verify_mechanism() to check the mechanism against the token's
>   list from --list-mechanisms, selecting the token by slot index or
>   label. It is skipped with a log message if the tool is unavailable,
>   exits non-zero or its output cannot be parsed.
> - Add the public method find_slot_by_serial() to resolve an
>   HSM token serial number to its slot index;
> - Add sign(input_file, module, output_file, ...). output_file is a
>   required argument, the path where pkcs11-tool writes the signature.
>   sign() accepts token_label, token_serial, slot_index, key_label,
>   key_id, pin, hash_algo, sign_algo and padding. It:
>   - requires a token identifier, a key identifier, a module path and a
>     module that exists;
>   - resolves token_serial to a slot index before verification;
>   - falls back for ECDSA to hashing on the host and signing the digest
>     with raw ECDSA when the token has no combined mechanism;
>   - requires a PIN. It passes --pin env:BINMAN_PKCS11_PIN with --login
>     and sets BINMAN_PKCS11_PIN in the tool's environment, so the PIN is
>     never on the command line;
>   - raises RuntimeError when the tool is missing, fails, or writes no
>     signature.
> - Add opensc_version() to read the OpenSC version from the 'Library' line
>   of --show-info. It is a best-effort check.
> - Add _check_opensc_version(), which refuses to sign with OpenSC older
>   than 0.15.0, the first release that accepts 'env:' for --pin.
> 
> bintool_test.py:
> - Import hashlib and add a _CmdResult namedtuple for mocking
>   run_cmd_result().
> - Add helpers _make_module_path(), _make_output_path() and
>   _make_input_file().
> - Add tests for mechanism building, mechanism verification, slot lookup
>   by serial, sign() argument validation and failures, successful
>   signing with slot index, key id and PIN, ECDSA with HSM and host
>   hashing, the no-mechanism and no-PIN cases, OpenSC version parsing and
>   refusal, PIN passed only via environment, env handling in
>   run_cmd_result(), and token serial lookup and resolution.

This is a really long list of things done in a single patch. That is a sign that
we are trying to do too much in a single patch. Can we please split this up in
to smaller logical patches?

> 
> Signed-off-by: yan wang <yan.wang@softathome.com>
> ---
> Changes in v3:
> - Make output_file a required argument of sign(). The caller now controls
>   the path; the bintool no longer creates or removes a temporary output
>   file, simplifying cleanup and letting the caller keep the file for
>   debugging
> - Add opensc_version() to parse the OpenSC version from the 'Library' line
>   of --show-info. It is a best-effort check (returns None on any failure)
> - Add _check_opensc_version() which refuses to sign with OpenSC older than
>   0.15.0, the first release that accepts 'env:' for --pin. Older versions
>   take 'env:BINMAN_PKCS11_PIN' literally, silently fail or lock the token
> - When tools.get_env_with_path() returns None, fall back to os.environ so
>   that the subprocess always inherits a usable PATH
> - Add tests for: OpenSC version parsing (valid and malformed strings),
>   version refusal (< 0.15.0 raises ValueError), PIN passed only via the
>   environment, env keyword argument in run_cmd_result(), and token serial
>   lookup with resolution through find_slot_by_serial()
> 
>  tools/binman/bintool.py           |  10 +-
>  tools/binman/bintool_test.py      | 650 ++++++++++++++++++++++++++++++
>  tools/binman/btool/pkcs11_tool.py | 379 ++++++++++++++++-
>  3 files changed, 1032 insertions(+), 7 deletions(-)

And > 500 lines changed in one patch is really hard to review. This is twice
that. So another reason to split this up.

-- 
David Lechner <dlechner@baylibre.com>
