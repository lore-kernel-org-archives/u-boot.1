Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E211ECA5FD4
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 17:36:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 78DF040D9B;
	Fri,  2 Oct 2026 17:36:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HelFCp9GQ3-6; Fri,  2 Oct 2026 17:35:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6E79A40D96
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790962559;
	b=prVy4sy+rnAC2wmLNnlEL63wq8oAiPWlBisHNGk21lnEuSLrBEv4X7P6TEsWY1cn/rLT
	 J1cZ8UyV4j6zum17W/O5EsWEotiVeNVCeUV8V0vASmx6z49kDJj19+ceYe8bOCkXKWCZM
	 OGJbrKE0XQToQeZ6DCVmINzDP8xC+74pyVbGZu2AxzbBnQNR78d9aquOTgoQ6XUL5vIZA
	 Ys3YM9ymh9qvfFmyvu1BncAY4bZe/W/GNmxat4TBDtCdIBVit8pWr9rJN4UqPwdScnNQf
	 tNPfAha4DKYLzvEdMOXYme0hhb9rwcWZ+H0uRvLyrbLFSZjvuti+Nemdml11na2qKjQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790962559;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Infomaniak-Routing:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=5S1jHHGw4YoWMDqtK6beoTg00wh06aqR2k6y5KgNjEs=;
	b=FKI3gI7wdr3xSI8Y/t8wade9hu5J90BCt6oGtkxmFxd12mrHqMhy4RHFzc4S33YOFhSb
	 TveVRVjqViLKOmwrMdLRoMARZIar9st2kSeN+hxxECnSYifBsuDwmKQJ6Ie1NKJ0fw5FS
	 ab6pqvVPREs1+i6JxnbVo3wEh7dJmKE3w5EMTAtAsEfW8/I/0zw+M1CP4/iBVzwIxCQR4
	 U/GXNm9GDZjulnGOKuc5ohKHlsbFAOH0/HhV0JEmkbqw2zVaAE5RguDSx7weyYSRpu+1F
	 UcrKpGwcbZXNNR4glg5pvCSLGKM4osOxIg+aZysxH5UNpqzT0+41bvhi+KVfA+PHY1Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790962559;
	bh=5S1jHHGw4YoWMDqtK6beoTg00wh06aqR2k6y5KgNjEs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SYV4/whN/UBoutzyNusA4ZlfFe+S57P0RXGPjVZilNASTyFa+Cc5E3qvjuE8ysxkK
	 Q9ohfx9C4LOsDwcz4WR8Gl3DOgmmMlQ7DqtyeGI/Jbn1fBUrIud+lEqEsbBY14jT1u
	 T51sYxiKDqUxrtPzEP2yHnP/W1eiAMXzBFvV6BWc0TlRquhD8pXKuhufmkLDSXNBEC
	 CMGCTb6+n45FoJYZwsUCPyCUkMZgYPA9gpS/wXN9u7J9E0eN7GZKS2zFo8zJJ1RBRI
	 j8PMSxF5m3vlpp7YvUft/crGAIfu7YALltdGcJW8UuPwC3+346f2PTC3yiaHfUHtAr
	 KztCTzYEcydjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E79A40D96;
	Fri,  2 Oct 2026 17:35:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 62514263
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 17:35:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 600EC404F8
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 17:35:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6qw30GNIJ7DS for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 17:35:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 8D7A8400F3
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:b8b8::190b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790962557;
 b=YWej5G0c+m30tifDXlu7mnCaTRhaIqYccffFA5sLSxIi6gk1oGl7N+sJzRedncZIezCI
 9ejNpG/sYEuSsCZOwfUYDn/uO8xz5jsYfwlgViaH7VnSNaVHdkL+6cpcZrPuqt0rkYA6y
 GxVRoncAYywnqzjLTbizIYVeD6De0ZAIv10tRlroWGKkb3HOxDFWw9N9nb47KWL1B7Eol
 N53V/00sA2M1Iu8QcSgp25N6AYY3x3Ul35FcfhezshUwduY+GelXTUMGgHyOTy27CZBx+
 LCh9j5WNXoP0jOt71dM6W1/3l3qeykvq4EXq6kq5l1ENPTn5Y2oxT6SFUdJU6b0LnOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790962557;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:Received:From:To:Cc:
 In-Reply-To:References:Subject:Message-Id:Date:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-Mailer:X-Infomaniak-Routing;
 bh=5S1jHHGw4YoWMDqtK6beoTg00wh06aqR2k6y5KgNjEs=;
 b=bLYUnaNgWcbGq3ti+jhfHVEXqsr60mDGlcAxV60uYd3OXTUvCvSPgqXw7/IEKIKOEnGI
 eNyJOHtAHsKWMvI9Ifo36CrqvTTilOdoo5GZVYRXrLE34ZtYgFaWzwoWjUtXQr6MnbQvt
 EwHDRbC4hM97SfYkU0dsaxora+VEhNEntIAs0o8XMLnqdvWhnT2AtIvYsuo3gTOPTptTK
 jLSvWu0yhSHhCuF8w7ibtLB4v/lzBpTw6ymz4j8Go7MDtCbYcwxRQ1tM5YhuQEaLYeBOe
 YzSHmDxhQkhSIL8YavgS0GDCEMnwiLE1Xmjq9yylgfllaA48WsIdvg7EqV3IuCxhE8A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=0leil.net; 
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=gVhCMRag; 
 arc=none smtp.remote-ip="2001:1600:19:b8b8::190b"
