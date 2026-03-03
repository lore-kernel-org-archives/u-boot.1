Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946CCEDEBF9
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 22:36:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBE87839DF;
	Tue,  3 Mar 2026 23:36:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gtPjUbg8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2A4583E7F; Tue,  3 Mar 2026 23:36:21 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72CC8838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 23:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-65f92a597a1so8680120a12.0
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 14:36:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772577379; cv=none;
 d=google.com; s=arc-20240605;
 b=OCeRY8nPYdtZOnj5y8SoFYoRyoRnjHWr8UrN16eUxjnET07pOC/+Z/9okF8JOwC49y
 9ritOLMTHtHL8ExEyKmQSYXpjzQky70BL0uY2wJTcz65G2UHDME7Pb9jt5SVXj7gCgps
 IVcHcpsn9wz3RwTDeJ8nVDMWRVZgAOBJR6bwfUYGG6tYSxrytXmMo9rOjKuzzDaGTBK7
 Mc7zGAudw41jOKsQbtTeYYzWUBeOOpRb9w9BggCtk7uDdU2oPuuvPerDmPqwI26u+edI
 XJVpyAsZq6yKaIMS8kospDRtpdCludMyxx2xGUQWRgR4o5gGDyXWbLllZ91s9kOylFGo
 DDNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5dN5w4dWlafjtKkwMzboWdEtBSlgZRTPvOCVSO4jy/4=;
 fh=y88EDaYy9H+d+/vyESG5znfcSzemuCaVIpKX0g41HHA=;
 b=gHTjVTkZvP1aLe+icgfwDWhS9J2a8GiG6B+nHgHFZ67F3qCrxdk9v/e8D3vbfiZ3tp
 JSsSW9Lg9sVa4SkaE3Jt9p4mGRRiwe3HSNyDFZgCa3m1JT1m2GkP5+garBXXANa6en3g
 ji0lX97Uwz5JsH9VRArJwbS9hxyVpFfM939OVKY8WmNcRsvv15Qmc0T3aFgQpjdSU6oD
 bKQOxvSFtrJKcsg5YMOGkshCPqMLySWcos+5MnJ3O+irlTG3ubiGCmbwJ6yfgoHZ/u9K
 arlw1u4ifxJ4yvoNt8G8WwaET62mPO5H6IBJkc2oIKkAdi5dQjrFAfbxcC7kkmeqbLmX
 YoQw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772577379; x=1773182179; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5dN5w4dWlafjtKkwMzboWdEtBSlgZRTPvOCVSO4jy/4=;
 b=gtPjUbg8AwL019XSGbK62H2A9zZKfQ8S8lW0RRb9Yqsn9Gc9YkPXmScqYCiNGVeI7z
 6XpPowyf/WXxFOLyL9+crCliBLxLwSvUNdUxcLBNcWA5sw0yrVmoYbiXKwsiskAfKRdo
 t0NHxI4yeWD4/qEj7Q6wMJ1wk0dFw3zzfW6E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772577379; x=1773182179;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5dN5w4dWlafjtKkwMzboWdEtBSlgZRTPvOCVSO4jy/4=;
 b=VATVG0I0RhiCypscw8OZQcnr37VGWDRtS+xwnpez7aKqKrGiH2oFurVUZv6Bcqq+ZH
 Wa7CPo8/Ph2LpPc/8xaSapE0GByZWkzHR45tNRQK9CPcbxi5xRNHWnMo2LU0vJR+M3FP
 sOXCrxUNo81IUuFj5jiN/JtjBUoyJAKJRJ9BAsUEaLeYriahmOTSUDYAqAzX9bpSMo/k
 86q+8wM4COLpYHkvBg0hjUVD1i6q/lzuMCz8v0ofr6Qh68CiIIbNM8f+4PDBaQvYB1sG
 HWh55YhHrwJXkUjtOmQwbY91Jo2Gww80l6zg57co6Go4kkB0n/1HixNN7vTNR/QhuR53
 jCfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP4bYFj8WZMI3jCS9hgfHCblAuYd4Vbo/wlySFedRlt7elXeUEqgOR2xHb2B2zsdyr6UebYnU=@lists.denx.de
X-Gm-Message-State: AOJu0YyBMY1EjRTsUOvRGCYBDYeIC9vRRUbD3IJ6Jz3s4BE/Ily8fcp1
 af5M/TuP4xKeHntD80hJ/tQE4YRW2+DHdSr7jP5kKdZRoxXSQeSm9/AFxpvnhcKWONrX63vF4kc
 5NbJjAfymsboH92q3tNcaPy+STcbILlQXP09vNgo0
X-Gm-Gg: ATEYQzzcYlSVikDX1aCN4RgcuREq/PY8hiD7wB+8+7PaR7LBzLnwuda1Fm77/viRW21
 9wMApHxxMEgo0roGm8KnVNfJfWOa9fSZwUr76s/BLrh//rZzs1zhl/E1Z3SeijahfSohqPzhAfP
 G5bhVF6Pbvp21IpYHNP3W6qXPI7VNC3Nu9/Y7K04n/8CtPHgwAQanCRsLUfGBCNCxelWKRK7xKe
 ocAWL+qKpVaAUBXwIg61l0ULQz6g7Rq0n/FrtSLMlox35Bmpl7bYj4Eo3LCufjcv01f0yRJONo3
 ftgKkeMZKNuhzjwn
X-Received: by 2002:a05:6402:270e:b0:660:a0b3:e76b with SMTP id
 4fb4d7f45d1cf-660a0b3eac0mr2669743a12.15.1772577378855; Tue, 03 Mar 2026
 14:36:18 -0800 (PST)
MIME-Version: 1.0
References: <SJ2PR07MB97117FB8BBBD7DC1F5CE5A21817FA@SJ2PR07MB9711.namprd07.prod.outlook.com>
In-Reply-To: <SJ2PR07MB97117FB8BBBD7DC1F5CE5A21817FA@SJ2PR07MB9711.namprd07.prod.outlook.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Mar 2026 15:36:07 -0700
X-Gm-Features: AaiRm504Bp_mQ4oUO6aCwisbqt8uxl07l1cu4G1u91sOCakWVrhxGruPy-UqHYE
Message-ID: <CAFLszTiGqVULDZKKqo7T5djXFjX8CHWKWJWTUoBBvHDMZN2=xw@mail.gmail.com>
Subject: Re: Fix x86 baytrail boot flow, UPD/VPD Updates
To: Eric Schikschneit <eric.schikschneit@novatechautomation.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Eric,

On Tue, 3 Mar 2026 at 15:29, Eric Schikschneit
<eric.schikschneit@novatechautomation.com> wrote:
>
> After much research into this.. I tried building the config:
> som-db5800-som-6867_defconfig
>
> which uses the baytrail E3845 from the master branch, commit ID: 8d24789abed0822fbe41a2f9d72cf19650159dc6
>
> with GCC version: 11.5.0
> on Ubuntu: 24.04.4
>
> When built from that environment u-boot gets past the stage that I was troubleshooting.
> This has been confirmed on both the Advantech SOM-DB5800 as well as our custom hardware. In light of this discovery, please disregard my previous two patch submissions:
> "Fix x86 baytrail boot flow."
> "Fix x86 baytrail boot flow, UPD/VPD Updates"

Thank you very much for following up and confirming this!

>
> Eric Schikschneit
> Senior Embedded Linux Engineer III

Regards,
Simon
