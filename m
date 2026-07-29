Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB364C53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 05:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8F8A980E71;
	Wed, 29 Jul 2026 05:14:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gx8Gqzc-Jpie; Wed, 29 Jul 2026 05:14:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA76A810E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785302057;
	bh=riSoriz88tJGaYtqwtRd/3FsKXUZIycNU6EXtlamVxk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EGhOPUfdry/VXo0m6Klr9FlJ1HcB/cLG4WGPk3WehmIgl5dxR7HZXQ4QW9LHDN9HI
	 zOgxOFj78+B2yoLEconVG58ZbboE7J2700NJj8b+l2s5kkIWPVM9W+KYCLuFP+FtvW
	 uZJ+DEpOUpx/tHcKMngIPS1hHFLtauepLGWUZuacrBm0aKeHuUIbZ3gfoFK1y216Ae
	 viClo0yo+8PFFC8h2fnjBUOVD9/BjYsrXzdD3QmZE8Au0qeEIzXStsDnZcy7ZNFs6S
	 qEU/nd/zIxbq6wAUyd4caU1wcNRDGrm9k4mlZywIfKz1p21h1WmxlAIGpICYsyvLGG
	 IyImGDpyeaqQA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA76A810E5;
	Wed, 29 Jul 2026 05:14:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E03626C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:14:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5FA5C40231
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:14:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MCX84rW5X_Ud for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 05:14:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=pbiel7@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0CCA2400E6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0CCA2400E6
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0CCA2400E6
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:14:14 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 528F38494B; Wed, 29 Jul 2026 07:14:13 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CD828404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 07:14:11 +0200 (CEST)
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2cc73e322dbso7195725ad.1
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 22:14:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785302049; cv=none;
 d=google.com; s=arc-20260327;
 b=qCJhQsv4mT6w0ZP0qHQ9UW/ENssLPr66Q0K0qSuLpnJPXZNAUiCt2vIi2MdMmwym6u
 qZgpl87igXzVl5Br3LmgfpCkXfD/gfRgaGjEknm5cLSAvNOgQoFjkWW2hGxbnkFoCwrj
 jgtWBqL27cUWRYxxQvHxoYBJfJU13ujwuATd7Ky+8y6mRcAneV4pUrF7wwZGrHG9qv0E
 gyqnGgaV7IvmI+uoe37UTIidxkOYKF5GMeWX6lrdkXg6qJch2mixkc7ckqggaZK3MJ3j
 k8gQlqkfEkArWiKH9ydxa5uyxEJV/BJVBZXQEw5FuEYEidSDGkJlbVfQEQUsEHqiITW2
 VuNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=riSoriz88tJGaYtqwtRd/3FsKXUZIycNU6EXtlamVxk=;
 fh=upyhGHb5jq/S0VCOKRgMi0o40DHv24CuzxVOKiZYsmM=;
 b=Un4V1rJ+iXdt0X9jBc0cNqsRkp6S3L6IIsSDplJGubXrs0PwumeRLvqvtEXHT5h33R
 aeFM45jardsK2Lwu/4YUVVGKKeJQUi89qqb9SEqt5DkiPtNoK7+2Gpk3zBcd+00apQz3
 SR6ZDhX0FZZ4PGN4E3/ZEB+EF0HEzblY52HplQVNuGBxkJSTuzhr4tVEzOGvycQhyh+y
 yD4EGIhc4JtSy8JpF46RNLfG5+sNTEn81gFIvQfxYO7CgqSi4vGNBSmLzWLgdC2hLMiy
 CMpAP6cZahw4pqH4eSXw2HRtyARnVKIQ29gJ3Qi04f2ZVCn7SY/Y5PXKvbuETfW4RwVV
 BD9Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785302049; x=1785906849;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=riSoriz88tJGaYtqwtRd/3FsKXUZIycNU6EXtlamVxk=;
 b=Nh2eUJ44MyJAXAywbuMKWFKPWTaCMxhH7sbxVoIFRtQT5sAws6CzzBC3v5ybe0vEaQ
 B1j5a1QDzx4Gmtl8W+z05UF8CR6PGjTSuZR84resj5dB4XS3QyCUKWyte3EKTE5ZaukJ
 bHXysPadoj6EqbrDXt6cRqbuRpkfTsUYarSMusi+I2waaLEX6yW2oGwwBqso5ItXTtcx
 MT1NO/W16aS+7KlpJItFK74ibKjRbwNwzm8VnyCgTSuEv/veN/P7v+Rm0wbNE3RQvqnM
 WxVw37FA0LZTpRwc/C7NpGibBaYPTw5kF84TDppYZpb8JJEwn+GXTAtllypoBs7OkT+k
 dZ0w==
