Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BFC606A321
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zKjANdvH;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=p75X7h9u
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 488A58117E;
	Thu, 26 Nov 2026 15:15:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0sRkuhxoxmhk; Thu, 26 Nov 2026 15:15:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 30D4881138
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795706109;
	b=RWVCRPW5fZIkOpACp80kJl4cHoFs73lN5iFq6rdb2b7uVmfWmF8sNkiqQVnVr79xv9w6
	 k+xzJbG+vaDCekbVXkdNMn8onTkfHGu08U99Pu6Sr/6IPaGWthvK4pc951M+rthEf6bpI
	 AA5Gi5v3AjCKkb43AD54lV7vjBg3fZdd5jHnkAsT2AF7hbxvHbV1VWGsCijjux3gP+rnv
	 A9ZbckDcNm7aMyjrKtl7Zpr3G5nnBFrkwLoPSnkDIYjqVUA9YdZU53DUds79ISCfGPy4Y
	 1C34rzxHAIo8nT65dYOxq7RqZm4c5I/jyWsiVOrHtiCe0Gd85Hj8vEsZM+N6nPLlSLA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795706109;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=V5yv2K2CCK4pHDy8jr11kLvUlIbRgPmhBVkoYFYpc1c=;
	b=NiIjfq5X24iQajJIO08U/CXidzKS49ZPrWXz+uINNGZ8p4blGkicqI5+uz/603/l+8XG
	 lqSLDUO5zO5M2TfNzCsYrsKbgvIC4usZ+ozrM7rVWWTR+FtRYC80YDSUv+sTsP8VxlRVe
	 FNgXhZLcmZvJAFB6iMhKmTFRqi9nYeC9OZOC9RAeQz8FyaEZq3WE/4nKgJBFb5P/zqC+n
	 uJxZzzH9LTxKmOgM9YQXzfXjzxA87HM0rfk+Yn+vEI+UgWTDfop+jsqqJQDyzUCaFlksM
	 dwfqkJKf9N0sbr7OIgJ3M9KHXJ+xA6nO+IgFQUblPWR8+nfkQ9Iy5G92M39H1r11pXA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795706109;
	bh=V5yv2K2CCK4pHDy8jr11kLvUlIbRgPmhBVkoYFYpc1c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zKjANdvHqA//RpqOoQMid8NDHIM62zD4lEsnK3609RLK4dkf6yXyBMiEgg/lV8bMj
	 zE0YuFuyNDaL9xUyN7axosinB5vAirFNXbOX1rc2wmEPirAAesyyOTHLQQcQGt1n4K
	 4ZdtF+HkC43BLKuPobrXEAPnVbshptfd08OnN5SzSvhWWMSqCBDlEFJlmWrUYk1Cda
	 X9y8rwaXtR4jjSt7bY9R5ZsJ2jVgGrAehsFywS52A4Yxjj6qTSplFAV3RVfgw7o6yL
	 vBlPS6P59VeihMJphB6gaiJddbgAaWVq77gvepOJGUKlgiqr2QKDfJJ2bd2wNA5gV7
	 /yrFnsoE/g1AA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30D4881138;
	Thu, 26 Nov 2026 15:15:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BF4F42DF
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 15:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B0FB04050E
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 15:15:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h_oSIQyhJ4zo for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 15:15:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0CCA840503
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b129; helo=mail-yx1-xb129.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=p75X7h9u
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0CCA840503
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 15:15:04 +0000 (UTC)
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-6767d92cde6so7875526d50.0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795706103; x=1796310903;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=V5yv2K2CCK4pHDy8jr11kLvUlIbRgPmhBVkoYFYpc1c=;
 b=p75X7h9ubdThWZv5Dwtokp1gmB3+BRN2UuG/ujsrcC014wUXzIyx4l6SqfxyGldHF6
 3vFhXAukZaPLMnFVQ89Ib7DGcM5kguDBRnHIM9zifXeN4gaWOLP1uWCB0dS0O1RIRpZC
 gSSe15k++4M2T92w4Xj30NKHqgPVlT6+L2ulDJ5/fvIqa/JDFdjEUNHjFvpnTmNgve00
 vnLGu44Ca8I4KhVVEbT7eMDnMCEPM460WP7MGQVp0Jzzrmq9AtXxpCLK9q7QAwTSEJ5i
 TyWyrZVDDcKi4Il4eb6v2l1xpnBTweBlQ9Q1WW4D2emRq31KwHngHS/HW8HhyysSyXik
 Q8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795706103; x=1796310903;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=V5yv2K2CCK4pHDy8jr11kLvUlIbRgPmhBVkoYFYpc1c=;
 b=2PSC6s/2lgoopCjqg0zZKY29JwxzXlDuKBsqkmqW1AU3E5egk/LKEXIX7GAQED3rV9
 oFsJKzYyKf8qc2Q2RC6Uq4KYYS5Skoz6h5YRF5iKGsqbY8NlDatKaq5udQbgdS5yq3FA
 GrrdZj0HH6FheW2DydE+VdB3gOd0MtXU+400vm7hCNhdDPz8xfNA8irqooxYvMvN1y1E
 91h+jVBucemERirw5VDGtUvNjV7u9+hgl+gsU72HGKSNsMX1qwqep5/EU6rItlM91aZw
 cBRK0V2aMunhlnIFImRIBIyqgfIKDfpA1AN7BM9HoV3lesH942dpDmWEF3iMdi5jkGH8
 UWag==
