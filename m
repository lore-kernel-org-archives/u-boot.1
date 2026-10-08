Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6C6CA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 01:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD7E460656;
	Thu,  8 Oct 2026 01:36:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ErakAyjS-apS; Thu,  8 Oct 2026 01:36:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 47914607D7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791423372;
	b=I67hcQ3JQI5Ed6dMpWKB5lHOx9Tu7WqaGDOLeTXvntPHYOcxMmDBQSpIW4H7AMWagmII
	 tIEASmFiWtWw1hMD7bGSgbjOHXED/nZ4Mx4b7tr9D41Z9G+PGaUuhTeLSAis2iACI0E1s
	 M5pCi3XgSqMnctRPTlMQQ9RXKDwRcNscMLCZ3pPHE1f8lUs4/cKx4qghpIjx+wbVUaZ/k
	 oCoMNrR/ngk+h4lzmXjjLNhve4rvENq4pIm0HuYJ7fxxoUvwhuqtx1hvySx8rvJvDBkDg
	 QJNydw4n8THpNojW7DHBKaFuZVO1l5JGItG3SjX085ld8iGJBDr45P9V9N089HFOMEA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791423372;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=yASaXWzDW+APgk1HzHkIthf4NSAcmx9pAqQ2j9Y36ck=;
	b=TV7kj2JxsvidpgO7kg2dGKxr8gQFpKJCTHWz6w4UXdUZSwm+LI8br8X5hjpdUOo5SGLB
	 x9s2kal8bexd7l5WXMERCrsr8U31imXQ48exZuTihaUsdU9EeQ2X3ggBibgDjQoFqNlqy
	 7k+rETr8sSipZP3jXbO4gG0VALUHbCP7Zka3HISI64EJJ1A/wBB3ZO0R3O4Gy9rMYCN0w
	 6b8CTv/TgFuvGFABCn/aXNBV4+Obj40gXvXZB2Ds0ZHgNFymg2lHuO0r8lxhb5JKElLg3
	 CoL2Cl+YC0WC0TuO0DZZVp4zovK3ny2kEfaVLZKOnc44qp8rxvJFV/4IlGzSXyfIUig==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791423372;
	bh=yASaXWzDW+APgk1HzHkIthf4NSAcmx9pAqQ2j9Y36ck=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=usbavOLQpjOLS24zDBq+IRePFoa4LXN+AumxeVUksNpr90xImez6/+LI6sdG3j5VO
	 apSUTLp0NdlGcwFd2UmrWf1d4YBgq2KqbGjp6Evb77ZOAHDbj+5Haw2j1TxQPkCHl2
	 xpmOZ7iFhLbfj8eL2h1e0sGBXHF989KL/PSLw/FOnY+G5XyIoDJSdZM/AptC3Q3lZt
	 OnLks1V98r111/wl4SxJy+z5YKT3PK71UrFeA0ofocPCUWoAUAVKFr/PylTglX3zWH
	 XVHc7s1tSzBA89CHzuQFIx6PAwmGMBi1vMzbVOtkRauZZxSkh6dLHKv/Fb4Mk/kCV7
	 OKjUExfqeX4HQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47914607D7;
	Thu,  8 Oct 2026 01:36:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 473DA22B
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 01:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 38CAC40765
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 01:36:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CDth1gdzroKv for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 01:36:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7853540797
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::4"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791423369;
 b=bVO8ci3xiCANKMGcCDrz4iW2sGAwgLVueM7qMKgTwXDVOEO/iWqk/UdDJxoWN+Y4pyQK
 28spOoPty3A4I1O9g1VnWYw7nzLoBXCtRTKS8YXtT7dxSql5fBBcl1GXxcm/iZwf/7S/Z
 BAj2TBx2h6S1aCcvCRYdS0cQo6+6SDzq07h5fGq/YKgzwiHZtiPS8cRLoswl2L8lNLjKh
 3AU5HYE2WRvdfCRUkwXHjFxQ7AiZ/cWYE41AV/QZcvw3aits8pH2uLI38G4hfNe5dxmUm
 +rCdojFE7wZQuTtut45TAJ9ZvlW0WIffu5jZFWnl4VqL91N3fAJcmNbsmXgd9PgUO2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791423369;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
 bh=yASaXWzDW+APgk1HzHkIthf4NSAcmx9pAqQ2j9Y36ck=;
 b=etrYF8VYl6Ho51DnKajmfnAS80cQG5/pjZ3E/1WBPCafdTulJdf944ee1bUjjcSvN9eY
 OSDbVG2r2wfhWpUxrfU/+aud64nELqxN+YLCxmO0mj6JGw5hV2XmR3XwulS57XuuHOvUq
 fa1hggT1c4sYAL1aDQOfoHYUrEiu6c52PGF0+L9mD741dvZQBbHVDpXi9ktTVrxedW0wf
 4EY0BV9nf2y+R7EQbK/zxVONu7EtDQZDKQucw9mKTJKJIBC65BIhGVnj9QeIYU6g8nlbv
 zVdTbIiqcNMfnF7yekTN3AmD+nyxHEmmN7GAuWmPIq9lUiJciMViW0n41EXGUnsxRAw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="OPQR05/3"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::4"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::4;
 helo=mail-oo2-x04.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=OPQR05/3
