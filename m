Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0413CA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 17:30:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9B0460BD3;
	Fri,  2 Oct 2026 17:30:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d7VYWAGDb6aJ; Fri,  2 Oct 2026 17:30:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D2ABE6066C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790962242;
	b=c6mx4QBGvMc5eLDpOxeuLdwuU4yEEIEq/5TL2jtIoxeVjt29Qf8FSojnUV2SjEJ+csD/
	 bnVoMCKmnuqnjP9DbUTQBkPR+wsu4h2+d19y6br79M+kSeBcf8/uGZGrMmqB1oteTfEfU
	 vBhlrBmZjhzRzt4skdSndscbgykb17IWZrHeAm9ZfcP0GYtVrCk1ESF3Fc5EiPQVzYO/f
	 2SxuF35gPMr4YKZyLb/5fRT0kthqKwc+gnou4afIOxagU5mFmD/LLxQopxUjq76R42Zpv
	 wsX8T7Mw11jtClhgqrQFxCiK4ATzPgZVpJ14yLaQQ+Hss7vQp73vdTU0h8e0ad0qKCg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790962242;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=degSFCL8GBXrw6vlC4aEoO62KiFuJl+KKm2CExtEkX4=;
	b=X40UiKrtNqyZ217upyQDnX7FJ4I5sGFXIbPCq8/JZHua2nPqcKtRkKWgLWY7j7Sif+Dp
	 Uk9HlueMt/fLAVLgSwvpPguo5cIWYKsZ8imk+hhRznFYv4MyLZfzJIKReolCOE3nMHNNX
	 KuYBxw/BMpx+gho2CiGUoz7TE0hjM+CCSkaw6INyLdziLiuUghgPL4AnKQFfws6a/Eb48
	 GxMMtslOCB/zkclZPPqUr+O11X/1OcykZEcI/tBcRWscgDEBA/N8SXWYzp/vzQJx7KJCn
	 S9ZvpRx4kCuTYzzthZWRtO7JO7rP4gA+Xfr45xrTks8ZI5bi0j9JhJT499+CJXDbsjg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790962241;
	bh=degSFCL8GBXrw6vlC4aEoO62KiFuJl+KKm2CExtEkX4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0D/YO9vPYgNZH21DWjdnVRTEyo1APQj98faighiJghlKTjxJBDzT22dj4rId4G2AX
	 X0X8pMyYtlx2RNoNXbpBtNJmYP6u6abDxT97fBuMnlOMfhbW6XC3RNQ9uV/B19D19I
	 /Ke2xfMjFwIdlhJ3uvDQ5Ju7sw96FCOzTuwYKxuCYXQiaM2zJ2yv6cfia9H12Q5L3N
	 BP8IizCO2MfDXyFqpN0YKuqsgjLlYlxEk0UMNEhRsjHEIwGt6+b3yBnQ0UQTq1pbAt
	 IwGuxlZmtDjmn1yh7wbaYcro9WxwNoyh+Pat3tk9dLIbZXGBIyMlAi3ve8suqHvXie
	 hGCZtBdzC/GBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2ABE6066C;
	Fri,  2 Oct 2026 17:30:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A846D263
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 17:30:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8DD9C40D01
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 17:30:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gmYKWEYoXNyv for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 17:30:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 84ACA40D06
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=84.16.66.169
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790962239;
 b=pSa5z1LOjCzUzH5HkKiKw/FG0GgxV6ci642MjlKXplPx2IE65ibTuoVWf06QbJlF0tn3
 6JKNtAvPPDKXb/OIysLA3Tz6GFII5G9P1xUIa5WMJw91dtz07unwdxHEcQk8dtAurAh5t
 Lx4DEGtHr2LWIc6hH5XC2s7/qgRI57IcxWmcPAGyA6WDyKaK5DAxIAh2UC2VTmEQD8/FC
 s45ORQImXJP29TJCJs0/K199hKgHdd+LRQipDiliXM3aaZxGpX17QsQlyo/tMEzc9+qwu
 9oJVEckCPgzAq0/ARS+8eNl1SNYot6tLEgn+rPfSEmTWJf62xqIXZTSwdFv1flmIeng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790962239;
 h=Received-SPF:Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer:X-Infomaniak-Routing;
 bh=degSFCL8GBXrw6vlC4aEoO62KiFuJl+KKm2CExtEkX4=;
 b=MZTBwJLuuQpaNFQishUTl+TyUJKaPoB9ZyGstOSHpNsiOpwiXKMMrmC5eADlSwKh5hH3
 uSsW47eUfGpoBqWF666wI7TkgA9x08FfvmV2Na50MIDupS+aWGaiq3PDc765ztvM+P/f8
 mna/ZcPIXtpDvyDpmZ7QRc3VWenJYzKO5lYkOSBBo4LcxKLOrGQ3Y295pVKH0CSJ3UogZ
 cUN38jS5DhVtgF6OAfD0ea9RhS3DvjF2zgJFhwV8n6U7ld+ZEXN0AhQ0GXs+a1HB457yC
 lVGlvt9kpU6kJDUosPaQ2M8lgJkyRKdEy7IaoEOOKLkOue08YgMNJWxgDHNAeDxV8DA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=0leil.net; 
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=lEYIm7u9; 
 arc=none smtp.remote-ip=84.16.66.169
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=84.16.66.169;
 helo=smtp-42a9.mail.infomaniak.ch; envelope-from=u-boot@0leil.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=lEYIm7u9
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [84.16.66.169])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 84ACA40D06
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 17:30:36 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hxG5P3kYQz2D7;
 Fri,  2 Oct 2026 19:30:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1790962233;
 bh=degSFCL8GBXrw6vlC4aEoO62KiFuJl+KKm2CExtEkX4=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=lEYIm7u9SsZzkPx6o8iZfBQz+hXnYRF51DFwzPNJjeuxTaBG/esoaa2ndHobEeVnG
 Mja/biziP00k5uit4WmCTLxZEEWqux5FnSS6czrEhYja378nqgu8zYws72Tdcmu7+2
 C03IThKwpmgISMcV6HCI8PwZWwd1hvQA8NKghRydgS4cyEhfbO2Dxxu9/qI4uHDlHa
 tSASLG5dwT8RnU3sb+i9cabetTRVBQeM89EnTJbkRH2QfSDWbXHqnLBt3g6b5ztezb
 lNfO1Cx+xpD/aMeNGAWU0hRl1gH+0E/1m5T0W7xgkPLTcunFY/tU9fGN6eZMn0zr03
 8fChPXHvqHmVA==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hxG5M6M68zpn0; Fri,  2 Oct 2026 19:30:31 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
