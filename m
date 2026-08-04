Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D73C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 13:06:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80ECB60762;
	Tue,  4 Aug 2026 13:06:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h_C3_pAUj4JR; Tue,  4 Aug 2026 13:06:27 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 68CF66075E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785848787;
	bh=x5s9fwlzZgWs5WTdDzHcm7mVPCLlYz0xKoNs25zJv2k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MkdUhoe9II2hqtRRYeLkbhywJWK21JXfG7LqnCkG8GbJpbxmfWkgbMawF/D2impg9
	 QEkTImBSYUb18xc1RFwX69OAx9rgLxMIf7tTsISfwN9gLCY1bb627YPhzPYQnfJ4QZ
	 Ccp5yEd0Wo0efUITExjkc4iFQm3A7DDR2PRI3AUlLVI9xGLfQFofxHUoK15vHBAO5V
	 JRNG4LGGEAaQq/kgsh/Ekanw7BhzjyhR5n+QjUbiIc2aA89H4MaVNTr6VUi/aVASVQ
	 M8OQEqXhRZb7YdnBV62W+td5r98ROkjeW94zwK6o5wDzp9XgJxAmESxsIA7A2TItgt
	 Hpf49IXvQWykA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68CF66075E;
	Tue,  4 Aug 2026 13:06:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 49AA4218
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:06:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2FAD2400DA
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:06:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I6su1ehOO-TU for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 13:06:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 876E040071
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 876E040071
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 876E040071
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:06:25 +0000 (UTC)
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-ca12086c06eso3608627a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 06:06:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785848785; cv=none;
 d=google.com; s=arc-20260327;
 b=QHmvaZVR5FwnQ85YWZfY7qUdT+tYsBse53pxxkNqfJHnLSWmCyVD3eTDY9y8rCD7d+
 afWIFwTA3HnumuBYxtkkKqtzCaCTunwGW+nlh0HCJQXWR6YwU3gXrORTan+U2fdUMOQJ
 f+07dsu51bW09Vj1BQgZ8WMAMnoQ0VETXzAwgv2hkhR4dEGgz5XBPxYZjUrZIDop4oPf
 1jADG3BA5eeRqGCigAL4pdkgoI7DlckwURYIt1P60tpJJSe1XX+xqi8ojofBfH44oqPT
 ZShNoiF4DNQBchXmGbBMLIAleLFeY2mOYui9pwVP+ZgwrbALtxCKBmQEl0BEvt7hFJyh
 ulUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=x5s9fwlzZgWs5WTdDzHcm7mVPCLlYz0xKoNs25zJv2k=;
 fh=Kycz0RmuF12z7/MfMEx/C/XJlPwcni/aTJr26m8kUJU=;
 b=UMwfGVbq7UfdobUa8VgA1rl8mDMgqP1KG4W1bJiw6hvQzsO1imGxhWPi6hCnchO1jX
 Y5HKIDxyFpG3fr6UpN5PwtK5cvbK2t8Bd475vBybeRhcli6FVfEvcSmWHXaGJ+TfgYkS
 k++5g1LSKloL39IqUQGP+sPmjHtDgmul50QlWEvtIfQtw8X4wXIJFtq23Or44bB4rPQ8
 nUtM0eq7DkuQ4n4he9nIQ74PzhgS63Br1eErsAno03O3cSOzpJnFCb53t3kNCyYqbU5p
 HTawScR+0jTNjTev7S5jzkbi+Locxz7B0bc4Eq/K4BY36KPbSLMJ2wxYStaOSFdK05Hm
 dTNQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785848785; x=1786453585;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=x5s9fwlzZgWs5WTdDzHcm7mVPCLlYz0xKoNs25zJv2k=;
 b=OT833LvxfB3hAYpeFZVRUaLYuDHkllezUopxC+qjmkjCg3SBpgp3gyvKv4nRFK89iK
 BH+kraPwq8pm2UboSXqF5mcIk0S1BzvobSVwd6advgXNXYmx3R2G6HVYPDSDAc2OkOF9
 bRonoADZ6fAalTsj4sMAvEamosDB6v5WMjN4GLgfLZXccVzBcvsKW1uBhx1HstOHmAWU
 XhnYh2QNNLRRvnilJoPgQ2GEKX3jl0DRLbmj50emf6WPpuo2TLJaTPsGkQiN3dfB4kNU
 iLaNGOB/7Id1X2QzJ1v7U+9mXPQVPeHkwlPF77GOvHkxQdY1N5/65WCxHpSDVXf5QG9C
 /S0w==
