Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036CAC5AC67
	for <u-boot@archiver.kernel.org>; Sat,  8 Aug 2026 16:24:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87B9C606AA;
	Sat,  8 Aug 2026 16:24:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NAx0NajxSzQs; Sat,  8 Aug 2026 16:24:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F0FF260667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786206256;
	bh=8wkkL9tPk0oookWQifgF+LCfaOmmy0qPI1HVbKXF4F8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=khI61jim22tp6+Ki25LBel81seQHepYSpaiQZ3yJcMdeB62hzbinS7+RKlOW2tlhk
	 A3A9B9TXqVttUcenjfAwhkdb58wuxl3GDr4YtbezbA3Kk+UaxmqC8LUJNsBgVukB8y
	 uRJsi0nUAd7tGq2jtOax7qTpxnhLlcCLlLCRHTGIY1L3Brll3HERIt+TpTPzrHox/f
	 eoXTLNyBz5YsGsxPt0/q8jVmKhrWqd8x/hUY3IM8wWwQbkihInC+5p+n7h/2gAfiJV
	 HIdV9W7j4sp8/gqXp6cyH0Q2CGioMsStyiQovuy7Xk3hz2uHoVRhcNBQ10r1rusUX1
	 04Ur80zTAo54A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id F0FF260667;
	Sat,  8 Aug 2026 16:24:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DDA3282
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 16:24:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1056980E78
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 16:24:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ko-wcEkAlFG2 for <u-boot@lists.u-boot-project.org>;
 Sat,  8 Aug 2026 16:24:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1F05B80E5F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F05B80E5F
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F05B80E5F
 for <u-boot@lists.u-boot-project.org>; Sat,  8 Aug 2026 16:24:13 +0000 (UTC)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-69c600f76ccso605376a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 09:24:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786206252; cv=none;
 d=google.com; s=arc-20260327;
 b=in3oeCc3Oc4AXTHBrokK0SVQpcNYVn3zNrP6ERkZtmP65nWIP5x9c3R83UxtvzpQj0
 IrGSNkosTQdTrXaHdZ+8KOWRSiR+5/dSq1OchFzyK1fDQvextD9wWZAbxfbNm8jdSyhl
 b3ONi0OpOMwxScumJodP/SYSpETxZSSmaeyxE7cQVmEK9K4VyffyKvNL+88ckuerTsno
 EaqnZkyeyrwvtcuenIwNefZDuncC1iB8RAITy9WOTvDhj2U+xOvrToVavqrXLSNUvc7p
 59I5Qa8Dd6aegCpmlypsRnIlMw1rWMxuy1ir6qB1LqqhrP5S33+0afHuv8IwpB4ZtbF6
 eB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8wkkL9tPk0oookWQifgF+LCfaOmmy0qPI1HVbKXF4F8=;
 fh=EvaptLl4ZRgYNA6EWAobL8SJupqMy+mPbLvLTsqLnCY=;
 b=IusU21Hl3FpieXRZxVMVz6feodgTMGvV+fGtBlFIXw57DKPsh1pB2tVY8RlvFhODzJ
 a3sXBTo8gsOXMl3jM3Tq17hfGZ66Ca007TESwJEJmqEs/AboUwrYtIZmq8//eaaLna00
 +o2Xu3H+g+5GKvzIjGRf78XYEmRwIv0+aBoCSsCz3k7rr+aVPyE67XBKsNeXoqB/dMeQ
 8BXrIALB3OPuW3Ce0TDdsZGtLsJ1v+Qe1cnBYzDz9OYJn9pW+jHyQL8iA/FK9X8PLoiG
 ccMlrYM78x1bB9myOoZmQxSnm4nLbSTKknAlLyRHP0KRjrrIoWX+t3iNvBehP0uEVnCo
 xCjg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786206252; x=1786811052;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8wkkL9tPk0oookWQifgF+LCfaOmmy0qPI1HVbKXF4F8=;
 b=SXLleDpjbKPhBXLQXH68XV/fBAq/AJCtIzQt8BddKY4Fm0FI4Lhc3CMcPunt7SFJkq
 DHVSEpCVkfF0V1mkkdP37YW6Yq8J9rz1ljnUSXZHp/+TZL0d7Y5QLsfbg7O1GpRP+xW9
 eeAWt5nCOUwHFgRHoh9O/CLPSUuTfnbYkGldSi53boo8ULfgDTbyhA90ZPa2CHUmn/mR
 F04U3DdmBfFSB7XNq1yv2NkqdU1gstmXvHR0o2zA3okr8ASFy5kv2Mut9HrGyt7TF1Fc
 +IVZF3eLk5RsSKUCNmXn0SBAYqyKUHobyhifpidYtCONJtuV8+4Z+qQWgCQ+HlaDRec6
 HiFA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0KwdU6Slfp4mn0Yzc/IKS2jXx/G9FkDrLBJLUYGXCjk6Qp7BX+jvgSZMLxPuJipUA8YgLPfc=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx7mz/fa55SjVb/Slkp+sIDEM92zgzIZ3uRaAGScoqLsLK6k9In
 xEYSTR40tF/zDgswXqjuPcNOVZ+4mdCNsxBHcMbPXqDTGd356nPkvhWW9YmMFCeDlhZPFDg9LoM
 6ni0p8hbpuUwXMFlKRYsm6TeNSx90fPVrjTE4gqx2