X-Forwarded-Encrypted: i=1;
 AL+hErFSTGpXgCRV5CngHpPb/DbYCGr8f1oKk18BxYAcDxJQSE7/t37CSrZ5n48rH7naG+muvoKXpes=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+v8PA4+KgFjSzoXNtqsvNe73fG7+32eAwOgCOh3aAKYqCKY2pM
 ViFazj4Kt7ZEtAoEyFiN4jd+kpWPwoADslY0mYTXTw7prRKeow0hB0oarYmd1yozsZFlf7A5Lgs
 ymYKp35gRySgmNnScsuNA1fGg0uhiSgUTx+il7qvTLQ==
X-Gm-Gg: AZFdTZdLc4WGvrgu2QfCgbIfdemq1ukr78mnyL3/qo7BnPFNdc1mpuKGYh2bVx2Po3W
 ZCrw5SF+sIPTEAyh64++KUZwatP6TxqzL2eUgwNlQzbZbhkMaYhUi5Rs4elGaD76Js7NqetF2sB
 95YE/rLf8ervISomXlo60RfsxI7G2RMbJNM3AwG+TziDoa/eSokz2mYK8ESIS4VqMTYHqXL5AuH
 RFPCEZV0AILXgZ4c0pH5GMQUV2VAgDb7fR90qoC5IM8nmlEKyLSpw3alQHZ2eNoHncZ/SBSc9sj
 ZomkhpzoDwueQzhrfy4UAtoMXBUSgnvoTWxMpjbTtLbcxG1mHJBgdu/StpPgrY5av8+XcXmDBl9
 D6+V6CdCt/gwMt7p2VygfhSpOISlpHZSqHpdG2TmTm+jNa7/XnEYSySVeeOJ5EHygBnRNIbxzO9
 WGWCxG01yItkJzhnmdSdkphlAK08qAmVRhMMLhRO5wrbEBvIwp0qJvrsG4MVt87MpGEqyH7bAyy
 pyi7dxiB7M/Cwu9SM+ZP+Fsb+9DRBmnei589X2lkhIWnH7WBSATjQGYo4GPx4H6HPFlsKqgRvYf
 dD28hFnXM7wCBErHngVEloV0K98x84hlOWjHOY0Zzxp22gTmYXyrjbCFGNIPOIe9K/Qcaq1J8a4
 Z1GF9+2tObOHpwAuRzGHYwrwVUIZufqpw9QgtOBai/z2EaHxsXsh2GxQaijGTzaN2J92fgKvDZU
 9j0H7PPxI6BgjxrWoZ93DqO5v2OZkIqgSEA08+Evr8+VcMgcrOpOsvMgjwKePY0NXhgM1Ey9Q=
X-Received: by 2002:a05:690e:47c7:20b0:67d:c44b:dacc with SMTP id
 956f58d0204a3-67df4441662mr7070768d50.70.1795706103025; Thu, 26 Nov 2026
 07:15:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261125074122.1965495-1-ilias.apalodimas@linaro.org>
 <20261125074122.1965495-2-ilias.apalodimas@linaro.org>
 <3a263d76-c2fc-4e15-9f2c-7795bb27a6e0@cherry.de>
 <CALeDE9NaEmTqxPebzYWYcyT4sYq=s+PCet0mPKuRAUtKZG3CXQ@mail.gmail.com>
In-Reply-To: <CALeDE9NaEmTqxPebzYWYcyT4sYq=s+PCet0mPKuRAUtKZG3CXQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Nov 2026 17:14:26 +0200
X-Gm-Features: Aa3M54okQP3jzjP2S2kXif6khh2pkOooTMZ6-ZuFS4Go5jdQ_yN6UxEATQdNni0
Message-ID: <CAC_iWjLAkaU-r1r=f30rq1iRFFJ==TrUeqJoJ29LG1Eie3cyMQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: Add RELR relocs
To: Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: trini@konsulko.com, richard.henderson@linaro.org, 
 casey.connolly@linaro.org, u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi both

