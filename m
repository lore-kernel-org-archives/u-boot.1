Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E56606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 08:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yJm3xFS7;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=eBkoN+I8
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA8C040478;
	Sat, 31 Oct 2026 08:34:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VHm4n95wsu-s; Sat, 31 Oct 2026 08:34:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CF8A9404C0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793435659;
	b=LekIJNhIMbOHTLeDunSLML7fndYVFHL4/sgOU0bAyiDYnzLNmJnDeL/CREVBBUCc2FrI
	 CH7PYucA58lODB2JNkgsAFVTpj1pvwnitXhk+cPWdy/LC9VOfBGIYtjVpkyZiNyTYdklj
	 PMygjAxXAQLUcq4ZlQLvSTIf8LJo/4G+taqanbjqchBCrFXEHOO8Ewh8BNut+rkpU4vSd
	 /fnB0lVrUJvXyQDk9BPxRChfcmgD3qLxIqstalVxTefyhRbf3XAHTrSnLa/92AZchvKrU
	 1fJzWEaGC5tcQggtFXNkvL6K8zCTMS3k+uG8D295Ov+uuIOfzL7oV5x3PpFOdPVUOew==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793435659;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=D3PP0bym30Y+l2SA8iNTGTMqc+FyznIzWSMQwRC+j4U=;
	b=GKA+X0lLywThql2MT8a9ZeXttRpfMqcbNszOdIGE/hguCPtBb9TiBTyn/XdrO5/maJqO
	 j6yJUeiYLhPlscfqB2x+jjGcTt5Cx/XVQ1fnH+Vi/bgDQ4k4Zsgu3oYLgwKJ+4Ypko4Zd
	 JuuLg9LFcCHnXvkTyO5qmzmgrN2VwRF88b43wLAZY2seGIA4FlgeapVwy5ge3c06mSQzs
	 YZzoyz9f9ixTEz2wAT15fc4eLgODJr64qnl45ygHzhShmHFE85WfWiOpG9AXUtciPBQfU
	 ztg8JUeggGTRyN24454AOlKNqLU2qJsdk2uA+kkEww3x2VxLV9Sn73uN4DV2p4b+G2Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793435659;
	bh=D3PP0bym30Y+l2SA8iNTGTMqc+FyznIzWSMQwRC+j4U=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yJm3xFS7hM1EWdRFubPXXMKFt5hceUCxDZkTFHf9OPOn+o2RrsHYfVU41UgIWpGxE
	 5i8gJBR0/UHb9+jsoeZKCSK1fUSerYqrBJZwT7Uug28cXmPoBw0JqbbVa9uasT0Isn
	 3udCkHfiI5ONcMz5moo4J7KY73trM4aJN0qMtBMAJ6Kc+Jz3IdapaHBzgLh3xAJeEj
	 w1AEGMYBRDoucRwcCJ23NG7v1qSPB9ujcyO4R7+60vsRwhdXCOcftWZNjMnB9RjgKL
	 trhUP60514lA+3ybO6zQEwivPXwF/tDHccdr2PtMB2m/Yn9Ack4SeXkuAx9pXtWYr6
	 z5QHALKFmUU8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF8A9404C0;
	Sat, 31 Oct 2026 08:34:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7E9C91DE
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:34:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6FD1D40057
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:34:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8edHTHBgZ6SV for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 08:34:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 718B1400B4
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::531"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793435653;
 b=PNLJF2RT6WWkLvUzulMIUCIFwExxZJ4b7jI6iGdWZ41c4htYljQKIf1CTS6Axn+cuGpD
 0q8w574sh/bs6XSM399ghJ5ilo4wiHBfoaBDceo+wojDU2pkTkzcGSoY0HWZAMcKUWF/h
 iQAyAGUWCzJ6NeDX50UsUe1X0t956IbGoZqHIBG804bMmq6nWgG8rCTr1ph/o/TZ//0pf
 FrBe6ayp1//YlMKZKUY8lWrIAu42qLsJJTN+Ywkl5yo8DSkd1IwGYrBTXEK4JfOCVEB7g
 9EDpCAOY7/AhgPpCwFckcyBZIavT+s2DNH36vH9hO8IpOrcfzHTzdy44j7C/TAqavxQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793435653;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=D3PP0bym30Y+l2SA8iNTGTMqc+FyznIzWSMQwRC+j4U=;
 b=VEgGwlNHmU0+NxqqYzBsSkm/q1FS50QnJN0ALFhVjtdiqY2/M0LXOeXyNhZx2qf7weeu
 itoEhLt3u6v/FX5IEj2/Bs/K4Uu6w2d9BuyhoDPGbyw3dJCgNIwcmDJp5Ud1SPY9L6Iba
 xW6petvUDrL00cHKX+VEwA5aq422o8IaOZuWCQ8Twz1SFZlHtffS3dQAP+2HFnXYO9bKV
 FxvwwKvTX9hk5UosyiKcuSkZQ9RGEp/GH4WF7nBZmwZUO5lxQr3rGOVeo0y4/OeNNR4lN
 6s61ATvQxc3iMFPj7laXWsAvrl4+PMOZyVvlsafZQ8HQUhuQ0ENjyeGiIjqR8Fkcs6g==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=eBkoN+I8; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::531"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::531; helo=mail-ed1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=eBkoN+I8
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 718B1400B4
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 08:34:13 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6b1ab2ad719so1956700a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 01:34:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793435651; cv=none;
 d=google.com; s=arc-20260327;
 b=FQDsbUSLB9o1NW+r8C4bChwM4TNCfqB21QWQDKWDcq9Obm+5kOpVo7RZ8TraDDm+eh
 nLZ/mPetQ8NoP/lp+N2rsRx7298EilZ+skDEOOCT472glcq72pjIZb41QXC7BqAAiGHz
 0SlfZSxJl+7aN7abslR/XiSoPdVv0dOSQ9o0EmAYkH7MJfO41wGnGpEVONYNcF7lhqty
 iXlXc1FbnBAOn5zhI1KUwd33JeyhxPlYP9azm8YJof5SWOWkJYLW1DT4o7XLZ7C1kvJx
 plArfeOUrJcsCMtF/cabSw80QSwjysZiVX4Z2TpP8xyR/9r7xLQN1w1zvIWAiFsS/uX2
 /H9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=D3PP0bym30Y+l2SA8iNTGTMqc+FyznIzWSMQwRC+j4U=;
 fh=VN98Y0auae+gfOO5vPHq5BCDyz+eiCJJZ2MVhrlBNbY=;
 b=hCRyhwpLvFy+J5ShxF/UR3vpnLUyZJM/PQDfYnGA7X2VSJ8kRWRlrwwE+GFsIfYtM8
 3GnXPtp1BJh3ivvsB000V7MXTq3RYt9rq/6UhDA5OjsyaGq2L+2KnrGEYnUguQIcUII1
 iNUCLa6mpypAkx5THzp1PS5z1FX4nTEynBtoghsilF3P342F6OgeMmNbEQKuRc/EH4Pd
 m6OM71q06JoBHccwcDiFtQlmBGh03tmRlpF3GKCszCldTHuRd7NxG/cuRyXh3d7oC4X3
 CZhqyk1le0De4pXwOA0EugPeLIwNuKETlgE3i2+AQby/r0unDGh/lS0AUPb9js/a8rE+
 C3Uw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793435651; x=1794040451;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=D3PP0bym30Y+l2SA8iNTGTMqc+FyznIzWSMQwRC+j4U=;
 b=eBkoN+I8cfa7a+YF2M/faCPgsMySzTYVk7/l9nbUWpZTe2QzB2r/UEth/Qik23pttx
 h5TKu4X/RW8kjEAky8Ue+vOtD/0CSiFof3vbrHPxoxSvrwV03P8Q903DyQefM0kyVNtc
 VPcYPKIrvBBBrUiGoNMUqhllo8fasftqWWCjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793435651; x=1794040451;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=D3PP0bym30Y+l2SA8iNTGTMqc+FyznIzWSMQwRC+j4U=;
 b=h/VybJeiYumd8oggFHlHDQ14/xeMiNrRl8Kn1cz1EyePQr9qzypRzbOhhHNzX8JW/z
 EXxRTTFjC6Sa7eq91AsYKOtN26GGy6135Vlg6Uv1+oJkz8GgxohkptQNNe12CxBC5pz4
 XXRHnmloxDRHagfSiurhZEtG3+9DGAAPeFyhAJkCNyWR3ykq06cX+CZ25wPs6ZzudvQK
 obzVtJ4LEjo6PxLEK8iFpmt3FAxopZd+1icO1Z76HiGDkbDtj8jANB1T6MSeqFURrhOT
 qYhMVlInacOaMpL+yY4FPKtKyYrDehTrEBm5d5YQ5kHqoATAEMRQTz6Zll7D1I2hcg0l
 Uhtg==
