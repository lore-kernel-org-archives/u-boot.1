Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF92EC5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 20:39:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 48F63812F2;
	Fri,  7 Aug 2026 20:39:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2a5kS1y97VNH; Fri,  7 Aug 2026 20:39:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 28316812E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786135148;
	bh=y9Hnb2bHRYxL6nDfRwwLw4oSNc98NriwuGFp2MskqWY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gqFRU3WF98nSLi7UF0Vo23E/5uDCAludLpBNu55+bJ9obnKVSaD7LVCATvdRfKWb3
	 HGj1OhG+kyXirnhqcNcfM61Xpjvkr3mrYMuZ/5xrymOgTPK3e0lWQx+EQBG516Xy45
	 Ywh21/0MwdWjaepqwDNvmw5fBVMYi6+44rYA3s6iQTCQcFmZ8c7HZ/ON8pzQ+sLZc7
	 QS8+kRqdcn0G98F8gll0aRN5I6Dt1hDdmEA7zCFyJWOpQuJvVhL5NklB4irGUL8Tzw
	 DKQoS4ZBabUEkm6sR7GDym/zFtbOYcZBpmZzqBiUtx476n900w7/STSQDq8etn/GGR
	 j0UWxu0zh7mng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 28316812E7;
	Fri,  7 Aug 2026 20:39:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F09392F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 20:39:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E1EE540999
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 20:39:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Q_onWvArgsqL for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 20:39:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org F08DC4098B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F08DC4098B
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F08DC4098B
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 20:39:05 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7ee37dc91f5so1494a34.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 13:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786135145; x=1786739945;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y9Hnb2bHRYxL6nDfRwwLw4oSNc98NriwuGFp2MskqWY=;
 b=JAjAV23/2sJ+Z25a47AoQ3ms52nr5C0A1X8/KQGtVoPPcplEZs1m948c1WMd8S+9ZZ
 mLnNEJc5wRoiUUAyrD/3GpOu9Du9bkC6E85A2kOmUnLoYj/Jp20h2ZxoCK8kbixFbc1/
 H+n9u+XLOWkjm1WuUC/0Rq9psUDg7/Wx1+z/GQ2A0nQzO2QKpzSVsP3u1QpJRDRUe2ux
 3mo121j0feT6KFCnbbL99IGkDBVva7Mcm9nVEICw9oK54uzy5ymBxIdf+1naFc9y5GYB
 uu8n1WNR6L8dFBmaWaldUDaRuhgeZzdwDAXV1iCj4irXSgGfQrXQDm6J5lbGXODCo4ds
 ku6Q==
X-Gm-Message-State: AOJu0YwaeP4XUI8eGhSvhogVvvz986fqkG1sfnKEnmnx+fvk6/rXBWSb
 3I/NradWsEJg0XBkypEDpNMiWuPdYKYtvvdAbNtbeIxFQ1Dy0Ynn1vbfIezaKYC+6KA=
X-Gm-Gg: AR+sD13Mv0XhWQQTgvDZSdopUxQMnMJ4CTn+cu6xYoz4x7PRT5/caJlBRW5Crv6KelZ
 RKtLLNg97952KZ0+mTYj3H3kDWJEUE3JeW7I4fEJMcvNYfjBl9ahorldJ2A+MW97H4aUOxZmdiz
 C9+jEXwdS3cijyE9LqzLxVGaz5MXWWtwQRzUu6Q5M7wdd95wdvMgRTchf4nS4YKlyYoyBHlgzav
 MpbWCLj6PDPprOZg9u4o3+3GlL1CbJsGKE+cxHKfTD6aHIX/vdjsyTLNEeg1ODpxLzbw7hHBfxV
 J5XOmcXTKrG//1slO1hoHoUbL8noLg1KuWsNWj8cp/dzxjD8BKJQe7kgBriISKPFIx5S3KV21RQ
 Fb7X/zm3H9UcxHmbFR6OiiW/oWsK1tFTdckn2gs0K25BO8CjispjXZy3MrAZgdsB+9yY5GFjWb5
 R6m++TRbVQ+ODCHBAiapgq8NTC0B8q2w5KJB1RrHOQKM1ec7Adcp7SBv2zZgfnzAtNkdOd/+X8+
 SQFguoUfFeZ4Z/YvWjGgdvEp0fBtMOWj3vFS3MFFVWfEr0BwLulu9BNwopgqS53wQ7SDXmY9gLL
 A0bTRqLh
X-Received: by 2002:a4a:ee87:0:b0:6ae:8103:f6ce with SMTP id
 006d021491bc7-6ae96d1aa1fmr13433305eaf.15.1786135144725; 
 Fri, 07 Aug 2026 13:39:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b02be47604sm2852804eaf.10.2026.08.07.13.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 13:39:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.u-boot-project.org, emanuele.ghidoli@toradex.com, 
 franz.schnyder@toradex.com, ingo.rah@linutronix.de, qijian.guo@nxp.com, 
 marex@nabladev.com
In-Reply-To: <20260807114827.51236-1-festevam@gmail.com>
References: <20260807114827.51236-1-festevam@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-imx-main-20260807
Message-Id: <178613514351.425444.15279954552007516855.b4-ty@konsulko.com>
Date: Fri, 07 Aug 2026 14:39:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786135145; x=1786739945;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y9Hnb2bHRYxL6nDfRwwLw4oSNc98NriwuGFp2MskqWY=;
 b=BSKYWVfsGEeUSQ0OM92JE5FfQOFo9Zbo8rnXG4nIRroWThVLteuFB9Rnwip3Qlsfj/
 rFVTIax27sQWp5g2XUVsGDcONGmD4NgFy4HYhsdR0kUIvMglUJ/dhx9L6443gvJSoBIM
 NT6EFnVgr7qY7QIGZZQdqmkB3UzpZWa1y6rmw=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=BSKYWVfs
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

On Fri, 7 Aug 2026 08:48:27 -0300, Fabio Estevam wrote:

> Please pull from u-boot-imx/main, thanks.
> 
> The following changes since commit baa64b2f892890f00a377eac4a3e685472bb56b5:
> 
>   Merge tag 'efi-2026-10-rc2-2' of https://git.u-boot-project.org/u-boot/custodians/u-boot-efi (2026-07-31 08:55:30 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


