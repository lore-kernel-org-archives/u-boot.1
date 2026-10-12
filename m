Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B517ECA9ED2
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 20:41:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5F41340553;
	Mon, 12 Oct 2026 20:41:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EEZEO1wR2Ezb; Mon, 12 Oct 2026 20:41:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4E2FD40512
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791837717;
	b=EqVPdP5lu6+XCQjhjg+P5YjwNBjtLjSfst6hnqm/k4V2JcK2188RFT6F4Odwu1XTtxjy
	 HisBpdORsj36WiU8sWqYzaa1qZIKcfKzWtYx7MeGE7NXfI+Qcg1aiQi6mGVqbGLeIw/TA
	 INRWki2j0Y4bsPff1dzR/y2oEtI7R6nz+NRQwgPCEy/U3Z/XLVHZVTfT9P/yeUDvvmP6h
	 IEGxWZnfYWmx5W//cotEUJJiGAWalYkYNXvpYHr/OdXr4h7RBKkUNvgjpzX+hnvpDtDE1
	 BFaEWZ35C7/XrFkFlQ2dPVhCRgMyq8civn9q+NWMu/8iIhuKYWhGH4AKXHvUrss90Jg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791837717;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rT8bHc/9xKvmK921p9tqLxUvTMUey74jyVcvy4RPal4=;
	b=FPiMSKjNAP9kEz4p11Yp68tzJh62WqFxswMlj++Z/9IP9W7qREmrVwFqEvldfp49MK24
	 EjaTxvD7ST4siBB17Q1dyNwOPGjz7KCL/H3BKjq28QsrTnHOqF/RZBU79baiYlO7UhIMM
	 Zy1dmzCNr3dJGlohgSwrzirMYu1rgKfbNMF26k6qFTnO5ubYVD0wyUNE4H8gVEEllE5sV
	 x0sisx9DNnvXAVNJpcxgrtIkEA6GjqALOjsms7lQmH/MJu33B3svfhtgzIFM3a3LJlIWQ
	 WDiixIF4sv8pXepbrgA1YgkvxfB8XH3FgH5XW4sWKQ+gZ4OZUPtT8WmgXsxZXEaObtA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AYrULLPO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791837717;
	bh=rT8bHc/9xKvmK921p9tqLxUvTMUey74jyVcvy4RPal4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EoUr/SuTg3AYU664zUfpOctUQx/5DxyB7YaZCXoc741ynh3Ocgtx9nyWBgUxhD0JS
	 fXyYY0nN5xr1Ux7gVkkzw6k0UqBVG2h+n+a/hb0zzzks4LU+MtMi46glDRraCutjlU
	 Gbuls7yquFTQXaKkfSdZZUn8E3Lyxp1GfZOpMHbMUNOAY+O8sDqrPMdPETr90s3P1T
	 3uaj70XqGop7qH6gothHTwxKTO77FrWR/XFyXCV0MYJm74IQtV26XnqT37QvNI95gJ
	 rWjqAIbeilLsrP90RjURawuZn+89wZ9Tj6xki8LXPD2IZXmgxFQ99tK07Q7vjipmCj
	 mR/MpqHqQYyJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E2FD40512;
	Mon, 12 Oct 2026 20:41:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 33AD92E0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:41:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3153740541
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:41:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oAQ-S5O29_eU for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 20:41:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2EB354053F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::a33"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791837715;
 b=EgYB8tt8hAyE9wKpVm3JBBEla13ThLlBFDnnIjVK9axl1wevo0Ud/2x+iRZ5+9pku9YA
 NNJHVS/grnZC7PoQrBwlbASQjUX5/oY0T8C/JgCjt543+Z3zFuZRGu8Fs9dUky5mxCkQl
 AH2UDxiZTEA+U49Dnu8v6wvdULxNus5RyvJSO2yOjGQyvs4E7tv97hrIsNh+o3jHq3tWZ
 euSPNFVSmXYdU6lBSpFjll5U5867Ci4MYNvaZslI1vT3aJHcOWellsoHmYr/kHExRsa2C
 R6lOawd1wSWiQb3tbY+GNMPM9IvsxW6C0sHzkGvEcWDjzK6rpQ7NE85eq3z2YmBTnzQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791837715;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
 bh=rT8bHc/9xKvmK921p9tqLxUvTMUey74jyVcvy4RPal4=;
 b=FYHuI5Ws9zx6ifD+bvg0lpS33s4tuO1TI+wNO80SZcEgJT0JW+/oGTrnWg6AOz/5jlFo
 FPqduIhPVWIMdPiwHFr0o9AEVEJLnACT0tKj9XDtdbvlscTaSyP/DMb6hp/ukQgyvLOpq
 XyU4q/+gPDFQ2fmcXZ1zYMycV4wAInZpOORLHq7Pz6f0+phWg92vLh2sDkCPJA/K9WdZE
 XkaiWUE8lPyq33p282GeAzXVXPDLXtE8QbPCXfeBz/68IRqSqZseN5e/P2dzZacJhtmZK
 DmFzZOgGo4/ndu5nRshw6ljHZfr0qW2DqJ+zO2Wx8qILBtF1EuyYE034fxqqDkZpzMQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=AYrULLPO; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::a33"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a33; helo=mail-vk1-xa33.google.com;
 envelope-from=james.hilliard1@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=AYrULLPO
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com
 [IPv6:2607:f8b0:4864:20::a33])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2EB354053F
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:41:54 +0000 (UTC)
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-5e95b036302so205049e0c.0
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 13:41:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791837713; cv=none;
 d=google.com; s=arc-20260327;
 b=e1Zwjr9a+Nn/Ywg+bg0Kmzj5W7KS8JKAbAkDD36LQpRGDgRtvcByBjeovX51QIN+IP
 Q4JUKG9c+hGuZqCE0052Y8P+oVW5YDvBU4vsirvvmIhl9mH4Isp1CBStdTvOvWva9Dwj
 jet1/wE7NsoHavQVAlwp4Ztvexxl2x2B7UnzT7JfMKa/VyYvHLAJQ/qpu6Wl7oYUrJlq
 9mqXk8YOf7v/QL2QLaQeBbY5qcEP2dx9JXEDM0tDXvhKkv9VvyLfaALr5hKMayu5UiqO
 ySZcLwFNkFP58CVWgWsZrnf/W1OQE2zTMWmkHr4aUV6CXtnZpRNO8RWGjvWTJ6CZMv/J
 UMWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rT8bHc/9xKvmK921p9tqLxUvTMUey74jyVcvy4RPal4=;
 fh=/NPyRc6tn+aqeTkx1apqNr4/K8yO+QuAkhZjRZ1oA7g=;
 b=oJ4vDvGp/etUnJBvLhfmU3bUL5h3Zd9q+AUIGWTJOK3jANAbKsLl6c40o2a3OmEJvX
 h6iugZtUPbUoAGgUvoNSU5Jyg8tNz45qWaecvEgKiyw9Z9w1aH3mj+O0g978nZjCCPkz
 +O9TcnGQSKddYhvpG9PF/5DVovvZ/8JxWUn6f0tmGMOkVAxZPwmyRUAwUw/B8nrDXpSQ
 pgts5O8y8YON6IE2VwoxwXxX8SXnvLU+0yVWor35LmNFoS/KIuZD/byBufkPvY89Qg2p
 cd9JpjulN5SvQj8pFUxBtVfk/SGkqzeJ3m8nO96b/juMyHwc4G5519rNEVgbyoeOOeDE
 enQw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791837713; x=1792442513;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rT8bHc/9xKvmK921p9tqLxUvTMUey74jyVcvy4RPal4=;
 b=AYrULLPOoUsg98bBoS3JehG/pLbpvTuwPkVZRB+lG2KeKUdSorcmgjGkb6v8V9E+U3
 y44I8Z45Td4nCXc/Gn4UTOEFvcFE0tUQp4PpGacJ+OiYj/YJsV2C5dh3MaELx7k5lsdd
 SkUp5Tb37Vu3sj9ONBlvvunkU5mX6QgZn3crzDQCuxrmSrFjCBRbnzBiQbkA0/Ovo3ZR
 9RyPmisEwM5VaX0rfIOxHQJRXDnQWub3suFXFg224q7/tMXCnugqvh07VsgTP48E+fR4
 8m2kMr73OejsWsjzdpIuzXsBaJBcR1QJsOpHWJmEKfpTEDJfnN86AoPXksyMmqh9CZgC
 SCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791837713; x=1792442513;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rT8bHc/9xKvmK921p9tqLxUvTMUey74jyVcvy4RPal4=;
 b=ngRg79cyPdkW6XlW6UM3CjYdiDthhhowCZiFph0rLZKbxHf8ZDwWeg1t0pEDaopBlK
 BuIvUQj07AkdrCYPyDiZocnmfJ7v+bZCbVritF2QcafwODArgPnTYL8iZQJjamxt2wkk
 pc6SQ0rMXIuvFELVWr/5CJB4RDKkAXu7OIvX5TN6xc2+rwwXzCmBRb0/iFOMjXHq2G+h
 48wR6/BWGLXYITmtdTS+FqbOnDBxDwicwCltEImq5Xc7SWYVPVeWQevrHzBVzAXHSq0m
 wiA+o9d51yvYvnHYMfny5BciABq2Qi+bSXBSxbbeNAh8r9IUkvsxrBqKupkMjmIV5Jss
 7G4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKM4q3k7nmwAJqg7Dtr32BJCw75AhdNmRfsriqBewkaGuVnc9pGD+dp/fA+c9ceqazyLFdxic=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKJk5hS5sfCLj5Wb3W0tBX7k6Q/P5WOLNNvz1To+xOE49C8uFvN
 kHRUmL3vx91niTvDIm6IHLu5FcvgCoLT1UECEuDEd0KT5MwRbqRyV2iWIq4DlCBvx82hCJlHJgY
 a/4k3ZFtjiv1XQuBzeCj7JeT8WwJKtJKlxz3b
