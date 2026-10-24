Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223CC606A31B
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=WEPH7WBh;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=egeRz23B
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 037F260A83;
	Sat, 24 Oct 2026 10:12:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zIohSLOR3TOc; Sat, 24 Oct 2026 10:12:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 32EDC6073C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792836776;
	b=TV58hy/ARgTMk7PFl/DFBaJD6Tir5RKzQxtY+TaADRG0FqqKrSo+Ozj0GWovMd7spfWw
	 hNv3Bl9kgI85FuAI4eTty5fIMOMSa+NlfiEshN3gsp2TPg7PIxfcmq1vA7STTRvhrsNVm
	 6UMhho11tDrTh7AKSIi0f1q5sWODOgt7LL6ODHcC44o8U10C1it1dFpTFkWmREts+9df9
	 YFT419RKPx4N3LHRF4iUfUNO1EuOZc1Sf1lba4QkmZeBf9TIHevQBLWjskLblPziREBKx
	 haNu0K3CIZlHnzXZs+AsSq1E4OnvcLD1M3Ui865cLEKn/7t3OfnqyvcNBWIZY65Y8/g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792836776;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FOhF3GxppWqvFUdfZzBEYMSkQJ+RDalysgyeQm/KRM4=;
	b=lJPcOdZVzjLQ7gHeRjfWViJYhS5MbWR84MILQ7bb/IRmImmvRSc2ixbFUpixYdjYjqXJ
	 jCHJhQ2Hfkpu5DarTVMoSgUBfnSXoMeE88kgZh38jRNPbEsgvszEl+4YP+8oPdDsLjTi9
	 FUwYYXlA1G9nd2FSapFa2nFhIikPPAd9KPd4ggSS/yaQ73TjwkTUVV31xtlLa+2+DRAGj
	 4fS20YoWOqWy3O1EVdQq3X//U7sC1adqtQTE1bnKxx3uB5ueMPe7ZywnjDNRGd49pMCIm
	 JdoxD8hVJFo6rsOJ39Vn71B79OhKEc5qF4igOMSb+19y0dtl0xD+//V6usR5/c6RU/A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792836776;
	bh=FOhF3GxppWqvFUdfZzBEYMSkQJ+RDalysgyeQm/KRM4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WEPH7WBhk6gVZBs555Cd0VPAY7+Anc17mehRKfnVmgywu/YMmUmBAhsITCIwSeaoT
	 FxzAU+1CsUxPU6TbjE1ceIEdwFB8hPnys7PmmvpjeeQIXLyxuGwnwlK+zTAjE35SNB
	 PpOxUB2C81KE7tb1Jfy8Y0k98krebi9ibhV1De8WbxNx6f2AKwnCM2KKCMUCt040kt
	 6LdwjwxXjNFuh1sgrvwnhI9B3D1Nlyiwy3sKI0VrJXMEyeNM6WsuY7XHnunRX7fSix
	 R32WIoFjBCsLFJSD1TTRg5t+ZqxBbgXY6T4yapTbczkcC9+1djLx+4YoVACw4V8dLt
	 FUfc4v1GXUbNA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 32EDC6073C;
	Sat, 24 Oct 2026 10:12:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id AAEF743
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9CD3C40A61
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:12:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OIDK55-TyYdb for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 10:12:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DE0A740A57
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::235"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792836774;
 b=VCr04edRyOoGHQfHqHwUbjwTWZjP485nXWcVYCWtuatHIrnZHAI3Gk0dxg749zx9+xkn
 Eqnn9hcIYhxl3e/BwCwAxvIghUahl2LOhH8axSocILsdtZBaGmbQr/lJLFAOuabWNnnpz
 xzXhkK5jI/JhlQgmsLPdCMaofa2qkkEMP+Vjx6UQddyCfhJixSiI9+Fh8nMykG52z8Zph
 olUTHByRsu5biSL3WpnV11KgtSe2mFJC0wGdw0WQKwutpSt8roo1CMovE+e+ubWI/wgIl
 ZbYKnvCvHUE4Rw+i5zjzWs6ds2sgJejNe84bBSRNDtPmTEY8hh6gQ0ZSVgevWIjxUyg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792836774;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=FOhF3GxppWqvFUdfZzBEYMSkQJ+RDalysgyeQm/KRM4=;
 b=e9U1dQehpbRVt+RhxmNGsavgNaULYv5W2Kl3qsZAMh1MVfVNZkcrTizhNO5Q2Fz8HLG5
 TlTz6V8hb9WLZMttmKzzRcthnkgfd/1mj4g7+b2QJjXqke7BKoi/Ko0NGZR7CpVhMM/e1
 h9oDeg6jhnyJEOJJWbKFo6pIlrDcnn0obycJXyyYRJQXxuDlC4dhqzkvvMPjtCtcUOoF7
 x1wIGmaOxwSu2nhDjRbbRccD6EMwzau/AMAxrBtbk/PaC6zEjEHYgYEiw47+dmFBgovFu
 qGdlLQkYID2YxPG8ui+0APOlc1tvyGFVIUjSavmACdSjYhxvFgEulqQ3Tdesa4xhaew==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=egeRz23B; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::235"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=egeRz23B
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE0A740A57
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 10:12:53 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-54cd7de2d42so944191b6e.0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 03:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792836772; cv=none;
 d=google.com; s=arc-20260327;
 b=RGvxqRhg0Lqz0aBA5F0N9/77zgH/9aRaD8iJwtJFIPqOusiPB3Lpyp3NnPnATFEsvF
 f+MZXzcscQ2sa7x6hpkqGUZVe13fSoKNcHFwiZ/CKYKt6rPN1ssZpeRoZax1OYT2M/+z
 lgscV4ht2Dmx5acN1rCM4H4IixY8QC2xpNYlNjlePzzvks1DVS8xYj0GJzHZyZmq8IZs
 IjjLrX4NnoE4e+kFyIloeJULMhobE689KKhhT6+0fx548+7XRt2A0Q5WivVRqr84WmZJ
 MboC3TfElkAQG5LMlZl29NgGnXLZCQF0n7ePNvJkCwMe/lJDsZcW9qIO+AtPhHkQlJT1
 5jkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=FOhF3GxppWqvFUdfZzBEYMSkQJ+RDalysgyeQm/KRM4=;
 fh=Y1ZREHJ+pHB0HlzZ/KBn18KcwK0OUTCLdCrezQyH/Kw=;
 b=Nu1GVwZDOUVCEKFlaw8+PZ/lDAutBG6vBSFvfn/mGle3gdqhgcQK64GO8+S4v7WQYw
 6AyCBs2OfFWwnxh98x5EmueUcUHDZ/TzVynTbCcmu9QS6uTiGChrBQ165KpS0ExsG5Br
 HC5nVjThIUWeobqv5orD2kB1WUvtLW6NdiVYpAFM72Qc72pfp9m/ks6j8jgVHQRbRCUH
 2zXxnIrpNQ+5QstunvRMvqVo7HNg8dmZGAzgWY0KqZszanPGzNnZuNSoDZxrmFmLpPLD
 kRApLfGDbRIPMUrClG8ddIIpdi8RTuBgbpJylN4BAkFHrHxOVwSCvaNE0vmGVYX5+ZXF
 ViZQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792836772; x=1793441572;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FOhF3GxppWqvFUdfZzBEYMSkQJ+RDalysgyeQm/KRM4=;
 b=egeRz23B2x4lik41ZWsfjly+uBLVhP3NwnCqIL4XKMpf+XgpcN22tFEhAiv5Vn1Emd
 /BQxA5cEL3nR3hjkJTYf9zTqpPit/XUsMSs2Hb5n/7kHKEpMs7fdmp+m/U0S8pCtYcM3
 3Z0CuMTW9B0FCK13UtxnqIV+rzsFYPbeA+jAPwartMVZlQda5VUQ2oRlDIPDO7axF6K5
 8WldztOtOrnpzD8b+cUuscZ01LUPCEpvVSV2HL3VVWptEBM5td8AmmKUwPXvu1hGHGWL
 DZXS+rmnAODIbeF+aj6myn3sPPTf6aZIlncyoZsQxl+810i49XHQU8oecuc+d2fmh0X6
 Pi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792836772; x=1793441572;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FOhF3GxppWqvFUdfZzBEYMSkQJ+RDalysgyeQm/KRM4=;
 b=jnt6fWQ7O6NuSDEQlzjNtu1O7vhWU/HV8dM2uyYRchH6kNrUM7+9TZcbIDROqDRY6F
 32UTN/BVZlsOoTAfAbPFxXXpDPFhaZz+Ji3MVe0DM7pXKaTxxf/wDad/Ilo8L2vdhL0g
 vZRmFaMnDAaBui7qR3ru94nTDoehlX6Piat/6fDKswZiwypskYFPr3ubMJKhwcpYckfU
 lOD+aRmZkfi00pOBztYd32+NxQw/7ZdccrUhLTetLnsESSXH2C+WDx10xpzJhgOaYF32
 MGb1bk6SXvG6bGr8T97GeYR/Ad5LyPV9s6dsBmpTw4cNm/XgTsO4CKvT9oAwFdNk12sq
 GoQQ==
