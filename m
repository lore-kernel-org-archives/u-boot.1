Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817D8606A324
	for <u-boot@archiver.kernel.org>; Sun,  1 Nov 2026 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Nez5PSXL;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vHEuyLud
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42C35405CD;
	Sun,  1 Nov 2026 09:31:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GRUtRnwB8fET; Sun,  1 Nov 2026 09:31:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 81EF3405D0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793525475;
	b=iYcosye5jP/2RwM1jnleTMvDBkBq+fkAF4NHehin3D9eroLaPihwpJGaldF0r+bmp57V
	 DbQnbJ25q2+yQ0Dkk5ba3RlhvX3QEJnbmtG15qxilALm3ZN4UEaKq2WDC75fKEAPTVfnN
	 dq30XvBJ+irdLdSxRgPAcQIs3/hTRoQoM4SI93X+e1AxnSC2iZkB649udF1/QeB3RANjs
	 zDTBDcTESknHKc+6J26w/nBL3apIqRmt1CjCYSWDG7FwTugAC7hoKZvDH9cgiuY1hQlFX
	 v3sZvE/M70k/BGwdZ7i6lMA+NI4NO+wjHdF3CLrM17P6z+I1OXPtVoLgFcYnmIUGo/Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793525475;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EtuzkYJap2aJJqFIcQZjnAisAgMgqr2865/8Kyo9cbc=;
	b=S39WeHYNNa2U9hKCNV34xP2yIUsKPUZ/1izHgocEEPaKJIcEhlhjo9grsgJZeZMhDAN4
	 YtNcrvROVr8ImaKLDoxX6zuWnX5SlJmcAw1LLf2/IOMEdXB1xRpYXgf0TAL83LmKFoImQ
	 0e8PHylDhQHj1j0Y4FDXJcxd2dPkfUZEfYsGV7ZrnV1bPIM4qE7yADB6yYEsjm8zkqa8C
	 PW1cNMDU+06HYenQQxe+gsl2amhPEDncrhLk6YpGTvrMvI1G7fhPvhFXAgh62pg8MIN8X
	 fdCnh42AEnwvnW8fOetghb51H/uv57jaJ9AoNP0Wf+U4MjPA2QnFpRjaC1euJtx4UYw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793525475;
	bh=EtuzkYJap2aJJqFIcQZjnAisAgMgqr2865/8Kyo9cbc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Nez5PSXL8gMzys23zuD6+cHwOptIriybOKdhqSd/15hAACoBSwop9xmn7RBkw7mSn
	 7v/rsGYThNbUJH4A/QcjPTiysyyTNHAX+S0TRvAW5pgFajdEAK311lQrWOtXUI8SP3
	 p4ymYFtrAkaPuni0auOjedKCGvSsw6NoqbiyaNelEvgYS4EJ44MjhtDTDHlxB/CRgZ
	 DZkozX/3XtrvnHWct8Lzx/jhoLJFaYs9FtZG+z3V85gzwHGIYqLC1EFLrNNt0uWlBr
	 6EabSDAJKgpoHDTQGzK4tHgzobVxxKEP5ttRdcL1zBLOPbzCjj02YxPkGWqJgWQ8xb
	 ZVaUXK0eY+4Ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81EF3405D0;
	Sun,  1 Nov 2026 09:31:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 513DA356
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 09:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 379B26066A
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 09:31:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l-f6eu5kweI9 for <u-boot@lists.u-boot-project.org>;
 Sun,  1 Nov 2026 09:31:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2C0CB605E4
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::112c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793525473;
 b=JCbT7eQxDRaLwlpKUMKJnpP/lKdDAvZr6kZSBPgzeDA+iPUbAchbBgf4fdYCuS2MNW2w
 MFMyxuJNTSxl8QidowhGCocTTfFJWLSpmemjkde6qiwDS6wW60yBXSIWo5IuaU61VL8I0
 T1MBk3+QClTglvf5b8S0ioxAUMG534U9g7R6ksLH/P8fUHZOZahrB/T+lsqJalBEh4Jh2
 28wyUfn0Df1E2xIt58rD7dYnvmbV4n8EwdcpApCU7IKss0TAzStG/QC+DW8kgp3g/z2Jh
 ShVn+Hw82iJ7rq3is5yAMSH5Zis3+uRsgcwtST+X0VVq/3+vSXfvkoyYdgDmKP+h5rQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793525473;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=EtuzkYJap2aJJqFIcQZjnAisAgMgqr2865/8Kyo9cbc=;
 b=S7050mJqdCR19eeDzg9Cem0N5+ORpLAus8fqLOue1LXjEr0w8osV7UIS9WFrnquUYHQ9
 P1mPQLa2V6PgKSQfk0U8VMrHANlIeZ4+kohQ8fRYU3K/VOqXTpnGCchaNR5XtwaZeeemU
 T4DSmBvNuIQ7NSN5Gro3CRg/wHLNXc+WMPc5HeDlwu1DYY6mIOVq4+R5fgXQPN3+vhk4k
 mgF7n+A47rZ0/ZhZ/guppRHjnpWRJqIygpwzPnaa1qXokj3HS7IC1eiteyl+CJxLPrbec
 lCWlB1SR4J566x9UkIjPUYiFxO6VZmPWKeHGAwfD9+DMUQalCQGcfapmZFIXRPDmcVg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=vHEuyLud; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::112c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112c; helo=mail-yw1-x112c.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=vHEuyLud
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2C0CB605E4
 for <u-boot@lists.u-boot-project.org>; Sun,  1 Nov 2026 09:31:12 +0000 (UTC)
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8b0cf2c0785so16127307b3.3
 for <u-boot@lists.u-boot-project.org>; Sun, 01 Nov 2026 01:31:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793525471; cv=none;
 d=google.com; s=arc-20260327;
 b=col9iQEwXNCC6KouGhlsJOyjlvwWcGl9LnzykMwPWugByKUyxYIZRqyXEyRwy5dI9V
 mqJpIznY71UZvaVdEpBOjcg+aEMqmqa+KrpFDggT2s6rt3Z0xOD3Qh7AK+JttsaPIU3T
 PsEDuy7ayiilGGt8UecYY6jjF2+aMHmuRK1oxgivkAJQjZUmRMU3XqGBSojdzeTzoUuX
 mWGfKHYNJY7UWC4Eaqr8YuMPEuYZUgOZ03Eve1S/GOP4zlVCiUxTlv13iXuO3k5R5Ujc
 04RjiVcxAD97eDMZvVAJ/F8oDhpYgR9gdDcnM1Y2OYtQ2AMpwvt2iClbxl/tQnZaJDbt
 FxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EtuzkYJap2aJJqFIcQZjnAisAgMgqr2865/8Kyo9cbc=;
 fh=TFNaK8L8I+rLyl+zw1IeA9IwAptBP+eXWZuehn2MABc=;
 b=O8RqkpEvcJZyd2AGQfQN4uX0BUb3ycYdvkRVvd6IjKithNmkLNQ3wBGi3wBDD6oSz8
 ok7l5lXoUvSdDjjINQMxrrMXaid8iCQ+99AZnpfp0dWMGq2pta+kN/pvYVweVJyYS19G
 LoRBePjPdMVsSn+Qb7gqmjHm4bEKc/dU32J5pcAMCrxbDVh4nj2res0nCG+Iygfi8npw
 82WWsBLEA1drEDBXpe/XL+C7xu3gdt23r3do+5i2+jJGCutZDeVHl9NXs9o8knAuYy+f
 BQdSVeWmKvJFdnTlI5UdGDwKMACN+ozrN+wMyQ5QoW7B71c1Qz0SnSbXjHaKXZUju35d
 DmoQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793525471; x=1794130271;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EtuzkYJap2aJJqFIcQZjnAisAgMgqr2865/8Kyo9cbc=;
 b=vHEuyLudg9ZG9ObuFRteB3ZOiT0TIaPoOqXwt5M5TQenMch8B1QyqDRRyeF7Ih79Rl
 b6bSkw7BEYbc88gu7Fi+2TWiKgmQyb4NQylDmY6JgI2Zi0QB2+LWwD3lYnk1X/CID4uB
 kXZe6PA1gVa64gMk/tvOuxwoDXWssd+BhnQ0uRUK9KwFKLrpKSlZ9AcJH+PikAehi20j
 zs40Xtp+AIruFN4RZg07tK6GY+8erc+GXKk/K4aL9rb5Qr2goX1I+CT29+PwsmIz5M08
 PXIXuI6e8GIkZFFDLP8m0+Y8FLfmOSwDhdMoIc/U3G6t0dDgA3psN7faAKNnVtBgtZCj
 LwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793525471; x=1794130271;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EtuzkYJap2aJJqFIcQZjnAisAgMgqr2865/8Kyo9cbc=;
 b=Wo/yuOLj9jqR9OQZskkz0aPHA1Kv150zg46yJAaNDcu/uuoePbo6MPm5lx2onVX8mM
 +CDCVGr4fCIlBRwDrOB8rEb9PRJJCZom9h++TK0YH+bsjCS3kW4kgM1CiIlz2c2eg64E
 3AmzRGnmcqYl2YerTpG/VVuMtnETLepI7GeQ3Bw8WATKBVmZYAMkeP3iBEPPVBnRr380
 hCTSzhbUzk8k0SviTCPBi68d7skPyufJ8GWMLu/+6wWEhzBri3in1rzCXbiFK/4sDUM8
 pJZgX3JCeStEHMUbjquojk5nEpZ4NnAy9YaYtD1kZFYFm+uGJnYM8vlLl0GcL0h6dL6y
 ToPg==
