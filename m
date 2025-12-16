Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BB0D609D2
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 17:29:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 535B8839D7;
	Tue, 16 Dec 2025 18:29:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bzx76Cg6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BB9B83979; Tue, 16 Dec 2025 18:29:13 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A379383984
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 18:29:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3f13043e2fdso1558279fac.1
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 09:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765906148; x=1766510948; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FlXfuqpwMYckG5taJzvM8sEgHJG03GHaItlTDmpND/U=;
 b=bzx76Cg6pA52GZKDKuhLXrVjbo0qFhUCJjeH+TzWaldkGS9R4LFGPEQmzblPlnh4+u
 wNcGyDf1nouAUmxgTlq1NsZAYb9dA0n/zdu8zPc1XFEpCu8JerW3u8Rk+/Pfx4rFcZ/T
 ttINet4Vqfse02UtxGOu+T1JVL1N/f4fpBAV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765906148; x=1766510948;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FlXfuqpwMYckG5taJzvM8sEgHJG03GHaItlTDmpND/U=;
 b=JbklaLDwua+CkAvfICfTu4UDybUM/jletfHGd3drIQ7JQuqoHpGJszYfVb2UITzZSg
 U/YPiqbRkr8tGSv+tpG7S/lQgDWhnq74uYzC3BRHivtTvmmxWxB60oE5lIX5WyXFZLNY
 cvMduko+Xox4YLEJX9wqxnSrQZ6rTnD19xPNB5X/3pwelIlN3XjPvOIgFfB7X+jXqwQn
 7jUsyHlQGdy0NCRPl6nGagiVmjtJb6WxzitX88KiwSVjPkOsqO4ykvcZ3UU9mvSNSeey
 jmJkgIPMNcqE5IxaDcSuV0o5SCGtZw0K5dzaSV7twi7CzPsQeXjBbg7FSMOBPal9S5v3
 5l8w==
X-Gm-Message-State: AOJu0YzZ8G4G5BEn/MH72Iklq1l9HsSqKWqpstP99tCvgCmHDtgObvcj
 s6AoDGkCKwrA/q2PdkZkjTz3mJUtq3sHQ91GYSK7vvsVsmcdkc7pw5pQTMZuj3sQ94tyOOG/tYp
 Aj6deqBw=
X-Gm-Gg: AY/fxX5VL8mpd0y4cF+V/uqBNg/t4Z/7a2cM04sC4scV9fvwojIeUTdC/EnxZBSYxLC
 M20qWyufv5Oe+0KkWS/FywCEvu+1qAADSIiew2zhSL7ippF6BQYBG1vdRovoJ7+nt3n54hryWa0
 6S55JT5munrLqOdY8JVEjJuemOBDG9IzxNXUnAE7qRn7G1A4zK2AKt+acwCrjmVwH+1fzSccXLf
 3VQichzsPEswMKkT4yIu0R07PF7Z77DIaNsNaVmNwl1U54DmvEuEYPhXpUJKaA59Ey3drkCyIA0
 Rta+1MtndYCYmtkkxKwhauWw/Dx0Y/7RRqm9D83SnDnWruNJeqjilvMni1/xed3p7GeOIx4qvxA
 rMJDQ0VTDqYT+w4uAKOwHiAIXzjmRXle5aqxVOn6fYelB5WLFK4Tyqt5mURc+oZ+jdbdJpgaZVF
 1eo8JFtr+p+LI+T5Lp8fnhl5zEucsdd6poIVyvXfRbVA4CCGan
X-Google-Smtp-Source: AGHT+IHY+zy8OYzGn+xRje3+KeJIf3PIve9lfRB+SEgCQZy52TNoxOvyvni0enpdMSBU+mT1yumeNw==
X-Received: by 2002:a05:6820:81ca:b0:65b:3c3b:699d with SMTP id
 006d021491bc7-65b451f310cmr6179772eaf.64.1765906148302; 
 Tue, 16 Dec 2025 09:29:08 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65b86c32d5dsm526682eaf.13.2025.12.16.09.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 09:29:07 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jonathan GUILLOT <jonathan@joggee.fr>
In-Reply-To: <20251211212039.31628-1-jonathan@joggee.fr>
References: <20251211212039.31628-1-jonathan@joggee.fr>
Subject: Re: [PATCH] cmd: part: Fix part argument description for `part number`
Message-Id: <176590614759.2175876.9905037537056231404.b4-ty@konsulko.com>
Date: Tue, 16 Dec 2025 11:29:07 -0600
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

On Thu, 11 Dec 2025 22:20:39 +0100, Jonathan GUILLOT wrote:

> 


Applied to u-boot/master, thanks!

[1/1] cmd: part: Fix part argument description for `part number`
      commit: 47b50fb1125c539d80ed3e7f739c02c6486e1b52
-- 
Tom


