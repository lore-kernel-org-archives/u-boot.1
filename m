Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B668C79FB9
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 14:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D129C60B75;
	Thu, 10 Sep 2026 14:58:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SYbToG2i4LKD; Thu, 10 Sep 2026 14:58:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 10E0060B57
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789052318;
	b=dg8780ZYNVV8ZgHJIPQmvK1mB+SqG9J/g8x2caRg1sGbWb+muq02kAwqaG1JVFv7IeUY
	 Wqz/kxF4B+LsuBQ0cydan2DEDd4c+gPWCD7CxwzRsi/rVmT/M0lHpGqe8h98DqJ2xhSCH
	 0GHDdDJHV++JRjIwX1ijlqvvFsm+Tr4HB/Le7upJgziRL+8LraqfJP3q001uA2rsRvfih
	 xU1IApXkSFtUF6bqpuhTvT67ktziMBrfLGpqxfpXNn1/Olac8oYW8+mP/YWg7jUOP+/nu
	 hi0QFAjdKl8X/ucGie4UDea1haJ1H7GlINeDD3rxetX4xV68wpdfxGrXmry4l/7oxaw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789052318;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=nyy2NwNNfoYuIJPve3lq3Um4uo9o6NHQzHRXesrtyx0=;
	b=nowHRRe+jK3A5SL/xS10CXH0taKlAHYuYm6HX8cBMlRUMPmQzCpPOijxgZ9nbHEAQagi
	 65cEKqDSKD7rRDXdU8WzjJisVYA0umI4ZAb+ijAWcjt5Pb7t7KT/vy71cYBCqB0FNyTAy
	 DtuOnU0APke2DmMH40fHNeLsx0LcDUbt4RN6OdTWhB0omqVRpgKc+CcvGRjgjTN5E8X/Y
	 Tc1tgVYQQ9TXmKe9V3f9/OnhGqR3N6eKN5SSj+HFhdwaR2pXhC2QMHSb3/qOKTlb3bC9R
	 N15PZ4YrTc9RgztVZJoIAfXAj/jmctoaV9Yr/y9ro92hOpeEYXRC+r7pVzHDv3d3SpQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D5Y5VQFp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789052318;
	bh=nyy2NwNNfoYuIJPve3lq3Um4uo9o6NHQzHRXesrtyx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NIv2AFs722uuApXN8FAEaarnZLjOGhwg+L6fBLIbKGVbgedC1xteXQsthbvXOMkLy
	 l95PfVyiP8ihi/dnKw4ZKR8SBpugHvVXoiV18rRk4NoA7wxd1rml1Jm1z+WwTvwko3
	 q+VDGAU9sWYWCy/cp4sHVfAoAhVLI3q7q6PEGpNL2aLq/bYpOJTGYerYtlN63EpaLV
	 oKEvt7403nr1ZBUHKZel2mrCYb/UtmU6nmt/zRACird/fEn/RIlH5V+K0+xp16XIx7
	 duA7dZIaXTmJtnAIlTTyk+VcV2Gtj9xwzcMfzc3IGQv1V+yrtyZnYuNCIeyJ7l5DLM
	 TH4waC9+9CRgg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10E0060B57;
	Thu, 10 Sep 2026 14:58:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 49A4549D
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3986060B61
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:58:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1P_hVPMix1JQ for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 14:58:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 02BA760B55
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789052315;
 b=F6G/4D93VvYw8+ilmyemfqFt61On3z0u2Dir0JUA3sP4WUnNJWwpTV4qizvJC5+KJmAB
 pT3/7rwmqaGgbCQJREf+YIRoIptIBPf8T/QX49pWFz1KXiGX0Dab8Tk4GBNg0uRECfsRT
 dO0eBSST4Nsi0nob+pnGwkoYmOZtVHG6DVxDh5z1VbjVY68of+ta/uLA1ddSOZLNIIs4f
 raoROuTZgAy/E1w+GA4b80ebvu8QgEUaczani82BDBvoRdiEEDQVox9J1sFg1OyYDHmb+
 IEyh+H29JVpEr0n55/zrZ3aRbgJCkiTM81W3evEp9CNjocUmeoDwnZVj+MoBa5CsbRg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789052315;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=nyy2NwNNfoYuIJPve3lq3Um4uo9o6NHQzHRXesrtyx0=;
 b=oCoCclLn8DIaRzTqU/kUk1pzw6smlXbq1BlLEnu/IsVTXmbem0tg1jMP75iLXvtcuS1v
 XkFJ0sYMVg2topfQVLIs4+uqoNeyl/GE1GfhYz/Tl+lW/ydgchoxuBUG7ypRMlfk1cuwG
 QyuKKyWztlUNIv7veFob2h26UtUj/kKHlh860SNG/f34n9YV4EqFn3LFAxvc9bYb8vwDY
 E731DlgBldk4W4aMM49SEozPV8/0DKtO/5Llkl8+/gVjnO7m+fQsnlGiF/DHdjP69FvOY
 YKbja/Eu6s3zKHKrVGGdIkMJ0JgZPvzMgL97rZ1CTovtWONT4oU2YLYn9WXmdPDeWag==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=D5Y5VQFp; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=mehmet.fide@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=D5Y5VQFp
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 02BA760B55
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:58:34 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49b8e527d63so92402685e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789052312; x=1789657112;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nyy2NwNNfoYuIJPve3lq3Um4uo9o6NHQzHRXesrtyx0=;
 b=D5Y5VQFpuVWhIhKm2ZLIrsNy8+xxI9VL+ORGX6u6ESCLkRXeMgYk9SBFf4Czairs24
 F8ELs0RVwsJ4BbrOxoscV9/Ot1SypGHmgvrWWDyeFMaWrvKr/O28dlHh71vMDirdejXr
 f5VcvveOo0JAHEBexAuBvGHGAVHCjMJ2UgpnaE97OpiMQPkI0gYQkU3mKGRUslsGOPVf
 20IPY3uhAVYb2s9wQ2nEFn7kUcEAjLQVaCjtUP6596ZEG8plJuA7C73yU+Fcb5SLEo0Q
 oile4fAC9GdtoD7zEQ/rYFiaEQg0j40Lht9IA/a6IbvV4f1bc84KmzBIrqyIaMizSOpK
 v61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789052312; x=1789657112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nyy2NwNNfoYuIJPve3lq3Um4uo9o6NHQzHRXesrtyx0=;
 b=oyI7WrhwxcHM7tfyMSs2FFt/7WGIy8Svo9r0wRZ12uIoRlcMRTKvUlCktsXsU+bUDE
 0dmiYEmaJP6Gh1BEO7psI7vvddg0aqihLXwzn4U3ZUVkG615PIKG3NDc4xpDIax8qpfy
 v8nsrGsLC0aRgQ1eeFFfiYvqOC2bKXfCRBj8NO5BLRol/lYg+ThZBYsXOHMA35wMI2IJ
 +CfUNKOz8rFH0/nZKMHliaKN+CsBnlpoWg6XQrqdRtkQDP6o1OhtGYgjrpQZEqTK+ULb
 hliEvOcj0hLkTRkpoKw5LxSsnE5RD+cpT7RANrdeWUTgmoh552cdX1xVV+aQMgKz44Vy
 zwqA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzYpQKm8iBgciqdJ1LsRkcy1McLZKsEN99vKEY5fJNXPsGuxAM5a2JoS0HqDNDuhxx3r/lmm2U=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m+qBNEgQBV3BXc7nAFsXDnaqVkx3zzxiBZwXhKT14S40sUH6XD
 +oHAHYAKyt9rN8GkzhvopPRQ2pT+DKFQ5ToAJ/AayG1rfFL6JGPV84kr