X-Gm-Message-State: APuU4Z9WGuoHciG16CQ+G4HKLGPYIe676lKzN5FOZDHQtkDPzBrYhoXt
 JNm3ro8CRpwpWvXE7toXn/jUV8Mu68YOE6TUtyjntzUT9+AqQ/Gc8v+7jOS66pjq0jIfjubFdrQ
 VAjD14vDmlYR5nFyGYkZMm3XyLmElKN+quQh83KcBmQ==
X-Gm-Gg: AYBFou1qM7w9yXIYN+3owy+LjJ3f6TBJwsovcYT+aoYnZtIL5bMRJRAJC0q/vWLlrVY
 gDN+sNXNnXOXsuh0I8JxGA+qyjt1zPwwpIcE3N/p15eZig1/NFvNlhetdTYzadT06p9zd+U6wq8
 s1pcthNZnRNMi4bP5QwXC9ilJZ9RR1aBTgdWhDBJG4wwX3hsChZ0tmFlBrzWVh6oKqJ7+5YlGR7
 B0KKeCWKKWtNIAWhPBhTRerinPyluz+SsMpW0J5Y+jZEti9yfgZIxKpkk2rWQMeNESaDNlBikFv
 mxEyKKE9JWyFx0xLYjhrBxpdcME3WrcVXtHi8BeFO2zFnZwWEI1X5XN85WE8XCzeoU92eBeyapO
 6UvZ9JcJW58/ur0Wa1yHFNMtnUQQkRS8sGxWWKoIXs20IzcJybB0yawlbqo1QaPOxHGGh2AG29h
 wGwvwJT/BrqQ5fsjRNxvt3675fnDNHQ4/z5DoEM2/ZIp7sdNg2/LFS04JAlxMuWzgBrlmM3ujV/
 tphmEoXditm9wSXDsGceATsoTk73/F9TZZj9nchD6oi0hQqbTBTf20b/AOsCX0UW3Ast/8HUeMj
 Y9ecghcMLdAE5CZuKQcnkxSPTA0ps1Vi4dnJ2NKX5so4CaghNVvtjOq2Myc9EdPclJPDHn+rV64
 CAGWEMW5A1TVAF2iOsBBWFK7bD+CfaT8NuHZglJO8XKIcsVaFv55tj5VNopz/s2zAWmKu3S7KMv
 jgOfgHqF6npRWjLeLulfNpd7OrpS7enbmbzJQ=
