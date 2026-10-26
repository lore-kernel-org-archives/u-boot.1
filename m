Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CF7606A31D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zh1XRlaw;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wQ0NNNgq
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3B6880DC8;
	Mon, 26 Oct 2026 14:29:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vVAI1HkZgCiQ; Mon, 26 Oct 2026 14:29:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E849C80E14
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793024992;
	b=Z2Kwxjs18fpjjDvPH3bDZMrAAh9mZpbo5vtAoVnXoR1Hsiz1qcph8cqLD16eFrWzmneW
	 jFC8di+H1tYS8KL74ZpM9iMTRAUjrBpfQxSYceqI4MAXa3quGw59oOh0NGLbSi1jrHPLN
	 vvAMWh/QcMawWy2lcuJNs5BNbcOvKnJ2J8tpF1ykNucbt/4Dcq/QL6QNTxoblvNO/gWLp
	 KpPVEcvk72BuhPklBrsTdTkQ/41OJU6mutwTOAP5Uf1KoVtFhjnurGD5ewgH/X1K4Nu/x
	 CJL3tyj05yFW8BaCl7yE2AsqgO/7Klyvs8tqxiPz2E7cm4tU19mdUvhmEm5a36xgyAQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793024992;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lFU5aVyyGQrJZqQFbKIvI/FqQM6WK3sMPFndyzubJ3g=;
	b=KOLCAm8P3DeR6oDpr2Rn1duZK9b4Gr4Olixj1Yri7RkmRQYrZFw01QHfRFWyCYnhSANQ
	 ctWes5j8w5JdO0hLHVMPrw0Kid82FBcreS+5A9E+vRrv/pPOOVZ0Vr3g9VFMmcj6dykx0
	 3fsFTsJfEyvX69Sge8OEYB/+ELySpiS+xD4+qy8bwYrTrB9sps/ti+i+SwTY/ZH8CRjt1
	 uk6b+uKeoL6LfXCOT6zPkmZ6o8LJihiUXcJODdPcau4EZbSt6XyuYCn3EH4hwk9y18iDE
	 kX2k+u55tdQwcc3sMNRzlp+GKvRPv+0xtLhOVmmdE9F67dyeX4RIwg94A9gR6kUi9eQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793024992;
	bh=lFU5aVyyGQrJZqQFbKIvI/FqQM6WK3sMPFndyzubJ3g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zh1XRlawh3kEX0ZML69Cp2vqQtMW+JP/jedPPb74GEL/ohse03NjbXPdHh+YnYSCr
	 wmEP+7N+UQzYZW96DBmq/rwwaYbZM0IvjRxw2fgJkcoyXFD7AcprGL8Qqp6qaP4P97
	 ix4UrD2NnorPW2tKxmyF9LOaWVAikpaoxnx3nP+mOxHEabW5Uc/AMdNvMZIF4riEG/
	 ODe2K2vrMMoX/4GmmISBY96vIpr7vksISM3mKGPLpPaCySS4Z1AQgnhkj4OvaLIyDW
	 eulQEfwtj57xa6+HJsvRjnTIGGK/rH9sK5PTkF/1cssYN7CjHpGvdsDoLSZf3OzU+L
	 iaI2f2sUmm94Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E849C80E14;
	Mon, 26 Oct 2026 14:29:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8BA623D9
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:29:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7AE5A40660
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:29:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6vD0hZgsCZOT for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 14:29:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 44DFE40653
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1133"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793024989;
 b=jqWXkZwtL/EZ+5GjQXm4UfnPqzkAoh7jwJwxLzJPyihE96mEemOHJQa64hxO+ODyFXZ/
 N/40gDaUlcmxIXruvPJe0mLh6gYNkuomhqTx7f4mpuA0+O3aD5AZezQJoPXT1TrlRV8fM
 lrgL1ncSocPSfB30iLNpc5RUQ8m1ZLN1pvSk0psVzgjX3sYq30XJ1PSncv8R5ze+jnXla
 S+7qtTRM1CYpRZuNdstZGhwxjC4p6tWDp75Li12c6Dp7G/gBLTbTJVdHvfRqpd6Cijafg
 dLGsO4RcXiKSuWN59akqB58j2EKqknoZevL4KDKsCWcQ6JCLX434gaCDs883fWOTOIg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793024989;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=lFU5aVyyGQrJZqQFbKIvI/FqQM6WK3sMPFndyzubJ3g=;
 b=dpvH/gz7KkNaIO85DFFXfutA73tf3TP7pR1QwZ6EXOtsS80lzYCiJUuMLyLSBgPkrGCf
 gr+X7uFOKvUPE8fBo+GPQDNiNr3sStcLS+WRUgjp1IjZqEWN4USnzqadmUSVdtaG50i18
 lWrHq1UNr2itbtATLgxmyl7aXA/tl0oQQklPpK+9cEzF7dpmnD67+qXL0x7BYe2RMmqf3
 WUChpH+UmwFG61FBRhQg6zUvmQPePUrDhkFGHCeHhkComw5ZWYoh9/wNE/k62hlcj7YEB
 wkkwrxQvhyiH7dJWrErzSZyA6AVY+lz1b4IHaJR+KUb7smwnqWwaL1Akgz24D4R5SEQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=wQ0NNNgq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1133"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1133; helo=mail-yw1-x1133.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=wQ0NNNgq
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 44DFE40653
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 14:29:47 +0000 (UTC)
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8b056d58f2aso26562317b3.2
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 07:29:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793024987; cv=none;
 d=google.com; s=arc-20260327;
 b=I/ZzankBN/woc6CKiJwndTj3ZvIUda/h7HcsoTTgRgh9l6yoRAhm2IICYZLCqaJ7tV
 51+4YnDUY07NYTOVX/pX53gtkGOjniMTJx5MkGcpMFd4zK3wnSBLIq/SzaMBzmIvGJKb
 IGTwSwHtoB/Oh8neRpUK4V5Zrvpm9ODGf29+gYbG2/CBPmk3oautuwvTwJbPjBf3j+eZ
 Z4Lng7Z7NfYn0PbVcRMyfYssOTjG0hRG27IPw3cuCRez2NBSAulXvJX5bPYjWOq9e6jG
 s9XvC/Q2RII87r0/SJwXdNPM2R96fa6jniLIr4PoW726etaBBYKc+61CXN5EOj78qWwA
 LMgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lFU5aVyyGQrJZqQFbKIvI/FqQM6WK3sMPFndyzubJ3g=;
 fh=OhOSfS6mWstEu/irkSxD71iDNWnMeRBAfsy0D3wuTYI=;
 b=UTgn5mXJM7MP4K3uTILNf7EUPpBgfYkxHmunaXaKqzWevy4Jse75wirX5ubx9e2apC
 zwH+O39RKtIptScF0JGk7yqGnRXezZ8pSoqedCilLOoyk3/D7NXZgmXnl3SZPwIDtqDS
 D89hPgbWvEUxWgLi01TjH08jHtPNKY1KUqYnLDw2JFvYBtIDJJacpAmcTjv2OrW8D8YK
 RPxK2m6iFZ6pWq/FWjD3+GRtvvi5X/Q0U+gXxdN7uyRELHB/FzFfSeMz0VR34bFzir6L
 74PyPPJjDAxZC8CtVCN2ndwRiWYo5fXttaRhuKzqAehdAaZQgqYhfMDBiRAixmHi1ncz
 6JHg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793024987; x=1793629787;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lFU5aVyyGQrJZqQFbKIvI/FqQM6WK3sMPFndyzubJ3g=;
 b=wQ0NNNgqpBVQWlNVqBMjhUh/4yuw8FmiBO7nb3lwz6tOK6nTn3AtocdCeimfzAsT6m
 S11pod+M/ejR7M5G3kjdgRWMZfRQb/GBh3i+5iJ4BmCgAn88UvDOQbox0Ihhf7Wqw4ES
 2vcJwXirmrXFJw+AV3CtZGhWk+89LJDtEOMNy1d0b+/5bWmGIqTaM5YjEpzXL9DgWLz3
 Xj68YKyA6TJZ2mwsMTtHu/cW1xUDBasILCYTPXzQmMSd1iTeaf13x8enVXR+ZZvuIzAL
 0Spx9jUnuOQXKqLObgSL1XXFnfaOK2xf1HavgmuwcLc2fcbtWPqBRPSws0BUjVaGPCnU
 mcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793024987; x=1793629787;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lFU5aVyyGQrJZqQFbKIvI/FqQM6WK3sMPFndyzubJ3g=;
 b=MmoJc0n8+hshWZCMFCkNzbnNgJAC65HIVGMQXl8Cvjhu29T/IBHtVSJbNE0A+sOznk
 A5TUQypduX8K6vrwT3S2cICe5DpsDSHTHZfr/5Aih+K14FVbFhc20O1ZCWKtB+Q5W6OR
 9Dcuq99TQWOz0+2LyNqBJ52VdIyr8ZLX1mlWqvtcmo02Xi/m6ZbIm641k4x+S/uhoCvY
 EWJ6PR6I11E11LOzrGK9b1iVly33+NVRXE8mb1NIJZQUvJD3G5RvKK0Tt08O68obs9lc
 U6D7qU6U7cPSUHooy5gtYz86no0E57+E+1w4E3IR/8GomD3+D3KrUE69eyQ0gG0XJX13
 G5Lw==
