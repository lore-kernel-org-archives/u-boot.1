Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA412C5AD2C
	for <u-boot@archiver.kernel.org>; Sun,  9 Aug 2026 00:34:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 858B6405D0;
	Sun,  9 Aug 2026 00:34:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 44mkXY01_zai; Sun,  9 Aug 2026 00:34:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 02583405A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786235651;
	bh=gX6G4nwZ/fkwXquzm4zs+9kUL/H1KHegBoYBYQF+9xc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BATPh//a3YUobBtnC+Ifal/7fpbK/65CurVlgF465dDXmExAY1ibKcxEIfAXvwpxF
	 EOC72HCLdmhj36nHpW0ULiuKduYsRT7YGpVT5MlcyFQkwGXSbkn/Uinypt0cAU26PJ
	 Sq+QD2g0/iomKISerUYWbGQ/QrADcOI+y6sxo2yXJ/ShRh+Pw0LZKR1zxKFSQc1q3j
	 T5AVWSxdRvVJUwnBuGD6dkq5YMgz8E1f2RsgQtTizdY1L5sq4/51qUBtQtfBbbqHuu
	 vOUJjNHquV8a9issemVp0pD/FP6alz+tXJQ7fz/eanT+F5Zw11LQjTBWgAdA76n8NU
	 wX/aT3gfcXNGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 02583405A9;
	Sun,  9 Aug 2026 00:34:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id DFE75296
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:34:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DDB436061D
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:34:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Esam-_6Gee39 for <u-boot@lists.u-boot-project.org>;
 Sun,  9 Aug 2026 00:34:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E4A9B605E8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E4A9B605E8
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4A9B605E8
 for <u-boot@lists.u-boot-project.org>; Sun,  9 Aug 2026 00:34:08 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6a1f7f42510so604156a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 08 Aug 2026 17:34:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786235647; cv=none;
 d=google.com; s=arc-20260327;
 b=SvDc5bzi4rTImwnestKOMsTecBgNc5pN6u8NdbUOAHuqLt0cqyGa3BoXXicS3TUWzm
 H1PzkuhCpikQ5aJ3xNII9SqyP2x40Z+wzp+Po/74aar60RWEGuCOAHpbpPekigcNADqu
 p7Y6A3CH42igwIUPZqRdnw5DjbiR7Wt82HetL2pMNPgti2OAKh5ku2oVkhaWC416yvjP
 4d9wwg2ygPgoVg71jm3Ksku+wfzIC4s0FQSfSeOof2JsGfnfTNbjQEAxgucsMGBjUrIy
 Ul5qNQXFOgLNl1NoXgDJvg1hspm6zZkdLYtjrTHtHbUGEBkdEoJnL9O4niKQFC+cNsrz
 qfMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gX6G4nwZ/fkwXquzm4zs+9kUL/H1KHegBoYBYQF+9xc=;
 fh=8ELUOjKyCW5zjNkDVsUi4ofPIdn1lZF/cGwENRhulfE=;
 b=ZmhzqsnAunrKV11ugQ4ovzBwufKKONslHaLijI3n+TT/2yJmFHHSQ40c7obpyC+nEm
 wy9szXQ3c270LDcYQlda0vcxOqBVaH4nZaDkiYg75QiMUHiWfAHNOw4LuOJerWzMct1T
 GrNi7nvGdKHFVXBKfxanggRnibzG+t2sjjNfmlnWpLy9lmdKWJDtFBDTG/wv+1mGsSvP
 elWE8xhxjlkiO0dqIk3xyVR2s5TuzjUeWNqxMD8MFmtey9HQlwMgHvV0OUGt6AcVXdJI
 PONWbrtyxApiEmR6viuPF6oboUhQ0lpv//gIC6hr/XrjyaiXbV37/KiCkEy0gWI7HBwu
 Ib5w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786235647; x=1786840447;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gX6G4nwZ/fkwXquzm4zs+9kUL/H1KHegBoYBYQF+9xc=;
 b=Dic00BseIXVfoP8dAfc0RGBzQYGnH+e+N6Vcv1hedNO3+v+s4r+88H6MevsUk4FIp0
 HFxCch4Y5giFSYL0+R9QQ/0JFxjPHf1cbDC3orUpkNDvrmnm7sOn2oYjO/UDuany253Z
 9MgAptKf8cBa+NnBrUr3elCElliRKc0HymN4jpFzkQlB9xOwoi8atB8phstXn/Ezn20x
 Njo7PmKa9LygYGHYO85pGUCTgj9MOGZJm016XNXmVXVCYrDFMyyIYXyU91BhrHryFODW
 UAUr4LCshr7XPiCf0qSiP5Xf3EJ4bCOyFWIqykNGTiCT5+s2oxrYdoIVgYlOJ86p+G6C
 jg9A==
