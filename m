Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDDECA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 13:43:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A5D4560EFE;
	Sat,  3 Oct 2026 13:43:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zGtJN-JD2RI5; Sat,  3 Oct 2026 13:43:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 04DD960F17
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034997;
	b=NGXn2Co3VYhJ7JmUrfGmhlmFiZ4xjr3NLWrhjaJDfGkE/qjLgcU6R5H0i8SdUxg8dOG0
	 VfDuWK8Ur8xKNmGYfsOcecFNczHdaDeGRTiN+aMNuZZkPXwkigTOOcDd9cR4xOZAW5Z2a
	 2u3VTSefXSxzE8dMUeF1LWrza3zll4hWqm+5OfF+D6sLPL9ODhn+7WLS7YU/CtAWUMsop
	 geY7qRKlVT7MqEXt4G79oyQkKgRSGpbdCSN9lmUgYCPVV4WiQnCzSe2qIoPLXcKsOrsT9
	 ACXx196trSjm9D5aEjy33y/yu8hKjdTB7fDYca2jcdzEiNKuplN6l3Ktx6H/FRUdBvw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791034997;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=cqY63HPDrSgDGHENgHm1SCMY3WO55G/dtDq4B5pUYqM=;
	b=Rmjt09KCa6Pauc01OOUM0US84n9/tUzlgjd4lf+YfDrCMNTvQeq808PJYEktEjodrSLA
	 pF19pm/k3hJjriUjS9n5Hw9Jv/M39I7o6F4DLaa0i0c7RVUox1qME4nIJq6t7W+0ML/9D
	 cGNTcZkURGQM7pOC2GJFnW6JkC8Vclv84gPjTnUF7qDkg6Yqx3sMi516Zhqr7OFEQGxVZ
	 FqPOKJ6+S51CTiQFeB1ybLP7C5ABxFWTS9fsb76WUlS7urlxXR4Xlk5A4MpCLpX95OL1l
	 IgXTJmPptd9dECZKey5Z0hxHp8iq/YYe/lfvAuvaQGeV75fPIBeTKWqbQWb1CbWH4cw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RvWSZOlH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791034997;
	bh=cqY63HPDrSgDGHENgHm1SCMY3WO55G/dtDq4B5pUYqM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aSJVM864w0cKumdEnR+VhroA7G5WpxrModBPiYXeC+jWFNBOgSM4659Oea7NuIEVG
	 4DMUju0561N/sGGje6aWloxVUpSwfGAoznvnQZ8m3/bju8/4JZhWVZBAta+ZSekZRo
	 /rgeiSXr6Vfgj+6dxYOKiJ20mmnqJo/PinTj1c4/XloqhJqGgAlgAt30WHz5ijLAFm
	 DE4MbDKcb9rZfES5TBYrJeQceVAIt3ePG85FOp96PRzxQvuPKU3FbHiml7hk9rdEe0
	 /MARghPaZ48w6w/UfvFhPVf9hVrsmllj5Bepu9oXK6cc+qDNC7Z15bsehGdApkIM89
	 1UQjAyxUeTM2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04DD960F17;
	Sat,  3 Oct 2026 13:43:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 841D3476
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:43:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5A67960EFE
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:43:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G6DnNRLhhQ4v for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 13:43:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 62E6260675
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791034993;
 b=L5q/P8CSD8ur51DvgYpiaPL3hVkc/+3lkBTsG8Ts1VHYR2ZhsAhZ6U+Y2rk2WZhOJ052
 g5OgMj99sr1+sBi+cAf/oX2EvtbpXaQZg8XbGmds4IG1zW3rneDTHJf1iMnNz4dqkN1XQ
 uklJSfgE8bLJVJRE7yYdCGDg6lrHSW0pR9sz8BJcVAi//2GpOG+pRV6sQaq78FkxyohbI
 0xrsS0EB0kr0R1vHOn2CNRbktiH2bGk/cDWmATnKQw0XjOl+IDbduBftqM0gj7PCMDA1m
 zaX4/81Jt8DL+/m7vVpAbnVEacaTNXEyREHpsl7uK5YpOuh3Kq4POlN225Y0BIWgtXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791034993;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=cqY63HPDrSgDGHENgHm1SCMY3WO55G/dtDq4B5pUYqM=;
 b=OS1lHUxTLWi8cMDSFXIeweK24yODykCn781YljIVCuZwgWyVQfhALeKpTJYYuGnV4O31
 vbsEoZ6jZkpMZcA7L7d9349ArGrSqq1poB4/66rqax+BLgQf9t35484vv4wW+eEZDJXQr
 ZigX4f3x6BWIMEb2EfzdjFiwLDTc+tfbEg+13hK5S0mqkAQOSDirW4nLx/LPo+hXmegaq
 R5QHxgxP/PW1gs8YQiTH0U0aQFKKy5Ojn+UIAcpkxC6rJ+iExmUGN/az5Rw5TMZ5pS3Lc
 1slEggQhiwdgca2iDT2Or+H8mkVEonHfv7OUkrmc556vK1tjx1uhDBRL1kS6CYDF6Pg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RvWSZOlH; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=RvWSZOlH
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 62E6260675
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 13:43:11 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a051b737d8so381206a12.1
 for <u-boot@lists.u-boot-project.org>; Sat, 03 Oct 2026 06:43:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791034989; cv=none;
 d=google.com; s=arc-20260327;
 b=lRbmdwQyDRMlhiFqf40BBXVxo3grUwThJOLCZOlvs+LpKmcyJsp/gyESOJR7KG+rlo
 2c/4IcmGVnGp0P4094vzGPBHJwp1v3W9y1R82+pTfZ0qTAEB+svU+He2SBLkKxL+9R0p
 RzeLPfS6fZs8hYDfzehu+4/RMBOQbc1xvp2CDRAqo0uuZtqaCFQsVBCFr5oFKAvIuimf
 OWMe2eBRb/Eely0CGJUJC/090QpII4oZBRDoljClA2k8zCdjWIiHwqPGrGbpNnMI3HV5
 csjucMJe3kE8fB4wJ/xMeHhGASWN08sAXo7/LztaMuZZLuafwk8WxsAgBIvr+4UzeGcJ
 1BmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cqY63HPDrSgDGHENgHm1SCMY3WO55G/dtDq4B5pUYqM=;
 fh=f3TG6ByMXnBYp5vT7uKl07Qim4vxFg4srt/jujzOAb0=;
 b=CM6+JAqqkc1JxF/OgreWgnUZFhSlWXiX6XRQIom8TLi5Q5x84mom4d7lOZG/Ky0hd5
 JGhElmkFWX6AtJ2/1zsC20VlUrZQ6XUv8yysQe+uh1fKehs4A1Bf//jPGM+5otgRq0ht
 MvannPAEVnJabKHjhcykRkXhWvVkL4uKl0KjLjfkFX/uSOKOuLPTzp1nSTpWJtISPdq3
 CoO5u1mhbwmDrow3MBPwwCuAFJAI4gu2H2SSETLftuNUUvqSjaHXdR8HgM5WbrNvxWEg
 W0NlxKpXpdkHZVd2Q2cshMlLsqJlcDmoClhjyvqsFrp0zjFX2KxB9EL7QTOkvwP/Nfps
 ixeA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791034989; x=1791639789;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cqY63HPDrSgDGHENgHm1SCMY3WO55G/dtDq4B5pUYqM=;
 b=RvWSZOlH/D7O+X8XMjbNb8MXUYQ10QTadZvfI17PvBEmvEtAGUPK8p3Y5er449V/YM
 mpQ96AklYGE4bM1SCqPRX3MGjdDsGt52r1SMn2ZH7xdMiP5giMmgqTO5Muvniwy816R0
 t/1/6js/Sct2cfLqGnSoFpAGrP0QgicjitQl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791034989; x=1791639789;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cqY63HPDrSgDGHENgHm1SCMY3WO55G/dtDq4B5pUYqM=;
 b=nhLm50nOun3gC5ZbuFYScYyIqhzY8h8yD+4lGS5xa+1iidjC6VcbHL25+RbEYgHk/g
 2RXU2Nis0QzqQLak3mmb+8nrWpG9jS/mBi5PSPZaTrk8rVoqTfIlKtq3YkMqlIllNNMj
 yBSqPhJ9jejPMaRXJ4xLeVZyXZGiH9tSZYNbuxJaDNeLO27FqGKxIm+auamokD+g2vy8
 W6eEU4YOatURzFIjwokIz4h6bAbRJgPjeo1HmMLzwiEIEKWTSgvFreTPj28GbKLLeRJZ
 qw94d/wJsEbIB7dkWLGoCvKN04Mt/yRPy0t6t875aF8flK4qDiWT5wmNr6HuSpQszh0U
 cq7A==