X-Gm-Message-State: AFq9FYI4TH4xoUfC/JuRAsELU71qsdW8HW0Fa5BvtaUROooz99Ah/j9j
 N1k9PzqHLuJuzDgpng0c34POKJWbfdipQ4fliKIuzNIDJiNySL58dwLT8KzN8w+fC+agQfzK1dT
 HK8GW18cnTWV7CfKM9PeFSC3QVPCpn42ij/xwPW/kgA==
X-Gm-Gg: AYBFou3Fd4SoDmQIouVgRwcyHBKELFbGU4ZnmlEL0DuzIE7bzF9Gxbl3y84igHKcccf
 p8PUHTknZebhOTb/qvNDub2BA69qsJ6V6L3GYOGI0qFIEIY2znw0KhZHYT+ACA0IrLj2lWeBcNk
 14miJQYak84R9hm+2o/XkZm8I5jUBuuHCt7FDlM6jMz/COmNpzkysw0Bca+4JuEc3zG6FntXcfc
 1tr5qfpzR68LNexxFiLut3zC66wrJy1e4t3OzFWOHZsFOF7PI5CwcdXGuI0mdtrsRVOk5nF+w70
 9GriYXUIcQNmcq7TWSESRizvJwV+3UZf8Y1wQtEU0JtKj8pr6kKzke5hAZCjsnikBuFvJW7PmLy
 G2uOppT1+cqPb/kOMEIY3TQHxNizaLFrpNxptgckph6Pkjyt51cwajru+lBWlkiUi46t3pspNEU
 1z4mm377ViImtlJWAOIji27d1RG8L2NXSodgI9mD0FEK4a3SBODGhwaE2UP1no8plWotQZMg8c8
 8VvxwCikRCi29sMmqIWKoxVSJCShy/Z5N1+n7SYDbtxzL1bGkXKfF4izAkjiL7aEqCqb9wqpzL7
 j/CmdBFM74rQavBHoaQ+Zn49rqUYxZxNSVkh5KN79U48JPBogWDEJowPc76DA1MgsBr1Pj2RF5v
 nsO2P3LcxtGZXTzpTSo4DSGHsShg62v3FTzw9ngffdXt8llVYJZKT2jNCf7yiwkOTFZ65LnhPyh
 NQ2eoNv9qYny4HGejZDJ7KUQhMbK3w4RFwy3g=
