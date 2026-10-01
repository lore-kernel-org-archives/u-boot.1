Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5D7CA5FC5
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 01:21:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A0728121F;
	Thu,  1 Oct 2026 01:21:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ra8zg9k7T48G; Thu,  1 Oct 2026 01:21:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1ED2E81214
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790817693;
	b=NUKgN/7JzOkUtOXe7zDnEmznDiKm3F0UuqwDH5kjapif7VyMBYEbahEJuBTCISMgYRaY
	 THZmAl11z5zVIFixMDT7p9qOlgiYQhgzDZ/i2CiK3fUl2o3iHRDrrvrpFPrw1eGL1f9BF
	 QOoAqXKQ7ixSoG8IBLHa8LdmYI0R4jR+jZOgE5X8SuF4TYIy6vq2CaRC+zxYene0IqQlA
	 +oNiJ399UZN4At9EuMKYGQBlcSuP1Kah+9OaoXvvMD1lqU8Woj0PpaDTXCCbOku+dUBRn
	 ePG/Z9TgqTwyiALT2+9osW7dwkZFdwH2KWm6sTQa3VG51kBzHYItlzXZPwa05904tyA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790817693;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=GKd0zQbncd8Ow66fjpap5zJqFzwMecQGTm1/eVRY8ZU=;
	b=iMhztS1wMzZT+ERfWNTmoCEyktw0AqQg1uqwM2CJkMlqtuOBrL8DqtTcbYYUhAWRIbQO
	 Z/+HWDZ5jT0DgBxsqL0lcy7NRqxEP8MCTjdqSUU5LbsXV/vAKhaHNh9VOWH9shLRRvMr0
	 A8BTHfF9tvm0/cywgobrHyBqHf6OnSWZre1E/Zvlt7hlcDH488OH9gvyYy2Lcq3lrmcDT
	 RQSzyl2idJkQ5aPI+0H0wlpDx3E2ltlCafLWsaebFP0XT1WNOvHJ7DLrkDdNL3LiHRe2f
	 TyWPpvVQRWY3cF9RCDVEcGJVa9cEmSiRbr3csOXd65bOLHcFvXk6FbE+VmcglJhHbFA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790817693;
	bh=GKd0zQbncd8Ow66fjpap5zJqFzwMecQGTm1/eVRY8ZU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DfjzPN/YpC1jCmMZcg+EkfKwcpfaqyQzXCfEq4cK5E4OAx3v0JaP2/Rk+SfwnG9nR
	 NFbVVSWCDXoQru3ohxOptPgFdbeeXv0r5jGcPAF/2oZiS+mtrUVC6nUje6cDdncT4V
	 9Ji0M+yF4ro2S/WHILgXLMpXvW/qe+s7Tf5539iaMABnfHtBdXeKVZoPv6kB6B15tQ
	 wOGcPQyFP+KHKEaBAicoaEPPOSulRJgghBAAJvn8LR8QstDm6+ZbdXvHFnwB6oy3zg
	 H/NYpskpl/XltarHaYE8OH1pBvX9YdeItok64GP68HdxC/bX3S7lhXrkuyKxhXsQDL
	 4rIHuVBADfqyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1ED2E81214;
	Thu,  1 Oct 2026 01:21:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DA21E4C2
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:21:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CBFEC40B22
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:21:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7JyWTUz7tiOJ for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 01:21:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0F84C40B21
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:39::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790817690;
 b=nPvN41VNkah5B2fXlxeQUKDjW+J2378WkANVOP2/8qJto+9MevVDviEYhV7+ceO5iNA8
 ZHqeHF8yQfLv/P/55qD+Se1I7Bzdzlzt3oIwupkowJNuevuvapxdFbiKLAcK7UtM/Fsv+
 H4LSy55KruFES9quR3kPyxFGWnGa7mHJ1axVUL06eeZGnXJ1nfKQjbAVc5r/Udokv+h4Z
 LLd+AhnJXndWom5KdUyOzddYunsompBRbcF6UdZLZ589qR9Qiy9osE7nxdFZQMN0nhobp
 TK2iGs7ddPFKFgaT45wQtUX26q1ZPqYp4OzHQj2AbxHPIbDDGTl1Pp/9xcsicMzmWBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790817690;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=GKd0zQbncd8Ow66fjpap5zJqFzwMecQGTm1/eVRY8ZU=;
 b=MDnHH75SBoj8NvNeZPwBRlqetjax2Rmw3TqySu/jgRyGEGzqbx3S7muUG4B2kWFfxcKY
 HQzlb4WrjFEEsJyg6pOtWi9F8eTsDtvgvcbXLiY3+4EQt+B0esafxHuE2BsNT1DHeYblH
 8uYGWJkUXflGdGKQc+aNWo2stC9ExtpATqQNZdN7Q4PixNZIRMfCuBFRG3GHEmuB0XJZG
 YczYil2iQzqLA/l/Y8ODbVfZbGDeO3qfOHQ6EdjWHc46uGyeEeI6PLunxG66donGVxWlO
 MTII4U18xwbB3ejA3JdRFV7x3tNo9JVsXK9cGJRuVf7f5BniT1CSWhW8Q0aABLp1klA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Ej62xETS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:39::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:39::10; helo=mail-pj2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Ej62xETS
