Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAD2606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 00:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ThyrscZ8;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vkVaYHqk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4DD5605E0;
	Wed, 28 Oct 2026 00:29:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TjCXC3ymnRzB; Wed, 28 Oct 2026 00:29:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DB91060613
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793147365;
	b=N9Raqk7pgZGJoex3mjD/dFcseMlfT9VOOgN3JuKjIwyGGMOWI3QMSh1shpUOGn6Z3iP3
	 HN5W/r7c/hYxeED/Pi4+TI+BMkEuhfpqVAGJui44DW3uw4vbHSKl8rvyv2szAoFUM0OvY
	 1gK6JSThv8jCH50pqds6cv76ojCpEwal61XuFKadya3xQRPra6MnTQmVhmSaxm2eLI/Sk
	 63B1cfdaDz02TAFfnPqwdsBw2VskyPxRHDe1rhfPlhaO0WJ79lpTWdLpJIcoTe1ebEJEn
	 ViAXvcaW+AEYxZRJeRzKxbR4bIb5qiErdceBgIBoZda1RB9R064SxyasF9lcFKxNRcw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793147365;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=AvBfr0wTy2OAjQLzzMogemw+gNgpB06BKXrF3rrLkvQ=;
	b=bdJb65u5AHKL3KmAdSFe6BKrafP/vZNGkkYNNCqOBAqE1sL4xb5InZubL2FZjZkI7kEW
	 7KRQXTK9rJm1CrP+hplrfG+ht1Ylp7MNQ/COIayd8n4lCL2/xUw4GCGpU35F5Ks/2HZXf
	 vmDimubvtGQMI6y9yVHWkqIRXzTkVTXmKbNo29Oy+pE+nOYvsWRIgwUX2qYEvA6J5Y1Il
	 JKuk0YXh5QD6oL9q5jP81M3RRUgyP1bEzspoSckz2sQv0IWuNZEwCiSl15ZkRP0KDKjMz
	 u1GbEVDPx0x/xecFcAKGmhmBy72yx6VzClbK2n7aYBvZJXksrSHad1VLwRoHN2M08nA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vkVaYHqk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793147365;
	bh=AvBfr0wTy2OAjQLzzMogemw+gNgpB06BKXrF3rrLkvQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ThyrscZ8mbnuEasjh9lIlNYQ7Qn/kt7TDrHaljbLRl88CSG6SXfJqfDM4QAgx3L2Z
	 aSdXcaXnlMWkAI4Dmpd5YBXRZyXgUqk72i2Gkrtl5gAreAuN/42KVDa+Qs4yTFM8VZ
	 tiZ4D3L6/rFjklRfejTA3MUIFHOeQKK7n+z90m2Tpw+BURzVOhcD4pxBgvPMT79Zlv
	 Dj1/sZZxTTTJ7QdexcVRRwDNB5PJmpJhHM9XHSDQ4jK2kTL/YyUBZz7CZFnHI6j17/
	 ogdoufKAmqIk6v2whf3Yltpld9Z7tGRWhSYv0PvvlEJxOT5SS9ctPC48mOv2dRi2bz
	 fCNyHPO05qg1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB91060613;
	Wed, 28 Oct 2026 00:29:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 94068D1
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:29:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 914BA605E0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:29:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R9m3pkEiRoxa for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 00:29:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A619F60613
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1129"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793147361;
 b=FYfD8loC5VEX7GlVD2APeTsXejEBSaPTczC/YlwGUZGUj+n08RN+K+pKParQMRFDSNlM
 fJW9B1Ib1BAq5dbNzePIE1on1X3MAz0o/AGAA7vPa8wuJnoS1bePBNVjVw1JdWSGEJkw/
 RyQ9KvpymrSd/3zwlseCjyIDfJpRDWrDHI41Rzfrexb83NbgP6KmFEquB7JSNBiupvrW9
 Oq5mRS/tq967u+ZH6F89NukV6pz5B8F6C9qdLgZDlVRpaElFwhZiQJ1iILk8Ar2diUODz
 hmfRZZRHHsu5GROV0W0PKI9eNQN87E4RvV/NNNKO5ifdycKdNhXcCUu1IPZSRI6GzRw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793147361;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=AvBfr0wTy2OAjQLzzMogemw+gNgpB06BKXrF3rrLkvQ=;
 b=AMnqgCQn4cvb/C65d3TL3SHJYh6xm3UNGftnlY2SXZi5NrgAQXnpjVM+iWJsAgvhvrys
 6JRoBx/LZSZqLtLplyEouZJjwPgghIQs7QUH9suTghsjFaPDw43RpiT3bH1YHNshXJhQh
 nMjEgkM3IN2LijPvm04kkdlY6fXgIqdfIxXTqBA6UMMkLo8vPTZnCD/kv+my3u0lTSNa/
 WbsiqgNF/VuQYusMy9xtHz8lCLPP22a9eYEutla64A1K6URjaTuy/CHskbZaHh0t9KmLB
 8XllPkTvmakzTfnPFUzcW21otqH6I6mzxQ9JBXfgiknWbFItk+3hn43X+eZxfr79EbA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=vkVaYHqk; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com;
 envelope-from=bmeng.cn@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=vkVaYHqk
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A619F60613
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 00:29:21 +0000 (UTC)
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8ae8607e8afso2925167b3.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 17:29:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793147360; cv=none;
 d=google.com; s=arc-20260327;
 b=SegoPIpa4yNKOcyMFtzLZcqPaLpSAKg9rOQaIVqMDK66oZ3nCVaWrCIpN/id5XCn4A
 NT7SvvZ9gvALA1lfC0GcbTD9OZJXzuoj/HvZLuzMsRfX5bv/Lf4cNFLy1hah9JjziIyO
 lAoqtztHx/UDrhvhhn5BssBMN4QRSRIJTrzHlLYXxLWXQgGpQuXHIQp185VgbdHTeatM
 mI6T1hTPBXXlgIgBL9azsB5HPzRe/kU6kl/T8eJfyiSKZirZXXO1sRAjkLfwwv40f0Ng
 jlZfgb9NCN5/tZBB2gBWIZsbeEuttfO6DaWvO527oArEBAA8GHCc5J7V4FcoVjeAlaQW
 R6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AvBfr0wTy2OAjQLzzMogemw+gNgpB06BKXrF3rrLkvQ=;
 fh=c2XAJkz3pTgmMho7P6mFsU5xHZIxNn2k040DF5NJppk=;
 b=hbTC8clnm7RY3T+rZ95FrHc+x6YuRQXg9gbUeHH4i/Z4IcH27lPglQJuufbWozzkLe
 LPE1nJjJosV/s9/xMA2ih77RlM0aPFiVgSoIZHUCMayzuNjjLFbpnLmV1STEt+NT9y0o
 dQzq2VV/kC7IvYRlC6OmQoRVY7SRSuWjT2QzsulTSdLIdYCilA0HtUIHVVBaOQiv8HkM
 LxAscar3iWsEky168SsRicLOe+TD/AeHBu45pyUVRHjdKgmi2m2iKmLbxQ6kD2//neZH
 RT2vY8iQCBB1HgnnEUjXR12HVvsBfJr1X4vwEWkDVGD39vmUWvCVBfq2du9ljffFU8vY
 7bgw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793147360; x=1793752160;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AvBfr0wTy2OAjQLzzMogemw+gNgpB06BKXrF3rrLkvQ=;
 b=vkVaYHqkCFa+WlHx2Lyy2bTc6azZY36GfRw1VYLWBM8hQxxCyWMINl1YX4EhGwD6St
 iEAt20Nu0uARLbaONnphyJgTXfkfq/Cx/hFWTENrw7b4krKZiJIbIS9jNASWDqQOVIiu
 +iFrAo6UA0ApKcjBJrPp04MKZAafEO679eahvMBQdz+L23gTV+WSmV3gyKqDEZf/Gwh5
 vzOEVIJCJReHu0jVDtbsoAFo+IpKyv8K10znZoB+J8363zp6B+N4j2xOKb5KQy02dxzI
 OFKKINTN1W3+lCdETX2VafrHKPNZKpAvivpPy+k3f84Cj+h9YxdyCx637so/Y+ooLHzK
 P05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793147360; x=1793752160;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AvBfr0wTy2OAjQLzzMogemw+gNgpB06BKXrF3rrLkvQ=;
 b=P9O41aqOqM7UaqSkJFM5QPDVAlEZwkXjxqx8HyEXdB5dI5dXBLb5mchF668YQ3XALk
 5QjQ+liyj0BZL0ov2CXdvj/cYeulZfgc/iN78R1asBTl7iAh//RENQREuJZUObwQDJ+E
 yf9mvAxmnskqEDVC1TkXNwu/VT4nO8++jhAOIjUuWX0Lk8qd4ltehbsPLfLcOeUhKHtt
 wheATBAhbFououKUhRh2MCMSPsbMqu9UGi9OzTP346JQqyjqXZt3i2HnQUGRPVDnHd7m
 4kY7ZNmyByjvp8cxG/TAxfV4q4N/cZ0T+Ny72PlcxzpTKCMFt/8aK8m9QAu0SYhu1NB+
 VwpA==
