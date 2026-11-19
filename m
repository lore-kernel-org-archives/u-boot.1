Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D217B606A320
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 23:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0OgarS2u;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=UaeBfV6T
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7AF1C40E05;
	Thu, 19 Nov 2026 23:33:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IKPpnJc1xZTP; Thu, 19 Nov 2026 23:33:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 64CE540DAD
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795131218;
	b=EurZOOv37vqmlZyL8Fo8TyIPFqso1Hc+sgvnZgk6X4IFtLR/ez0SH0yxXTcx+EVGi4eM
	 SXaNidOw1lgy6mGqSxOTwxd8468bnulKPUYdx40F9hwr+VSy5a+QF3wGuWLc/LOBrWcin
	 TdYNJS3SFjLp4a2vL6QDqDJpeObkus4T6HUYZX8T08MgpmnLE/IH1O2okt3Stx9b9gtC2
	 aEICcE7CmITG+8lLyipacFhifVisUCEuX0TkQU8N6nxG9nnTKVKn1Um/Tk5KTTwAiHqbc
	 Ybum0fJRfx/0hu+/5tl5Z0LJMgTkSpVJ2HHRpbiAnIi+vnECU6CKBwSK5H0rNjBfbww==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795131218;
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
	bh=g6BnY9EzHb3bs5Cf6HA+AmFsauRd8X3MJaC5bXVCEoM=;
	b=VoOMhxIbZJzlkuOK0vfucyfl3ZC/vJLd9MdGO+sh3eeFT6Jq/0GMilvGITgVa6oSXsLp
	 fI9H573dr6/LnM8xuBW7B2l8zZ7hvRB0B3rLQo7TO5GjpTPmlXW0TjH6I6OrKINIeKzJU
	 50EiAT397r0CfSsiubD7DnX+7lowPHPxXJu5AIYiSYo1yM86shIYzYMMjxePm6gW6/Cjt
	 e8sPtEoDvKuVwsi7EWJMhjqQtCWg3HlCU1cH+6MBmB+MtAl3jsw4PRYw7OkvKApfL/YU0
	 dTaVN49fGfupx1TeXYhxcuHGzgczHaCSo+S9GidYoCv5YJfcT4iHfThyT/Xx0TgRE5Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795131218;
	bh=g6BnY9EzHb3bs5Cf6HA+AmFsauRd8X3MJaC5bXVCEoM=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0OgarS2unepgV2WznymLVv9HBbsnLPwmczgHHo4UNPpb2pMtSLkvsb7Vtq8jt4DNe
	 8nGR+6NsCkqffIj46cCeme9Af7Didd+Wa/LgolMPORaT9e1AIqQmfQAfWSzq9WFkYc
	 llZzRtOifYKG4NVgO/8u5aIV4c9BXrm7Ik9IFJ8EtHaFDrLKzRlFxT6BxjZyri7slN
	 aJf+A1ha2sjlO6zuiHDgpMxjdbWR/QoPMvPLCwnX/rBBkIMFKMBzS0W0jggn5qx82l
	 zOL8k8w2uPlu0oZDk10pOMrkfOj2x8AeXcFKix63aLxaFqpXql3rMViM2JmdYtI4Ls
	 d/B4GHwmmwSqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64CE540DAD;
	Thu, 19 Nov 2026 23:33:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D8EAB1E7
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 23:33:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BF3FB81380
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 23:33:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PL2jv1UC7OoV for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 23:33:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 774F28130A
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=UaeBfV6T
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 774F28130A
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 23:33:33 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4d198f1a591so326952b6e.2
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 15:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795131213; x=1795736013;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=g6BnY9EzHb3bs5Cf6HA+AmFsauRd8X3MJaC5bXVCEoM=;
 b=UaeBfV6T1AIiFofkhYzxn9MhHIHye9w5BGgeQah0TzOUxpUg3i+qUXI0YIeNsOB8cA
 wkuWoSK95aL4jPDiteknDVGfuT8bOe5007eY4RLCHRQ7jwa0IYQLZ+LIp0pGIFjMMrj1
 9W+/tgmfEi8E9V8OF76qSv1Y7XcoWlxUwR7/36xJvd7d/wF9rO8Bb5RP0ljppAJRli/J
 3HxgR41OuSuwtnX2xlvj8sYrkRT2FkneymWEY8sKdEw9kwj2AVvVuIIToUU+ajCCmPyO
 /K+hbqiXiU3FnrgQcuqp+2hZASjMbLnbk3K6u1EG8T47iv4peR53hNfgNTT6HjpXYnbd
 W3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795131213; x=1795736013;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g6BnY9EzHb3bs5Cf6HA+AmFsauRd8X3MJaC5bXVCEoM=;
 b=v3Jc7QUo20bWKHP0CGnDj4eL/8oYEh4YXJujwroJ9AzTY0618HBdS9JwZCyeo5EIsl
 VsuqNpTX67wl+644t2c/slFjTfr5qZKvljhRYgBfKKvSU05mxSyXhyL7naclVfpk4U3w
 UyBUDTRQavmvX0caEmKnYVIa2kjCOXDuNZwG/FsKNTdZXXqg8s777aNUNCt4waNJ+shu
 QcRa11H9p4K2AIP/pnzWbh0PBEPm98e/G5ldZARBejEeyfmLgYEedGcEoRtAs4Z+xY9V
 /XuRyF2FZtYhFV73wJIDWJfDObKrXRX7SuEa0P7Ne8E3/LfbMsBUbCg3GIY5TKbixdrE
 vSpw==
