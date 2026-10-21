Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D657F606A328
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I+qWKOOV;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Exe1ZEab
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1FB6608F6;
	Wed, 21 Oct 2026 13:14:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OHjgzEiwkUHv; Wed, 21 Oct 2026 13:14:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 277836082B
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588451;
	b=GYO6Sy90X3kz1rG6rOjIjKMb29I0e5BeLPPoxy/lnCFRz/MP9TTu/VW2szPOuaPqBGgV
	 nMmaik+L8d39wc0LQR4/s1QTG1UJYZaCMxYsVCeLAfB8ZHVUS3iP8wmxm4BXB8pviYgWg
	 f1kJomNg6qgU4k6zkeoMNbjVHLXEdlCdmRIvyahTPR869Ld8+zcrfV2VzM5uxMusiwAcT
	 /wdb+FjUfxmx6AquegPG3P63MQSxlrwmx+KAwi5wGzMyVSJhhYPCrii9pgbU8YbInwchd
	 b0o5gSG4hM0Rzd8MtnADTd3OLOaofyFbLXveDsgcRJyEOFGnZHLbSSTYLaQvkGP9QHA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792588451;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:MIME-Version:In-Reply-To:References:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2joXwCBftV112eaa6Xv6+bXWt+aDiWxhfq6oyQDPp+E=;
	b=Yd8d4C7nSwSXy6G82x36ZP+jqWJHGoJ97wKhUpdgO8VmYlsaCJHKUK961uHNpEBKIaqD
	 1GKppXmjOVE9vYH37PXQ5PJ1w2uSXhWLM+8bz1oYVzp2g+89Fk980aX+5O7tCAzBF2kyk
	 FIllKP9vz/ZCdE5r5xmsZBYLd4HhiafWfz3iAhiiT53MtK6v2Kp1g1khPwXhs02ih30Ez
	 zz4V3Z7fx0AproMOhj3kOm26v65KXdouatVQuba88CYMyO4Md+vx3DEMntZBECrlDbqx7
	 lRjgmiWoHWCV1TQWCoJI/lb6c4KGt4h362FA9JRNJDXlqSpnUedRdVtOVczAK4dMPog==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792588451;
	bh=2joXwCBftV112eaa6Xv6+bXWt+aDiWxhfq6oyQDPp+E=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I+qWKOOVoSvmoPnJGiy1CIinzSH4wGs/wRN43ZH5cxMd2UywbnhiLo2CGBoECptRd
	 RGiN4ADYFZcYw5s0iSna0tShIbyrz7CDK6L32xHXzyMJquQZ0Ax4tz21Fb5YM5sPFp
	 IjpspV3Fd1WwjSBlGx9eXkYgbjXgAFnX09QLnHSlJVqARbdIm3QDmhjLxPK8jKQdLv
	 3qRNuZxkftt7hyOkh9bzTliJjgsSjffvRR4C4vGtcGNhzWFfdYxnH6uT6boEG0DTzw
	 rF+zAwvlIfOXtnbqt7essb0P5kUztgEA8zh9RgtJUZjhxDrmRoNE/bCXJ1cdy3TjK4
	 ThODaeqX7VjJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 277836082B;
	Wed, 21 Oct 2026 13:14:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CFA2E3A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B5BE9403AD
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:14:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rRrIj7g7R8F8 for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:14:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BF56B403A6
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792588449;
 b=DGp0UJvX96kwLZdHK//AxFjcoND+PgVj4BgMRKzu3eCqLgHEkWW+M+G1Gi0MbrdQzXjA
 Bgk33IrNOU2BoDdbrQOJD+R8gEWYgE9bREDfVl4FrcZLASr8SPCQJ6ddnlnOa5D8rmk4g
 XI2ilkWk8SxBnfANFOPhLk7FlS4j5Tggx5cc0+LO2mDYyEdt6dzF+fGOxWr8yJExOCK+8
 v9s+enQtzr5wf4sEqEFz5q+FZgqm30p4+5QzIibkFP8ZU2rH3F/2vofa5HUFxwU58mRoP
 1I+x+mJ9qUO9f9LJfVTPnSTSaQ3YnwcGGF6AFKD8JswCJ5DTyDeUQXr11EO6w9mDZyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792588449;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
 Cc:Content-Type;
 bh=2joXwCBftV112eaa6Xv6+bXWt+aDiWxhfq6oyQDPp+E=;
 b=PCLuxxka2XBxYuYT+HzyiHe/jsBeYpT629r0UhUUGA3GnucT4Ej++Gu5FGteIb4dCHb2
 ncWb7wcp4bBXhe+Gg5FXQZ0AE09th78g0AX9uDZsuogypW2KM9TmZf9MOfqSts53oicnV
 Nzx7ivg/6o/lWccmFy0uRZtC0ABufwAZbMm2nbPll1Hc+nwf0IKyfmVFF85Xr6QI5jOup
 k5wkymbE3JSW1urOPhe8gsijBSQp9yAyZy7+h16wXHL0PB5VvNtqMNryWwUa8UiGhhElb
 HTWfAqRXXWfOySGRTz4xgk/fOTuV6YyFkqf/5ssMomSmlg+2CIkJ6tcWPhhmiEYcNJA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Exe1ZEab; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::52f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Exe1ZEab
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF56B403A6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:14:07 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6b3dc272dcfso879237a12.3
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 06:14:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792588446; cv=none;
 d=google.com; s=arc-20260327;
 b=m2c+q/6OIpg1sHKh3sd1oeXlBFihQnlFentqJm+8euhEpjiaA1qL6N+g2lpJsOA9KA
 TeiPO4kyjwWTAlsTo9GUq9vjzuLHK2dp6sINlxS+9SEAn/jyu+bbs/E1x0KWvhYcvHnS
 evAiEzUUB+neb4rLV+P3aBOQGTXKsazb2Ty73KFAgsET6OR/f9/w3e2LD6nW9sFSDtpd
 ioYZ5lkuYwgHegVdx72MDEp+2KxfyHbajH2MLi+cj9FLS37Kcag8Va0jhtgqDakwWJI3
 3pXFhQe5MARQiCl0DzFZAA1AkHbGITwSRn+tFXjQRKebUDsCpzzO/nvR5Q9OU6njeT03
 c5bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=2joXwCBftV112eaa6Xv6+bXWt+aDiWxhfq6oyQDPp+E=;
 fh=lFEvJiD09eFkjC0zjxFrJW8v5KPieVD3ZcMao2sBQCU=;
 b=CQe7BdTSdpL9IcbZyx8a8NT98C/3YVNu+tSlsU79/2yny7TTLkO8M/1n0cnv1cOkpC
 CUJhynNUCMRs3CeBw6njNYJfiO5Bhrau+GP800056bAudE9/MpchOFIFVCJY9Mm8c8PV
 t7VhBd99w5qdRZ/T+UHRjrUwccQDvFrg0nbZuVD6Yck67uFHH91wNPkO3+6mZc+7lMCu
 gdeufPN+A7xqflI83nzQ3tG4kl9bL0fF+7nsb1UHZIzLKWJCLBYpceWl8zgg7MwwnvjI
 aDynZLeoD2zzIBnXYn6AxtJbY3bAg2EN5++sj2H/6NQWtbTkpjMQ4jOO2mrNpI3KXv69
 tVrw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792588446; x=1793193246;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2joXwCBftV112eaa6Xv6+bXWt+aDiWxhfq6oyQDPp+E=;
 b=Exe1ZEabJEF9MBL8/gfyLd8dezDdChXcWioL4HWtWpazQsOzoCi51pH1M29d59aP4X
 /yspJyPCUB8t40+PPTkkRfG3I3NRi9SkMkdwVGFT9H1x1JKo4+8B5jQDIIVE3C21Vwsz
 7fJWURm0YvXIszwP8LrcBqxuc12jLgAjCCe+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792588446; x=1793193246;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2joXwCBftV112eaa6Xv6+bXWt+aDiWxhfq6oyQDPp+E=;
 b=AZJYzXyhVE1rwi7Vg7YmGhOdUHOuZJXCbA4mdo/wAk2hD3tT/AXTHiDiVaNXN+1uCn
 akMRG9iH4/40m7WWsT57WHgWCg04OgK/11acb4RcbnDvBdbrjzkl1hAlH4le1Abd6sPr
 Cbben1UZJ4QZj/RxhSQQ6XhWGC6ipoSUCwQyJPtH9AcoY5+C3latvMkZNvHd2c3DII5r
 /gRtN9Fu1LErFmeYQkxI+Q/mrFFdkBPHVJzuVBMFFfpZIN5MVHAQRoGCXjHINkOyBIOv
 sXlv9DWjuz028qANm0BC8ss7QDOgWKNgYKl2D3FxgKRqNuBdClttczRzcW7P9shPzbk7
 CBpQ==