X-Gm-Message-State: AFq9FYLsIeWov8bLmlj7hUonAZKEUXBfndSHqeRRUHiqnrWfjCiDqOxD
 6E28xRi3Tluj6psCDnEyUtkNcDEBVW94WR0ckaOuGpize14Z8oVRb0TM5st4beywJzk3Ek8d4CX
 +NgZ0yP0Wzs5R5fQ46LLXMpKjVkiwXxSw0bJk
X-Gm-Gg: AYBFou3FDh+xebIJlztLdVL9truHxtGu+vmtZf4IV31+PlGT4eWCehrXe0jvUDXZ7Vw
 vMNh8WmuvkfnuBv8/9yvGB5fUEWSMfLMvU/zA3MjodCa7mWHLS3FPyQ68vQicOgwF1mYEHgTooF
 pxu3Wo816EeRuVsL8fDxa9BtX2QVWrU9ckkkkb6P2MDA+UHmP+oHUexiWZ3QMcAgFVIZc3JZYhq
 9fp8gwWEB0CIbIKrU8xRoCqg5JdstVmp6WRZZGgyNQBaIJc7QUJDHPxGsFJEVP2FVSHHWOis3Bv
 tXJghjegSiHByEnBCddFkq5koRiXe2v0PherQyqKEzmQU5p4EdE7wz3rM8lc4uaZ8ELkmsbQOsF
 bjnqJNrdxv7KHXoWR84yfNBRxOKdiZ+IFwqtsvg==
