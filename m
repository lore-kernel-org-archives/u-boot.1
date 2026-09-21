Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6533EC982E6
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 16:28:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 108BF60759;
	Mon, 21 Sep 2026 16:28:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cWGlA_kXc10a; Mon, 21 Sep 2026 16:28:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 50A7060740
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790008118;
	b=DkhQAXfS+1EVRjnugAxJVuhI4U9L4R/1lVB28jRippCmmCsEPR4jr3wWX9mqvnzXkNsN
	 BVxjKpXcaYjNm51dg6fxkDJ37NjPa3BEhdvcmTTonHZbChRHum4Ij/sB7sxxsZTU1Lsad
	 y+aH9zbevjaMabrb59TASBriw6AkUvHCLjnluYhrJIKAqYUZq848SH1ngaMwAXrA7lh9w
	 2f/m+d+4bJ6o8IhPb7kd0juDWecPr5meFsh5opZK9FsjstAxvVGvsz5TpaODHDeL3bbk5
	 HSvqfF3LczfuaBH0tk4b5e+fIru6Vn86qmIZo0jBciLrCHgwAhsQRDE188nIjC0mxow==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790008118;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=D8fCSPVJxMlHKn63wdKRJsgdinlrq0hk/pp6uxvPesQ=;
	b=LCuimoncF61f09fBui11twLVBxzn/Mk5jl0PRZn82p4QepjItNlpoX5LGFUJQlHiodS/
	 2KsmjZPYcR2dBNFpMAAxyXSet1d8iXpDSm6Sb2KRYp36tBAlQaPQubX+yGU4mhkASa2IK
	 g5nlaGUo1eKQCWd6EGcuEnkvQ4gi1w5mw3wwHGnpkcYxT4aCZmsLKKh/I3/1lc1MtqGHX
	 5Q3ldHkvC5igbd4/5O8+lkrizLjeNKWk4Basx573UDrfTZ4Kgo/v+013vt+xbUiHDGk0c
	 c1kn4seaSBPddVXSiMeu67HhE/rdHxo8d+tzqeyGA1OBSyUErKpfcrGE8u8E1Zr2K1g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790008118;
	bh=D8fCSPVJxMlHKn63wdKRJsgdinlrq0hk/pp6uxvPesQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OP1egTJUKACVj6JEKuZov2j0QjIPr2JkXMbxRgfXuziKa35dcCmOmw1hom/6ddTiv
	 Nymy8SsdWQ+QT7FtL/8sr8DAwJowDZ6yJIse/iiSjDcEzx+EBayotWm7opeqPGBLVE
	 00iHhZ/ybImSL6Ulcqj9LlYjHqmI2kTZ8w+q+IE3LhWx+Hr7m3JpzGp5l8GXDNws8Y
	 ALr0Ux43ITl1/aiMho2js++2+WtFqTqERrVsGYa+p2+9E5Z644z9mv88rZ5YzKQYwW
	 J5LyTHWvJBVr44VrU/vVxM9MSbTKVuEluRyJ668uNDJfi5lDxdEmWoW8nv0Jyqd4mt
	 lReZu1f3A7dQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 50A7060740;
	Mon, 21 Sep 2026 16:28:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DDDFF12C
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:28:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C390580DCE
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:28:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D0W5o05dJoNJ for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 16:28:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E4E2880DCB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::20"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790008116;
 b=e0fMOiT7VZdkV+7cc4GIt2qg9bmuf8Eu5pK1icMXk/cMloIRW/Bwvsa5K8yehj8o5C95
 oE0Zcbejmf9q4pWE6b3bUBrLjqI70kC+zkfiKpPifYs5CZ3CZPpveHB+tWMI3E2K1kFxo
 moQRE4szDUb/tjTrVMYyDDJZDf1yJ+SbI/OEM1baQSMK0qCltasd+egzuBwab3Qcbek1w
 O9R1I8Kew7/pAsbAIx4ebESjyDv8TF9WmeZbiFbO6ALnVSQb/3BjeU97a7Flc6Ld4FbZW
 6rT2HaAZWrm83PW5gBcx8JZNIXN2tMAsYHzL+JG2c3UQPqvqisPm2shRauHbEOa8umg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790008116;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=D8fCSPVJxMlHKn63wdKRJsgdinlrq0hk/pp6uxvPesQ=;
 b=pzD8+1Idrluplc6e19yN4sM2YYFlXq+4C0m+6XBTqPPZ1nbze5FgZd/QKvfMy8sE9F3p
 zbotrMB6j7bx4O/yv4MIXlIGDcRCSvq6aSnwm1mFmdYX+ZPS2P6WQWvimSlQeZN0pF6wK
 meXwPLOAqil3p1RHmas12BFrSQxKV8Sb2osp7/MT5qLm8SefcenNs3CeKw+FPFSQG/Sux
 Kul7pYVMslBf4JbibGZI9lp4QDayceyENeomtu7IeeNPS7L+jd1Ubprq07AEyQCDRc920
 TNBjqS/877Whv6r5njlKVEyB5zStXXEgBqX08Z6LdZXrouZoy/0sAPfXWkjoBRxsW5Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=eCnIoXCq; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::20"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::20; helo=mail-oi2-x20.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=eCnIoXCq