X-Gm-Message-State: AFq9FYJm6nU3iLK14yg8ayW2H6/0So7NICnc6KOn7AocfMaD3Yy4IqwX
 i9nem7vFP9wt7hRJRM2UG1bauTst0w1UqfIdt2Gw/2zXPWgpjG3IAX2azixOignOpfnHIrmT2iy
 y72EtkqzVFu62u8TvVMcwUiI7QMUDHjVCaXFiEGOqMx6yygaTr6GaOQ==
X-Gm-Gg: AYBFou1fY7OOUcf0Iica38+Fh0e26+ezOFGN+f0eMBQZAb8IdrJIvaf7gRA7e9u9Hls
 YTtcV8+BsIP5v1rQzD59iAj3gZFCpU8L5dInzOq0Q3VElithzRArTWzpSBeSOiteKlNrEYka2qo
 Gs0Jzktr4U9LsdhTCuDeQtEPQoZxVgtZTcP072/5Ld543hWAWEWOS1Cee1VYv1e1rOvZb3gIw2U
 1+DByQs/Epgjxj8gFMInNdg1yl/ZYaWCQR3NO26rveDLyDRykCHOPv8Y53J7hn8v7JJNxFaxYgZ
 wOe2rW8nUw8O8cTAl4JHQ+oFVmZmD9TCOd0tJX8q+72FPKvY2N1PyF7gNJyJpxUW6Vt+ATstLSF
 OpN7zOofyvll0da2dhk1YNudfarrpCLU4ZYs2kpruZXO5hyBh6uZas+8w
