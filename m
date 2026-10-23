Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397A0606A31B
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sQ/kJ/DL;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=imK8M0+C
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 76EED814A9;
	Fri, 23 Oct 2026 13:12:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x2A7-ZhbYARd; Fri, 23 Oct 2026 13:12:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F405481467
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792761153;
	b=RKLsoA4v0HEkgLMcpAqNzns+jySmfmEXCZKr6zaiCj2UJ2V58Lr8BxEsF43rAcqSx/Sc
	 fW1UikTx3xK91aoumv2UlEd/ddSJCcJEcb8ewPFV5ho4F2lkHNgFirZCYZDfIS9PrHlQM
	 rWgXsKISRob7UNMfdi0rON/959fE39bifU7W3vwmVcXeX2zoBwzKq9eP7aVF12Oc/rKtW
	 BsUPNCs8bLInjGkOoGXxXpPRg2Kh6QNPPu6dFXK1rqYnE+dtB0agJnsD4kSoD8WQP2eN3
	 X1XkBbbwWv5k0yLwuNuFDICBTSbYt0Y1tFGghXnHkaTr4DrNuLqzynPjBRLERhHf/vA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792761153;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0eaOQ2AVp3EeO8xiOs6sJA5tCM/3RTXFQp3x5u7Bk00=;
	b=amt0TbISpwRmp2uIyI4rtTR+P0gRG60LWgo1PUWZmoJtXB96mEYfgWqXrdLnorOTN7Q1
	 IOZkKTwEIC3ZayiHpW9b4Hj9W8C8OkUdf/5Z9+0QB04b3LHgf2vjWm00lJEcj+5wdWslP
	 e0UM08V0Zn4I72UVhlu+9//q0Z7Wm0rFEg+0xV64KdR1+ey9WCJ6DuhP/+jdAbj+UFMiC
	 mpc78cXHuhNIx6qnluKaQxJcUsF8J8Z0GCu5QSbSDFWo7jj4eINiMPcoqIvZVAgza3Xda
	 o8JnoFB1YqD+gkesmBEGHniUSw2Cym0apL86zOBM4d5+/FW4YuxTh1P3wZJEZbTgdgw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792761153;
	bh=0eaOQ2AVp3EeO8xiOs6sJA5tCM/3RTXFQp3x5u7Bk00=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sQ/kJ/DL0VgStnzb4yNNUvtVcZpMJY7JSDAbyj0fcA8oEsOZthgeiICQ9PtbWKdLJ
	 Hu28vLqwSPagrd/RtO/VLVc6jN/r77B5AGcZ0eWWSgCnUXGgn11anNXD1GNnl+wPdd
	 rKUfPds1IMEFDCAQC5Ob7/flWFj3UHIzVFIjGqZ2YqyPtje9TkBmm13Po8/0CH3bYk
	 NqzStVcEMtXbWVji0+vFXxgAh3pTVLJnXB6T/6/IMmfdvH1cV5GxrJj4s1Yc2amm2z
	 BBcNM/1O43YjB9iFnrwgYwZ3xvzDGaKXQuHjubVapfe35tSMQ/bgbLKvBtk4HqzsYh
	 GM4J7vinmibZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F405481467;
	Fri, 23 Oct 2026 13:12:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 79CB23C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:12:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6B15E407FC
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:12:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id efp56k0QNRWR for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 13:12:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6CB444072F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::533"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792761150;
 b=deo5eWHzXGxw7AfMYaJexYlx5IQ7cd1ewCdA5xchBXAFaUASs2JSjB2TCvLAkXhkAiGe
 bGZoPdXycN9SdcN0CILgmTQm6x+e3HoRwh+lGnAOGWkHnx62zbBAydw3U7a8t0dmQhb5n
 JVl5jVmA+/zsoYECEkCwvybcvoUA2B9c9e16JRLbcn5PScH/fGQX7s0I6/GXYAPajpNk2
 6q7iEUsQIfWBSW/m4GaI+m2yUYL3hL5GlGiQ+yRiKF8Zj6CHzkwj9xOpqBEPsfaQEdM5Y
 cLmMf1A/3kDGbv9uc0REwYl03M/YDt7b+V8SCeZtq7yrNpOVKxOYSGnTZozeldBsZwg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792761150;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=0eaOQ2AVp3EeO8xiOs6sJA5tCM/3RTXFQp3x5u7Bk00=;
 b=j9Rr9l3r0ze/OG46cFGmnaSpQXGj38AESOWUrhlv2hTdcBF7pT5DPZZDKj6vSdiPc3KR
 Zf0k22mzFipWOARi4Wha/mqY8K0/FuMkyMsMayUevXWAb23xOMRqHXQmTlEiu+dzxH2cF
 kuygWcadwZ/DUztPua1Iposf1CYb4PvnEgHINGJUzc2vXuEPSr6JEsF854jsq5SZ+rFlh
 U35VCTJ51oZsS23MpEsWMetFXUPOSBqF7FsAPQLPOgg3zta7ow3YlSGmUtOllL3S00xoR
 ZvVKL4fanZ3XtbnfLRrN3leU0YshD0hAJQDKSg7rae6iTMtZhzkBaIanR63x/9Tn9wQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=imK8M0+C; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::533"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=imK8M0+C
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6CB444072F
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 13:12:29 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6acb9c018ffso1172250a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 06:12:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792761148; cv=none;
 d=google.com; s=arc-20260327;
 b=Jff3o3P01kdiZzP3ng3fsI/oMd828L4aheCJUlvwFxb/QlxsnY6Jw4mU5UDbbzUwwX
 WO2KxryEsTocHYQ2vJ/jVVpJk9mYiOzBiO56pLZN1P7H9Ef/KOF2yxAlMkdoq/rDUZte
 3upqiMR10sWDaZs2Hh1EWRmKkp00pA1LuJod7N4J/SwWrbZPvReUEIVjbFBqSsmSDo8P
 rZVPWWAlok8FrPOp1KNOUknF9thxxCRBDl3205Lap9OApNCVVKu6VxA1gNMOM66IUSxF
 bKcw9wrsWidViOcXClhXk5e8g5l9ujoKOSDsLLl0lZ8EfcBMSm8gb3fS1BSPXZCoS59C
 Uexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=0eaOQ2AVp3EeO8xiOs6sJA5tCM/3RTXFQp3x5u7Bk00=;
 fh=T/8Gx3lCxoevZhQqLEmO6dxXJ74ZDrnJlpsVQTbXodw=;
 b=PDrRThkPiZ0o6IfcIsvpj9aR3N+aPyXwWrMus0G440tli/BVVLd2guB8DZ9afzej0h
 mO94UBb9bJu1+vX0vQcfq1+bzLMYY+lbHXX8GNMDHYXka8X5YwG03/JT6sWTm+rTL8JU
 XYvQxxTVVYvMK3L9AxR/4KGgdM3BoLugjSjfBLFRnuoWqz1paDiwDcBXLzB4JHYyNo7H
 yGBYo4MhOPaeAMRomBdM0BiBDhyun7ut3DUPqnu5i7zUFBZARtBVyujAmxVHLfy1Ki47
 H2ihAYe/yAkYIn1VmkpUD+tEREHuDp/Es4+Xb8+89QWubzb+B5mQ2lhRe3Y9HhYelvDt
 A+mQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792761148; x=1793365948;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0eaOQ2AVp3EeO8xiOs6sJA5tCM/3RTXFQp3x5u7Bk00=;
 b=imK8M0+CjxqLkmiHWEGIRuFjeYpWCrJe62Q7NVBpWi3T0G6P0jQvuhS9h3tWse3Y6J
 LjX9Ra8AF/XYNY950BFuGktoHWbRFPLX7q3ZJ+oNczKuibfppElyCVRCmn8r+7SYVLvA
 gBlrs+mE3aHQb5ggqKgQGk51bPQGSkZtTWV/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792761148; x=1793365948;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0eaOQ2AVp3EeO8xiOs6sJA5tCM/3RTXFQp3x5u7Bk00=;
 b=PxCwQzNKMP8W/EzVPG1ISgGUIWlCaDesU5otutiF7Dhxt79KVDp6TL7/Gv67FjsedN
 aC2xKStzbAZPoVpQ6L8ffgi6qedvnAOcxzi3XxOvX1y2b3cbVSUbZKCT2gZ9O197JKEh
 yeehjOYHOhs0A1Clt0cJaNio5OJ8jsBx1yXzSb2q47hnphaTa8htyCqPfm3EgxtRAVaq
 Xp7aBqG8NDpE6SCeibwdgRWa0DwSjKBqbzFaNlW8P1K0Ct6Ah3avIoJAQAcexMNjRmJL
 X5BPc1E0rMc/UNWQPELENGUx70hKcRxna5E7eq838H8MpDSRyhmgalTUp+0UuQJm1vWL
 bqWQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOBaWt9i4PZHdXa1iwlVM1no62P80d4EjKmSFRgfFODbKAUxKz5yNdE2Ae9DoFB2QJSlPNZDg=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYLzu1hJJ0wuKiLym34ggI2EfXtsM7jj7MNSDHNzRMV0suR8x+yt
 EsEND1P5Iy/Ykp7DBlCvBGBuSVngYG81394aQ4LYrfB7WaSKRPkF/+EThzhyIonFcnYqa0C2+0V
 axTawlhaqP9liHBuhJuuFLoKpg5elXWT9VnVO56aH
X-Gm-Gg: AYBFou2V2S9h5mGjT7qzdGdn7K7UXbc27AjvpeBNxX3o288+BRC972sz6QCToOAOtdp
 T2wlmpYUbN3rVszlXuWde6oIGAL4cu6GIhymr3Z31i2rcW3HaTNcbxAjXcR5GlvsPwTYKypp8oW
 bzOECaPy+1hLp0A3OyHETq6BGXdEyd74H3t097AMAzv2TCcskxUkTmf1HHQGUmZMIOrhZ2/NzdV
 XVa4g0aH/BHl2fMGIsMhOKl/x0vLtjR8EOpSwOGphwqPl8/tmBM17xGSz8eXT5NKAjP1juD7zCn
 BRMAeeEZ09DIQOydpPSlQlPuo15CvVuU8407/J+l+vdzAU/SrWApJL2pvoAbG2Pu9EDdQ3xByPq
 MBYC1gr3hljedk3O1oyZ1FN+4BP3SwUZZ3OY=
X-Received: by 2002:a05:6402:a259:20b0:6a9:8863:ada4 with SMTP id
 4fb4d7f45d1cf-6b41d5cfd47mr6352116a12.3.1792761147918; Fri, 23 Oct 2026
 06:12:27 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 06:12:25 -0700
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 13:55:16 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261022194049.670889-1-ansuelsmth@gmail.com>
References: <20261022194049.670889-1-ansuelsmth@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 06:12:24 -0700
X-Gm-Features: AclHuK9joB2KNwnudILbnfIDd6neKtxPJJPXL-sBdAOsXYWw2BBtUDnZkiCgoJ4
Message-ID: <CAFLszTj_A7dsQ_Bt5jHMmZs8Txs2Leo=we5qEdEb8ERdxKuH5w@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] misc: fs_loader: reorg and split to FS and FW
 loader + FIP loader
To: ansuelsmth@gmail.com
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Heiko Schocher <hs@nabladev.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Aristo Chen <aristo.chen@canonical.com>, "Lucien.Jheng" <lucienzx159@gmail.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, Anshul Dalal <anshuld@ti.com>, 
 Romain Gantois <romain.gantois@bootlin.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Tan Siewert <tan.siewert@9elements.com>, 
 Peng Fan <peng.fan@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Yao Zi <me@ziyao.cc>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin Schwan <m.schwan@phytec.de>,
 u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christian,

On 2026-10-22T19:40:35, Christian Marangi (Ansuel) <ansuelsmth@gmail.com> wrote:

> Changes v8:
> - Address all the comments from Simon

Just to check, two series-level points from v7 still seem to be open.
The binding update (patch 6) still comes after the FIP loader (patch
5), so u-boot,fip-loader and partoffset are used before they are
documented. Please can you move the binding before the driver, or fold
it into the driver patch?

> fs_loader0: fip-loader {

The 'fs_loader0' label is still used for the fip-loader node, here and
in the commit message of patch 5, and the binding example in patch 6
has 'fs_loader4' and 'fs_loader5' for its fip-loader nodes. Now that
FS and FW are separate, please can you rename these to something like
'fw_loader0'?

Regards,
Simon
