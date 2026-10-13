Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E3DCC6B03
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 03:45:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88E376073B;
	Tue, 13 Oct 2026 03:45:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v8FFOF_ohDLi; Tue, 13 Oct 2026 03:45:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 728A4606EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791863113;
	b=iJ7Fen4WiZFJshi5iJxy2V8fJC8rs04J107TyQGeWCXWXoxG/S0oP6+twWOZGmlra+Ka
	 YpnE8btKMLp3l8Sg67kImGJSNHqfCtb00vciElaiI0kuuNthdu9bBYQ6t6MqXTK1fXkW/
	 DxYT9j9LdPlWSQ3HM4o7elsEGHV7Fzkw7HC9a2K6Sj6pRhCxqXnTbq/7xQh9nJJ9BzA0U
	 lqrP34Ta9uzeNScS6l7F0TUvh2zG+SThOS2GWj2MF/MFKWx/Tnfalnv/DlAENwrpwGp7b
	 +gM8JM2JLJOX6Z+sj91J6/lGZNG7OcOjLnhjET5nTsdIf/MPikgv8D2fFlB3tuuDkwQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791863113;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=612H4VIHe0j2/8/iEHUSnpstjhzPqMcpqhXGBuaC7vc=;
	b=ZR4a+BkeV4+Hsryowe4U5inEpSBM/xqYQ82XueqaTcffYsXDpEHz2nc/JlNA21rDOwLU
	 s40tvRHhs6p4m7qyHdv10cdG2MjRsZpxMBihf/XDD0I3iq2fKf78fEQ2nhksprs1olXIl
	 LJA99tsbD2Xyi+Qo2PecmBeb9zrFObjFGpxaa+OZJBhicoGHYIujcN1OgagpfuyzX4Be7
	 IgMRqV4SUfcrLn3MNUI0fEZD42OCeb9qA84XY2gMf0H+AH2PciOZRP1z1n4rhStudhhH5
	 C6p1nrDk8qn30v9paJMyI2eELvv9VuZ4BdlwGX8unRxCgP4wKpislNlILqOs/UJZWuw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791863113;
	bh=612H4VIHe0j2/8/iEHUSnpstjhzPqMcpqhXGBuaC7vc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=013fEPkSmDm4G4iQQJ8mA+LawNenIc61mV0cD8zXS/4T474h2d2UV5SYWb4es83c6
	 RxogBK+GYCSmTNla3xEvJpivDVDJRUa5RXukaIPj5lOoprXfuhvMf15/G76F5y6oTG
	 Ge+PLjcfu99evnWWXKW3FVI3WOnoRUk0XW97SNmrZhnDUqUVVfeE4xa5s3268G/of/
	 zE5q/DJF3givup/Yzpr9hWY3yQ1udJwZ6GgDPIPvwcrG/l/vbHFGZvItp9l/wwAjH7
	 88OyS6qZjz9GeyNb4QggjMRAyUY2fEL9j+Fk5ugb3jzG78KQH7Kpk83/jjWiRjWEah
	 fAo7BoRnUmNOA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 728A4606EB;
	Tue, 13 Oct 2026 03:45:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1632B2A8
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:45:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 13E7140187
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:45:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QaNwSSN-wt3j for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 03:45:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1B8004008C
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::82a"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791863111;
 b=QOyv2j1vdmaNgTFUR0i1UKtFXk8AuyxEjkPoxePB4Ukozm6X/uYUfXsANlZPM3m7GVBh
 I7bQSzmoiGRXRUD9GiVBj3u9ZNcAOv2UPdX04lyKjKKPxSVHAl6PyYmkDO9vY90DTfmfb
 yyWNcFTl4yFSI06Rkq43dxKnSSm5Tgp34WXMORXctPN7GUhvbBAL4hOSYLVl/+iH6zE5u
 x5rAytXbUc/0RkY8V2CagQ5wVbFO6hPjwbWTigIwNY8v8apKEvyosz6BqMWkkYtfasEZZ
 +xO3TZi8TizBxJmMye5foTttvL7Yho9bLsofsgC5r6FSCOSQTaBhLy9fzoE16R4/hZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791863111;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=612H4VIHe0j2/8/iEHUSnpstjhzPqMcpqhXGBuaC7vc=;
 b=e0PJdb7bA4NjQ4jtsLFBzl4V6oR+mpVcfhwyK9YzrOBzDzdTtS1q/82DSjxBIKDPUFjp
 FID4uVr+IeOHOGI4nTQEfJ5UOrE4za9MuQMdwoLIzb8OA66aSW1LszKTndnQrANSibfa2
 Bx/KOvVvuGmdjx1nOQ5NQe2D3StqCCRm+brXNDOhddTQB5q6vB4R0quNBHvNAOpg8NDmj
 fDPZiA7oHBAr1vJQl/27rRdonxM7di6NoPqarhZdyVC1Rl1ivqbohPFNQwFiMr9zvrOql
 W+Q3DXWXC89EJlJc5BDg2NxHuwUwfnZ1B2naxS7rSTHYc8vi9P+Mbqpaxs24soTMuRA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=BYAWxWfD; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::82a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::82a; helo=mail-qt1-x82a.google.com;
 envelope-from=linux.amoon@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=BYAWxWfD
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B8004008C
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 03:45:10 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-53512cd2f85so33286421cf.1
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 20:45:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791863109; cv=none;
 d=google.com; s=arc-20260327;
 b=IdQagZFhGxG3hawg8+dW2WUX9rObGVLp28y3BjDx1NqqReKzMTWQBXT1QZBmmDa6Xi
 /9RUg2HmmiViUbCiKZRR1e1s/FCbZAVg5o3dXhhcbF3NqhEamgPzN2UxOL2Z17Dh/oNi
 XUIprFFA+zV3omiApo2vodI7EM69OplGvkv8z8NWuv4/ZekFxVGMhlfCP70swRmB5/rw
 LEVTgjlSPM4caJMGkB2poJi+46jN1QuulCJU50HsQUZxGJqW+GgxTKkBjevNXriFzEAV
 oIpbKdt0cIXCNSDSWG93XP9zzopwcEjYq9IhqV0TtE4tbxqbHK7+RUrPcwXu58BVUmo+
 CAbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=612H4VIHe0j2/8/iEHUSnpstjhzPqMcpqhXGBuaC7vc=;
 fh=cR+lz5bI7Asb0IpRrBMLf6OWH+KD3gBK8yuAt8VLQ2w=;
 b=p4iYz5l7LXKD07VCj9zoDc5NgwZEPW/eGex2vldYRBe8H/fioWLfJxljGrloa53Xnq
 ZY+8hS3XK/1Vt+oHocXflLKbdRfFp96OBj+bcvqhkOltIcZcjii9YLx6DA5JKhhh8Vgf
 +RDGNRr2iKn5HirUOj+vm4B82q8Is/mLrxEfSYglqev3BXdyWzXnmOF/JVhyrf9Xad6i
 ky/l+T06h3AZmCieo2oN1nUFYIVTDReLRvJHyBvNNsqbRUCevWCcj+vzjhgQNqPmqp6B
 5L7beTvPMLrv3xVvXycqPgUuXJubhbkrmJcNe5vb2DK29UxLaisJZKw/73kk0GUuOVXH
 C51A==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791863109; x=1792467909;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=612H4VIHe0j2/8/iEHUSnpstjhzPqMcpqhXGBuaC7vc=;
 b=BYAWxWfDPBdT7ksQ5Qo6OTVJpTle2MF8/N4Ri46EEo3+c8eP2jWpmhc/30AxVRGQOv
 /wEnpJ1V2SguJlTF44L2rsP0NmFkQu+g0MwjK/oAvuxDnRa2jqYgT8ZLkontcutSwS3g
 duCOebfXFT+30COKJNDLsgLlL0K4+Zx8E+TYkpJ0vjBhuLPkN9/qUTXthXoXu2GokwUQ
 BC89AsK2FPGV/me2dhvyjfkG1/wV9HL0WMMFDNSLrbwfqUZKs2r1T2bgWuPlOPGaKp5H
 e5Ho4YKjJ96M/Iivx+3gW0jBx2qegHtVrhX8q4Y294iMRxPf4mzfINUIiLRqxGAxWPUY
 g2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791863109; x=1792467909;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=612H4VIHe0j2/8/iEHUSnpstjhzPqMcpqhXGBuaC7vc=;
 b=AfzbeMlaN1tq64nsS0SSXpifIum3Tl+1KCeK6X0hszRX+5RILnqxz7zqlQQtA5iieN
 Q3UUMooiraKZ6CrON4AU0dt9BhdGYP/rdXrAOveubqTDTaS0AmtcILo0ffW5E3BHyFO6
 YnzxbdRKHcw4TKMioUDxhlYf3701Kuwa5EfosOs1dHBq0lRYB1nDdlQednGaqstqO2Qo
 PsgPf8YFg59V73ZsKxtgTVkal8YGJESDEGsBb8/mN2000wBlHLE9GR0OxxZ6+5FlmMfp
 cqoNt/MDBl5RrrRzZ0nUJkLNFvU2/qrTBwHIk+7rr4ncHctLBn9onXC5MHSKklGLb55i
 tL+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxtFdLNoBtb5uagTfJxAu6HK5wfqwBapeT8MMh474saqseJ2N66zmR2PSE5W1raz7ICy25VrzU=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLtgTo46kOdMVsq4utNsne/JoZIUDo0CW+LINO+TQsxD1bEXkJ0
 VhaGKdmeK64QCcPK+jxBS15dwYxnwGBzioIHaxNXpGk6netLe1spb2z3Rc/kwX89YDM9Zk23Oj1
 zKJBHMEImet3AlGb4sJTICVGFnSrtJOE=
