Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E11606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 06:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uFMQD/U9;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=feVCW6zx
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E01C60A75;
	Sat, 24 Oct 2026 06:29:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZR6gXEhspsJ0; Sat, 24 Oct 2026 06:29:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 7105860A48
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792823362;
	b=gKfAcXvyomExP1V04LemwggpnetLupeIcfhJzjIpTxc1wzk6E8JBKGWua/420tzrJnhk
	 959GeBH69hyWITBYeQ29PAQjoukqonHJFjoeTOUGcymj+Q1Kn7zmdD1J7xbPVNfYLfYyo
	 G756N+vycsk8eVlInAuUb5RbxNzTAfGds/sOeWRnDkXF12R1xQBuRy1lQ+0slNy+tMH5Y
	 5V6RM/pyDb/O0tgLsJ/oXE1B64+Py6t4IXnGxKEtqoHBEuwsckyiQDR2j1nm2+RR/PRG/
	 pW2MN3PQvqfMkxxs7kfgXjzf+f+CBH+Q0r/R8GriY9VycbVLv4n/EXDj6+RqaS9xhFg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792823362;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=1Xls1RVPpteLeq0ebqpRGiZwrjemkSUI0ce48EFSeFA=;
	b=oKuEE7reMd4KeYFVJba4O0Z+Dhn5fqxgty+7kil+QQt6RB6nndMuFtQ/WRAhh69DTlTk
	 zsFm+qPYALs1Me/U47UnOTdDdP5PiXP/ycw3+rJ+nAZoAaphm2F1pS5CRLJjrdkRgvoHD
	 Quifb2uFh4J9dmK2q2wOwnpZQ9/b1XCKiNgZFeQ5dtSGyeMhKwKEORqu69hqvDVkv38eT
	 oWNrqWrjdIJ9EJlK2W3IA1F7CipohHQ0eg/e29257PmgwVvAzqfF989k26+jzvToRgymM
	 pkSKZRbEqh6c7Fl1qctoBqRxb0KeANDbUTimeWCYYhdEDv11N5fF8oBletMKnLpgOtQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792823362;
	bh=1Xls1RVPpteLeq0ebqpRGiZwrjemkSUI0ce48EFSeFA=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uFMQD/U9mITD0zarAUNmoVMeg6sxCpJw79yq6mbEZv9tciLn0FEvJ0c6PY6kah2bm
	 soT9a31f4CVLYfbfnoLXPp55zzz3liFqUXKXW7+RESjoh7K14gvBTsrX6oDkc/SSWD
	 KdO6vHSOsW01RAJyiwbEkPaoAQI2XiWbapAmBCT4Aw3P0BYmxxKLrOfhW+RI1wkbDU
	 1A38+VBV5uv2MH5af+e0m2W6a/7vQPxg8uHhTy1HApyAaeN/aYmJeCsW+7ff7lZaPm
	 IHz1l8t1ZnXM0DUPmNiHSzuiUBaXObapBbYouATmKBTkriZOyXk3YJPWywFp/lD3XS
	 HHhZW4DegXR5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7105860A48;
	Sat, 24 Oct 2026 06:29:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 59462765
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:29:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3DC1440A45
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:29:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MZ72O7PqPlBa for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 06:29:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8904440758
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792823359;
 b=BNJOV8Ktwah/fT3xBOaqFKH+BnPl8Bx3TpR0UnUhCTCjzVZK+yXfGqXpRjxqvMqJ9p9Z
 JV96/l7k2tozrvk0nTomSY6F0EMO3bCtG/+9XXW4LD6woPAaUdwoxk0oENbI0K9zyXhPY
 T4Ta1EkBIYod4XpLc1rxrYEXsj+rfQGF6z4nNm7sI12VtK8kEdToXoZDFH+c7RZUz4mS5
 vWyBpmgpbbRdS5EQEHsbcB6hqKvO48EJn7wLi9LnNWjSRo02VCMjZEE0UJOLTW1lFLOD2
 2k3krSNTFqmUfJtVJTB57GTsIYLn7z42NyoAMCsginSkJK3OSKKmCZv1PVd8VOIx1GQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792823359;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=1Xls1RVPpteLeq0ebqpRGiZwrjemkSUI0ce48EFSeFA=;
 b=NSlxo4o3KTvM/XgQe2UPLVv5UrfDo8QfxiKjeg9PWHQMoGKZaL52+1a3Zgv8SjbQ+Q5o
 k42zwEH+AcJrbTOAdFedZuzVAaNLBZuuH9DoL2cHyfJZBT2Dqg+t97uc9Ap8V8JGJwGI6
 qLQ+i/9SFxmVoaXXqklaVvI5BTJ4dt/TChhRko3W15wutITEAhdjX3ZmQv8btN0IzvI9f
 6BhfSI5Es49dQCGLg1z7xxNeDx0enyRlVroc9DzYBQRrKig9mQKSbWR+M7XuLZ+PijP2D
 AyxWjypuoTJNNLvdj+IshmfnMyiS5h4aN/qZyhw/bAZrU4un68MExgaLxOnz1Wfl7eQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=feVCW6zx; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::102f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=feVCW6zx
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8904440758
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 06:29:19 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3ac451e128cso1110600a91.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 23:29:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792823358; cv=none;
 d=google.com; s=arc-20260327;
 b=XD28iGBlQmCooq9tyT7tG0iZ8Xdj6heGUcWb2i02SzTCEedgpXdOB4U2XJ4/ZUglO0
 IdabbcVrcAt6lHymGnLAmzxldpiKpUg5P699XAXD37alz9ygt+KHjEg99dO74ZVl/B6w
 671axXUX3lNcr96A3BmXDeEHQnM7FlVMEPHWgQ7jvL5hK8nkQQzJvKXV9cxiNPq0FrL4
 UlMadUtRZTo9ogpYtsSpThgDS2928EUWIVp7gOevoSNK+p1B699aA7r/fAQusoQkJL4y
 3Z70c+gWhMkWuBvZo+nsu2DWtLMVDrEqA1ntApWKcZ7kZyKlKjVddrAlaz9S2Id1+lZq
 emqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=1Xls1RVPpteLeq0ebqpRGiZwrjemkSUI0ce48EFSeFA=;
 fh=sqFYa5HhsXMHk6lK1uJ95N3qZeoUfXxEDP8vyXdmNZo=;
 b=LFhlzC8bvdhJ5wYHgtDeanMP5YpKYFbkUEM8avOz9+lSdnjdZlY9EIFiPrnAA465bk
 7u/6bxbWtcpqmo7gsrc0QzRChRjiiVqrxoWbG/0+7uYdrKcFfjb0kcoFY16Kk5tx/ccs
 PwdayrvSfXoSSk/R3YIOHDX+P0rNSjrVSTHtXFXfZ5oOOlSik5tbhs0+A6pt1pzUCWAE
 Q9mbZttAVWMXuKbFQXyYAmIsHlcwAnB6tRGEUA061045zhSBoAIDWJNfuaE4fZfbFxYd
 pRLnOwoL9DCOK53VjcMA41g+ykpREOO0+ppD9upoOgYtq3y2H4BpCNxqnB+P0NXXBTAz
 f63g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792823358; x=1793428158;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1Xls1RVPpteLeq0ebqpRGiZwrjemkSUI0ce48EFSeFA=;
 b=feVCW6zxjqHuJaP9FJzWyegK+Lw1LKAidckkkAtGcWwnX4FrvlBa62nylXOwEFc27Y
 X8AEGDfCnweBu5K9N9fcQ53bdqgJpf+H/71GvebIQVg+vip5HiAa1dLixu+XF+2X0Sn5
 xUsXR/+9ZHtRe7mh5Thkb0d1NS8/wR/plSN7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792823358; x=1793428158;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1Xls1RVPpteLeq0ebqpRGiZwrjemkSUI0ce48EFSeFA=;
 b=sQeygktcgTs1yQYp0J3xFCNTcgWcmeFuEu9r+ny/svlnXsbMjENxViEMqvh5uMIo1S
 GWxpSCuSguNMO5WVU23H1YM5PEd0wcIVRzF+AfaYvef2GHkRO/xANX2UVLUzjx2n7ISa
 eElJ6Q4ACRGITA7fVFFg0W6D63tlcSOgtzS7bt9B9Y8P4MUBrxSSIqG68xiejd99y27r
 p+pL3qJ9t1pQR0M8567pltJtOrIi38+TXlyXmFKyI0ZxXSMSTinoiY9AgP4LCr2uukrz
 zqH9Y3GX2JJhPc+MvYCXp8gBGEiL8X0Td/fxP/aHDdjkM/nWkW8qyyEC1tcRnB89oPe+
 2gNw==
