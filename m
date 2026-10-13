Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EE0CC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 03:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1E76405F8;
	Tue, 13 Oct 2026 03:36:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mF18YoKfhXVN; Tue, 13 Oct 2026 03:36:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 326B5405DD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791862611;
	b=H1PtWDyGo/iOLWmM57mnqNMDQvuen172DCOFYE1MnZW6ktCppuxPGNZmKvYkwEGHrY6V
	 6NmFvJ3n0IyAw7oiFu8HObvqVjVNf9ROmKOhNiMXmwf3Tvoj4S+kkURcHqm5CYbPzQf/t
	 6SbZwek9Tr6j8G1hlhBL5TFnw3aonaAhKibCpZpgV1CfHbKl35z/ZY1Zu2fnLPzNkxYuT
	 X0mLGsDDwbSy3uSTK3tX/seOVACGnagcnriWJ97eVtQ3clRRsU39U9DcJ74TFz8ruYTjf
	 dQ3Vg4JBaR3jYUH5AE8ZSSWVo89Br78jZr5AnRGeuq4svqo9ij4qgTc9FJ69GCFxYXA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791862611;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=1xpLvTCzrNbbOwmhy6TbM/Ml0nd/P1fw8V3L+CVs8pI=;
	b=rujXvpKwj3/JlRbLRptblkJgnrAz/U0PqeJ5q3a3hIij8GBxKRA2QI0wx18kwSZ9mhYZ
	 aSGRznosR6tifD0wgWVw5bO9gODdZrXzZjNFH9WH8KC3SvoSyoK663H8K/w5tuGdN1REm
	 JyWXJu4Lzw6pW3GeorvVlGepVT8TJr3sUWl2DT/YU1k0pyxQWrvuMZfsPppqYEENnHhEA
	 CJU8Ixqn53ppaVeSMOkhi4dk9fHuIDEHwAW0vhsgPNnB8z5DPUJu6XusS6V5Q5+J1x3qw
	 EeR12urTPO44YyE31J7RdKWMinMRzo9OG+bJhwwlntGoALmzE+aasH/egwaSi3O9HXA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=AdNglvU7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791862611;
	bh=1xpLvTCzrNbbOwmhy6TbM/Ml0nd/P1fw8V3L+CVs8pI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NvdBuwMTYwN6AWgVkeGz8skWo2rkEExBTn3wPcn8ksxNPyYZBxtx8URnTzF6+7HCL
	 IyHssA0oW0KfzV6lGrArptLDOKWvF5P/FdrhrLv41Rj2thrMoc7O42JVlRRdQum8jy
	 tVlyuVZ/cU8Uyi9AXaBBOiTnKLdm6cWiMRVpYCRyVa3lCOgCvGQuWub71l3EzDuXqq
	 7HAn0LbQi90wkyfHFAx/eCJTzqsjUFWBurhRoIC7ovCKLhAoLdsy0fE7Q0GfLAuuD+
	 6WpubeqNGHq+3zH1Mubc/IE5OMkcVfMImkrsfWJdsS2WwIZ7yAOlOLjIiIG5jYg55S
	 risqpsaHm0FXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 326B5405DD;
	Tue, 13 Oct 2026 03:36:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D63F31E9
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:36:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C85C040581
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:36:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tBqd5pRIA3uo for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 03:36:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CFD39405DD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791862609;
 b=GUpPJZN35TR8YukCX+COL+J5ivyO2QqiV1ulEYD3HisjiC9Z6pRKr+rL7L+AQ3d70y2U
 XxFmbkPRLVKUBZqA3VxdOGcbJ5hFoLFYBHMRud7GMWDjezStoYjOcMdfUGyEyO8H2YAei
 02WNIMvSXUmCBMw41nfD4ZdVJYYV+GqDdDTAQJzkX244vNUKNPp5+1sHoXQh10k2Jr+5d
 xb8s7D8m5FkHVAa3NN+3MsfxNBpwdSKRnw1C4K+AJ48Ai6KSlnxEkqI/GXZ8oXlQ6wFpJ
 k7KULkjGQHdz6ashDzt6Vl3qZX7MY1Tp43Gvp9kHYPNqFr3I9+NSxARENYoKRgDXMyw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791862609;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=1xpLvTCzrNbbOwmhy6TbM/Ml0nd/P1fw8V3L+CVs8pI=;
 b=RSwtD9qARIS+PslrjteM9zen/Jnj+oyIKx65P1bVJIDnUrZrsGPE2ohYsergl0krca0T
 7mWCPJ94TpHTkGhhJSTnvA6wogossDm1nRHvk+4JGkwv8Q9sEStnefpZWsx6DFXDGmbF2
 A/n4efqK6j6nF1thKE68iJnZU0zzho2jhJqpj/RlG/rzZFLoA1Ed2vhQvQXIhv5OsPnoe
 Nhw1RTLhZAHbgQXYXqVYprZHORY4MIVZiLtVpCsYsebPJ6tJYEF3X4i1lSETfVPkR5nar
 AsPmwI4vPN2nR6WBX3ieW4c/hGDE/kzuBdZNnRghbPYvGGPUx+4zOXzv2WfoxiHgdUQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=AdNglvU7; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=AdNglvU7
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CFD39405DD
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:36:48 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b1dae0febeso1327311a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791862606; cv=none;
 d=google.com; s=arc-20260327;
 b=YTa0rYHOm3rOtVGF3iXPDtgd9OmX2xt/0GaZgs1LlQKIdaD4LLMOj5Rf3ReW5zZCko
 FbeGbl4IXaWXtxy4HJu8GaxS6Rj1PUcUPXSV1EpycTN3t1ikFYQHAJMuYARO5ItO9Ikd
 id/33k5zsZMTb5zudhZYiVtd9Zh/apW0uS6IpR+ZydBjz6mxpxIZxdBMgvQ3L/Q0Akb6
 50pxXbjZH/3EG1vrvWb6KMQ1Gvx/IZ9l2Rr4HmsmPihQCuk4Gc3R7mneuecGLKDve9Mo
 m+5epWd6zc7YK/cjOB2YmI1scNl4ET71mr6lNaanhF0YuBCbLwioN8BV9yliMJ+IENKA
 Ykpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1xpLvTCzrNbbOwmhy6TbM/Ml0nd/P1fw8V3L+CVs8pI=;
 fh=V3RexjA6fDaXrF8PLue/pRP96Vuiurd4J7Jkb6uhreI=;
 b=QvGL724+/Ja4oHWBmKgKAnyGr9B2fBU4uKmcbAkf7u3imxf0uRCkyjCGKZc0HfQdrM
 53K4wfhXrXDFIhy1vkX9xKIFf8S7SQS4OOKBMl4pYTaRazTXBdRIQHFMpRNgrUJA5+T/
 nKeRfgNfox1yvMwiZSLefdkfzaNH06H400IhCYGtIarxIz4BS/JQ2J/0IhK2ISmE2kZ4
 yXoveyUhL1zeZrDc9v5d83mXZNGjMNfojECDTv3TSAAoxxHmPTnWhGgcF9VtCQLOTr63
 2H0WpI5X3DjDpau18jZSpJBhjE+jjGLZdo2HbxZo63KLAgY1lCIz1ALKiaPn2G73FM6/
 1wKg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791862606; x=1792467406;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1xpLvTCzrNbbOwmhy6TbM/Ml0nd/P1fw8V3L+CVs8pI=;
 b=AdNglvU7D8VTsOLGu26oT2CObhu5G9lC2r9LK26b1sLpZxTdLRK8+a0qzow5ca0lew
 INVczEENsznRz/m9plnQ1B2tbhdL489nfV3gT6QCmpj5/PZqrXHNYuBY92oL2x1Sj9+r
 bptLgTmKWQIJe+FgYYzZCVyf+Hou76LZluvoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791862606; x=1792467406;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1xpLvTCzrNbbOwmhy6TbM/Ml0nd/P1fw8V3L+CVs8pI=;
 b=H30IskBICoKHLqL87r4tZMOSZUWRWUIDgyWCtEB477vdHp/N0DzVmhuw2+6S+zdfdb
 LDfiRLRXmFdGH/if/bknNy/BRKhCejxtvs9m5xt8w19pTasd28iMJ/VqoiuwJlvaDhqF
 6tKu+mmWlb3c1MFw56Jul5TK3WOBYETBVnUw4ahmANQ5z14A0eAGiRUnokryij7PGm44
 7Z3056Xe0GmBYGIhH+WQesbAdJCLP/md23CBU+5UZ3/xvtLJ5TBU+lqOwpnMOa47AqKv
 i0pBgFqRW6lpGUmBLttZgMBdZdnENY/tCYl7XRUOIvgj+Dbj0tuTAQCSRTf1H89pIi2q
 YvbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvgHKfbC3fuwpouSv7d9qcZhrTSozu73g1nFV3M2aRfS2oowBzQwsmdWlqscnEbe+LlMh+lcs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYJR+0nKT1iXm4ygRWMfiLYUG3s/QpRgS213nq8MFE5ik7MbyJpZ
 8Kt2TG7DRp5Pe+3fqW9QESgQVZWF4L0HQu40rE4ky2IMRTnT0U10SVktvp+bbtxsI+OmvfFvH2H
 T1GmEdCFcGKQo+BzLQ00Q6bcRMqxPtQ8+NJIvjl8I