X-Gm-Gg: AYBFou33Zs452Y8Ax9YjRR2dn/kxPok4uBcOK7kyVz+NBxQs9QPQ3zQWlZ4nZOLAIhE
 ljcs1ySUJnVPCF44lxGdZ2IjCFgXpqM+l4a0qp/9nCwuaJ6PGB/0+0FUn8GnWr2ClDBTnVPL9nY
 IHS4mibv29g3TloNCwILeU1j9XUkTSHOt37GO0RvdLAT5GjlGO7aHCYV3dcPL3fLvGOZFFulbyF
 tJnbHFA9exV0VUer9lwxAIr0Tcs94cUXAS/8Vidlsw1JaYHpsY6POiPAS5MAy2wx5yREguYC38V
 f+mamTbhODsquRu0lMyzy2Lo6qitvBopoKZvo2YziH4SS88dhgcBCg==
X-Received: by 2002:ac8:5a95:0:b0:535:2447:3cfc with SMTP id
 d75a77b69052e-5359f4966e6mr205915241cf.1.1791863109088; Mon, 12 Oct 2026
 20:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
 <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
 <a57e47d3-fe8c-44dc-8afe-2c256ed49d71@gmail.com>
 <2ef42a4d-ee32-4650-819b-ea6d042bdad5@altera.com>
 <c02f3812-e549-4f4a-9fc8-77da7ed6b883@altera.com>
 <8a263ad7-5cf5-46f4-87a1-43e898a1d15a@gmail.com>
 <6f00fd89-d418-4d64-a066-c893dff89994@altera.com>
 <1f734cd0-cd75-4b0e-93ec-490ecfbb1ab0@gmail.com>
 <CANAwSgSSbmQu0jzJQW1-4ZBSxUXnBD87svNa+fqyiEwF6JhYDg@mail.gmail.com>
 <20261013001538-GKL26088@kernel.org>
In-Reply-To: <20261013001538-GKL26088@kernel.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 13 Oct 2026 09:14:49 +0530
X-Gm-Features: AclHuK-OFndzgFrDTW1NCD7Cm-CeNio_8H0ubcufRcGhr7qgQpqDKFaqCOPQ7EI
Message-ID: <CANAwSgQtPCL2FgJ511M6su1utYSKvjDP6xJhBiDVJ_ZAU1pTVQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
To: Yixun Lan <dlan@kernel.org>
Cc: Zixian Zeng <sycamoremoon376@gmail.com>, 
 "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 Dave Klotz <DaveWK225@protonmail.com>, 
 Eric Chung <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
Content-Type: text/plain; charset="UTF-8"
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

Hi Yixun,

On Tue, 13 Oct 2026 at 05:45, Yixun Lan <dlan@kernel.org> wrote:
>
> Hi Anand Moon,
>
> On 21:37 Mon 12 Oct     , Anand Moon wrote:
> > Hi Zixian, Tanmay,
> >
> > On Mon, 12 Oct 2026 at 18:49, Zixian Zeng <sycamoremoon376@gmail.com> wrote:
> > >
> ...
> > > On the pinctrl side I had already run the SPL with standalone
> > > CONFIG_SPL_PINCTRL=y, with bootph-pre-ram on &pinctrl, mmc1_cfg and
> > > mmc1_uhs_cfg plus their pin groups. I confirmed that
> > > pinctrl_select_state() return successfully. The multi-block read still
> > > failed the same way with the rail at 1.8V.
> > >
> > > Therefore, I suspect that configuring the MMC signal voltage to 1.8V
> > > in pmic_init() may need to be modified.
> > >
> > > Thanks for your suggestions and guidance.
> > >
> > I have also made some changes related to SPL GPIO and pinctrl support.
> > On the Banana Pi BPI-F3, the MMC controller uses the following
> > regulator references,
> > which are not currently configured in `k1-musepi-pro-u-boot.dtsi`:
> > vmmc-supply = <&buck4>;
> > vqmmc-supply = <&aldo1>;
> >
> > To address this, I updated `k1-bananapi-f3-u-boot.dtsi` to include the
> > required regulator
> > configuration and make it available during SPL initialization.
> >
> > Could you review these changes and assess whether they can be integrated
> > into the mainline U-Boot code? I would also appreciate feedback on any
> > changes needed
> > to make the implementation suitable for upstream submission.
> Hey, I'm confused, are you trying to prepare a patch here? I thought
> it's Dave Klotz who would do this, let's not hijack this thread but
> coordinate together, and please be patient, give Dave some time to
> respond.. I think what Zexian done here is trying to investigate and
> test the patches..
>
> > [1] https://gist.github.com/moonlinux/2ae03be59f263b0797acb138bed226b5
> >
> No, It's not a proper way for people to review and comment..
>
Please accept my apology for this.
> --
> Yixun Lan (dlan)

Thanks
-Anand
