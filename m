Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCDC606A31A
	for <u-boot@archiver.kernel.org>; Sat, 31 Oct 2026 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=JSkzTjME;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LReGuR05
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DE5388112F;
	Sat, 31 Oct 2026 09:30:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xeTRIoyrPjiC; Sat, 31 Oct 2026 09:30:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2BEA88111E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439009;
	b=dLrm/2hksW6ksx6Y7r3qAjsc0cUQMyWysPdCk12OFSvBD5oRxKuYDvD4bzFjEjO281Fm
	 AGKqTYSGdqgBUTA6jKd+dL0yn6yIzASeK/+pkmfr3/6mPkQTkXTGWxCR8sNtZUhvrDFcu
	 e3D1qwtksMpD72FpF9Eplv4V/toxGl/wEI9VRjajafnr2O0WI+2M+DIvEUVphLt/8yyQy
	 AoGY2/FnDxXc0N7J5/Bww4FHxmHbLLbhc85BAuBN7Yub2RkER2xeYiYi1/Y9HLfiyL4JX
	 e3AFflDVYgTA0jgIvcPGw6galMDqxmUvMz1klRJdxGg0LCKhh5y+WSp0a9ZYFoEsoCw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793439009;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ptfiQTYoUl1+CpBX2QxMJnsk5tieFTC//iP/FbqXroQ=;
	b=IG7T4DQOLxYBUxaTKyhUZd+vgSSkWgZ91e1IXaHv07TkrjFEJlZ8zSrio4a8CKnScWYb
	 4JmoH87Vxc6AKSPVKsJPKQN3w2fU+iiKdN7NTDFjAz+f89lvxiByEEawEEzU308fHjMTV
	 Cs1wl+uqhNaam8v4Ku7j3qmsckxgH+qVFTIDkzpCve1QG9H0gwsm4VQR3h52G+FhYEwG9
	 fEGGHR8oOHOCHX2KszTkNWxE0JUN67LYmCQxyBHtQC16Og/Bu5TzuBMS0OwBrmtRZdKmA
	 EeUK0848SHbr/tk72eSrESgwwu4DBFBJeNOoMBDlOfBJbUUHz6bpiExCbDZpo28ndHw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LReGuR05;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793439009;
	bh=ptfiQTYoUl1+CpBX2QxMJnsk5tieFTC//iP/FbqXroQ=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JSkzTjMEH2U3Cnaop3l7Ts3VrjDkpXpnoQORrJNpQSpi7L3joWuZTUdG26yzjMHC2
	 0tezIVSKUmg+MatFa1RrdcdmoyY6DWHIMDptTG34wjpWqminYgzgGnl8UeRzGkMIEy
	 dD84oLAsB7Ufyv/E1IQq6bNGwA28BQSjtGt1rMMLohYcdkWiocVC/0tapiB4YsQkT8
	 uzEkZbgT1LcPXuWWZZnzgwQsz/cFtIrE/Th0HnvIJ6nMDsfs7hfb64O/B4gkIDgIKw
	 exI04B4Y2spoDWXOKCu5OgnWKn2q5KTkcGwFeWGyXY27gS1Zi1xjY2krUcXoAC9R28
	 qWxoU55xNry5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BEA88111E;
	Sat, 31 Oct 2026 09:30:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B367B362
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:30:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A591781127
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:30:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dBWJ-V9ooOfg for <u-boot@lists.u-boot-project.org>;
 Sat, 31 Oct 2026 09:30:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0B3E181119
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793439007;
 b=YpaOZOVBJvWi9N/cVr1DmihwyxlHtWuqWeZnUAPCA4d3o7EYAoydyeIpKomjwhSOWpyI
 31mdNJcBRjAAaMe/z4Y5dvnllA+cI9E971Y/fHlxPKwng/dnNGPkJTm4P3k7uDdCUQI3q
 JrdkNZnZ7rf2M6WZlguQOxYRRJZyCrhq+eKLMA5XBNuw8LuED+mlzkdeseq6zWkUbiapg
 TcXrj00+lWNmWCdRGn5/5tGkqnTj1fTQ9HJH3vChNH8bK3TBWgU6vG/J2hRWEc60H4XsB
 JISEYUm+hXxsRhPJNzzblff+I7O9ObZXtHEdYH2/U8NKrnqalIyRXtwcJZ0MUWmtLvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793439007;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=ptfiQTYoUl1+CpBX2QxMJnsk5tieFTC//iP/FbqXroQ=;
 b=aXM7PZ20u+1vhRDUeF6YR37OE3TWRnZlidIFT4zrG9x1SitNl23KiNz0BSDtNCYpMpYD
 qrexHJhoEA+fUkK6S9d6vfDjUbVEWUkjO55KJZG5VgHRS4Zpog+HloIFVjh/tYxfmKPkl
 9CnGBEIqKRBh6KnCIVz3e1EAd7VkaHsT1ei3VDXBlw9Tm9w4MXVxczfaq5UUNfjtgN+RV
 lHNM0D1s5HyDSEcU4I3dmp5fgkRuptzuS7jtOyu01FhYHk+y4NvMre7RjUnubsfqKvEdW
 a7GeaWH1MvimPyEMXnGuIaBoPi+uC/CiDyp2BXnFURuH02WhOiAhiBve6HfWF7nA6ng==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LReGuR05; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=LReGuR05
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B3E181119
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 09:30:05 +0000 (UTC)
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3adc4590de4so1320090a91.2
 for <u-boot@lists.u-boot-project.org>; Sat, 31 Oct 2026 02:30:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793439005; cv=none;
 d=google.com; s=arc-20260327;
 b=jlYj5XeE8E3UyNWCljW7qjC+U6ynkAnulafodRh0AlGK3by6TZNAHiZIDdorwtVcWZ
 Slm0bl34kWD3UwPJsdKYZNg5c5LaNoK3bPVYld6nMVAZ5GLiabd/crSCszhCXPLY6inP
 n0D/dDQkbRKTjyq8XlIRULo9OlgtmOujiW/wjTPu/PKdznx8d/TTqyYiF5nNE8xCY2O8
 DsP/Fa4t9xUxswYIW4YyGnl1M9p9cLEMDrVAcKFz13Ufyb8QtEpDUazqGPa7s0HpEm0f
 voB5PGZh6WU02nOCki16NA6cSyCF0h/xgTOfrWWckx1nydAVDtaoz9ItguG06jsVuNOq
 xYEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=ptfiQTYoUl1+CpBX2QxMJnsk5tieFTC//iP/FbqXroQ=;
 fh=eSGTpZ/+rqpDSLRAETcqVHJrTBA7Fx3Zl7gWkQXUacs=;
 b=VYtV9BIyC+3u2CvL+HoC9wvg2upakg9T7/tbFKRfef1rqeS1o5GG7RY2mflY4oZ2ov
 1RJ1yw6ew0Aqm7jKnzk5fRfMTYKt6K61p50euWnOBcFelCGafwcx87ZGOGGpGXJ0tf/B
 0dZFK1AGAdNvPGB7CHGdnFzIynoATXLeqHgWXk0gUeKdvmzepAMzIEh9rtxlq0WnmyYp
 DEBhHaU0p1kqe/JMlRxbVUIGyOlw7H1n78k0Tryw6KTtB4rv/1c01pBsAeXo6jqcYEp6
 U3FpoQghzzyjNb+2J0H5Adu6uNDDjeoM2iZOl2thB/AzsxlEatSSUs5gpVWoNNN3vTZ6
 OYKg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793439005; x=1794043805;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ptfiQTYoUl1+CpBX2QxMJnsk5tieFTC//iP/FbqXroQ=;
 b=LReGuR05clAhxFxcTCoomrDX5iaeVCHh/t3L7O0LmEF59gIWoV8KDfUzYbx4xmETYR
 Cfts7/A2Z2+21P4zEFgZLLqjGEK/wFhfdD+9NKtbc1fm8U0jeWLcTx4VSw6x+4E7kJtl
 TWOFXd4j9I5CQxpVZf70/mwzybIHjNXk0EQQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793439005; x=1794043805;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ptfiQTYoUl1+CpBX2QxMJnsk5tieFTC//iP/FbqXroQ=;
 b=GtuOTElYh76HEv0wP5FvywGWCkKihtrNwMVBHozq5lzEVp27lka6YDS12z0zkl3M+i
 0VErH3N45Ig+ZsIDpOjJFKCbyL4UGIXcuOyLipnvbhdyI6jA9cthTBYuF7sBGnt7oxO5
 GlU0QR1vn5d1bHWWtXOb7zix39XAD4AAcLfdmR7RGUV8mHN7+KauGRRBK0uFNa3aHz/S
 VpYG1bCn5CkxQo9w/aVfE/uW/QlOsvbf0JP73cMJvWr7FOR3/sW1KtYPj7uN8/zmVFfV
 1qdoeQNf+CpdEeJ8E/W3IqcjNZbvt6NqRhlwRl3J9n3XlphydyHSVgkQjjV6fAsmDqSN
 3ODA==