Received: from mail-oi2-x20.google.com (mail-oi2-x20.google.com
 [IPv6:2607:f8b0:4864:32::20])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E4E2880DCB
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 16:28:35 +0000 (UTC)
Received: by mail-oi2-x20.google.com with SMTP id
 46e09a7af769-80a18990c76so2265105a34.2
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790008115; x=1790612915;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=D8fCSPVJxMlHKn63wdKRJsgdinlrq0hk/pp6uxvPesQ=;
 b=eCnIoXCqtjFAWtsXDg/7DjqdxYP4Wyg+4ejD8hQ8od0+0R99hdi9s6Y8grwX+DnSnh
 GYx4dD+cPDuzKXkizEUsh7i6j2QRu2Ykm+VQ9KJjH0XtZ/zPmAbF+rWHQbBFGK7xRddo
 5yrGFA1P6VuGr7vtCRhEJKa9+btqvxm+T7xp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790008115; x=1790612915;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D8fCSPVJxMlHKn63wdKRJsgdinlrq0hk/pp6uxvPesQ=;
 b=IBZZEpAxcfmx2000Ydc5puxD5b0IVE65QNsaCTlun6sngJx6iZSx6VhGmGrESuyctl
 9kMLgupNRaEx5ylYm45ZIrWHT5tL91qYxHR71d4dP2wlueEZQMIBkZfQnZG8y7rzgjRj
 0+JX02rUUo/gVeOvZ163UzIXJu7S/ZIMlS8MozwcXonduQ3XLFGsJIhnVeSSscYs6xFq
 gzCcRYybht/TWXDoKTUISeYreiugAhvCcbh/CBR27LgAev32HJl2xWHNy3GdUsLskfge
 /8y+x9Hzye/gmzHRHxwgO2a/xvs0lD63MsY5I32Lv7jBTL0c8xGZ0Snf+CiIBKn3GjCp
 klhA==
X-Gm-Message-State: AFuF++nkwk+dTTjK3qBn4JKSA6OFJ5JirFc3UR0wXaK2mBbzgRXSQNc8
 uBr9M2aaqQgGlknCWI0EN0x8GglLsaDU7KLgt580xYONW6r+n0xjx5+ANG7SF9PY8ek=
X-Gm-Gg: AYBFou2pNcPyaLOkYaXW23YjkpJpGSR0BecOlHncbUE5YOM3dSU9G8E/EDCo+KyWDwM
 9W1xnV2xJsxH/BgTA8nUl5Le1RNnKtXRbL0oMHeGOna+gmcr04r9yfx586p0JjDy7abuQsoFxI/
 XuoQPcLjgqVfz5OL035211gea6XxQ62Wv4BDuUW+hRyVTPn3IawSPDny1RSRlfGvvKp6cuOER3d
 R9eRyAaPvzERxTS6WQiRwM6Zr3pfawFE5iJ/MWiYpljsJjd278weZbKGcX3BmXrxu1HmiwJt7ZH
 MfNlX46OVVk5YuOdENR5mmeXku2jI3hDUpWFzivusAAj1KHfS8A8izfeeu9vVs2pyspGJbQsMUq
 4ctgt+FGIWFDENCpOWjzDEmeGsrEAfBW1Gj7MlciZmtDhNKC9tn3FqPPTUt3tmY50eCLct2n4Jh
 rU5ppeqchXD5fYL9RnUX13SmiN74RvurNw+S5NsX9VA9rZboCRAcnnzRBHRH2l2YodaqJHXKeuL
 7QTfbUvtHypQ1s5/Rs4S+1bW1UkBDHXa0i8qetQU/hyxa0h5zDKQpiEyq0BwKpuxZNWYgFYwDPs
 SGobMxtOhXeNAhAt258+c4+Gw2uCLA==
