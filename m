Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE34C5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 06:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 226AC81FEE;
	Fri,  6 Jun 2025 08:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JGqPyAPy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93009828A2; Fri,  6 Jun 2025 08:58:32 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41E91807B1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 08:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so1825949f8f.0
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 23:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749193110; x=1749797910; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eVW6lITVdTlfrLAB6uiH1TuA6rfuFK/rhOq6SEifuXA=;
 b=JGqPyAPyLMH7VQVqUuHEAtb9DGtjNa+iNTJi6WqLmlm2MK6mCn9Y6aRKhtiMqMxAoA
 1GWWFDf9fE7C1tbU4IU2vIhJTMDfT4gMtt2KGkigqy/eMnF2ED/bfe4ytL61QAmF48Vo
 LAe1072Gvif65rSA+HoNK2NUfqVt1iYlGuq0+vl8vOBdWQnOHOb/G0J0Er1xljTYpxt4
 sv9Mxit/LcuQaTQ7+zx9dT42uDQ/1MkLFKAHefz8AgdWGPPw8XVc2bXmjbRMKXHr71Y0
 j7c+U+4+Pb1zdxKfCK2IpI5JSiy6hgVd2DnwaoBG5MbHWrkgKIzXo1Ijx/s7j//NMovb
 BBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749193110; x=1749797910;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eVW6lITVdTlfrLAB6uiH1TuA6rfuFK/rhOq6SEifuXA=;
 b=CumHxbF8CBteMZ6Va+z2HtbTk30xP09l32WQFJjkJLtGA1HMkSA6kzGzwWbz4j7LW/
 dV17RjhkkjFILKro/AukQOHYQ9C/2BWh7BBAyrLX+sTZf2ABCldVmqphJkkAhxRQE6+W
 gp5My1262jcvloFxIQUxM+UbwUWaR8bOmsS2zqr+zIm0/XIvN03IdbQWERBMIyDnT69O
 In8VPdCPtgXENK4eDRORHgrzRalZhV02JW73eywGxxEM8cBhOoOS8KNxd0H0xVZcxp7/
 JX7KV64YhQYbET4/LsppK7Yi6VsRc6447u4KDwyOWhjMXqcaghfqqF+DSMnTTXm3tGSM
 jYYg==
X-Gm-Message-State: AOJu0Ywv2Gq3KY/ZkTcSf9ylYy6I1/EipK7oo5f/8kHlRWD/DTrfZRmO
 mAVDRis10AScHl0drYqoKUA55T8bG8zTEwy7FPyMAkSfThODVrhwrYH7qrs62nFl+ZY=
X-Gm-Gg: ASbGncuSf8p9M9avEWEEREs/IFQkRNpy6B2RsAF5G7kHxDOaJdMTd7/cv4RyBziW3Wl
 FPyrLJTcMeuqllzBZpu5TQvW9U0yo36xmK8TupdXa/6jkMFXZqltYhIDpyiyrU+BZu+ddeokRQi
 nYxmOwsO0yiJ0o/rfPIpemVjAX2cQMi40sfK+23+wOJR/GuRDOtSIx0qCkslcjc4BhIcovWiaNT
 I1cEsu9pX7i//jgZ6Q5hct7ldYEXPHAkkRWgn/l+sTaS7vpjx49+0SwQ7AIctz3DkRnMnCl9cr3
 ARTazACdmzNbawJlUX8vgtpkUFagoe6uTgJxqdQa7m+R3Q7yG2vSdFsBSiip8wDVcDirXPwwPcX
 8FNo2OiustzVQaMA6hro8WPVbvHpUic4fVPoKc1Lq9TSofeeKdbv3
X-Google-Smtp-Source: AGHT+IE4fBN3omUuNJITiIxiP5/2ro6jgpWSGr2tNEh9K5ab5RXVnCI1PGRQI1JkYr3SvMTTHk8vmw==
X-Received: by 2002:a05:6000:290c:b0:3a5:24cc:6d5e with SMTP id
 ffacd0b85a97d-3a526dc5198mr5697121f8f.3.1749193109642; 
 Thu, 05 Jun 2025 23:58:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:37f7:19bf:f6b3:6381?
 ([2a01:e0a:3cb:7bb0:37f7:19bf:f6b3:6381])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4526e056138sm11696985e9.5.2025.06.05.23.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 23:58:29 -0700 (PDT)
