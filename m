Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE06606A31C
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NSRq8rDS;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=NIT1Phtp
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8A1F140588;
	Sun,  8 Nov 2026 16:14:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AKHdYUvVapaj; Sun,  8 Nov 2026 16:14:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B31AD405B7
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794154443;
	b=U6rMEUwzOWbgyd6cAGp/kbbpQhD4LvbOV4ZEznzI3/yolAfwra4GNPMKh7yGrnmRCJbq
	 Xsgzn5Q08sTUQWo/dciddEoQ9Enp3DtJyfOyNJivFZbI/u6nxpkf5wj5DyQhD8ih8uvsM
	 DNxzyTvw4XV9KdGJXaaVp2XCKZP01WvpwOf9pO2+HpPBwHTy1jbDi0QUJ+putcGwK7lB/
	 mi0PAD8tZWihZVTXZSlAHJWyTCyABhR6A8nNhkJU6fkHe+jZuNYVj2gb1xQllKfx106TO
	 Nra8fdyIk9mCxplF3yEqPJmin5VUaLb3/0b6sKqZ4neootkUtCkeU7ePNpwGHUhUzxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794154443;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=9XueXqamqZtoBZRzcu40KTX6d4UD1ngfdTGIG6I7exc=;
	b=cnfqnytWlG4n7Ad0wyWtFfNwauWPnyuXQsdtGiCX2xhaYmSuur/76uZqlJHFRdo68Rnl
	 Q5G1Z/tU4CguQTnV4RKn+hIKMjcYm8NeBAhNShwJ5sxFM5j6bdQVp0Vj/4MAcvsmCq+FN
	 MnIZV0FPHOcdWjr2PpNKCojixZjehGOQ0ZB2Vjw9wMZY9H02ZFNeZFWzfRaZHkEZwH62z
	 yTEYL4Iw777YYYi/yduzE18rud89mt7yDVX1f/QuYfpRenJCWB2gQN2+0oxicUyE4CiVx
	 FbpTm39ZpJb4QA82hK+7a297EgzLVHbTLS+AiomDJDmLQPk6jF2MhFnNm43a/9wAcrg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=NIT1Phtp;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794154443;
	bh=9XueXqamqZtoBZRzcu40KTX6d4UD1ngfdTGIG6I7exc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NSRq8rDSNk7Kv3vquhHUp1HoP+W5sazz3lklTvfb4xV550bhlDNREPIYdIlqPFmLi
	 HBYaN4YvWnkBEGam4GDMAx+dKnljCFuzM13U4yUOTMVyuPOEYywKjBl7PVEyG0h7DU
	 fiUS4NSSmcciZ/ab50ioUcu97PVhKejIXToXhllLvHx+sbKXSGucT9pA+MTMJJrDKM
	 yY0mz2kdjQ3qqUYfQAjlp0mMG2/z+gedQfcKjok1W4koV4Wy3tCnpr3kKMN1lacpUR
	 PrVvOnDaM8t5VXXDiLoW/bSdf56yxZi2S5bJxfNTWse/ti60hf3CtwVtJixaXq7CJt
	 6RhYCpsYLonjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B31AD405B7;
	Sun,  8 Nov 2026 16:14:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 34CB9932
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 16:14:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1ABC5405B7
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 16:14:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0FLZV2LEIFi4 for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 16:14:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2560140588
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::6;
 helo=mail-oo2-x06.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=NIT1Phtp
