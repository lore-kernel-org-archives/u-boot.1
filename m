Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33614606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EpF2NJkf;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=rq8kZyGt
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64B7F607C2;
	Mon,  9 Nov 2026 17:07:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w6scd5DCz59a; Mon,  9 Nov 2026 17:07:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8B30260720
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794244066;
	b=jYelaPnfZV+/3VivnQydgMR/+daoclj2WnbYsqawX5h1UmxH2Dl7cwKreIkGCbf7GDbY
	 MwAr8+ZfvWxdBIxNitfdbl+9JGuO+QNzouzZDfn+AgkonIyuWBL6ABRS4Bf0+UAvu+6Gq
	 hbSX7fUy+4L/pjTx776GaPoHfu5eLpIx0I26t5neYsda2FKfWWNs4LktDD7DTiBTHwb3I
	 71qm1p2ifuQiq6nenp2BAQjBpYSpbYNyR0qP8HTuZIqgIpwWaJeAV33Nyn83XFYtQ3vFb
	 sxaOItnZUPktgM6wFsmd8h9piDlDCKomXMMigWhlgKbk7ChLJ1PIyz57WwBQrP9VTmA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794244066;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=+UhAEoRTiObbFnkXdX0+dsTmNxtaj0xwHWT+264eCQo=;
	b=AOMOvqrUWoTLjMI8OHHsxjGXRpyuKZkwnisC6+gpDUcYgeNgAlJLnDeD6rYyAvrHsmcx
	 XiOr1cO/3D4pI94Gq/Q6RdGANYPdSsDTNBqGba3Mx0anQsjYdXeuo3xymnJCJ+uY93W5Z
	 b9EC/I8cvryllyJJIp0coiQLy+k5vpQ44wQtwk67sBvtJTaEJUK9mZ4SMSesIvSlorN/E
	 QBvZxbV2ErRwLvI46VQpPR7uAswIOjzKGmDnCSimhP+Xc4F7puSkKlNhu+5fDXKbfO1Ub
	 t5qIRrqgF8dJ356hMwxW+mg0+G9tfYcCn7f/leeJ9pf6ysQ5Rwv3CPALpKhWWCoqBmQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794244066;
	bh=+UhAEoRTiObbFnkXdX0+dsTmNxtaj0xwHWT+264eCQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EpF2NJkfeT5nsTI23KxxBhi7mbRRVMXidx/ZvSkOsDfvc2joIZr4Jj3FMqeS3iCpf
	 m3a/EUSAJ1hGpTE6yRMdXlvaz3ZjoN7wS8OnxOiHt9iuKM3CnDPghO2j94VjSGWqsO
	 kjxT02vrTHUBay0TQBkN7xWGJutuZKpGdZSqjeUi3v2BBsJ9F/LSxKspiKLbjm5LsH
	 ij9piZb539q22GYKpcWHycPCSJ1QGCggoSWVM/0revirXg5YN/c284LOUlzwvsYwEi
	 wIhbm6+9e+8jzpqUH0UK6MWMh7MyGGSsUvDrORasLhScIDULQccwGmQKlUoFbMwfbL
	 NnH9+2+6RnpgA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8B30260720;
	Mon,  9 Nov 2026 17:07:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B723251
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:07:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8CC8A80DFA
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:07:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yBb76oXOSrlA for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:07:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C8B9680D77
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c34"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c34; helo=mail-oo1-xc34.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=rq8kZyGt
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C8B9680D77
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:07:44 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-70059e4dab6so586323eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 09:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794244063; x=1794848863;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+UhAEoRTiObbFnkXdX0+dsTmNxtaj0xwHWT+264eCQo=;
 b=rq8kZyGteMzBkYHWYTRhOLSRET1a2gzKjHKGms18buDF0/klUgh3yt4cvqjtjiEYyA
 hBhcTeP1x54dl7devGFBQDt+9KmzwfgkMkVgCgyNelD9SkyFjTAQULNzjUznngtADYzZ
 oJTR7rIi4ZyxFwHLTuBPetEL1taSrvCkJfUqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794244063; x=1794848863;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+UhAEoRTiObbFnkXdX0+dsTmNxtaj0xwHWT+264eCQo=;
 b=oZROH5EXwdJPMpJ8urW5/yHGOX2m6ZiJ/tVjT6J1rvMcZHQZEDttAuCUv2ZQ/HhjaN
 vqo+crjxPD1sJ2DZaI0IKk0E/h+Wyhl2J6sfdBWoMghRqP7e2aNgUANZd5qR8PbOJ5Ta
 UiN09eIktpUoWe0k7IdXoHJzCraESw9NRWiNv1fi2TW9cbM2xkku3HV7L/iZ0yCnLi2d
 U99czFnBMWoJFJCZ5T2ksCEFON+8aZM0Wrx5lcm/5nTyCuYA8A4n0njJDmHmSDl0cYmG
 z1l9aG4DzwOtEMU44Fw+5fS/GugwqR/vdQAEFIVwrhpnun5Q+06uLFXU3UR3JtEwhZZs
 4x3Q==
X-Gm-Message-State: APuU4Z/tk20WUXf+b1W5B2gmHZH5p8gXCFQCocZm0hJeYMfsRh94cp0i
 ak+GnCRjJ0hIj2kwaJJERb/ZHd5DK7vE9oJuhBEGTIPN1SW6UXj8XP1/f6h+b/XR02w=