X-Gm-Gg: AYBFou0QX81mWQcUOeRqaTJgt5n55CfTaOmccx6QpGo+KKcfxsUis542wPIS73roqla
 VyGM2dLiF/ktTEZrJKGbMt+DAvUIVbs69/QYJ2VJ9DM//AIrmzTSPKeOPpdYkm5XSsRkYrL239k
 AvVPCcwg79Tzx2EYAheqryEYEYMBw4h8/pLXat2WBXxmC4wJFgqC2iQuAM99VTwJlvrHIg3VK1G
 7lVvO3a/Qiu28vRN4+4iBfSwDOM4K5bjMDM9oWXiDMzjftdWNilP0cQ4+Xy4WQeq1smn6Sxlx1Z
 ty9VpC7H0LkKe01PVx3KB73uoEyODTIHG2mQrVNl0l3+KD43v/Mb1b8DqqJZDpuyW4KENPMiR7e
 +izuOF9zZ0S1t+8sScgiLH/XeHS/OJ51/9L8FQw4p1prm8JlPlwrZGipgkic220OjtbeHWWHwub
 1PVtJc7DWjYaXjmsBIjrRDpC+2BEa0BLtwnTaj2bBOleiYwbtI5TOEFrDTuPQkHbZSscCFOtKvu
 QH3
