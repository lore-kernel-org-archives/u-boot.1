Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E30C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 16:20:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFC4E8109E;
	Thu, 17 Sep 2026 16:20:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sSruiSS9ykRP; Thu, 17 Sep 2026 16:20:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 02136810A0
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789662045;
	b=lPeMAkbmz4uv4uO9PFoN/Opfc0bZ+sP2fZXiBx8iC0PLClYeLVW/OoZt4NCNPFOTknsR
	 3Vj7QuvvTc3F+LZIRbtlkeVntSjQX23XWpjAgc4WEN0wH6T6o5puK8zZJ32wnm1DfJbAJ
	 ZJIGCglsL6USn47LGREkBWVkw6MyghjvHHY5GKYhjJ7QyHATJVUaaR12fqmFSbKjwH/mS
	 5BbN+HwIHlpB0zc2mZLi9GjPDkUaD18XObJt96wEGDv7njIg5amdDaVgQPo2Z6gn9xK+q
	 zFZWXd1kwA2//3QtEhSkZ+05zZY+0qBRU5lRSZHKyeT7FKzeVDrLqte73SMmTV/p/ig==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789662045;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NzvbP32SuMa7suUvjy9uQ8YIaVkeDZ8RJP3BvLIaB+s=;
	b=d+V3yExrUUazbmH6WaaHxjKOsfYSAjmZgqdV8f10co2PWm0bt9DxCm3Rg8nMvUVroz4Q
	 4g015dxEJpdwDAX5Z5cUtPpxzUWpROLxLMj3GkzxxOgCzttX2skmOFigvXFflcX7gUXTC
	 5hD43da+DRM3KiQSbfaqVC24v3q+wep6Bgy8MxFRTi7toK4zyzAzzfEEC5iJ8RxiWsNJ4
	 P6F2FjFfgWic40UtdDxy56vgZ0qE0u5qxIq3WhbhG1OM9T9l81M7iIMvCMDxKB5jReNH6
	 Nvi/IUjPJS/u1GKlZ4+mMivcF9NxahvmMBJSmXswP5xYEKGI1BEOqlcv8de3LswAMhA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789662045;
	bh=NzvbP32SuMa7suUvjy9uQ8YIaVkeDZ8RJP3BvLIaB+s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o4SQmwlce8aRLwDN0W9uaLpc05Fl81gpq/U0SeB6l0hUChioebfg56EZb040O+K2v
	 dFrm7zjihhS2xmxKr9nhgtZyqMhCGR3gKNUlJz57CB9TvDaYq5DQrXoK7p9/YAR3AR
	 RQ3DQTZs+QlsljcVlz26s3PwvpzeLR1rcTKyT/aUXsuF4GjVuWJnPQrHI9e61g4njL
	 cZ3SUwXdS5e8caJiRqpdfQ+jug/jMY788nA0GcifnOBejFLxdHMSb/VxznZ+MvZSpv
	 oWjd34fEBpE9gDSr7RZpVO3WsfWSfdIbSYWYvTlVZKV2OCgKcnrPazeqE0O2ayfD5/
	 dW84JC2+yHeww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02136810A0;
	Thu, 17 Sep 2026 16:20:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D33B465
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 16:20:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4AB9160B2D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 16:20:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FKx3HpyU9SVf for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 16:20:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4C94E608A4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:41::19"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789662042;
 b=mnL4SaMrLq8SNqzLyqp7cePvK88L8Pj84W2ixzU6I/bAZysKSNCmEY1LzcVUNhm+LMA3
 CLj07ChaDiWdXvgtE5sfGnr9Ej9q9wHcDf73jq9rklND/uo2VJTvtTxuCxlY1VhDdyozl
 YeFqyhPrb7TGosEtVMBjNVMM9P01CZNvj7rrNDZgaBwzLnK2waJs43OICVWQ4pW5ILSMK
 h3RWtr/AHduZRfNnL4+VXjBZktlOGwyM8DtxJ0aTkgyVM52e8Lg3KafdYUHLaOs2zWr5Y
 6ZUy+89lNSUOHe/A51+m3kEmJ2soIr8eMjEzZZeMQnI+c1QFpfSM8Jtdvv0Vl3rOZZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789662042;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=NzvbP32SuMa7suUvjy9uQ8YIaVkeDZ8RJP3BvLIaB+s=;
 b=FbEHz6luIrIHREYocLOUj91gGBBiR25xuw848vtsDT9BQ1vOdjoLNJJCKsdaUZ4GvRaF
 z2r351FgpcPlx9+/oPNgesjaVQ3E0L/hIFwID2aau6Q38iQpqy0hyvny6GgjN75Utuk1R
 gxISXGZN3ewXG763xmTPgn2Tebo5bCk0A6e284ltI4o3HBet58iEkz0GDdoZmvXPN/I9E
 sGV0juyiTd8ZLJahxKb4tbBkRn9pql5eU+NlQAb0Fa7FQJkQKRGiw8FHvhMgvzTAZ0pyj
 pNcwAMaOmSNRNZmprMgi7hdQ5UhnfbCyt4rE7r4xA0I590LHIc3tv4/bjgbGnPWhYxA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=iSY+6sW9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:41::19"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:41::19; helo=mail-yx2-x19.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=iSY+6sW9