X-Forwarded-Encrypted: i=1;
 AL+hErHwgVCFot3hY8YaQLaGMVRsRfGMVyeFoDzpX3C1EAVwjFGIKPcGT2JmujGa1fAdp2blVbrtxzo=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/LeHlWiZyoUYasu0OxAqN3yQZOxuYHmfxHw47apmtxdHOmpwEP
 YDUmqz0adKvz9UynHdNrwCSbPFm9DardKIZdigTqp/Ve48fv+Z/7pn/50NULbtwNJGY=
X-Gm-Gg: AYBFou0YlIHM+J7IwrfMP60VAi0wz8v5BMdRj/26aTWx3r/WumeASDHTIbzRJJtDMFa
 v2JJ+0DcybWPqMVQAke1c4GcjasSLQcMnoiwliZuy2hvwPJdw8J4qU/VXBs6dniqI2zuRGMgxjT
 EqqwzsjTZp/u9hICjYhYkzfa6xkGh53faYaHjhCOS6c+ysxqhYgKMU5C4jZABhKeKyIYm2Omj5o
 q6y4bFBSsBsswSt6hj6LM47Z85E9hd9BzZfqVsvOHPH2ircOnV5AvZ1+8Z5BI/WkkdxLNNwjeas
 CiZteSOLR16hd4yReVI3X4iJ6lFrLj7PZdBotyVKlRyOsTisvq0OIJw3O9wOYdBqVk5SArp1Rcy
 dFv8kLCAtJ1LZsOb2m88b3ze/dOWGqNcx7aoZs8r/2miCJarrjEsxJrnVVS25JK8MtVrBgPcAqi
 o1OiQjRw2bUvcoGy2g2QjfNxtN/GZpBP8NxJQSxUySTNTnshhhjjZ2g5bKjfvbv7SF5Nb/87N82
 8mnJBL3QU32pOmSnhXbZwj9xDziKqPC4R7Njk+Sw2fFnuQhwqtfpduxoh82gh+SZgjma15ctHhi
 NgDBljH/CqYYR106M9wQB1Ihe/XCKiT3+Q==
X-Received: by 2002:a05:6808:c3cb:b0:577:2888:47b3 with SMTP id
 5614622812f47-57a0ac33d63mr1817919b6e.44.1795131213016; 
 Thu, 19 Nov 2026 15:33:33 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:43e1:bc37:7497:58db])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a34250ef2sm813561b6e.3.2026.11.19.15.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 15:33:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 2/4 RESEND] binman: pre_load: Add HSM signing
 support
From: David Lechner <dlechner@baylibre.com>
To: yan wang <yan.wang@softathome.com>
Cc: sjg@chromium.org, alpernebiyasak@gmail.com, trini@konsulko.com, 
 alchark@flipper.net, paul.henrys_ext@softathome.com, 
 philippe.reynes@softathome.com, marex@nabladev.com, raymondmaoca@gmail.com, 
 u-boot@lists.u-boot-project.org