X-Gm-Message-State: AFq9FYJvFZOumRUDRis2qiNhsCnH4fy9LnjYLqzmfY47hZMdSv9lT8hb
 mKC9YsmILBuNqk2BINqBnEv3dHBsiHAtoO9ZJR+RC8JqS922dOwIAE/MwpoGAdvwyjG1sAd0k+o
 acsrVuLzVH+UScrUZeT7T622bHoHF5Z1OjDgBrKkf
X-Gm-Gg: AYBFou1sy4//1arnSHwM/YpBwsCtVbAnTr8GRDVoji3rg7xaJKE+Do9E2BjML6L38Gu
 44K1sUyUonr5jOg/y1+T6JdxPX39zoIRmAnV7+Q24S+m0e5tD9q1V9nMuZ2U/ZKBma7HjfozoeR
 nGJWXb+MkD6dckr6d0Y4oc98meiLD91L8fNDcjfu8mMkrKceje8gl1zfN+GAMA4WaPbk2r1cqLf
 64B6ELG1XAiGvdRAaq54ijD/nC6LDB92Lyx2vzWVgcoN5v4PP2eFkOL7wrUu+6x/Tl0vrXG0HC7
 6p9MHIDEOHRkj+h1jV/+4PJgD+OddPxfn5L+bI58S56x9ay/y2+85bocfhRNl8cTo4dVZWDn6vT
 nUw64+Xui3TgiQI9hcBf/NyAfHhgoPMYCyGgqEPcgBKACvgemGRWYGdt4V1cF7oRGPG4WPBQ=
