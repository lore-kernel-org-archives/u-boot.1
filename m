Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0094A606A33D
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 06:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Vcg5svKj;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ytJyoROy
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC5D440708;
	Thu,  5 Nov 2026 06:43:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y5hnW5wSRero; Thu,  5 Nov 2026 06:43:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1EE8A4070F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793861025;
	b=jrGOdYLi95kW7MMbhueH5viwbrMJIDlKzPo/0rDVXBzWweGwSBwsWpopq+dRRAjKFdj8
	 eApRxfuGRSxHYILeX4PoEmVWGNNCEIPS/k8y52WYAbNzur03fv6JRIQK+tyvOef/CDS3X
	 s5ihWa53zEUhnlVJ7SzQGKKOubg32e0zQSr4SnFP68R28cmzn1zyTu5SnV5JwdaiB3Ifj
	 /WX8j/I6IoiAVjKukxKnSzq+N8sTTcFVPwkDQHt4v6qVDSqH49QVbKRlZ5dmC4VYv5w9i
	 xi9xDfehCiH37xxHdRDoIEtrG6As+vZbRLyXRIERqF/rWdFKvNwLfqUwoUzPLx2ieRQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793861025;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=b/veoyvGeRg2nBEBc5BpX11rqs5lIPPTcc1B55Zq69Y=;
	b=FUQx4xo/MiQtzE/JEe+7Ks+cRoILobgjZ2JY5QPlHmINYhhH8zUf38etTe1rvuVJp1PT
	 8MJ2aY6cDBObiq7CxIzssFOcfEvtQh+bX8eINrV0rUhPOIq94Z/l/GsYKuJLRQG4W5JPe
	 Up3Damvo1jlXRjkLAoU7648H7Bhe51NVXolIsJL6Z39xawacOF/36SgH4gFrJxcYAPeZx
	 BNaHYuSI6KT46tpQVtvc30pdl6quFWzAXHYV6qpolPoOjRBGOzl3Ppzn7NvcjXiXk8Ie1
	 G4c280MYsKklNtXCuTkrahRiOqqdfT1ahmVkF/gflvUsC8XAUs2oCeBPGhIVsoxYQ6g==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793861025;
	bh=b/veoyvGeRg2nBEBc5BpX11rqs5lIPPTcc1B55Zq69Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vcg5svKjhxUbl14yH9yev81+qFOLn6QLdR8HsD6u8KOwojOwgO7Lkzc70tskr0HNV
	 tH04giR3dHg+1adYOskYCLDhZdOXfvFlRn/s9LuT3oO8jgNquXG3ecc7+a2od4gjWP
	 wcKlAkHUHBv6490UxuCCTKju1iXJ0k1bZ/YGsmeHZeWE2ddPCz2KcIE+/s9XfBBxQx
	 C1jhwsbtJq91SuY/kzs4Acne5FvEapNvSGgqKMY4z3RF16jzO3cc5Xv8MhNgB+30Hp
	 do/saHkNX0lOzY713VGVxLqRVSoUVDGDuo/baXE8e9W3z9WypcWwJGA2ZGddn1UzPF
	 sQH4VF+rZ8QIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1EE8A4070F;
	Thu,  5 Nov 2026 06:43:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2805534D
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 06:43:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1A135400FF
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 06:43:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P9hLB88_53_p for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 06:43:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1CF0440076
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1129"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1129; helo=mail-yw1-x1129.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=ytJyoROy
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1CF0440076
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 06:43:42 +0000 (UTC)
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8b315dd057bso9288507b3.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 22:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793861021; x=1794465821;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b/veoyvGeRg2nBEBc5BpX11rqs5lIPPTcc1B55Zq69Y=;
 b=ytJyoROyrr033x9Yee8OLRgnnC8J5yw1al1KkGRrH8O0p/Mdt1c7qVpDbs4tjY2bZD
 TNVs726oYSAXcPQqf82JzU+pRawCD/qphiLNvYsmRuTD0A2xUNQozOz5M4/gtg2yBzi5
 jazdHl8Hkp7ZXFfp98p/F24+Jlqov7CKkFwOuug6zfIVsxWQjgf6LJ09XHumS+fho11q
 krRGIrtw5c+DDZJ5T7LzsrDwugPskpvuSRJsY4g756ymwvTMTbIPgiuc+k9iV3id1hK3
 0bCJPDrIt/KViaZ8r/T9SGR0lhyaYKQHhS1En74KZt+um6pF+mxUcE30ArDcPeZjBFBg
 Aycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793861021; x=1794465821;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=b/veoyvGeRg2nBEBc5BpX11rqs5lIPPTcc1B55Zq69Y=;
 b=xXv6K0e1rIrjz6TT6EYweJPytYaCtlbCY6jkTZ95ZjKvrer9FJ3SAWxRUXNo4Ph3X6
 eMtf7K9TD7WOLXsp8SOYWMvBavWsHn/FATR09754bry+UwaONqmqx+loMt0bK0XlrV4l
 O7+vfPmmS+gBwliqIuXErIJjOlG9Gk+Q1KInIxebvy+scBAGahfXy14rwP3ddCBT/LC4
 RXAIIkuwU4YNIYYE17U94ZNOVBHpAoHTKmBdjNHYsdWOYwGOuzqJbJBcWaAf/jVRGEAP
 nWnSoBn5X1W835sjZBUjK+6x+rF1qZBEHHToqfqCc+rjyAzLMwUsUPwI8BU4uPThMr3G
 nviA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYlCW7rYwchaAwjNWfJDwm/Qe49oPT6x/1WhZ9Dp/TO7P12by8xjn2kM2hXK5w4PsJy0VAd3I=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8Vcddiv6Mutnko9p3JBWQuyueU+FsC4H0Yy6p3HITwO3Hs8p7T
 XS3VV4ApZEZEZLrjQ+Nd6/4JxWPRHfF/i4MIDsxoSSSqRC39csUE16FseXWFsgBNsQ6eGPka53o
 1vqD/hasLOc0/K8EgN+0ouzc7s4DFmIX/kcrgJh3yDw==
