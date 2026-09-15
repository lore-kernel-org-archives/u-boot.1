Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FEAC88E77
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 20:35:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30AF3406C5;
	Tue, 15 Sep 2026 20:35:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IoNXo5OLuEut; Tue, 15 Sep 2026 20:35:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 275AE406D4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789504532;
	b=C2TSbdhY+KtJldLxbcQaUYXsbF8qVobTaYLxR8xBCtqc3TFXrrN39WbnAg8ikOkw9xFr
	 KUcUvoEhWupZuixipXgRFrAcIAqVJFXwmXV67aY9xz0jKjKDqBtbWC1n7zoX/fz3dKC9U
	 VfSBxh+5t300syXtWJNTlIQQsgBNj7HFsST71tWVFhe1IHjIGWmpXYsgCVfjTO7xNZ5B0
	 BvMCrGgov3jevRD5TgTBiV7SXti7FhHPj44Fdejxb+tQv5abLigmelCQx7dqdOQMnlqw0
	 Abg4tL5PP/iyIeNaJmj5g7W4HVBj+dqr8Kww0l30fF4P5p/vJuyAbp830XGr9GUVoEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789504532;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=AhtHABsjUam0DOeteW2QG56GgeUITxIcz81EriZHztA=;
	b=b1nroVJ4cS7PvhEQba6Le/9uxOW5dSVfpCWeE/DtIPv1tMMuX5U7MVSsWxOFd1VYyyes
	 8NFiy6VE7EQWWqHU/+DX/5VK4ESkG3X2RssLPAXhc/JQ/xjI4oxskm9rulLhoYDnFDmvQ
	 oPQ2MMZrPSxY4//9FF3D1QWwpR0nQCSdE5t8YvcgrYzkW3Cw815RNXmSeenlgjUbzkxZd
	 IjHtrL63Y0nd3chfopa6Cyg5HHc0JeKtF96/xPs/vZiNRu7weYRzj6KyvYLX+EjtjZTNp
	 KCXJQXMFEpTw4+arHPdT3XS75jLHypMr4zwAbAKdjl4fodQpSV8lT5WW2YueQElQWoA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789504532;
	bh=AhtHABsjUam0DOeteW2QG56GgeUITxIcz81EriZHztA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WkqItQd+8IZ970PHoKtYck3JM0pI1rTWGtaVOcw3Y/NH41j2uar4sUekhag2uBJi+
	 NH5e9Xd+pL63msNE9bGJAGeQ9xVFH2pjGOeeonqhr+bZ85W2ns2+ysTU7rRG0nsfnt
	 lX6C5x6RGOfPK2y8qM9YU0CrGemBeJKlud8esTze4Afp5PWt2Ao2/rY/d1VO21TmCt
	 KypVhuNc5ai8DGTkZU8SpXHlq1PuJpQxarKWoDji2MWBFDP11ydlV1XfSnq8438j9G
	 kEItHAN/NNDogYxKVOspAc5JA3xJuu1NlR52yzQVopm9+UYBiyRO35QHwIPJv1XghX
	 8bjIp4lgYAQRA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 275AE406D4;
	Tue, 15 Sep 2026 20:35:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 51E7323F
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 345B480AAD
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dMGGA3Ra5Pqm for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 20:35:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6F91A80AD0
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789504524;
 b=CMHV2d7gweJv+eTq5kq5KIufqcdlU583rPEEYrQ5L0KPS5s6Zwp57sCVrbz4bOx4Sd2T
 deGZr9fNZr7wzYb7V4giIn6Gj3klaizJ3rGtu0fOr8cN4PuomdBfWYa5NdeiWvTzI+5eJ
 U/QmB4wW/zJUWVHsazVawxw3VdPDLINtkmElmu4OMxCqGOy1Eo8ag8lNGSqLTlTxXzCou
 HwKQm+1mPFpD6QbvxVfoX1vu1vn4t3rnJdKBn+OSud8y1tv2oRnQ6hU1Jw4lPUwcgMkyM
 6wvWCCThl+ruy8ha/GlYTotUNaiA0dBqgg6qHyq0ZXXiCyWNLUzZmjtUfqZEQdadT6g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789504524;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=AhtHABsjUam0DOeteW2QG56GgeUITxIcz81EriZHztA=;
 b=mcCksHwa5rPOI+YmM5m5yONaE7u26fXn/ijsIoRj0aDBM55/rIqDrsLfvNDKBGSEhUgS
 UeZ0ionRFd4LwS/2kM3/NjBbk/FB/RH+bgo3hcYYhdF/dGG9suGgxuY6JqYIgSfNUCQlD
 ckEYF+86raYqbsxdSmtStR7RisBvlRI5x/0HjbXxDlzgMzd1c8oX1VsKx7PVXfDO5r3ZX
 hgz1SQGg1dxNo3NdLktkxr4+D7r42JdaIup8W0aToSK6q8+orcod4Su8eLFDGcEGdiYR/
 iLfayyOGhE2KAMipwktgKooSKBfrzMAPvZyVHeeIRejYKtQ0b7O6dW8mBsI0hD4ibSA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="HD9Uc/3+"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:32::10; helo=mail-oi2-x10.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=HD9Uc/3+
