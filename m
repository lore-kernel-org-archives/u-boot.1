Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A15BCA9EC9
	for <u-boot@archiver.kernel.org>; Sun, 11 Oct 2026 05:19:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18BE781086;
	Sun, 11 Oct 2026 05:19:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eZcwC3AXgfLy; Sun, 11 Oct 2026 05:19:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1CA9E8106A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791695949;
	b=KLFmJYWq7vsfed9DqgY5Sn0qSlCSzzvp2zNEczt3UbeqpgzxCuY9ixIIfvlrou+WCxVU
	 eurgchZj3g3H/DckU/64/pnJPK9OMqt5LU7+NdJQ06HLSbzbkZZYvekldeV3OfDoWObvk
	 C7tpUb5wataJ4ZkQRYOYrRgWJtUSB2Wua4IT2WjmmMVgMvgeUy/iGlSEjW1oNy+BURHsu
	 Pze8bfUsg8W8tm3+6LMpwVhVA1I2f4FyXbianowYZb2egHbxWchVqOpkpSs9VSxJEVKdG
	 yWSw6fhnltn9AVh+4s4lq+SIp+1HneIR77t9BCoiSFq35n/EI7HduAS/clkveqexJ5A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791695949;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=tddjwPqW6/Kw9R/l3HwF+SmyatofM/g71d0/hvNDDUU=;
	b=X5pqbAs4CFXjJFcp6zUG449x81mSvGA1wiPCktr8plcmLQAg1/YtBJo/1eSVt/snPwY6
	 UYfrllOwz/FIKRc6KrqS2MnSDd23jCo15aD4nRMk6BfO4CHlu7ZLk+w/H6uePYPHiusmW
	 ba9FuvrXtUyPFD69N9OYuiQ/lKfIVO689yySz6zxKuxVACw/+37TOSGILaMbluT6jsGxZ
	 SPGa63T37rrkyQJQOEsoHPVsMSCu2mVrVH6s4V/J5GgyYfQRbaN2brunwFRKSa6XWkzbM
	 ycZJkuf4nGewS+YQT7z8OrTaQBCBT3F0gin2nTNDwKLdQcKCyjW1KZ3fcWrZAFVc9YQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791695949;
	bh=tddjwPqW6/Kw9R/l3HwF+SmyatofM/g71d0/hvNDDUU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dRAdAlOtIToOJH4bjnJsFGY0WEV6rMpxeJpnWuPxMU6TE1Co8Wc087bB/hHQE/4ZH
	 dHCsuHxtrnejXBl5tpdSE/7lllJoxHWHpWi+VuAPxGkxQPNcY5H5S5DuyToztcOKZn
	 eX1nhBy8yyxNqGj+fBUY82YH7jQG+lP0UFVHWTEb5gHc0mwY5Vc4wrXPouTugPWYVK
	 HiotcSOhBbDt2VdQXUfEH6tx1J8uYiY/C2XDoPPBDaalYZDIpkTq5+l/wSLjcrArcr
	 qerg3RCUggXFBV8dpwTI8JCWScHNGgaI1fszM5vwkQkPEH79kJJNJpcePWArKzCNa4
	 nvJylR4B7MSZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1CA9E8106A;
	Sun, 11 Oct 2026 05:19:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B9FE9DF
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 05:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 30F4F60631
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 05:19:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5DIoy_5lzCAe for <u-boot@lists.u-boot-project.org>;
 Sun, 11 Oct 2026 05:19:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 12C6B60618
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b136"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791695946;
 b=LZi1qPT4LWHm+K+rOS408l5YvvtuH64pndfmK2KRjGs9CIx5Ficf2BtPETg/DrfGp5ez
 saeHb2O8dF0IQFnYhAJm3yq6AjewlyaPs9Zl8tXkzDccb0ancbdmBR+W/GauSqRu0K95S
 SV6c971FeLWKAVJk6rLu3Ivpd8gVOxOk8t96NYns+LkEJOC9CKtwhmFO09zyW2LidLwTm
 jINMqxPcOSma7wFX3JhyLYx1X9lsyRRYOG51jD+lhJZxk+xMxw34uBCU4zjY9eEgpZmI7
 qUCR1YmTXJyUgKiX7TkpUESm+AHQS50Ze9gF8FKMTiIbhyqFTrBPAfCnPcuQu+uG3fg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791695946;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=tddjwPqW6/Kw9R/l3HwF+SmyatofM/g71d0/hvNDDUU=;
 b=Vs+B6s1at+4ws31operAiKogfCkfBtRQsns/0I+GmWZv/jtZ/gQQMrrLSw0dCLZBGpDA
 ryKjSuF8Frc80o1PonOE09xGsYmkiw23drLVwG/JfCQYIsk4KJJVZ2Rjqn9VPE/FcK+X/
 Bfu9tRsEKXmzOaYlYLES84sSB0vPwblcsHs8SVcH3eVurECDZ5gdPtosLWruZkkC0Y22a
 1oz/AKJJcxm5fpsXW85S/0HQ0grjGKUD2WU2U7/sAzCY5HRHIcXZSgFZCEI9uYZYOISoy
 kDc29W5VWdei63gam6jSUOJKjPl2feaMz3WkUVUgpa3JPRNvzNO6GFm0ufRDamEQhkg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RFoO9kGS; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b136"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b136; helo=mail-yx1-xb136.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=RFoO9kGS
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 12C6B60618
 for <u-boot@lists.u-boot-project.org>; Sun, 11 Oct 2026 05:19:05 +0000 (UTC)
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-677aec6ddfcso667109d50.3
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 22:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791695944; cv=none;
 d=google.com; s=arc-20260327;
 b=Zr9oyQr4wPMrd2D+/IL5anDg2wGQ0usm1iF+SeBf3YNFUIvxb7R4onZAVRg2wT30wC
 T30Pw1ReIxc9kpvoDranW5jTC+RharJ8DwVoPOZfQi9Rfl4ANWgUqgANBUyyu+b4SYei
 XK6HXbcRF+XgHuFY4GYQeEmWYeY+7qj9jCN4RWenAlJJcZAUxFBmcP6Z0DSBDz0KKlAq
 7De49GdMPV+d9jgVA9YwA7HbLWpKERnTa2u/fblJqZXF/ggD2QoXxQAKkMgtSD4LFmvE
 wigBhmR+RlTj3byhrOnM+wLSIG4Vid5s7FgmRRLK6vgntZbzAOlkTwaq6ceExnBZIWnL
 N1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tddjwPqW6/Kw9R/l3HwF+SmyatofM/g71d0/hvNDDUU=;
 fh=y5gsrFuNSA3n4e9YVSwMBV7vKCaUHLBVgv6Lsatinr0=;
 b=X7suefOFkTcUO0MCfT0AU+wZTIj13oV0YSUhpnfAtGdFyk7L0V3mRbMV5Qzluj9/NB
 edNlIwQU9anekuuQNIksFP1vjBfBc1zmmxyuf59y7hjq6zg1Fa+niRVzaP03PFQWCQJ5
 cWS8JHsrr9oT9bgZ64molMXEu4FkLOLS0FzwcShg3RRUxjH/7bJuTJZofVifmPfybS44
 ehTe5ypumGzsool+ZGOrwz+R4GBVkFryT1YrC+RZzUIk4fHOCiBW7jVrI7E+SIN9tLdZ
 JGn6sTIo9aCr18mjs7ifAmry3s75gKdyxtUNwF6huDwm8F/MrHx44cGm5/E+nHbNrsH9
 RmYQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791695944; x=1792300744;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tddjwPqW6/Kw9R/l3HwF+SmyatofM/g71d0/hvNDDUU=;
 b=RFoO9kGS3fiYHxXGoWsyJtTMO16bj0Oh37iQkJNNmOOxQJEvy0WUM2oNATXBqZrvia
 zU9FZF/dVHYNUvStJdrLd94gZm5htN+x0WZL7rJS7zfPK6FRxIwQ2gINvBeuLMrWtPRC
 1KfHpEU0L2hK5Rz+2zvYwHj4sSOpunX9Iw3TZx18XC9TFdQRbJ1z+03L5/AQ+eRX/2gd
 pasNh1BY+ns7XyZK7A4yOlNBl7AVnsmjbgpHp7g7/2pCl4l39+YEXrKuTQH7pMitcJR5
 5D47O5T1LSQ2Oy4Hvv3theP58kBeKnrAw5FVSCq1IeWzofmjvioWy7TfR/bpoOAYP24e
 qp9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791695944; x=1792300744;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tddjwPqW6/Kw9R/l3HwF+SmyatofM/g71d0/hvNDDUU=;
 b=lK03nFygiK1x8h2jWTKK+Z8PMcmp1jKT9uUjywNrdGTSEdHbVxD3niXmhKnwOYw5SH
 2iwfoyX3ARskI3oE38hC45xPEWxKlVY1qlxNbsPcw8PgLFjj+XqlbADnPUuCyWAedBM1
 4/UN872B6+4BzU4Ghhr02hTqjhulIdAzuh8Buviaou6QXDDXXGN5Qc1IvyM6jaHU0fhs
 cqTN47Ad3Oc/AruTGq7oPRxXyh6Nk+/Yg2PeNOv+alVlB6TKkfvy83K6MN7UMmox+vDB
 I0adpyOQU+JH5f4x3iyOL/un4tKggREVa4q3sR6mM57YPDRGj71ym11mdjFiaAnYSITb
 CHRg==
