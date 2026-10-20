Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71D0606A31B
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 07:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Md6kjdE8;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=h1y8HKwp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 806D960886;
	Tue, 20 Oct 2026 07:56:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T1HA9BFsjpLK; Tue, 20 Oct 2026 07:56:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BE88860866
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792482968;
	b=WJqGTEQJYvIKyo4SgNgv5/Dx87zsoTki3cyhOw5XEZu/I4kmnDfeAHy666yEcTrHNuHI
	 wdqkV4vR4Ddf7NbBUpVNpNU3tt8M8ML8nUWz7Wj4/lnJn3t9hlwnVS7yEG20vc8BlSwby
	 A4crdo7/xauUGKBVqSP+sbQqEllljwJQQnd0tCb57BiG0kfIaAu1TFu26/Qt+TiOOzDyv
	 yUBstHE/YPG0CqeYL2JKJhVYnXxjNVBZM4Kya9wUu+E2ReqqZueNGovYazTYH/lRvXq6x
	 CBG0yYKLIlffC6hlFKFyaCdIaCZ5OK9vchJNItlD8rSnOvz+lGzwSei9fisiRQFrzFg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792482968;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=DJ8mZmXwdW+WhY+NT+YKTpRFKxKBwjlndLHmOxobQxo=;
	b=VqLyEcoFugjTcBNqlxBdYwjOl/M/2ZZZpNajajy+6/TGy7pxU/+COA8sJ/aer6W+mQD7
	 HERFPXPifAhSseNTpr975B7Aj6c7JrW5I8Ug8WIFZ9pa0R4ywEXPm4JE2DaeUuVp452wJ
	 QgQj8Tc3S4iXbi+xIf2agvx89aRm4DHDXenquwQ0IUklPH9Ehnl5b5exSx5VAyXMmM4DW
	 +2CYfeBifQ+mRRIRy3+meuSPk7KTCs1V+bu6lUe4e14rpr3GRGOTqc30RAJnPnzmnQDgb
	 KnR2O+xkvQ+bSXSmAyRxB7RBhw3bWK5LDZXDBSQtkd1rNIUcfki64ypps7gjxdLZUPg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792482968;
	bh=DJ8mZmXwdW+WhY+NT+YKTpRFKxKBwjlndLHmOxobQxo=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Md6kjdE8GRL6m/VRM4sUVpT68n9IpR1kcBSiCJsyjXoPd2rbzq99y3PnjNjwVftKL
	 uY7IJbkCTLyvjD0SrsZse8gzNqSRgctMGU/XtoKBEFZnbH436vRcELKg7qoQcb+n/u
	 7cSbbk5OeNo1Up11uYfvC5CRnlb4TtzZ0leCXWVyJKzjENUA5aN++pHK5Z32jijXW/
	 Amt9Y6pgJRQnjesUuXjujWtMZpE7JBOKugLoU6mCMolKUkPrslPD+hOk+vt0OKcpPA
	 VXnd+dpRcQWZ2elzvKYMb14rWCwnIdcRD9juxFTmYqlbw6vWtPE8qTSO1QH2yrwEc7
	 0WqGf92zqEfkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE88860866;
	Tue, 20 Oct 2026 07:56:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A09AE23A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:56:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9E40840821
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:56:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rWD9JxMQv18T for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 07:56:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9E70C4081F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::536"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792482967;
 b=UDwjEbo75RS2p7AW0r/ix2B9gxq3/PZDxuvN7lrprj+ScnfVhmiUCi9SvbbFuVgX+kuk
 J0RM8ljGQ9cFCnv3U7sP0FGeFqOOtc2VabykFHvqthoXVffOQZqsWCjB9+Me33C+raMfi
 uK3okghEQeXayuQiJlRXTeC/+23SpIgMeNte0LcmmEVNvkrwvVcrqzAXrH9/iCl/4JYOi
 ABOioZd1QcQiBBazWpVGjhBCkQVuTFKesI89o7zI7tNCUUrSdangiMVgdP58u9+vCJRXJ
 paEsO8DrLv+9UXbkER/nptMySOsB7OWk+OZ4q7SuroAPqeyy7q1tBLapHyU2XaWwPtA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792482967;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=DJ8mZmXwdW+WhY+NT+YKTpRFKxKBwjlndLHmOxobQxo=;
 b=gycdVPSGcZlREvPMDszDGhcy6gXNAIm9m/ubF1CIkIluvW1STThcKv/pY1iP5PyKOhoo
 FQnygwMyfPUnJihqGGjxg44dzLyFsOu26j7ywK8t59NSNtW46JKFqG110Ze4FAz/saHDE
 OgOP45qSUff1WDV3SmFz8ekEjE7dKQrdKLRFOVRlqXMdvj3aZlL0JSa/PufQw/SI9gFXI
 XbQEPw0JFJpHmueH9kntJYRRLa3BmsnxCnBF4Zsi3eHZvMg/le+lEF//4S4a1I42ZLUQd
 LxwIiGGrLYkut+cz8smdc3jjl23WPvddviLxcllnUuEaIxYQUVkLgghfSNfJjk7lggQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=h1y8HKwp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::536"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=h1y8HKwp
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9E70C4081F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 07:56:06 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa29e06bso5148640a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 00:56:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792482964; cv=none;
 d=google.com; s=arc-20260327;
 b=GJFGXmPXS5DkDShN87H8A1EPWs/Zv3RRXpF8BcD1Ot7lmEHzfT/0Y2Y6DhlFLPrX2l
 rxyDMxMJnQua4EB6XemeIKGi/s7eaYAsg+yp1NCGpOmgEjMPDWjFv8kxXSmgMyvMP1Q/
 TEsEA5elNvWHwD0X6qXvPK2+aGR1+5P10DW7+nC+nijhHZpFPA9r3beGkHwKlNtxOykF
 Y6390hyn43MasBcwI6ggoiybLrODVJ7KMEP4FB9V6PzARrHxSw7ZOqm4oaEhG6lJDgVv
 npSKh6eKG7iXeaZs1c8XH/h31C52h2jbjGls1CZim3t/UKcJDsa1oskvtvXogY7pl6MO
 exgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=DJ8mZmXwdW+WhY+NT+YKTpRFKxKBwjlndLHmOxobQxo=;
 fh=8MnBX6WWYYeMHrlMWTuMwwwSxFPBu1ShKtk72wjd+Cw=;
 b=eiHU4mGPZPWz86mXRfbQ8J5wP1FPfFBHnRZ6Fvzk3W3LMRmbk7BipYOj2DRBj08wRJ
 C8oWwv2LxPH5cgoHCGCPzN8gFAy8BmPG9Gvti0w2YR1crVBkE9BYoMwd51eNfQQ8dXaS
 opiMcJvXa9YqWGevW0yiXpfwtqL3vz30rj1m66jF0qrYw/U7kHcG0w+aKOp2YnVNsHhT
 tlKZbAqIZVdYVdugWmKmZUKmT7JHrNYR7jlIIQDzThhsuaAbvpSZfUdD0D/QfBuEHU77
 XoVweoCJSpUQMloNiUbXc5O0wIpCpc0LDzlME11gywLAxZkt5RMWbvpGidw/0G6zPePH
 PP9Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792482964; x=1793087764;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DJ8mZmXwdW+WhY+NT+YKTpRFKxKBwjlndLHmOxobQxo=;
 b=h1y8HKwp3Gfw91NKz9OtnxBaM1ydFZrU84GsRMut9+yK09CTeoQZci4ng7HzZD4mzm
 b1Kjdx8HA++LNLqpA+/3Gjfs60/5HkCnybX5TvmLzfMANqbWez0rHpuPm4Mg3xtQm5Gf
 Ro1SdhYsydrq3ULhq6yuzmXs0Jq4oExsD0JFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792482964; x=1793087764;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DJ8mZmXwdW+WhY+NT+YKTpRFKxKBwjlndLHmOxobQxo=;
 b=E0Lm7szyReqJUQGLq7aT+yjjkTYE4yLEi38kINlfLlJt21MDjudSxxTZ14pSjM1yKO
 5D5DfLuQkscGzXtBjlQ+NvarGplXHdlPYDeVW7+F/1apaTdjTkYh0Eh+uzXOENWZoOv9
 Gb5ROTSP66nM4zu50rz1ClhV+Xvbfkt1oNPn2hzFmUEO2sDLSK9hF+SqKWdctVybynmq
 SJNC4e+wHdVVjIVgJqRp9U6WIxO8uuTEI7+4B+anpBCIZhswOWHLyJ38w62ByBrvem0s
 dKiLVNCIUNgxH50NzYIapRmUYFSG+vvF/9ydGVDwmway1xOJpo868Njh0dsmoFmESMN2
 8M7g==
