Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CFBECCF2C1
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 10:43:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CAFCB81492;
	Sat, 17 Oct 2026 10:43:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5n6sd2M1nBZx; Sat, 17 Oct 2026 10:43:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D37108148C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792233795;
	b=PcIgq0C4zb2NPMytVTJPSj5BlQTaQskCWdzRCvVIIXngA0eDByY6yPgAMCxaEYCivvMX
	 oue+8hRaW2ejxzXjFv8XeAee0gqYOoYwSkOFxfP3xrrrxq08DDDx6KFgdMg9X+6r2scO6
	 JbfGj2LaDQliPytMUmAJdug7zzmBcntroN6GwXEHHsUESHHbG7EnwfWwvdB7BbDvH6lHk
	 zCZKyo++gkAozVweOKIhb6y5dWlrcSooZnRRFy4MQEZPj3dDt8tOnQQmdMOIGX3bYKE1s
	 tEO8sgwYLmXAgCfjN42UXPhS80W+hs93XmuSD3DAa7bVkE9jtyMmfReer4QVD7MSKlg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792233795;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=yw/niyzomMzBNTRHaIzXZzWvv1yRq2fd7q81DAMF3aU=;
	b=B5W9EtReBwZnSAq2hmbiVmeG8r6wbKTctQtXVmsxQAD+NKVtG+fm2E01vzL7Xrf+dsma
	 /VBsbVojdpg0EIxQ0od90oZ1J5xUbacetiZ/EuQbX88FKAFTapX2MWgaoEEnQPf4zkDL1
	 qlUYM4ckIS2hYzM6LkoJJwQTtzNlp8tE8sz5X0BBXK1f5wbjoTNqLJbKEIJ7qJ9Jb90N1
	 2jNnHhycF+yFylzaZsDafnRnoxDkdpF8tcg0SbAqlcpESYzFRlA+wCT5QiAi+nUmH1YNW
	 Aghbt+rbIo5gX91z/MrTmnFmQEOpoFapJH6T7sFc08DYsOG9Xn5U8B7PL+MnlVLSeyA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792233795;
	bh=yw/niyzomMzBNTRHaIzXZzWvv1yRq2fd7q81DAMF3aU=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U/NDrLZ/bGeK2mVisvr35wIUfVreFYkAQ9Y4pJbahwujHTGtwIaKQuBu8uGSy7FRD
	 xe29ubRairnDUaoCYDZ4y+bGhYA5eleeb9Bhzl+bkYog1p7VWojC2df7NJzdR/BIlz
	 80dHQ0yYvrzrfI1xJ4Oz93edbFq7HQFbUneESabX55iCHo1MNei8SS/8RLnbYX55Zh
	 36dKhVIENQqbruQfrnU/eWSssl+dtgMMYnI7VMOd3n/I5cAED/iL3Sp/wZMNilTIED
	 9zJhHk9VdYQ1ul/i3RW8Gd+dY3tj1XZy8Q++DkSiQu3pviCqr3KYJnas4cTj88vZJK
	 fNow1OffN7vLg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D37108148C;
	Sat, 17 Oct 2026 10:43:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 693A51DE
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 10:43:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5AEE840925
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 10:43:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WDA5Q9uTWigT for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 10:43:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 473A0408EB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792233792;
 b=STyTij4xD1Ciz3W9tkaXI0jaDXtjcb3dmvkA15Mu56VHCFkqu2QoPwCDv6fRopjqKqyy
 xny+ucA5Yi2la/14+7b3/207nuAJ07Z9e+VIbOQYEfXnKC2oGL6y3WIC+jIo+k3xq5yVi
 BfrTpXZzdqPFElXkLmVmpZSD78BQYGrD6Y9ieqsPCuCKSvBzrtJQuo3hiy1aQ3OSnrTRN
 5eLIf4m3LvKaeyEFB6UFBnSC1fAAGmYr6n1FA+IJSIrQr1BZCtvBpWBW21XLGfzHFKQJ3
 j/EyYo2Z6pEDgGn1ybCXz/WGh4h7/QYI7/yHl0OvJcE6YsGS/qPYTC+C0W4cIOszUdw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792233792;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=yw/niyzomMzBNTRHaIzXZzWvv1yRq2fd7q81DAMF3aU=;
 b=dQoM0lWAwS2pBfJoFQrNsI2oOFIS755t7ULGV7bj0YPY+Fd7xixrysY02DUKE3wCH76x
 XpPxroiTpNdS+qVctqVmEfdEA/Ij/nN2fxgJwJwKj7mi53TlAA9Sb4TFGA5SaZYglMvUg
 u+VY7+kYDCoMzV++NFeZ+teKG3N64PhMUu+hBj/3PI3hjAOLpQlpF0IBMiS++GvqQxKRl
 1T1h5Vkbs75u43U1+1C6cxC/EwR6bCBs+mZ3WyQ2KCHGtxwCOWk5qjtaYPV/lRQge0Wvq
 zgdVAODKKXwnJov8ECWyrFemeX0SKoJb6I6lmGMiAo8BirZ6OBsQOl/J+wc8xww0MBw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=GcJyaxsW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=GcJyaxsW
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 473A0408EB
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 10:43:09 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6b1f4d8e09aso967123a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 03:43:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792233788; cv=none;
 d=google.com; s=arc-20260327;
 b=NdZBxvZ7kYYo8h0lb1AlpGbUIfWXDhVlw9kdE/MdOa9rzgmuc0Mqnip2Z2fo9Gpw6L
 h7ntyn3gmqsXjuNR7cHa34QQl0UKCkl/AXZVJ0XpRr4ZfL8L4MMNEd+L1NyVxYJcn9Ri
 NlQdwiK4u3qQt/wv8HEzfnX6n3oCQQ/ofT45SW+lBIE9s/1MPQfouT9JPNUrzPUgS9ox
 nEx3RdkQJp5eK+KVZzK8i6REe1lRLEuMbXdweb7Q+eUlM4YDyGs0hVKa8vx01OqiVhLt
 j4+XQzAvJnkKm87eJ3AJgV19mryJEv+QTE78/oB1VvXm44HkcYO4mP79SLnIPi6q3k8B
 cq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=yw/niyzomMzBNTRHaIzXZzWvv1yRq2fd7q81DAMF3aU=;
 fh=tyce3N3SmchVmB3P5gdAh6RPZjDulr7njFqq1hzB9c0=;
 b=EDuwhWyx4znXxRGuewYIUni4H43fdH+NrihdNBi6jCTaHLxPaWU/BhWyxnYcsgtFxe
 nf9JeOtp9in4yZPSWnVf1wDKPi2S7lf5ZS5w0WQd63+C5dXFdOLJGfjWaxEMSXBe6mfK
 1Q4YQ7mNeOd3JMK16QKYSNjp7Cz8PyeQTAt9siwyn29hrCdHZ168BpZ5kBq9JSLp51P2
 Gt0Z/RL842awV6wqFyiDbukkaEZqzoaYJ3jHOyws4+PJABqZd1Buazaw+9NsiGd1JWtv
 RqWLxi6/uEbylmPIx2K7Wtj/dSPH82wvWZFl1nwTfGHxVozhEubL8ta9fJrBOIbIXPjs
 kXqw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792233788; x=1792838588;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yw/niyzomMzBNTRHaIzXZzWvv1yRq2fd7q81DAMF3aU=;
 b=GcJyaxsW7w8Ghp7kyMsepHp5c15CTYFJO/BiRuOScT8XPf/VQwJ448/HjxULmebRv3
 iOL4kbqRr2bhpwhxLAbD9LfQCwE75bwS3B+9nCGjBd/55GnO/o5jAxHUZg7Y+auUGV9z
 yfi05DbKmjfkIHAGVKYWAlxTV5+Mg1qyvj7vM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792233788; x=1792838588;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yw/niyzomMzBNTRHaIzXZzWvv1yRq2fd7q81DAMF3aU=;
 b=sMDnNI2WQpthMFqYwTencQHsLGSTWHYac0+mD64FVo6TYskxUFCylVw83HoznwpUFr
 PUVrPfqivu4vkLMM3voTyzKMFp7y1hfTDf4AnKSBgJkGDMyf1ZZuOJ0jc6bkILa2HgiH
 dVW0uGQV0YmOxvCwGBtwMqQRWM7ZRa9flhTExcTgf2Qbok70tWAnWec2e13RFJjImpNR
 cePgXCeyU0CaK6jaGW4XLHCY+2vOInDB/eXfOGL2L8U592apgSMPMMvDk0kKCa8vOpzf
 kuQVkRwRN1p41frVKoDCsfKBpGL5pI3SqRIaUtXjulFw8dc91UbzGabBUYncTM1G2Cgg
 Uazg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwE9I3/vq4Fewf3XiG7P68Dp2IUvXBdAmvBj5/XxiyM+l4atSBN+jNpG4aNAH3oGYfap6caySg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKdBW4pGRLI9BKGXl62uHkJRjxKyMtIW/zMaMIG4YAIWk3whpqt
 M+mAfTvsoI2/JHqeb6NzpYQilHLYf2PCzTsUtXQhTh/tpuUZXpFYi86NrcC1reELtOlN2ZLCJDa
 a0vMpl11wNVwovk/ogmTm3DGW6XEjJCTmG9ajqUoc
X-Gm-Gg: AYBFou08Bm3F0cTQopweERCHEGeQo7X1cxQvQ/d6NQdRJACyvvhWAJ5JYyqopbIoW0c
 NjHjZAZrlL8qZqjDvXE+TvGdXGmsthcg0CpZ0+P0UneLBPcHCJa/rI3rs0VtoNgN6xcQnYqrFI5
 nDvTxOqyjmOypmBiJMEkwFVJygGTRKLxi3ruelSQYCgVut+Xq8y0jMdMf5EILYWvBHNl1Zufj2j
 UCCjq1CM8VQmp6f63x5c9iI2kZldu6LlebAn7HNBhq4uzTJT18TAfKav1AnqzadypfQD5jp/EDa
 ctnKkmgBy+aoYz5O5PhWjcgO6rpoz/5JJdLkNzwlydBcMSoVb0PQOw7sm8Pi5OvW
X-Received: by 2002:a05:6402:1f8f:b0:6ac:c618:8e76 with SMTP id
 4fb4d7f45d1cf-6b3a818e627mr1265459a12.16.1792233787673; Sat, 17 Oct 2026
 03:43:07 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 03:43:04 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Oct 2026 06:23:24 +0200
MIME-Version: 1.0
In-Reply-To: <20261012104805.17297-2-yan.wang@softathome.com>
References: <20261012104805.17297-1-yan.wang@softathome.com>
 <20261012104805.17297-2-yan.wang@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 17 Oct 2026 03:43:04 -0700
