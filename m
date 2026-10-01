Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8B2CA5FD4
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C6A0D607F0;
	Thu,  1 Oct 2026 16:15:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7poFn24hbu4J; Thu,  1 Oct 2026 16:15:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 087A8607F2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790871301;
	b=lurRuzrGEB7oIxfNAHtzxUv6ldzis0QHxML5cjv0ysQTuJ3JTYsdFDTl9VNJFftL+ufh
	 k3P/t8/k83USHg0KvZ1+2YWB1Im6S7ND0dQwMSFPv7y04ooI58Tq6/O9Us6F4k9igcd0K
	 aspmfekbAqbwcJT1yDDSm8FiFGzQIzuP8eX5fVG1wiKWBuVvmDRL0R9p7EW4nHsmKniSX
	 psTWD1Jyg4MwDCGg0mMSMg9uNMo58YD3BM+QY98+FF+PGyUlXZt99kvDPvsdyemMzwZrV
	 Yd3D5WNREkmKEmAIq9Y5vipaI9fgh1ViP6+mBRk6n0NbxUHlCm2IRVGbEqonRfsRvNA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790871301;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=EzzA1GpzkfkdPD3tXoB0XjJ+h8D7iOWKDfEAbO/B6zg=;
	b=CyZ7SX7K7cdBDOWvyVz1NFwag7OmggJ6I7Ui18bEnvjnVqd+N/1+GbiyEiXawljqONgj
	 doaFMgpGYnyHsAMRwnoebOSDb2Y6mRd0WazzoTrF0wFy1pxau7honYiburjPbt8jfoJFJ
	 yyKZF8DyTdG/dpLrLBKfS8XGzKA5FbJW1I6MNkdRBHXUzzqQhfWfRSQnUMARWUEKh03DE
	 oXqJ9/Uf0HR5uUuMJ0QuhYnJAo2/q600LUTvKvBQAeoO2M9hH6CRKGVRQxqyGq1NAXuGj
	 r3jNQl1llyK/EvxkGR8AOpCVorverSbUnWnt4MF8XhH7nzHUpQ8/ND2nX2x6nZ7oUZA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790871301;
	bh=EzzA1GpzkfkdPD3tXoB0XjJ+h8D7iOWKDfEAbO/B6zg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0NWvvXDFtDasJHVq1zO1mIVYDgO0Ks09xC3De2p+fLEz+zwV/2WLye7nYfzLVIRpv
	 OvHhPR9rcXx0cIBK0O97PriRiOB1C4l8e9gcIqPjCCrf0ms8bsvuQpaSBGJbVhDEEt
	 lWp2qYeOug3fy2J5vlGq+a5FTr4dmfQtHwyYxmbIT9Mn9xdPP8ag/aOBNHlMSZFyx7
	 dToEllb+HIzHTq9QRzmF2Fk+/QqOw6otfiitL6naLGFeHzJmvP/fhjYasBJqa2LtWM
	 GX6QSOTI9Qe0r6ZSu+yJtWTQktHPGugAEvqKK4cupcQw8Mvj5KKHHqt1EhgZQsV4Gj
	 am05y0UZKY9hg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 087A8607F2;
	Thu,  1 Oct 2026 16:15:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 10EEA3D8
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:15:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EB20940185
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:14:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aV9HKmLtzS53 for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:14:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D40C440098
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790871299;
 b=M7mNTi+R1sxgL73kbvHL+g9mc3g3sNyajqpE79/9Y4Jg0VGMRA0Ea7HuPnDi+bXo4VPY
 +C1+G6kGu7feqg+2cBgwSxq9pHlcpwkvGwXRCtPxXaLDhS3jLBWyiG302njNfFCBSnHMR
 U9igjlEbaxGuXa65sRj3OD7pThhneTGmJGzc/HmtIF5U7cTwaLr40HT3rn+Rol1T2x5av
 /2xwNPNizDbwxvCMv+zPfQ3aHqTqhx1H5pTi9ZD565XYnbbVbp5ZJtDzziRwX8uWthxWW
 zrIrB0QNutoFJ3gyypXBlTvQch6z3/9/de+ZRI6Q81j0eeL5sT/5OvkcHgpmZ1a2M1A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790871299;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=EzzA1GpzkfkdPD3tXoB0XjJ+h8D7iOWKDfEAbO/B6zg=;
 b=CVHcbbWME3unmzIojJJcX5nKyns7WpAM+EWswAlrPbnutQee+Q64q/2kZxgoTcLNtAF2
 5Hu4fGK1DnRO/5skhKnvBWU+lgaXVni4yDAXwSaZEv/YkYPd34usM7wXuNCC4M6wazRxr
 5cnKpUkx+AqPxt/iQM+jd/aIBI3EwnuLn9mdcrA3Zcby2K0u/hCBme0zI+p4KIFUJsvfn
 bV4WNLu3pgS9SPrLic82Z7ybWdBCBjO0MCsLxXEDwFkqJpF/XNjb4EU02ivfLUOIw/siU
 c+gDg1B65bLY9XN6EwReIYU8bln8c51Rg3v6yxdk0sCrmv1txEFHKSVkW0jbEtOFrLQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=XIHcsjhM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:33::f;
 helo=mail-ed2-x0f.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=XIHcsjhM
Received: from mail-ed2-x0f.google.com (mail-ed2-x0f.google.com
 [IPv6:2a00:1450:4864:33::f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D40C440098
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:14:58 +0000 (UTC)
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6a60591ae54so10736505a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 09:14:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790871296; cv=none;
 d=google.com; s=arc-20260327;
 b=Txr78danbmKo3SK1hpCXB3QKsxGXXEIYxQvWmtQCCWVYeylgKNAofhhuXcwy2Y1XvD
 /ukAZFg2UZWtpqHkMJ/KqI7nZDSgNaissPydSuGCy+ibejYQ27TdeKQrp32He0hzrOMr
 xT8Uk17D70frNxJuPGb3suTLqaY+rSkx9f8i1hTHFMAdUfU+ZBAx+wZmYXRBd+xKtpgd
 BIloKlY29KweDGQdYABgffJDDJ9jnDWFjTuX3/p0ZUM113JpjPgrbmrNj5r+1JmOUiny
 DE03z2RwBmOg8S8bxvaS9CCYS6CLRevDWqlpWydeapov1+zm2srJe172ZOozop455Jkm
 KJBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EzzA1GpzkfkdPD3tXoB0XjJ+h8D7iOWKDfEAbO/B6zg=;
 fh=392kzIeBF8sLz+gMF/PV/jRYniD2uCxeNjPS8gLMPP0=;
 b=Umorcjp7K+sA8sSxoBwUQV6gMnGwbtEv+LyHsEf9Kts50qmbbJ2LdFW5L/qTHHHo5l
 yF5nneEIJsmEOWrWT0U5Pdt2NBoIcIQV79Kx33Gr+zaA3S2gUHm2tT+vSaz6f0PQinfW
 dotKLmsr7cLVDvAOXeG1tac14x7yfG/U8rOLL9Q88HLLYZPr7bBzUJRBGzteJrMe0I3i
 ywFu3RAdtboRCkKOKHvO4bfcOe1nHipGZMfRPXUMZJb/AmMXLl/7g6xqyY4ekGrVLHHq
 G6YQrGRxFpZgl5juEJBNii0zi8ttlmoiNVyv/o9qRfQYsvFMsad1VuOqm45T3GVzGHoV
 W3sw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790871296; x=1791476096;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EzzA1GpzkfkdPD3tXoB0XjJ+h8D7iOWKDfEAbO/B6zg=;
 b=XIHcsjhMn6j8Xz72XWlUFRGro7EFnPg1bA+4kP8u9cbot/TERnPXD63TH69qLWq5/1
 5dIeB4t2s3IwMH0lVIUHhXy/Y8axQjvDwaMZEqNeqraGa6SyZHfI3VHDpO+Lf8OIzOB6
 xJMlbJrImdQTS+PxXQGNpF6+s1zQq55emMauw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790871296; x=1791476096;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EzzA1GpzkfkdPD3tXoB0XjJ+h8D7iOWKDfEAbO/B6zg=;
 b=hZXKhd2i86R1X5ivLfCpyYCqG81FiNM9x0qzLsv1Mbbg/sOwAaagnvfvMlrk7iW9Cg
 xtX9FH/XgW0uAP+3P4uuXyRdBuJrqrHYOg+p0ih8ZlNfU9waTdZLMJT/ANCMkacYDjbc
 3xGsSPnEmDlDjc/GURblkosTA4QUSXybhcb02b3Uejac2391edXtGAAUTVOOXDYkJ+y+
 07wL8/3erJvXTA2Akp00M8geaJCZy21g03PAXXByq9CsgH6J7KVP0EHdZFF1lRcpuUNq
 i5CDsIYuX4z2HBtUEUD9xSoN8jpO0ubQSnnoI+7IGWME7HPUCTVypWH+eIzNM9c+xvaS
 8U3A==
X-Gm-Message-State: AFq9FYJTW8pCNbsnACanvC2d8EXcfipt75TbRbtiY7mPpParNcSoaK5i
 VBhEo3fz0ytAZ5PM4d2/kVT3T0dblKSWbIpQdAjZeK3wcl2v8tFbTCuoa9acF8f/sLb1T0ZYjTO
 N8JvfgkSbEhrCoLnpDFS/0yhPhyMktPEW2O1SiX9runOIjBmHl8g99Q==
X-Gm-Gg: AYBFou1NYBRrfg3y2d1USQ14RYmHptmLShB8pmXC3VRvFos7EHnx4kQLUNx7H2mlVZe
 7fwauzWxfGx9S53MjXYrEC9fD8MudHm9lsBrGPRvMOQpvA8ndENeh3lheFI7b3cv7f5KOM8iLmg
 3kcxbeL3ExrfalfAYu2sUIY3Ny+h6FE3bv7l+ePshedqPq3Syjy1w82eB+mNCyYx8NwXeApevP3
 lI6hq1a+1/eg67pWQ8O1uJ7Ck05mGR0prtyVtPDYvLH2qRwJ9RT2ILqFhXOYF93XpNatlNvwd2r
 OBV+g74pPl9Zt/28mqlKJu1tF7/X72vvEPh3BFEbK/zDQMv5M0kPzZAV
X-Received: by 2002:a05:6402:51d3:b0:6aa:e46b:2c3 with SMTP id
 4fb4d7f45d1cf-6ae198f22f7mr4365099a12.29.1790871296123; Thu, 01 Oct 2026
 09:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260925072741.1966573-1-0xiviel@gmail.com>
In-Reply-To: <20260925072741.1966573-1-0xiviel@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 17:14:44 +0100
X-Gm-Features: AclHuK_IglonF6eHOoC2_hV7jJVqniUmHe2uuiUzaeY3SfCYnk7_Q5oim-FTieg
Message-ID: <CAFLszTiXz5V5HhH2eVEVLp_JSMUetcdhCpFD21=5rauV34w_Pg@mail.gmail.com>
Subject: Re: [0/2] image-fit-sig: close the image-signature fail-open gate
To: 0xiviel@gmail.com
Cc: u-boot@lists.u-boot-project.org
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

 Hi Eva,

On 2026-09-25T07:27:39, Eva Crystal <0xiviel@gmail.com> wrote:

> Ludwig Nussel's "Improve FIT signature handling" closes the same fail-open
> condition on the configuration gate with FIT_REQUIRE_CONFIG_SIGS. It does
> not touch the image gate, which has its own early return in a different
> function. This series adds the matching option for that gate,
> FIT_REQUIRE_IMAGE_SIGS, along with SPL_FIT_REQUIRE_IMAGE_SIGS, both
> defaulting to n

This leaves two options (four, counting SPL) for what a board
maintainer sees as one decision: 'this board requires signed FITs'. I
cannot think of a sensible setup where one gate fails closed while the
other stays open, so a board that enables only one is probably wrong
without knowing it. Please can you work with Ludwig so that a single
option controls both gates, perhaps his FIT_REQUIRE_CONFIG_SIGS
renamed to something broader? The easiest way may be for this patch to
go into his series. What do you think?

There is also no documentation update. doc/usage/fit/signature.rst
describes required keys and how the control FDT is used, so it should
explain what happens when there is no /signature node and how to make
that fail closed.

> Note that
> the series does not apply to main: v10 4/7 depends on f252d228be ("tools:
> fit: sign all config image references"), which is on next only.

Just to check: both patches apply cleanly to next at 9e002445cd0d
without Ludwig's v10, and FWICT nothing in them depends on his code.
If the dependency is only conceptual, please say so in the cover
letter, so maintainers know the order in which the two series land
does not matter.

Regards,
Simon