To: Tom Rini <trini@konsulko.com>, Chukun Pan <amadeus@jmu.edu.cn>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 u-boot@lists.u-boot-project.org, Heiko Stuebner <heiko@sntech.de>
In-Reply-To: <20260918120001.2256317-1-amadeus@jmu.edu.cn>
References: <20260918120001.2256317-1-amadeus@jmu.edu.cn>
Subject: Re: [PATCH v2 1/2] arm64: dts: rockchip: Add HINLINK H28K
Message-Id: <179096223164.249755.16460808091746718957.b4-ty@b4>
Date: Fri, 02 Oct 2026 19:30:31 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Infomaniak-Routing: alpha
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

On Fri, 18 Sep 2026 20:00:00 +0800, Chukun Pan wrote:
> The HINLINK H28K (LinkStar H28K) is a SBC with the
> Rockchip RK3528 SoC. It has the following features:
> 
> - 1x USB 2.0
> - 8/32GB eMMC
> - 1/2/4GB LPDDR4
> - MicroSD card slot
> - 1x 1GbE RTL8111H Ethernet
> - 1x 1GbE RTL8211F Ethernet
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.01), thanks!

[1/2] arm64: dts: rockchip: Add HINLINK H28K
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/21b49ca08cb4286e353235fce307bf9f87bd34df
[2/2] board: rockchip: add HINLINK H28K
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/64e0d6a0369e0529618d369a40f2a95e261aad92

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

