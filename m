Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E567C982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 16:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B4A080E81;
	Tue, 22 Sep 2026 16:20:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bf3Y9YuxO7-v; Tue, 22 Sep 2026 16:20:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6C3DD80E45
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790094057;
	b=XYFMyd6oo1E3IUeU6HS6hUadizxQcRPTzWviinlRYqHpCoEXRWx4W86sPQIvQH0w/0jb
	 XIZdd6RsAraCK73tHvliWVoKU2K0b6lAgRSAvG78gTTl8fJ6KrUAJ/jqUiP86hrxFKagN
	 EMze2r+F6kjDbsa8RhtgheNMXodcjH99sOx5tVxDkbzwU6/uijstS381K9xlY3rji1fxI
	 FNpq/vMVTMljUEfb0Kf6U2e8yRqYb391YVmVuU1ELpRnMTCikMU7mCaGKbjhYJ3zA6p63
	 gfAhNMnPS2aCxlQ9r1oaswqBryqVVxnE1uH905PLXA8ylwunNPYbXG4KEoiYyS/Pz/w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790094057;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NO011RL309TvCVZV9Pn+CGLRnwNbrYKGIfKJrErPxEg=;
	b=UYEj8vaOQv00jgKpkWdFSCYFDvgICrt0Y7qvbjtfU3PXdNPhtB3FEDXOz07ygfiWTK7H
	 lF1rATQaWsahlqXpgCQnkkCOwAnOA9pVU6mzAsX6dmvSbpVAO911l0VrLQDIve+zVhGQq
	 NUyBeyOiBIonOJt6SjyjZXc/YSVnuVpyeiPd2ysGoqZpBg9JeKToF+CgOXTm2dDIpBb9I
	 CDMkQjb3Sn8iWRYk8i/Ibbz+8/QNwYWyUgsTUIhv804+eCxG9gDba88k0dNPz8smGE/v3
	 Xw45h/3iSN9bGdWwr6qua6k67KDq0fb9W0o/0+t4h3g8/KRfjgsGRAk12ATDfOkakiQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790094057;
	bh=NO011RL309TvCVZV9Pn+CGLRnwNbrYKGIfKJrErPxEg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RKurLIqXSfIfj/n7IjCBFU9N65zYYtklrHmD8eh7tQImnOQ6HTvxHWaZamqStjYJb
	 hSdVkTz06nYea7SDwcWnh8GUcM9dnt6sHzp+cM67RCy5SdoK9kZwUF2UP6fWDsuhzP
	 dduoeZ4Blahv1Z6sT4Xyn2xaHNNBFuHRYdZQwMpQFVK/mY6XN+z7NddOGLUG0eaS0C
	 35TOhJs1AH59OuY3zGxLGKRJc+94Zd0nO8qHGcRvLlg2eJJCw/j1v488Ea89GndH2e
	 kwMRai9XEt0p4hWWriZ019UXz6PacyaIi/iMU6wox2k7t2spv17Oep35PeFtbEgImd
	 v6oS5yUwTgT1A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C3DD80E45;
	Tue, 22 Sep 2026 16:20:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 138353A9
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:20:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 052EE402CC
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:20:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4_zofYD6TQiH for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 16:20:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 010E8402A9
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790094055;
 b=P6/nFaE2yV9bKQ/YyZJZHFidJtY7T8SHCHOI5QbYFC2bjggQwAc03nC+ZMHsma9KlWfm
 xPJ3G1QIDJth02WSrxztprKkT5v9GlzKyTrqSGr+3AtYJgSl6KfMih8RUrs/n7TqWgUq9
 8qbW/dvWNQ4AFjK3njQJF7GL8zwVJql0HMCRZPeP88TblxqhCWn9kBQ+B/ZaoZEdbOb6D
 y9w6RgxYLlme83GsGkSXnkTTt0sv2AgMa5Nfyk+6d4xwqDAVp3V2+x+5LtwE27DsXAtzd
 lpXARVzFBEpJ/1a0rqQn65DM1vekVztSIyd15WbrvX9cB+VCiJKCEQ+lSfbCNHuJKPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790094055;
 h=Received-SPF:DKIM-Signature:Received:Mime-Version:
 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
 From:To:X-Mailer:References:In-Reply-To:X-ZohoMailClient;
 bh=NO011RL309TvCVZV9Pn+CGLRnwNbrYKGIfKJrErPxEg=;
 b=PXLv3b57Btt4oeGVK3lMbS5UdrWn4OvMj6wOG/SfbJdOvOmlDFkznycNN6H3GdkrGvFp
 0JX3Mzpzhyu9qyrFxhTkhSm3FQnZFkb9nBNWCKxHDBgI0bFfUbYuH8u1L9VI+G/p2YXhI
 EPWJfGNLlm65ViJQqowTf8HzxeWZBRldFPthXcf6sMklUw3/mgFthMmVD/le5NVO9rCkn
 W+oij9mKbb6OIqXW/qRH2LMxwhR+f53ESWnHIWoU/uIZDjdQEAzE8RgP+tzx8dYSEhSXw
 Ncep3L03Sths/lsDOs2M2t7BGGTBEV6mYmiDqu2M6qHrcdeq2UbGTrp8FyZoVKLSSkA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=none header.from=pigmoral.tech; 
 dkim=pass header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=PNAGat+s; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=PNAGat+s
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 010E8402A9
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 16:20:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790094019; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=AeG1MqtxOVxiupK7SiEb32Sx99t7rP3z1fkNCt/JlTeRwRgw3zFBDfrCHaz7QqeXrgtMAx6pfco0w9Jw/e6Gm2RfLwIi3i4MrAaz9IZ76iA0A+n2T8BdO691somUm9Nq1Qud6eCn6svxNWk/vZMwr+I/WJCEAdsFjrdcDP6lIp4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790094019;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=NO011RL309TvCVZV9Pn+CGLRnwNbrYKGIfKJrErPxEg=; 
 b=dwvbNywnWx//lCZsPxKq1fPd/ZazpWuYALiZaWlRysbW+uYncAZloAT6mSWGpVhx/YdmgaIbWSFtj79i89ZLnatuIlgBr9i1CG07GZ7Aa5DuJ8HbaMZ6Dn9Za0EpmKFU9q+J6kFu1O9JLszhsJl/zYY7Vac075AzdDuPjhanbv4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790094019; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Cc:Cc:Subject:Subject:From:From:To:To:In-Reply-To:Reply-To;
 bh=NO011RL309TvCVZV9Pn+CGLRnwNbrYKGIfKJrErPxEg=;
 b=PNAGat+st+/PfRloqQcteYzR3MvfCK+qgCpCMTNq4Vw05bi1i+v/B1sE2uTxRG0+
 oeM8UCPJVEAV6VZdO1hwo1tvxvt0iOy8x6cF8YL4eyK+OV/+KHdbb45Hs/aFbW03dzR
 OUHWVwqTZnXGSbhRMgGNKAc5jRSrbXSmwLv6yYH4=