Received: from mail-oo2-x06.google.com (mail-oo2-x06.google.com
 [IPv6:2607:f8b0:4864:31::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2560140588
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 16:14:00 +0000 (UTC)
Received: by mail-oo2-x06.google.com with SMTP id
 46e09a7af769-8217177c5daso74545a34.0
 for <u-boot@lists.u-boot-project.org>; Sun, 08 Nov 2026 08:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794154439; x=1794759239;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9XueXqamqZtoBZRzcu40KTX6d4UD1ngfdTGIG6I7exc=;
 b=NIT1PhtpdLGCTHMD4tB70UyHmjPj9FJI37evKWj64KT60jLH4vZ5J29FcUyD34dKvl
 cK+Xiiy+MQTOnyWoaNzwxGlQTOqf1AcKRg51rcWgGLfcpGz2aOQRxtjU3IaecWFuEza7
 6mzNTxruAOkzIIb7ct+9G6uJSM8d1PZ1P1fK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794154439; x=1794759239;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9XueXqamqZtoBZRzcu40KTX6d4UD1ngfdTGIG6I7exc=;
 b=wJaTSIBI966J/hqMRImI/oPkQQKaLGZydgJGsRcH+2cU9J5szQsgCemvcC+/88rfnG
 Uy+3SoVpsRkVGiOkcBZSaXdfcnbifBqa4vaV+pVUIjxf1XVpJg1R8QpnMS44bun4YFdT
 fcgK9DU+j7w5IAv5+zYPTj664ttn//lORCcoEIxLm0OEGSl79FV97z7YCct7Ai0GWHjt
 f7rXcFpkSEBuARpgcchzoDoc3XK84PKefmeNOCPb/u7argvWUt+amAyhWR1V5HcupsFV
 siy+q0hB/r8uvrcjLC+OKeKSYRp786eTZ66UKAbFpmr0YL1EDJuEpf/jBfkpIQK+znDr
 ouhQ==
X-Gm-Message-State: APuU4Z9uQLDw/RuYoTutjh/M3IbOHCl0mUioCe0D7hOprJmj0TYP0Lui
 sreLlN+vP2vBHsxBMpbraLutnT3F44jBuU24+qTDQBv9kgAboCToTiDsVaUM6NK7232e+P/LpUO
 Pqzc/2GIChKTMuiU=
X-Gm-Gg: AYBFou0SZxPEi/aLiN+uC7JLbNhW4PccgS63UeqnMgqLviHsnAOVrSQ9c2GonPMewft
 c/fP0D9Tyr51kb3HABgLNQ3ZVAqVH5KizyVNmA2pnRS2uMgV7NvkaEDeFR7Qrd5eXAG1SNw8yXS
 RKBRFAwI3B1jGFuFnQGUMjOOuPaC58DkTpc1peKrj5LjgJ34eufpN3GKZCFboD80fVkj4JFF3Jl
 JgyAwIjWr6PCdyAbM33CsHWUkEcmmbQoxFaEW/99Kd7xv96wbU+Cg71Bef4qhtnNGD0iAetKePm
 yQQmyn3UsQQ/Ep5UkjOmJKLMPnWe3nrGCcIVy8Bi92V4P0GkZRc486aYaCGfHthr8Ml+padgIBL
 U6jU7h6hG4Vt+HzWR71RvG6HlhKlG5bOPzTMIEN23ImQRnzJeZ6wy7Nw+MWQMa0VBk8nB7AP4L4
 aRza410/rS/r+DlFuK10gSJMbrXEqLP8JFdfsb4Io4enq9WwbiPw+YpYm63ALE3UisihsA7DdSg
 x28U1XBIEBpNRf0ZkIcSqYIU/LDjXu9MO9br+NJy9wjml0lZHTn7IYzai1gq8C6+dq6Y0gfAK0D
 AG2Nzoo9z3JZSubTd60fB5M1PTiVK5r7hHSXYi2awKan3AoaFgRopePMNIFUDNzS7XpjGaJsd7o
 i42m/krdMw9LbOBJ1okqsyKe0qC2yXG65bGcWaFWiTQouu1VOb+bk7+VMHKBANexnKP1we84Y0u
 zaunXvCMvWs9okRmHxT4UJxxedJgARJg==
X-Received: by 2002:a05:6830:254c:b0:823:e626:2765 with SMTP id
 46e09a7af769-85f5092c968mr1818371a34.31.1794154439551; 
 Sun, 08 Nov 2026 08:13:59 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85f4fbcef97sm1756500a34.21.2026.11.08.08.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 08:13:59 -0800 (PST)
Date: Sun, 8 Nov 2026 10:13:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Subject: Re: Please pull u-boot-x86
Message-ID: <20261108161357.GJ3741582@bill-the-cat>
References: <CAEUhbmUriwAm2_WHVDEB6mfwH57hzFYbPd-4M6nyUGFqPEHcPg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AvUnpdB1mWPfQ9gr"
Content-Disposition: inline
In-Reply-To: <CAEUhbmUriwAm2_WHVDEB6mfwH57hzFYbPd-4M6nyUGFqPEHcPg@mail.gmail.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--AvUnpdB1mWPfQ9gr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 08, 2026 at 11:53:48PM +0800, Bin Meng wrote:

> Hi Tom,
>=20
> Changes for this release:
> - Read correct TSC frequency using the right cpuid leaf
> - A small cpudid implementation refactor
> - Display actual CPU vendor and device id when booting from coreboot
>=20
> ---
> The following changes since commit 934995f642a21ca7f35fa9aed5f061394fcba2=
43:
>=20
>   Merge tag 'u-boot-imx-main-20261107' of
> https://git.u-boot-project.org/u-boot/custodians/u-boot-imx
> (2026-11-07 12:04:01 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-x86
>=20
> for you to fetch changes up to a7f22b345ab311488b7fbc242e408e97eca4e93c:

b4 shows a mis-match between the hash here and what's in the tree, can
you please re-generate and re-send, thanks.

--=20
Tom

--AvUnpdB1mWPfQ9gr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavCfvAAKCRAr4qD1Cr/k
CrmHAQCvjEevHJeSS+YKly+CoaqAiWtJJg+zFhbRarESKMG6pgEAqkVV8DnLcroI
bVT/PyniNQGGaSRUdWh8xQQ7fdI7nQ0=
=IHZN
-----END PGP SIGNATURE-----

--AvUnpdB1mWPfQ9gr--
