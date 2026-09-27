Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D54C98338
	for <u-boot@archiver.kernel.org>; Sun, 27 Sep 2026 19:08:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C671F4076A;
	Sun, 27 Sep 2026 19:08:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LBF7mARL-qfQ; Sun, 27 Sep 2026 19:08:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DAB4F40767
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790536134;
	b=lbJSDx+Ik21ABmX5cd5niBnczMvhNPWwvv8yNRZ2Sg7TtY5C462hMKCk/h0ct61Fakmw
	 qjpRJXpDn+oyvvtd5ODqLgaFnARZKo0kUi1P+oM23df6r07QJWLDe+5BjP5G/wSuiYPLw
	 V/esTqVJPpoPk0kJiu1kkAI3ASp3bfC5/LOXGsXwnVXiEoFPyIoHPCvVZeRo39orwmFue
	 hAzjG17wYROdm1voiSgl1zs/EMDYdXIeZXRZKcS42uh+LkqKzLb3T760YUD03+0q2C/0I
	 YV5VTeUAWI4uAmVGtXn4MNJO82Z72xdpx5rEvhmwux5vEUMlPQYYIOK6jZB6Q/Djflw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790536134;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=juUFYx199UyDhXlD874GARhBvthEXSIEl4QBE2wUJ40=;
	b=pGl7nFtm+1mgeP0/WWg1uJhYUc6l/kadHigJaQ8n3QtNYL1ZihyfAKKquHRhGsaz0NqI
	 QAzvk03XYMk/GrfkD8ESMG1JnqMDDuMjY/lTQxL+w9qkxYLWxcrQlXX/TjOjWMJgL7FLP
	 b5TVa1bVaayToI0gCJjjMd1+EnkG085b3XK/hPCDJzxXGV+kQtHRXVpWRcItx7mGB/Epo
	 Qh2BnB/EEI1UC9NalbfarY/I6oMdcIRv2rLAywisWMKgw3FPVpWvNg9zNoWOW5aRem71F
	 p0pqWCV5GAh5qKsur0QE02GKiKaJ80tdXeH+VupYHqiDDNf6QyXTKs373aRvipWPv5Q==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790536134;
	bh=juUFYx199UyDhXlD874GARhBvthEXSIEl4QBE2wUJ40=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wnXKQdS5VT6M91J6wMbOHk0LYPUdygVNLQ+qkPUg52JuPSwQou/CMoq9WXFQU7weg
	 rj4j/Es6h7Z7hYwiNaO0I0bnBY5sV3mz0ePfa2Dh7umWY048/G57bKoaQx15+LFYSi
	 M55tMdoChGoM6hlzcklWtXm6Oz3UWOduXqzrSKuXVqpTEceUwWtOgP8IRmFeaathHf
	 Uv9BefG4t07Epx0dgHBfDCnIcWtWwIl9tSjMeRipz7sErd5Jl0yfLuEnFHhRPhcuJZ
	 C6CuHpSFql8WSYIzazOaOpNBmOglgnTQGZLVleFwh7CwVNSzkL6YpweMsemzP/9JLf
	 kpwg+hO/s2TZQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DAB4F40767;
	Sun, 27 Sep 2026 19:08:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E0085194
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 19:08:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D1A9F6060C
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 19:08:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FiPG7AsyggSA for <u-boot@lists.u-boot-project.org>;
 Sun, 27 Sep 2026 19:08:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org D647F605FA
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790536132;
 b=jRZoJs7SOtCAllqqK8PvNf/Rir91+OCK4xEmYiPXkicbsCpxqdxABZL8MTL9xo7p5W9y
 8FlWDHIOZH0sKBLhY8UPd6EjUVDqAo6T/Q5NAz1V6kcwXpCvPA+y5e4tMqn12JdtStxrP
 fEcbNBQzdzhGofuDmxC8ArhiPXDdAuSrPqgRFFireGQ3lsi5t3HY9DVZX/piJwSyA0Uob
 b7seDzgoClXRFqki3GywRCQJM1hjC62KxSW3kFqAKDvXtDHaWOX7AQVONRMg0e0RSv9jZ
 94V0RIQCCzrA4KPprUzlNzuL6PNrLu+QXqmoRwAkZ+rhTxspn+BmaYPa6B2KmJDbuqg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790536132;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=juUFYx199UyDhXlD874GARhBvthEXSIEl4QBE2wUJ40=;
 b=WCCEZDot4XF4DOOWcaR/b/nzokEahx+8/4GH5cBtJ+d7y5OxLAvuAk7qfuZRySl2qSwk
 ADJa3VM0VXpDRDBq3+8Eh1ZrTCCMvdme8W45a1Mzu8+hiSPfRIcq8u9unIz5/QD+IPhBz
 THl+3/F4Vx/SiUhmEkn5FSJPU879doCbRB+NVrSJmafK3T38M0zCWFiD6wGhJWUJsIAOo
 IM0pMZ36nsdM+wTuuqDgk3+GmOgfMOHZOGln6zqhmVLv2Z8zSfQRnuc3Rvw7nAUrC2+2f
 AinIHdCZ0d+ENw/cgepLQI/8qHGEIXfyJ5ZF0f19W/Ib2Sl1ohO86CJHrNsElSEufSw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nh9p430z; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::b;
 helo=mail-oi2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=nh9p430z
