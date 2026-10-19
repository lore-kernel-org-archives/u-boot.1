Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2993606A31B
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UlcDlj3I;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=a73oeKmr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF32D6077E;
	Mon, 19 Oct 2026 17:25:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8N0Y0k5eO2bK; Mon, 19 Oct 2026 17:25:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C70896076C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792430749;
	b=c8i3ffvhtn+bjZtyuu3PNrH7WeV/8wSy5nqsAGK+m2KLwVpUlip/CV6ud0H05yaOH6JP
	 C7pJ7peXTMYNzjUtBvUvZRx56Xu4Ts1VjB2JNADaBgRi/93wkRGgpIgb/VVKJfuMdC2nb
	 HQMsm0yk/ThynSxs8Z880ajsMX3+toidG3UEn6pK14IlML/EeF+uxmzQC1vKBELf4leQ6
	 AyT5ucLedH6lL7AhZqYhS37Ace7P7vFTalqGTCWU9Lj9BXTTfrzvYqNDVIqqET/dFPVqH
	 PAAaGJ8YWSQWjwjkr39X6JClhuMYTCY5f7kh0ckR8yNGyUfj6HsDIlUMVWjkm2Xv/lw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792430749;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=uMLKCfkXjVIpLo3J+qhXp9zf1PoOLNHz/uqey5PooFw=;
	b=JV8NesnTI7nUZdYzVcw1bB9g035iRwbExID+kbDQV6+44YooilbXtA53jpRYlKeWGqNr
	 RYmMeOSV2Qxmrqv30EZeI3yXBATx+1ip7Dy3gwmuKe0+mocdXPzN04XWGLfVTzzQbL1/F
	 Wx3W0od4RTpfb1bIUYjPKB3FoUUxZC6K+m6+sHBBkvrJ65vNlhlB3AgV7lOXeEJ90MXy4
	 c9hP4PYEyrkHW23CpZRQcQw2dq3xEAZWcdXk3YXqe9FrOkiucVahI/wgSMp8SQAQN95ws
	 0UL2NOudZ3ePPqhpnwvCggkFDySw0cKyoKAwDqzZyH86Rz6JqA4uD1bzWSTFpqxFuSw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792430749;
	bh=uMLKCfkXjVIpLo3J+qhXp9zf1PoOLNHz/uqey5PooFw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UlcDlj3IxnBPbu7TwOZds1viv2YswoB6H9l0RePooifcPVa4Ck7wnInJz6tsmRzev
	 USbj2PBMwXb8/BNJ5us+y9P8B1MXhq9djMDWTOmFcvpUxVaLZw9Bwi5BDdLq8R5p0V
	 IyvPc7AtGGiowzHaHhpN/S2+t6q8eqdh8Kr7fz1vE2Luu1nb3DyJ3NOEu8IOn61IWA
	 8raXfZHpEBFVDaFACVuS9j2L7ZvaPwNI87wNJtJnLmKCNo5HqmK7d/kAuTYiBZpf8w
	 5v8cd5K+JkDjTRg+GkLv82N7vfzb5bIB5eFhpZ3Rsmo15R4rmo3o4HFqr16DwFxAKV
	 WDmtbnGtDnVjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C70896076C;
	Mon, 19 Oct 2026 17:25:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C0B89279
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:25:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5C15C405ED
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:25:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kmrtzzy4HyfX for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 17:25:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8392A4056C
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792430742;
 b=ZdNDEyM7uU9/VR4yJ51+TFDP/5dlLvZImUxBHgLZ4KbXjrNVg/z/OdIAv8JW3UUqmK/5
 FSESxW5RP1e4WTud4mtpbNk3fFt8n+q40uWz2Sql2/HjG6Bqt/hNxMzXsHXWPrnpb+vio
 ++8P1+AaVMTV4Goet98WOT6vM6WYNAAXYfCpaBewQhkTozNUb9znUiYoM7K/O8XP95rU7
 2SHXz6O28pVBN2Q4mZzCtrytHO/7dHPnYICma6V1Dhv4WcxkV6O5SlnMTthKexTYC981j
 Zq3SLgmCm21YAc6b6jfl/p68nxYJFE9DI8mr/9WP0WHCESVkKL0aEBG/13OT3+n7sGg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792430742;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=uMLKCfkXjVIpLo3J+qhXp9zf1PoOLNHz/uqey5PooFw=;
 b=ctVasxjxM+ZK8SzrhLH8Nlfl4tyTLDLSmZy5qRu81sqfUr4ppetXp3YZ1NEC2B4iF7gX
 3KKGTn+mNgphcuOqh2/kLhmlR3eOhvpNEVfC1w9IrYiAjdOg27Ir+A51AOIt+Um+bBOY3
 qErbvToMzPocI/OGO3RjQ4mYJhftBAjCJ4OMqw6TAIs50d9ybhTaT+juyiqqN/MZqyE2b
 fIUq2Qot8SMn6i3v40kzX5/g68+vQL75Gr9VI6PSXscLeAvFiMy9oCXasEWI7j8MVn7iw
 i3AHTsmUbu3bEgpNtg/lrIyhjTdf55U5Uho92sax/QZqmxmTPzy+HQ7HUFt2UVxppOQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=a73oeKmr; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=a73oeKmr
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8392A4056C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:25:42 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-70059e4dab6so1591067eaf.3
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792430741; x=1793035541;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uMLKCfkXjVIpLo3J+qhXp9zf1PoOLNHz/uqey5PooFw=;
 b=a73oeKmr6+7nCGj+JEMAF77+o6LWXMkoabBUAE67gH68XXEdrvccc8hU/IVtBPS9Hf
 3IN0spVjk5IUKnTIv3HiivvGtWyFACmMN6320x4msFRYvEAuqAQpbha0RM1o1u5Luqtt
 0hJljO8eDEH003ThRcHJJFx5KYijT29SBwDyc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792430741; x=1793035541;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uMLKCfkXjVIpLo3J+qhXp9zf1PoOLNHz/uqey5PooFw=;
 b=aW3ScLs8G6BLU3Oi5sjoqfj9zxFEQ3g82Xe1R0k7IWM5u2Glj4ycQQVIyOshY12gwj
 jqbpTQ5IZLecUNnTEqEAPjI4kg0QYsi2/Kmn+X2IsZmhbGzTx4NiXX1RnyT2MuCgv2tA
 9u3eYXbV81Lt2103s8qEgFA3euFGb6TaKNLe8E/j6VSEQ3xCt4G7e1rUGGk0WDZgpg9n
 BDX3OjSxfsBJ+p4etgrYOnYk9HvFSDnRq4f2HQXSAgpzbSCa5ZqanvU50N1XtJPpTaKx
 O592Dv94M02FeM9CGOCMuJdQWbylmZWCrrDq0sMFvtSr/1mzNdu8zWJzz/WwmxqFKXql
 jcwg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzGC2M/dk101mnGI3Kg+xvTA73f1H4l2SFJG253FfrQ7s3qmBvET89WgYYNkYdDYBKx3mhYI6g=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIbRwFxPFKOkW2JwT51lCAkUDdIkM4o1Uc1moL50K7IUzpg7N3r
 VutyrcNraTi+NlQXrwfQchqHhaCt9Uc+IDSrq68fwGjg77UwZ24A3Bt10QwlbyXrChE=
