Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9E1C88E56
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 11:45:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1249C60751;
	Fri, 11 Sep 2026 11:45:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uuuTJTyybJKO; Fri, 11 Sep 2026 11:45:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 54C896069A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789127121;
	b=rNii/5Fevb0QXNLbKwaAMmG7Bq2lCF1kCMiZsic7DHQmcK/UY/1peCUGQWLFCIfM2+cE
	 jKUrzIOywUv1fDj9giHY7cej4iU/32IevrVrwVjffbCRAM1Sgz0fzNOw3HnGdkmzm1CYN
	 5DzdA4AmCXGwgPbVxbusuacgHyEwxhos4Sitj50f5vwR2GBIEQk+29ka8y1fhFMsoVIV3
	 JNq4j/OFyoVOYWpcWwiyOQrJdyrKT2ZOcynVfwwdoXAuJr+ZKwMKdV4MX44ZhMmZLXjvu
	 xQWP9PUEc7M6X6tv1kxuh+9kQD34qPc2CK4tae+Tilw1GiRawYc9JvoRswWB+ykmbxQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789127121;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=SZlQgbE+hW0Hc/eTmznxA76/2TopJAv+V4sYyKZVS8M=;
	b=HsZsQfgZqH8qtsivjckzeuwiR8duzDYYuTOJLoj8BM2JZFvZj5dP0O9652vflvwTZrc4
	 MRa3jK1GsOPMbtOrVCyCRYuvCNvnU3NSSnAcMTFlkIxBpaSLBB5+EVAWxg+PAU/zxqyAM
	 QaO+h+BYoB57wrodmNvYwejqsdvmnOsRh1C3FqKgcz2s7F7r6/0YHQYfZAuELeWnmPwvg
	 57rdLgTXoTg+iRGvXFi2+SSBYklhvSC512iBASyp4I1YVNOAx7DvfnsMu8mmHX3O6MS7R
	 ALMPH0YNjChh5dIMM+Sd38jw+Rdp1yJiSON2OgD8geMvAgViJvxUZZ1YQ+Xly+6UToA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789127121;
	bh=SZlQgbE+hW0Hc/eTmznxA76/2TopJAv+V4sYyKZVS8M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ixCBvMZQACSs6QLbUymrBIxsz/JrgDkd69z1ZonIlATun9Zh4OxEK/s5CJITToNpV
	 O6XWThffLQGYEvya1rxfilA+xbR7EO+RrWU/lyvSnJDyRrjQIn4AuZ7sN8uegpdMVF
	 pxcdC/iT4x0pS9geDZujKy3KRok1uW9ntXvnQGkvPDQ2606ewEvLa9pY4kvWYlYG8g
	 SrazD8VPpDCJvZRbbhWD6rkuwltaIOur4tUt2VYKO5+n2GQQlQmWUt7DaocLNj4fyf
	 2nr3zzvgfe6KSM/7CzO/iyoden77ACu4khmOcYD10waPOOhi4CSIL1r4v6sX74doQq
	 n8Oy105HJ5ngA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54C896069A;
	Fri, 11 Sep 2026 11:45:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 516D132F
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 11:45:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 43A2040469
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 11:45:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O8uHKNRtDX6U for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 11:45:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 3FC60401DA
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789127118;
 b=U5uPmJ1d0hzTMy1IUzm6FiK63DFtBRlH962flqv1wF9Yl4O3PCseOzY89/c6yqZDm12B
 FnRSWD7opZ0VPmQ/Ni46EZ9NdO0mcO80L0A1jOu1DP7z2SXULlTlDOq1ruGyVEreYqZH8
 +MXLnZe9ef0YJS9dGATwjHsIAo1t1v40Sy9cKmJRvyHLQk6hrjy1lxOme5opSrG4OQkPp
 Ok1yVUU0grEZ8fhlSwwyMrTfsnnrACpOVS58yTg0bO/QcMF0N0ZqPVKywlC7WiCHuIx6G
 VolrsOU/QULtzR73jdww+Vt0HOogAYVXfHb9VVyRXPyA5Z1JJ239eltd3L4GROM/aaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789127118;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=SZlQgbE+hW0Hc/eTmznxA76/2TopJAv+V4sYyKZVS8M=;
 b=SSeFNeG+QU4y8p0CsW3NGqk8MDtnXMoz/AYKhcg6z7qMptxLw5YI8FMHF5EmDetfbJhT
 HniLK44Vd+GQDZHUirSFZ6v7T6SPiqrBplqOnEC9gfiosLz3J4Pimlo7BMvT5oSnUhHL6
 yMJFOOKf1OEng0QY7Y0/24sT1rcFOqryE6BqTAELR1SoM9mN6kzVwwhJhz+m5YIsKpkof
 FrHwQJ0jSiyVZtTJrOah9/SiCF7QH6DremcDzn8UW+Ds8Lt1riYA14XO/ZqiOgU+nIqUs
 E+sIF0NxIMmg0lOuvzf5j6/PSRvZDK2KC4F9pTqAQbSPVed/vHMlQvCKxy4HKooiScg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=URqRjRDV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::10; helo=mail-ed2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=URqRjRDV
