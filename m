Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4BACA6018
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 11:16:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E40516069F;
	Fri,  9 Oct 2026 11:16:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o5Di-qky_vgy; Fri,  9 Oct 2026 11:16:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AE52660683
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791544576;
	b=emKq7V/TUpRB7VSK0sbvBS6v4acN/X5RPBA200kACnE54sLb67ThSKtqDXmYKB7Prvjl
	 VSdneAvwkYSjIzb9R2u9sWEMXwtqn81fDJAp5tX35uMOfVF1cAPMxgqMgqZgxZno55Ml9
	 uDT4Fb9Or3qAZ27oEoeVeg8aBEWm1o/KS1VQZH1SZX4KSzKMcHm+WbiobG1ObdJj337OD
	 gS8uS0SGvIqDXdmv7HRPZTmYcmUzT8ReJWCPkFzH7k8xaJ1Bs46UUvFUFWlmLa9AHDLYA
	 J7fkXLUgDnaPuieizxIKpgi4dkqJHgPkVVZtabS8F/66LxQd3eAXMgf9DSgIZUkBXyg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791544576;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xmgHQaOCNOazOIzk1Au5mYNQ+GbbAcWj/idKohvvTSo=;
	b=G3ctkBUUsF8CqHwjgKvIsX9WjxjBBHGsqFGYbQEhv8HaDG0EjWSkw3eF7mGofVvIEhYA
	 RB5iOGmHYZpEWTGBIwPFL7FpwyxZ3FJ6BVhisNwI2MSO3CspVoNlS5frPPk6ANcoF2Ldl
	 9HDxwlfXLXQ8ZbhtLij1WSr739V/rfB9XfRsAS0XUv7knNqDm7jNOcNK0jjGW46ufdx/O
	 ZmWNvZrtblkbmk9SH6a1QG3LWK+ba4YBzc0B0k2OCDK3l9hHStK1UqpHmYyK+VqcvUTb9
	 tPZ0n1P/bjFDBfqL1ocsVWj5/lqENotZgCdtYP9M70Q9kxSyc9ozXIU8UKRp8WMTtIA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791544576;
	bh=xmgHQaOCNOazOIzk1Au5mYNQ+GbbAcWj/idKohvvTSo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eL/2C5DD9QbSAzX+n8ahzFfd7TIqs6kCQYXabjLzxcKqU51oQTlpNmu5dJKfZ5Zni
	 OdKlQhcGLDKH+8hD9Az0Rm8L1gRPLajmIuYL58X5XG6QUdDJ6y/0Apjoafg+Rrsq/f
	 7V4TwBoXgNBBjPBFjyrXUedR1sn8tRPJ2Hy3tMaYGe/qJdDmVHBo8sfQVyIEKPV1uR
	 +LfKJ23L1lNucPtCeLSlEU0w1IV0ctiyh+mVAml36aWhz6+sarJszMyAksKUe8d2ae
	 Fo4Cd25m3ibWPbjz5cJaURpxuiJAmZVABXkoBHVKC6nP8mRhtHGTEMPLwhU2WdHNUR
	 BybwDv6p4K7Gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AE52660683;
	Fri,  9 Oct 2026 11:16:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B3E8B22B
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 11:16:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A5CCF40098
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 11:16:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3cD7raXYb7sJ for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 11:16:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 077E840061
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b12e"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791544574;
 b=l+9z1Z8jzYOvp93yToTfzwKXDvrEKJx+j5LZeC+cM6fnoMcoMTRq7U1uka2W/SsAI5Cb
 eNIfbhUk2BShhz7q/Xnvkq5jVKbLhGXAIRWrqcts12w2z/CIrfjb7mw/WY5buojc+SSy5
 CNB02G0UwvxSc41sQ7otrDdpzYWkMNaJXp5loecWC2BqbcRwASUs8tccjYxHmTf//hVi0
 +N6QZxOF9DSsEVge0jrH7+N3hRN3V0Ev0soQbvj533MXN+MI9H4Q1nWmPaH4FMk965d3t
 1Fx8gx8X5sJucvSfvuDkppfPjQZhshzJDMJj0g/ZdnF42RtWPf0lRCOheIT8Xm9V6Lw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791544574;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=xmgHQaOCNOazOIzk1Au5mYNQ+GbbAcWj/idKohvvTSo=;
 b=Oj1Qy56icfPHD9sUmSWbfWDmYR6eu1aSBJrIsxLk1nyshs0N3QcJiBVPxHZ18aJDHZyt
 iOzAfPNibZN5KMCj6eylP3J6he6SrQmDyZeKkWnsXv5KxIfplT/Cf78GpgdT5BuFyfIBN
 BOv0Lf3Tfl8oOkBObyblf4D7mmsXbkIYSrMpx4DM6zZa1brddX1VGc4K/IUX1CxhHEGkX
 /Pm1zYkrsPoy4SAG8c+fn2W2kuVq3912vL/QJlLD20kRyMaRxbGo4TZFrNoZPnUGg3UDX
 tVBSXTQqdJvtPRf7IIoBUf+pZWwis/sdquLTpiNj3LB4p6HNvPSak7URo7/CeI68xHQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=inYR9cHE; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::b12e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b12e; helo=mail-yx1-xb12e.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=inYR9cHE