Received: from mail-oo2-x04.google.com (mail-oo2-x04.google.com
 [IPv6:2607:f8b0:4864:31::4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7853540797
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 01:36:08 +0000 (UTC)
Received: by mail-oo2-x04.google.com with SMTP id
 006d021491bc7-6df960a7c6eso2068320eaf.0
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 18:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791423368; x=1792028168;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yASaXWzDW+APgk1HzHkIthf4NSAcmx9pAqQ2j9Y36ck=;
 b=OPQR05/3LdIEUI/49PqV1y5EiGUiO2bJSxGJ4xewrwjbP/OrRtP51o6MMBBmi3exPf
 +xRX5Hi31JD1boo96Ij1BsNKlZVglwSRtVmnA+2UE5GZRBgc1B2QqVnMZgbLkAhnHI55
 yXOlVQ25imA+gy5V6dTqHuNqjSCDzMI3z1cXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791423368; x=1792028168;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yASaXWzDW+APgk1HzHkIthf4NSAcmx9pAqQ2j9Y36ck=;
 b=U+O3HusAYysTvZPPHfWeIE1+ld+2NoxuSWFYrGx1xz4ehVfkKrEDG/W1cgiNQpP9eJ
 jNsSg0KdQt5oJywrgjqt6LoApOmEOMNKwH2uJm92hn0NGc9QtaLWtqAYBNKSiarRtXZ0
 Bg9EM4I8sWa6pxn/fkGQ0P074O/Ex33llmPjfDCyWNLKUte1Mk9al5v9HKgNpje/X8Ux
 lUnYEVRQjYcIctGL1uhoKnTJfsg05/lZKOXYv00NkNZHMhEunnZQRZ5FZFpiaTPi1LUz
 ThIKmO/KXNDSAIS20D6tzp69xcBtLl7EnRVS6i+kxTSLOP8ScQKv5UM2vv6TJ1+42oh2
 UIag==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8OfWN81vD3Eun6a/J47NwO/XS6dz27rr2qA6BwIcOzarC4XHGNT5dbYnBjfQVT4zJAjlQcHA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lCEKjDNc+8JoJu0XTuE/4gqXB8qWMfDwJ0HZHFN0GJsnzFFxmi
 rggNbMfPsMvS/hQt+L7u5MsaNDnRBFhi3ZLHREKu0KaXk+j3+72Cki0hMW7/qzKuOAo=
X-Gm-Gg: AYBFou2Q8zfu+eCyfxeU75M/pzI/BXb2iPkuDeE10FDNJG+REAoGqPoEoiOV55X2Q6r
 mvwG/zOSWesfd7j0u2ssf5ChfR4oyeM1qQ8s+AOy/IXZScQfziwRc7OEHCD9ynifs8WMLkfSrRN
 Hy8tVi0HWXDTAe/D7MA8JPQD6cgieOpOGJ8WdJiPrdLDTaDFkeVt4lczDvr8xUFWhdQt9b1flEa
 FrhSAuQCiuRS1vvxXaJVI0QhF7T1/lNs6aicZCy70GDuqdBRtYOL2FWDjS1Rb/JVHCfELluKUXY
 LvPiZcy+q9ZzwaVFyidclD4q6a/IU3JqmWrY4Ucuxles/dcs7G9QkahMTDyKq8s84HRYnP/GhSp
 CevzxGiPMqsHAsjFg3EP4hdWNCX6LmOf4GtRXeeiy3WeDgzyN6jR8Yw6xtrFOQAMbMIOXkAYAWK
 DElQL7z/meAmwRuZVIWu/PZE0dc7Az2vd52nMykTEk5hFtkXTwm4OgSSF76B9MCPqlMp8MhsCiB
 KMHeR6k3+xK0AhCXbVffbq0MhofYfSuU5axpdAMnYRZ1RgiU2zEiqY9pNJcgQN2clKiU73QAPx+
 uOQM14tP2MCRxucjVQ566EELlI1C
X-Received: by 2002:a05:6820:2203:b0:6bd:bf80:9796 with SMTP id
 006d021491bc7-6e7a6f8984fmr3736103eaf.41.1791423367502; 
 Wed, 07 Oct 2026 18:36:07 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6e79447d8c6sm3450237eaf.11.2026.10.07.18.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 18:36:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com, sjg@chromium.org, 
 jerome.forissier@arm.com, jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, 
 marscheng@google.com, u-boot@lists.u-boot-project.org
In-Reply-To: <20261007204234.1081107-1-visitorckw@gmail.com>
References: <20261007204234.1081107-1-visitorckw@gmail.com>
Subject: Re: [PATCH] Azure: Switch u-boot-test-hooks to git.u-boot-project.org
Message-Id: <179142336472.3903920.14120584346110452552.b4-ty@konsulko.com>
Date: Wed, 07 Oct 2026 19:36:04 -0600
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

On Wed, 07 Oct 2026 20:42:34 +0000, Kuan-Wei Chiu wrote:

> Azure pipelines still clones u-boot-test-hooks from the github mirror,
> which is missing the recent qemu arm64 9P device setup and causes the
> 9P test to fail to find a 9P device. Switch it to
> git.u-boot-project.org like gitlab CI.
> 
> 

Applied to u-boot/main, thanks!

[1/1] Azure: Switch u-boot-test-hooks to git.u-boot-project.org
      commit: e1dcad5512b81009eaf7e472c20a8a15db8c4a0e
-- 
Tom


