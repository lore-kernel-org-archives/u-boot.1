Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8685CCA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:00:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39B2E406DB;
	Mon, 28 Sep 2026 15:00:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CzH9dfggESrN; Mon, 28 Sep 2026 15:00:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1B16A405C9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790607633;
	b=RH9o03JEPPoYfb36c2KKIoEq3J/uuBEKhOkKY0DKZF/FwDBXwWa5T6MTsZM8DrZgsTgy
	 /Zers8FbUKM8ay7GKoiB3hIWzX2Rumo0kbWGiTdl5s38csf/61dzE0zGgfLNvYP+Xz5wW
	 86XBRZE5G2RrmII3vAor6Pe3E9fvATPnfCVB/FI3bBKwgFz76w92ORFQVbWC90/4sD8rw
	 dq4/BsKiygbNzw7SgPebZEWzQw/VC3ReDdxxT5RIVo1AjuZbGCvoR52VbUVR0r0o99hSC
	 kdAmMFYMLtlH5OgKgkhkz4TkBwnxeZkKpmCvl9GMAN8x+S3rAl1PEuK/hPAMjwpkdYw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790607633;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Bx45jCcTaYj5XJX0f/8l7Bk7+Z+meqPK818Epnbulpc=;
	b=FXxx1gEGDJE3hS3P9SqJ/sIvZiy/OE/nqMr6q44TULSaBed+RbJJjCjmLFMl38WvrawR
	 5u7F/wdMA4v9TBFfNklo7kUuENkSt5s+s+W1Cx9eBFAz1RR4dSrRl+ThO4CtAGAZqdNTa
	 6ZQmUPUM8pQbWrg2UYVp8HXqnjlwVORm2LcdoONJSEb8I3JMxRGDR7IjuD5GH0fFoNF7Q
	 Xv4+TwntjrPKPsfN+Rf0Fx/lLtmEaHn0V8+q06N3y6XhpVZGzU4gNkBQgtPKro3VF45We
	 mnazaUceUKgND6QmqZIDkkDnrly/u8/WfGFem86B6ijLxe+vrc64NZ//6gEJX+yIe8g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790607633;
	bh=Bx45jCcTaYj5XJX0f/8l7Bk7+Z+meqPK818Epnbulpc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n1fLBF22OHu9fl6baBlKy/+BdjA9qgmsOUkvPoQ0V00Vg6J+lZ4U2+L5NBRk2kTzW
	 lyUnDy8p9fLvqsXoCtQnMELdhpfFj0lXuJmiT7eB6vqY6lxY9/NnufR57XhgOiH1L2
	 Mh+vOyr7Tg+EzPlk38wDQfWJqGy+IIJzWMt3hy2PnU85/wX6UAKMgqDVDRSNwPTHo9
	 MnKBYU7sDsFj4pVmTybrjC5pTR0vHA0f4kWYNT1Pu+xkV7vKZQHI11WfWjWm4LKi8B
	 ESgBRZL4Jffug8zqrq7fVz8ghsqrTTrGINBOgRXU5ZJ/QSBCfwrnDL/hVKweMRrWzh
	 ZkAerXPCGcBwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B16A405C9;
	Mon, 28 Sep 2026 15:00:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9AA7E2B6
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:00:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 804EC606C2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:00:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ifp_Hl0Wdua8 for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:00:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 56FE46067C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790607630;
 b=szXQvUzJhGzB5Bwcg6GjC6XdBDyJhIthJQNKFhP1VEDjJmaKjafa8g4fiKWxO52WHBKH
 Ixp6TShGRlX/II/mnULqQTpgyJHcEykj08OoDkLWWSGVPFVJtrIzC/oe/IV9Q8ny+BVy3
 wIw6kkOH+KIC3CTXKUjqtw90LjV/3SugwwDX/wptpX6pXbGbCx/k/i/cMOF2bi4VvPVVn
 kSJphn4KeCcAb6W6/Pd2OxGGurvBOPmFen7dMNdz3ugcgxwDa94v1IFGDyu6psYL+Qoyg
 qdLWvHUJS3oKm0k5GRVHkX+cVPFKjxwnt4X4NbX+/GFN3oalt1RLycfqR77FSjZTiww==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790607630;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=Bx45jCcTaYj5XJX0f/8l7Bk7+Z+meqPK818Epnbulpc=;
 b=fDqq4UCYZgeG1vlxU9mxhBsvw9CMzIpkGHLvi2W0vlH2pMbrkIkEo/74HEZ9kmXTlHo+
 qC6qDQw0d9cBqW30gioMpX4udPfKxKXnXxqI+jIfSuOJq+lk5gyV+eKXfNNJ1rGxHLC6P
 S5aU9Ikwq4nCcT6kliqI0PIKan52Thi4tyLzeU9OsnCOFxMoYeh0PlVNt5cBHrTjjsg9i
 2pcpEbYmo1tvDwY7XKy2r/+LeVw5XPvbsPdsh2JtRibHgrG90eoNpHC4ziop7VtKclGPs
 CKCivEiNUSGFPvRWd9YC2tfhyaCFkCL8iyU5dRk5a+3HgU45y6XZKwMd/qwTQBOYZxg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=JnKxctoV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=JnKxctoV
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 56FE46067C
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:00:29 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a9984f9adcso5319079a12.0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 08:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790607627; cv=none;
 d=google.com; s=arc-20260327;
 b=q4BdvM7pLSbJ1Ctwb1V3j0OweGs7epfknSwuUs4XcOtW/h6VpVULU+YaOUZQZ36GS3
 Ej5G6FpkW3BS7ahHIr6OsrfMDccfh8IfbbghUTqFdfSmq/HlpUHMDLPn334w3Hdd31qg
 bONUP22w7kgGrGu4xT9bePuJrgFP8Eut2CjjiepQtv+6Czqp6rTd4ANmWa/dahlwxULu
 vXzblZ2mCNctNFWdfOkpIqNcsedYOA63MVDONPLSXuOOab8S5QFPSCtO7exeNRuq8/u9
 VO8+RkodwDzZRNtoUzd5VJTsMGZEMQOPcS9Mu8TIoe7zvCILAYrsivXofBF77SdUAlxn
 dQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Bx45jCcTaYj5XJX0f/8l7Bk7+Z+meqPK818Epnbulpc=;
 fh=lFEvJiD09eFkjC0zjxFrJW8v5KPieVD3ZcMao2sBQCU=;
 b=G4Vavj+Xn4AfyrAXbc4zP5pqOUOwREdHBx6q1qGdN7Uk2vIGcLo2mfJA7nlq55qTmj
 MK+Qd27XTJ0m+QVMYDoS+Xu4/PBWOb9HjMOB5bk42mIE/FCgF9hSaNLQHKO0/d7iqlV6
 x1wVU5w/eWPbXoJaN7KpSYFSTHiu5m37b+ZUQADo/dnFuy74Y5K+BMNXW3KeWB/QLSgT
 m4K6Jj2eVc5uQU7w13of6h08v66Hmlr7NBkQdpgL6UvopQD18Sy8qnaPrZVmYD3G2xL2
 MLoaq+ZyU/8NATaoBBCXxzCfbqiymlHR27nmLlxh4v2vR/szT6Mq+FaumyQd1F07ecoG
 iGsQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790607627; x=1791212427;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Bx45jCcTaYj5XJX0f/8l7Bk7+Z+meqPK818Epnbulpc=;
 b=JnKxctoVK9tk37Q/luUEGFiBjPsnUwzge4anqncSj5Qb2FfdfQD+l2toAvmbwaTSeY
 pQBD7CMGavg8VdypB9tRrq2r966q3tzT+Krqq0txBOfHzzSxb3rVU60A0gs0eaOoWtmT
 07yCnbzT9JYT9P2sRqLOyrH9ilfvchup611SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790607627; x=1791212427;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Bx45jCcTaYj5XJX0f/8l7Bk7+Z+meqPK818Epnbulpc=;
 b=wmwNaB6nj5R7Sr462rdp8OCoMaE62TkhWQoECEXbR1TTRZ+9K614WY5wt3GlXweQnB
 k51VDKcFZCas8PjqbMfUywhYLSLmrMgBfQse0nQdNrTygNvNkgnKkLeIwHfPVeL51r8G
 vIEsqkWHsvGj/HgplLmPh6gw7xWmrdCVWI8OZSlGg8eZzxgzzFMM8iHdZTgudi/Z3jRL
 njmo36c3UYJY0de4/O/ckr2k+NVP+YP1R0TZXL8n2egcpprlfdqJTjp/3/DjVfAUsjpV
 gjxwk7qYMOHSrGAfH9ZMJPR+LATLjIWLVoduXxEYSWuezDEWYOUYXZ8W1oHjafswbCJt
 o+wA==