X-Gm-Gg: AYBFou2yu0jeJRysRsl5dJyUt8tpivjk4pjxQyxanJoy1erRQdGvK8YDOxX2aRA4ZCE
 EBduXQMvqwDk6HXIDAZ/W+FFzK/A0e9hN9nDvIunAUieOSq9KdRUKJwIvX9K7YN/qrQSkjmsjrE
 0a7OyeUJknhpFWc8GYzcCsE74CA9e8FRvxpchaZXDGSId7eFfjmrxivsgo7i2qBogIhI6jCSaNp
 UyGmNhEV74gP8ulOQZkLnLBgj8s4easM14IUiPOWwnoD6NnWB5wtC4KQyZWLKqzAvh7w2q5lTVH
 Md4vIO6DLTQQs3HsUcA8TS/HA9pfTioJwfrdpneI2qGgk4y7wswcJGd3PKhIms5ujxv0jpUEsQ3
 2c4aM2UD02yzGbOnCtQ3Wc6kZu8JTCR/eKWnMfAXoXmDLBcQNDD3CrrszcmKfVPJ8VVudjq648p
 HmV/93VPhjZ6rGke5MQdfFhsCBBS7EPNfj/OpVjYfTIX5gHGpYMCR4fkEWCMopM8I9wTPpEaDJs
 J1JgKqh8z9e4x3wTDf+nLYgAUDFsXwX6ZDjgp5NywrJ+3SCGzX0OPmh9RVUQ4b5CpzS86CBTNRf
 4CRg4lMCSOBlzWrr2pe2YT0LsTEmTajNmT6wUBY1u5dWfjNpqCkVsx2obGZEUC/3Gg54S5L/UsH
 n7mE8hZP12f7Fu/clKvp2VlzXgUsLKlbbc/zj7rUGlIIp3Z2hoZtFAQ1O45zCaAxUJQPKFazeny
 NPyjBrb/5lEcstUEqAjEqGZJJOIcXNCQ==
X-Received: by 2002:a05:6820:c2cd:10b0:706:5b0b:4e8e with SMTP id
 006d021491bc7-7170f2cb305mr1888020eaf.55.1794244063244; 
 Mon, 09 Nov 2026 09:07:43 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f4fbcd2d7sm4330128a34.19.2026.11.09.09.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 09:07:42 -0800 (PST)
Date: Mon, 9 Nov 2026 11:07:40 -0600
From: Tom Rini <trini@konsulko.com>
To: He Yong <hyyoxhk@163.com>
Cc: u-boot@lists.u-boot-project.org, alchark@flipper.net,
 daniel@makrotopia.org, jbx6244@gmail.com, quentin.schulz@cherry.de
Subject: Re: [PATCH v4 4/5] test: py: Allow custom partition specs in
 setup_image()
Message-ID: <20261109170740.GP3741582@bill-the-cat>
References: <20261107160406.3943071-1-hyyoxhk@163.com>
 <20261107160406.3943071-5-hyyoxhk@163.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p7jcTxG/VFzkBHi1"
Content-Disposition: inline
In-Reply-To: <20261107160406.3943071-5-hyyoxhk@163.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--p7jcTxG/VFzkBHi1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 08, 2026 at 12:04:05AM +0800, He Yong wrote:

> Add an optional part_spec argument to setup_image() so that callers can
> supply their own sfdisk partition specification, for example to create
> named GPT partitions. When it is not given, the existing layout is used,
> so current callers are not affected.
>=20
> Pass the specification to sfdisk with subprocess.run() instead of piping
> it through printf in a shell. The shell would mangle quoted values such
> as GPT partition names, which the new argument needs to support. The
> default specification contains no characters that the shell or printf
> treated specially, so the partition table it produces is unchanged.
>=20
> Signed-off-by: He Yong <hyyoxhk@163.com>
[snip]
> @@ -262,8 +262,8 @@ def mk_fs(config, fs_type, size, prefix, src_dir=3DNo=
ne, fs_img=3DNone, quiet=3DFalse)
>          raise
> =20
>  def setup_image(ubman, devnum, part_type, img_size=3D20, second_part=3DF=
alse,
> -                basename=3D'mmc'):
> -    """Create a disk image with one or two partitions
> +                basename=3D'mmc', part_spec=3DNone):
> +    """Create a disk image with default or caller-specified partitions
> =20
>      Args:
>          ubman (ConsoleBase): Console to use
> @@ -272,6 +272,8 @@ def setup_image(ubman, devnum, part_type, img_size=3D=
20, second_part=3DFalse,
>          img_size (int): Image size in MiB
>          second_part (bool): True to contain a small second partition
>          basename (str): Base name to use in the filename, e.g. 'mmc'
> +        part_spec (str): Optional sfdisk partition specification, overri=
ding
> +            part_type and second_part

That we need to sometimes make something more complex is fine. But since
this is an internal API, we should just rework the function. Looking at
the few callers, and git history, I suspect converting the last few
users of fs_helper.setup_image to use FsHelper instead was somewhere on
the TODO list, but got lost due to other issues.

[snip]
>      try:
>          check_call(f'mkdir -p {mnt}', shell=3DTrue)
>          check_call(f'qemu-img create {fname} {img_size}M', shell=3DTrue)
> -        check_call(f'printf "{spec}" | sfdisk {fname}', shell=3DTrue)
> +        # Pass the specification directly, including quoted GPT names.
> +        run(['sfdisk', fname], input=3Dspec.encode(), check=3DTrue)

Why can't we just use "check_call" here ? There's a few other places in
the test code where we call subprocess.run instead of
subprocess.check_call but check_call is the normal convention.

--=20
Tom

--p7jcTxG/VFzkBHi1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavH92AAKCRAr4qD1Cr/k
CiYsAQCNblbMevoZ5u16bjm7yEy67zQGQqBADvWWc2YLCgUQzAD/T10sJRgbz11g
mSRrs8TDfYe5otZGzaEo11hu3xOfTAI=
=rjkn
-----END PGP SIGNATURE-----

--p7jcTxG/VFzkBHi1--