X-Gm-Message-State: AFq9FYLeB35LDiV9BEuOqTqR88xYCk40Pz5XVPqA+EuGQTlLsgdsm+Hd
 OocchozBVmVWOM1L+OCHr2HcIr2METbMhKwo20J8XpwAfHITicHVazPGu+BWAjNBIGbcyEHO2fp
 dajSAMr9TwqZqVRIll0TjOqjRXp1xN2I=
X-Gm-Gg: AYBFou37QgkY9L7l40+K9dOH2FWRIiNuDwMOXB1Z2gX7fBYVXwy6zJuVlyBkk/ITPbd
 Iqmf4CL3lEn+KjoL25zfXKoakupaXMEoOvNemTG6ueFELJiwzWNhA4mHQyx+CvQZbTYOClIo96C
 fzSTEnj6dx78Zkrj0rFNBO4eY0mejPGzshwyToyiu6h1ojThLsmf9bbQ+7lvHtf31BdH1i5/Cqo
 xUUKIKxn2v8Xw1qNnFCw7chzyNZrLFZQo5u+Hc5DytCtjd14V/kkbnebhOPVGt1YjP7EEAgOe9K
 LhRvHsseZ0/wL5uDg+QyBSTKMySfLD3jb4SwWa2C2KPa3c63ceIdI60Ef2RlGXgyWpntn4svLUu
 aa+66d9nazXSh5nDJiuq6eHtDMfnp4KfQ9TAyHuKLesD67Jm/ue49vSndD6On8+DB6f1+LMmCPg
 ==