X-Received: by 2002:a05:6830:6a8b:b0:7f8:4a55:cd97 with SMTP id
 46e09a7af769-80de065ea34mr11182770a34.9.1790008114639; 
 Mon, 21 Sep 2026 09:28:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-81476bb7a3esm430197a34.20.2026.09.21.09.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 09:28:34 -0700 (PDT)
Date: Mon, 21 Sep 2026 10:28:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Xiaoyi Suo <18102059357@163.com>
Cc: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 0/2] lib: make the clearing stores in lib/ real
Message-ID: <20260921162832.GA858934@bill-the-cat>
References: <20260921151315.1167-1-18102059357@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DkJssHhm2BBR4K00"
Content-Disposition: inline
In-Reply-To: <20260921151315.1167-1-18102059357@163.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--DkJssHhm2BBR4K00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 11:13:13PM +0800, Xiaoyi Suo wrote:

> sha1_hmac(), sha256_hmac() and the mbedTLS sha1 shim build the HMAC key
> schedule in local arrays and clear it with memset() before returning.
> Those buffers die with the frame, so the stores are dead and GCC removes
> them from -O1 up, and the key stays on the stack: the pads hold
> 0x36 ^ key and 0x5c ^ key. In U-Boot the only caller is the TPM 1.2 code
> (lib/tpm-v1.c:577, :641), where the key is a TPM key's usage auth.
>=20
> Not remotely reachable: reading it back takes something that reads the
> stack afterwards (the next frame at that depth, a core dump, /dev/mem, or
> an unrelated memory disclosure). It is the secret's lifetime, which is
> what those memsets were written to bound - CWE-14.
>=20
> Patch 1 adds memzero_explicit() - a memset() the compiler may not delete,
> built out of the barrier_data() this tree already has - and uses it for
> the three HMAC key schedules. Patch 2 does the same for the SM3 message
> schedule, whose clear sits under the "Zeroize sensitive information."
> comment.
>=20
> Measured against main (211de43) with GCC 13.3.0, each file compiled on
> its own with the usual include prologue and -fdump-tree-dse-details:
> 4 deleted memset calls in lib/sha1.c, 5 in lib/sha256.c, 4 in
> lib/mbedtls/sha1.c and 2 in lib/sm3.c, and none of them after the series.
> A probe that reuses the frame recovers 20 bytes of key at -O1, -O2 and
> -Os, and recovers nothing at -O0, where the memset still runs.
> checkpatch reports no errors and no warnings on either patch.
>=20
> Xiaoyi Suo (2):
>   lib: add memzero_explicit() and use it for the HMAC key schedules
>   lib: use memzero_explicit() for the SM3 message schedule
>=20
>  include/linux/string.h |  7 +++++++
>  lib/mbedtls/sha1.c     |  8 ++++----
>  lib/sha1.c             |  8 ++++----
>  lib/sha256.c           | 10 +++++-----
>  lib/sm3.c              |  4 ++--
>  lib/string.c           | 21 +++++++++++++++++++++
>  6 files changed, 43 insertions(+), 15 deletions(-)

I would be much more comfortable starting with taking memzero_explicit
=66rom the linux kernel. Also please make sure that your commit messages
are concise, and it's better to mention function names than line
numbers, thanks.

--=20
Tom

--DkJssHhm2BBR4K00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarFbLAAKCRAr4qD1Cr/k
Cp77AQCxDDA0knAVfQpQZfzmzMEC3zWjmEoq620d/jsxTfzoUwD/RmSztwjCZxkq
mcXMR1XFV841vVuq/pPyw4ZQRxkFoQI=
=CmvJ
-----END PGP SIGNATURE-----

--DkJssHhm2BBR4K00--
