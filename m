Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84117606A31F
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jIdv2Dhl;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=hQFnruVs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DDEA36084B;
	Tue, 20 Oct 2026 08:02:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UJcWwZ8xz4vG; Tue, 20 Oct 2026 08:02:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E6F426083C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792483374;
	b=g+th0ebS0+oY8MLSay6vrewXSf+84i2dTrAf4bJZSR4yOShMFkSIhr1KhvmGF3TK3TFV
	 apRz8byojsEZvT3g4FxgO/EgoHNPyukrFqbFB4steMzT959lYquxJuU/3ZMPEB5arLIgR
	 WaK+P+gTqfrdFAC9Bn+P67YfTxhZKbOoNdm19MNO7UALPB5BqmWSaX23empAQ1toGsJHV
	 zaSQyYlp3+Clw8zExmi/oysodweBk7e42+iQTVu4PUpvgOfPjsyrjdysD3J6bs2Gk/fQg
	 fr++GyXPlx8S3jVqP8WOMm9UcuAWlweSswhPlfTWSB0DAcVuL+aFV00PteJzDwqN41A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792483374;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=1sj+47oxsA5vuQgbx1tnWfq/PwbPAmGCknMdYtw1uqg=;
	b=Dooww7++cwdvy0J+kCDz2RJJ9GpA9TGyAUu6c72N70okYPc4DXc/K95S5iQKbZmQ6VRo
	 H9gvLuDeyweo8IwmrfxBhSnKiF3UCKei1Z0o1W59eTd30OjKl3J6wCGKaRXkWvV1MDKcP
	 IoHAT040WwGgEtT3ey6colK36SBANI1ER2kPm13SmvY4M5q+CnvxDguqkrqPSaN81E1qV
	 980ceGc9p8LcXANrNXmY6xl5eVpPblb32xqA80E4sHeS/ar0rL0ttZIARQEFhEE6oJ9sx
	 c1i/6/aq910LnfFEaCdR8e13Br0kKF4xJpeCIMLKF26aVnGs+PEVDJGUQozi5t7jxWA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792483374;
	bh=1sj+47oxsA5vuQgbx1tnWfq/PwbPAmGCknMdYtw1uqg=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jIdv2Dhlmn3yFonj/TFRA3NtbNHEdVccXBSaFuc1TqX0jo7g7uTx6UbdfP7OgnzLE
	 BpvWi/wwCeE5EAzDLHcemS5O/mOLfMB1vgU5U8ZykVnHz/GRQQLNpfEPpxCIdRhKev
	 anYXtD9Z1YrgCkUA1nOthYzWkXWRqx+hlrH7P2goi3f6di4EePGE680DfdYbjJYL1N
	 Jqvmi+u1W1uROkmgYU/XtunwGoCZ7Jjqi3B/UBhEDdX/3hffDiLrRcM1733aqgttHS
	 x6kRFkjGHDVnJN7giX++8cu2eKIZB3BV7j6hakRTEDwvlCGAIXoC6wx1s5DxnXIv54
	 lAj4wbItprJ8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6F426083C;
	Tue, 20 Oct 2026 08:02:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C85E23A
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:02:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A0A44081F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:02:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zu0AI3TGRqKn for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 08:02:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CD199407FB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792483372;
 b=OS/GE+0uWykUQC/eGfjsGB7tQ+O0yfTZr8l7sVv9hwgnt2hMHEogclPViZoTgt9AIENu
 LWD/IE93O0qJrXkwA+jLriy/506qPrBtMI7OClhdw6LJ9CALZyTaZJVAPEoNIxdeRxeGx
 oqYuph5LuTZ8LtxO5QANeq4huSooW+uojXIWRXCfW2W0DeJRrkhB0P3Lt0AzLVjSmzrYl
 F6enM9uDZZbf7JzuzjCiQhJl5t+Kg9H6VvuN0lOrhOL17h1rXnRj/QLyrgpp/iZMQvHXX
 +aEkg0E9brgW+pCviA5NX9WcAmB0PIIa8GoBsY21cD9Pisy1/kAxGMKMKsHnhb+h7Pw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792483372;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=1sj+47oxsA5vuQgbx1tnWfq/PwbPAmGCknMdYtw1uqg=;
 b=fhPj8zPEPD0dDQ361hbwC3NcHsZknG//4O+xWbAlusc4mjX4L0JAyW9LskFNVLe2DULZ
 MXn7ZFOO3seeu6rYPanUTFFgRFUEJBwXH81jczCCJqivsywegeatHH/+6rvZuIqMmmWKa
 ZSkYBdlfUwNGWgunrA5olUC/J9ouoyBDH/B31gfOuIAEptCZ7PLM94TaZldllaxXFkqs6
 Mm3i+FLGHgZvizh8br6WR9pCAnO5CVl6qvZUd46zKaj/LHkRQmUNbUixsDKHHqQpD0kQv
 mDBRr6NdvVqUduqzaG6sDEHHpXT3jAaxrnQmB60wxgbAaZUkD1a3thYzQQg6YScLOhQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hQFnruVs; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1029"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=hQFnruVs
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CD199407FB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 08:02:51 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3ab868eb9cfso1574575a91.0
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 01:02:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792483371; cv=none;
 d=google.com; s=arc-20260327;
 b=C5KeYfnC94FLVSywetM/Oj19ctg0P6PIsOsUJog9dyGZVZixmpXNDSeenXRWgN3JYk
 49OcDBHc9e7HahW63a14CnDRzAkqVz+S+kZoT2ER18H6vNt8st1tRB0n12xSmhVJnsk3
 hw+KOetV2jV5m7KkGEEBk/d42l+J4PMt89q4wB0ZZ0wlU7Tfb0LaBp3i0JhCwCw3Rp9X
 aEtMpi6dc+5g0csG4EVLOcvru3iOg9NDXNLovVuGlLPR1RSNKkZahXQkWrGJ94Ejq+Ps
 /TErBWEziPII7LRcaV9ZjsdyfjBx7OtRB7a6PxdGYbV232JsMDax7kBrBIQEeN5UQXNQ
 W3ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=1sj+47oxsA5vuQgbx1tnWfq/PwbPAmGCknMdYtw1uqg=;
 fh=hGUL+aX/o2agmMkKpMLqwBc5KpMFv73h+1G+OqN2wYo=;
 b=GV4Cpk0ZLTEyR6A0I9DDm//F1XtnNossSmG5CFZkv0p4igIvsX86MqWw2lHPLXV7IZ
 D+pTS1ankC2RnbHjaqqnsfnsp6ungTXVzdhXwiTzv5Y5NXPjlAt0fVg6lviN8sI3ODTO
 6D2Dp3Ni6LaAPm3ZmRS708PIhgRWJQn91DegbBuJlihEMUW7qHi+KKVdSnynwF4l62Er
 13ioEDGPqiyOlZWotByVQEnC2XcvidS1hwvZY+wgMXj3Z7rPHw/J7jsTEq6sck+NDqpG
 MCszHofTaVjbua6ureSctoj4jYGUjmAYo2GNMnFHUfEKVTC8H8gTSAQK3CRH9G5UFfH8
 Ahxg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792483371; x=1793088171;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1sj+47oxsA5vuQgbx1tnWfq/PwbPAmGCknMdYtw1uqg=;
 b=hQFnruVsMrAG35W9ACWJ6A7tdDO5b0HNsjTXgzDY10pH2Gqh+++DwzskigXegru8Ng
 DuMNWnwNO79E/TPhwDyX4BketAehHHvZKtvVv8Mbb0hH24Od60VfGyp4G5D0ErTDOE1g
 i5SJSc7Aq+sqBmgxjLFEx/S+4FK1BaToA6o6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792483371; x=1793088171;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1sj+47oxsA5vuQgbx1tnWfq/PwbPAmGCknMdYtw1uqg=;
 b=TKEqy7AC7KwSrLuk7c3GcF5U7WaWfmrboZsULO8TeHl94sXVX3nEmWei2FDdMFOab3
 +r53olEuFiNIL/qghsWzG0Ezw8zfsAO2iVDGLmExbc3bBc8CUo1bwIKThuIpdry9Fqjr
 U6vHn86PV0I+guWCClmY4L3Y6lCdschclwD/GV1DFTWS8nmmkO9AE56udOgx5RooEIZ5
 WbbB3zVj4HjHDkV+ZJgCWOJmWChluCGgIxJ7VMwDX97jLBG4+JpBzQ0cPac8vWJEm5+8
 /aRGrFMVvyNlzUClE4JlIZAFUNBk2pOMWc+T2mgFv1FZeP206AjExmrzaFBlRJu7Mapw
 tZmA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSotXzLiJtYCEO5brAJ8Y+9IpHbKC0G0E/99f+cXba2gZuyazaSi5pLnthFV0eWm4ktmjomAs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIBklRGmgvoF6uj9oCmGPXDCeTRhPA8MC1k9N+dljuh1G46mLGi
 iNFc1kF5ELEX1fHZgZksmPzq6Qyhq/mfu37LIP1MWHhGIWqbHQ7vSZGZpHcSCNFiU45lTN2fr3H
 9dQqtXyeU58OyWzeREllP/AM9YCyYU7og6zvtWIXqE683jsk3c8Shag==
X-Gm-Gg: AYBFou1McE1+zrBUOI36rNu/dZ/6K1uwN9qRIZ49d41xkmPgIV/4R2N9hkYVHmYksr4
 z6aBZULEzLLrOPS3cMBAof+bt/1+3/VQ7yntqM+OEQROf2dnwOh5PFbczfoWICVpg9cgUBi8acu
 EnUUgjSO9tN0mCDhWVrh6w3QdREr5rkFYhkE/Io3Ho196UwzIB+V68+FQDSQERgm6tFskYZ0lES
 f+ofEm52LzwnuMTw1tqmJNNAAwrV3VMCXhQidgLekdvI2VBYehY0Hn4VgA4PaR2gpN0LORWcK07
 VgJ3T+1wZ5wA95dJhelF5rk9OrhX2vQINch0nwQ7SirZxfunrpwwvw==
X-Received: by 2002:a17:90b:1a85:b0:3a7:b260:9ced with SMTP id
 98e67ed59e1d1-3acef5ae3f8mr9732303a91.58.1792483370821; Tue, 20 Oct 2026
 01:02:50 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Oct 2026 03:02:47 -0500
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 19 Oct 2026 10:31:55 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bd77217d61defb38362d8b6df3db4d863119488b.1791966831.git.daniel@makrotopia.org>
References: <cover.1791966831.git.daniel@makrotopia.org>
 <bd77217d61defb38362d8b6df3db4d863119488b.1791966831.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 20 Oct 2026 03:02:47 -0500
X-Gm-Features: AclHuK_6tX8njoxYQCxE_WPkF1HlrZ6I1PJPZ7lMLRXC-YIo3dPNxKb-F14sFhU
Message-ID: <CAFLszThEhY1Joav=ixNR7t7+tT8t=5yTPgA56gOD3L=T-tMPcQ@mail.gmail.com>
Subject: Re: [PATCH 05/11] doc: imagemap: describe the API and phase gating
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Vincent Jardin <vjardin@free.fr>, 
 Anton Ivanov <anton@binarly.io>, Randolph Sapp <rs@ti.com>,
 Anders Roxell <anders.roxell@linaro.org>, 
 u-boot@lists.u-boot-project.org, openwrt-devel@lists.openwrt.org
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-14T08:38:38, Daniel Golle <daniel@makrotopia.org> wrote:
> doc: imagemap: describe the API and phase gating
>
> The imagemap_create() entry omits the devp out parameter the function
> actually takes, the boot-integration list names boot_get_kernel() and
> imagemap_map_to() without saying which caller a reader can reach, and
> bootmeth_openwrt is described as the primary consumer although it is not
> in tree.
>
> Correct the signature, name the callers, and add the section on phase
> gating that the commit adding this file already claimed was here.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
>  doc/develop/imagemap.rst | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