Received: from mail-pj2-x10.google.com (mail-pj2-x10.google.com
 [IPv6:2607:f8b0:4864:39::10])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F84C40B21
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 01:21:29 +0000 (UTC)
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2dd58e1e2c7so29015035ad.0
 for <u-boot@lists.u-boot-project.org>; Wed, 30 Sep 2026 18:21:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790817689; cv=none;
 d=google.com; s=arc-20260327;
 b=OK3tW5BQmX9f0EO6EEPsMtfKdT51iy8BHXCvZ5YQwPHsMuYqbiS3Lh/fyDbcLKmpS3
 89bz//w5WjJv1RcsAl41PVlAVWF1AUPQFh8nuaUKYsA4bfvR9s/5DO2F1TT1wC96jN7c
 Wllu5DbfxN0bfiIDay9dmbmzJ+7Kd7yOoih2WBQQo5y8ZQVVFt6PyGdm3VedbgycmMhG
 BwS2/uqxfTVcPQx0ggSda9/CAr0YI4pN05ZZGffssYZrjuwS0ZSQme9SFEPH8hlh2SsG
 uaiZy5BPq1cUDf1I7wPF9JIWux7vToG7GodKwd65gfpYaZ0bM3UJRKAUJkm0OMGUozie
 xugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GKd0zQbncd8Ow66fjpap5zJqFzwMecQGTm1/eVRY8ZU=;
 fh=dZ0tJMEGsIVFUzoIG+XzQP0n93LR20+4J2Xk227cWpM=;
 b=KMxXrjpwf4OkJPfuo809kk2bb1SO8kvnCMODBZALqxJGcMF915QCfpfVqETl/bnXIz
 /NBVAeht1qVWpyT/QEftDtbAYqiJG8V1Iw4Q8PRATardyzP6F0ArUvljBlo6H0IUfkD/
 EryuSWdnWdaFIIwr1a/bFwPLCakzOpOofNL0McF3g5DJHcakeDyiCUajHa1zOX6oGe4W
 +Hwd95JguxOmH9WnFmLE2gu+UogngMRNuCvbT6bEY5oBN+SUAzxXObA8CrdgZZPQKSNL
 zsIFQRrmvbzzVyRFwGAIfJybFLEoMwCIhS6zOIbBol1p9SsV3YTz9Gdm7952rjpKsFpJ
 8zjQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790817689; x=1791422489;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GKd0zQbncd8Ow66fjpap5zJqFzwMecQGTm1/eVRY8ZU=;
 b=Ej62xETSAAjhsveJF2p7FWPdxT5v9FRfjmPzfHSN1+Tw3v69CrIuamk0p2CdEZltpJ
 8XH21TGye2MmdPtM6hj4GrHnBBJWfs/rZgRoe1K6ufTqQZ3ls9BZmaqnt9FESeAiYUwo
 j/0bP8T0ibBkSvB/WV83iSg3Q+rvWbU4lJGt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790817689; x=1791422489;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GKd0zQbncd8Ow66fjpap5zJqFzwMecQGTm1/eVRY8ZU=;
 b=CJVD+zdZX/IvcgIJzFT2qtTavcPMbCgEMwpLBxVcCd9xEcrhS4GA5nTfLoPNkgOt9H
 r3uZCdbhOxrH+Gt8cc1OFzKAiHy+Zws0u936Piap0+ATSatQV11C7lQQ35uZZtRBP6lV
 WdDmdjiHnMBOGAasu0hcWOtz0OhWaQLrJsAkb/NBIDHzaupvVIsjsMDCbjVEUVGkXzfL
 Fz6rEUpCrspT71DyNW8vBNK2GRAzwyTuFZeeV+yWsvyWz+K+MMfnLLDDVM8hOxN7m5nx
 zSzqamCPg5QjAtVAw7mvpsayDMAbwxe6jVdEFzH+sxOYhLSa11U+F31smBM5aQn3/aZH
 TDZA==
X-Gm-Message-State: AFq9FYLPPfJOznVfUQWuaZ2g0Truv85KuS9Oii65oDLRWEGxoG05EVMT
 Xnpmj/XajVbGPlKdi9DRKpC3eL6nKzgNQYXEIPjbPqsF80tsN8NdNSw5MdcFa25QFyZ1Ii9G18i
 YXGyPz7zpAr/BaP3jKeWI5e/NMjDpy47bxe5F9loI
X-Gm-Gg: AYBFou145ruZRwOvw9Fc07M5cNwdQboer7v0majd2Rqilv+Exx/moGEefiz1fanQ3Kp
 6jz3kBhLHuCSolmKk4evET6pWxnpOQWKslAC6XiUYGZu9niC4gqbP5yjvZty+P3MiDM90IXYFKa
 aRLPLUY0N3lCI8YplD70gV7IjGdKMXvp8zASF0VYDbPf7wgOvDO2pMrw2aEwre9lM19FA95JJBZ
 uiEVmhPriZfGWNvjuLwlh0kllvI5d+2ovew+ndf8sMm6tlhfDJkw20yHPQcCbmBCOZqrTZXIUbF
 86zz8m3hjrUz9+pQ5rp98v88oI16FnLeJhj2PQk2X1HAcBthomh1cjaX