X-Received: by 2002:a05:6808:4fe9:b0:4f3:6c2b:5f22 with SMTP id
 5614622812f47-55c0028c446mr1240360b6e.29.1792836772364; Sat, 24 Oct 2026
 03:12:52 -0700 (PDT)
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 03:12:51 -0700
Received: from 1077388689865 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 24 Oct 2026 03:12:51 -0700
From: Ana Bobillo <anabobillo3@gmail.com>
In-Reply-To: <CAJnxHshO21nXubiOWq9+MRtAY9TWqWvLn5nZWNtKKBQAPiL6Dw@mail.gmail.com>
References: <CAJnxHshO21nXubiOWq9+MRtAY9TWqWvLn5nZWNtKKBQAPiL6Dw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Sat, 24 Oct 2026 03:12:51 -0700
X-Gm-Features: AclHuK-n9RUckcknMy-DOn2T7DlBY10chEimPTQU2N_e0JNz4xRWPgorUz7431s
Message-ID: <CAJnxHsjmGGYPN0Xhx6xpoQifLsWOuaW7qs4-Lwc6BcAWLr+SZA@mail.gmail.com>
Subject: [PATCH 4/9] ide: Refuse an ATAPI block size atapi_read() cannot read
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Charkov <alchark@flipper.net>, 
 Javier Martinez Canillas <javierm@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000f5279b065e935627"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000f5279b065e935627
Content-Type: text/plain; charset="UTF-8"

From: Ana Bobillo <anabobillo3@gmail.com>

--000000000000f5279b065e935627
Content-Type: text/plain; charset="utf-8"; name="0004.patch"
Content-Disposition: attachment; filename="0004.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: dde7ca44d1497c42_0.1

