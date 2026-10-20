Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7E7606A319
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 21:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kxJfIjk5;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=C474kCQ3
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E19A1407C1;
	Tue, 20 Oct 2026 21:28:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ipZvfGeffATw; Tue, 20 Oct 2026 21:28:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 32B77407A3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792531706;
	b=kyh1gsjv7bKxCqayr3D+uQ3tvxd8wvyBz+WHu5/x73QycN3XfmQpoG018QnDY4qwoTdd
	 TNylfbTPFOl4abQiDqmtzbuxabLeKtl31lBrYDHHgbztokN0N1LwGWwHOPHALZVGNmXVJ
	 Xq4Obl9R0sa+ViTy4YZRiRtfgfg5h8VMvu5uw1gRn5J1bRZRrPvZYE9n6Dxjh+5TsnViU
	 KrVqnapUYvINgQN3Na3o8MyoMzsLOE4EcErDGzkVLfMV9O1umCVigtCedKyH19WKhGUTt
	 UiwNk9IjLUiAZuZLADDt+bJnex9t+Q3IkinJVvlZLnMF/cE+Y+3zovdZ95z6MsON45g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792531706;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=YQ5zUqBmp4TGKzYL27QXeOJLSZoa0Og01K1lwxkBnq4=;
	b=d0GV/5A5fgViscGcNvdVlwiqldGyC2PIJpyeff0pOuLPRaMyKyqjlvKVIA3o/7zni1em
	 T40eDHupJ3Ay4/HS/0myDMfGOc6ZpX7kDwIyrzZswxjPboZFzaPxHw+ujhipPxulcbQ7g
	 aUUj9teaJ7Iyjy+53Z4dyvLLiDkHDhEdWPSB8nT8hNJU75YCXC5oPOTY8A2tVi7ibTToJ
	 NfJkaQUk4yCrahfKr2gWfhIIY4gUwL0s4jyGFW4J+n96gcbQmA0K4mgDT6C936fx/lYNG
	 sOXQvAe+WXoz2ABKGpF2iuZKtTQc5PnFVCngbD2flTVQ93su9FN29ZGXiFkXB3MpLiQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792531706;
	bh=YQ5zUqBmp4TGKzYL27QXeOJLSZoa0Og01K1lwxkBnq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kxJfIjk5Hk/5CFLjABByds3pwFydyR9xEstejYeb/1TruX+u5ayTXfc4+bYFIObpu
	 EMEvwYAN4udvwcZFeMqzAcicwpmHUY0aBaUINjHmTGRhbEiaJxxI95czbAgTnaHiYw
	 03V2Ol7Y0UyyaTRuldMF9WOWaUp3zvmMMcd0/JTLr7sUI1qETsSfqyYr970p4CHec1
	 lTPIi0Xafir+2WnJSqHpRE2CN2clBih5Bg6MaVWzSEHBZE2/2fRbLG0Gvx3Xp48nvd
	 0OrNZBsGP4POU8XdSSmo2Pq4+c4xDXL63pZqpfo7T7j4ZXc6o1sopvmvS/n/ek51hs
	 VBpwNcR3m2cFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32B77407A3;
	Tue, 20 Oct 2026 21:28:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id DB2F33A8
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 21:28:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D8CF74006F
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 21:28:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2XdtrcxdvMzr for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 21:28:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 199594005E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::3"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792531704;
 b=EiLxcbRFNV7Yp4Bvu3ryrHlH3P5/k8jgRQ95H5x/s59kvANO+L/Por41mD+S9ap6UwP/
 BlV36R7oiOZBz1zq9Zb7JJN/qhEBwWPz4+iCCNimvuk6JtmTwmKO9yhu+KPKuhYTZFJgM
 mATS1lJIX4FAVoheORginoprwniR66MyXDOupT93iJtUYVXwCV7cly5mEKHcTcyxP/Rwz
 YuQT7HCgcvEPq8r/IeQf9VDQaMtfVE8J53AwJVfAAG6CIX+/GaXR5kC4ZX3uG1Tjbgc9k
 irxR0Is0+FtVlvlon1DhmlQjr1jHMD/BE1hcO2WhADbegKVmkd+5F82m49iqlWxyWIA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792531704;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=YQ5zUqBmp4TGKzYL27QXeOJLSZoa0Og01K1lwxkBnq4=;
 b=VHvlNyes53V3zZm0BAfk8FnHsImxpRsW6mB7a69cUAgg5zz3oMwYXpjr6ciQZp3Q8ti6
 bUU52qnj8Vmuc3+eKZ6SwAmQUUy3EXQh2ZJUYk7zovy/P7hKkogcc8lH0NCCaAHVLXHut
 5boa4WFdZE7CkSsZsj5jcXWaOrJExNqsZLzI+L6S9OfTGGMS2nBvyW5CLdQulv86C5Yne
 J2cYy9DEmm3QWRlV/35vyzBlUS37+o2scJmS5/zTTmVKX+al2ehR36Et2m+s8jA5JKPvr
 K8ELf88lnWvxnmzl/Vpf212qoQ6ATiJc/ffrxDK69rxldG4MxJJeNezKl70IJ1yEVDw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=C474kCQ3; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::3"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::3;
 helo=mail-oo2-x03.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=C474kCQ3