X-Gm-Gg: AYBFou2BSHdQTuYBPKzuqSRFficnzQS/PKOEYxaG2UOROAD9iic+9eIJ1MqI71/Lo3z
 J0myYlE8wmicxbDWV1Dv0ycsPiSIwyJ1JsPWBqvP5G4a1k83VI0jb9HvmMKoBKmDhO6AuAaZvn5
 ioRPEoCWuYlMrCfCv2MGsPG+fzU4zz8FRo8MpF/arM+WR6Z6An5Q89PYhNjJbMAQYsk3S9xzw/m
 4aGb45nkZKYBRAIiw+hSd+5OwztEVOUmBegMUOwW+O7/WkYCM1glVfmrA/OjS1bOUpjswuI6DyW
 H4H+5kcHTIEckiQ1dtMRMMGMBeJtlVPsT+UP+od+tCbf4qvk2Fw9YgFyws9Y12MAtxJ0paoGwFS
 GUDGDNJIFXGixXd1SZA9EJEu6cxtGguM7tTIAIaYHduGEwCX+PLOwoJMiu+a6//bB/Fneqq06hi
 Nk9QVUfuHe83X16FOM2ZT8NIzJwCrPpB0Z9OeJgJlfZ7Gkdw==
X-Received: by 2002:a05:6122:6b17:b0:5e8:4f3c:bff4 with SMTP id
 71dfb90a1353d-5e91e38f2d7mr2492223e0c.2.1791837713408; Mon, 12 Oct 2026
 13:41:53 -0700 (PDT)