YXRhcGlfaW5xdWlyeSgpIHRha2VzIHRoZSBibG9jayBzaXplIGZyb20gdGhlIFJFQUQgQ0FQQUNJ
VFkgcmVwbHkgb2YgYW4KQVRBUEkgZGV2aWNlIGFzIGl0IGlzLCB3aGlsZSBhdGFwaV9yZWFkKCkg
YXNrcyB0aGUgZGV2aWNlIGZvciwgYW5kIG1vdmVzCnRoZSBidWZmZXIgb24gYnksIEFUQVBJX1JF
QURfQkxPQ0tfU0laRSAoMjA0OCkgYnl0ZXMgZm9yIGV2ZXJ5IGJsb2NrLgpXaXRoIGFueSBvdGhl
ciBibG9jayBzaXplIHRoZSBjYWxsZXJzJyBidWZmZXJzLCB3aGljaCBhcmUgc2l6ZWQgYnkKYmxr
c3osIGRvIG5vdCBtYXRjaCB3aGF0IGF0YXBpX3JlYWQoKSB3cml0ZXMgaW50byB0aGVtOiBhIDUx
Mi1ieXRlIGJsb2NrCnNpemUgbWFrZXMgYSByZWFkIG9mIHNldmVyYWwgYmxvY2tzIHdyaXRlIHBh
c3QgdGhlIGVuZCBvZiB0aGUgYnVmZmVyLgoKT25seSBhY2NlcHQgQVRBUElfUkVBRF9CTE9DS19T
SVpFLiBBIGRldmljZSByZXBvcnRpbmcgYW55dGhpbmcgZWxzZSBpcwpsZWZ0IHdpdGggYSB6ZXJv
IGJsb2NrIHNpemUsIHdoaWNoIGlkZV9wcm9iZSgpIGFscmVhZHkgc2tpcHMsIGFzIGZvciBhCmRy
aXZlIHdpdGhvdXQgYSBtZWRpdW0uIFRoaXMgcmVmdXNlcyBkcml2ZXMgd2l0aCA1MTItYnl0ZSBi
bG9ja3MsIHN1Y2gKYXMgWklQIGRyaXZlcywgd2hvc2UgcmVhZHMgb2YgbW9yZSB0aGFuIG9uZSBi
bG9jayBhbHJlYWR5IG92ZXJyYW4gdGhlCmJ1ZmZlcjsgc3VwcG9ydGluZyB0aGVtIG5lZWRzIGF0
YXBpX3JlYWQoKSB0byB1c2UgdGhlIGJsb2NrIHNpemUgb2YgdGhlCmRldmljZS4KClNpZ25lZC1v
ZmYtYnk6IEFuYSBCb2JpbGxvIDxhbmFib2JpbGxvM0BnbWFpbC5jb20+Ci0tLQogZHJpdmVycy9i
bG9jay9pZGUuYyB8IDExICsrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svaWRlLmMgYi9k
cml2ZXJzL2Jsb2NrL2lkZS5jCmluZGV4IDQ0Y2UwNTRiZGY1Li4wMzViYmYyZWQ4NCAxMDA2NDQK
LS0tIGEvZHJpdmVycy9ibG9jay9pZGUuYworKysgYi9kcml2ZXJzL2Jsb2NrL2lkZS5jCkBAIC00
NTAsNiArNDUwLDcgQEAgc3RhdGljIHZvaWQgYXRhcGlfaW5xdWlyeShzdHJ1Y3QgYmxrX2Rlc2Mg
KmRlc2MpCiB7CiAJdTggY2NiWzEyXTsJLyogQ29tbWFuZCBkZXNjcmlwdG9yIGJsb2NrICovCiAJ
dTggaW9idWZbNjRdOwkvKiB0ZW1wIGJ1ZiAqLworCXVsb25nIGJsa3N6OwogCXU4IGM7CiAJaW50
IGRldmljZTsKIApAQCAtNTE0LDEwICs1MTUsMTYgQEAgc3RhdGljIHZvaWQgYXRhcGlfaW5xdWly
eShzdHJ1Y3QgYmxrX2Rlc2MgKmRlc2MpCiAJCSAgaW9idWZbMF0sIGlvYnVmWzFdLCBpb2J1Zlsy
XSwgaW9idWZbM10sCiAJCSAgaW9idWZbNF0sIGlvYnVmWzVdLCBpb2J1Zls2XSwgaW9idWZbN10p
OwogCisJYmxrc3ogPSAodWxvbmcpaW9idWZbNF0gPDwgMjQgfCAodWxvbmcpaW9idWZbNV0gPDwg
MTYgfAorCQkodWxvbmcpaW9idWZbNl0gPDwgOCB8ICh1bG9uZylpb2J1Zls3XTsKKwkvKiBhdGFw
aV9yZWFkKCkgdHJhbnNmZXJzIEFUQVBJX1JFQURfQkxPQ0tfU0laRSBieXRlcyBwZXIgYmxvY2sg
Ki8KKwlpZiAoYmxrc3ogIT0gQVRBUElfUkVBRF9CTE9DS19TSVpFKSB7CisJCXByaW50ZigiVW5z
dXBwb3J0ZWQgYmxvY2sgc2l6ZSAlbHVcbiIsIGJsa3N6KTsKKwkJcmV0dXJuOworCX0KIAlkZXNj
LT5sYmEgPSAodWxvbmcpaW9idWZbMF0gPDwgMjQgfCAodWxvbmcpaW9idWZbMV0gPDwgMTYgfAog
CQkodWxvbmcpaW9idWZbMl0gPDwgOCB8ICh1bG9uZylpb2J1ZlszXTsKLQlkZXNjLT5ibGtzeiA9
ICh1bG9uZylpb2J1Zls0XSA8PCAyNCB8ICh1bG9uZylpb2J1Zls1XSA8PCAxNiB8Ci0JCSh1bG9u
Zylpb2J1Zls2XSA8PCA4IHwgKHVsb25nKWlvYnVmWzddOworCWRlc2MtPmJsa3N6ID0gYmxrc3o7
CiAJZGVzYy0+bG9nMmJsa3N6ID0gTE9HMihkZXNjLT5ibGtzeik7CiAKIAkvKiBBVEFQSSBkZXZp
Y2VzIGNhbm5vdCB1c2UgNDhiaXQgYWRkcmVzc2luZyAoQVRBL0FUQVBJIHY3KSAqLwo=
--000000000000f5279b065e935627--