Received: from mail-ed2-x10.google.com (mail-ed2-x10.google.com
 [IPv6:2a00:1450:4864:33::10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3FC60401DA
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 11:45:17 +0000 (UTC)
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a9c4c3e3b2so80075a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 04:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789127115; cv=none;
 d=google.com; s=arc-20260327;
 b=I3x2TiAgg0viUmS8+jIcH/CHrbatb6R5rLq7V5Yxqn6XrDGzIhdvpuWposJIuS8YiB
 EGD/ciwwi7phuRknENW7wHmzFrg6/xeuvqv5Dzawq9D+7L8bcX3oV9Ol/oanKjCBYowQ
 hG2OxGSN7JZ100QC0i1rmBIYz2P64GXwkIgT2UXtQGh93/EuN5FenxnyNZ8ovH6Am8p7
 CCZcnUA5JEmYdJcyjTfuY6INILsrQRw9N83T4yad6Oxbi8DEGpNjigzpbKZ7k69AMDGl
 gve7IqToSwmkgSrhhEja30EV6Ps9k5m8VDvJ66yNHN5YKnQexuD0ktuFQ+MtL/rfIJ9y
 YATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SZlQgbE+hW0Hc/eTmznxA76/2TopJAv+V4sYyKZVS8M=;
 fh=uvhTNtKTmGRRkzorYCArhSKoDqgPlPAD6XWFWX3f/oU=;
 b=jJ2cH6AJuuPXBpkqaVeV6qzzEoEyRt4JOw3Gtp0Sb6BZKe5AlOoSKE/uYQGrv4Rx3O
 OjXKW3XIzEdHJ4/E/p04R8o+hJ+op2xpEdm+23kK7jlrUV0//roK6MDaKJDQZmmjErvj
 b/dsTfQk3Hl8BLNUIA67pMUO9BJnwe3SJYSvQjMRjAsrBPs/enjQyKaTOg9zXJfDmKjU
 wVFSL3x/IqDuPd68NR1+a0R9hVJ8yjwDFqslYsVwetB7MRwPdrRYG9JyP/5LDm+XE7IA
 wbpxqVFMYc7yTV8YdGDaYjcrlEE758lA1cj1WNCIVGg7LzoqkF8YFL9lRqeuiBCEt4O5
 IU5g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789127115; x=1789731915;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SZlQgbE+hW0Hc/eTmznxA76/2TopJAv+V4sYyKZVS8M=;
 b=URqRjRDVSKPuWoPIXRMxp20GqEI0AxslVPD83DyxLzAIwmU/R1Hft88id5oMEEd1Xp
 pF46Od2XrHUjGPvV5kMnu1xyuzd3vuABpiF0LTPl7Z1gjj43ZF5MKNZl7H94AphC7ep3
 hK04jy3kgvXYIfKjCBLNlHefKt1MeXI/HuA+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789127115; x=1789731915;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SZlQgbE+hW0Hc/eTmznxA76/2TopJAv+V4sYyKZVS8M=;
 b=eHM5hql7NcSjOV/II7Kn3Oy6YfCmPlRh6Ri4X9sI536rdc5itynYtRmUawH7W2dkt6
 4YoCnejQBVgXPn+c5sjPvTNgytcpinqjjD8F/JD+9jUE84PShKTKH7Wl5/hwepFvZfhU
 MB3kfL3La0wqxB5wYyN2f26YrelrmJhNJtlGAnFWgrNmD4t6b04teYbpUGEm80Wuq+39
 OHRKbPId9zvmNFXcFyNpa3RyhoburEayJIn/sY6zggMk2E1ciEwynO3oJaYHDapZvbwh
 JZAGhx8ZJYdUjS8m7NyQyn152GKPfpjIsjcdaYLAgZULKe1tCdq+tPHl5LhBXnhbei6i
 Mjvw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy9LIvPK0VB5FpAtjk5AbgAxbQ6u+HAv13/gmnafPYhwCSiksa+5GDFka6zlcUHfijfDrBsq9U=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ngHwFtiJN9jI1dQSAL3SIl38wt1WnEqIaBwyAk/yHas2aKBjUt
 N7+76AlXnQRaxpaNg01rtFkPsk3EbiSg4GAGHa3QzRlanexk+8lreR2Pdau9Sz517d8hDIOBQpX
 udL6zU8/Z1gIi0JaDhiRFdNhg87NSaBqlzVau//eG
X-Gm-Gg: AYBFou3Nglb8utkI53BXabGyYuh6pMkJHZykzQQn8EFYtlp3iTOxIzCkD8RKbkGjHJk
 CoGiGzd6rvK9NPo9ND6q/AV7YZLcHBpB8CFPnLVR8ih4YtHdPGC+pm+4KSsAuh/EHT53SSQLF9J
 x1/qq6aELySpxWAZdoNjUjHfZM9Rpj8bdNrPkYz5oTn4PQSq9OJu6WfuMCysgovmKmpU69g5t8a
 jxbXpVSstmq/EauXh7rj68K7/XYzR0mWeFT/7rs8tRCyHfKXS9ggYfkISRPInud3thZEnUJaetG
 a2F6ClCihTXVIfAJYw+dFjGkfbwnifjBdo1mwLCPe3XYNuhKBt9qJqM=
X-Received: by 2002:a05:6402:f20:b0:6a9:c139:8640 with SMTP id
 4fb4d7f45d1cf-6a9c13987b6mr983452a12.11.1789127114969; Fri, 11 Sep 2026
 04:45:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260829192119.2658328-1-visitorckw@gmail.com>
 <20260829192119.2658328-6-visitorckw@gmail.com>
In-Reply-To: <20260829192119.2658328-6-visitorckw@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 11 Sep 2026 05:44:10 -0600
X-Gm-Features: AcwNN1VyZTsuXGykGLCI1w-I9QIo6STbuYuUIlOLvWpHs8K4YBXHD2ojlz-YeHI
Message-ID: <CAFLszTimE0ZxNpYPjxDZdOQD4=ordEzcwgpnoGihYBN499edpg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] test: 9p: Add test for 9P filesystem
To: visitorckw@gmail.com
Cc: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com, 
 sjg@chromium.org, jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw, 
 eleanor15x@gmail.com, marscheng@google.com, u-boot@lists.u-boot-project.org
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

Hi Kuan-Wei,

On 2026-08-29T19:21:13, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> test: 9p: Add test for 9P filesystem
>
> Add automated pytest for the 9P filesystem testing directory listing
> (ls) and file loading (load) over virtio-9p in QEMU ARM64. Also enable
> the relevant configurations in qemu_arm64_defconfig.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>
> configs/qemu_arm64_defconfig |  3 ++
>  test/py/tests/test_9p.py     | 82 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 85 insertions(+)

I think I saw a change to the hooks for this, so I assume it passes OK.

> diff --git a/test/py/tests/test_9p.py b/test/py/tests/test_9p.py
> @@ -0,0 +1,82 @@
> +    output = ubman.run_command(f"load 9p rootfs {addr:x} /non_existent_file_9p.txt")
> +    assert "bytes read" not in output
> +
> +    output = ubman.run_command("ls 9p invalid_tag /")
> +    assert test_file_name not in output

Both negative cases pass for the wrong reason if the command silently
produces no output. Please assert on the expected error string (e.g.
'Failed to load' / 'No such device') rather than the absence of a
success token, so a future regression that swallows errors still fails
the test.

Regards,
Simon