X-Received: by 2002:a05:6402:4403:b0:6b4:12df:8243 with SMTP id
 4fb4d7f45d1cf-6b412df83e7mr1023232a12.20.1792588445587; Wed, 21 Oct 2026
 06:14:05 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 15:14:03 +0200
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 21 Oct 2026 11:42:17 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261012101054.2104707-4-lorenz@sigma-star.at>
References: <20261012101054.2104707-1-lorenz@sigma-star.at>
 <20261012101054.2104707-4-lorenz@sigma-star.at>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Oct 2026 15:14:03 +0200
X-Gm-Features: AclHuK8WA8Awh26Ki2W0CPkNZ_Pw8NyKn1uPOFTbIHTpjY8lj-NfUBgyf6glPLY
Message-ID: <CAFLszTgm4e=f1Bz7VkdJT3V0CiWsBOf9FqjPtyGZAxacJyrTAg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] binman: tests: Share SoftHSM token setup
To: lorenz@sigma-star.at
Cc: u-boot@lists.u-boot-project.org, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, upstream+uboot@sigma-star.at
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-12T10:10:51, Lorenz Kofler <lorenz@sigma-star.at> wrote:
> binman: tests: Share SoftHSM token setup
>
> Factor SoftHSM configuration setup into _SetupSoftHsm(). Use it for
> tests testPkcs11SignedCapsuleGen(), testFitSignPKCS11Simple() and
> testFitSignPKCS11Object().
>
> Signed-off-by: Lorenz Kofler <lorenz@sigma-star.at>
>
>  tools/binman/ftest.py | 89 ++++++++++++++++++++++-----------------------------
>  1 file changed, 39 insertions(+), 50 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