X-Gm-Message-State: AFq9FYJXh4UzoKItlEY2u72eMQy8nq3agDP/NjC2wxYnGkfE4RVtORL2
 xBv5g3EfSPHyYL1sqwyNEGFKp7XqITEt7y9LypdGmS3VLBpCZToFjWlEvjuL1bNcTaQiUYbM9iK
 yXBRw8EUpgw7A+w8JexZcQRDU2iik/WXd6k1VFlkJ
X-Gm-Gg: AYBFou0slVU5e7LJu2IY/j41tXHBv+7+i7/dci86OX+aEsOL8ACwtS7EbYLpQbTQxdN
 Ic68Wje4Yd4Xol7CWpy1vvSf0oU8JYPcnLZ8l9Q+mFYUw0krkAyPHG6o/y7bqLvApOr15dx4OYO
 +tl4WTwZz4X1O6TI3NrjS+Ia2jOpwr6yVztNgBRfejhKQJ9g0o8OpXFihCU2F2g3FM1b11tRvLH
 TsU5kke9TDEFiac721kN0TAudx1Yj8IWjkbRB8GwF2PRlv1Y7wMPYM1EwZav2a4xQ01g8W/CUuT
 f/fSR9ExUMXuLejBYC68TvxaxovTt0/BDKu+5iGDUyHvRUC8KLvAZ3KR5zlKU3Lp/ZHoSbKhEUu
 /T1U1bBMUX5VQqlOB2ZXIoHKBDT5Q/A8DxNVlz8Mqr1JqV1dgNxmb/gYgm1dzfxY9SYg4nFM=