X-Gm-Message-State: AOJu0Yz4j/OqzXmR3AA/lK5/aZ8xGVkacFvhjOGRy75mvU0fieG5MAuC
 Z9Ch/ejS3JJvqxolF1+KiofsQVMat3yfX0Mcvl3N1sTuM5cZDTEAozch7Drb3xr4IEFQxm0ckLX
 d0r9q85fjOd9WyJrr5+fTTQD1xxD/Lb1Mgt06GP4LCi2Ls0L+2a0=
X-Gm-Gg: AR+sD11A2S+37RzQ/2ZEXwKtPsniqR9EmKH+tMUH5aFz9FM+ReO5C7uQHA816fGvhNF
 mVkwq2ExngYppX8nnJRnaJ+LaPYpivwE5rFWDGzonYiGKmoH0oXJ7QRqLj5Cunjfo5zZ9eKxUO0
 s7SwgP8bmlsmnqqYw/Zw4IWPBmLEWxVf2hvI/rky51ISO1eFiUKq2uoRdojwXjJyf80L0AYwhdw
 eMT4LEGUInjBRlPYXA+eQKhOJx9t/JbUp0PDM8xuVW4YLdaDCTb+e9pTnC6wLYctqGzW9gjNthE
 lNFkiOhAPUEMRf1l/Ejp0LW/l5ZyulD5LoZGIWaK4GU=
X-Received: by 2002:a05:6402:380a:b0:6a1:1e25:143e with SMTP id
 4fb4d7f45d1cf-6a14f07aa0emr16164512a12.3.1786235646819; Sat, 08 Aug 2026
 17:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260802213530.134789-1-marek.vasut+renesas@mailbox.org>
 <20260802213530.134789-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260802213530.134789-2-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 8 Aug 2026 18:33:50 -0600
X-Gm-Features: AUfX_mwMP58OgxCFAJNr9qznfwYbM0quT6kV4PGnS41waVSELbsOh1uTP-fXNo8
Message-ID: <CAFLszTgshz0D6HA54tEAL03iinAdfaLvOagQsviT006ke2Vvmg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: renesas: Enable verbose DRAM layout print on
 Renesas R-Car X5H R8A78000
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.u-boot-project.org, Aristo Chen <aristo.chen@canonical.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786235647; x=1786840447;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gX6G4nwZ/fkwXquzm4zs+9kUL/H1KHegBoYBYQF+9xc=;
 b=m6PcyuUDcQLg3XWsZJrlFcITS9ZxxNfZYenKBTe8oEsJYX0UeZzSEPQcOGexDqLN2s
 7JJOSNnj6fZOfEOqiduQyJcQq4HNq3X2PV2jSEFKkWNz4Cy/mu4tpHOHw/4yxP1h2QwD
 TyTU2/4ossjAgkO+2itV6iUd8XKzqWl8tl5Nc=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=m6PcyuUD
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

On 2026-08-02T21:33:37, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> arm64: renesas: Enable verbose DRAM layout print on Renesas R-Car X5H R8A78000
>
> Enable verbose DRAM layout print on Renesas R-Car X5H R8A78000
> to inform the user of the DRAM topology on board.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> configs/r8a78000_ironhide_defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