Received: from mail-oo2-x03.google.com (mail-oo2-x03.google.com
 [IPv6:2607:f8b0:4864:31::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 199594005E
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 21:28:23 +0000 (UTC)
Received: by mail-oo2-x03.google.com with SMTP id
 006d021491bc7-6f4cc0bd537so1144eaf.1
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 14:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792531702; x=1793136502;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YQ5zUqBmp4TGKzYL27QXeOJLSZoa0Og01K1lwxkBnq4=;
 b=C474kCQ3cRE6dz2NEOv1w0IN8rfRSWBIIgvq+lM7uUYHZWR7D/h7ZovMNcm5UvZcQ+
 oVyUZnBFKebpPC1kA20vAPY123Uasv6Qrztpby3/h+5DWP+HPZf8VMH6WSaAtxbhG8eJ
 N6mjvpeq3uYQB+SZ8zRVN8nBDJBqcRF9cF/6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792531702; x=1793136502;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YQ5zUqBmp4TGKzYL27QXeOJLSZoa0Og01K1lwxkBnq4=;
 b=ZkL4+6GbJMLEXkh/xjuweN5U/Uot+9V4dkqM66NfJYGNxnOTAp3WbyrDKBXwmGGeHh
 wD7LKjKuA4FUqZggAhHESMiu4hms+TLojllCDqyKiQb8yNdG5yRlNBPOKRanE+ESRcgN
 vPB5FalKCs3SQzjJojybEq19KUz64EncVROR3XCYvRKowerCuSoDEyrSyg/8jdUYQDzg
 /d2h5R2UB63N1jByRgF1Abynt2pzqh+84FnASk7qgDxxHwyrerEl43XTJjJnl47Vv5FI
 lB7eXpfzIyznEvM5qeu0Fygj/TKVypUTxJgrZvrNI1Jyc0IqtJsbJvFG1TsKi0vAi9h4
 R+Mg==
X-Gm-Message-State: AFq9FYI1RBwQIUCNCFDSXW+RqMf9fWQDB7S1IrArKN9VIRdMCNw6s2D5
 gw9HKNR8CSoC+f82TXqm/Bnq4P2WDX3HCDHZaOxeJkngC295QiiyxGiqg469KxRa1zw=
X-Gm-Gg: AYBFou0mMpkAgc6FhRir5N7LH5yRrBnpiwHOWZm3Bi7MxaNZrhMrimdiLB5qJlDwsMB
 h1zpFPUGPnUGWYCxgUCHs+X5QuH5rXA1BNalGmSzzm7WznnEfWbLY7wD4HMR6bJX4X7cCl61pjb
 +fdGwA6/PA3Uz5gLe+sfbQvTkGjCcOvryNMO7IkEJ6jUXndoSzI0XXMPxoocq+S977pKL5ULkFJ
 IEgKhh4QM5zYrKwy7vsIR3K9yfAlhrsJF/GwN9MUeOIC/rxkkmJzldeDlzV21D5or59T7U0DyWK
 hMXxlBgZvsrH9/kVhZfWqJKWUm2QEP6z3DFKRj0Y5+HPVc0BT6xavBnsUiOJJGYxjLxrVKbWHIm
 zSZ3eHB1P7jEcTYUudLbIhBEsw5VHtqRp17oEWXqzW1MMcrNBZH6UKsPeMBZWl/TU06S6k8nxhQ
 KW/bd9zIV4b4/BdcEZ7ItboX2i6ZgJSgqQZYUvF9xEa7OzDvt14dWZxObmeDOOKaeLEz7DoJK+o
 +Fd8YqKKX72T+ghJLuh2Rsfp+44TREVB1f0xZAXbFnTmbQ7bt/WZcyK7xwRBjKCV1F7LjECMECm
 lO2doZK/tIXK5t9ErSk=
X-Received: by 2002:a05:6820:4c04:b0:701:e4ae:d394 with SMTP id
 006d021491bc7-709417260f2mr94938eaf.75.1792531702495; 
 Tue, 20 Oct 2026 14:28:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-84cbcdd9d3csm568668a34.9.2026.10.20.14.28.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 14:28:21 -0700 (PDT)
Date: Tue, 20 Oct 2026 15:28:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH 2/2] Makefile: Set LTO_ENABLE before including config.mk
Message-ID: <20261020212819.GK720525@bill-the-cat>
References: <cover.1791877299.git.pepe.schlehofer@gmail.com>
 <6b1531855e6557a015d83d97ebd0e80417f2e15d.1791877299.git.pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZR3eFXqUs7wPOgxp"
Content-Disposition: inline
In-Reply-To: <6b1531855e6557a015d83d97ebd0e80417f2e15d.1791877299.git.pepe.schlehofer@gmail.com>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--ZR3eFXqUs7wPOgxp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 09:43:22AM +0200, Josef Schlehofer wrote:

> Commit a55014d09b29 ("Makefile: Allow LTO to be disabled for a build")
> made the condition in arch/arm/config.mk that leaves out
> -ffunction-sections -fdata-sections with LTO test LTO_ENABLE. The top
> Makefile, however, sets LTO_ENABLE only after it has included config.mk,
> which reads arch/$(ARCH)/config.mk, so for U-Boot proper the condition
> has seen an empty LTO_ENABLE since then. The xPL builds are not
> affected, as scripts/Makefile.xpl adds these flags for them anyway.
>=20
> Set LTO_ENABLE before config.mk is included.
>=20
> Fixes: a55014d09b29 ("Makefile: Allow LTO to be disabled for a build")
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Marek Beh=FAn <kabel@kernel.org>

This breaks, among other platforms, am64x_evm_r5
+(am64x_evm_r5) /home/trini/.buildman-toolchains/gcc-14.2.0-nolibc/arm-linu=
x-gnueabi/bin/../lib/gcc/arm-linux-gnueabi/14.2.0/../../../../arm-linux-gnu=
eabi/bin/ld: arch/arm/lib/cache-cp15.o: in function `mmu_set_region_dcache_=
behaviour':
+(am64x_evm_r5) arch/arm/lib/cache-cp15.c:331:(.text+0x8c): undefined refer=
ence to `mmu_set_region_dcache_behaviour_phys'
+(am64x_evm_r5) collect2: error: ld returned 1 exit status
+(am64x_evm_r5) make[1]: *** [Makefile:2131: u-boot] Error 1
+(am64x_evm_r5) make: *** [Makefile:189: __sub-make] Error 2

--=20
Tom

--ZR3eFXqUs7wPOgxp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatfc7wAKCRAr4qD1Cr/k
CphnAQC9KeSJIb5e/kin3DGBVgD51riaLjHDBfNPGXZdy1/oPQEAlSvodKSuXu+m
wfZtRn9waGA/wAjT6zw3VHe7XUJJJgQ=
=8LeG
-----END PGP SIGNATURE-----

--ZR3eFXqUs7wPOgxp--