Received: from mail-yx2-x19.google.com (mail-yx2-x19.google.com
 [IPv6:2607:f8b0:4864:41::19])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C94E608A4
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 16:20:41 +0000 (UTC)
Received: by mail-yx2-x19.google.com with SMTP id
 956f58d0204a3-66e4ab1b9f7so491447d50.1
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:20:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789662041; cv=none;
 d=google.com; s=arc-20260327;
 b=NzcX2rNanyZEL08phs/26Ryft/fdvI1rJJJBK4y5z9dZaNKCL1Ag6vv5Ub44dhBvCf
 7zFVZHuMtxBR6arQyB3DH4uPfIfpjk8UmiHveD0wbtC7vSpFUakDTEE+KN9bBhh8K5GT
 dL99isPfrstrj/OFg+tD6Xw681DKl9WK99QdwLxc5cCaahDYdrBpg87MIKgeCsGTZ57A
 RGMSWU77b+ChtA2jpglsDrVkuFm1GL0CXoIagXNTKqAunstFwZvnyuuc0nb7NWcGNpjU
 Fi3sksFO/byEIiJ7ni3hv3nhlRyoZPNl93L4FsbhrRHm0U9aUIAy/nC/KBMCQ0HaOYxB
 IxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NzvbP32SuMa7suUvjy9uQ8YIaVkeDZ8RJP3BvLIaB+s=;
 fh=gQzVqmbwppby0AgSVoZnVOwdcREHZVY9ac5o3RAiTCA=;
 b=I6CfbKG4mO6RVN1ZMibNL8e7e0LXL8ErTUkXKR0acEd7Mt8NuUnk4PJtHYPI7S8hZr
 bDIoe/PC90dzs6O6H5CusCuCmAbZxbHoBekzSMyooPELE9aCpvCesStbkuLE6AxUBvqQ
 fc5PhUboOGdi/CXpU9eQg114eNEoBkjPZUK2Ry+1iMEDOBmBBB+rmN5GlbrPzb9ZuFzM
 0Gskyyca3quiTbHaVsOyFs3gHN2RJPBP60Uas6lNY5qWqq2D58qoEU5ynLW4rB7YKrTv
 ytbKxtLOxChheWS5o+o2qjuTTGpiKdaKQsV1vvLBF7pHZEIbAhfp+7zOnR6jMipqJzmP
 C9Hg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789662041; x=1790266841;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NzvbP32SuMa7suUvjy9uQ8YIaVkeDZ8RJP3BvLIaB+s=;
 b=iSY+6sW9SgOMTYjzZewjCuEA+ct9kcfMYGeGQVW5g8i7YV70iJgdrlCBGf0IMev5ys
 rR6flUVCSoYRnocw9vPBKVVdWOnWw+tZcQw1iiZPLOAZTDeOymTX9yPkOqLCsOMKEYgQ
 NJa40Fc6cNugq62Bh5igTGYkJIxj54FwdzQoewam15oZHLIapt9M5e+PSUnyl5H3tYea
 YyaFM1MpMZHAgRqfb7g5sz3HKj8Quf14gEnDeGxsgHflEVnloTvxasR28pHmKgO1i5Vr
 idJJICFf3XC8Cx7dPLLGyRARES+dW4B7laHgks8q2OVbY2yxWuyAxBY9EEOo3TixGC/e
 DiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789662041; x=1790266841;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NzvbP32SuMa7suUvjy9uQ8YIaVkeDZ8RJP3BvLIaB+s=;
 b=nj6EVupU5E6whDlhK97BgNQhwo/GeQeqt7MDXIqKwTOa6JZgGtSpXVxGsNA5qc5n83
 /qly86Gkwa/E8jZKD+VayKmcvE3x3r9lPjv3lYhbC+hy0hCM6yoUVjizri1ZK27P0fFt
 bIy3T3uqtYMCgnB8dnvEmuyp3huh5QxYdjl9/Vrarkzl4psGlDfxwxOoxyQxbcUoAryx
 Lz0qTF4htayOoD+nCp5ufiNVa6CvEHEncR6AHjAAEuJBvEJ6t0r20Ebh22YHq/efgPNU
 EXsJpRmjhRyBdfS5/NEq+4aHPi89gOX34xa5oZkbGcB64uqwaNTiqN37vZmxg+7tMt+n
 HFlw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSZpa7yhVmJzf/zTdvBwjSGkHtI7tJQnqG3YUtMfQnV2hv8ffPbyWMzgiElGsyVDTtMpSty6s=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kl2Ta/23QVHhQjo/mMqZDP48Li/6P0fmwZTFnnE/HzF0ogNKds
 dPRreLbfmD+ToFNL/NKvFL4tKScVf//WGxkBFwabQeT/nSRNY5fpUkh764HOxaJBFLdP+N1N59T
 3/gWqBXcEGT7+IwjWBoap5sgT5PCnyPFipw6o+J0ktA==