X-Greylist: delayed 319 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 02 Oct 2026 17:35:56 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=gVhCMRag
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:b8b8::190b; helo=smtp-190b.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [IPv6:2001:1600:19:b8b8::190b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8D7A8400F3
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 17:35:55 +0000 (UTC)
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hxG5Q2F0Gz34l;
 Fri,  2 Oct 2026 19:30:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1790962234;
 bh=5S1jHHGw4YoWMDqtK6beoTg00wh06aqR2k6y5KgNjEs=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=gVhCMRagNGVnlASsMNO13zsNkswITSrm8oCHIYYrUkFtV85oDmUz5HL8/D3+VK7au
 c3sclH2fWIDyT5nI5Wba1A3dBySxXh/sEhfTKE7CcoJkQjMcbu3wlfV0FsGpt34Bh2
 qXg0bslg+1RYIma2nSzap/lsmNVyAHX6DaYePNlnRmEM2Fl9qVwClIxKkJ4c+qPDJq
 UIzHLtO8vZAOKPNKynuxgpWr8bOG/ia8RdlVOX9wGxfmgDtLogLB6fyUTeXoMj4+JA
 8bI3ZbrOgg9t9WhbgLorzxjlHUwge1JaJxhs9WAb7s1dCHTU/kX7TaI6+dJQsb29MU
 Hvdml3sBG/7Qw==
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hxG5P4QWbzrR3; Fri,  2 Oct 2026 19:30:33 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260920161930.1880133-1-jonas@kwiboo.se>
References: <20260920161930.1880133-1-jonas@kwiboo.se>
Subject: Re: [PATCH v3] rockchip: px30: Fix TPL_STACK overflow into BootROM
 reserved region
Message-Id: <179096223338.249755.11834947837171057544.b4-ty@b4>
Date: Fri, 02 Oct 2026 19:30:33 +0200
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

On Sun, 20 Sep 2026 16:19:29 +0000, Jonas Karlman wrote:
> The PX30/RK3326 has 16 KiB SRAM at [0xff0e0000, 0xff0e4000), with the
> initial 4 KiB at [0xff0e0000, 0xff0e1000) reserved for BootROM at boot.
> 
> SRAM addressing only seems to use 14 bits, meaning that reading from
> 0xff0e4000+ wraps around and instead reads back data at 0xff0e0000+.
> 
> Using a TPL_STACK at 0xff0e4ff0 (16-bytes aligned) means TPL use BootROM
> reserved region for its global data, malloc area and runtime stack.
> 
> [...]

Applied to https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip (u-boot-rockchip-2027.01), thanks!

[1/1] rockchip: px30: Fix TPL_STACK overflow into BootROM reserved region
      https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/commit/b177b194d9e4af7631a23b2a9227edfcf937f8b7

Best regards,
-- 
Quentin Schulz <u-boot@0leil.net>