X-Gm-Message-State: AOJu0YxSF4+svd/OnQjLCzjo8EzmQ9t6Z6/xSour4hEg+AljDk/TUuzy
 lhfDzYVk6RxKOIF8pY/TEzc9jK4oNaZeWeWjoKwXFo0i44w8pTlFiCu4QbxKlh36tsiuEjiW4DE
 fDCHRj3GYNpB6trYDz6Ole8/hK9SFirw=
X-Gm-Gg: AR+sD11VGtLYX4o9gBmPS+rOOnb5jnkgoOq1/HcYW7rR/mszBo0CkosueXHM+rudI2I
 wKJXXEW/NMSLCZ7/CiUTRSyizWiPH1YND4jraYflQfjbbZmSBTJpeei5iCoyDZZEx3tCIEUEq4v
 vnPu4DD/Kdusgzi0NFiKvE88sdTDblmXouN0iWC7ktMc5VBF0ly/Inw3fNdYKKAw6JYvJ7q0HIi
 5dYVdXo/x30J4vN8jWKFEED3+Ag6JrqkN1TNyLKCer6boBT2oUR7psTued1vF9HSUcgXbX80vRR
 k8vqQ98gPVj4d2EIC0wI0LKNNgBiINxv9oACDpuI+FqwnZnPpmOaOOHXgIc//sTL8Maqs9NGHIB
 dgJhim671dMdFgfqZ+w3QNbdOdUmNkg0To0EfsWJ4mfGvnriobGLJkhITKJp6
X-Received: by 2002:a05:6a20:734a:b0:3bf:b4ed:5579 with SMTP id
 adf61e73a8af0-3c8ba5f6db2mr6350242637.59.1785302049321; Tue, 28 Jul 2026
 22:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260726115702.15397-1-bhargavdas100@gmail.com>
In-Reply-To: <20260726115702.15397-1-bhargavdas100@gmail.com>
From: Patryk <pbiel7@gmail.com>
Date: Wed, 29 Jul 2026 07:13:56 +0200
X-Gm-Features: AUfX_my9im_4QSeQG2IViDRO9d2-RZQgQTXJLMbvSoXUd7Xz8CfAl4hHl9iSAuk
Message-ID: <CA+DkFDaa9DU1E_PYtoCSU19Ctr7cgN2st87EBQyy_BrX3wZSsA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Add initial Raspberry Pi Pico 2 / RP2350 support
To: Bhargav Das <bhargavdas100@gmail.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785302049; x=1785906849; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=riSoriz88tJGaYtqwtRd/3FsKXUZIycNU6EXtlamVxk=;
 b=TwO9hyhqtLXdKk8wYK9ax4ZlxLFqIeBp8thD+Gg/eHqGhrAFqxvR9qsU2XlWa3HDU3
 wYyCtT2hy/GCVs+IFp6/PLHcRWSH/94FrxvzLbxH6dHaHtMU4v+mATMwR5S9+NqN8uYD
 PEN8FUeBOkNb/946I4A2C+uQI35+vfeItnJv2hU08QxQIphWgjeq0PX1DK/GVWv1rj3M
 6+DJzz01Ii3Pvl/1VpA7zyvERT+ZoQfBHKINaasP4sh0F5EFq2RnvbUchx8B/aSGOapK
 k/Rz/pkfDatW3tPcSmRtB242MSMsyvULv7le4JLR72m+xcyU5SLBDg+XluLCcMZ+hUUz
 m3Cw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=gmail.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TwO9hyhq
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=pbiel7@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="TwO9hyhq"; 
 dkim-atps=neutral
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

Hi
>
> This series adds initial U-Boot support for the Raspberry Pi Pico 2 board
> and its RP2350 SoC, only the dual-core Cortex-M33 support is added.
>
> Sent as an RFC to get feedback on the overall approach before polishing
> further.
>
Just out of curiosity, what's the purpose of adding support for boards
like this? This will never run Linux and there are obviously better
alternatives, designed specifically for these tiny, little boards.

Best regards
Patryk