X-Gm-Gg: AYBFou2x6fcoxz8nFOKiPocvhx5j0zMu0310wWKHDLwZTyqnU97FEEelt8G9FnItGAv
 BbQLOLtWkX0WaDhRa4oEs/1bSmZI9RHydJka/V4SFPXO9kvFEplm4drf6xYubVfgrMtcwGN5EGA
 e8gUEjEnyb6jABdOKMoFMaEFUwKlrkbKPo6MEhxFaZeb4XU4nH8HtgU1u9VaL0NTPNEbiRB/Q06
 +KCzJaJaGD+aspFfOJhbGZ6hcCIjIKB0nOLgFKkCdjQr3BKYa102bqlXTxf/iHRMWXBRdVhmOet
 pHpEYKvW7peUCD/NEd5S++E//vGqnweHMxpLnVSmXsLKZXlWtjsneaKnYLo0djYvOswz4uSPjEa
 VkV3a4sYkganOhJQ3OIGu9iFbvOTkgCQICMqu5Z/sd5pzrq+qKsbc3mcckLlvhIAaKE3MiQlM7g
 K56sqtHalviCl5O89XyuULbHkvXjKbleBR6otnBifVpXsrEQecU/ewJXYIqse+Rup5OhPPAvVMO
 3ra8t/9MJlJEfwk52+XoGkIl0tmV4mgaDuUO3jf+G4u5sOhw+FlG4KX/YgOx9xZgHxf6I1RX9gK
 WVdzBqOvvqHrZPpiu/o/N8HEZyaXKDvXzen4V4kUHH7Qlt34S8VjO8nFg9DRnNZ1gMoj1sVyVf4
 5vyRL069aBzxK0MU/ujlrzCI4uCiZTFabaU56WYrbmdN1u3pWGCrkNYA=
X-Received: by 2002:a53:d014:0:b0:671:58d5:3842 with SMTP id
 956f58d0204a3-6717042e9c5mr874511d50.45.1789662040567; Thu, 17 Sep 2026
 09:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260914-crazy-v1-1-89a0177b7531@arm.com>
In-Reply-To: <20260914-crazy-v1-1-89a0177b7531@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 17 Sep 2026 18:20:02 +0200
X-Gm-Features: AcwNN1VNC0Lh0pKiGUGHHZnmM-Eg8rtxw3l6BZcoRICvgWQ17WdmW0-Lf4UYzC0
Message-ID: <CAC_iWjJ4M3FJKvDCPxEqz03Lag_N2UanHfEAcd-OEYD_1x+TBg@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: fix efi_http_instance free on error
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Adriano Cordova <adrianox@gmail.com>, u-boot@lists.u-boot-project.org, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, 14 Sept 2026 at 14:38, Vincent Stehl=C3=A9 <vincent.stehle@arm.com>=
 wrote:
>
> The new_instance efi_http_instance structure is allocated with calloc(),
> but it is erroneously freed with efi_free_pool() on the error path.
>
> This can be verified on the sandbox by modifying the code to force the
> allocation of new_instance->handle to fail, and with the following
> command:
>
>   ./u-boot -T -c 'setenv efi_selftest http protocol; bootefi selftest'
>
> This results in the following error message:
>
>   efi_free_pool: illegal free 0x000000001928d470
>
> Fix this by using free() instead.
>
> Fixes: 238e0269d82f ("efi_loader: efi_net: add EFI_HTTP_PROTOCOL")
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Adriano Cordova <adrianox@gmail.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>  lib/efi_loader/efi_http.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_http.c b/lib/efi_loader/efi_http.c
> index 2a606aa441e..d26b2119d6f 100644
> --- a/lib/efi_loader/efi_http.c
> +++ b/lib/efi_loader/efi_http.c
> @@ -404,7 +404,7 @@ static efi_status_t EFIAPI efi_http_service_binding_c=
reate_child(
>
>         new_instance->handle =3D calloc(1, sizeof(struct efi_object));
>         if (!new_instance->handle) {
> -               efi_free_pool((void *)new_instance);
> +               free(new_instance);
>                 ret =3D EFI_OUT_OF_RESOURCES;
>                 goto failure_to_add_protocol;
>         }
>
> ---
> base-commit: a44f46af0aa17e48572e0d46c0d082886ee353c3
> change-id: 20260914-crazy-972d7c92a81b
>
> Best regards,
> --
> Vincent.
>