X-Gm-Features: AclHuK9jFApqI_Ylcgt6GKvRLtam311kvTJvRmWsVvM8qT0mEG9Hw2h5xTmruAY
Message-ID: <CAFLszTjivzCRzShc8GJFKjpSgOHXGEc8S28ykU9Gr132hFKhnA@mail.gmail.com>
Subject: Re: [PATCH 1/5] binman: Add PKCS#11 signing support to pkcs11_tool
To: yan.wang@softathome.com
Cc: trini+nodisclaimer@konsulko.com, sjg+nodisclaimer@chromium.org, 
 alpernebiyasak+nodisclaimer@gmail.com, marex+nodisclaimer@nabladev.com, 
 philippe.reynes+nodisclaimer@softathome.com, 
 paul.henrys_ext+nodisclaimer@softathome.com, u-boot@lists.u-boot-project.org
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

Hi Yan,

On 2026-10-12T10:47:59, Yan WANG <yan.wang@softathome.com> wrote:
> binman: Add PKCS#11 signing support to pkcs11_tool
>
> Implement the sign() method in the pkcs11_tool btool to enable
> HSM-based cryptographic signing using the PKCS#11 standard.
> This provides the core PKCS#11 interface needed for secure signing
> with hardware security modules in binman workflows.

Please can you say more about the design? For example, the token is
selected by label, serial or slot index, and the mechanism is checked
against the token's list before signing. Please also mention the new
public method find_slot_by_serial().