X-Received: by 2002:a05:690c:9988:b0:8b0:a08f:2ace with SMTP id
 00721157ae682-8b2b6702cfemr42241287b3.42.1793525471369; Sun, 01 Nov 2026
 01:31:11 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030143843.467968-1-felix.moessbauer@siemens.com>
 <20261030143843.467968-4-felix.moessbauer@siemens.com>
In-Reply-To: <20261030143843.467968-4-felix.moessbauer@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sun, 1 Nov 2026 11:30:34 +0200
X-Gm-Features: AclHuK_xpjBXnj4eV-gTkhhXc7BB8Q7FLbaWZgW0g8M4vtPTzbAK2Q6oZYo6Ngg
Message-ID: <CAC_iWj+ORNwMfNvw6KSaeq9YjA=9F34t46A_pE5BMVKoivu-2Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] doc: uefi: describe EFI_TIMESTAMP_PROTOCOL
To: Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: u-boot@lists.u-boot-project.org, xypron.glpk@gmx.de, 
 jan.kiszka@siemens.com
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Felix

On Fri, 30 Oct 2026 at 16:38, Felix Moessbauer
<felix.moessbauer@siemens.com> wrote:
>
> Let users know that the protocol exists and how to disable it.
>
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  doc/develop/uefi/uefi.rst | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index 94ddf690440..7d5d8943360 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -1015,6 +1015,19 @@ So our final format of the FilePathList[] is::
>
>      Loaded image - end node (0xff) - VenMedia - initrd_1 - [end node (0x01) - initrd_n ...] - end node (0xff)
>
> +Timestamp protocol
> +~~~~~~~~~~~~~~~~~~
> +
> +The EFI_TIMESTAMP_PROTOCOL gives UEFI applications access to a monotonic
> +timestamp counter, e.g. for performance measurements. It is enabled by
> +default and can be disabled with::
> +
> +    CONFIG_EFI_TIMESTAMP_PROTOCOL=n
> +
> +GetTimestamp() returns the value of U-Boot's tick counter (get_ticks()).
> +GetProperties() reports the tick frequency (get_tbclk()) and an end value of
> +0xffffffffffffffff as U-Boot extends narrower hardware counters to 64 bits.

It's true that all board functions return a u64. But some only return
a 32bit value. E.g ast_timer_get_count().

I think we should clarify here that the return value depends on the
board implementation, but the reutn value is guaranteed to be 64bits.

Cheers
/Ilias
> +
>  Links
>  -----
>
> --
> 2.55.0
>