Message-ID: <c114ac9f-bcce-4dbb-bf32-1825d455240d@linaro.org>
Date: Fri, 6 Jun 2025 08:58:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] makefile: fix Clang link error when
 RSA_PUBLIC_KEY_PARSER is selected
To: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Prasad Kummari <prasad.kummari@amd.com>
References: <20250603144258.1701265-1-raymond.mao@linaro.org>
 <20250605171538.GC1382132@bill-the-cat>
 <CAEfUkU+Xp1bkHRWkBSzbF+S5VewB2E4_dXr+LU-+WAtOgvPLLQ@mail.gmail.com>
 <20250605200117.GD1382132@bill-the-cat>
 <CAEfUkU+ns2XGb7J8WP+uD5SuxkQfdzZxPD+axN-J-xoLVzndyA@mail.gmail.com>
 <20250605214655.GG1382132@bill-the-cat>
 <CAEfUkUKR-zZ124VsOX31KNer6EiDKyXgO=oF2L2YwUOgf40CEg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAEfUkUKR-zZ124VsOX31KNer6EiDKyXgO=oF2L2YwUOgf40CEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 6/6/25 00:10, Raymond Mao wrote:
> Hi Tom,
> 
> On Thu, 5 Jun 2025 at 17:46, Tom Rini <trini@konsulko.com> wrote:
>>
>> On Thu, Jun 05, 2025 at 04:52:20PM -0400, Raymond Mao wrote:
>>> Hi Tom,
>>>
>>> On Thu, 5 Jun 2025 at 16:01, Tom Rini <trini@konsulko.com> wrote:
>>>>
>>>> On Thu, Jun 05, 2025 at 03:45:00PM -0400, Raymond Mao wrote:
>>>>> Hi Tom,
>>>>>
>>>>> On Thu, 5 Jun 2025 at 13:15, Tom Rini <trini@konsulko.com> wrote:
>>>>>>
>>>>>> On Tue, Jun 03, 2025 at 07:42:55AM -0700, Raymond Mao wrote:
>>>>>>
>>>>>>> MbedTLS bignum module needs '__udivti3' which is a 128-bit division
>>>>>>> function provided by the compiler runtime, typically libgcc for GCC or
>>>>>>> clang_rt.builtins for Clang.
>>>>>>> Thus 'clang_rt.builtins' library is required when building using Clang.
>>>>>>>
>>>>>>> This patch supports the location layout of clang_rt.builtins libraries
>>>>>>> from both LLVM pre-15 pattern [1] and post-15(up to 20) pattern [2].
>>>>>>>
>>>>>>> As a fact that starts from LLVM 20, no official prebuilt multi-targets
>>>>>>> are included and users might need to cross-built it from source. [3] is
>>>>>>> an example of instructions for building.
>>>>>>>
>>>>>>> [1] <INST_DIR>/lib/clang/<REV>/lib/linux/libclang_rt.builtins-<ARCH>.a
>>>>>>> E.g.
>>>>>>> lib/clang/14.0.0/lib/linux/libclang_rt.builtins-aarch64.a
>>>>>>> lib/clang/14.0.0/lib/linux/libclang_rt.builtins-x86_64.a
>>>>>>>
>>>>>>> [2] <INST_DIR>/lib/clang/<REV_MAJOR>/lib/<CROSSTOOL>/libclang_rt.builtins.a
>>>>>>> E.g.
>>>>>>> lib/clang/20/lib/aarch64-none-linux-gnu/libclang_rt.builtins.a
>>>>>>> lib/clang/20/lib/x86_64-unknown-linux-gnu/libclang_rt.builtins.a
>>>>>>>
>>>>>>> [3]
>>>>>>> git clone https://github.com/llvm/llvm-project.git
>>>>>>> cd llvm-project
>>>>>>> git checkout -b llvmorg-20.1.6 llvmorg-20.1.6
>>>>>>> mkdir build-builtin && cd build-builtin
>>>>>>> cmake -G Ninja ../llvm \
>>>>>>>   -DCMAKE_BUILD_TYPE=Release \
>>>>>>>   -DCMAKE_C_COMPILER=clang \
>>>>>>>   -DLLVM_ENABLE_PROJECTS="clang" \
>>>>>>>   -DLLVM_ENABLE_RUNTIMES="compiler-rt" \
>>>>>>>   -DLLVM_TARGETS_TO_BUILD="X86;AArch64" \
>>>>>>>   -DLLVM_BUILTIN_TARGETS=\
>>>>>>>     "x86_64-unknown-linux-gnu;aarch64-none-linux-gnu" \
>>>>>>>   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_SYSTEM_NAME=Linux \
>>>>>>>   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_C_COMPILER=\
>>>>>>>     <YOUR_TOOLCHAIN_GCC> \
>>>>>>>   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_ASM_COMPILER=\
>>>>>>>     <YOUR_TOOLCHAIN_GCC> \
>>>>>>>   -DBUILTINS_aarch64-none-linux-gnu_CMAKE_SYSROOT=\
>>>>>>>     <YOUR_TOOLCHAIN_LIBC_DIR> \
>>>>>>>   -DCOMPILER_RT_BUILD_BUILTINS=ON \
>>>>>>>   -DCOMPILER_RT_BUILD_SANITIZERS=OFF \
>>>>>>>   -DCOMPILER_RT_BUILD_XRAY=OFF \
>>>>>>>   -DCOMPILER_RT_BUILD_LIBFUZZER=OFF \
>>>>>>>   -DCOMPILER_RT_BUILD_PROFILE=OFF \
>>>>>>>   -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR> \
>>>>>>>   -DLLVM_ENABLE_PER_TARGET_RUNTIME_DIR=OFF
>>>>>>> ninja builtins
>>>>>>> sudo ninja install
>>>>>>>
>>>>>>> Fixes: 13de8483388c ("mbedtls: add mbedtls into the build system")
>>>>>>> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
>>>>>>
>>>>>> I think that newer versions don't even ship this moves us further away
>>>>>> from a solution here as all of the logic. I think we need to look at the
>>>>>> suggestion of just importing the assembly version of the function.
>>>>>
>>>>> But, the assembly versions are architecture-specific, do you want a
>>>>> portable C code for it?
>>>>
>>>> Is it easily done in C? If not, we can just try and make it clear what
>>>> needs to be pulled out of LLVM sources if/when another platform
>>>> encounters the problem.
>>>>
>>> But maybe we can ask the LLVM project owner why they removed the
>>> prebuilt multi-targets since 20.0.0.
>>> May current patch can support multiple target layouts of pre-15 and
>>> post-15 patterns (I believe they will keep the one of post-15 for the
>>> future), if they can provide the prebuilt multi-targets via package
>>> managers or release tarballs then it is the best solution.
>>> In the future we might need other functions from those libraries and
>>> implementing it in U-Boot is not a good choice IMO.
>>
>> I think adding all of that logic to the Makefile is taking us down the
>> wrong path. Looking at the kernel, they're working with LLVM to be able
>> to disable these 128bit intrinsics currently (as part of rust support).

Good to know.

>> So hopefully we just need some temporary workaround until things get
>> fixed upstream.
>>
> I will try to implement a C code function as a temporary solution and
> be back shortly.

To solve a similar issue in OP-TEE we decided to import a few files
unmodified from the LLVM compiler-rt tree, and that's plain C [1]. OTOH if
it's only a temporary solution, maybe a single C file can be put together.

[1] https://github.com/OP-TEE/optee_os/commit/48952fd403d867dbf13675e062cd8a7d2e5260a9

HTH,
-- 
Jerome
