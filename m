Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21392C5DF81
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 14:58:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D11C406C0;
	Sun, 23 Aug 2026 14:57:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Tf1Xu5fzt0WY; Sun, 23 Aug 2026 14:57:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787497076;
	bh=/evTNp2WD+YXygHFNRiN9AW6ETWGrqGjDML792+9XK0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FGt4F2BCYa+SrDdF6QkmxQs9x8NBIIooKxF462q7j7sT8701MgyuaNLNshFRfx7yP
	 KtoJhR/JiCCfIYxNQ4ZI0pfMM3zdP+GiBZo4ADW+5u0zXKz8wNRhLlMNEHzJ5hNQga
	 ygSPIlS/9MzCb1pEYjrERa22K/kxirdzsUbpL884AxdpSP8diPAkBeDXVPzdYxia7w
	 JinRAl0mxZLwDMTmuVIHKKkc5OPBClxes2zNRcVkyiOFKNnsdgYNtD4do9ZFdnItDQ
	 xpnzza4Uou1R+B4bdRyiJxQSEaG5XKJguE2vgDKjqd95X0evKAQXVS63MClluw1O+x
	 ejwk1cLGJv/DQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A88004052A;
	Sun, 23 Aug 2026 14:57:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 88FF3386
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 14:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6F5684052B
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 14:57:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PXiTssZ66Q_j for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 14:57:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=HbNqcGrj
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C00134052A
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 14:57:48 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7e9f1f24cbcso3117469a34.0
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 07:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787497067; x=1788101867;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/evTNp2WD+YXygHFNRiN9AW6ETWGrqGjDML792+9XK0=;
 b=HbNqcGrjo/JTPaGQqETXEi6tR9WRWcI45tIf6SPJMUeXswr8+cQNwsbdfHv8JpqeMY
 juIIciKAFIk+49x/OJAeofmsURWorhHesd1bA9uqqKj07b8USjr9rJPk1AzFxKWaGMxP
 Gj3o0jat91gZDDDvnKgvt+05Iujgf14q5cbZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787497067; x=1788101867;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/evTNp2WD+YXygHFNRiN9AW6ETWGrqGjDML792+9XK0=;
 b=YUAoHXwlcJfo4/JKJiygjafzEDptfkW3r8SH2qQLgxSKvUPPZrn+Du1/Z+4VfJA7lO
 21kNcK7IOVSoYGW1PJYRSW2zI1u16G5d5l0lsxY/NSovldgu80oN85ls/RprjfBpHTqP
 e+KRQpcBQ7zzTFbmhii7OVrHTzVKB6EF4byaUkY1LGJrmn7n/E15i2jG06bDX8j2nhhc
 o1Gz+k18ra7XCaHK9dAvqAjJmjbdQrNans2mSWvnkKzIZcSYjDWe8YsP1DB1Ymp+1Fzl
 tXSjXqMDjhHSPCmrA+BXsmnwpK3cbOq6OP1G8C+uf+ZSwEGopd1KXo836vOkfDWGTl0O
 gieg==
X-Gm-Message-State: AFuF++kiLdlN06Ct0ffqkxLvPPKCw0e4fW2JkruZG0WySHtf55n9hV+v
 QLS61w5N1dEaNeBSozY9w2aS5Ht4k+xJ8W9v62tx4sctU3DjfB4KyPjnxGV3yuZIWvIyPoVAAVe
 3Qp5PDCYF9ojT
X-Gm-Gg: AR+sD1257Y3suOBT43t45/MKxwnGQBAybBO1IG3zn1RCQUEFFsFixCOag26hGoCxQmJ
 X0M+Z5kqqpsEeTmiDM/UwYK3o72+0bsf1mIjTu171+fEN6d+oTsYUHFA3GlMGodA95+n64/n2Fb
 AGYFH1LxUHAr4dOxv1KlTmnRNQ7zpK6ozOHqaEWrQ9xK6dDGcGb6ivfeLTAgTBZfrHn6C3Eu0iq
 VBS4M2fOOVGrF3DE0z7+JfcOFjBEH2dA4iY22Nj9oRIbDRXALM5xsBqk0rz9Gm7/AKqqk+aobX+
 GV4jloGox3X5C02FUvXd6WouStDxOe/qT2f7RtM1Eb2j9pIk0i7/W7ras6ykfJLJJci3Te3ZWE/
 k6wklWZ41K7woXp782IK/8/dVTmdHHgSNvSKveMisL1ICNAyyolPiobsMceFLNxVL2ardawUr2k
 UjuETGF2rf/i/TgH5KZlyxO9xIwjdUs5xOxScrvOBkGbkiFDM+98AjwujtYM09KkAHKg3zs/4QX
 6qzTWYUuVb6/2UxLXob8fBilZjFXD4X9kk3xApFpq5bvKmLQLOIkYn4s+OkB/P20TGKhC/5TOJT
 S0j6IZUb
X-Received: by 2002:a05:6830:7182:b0:7e9:dc11:5920 with SMTP id
 46e09a7af769-7f462be1fb3mr18273849a34.8.1787497067444; 
 Sun, 23 Aug 2026 07:57:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f48fc89283sm2028583a34.24.2026.08.23.07.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 07:57:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.u-boot-project.org
In-Reply-To: <20260806-fix-dtbs-check-v1-1-2fe0b9486df5@baylibre.com>
References: <20260806-fix-dtbs-check-v1-1-2fe0b9486df5@baylibre.com>
Subject: Re: [PATCH] Makefile: fix dtbs_check target
Message-Id: <178749706686.206448.13286714416579476143.b4-ty@konsulko.com>
Date: Sun, 23 Aug 2026 08:57:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Thu, 06 Aug 2026 11:53:15 -0500, David Lechner wrote:

> Use absolute paths for src and srctree when calling dtbs_check via
> sub-make command. This fixes dtbs checks not working.
> 
> Without this change, we see errors like:
> 
>     find: ‘dts/upstream/Bindings’: No such file or directory
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] Makefile: fix dtbs_check target
      commit: 35669c04387781e8b8601ee8c26ab571ef6c878d
-- 
Tom