X-Received: by 2002:a05:6402:2749:b0:6b3:fc9c:6343 with SMTP id
 4fb4d7f45d1cf-6b4d3286204mr3346308a12.0.1793435651185; Sat, 31 Oct 2026
 01:34:11 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:34:09 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 01:33:19 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261030143843.467968-2-felix.moessbauer@siemens.com>
References: <20261030143843.467968-1-felix.moessbauer@siemens.com>
 <20261030143843.467968-2-felix.moessbauer@siemens.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 01:34:09 -0700
X-Gm-Features: AclHuK85XhcAVluVfW1UB0LcWgZ2KUX3GS2k8ujOLV9su8MRShKZVEnn30qvNtc
Message-ID: <CAFLszThFTkeF4zn3n5ueuaidT0jPZNQ+UJ18UBtieCoL8ooeYQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi_loader: implement EFI_TIMESTAMP_PROTOCOL
To: felix.moessbauer@siemens.com
Cc: u-boot@lists.u-boot-project.org, xypron.glpk@gmx.de, 
 ilias.apalodimas@linaro.org, jan.kiszka@siemens.com
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Felix,

On 2026-10-30T14:38:40+11:00, Felix Moessbauer
<felix.moessbauer@siemens.com> wrote:
> efi_loader: implement EFI_TIMESTAMP_PROTOCOL
>
> EFI applications such as boot loaders (e.g systemd-boot, efibootguard)
> measure the time spent inside the bootloader prior to loading the next
> stage. These values are then forwarded via efi variables to systemd,
> which exposes them via systemd-analyze. This helps to identify where in
> the boot chain delays are happening.
>
> Without having the protocol, bootloaders have to fall back to direct
> reads of the time counters, which are architecture specific. To unify
> this, we implement the EFI_TIMESTAMP_PROTOCOL inside the efi provider,
> resulting in an architecture independent interface.

Please can you use the imperative here, e.g. 'Implement
EFI_TIMESTAMP_PROTOCOL in the EFI loader so that applications have an
architecture-independent interface'. I'm not sure what 'efi provider'
refers to.

> As the implementation of the protocol is tiny, we default enable it. If
> this is not desired, set EFI_TIMESTAMP_PROTOCOL=n.

This should be CONFIG_EFI_TIMESTAMP_PROTOCOL=n

>
> As the implementation of the protocol is tiny, we default enable it. If
> this is not desired, set EFI_TIMESTAMP_PROTOCOL=n.
>
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>
>  include/efi_api.h              |  4 +++
>  include/efi_loader.h           |  4 +++
>  include/efi_timestamp.h        | 35 +++++++++++++++++++
>  lib/efi_loader/Kconfig         |  8 +++++
>  lib/efi_loader/Makefile        |  1 +
>  lib/efi_loader/efi_setup.c     |  7 ++++
>  lib/efi_loader/efi_timestamp.c | 79 ++++++++++++++++++++++++++++++++++++++++++
>  lib/uuid.c                     |  4 +++
>  8 files changed, 142 insertions(+)

> diff --git a/lib/efi_loader/efi_timestamp.c b/lib/efi_loader/efi_timestamp.c
> @@ -0,0 +1,79 @@
> +	properties->frequency = get_tbclk();
> +	/* get_ticks() extends narrower hardware counters to 64 bits */
> +	properties->end_value = U64_MAX;

Just to check: get_ticks() only extends a 32-bit counter correctly if
it is called at least once per wrap, because the weak version in
lib/time.c and timer_conv_64() both compare against the last value
they saw. Once an EFI app is in control, U-Boot only reads the timer
when the app calls into it. With a 32-bit counter at 24MHz a wrap
takes about three minutes, so an app that reads a timestamp, waits at
a menu with no boot-service calls, then reads another, could miss a
wrap and report a wrong delta to systemd.

I suggest mentioning that in your doc patch.

Regards,
Simon