X-Forwarded-Encrypted: i=1;
 AKwUvByOaMWIC0xmO1efbL1RwZHwG58q5jTF2Qa5WKjSb2ibvp6fLP6VG8SGyA7n+bplqDFOWD4uPsE=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKr1+J5Wd/Ip26/NGM2/P2rNBJOpqyvBZvwSTIbvzf1sySFGr93
 9DLyV+ySR0swMGkQpA8iWFfS0IhZYyZjYPfFS8A+Z9++xz9jzbX6MuNddsLM8ZPeb6NNczgUOJ+
 wdW1UbCSXdM6zbrf7wLBHdGMhGiA3WtZpHpB1ntRw
X-Gm-Gg: AYBFou0ph13WiLAzqtnduQYdgslwQ3oW1agIMHwvB5AGd1XRhjGGDYUNZBCR6YDzC4x
 i2rJKzXhhsFNlBK0u9RNSsfOXau7PJXWpUASnB/xEE2+M3u0iR8Z3/ESsprftrBmfW2F4UbBnkV
 MRnQLuOLK4dQhK/zYNRQbZPXp+fuvzDfZFUADlbxZ0EekQJA7QeT1mc+kWQytUTEWdfRL7VsbWs
 xW9wKJ1fnaVa6DtFQwjUf1wtgH4wKefKo7vDSoBDwlnBZkDFGpiRx3fKVE0nj6Nwok3i6thTh+b
 kPe0KF9dTZjW9zy6DoQBc5p3sOL0qk0EN0uSq6dWGmJE1KGETfVmXg==
