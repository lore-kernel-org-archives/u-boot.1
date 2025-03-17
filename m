Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B993C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 16:16:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23C1B80F4C;
	Mon, 17 Mar 2025 17:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dfpCvx+S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6C878141E; Mon, 17 Mar 2025 17:16:09 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45AC4800B3
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 17:16:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e60aef2711fso3372186276.2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 09:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742228165; x=1742832965; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lPM883bKqyh+2r3PnmgWgjj8VfcIQTjV4VOSpRb7TYI=;
 b=dfpCvx+SZXf+E8YEwAGaUX+ubLZ8dHHdHn6aeRzjyUwNs+P1NIlG+fHMK/RwXSeat1
 bLD54yXxhPbcQ1kRGRt2BCLossWQWIxGUpxCq+YncmM3IXybxwZs7xLtZsC6BRn35CWt
 ZremBvWb8N0ttxMSUqAaoPJI9JINpyXxb7Rww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742228165; x=1742832965;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lPM883bKqyh+2r3PnmgWgjj8VfcIQTjV4VOSpRb7TYI=;
 b=lNV+v4YNlQnHe6Oqfbh9wvA9l6yF99fNtPA9H871gtH4VZZJ8WC0anTApsitZonfT1
 DPVvZe972LSJklTnEupb0ee7AeyCi89qa8o1p/W2EoGCw/1u69Z0mtEAS8njEI1rKSkr
 U+smnD0zg+Mv2W2HtqO6ekvzfpoIZtwRmsF0VaBdSbywSOyfLmltVGLAIx+ktSCeEWhG
 ZFqIAFL/oAgK4UtJTp8imW4OqVlolk+YEGqhWgEUZ501JM2D59vOSx2s0+kM38Wk/c/X
 b0ju25v1j+3fUyotEnfkca9iPc7LS6TphIMchlMFpx97Vd4EQM0g7MuoA4w62+3Q1YXZ
 PdtQ==
X-Gm-Message-State: AOJu0YyEiMtpcNRQ2QfBbY7F/oHA0WI17AMs/r5WH93Tq7QgcSDXai52
 4UX2/oFkgDefmUL6NQaEGxpxHaLSyVrXYN2b50ynXxZdJPzNR+acaPkVXLmoFRU=
X-Gm-Gg: ASbGncvfcGiMJxh6fBHcZP861ex6vFBpeQUrCq+dzlInJz9TGBFMxcvl89S1EzKNCyn
 Orwx5t02wEntZiicYXy5Pbwrn0tosm9P5t6Dz3H52eUXz3A60Ovg1QpC5qY+llGFtuw4LzEkaEA
 G408sQcPhkMXEmfEQzq6Z177n7qJFF66uCT7q72SYCpwfoFBgX1kMhdKpFGZQUl2hz37ELSRzuf
 tG1kjQ2vQXtmgVtI3XP1/mDYAkecaavqsLDvpsCS9XklxAt3CVjlcQ3aGE8lAaBUlcvd6JO+1/A
 pX9Nj8YuN1zxbJ2OrifF96IAMvZ+v4Cj/n6LRaq8LeK4gHN/VdSNTkY=
X-Google-Smtp-Source: AGHT+IFBFAjYDIuy6DU57pJ9guAaRew1ZTNbX/ckGJ6MBQ7FmRwgSuGnNh6OigJe/4MqfXKUUds6+A==
X-Received: by 2002:a05:6902:2387:b0:e5d:d161:2690 with SMTP id
 3f1490d57ef6-e63f65ca916mr15773432276.43.1742228165120; 
 Mon, 17 Mar 2025 09:16:05 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e63e50d2b6bsm2322155276.0.2025.03.17.09.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 09:16:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250317031940.223352-1-marek.vasut+renesas@mailbox.org>
References: <20250317031940.223352-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PULL] u-boot-sh/master
Message-Id: <174222816413.1613115.9286478874943665780.b4-ty@konsulko.com>
Date: Mon, 17 Mar 2025 10:16:04 -0600
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

On Mon, 17 Mar 2025 04:16:11 +0100, Marek Vasut wrote:

> These are mainly DBSC5 DRAM controller specific fixes and updates for current
> release. There is the long overdue BL31 start V4H board code as well, that
> should be in the current release to make the V4H White Hawk board usable with
> SPL, and a fallback U-Boot PSCI implementation enablement to make sure the
> board always boots. And finally, there are two comment fixes.
> 
> The following changes since commit 15d6518c942f0da13f9a7ceeadbd925c3317ec8d:
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


