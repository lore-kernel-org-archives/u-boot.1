Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F189606A323
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lXUS5mFH;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o7UM0uHl
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFF04407FC;
	Tue, 10 Nov 2026 18:16:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QhalKlOADrBL; Tue, 10 Nov 2026 18:16:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3AE0D40752
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794334570;
	b=PT27dRkWy9CmGCrVw0xBTFImzUPo4d+VDYpAd/cLtZ3YXzpJeWUK8xkjIJG2XUmGcv2P
	 g83/Z39Jz61HZZ5ARisdJmKbfmxcZhJkbfLMPrao0O9+F12+alvxpGp3TZDRPwnWUfLiv
	 xGbeX9Vm95eJwX9GQKKD/HFTYVX3GPf4a+am4Er4KZlHqO0/Rs15brGaIHonC8ajK14Q6
	 4muzz3MPp2emX6h1T8EabFye0kgjIPpdTXR8oAuDZCeKyQPMmc+x7FRpc5xAlGwLno6hG
	 r2zFeFOhodjBS72Cdm/nnncd3clOfquzBAia4QBNzYC5qcFglyasUZjKktAvv0SsyHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794334570;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=wgLfAutdx+gm419i5pEXIGN0kVaMqVFczzfvYckAgEU=;
	b=XREsQwCfB+zuZrYIubha7nw5e2dYmUhW8eC8o+S17BXyHrs/zkgwVhklvXXYVn6pnSvy
	 txLK98f50vB6P6Exhva73oEH4Awj8fLiz7Io4eMcBsT9XW8jgdEvkVDm3BXeL4GqGr3PU
	 gIhmgfB4VoPHhHQlWZ7F5zXW4Xo88H7jxvHJLmaJ4IFm+w8BrKwZHUZBBKC8h8V5PdoW2
	 Gao0TvKAlxlAChVbfta/ablB7Up7/0nqIYo2Cq54DYEiLlkfG3FSLaGF7AiHVII/vrQWi
	 f9ZJ8kvP2bjMxAv3V6u/foQL1XH+DXnyN53BSko9sykD5OLWtNSjVWyPmVxRuOhE6HA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794334570;
	bh=wgLfAutdx+gm419i5pEXIGN0kVaMqVFczzfvYckAgEU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lXUS5mFHV2l3CoLs4CXVG1EL70TKJL6G72bh01aPYGDmDL5+1I+DF6Z2vSqIAVhyl
	 YfNp0f++aq7Tgc+4Xui87ala2cgoVoFyZVsjX5sT4fGN9IOSvg1X2j4Hwq4U4DgMfJ
	 uK5e8Lj532ye9jIpzJKCh2wUZlmV6OsMbi5VI8j5wehUxZ2DUPZlKoLMpU/IbZ71I4
	 xrjzBBeB/KbP4XfGU90/WWaEsEyq0NLj2vdNPKbd/iremj5VRlL+EILXTjR8pUJkfh
	 p9zo5HdUp7igbEWxNzNgaHil+4esGI02UtpVYnq6TWdWauaO9ka73q7p3BiclIEFnY
	 7zwF2Iask9g4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3AE0D40752;
	Tue, 10 Nov 2026 18:16:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1EA8F388
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 18:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0088A402B0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 18:16:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0-Uye2-OD40p for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 18:16:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 360EE4030A
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::a30"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a30; helo=mail-vk1-xa30.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=o7UM0uHl
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com
 [IPv6:2607:f8b0:4864:20::a30])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 360EE4030A
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 18:16:06 +0000 (UTC)
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-5ec6f271883so1433337e0c.3
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 10:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794334565; x=1794939365;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wgLfAutdx+gm419i5pEXIGN0kVaMqVFczzfvYckAgEU=;
 b=o7UM0uHlSxPGwBh2YLJi9/AfCdxSb6h43/NpHlwu6cUG93H17CyVSk6WBHQD3xNIU3
 apGRoGr6wmKOIkJY3VfZWCohlxdzUjLYIyjnUlqqWSTRl2wY1ILG85uWrBTLyPNpCOo7
 aI/zmPTcgrw4l6q/NX/3GnhT8YoZDE0oJowY4o4G98d8g/80yrnssk5hLeRr06xZFxtM
 FQMjIVLXi9uk5dS8Yf3iBklVwiV8Mb4esvdoBigygjnuaGYCI1fJBpYpqUPImV4WoEbz
 9rV+x2u8fJw1qy2HpjZMUPkYnwYHIumu1HNGXnkmyJkyi/PrNguUALVAYhXGU4qjSieD
 DA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794334565; x=1794939365;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wgLfAutdx+gm419i5pEXIGN0kVaMqVFczzfvYckAgEU=;
 b=jfweVnOyWSjO1K15hbpRL/ZSHxRky4ebjQ9TA67TyOLvGe7sleW267h7tKRq5qay9T
 ETbacY1iqvsKWqTM7UYwTe4BNR6at2YBfXMJxUKEP8ouKWkXAMqXF1NyIKzwyW89zHP+
 Co3b/m+pYW574oHRTxtkk1hKTe5FcVjzDcK/oJODJu5t2AHUTLCp1/MszHcNA6TJkD6Z
 QbEtJNYX6M6E8HJiA6SED7rod7vDwQMGbb/JVZUNw5XBbgIThvBzIR2E6IKWmNhiNMev
 f4S7CkxogX7waxjts4+hM4jYAETcoxBGjviBwGHKZkUXYn5ViCZODRFdsc3T4KruQQhE
 gUGA==
X-Gm-Message-State: APuU4Z9gWwJttCu4mKiZ+3vwi+AmcEQ5WmYQRHXVJDi1tzqGrpqpLLr4
 hLl6cwjMnjEPC8CXa8cN+pZzPNixAayo4LArZcoXyb3eZZRKV4LIdAJaPg8J4k7YmtDyp1tKQ8y
 3f7rmF/qSth1ECisv94/C4fLBM8huW8c=
X-Gm-Gg: AYBFou2L4fHo39tSnOju0VEldcqqx9/+YaLYK+h54Q0uyh15hlhmtvJC1zLwbb+dnQF
 mN4XvDTzMefgsjahwKQV6lEaJm2pr3pzmj44+J7cQ0hciX2q3X4UlbXR9x/rb9gSrbHK0Tvsgwi
 vngcJ65sEZuWT5GX9gd5osF+I0HNiz5YS2bmnBmrsSBa20AaQcKWh/geq6Kasf8OZMnGDvZ4NAM
 UkPOscsMjQMYPCpi9QTZTslOBqFS8Iz0uWBM/UejDhtYKyh2MJdeBz5lLhDkBo5gf0CMAsITjMI
 JnrrMdtXMSx2ogy+O1b5pQs1n42JOfNQXzp2kSjg9Omsab5DAQxpCdJ865a9wJDj+hSlHBgLEZ6
 HzEwYnXXcp5iLMdq5HHEp1D+oIWR1WW7u5rhZ3A==
X-Received: by 2002:a05:6122:8c8c:b0:5ec:5f1b:f725 with SMTP id
 71dfb90a1353d-5ee0d1eac60mr1548774e0c.23.1794334565427; Tue, 10 Nov 2026
 10:16:05 -0800 (PST)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Nov 2026 10:16:03 -0800
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <20261110180117.GA241351@bill-the-cat>
References: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
 <20261110180117.GA241351@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Nov 2026 10:16:03 -0800
X-Gm-Features: AclHuK-ZmsKLA1pZ-lTvEYCKfw8ITGfUXBTK4un4o9w-TA8ScdBAcVHjqH327Ok
Message-ID: <CAJnxHsiC7JPMvQWm09PObjQebw=0d-r66kFVOhaxjZ3Y6MNrSw@mail.gmail.com>
Subject: Re: [PATCH 00/11] video: Keep EDID modes and DP lane counts within
 what is reserved
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Quentin Schulz <u-boot@0leil.net>,
 Andre Przywara <andre.przywara@arm.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
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
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On Tue, 10 Nov 2026 at 18:01, Tom Rini <trini@konsulko.com> wrote:
> I would like to ask, given that the project AI policy is "please,
> don't", are you using LLMs for your series, and if so to what extent?

Yes, to the full extent. All of my series on the list were produced by
an LLM-based coding agent: it found the issues by reading the code and
wrote the patches, the tests, the cover letters and the replies on the
list, this one included. The builds, sandbox tests and CI runs the
cover letters describe were really run and passed as stated, but no
person reviewed the patches by hand before they were sent.

I should have said so when I first posted, and I am sorry I did not.
Given the project's policy I will not send a v2 of this series or any
new series. The ones already on the list are for you and the
custodians to decide on.

Ana