X-Gm-Gg: AYBFou3D651Vb6JaT7btSbzBTtxVAvV8Ha5DyRUoZ9h7iPCVk5lGwwRWMRLFFw0JOoY
 OKvcKqGTt8UgHOJat7Rm3zPz9KAxpZRukBb77CPxgEujTqp6is8ucaZnG6btPIMAbVzvMIDPm2/
 1f8UgzwH2XsNRATmKazzFObCi6Xiksv/Gq/AEzxgq3hXaGJ5X7WfXDXAHFrtclCRm9j8w4pODxY
 /jpXU3nBABA7OafOLzv3dzWwZyngtiasomhP3wd/u2Q7NORxNyKhbzEd56NufnkwmVygkpG7J0G
 ypCSkJQX4V5FqSVv+r5tQYDf+KLQ4LI7hcWnM9VgodkXq0rqPlt/NFK+
X-Received: by 2002:a05:6402:501d:b0:6b1:e474:e0e2 with SMTP id
 4fb4d7f45d1cf-6b1e474eb97mr933337a12.43.1791862606489; Mon, 12 Oct 2026
 20:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20261012140048.214059-1-heinrich.schuchardt@canonical.com>
 <20261012140048.214059-7-heinrich.schuchardt@canonical.com>
In-Reply-To: <20261012140048.214059-7-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 13 Oct 2026 04:36:32 +0100
X-Gm-Features: AclHuK_8eWU6TosaTZ-HXyg6Ts2LDPmT8tFaG46D5wh9GKxkSAKgPt7kufI849M
Message-ID: <CAFLszTgC727cRd=0vu28r1_iKj+5+1ASBgRW5qA1BZTognE9Jg@mail.gmail.com>
Subject: Re: [PATCH 6/9] test: Probe RTC early in dm_test_host()
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Huang Jianan <jnhuang95@gmail.com>, Daniel Munic <v-dmunic@microsoft.com>, 
 Tony Dinh <mibodhi@gmail.com>, Alexey Charkov <alchark@flipper.net>, 
 Vincent Jardin <vjardin@free.fr>, joaomarcos.costa@bootlin.com, 
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org, 
 linux-erofs@lists.ozlabs.org
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