Received: from mail-oi2-x0b.google.com (mail-oi2-x0b.google.com
 [IPv6:2607:f8b0:4864:32::b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D647F605FA
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 19:08:51 +0000 (UTC)
Received: by mail-oi2-x0b.google.com with SMTP id
 5614622812f47-4bfec71901fso1193391b6e.1
 for <u-boot@lists.u-boot-project.org>; Sun, 27 Sep 2026 12:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790536131; x=1791140931;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=juUFYx199UyDhXlD874GARhBvthEXSIEl4QBE2wUJ40=;
 b=nh9p430zIykyRz+B/mjWsP0LJ/OfyT0W3znTpvAV1xwL0svuVZtcG//KYIubWhsZnq
 cDnGOQDaPAeofdG8ELE3dx2NRV4vnE3HtMQjO628r8cuFl7TDyaddJsH00wwAWLWw+Gn
 sK26uKP7oyS7V3ykdRkiAI5jDY9dMdfczBGyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790536131; x=1791140931;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=juUFYx199UyDhXlD874GARhBvthEXSIEl4QBE2wUJ40=;
 b=kxJtqU72gZy9FoVrcSQGjlRqAvCmytOJxPs+bqneqciZoHHxmgX/yAIQXG9T6/ydPN
 x70WjhgYWcQM6Xh34YraDc0ZYb8DD8hcxdTahRgvDVs5XGf78STsZTmXU++AgBVHmPjt
 p+vHmGQMaaeUuj7ntY9ItzTXopD9Hw/ExkN/gyX/q0nGyItbEpz1ucG7vNZOyKz2vroF
 WghH96+ccKcL4VEnnuUH8m4OXYBLCVXfl7umCMBKwV4BTvMKsWmT86a2S5tRHWbIXsL9
 QidgOl2GmH/P02TEZ67FuosGk6QvPA+9FJCOyfh4BGBLl15wyaFkP4rPMRYXIjCcmgNK
 qxCg==
X-Gm-Message-State: AFuF++m7kxLDyyBw/aB0cV8Zkla96L5fDCZr1hWpAT6l9P8iGEieiVZt
 MtbLMp33/QxOpE1DAj9wKFIUCOzimBNvKBs+yl8Jvxbvfem4X8VbmCmBbWmbn602gU17rGBfORC
 jKKaFmxt8YIAp2JE=
X-Gm-Gg: AYBFou1QpuT3NEstfJ0uED0ObP8SkAh3JLhOhKkldoka7phmgJiTWjDlYlGgrq9sH7w
 HRYnNgZyjB7RuNdR00wIVgLemwVWT+yklrsMqZzEjNV5dGV7zgpU3RHz4DSi6D95OF54rxf2t3h
 y2UPxAqGkT73n21VUES3MXu7uYlgNVvhOQDe/wmhV4OWHZb881yVvNnZbc2eKBn0MPv88uuI2vH
 Ys7msiJjaiTKnP/8DRCWzH2/ejM7fSt6SeSqbN8HyG8sKx/T0wtuf4SJFQmQo8mjng73DrKd752
 i+Z+0lVWMW/8EAX2vKazN/UF5fWOoZ/izoAM9ybUO5BLw0eJrzgbIeny/s1Pj8tFsQkCdjJF2M5
 sCTYlU/nFZcll+O0nCRlen3pcuepz62NdROqgP6CsP6atKBxlAk3uLUEoVjk1cci+qyaoPPYRZp
 S0h85RkMU6++qZ0L5gvKQ+gPvyzw4dm5hwP/HJ8k2ekkyw8KSooVw42rbKvyDkuvkAY41X9f5RO
 oM9cRcEcivXxjPiCpPWSHir/cywmBBswe7MZ7NfEY04A3gnNtGMVMDRlhyUlbA/t33jI2YZZC8R
 YU+rsNp59SukHbh7iw==
X-Received: by 2002:a05:6808:eca:b0:4c3:bc6a:a328 with SMTP id
 5614622812f47-4d72df6fcebmr10699591b6e.31.1790536130779; 
 Sun, 27 Sep 2026 12:08:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4dbf849c0b0sm7300032b6e.11.2026.09.27.12.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 12:08:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@arm.com>
Cc: u-boot@lists.u-boot-project.org, nd <nd@arm.com>
In-Reply-To: <3fa59a87-81f9-4ba0-80c6-bec70294dacc@arm.com>
References: <3fa59a87-81f9-4ba0-80c6-bec70294dacc@arm.com>
Subject: Re: Please pull net-next-20260923
Message-Id: <179053612894.2206597.1436758321779243080.b4-ty@konsulko.com>
Date: Sun, 27 Sep 2026 13:08:48 -0600
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

On Thu, 24 Sep 2026 11:48:11 +0200, Jerome Forissier wrote:

> The following changes since commit 9e002445cd0d47d3965312f12e97a18e1ed8bd53:
> 
>   Merge tag 'u-boot-stm32-20260922' of https://git.u-boot-project.org/u-boot/custodians/u-boot-stm into next (2026-09-22 08:59:41 -0600)
> 
> are available in the Git repository at:
> 
>   https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git/ tags/net-next-20260923
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


