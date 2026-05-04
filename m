Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3391FCD3436
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 808F284674;
	Mon,  4 May 2026 15:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TIjAJR9U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 371328467F; Mon,  4 May 2026 15:32:15 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49FEF84661
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bc177ebda91so225377266b.3
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 06:32:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777901533; cv=none;
 d=google.com; s=arc-20240605;
 b=ghMuLFt/y6x1BdpOv2V/j92uRU/nzAy2ccsR/rDnVsuW1cSCb1Oj2ns9w3V2TKyrw7
 ehLBgzpdgXFVvGb2hOe22P3ESb5QqLhKBGuxJMfD5b0ngVitt2bx1MSEBC7Trji4XEC6
 a+b25v+jvNUR2WwcdlIBUIIqOPPRE66f+ufgFtxpNZkavQcIsLKlcuL1uMyrWb7AbOlZ
 Ja/YugrCsBamYkj/872hAZ1s78I7Db1NB6s0EitCbf2X61ey4oT9AyVxcvEU/mCGijjK
 24vxw4vl79sCVdMwmNQk2iadAZRSGEobxNIFoZT68nNZKXUNwrewU/cJUyarx2o7GAP4
 EXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RosnfYm1Ug2SN1oPnkWkcieJ/wsQW3MCZ6dbJhmbxEs=;
 fh=W5oOCZ97TZE0v5ET5op14UWxsMT3M00MjBK269dz3z0=;
 b=gFZoiz7G5w79GxuIItx0n/tc4Dnsnz1vNyZRWP3aQDAuJ+9QBM4j2UwcdmSefiJ677
 2D8RSx8smA5/XMCbM9nOGtJ6qMDTWWpYUtmL8Ol6ceLFSQ1z+GAH5lKuzQ760TH+rjME
 CoMcmKle1rIQZb9YICRRoxIRmMnsHld8fkutil+VBuJF+PkWvrLyMCU935r7aCRRRt4u
 1BZvL/ubJ5hJj9TQREc0j15HvtB8fGzPjr0cf5leSzCP27SZO1kmaLu9s7v+XJEed2Vf
 /qZBFCRBo9pkAMuumsLlpdy8a5AQXsgzA8nzKC75btO52Igyaz9Gt5ltDSvKgHB8NjIB
 fN/g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777901533; x=1778506333; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RosnfYm1Ug2SN1oPnkWkcieJ/wsQW3MCZ6dbJhmbxEs=;
 b=TIjAJR9U4wteLK7+FIwwVLY18vefq6y4K9U3N5lacU7OhcTrEzmypsrtH3W7I6c+d2
 T0Gk24p36kVWQ5MpGuMGI7yIgrFoD48Rs4yK2Ap8dTBRGYO6z/iglU6Hq2u/8Jm3p2Zh
 1l969RJARiw7SDNF0gxgHTlF48AAR1nQFuxwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777901533; x=1778506333;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RosnfYm1Ug2SN1oPnkWkcieJ/wsQW3MCZ6dbJhmbxEs=;
 b=gh3Q/ujePkGr/VTkKLOg7RV7+Qx3GTX30aRay4h4NcrIACrnoIyvO+REp/JAA8mvol
 k9vCGbTfeUJhtUXbFUnJXIT7h+tumSCezfyl+E0o3Hbwa5PUUsXbEbsPo5vckHtpJZTH
 48IvpzBOfaw1fKYNoqBP0jF/ZAmxM9IsG2CrMrON69LcP1KhXY+ao2vyq432MC4cxOAq
 k5LbcMTTvEKYmxGGRxavkOQSwB6Nr+bU+hVWwnc9Z7hzaxvdjPBk5gS2ddiVHQBK7XGH
 ca67O+iMXdqZhct/OyHMpt7MMzk166MGVkWRPZc656ENu7ytLzqGbwr3Gkl3gLA/3C7p
 EkKw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VKMRz+OvVhQ9eHhAtCnnZ/82tQC4xeMLbrzw0+jr1HBPaBAGYMLgk4FxJbyoXLEDM+QVZJpc=@lists.denx.de
X-Gm-Message-State: AOJu0Yxoqun1x2IEUWxobnfxRX7pbS/aQRpBYCkhVI3NjwiO2B9rv1mH
 1SPBXXEQtBPoNvGPzKPLujeBMNXwKxER6aHGwRjqSRXXWPneqZ5iQ6ScIo9IKXhvcBTO0/riY5e
 Mr48djf0Q90F7eMqZayHWVIc8p++gMwp67gUiqUhpP7BLyJpFhDk=
X-Gm-Gg: AeBDies1YxEFv/PBJ/1NnJia+HZYadShNyZwGK9r+26Xid9n+vUMIQMucTG0lz55E+o
 srBnAiL4QUDeQ7Ed/H78FSW16zfH3x+JMYcW+vhoHNCJrUpjkTSQqiGDwaF5/AIMlgg+1NC+WqJ
 4ORiOtOO7oEcifSDAibogyydM7ILd0Ty60UbsqEOkIshKLwkVcc2wV9WPRF//XAPlHnsXmvVgsM
 XNZZItA1z7wyUf+AK/V87xkroiHuCgN4QhYB5aw6ZYSEdcK2QiRzBz7X9EhPkOueWodVD701VWw
 TDBTlFGmWbLWM3cx
X-Received: by 2002:a17:907:970a:b0:bac:7f7d:2bf8 with SMTP id
 a640c23a62f3a-bbff72cece5mr460630966b.0.1777901532418; Mon, 04 May 2026
 06:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260429155418.75429-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20260429155418.75429-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 07:32:00 -0600
X-Gm-Features: AVHnY4LbqPugHOyEZ-fEHKYklX7ZVARcNbLeGkzED5PsKWXt--yCCmi1ANmrVXA
Message-ID: <CAFLszThyb4f9QW4x0F83n6hEF6we1KTQZcx59VB3ANLX9RqgFA@mail.gmail.com>
Subject: Re: [PATCH 1/1] fat: initialize ret in disk_rw()
To: heinrich.schuchardt@canonical.com
Cc: Tom Rini <trini@konsulko.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Daniel Palmer <daniel@thingy.jp>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2026-04-29T15:54:18, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
> fat: initialize ret in disk_rw()
>
> If fat_sect_size = 0 and nr_sect = 0, the value of ret is never intialized.
> A random return value is returned.
>
> Initialize ret to 0.
>
> Addresses-Coverity-ID: - 645495 Uninitialized scalar variable
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> fs/fat/fat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
