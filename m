Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA15F606A335
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 19:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=K1G7RIDb;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XbhnmOLA
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 711BE406B2;
	Mon,  9 Nov 2026 19:28:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GAft7BEvndsM; Mon,  9 Nov 2026 19:28:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A8DEF4061F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794252522;
	b=YI0reyngUhhJsgJ6ITzPhdvYKHSL7tDFaDY+SH9x/AT803BMDXvIeQte7Ly1oYFrVJBW
	 iVD1Hhf6thapdicbP+fXRHeyMJGEnlYQ0gGC6tBp9J/siWOHgQNChpPrVMXc8NR/gj9MB
	 CpZe6ZJHHO4cAEfR588jzVRuqoqhJ6EMN71A0ikq1AwMnnoSVV1IaVvNg6k6CeZcJbD+0
	 /rUfd5eRNWTQI7gZ6rsNdNYObvg5Idn7P2HITj8atoSWVvHldfh+futqvDVh2UMzsUFox
	 XsHPwFL7JPc8INWUTdYtDv0H2op5gGegxRvzfxTOVCA7UvehIcTzb1VLrviSZIYrYtw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794252522;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:In-Reply-To:References:MIME-Version:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+uJyQOcCGtkbiqqQCrb8C1kZk3Od50APqq70Pcj3vow=;
	b=SUX6w8HsKJIUUVs5u/8K+NeKICbPXg6kAAH3BlTLgjFUEE1OpTlBblGTmxLsEhdnzLLv
	 1uV3TFAyXAL9utXtrZYc7iyM8t0JXar70abtcmH+nMdUxw5LfTRAPGPZkS2q3EP28hdkX
	 y5Ajmhfevk3/rKwNkmI6AunagM3Si0zrhYNXLbiGK4gPOFYCrREnyMp55oNEWH+v/bWSS
	 ThWqReFrfxX989hdajNsqPObxOsbjubRnOVQmLYWtbxKDVhCjeqqNYMGbaUm3+RcCepNa
	 Db2u8c9ArHIEfDypNAiy722u4ESuGzE2W5lT2A7xPqq6QI2vQvfNATVeFA3k0KnxhyQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XbhnmOLA;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794252522;
	bh=+uJyQOcCGtkbiqqQCrb8C1kZk3Od50APqq70Pcj3vow=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K1G7RIDbV+AMucW5KnPgeNTNohpYc1+NUig0O0XYIrTBpTAtD75nh6oJHPjBi5t0h
	 eznK6RSH03adJDdsbabsRAKee6Zi6MNO2h337ueGlsnBXf0e3dy1rys21XLkX2gGu/
	 WLbqSQnNLkN46CLr66WCzb6w30m+gcUV61CaOONOtNUxSdhNrgp8dThgdM18ClOUc8
	 uZiuXXEhB72d/ebU6KSH7sOI+sOVKm9QXBQkg6sNrWzTVWspm3Nh/IkwenmCEI2DBu
	 3YmuXBC5UKJW/zNKnnMJseK0FokNhOa1O7ORYGlEpk6E4JtzUadrlPqBcgPfjUk46c
	 dWETWPi7VKiEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8DEF4061F;
	Mon,  9 Nov 2026 19:28:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 73506335
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:28:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5907E4066D
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:28:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rZ_gWC74l0zG for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 19:28:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 593134061E
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::22a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22a; helo=mail-oi1-x22a.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=XbhnmOLA
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 593134061E
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 19:28:39 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4f55a53898cso569476b6e.3
 for <u-boot@lists.u-boot-project.org>; Mon, 09 Nov 2026 11:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794252519; x=1794857319;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+uJyQOcCGtkbiqqQCrb8C1kZk3Od50APqq70Pcj3vow=;
 b=XbhnmOLAgBvplaRzWpQCgw4fdNJ/uBVbwxpunlw1CBTjM1vW5BVjWrc1Tbvrke56Kj
 jPxZd3Jrs8BBC8aJXkLOY3kTbrV6rbAI2LXCx2Eem1kAsOm8T7Pi9txrdWFVYrIn0n4n
 aXAVBgS9I/ZsGWlPZySulJX6crpSNYfJPvs78w9Mi8VI8bsHwM8ZpTMeTBLYR0UT68aN
 DuTUNKzFg0bqmx2kElKYxUXh5qlpAnrH7ZovX15np9vBEhWN81BKQkOch8lGIWSdQjo/
 /stcsP50Csxh5e66+Ttf/P5LAbAkQ7XPVMAS+vUNJpWoLv3O9yH7FHgqBljPIO40izvl
 c4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794252519; x=1794857319;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+uJyQOcCGtkbiqqQCrb8C1kZk3Od50APqq70Pcj3vow=;
 b=ZLz3VCDUrMXesj3zfhLDMH7DZZx3kf+d3l0hoc9t6EmDb8a4bMs0i4dZCohTfWvi/h
 UNeDLg6KcWowv1V6RJhDItWj9ZbNDn5yCDI0meG1ZxDFTyPkR1pHDt2M5p82WQcoz492
 b2oYob+Enwa8c+he4E2RA5ruVsVVCh7mRDlwx1NqnvsTCcRYewIPK08j2WWlZxJ/wwXR
 ntQAUhAmx4YZhqnGFUg2NH3NUYpZPT5X+Wll7ImsQQ4KYQCuUNlKg2FwFvmaHIIwt/10
 p45J/qsoXPpz1v/sIDIMnOp7NMEiqIx9E5rnwcC4u48kweO4/yrlHStk6H0OGGEisPLe
 7pOg==
X-Gm-Message-State: APuU4Z+CixjeujfhhBabtWF5KLLxNg/2ZXdWsAX2rNK7uTalwpZ7FlFa
 YcVhgjlrP3H9KwEY16YdVYEEDpk1H9g9Yz+apEPPYH5cBCHojlyVhQlyl58sL1zcDFkba3kJam7
 ig2jmG/KwsQ1d49ctJUEFgVxoyow1h5s=
X-Gm-Gg: AYBFou0GRsY5YfZfFwMcSZsuQh5dmBFckoYoVVolv7Vcb+xB/bhxGV2MHOqq6VXJYJz
 C+ZVis7l7d7II2IlBmmKW1Fxrl5J/Xj7+jpTT82DaVKlMnAZVkYWdCTdWSuXVbhA0LEn5OQXDRM
 mKdfJ8aliNm1nIuMUJQM+XhwhOhkdoATTOsVJRUQb+9NAnIH3yN6fvEWUmgPK7RAuzdOsyaNa1g
 8R4ozwDEQerB6JkEnaxaC79RaYgKYVZIIKs54ebrDJcVN9O0rwyYenB/QTneAvJzGblCIucLssL
 L4NkhzXAbgB2/kygVx7PhquQsdYrZ19iKmQdK1o36xt+guxxxUOB9VS3rscpr7J52kG356e4TOJ
 9E6ChKC3/pnr0KVKqu9hUFYxUlJ0Wu4LbYHns7g==
X-Received: by 2002:a05:6808:319b:b0:53a:e153:e8e6 with SMTP id
 5614622812f47-5683dc70072mr416327b6e.59.1794252518989; Mon, 09 Nov 2026
 11:28:38 -0800 (PST)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 9 Nov 2026 11:28:38 -0800
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <20261109181638.GR3741582@bill-the-cat>
References: <2399d63c-ddd0-44b0-bb81-d5d9d2a8a8b4@gmail.com>
 <76cc4bd0-52e7-4362-8aff-489f17df1466@gmail.com>
 <20261109181638.GR3741582@bill-the-cat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Mon, 9 Nov 2026 11:28:38 -0800
X-Gm-Features: AclHuK_5G4D5X5HVYJab7VSWa3_MqZ4SoMi3pl9cdRuGtslzqVES6VlpBn_Msyo
Message-ID: <CAJnxHsgss7B-pUoUJc0sf3dhd_UdhUJphGCqtj+M1v=rcd7HBw@mail.gmail.com>
Subject: Re: [PATCH 03/11] edid: Leave the timing alone when no mode is valid
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <u-boot@0leil.net>, Andre Przywara <andre.przywara@arm.com>, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

On Mon, 9 Nov 2026 at 18:16, Tom Rini <trini@konsulko.com> wrote:
> I'm a little confused, sorry. There's two drivers which use
> edid_get_timing_validate. The Tegra124 uses it, and falls back to a
> hard-coded 720p on failure, intentionally, and seems reasonable. The
> MediaTek driver sees the failure and then turns off clocks for the
> driver. So I'm not sure why any of the functional changes here are
> necessary or a good idea, can you please elaborate?

Sorry, the commit message makes it look like a bug in the current code,
and it isn't one: for those two callers the timing left behind does not
matter, as you say. (The 720p fallback is in tegra/hdmi.c, the
Tegra20/30 HDMI driver.)

The caller I meant is the third one, display_read_timing(), which calls
edid_get_timing_validate() with display_mode_valid(). Tegra124's
display_init() (tegra/tegra124/display.c) first fills its timing from
the device tree, then lets display_read_timing() replace it from the
eDP panel's EDID, and if that fails it carries on with what it has
("Failed to decode EDID, using defaults").

Today that works, because the Tegra124 DP driver has no mode_valid(), so
the first detailed timing is always accepted and the timing is only
overwritten by a mode that is used. Patch 4 makes display_mode_valid()
reject the modes which do not fit in the frame buffer, and patch 7 has
Tegra124 pass its size. Without this patch, a panel whose EDID only has
modes too large for the frame buffer would leave the last of them in
the timing, and display_init() would use it instead of the device tree
one. Patch 2 then refuses it in video_post_probe(), so there would be
no display at all, rather than the panel's device tree mode.

So it is a prerequisite for patches 4 and 7, not a fix. In v2 I will
drop the Fixes: tag and say that in the commit message. If you would
rather leave edid_get_timing_validate() as it is, display_init() could
instead decode the device tree timing again when display_read_timing()
fails; I can do it that way if you prefer.

Thanks,
Ana
