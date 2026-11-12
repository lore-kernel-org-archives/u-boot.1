Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4B8606A31C
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 20:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qlCAx3IC;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ff5lp6OJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CED1840D1E;
	Thu, 12 Nov 2026 20:13:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eROlTf0v5aUv; Thu, 12 Nov 2026 20:13:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2D3DE40D25
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794514428;
	b=efWJkQoV9F+cxWNgPaQXWMUFydYTqiCOTxDxO/CAFKX6XdrFB9V6oR4err5P2K7Sn2Fk
	 bMAtX4CdHOD26wwB4nUfnadcQso7z7h60j1CidwB4rs1WLI6ayWAH6Y/3wpvG9ufmGWl6
	 AN2QBfA+n6TDPRpvm0nxni6gqGNDSBpYqbmVnlvAiSAQbwjtYDQgnkTv8Xu+rpzUwS355
	 Cgj/byaYkvrMuqhgA6Ihy1XCefEj6HVSVmSFxEmSr2PI5krX0srBcRKDau4hd9FMBTl4Y
	 OE1r7v6+nNQ6bZZqsXxqqz1sCFiu2HIGs45pfL/YurP3JLxKzF595k+spT0yv+I1G9g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794514428;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=nRwbChdoZQ0Xlc5U25gElO1h+ogyxAcZc3PAuh03GTo=;
	b=YnjXj4GKduRCu1UurPvchD9JdV3oSL+y9Lqvkz7EoR1N5Jy3Zcwxqfw0FuZy6geVgut9
	 FdlfPMZhsx/JCLQT6F1R4Y15XPs98A2qrLUgeoqw3gSAPp35L86o+hV7Lg9J1q/EDReSB
	 KKNtaI62hfSyDUqHcOCUdW+VKW37IlwEiQ99byObox3XGyQlH8oazpxkByQ1TTrxXjVYC
	 4R3LJtslTIvDqVa9ZfHsI/jIOFOsi9jPxE7MnDsgb3nmeoLGvm8aoKc4Egn5JboyCbY3w
	 SO56wGtCM5mzkolXfC2uXe6J2Y737q6DjBAO0cgHYTB+ECELjSw30qLzF3RS4dqSE0w==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794514428;
	bh=nRwbChdoZQ0Xlc5U25gElO1h+ogyxAcZc3PAuh03GTo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qlCAx3ICfTw7ishPPNV7jTzJX5V6DSSRvWMEy0MM+OXf6TgN7OMIUVQ5KknADQ4NU
	 yagUHOBwOh1En+V32J+qbolotFeC6qEJpGHFQVSB5N6xaLldGOZktdUivExueGxiUZ
	 G4diexFJTnUvE2I6T0lQJouVjK8R3wj2bC9cyS58CezB1QMGqqgl+e/weq0e9u9jLB
	 nISd1gvbi5rQERu1pVVYuijejHkFYoPsgdb9aavxVDQoLjeYT/DOANZELPtEo2ceIU
	 xXi9sM1I28LYyRdltt+BcGK99rwn67vNozGF345nNCqrhdQ0R0Pq+NreN82ZTUMaJV
	 J8qALHtCSMfhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2D3DE40D25;
	Thu, 12 Nov 2026 20:13:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E9CD31799
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 20:13:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CF8C581544
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 20:13:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Wm8gtT5z6Z8V for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 20:13:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1E16C81553
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ff5lp6OJ
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1E16C81553
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 20:13:45 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7f84a55e31aso114087a34.2
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 12:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794514425; x=1795119225;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nRwbChdoZQ0Xlc5U25gElO1h+ogyxAcZc3PAuh03GTo=;
 b=ff5lp6OJadVnjqzFT39nM7IfcQup7wOP6CtSOB8hlE3d75gKIhW1dA+CWpoYERhalN
 CCypPy7BL8ofAWOLIC95bxsYrU/t4FsOjYq5JFrmYNsRdhUlKhNu/79F0phvixJzY3NN
 e7Ezzplk3fyOeY1FylHFpW+/SN3E+wKKGMQ7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794514425; x=1795119225;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nRwbChdoZQ0Xlc5U25gElO1h+ogyxAcZc3PAuh03GTo=;
 b=I7p2dRw33eiaraH94l6TAGJOVaRTfrhI59OuJ5AhQf14XM3Wjo/1SRev5E6EljpLYi
 fI4AjRGgIdhOQRsqditIh9LF6t4Zc2zDK9o/MnQcreBoXD157yT6eKgc1VFci6dZWs0w
 JmD9V0toZ4679skv1soMtG8RmYw1aK5T6VVkbkFJ4sAlA/REoFEVSUsp+SPMSZYmIp+C
 enb7/zFvj1DhQKoV0F4rXl2/Hu0QUUAmIliDqMv7L5W075e6d8dIgIDcXvfntG0a2iiF
 4bcxFvoKJiFUa/LY2x0GHe7c7C3CgvR6vo6rzVEA9g3OVbYaJGF1REMZiTu8lLvFDls2
 CLvw==
