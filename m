Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E99C5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 17:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69D8B8283E;
	Thu,  5 Jun 2025 19:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="g692L9sF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7A95826AA; Thu,  5 Jun 2025 19:15:45 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E38B88091A
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 19:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-60ef07eb7f4so669752eaf.3
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 10:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749143741; x=1749748541; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z6dHhM0Dpwdhw0jSgKLRWBgmTLHDhFNk7kDLTQMPj3s=;
 b=g692L9sFCPXZU56JSbd5yqRbcLS+xcSof5xFpAuqhjmN0ZlrTflXQG52DDByhV2v0k
 kwihHNxLQeGu+HZ+ZgwY5epaXSrpp8RGut3T/0f99U8uQcvV4NZ7F8QgzefcZ2OARWjH
 A4yC3VMHnsQs4I158X8+qt77uN6g0/zQGFOGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749143741; x=1749748541;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z6dHhM0Dpwdhw0jSgKLRWBgmTLHDhFNk7kDLTQMPj3s=;
 b=wr6d2zAHQ4PEAWJsT7UVtlI+uGE/yscy7CLH0/XTO1rtZJ558lrmECXOfF3zzNZF3x
 YaH6oxLHttThy0aDKPx7rLpPc08CEIbq99SUbTappIvSrlwPws03eekMJSp7pNFv0x2x
 x+/D6RJaZLidUP1MLHRPhCXVhLYYyZUtVGVSq2xHYg/xwhX6IyIXTwspZ6A7jcr8Q6jV
 xxF01WlgEGTk7Tz7JQL4goFcFTn8jsxUqBS1YGnzr8KxwRPgqhocL1qXfcIoKw7obPLg
 jPXi5ouByroLrqCnqJ2uE1sD4VKK/6Xe9ywcRAt5LwZRcVaEbhAyOEzxQTr/KXlQrWZy
 GxYQ==
X-Gm-Message-State: AOJu0YyIwIP4zeZA1L4fgWFAp835Op6fxRr9DsHUn2cpGTW2L/3F5141
 4XsXy4cdEfnl28cCg3hcdoSmG0eN8/xj/Cq+3S1Y9/BRleREFkftVIXuF7wxXkaHwXY=
X-Gm-Gg: ASbGncuk+KDje662MrYYx3/xzo1zXaIO5Mn3Y5Tw9AO7d3S6J3Vyy9/1H9kJldQn6jV
 CGO64/fxgFtTE1xUNVe2bFxTyMQayUqkXuJYalmSfeRnv7IqX71EhOBW0biSZrLjz6PNCOI2+2s
 Qxbk55tJMz0nQiMIs/4jSGErjfU6FhBwHabZ2Qy931mquIAjeQwEN4O5DDMV0FnL6LXPpPSmjga
 QX4mKVXyfOR9ysWpk2fJYEyJYaV2wZLYCWppVfO2dOL5dx65B5dnJoXb+MjAozWhZojMdAyYtAr
 tOv0Puxk8SazxU7W9Ts//KFupK2NSVjETJNPAcPxiFdA2WMdAaOEjNwogZeI5u/LUbWPVh/PnE+
 u6SW/6N8IuQRJ
X-Google-Smtp-Source: AGHT+IGdk/UFGqaxJuyUfmiPRWikB6zMvhoYSwK72ykggQ0Xnjg5EpOgCngksEGUg67Su8HCnGi2iw==
X-Received: by 2002:a05:6820:1898:b0:60b:c6c6:f69e with SMTP id
 006d021491bc7-60f3cf1d259mr216462eaf.6.1749143741595; 
 Thu, 05 Jun 2025 10:15:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c14c427d2sm2662141eaf.4.2025.06.05.10.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 10:15:40 -0700 (PDT)
Date: Thu, 5 Jun 2025 11:15:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Prasad Kummari <prasad.kummari@amd.com>
Subject: Re: [PATCH v2] makefile: fix Clang link error when
 RSA_PUBLIC_KEY_PARSER is selected
Message-ID: <20250605171538.GC1382132@bill-the-cat>
References: <20250603144258.1701265-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+Ftp1zT04gQRVjEK"
Content-Disposition: inline
In-Reply-To: <20250603144258.1701265-1-raymond.mao@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
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


--+Ftp1zT04gQRVjEK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2025 at 07:42:55AM -0700, Raymond Mao wrote:

> MbedTLS bignum module needs '__udivti3' which is a 128-bit division
> function provided by the compiler runtime, typically libgcc for GCC or
> clang_rt.builtins for Clang.
> Thus 'clang_rt.builtins' library is required when building using Clang.
>=20
> This patch supports the location layout of clang_rt.builtins libraries
> from both LLVM pre-15 pattern [1] and post-15(up to 20) pattern [2].
>=20
> As a fact that starts from LLVM 20, no official prebuilt multi-targets
> are included and users might need to cross-built it from source. [3] is
> an example of instructions for building.
>=20
> [1] <INST_DIR>/lib/clang/<REV>/lib/linux/libclang_rt.builtins-<ARCH>.a
> E.g.
> lib/clang/14.0.0/lib/linux/libclang_rt.builtins-aarch64.a
> lib/clang/14.0.0/lib/linux/libclang_rt.builtins-x86_64.a
>=20
> [2] <INST_DIR>/lib/clang/<REV_MAJOR>/lib/<CROSSTOOL>/libclang_rt.builtins=
=2Ea
> E.g.
> lib/clang/20/lib/aarch64-none-linux-gnu/libclang_rt.builtins.a
> lib/clang/20/lib/x86_64-unknown-linux-gnu/libclang_rt.builtins.a
>=20
> [3]
> git clone https://github.com/llvm/llvm-project.git
> cd llvm-project
> git checkout -b llvmorg-20.1.6 llvmorg-20.1.6
> mkdir build-builtin && cd build-builtin
> cmake -G Ninja ../llvm \
>   -DCMAKE_BUILD_TYPE=3DRelease \
>   -DCMAKE_C_COMPILER=3Dclang \
>   -DLLVM_ENABLE_PROJECTS=3D"clang" \
>   -DLLVM_ENABLE_RUNTIMES=3D"compiler-rt" \
>   -DLLVM_TARGETS_TO_BUILD=3D"X86;AArch64" \
>   -DLLVM_BUILTIN_TARGETS=3D\
>     "x86_64-unknown-linux-gnu;aarch64-none-linux-gnu" \
>   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_SYSTEM_NAME=3DLinux \
>   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_C_COMPILER=3D\
>     <YOUR_TOOLCHAIN_GCC> \
>   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_ASM_COMPILER=3D\
>     <YOUR_TOOLCHAIN_GCC> \
>   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_SYSROOT=3D\
>     <YOUR_TOOLCHAIN_LIBC_DIR> \
>   -DCOMPILER_RT_BUILD_BUILTINS=3DON \
>   -DCOMPILER_RT_BUILD_SANITIZERS=3DOFF \
>   -DCOMPILER_RT_BUILD_XRAY=3DOFF \
>   -DCOMPILER_RT_BUILD_LIBFUZZER=3DOFF \
>   -DCOMPILER_RT_BUILD_PROFILE=3DOFF \
>   -DCMAKE_INSTALL_PREFIX=3D<INSTALL_DIR> \
>   -DLLVM_ENABLE_PER_TARGET_RUNTIME_DIR=3DOFF
> ninja builtins
> sudo ninja install
>=20
> Fixes: 13de8483388c ("mbedtls: add mbedtls into the build system")
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

I think that newer versions don't even ship this moves us further away
=66rom a solution here as all of the logic. I think we need to look at the
suggestion of just importing the assembly version of the function.

--=20
Tom

--+Ftp1zT04gQRVjEK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhB0LoACgkQFHw5/5Y0
tyzq1gwAllbhUefBqEsrJo9bdu53sh/oZ2vvMOrsX/G0qoNYb0fiQM6BQNco9Spe
FeqIhQ4gS2K16hRoIJvdl/ciOAtUq0tFHc1FpXXlTnxIR8nCdz9HmWIBdvnXGpGU
JJ7wxQnW0HQ/ZyNVtjwJtefNxNaI+ULAK4A8IS+3x7lVpEqp12TSLx2SYE75IlBZ
2e7uK63zUTqRmH+DvLXmY59lkxwvqKWp9WPn8Zdj4Orb9K8tBHDFgWzPnrSyzwxB
AjoPedHWQz5MbKjRejZTyq+D5Zt5SV/IicGFjs840EDp9RVIo1ErvObvjPFCzRPj
GBt+3fGbgrne3Lv1UdA6Z9S62VTp0HFJAlUhIvSqAH0WhsUQXTsmdgaWAUsgosNt
iPlihc2UVFYkxTK6Hk+mmMXkvuVsoYOBvfUKBhuYm0CJIhSsPspx5TV1dJSP0Pmp
NHXVGo1A2Fl22r6ZISJSYr3H8D5S3IrW5li5r5g6kD8GV2VofmjPt9JWRZzQ7SwM
jk62UMXY
=gvtb
-----END PGP SIGNATURE-----

--+Ftp1zT04gQRVjEK--