X-Gm-Gg: AYBFou10vuVjKGQJd3dLY6HDCEBXnEY400YHMlItOJ/dmU5ZbEqFgTXKdjMoiMQzVky
 Z4d9PwPTrM39kEufQhzQhPVLN7mf9gCHvoUlmpVrOIsgLtpEVKxz0php783bGu0TJwNV6j0pZhy
 JBTmJro7qMPK1xxtlC9IwbfPYhAjfYYQjWCa9dIKjk+urylDg8NV4MHjsIARvKUNVWvu84jryM/
 RLywZnbqp0JRLL0+DFx/0T8C5DuAx4uI5lU+TjPskaUynNvsNqwS4051amDgJ9zSGxogtPH18wF
 n90XdiD6tsoL9h7HbIQIz3ahuOCha+09nk2khrtSb/pK5l2JK5A+eFspDcnKSTpxHAFPxmFU48O
 ryEl3AeIV4JdIzcMr+RM3jGKM2dS3rrphe1z8WXZEBHQkVJrEjULm+DJJVcuh6XD6CAkty5Pfl8
 heEja0YziDbhiYNxUhXL4as8khjuGfxOwdWvvrwdpUZ+/gvR1B5f9y3YCXrtFCVc/dCI3r8Zn9d
 3sRFczuUuNfQI+pnP9RhIVU038dgl2h0IQ0NdTamHb80TrqrF+Q6AmKyR9uki3a9J3j0ls5esQ4
 O68e4s57GNwijcN4hviAtK21hWwQvJP1YLw9gbwzg0ex9PjOkmDq7ytiHVgVMlVuD0a9gnXFSyI
 7Wh6m/B3TPiMzkt3PFn9d3qKfSoZdMyeaYR6TjZ6JOuN7QVwLPgI1zWdEoBmUUr189rlrXV0fWk
 XiGiRn5Fw+Ec0q+K8wgMQ62QOxQpAAsa/yg5TPhGWGDioCGrVphCrvMG7K
X-Received: by 2002:a05:690c:f05:b0:8a1:781f:4aa0 with SMTP id
 00721157ae682-8b2b67f1889mr128126047b3.56.1793861021107; Wed, 04 Nov 2026
 22:43:41 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261104-bloblist-tl-fixes-v1-0-477121908257@baylibre.com>
 <20261104213231.GI1164024@bill-the-cat>
In-Reply-To: <20261104213231.GI1164024@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 5 Nov 2026 08:43:04 +0200
X-Gm-Features: AclHuK99LVhandTTyJqDSbwHZPnMbyz9De-2e4kDmD5RFSrUx2chAqCFf8-SOrM
Message-ID: <CAC_iWjJP3_qKua9fnsJ4S0jFV+GiyoG2FzLbbmw1LgepodnVnQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] bloblist: fixes for transfer lists from TF-A v2.15
To: Tom Rini <trini@konsulko.com>
Cc: David Lechner <dlechner@baylibre.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
 Carlo Caione <ccaione@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 4 Nov 2026 at 23:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Nov 04, 2026 at 03:23:07PM -0600, David Lechner wrote:
>
> > U-Boot cannot use a transfer list created by the transfer list library
> > that TF-A v2.15 and later use. The first patch fixes a hang when adding a
> > record to such a list, the second moves to header version 2.
> >
> > I found these with a DDR loader for the MediaTek Genio 720 EVK built on
> > TF-A v2.15, which passes a devicetree overlay to U-Boot SPL in a
> > transfer list. With both patches, U-Boot proper applies the overlay.
> >
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> > David Lechner (2):
> >       bloblist: align the used size before adding a record
> >       bloblist: move to version 2 of the transfer list header
>
> Thanks for doing this. I think it was on Ilias' TODO list around when
> the version bumps happened but got lost with other things going on at
> the time.

Yes it was, thanks for doing this. I'll have a look

Cheers
/Ilias
>
> --
> Tom