X-Received: by 2002:a17:90b:58cb:b0:3ac:a6a5:5743 with SMTP id
 98e67ed59e1d1-3ae898168f4mr3598783a91.32.1793439005315; Sat, 31 Oct 2026
 02:30:05 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 02:29:54 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 31 Oct 2026 04:01:56 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261020-b4-reset-edl-rebootmode-v2-7-f690da515804@oss.qualcomm.com>
References: <20261020-b4-reset-edl-rebootmode-v2-0-f690da515804@oss.qualcomm.com>
 <20261020-b4-reset-edl-rebootmode-v2-7-f690da515804@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 31 Oct 2026 02:29:54 -0700
X-Gm-Features: AclHuK8DH_f0MGTV09qVb6eF5pnCdwPoSFLVpGuafkL26HMFQa3eaBjgduUsock
Message-ID: <CAFLszTjRrgeS13-EpEzOCqwA_Z_nni4NL8Fu8-z=EniSiv8h0w@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] test: dm: reboot-mode: test trigger dispatch and
 mode enumeration
To: balaji.selvanathan@oss.qualcomm.com
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Biswapriyo Nath <nathbappai@gmail.com>, Simon Glass <sjg@chromium.org>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Vincent Jardin <vjardin@free.fr>, Michael Srba <Michael.Srba@seznam.cz>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-20T16:46:19, Balaji Selvanathan
<balaji.selvanathan@oss.qualcomm.com> wrote:
> test: dm: reboot-mode: test trigger dispatch and mode enumeration
>
> Add a trigger-only reboot-mode backend and two device tree modes to the
> sandbox test tree, then cover the new trigger path:
>
>   - reboot_mode_request() fires the owning device's trigger op with the
>     correct magic cells for both a 2-cell and a 1-cell mode;
>   - an unknown mode, and a backing-store-only mode (gpio/rtc), both return
>     -ENOENT because they are not triggerable;
>   - "reset -l" lists only the triggerable modes and hides the
>     backing-store modes;
>   - "reset -m <mode>" reaches the trigger op, and an unknown mode fails
>     without calling it.
>
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>
>  arch/sandbox/dts/test.dts |   6 +++
>  test/dm/reboot-mode.c     | 129 +++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 134 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