X-Gm-Message-State: AFq9FYJunQwEAuB2SEjISNmMTcnjmIPlHErSq2FcFH2WTqTAq33cM1iM
 zt9DFGog4YWFAL/YQCvCb9AWOBfuWbJGNTiPHORc3VJU5RxQGNXnWyXVUtzEBQZ7a3HZvsRumZq
 uglzNrqlFTYPEab1H//CAVdZ467t3EKHKMHCOlh1s
X-Gm-Gg: AYBFou1+e9vjYIKWEaqxojepl4qxfDOL6FU85teqcdcPJ7IUeYZOHbAJ4fj/787dmY1
 eTKFPDXQ3wE2YUBs2STorZValgm/Z9P+QyqwvbvojbTrdeweYGZDAFgfvRQzASU78bfJX27Qu1p
 TRZq2f4VlMaok8R61GuprGXO8lxvruvB+DFU1y1PFdRisIfa4+H8pgYCPENLnDFedW3jn4mZvy+
 47hkW3HmISKGCtVtFLn8CJXvz08Fo0IkaMjGYg+h6+zkP/bf/Iv5vhiBRSfjumDdIRKQenPgWL3
 J2hLRCOa4ELs0O0YkHI5hDA2KT6zM/3lPwpv+EJK+/YGS5ox0Gft7Q==