X-Gm-Message-State: APuU4Z/BPQ0kQzlhqw5wl3OQhvW0ZdHRKp/7EB5nYWoJVT6L+xafTTOf
 Utlc5AwAdEh18PCGStj4uQHTUT5ubNETxjit59v4iEDsBb9TwPbVaFZVtj/1MIeqS6w=
X-Gm-Gg: AYBFou3VHVyYv08kMxze2xfPPxtyQicHKJTcN2ugCeQtY+VvH+pdliLHNzygGoYeOFf
 UH9I/jQToyMmN2DMvrti7vLM2vn7iptE3+GvHhhOgHtAALbLCj6Uz4I3OEcOGWm/VZ45e6wDkWr
 YEhdl7dYg2DxdpNwQACBI9aau3//DMMKzUFh0Y6zEVrJBLy7gi6SFk0Z/gnqWHrnFKvkjm1WIrI
 laJcW9asZUDVyus+Uo4wK3D5wmjQJnbu2w29GAQaOtlxeCo+MMvQlIYPk6F48UEjBRlZorTKVX6
 9OLEJ4Vz/ANTl82HpyoALKIWQkv+WYUuSj2A5sK7yTe7os+HsVKKtT+SFChQYMOv3gPiPTwHkue
 9dVawzZc1MBABd47sMM9ZehlkoP4M7bWacD1WPN6ujLvbGrvjc+W25KK+4FDA5wB1HYOlhn3RFK
 +7LoUEa5G3m+aD1p9IFYJh41k8VTR+3FrJ4XDVZGxTkYKyWwduSXVYesWAzv+09G8gDwdf2PNeX
 rhfK05hLe3ho6l2c6cl+GUCb/iBlRpmJmABgT9leetnu/6j8pz3SeBgSf1yFS/kSk4JIbWjvwez
 cbgOE4vxpdfIUNintfFVjH1YXR1fPJNGzjdKtCMXrUxRdn70X0AG/WGDS2VcKKYSOuRWKM/Kutt
 giIny6hCHFlB/xcrcE/7Fy/JMW/JoLzoO9M7nZqA1koHfyh7Hl229kYR0P9ViAGnLDLLEczhZdh
 L0632c+ctVe+fO1aGlMjPcSOctndooMQ==
X-Received: by 2002:a05:6830:34a6:b0:81b:9d18:75a with SMTP id
 46e09a7af769-862898709f8mr258640a34.21.1794514424657; 
 Thu, 12 Nov 2026 12:13:44 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-862880a4e4csm613222a34.8.2026.11.12.12.13.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 12:13:44 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>, 
 Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <b8f8cb8e-2bac-a529-1631-dbfdccfc6aef@nabladev.com>
References: <b8f8cb8e-2bac-a529-1631-dbfdccfc6aef@nabladev.com>
Subject: Re: Please pull u-boot-ubi
Message-Id: <179451442392.966571.10823870004725589400.b4-ty@konsulko.com>
Date: Thu, 12 Nov 2026 14:13:43 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 12 Nov 2026 07:01:21 +0100, Heiko Schocher wrote:

> please pull from:
> 
> The following changes since commit 8ea02c99391d2d922810065206721ead2863f075:
> 
>    mailmap: update entry for Viacheslav Bocharov (2026-11-10 14:57:48 -0600)
> 
> are available in the Git repository at:
> 
> [...]

Merged into u-boot/main, thanks!

-- 
Tom