Received: by smtp.zohomail.com with SMTPS id 1790094018922847.5055560812488;
 Tue, 22 Sep 2026 09:20:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 00:20:11 +0800
Message-Id: <DLLZD88NDXNN.2EBK03OSYXW7G@pigmoral.tech>
Cc: "Yao Zi" <me@ziyao.cc>, <u-boot@lists.u-boot-project.org>,
 <u-boot-spacemit@groups.io>, "Tim Ouyang" <tim609@andestech.com>, "Leo
 Liang" <leo.liang@sifive.com>, "Conor Dooley" <conor.dooley@microchip.com>,
 "Jamie Gibbons" <jamie.gibbons@microchip.com>, "Huan Zhou"
 <pericycle.cc@gmail.com>, "Ilias Apalodimas" <ilias.apalodimas@linaro.org>,
 "Raymond Mao" <raymond.mao@riscstar.com>, "Minda Chen"
 <minda.chen@starfivetech.com>, "Hal Feng" <hal.feng@starfivetech.com>, "E
 Shattow" <e@freeshell.de>, "Yixun Lan" <dlan@kernel.org>
Subject: Re: [PATCH 1/3] riscv: Fix up the OS memory nodes from the DRAM banks
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Tom Rini" <trini@konsulko.com>, "Junhui Liu" <junhui.liu@pigmoral.tech>
X-Mailer: aerc 0.22.0
References: <20260922-riscv-fixup-memory-v1-0-83b3166320e6@pigmoral.tech>
 <20260922-riscv-fixup-memory-v1-1-83b3166320e6@pigmoral.tech>
 <20260922152400.GI858934@bill-the-cat>
In-Reply-To: <20260922152400.GI858934@bill-the-cat>
X-ZohoMailClient: External
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

Hi Tom,

On Tue Sep 22, 2026 at 11:24 PM CST, Tom Rini wrote:
> On Tue, Sep 22, 2026 at 10:38:45PM +0800, Junhui Liu wrote:
>> The device tree loaded for the OS may contain a static memory
>> description that does not match the layout determined by the firmware.
>> RISC-V currently relies on board-specific fixups to pass that layout to
>> the OS.
>>=20
>> Update the OS memory nodes from gd->dram[] in arch_fixup_fdt(), as ARM
>> already does. Platforms that need to keep the memory description in the
>> OS device tree unchanged can disable CONFIG_ARCH_FIXUP_FDT_MEMORY.
>>=20
>> Disable this option for the generic Microchip MPFS configuration. The
>> supported Icicle Kit device tree uses multiple memory nodes, whereas
>> fdt_fixup_memory_banks() writes all banks into the first node and leaves
>> the others untouched. This would duplicate memory ranges, so preserve
>> the existing memory description for this configuration.
>>=20
>> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
>
> What is Icicle doing such that arch_fixup_fdt shouldn't be written to
> handle that case correctly (and is it not handled correctly already on
> say ARM?) ? Thanks.

You're right. We should fix fdt_fixup_memory_banks() to handle this
case correctly.

I also checked the ARM platforms and found multiple memory nodes in
Renesas, ASPEED, MediaTek, i.MX and some other device trees. Renesas
removes duplicate memory nodes in its board fixup through
scrub_duplicate_memory(), while the other platforms do not appear to
remove the duplicate descriptions from the device tree.

I will work on a common solution and include it in the next version.

--=20
Best regards,
Junhui Liu