X-Gm-Message-State: AFq9FYL9VttJWbqWhrU/4hh5t0ml7A39GdloIguRszqDwJQpvKT8h57M
 +05NxmqN3VtOmCBMQv7Epx6i14+Qd9sjBgxwsb5g+Ypno+LIo+hU/8XE0QLycm8cdLLUp2rHvT7
 Eu4NPt30ircVOA+7oBjxL1uo8hK1f3zk=
X-Gm-Gg: AYBFou3vk7sLhE82p4YMhXt3Tpxk6qB6ItTytFiUCL8e2DDluLR2q05YRnoBb/TWNDw
 OtBiePqL84v8r22ArxbJpocX/t95rZsaBhn/nD3R356+5RUSLsCyiK9zWPW1t6HSGsUMNxt6prd
 WaMwPdRluynalvulgTtWkVQMJ+KzdiVHRWrGTxDqkIwMvpebqxZ0SZbiqyP/HdoMGB6Rwgo4jhE
 Nw/zXW20Ml5c9dNtfHV45rjLjVeaXfhO0lFwoizzOck7iYaEEs4K2UA9LYTHiubGB3nIw2FJ/FA
 AKH9uDakz/Op5aRHOeWmfOtslOc/hmjaUkJztkqFPJdQb8F28diJ0w9e3TN85SYH3LuxtFtGAQa
 RwzAQl4PIoHueVtf8N6DtEGEftqOmG20jx4RljHcf9euuscgptV3cZoGDWMkZ6BE9ei2rVUY=