Hi Heinrich,

On 2026-10-12T14:00:39, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> test: Probe RTC early in dm_test_host()
>
> The ext4 driver probes and reads the RTC which allocates memory.
>
> Ensure that the device is already probed and read once in dm_test_hook()

Typo: this should be dm_test_host()

Also, patch 5 adds the RTC read to ext4fs_write(), so dm_test_host()
fails from patch 5 until this one. Please can you move this patch
before patch 5 so the series stays bisectable? It is harmless on its
own.

> diff --git a/test/dm/host.c b/test/dm/host.c
> @@ -26,6 +27,18 @@ static int dm_test_host(struct unit_test_state *uts)
> +     if (CONFIG_IS_ENABLED(DM_RTC)) {
> +             struct rtc_time tm;
> +
> +             uclass_first_device(UCLASS_RTC, &dev);
> +             if (dev)
> +                     dm_rtc_get(dev, &tm);
> +     }

This test runs with UTF_SCAN_FDT, so the sandbox RTC from test.dts
should always be there. I suggest asserting rather than ignoring
errors:

    ut_assertok(uclass_first_device_err(UCLASS_RTC, &dev));
    ut_assertok(dm_rtc_get(dev, &tm));

Then a missing RTC or failed read shows up here, rather than as a
confusing memory-delta failure later. My understanding is that the
allocation on first read comes from sandbox_rtc probing the I2C
emulator lazily. It would help to say so in the comment, since it is
not obvious why reading would allocate memory.

> to avoid false positives.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> test/dm/host.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Regards,
Simon