X-Gm-Message-State: AFq9FYIQXEWk8TqPE4DVoKQTgmBla012VDZRwmRb/Vw6FBb2qDtev8E2
 7/zNHHAtwWRAL6SPbqs9a4/mx2EVER/MbzC/budy4zWBK/K8Hk5AJ35bprXNZb6JoUaCf8n0m43
 RG8Xn6crf2IoBX5iY7zITpkEOlAA13tfcrKGNnC7O
X-Gm-Gg: AYBFou02fVau45tM0ZzoBKGywy4x83VgZnSO0CW1K5Wtet6mQSBfk8nbYNjQhVuzPQK
 vLdPAAyYwSfN/x9u7AnHhnTOoOwy6oR7/GoXkhbzShGbplrEEA7a9ynlJT3JkWBLUQWeXZumVce
 gA5Wsn8A3+D2qWfnH7FRtA4e1TvYCseB2RrXPok6dHV63X2J8gO0UVaZLp17ec+9ec/jnNN0Kn+
 KonQCmG7m8k/mJbHv1vhI/EIl08DERDl5vg+kDHL2lccvAU09N07dA1/YtrUn42oLwKzMN4mMvL
 HDQyXZrI4Be5ZLZaCUfTcVe070a48FtLsp/0W5hdzlFCincjGd8I9meuCzeO8vArwZSmdgkykzh
 RovQ91v9a71WiiTWOcagK9K9AdHEeMpQUJRA=