In-Reply-To: <20261117095322.16813-3-yan.wang@softathome.com>
References: <20261117095322.16813-1-yan.wang@softathome.com>
 <20261117095322.16813-3-yan.wang@softathome.com>
Date: Thu, 19 Nov 2026 17:32:57 -0600
Message-Id: <179513117714.2216103.1816933711277143464.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6784; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=Ye9ZxmWrAnRc+Ho8RTsBkBxr2p8gQcScnbjiBoK5Nq0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBq/4c0WVlAlGBRyNmdd3GpHUwKYD+KXQ5yfxYfP
 84YsJMJsf+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCav+HNBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A85YH/2XW19+GmZeiWVnp56uCmS09ohR+KY0aFFcXs9g
 wz3RQ9Y1VUnTnmsFU72uWzG7Xfcx9A+QJgwyZ0+dqV6KXT0ar786wQxjtKgkASqYrEWW3p/74JC
 RdbzMo/0N5HSQcAoJlw53aYc7MX6FGyYBNnIRldSrEgM06YACt4wEQNlrDq3d4rXQS2AbMpi4/z
 g8lJNLuyGkDVIS38IJ37T7zOqqY1LuSqVlXIszqs8gHkSOPsTHpiPuVqZ5UIDmA13x8bhCCx5DE
 8kTFkN/cdeT68U9qgSZBo6iJtBgCl0/LUy3I+A1KsEuSDkNNYuQrQcnNwFjz7WuzhMu2VtSCuS0
 CqaM=
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Signing the pre-load header currently needs the private key as a file
> on the build machine. Add support for signing through a hardware
> security module (HSM) over PKCS#11, so that the private key never has
> to leave the token. The signing is done by the pkcs11_tool bintool
> added earlier in this series.
> 
> The HSM is selected with a new hsm-key property holding a PKCS#11 URI
> (RFC 7512), in line with FIT signing, for example:
> 
>    hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
> 
> The URI can identify the token with token=, serial= or slot-id= and the
> key with object= and/or id=. When hsm-key is present, it is used
> instead of key-name. Both RSA (PKCS#1 v1.5 or PSS) and ECDSA are
> supported.
> 
> Host-specific and secret values are kept out of the devicetree and are
> passed as entry arguments:
> 
> - pre-load-hsm-library: path to the PKCS#11 module (.so). If it is not
>   given, the module-path= query attribute of the hsm-key URI is used;
> - pre-load-hsm-pin: pin for the token. If it is not given, the
>   PKCS11_SIGN_PIN environment variable is used. The pin is passed to
>   pkcs11-tool as '--pin env:...', which requires OpenSC 0.15.0 or later.
> 
> For example:
> 
>   binman build ... \
>         -a pre-load-hsm-library=/usr/lib/softhsm/libsofthsm2.so \
>         -a pre-load-hsm-pin=<pin>
> 
> The HSM configuration is validated in ReadNode(): parse and validate
> hsm-key early, including the hash, the signing algorithm (RSA or ECDSA)
> and the padding scheme (pss or pkcs-1.5), and record the expected
> signature size.
> 
> Add _BuildHeader(sign) as a shared helper that calls a sign() closure
> twice — once for the image and once for the first header — and
> assembles the padded header.
> 
> Add _SignHsmData() to write data to a file, call pkcs11_tool.sign()
> with the pre-computed HSM parameters, verify the signature length,
> and record a missing bintool if pkcs11-tool is absent.
> 
> Update _CreateHeader() to dispatch to _SignHsmData() via _BuildHeader()
> when hsm-key is set, returning a dummy zero header if the tool is
> missing.
> 
> Refactor _CreateHeaderRsa() and _CreateHeaderEcdsa() to pass a sign()
> closure to _BuildHeader(). The RSA PSS salt length is calculated from
> the hash digest size. The behaviour is unchanged.

If I understand correctly, the previous review asked for adding _BuildHeader()
and doing the refactor as a "no functional change" separate patch. That seems
reasonable to me to not mix it up with the HSM stuff this patch is actually
about.


> @@ -77,6 +136,28 @@ class Entry_pre_load(Entry_collection):
>                  };
>              };
>          };
> +
> +    Example with HSM signing::
> +
> +        binman {
> +            pre-load {
> +                content = <&image>;
> +                algo-name = "sha256,rsa2048";
> +                padding-name = "pss";
> +                header-size = <4096>;
> +                version = <1>;
> +                hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
> +            };
> +
> +            image: blob-ext {
> +                filename = "sandbox.itb";
> +            };
> +        };
> +
> +    Invoke binman with::
> +
> +        binman ... -a pre-load-hsm-library=/usr/lib/softhsm/libsofthsm2.so \