X-Received: by 2002:a05:690e:b42:b0:672:99e1:11ef with SMTP id
 956f58d0204a3-679362bd5b4mr1717259d50.140.1791695944336; Sat, 10 Oct 2026
 22:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260928110434.70686-1-pepe.schlehofer@gmail.com>
 <20260928110434.70686-3-pepe.schlehofer@gmail.com>
 <20260928194637.GO858934@bill-the-cat>
In-Reply-To: <20260928194637.GO858934@bill-the-cat>
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
Date: Sun, 11 Oct 2026 07:18:53 +0200
X-Gm-Features: AclHuK_pJ8rIYEwVwzjeHTQs2DOwR1NyJyFfD88FqElXAB2j8Z9lJm8KHcA1V0M
Message-ID: <CABPHAJweVnVqpbfL=UUPNGjsoQ4dqZVYMJdFTPLszsL1Z8b5sQ@mail.gmail.com>
Subject: Re: [PATCH next 02/13] Makefile: Link a toolchain libgcc outside
 --whole-archive with LTO
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 =?UTF-8?B?TWFyZWsgTW9qw61r?= <marek.mojik@nic.cz>, 
 Peng Fan <peng.fan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>, 
 Qiang Zhao <qiang.zhao@nxp.com>, Shengzhou Liu <Shengzhou.Liu@nxp.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Christophe Leroy <chleroy@kernel.org>, Mario Six <mario.six@gdsys.cc>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Heiko Schocher <hs@nabladev.com>, 
 Holger Brunck <holger.brunck@hitachienergy.com>, Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Content-Type: multipart/alternative; boundary="0000000000004eca6e065d89b81e"
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

