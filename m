Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5B4CA5FD2
	for <u-boot@archiver.kernel.org>; Thu,  1 Oct 2026 16:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1467F60D77;
	Thu,  1 Oct 2026 16:00:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JkH33XrJ9r0O; Thu,  1 Oct 2026 16:00:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2C25B60D62
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870431;
	b=iuY+XLyEg1azMYb9ivZu4AQBMnvtWAbQV2pfWd8O6G5QLlfvoC93OgSDwGocggr5bt8U
	 uyMfpSzxL0+kbShZhHfcKQjWNK/0SInFUTYeP7w0fkFtHVCZYE7hP37a4JlXvMrUpcZcz
	 WoIiWq/2zm+hE/RZHwxb5sq+imHKs1/uHF9Uq8bMAkdMae5r96hbyE5cwWBvSK/dKXL+0
	 9DtgZaKUij7vm+glWI3/R54/iRLzpNOvLP7xRe+yWCDJLgBFF0QSdaJTx9MqWp7wtarBR
	 INqQLQmyAeVCJINS3gC1he/1BfF4x+5WH+8Z5b4LWIxunZuR+KjLPL3Zl/NxaUtxVeQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790870431;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=VWjBefMuO3TPeAmFrjh56WtQok/jTohaXkWtmERgIQE=;
	b=XTuJLilbEbIR7F52vtNmWvDpnr1dpq0fF+OgZOMvHZVy1Pv5MGg82q+Jjm8+H5bWEMh9
	 tCM9lFMCWirhX1e7fgIN6UI1gukD5B5C2w3H1JPNKZ/sXgEuImV+2t68TAlvpFt8QnWFv
	 0vLPo0AhTp+8g0kBtqOimqs5ifceXFkWUJ6UpMOex9VRyrbHJapkySWWt4CpHB8PPyFi+
	 FmaqY9qKXB03DBSa1ojRTC+GngZRSnYkSGb+wZnTpcDHzC50Wj3OnTIAeCCIqDYNswTEw
	 Pbr4BXdt9F0tBQR7DFw6en7MnYXQ8GK5hrYOKhHcGNJHceZ7yzx8WBHHQCUI7CM2tKg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790870431;
	bh=VWjBefMuO3TPeAmFrjh56WtQok/jTohaXkWtmERgIQE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uGqY1xn6Vpr/vuKzJ0ud5eSSXYn83uzsKelprjDLWGJ2jRuTcSKOHgCC9IJYeCGV7
	 /ItnH4sDYlBxmnCy3g2bxmMD7WfhIIxfmIQX9Tmikld2daknJ5QSU9UP4mM4HJWETW
	 XPZpoOobcf9qJIJ6ibMRncISAOCpHGb+5woCjY7A5+SaqcgTFoVtLMybM2zlHgb0BS
	 XHGRsHW6ByBrBJUjYCeLSKnVoefc6h5GGdbG77uWmc3N4ajb3CLqCLQEf8lw/Q1TCZ
	 p4PmEZ99//xhYo6QPT0yV/GGILzgnU8TMyNqGPrafSC6s07RguKc10gcLNBJztduYD
	 kU7VR9ZTbv27Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C25B60D62;
	Thu,  1 Oct 2026 16:00:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 43DE832F
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:00:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2994D81219
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:00:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EHRClqtOqGBN for <u-boot@lists.u-boot-project.org>;
 Thu,  1 Oct 2026 16:00:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 738EB81139
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:39::c"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790870428;
 b=e9y/IqfiooIKLxczg9MSp6xwzbwNJFSy15HRlnUaPvtUBewIJHutAidgibtWHv5iLtMD
 64p9oPd7Eoz1mg54FjNvm9kI3xRrYjBNw1UT4plvxEAmrhOsUcF9judcy3vzGU3jGYwmc
 VJUwVgirWwsqIUNEs4ooWwsHwle71EHDtxgDNEsgP0S/XayBx5c2xFQ9B/F+CBJ41kBy+
 Alpvtjb7N+tI+u4e/Kph4XD5+rl+okYvNQSt+stoP2Cg6c2s3mtmRv0nePMjj0zAR7MWu
 ZXqwGHF8KyBfIZ/eaOghAIZiwmheT2YCVDvK2zXGrAXpVAAs6OFu66FgCH0HjLs5WTg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790870428;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=VWjBefMuO3TPeAmFrjh56WtQok/jTohaXkWtmERgIQE=;
 b=el+9ZDuIQKcr4jvGctqm/lBj2RU1Ir8nbDYkxQcokceyGOnr8qx/ZUKmr7L1UEQTdFm7
 gMY1j/KYShs/o58Rjbckr+V4gH9oXs5pY5rBqmu2PYRGEwXKP6L1QQ3WapKQ0V0i01Foz
 aGI59llvjkddOEfa546I7+D7so6yKBi6+SLtY2HgpNDtT+nhSmGQ6+a7hFT5o5P9Ux+Z8
 iVIEFG14S7pUZJdY4KDsv/uN+OPJIQMFAZaITrXalNKO6k+QNIE5YNiZkvOpJxdmU0qya
 qMkTFkAdPJeal6/WF9tnSyo0o8ovyNSgqMZtToPR9FAUm9BvYiR8B/e6ScX43dm9rxA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=gMt6y4eq; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:39::c"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:39::c;
 helo=mail-pj2-x0c.google.com; envelope-from=sjg@chromium.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=gMt6y4eq