On Thu, 26 Nov 2026 at 14:48, Peter Robinson <pbrobinson@gmail.com> wrote:
>
>
>
> On Wed, 25 Nov 2026 at 17:20, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Ilias,
>>
>> On 11/25/26 8:41 AM, Ilias Apalodimas wrote:
>> > Linking U-Boot with -pie emits an R_AARCH64_RELATIVE entry for every
>> > pointer that needs fixing up. Each Elf64_Rela entry is 24 bytes, so the
>> > .rela.dyn section ends up being quite large.
>> >
>> > Modern toolchains support packing relative relocations in RELR format
>> > via '-z pack-relative-relocs'. Instead of offset/info/addend tuples,
>> > RELR stores a stream of 64-bit words. An even word is the link-time
>> > address of a word to relocate and an odd word is a bitmap describing
>> > which of the 63 words following the previous address need relocating.
>> > The addend is the value already stored in the place.
>> >
>> > Compiling for QEMU with RELA vs RELR looks something like this:
>> >
>> > $~ readelf -SW u-boot  | grep relr
>> > [ 9] .relr.dyn         RELR            000000000016f970 170970 000960 08   A  0   0  8
>> > $~ readelf -SW u-boot.old  | grep rela
>> > [ 7] .rela.dyn         RELA            0000000000115110 116110 0184f8 18   A  0   0  8
>> >
>> > which is ~98% decrease in the space reloc entries need.
>> >
>> > So let's add a Kconfig option and teach U-Boot RELR.
>> > - pass '-z pack-relative-relocs' to the linker and add .relr.dyn
>> >    in the linker script and the objcopy'ed binary. relr.dyn is still
>> >    overlayed by .bss
>> > - skip checkarmreloc, since we now expect R_AARCH64_RELATIVE entries
>> >    to be packed in .rel*.dyn and older tools don't decode them
>> >    properly
>> > - process .relr.dyn in pie_fixup. It's worth noting that efi runtime
>> >    relocs, due to how ld emits RELR, are now packed in .relr.dyn and
>> >    efi_runtime_relocate() doesn't have to relocate anything.
>> >    A sideeffect is that we can't support  SetVirtualAddressMap and ConvertPointer
>> >    for EFI, but some architectures are already ommitting this call
>> >    (e.g Linux on arm64, openBSD doesn't call it at all). [0]
>> > - process .relr.dyn in relocate_code(). Note that the places are
>> >    link-time addresses, so we still need the link-to-copy offset to find
>> >    them, but the stored value has already been shifted to the run address
>> >    by pie_fixup, so it needs to be adjusted by the run-to-copy offset
>> >
>> > [0] EFI runtime services relocate themselves when the OS calls
>> > SetVirtualAddressMap, using the relocations between
>> > __efi_runtime_rel_start and __efi_runtime_rel_stop. Those are collected
>> > by the linker script from the .rela sections of the runtime code.
>> > RELR packing, however, is done by the linker as a last step and all
>> > relative relocations end up in a single .relr.dyn section for the entire
>> > image. There's no way to emit an equivalent __efi_runtime_relr_start
>> > marker for the runtime region, or emit RELA relocations for the EFI
>> > runtime, so stop advertising SetVirtualAddressMap and ConvertPointer
>> > in the EFI_RT_PROPERTIES_TABLE when RELR is enabled.
>> >
>>
>> 6.4% size reduction for u-boot.itb with RELR enabled on
>> tiger-rk3588_defconfig.
>>
>> $ aarch64-linux-gnu-ld --version
>> GNU ld version 2.47.20260726
>>
>> from Fedora 45.
>>
>> I reached U-Boot proper CLI, which I have been told is sufficient to
>> test this series, so:
>
>
> I agree with enabling this by default, it should be opt out if there's issues.
>
> Looking at various default toolchains across distros (thanks Claude) Ubuntu 22.04 LTS has gcc11/binutils 2.38, RHEL 9 is gcc11/binutils 2.35.2, Debian 12 is gcc12.2/binutils 2.40
>
> All have options for later versions so I think we should be fine to enable by default and error if the toolchain isn't new enough. The reality is a lot of users will be using old U-Boot if they're on ancient distros anyway.
>
>>
>> suggestion: make this transparent to the user
>>
>> We've talked about this in private but wanted to put it in writing so
>> it's available on the mailing list archive. I think it makes more sense
>> to always enable the option (if it's safe!), if the linker supports it.
>> According to
>> https://rfc.archlinux.page/0023-pack-relative-relocs/#motivation, that
>> is GNU ld 2.36 and LLVM 15. We can use the same mechanism as in the
>> kernel, c.f. CC_HAS_UBSAN_BOUNDS_STRICT with def_bool
>> $(cc-option,-fsanitize=bounds-strict).

I don't think that's a good idea. You turn on an option that promises
to reduce the binary size. You compile but bercause you now made the
linker flags conditional the end user finds an *identical* binary
after enabling the option. I prefer breaking the build so users
understand that this relies on a newer linker. Whether they can update
it or not should not be our problem.

>>
>> What I don't like about it is that if it's default off, nobody will turn
>> it on. If it's on and we force the option like in this patch, then
>> builds will fail on older toolchains. I bet most people don't know where
>> to get a newer toolchain than the one they have from their distro, or
>> how to install it so lots of headaches for people I guess. If we stay
>> with this solution here, is there a way to tell the user how to fix it
>> (either via a Make message, or at least a comment next to the places
>> where we set the flag?)

There should be enough explanation in the commit message and Kconfig
option why this is not enabled by default.
TL;DR there are implications wrt to EFI if you enable RELR that do not
affect Linux for arm64, but Linux is not the only OS we boot. Since we
have it documented, I'd rather leave the option off, at least till the
EFI implications are gone.

Thanks
/Ilias

>>
>> Cheers,
>> Quentin
