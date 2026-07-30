Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC6FC55160
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 13:38:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A156E40A81;
	Thu, 30 Jul 2026 13:38:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MPu-66xTV2sk; Thu, 30 Jul 2026 13:38:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C492B40A93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785418723;
	bh=SE2QJa61TKvwSyidRBUkhqKv2AmRnDEku5a4fClDlpk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LAtrln5DSQC/N6LWOO0bNYLja5d8HODtViIbREn/KO+rBMXUfDWRBTGb6Y3WI2JHn
	 4+IYHwxMyTrj2zamUvJo141EX9bznOr/JB5T5yvCVAjlBikfSqHEU+B2g7ztrWDYLp
	 9wk66ubvkwpHSvrygjDV+4j4yYctAnv5MAPxpWMzhc5EeMFtiFKrXYoHRAedbJklKv
	 3gEkEPQXCA8pTMVA2ginWo0VFwgC/lCbXz+SaBSQQgIua4OPGn4LQJHSZPA3/L1XrQ
	 lXPLeY0hxkTT32eXTpgqvs/LjNoqvaHIpbvSqEzVwukgmDRaUtYfgBlxHoCBZ63IzN
	 UUc9JFGqKtRMQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C492B40A93;
	Thu, 30 Jul 2026 13:38:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C5FCB27C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:38:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC3FD40A83
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:38:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ikXa5u8WKJDU for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 13:38:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2b; helo=mail-oo1-xc2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 0251B40A82
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0251B40A82
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0251B40A82
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 13:38:39 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6acb63301acso393389eaf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418719; x=1786023519;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SE2QJa61TKvwSyidRBUkhqKv2AmRnDEku5a4fClDlpk=;
 b=NSB6O1mZ0fPDPV9gxZEU40jrTMH3crG/yvQgdVwSLgZWnpAZcN5SF/S0coQVL/MnjE
 q5qBueawyTsO4TvpvZF7cPEli5+AXQ6xsZTihuCVGNAB+oMAaV4bNZu7hs+W8h49wFgT
 Z4TUryTH60zB5wn9qBol/haYdqTnDBh2ha8UZsjSay3gXR9PlVzlTSpPpCBTJ+fJAlBN
 teciJHizOUD6+McBwdJr4T8xyYXbaznWMRUJGPocnFD+Vndr7qWk2U0Br2mAKWLYTgzJ
 SonR7qloz2ZMBznE6r5CdMBZYOp7nQ8Ls9+jcGOkEnSO4swXpRBsn13i+8LUMdUQFSOr
 BVjQ==
X-Gm-Message-State: AOJu0YzvsTktg51VJdSi/02PGGLslrXqA3sDwyjeZJpH895rwWrO4Suw
 dm13isxQZuC/OL/2e9f4DA98kPH66KKN31e3oMaIE76CmymO+eeq+vkF5j5q9sI3a3fsYaKaC85
 8zrdIy9E=
X-Gm-Gg: AR+sD127eJ3ZN9+JhM3lyeT1wbfcgYhe8KxCM+TD2kBS5RQfuu82wxeFYOCwviuuGfI
 xWiLXadHW5lx2d+OhmE4lVEi9c7KMBXNuJT5GyNLDtrzGrGpnvwU6/RFmYtZ3REUCq3sa1jRbEi
 0WRmW+04I8k298/rAKg2uS/wZMYw86xqe209eXieG/vStx+Yid4Yi1o4w6o6Tq05eNfebppQfqU
 RaY95MoRX0CN7jaGhweWpWOhmfmRKPqkyEe8gRib2a6U7rQMwuKu3v3HYbbvliIvJZVPptEg1ql
 2IcqH+vHDprRiR9OKhPzziFTP4cf0Yq6KYkJwKXz3oES+6Ydv5rdpl+FdfJdTQlJjGg0q5JW/kY
 1PqaYYM/V9aCjmgl7dDpm9pHs9OjvlqLl8tRnbuHmUbj4ZQggYn1FvRMeueKZtK/Uffv/aW4wRs
 yDlkaKR+I3mqh+3WaHvM1JJJF7qzxyTOsbIkjHI4NWPfq3GSr8MimJa+x2/qlLnd/o83b85tYCl
 WA3gkQmySaCC1dJjmeugtAEwXzHBx3ryTCxfbdegdQSrYu7bVgnJRPXbC+XgXLP2U9bDrhvBhO8
 omxNcp3u
X-Received: by 2002:a05:6820:821:b0:6ac:a265:84f4 with SMTP id
 006d021491bc7-6acd2dcff61mr155674eaf.29.1785418718946; 
 Thu, 30 Jul 2026 06:38:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6acbc554a5esm1457983eaf.10.2026.07.30.06.38.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:38:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Denis Mukhin via U-Boot <u-boot@lists.u-boot-project.org>
Cc: sjg@chromium.org, dmukhin@ford.com
In-Reply-To: <20260723005203.36715-1-dmukhin@ford.com>
References: <20260723005203.36715-1-dmukhin@ford.com>
Subject: Re: [PATCH v2] x86: add support for CONFIG_REMAKE_ELF
Message-Id: <178541871712.2173019.2328046083263926006.b4-ty@konsulko.com>
Date: Thu, 30 Jul 2026 07:38:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785418719; x=1786023519;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SE2QJa61TKvwSyidRBUkhqKv2AmRnDEku5a4fClDlpk=;
 b=ZL66pFxLXrzxI6ECxbIvMJMjeqVGH0PERfrfQnSant4BQog/PObQFYcCNRN2WcNO0A
 0gfBL8SX4HHvcPtavo1+KwKLZfS5ZP2iL/V3ItgFktpLWWlvILaF6tSkD09nhHP0D8E8
 BeMZLmyXRUEFvymryJSIJKih5bhUP4N+GCp5M=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZL66pFxL
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, 22 Jul 2026 17:52:03 -0700, Denis Mukhin via U-Boot wrote:

> x86 builds with CONFIG_REMAKE_ELF fail as the following:
> ...
> u-boot-elf.o: file not recognized: file format not recognized
> ...
> 
> Fix objcopy/ld parameters for x86 to enable CONFIG_REMAKE_ELF
> configurations in both SPL and U-Boot proper builds.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] x86: add support for CONFIG_REMAKE_ELF
      commit: f6a37207b84342441ed8af4226cd85048931cc61
-- 
Tom


