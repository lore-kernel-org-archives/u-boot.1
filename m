Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964AA606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=gzKuycAz;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=aK/sxxRA
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C48C607F0;
	Mon,  9 Nov 2026 17:28:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kwQvGkIrePaX; Mon,  9 Nov 2026 17:28:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B2FEF6071A
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794245287;
	b=oJRPew24rYwYnCy7VSF7SMJQ9NwLZ8fgnLE4VgX0mEe9WSRXIAZvF7P3sCaG46esuzYc
	 39kjJZWVWXDFsFuQIhOV1uzu0pvpeJB7NNxv09oS28bf+T9oDmLHwzVGHYjbhjoX5NyuT
	 zdRb7Ofs9JZm5WAqinxmJ789ZLWuYOZMngnSngsr/FFhYMKnM0m3+8W2pbmbTo/3Gs9L3
	 luXkHSqH56yl8JxnTpOXtIAMMgSukeeLRN6p5t5Bpqh4JfuJXHfPemEtXFMk7Aq+Upvm0
	 XfyPcDmm5aI7DqeOIIrCHqCFIA8Js1fmDr4d9gEbpPMl32x/c5lxI2zQJit/6LUeeiQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794245287;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Qw9sEq1R+PXHyP0T0gCOsrvI2ZVYDxvRiCLZ6WxdKrE=;
	b=oWMrVM/eZQbEkJ4iPB8n7q9BAzjikHXrtFRQjrfSRAv5hoy4q2PdsaYQTv6bMMZnpaAx
	 fADaU95yTezGcmJDy4ZL69pFsVO51GBZTUKwvE9mit8ohOz1nN1sCKepelIAA3npas3Fh
	 avncxawaCHNZriyI7FPlkpI+V4rTRO45fVgjT2AvKyS4IDFx6kkN5bwWd/Gd9msLdWODl
	 fzfTD06UIY8J79M1lYDKTpD4MZC/u2Uak3SbYie+5sxyTnn/ktw8k3GJIUGGE+g4epR9S
	 6Xzw86N7gy+b5hP3RKpqf8fXtE9wZVsU4M02RMcp0KjdqJaPlwxavln1Qj0GxeszW6g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794245287;
	bh=Qw9sEq1R+PXHyP0T0gCOsrvI2ZVYDxvRiCLZ6WxdKrE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gzKuycAzMoc/JOWW1qHLzOxa9dC/8cP4I3U+uKmM8fcgFi8ov9SW/dgfRI2dd29VJ
	 4RmfxsJ82ASu1wTn7yVDsnVnKObRdHLxc+qt122xAwAjj+Zr2D67NDpfgRZ3USi0nO
	 WrYZgX2rjmc3o4a77ns2wRhIFsuSLJJav3ubetAXjJviSMuq3XZ+pW+NAQAvcxvFMJ
	 kNqz/CkRbepQ9dGZrFEMNev/IOtc0ZgT43Yfl6UoGI1ixhiBlQaty9NShXdTEq0H3O
	 fq+rfsHAjpTk2qaZPtP4eJq5wyec87s0NxYitK/p+6IuXhKgjIElZ4hQA9eSu6E10k
	 vQjlqRNeT9n8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B2FEF6071A;
	Mon,  9 Nov 2026 17:28:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BAE7428C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:28:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AD1E640068
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:28:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fY3fBZy_rcUx for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:28:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0CCA740243
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:4860:4864:20::35"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::35; helo=mail-oa1-x35.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=aK/sxxRA
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0CCA740243
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:28:05 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-4ad4072943dso397345fac.3
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1794245284; x=1794850084;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qw9sEq1R+PXHyP0T0gCOsrvI2ZVYDxvRiCLZ6WxdKrE=;
 b=aK/sxxRA1rS5+EhHD3h8kL1IvaFJjt4mI8xXmo63lET6YwqDU/4ysf+kz5MKSJDjHE
 /7MyFuFZ8VFSI29BN4r7J+mRjW+5eWQ29HKwSwwe1+aRXTPpo9CEqY9FBQWG9bc6aVnb
 AnTBt9BPnMnKhtwTBJp8PL/v1F+LH4Llze2EFLuxzoVsqeC15fWef6L8vUoke3jGJwgt
 KzKYsO8180QEMvPBfJ0r6Wt5/gzbzg6tb2eTvGnK0QngGf9VgWnLmP9F8HBJsx/0la5Z
 mEPKUrr73R0XdTWFk2BitYTjRdcKyFirE65jedGWIecStoPSr6lCQ+Gcr0qE6Eai8dyX
 rLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245284; x=1794850084;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qw9sEq1R+PXHyP0T0gCOsrvI2ZVYDxvRiCLZ6WxdKrE=;
 b=TgANh/E8VwCI5tWhht0+qgkBxq2JicqYquLUB37M1kIe8mEal2x7EuGkt3lZFEVXU3
 At48NpjmLiBRNLitx3zkVgT5zNgETQ7Q7JHcowEvaaN01p7DYxHEMM28XinAnmIzGYVF
 dO7btmr8ZpSeJoX2M+f5TVW/BQ8saFwj1Jh80f2cXqAqSQSRORGciNcnLNVuj0+8dAxm
 9c8oLklxa/5/xlWh7fQ3SbUhJge0sW+kDWMFrxKVq8XVRM6yr0/BxepfI1BCdbbygz/+
 T9IYq29cBZVAZDd2Bp0ITWxk+LXs5vjr69JkC9NBk6IIrlfYsiF2qjxV5FossZRpLWND
 QdCw==
X-Forwarded-Encrypted: i=1;
 AL+hErG1lUZulfQyoUEaUM+4WXKeQmmD1cypsI1ZUVWybcjUPed8JtQlG7zC4TCJd+1gLBMxpsFqPs8=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8t5i0rZM4uSE8QJ1w92MMVsKqekuqFqJoqfVfSjyngArgd09fb
 0Iu4AAK8ZJtoaxkW9HWXG+9NEOq8HhYj238X4JK8+57WHR/bNNm2F34alHMyaNXt5GU=
X-Gm-Gg: AYBFou3CbsWjI/QuIgpyfqNRImRblCXGaiJHozOLcVI//ON7HqLSFyTcMKkCYpFGobE
 QmqmIJ7cmY1VblCNUlRhNrcFEv5KGMe9+Wpxz0rSm+Sc/75rMRPMDaQepwVL3CF/hjs9UdZd3xt
 WAqFH3rJ9jbEHqPgeUgZ8DdL+2+pMBI8Psanxlb7j+mnARPJp9FgwlRBL7NYxW/AwjSnFLZBQAb
 4wAhyge6sP3NsX3dkRIn95ZnsUULDYVXuWs4x1Em32UYQm/N7leGrXI86TlBeS8BrJazezIarTS
 +JgtMtNdcHCYFxn4+UMYTOaTMi0ZCFA/WDHstGm9oJr9EsO8/JWp3TH/t48ei7UQw+jVSCQz+zc
 e4DPfz2uSZp9s+l4ncw8bFznyf0VT0/9TGLUVjSxnwuXmDjqwPb4VBLOMLhujUeN8N3Mb+Y/ern
 ENwps/N1duy8F4fi69q2eGnfMpVsUxl3Ey31zcKE/Y+/Ik2CQCQJ3G8BCdq4Hx6VUzOr6Q+bSca
 cBI1K+gmvg8ljicUYhdPgRs0ZvTnzxChRJB4985BpW0Luu2zms0utCK1wzLGLUSRRrsGiIXKHb/
 DKuWRcw5Wnmlodmksh9MtNhZAcSjpZvoB5xXNx8OxDAAWLMfAN/bJbPKcr/PE6lplwgNAfyi5Bh
 jrA==
X-Received: by 2002:a05:6808:c12e:b0:568:39f2:1254 with SMTP id
 5614622812f47-5683caddceemr252524b6e.47.1794245284600; 
 Mon, 09 Nov 2026 09:28:04 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e08c:f307:ba9d:b979?
 ([2600:8803:e7e4:500:e08c:f307:ba9d:b979])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-56813db2977sm4811914b6e.9.2026.11.09.09.28.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 09:28:03 -0800 (PST)
Message-ID: <a0b75cef-90fa-4b85-ad7b-0a67ae16f0a2@baylibre.com>
Date: Mon, 9 Nov 2026 11:28:01 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] test: py: cover fdt fit preparation and failure
 handling
To: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 E Shattow <e@freeshell.de>, Ahmad Fatoum <a.fatoum@barebox.org>,
 Julien Masson <jmasson@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Randolph Sapp <rs@ti.com>,
 Anton Ivanov <anton@binarly.io>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jerome Forissier <jerome.forissier@arm.com>, Johan Jonker
 <jbx6244@gmail.com>, James Hilliard <james.hilliard1@gmail.com>,
 Alexey Charkov <alchark@flipper.net>, Vincent Jardin <vjardin@free.fr>,
 Peter Robinson <pbrobinson@gmail.com>
References: <20261026-ccaione-upstream-fdt-fit-v3-0-6c5d86c3007f@baylibre.com>
 <20261026-ccaione-upstream-fdt-fit-v3-5-6c5d86c3007f@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20261026-ccaione-upstream-fdt-fit-v3-5-6c5d86c3007f@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 7:18 AM, Carlo Caione wrote:
> Boot scripts rely on fdt fit either returning a complete, verified
> devicetree or failing without touching the destination. Regressions
> could otherwise leave a script with an incomplete tree or overwrite
> memory before an error is reported.
> 

...

> diff --git a/test/py/tests/test_fdt_fit.py b/test/py/tests/test_fdt_fit.py
> new file mode 100644
> index 00000000000..3a039b32515
> --- /dev/null
> +++ b/test/py/tests/test_fdt_fit.py
> @@ -0,0 +1,371 @@
> +# SPDX-License-Identifier: GPL-2.0+
nit: deprecated SPDX license identifier.

