Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A026B606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 21:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=xah+wJ+n;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QnKxhupZ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75B27606A0;
	Tue,  3 Nov 2026 21:34:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JjoHaE0SkkpY; Tue,  3 Nov 2026 21:34:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B99D2605E8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793741677;
	b=KH0B+ESmH7BTtBKRIXODHH9JdowbyVgO/1xETlV90PY+PV9d9XmpBMJkKg00yONks5XV
	 az4201jyxBNohNLwYwV2M0HOg9+YC2wIpQ/8a67stNsIpApFBmklCy2PmoLgVa0lI26la
	 gGUd4Dw1mdx3vas0IAa4cbvCPFvNhAGqaTBDR329NYTERSasQcfqGQvbbpg6wddaHhN5S
	 a8weMyOSIYQsA04+BvaVfwyZcStWBpIeU7/JeKy4BvhVSDzjcaPsYBuLOFNJwnMk7Twv5
	 A3q941FjpOzaLLgUjmhixTs/uPVBrzrFy3JW3Iev5PTIIwd+4mZb6BHBZrPH2sUFeYg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793741677;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=0itQkzXwV8tu/jIF+OuCDb+IawoTd9RYHRWse3jR1Xc=;
	b=FzS815pPrUIynOJ2bmZyb1lnOrD23G4MrR3/QT4X0hfKE7Oekyivwb6RXk20BS8pHnTr
	 J5opNOZycKRdvSH18NhhgKpzzFGN5NPjrL25oW9C7lEEELlx1FILo3MNZOjQxmc5sCmP8
	 SX39IMpqxrbE9QTe0UAATNlk3KBn4KVAc3QBUJRDBkm9gndJxJuwWQHYvvmYkR8+Kx4T/
	 PoL2VXsFKlnBCVX0UJz7Ygl50Ja0hlJgh4B1UKl20XtRGVAq+eM6y6BPDreWttIYR1XCe
	 W6vjs5ioU0sfpUzpvWCF0lTZxQmQxm1z4At8FNHMdsp3srIQxzYx2p/LS8it10BToAg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QnKxhupZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793741677;
	bh=0itQkzXwV8tu/jIF+OuCDb+IawoTd9RYHRWse3jR1Xc=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xah+wJ+nmUUhh3aaFOf9AjNKwehmUQzf1noB+5s0SABGALw48zScYgRwLtoPyd7cN
	 M92nQ8cNmtT4Zr1gjNLk+6TCgGmhPWWdQ6i/cd116EaKUj94ryl0Xl6Sl2y19CDoPV
	 apnYJ0cTfSJyp5IDR9XkQi8/VP/TZ9ZxxR4bw1U7melCeL9KWobsw5n4vHCsGZTh0f
	 w5OnQSVsTav+93LcL/hu+IoqggK9G0g8qcszFG1i51MXPX3W48O3z72RLzF2vBXh2e
	 8/Fh4pCBBzIwcKsZ1g4lXFAvjP50vXuU3HVBD1T62SiyJSz9bXoM1cdeZziM4jQAqL
	 pKYmkAXNE6zew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B99D2605E8;
	Tue,  3 Nov 2026 21:34:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id CEEEF2B6
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:34:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C0A2A60698
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:34:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zBA4U8kqdoEW for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 21:34:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8C90C605E8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793741675;
 b=d706Ku5C6i3WlILJr5lCmV42qyKi+lL+LruBcZP09uobVR0UEQHEkPQFx8XEftzknzoe
 Ox4sxq7Fg3fJAFFf8aJS+ogrKQNG7O9ZWVoR7DjeuD1Qsdngi4Ihx2eeslSHqYZMGUgfi
 YI6NR6tyrYOLgXJXkZjXaM6Q/A3ec97oJayW424gk9WAw+DaGmFxPO3oBG0kWFALwp5G9
 FgfxAoYGOxy1a9nHWvYCxZeNr4hQ1YyzvQ8R9kq9lrcd9faKMrzPx/gCdCJy/TQf8AGt9
 l5Wh71w6+aUnTorsOk1HxGwlyh/D/co7+C79cFVHIFZ2fye+HSl/bWUIt3/eq5WkEOA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793741675;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
 X-Developer-Signature:X-Developer-Key;
 bh=0itQkzXwV8tu/jIF+OuCDb+IawoTd9RYHRWse3jR1Xc=;
 b=DQx24toQfx8l3WknyBwlVh1TA/bMsJA32v656Radg9+afWVJoqOP5dzbwUm5t8ZNRZKM
 ERRrXMi12qD6kBSI4fLYNvMMD1vSii8q35YrgAUPWjwg61C0gES87EZ6H6hr8lkopkz0i
 fSLm05PIPTMPHLfApdvM2H6atBjWaHRI6wtXyOYTaxCgJPsa5cC62nq/9kcV7o7bfBL5q
 2zwN7diYfXZ5PNn5X2xRkB1XFMxbAtsTmgAYzlu+/tadYm48kyXVTghWKPNDnGK8gTOQu
 hu8i83t9zA3xL6xrM6rv8VKSBklrSkqTmobA5YQzFnv+d1gNuSxgdGavoc7P32USt4g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=QnKxhupZ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=QnKxhupZ
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8C90C605E8
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 21:34:34 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so118565e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 03 Nov 2026 13:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793741672; x=1794346472;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0itQkzXwV8tu/jIF+OuCDb+IawoTd9RYHRWse3jR1Xc=;
 b=QnKxhupZPzhNOFBhFibnQbEBs/4CUpM4tYRAlNwvvfxaagT01Oxq/DfYSccjoXFiib
 s3VINl+me0eCp+7Sl1ws6JcHVxnEObiZ4qfI1k7XG5YGwUE4cwBNBx6o7/PZvMa54DhV
 u4dIeorUfIkZSiQMfbyjgnj34Y23M5IQygrZ4/12kdKgRT6FT+W7d4SJhDNWw5TJAe5U
 p3N6VXlyz0/UHv+ZZcH2K7aU7P4boH6jEzaFbF+sTPNKf7qrEWUwGl7y4swHVoq9eI8B
 rtoxwJfvqm7ptYHYN3AfFepDGS3ChFJvr31NlTl2NHLuq5xOaLtFLLGbYbjIesBbihS0
 DKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793741672; x=1794346472;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0itQkzXwV8tu/jIF+OuCDb+IawoTd9RYHRWse3jR1Xc=;
 b=EREqA/uTmBTHEsGw10HofsZGiqA+i/VlrcQyoU2QL5sUsuI24mFocvxe9zPeGavS8c
 daNHKqK0hfNT/yEOdHyYLJ23bx9fpMhNv3xadlw5Xki/lrC5S3KABaQNd8HfvJ7+YIIa
 T1xviCoStb7ySOZHQEyyHhYXqZbzeIy4vaTyG9IfcSRQcC47pBRK0aU8NC4B5f9PKWXo
 lfElumC8R6Eg77Oyk71ZRqBJOm1Eg7LpTJdFcacD8IkIPp1Ds+h5eiw+YLkeRcjkXjre
 ZWwxcz89llDX0fVJgQ9r9F0ZLyQpk6eBpn/yFwblzjn2f8DeIQDst5QTrGoeiTUcshbg
 epfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxiVjDzFZUuEbDmqtQJrRSDoJwLtToE2gkq09MJQqUYB/YwpYXpNMZ7nxBskCuXjvZ41S4LE0s=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/ASkeOZJmmifXtTaNUn7S/47pzFDjnQJMFeSYnkGWyuaVf6Xnc
 NL3i2JIB7yifYcdOe3DXNWUYnfNlViqlyMd6ekG+/Q21SlSI2diyiy3nXj3vTFAeu5c=
X-Gm-Gg: AYBFou13tGvjkch8aC5whtAj4uuPZWw2gtXkeTxHk59dO0PO0IxikNJEOqRkdF79xax
 ipeRIwYLheNmjnqYd5/go6slIVv8uv/bU7mRXDiut3jPmNJCYfzR07T/1gbylgraBwqDgfnwjIO
 VvNmfykVowmuGWTc1exf9upICIghUyyiLPqrH2lHoAO0Ong1OSgdMKkH/ypoX32yKBxHVIYJyxL
 DlPq10elfSMKEbzvAnPTcb7vchtssNIQ8pPgHEw1GfZErroGzdeZnR8ZcN3ubxtl2Qf+e8pezSM
 pb4gaClDZyj61sQ2stsuJ+HUtvVWblph5J0lD6TBgadN4UmVzzSVUyV3FRWU38t9kCTZERYR3Yh
 ML08ccz8VpdkUCT/roELYiTyWslXPXC03DNiDItbdHu5Jw3ahqk5WBeUH5tK1v1agGJqvOZyNhe
 1XWV28o1VNPsChyDwgJvoyx7gWp7RFL1vww/aSzD+lbbW0zgM06wna+luGLEdsWFWiuaIv3Bca7
 wEBv+LoVoxmqL+CP1819JbBN9lhWE+4275JzHuvxvwhqhDcRMqY3gKVlnO6DEWJeQah72+PSl2p
 kKhI8g5qRDZoswrV4Vn8V58Sz1j9its3tPFMhDHpMHEfSbWlWLXE
X-Received: by 2002:a05:600c:6208:b0:4a2:397:73fd with SMTP id
 5b1f17b1804b1-4ac182dc32cmr330406175e9.12.1793741672114; 
 Tue, 03 Nov 2026 13:34:32 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43a48adb7sm3246585e9.1.2026.11.03.13.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 13:34:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] spl: fit: reject failures loading an explicitly
 requested FDT
From: Guillaume La Roque <glaroque@baylibre.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, York Sun <york.sun@nxp.com>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sam Day <me@samcday.com>, 
 Pengpeng Hou <pengpeng@iscas.ac.cn>, Alexey Charkov <alchark@flipper.net>, 
 Kevin Hilman <khilman@baylibre.com>
In-Reply-To: <auoNQw4AW5xbCpqL@macbook>
References: <20261014-ccaione-upstream-spl-fastboot-boot-v1-0-d29df15fb9b8@baylibre.com>
 <20261014-ccaione-upstream-spl-fastboot-boot-v1-1-d29df15fb9b8@baylibre.com>
 <179370057186.349126.13750066367082256700.b4-review@b4>
 <auoNQw4AW5xbCpqL@macbook>
Date: Tue, 03 Nov 2026 22:34:30 +0100
Message-Id: <179374167082.3704535.4800495642296364214.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793741671; l=1133;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=eIXVbI4tcJwmyTzV9XizbGaes62NAvoBpFh+DzZxDBU=;
 b=6Em3gcd9E4X7iA7eIuzXgTFfZb9YJFM0ZbqI04fp2Z3+cR7SCz+0X43bu+aKPNfzKs55/JvcN
 XGB/YfJdkNeDxXEmbQkVWBdyxiLTF0/4tIu6rtfsr1jqE/+5RQPEgkT
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 2026-11-03 17:50:46+01:00, Carlo Caione wrote:
> On Tue, Nov 03, 2026 at 11:09:31 +0100, Mattijs Korpershoek wrote:
> 
> > Hi Carlo,
> > 
> > Thank you for the patch.
> > 
> > 
> > What's the point of initializing fdt_addr to NULL here?
> > It's assigned in both cases (whether node < 0 or not).
> 
> We actually have a way out if (node < 0) and (!gd->fdt_blob) and the
> problematic path is that early return.
> 
> The problem starts in spl_load_simple_fit() where image_info is not
> zero-initialized so ->fdt_addr is basically garbage. 
> 
> When we return early this garbage is copied into spl_image->fdt_addr.
> 
> Even zero-initializing the passed struct doesn't fully solve the issue
> because the helper also receives the main spl_image, which is reused
> across boot attempts and can contain a stale FDT pointer.
> 
> So, setting fdt_addr to NULL is the quickest fix for all the cases.

perhaps talk about this in commit message or a comment in code could 
be great, otherwile :

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

Regards,
Guillaume
> 
> --
> Carlo Caione


