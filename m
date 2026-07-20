Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C7EC44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 19:15:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8F2180AE3;
	Mon, 20 Jul 2026 19:15:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sH4z1kMy2-k9; Mon, 20 Jul 2026 19:15:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1266980A7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784574926;
	bh=4KITg7q3fZPFzzXTWiaZc+zhHmZtI0V3WlgabnYtseY=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=j0RFxyQwuA/sfj7uQ+VSsm1lLS2lR14YJBp3rUShHdclPQHPydQ4/Y3edgHwE9YuC
	 9Pcr+Z6F96biK3bUWmgvpDPI3VVAmbkdvIoZF4F1D4xY4rJIHPNx94lMrTfbYvuwK8
	 v9slxqf8HaaiatcUQTvHRNTKd7Ho4+7rNzp1EPwZRZrXhj8ufzq+bVPYGuuSl0rA+A
	 YeXeVFdXX+u/Qmsf08d9mfKp0NBP2N5D4bS5+ESCwSV1o9q0B2e2MdDb5xRy4YICnd
	 t9wFGWp2R8+q1K6dxdVHkFJclroXBC9SEso/4RvWICIUzKIsieIu0TtJCsPw6xGjGi
	 6wtAE9uykbDdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1266980A7A;
	Mon, 20 Jul 2026 19:15:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EB73D786
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 19:15:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D1C7E4058C
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 19:15:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DKW3oB3GR21H for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 19:15:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22f; helo=mail-oi1-x22f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 24DA940581
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24DA940581
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 24DA940581
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 19:15:22 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-492046a3313so4892460b6e.2
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 12:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784574921; x=1785179721;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4KITg7q3fZPFzzXTWiaZc+zhHmZtI0V3WlgabnYtseY=;
 b=jkDKR+QXhhC3A0bonZXQJTEH1ODBujviDldJcUPT2lzNKzjTV2T6+Xvtbokrbsu8k/
 DMey279CxVFs6oCHytnLLdhSok0WW9XuDbeIdg5+ARTZTNWLdNDrNStjbQJkiQ4ssIzC
 HjcgbxkEUmbfp5R1dZdBahV38W9l2qK6KPUfeqJcFXmF8Xvqvb0cYF5gq8cwK00Ehd4G
 V3tnE6MBnhXgDdX8aNfzXy4uVZYOVhPG2LlLAkyb6Wk/ffE5k+dBIm0b7e4+gDo3Z/qb
 IYQNeTGLJuJhrr/e3c/+fs0uwV9CxrqnC7RRBCOv54iIC+R0ml6FG03WmKbxuwyR47n6
 tJug==
X-Gm-Message-State: AOJu0Yw27w+pifojwdYjXPSaELjjF/U9UF/yaxlG85/ty3nk7PQRHo8k
 cWW2QwjgNmbdUCSB6kByM98kQCL0O8HLx3sTDgTgxVWM/DJgIGtyPj8j08ZL8rwf3v/zr4zZOTm
 8czy0NXU=
X-Gm-Gg: AfdE7clb+5GJXKTMoBHecPUwYTSFDMDV+JSH9fLGMVG7mRTgLYzWyylQDFsdVYYUvuw
 nNGS6eWYmPbdMid5p7GcLGL9kE3xnmq30WRI7O562ztWNLz84qiV6cqrqgWk944c4q63neEpNFI
 0DtBkzS9/dWM5AQLtq/g5casq/VxM/+flcm/X8iG8p9cGR4YHTsbUaTzGCTBQYwiTgNNkrjl9GL
 26Jau2h6Ayp6dJjI02s0LI+B7bUuq/lTe60iOKci+A+l9z2ZFt1avUiMPV7HL5dvgL7NGKPlNpz
 mhAbyvo6WJH85oR4wNOq0DM/BI4BRI+INE+YLSfSUqXzsB86JpKVear+uR/4siyy/Dl8vR04+xS
 xF7EnmwTaSN94XfNNcNApeAvL+DqA5p1hRlUwEqI1IWZnL2wcUKZf8k7eEVlb57QYX1gbw/Z9Ji
 BtNBaspryvB8Ex6FGcNDsPzO6HVcfb11Lk84J39igQ0n17IDP7soF61d3jBowC8JDCP0DbEtEZ/
 NTovl0L689WBI8Zn1WWeUB0d1gGa2lWwMjo6nIv2vdxw2e0YdQ=
X-Received: by 2002:a05:6808:1529:b0:496:fd1:82e2 with SMTP id
 5614622812f47-4a4d031b30emr9804736b6e.27.1784574921067; 
 Mon, 20 Jul 2026 12:15:21 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4a4d3d06e08sm7830651b6e.14.2026.07.20.12.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 12:15:20 -0700 (PDT)
To: u-boot@lists.u-boot-project.org,
	Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] global: Switch from source.denx.de to
 git.u-boot-project.org
Date: Mon, 20 Jul 2026 13:14:56 -0600
Message-ID: <178457117585.2414914.11328974657092094838.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715172146.80974-1-trini@konsulko.com>
References: <20260715172146.80974-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784574921; x=1785179721;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4KITg7q3fZPFzzXTWiaZc+zhHmZtI0V3WlgabnYtseY=;
 b=qTk+061oIbwHLU9JaBtwEA3/1aPhF58iTJLfoDLs1jB3TnILmtEMh8dKil1v8Alx1i
 k6vZofG9xx2yzebQJvgRKydP9sdQ5ikAmX9oZDCxQZfuFr+EyESMmlu1X+K5BkcJgATD
 XpMAHkhQn5r0P78Qgp9f6K1h2lPg3XIQgQuR0=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=qTk+061o
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
From: Tom Rini via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Tom Rini <trini@konsulko.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, 15 Jul 2026 11:21:41 -0600, Tom Rini wrote:

> As part of moving our git forge to a new location, update all references
> in tree to point to git.u-boot-project.org now.
> 
> 

Applied to u-boot/main, thanks!

[1/1] global: Switch from source.denx.de to git.u-boot-project.org
      commit: 042e45e026c77227319a426940577856ffe62e7b
-- 
Tom