X-Gm-Gg: AR+sD12UK3PKojibC9eaMWSHJlup9Olb7Pb7DclEvlQhmmN/KWknzKa1SEF2QVXgQAE
 HJJUOtJapiVHeF3W9RxWuMVP3W1HROKej6+fnfrqizcfrxECSiA4hccOdLa3EEC1q7jT4qn4fP5
 efzBaspxxQxZeDmQqyYNYXVUyATgEynF8tCUntCYqiPsFmVOdlQHE2FdH8U/4AVDbv0RM6zlxPw
 ZgRmIQ7nN6UCZtP/81orhhA1pkB80yv6zkQNivG4V2eL+8x6P5wrPncLuqgCwiVWcSFl4Gu01ds
 Bh6MZp8TQESQjm9panrYNrkWQCU7wJjUF3sbsnf0HcY=
X-Received: by 2002:a05:6402:5349:b0:698:ac05:5b2f with SMTP id
 4fb4d7f45d1cf-6a1f258181bmr3050534a12.4.1786206251835; Sat, 08 Aug 2026
 09:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260806-fix-dtbs-check-v1-1-2fe0b9486df5@baylibre.com>
In-Reply-To: <20260806-fix-dtbs-check-v1-1-2fe0b9486df5@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 10:23:59 -0600
X-Gm-Features: AUfX_mxtqT7G_9lkYnmGSGz6dnKzUjBiN1DI4j-U7Y_S9O7V9Ig5SNo9EJW1CH8
Message-ID: <CAFLszTi0XiuovK3UW4Vq1XKB63ULKcP3DW5w-yYOkSrABpksCg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: fix dtbs_check target
To: dlechner@baylibre.com
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786206252; x=1786811052;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8wkkL9tPk0oookWQifgF+LCfaOmmy0qPI1HVbKXF4F8=;
 b=HUixmmMVMsL5ueeWkyHQGFTQakwwauXLR4j1TrxtfPlqHMFyv0uf4DNHTWZPebqPDS
 oxThuKg+b6xbIx+6MfZTn/H899rZwMlmnhD6dshkqPgsrzDvkJjlD22oY6K8aVd5pEvS
 mEuv4wIyQNjXvS9y5wK5hfDK0rls4WBp2MD6g=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=HUixmmMV
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi David,

On 2026-08-06T16:53:15, David Lechner <dlechner@baylibre.com> wrote:
> Makefile: fix dtbs_check target
>
> Use absolute paths for src and srctree when calling dtbs_check via
> sub-make command. This fixes dtbs checks not working.
>
> Without this change, we see errors like:

>
>     find: =E2=80=98dts/upstream/Bindings=E2=80=99: No such file or direct=
ory

Just to check, this only happens with out-of-tree builds (O=3D), right?
In-tree the sub-make runs in the source directory, so the relative
path resolves. Please can you mention in the commit message that this
affects out-of-tree builds, so people know when it occurs and how to
reproduce it?

>
>     find: =E2=80=98dts/upstream/Bindings=E2=80=99: No such file or direct=
ory
>
> This resulted in no schemas to be parsed and therefore no useful checks
> were done.
>
> Since we do not want to modify dts/upstream/Makefile, as it would be
> written over when we pull upstream changes, we make the changes in the
> U-Boot Makefile.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
>
> Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

> diff --git a/Makefile b/Makefile
> @@ -1455,7 +1455,9 @@ dtbs_check: dt_binding_check dtbs
> +     $(Q)$(MAKE) $(build)=3D$(DT_BINDING_DIR) srctree=3D$(abspath $(srct=
ree)) \
> +             src=3D$(abspath $(srctree))/$(DT_BINDING_DIR) \
> +             $(DT_BINDING_DIR)/processed-schema.json

I traced this through scripts/Makefile.build and
dts/upstream/Bindings/Makefile and the logic looks right: src on the
command line overrides the assignment in Makefile.build, so
find_all_cmd searches the source tree, DT_DOCS still resolves via
VPATH in the objtree, and the output lands in
$(obj)/processed-schema.json where scripts/Makefile.lib expects it
(DT_TMP_SCHEMA). The kernel has moved to defining src as
$(srctree)/$(obj) in Makefile.build, but there are more changes after
that, so we can worry about that later.

One small thing: $(abspath $(srctree)) is expanded twice. You could
assign it to a variable next to DT_BINDING_DIR to make the rule easier
to read. What do you think?

In any case:

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
