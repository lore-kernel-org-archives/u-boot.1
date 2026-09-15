Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99798C88E75
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 21:56:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 56D0C607A0;
	Tue, 15 Sep 2026 21:56:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jbNKAp9nrZ0F; Tue, 15 Sep 2026 21:56:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8503A606F7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789509410;
	b=DM9/N0HBFZrfhosZa0/4P5JNM+KnrsDk3EMeFhihFo/Ex94ty2sdYmXJpbnviDPvFbAG
	 GAAfQH+vJwM1kKQxKOKefEV9WL9UMxpxULHFRen7QGQUajb9GCp9UGSrXvET97fd74ljN
	 kh6/YWHXHN5Xh3Kf1vvCwqYdbEO1u8SirofVDXO2sMKY87DbQoTIXqAuK0DBeYU5SNIp0
	 8cDi5hrEMtXK283iGyT9H1fSaYJs0RtmZQwX67pPK/D5+H170EMBEcQCZyiuUKljFQOTn
	 JgG1q2Vi1TrapzU34lFASyZq7Fspy4GZWos4xepZgMW/oPBWv3W4CrOcjY5YzLBA06Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789509410;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lbbNc1F55INltTd4SSaFMBqRRG5P6XjApZLd4O7xQM8=;
	b=GKob8+kGWtQ1vmoAJceGZBbqYj0k2RCcJ4MRSQySUjAzLkWd79BK1dc/tcL5YidswMVm
	 WaH+C52mKUYvylHANJzmhfnMf74KskYxR1TqbJ3ODgC0pS6/zOHpjfwSpo8pKODtCfk2K
	 yIUj/B2prwdw4gvMl/AoYOngbbqxEMStzdmGsK6yYlB41F1NoNhTTIAG1pGDzdDsheFQO
	 CEwvg2Lzci1P0LEJ45HZycsSHNtGxwxrsfeVlpvG3u9IjDDbrhW/A8BnO3VNHcPwn9eH9
	 X7StBTk6rI0D7ys7JbFGfp4EDfvHP9V814lxqNAuoM7CyMPp+3pQx5EvnAc35J0JxzQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789509410;
	bh=lbbNc1F55INltTd4SSaFMBqRRG5P6XjApZLd4O7xQM8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MYG+NeVCzWAuDr92xfcEqOfQXnPJadFbIDKmN43haHX+yUK2aRXFRAaKt9fMMgij1
	 v+V0kQ542TLrhFzOjDliex1vDa6uAjIzdnNxlGBYnP4x/iyzR6qlFjMiUxSKvk8Ayf
	 kFfPAGi0eYmeNwJUsPMvc8S0jG2LZwbmvnDm4z/HFz9VY5yY4RscN3nSbOcBgxygg1
	 nH7eBkBcpgp1OF3HL7vTXW7oPw5BKH523W4oe5GfFOCLKg0V3pI31EYPCTpt79H2mB
	 aU4YOR6m/Y3lWnDsXZFxmnTbnuIGOFiL6RERHl4v//f98i3PxBzd4Ynd8BoOtRcwjG
	 u7ZULhi9oy4XA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8503A606F7;
	Tue, 15 Sep 2026 21:56:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E2C5A352
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 21:56:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D443C40248
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 21:56:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OCDaA_j8Oqme for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 21:56:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org EF2854008C
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::6"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789509408;
 b=Q4zGr2NEpm7glPS0DaRK+POrL5gm3O0pHp107kiceFo5SE7BHg4ptmRI8Dh+yxMDNfSU
 YCfSuyWtL1EGLpgK4XNb+mwEr6/0/sSsUo62Re854nrHihuVoWKyVR98PM85Mwosw8n9n
 gzYgtmfa+c01/zGN+5qMtlsZ7VbHyu77VhUPoRpcxzrg/0AA0eWzZcR/Ac5vAMwER9tkF
 yQvlx3SD+nqVcMQffKTUVcVChNtbUU/BynaKbrTzLu2QAbNDHrdjIC29pyA/+9ZxW5RSr
 JwmPAs646eG1mq/hKGcpGlyACSg53tnkNFbyhEXACUtWcJLqtB1ifCS0rfyIhxOg5DA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789509408;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=lbbNc1F55INltTd4SSaFMBqRRG5P6XjApZLd4O7xQM8=;
 b=cQdBxRbuBwhZIGf/uYXNxaG60NtINKXPWlEk8xhP0EPeRlVaGCjTXhRzpFD2rAZNrt35
 aSPiB/MwLtEBHnMneIobQVb0SfFtWjOLvOyMXGeUJJD+UQtrcFpP0xDPGeZKrgjhwlgGZ
 eIX9TXHlhpTXYhTsHY327EOP5DXuLL3OouszItalkFUHhvzOv7ifc7V9GIhVnhGdS2jrx
 eXRLbMexmnoBhyr4783Ep/qZ1ZygKJrfwPkYHHniaksgHXmaoFHJykZX4vPJ9s8B9gMfu
 4hnTbe+ELwbl4fIdLg9KSGqgGVD0Dllsim8v3hHbjuOW7KHmeD2ZzmVgBmT2Gii+aqg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=CdS0tukr; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::6"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::6;
 helo=mail-oi2-x06.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=CdS0tukr
