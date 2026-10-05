Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A5CCA5FF0
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 08:01:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F340D4066A;
	Mon,  5 Oct 2026 08:01:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EYzC27Z-nPnL; Mon,  5 Oct 2026 08:01:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 3F6B840641
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791187311;
	b=IzmoSY21V5B2NgYQjUbWAdJBjOCwGwB5sIwOKYgdR5nXm88/GYMAba+uan9cDSfrhGLI
	 hu5/2Yyrqklh5U6bQl8I7MYUFPFtJz+TOrWrs3OkyEDddIopCLbA63n/Sxd67hg+WLHBc
	 q2FV8ACsrlJf3k+9lRDoWPuE4D/jY0sa19Hn48ucApzVQk9+LJPSLjd6cNGt7aoolfYxP
	 Mas96SKSZNJBsIGguMWRq/KaJHRH9+bLQFGBMaHy15fZmqnlQRFwz6XrrnPCObJDpsh1M
	 z32kgU4tQV0DBFDlBHsqGvjBmn58mt5Hg8I4o4e5eExV/KaZpgKzHlDqQRZbZGGEPGQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791187311;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=34PlZHYTXyGP+ZQql+zUBwpR3TnlunSHN1IJ5DZTaac=;
	b=T1tky7ib2bhfrs7LbfGmCFoDGXgX6paota7cMOyZ8j3eeJO3zMx8WCIBYAuhdT5BcLSN
	 pCYYjCZMb3o1TtgjJQzvXY0o6AbIF+VA7wAuaeYUXS6sI2OjtpLGpnFlUom2IA6znl8Ci
	 90cwZjHe14Wtr97fsNADxCBgxaQZCCFzLKs+UXYPOJ/kNMIiYYiU4mzRxVyZWLf9rgLVS
	 q5j79M1beQ5+JxCXjdLh/A6rmKEvw0f0OLwIUNxrnua/dbaiU6Njb92x1HuQLf5mkFnuS
	 UPCm8YsPZ58qy4hP5tBWA8ppNoQTU1hgwpnBdxAKJewMOSPa5vFbakUY0e/+2FQJ3UQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Iwp2bHIr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791187311;
	bh=34PlZHYTXyGP+ZQql+zUBwpR3TnlunSHN1IJ5DZTaac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UjpK5gzYpGrVN+aXzZjPinJiJg4/pbDNXe0MVod+3kVZl4K71vuOSS+0YpCnNW7DZ
	 8iJL76+SrnfvwSKmIkkH99FC5o5aWGHpD7j0vyOgnaVuCIH9HU3+a7VK3wRiHYtXoQ
	 1e5wlhzfP0yIKW7VR4JaSlWvamTI4h7TyGPyFkbOTsio3Wc2pffnH2EuspER9apWdB
	 G1u14wRjRCOWoSOy+cvJ6KjRip7txclERrcAUGzSIvHG9ZOyWS9YaYbLKo0RkldDkC
	 mkZ3W/1U6FTc8OxX8EtcHkF9iBixJ6dKwSxkZANu/M8XXpmeZuc9u5A8BXlGgLx4xC
	 X11xlOQjDY/pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3F6B840641;
	Mon,  5 Oct 2026 08:01:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D5D675
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:58:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3F3324060C
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:58:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QoVECoyR3L1L for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 07:58:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 415434060A
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791187104;
 b=alIvI5v6cxlk3LtA42f8PsYUGeiELMBiJhU56kbmzMSqd+SDCJwhDNTUGqHUAz/Hhsx+
 M3MV4i2nKopm0TRF0LEljOwZJ9mLJ4VPnOlHauychesxwDSiqmjwIyi5SIymjdUvNtWz4
 zT7mIdurBZLCaBS4qhJpw7tsSiKSJ9NLQHqXDzGYjyP5WbYDoS6/7Qfuj/sz4gJr9asoA
 xjPrX/LpTkBvZyhdKNDiBuYn84pGWf69oAN9vE+lWWJh02d0vvqWgYDyMI+1tSKTledtt
 /12f8JCi7SZ4j1hBMZCtnS02FTgC3H1SICTUVNfnvqZo/HeNX0LmmBAc3+tZmp8LAuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791187104;
 h=Received-SPF:Received:DKIM-Signature:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-MBO-RS-ID:X-MBO-RS-META;
 bh=34PlZHYTXyGP+ZQql+zUBwpR3TnlunSHN1IJ5DZTaac=;
 b=CO/8Xz3QvSeWBQ43RGJkFrNOPv+jqdMiLMwvUaPjE2bkDKCQ30lFjNOug9G8gZNgGKRJ
 rkVYFFozCtyYwiTskqWp9rW/K2CM3AbwwGr7zIKSBya6dzUwtNtc9l9LeHm8suyTnhuEJ
 FJ28aaQ+YpTr/R/HsBaYKRpEKfCrgSBAVolZy5zzn/9DyTf8Wo8+qDn2tt4o8nxh93hSP
 pfGeuKMBdzxF3+295LsHIsXSYaHRwhMy1b1uTajyLW3Dk2P6OND67wwPDGIRnTytDzmx0
 VruvdxaeIVMfpajeeSHNGKEZ6lHPxzaROmzDAXyXGQ11Apbi3HPkC23OfpHRIUIKyYw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Iwp2bHIr; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=stefan.roese@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Iwp2bHIr
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 415434060A
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 07:58:23 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hysFm4ByLzMlSW;
 Mon, 05 Oct 2026 09:58:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1791187100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=34PlZHYTXyGP+ZQql+zUBwpR3TnlunSHN1IJ5DZTaac=;
 b=Iwp2bHIrNwLk55094cYwkNo5AhMNIc6pxG0KhcsAnPN7x3XiS9xzVyLYim8PwtRBcppDfD
 QHn1RfTEQHqnab8F9epB/66v1IoXDdoPnv3j7mJ8Dv9iiq44EUxRVS/FXzT3tmYLrLOQmg
 ylvFbdPhtXvpU8NvxkbKuAcefMaB7OQtMbctmH8tfQTyl1y1UNLjV6vNXU2yVz5K0TgfF3
 rUenOn9ytx/llJLLswOtEZ2oIVSScHy+Acb1cKcIXlIEbE9DLAmb/sYA2sbrEFFajQOaUj
 vKYhxXuQjLSsIYZVc+DQ4lh3tQwWslIexYY/TTMl/1qirZmqT0VH6mEYNclrVw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Tony Dinh <mibodhi@gmail.com>
Cc: u-boot@lists.u-boot-project.org,
	Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] arm: kirkwood: remove obsolete configs for Zyxel
 NSA325 board
Date: Mon,  5 Oct 2026 09:58:09 +0200
Message-ID: <20261005075813.601288-5-stefan.roese@mailbox.org>
In-Reply-To: <20261002-nsa325_configs-v2-1-56dcaf092b29@gmail.com>
References: <20261002-nsa325_configs-v2-1-56dcaf092b29@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1c147acdb8909e04170
X-MBO-RS-META: mdxfyd4ybmnaa19ya6b9upzf7o33wi1s
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

On 02.10.26 22:54, Tony Dinh wrote:
> Zyxel NSA325 board has been updated to bootstd, remove obsolete configs.
>
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan
