Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBB8E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 04:04:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B15DF801A0;
	Tue, 17 Dec 2024 05:04:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Du/PnkSU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 504E7800D2; Tue, 17 Dec 2024 05:04:15 +0100 (CET)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B1CD800D2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 05:04:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-467725245a2so48898291cf.3
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 20:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734408252; x=1735013052; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1nRsC3GmDMDzUjDZWxN5+uJ9sNyyt9vq9X1jtHAHkpY=;
 b=Du/PnkSU8/8uiZBM0RvZ2+dA1ckR4M9lceUB6H/Eaz1zHEhRFVuptfkQucsvZqvVyl
 VrfUk3SRoAl+eXAcYLEdW+VkcNRORKxCl9IiXG0CHV34sL4fGEAzOe0g5vJjqSjiRg8Y
 fXs2eaLDgxuCuwqSVMrhKecdCed3ixCcHOdyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734408252; x=1735013052;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1nRsC3GmDMDzUjDZWxN5+uJ9sNyyt9vq9X1jtHAHkpY=;
 b=M743iR2KCuOdVSRNk6NDmtbkSkxb0Q5+faucgcEnFNUIOD2KNSg4HLVi1F0aLQcwcO
 uFWhDPS19cSaK2MsLh6GTHW1icg+z7Agn/PZOvwx+o9j2/EvuDxI7OOvJYMxf8QlBLRf
 EFbhqRaExtSL4/fME22h6urQN96whcVcEHzXmghKWf/c3GEALLeU606d0NUwXznqH/AB
 pY2b228AMhpanigm5nFFuSGHvs/qXWUni4MUvvexO6+olSOno181R7Vis21FO3Bt2TJS
 3/ahW23R7XrfWLJWhTGiAXztSnyAtuk8QBcU79Di02/mCLuZaWRYVKzsJ8nYo5Og/G56
 PlEA==
X-Gm-Message-State: AOJu0Yxa3wW8gouBtDYsFuNSboMAMMG6DqvX3rmk1HQnI/7mMbG25MF4
 sPKMVRgKq5dWnMJtrSXnxUyILXp3ov1PzDjrUO5V97LWPEmcJcDXUjP6FjC/jIRt0h8zYF2lMOd
 ZChI=
X-Gm-Gg: ASbGncuAbOHd8jQLWfZgAccKIuDXYf7b3PRT/0wlpToqh9zbUmeSf7lswOCjFJG1mOB
 /GQR7zRzYYHox3H3QsmoNsNCfTmvzaiPDl5eoHC+HGu6ms3iDNmVLBXBjBFp1TzHylBiTMaxnmm
 xKFlYmG46wq3tUR+iHh5kkFxBHD0HHkZW2jDHzUAbSKNrKSMxiWd4wLXmsfhD8boRZGJzK7639s
 uhJxOP27lTfBtdsL4qBfhWkeuLg82XIwG39f/ZPhbVL0dqEutz1N98=
X-Google-Smtp-Source: AGHT+IEueo5OsQo259aw5bbAUB+Gvh/jH13NVipdqDqWGfhqZ46eJwbs9c3DE/7Arep29oBn7QRb/g==
X-Received: by 2002:a05:6214:19cb:b0:6d8:a967:8387 with SMTP id
 6a1803df08f44-6dc7ea12e5amr301538986d6.1.1734408251744; 
 Mon, 16 Dec 2024 20:04:11 -0800 (PST)
Received: from [127.0.1.1] ([187.144.29.192]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd256fd9sm34358136d6.37.2024.12.16.20.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 20:04:10 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Yuri Zaporozhets <yuriz@qrv-systems.net>
In-Reply-To: <20241130205625.24668-1-yuriz@qrv-systems.net>
References: <20241130205625.24668-1-yuriz@qrv-systems.net>
Subject: Re: [PATCH] bios_emulator: fix incorrect printing of address in
 "call near immediate"
Message-Id: <173440825001.3115242.7311488199698946711.b4-ty@konsulko.com>
Date: Mon, 16 Dec 2024 22:04:10 -0600
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

On Sat, 30 Nov 2024 21:56:25 +0100, Yuri Zaporozhets wrote:

> In the x86emuOp_call_near_IMM() function the address of CALL is
> printed incorrectly when jumping backwards. For example, the correct
> disassemble of the bytes below would be:
> 
> 0000E8DE  E8DBFF            call 0xe8bc
> 
> (verified by ndisasm). But instead the address is printed as "ffffe8bc".
> That's because of the following macro:
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom


