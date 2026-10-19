Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87588606A31C
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xGHKixce;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=MW/YQg5H
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 551AC6060C;
	Mon, 19 Oct 2026 17:25:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tLlMDxcjFbd5; Mon, 19 Oct 2026 17:25:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 79E8460693
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792430742;
	b=mM698UbYK5Y52b/HaSlgy8VJahJeDE4YoXa9Kr3EZ53QAL2gsxJG+PHKACZJLsjGWLbn
	 csFDDfZdwDMPrw6bl1D1hHXQhEK+2eRjEdknE8+qQWOIULF/TsrEBYPP5CwUYWc31UFhl
	 B/ZMMVnGz5cmSzaG/qZJMnkiQ+qfwQRN1GLMje195KS24il142/6rXyFycf9NcmfEER2j
	 sF18C6bjFM++woAjxhecTv1IzXZGDRkrA8kNDcnNUy6yC9pPRWIjjlLw5VJkzPch/b54c
	 lxSvRGECP88ho4DfPFXDYz9rak3DLsu1e1S1HL/L0wZNoadFhvGz3GkhDSmtfEkWcGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792430742;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=8/cyisDBssMQ3xHFYQCQA5UBpoh8SrdWk2BMD5iVqHs=;
	b=e+y/zUPf7GXh7V3W5Ti+WqK7QOq1ohee4tuAA98KGX+TBnr1vn+LvIpMCKnwrhP2d1pD
	 5tEekkE7zZhWetjODqE1Os1HSYa5o4lz4ptDLzZVW/4ww/YR5kTaVyLpaFtgFGbZovphH
	 VqZKd9NxD12mBwfzusYjb74Te1i8YMHgVpZbRh06RdHdqVBDvoXTpZefPtDAXl+UZz7Hr
	 xjmOtRwg7RhtcpDQo5uNq01bwNenCf1LS6k4ofMebHYb/aAS6sggGBYOeRhGfxWBG2X+D
	 r1snMlvhsieUB0LyqyLYEmQA6VCUL0Bkyem+fSpzM7pcL0ezdQ/VFrRsC9hnxtVFXvw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b="MW/YQg5H";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792430742;
	bh=8/cyisDBssMQ3xHFYQCQA5UBpoh8SrdWk2BMD5iVqHs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xGHKixceHSh45QN5tIud+zPA+pDfTWdpvWW4dgjIwVZJGJL4sRBEYlHY0K7TUEZfI
	 oMkTBQG3p9H9g5p2WXZ0My7V6YmxJK/DWNhtMZBGcQn2xmg3uARugCwgHTfK40LCjU
	 u+GrSkH9DeXpaJSjet3GoYsPvIUudBysoD8OGOYe72nj5Wtc8L2vg8HvD2D0Vxutyr
	 K8reVr8tCPP91SwGcwEg39tfS07xa+J+3qj67wwQbyhzFjgAQBQFt78W7M0LYiAAcL
	 Jf4YVwESX9ZiRLPBGPPvgSceg7TsF/zSDPj9t8wTKIq7/xDI0aiXWQEw/5MFvDV/Gv
	 Z80V1pgVxuF/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79E8460693;
	Mon, 19 Oct 2026 17:25:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id ADDD81E9
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AB35460693
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:25:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 90QPF0Z3tJjQ for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 17:25:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AF8176060C
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::4"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792430740;
 b=o/CfzdC3q457hx9IRGF5yAgT02vKOOQKxyJZbSQkhlh4L/kqIVd6HcM1r6uZ6w8+ZZOi
 osogs/tdhsu06r/ftDG9zi013yIyeM6q+O/PzCA8fz9Nr2xiYqEW1mW9h1awoo4M+UzQn
 9GZ/etKWBzPEQ6QU0sx1Jbeb73UoJSYg0RZlyd2T9ASDP7oy+EfmYYicucHUtaGgkdsTZ
 DGsSYTURQpspBlrMOrGIxX754b4cAXDpGut6OGKFgSilUHdkByYY9NFWtirLFPkl6ANie
 /hrJ5s6uaQ+e9zqDLuOz0PYCimzopznv0nWqhElBlecs8i93R5so/gAV0JaaDEST/PQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792430740;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=8/cyisDBssMQ3xHFYQCQA5UBpoh8SrdWk2BMD5iVqHs=;
 b=HOKOtF7gFvS4aFBJ+UOIMQll8hPwOIAkMW//ZKgYN5KS5PQOELzz54IBo22Anaoq1kFl
 /xw4lPLtcCn8ikO22UIStpdJZvMqzKPMMPJR0LUWPSn/3UwqH/XXTSbSXyjfTRxCnxrb2
 81F1XFG+W3iQrXYWPFun8/CRTt5GAHcEhsbUsJXwMKzEmFGhSUwuICYD/4Jg9bGAIcK/B
 9gOachcGA4cRj2n7++7WI6ROnBaCdRJ1XrYdSXGnHEiz+fB8/bNSBHe2KeJjSxclSKoea
 6GX3UmceM/j6y+Kz8cbm7OZb0kPYHF9gGQEcFJnhWOl+Pp01N9ozPxz7IFIgbR1JP0A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="MW/YQg5H"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::4;
 helo=mail-oo2-x04.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=MW/YQg5H
Received: from mail-oo2-x04.google.com (mail-oo2-x04.google.com
 [IPv6:2607:f8b0:4864:31::4])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AF8176060C
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 17:25:40 +0000 (UTC)
Received: by mail-oo2-x04.google.com with SMTP id
 46e09a7af769-8458611046fso1014565a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792430739; x=1793035539;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8/cyisDBssMQ3xHFYQCQA5UBpoh8SrdWk2BMD5iVqHs=;
 b=MW/YQg5H/0fnlIiTJ0EpX3uK4kZPn5tGoKSa6gQ4Cd0ed4uLEfs4cThCu7vaMYmOvq
 pbt+R5s0Co/oqDvzRp4VMBHQM3IBkgH4cMsc/zOiSPXd5V8ffzgRUVVFZykjBe/w22JK
 owSRc4zcDYi6HsTPVtGO9vP+sglLVW/v3iZMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792430739; x=1793035539;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8/cyisDBssMQ3xHFYQCQA5UBpoh8SrdWk2BMD5iVqHs=;
 b=cEWUbaaC6W8NcuziQdYG8tnd7ukFvpoifvf2JK1VlCRp/iyjRgjmV4BuZDcJtDKvXt
 nZa7VDBHogs+P1/6JBBXI6w5R16vJNqFvrP+RaZ4j+YGfPXuJguSLMIfZrqeKwRwtcym
 OnDfSnknLviz7WT8okwdGRyWXzDW75hz6UOLtYKAaZ58GXvT98kulUIMzhECG9UEMeaY
 ArFdN7sOC/jG/xZ8l0kJw7tG4e9ZzYbgPQsdQFbTd8oU/5jE2JmhYOmViWEQnv8gKq9h
 /Y27AXxoOVth+p/HjtsIqW1ZjpSeNs5rktOn2aEkt30LrtYBil6vXl4G6OshDtoRBV8/
 LgpA==
X-Gm-Message-State: AFq9FYJoq8C0CI7MDbHKi7U7cTZozqk3cAepexn9vx2Ly1lvXb+AA24r
 5Q287jQlFItOrTSm1w+ETwMd8f1imHkTirfFK5UBgfxgjd8EnWV7gY475nvTsJ6dPEo=
X-Gm-Gg: AYBFou3NUVrtkhMf77hLOSEv79eV9ECYw8gQNm4LLuo+2jNWzFziiBhM7rF0YAxAjBy
 3i/9O/7BD5Jy813bYqljJxYwdv6PTOoE6A669k5vuTJMnFw/574HBFAOq2olHeTIMo56vCNgXKR
 3V3fbYyKSRSTxIDxaQkIucEzi86OSGq/UW8tM4uP8XItGD0MkeOYkWQbHISZ0RNxBwemrGjVw/c
 Lc7K32KzG0GqkEAKNv8Cql/wailM4Wrtpckz1Uw5d7B/3lyE/lMXHda6/yAAyX/pUJFh11RSRvL
 KYRcSgeMUyZslVN1YWp5ZYSRndNmM71EnWn8JEamno12u8AufrcNKeJmrdO+9cr1eLzS6Xue4Sz
 T12S5gHOVe/8jbWEmmnGS27czsmWktOUhTZYxpwqvEZ7CuFHvalOz+loxE4/gIUxbTDxacoq222
 yZg1jTPeVRQB8sv2xY4sjsVGeX7MO43f4AdjHYkXRHUa0FvA3fEsTqFD7oTDoLpT4M2WQEYf3Za
 IDoh3+4/A1qR6e2eDBdgb5O1hOqQi82aSQtGOmzZC6+s+NkHiPbT8b2fEQhRUIX594gWJmDB2gT
 An+UAoY7JUNc1RV4xQQ=
X-Received: by 2002:a05:6830:6738:b0:829:10c4:2c11 with SMTP id
 46e09a7af769-844f377804dmr8123692a34.0.1792430739229; 
 Mon, 19 Oct 2026 10:25:39 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-845b9e280dbsm6947094a34.19.2026.10.19.10.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 10:25:38 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: Bruno Banelli <bbanelli@gmail.com>, Ryoya Tsujita <tsuji.riya@gmail.com>
In-Reply-To: <20261017143216.157109-1-marek.vasut+usb@mailbox.org>
References: <20261017143216.157109-1-marek.vasut+usb@mailbox.org>
Subject: Re: [PULL] u-boot-usb/main
Message-Id: <179243073839.723589.12545738526838502911.b4-ty@konsulko.com>
Date: Mon, 19 Oct 2026 11:25:38 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 17 Oct 2026 16:31:48 +0200, Marek Vasut wrote:

> The following changes since commit 8d534cec0cc0109a37c0ded8854da03f1526dc0e:
> 
>   Merge tag 'xilinx-for-v2027.01-rc1-v2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-amd (2026-10-16 08:42:42 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-usb.git main
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