MIME-Version: 1.0
References: <e38b2ce1-a74b-4266-8d34-8a8eeb9981c6@arm.com>
 <20261012200814.GA3799261@bill-the-cat>
In-Reply-To: <20261012200814.GA3799261@bill-the-cat>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 12 Oct 2026 14:41:42 -0600
X-Gm-Features: AclHuK_gAa0CmL_Ky14nUoMerWr72G-N-9cSKnPoC8F3wW3TAQpXTy4sCFZcN9Y
Message-ID: <CADvTj4pfFC6JOSwK1AUEQwZ9=6niGAx13e5fiP09L6hbey4rzw@mail.gmail.com>
Subject: Re: Please pull net-next-20261009 [corrected]
To: Tom Rini <trini@konsulko.com>
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On Mon, Oct 12, 2026 at 2:08=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Mon, Oct 12, 2026 at 09:47:05AM +0200, Jerome Forissier wrote:
>
> > Hi Tom,
> >
> > The following changes since commit ed869863c7e2aca50d57a05d843830dd8431=
38c4:
> >
> >   Merge tag 'u-boot-marvell-next-20261005' of https://git.u-boot-projec=
t.org/u-boot/custodians/u-boot-marvell into next (2026-10-05 10:40:38 -0600=
)
> >
> > are available in the Git repository at:
> >
> >   https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git/ tags=
/net-next-20261009
> >
> > for you to fetch changes up to 28ddd369e2f7199539cdefe22ce014c592b890bd=
:
> >
> >   net: dwc_eth_qos: spacemit: add support for K3 SoC (2026-10-09 18:58:=
10 +0200)
> >
> > *** Please note ***
> >
> > Commit "qemu-xtensa: Increase the U-Boot memory reservation" fixes a bu=
ild
> > error detected by CI that would otherwise be caused by "net: e1000: use=
 all
> > RX descriptors". I did NOT send that one out for review to avoid delayi=
ng
> > this pull request, but if you'd like me to do otherwise just let me kno=
w.
> >
> > Similarly, the test added by "test: net: cover lwIP DHCP autoload hando=
ff"
> > initally failed CI and I incorporated my own fix (see the commit
> > description).
> >
> > ----------------------------------------------------------------
> > Pull request net-next 20261009.
>
> Now that I've fixed the sage lab in CI[1] I've found a run-time failure.
>
> [snip]
> > James Hilliard (20):
> [snip]
> >       net: lwip: finish DHCP before starting autoload
>
> Fails on BeagleBone Black with lwIP enabled, none of the network tests
> run and the log output is:
> =3D> setenv autoload no
> =3D> dhcp
> link up on port 0, speed 100, full duplex
> =3D>
> and we never get an IP and so can't network.

I think this should fix it:
https://lore.kernel.org/all/20261012-submit-cpsw-rx-eagain-v1-v1-1-0fbdc975=
1568@gmail.com/

> [1]: I still owe documenting better, but you can either git push .. '-o
> ci.variable=3D"SAGE_LAB=3D1"' or add pushOption =3D ci.variable=3D"SAGE_L=
AB=3D1"
> under [push] in .git/config
>
> --
> Tom
