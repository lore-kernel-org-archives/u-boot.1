Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01409C61DD6
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 20:42:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0FD0380C44;
	Sat, 29 Aug 2026 20:42:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tHEO3CYyUuH0; Sat, 29 Aug 2026 20:42:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788036125;
	bh=zUmaSQsugtHsYIRBfdllfpUJ+X5ruta369pjJbTsYyY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jDzu3gCr3yC8p9UJOQ60B4hxpoQFuAjM8gRoKqWH2X56UQjOrB8x+UmFpXBWWI4vE
	 RN+BsACmgk3u54NRkFCFZDKp7BolRC6ILQ6krQdc9U90D+ec2TLi9Fy8IIK0c7bH0c
	 aGsW/IzHnZONL8vr0NJPjPLQzgmHwM85Vb7AahrEWss59EpmhiteLDJ4mTP4XcJseK
	 bbHdnj65SHXUhGR4S138MjJPPHeNGGOxuuPmjSMmV/933JN5Pvn5Mbxtg8K0DyO2bA
	 oQv3O+kSpF2YdBzZ09PEP/pySIlLxyucZ07FRtd8bPvy6BOSITuh7P6XdAgsADkuvT
	 LpxJcmuDm5UfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6001F80C43;
	Sat, 29 Aug 2026 20:42:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 88FBC23E
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 20:42:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6F12C40059
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 20:42:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1nM1pNvvnNN0 for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 20:42:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::329; helo=mail-ot1-x329.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=a7E30pDw
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B97B140057
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 20:42:03 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7ee4f241f42so2916015a34.1
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 13:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1788036122; x=1788640922;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zUmaSQsugtHsYIRBfdllfpUJ+X5ruta369pjJbTsYyY=;
 b=a7E30pDw88OcAvB4xfChbWELR8quWCk1Fi56EPU+nmYgmKul84mwcaiMmBoCpFBhJp
 akwIhMUCPcAylyc9rs3ccqSNk9ZVa1Dm5gDLEChaL+VDvImR9X+OvO0nUwFAstxj9SUi
 zxBvFEqb3IPqNVDSem6fnwdufXovfMIMa8SOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788036122; x=1788640922;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zUmaSQsugtHsYIRBfdllfpUJ+X5ruta369pjJbTsYyY=;
 b=EOFYaCKeXKmp1IkZR6aDzQEJQBB4HGbJbQntQiwGpYcOP999vNymZPEab+Wcy8ZoW+
 LuqHtxXZlSvslV5zNXXuM6Td3L+Ov0jWCNi7jlntFUmit3FanzO7t0kDLgL0+OIr7O03
 /IENnIuXVKm4+aPGeyBVZhAp65vee9oYdD7+Ci/aZ0RZsGV8aH7XENTtAKazyGm+MsCo
 scli2hAPE8bi7O6E45W9EOm4WodYVodT6LvBFhIQZxehrraBNYWalt5cwKShFH/cNijT
 fj8bzFsRcfV3BpNqN2nZNb78lQfDu0aMSJQ4HnqSwjjNbD4CTemubMcg5K6bnH9lELFS
 xYkw==
X-Gm-Message-State: AFuF++mDg9h7QUajLpP0KdjOIY/OfPnsyJCW2+Uek9AlVWDez0XFzZTL
 PwXxzrVY0xoeLKnuRHx5UOCWfNRzAEtipYcRSPgZp5Q9eqrYFDoogu3HX7wk/MpFrJ0=
X-Gm-Gg: AR+sD13ApoqjHQl4zKxeVDiatKwMu28ADDbZD+COwnopDuEgswCDX9UVgKBL5sQQb/C
 0a67c4v1bfruP6O7/vvmo7rXxOIbBZAExOb+lNrNujgXhSa15Rs+qHvvzM7wo5GgT/k89VVsHvP
 6ekqeWUrXxXAEHXS4/fYbC4VRu3rINcTpEGlFPcFVL7Qwb5elcjW7QmVA+p5NVdAEGmYKzY7RwU
 HAQHDzWcINkhMLGUWDqf5zkyT1z69G4BCl3dp5czqe6Kxlw80fcfNaYvKjNeG+dUuH41QexbYdh
 CiwHfHSTQvYk/Z6m8vVN8mPq3W2Gb/mXhnfH0AHV8haXGj6HNAM3vcPMxbWSPcF9/IiTC+9I5oa
 uLTh3/wobj3GBKeT2nedOC3KhnCmUQYaHgyU0OFlMlDRrDl4I8il0ErBmD5GAMQIi2ghfQC/jmP
 9yYtFU0nv0L4mfCx5BBhfUvx54ztJY+AcAkkiAHA1llvqaCKrx8fCSKE7de+N/OviH5lxeqofqL
 ydOSFz7P4DJu6UjXVSQE9D6uuGFEUuhKz2jh13etFfQqyiS/pFtm+uGZW1EBryNBBtnMTEiuyu+
 HE1T35BC
X-Received: by 2002:a05:6830:700b:b0:7dc:e78b:158 with SMTP id
 46e09a7af769-7f6261857c0mr7729984a34.4.1788036122362; 
 Sat, 29 Aug 2026 13:42:02 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4fa6bc42fsm4165532a34.6.2026.08.29.13.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 13:42:01 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, Love Kumar <love.kumar@amd.com>
Cc: michal.simek@amd.com, git@amd.com, sjg@chromium.org, 
 akshay.belsare@amd.com
In-Reply-To: <9a22e572783f9877759f4d2e9b661babda99c9f1.1787047982.git.love.kumar@amd.com>
References: <9a22e572783f9877759f4d2e9b661babda99c9f1.1787047982.git.love.kumar@amd.com>
Subject: Re: [PATCH v4] test/py: nand: Add tests for NAND flash device
Message-Id: <178803612135.686790.17503827893410098146.b4-ty@konsulko.com>
Date: Sat, 29 Aug 2026 14:42:01 -0600
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

On Tue, 18 Aug 2026 15:46:27 +0530, Love Kumar wrote:

> Add tests for nand commands to test various NAND flash operations such
> as erase, write and read. Use the current test/py APIs (ubman fixture
> and utils helpers) and refactor the pre-command helper to return a
> dictionary.
> 
> Also add the test_nand.py test to the generated documentation. See
> commit 8f8f0f0ed9d0 ("doc: pytest: Document the test_net_boot test")
> for the kinds of changes required for the docstring to be rendered
> correctly.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] test/py: nand: Add tests for NAND flash device
      commit: 043b4280138d45c50340c0f899935b83be4375b7
-- 
Tom