X-Gm-Message-State: AOJu0YxKlr3PXqKAfyOuz5JiKXlI0LeQmeRhgqHO0WLLtxVf7aa6KOwg
 LvrrUB+fDQAbAeAkuHWUcnx8KgarPpQxOGg6BmykDfrU7NIlDquZyXcNv8mOIaIeJ5UqBmsoavs
 25Yp9MasljBPEz+wLG+i+saQjcao6uLHO4btNVYvUSu9DnXwJ/JU=
X-Gm-Gg: AR+sD13PE/qTx1efKnIKrDMTUdh53jPDEjhdZ/8lfth80axEibjVU5HySThk5v7YyGy
 2Xtl03H2ZQ6HTQECDvZql5zZeISjNSnKOjLBMPypad5BRy+gx3Ybaa1YnPWiLVpYs+fPk6jfmlX
 d0JFPNmL5rlpFQko9x06CLG4ykpySYCb6j9t+KHGUt5YPJFc+O1JnW5MeWPzLqGFuOGPIIwwZd4
 EsZ/8dj4V9xT5AAmck0CY/f9tzir83nD5NT9WXRbt5K+aXwzrJa6HMinOgSByn4a99mXxxhf437
 Y1UWbJ6BM9A9EfHmOsdSH0Bs0/nWyJY+ksGrMvYftnk=
X-Received: by 2002:a05:6a21:114c:b0:3c9:1c8:2b60 with SMTP id
 adf61e73a8af0-3c92a94eed9mr14869466637.65.1785848784647; Tue, 04 Aug 2026
 06:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-gpt-4k-v1-0-a3f1f16b53ae@flipper.net>
 <20260731-gpt-4k-v1-5-a3f1f16b53ae@flipper.net>
In-Reply-To: <20260731-gpt-4k-v1-5-a3f1f16b53ae@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 07:05:49 -0600
X-Gm-Features: AUfX_mymL5P9AcYRQ-nseJVM0Cn0PSWawZEAG5doe7k2yvW-SivhiCP_vbunxUA
Message-ID: <CAFLszThUoePoxiM4XtGrOyMBhvAFvknRcR4y0=oq_vhDuP_+wQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] test: py: gpt: Bind the disk image in
 test_gpt_write_part_type()
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Tom Rini <trini@konsulko.com>, 
 Anton Burticica <mouse@ya.ru>, Javier Martinez Canillas <javierm@redhat.com>,
 Simon Glass <sjg@chromium.org>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Quentin Schulz <u-boot@0leil.net>, Kever Yang <kever.yang@rock-chips.com>, 
 Jacobe Zang <jacobe.zang@wesion.com>, Jagan Teki <jagan@edgeble.ai>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, Klaus Goger <klaus.goger@cherry.de>,
 Tim Lunn <tim@feathertop.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785848785; x=1786453585;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x5s9fwlzZgWs5WTdDzHcm7mVPCLlYz0xKoNs25zJv2k=;
 b=nnqYhzVS9waQmzlay+rS3CMtS/4RplrJH5zbp5sgG+RuKQddXQwlGhuXXAvnO5I7sq
 odY4F8SJY/T01Ep6SYJN+hRWCb5aUIbzSk+E6ZP2WO6gsJOXFB9aV/qDnO3skQrQkr4d
 hYI1Bvg77rO3YlXFk9hruvphm9cwXcMbEqopc=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=nnqYhzVS
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

On 2026-07-31T12:39:59, Alexey Charkov <alchark@flipper.net> wrote:
> test: py: gpt: Bind the disk image in test_gpt_write_part_type()
>
> Unlike every other test in this file, test_gpt_write_part_type() never
> binds the disk image it operates on. It has worked since it was added
> only because some test that ran before it left host 0 bound to the
> image this fixture provides.
>
> That breaks as soon as a test which binds something else is added
> above it, and it means the test silently depends on collection order
> rather than on its own fixture. Bind the image like the other tests do.
>
> Fixes: 7a598e633a53 ("test/py: tests: gpt: add test_gpt_write_part_type")
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>
> test/py/tests/test_gpt.py | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