X-Received: by 2002:a05:690c:8010:20b0:871:bc3:9856 with SMTP id
 00721157ae682-8b1b5c972c6mr3427517b3.33.1793147360114; Tue, 27 Oct 2026
 17:29:20 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022155806.115031-1-dimorinny@google.com>
In-Reply-To: <20261022155806.115031-1-dimorinny@google.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 28 Oct 2026 08:29:07 +0800
X-Gm-Features: AclHuK9zbYhipe_IGebFjcaZ4j2LwSX0ErCyJVlpi9jm6zSEh4xpHbSMl4P6_AM
Message-ID: <CAEUhbmUa7k+F8VrbsaOma-bM_i-02SSPH_+w9wn1mcfQYWtd5A@mail.gmail.com>
Subject: Re: [PATCH] x86: tsc: Read the base frequency from CPUID leaf 0x16
To: Dmitrii Merkurev <dimorinny@google.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bin.meng@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 11:58=E2=80=AFPM Dmitrii Merkurev <dimorinny@google=
.com> wrote:
>
> cpu_mhz_from_cpuid() should return the base frequency in MHz from CPUID
> leaf 0x16 EAX. Commit ecf31113f178 ("x86: Sync up tsc_timer with
> Linux") changed it to read leaf 0x15 instead, while still checking that
> leaf 0x16 exists. Leaf 0x15 EAX is the denominator of the TSC / crystal
> clock ratio, typically 2.
>
> The function is used when native_calibrate_tsc() fails on an Intel CPU
> that reports this ratio but not the crystal frequency:
>
> - in 32-bit U-Boot, for models missing from its table, e.g. Skylake-X,
>   Ice Lake-SP or Comet Lake
> - in 64-bit U-Boot proper, always, because gd->arch.x86_model is never
>   set there
>
> U-Boot then assumes a 2 MHz TSC, so delays and timeouts are about 1000
> times too short. For example, a Core i9-10900K reports 2 in leaf 0x15
> EAX and 3700 in leaf 0x16 EAX.
>
> Read leaf 0x16 again, as cpu_khz_from_cpuid() does in Linux.
>
> Fixes: ecf31113f178 ("x86: Sync up tsc_timer with Linux")
> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
> ---
> QEMU reports zero in both leaves, so I tested qemu-x86_64 with a debug
> change that makes the timer code see the leaf 0x15 and 0x16 values of
> the host, a Core i9-9900K: the TSC rate goes from 2 MHz to 3600 MHz and
> 'sleep 2' takes 2.0 s instead of 0.008 s.
>
>  drivers/timer/tsc_timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

applied to u-boot-x86, thanks!