Received: from mail-yx1-xb12e.google.com (mail-yx1-xb12e.google.com
 [IPv6:2607:f8b0:4864:20::b12e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 077E840061
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 11:16:13 +0000 (UTC)
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-676858d42f8so3933217d50.2
 for <u-boot@lists.u-boot-project.org>; Fri, 09 Oct 2026 04:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791544572; cv=none;
 d=google.com; s=arc-20260327;
 b=JriepT4uZeDzvgIeUYyDMk+1h3g/LGvtgr2WXyQuv4wtT7LFN1f0WOUEm+yWZNF33L
 voBwzlbozUQ1cyXwgp19x7+p/oGOZ3ruNS0qqpXOL/TyWGwokPe1T+2GLkAaeVOF5F4T
 QGhFHkCVeCH+g993hvsDFHrut9x88wu657eGxqcMXUd2GUWZWxIehG6iLEY1LfqbtwNz
 KPgUJUYCPJtOlRfWOjJDtP5GWa1wIUGj43thsFtghi5veYAxziPwnbvqoG3G948kPzdk
 4B084VLwqLWQe2x2JsldzEteosT/jFBHzz50exj5JGtQeR/xRGrdkKGh6QV0YDhs0P47
 fEzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xmgHQaOCNOazOIzk1Au5mYNQ+GbbAcWj/idKohvvTSo=;
 fh=dBPtYC1TZ/qisQKccqrPk+ZU1k6U81Ut+AAudAfs85g=;
 b=K/LAoawXaX0Ww9loIL3In9/L9eSOnpETO65Y86cDq4gUdA+OYtTOGGUE0CqIqxBsI7
 M+vryEUFA4+pqE4p876peAtgK0tdw0LRGjU3rS2u3k2cwsrYoRHtb/zYAWqqdYIbfh7Q
 WRft8p2tYpoic2ThBJKdeqeRVGYVdpZDwYI7Bh1SMVgZ+arfKn3Abb28TguhEkPJiO1R
 U4oXj5To2udjUK7nrvZgUzvUEhfPFOxsjrQTzLz6xE4WRSKzxdqKJJt2Idazd8B3YDzG
 eLCyFaRL+LG07qTgYiSruhwgJtVMvSALbcMZCtii/WrUcxVgfo/3oSZcfWqQYYumVfpX
 meXw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791544572; x=1792149372;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xmgHQaOCNOazOIzk1Au5mYNQ+GbbAcWj/idKohvvTSo=;
 b=inYR9cHEgn/4w7JvRrg0J7Rv8Uv59pV29y5dEQNlojVUlsvMoHMXu0uAw7qZuRxXqG
 ygxFtjak7vcmQLnTVECndMWWP534RiqxipnYX9tWTE5/i6ga6C/kF5jP9ja0nTXDMfEM
 i4hp8hjrGVEi3hEeHoL5xhUGC+XYLQzPO4+Kjb4GKvereV1inPAL2pr6wSabOtR4YsDG
 3oH4Mrd7QZsamksfDF5oWHteHbCtSi0yFN/C49fA2us2ZjYvyr7R1Klv+v+/ltkPEADC
 dDy+mFdAyjjYXGn2/pgDxwWPullsz1CVa5akkDwy5q36JOWSMPak6McRYypdCgDB9JED
 lviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791544572; x=1792149372;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xmgHQaOCNOazOIzk1Au5mYNQ+GbbAcWj/idKohvvTSo=;
 b=1evIk0HvbnDd2Ch/mjkndWv4PQIaEuuBhnN0C0xhlj8pG907B6ofc4+hwdp/muLCgb
 56uN0Nrltc4AdZs1NclVcNpeJPMPrwR7+ZxNOfzM1e6gHPZ7euuJ0QN/e+/CKc+1tzmV
 yd1p7xdT1Wxjj7KEpQ++g4Iz9FUXk9iLjLKr0nEXdel/jE9jpcGeIv08UYK8pwdoGBeG
 PrrEwKNtCrpWqBL+cJjMdY+oKTDVqaP62jVlGZMwYsV1b88x2jaUsNraMsZ9+QGm+G63
 pQkHEjcy1jXEhIHasQStwfDdcYOen9hbNDuMK/VY7Di9ahAGyhlQRvFHsF5o2HDZcvo4
 xEVg==
X-Gm-Message-State: AFq9FYIrobGDtp3Hh/YQEXkc2fcF8hG9bRZl3E8u/P1oyUBWN+M3Iox0
 mKED57y+/vQQIwGJYkmadAzu99+FbEHE4xYNs3jn1OfRLx49QUu3r8UAL3Ri/aBF9VNytyGikub
 m9QIjUtdY59/Ml03lo59KRVh14Dm7uewZm9JQSfeI2w==
X-Gm-Gg: AYBFou1UAQm4UxdnFjj+eubWlWDhTkIBe7ExXUohucDi9Tlf/07FeKe+PvZj0KuoHoZ
 X+FoVDLhp9YEP7mcL6VaXRwrdy/CCSu3+IdgsbCzpkRCdy2NLApGmeq7F1Lpy553LI7WKZFej2K
 J76pjVs7x8P6MM7LnoAhmPhIhctR5IQTJlkia+5mtjH/tpgukOlqfm/+2ia7t1TO3y9SdLDLr42
 +17XZ85U4/qlYcbBXjig93x6TzLML7ztcsCVFh/TcQJpkkhBmqIu3z9JZONeYqTf3Mrd21Swonq
 PvUEajvfo42WctN1BBRABVux6l820pcBZymK2XwsOW8GtWb8oSObiBrivX/bQw4wlQL6y5i8D+N
 nHQa/8uFPfCvymRHFhvYV1n9zSlM2LFfBnfs/qVfyGWlO4oYqLkwl436cbtNWac35PqBIBUrqb6
 Hmbsaea9fXxnzT3BLZGtkP0RYdNDuAz+OI2kasCrmOCA/+kQ4/RmNJ3ei984ZnEVcilbiHL3MdV
 mL05iVVOhEqQ5klRxr3sS04xwqFTBY1xS5x6F7xkDBLOA5IGw53eXwgGSi3gwctlwqHRRfdiWdJ
 LASGAkT/YROSfMqVsg3HctuNwm7UH97LD06K+1pZCVXkYBxhLJGBUlnhcz94AzA4GKGu0JmVrcj
 JsLhwh3zibyBq/1rStJ87bYmeRdgGLpZhfYHMAxTzyDYQFXEcKdaVlw==
X-Received: by 2002:a05:690e:1381:b0:675:3dfb:41a2 with SMTP id
 956f58d0204a3-67935f1c9d0mr435615d50.1.1791544572013; Fri, 09 Oct 2026
 04:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
 <20260914110106.1974894-14-harsimransingh.tungal@arm.com>
 <DLINF8X5LGMM.22DVNGKNPMAM8@linaro.org>
 <eca5e6ca-ef4a-4e20-9255-f7d20ebe0788@arm.com>
 <CAC_iWj+VHR_vGb8EYqR7tzLXihZLW586BjnjPsKswf9uDnngEw@mail.gmail.com>
 <55e2793e-33fe-43da-a509-8e64aed0c432@arm.com>
 <CAC_iWjKRo7Dm4f7FmMi15fELP9_A5XYmMmBtQN8q8qBFs1e+Sg@mail.gmail.com>
 <8a6f0286-c599-40f0-b113-1621498d2357@arm.com>
In-Reply-To: <8a6f0286-c599-40f0-b113-1621498d2357@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 9 Oct 2026 14:15:35 +0300
X-Gm-Features: AclHuK9I2Am1u8qVUInnY1KfH5GwPSsEyb-YlcMEQP8P5oq798yCVwp2N1V9r0I
Message-ID: <CAC_iWjLCpN=7YqFOMVC0HZJBB8vRE-D+jzsH+k=GZBWn4JT-tg@mail.gmail.com>
Subject: Re: [PATCH v5 13/22] efi_loader: enable TEE runtime SetVariable()
 over FF-A
To: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Cc: u-boot@lists.u-boot-project.org, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>
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

On Fri, 9 Oct 2026 at 14:08, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
>
>
>
> On 09/10/2026 09:19, Ilias Apalodimas wrote:
> > [...]
> >
> >>>>>>  /**
> >>>>>> @@ -1129,7 +1262,7 @@ void efi_variables_boot_exit_notify(void)
> >>>>>>      efi_runtime_services.get_variable =3D efi_get_variable_runtim=
e;
> >>>>>>      efi_runtime_services.get_next_variable_name =3D
> >>>>>>                      efi_get_next_variable_name_runtime;
> >>>>>
> >>>>>
> >>>>> All the get_variable*() calls used to point to the function from ef=
i_var_common.c.
> >>>>> By changing this you are breaking the runtime case for OP-TEE since=
 now we will get
> >>>>> EFI_OUT_OF_RESOURCES.
> >>>>> There's no easy way to fix this at runtime. For OP-TEE the kernel m=
ight replace this call
> >>>>> with an internal OP-TEE call if it's part of the firmware and annou=
nces it can provide
> >>>>> EFI runtime services. However, the default uuse case, which we don'=
t support SetVariable
> >>>>> at runtime only needs to keep working.
> >>>>>
> >>>>> I'll post a script next week so you can replicate and test this in =
QEMU with OP-TEE etc.
> >>>>>
> >>>>> Cheers
> >>>>> /Ilias
> >>>>>
> >>>> Hi Ilias,
> >>>> Can you please share the script, so that I can replicate and test th=
is
> >>>> in QEMU with OP-TEE?
> >>>
> >>> https://github.com/apalos/efi_optee_variables
> >>>
> >>> make run-fip should give you a QEMU command line. You just have to ad=
d
> >>> an OS image to test.
> >>>
> >>> Cheers
> >>> /Ilias
> >>>>
> >>
> >> Hi Ilias,
> >>
> >> Thank you for sharing the repository and instructions.
> >> I tried the OP-TEE/non-FF-A QEMU setup from your repository and it
> >> exposed a regression in my current series.
> >>
> >> With CONFIG_EFI_MM_COMM_TEE=3Dy and CONFIG_ARM_FFA_RT_MODE=3Dn, Linux =
hit
> >> an EFI runtime paging fault when booted through U-Boot EFI. The reason
> >> was that TEE ExitBootServices() path only installed runtime variable
> >> callbacks inside the CONFIG_ARM_FFA_RT_MODE path. That kept the FF-A
> >> case working, but it accidentally stopped the non-FF-A OP-TEE case fro=
m
> >> switching to the existing cached-variable runtime callbacks.
> >>
> >> I tested a fix by keeping the FF-A/MM runtime callbacks only for
> >> CONFIG_ARM_FFA_RT_MODE=3Dy, and using the common cached-variable runti=
me
> >> callbacks when CONFIG_ARM_FFA_RT_MODE=3Dn. To make that clean, I plan =
to
> >> add a small separate commit which moves the common runtime
> >> QueryVariableInfo() and SetVariable() helpers, plus their shared
> >> SetVariable() validation helper, from efi_variable.c into
> >> efi_var_common.c.
> >
> > I am not sure I understand the plan. efi_var_common.c already has
> > callback for the above, it calls the _int variable for each service.
> >
> > Thanks
> > /Ilias
>
> Hi Ilias,
> Thanks, I rechecked the pre-FF-A runtime TEE code and I understand the
> confusion now.
>
>
>
>
>
>
>
> Before the FF-A runtime changes, efi_variable_tee.c already had local
> runtime callbacks for QueryVariableInfo() and SetVariable(), and both
> returned EFI_UNSUPPORTED as follows:
>
>       static efi_status_t __efi_runtime EFIAPI
>       efi_query_variable_info_runtime(u32 attributes,
>                                       u64 *max_variable_storage_size,
>                                       u64 *remain_variable_storage_size,
>                                       u64 *max_variable_size)
>       {
>               return EFI_UNSUPPORTED;
>       }
>
>       static efi_status_t __efi_runtime EFIAPI
>       efi_set_variable_runtime(u16 *variable_name,
>                                const efi_guid_t *guid,
>                                u32 attributes, efi_uintn_t data_size,
>                                const void *data)
>       {
>               return EFI_UNSUPPORTED;
>       }
>
> The common callbacks from efi_var_common.c covered GetVariable() and
> GetNextVariableName().
>
> The regression was introduced because this series only installed and
> renamed the TEE runtime callbacks when CONFIG_ARM_FFA_RT_MODE was
> enabled. That made the FF-A case work, but it skipped the previous
> OP-TEE/non-FF-A runtime callback setup.
>
> I am planning to restore the pre-FF-A TEE behavior when
> CONFIG_ARM_FFA_RT_MODE=3Dn, and only switch to the new MM/FF-A callbacks
> when CONFIG_ARM_FFA_RT_MODE=3Dy. The relevant part now looks like below
> along redefining efi_query_variable_info_runtime() and
> efi_set_variable_runtime() as before in efi_variable_tee.c returning
> EFI_UNSUPPORTED:
>
>       if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
>               efi_runtime_services.query_variable_info =3D
>                               efi_query_variable_info_int_runtime;

Don't name these _int. Maybe efi_query_variable_info_ffa_runtime?

>               efi_runtime_services.get_variable =3D
> efi_get_variable_int_runtime;
>               efi_runtime_services.get_next_variable_name =3D
>                               efi_get_next_variable_name_int_runtime;
>               efi_runtime_services.set_variable =3D
> efi_set_variable_int_runtime;
>       } else {
>               efi_runtime_services.query_variable_info =3D
>                               efi_query_variable_info_runtime;
>               efi_runtime_services.get_variable =3D efi_get_variable_runt=
ime;
>               efi_runtime_services.get_next_variable_name =3D
>                               efi_get_next_variable_name_runtime;
>               efi_runtime_services.set_variable =3D efi_set_variable_runt=
ime;
>       }
>       efi_update_table_header_crc32(&efi_runtime_services.hdr);
>
> With this, the OP-TEE/non-FF-A case uses the same callbacks as before
> the FF-A runtime changes. I tested it with your QEMU OP-TEE setup and it
> looks fine to me.
>
> Does this approach make sense to you?

Yes that's why I thought moving function to the 'common' backend didnt
make any sense. This looks reasonable

>
>
> >> Then, efi_variable_tee.c can select either the common
> >> cached-variable runtime handlers for OP-TEE/non-FF-A, or the new MM/FF=
-A
> >> runtime handlers for FF-A runtime mode.
> >>
> >> With that change, the same QEMU setup boots Linux through bootefi and =
a
> >> small initramfs, /sys/firmware/efi is present, and efivarfs mounts
> >> successfully.
> >>
> >> Does this direction look reasonable to you?
> >>
> >> Regards,
> >> Harsimran Singh Tungal
> >>>> Thanks
> >>>> Harsimran Singh Tungal
> >>>>>> -    efi_runtime_services.set_variable =3D efi_set_variable_runtim=
e;
> >>>>>> +    efi_runtime_services.set_variable =3D efi_set_variable_int_ru=
ntime;
> >>>>>>      efi_update_table_header_crc32(&efi_runtime_services.hdr);
> >>>>>>
> >>>>>>      /* Record that ExitBootServices() has been called */
> >>>>>
> >>>>
> >>>> IMPORTANT NOTICE: The contents of this email and any attachments are=
 confidential and may also be privileged. If you are not the intended recip=
ient, please notify the sender immediately and do not disclose the contents=
 to any other person, use it for any purpose, or store or copy the informat=
ion in any medium. Thank you.
> >>
> >> IMPORTANT NOTICE: The contents of this email and any attachments are c=
onfidential and may also be privileged. If you are not the intended recipie=
nt, please notify the sender immediately and do not disclose the contents t=
o any other person, use it for any purpose, or store or copy the informatio=
n in any medium. Thank you.
>
> IMPORTANT NOTICE: The contents of this email and any attachments are conf=
idential and may also be privileged. If you are not the intended recipient,=
 please notify the sender immediately and do not disclose the contents to a=
ny other person, use it for any purpose, or store or copy the information i=
n any medium. Thank you.