Received: from mail-pj2-x0c.google.com (mail-pj2-x0c.google.com
 [IPv6:2607:f8b0:4864:39::c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 738EB81139
 for <u-boot@lists.u-boot-project.org>; Thu,  1 Oct 2026 16:00:27 +0000 (UTC)
Received: by mail-pj2-x0c.google.com with SMTP id
 d9443c01a7336-2e494adf48dso1291725ad.0
 for <u-boot@lists.u-boot-project.org>; Thu, 01 Oct 2026 09:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790870427; cv=none;
 d=google.com; s=arc-20260327;
 b=jLgyXALzrlKeKDzh8P5V6PjYS5Y2a2ZxjqfMOFX21CsC3JSdah6iBIzW29Vq7am+12
 hy5S2YgnfO9jLajKw5Frd5PDbezqTZNFaGaQ4OzvyDjtZlmhyAYnhNqk2R7Q2E5I3XXw
 WouXCwEFoeP/9w5CPCNcUsXepblrumUalTTNIXE+oofsgqBU8QlBAbxYSVqTgnvSl9++
 Kk9sJGS/NpMqGfFJhJhAanUB6GinbJQ4+lfPcb1CO7VsZ+W/AvAG2PX+yrrl9nIzGbxg
 OISqSw8twoeFByBcVb7XI6NphsNXjuPS0ckRoCq1Vyo6iAFzFGycU8ljXVUx6hJRV2kS
 xVHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VWjBefMuO3TPeAmFrjh56WtQok/jTohaXkWtmERgIQE=;
 fh=iO7aF5sJ0jvhl3MuzrDCAVJjSWl4GZX0gewNaLqEfAY=;
 b=rj1HbzjIND0wqWe7Ea320SuEhx4wFP2+3kOHzPe1kWZiabCkm8CiJqeQIRT50lYTXa
 XUIQn0Y7F8C6nrKuukRSzlUUDvL4B2GSCHqiXVyuLhyds4VT0Bs9Mz0+OjFJt9f/3G+q
 HDlHgoLRg5RXVd93GK3uiJ8wqL3MVoQY6+yegM5ihV7a+7VPwQ3wNt1bGGQzVjXp7mTD
 7dy1Cy1sLWt0MByNi1998CHVTys0p7zPzMLzu1HInoKVG/uB46zVL+Txb/cHAFacBDU8
 HOzbMNXyHiTw/aQSZE2K5W0UJ0OjkgCzEbsMI+Xfk4WT8q3RBnaXQSHqbH6ZuZBbyvm/
 WVHQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790870427; x=1791475227;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VWjBefMuO3TPeAmFrjh56WtQok/jTohaXkWtmERgIQE=;
 b=gMt6y4eqBuFN0/FAyxPpxZuIytSNheZbt71Dcsppt857XXs6Zi0Ismk1KIW9XQlrxw
 4AnJ5dmrR+aaaoMdrtY2np5VUpuV87eTCp5DuJP+RY9Fq7ROSalcvyMp3O6y/v3KiPQC
 qVHWreheZYCYa8L8M2VoPRhu1Nl8GkYWTIJGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790870427; x=1791475227;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VWjBefMuO3TPeAmFrjh56WtQok/jTohaXkWtmERgIQE=;
 b=KIjXm8xRB4J6rpyI/AXF70g1seSQBt+SUAQU6hPSzcWX5e4ucTFeiDirGcvCejuFyT
 PF8OVnMQk5Z/J95l5thT5OOFRV69MaZFnHOm7urb721qhzNrvwJjDOEKuTqnvwfB1oWy
 oX1vt2zWHtOxIqEf7I92ABfgUSWjx7jgztHcoXG4SZQobifUtr/z7kPp7Ue7twi/0Xr2
 FtTyHugxwZCZ9Mi5OtpldyRPI2YxgtNBBbK9ruxafgCP9/wOhFvbFf4MVJMg9DXPlxgu
 bYxflZssUebG00eNU+rHuX9d6A3DIT/JTrIHQkF6kLyiKIz09KpXkAf4Y9t1OUvkn+mP
 l+Hg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwW5EsOdbL0iopmf16DbhOANOIyB5e2a/LKE6T38/uwEMdDzuwjLMy10Ap05zxjuYa463/uFtY=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIo2SCCw/x7yEMQPQ2c1NEQig6aVkR3DS9ks9yYhpnitnsqp+9M
 8bs0i7IvHBLZBxJSjatqecFsjOr7IgPtcyWYmzcwK/3ft2JpCeHv8kyrGubdH90EHBIndasjhI6
 Cyk+ccOFh09DwmG4PS2BEnU+c40uAleBgpHoX5nBJ
X-Gm-Gg: AYBFou1t4Oaqu523lZ0p6ooDLN/nVARzqZdbAKLo0VbHr9+3BJ4ZHfQFIoSiMKSuY0u
 tqTKR81dbOpoY8GLhryzuZNEOXh4iUlhJG1Dkw/74zC0FnR/iUNU8rTehUSnNEPIPgzqmp2Ox/F
 XAAFyvItZo2Trigg7dLBpuzecltH5pFfP9h3jchU1dwhm8C2CfgdH1pmVmxLA6pN+Hlx0VzxBvC
 JafcOzK4NQrcS2CsVYyoL3nl1tYMmQtcM2PDhmcx05Gel8214Boo1a7l1PEnhZ+/E6flcjyvNtP
 cyAqBL4TC0dQWQ3YMTHlW1Ln4hPw+0WNQZu1jWSgG6QrJffRPuYuZWMy
X-Received: by 2002:a17:902:ec91:b0:2e2:e7aa:74a5 with SMTP id
 d9443c01a7336-2e2e7aa8292mr39075235ad.25.1790870427125; Thu, 01 Oct 2026
 09:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1790626459.git.daniel@makrotopia.org>
 <9a960bc5139c79b9f60f37f8ea6255e6e8a76c2a.1790626459.git.daniel@makrotopia.org>
In-Reply-To: <9a960bc5139c79b9f60f37f8ea6255e6e8a76c2a.1790626459.git.daniel@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Oct 2026 17:00:01 +0100
X-Gm-Features: AclHuK-6vywql5mrK0iQL1hp7GS66J4KwUOG-f1IYNzG76RAocGEK2ax2Cn0boQ
Message-ID: <CAFLszThrXu=rdgnmMBZiftAKLUsCr1jPgmuK_KcDRszgFoSSvA@mail.gmail.com>
Subject: Re: [PATCH 06/11] boot: imagemap: read only the bytes an extend adds
To: daniel@makrotopia.org
Cc: Tom Rini <trini@konsulko.com>, Kyungmin Park <kmpark@infradead.org>, 
 Heiko Schocher <hs@nabladev.com>, Simon Glass <sjg@chromium.org>, 
 Aristo Chen <aristo.chen@canonical.com>, Anton Ivanov <anton@binarly.io>, 
 Weijie Gao <weijie.gao@mediatek.com>, u-boot@lists.u-boot-project.org, 
 openwrt-devel@lists.openwrt.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Daniel,

On 2026-09-29T00:04:16, Daniel Golle <daniel@makrotopia.org> wrote:
> boot: imagemap: read only the bytes an extend adds
>
> Growing a region re-reads it from the start even when the reservation
> was renewed at the same address and the leading bytes are still valid.
> The translation table exists to avoid re-reading data that is already in
> RAM, so the common case of probing a FIT header and then mapping the
> whole structure pays for the header twice.
>
> Read only the range the larger request adds when the region has not
> moved. A reservation that had to be placed elsewhere still needs the
> whole range.
>
> Fixes: 9b41c7dbee96 ("boot: add imagemap on-demand loading from storage")

This is an optimisation rather than a bug fix: the current code reads
more than it needs to, but the result is correct. Please can you drop
the Fixes: tag so this is not picked up as a stable fix?

> Read only the range the larger request adds when the region has not
> moved. A reservation that had to be placed elsewhere still needs the
> whole range.

Strictly, it doesn't need the whole range from storage. The old
reservation has been freed but nothing has written over it, so the old
bytes are still in RAM. A memmove() from the old address to the new
one would keep them, and copes with the new block overlapping the old
one, which is quite likely here. See also below.

> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>
> boot/imagemap.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)

> diff --git a/boot/imagemap.c b/boot/imagemap.c
> @@ -261,8 +265,14 @@ void *imagemap_map(struct udevice *dev, loff_t img_offset, ulong size)
> -                     ret = spl_load_region(&priv->info, img_offset, size,
> -                                           base);
> +                     if (addr == old_addr)
> +                             ret = spl_load_region(&priv->info,
> +                                                   base_off + old_size,
> +                                                   read_size - old_size,
> +                                                   (char *)base + old_size);
> +                     else
> +                             ret = spl_load_region(&priv->info, img_offset,
> +                                                   size, base);

Just to check: how often is the addr == old_addr case taken in
practice? LMB_MEM_ALLOC_ANY allocates top-down, so the FIT header
region is normally the last allocation, sitting directly below the
previous one or below U-Boot's own reservation. Growing it upwards at
the same address runs into that memory and fails, so we end up in the
else branch. If so, the 'common case' in the commit message mostly
does not benefit. Copying the already-loaded bytes across in the else
branch would make the saving apply in both cases.

The comment above the loop still says "re-reading the full range from
storage", so please update it too.

For the test, imagemap_test_map_extend() only checks read_count, which
is 2 whether the code reads the whole range or just the extra bytes.
The mock already records last_off and last_size. Please can you assert
that the second read is (64, 192), and add a variant using
create_mock_loader_bl() with a block size larger than 1? That would
show the new path is really used and the offsets are right for block
media.

Regards,
Simon
