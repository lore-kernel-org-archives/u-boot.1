Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA82B606A31C
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dbvMOFRq;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=THaSEG98
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 926A4607BC;
	Mon,  9 Nov 2026 15:51:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T2DGrTWPjhA7; Mon,  9 Nov 2026 15:51:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E6026607EB
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794239460;
	b=rDYkm6dkf6iYlMxuRn8W8hZpaXdG4vTAKyYvDhpdgWnaW+w9gVndWqdBOe8ELkF/Dv4x
	 iGgO7k32dVIGALk8kuoses5K66dVJA7HEeZC5xKtBhpp3pm7/whCH0NOFGuvaCYO7jagb
	 Y1Fd8M+OU/eeVhPAo4Kp+dsuLAf/jlINNuIOMZ8+G5aFwa5NSAJLD3lMoT3uJ2XitEre7
	 BupVzd3QjMrK7b/bllMhkv0v51D4JAVWkr62xnkih9B3UAH6XVJYNOfO3tmUYOb+231vU
	 D/sHWUtMDQ8RG7DuJl+4BhykRDLAixo8kqS7ezE54et6m5tcWXMS5CfiPMMpnfR7bkw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794239460;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=VkDdJFdjfovncL6aQXHBsVe481SqUOa+fzTIBlJHEM8=;
	b=I618tl7TqEW9INwZlEtJv0rE3k0iEsImp83tZwS6kB0p6HHEMqCh+QTePcMYq+a7ror3
	 TFscqiOfszXV3gNPlCzPeaJGCsrsdDNEn0MD/ZYAlzExuSYuqmLHfkLFXQMrZ6HddGoeS
	 Xi/+vIbCZSJUMkDFVQr6AqjvjVoFMBqLORwj8BoMY9RB4dnkN1N7JigHirIGTihFwdzE0
	 SfWgysedbvCJutgUN8SE7Gyrn2p8JYW5F60yPsXBfhjZnUqQuIuywIwtOgmBMO9Pkhpzg
	 eLYpzJJgEEFQEYvn4KdyTlJmKADMIf2sqkePCq6pPqSNWGwbhS3wWV9hdFwSzgyXwRw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794239460;
	bh=VkDdJFdjfovncL6aQXHBsVe481SqUOa+fzTIBlJHEM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dbvMOFRq5NOIwsbqrjFNHR3EPeYCMu4regEUlFF0za010/2K94a5X0QU9xOMSZ4i5
	 Nay7jsTduAlBefowSOjs/aFdUIwy753rpRSE4cfHynJkmQ8oZ63eufwZH/TW3ULCWl
	 8sVA3Vo6zBzEZZCyeX/quko9MiDL6SH9/rrSFSXdvDYVxjFrfKt04LncdP3bxNpqpw
	 mS56MBPtxiE3FSLuYXZ+h86XPhZrh8K7sSPmYLmH3yj9jIs6Tg0T+pQB1xrZNyP37m
	 mu9x5R5GVnzpKgWxvhVZNNo7bqmKwsPY0umrBMedkPWVJ8PZBJVxIvoIuzlFcs2/sU
	 yW1vSmnFTZOEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6026607EB;
	Mon,  9 Nov 2026 15:50:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 474DC1E3
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2D04580FFF
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:50:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ApMUK-GLOQgt for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 15:50:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 635C380FF7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::c2a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2a; helo=mail-oo1-xc2a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=THaSEG98
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 635C380FF7
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 15:50:57 +0000 (UTC)
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-717034b331dso560991eaf.2
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 07:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794239457; x=1794844257;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VkDdJFdjfovncL6aQXHBsVe481SqUOa+fzTIBlJHEM8=;
 b=THaSEG98sE1yI6uQcii5tt9QLTId9Vf1tS9RGd5cUiFtHVtJ364Wf4F5V37mDtx5j8
 bvhsF0W8DWY1k7OF/K66gjKcAMWVqFEOieiVQcnQ9CvEcEDlTMeUTNP1LFJQhuVm93+C
 Wl3skzL3xXh54TsS1/zV4uAd2DqT50fH05F5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794239457; x=1794844257;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VkDdJFdjfovncL6aQXHBsVe481SqUOa+fzTIBlJHEM8=;
 b=qHtf3E590x0r0zm3aU/LUYeN/VlpuM3EHgwr53gSCQGhyXjEGwb0QRnLsNfGfcwwEL
 EI52Vp/6hgDq/cppVzJIgFl8eOLEkSuZq+wo222T7w4DTLMzd0RWw+VHPIa0U6O5tppW
 9VT2I+/udfT/rcKAvxnTURoe1EzTOAFgXkCmvTffftO1jGGwPgjiH4wdl65z1NvCLAw7
 7Wcu3jhO/xqUs+3ssDM6EBjjacyU7STfJMCJcA094pj1OryddSvPwsVwDmO6L1fsZpui
 aRLBPUalr24K8lz40G+PzOutH5MZybqtmeQWJLp1W+uv6zQZox8VAYksvu3+rLLk5fsK
 mNrQ==