X-Received: by 2002:a05:690c:ec6:b0:8b0:cd30:ce86 with SMTP id
 00721157ae682-8b166c683femr42702177b3.78.1793024986510; Mon, 26 Oct 2026
 07:29:46 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <f58ee8d2-b69f-48a5-99f5-a1bbcd3a920b@gmail.com>
 <e8c55302-bca0-412a-b4a8-b51e8f44f642@gmail.com>
In-Reply-To: <e8c55302-bca0-412a-b4a8-b51e8f44f642@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 Oct 2026 16:29:10 +0200
X-Gm-Features: AclHuK-10RvhgQZhYgwQmBxAFVZyINdRdFoNLL5QHr-uJfz79MhyLDw2wxhx7HM
Message-ID: <CAC_iWjL7_oBgQYy6Bv+yW1woYYK-GT5-Va0kmzXYwapUbcDgxg@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/6] efi_loader: capsule: check the size of a
 capsule file
To: Ana Bobillo <anabobillo3@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 at 15:19, Ana Bobillo <anabobillo3@gmail.com> wrote:
>
> From: Ana Bobillo <anabobillo3@gmail.com>
>
> efi_capsule_read_file() compares the size of the capsule file with the
> capsule_image_size field of its header, but does not check that the
> file holds a whole header first. A capsule file shorter than struct
> efi_capsule_header makes it read past the end of the buffer it
> allocated for the file.
>
> Reject a capsule file shorter than its header.
>
> Fixes: c74cd8bd08d1 ("efi_loader: capsule: add capsule_on_disk support")
> Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  lib/efi_loader/efi_capsule.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
> index a77810fa15c..54c118736cf 100644
> --- a/lib/efi_loader/efi_capsule.c
> +++ b/lib/efi_loader/efi_capsule.c
> @@ -1190,7 +1190,7 @@ static efi_status_t efi_capsule_read_file(const u16 *filename,
>         /* fetch data */
>         ret = EFI_CALL((*fh->read)(fh, &size, buf));
>         if (ret == EFI_SUCCESS) {
> -               if (size >= buf->capsule_image_size) {
> +               if (size >= sizeof(*buf) && size >= buf->capsule_image_size) {
>                         *capsule = buf;
>                 } else {
>                         free(buf);