X-Received: by 2002:a05:6402:c1d9:b0:6aa:ee55:a650 with SMTP id
 4fb4d7f45d1cf-6b3a81a6e01mr4213712a12.37.1792482964480; Tue, 20 Oct 2026
 00:56:04 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 00:56:02 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 10:31:51 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8fa208dda8b261c8683d8144086cfe6417658a32.1791966831.git.daniel@makrotopia.org>
References: <cover.1791966831.git.daniel@makrotopia.org>
 <8fa208dda8b261c8683d8144086cfe6417658a32.1791966831.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Oct 2026 00:56:02 -0700
X-Gm-Features: AclHuK-5pHCldf9j7comGBOUnSxCOdO9m3L_LJev5mq_vaQ5L7zudXPz_dfZabA
Message-ID: <CAFLszTji8TABKxrzsrF5-YpCiwJ8Q0dvMdTxAockOx6k7+F6Nw@mail.gmail.com>
Subject: Re: [PATCH 02/11] boot: bootm: derive the header probe size
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Vincent Jardin <vjardin@free.fr>, 
 Anton Ivanov <anton@binarly.io>, Randolph Sapp <rs@ti.com>,
 Anders Roxell <anders.roxell@linaro.org>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
Content-Type: text/plain; charset="UTF-8"
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-14T08:38:38, Daniel Golle <daniel@makrotopia.org> wrote:
> boot: bootm: derive the header probe size
>
> boot_get_kernel() maps a bare 64 bytes to identify the image format.
> genimg_get_format() reads at most a 40-byte FDT header or an 8-byte
> Android magic, but the legacy branch that follows verifies the whole
> 64-byte legacy header, so that is the size the mapping has to cover.
>
> Say so with sizeof(struct legacy_img_hdr).
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
>  boot/bootm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
