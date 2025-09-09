Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38F7CAC582
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 18:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6654E8318E;
	Tue,  9 Sep 2025 20:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EvL4kl19";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6864F8318E; Tue,  9 Sep 2025 20:31:44 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87ADC83192
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 20:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-4023132bd4aso18406785ab.1
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 11:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757442698; x=1758047498; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D3KAEEli+YbbGJ8sHGNEn+oHxPbEdEKMeow/xNT2ZWM=;
 b=EvL4kl19lZOfeSuYircO8SkD+29XhNFsjGB5b672L27zPgABJwW6DbyxsSR8PiHEWu
 d4/NwoBPyGSCeADlKPM4wz0gheY8M04bGYYjM6zQzGoI8uZW1lBI8qZYoIjh8A/+VaN1
 94GNEknPYR9hF5pyJIFGht+xvNXwGVhCErQQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757442698; x=1758047498;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D3KAEEli+YbbGJ8sHGNEn+oHxPbEdEKMeow/xNT2ZWM=;
 b=Jvp/BfwxJzORwLT8d+sK2+kaEwvQ2fe12a7b5aiOc9wdQWyQUDJQzdz2DO8vrtz0wT
 nkI+C2PVv01R5EERjN3MHnCeNSqLsboKCADvzAUUNIkylDPqhkMSAIpxQ6544bt5iQUv
 KmEmWQmzMrx+l58gSpgG4uQZxHduxNDf18zeD2HbwzRUTohYnxP5AMabssDCM+Her1RE
 A0Se3vfMkO3hocUYyGPT5aykNxkooj/6aPJYNkVwx8Je8v5ikwht75na/71vHHP/MEqO
 JGOdJ/YlV2s6evNvwW6lUutmrONPPIO3XGThajKl67CkoXOsDyXGtxL6Qwv857Yos3/p
 o1PA==
X-Gm-Message-State: AOJu0YxmRxUckk/m2u3caDfPCI7RwSOg0ChRaG4gHwzE8pyc73IU5wK+
 j/J0C9Be/Wb8TEv2FlBjmm0WjbuZMeUHkxDRqOT6RptT7LjfDFy4gu9BPIJ2XEIpFkPLTeXCuNy
 Nw7yd37Q=
X-Gm-Gg: ASbGnctzmbiIuq1h7gudHtkbllMCubZ3AvuM7sj2XRo6GFG32lghhN+r8gESUS97Yz3
 +cE1pbbahZp3rA5KWt0dxU1qgrh7bVjcUYQYTbilfBXu1yNFPi7kBDz3212TIiElVLBgZoJJrGb
 wZX+EGDNkqjq1csRcxkuoxD3INf/JKHnk2utFSIbFEVdvBw5kIVDyRJ9hPGe6Ik8WUUvD3tLnvX
 zrma450HBDpdm1UfUzbYKujjBZBS6vtn83nYCiJXrWkac7EDuvsIWPA+IlNqzNCTzE2yUAF3RJ/
 HDmXJnzQ4ooFKtyzE7wwr7MuKNVha4Aiy963+zTRXiK23ZtFFduIWsinm3PmJOpo8oW6aUQBLq/
 U3dYI58SQ9FKnzrrkGBaJjNRZN6v8LP0CKQUw0daG1rhE1zfbF+k9+SA=
X-Google-Smtp-Source: AGHT+IH2DK7CJG4/C/1dvrCYgOED66UXLUvVn3hDdm/lg8s3ktQq+9zY0QO1E46DoAf6JK0BJiXOwA==
X-Received: by 2002:a05:6e02:16ce:b0:409:4a96:3168 with SMTP id
 e9e14a558f8ab-4094ac3fa43mr122650295ab.26.1757442698226; 
 Tue, 09 Sep 2025 11:31:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-403c8eb8884sm32715295ab.33.2025.09.09.11.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 11:31:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Rasmus Villemoes <ravi@prevas.dk>
Cc: Sam Edwards <cfsworks@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20250819105554.3067982-1-ravi@prevas.dk>
References: <20250819105554.3067982-1-ravi@prevas.dk>
Subject: Re: [PATCH] common/spl: use memmove() in load_simple_fit()
Message-Id: <175744269720.1809471.16465180669172096216.b4-ty@konsulko.com>
Date: Tue, 09 Sep 2025 12:31:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Tue, 19 Aug 2025 12:55:54 +0200, Rasmus Villemoes wrote:

> I had trouble booting some am335x boards (both
> beagleboneblack and a custom board). SPL would start just fine, and
> apparently load U-Boot proper, but it would hang when jumping to
> U-Boot.
> 
> While debugging, I stumbled on this memcpy() which from code
> inspection very much looked to have overlapping src and dst, and
> indeed a simple printf revealed
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] common/spl: use memmove() in load_simple_fit()
      commit: 122c25c00a238b55ac6745eb961c5ea66b45be8c
-- 
Tom