--0000000000004eca6e065d89b81e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

po 28. 9. 2026 v 21:46 odes=C3=ADlatel Tom Rini <trini@konsulko.com> napsal=
:

> why isn't the solution to just replicate that logic
> under arch/powerpc/config.mk ?


PowerPC's private libgcc only has the three shift helpers, so with it the
LTO builds I tried don't link (no _restgpr_*_x, and on the Turris no
__udivdi3/__umoddi3). PowerPC needs the toolchain libgcc, and the
--whole-archive in the generic LTO rule is what breaks it.


> I also don't see a later patch that
> guards and drops out -ffunction-sections -fdata-sections when LTO is
> enabled.

The ARM conditions for that have had no effect on U-Boot proper since
a55014d09b2: LTO_ENABLE is only set after arch/$(ARCH)/config.mk is
included. Should I send a fix for that, and add the same condition for
PowerPC in v2?

>
> Also, in your next iteration please drop Pali Roh=C3=A1r from the emails =
as
> he does not wish to be involved with U-Boot. Thanks.
>
> Yes, I take that into account, and I'm loosely aware of what took place
here. However, I wanted to inform Pali that I'd be glad to finish up his
work regarding Turris 1.x, seeing how much time and effort he dedicated to
it.

Thanks,
Josef

--0000000000004eca6e065d89b81e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi=C2=A0</div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">po 28. 9. 2026 v=C2=A02=
1:46 odes=C3=ADlatel Tom Rini &lt;<a href=3D"mailto:trini@konsulko.com">tri=
ni@konsulko.com</a>&gt; napsal:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">why isn&#39;t the solution to just replicate that logic<br>
under arch/powerpc/<a href=3D"http://config.mk" rel=3D"noreferrer" target=
=3D"_blank">config.mk</a> ?</blockquote><div>=C2=A0</div><div>PowerPC&#39;s=
 private libgcc only has the three shift helpers, so with it the LTO builds=
 I tried don&#39;t link (no _restgpr_*_x, and on the Turris no __udivdi3/__=
umoddi3). PowerPC needs the toolchain libgcc, and the --whole-archive in th=
e generic LTO rule is what breaks it.<br>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"> I also don&#39;t see a later patch that<br>
guards and drops out -ffunction-sections -fdata-sections when LTO is<br>
enabled.</blockquote><div>The ARM conditions for that have had no effect on=
 U-Boot proper since a55014d09b2: LTO_ENABLE is only set after arch/$(ARCH)=
/<a href=3D"http://config.mk">config.mk</a> is included. Should I send a fi=
x for that, and add the same condition for PowerPC in v2?<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<br>
Also, in your next iteration please drop Pali Roh=C3=A1r from the emails as=
<br>
he does not wish to be involved with U-Boot. Thanks.<br><br></blockquote><d=
iv>Yes, I take that into account, and I&#39;m loosely aware of what took pl=
ace here. However, I wanted to inform Pali that I&#39;d be glad to finish u=
p his work regarding Turris 1.x, seeing how much time and effort he dedicat=
ed to it.<br><br>Thanks,<br>Josef=C2=A0</div></div></div>

--0000000000004eca6e065d89b81e--