X-Gm-Message-State: AFq9FYI+vcUgdNU090wi96vXE0je81OI6CUS/JJDscTAwgt3oMKumvp8
 LaYl4kLGqjwA6BwvM5Gwa6QtReRYRzsWXgh1UrLkAl9k1fHZCSZ+7rwGMR+BLQ9TOBCJryEluJx
 mxOC6Dxd3rb0czcfR2jZUvsN6LBmM7NZov1lMVUJ5
X-Gm-Gg: AYBFou3gqWxPnUoDZycOEy1I4hQMCQ/BpnqVGRTwaXkCPsI4FpWBBC2G250X9x+FBHa
 dbNwJqRfLhBCGBOyEFdMyZgh5sY2FMT17n4m6ko+RhE9Q5aIIOf9uaKq5EgyBvGJvuj0yvwpKu+
 v3pSzqmPsFTTiHxd7xCUqOGDfpK6l5VD7LReOM9vgf4GYZ2wHWmbkWAevEcOYxpQZVpI5KeeUE7
 vwM7xFxDGbuJv8r3moBlGtYGeD/hgmm19YEHDKBxizgu/bsKV1EXyG3YBQIorSbpuofkan+REQe
 48N9sSGBBdlCBnm+JwfsxREPeARhZu4YAZvV6NF3JWM51F4ZLlSjeBF/xHDh/zdSmQ==
X-Received: by 2002:a05:6402:50cb:b0:6a1:4458:7f2d with SMTP id
 4fb4d7f45d1cf-6afad760edcmr2298598a12.5.1791034989288; Sat, 03 Oct 2026
 06:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20261002073357.382228-1-aristo.chen@canonical.com>
 <20261002073357.382228-4-aristo.chen@canonical.com>
In-Reply-To: <20261002073357.382228-4-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 14:42:57 +0100
X-Gm-Features: AclHuK_vGeGIbZalZ65ZvZLidKELjTimk6pAUPfQ0QGhecfA0dy983GBiepJkRo
Message-ID: <CAFLszTgkEgteJ6sZN_kLZ2904gzuBmTMLSgSPF8pD+kY=9UAXA@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] acpi: drop the duplicate ACPI_PPTT_CACHE_TYPE_DATA
 definition
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, 
 Simon Glass <sjg@chromium.org>,
 Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
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
> acpi: drop the duplicate ACPI_PPTT_CACHE_TYPE_DATA definition
>
> ACPI_PPTT_CACHE_TYPE_DATA is defined twice with the same value, at the
> start of the cache type values and again after
> ACPI_PPTT_CACHE_TYPE_UNIFIED. Drop the second copy.
>
> No functional change.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> include/acpi/acpi_table.h | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
