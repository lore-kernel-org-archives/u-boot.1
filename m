Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FFCC5B569
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 20:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 247ED60756;
	Mon, 10 Aug 2026 20:53:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qU840iiWGkP3; Mon, 10 Aug 2026 20:53:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A7CF6075F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786395211;
	bh=LG0Hh9Lg/40lgXnSIhbRlGz56Uc8pFLZma7sCe/9DJ4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EXuET2Nq0lqsJNk/v5gSLG3360/o9MdnkDSgrmSkgzTJVQ+OnqYHSylx7iXzY0Rkv
	 wFonHUy8G0hDjXko+Ffo7HyJelEhhSYAhqcnldLn0dsF7gAfoP1GklP8JfMJwHfg5h
	 0u6p109pzOfjdSXZ8+w8/z0FuwJY2KA3wnB5rUIWokzk0xrU8WGzxoXZu4sXrlmDKA
	 F6ENSWT6gD2yFah4aExgtUV3CTWcACk6JdIPYAIa/vDS0ZivGIWYASQE5ZJphf9FLO
	 3tFyvuwgx+iH8BxSp/RLW2pII+vhlpu4etd2WkrE/a/RO2OaWYWKFbFlMNvK81bIx4
	 YBuv2tfrTkq8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8A7CF6075F;
	Mon, 10 Aug 2026 20:53:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6756610E
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4D9E26075F
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4_mQ7CFbC-eZ for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 20:53:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c2d; helo=mail-oo1-xc2d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9AE8460756
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9AE8460756
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9AE8460756
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:26 +0000 (UTC)
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-6ae542c486eso812042eaf.0
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 13:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786395205; x=1787000005;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LG0Hh9Lg/40lgXnSIhbRlGz56Uc8pFLZma7sCe/9DJ4=;
 b=srfbThp0FCMDAP4MUeXu8PQkNgqrflM0uVnmkW0m48Py71+64k/54IgF1s77ItCzo0
 LRy9KlfgMSwvmS55ffGwHorAG0qgUe6g9+MNKDoc/iB3Ho+foReC0R5C3clL+qHDusye
 3+aHsRZFrpIUGh/Yrw1HS+ftAp3dCtVMEPaVHwXBrMb1pEKM2V+Wh0oMyjcjV1h9am4u
 yIS5SDF82OkbZgSNin22g99YZ3W0yMCumD3h/O3uZJm97IpDyVKIVI8I3Y/mY4n98q6I
 FHhhjzmnCjJtgtXbPYKuHDNIQHlYJ1208qoeIYdiwWMpJ7zw4txJImG2+KMHfsQUANrJ
 9eHQ==
X-Gm-Message-State: AOJu0YyiJT+fKuTtQQD68UmYntSeZ4bS68uU4+dMtJn7pKONkfgDzQKN
 xdlJ3kH7CgKFKyKfANx44zHDVLdxI96LS3I88YhVLRvBjdPqq/falrY9KXWLkR96QNG4Kq7adid
 6nuc0nNM=
X-Gm-Gg: AR+sD10akWuVB6LW4lDlh9g5yDQseCVgoyuSBje6RQWLm12Auyq7XIy/gH4dIegrC3G
 QBxjUGD5tieAZEfveoqu3YnB4gAY0Zx1e8bTJwQ1CzmCr9AoZR/yTiHDSiifbd+NXxKOJZ8ltWt
 OlJq8hrByF1GGv39v19A3+8FwI7tf61cPd1Nge9v615UdGwRHw2wF0nOWDsx/9/ZalBSs2WONS2
 n/neX036KcrdRccwcSoSbMsopSZrUbsMZPZxgx/SDWXkuRXTkkxZ+XSaTk7HHFJ+UnWwcVQry0y
 yHYzZ48Lcl1+mXwvku0Wu3XqkPcuTHBqHC3KDEuTCmm6tEl2spf98q/7TGDGnq7eWIOVNEnVZy9
 Okaa7/7tNVi/MSFNybxMDC65eZTT7yoQ3aQWyLDjtaXfv8gWP3j7t7MF4BUEkEMbu2r+EmC+p5e
 C7xJcq6PPHsAYNfrZbt57dK+8chkPZVVPOU1NaQ+NxiUsAk1KkpyKQjfThnmaj9jO07DfpBg6hD
 l3l+Cz/UhItXPkpWUL9HkS/ARAGnTQ7zjO5GbtVrK6N8u70HdgI8QIKO2P4lvnmwxeY47zf/BdZ
 WO/N2RTI9FTuHE+TwtI=
X-Received: by 2002:a4a:ee17:0:b0:6ae:42c7:ef95 with SMTP id
 006d021491bc7-6b041f7ff09mr10606721eaf.13.1786395205529; 
 Mon, 10 Aug 2026 13:53:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-459f1a76701sm9061652fac.5.2026.08.10.13.53.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 13:53:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: sjg@chromium.org, Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260730034316.26353-1-jayaramudu.desapogu@amd.com>
References: <20260730034316.26353-1-jayaramudu.desapogu@amd.com>
Subject: Re: [PATCH v5] serial: coreboot: Accept DBG2 subtype 0x12
Message-Id: <178639520476.1450255.15124101510420097800.b4-ty@konsulko.com>
Date: Mon, 10 Aug 2026 14:53:24 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786395205; x=1787000005;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LG0Hh9Lg/40lgXnSIhbRlGz56Uc8pFLZma7sCe/9DJ4=;
 b=FF0hyo7GJnuuQxSTuJ1G+5c/Szcyt+WvzbboGCt7L7Pq3t6VVHK4W+yLlCRDlMVzH+
 fM+B2isLn47KeKApXuTf+pN3bs/vpuk2iLZPzl533SIxmB7WS9oEgVvKg/gVNw+qRgZI
 Bp5oVsihlzguvxsOgCcrio9yM5cBZ5X9vWvnM=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=FF0hyo7G
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

On Thu, 30 Jul 2026 09:13:16 +0530, Desapogu Jayaramudu wrote:

> U-Boot running as a coreboot payload obtains serial console
> information either from the coreboot table or from the ACPI DBG2
> table.
> 
> When serial console support is disabled in coreboot, the coreboot
> table does not contain serial information. In this case U-Boot falls
> back to parsing the DBG2 table.
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] serial: coreboot: Accept DBG2 subtype 0x12
      commit: 780808133b756261c1c1a0aacb4c7067fc97857b
-- 
Tom