X-Gm-Message-State: APuU4Z+MFHG7sc3rtCE3iNOuOTiPRiC73jmKSQnxYBv+G0kuA2RfqaES
 SyMOBsyaXAsj/AUHa81ltO+AMi1U4e6cMXvXi2GcZHSBAT+wl9fcjNVKNCh0QXHoSNE=
X-Gm-Gg: AYBFou1UsDOw0t3jOQTZOIig/U4dxzLL/rQ3fopp6LFv3TOj2DSXf0fhwcgD2x9WEMZ
 js4i7pYOkNJoV7L3QEN51l4VzjCRcv0r6n/ADsZc1l6t/rS/wsw2BOUciTFLgodqJ34zreSkLYJ
 YFa1d7QWFV5gkAt35OiIVWJlVDnx9XVs8BlouJwBc3JISN9okEcjgwRNU8gOoCSM1wmaipEafEc
 fHoEhDfDBRXHZSkLzmLltlyrokxirbxrl5uGuz1/+YuuQTxq3yg71tW2HcJLTvGa4oOzYUxScP3
 JNCoX8sjjHuLJbTBtKED7YCKMqQsCf4RsNZBbxxnm+PvEqmY8q+WEe2+fjTGcNUt+bF11598B/M
 qYBveqT3gkQv/RgYsGHUP12EdmHXrOjyhMVkwFOejEfmeJc7JpD2sXSH7ysOqrbu+OjZEiy51fT
 bpnihK8l1YXaHnp8KRvYXPP3F1uek6eKsVg4q0iJawZo6tV/hD07IidjcJvs7L99hPFGSb0qRo4
 mL00frCtqicYae8CJorffnoFQs8KqZBxg4sNX5cClw/JM5fJzJhCFXEVju6xfWhVo5DEPTdKfzs
 y8e+LdWnLJm/jNmxcN75cg8oi30sZiqssvlh1bRz/OF1XZnBId9HsguotqNv/w3ju5eEOO3xJMq
 IlXVRHbd03iSDn646tImdCjkk/dgOoIFXsubmM5pjqhlYGHiyitsy6BMTXPv3sYUiKTTAxzojoq
 6z3t4XBO8FSHfgrjqGj0gvtSdQH18AVpQs0JNDu8rJvAq1js7xzCc=
X-Received: by 2002:a05:6820:c2c9:20b0:716:bbec:d300 with SMTP id
 006d021491bc7-7170f2a1cc8mr1500408eaf.47.1794239456943; 
 Mon, 09 Nov 2026 07:50:56 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-7170f8fb94fsm3458385eaf.13.2026.11.09.07.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 07:50:56 -0800 (PST)
Date: Mon, 9 Nov 2026 09:50:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, rick@andestech.com,
 ycliang@andestech.com, e@freeshell.de
Subject: Re: [PATCH v3 1/2] riscv: spl: Move BOOT_DEVICE enum to
 asm-generic/spl.h
Message-ID: <20261109155053.GN3741582@bill-the-cat>
References: <20261107020547.2021618-1-urvashi.sharma@oss.qualcomm.com>
 <20261107020547.2021618-2-urvashi.sharma@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NlHOHFvV4Rv+q2/1"
Content-Disposition: inline
In-Reply-To: <20261107020547.2021618-2-urvashi.sharma@oss.qualcomm.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--NlHOHFvV4Rv+q2/1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 06:05:46PM -0800, Urvashi Sharma wrote:

> Some architectures, such as omap3, need BOOT_DEVICE_* values that match
> their boot ROM. RISC-V does not: U-Boot works out the boot device itself
> and returns the matching BOOT_DEVICE_$dev, so the values are only used
> inside SPL.
>=20
> Move the list to include/asm-generic/spl.h and include it from
> asm/spl.h, so that new devices only have to be added in one place. Other
> architectures in the same situation can switch to it later.
>=20
> No functional change.
>=20
> Suggested-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Urvashi Sharma <urvashi.sharma@oss.qualcomm.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--NlHOHFvV4Rv+q2/1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavHr2gAKCRAr4qD1Cr/k
CpJZAP9OlgbRXTZ+cMuBoKKq7Wxgmkm3HDl1VzhaQkFTtIoSwgD/YP0iL4ae99X/
vowv62Wrvf6NPQcTjcTme2kKpXgW0wE=
=pR+k
-----END PGP SIGNATURE-----

--NlHOHFvV4Rv+q2/1--