Need to escape \ here or make the doc comment a raw string.

> +                   -a pre-load-hsm-pin=<pin>
>      """
>  
>      def __init__(self, section, etype, node):
> @@ -87,6 +168,22 @@ class Entry_pre_load(Entry_collection):
>          self.header_size = fdt_util.GetInt(self._node, 'header-size')
>          self.version = fdt_util.GetInt(self._node, 'version')
>  
> +        # HSM properties (optional); populated from hsm-key URI in ReadNode()
> +        self.hsm_key_uri = fdt_util.GetString(self._node, 'hsm-key')
> +        self.hsm_library = None
> +        self.hsm_token_label = None
> +        self.hsm_token_serial = None
> +        self.hsm_slot_index = None
> +        self.hsm_key_label = None
> +        self.hsm_key_id = None
> +        self.hsm_pin = None
> +        self.hsm_hash_name = None
> +        self.hsm_sign_name = None
> +        self.hsm_padding = None
> +        self.hsm_sig_size = None
> +
> +        self.pkcs11_tool = None
> +
>      def ReadNode(self):
>          super().ReadNode()
>          self.key_path, = self.GetEntryArgsOrProps(
> @@ -94,6 +191,91 @@ class Entry_pre_load(Entry_collection):
>          if self.key_path is None:
>              self.key_path = ''
>  
> +        # The PKCS#11 library may be supplied as an entry arg so the
> +        # host-specific library path is not committed to the board DTS.
> +        hsm_lib_arg, = self.GetEntryArgsOrProps(
> +            [EntryArg('pre-load-hsm-library', str)])

The documentation says that pre-load-hsm-library should not be in the devicetree
but this still uses GetEntryArgsOrProps() which would allow it.

> +        if hsm_lib_arg:
> +            self.hsm_library = hsm_lib_arg
> +
> +        # PIN from entry arg or environment variable, NOT from the DT. Use
> +        # state.GetEntryArg() directly, since GetEntryArgsOrProps() would fall
> +        # back to reading a 'pre-load-hsm-pin' property from the node.
> +        pin_arg = state.GetEntryArg('pre-load-hsm-pin')
> +        self.hsm_pin = pin_arg or os.environ.get('PKCS11_SIGN_PIN')
> +
> +        # Validate HSM config early, before any tool is loaded, so a bad DT
> +        # fails immediately regardless of whether pkcs11-tool is installed.
> +        if self.hsm_key_uri:
> +            try:
> +                uri_attrs = _parse_pkcs11_uri(self.hsm_key_uri)
> +            except ValueError as e:
> +                self.Raise(str(e))
> +            self.hsm_token_label = uri_attrs.get('token')
> +            self.hsm_token_serial = uri_attrs.get('serial')
> +            self.hsm_slot_index = uri_attrs.get('slot-id')

RFC 7512 slot-id is the decimal CK_SLOT_ID, not the slot index. pkcs11-tool
takes the ID with --slot and the index with --slot-index. With SoftHSM, slot IDs
look like 598648507, so a valid "slot-id=598648507" fails here and "slot-id=0"
picks the first slot. Please pass it through as a slot ID and use --slot.

https://www.rfc-editor.org/rfc/rfc7512#section-2.3

> +            self.hsm_key_label = uri_attrs.get('object')
> +            self.hsm_key_id = uri_attrs.get('id')

RFC 7512 id is the CKA_ID as percent-encoded bytes (e.g. id=%01%02). unquote()
turns that into the str '\x01\x02', but pkcs11-tool --id expects hex ("0102").
Something like urllib.parse.unquote_to_bytes(v).hex() is needed.

-- 
David Lechner <dlechner@baylibre.com>