>
> Signed-off-by: Yan WANG <yan.wang@softathome.com>
>
> tools/binman/btool/pkcs11_tool.py | 275 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 275 insertions(+)

> diff --git a/tools/binman/btool/pkcs11_tool.py b/tools/binman/btool/pkcs11_tool.py
> @@ -3,7 +3,12 @@
>  from binman import bintool
> +from u_boot_pylib import tools

This import is unused.

> diff --git a/tools/binman/btool/pkcs11_tool.py b/tools/binman/btool/pkcs11_tool.py
> @@ -22,6 +27,276 @@ class Bintoolpkcs11_tool(bintool.Bintool):
> +        args = ['--module', module, '--list-slots']
> +        result = self.run_cmd(*args)
> +
> +        # Parse output line by line to find matching serial
> +        lines = result.stdout.split('\n')

run_cmd() returns the stdout string, or None if the tool is missing,
not a CommandResult. So this raises AttributeError the first time
anyone uses hsm-token-serial. The test in patch 2 misses this because
it mocks run_cmd() to return a namedtuple. Please can you use
run_cmd_result() here, or treat the return value as a string and mock
it as one in the test?

> diff --git a/tools/binman/btool/pkcs11_tool.py b/tools/binman/btool/pkcs11_tool.py
> @@ -22,6 +27,276 @@ class Bintoolpkcs11_tool(bintool.Bintool):
> +        elif algo_family in ('EC', 'ECDSA'):
> +            return f'ECDSA-{hash_upper}'

The pre-load entry only handles RSA, and no test in the series
produces an ECDSA signature that U-Boot then verifies. I suggest
supporting only RSA until EC has a user and a test. Also, nothing
checks hash_algo, so a typo only shows up as a confusing 'not in the
allowed mechanisms' error, or as a pkcs11-tool error if the mechanism
list can't be read. What do you think?

> diff --git a/tools/binman/btool/pkcs11_tool.py b/tools/binman/btool/pkcs11_tool.py
> @@ -22,6 +27,276 @@ class Bintoolpkcs11_tool(bintool.Bintool):
> +        result = self.run_cmd_result(*args, raise_on_error=False)
> +        if result is None or result.return_code != 0:
> +            return  # Cannot verify; proceed and let pkcs11-tool report errors

The check is silently skipped in several cases, and pkcs11-tool
reports the same error anyway if the mechanism is missing. Do we need
_verify_mechanism() at all? It costs an extra tool invocation per
signature (two per pre-load entry), and parsing the output is fragile.
If you keep it, please at least log something with tout when it is
skipped.

> diff --git a/tools/binman/btool/pkcs11_tool.py b/tools/binman/btool/pkcs11_tool.py
> @@ -22,6 +27,276 @@ class Bintoolpkcs11_tool(bintool.Bintool):
> +        # Write data to temporary file (pkcs11-tool requires file input)
> +        input_fd, input_file = tempfile.mkstemp(suffix='.bin',
> +                                                prefix='binman_sign_')

Other btools normally take filenames. The etype can write its data
into the output directory with tools.get_output_filename() and
tools.write_file(). The file then stays there for debugging and is
cleaned up with everything else. Please can you change sign() to take
an input filename? It could perhaps also take an output filename via
--output-file, rather than reading the signature from stdout. That
removes the mkstemp()/unlink() handling here.

> diff --git a/tools/binman/btool/pkcs11_tool.py b/tools/binman/btool/pkcs11_tool.py
> @@ -22,6 +27,276 @@ class Bintoolpkcs11_tool(bintool.Bintool):
> +            # Add PIN and login
> +            if pin:
> +                args += ['--pin', pin]
> +            args += ['--login']

Two things here. First, a PIN on the command line is visible to anyone
who can read /proc on the build machine. I believe newer OpenSC
versions accept '--pin env:VAR', but please check which version added
it. If so, it would be better to pass the PIN that way, or at least to
mention the risk in the documentation. Second, with no PIN, --login
makes pkcs11-tool prompt on the terminal, so a non-interactive build
hangs. Should this raise an error instead, unless the token has a
protected authentication path?

Regards,
Simon