X-Gm-Gg: AYBFou0hRcdvmzqifNFgljJyYzLms9qhObUvsT6pAQt/s/P6YBo2rmL/YPLvg6HK/yf
 T1ovLcs8WglrquvdB6BNSC7VFMWHfc80jbk6k3YexTfH5j3wSCkjyN10SyZHp9gXNsy4tITlONI
 ZfToYW39O0hmQUClzRJztrXfNCErtfH+mbzbiFeYV/wzsKWzyfbb4JFBvmyu9AvvWzBfsTxoWlJ
 XcFzbV6N5pYHlf8IliO55M2zpcgvG/bfGIQirgxc5UI4E/nWF8dfsjRat6xEUoPfYvBJ+DqR6yC
 vY1IT4uT77Ir9tfcTXyxRwHJgE4SBsd3ZjUl0fXTW9IOAJ4CXH/BPUNZ74kAb0wldV9PsoWpxnP
 NRaSJQu37s0Doe07oHPCc6jHEv2dIXoa8JWNVbhhhMtuizLLdFEriotlsBdux5CFf17tztXje5N
 kDicMjRmZ8E0Xt4neNmOBjP6DQNf38gZdSDNVlTj5IEukCyAloHpdnmzIUDJ+2kJ/VgmSDiWEUl
 E7u7R2ymkUwQTCdMvmoo7Gqi1jQSzcC3nDKi7H3wdcneJvNrw4rwCXYlhn/xpjBhWFGCq9y16az
 gUo++9SQvAKsXs76+g==
X-Received: by 2002:a05:6820:2911:b0:706:5b0b:4e8e with SMTP id
 006d021491bc7-7065b0b5049mr1743858eaf.55.1792430740948; 
 Mon, 19 Oct 2026 10:25:40 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-845b9e280dbsm6947094a34.19.2026.10.19.10.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 10:25:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, u-boot@lists.u-boot-project.org
In-Reply-To: <43978c30-32fc-4a64-a628-e1dae1ecb362@linaro.org>
References: <43978c30-32fc-4a64-a628-e1dae1ecb362@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-ufs-next-20261019
Message-Id: <179243074026.723589.5558948014736196469.b4-ty@konsulko.com>
Date: Mon, 19 Oct 2026 11:25:40 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 14:49:57 +0200, Neil Armstrong wrote:

> Here's a simple regulator support for Qcom UFS and RPMB implementation
> for UFS, allowing secure boot booting via UFS.
> 
> Thanks,
> Neil
> 
> The following changes since commit 8d534cec0cc0109a37c0ded8854da03f1526dc0e:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