X-Received: by 2002:a05:600c:4e46:b0:49c:fc6e:8cb4 with SMTP id
 5b1f17b1804b1-49cfc6e8e51mr383656395e9.24.1789052312031; 
 Thu, 10 Sep 2026 07:58:32 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c300e2sm84539705e9.8.2026.09.10.07.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 07:58:31 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>,
 Ye Li <ye.li@nxp.com>, Michal Simek <michal.simek@amd.com>,
 Aristo Chen <aristo.chen@canonical.com>, u-boot@lists.u-boot-project.org,
 Mehmet Fide <mehmet.fide@screeningeagle.com>
Subject: Re: [PATCH 2/4] regulator: claim the enable GPIO at probe time,
 not in of_to_plat()
Date: Thu, 10 Sep 2026 16:58:30 +0200
Message-ID: <20260910145830.1276001-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAFLszTgNV3_vOO4o6rzVabU7+amqLR2NSek3xU-05kb_jvpv9w@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi Simon,

On 2026-09-10 Simon Glass wrote:
> The debug message is stale once the request moves to probe()

Will reword and add the missing newline.

> This quietly changes behaviour: the old of_to_plat() only
> debug()-logged a failure from gpio_request_by_name() and carried on,
> whereas probe() now aborts the device for any non-ENOENT error.

For the fixed regulator there is no change: regulator_common_of_to_plat()
already returned any error other than -ENOENT after the debug(), so a
missing controller or a busy pin failed the device before this series
too, only at a different stage. The change is real for the
gpio-regulator's voltage GPIO, which used to debug() and carry on even
though the driver cannot do anything without that GPIO. I will state
that in the commit message.

> Also the 'if (plat->gpio_dt.present)' guard duplicates the check that
> gpio_request_parsed() already does

Agreed, v2 drops the guards and tolerates -ENOENT in both places.

> Does fixed-clock ever actually carry an enable GPIO in the wild?

Not in this tree: the only regulator-fixed-clock node is the Colibri
iMX6ULL Ethernet PHY supply and it has no GPIO. The binding allows one
and Linux drives it next to the clock, but our set_enable() ignores it.
I added the request only to keep what the shared of_to_plat() did
before. Since nothing observable depends on it, v2 drops the call from
fixed-clock's probe() and says so in the commit message. Teaching
set_enable() to drive the GPIO as Linux does would be a separate patch,
if anyone needs it.

> Once the device is probed, gpio_dt is dead weight in plat

Yes. priv is not allocated when of_to_plat() runs, so plat is the only
place the parsed description can live; I will note the trade-off in the
commit message.

Regards,
Mehmet
