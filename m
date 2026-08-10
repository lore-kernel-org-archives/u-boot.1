Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E92C5AD55
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 20:53:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5275480F09;
	Mon, 10 Aug 2026 20:53:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HVEiNHFuSKKJ; Mon, 10 Aug 2026 20:53:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 530BE80F0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786395210;
	bh=Vx9Dv915moHK9lJOqKe0V/mZ08zGf6G1FrACJ8gNtyg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LePzZNzsMeIMsR0KCnQS4406TZjCBuaqYru6bfD5QCblHOwHBmNRlmRVu0+3M8vT6
	 hYbUAu9u/b42BVZCMxZUQNVPX86qQ+DyzetOKdH7f/Sb5kKHIdyN4ZgQVIJEq44umS
	 Gc1TR4vOmIoqgv21d1oUxUkBGzJ6XiDkiDKvkYsBuPuaB0Eleis9tMLHaMiqNQfco0
	 RmS4V5E4sAm96FXBZ6njR/CFR9d6jCJj41AUPL1Ou44QtxQDrTAUaxhWeJWQ19sEno
	 I8KRDJJT+jRhLEjdKLTsRe4FB8qe5nBNzvbIEmR48rlbwseSzgUZyvq5AlL9Tj0/pW
	 Z8mht2uT9noVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 530BE80F0F;
	Mon, 10 Aug 2026 20:53:30 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 77B5810E
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 69C146075F
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LAV87FYr7_w3 for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 20:53:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::31; helo=mail-oa1-x31.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B534C60756
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B534C60756
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B534C60756
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 20:53:25 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-44cb057311bso46242fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 13:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786395204; x=1787000004;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Vx9Dv915moHK9lJOqKe0V/mZ08zGf6G1FrACJ8gNtyg=;
 b=BH0qUuWO8om3yVY8z1eZRZ7EiSYU6i0bJiaPj0D4vgEe3HuRhiTD9mnxsSB5mDr8gA
 DAafnz8VnQaBEyBTq3VBdVUtXkWt8I5b9kaKW6DH4Q/kAFSdcMW9b+iQvApaBVgUjSWC
 MzD4LrZ8iY8wUzuTYNgnAbHhpx9/9xGh8qvmn03X3NloLGICOKTSelJPjPX2Ay79Gqzb
 0ceHZXPVZxk1m1TgtPbmDxmW9aghtD/z0wIOj314EVwFW+El6duftFH3siQcMuofp8IN
 DcuSw/uTZipn5KKK3tEzFTPwKLPBf3yaVHsElMQA0owinJBh8EQi7FKzsQoHUShvmcPR
 VTkw==
X-Gm-Message-State: AOJu0YyZTz5e2mFuvzVEZT2xvZv63eNDuJOmAQRqOVIkngeGUwGelvUL
 mOa5HFu2jzynJqz9UL72wtmm7pdk/KzeWNU8K8JnmgwjYenjaQ7MGcxWXy23tHONQy8=
X-Gm-Gg: AR+sD12K9RoMl09JGPJnx9EuDOV266vAPCZRtA2znCrhezcITsiHXbdVxcM1Gj+k8Ei
 GYsrN5k4A3POY5vRkKjMdnhYJlWfQxAJtijy1Z/PP24MY7VWD8iv4r4E92MQPxGp9ARcw0Gbgbp
 tm+xwHXTxpPjT3wBKbeXAscuhhm2yzjx+dxGEpQR3vkS7j5HNGRHfClAhTEnhIDAti0mth1wrj6
 skwlx82oBzxox1t8iHGXYOj1jDpZn9FN0vlwK/2Rc7d4BcqvTHSC6dhQ7ve/1O7LelvhbCjO8pM
 UMaWwFRPepUyDGEe40xbgQfgasmvmVcphlwYEkrwBPUiY2lkYiNIL/sxj5W34SPcaw+5kVLBZbC
 Ldod0PWUpdTrrYKWgZzhv0J6A25d8CSvFMUZ3NWj+OFjyvOhpDQKY3fgNWNwr4mlgLoXJvTmHk8
 +b6EeFxj6qu7JcGm8F1QzSdve5802/eYcLLGaPExnvmFajcXSp0vEvNnE9FmP9JJHQzbnNQkqn4
 6zERfvIg38BEDt5BsQhehY7OTqMHXB58yKu/5lf8ygu+9HR4TU0ihyftI8eaNShpzW07t4g8/4P
 CVucwelY61Eru9UORXA=
X-Received: by 2002:a05:6870:cb8e:b0:43c:2d3f:95f8 with SMTP id
 586e51a60fabf-4599e58b491mr23930341fac.0.1786395204623; 
 Mon, 10 Aug 2026 13:53:24 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-459f1a76701sm9061652fac.5.2026.08.10.13.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 13:53:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260802220904.168737-1-marek.vasut+renesas@mailbox.org>
References: <20260802220904.168737-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] cmd: scsi: Drop duplicate leading scsi prefix
Message-Id: <178639520379.1450255.6711748669004925296.b4-ty@konsulko.com>
Date: Mon, 10 Aug 2026 14:53:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1786395204; x=1787000004;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vx9Dv915moHK9lJOqKe0V/mZ08zGf6G1FrACJ8gNtyg=;
 b=QlR2DOejyobHjEHm5mCNq0wwz5Ju3PbSHjrmYvn628YolbaTbCuAtnhXYn4c9cNC1Z
 i2hzLRBYYCdWBGoE5CDKrOnjRw8fBaO9v10YmxIltEze7aJGakJuL+VJVukRjG6SXkxk
 APM9OZXYVZ5yM1GNdBub0Vzg/td0L3dEcEgPE=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=QlR2DOej
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

On Mon, 03 Aug 2026 00:08:38 +0200, Marek Vasut via U-Boot wrote:

> The SCSI command currently prints the following duplicate prefix:
> 
> "
> => scsi
> scsi - SCSI sub-system
> 
> Usage:
> scsi scsi info  - show available SCSI devices
> ^^^^^^^^^
> scsi scan  - (re-)scan SCSI bus
> "
> 
> [...]

Applied to u-boot/main, thanks!

[1/1] cmd: scsi: Drop duplicate leading scsi prefix
      commit: 06084f6f92a2fa6b2756f4928ddfa27583074d97
-- 
Tom