Received: from mail-oi2-x10.google.com (mail-oi2-x10.google.com
 [IPv6:2607:f8b0:4864:32::10])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6F91A80AD0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 20:35:23 +0000 (UTC)
Received: by mail-oi2-x10.google.com with SMTP id
 5614622812f47-4c5b53d710cso173676b6e.2
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 13:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789504523; x=1790109323;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AhtHABsjUam0DOeteW2QG56GgeUITxIcz81EriZHztA=;
 b=HD9Uc/3+QdamHS+7khB7HkxskqFu34BhgfKJ0J1pZE1pD/ZqGuhD9qq+5s61MHZ3+j
 bR2J4ogmmX2DjwQVSGyMvYqOZR+bGMdlq2iFRrL6a2jLnEuav0CvCCkwIJWoE8wQyxkR
 oKU3Ub4KsamxmouA1LzfypRyV87LL4dUZT9P0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504523; x=1790109323;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AhtHABsjUam0DOeteW2QG56GgeUITxIcz81EriZHztA=;
 b=TDl7KndxDWvz/Cm+xBDMsxex0I5TWhO6+eMi6/ENHh0wKLCO5M9KGl1iGyWiAc7jHJ
 M+QaIK406hTwciLZezkJF8BRB1asxk2XdXczY7MfA436kinMYTjrjqVYUCMexAGOyFVr
 cAtHgiWelI0vqsgvbJ5rkG6Kvzh2oDPp/LtZW7/0YdS+GFsWB6zfxJnnKLaphfymPjic
 aQJ51x9LmY3OI+toKMJ+ePxpIYdspL42m/v3H+nfi93YQpenA7TrQG6jd9PWzD87OqZ2
 i0zdZyZhgUqKk63c6sUo4A6M8xY/DpwIVtIkCRKloWru9oQu3lkYg/9nWCCmENmgrI/s
 qr/w==
X-Gm-Message-State: AFuF++mWsE6WsUosQIOY9ksOZV0DCOpAsesqPG58Ed13hNx1JNibgQrr
 qac3b9IfsWy3OOIwPeWfA/emM3T7msku9ECo5pC+7sI94gHGLU/SmrlR+Lc1xc+d/pY=
X-Gm-Gg: AYBFou0terrzmueZBWiUVjngoQE0mai2dXOuARoNlhr8lu6R69jnqNyxW5oTLZLFKNa
 EmflcendwLfncCgW+r5e1ZdiYHSjcInT7PN90JkNWYE7qPu45TGNsXy/IdS2fk6hAQwKRQPTp+n
 BfMiPxnD6HB29qOIHIKI+aLTLWNSUY/tgU5w15tR9W8bQiLAYasP7GRL3PXB6SpBHVvNTvVmMLw
 D6s3bAR3gdNe4EhhGMfOSpPRrPiudGlQz5FnhrT23N7OWEM8+iGDbm+gcR1yK6XldRnEvjANCxa
 frMu17foeXEbCVcGPMgkJIkcolRMSZM+0Pk+XqOk1rt00nyRRUhiek2InNwgJSncuLhNtdlDhxi
 6XGh5gIRyO0pN4dAX5cl7EqULti7+mbpCiU/5ytXYQD9oIrgfO0zHh6OGnd/DU2iXvuPWl40si2
 KSATXCbrYKcfNEHOXPGKcetUpvatf4yd/P64HLhLpu8xH0LsQghh8cuGq3w5OmA6XOgjTAmgTQD
 VEZO+DX2e9JCB3khE6TmRsCL27sWsuVE4nITZGJwngHXHyDpSCy/RAzgss7S415Ti/rwhi5Gwgk
 ong90N8HX246LUAkLvQ=
X-Received: by 2002:a05:6808:4f2b:b0:4b3:7549:d3c0 with SMTP id
 5614622812f47-4ca4a1de420mr71851b6e.18.1789504522945; 
 Tue, 15 Sep 2026 13:35:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ca20e54317sm486511b6e.2.2026.09.15.13.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:22 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Valentin Haudiquet <valentin.haudiquet@canonical.com>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20260831163056.3854693-1-valentin.haudiquet@canonical.com>
References: <20260831163056.3854693-1-valentin.haudiquet@canonical.com>
Subject: Re: [PATCH] video: console: fix scrolling on rotated consoles
Message-Id: <178950452200.931545.4204735267556091908.b4-ty@konsulko.com>
Date: Tue, 15 Sep 2026 14:35:22 -0600
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

On Mon, 31 Aug 2026 18:30:56 +0200, Valentin Haudiquet wrote:

> For odd rotations (rot=1 and rot=3) the console rows advance along the
> physical X axis by the font height (priv->y_charsize): console_move_rows()
> and console_set_row() treat a row as fontdata->height physical columns.
> 
> But the scroll condition in vidconsole_newline() compared the cursor
> position against the font *width* (priv->x_charsize):
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] video: console: fix scrolling on rotated consoles
      commit: 6b2b1578bceb2a439222de206c5f636dbe5dc92b
-- 
Tom