X-Received: by 2002:a05:6402:c2c9:b0:6aa:f1d2:ddce with SMTP id
 4fb4d7f45d1cf-6aaf1d2e0ffmr5060651a12.21.1790607627545; Mon, 28 Sep 2026
 08:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260917065545.1989088-1-lorenz@sigma-star.at>
 <20260917065545.1989088-3-lorenz@sigma-star.at>
In-Reply-To: <20260917065545.1989088-3-lorenz@sigma-star.at>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 09:00:15 -0600
X-Gm-Features: AclHuK9e12sP55q34FmQ103QPTc5tGqxZYD1gX92zf9CZbmbX1BMR27pqIdmM_I
Message-ID: <CAFLszTjDZNdPuK=Y81Bknfyd8rqu8ELgbpU5ZX7ERgqqpnWafQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] binman: pre-load: Allow signing with an OpenSSL engine
To: lorenz@sigma-star.at
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, upstream+uboot@sigma-star.at
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

Hi Lorenz,

On 2026-09-17T06:55:42, Lorenz Kofler <lorenz@sigma-star.at> wrote:
> binman: pre-load: Allow signing with an OpenSSL engine
>
> The pre-load entry type imports a private key from a file and signs with
> Cryptodome, so the key must be readable as a file. Keys held in an HSM
> or on a smart card cannot be used. The FIT entry type is not affected as
> it delegates signing to mkimage, which signs through the OpenSSL engine
> API.
>
> Add an optional 'engine' property. When set, sign with openssl using
> that engine and interpret 'key-name' as the engine-specific key
> identifier, instead of reading a key from 'pre-load-key-path'.
>
> For the pkcs11 engine, expand a 'key-name' that is not already a PKCS#11
> URI to:
>
>     pkcs11:object=<key-name>;type=private
>
> With an engine, binman never loads the key itself and so cannot check
> its size before signing. Check the length of the resulting RSA signature
> instead, which is the modulus size either way.
> [...]
>
> tools/binman/btool/openssl.py  | 28 ++++++++++++++
>  tools/binman/etype/pre_load.py | 85 ++++++++++++++++++++++++++++++++++++------
>  tools/binman/ftest.py          | 12 ++++--
>  3 files changed, 111 insertions(+), 14 deletions(-)

> +    def _sign_engine(self, data, hash_name, padding_name):
> +        """Sign data with an OpenSSL engine
> +
> +        Args:
> +            data (bytes): Data to sign
> +            hash_name (str): Hash algorithm to use
> +            padding_name (str): Padding to use
> +
> +        Returns:
> +            bytes: Signature, or zeroes if openssl is missing
> +        """
> +        key_id = self.key_name
> +        if self.engine == 'pkcs11' and not key_id.startswith('pkcs11:'):
> +            key_id = f'pkcs11:object={key_id};type=private'

If key-name is absent, self.key_name is None and this crashes with an
unhelpful AttributeError from startswith(). Please can you validate
that key_name is set when engine is used and raise via self.Raise().

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -78,6 +98,7 @@ class Entry_pre_load(Entry_collection):
> +        self.engine = fdt_util.GetString(self._node, 'engine')

Embedding the pkcs11 URI expansion in the etype ties this generic
engine knob to one specific engine. If another engine with different
URI conventions is added later, the etype grows another special case.
I'd prefer the etype pass key-name through unchanged and require the
user to supply a full PKCS#11 URI - or move the munging into
openssl.sign() where the engine-specific knowledge lives. What do you
think?

> diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
> @@ -115,7 +167,7 @@
> +        # An engine does not expose its key, so infer its size from the signature
> +        if self.engine and len(sig) != RSAS[sign_name]:
> +            self.Raise("The key " + self.key_name + " don't have the expected size")

Worth a short comment noting that _sign_engine() returns a zero-filled
placeholder of exactly RSAS[sign_name] bytes when openssl is missing,
so this check silently passes and the missing-bintool path is
preserved. The placeholder-length coupling is not obvious.

> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> @@ -5903,12 +5903,18 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
> +        with unittest.mock.patch.object(
> +                pre_load.Entry_pre_load, '_sign',
> +                side_effect=AssertionError('signing should not be attempted')):
> +            with self.assertRaisesRegex(ValueError,
> +                                        "don't have the expected size"):
> +                self._DoReadFileDtb('security/pre_load_invalid_key.dts',
> +                                    entry_args=entry_args)

This belongs in patch 1, where _sign() is introduced and
_CreateHeader() is reshuffled - the test would have caught a
regression in that refactor. Please can you move it there and keep
patch 2 focused on the engine change?

Regards,
Simon