X-Received: by 2002:a17:90b:164a:b0:3a4:ba6b:cc24 with SMTP id
 98e67ed59e1d1-3adeb137823mr1005494a91.58.1792823358476; Fri, 23 Oct 2026
 23:29:18 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 23:29:12 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 13:56:31 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b710a08f-e050-4543-8c5c-291d73d56050@gmail.com>
References: <2646c589-e23d-460b-92d6-cab299fc4f56@gmail.com>
 <b710a08f-e050-4543-8c5c-291d73d56050@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 23:29:12 -0700
X-Gm-Features: AclHuK88vz8X9j9OSX8iqlaW_vx3S6XOoez8xYv3o7VxS8__tVf0tmGGd1In2lI
Message-ID: <CAFLszTi2aQEjsNWU7zr7vRjnrbJLB4_fFd8OCnFHgCQ7CQ=gGw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] test: vboot: cover required image keys
To: anon87111@gmail.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, sjg@chromium.org, 
 0xiviel@gmail.com, me@ziyao.cc
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
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 2026-10-22T18:38:39, anon87111 <anon87111@gmail.com> wrote:
> test: vboot: cover required image keys
>
> Add a test for two keys marked required = "image" where the FIT carries a
> signature from only one of them. Without the binding fix the single
> signature satisfies both required keys and the image boots.
>
> The default policy refuses it, required-mode "any" accepts it, and
> required-mode "all" refuses it again.
>
> All nine in tree sign-images-*.its hint "dev", and mkimage -g does not
> redirect a hint the node already carries, so a prod hinted fixture is
> needed to get two keys marked required on the image gate.
> sign-images-sha256-rsa2048-prod.its is the in tree
> sign-images-sha256-rsa2048.its with its two key-name-hint values changed.
>
> Signed-off-by: anon87111 <anon87111@gmail.com>
>
>  test/py/tests/test_vboot.py                        | 98 +++++++++++++++++-----
>  .../vboot/sign-images-sha256-rsa2048-prod.its      | 42 ++++++++++
>  2 files changed, 117 insertions(+), 23 deletions(-)

> diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
> @@ -477,6 +478,55 @@ def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
> +        # Both keys are now marked required = "image" and the FIT has no prod
> +        # signature. The default policy is "all", so this must be refused.
> +        run_bootm(sha_algo, 'required image key', '', False)

With an empty expect_string this only checks that the image does not
boot, so it would also pass if bootm failed for some unrelated reason.
Since this is the regression test for patch 1, please can you check
for the message showing that the prod key failed, e.g. "Failed to
verify required signature 'key-prod'"? Please do the same in the final
'all' case.

> diff --git a/test/py/tests/vboot/sign-images-sha256-rsa2048-prod.its b/test/py/tests/vboot/sign-images-sha256-rsa2048-prod.its
> @@ -0,0 +1,42 @@
> +			signature {
> +				algo = "sha256,rsa2048";
> +				key-name-hint = "prod";
> +			};

This is a copy of sign-images-sha256-rsa2048.its with only the two
hints changed. Instead, you could build the FIT from the existing .its
and run 'fdtput -t s <fit> /images/kernel/signature key-name-hint
prod' (and the same for fdt-1) before sign_fit(), since mkimage -F
re-signs an existing FIT. The test already uses fdtput on the FIT
elsewhere, and this avoids the duplicate fixture. What do you think?

Regards,
Simon