X-Received: by 2002:a17:902:db05:b0:2e2:c8a1:ab63 with SMTP id
 d9443c01a7336-2e2e49fb754mr24669745ad.17.1790817687427; Wed, 30 Sep 2026
 18:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260929110315.2879640-1-suraj.hanumantkakade@amd.com>
 <20260929110315.2879640-2-suraj.hanumantkakade@amd.com>
In-Reply-To: <20260929110315.2879640-2-suraj.hanumantkakade@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 02:21:14 +0100
X-Gm-Features: AclHuK_RJ0d8vZHVUAT6O8vLuXDktk8Cw1iEcNP25bD5jtxK1SeR8ppiUJoSAIY
Message-ID: <CAFLszTgVsth9dWeB8qGY-NivzfvnmDjqpEnC67dwQAhyBc+btw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] scripts: pass dtc cpp flags via a GCC response file
To: suraj.hanumantkakade@amd.com
Cc: u-boot@lists.u-boot-project.org, michal.simek@amd.com
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

Hi Suraj,

On 2026-09-29T11:02:52, Suraj Kakade <suraj.hanumantkakade@amd.com> wrote:
> scripts: pass dtc cpp flags via a GCC response file
>
> cmd_dtc inlines dtc_cpp_flags (including every upstream dtsi -I
> path) in the HOSTCC command. With a long $(srctree) that command is
> too large for /bin/sh -c and Make fails with "Argument list too
> long" while building a .dtb.
>
> Write the flags to a per-target .dtc.flags.tmp file and pass @file to
> HOSTCC/CPP so the shell command stays short.
>
> This change requires GNU Make >= 4.0, since $(file ...) is not
> supported by Make 3.x.
>
> Fixes: d31ff219a833 ("Makefile.lib: find capsule ESL dtsi file with CONFIG_OF_UPSTREAM")
> Fixes: 1e7883f6325a ("dtbo: Fix dtbo generation rules")

These two commits only touched the lines being changed (one added
-I$(obj), the other replaced '-' with $<), and neither made the
command line long. The length comes from upstream_dtsi_include, added
by 3a4e5944c96 ("Makefile: Allow upstream DT subtree to provide DT
includes"), combined with a long $(srctree). Please can you either
point the Fixes tag at that commit or drop these two tags?

> Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> scripts/Makefile.lib | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> @@ -448,7 +448,8 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
> -     $(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
> +     $(file >$(dtc-flags-tmp),$(dtc_cpp_flags) -I$(obj)) \
> +     $(HOSTCC) -E @$(dtc-flags-tmp) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \

This breaks the command-line check in if_changed_dep. Both cmd-check
and make-cmd work on the expanded cmd_dtb, and $(file ...) expands to
an empty string. The cmd_ line saved in the .cmd file therefore holds
only '@.../.foo.dtb.dtc.flags.tmp' and none of the flags. If
dtc_cpp_flags changes (a new -I path after a dts/upstream sync, a
change to UBOOTINCLUDE, or a new -D), the compared string stays the
same. The .dtb is then not rebuilt and stale output is left behind.
The same applies to cmd_dtco.

Also, cmd-check expands cmd_dtb on every make run, so the flags file
is rewritten for every dtb even on a no-op build.

Also, $(file >...) runs when make expands the recipe. That is before
the shell runs the 'mkdir -p $(dir ${dtc-tmp})' at the start of the
same command, so if the directory does not exist yet, make stops with
'open: No such file or directory'. Makefile.build normally creates
obj-dirs for $(targets), so this may not happen in practice. But the
mkdir is there for a reason, and I am not sure every dtb/dtbo rule
goes through that path. Please can you check with a clean O= build,
including the dtbo case?

To keep the rebuild check, one option is to leave $(dtc_cpp_flags) in
the compared string without passing it to the shell, e.g. by
overriding cmd-check for these targets or using a filechk-style rule
for the flags file. Another option is to shorten the command line
itself. You could use relative paths for the upstream include
directories, or fix upstream_dtsi_include: its $(if (CONFIG_ARM64),
...) is missing a '$', so the condition is always true and the arm64
include directories are added for every arch. What do you think?

> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> @@ -486,7 +488,8 @@ quiet_cmd_dtco = DTCO    $@
> -     $(CPP) $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
> +     $(file >$(dtc-flags-tmp),$(dtc_cpp_flags)) \
> +     $(CPP) @$(dtc-flags-tmp) -x assembler-with-cpp -o $(dtc-tmp) $< ; \

Two other places still pass $(dtc_cpp_flags) inline: cmd_dtc_diff
(used with DEVICE_TREE_DEBUG) and dts/upstream/Makefile. cmd_dtc_diff
is appended to cmd_dtc, so with DEVICE_TREE_DEBUG set the command is
still too long. Please can you handle those too, or say in the commit
message why they are left alone?

Regards,
Simon