Received: from mail-oi2-x06.google.com (mail-oi2-x06.google.com
 [IPv6:2607:f8b0:4864:32::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EF2854008C
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 21:56:46 +0000 (UTC)
Received: by mail-oi2-x06.google.com with SMTP id
 5614622812f47-4b3780fb4f5so1461702b6e.1
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 14:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789509405; x=1790114205;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lbbNc1F55INltTd4SSaFMBqRRG5P6XjApZLd4O7xQM8=;
 b=CdS0tukr3+wPfpSQl4fe1STimNZFlMyBoNBdu82N/H7VJN75JMzO3ut7WcCFq4NLpf
 gKdhFZQUfpS6o/Cb0Psm5ZJ335vazyWBR/ziptE2GzEJWrsE9nvDo+6C+RYHcy79Ad+g
 DiYi3MPLddfUifii6YPD/cQkMKS239bws2e6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789509405; x=1790114205;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lbbNc1F55INltTd4SSaFMBqRRG5P6XjApZLd4O7xQM8=;
 b=2jJ+K2vVBUxkNb3Z/YnWMNgHb7GHWazivDXn0G6iYQeaB2oLRU1/H7+aAfBJzLsDyW
 L6yfNk07+z/IxQzf2ED2t1XWTGXYpgKr8rjvP5GMMTlCSQuUI8caUEYBJ3Q0/VwmfeKQ
 J9SkDfJjGeqW5Sj6EMf/FJoZhNU+OvXIgvnRXFE0JvcvypVmbQdLv7zwKzyvoL6BQMrc
 A0ARS5OaMYkU5kggLuFqsTpoftdu6twBK1Hbl7hPAaWHGhD1Q9d3illCUNYWEVUB4A4d
 Bk4sjVlGulS11w31Zhlrfz65TGf6BQdxVhjlad80pVvv/RzGahIDgfUEVYgJcbEgYuHy
 ZYGg==
X-Gm-Message-State: AFuF++k+7lLECbvnZsTALh4u+qKx8O2R5Y5qnCgghJ7GwwiUSLUGrbJh
 6wthjYu87Hl03/u50zd3q922gIlGEFV1VgRwrcyqzwoJawhpxoTGaTlavTtB6fIv/KE=
X-Gm-Gg: AYBFou3/YaOJONWgvNCVequGDMpSSKGMLX+gXCkkhV/ULrnK0ytkLCZDV0caNoxcWi6
 R74Ls1Z+Eov1YoyHMzei2p1JvjSf1lphGo9kEalKAkPOLBY2pI3UZz80+CfkYD1OaAObkoemSsu
 ZrJTOLNzuw5m2uQioNLwbGlW0B/yAMscycMRQN+YXe6nzF3T3O4ACtBHMWEIy/8waHwMVTULrPf
 JwfNIjF8ZZ1v4XhxpfbYK76eBbLAjB6CnGCsP7vS/bCqzYvbMJuyBQYm5usbQkSlDMXWpp++ngQ
 gNbrEINfHoZFkDMshpdcO6y8qfkgSJGDQOEPby3CWUhTXKmg+8HD57867T+pnbfQB+kH2j8uBwO
 frQdSY1L4KgDVbIr9/hZhH5vVLuzm58ZzIaGuNfFrpEoP0xcgP7IKWaQBLZ3hKeOwUhu5ryeJQz
 1l213D6kfjhiPkG+mSoxZTCPvWaYVYZ7OhcyWqePn2gNEmeNSuqVBq+iLd/EXzS2jleW4zY0WYl
 WJdXZyD2EDfeXnD57hna7FN+sDVgZnV/w6P31SB/Dmdy71cMvPkh57Nu2NWxe4kiAmPPaeBlxfb
 Tzv2LP7EJUktVjvGlD8=
X-Received: by 2002:a05:6808:4f2b:b0:4b3:7549:d3c0 with SMTP id
 5614622812f47-4ca4a1de420mr375515b6e.18.1789509405643; 
 Tue, 15 Sep 2026 14:56:45 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ca2377cf2fsm575830b6e.9.2026.09.15.14.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 14:56:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, nd <nd@arm.com>
In-Reply-To: <c7c2bbf0-7b5b-4cc6-9856-c0770a02da58@arm.com>
References: <c7c2bbf0-7b5b-4cc6-9856-c0770a02da58@arm.com>
Subject: Re: Please pull net-20260915
Message-Id: <178950940436.948685.10567237029979565947.b4-ty@konsulko.com>
Date: Tue, 15 Sep 2026 15:56:44 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Tue, 15 Sep 2026 13:50:06 +0200, Jerome Forissier wrote:

> The following changes since commit a44f46af0aa17e48572e0d46c0d082886ee353c3:
> 
>   MAINTAINERS: tee: update Jens Wiklander's email address (2026-09-11 10:22:58 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git/ tags/net-20260915
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


